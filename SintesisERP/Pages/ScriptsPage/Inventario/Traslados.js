var JsonValidate = [{ id: 'cd_tipodoc', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
{ id: 'codigoccostos', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
{ id: 'Text_Fecha', type: 'DATE', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },];

var JsonCommodity = [{ id: 'cd_wineri', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'm_quantity', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'cd_series', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' }];

window.tblcommodity = null;
$(document).ready(function () {
    LoadTable();
    $('#v_code').autocomplete({
        serviceUrl: window.appPath + "/Pages/Connectors/Connector.ashx",
        type: 'post',
        datatype: 'json',
        paramName: 'keyword',
        params: { 'class': 'Productos', method: 'ArticulosBuscador' },
        noCache: true,
        onSelect: function (select) {
            if (($('#hid_wineri').val() != '' && $('#hid_wineridest').val() != '' && select.inventarial) || !select.inventarial)
                if (!($('#hid_wineri').val() == $('#hid_wineridest').val())) {
                    if (select.data != 0) {
                        $('#addarticle').attr('data-idbodega', $('#hid_wineri').val());
                        $('#addarticle').attr('data-idbodegadest', $('#hid_wineridest').val());
                        loadpresentation(select.data, 0, select.data, $('#hid_wineri').val());
                    }
                    else {
                        $('#addarticle').attr('data-id', '0');
                        $('#nombre').val("");
                    }
                } else {
                    toastr.info('Debe Seleccionar bodegas diferentes', 'Sintesis ERP');
                }
            else {
                $('#v_code').val("");
                mensaje = $('#cd_wineri').val() == '' ? ' de origen' : 'de destino';
                toastr.info('Para seleccionar el producto, debe seleccionar la bodega ' + mensaje + '".', 'Sintesis ERP');
            }

        },
        onSearchStart: function (query) {
            query.params = JSON.stringify({ filtro: query.keyword, op: 'D', o: '', formula: 0, id_prod: 0 });
        },
        minChars: 2,
        transformResult: function (response) {
            json = JSON.parse(response).ans;
            var object = json.data;
            if (object.length > 0) {
                return {
                    suggestions: $.map(object, function (dataItem) { return { value: dataItem.name, data: dataItem.id, inventarial: dataItem.inventarial }; })
                };
            }
            else {
                return { suggestions: [] }
            }
        }
    });

    $('#btnSaveLotes').click(function () {
        if ($('#opTipoTraslados').val() == 'T') {
            id = $(this).attr('data-id');
            xml = '';
            $.each($('input.inputlote'), function (i, e) {
                element = $(e);
                if (SetNumber(element.val()) != 0) {
                    xml += '<item idlote="' + element.attr('data-id') + '" cant="' + SetNumber(element.val()) + '" />>'
                }
            })

            SetCalueColumn(id, 'LOTE', 0, '', '', xml, 'EndCallbackSaveLote');
        }
        else
            $('#ModalLotes, #ModalSeries').modal('hide');
    });

    $('#btnSaveSeries').click(function () {
        id = $(this).attr('data-id');
        value = setMultiSelect('setseries');
        SetCalueColumn(id, 'SERIES', 0, value, '', '', 'EndCallbackSaveLote');
    });

    $('#cd_tipodoc').change(function () {
        if ($("#id_Traslado").val() == '0') {
            var valores = $(this).find('option:selected').attr('data-centro');
            var split = valores.split('|~|');
            $('#id_ccostos').val(split[1]);
            $('#codigoccostos').val(split[2]);
        }

        JsonValidate[1].required = (split[0] == '1') ? true : false;
    });

    //Evento del Boton Agregar Articulo
    $('#addarticle').click(function () {
        var idarticle = $('#addarticle').attr('data-id');
        if (validate(JsonCommodity)) {
            var Parameter = {};
            Parameter.idToken = $('#idToken').val();
            Parameter.id_bodega = ($('#addarticle').attr('data-idbodega') == '') ? '0' : $('#addarticle').attr('data-idbodega');
            Parameter.id_bodegadest = ($('#addarticle').attr('data-idbodegadest') == '') ? '0' : $('#addarticle').attr('data-idbodegadest');
            Parameter.id_article = idarticle;
            Parameter.costo = SetNumber($('#m_cost').val());
            Parameter.quantity = SetNumber($('#m_quantity').val());
            Parameter.lote = ($('#divaddart').attr('data-lote') == 'true') ? true : false;
            Parameter.serie = ($('#divaddart').attr('data-serie') == 'true') ? true : false;
            Parameter.series = setMultiSelect('cd_series');
            Parameter.inventario = ($('#divaddart').attr('data-inventario') == 'true') ? true : false;
            if (!Parameter.serie || ($('#cd_series').val() != null && $('#cd_series').val().length == (Parameter.quantity)) /*|| Parameter.quantity > 0*/) {
                if (Parameter.id_bodega != Parameter.id_bodegadest)
                    MethodService("Entradas", "DocumentosAddArticulo", JSON.stringify(Parameter), "EndCallbackAddArticle");
                else
                    toastr.warning('Seleccionar Bodegas de origen y de destino distintas, Por favor.', 'Sintesis ERP');
            } else {
                toastr.warning('La cantidad de series seleccionadas no es la misma que la que desea agregar.', 'Sintesis ERP');
            }
        }
    });
    //Evento donde se lista los Traslados realizados
    $('#btnList').click(function () {
        if (window.gridTraslados === undefined) {
            window.gridTraslados = $("#tblTraslados").bootgrid({
                ajax: true,
                post: function () {
                    return {
                        'params': "",
                        'class': 'Entradas',
                        'method': 'TrasladoList'
                    };
                },
                url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
                formatters: {
                    "edit": function (column, row) {
                        return "<a class=\"action command-edit\" data-row-id=\"" + row.id + "\"><span class=\"fa-2x fa fa-eye iconfa\"></span></a>";
                    },
                    "costototal": function (column, row) {
                        return '$ ' + row.costototal.Money();
                    },
                    "contab": function (column, row) {
                        if (row.conta == 1 || row.conta == '1') {
                            return "<a class=\"action command-contab\" data-row-id=\"" + row.id + "\"><span class=\"fa fa-2x fa-fw fa-money text-info  iconfa\" /></a>";
                        }
                        else
                            return '';
                    },
                    "log": function (column, row) {
                        if (row.conta == 1 || row.conta == '1') {
                            return "<a class=\"action command-log\" data-row-id=\"" + row.id + "\"><span class=\"fa fa-2x fa-fw fa-exclamation-triangle text-warning  iconfa\" /></a>";
                        }
                        else
                            return "";
                    }
                }
            }).on("loaded.rs.jquery.bootgrid", function () {
                // Executes after data is loaded and rendered 
                window.gridTraslados.find(".command-edit").on("click", function (e) {
                    id = $(this).data("row-id")
                    params = {};
                    params.id = id;
                    MethodService("Entradas", "TrasladosGet", JSON.stringify(params), 'EndCallbackGet');
                }).end().find(".command-contab").on("click", function (e) {
                    if (confirm("Desea contabilizar?")) {
                        $('#ModalLoad').modal({ backdrop: 'static', keyboard: false }, "show");
                        id = $(this).data("row-id");
                        params = {};
                        params.id = id;
                        params.tipo = "AJ";
                        MethodService("Entradas", "EntradaContabilizar", JSON.stringify(params), 'EndCallbackcontab');
                    }
                }).end().find(".command-log").on("click", function (e) {
                    id = $(this).data("row-id");
                    $('#id_proce').val(id);
                    loadlog();
                })
            });
        }
        else
            window.gridTraslados.bootgrid('reload');

        $('#ModalTraslado').modal({ backdrop: 'static', keyboard: false }, "show");
    });
    //Evento de reversion de Traslados
    $('#btnRev').click(function () {
        if ($('#id_Traslado').val() != '0' && $('#id_Traslado').val().trim() != '') {
            if (confirm("Desea revertir el Traslado?")) {
                var sJon = {};
                sJon.id = ($('#id_Traslado').val().trim() == "") ? "0" : $('#id_Traslado').val();
                MethodService("Entradas", "RevertirTraslado", JSON.stringify(sJon), "CallbackReversion");
            }
        }
    });
    //Evento de Impresion de documento generado a traslado de mercancia
    $('#btnPrint').click(function () {
        var idTraslado = $('#id_Traslado').val();
        param = 'id|' + idTraslado + ';'
        PrintDocument(param, 'MOVTraslado', 'CODE');
    });
    //Evento que acciona un nuevo recibo de caja
    $('#btnnew').click(function () {
        newTraslado();
    });
    //Evento de facturas Traslados
    $('#btnSave').click(function () {
        if (validate(JsonValidate)) {
            if (window.tblcommodity.bootgrid("getTotalRowCount") > 0) {
                if ($('#opTipoTraslados').val() == 'T') {
                    var sJon = {};
                    sJon.id_tipodoc = $('#cd_tipodoc').val();
                    sJon.id_centrocosto = ($('#id_ccostos').val() == "") ? '0' : $('#id_ccostos').val();
                    sJon.Fecha = SetDate($('#Text_Fecha').val());
                    sJon.idToken = $('#idToken').val();
                    sJon.detalle = $('#descripcion').val();
                    $('#btnSave').button('loading');
                    MethodService("Entradas", "FacturarTraslado", JSON.stringify(sJon), "CallbackComodity");
                } else {
                    toastr.warning("Traslado ha sido realizado.", 'Sintesis ERP');
                    $('#btnSave').button('reset');

                }
            }
            else
                toastr.warning("No ha agregado ningun artículo.", 'Sintesis ERP');
        }
    });

    $('#v_code').blur(function () {
        if ($(this).val().trim() == '')
            $('#v_presen').html("").selectpicker('refresh');

        $('#cd_wineri').trigger('change');
    });
    //Evento de que determina la bodega de origen y destino de todo el documento de tralados
    $('#cd_winerideforig,#cd_windesdefdes').change(function () {
        val = $(this).next().val();
        $('#hid_wineri').val($('#cd_winerideforig').val())
        $('#hid_wineridest').val($('#cd_windesdefdes').val())
        eselected = $(this).attr('id') == 'cd_winerideforig' ? '#cd_wineri' : '#cd_wineridest';
        element = $(eselected);
        if (val != '0' && val != null && val.trim() != '') {
            element.val(val).attr('disabled', 'disabled');
        }
        else {
            element.val('').removeAttr('disabled');
        }
    });
});

function LoadTable() {
    window.tblcommodity = $("#tblcommodity").bootgrid({
        ajax: true,
        rowCount: [100],
        post: function () {
            return {
                'params': function () {
                    var param = {};
                    param.id_entrada = ($('#opTipoTraslados').val() == 'L') ? $('#id_Traslado').val() : $('#idToken').val();
                    param.opcion = $('#opTipoTraslados').val();
                    return JSON.stringify(param);
                },
                'class': "Entradas",
                'method': 'EntradasItemList'
            };
        },
        url: window.appPath + "/Pages/Connectors/ConnectorList.ashx", //conecta los metodos con los controladores*/
        // rowCount: -1,
        columnSelection: false,
        formatters: {
            "delete": function (column, row) {
                if ($('#opTipoTraslados').val() == 'T')
                    return "<a class=\"action command-delete\" data-row-id=\"" + row.id + "\"><span class=\"fa fa-2x fa-trash-o text-danger iconfa\"></span></a>";
                else
                    return '';
            },
            "total": function (column, row) {
                return row.total.Money();
            },
            "costo": function (column, row) {
                return "<span class='tdedit action' data-type='numeric' data-column='costo' data-min='0' data-max='999999999999999999' data-simbol='$' data-value='" + row.costo + "' data-id='" + row.id + "'>" + row.costo.Money() + "</span>";
            },
            "cantidad": function (column, row) {
                return "<span class='tdedit action command-edit' data-type='numeric' data-column='cantidad' data-min='1' data-max='9999999999999999999' data-simbol='' data-value='" + row.cantidad + "' data-id='" + row.id + "'>" + row.cantidad.Money() + "</span>";
            },
            "serie": function (column, row) {
                return (row.serie) ? "<span class='tdedit action command-serie fa fa-2x fa-pencil text-info' data-column='serie'  data-count='" + row.cantidad + "' data-id='" + row.id + "'data-bodega='" + row.id_bodega + "'></span>" : '';
            },
            "lote": function (column, row) {
                return (!row.serie && row.lote) ? "<span class='tdedit action command-lote fa fa-2x fa-pencil text-error' data-column='lote'  data-count='" + row.cantidad + "' data-id='" + row.id + "'></span>" : '';
            },
            "costototal": function (column, row) {
                return row.costototal.Money();
            }
        }
    }).on("loaded.rs.jquery.bootgrid", function () {
        window.tblcommodity.find(".command-delete").on("click", function (e) {
            id = $(this).data("row-id");
            params = {};
            params.id_articulo = id;
            params.id_proveedor = 0;
            params.id_proveedorfle = 0;
            params.flete = 0;
            params.id_entrada = $('#idToken').val();
            MethodService("Entradas", "EntradasDelArticulo", JSON.stringify(params), 'EndCallbackupdate');
        }).end().find(".command-lote").on("click", function (e) {
            id = $(this).data("id");
            count = $(this).data("count");
            CallSearchLoteSerie(id, 0, 'LF', $('#opTipoTraslados').val(), count, 'EndCallbackArticleLote');

        }).end().find(".command-serie").on("click", function (e) {
            count = $(this).data("count");
            id = $(this).data("id");
            $('#btnSaveSeries').attr('data-id', id)
            CallSearchLoteSerie(id, $(this).data('bodega'), 'SF', (($('#opTipoTraslados').val() == 'T') ? 'P' : 'L'), 0, 'EndCallbackArticleSerie');
        }).end().find(".command-edit").on("dblclick", function (e) {
            params = {};
            $(this).hide();
            data = $(this).data();
            tr = $(this).closest('td');
            if ($(this).attr('data-type') == 'numeric') {
                max = $(this).attr('data-max');
                min = 1;
                input = $('<input class="form-control rowedit" date-type="numeric" data-oldvalue="' + data.value + '" data-column="' + data.column + '" data-id="' + data.id + '" value="' + data.value + '" money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="' + min + '" data-v-max="' + max + '">');
                input.autoNumeric('init');
            }
            else if ($(this).attr('data-type') == 'date') {
                input = $('<input class="form-control rowedit" date-type="date" data-oldvalue="' + data.value + '" data-column="' + data.column + '" data-id="' + data.id + '" value="' + data.value + '" current="true" date="true" format="YYYY-MM-DD" />');
                iddatepicker(input);
            }
            else {
                input = $('<input class="form-control rowedit" date-type="text" data-oldvalue="' + data.value + '" data-column="' + data.column + '" data-id="' + data.id + '" value="' + data.value + '" />');
            }

            input.blur(function () {
                var row = $(this).data();
                newvalue = $(this).val();
                oldvalue = $(this).attr('data-oldvalue');
                type = $(this).attr('date-type');
                if ((type == 'numeric' && SetNumber(newvalue) != oldvalue) || (type != 'numeric' && newvalue != oldvalue)) {
                    params = {};
                    params.id = row.id;
                    params.column = row.column;
                    params.id_proveedor = 0;
                    params.id_proveedorfle = 0;
                    params.flete = 0;
                    params.value = (type != 'numeric') ? '0' : SetNumber(newvalue);
                    params.extravalue = newvalue;
                    params.id_entrada = $('#idToken').val();
                    params.oldvalue = oldvalue;
                    params.modulo = 'E';
                    MethodService("Entradas", "EntradasSetArticulo", JSON.stringify(params), 'EndCallbackupdate');
                }
                else {
                    tr = $(this).closest('td');
                    var ret = (type == 'numeric') ? parseFloat(oldvalue).Money() : oldvalue;
                    tr.find('.tdedit').html(ret).show();
                    $(this).remove();
                }
            });
            tr.find('.tdedit').hide();
            tr.append(input);
            input.focus().select();
        });
    });

    newTraslado();
}
//Funcion callback que resulta despues de agregar un articulo a la grilla
function EndCallbackAddArticle(Parameter, Result) {
    if (!Result.Error) {
        $('#v_code, #nombre').val('');
        if ($('#cd_winerideforig').val() == '') {
            $('#cd_wineri,#cd_wineridest').val('').selectpicker('refresh');
        }
        $('#m_cost, #existencia').val('0.00');
        $('#addarticle').attr('data-id', 0);
        $('#m_quantity').val('1.00');
        JsonCommodity[2].required = false;
        Data = Result.Row;
        $('#Tcosto').text('$ ' + Data.Ttotal.Money());
        window.tblcommodity.bootgrid('reload');
        $('#v_code').focus();
        $('div.divserie').hide();
    }
    else {
        toastr.error(Result.Message, 'Sintesis ERP');
    }
}

//Funcion de busqueda de lotes o serie por id de articulo
function CallSearchLoteSerie(id_articulo, id_bodega, opcion, op, count, callback) {
    params = {};
    params.id_articulo = id_articulo;
    params.id_bodega = id_bodega;
    params.opcion = opcion;
    params.op = op;
    params.id_documento = $('#idToken').val();
    params.count = count;
    $('#btnSaveLotes').attr('data-id', id_articulo)
    MethodService("Entradas", "EntradasBuscadorSerieLote", JSON.stringify(params), callback);
}
//Funcion de nuevo traslado
function newTraslado() {
    window.edit = true;
    $('.divarticleadd').show();
    $('#opTipoTraslados').val('T');
    $('input.form-control').val('');
    $('[money]').val('0.00');
    $('#m_quantity').val('1.00');
    $('#cd_winerideforig,#cd_windesdefdes').removeAttr('disabled');
    ifartycle = false;
    fieldsMoney();
    datepicker();
    $('.entradanumber').html('0');
    $('#btnSave, #btnTemp,  #btnconf, #btnLoad, #btnSaveSeries,#addarticle,#v_code').removeAttr('disabled');
    $('.dropify-clear').click();
    $('#btnRev, #btnPrint').attr('disabled', 'disbled');
    $('#id_Traslado, #id_ccostos').val('0');
    $('#descripcion').val('');
    $('#cd_winerideforig,#cd_windesdefdes').val('');
    $('#cd_tipodoc').val('0').selectpicker('refresh');
    $('#cd_winerideforig,#cd_windesdefdes').val('0').selectpicker('refresh').trigger('change');
    JsonCommodity[2].required = false;
    $('.activelote').removeClass('activelote').addClass('desactivelote');
    Data = { Ttotal: 0 };
    $('#Tcosto').text('$ ' + Data.Ttotal.Money());
    EncabezadoEnabled(false);
    var div = $('#diventrada');
    div.find('.divarticleadd').show();
    div.find('[money], #addarticle, select.selectpicker, .btnsearch, input.form-control').not('#nombre').removeAttr('disabled');
    div.find('select').selectpicker('refresh');
    $('#m_cost').attr('disabled', 'disabled');
    var Parameter = {};
    MethodService("Entradas", "EntradasSaveConsecutivo", JSON.stringify(Parameter), "EndCallbackTempEntrada");
}
//Funcion callback que resulta de la creacion de un traslado nuevo
function EndCallbackTempEntrada(Parameter, Result) {
    if (!Result.Error) {
        Data = Result.Row;
        $('#idToken').val(Data.id);
        if (window.tblcommodity == null)
            LoadTable();
        else
            window.tblcommodity.bootgrid('reload');

        var par = JSON.parse(Parameter);
        if (par.id_entrada != '0' && par.id_entrada != 0 && par.id_entrada !== undefined)
            toastr.info("Guardado temporal realizado.", 'Sintesis ERP');
    }
    else {
        toastr.error(Result.Message, 'Sintesis ERP');
    }
}
//Funcion callback de consulta de un traslado realizado
function EndCallbackGet(Parameter, Result) {
    if (!Result.Error) {
        var row = Result.Row;
        if (row.estado == 'PROCESADO') {
            $('#btnSave').attr('disabled', 'disabled');
            $('#btnRev').removeAttr('disabled');
        }
        else {
            $('#btnSave, #btnRev').attr('disabled', 'disabled');
        }
        $(this).attr('data-option');
        $('.entradanumber').text(row.id);
        (row.estado == 'REVERSION') ? $('#id_Traslado').val(row.id_reversion) : $('#id_Traslado').val(row.id);
        $('#Text_Fecha').val(row.fecha);
        $('#cd_tipodoc').val(row.id_tipodoc).selectpicker('refresh');
        $('#id_ccostos').val(row.id_centrocosto);
        $('#codigoccostos').val(row.centrocosto);
        $('#descripcion').val(row.descripcion);
        $('#v_code,#addarticle').attr('disabled', 'disabled');
        EncabezadoEnabled(false);
        $('#btnPrint').removeAttr('disabled');
        var div = $('#diventrada');
        div.find('[money], .addarticle, select.selectpicker, .btnsearch, input.form-control, textarea').attr('disabled', true);
        $('#opTipoTraslados').val('L');
        Data = Result.Row;
        $('#Tcosto').text('$ ' + Data.Ttotal.Money());
        window.tblcommodity.bootgrid('reload');
        $('#ModalTraslado').modal('hide');
    }
    else {
        toastr.error(Result.Message, 'Sintesis ERP');
    }
}

//Funcion de totalizar Traslados
function TotalizarTraslado(Data) {
    $('#Ttotal').text('$ ' + Data.Ttotal.Money());
}
//Funcion callback que resulta luego de la reversion de un traslado
function CallbackReversion(Parameter, Result) {
    json = JSON.parse(Parameter);
    if (!Result.Error) {
        datos = Result.Row;
        $('.entradanumber').html(datos.id);
        $('#id_Traslado').val(datos.id);
        $('#btnSave, #btnRev').attr('disabled', 'disabled');
        var div = $('.diventrada');
        div.find('[money], .addarticle, select.selectpicker, .btnsearch, input.form-control').attr('disabled', true);
        div.find('select').selectpicker('refresh');
        $('#tblcommodity').find('a.command-delete').remove();
        toastr.success('Traslado Revertido.', 'Sintesis ERP');
    }
    else
        toastr.error(Result.Message, 'Sintesis ERP');
}
//Funcion callback que resulta luego de la facturacion del traslado
function CallbackComodity(Parameter, Result) {
    json = JSON.parse(Parameter);
    if (!Result.Error) {
        datos = Result.Row;
        $('.entradanumber').html(datos.id);
        $('#opTipoTraslados').val('L');
        $('#descripcion').val('');
        $('#id_Traslado').val(datos.id);
        $('#btnSave,#addarticle,#v_code').attr('disabled', 'disabled');
        $('#btnRev,#btnPrint').removeAttr('disabled');
        var div = $('#diventrada');
        div.find('[money], .addarticle, select.selectpicker, .btnsearch, input.form-control').attr('disabled', true);
        EncabezadoEnabled(true);
        div.find('select').selectpicker('refresh');
        window.tblcommodity.bootgrid('reload');
        $('#tblcommodity').find('a.command-delete').remove();
        $('#btnSave').button('reset');
        toastr.success('Traslado facturado.', 'Sintesis ERP');


    }
    else {
        toastr.error(Result.Message, 'Sintesis ERP');
        $('#btnSave').button('reset');
    }
}


//Funcion callback que resulta de la actualizacion de un registro de la grilla
function EndCallbackupdate(params, Result) {
    if (!Result.Error) {
        param = JSON.parse(params);
        window.tblcommodity.bootgrid('reload');
        $('#v_code').focus();
        $('#ModalSeriesPos').modal('hide');
        $('.rowedit').remove();
        $('div.divserie').hide();
        Data = Result.Row;
        $('#Tcosto').text('$ ' + Data.Ttotal.Money());
    }
    else {
        toastr.error(Result.Message, 'Sintesis ERP');
    }
    $('#btnSaveSeriesPos').button('reset');
}

//Funcion que muestra detalladamente los lotes del articulo seleccionado a trasladar en un Modal diferente
function EndCallbackArticleLote(params, answer) {
    if (!answer.Error) {
        var body = $('#listlotes');
        var par = JSON.parse(params);
        body.html('');
        var totaltol = 0;
        var min = par.count > 0 ? 0 : -999999999.99;
        var max = par.count > 0 ? 999999999.99 : 0;
        $.each(answer.data, function (i, e) {
            var tr = $('<tr/>');
            var td1 = $('<td>' + e.lote + '</td>');
            var td2 = $('<td>' + e.existencia.Money() + '</td>');
            var td3 = $('<td/>');
            var input = null;
            totaltol += parseFloat(e.cantidad);
            if (par.op == 'T') {
                input = $('<input class="form-control inputlote" money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="' + min + '"  data-v-max="' + max + '"   data-id="' + e.id + '" value="' + e.cantidad + '"/>');
                input.change(function () {
                    var total = 0;
                    if ($(this).val() == '')
                        $(this).val('0.00');
                    $.each($('input.inputlote'), function (i, e) {
                        total += parseFloat(SetNumber($(e).val()));
                    });
                    $('#lotetotal').val(total.Money());
                });
            }
            else {
                input = e.cantidad.Money();
            }
            td3.append(input);
            tr.append(td1, td2, td3);
            body.append(tr);
        });
        $('#lotetotal').val(totaltol.Money());
        body.find('input.inputlote').autoNumeric('init');
        $('#ModalLotes').modal({ backdrop: 'static', keyboard: false }, "show");
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}
function EndCallbackSaveLote(params, answer) {
    if (!answer.Error) {
        var body = $('#listlotes');
        body.html('');
        $('#setseries').html('').selectpicker('refresh');
        Data = answer.Row;
        $('#Tcosto').text('$ ' + Data.Ttotal.Money());
        $('#ModalLotes, #ModalSeries').modal('hide');
        window.tblcommodity.bootgrid('reload');
    }
    else {
        par = JSON.parse(params);
        $('.rowedit').val(par.oldvalue);
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}
function SetCalueColumn(id_articulo, column, value, valorex, op, xml, callback) {
    params = {};
    params.id_proveedor = 0;
    params.id_proveedorfle = 0;
    params.id_entradaoficial = '';
    params.id = id_articulo;
    params.column = column;
    params.flete = 0;
    params.value = value;
    params.id_entrada = $('#idToken').val();
    params.op = op;
    params.xml = '<items>' + xml + '</items>';
    params.extravalue = valorex;
    params.modulo = 'L'; //'L' Representa a Traslado
    MethodService("Entradas", "EntradasSetArticulo", JSON.stringify(params), callback);
}


function ValidarSerie(vector, serie) {
    if (vector.indexOf(serie) != -1)
        return true;
    else
        return false;
}

function loadpresentation(v_code, formula, id, idbodega) {
    params = {};
    params.filtro = v_code;
    params.op = 'P';
    params.o = 'PR';
    params.formula = formula;
    params.id_prod = id;
    params.id_bodega = idbodega;
    MethodService("Productos", "ArticulosBuscador", JSON.stringify(params), "EndCallbackArticle");
}
//Funcion Callback para cargar articulo buscado
function EndCallbackArticle(params, answer) {
    if (!answer.Error) {
        if (answer.data.length > 0) {
            var row = answer.data[0];
            $('#addarticle').attr('data-id', row.id)
            $('#nombre').val(row.nombre);
            $('#existencia').val(row.existencia.Money());
            $('#m_cost').val(row.costo.Money());
            $('#divaddart select').selectpicker('refresh');
            $('#serie').val(row.serie);
            $('#divaddart').attr({ 'data-serie': row.serie, 'data-lote': row.lote, 'data-inventario': row.inventario });
            JsonCommodity[2].required = row.serie;
            if (row.serie) {
                answer.data = answer.series;
                par = { op: 'T' };
                EndCallbackArticleSerie(JSON.stringify(par), answer);

            }
            else {
                $('div.divserie').hide();
                $('#divaddart').removeAttr('data-series');
            }
            $('#m_quantity').focus().select();
        }
    }
    else {
        toastr.warning(answer.Message, 'Sintesis ERP');
    }
}
//callback para mostrar las series disponibles
function EndCallbackArticleSerie(params, answer) {
    par = JSON.parse(params);

    if (!answer.Error) {
        var options = "";
        var serie = "";
        var id_articulo = "";

        $.each(answer.data, function (i, e) {
            options += '<option  value="' + e.serie + '" ' + ((e.selected) ? 'selected="true"' : '') + '>' + e.serie + '</option > ';
        });
        if (par.op == 'T')
            $('#cd_series').html(options).selectpicker('refresh');
        else {
            $('#setseries').html(options).selectpicker('refresh');
            $('#ModalSeries').modal({ backdrop: 'static', keyboard: false }, "show");
        }

        if (par.op == 'L') {
            $('#btnSaveSeries').css('display', 'none');

        } else {
            $('#btnSaveSeries').css('display', 'inline-block');

        }
    }
    else {
        toastr.warning(answer.Message, 'Sintesis ERP');
        $('#cd_series').html('').selectpicker('refres');
    }
    if (par.op == 'T')
        $('div.divserie').show();
}


function EncabezadoEnabled(boolean) {
    $('#cd_tipodoc,#Button2,#Text_Fecha,#cd_winerideforig,#cd_windesdefdes,#descripcion,.btnsearch').attr('disabled', boolean);
}
