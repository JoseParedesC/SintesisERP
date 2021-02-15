var JsonValidate = [{ id: 'cd_tipodoc', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
{ id: 'codigoccostos', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
{ id: 'Text_Fecha', type: 'DATE', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'ds_concepto', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];

var JsonCommodity = [{ id: 'cd_wineri', type: 'WHOLE', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
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
            if (($('#cd_wineri').val() != '' && select.inventarial) || !select.inventarial)
                if (select.data != 0) {
                    $('#addarticle').attr('data-idbodega', $('#cd_wineri').val());
                    loadpresentation(select.data, 0, select.data, $('#cd_wineri').val());
                }
                else {
                    $('#addarticle').attr('data-id', '0');
                    $('#nombre').val("");
                }
            else {
                $('#v_code').val("");
                toastr.info('Para seleccionar el producto, debe seleccionar la bodega.', 'Sintesis ERP');
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

        if ($('#opTipoAjustes').val() == 'T') {
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
        count = $(this).attr('data-count');
        value = setMultiSelect('setseries');
        if (($('#setseries').val().length == (count * -1)) || count > 0)
            SetCalueColumn(id, 'SERIES', 0, value, '', '', 'EndCallbackSaveLote');
        else
            toastr.warning('La cantidad de series seleccionadas no es la misma que la que desea agregar.', 'Sintesis ERP');
    });

    $('#btnSaveSeriesPos').click(function () {
        valid = false;
        series = '';
        var vectorseries = [];
        $.each($('.inputserie'), function (e, i) {
            val = $(i).val();
            if (val != '') {
                $(i).removeClass('is-focused, error');
                if (!ValidarSerie(vectorseries, val)) {
                    vectorseries.push(val);
                    series += val + ','
                    valid = true;
                }
                else {
                    $(i).addClass('is-focused, error').focus().select();
                    valid = false;
                    toastr.warning("Esta serie ya se encuentra en el listado.", 'Sintesis ERP');
                    return false;
                }
            }
            else {
                $(i).addClass('is-focused, error');
                valid = false;
                return false;
            }
        });
        if (valid) {
            params = {};
            params.id = $(this).attr('data-id');
            params.column = 'series';
            params.id_proveedor = 0;
            params.id_proveedorfle = 0;
            params.flete = 0;
            params.value = "0";
            params.extravalue = series;
            params.id_entrada = $('#idToken').val();
            params.oldvalue = "";
            params.modulo = 'E';
            var btn = $(this);
            btn.button('loading');
            MethodService("Entradas", "EntradasSetArticulo", JSON.stringify(params), 'EndCallbackupdate');
        }
    });

    $('#cd_tipodoc').change(function () {
        if ($("#id_ajuste").val() == '0') {
            var valores = $(this).find('option:selected').attr('data-centro');
            var split = valores.split('|~|');
            $('#id_ccostos').val(split[1]);
            $('#codigoccostos').val(split[2]);
        }

        JsonValidate[1].required = (split[0] == '1') ? true : false;
    });

    $('#m_quantity').change(function () {
        serie = ($('#serie').val());
        if (serie == 'true') {
            if ($(this).val() > 0) {
                $('div.divserie').hide();
                JsonCommodity[2].required = false;
            } else {
                $('div.divserie').show();
                JsonCommodity[2].required = true;
            }
        } else {
            JsonCommodity[2].required = false;
            $('div.divserie').hide();
            $('#cd_series').html('').selectpicker('refres');
        }


    });





    //Evento del Boton Agregar Articulo
    $('#addarticle').click(function () {
        var idarticle = $('#addarticle').attr('data-id');
        if (validate(JsonCommodity)) {
            var Parameter = {};
            Parameter.idToken = $('#idToken').val();
            Parameter.id_bodega = ($('#addarticle').attr('data-idbodega') == '') ? '0' : $('#addarticle').attr('data-idbodega');
            Parameter.id_bodegadest = null;
            Parameter.id_article = idarticle;
            Parameter.costo = SetNumber($('#m_cost').val());
            Parameter.quantity = SetNumber($('#m_quantity').val());
            Parameter.lote = ($('#divaddart').attr('data-lote') == 'true') ? true : false;
            Parameter.serie = ($('#divaddart').attr('data-serie') == 'true') ? true : false;
            Parameter.series = setMultiSelect('cd_series');
            Parameter.inventario = ($('#divaddart').attr('data-inventario') == 'true') ? true : false;
            if (!Parameter.serie || ($('#cd_series').val() != null && $('#cd_series').val().length == (Parameter.quantity * -1)) || Parameter.quantity > 0) {
                $('#addarticle').button('loading');
                MethodService("Entradas", "DocumentosAddArticulo", JSON.stringify(Parameter), "EndCallbackAddArticle");
            }
            else
                toastr.warning('La cantidad de series seleccionadas no es la misma que la que desea agregar.', 'Sintesis ERP');
        }
    });




    $('#btnList').click(function () {
        if (window.gridajustes === undefined) {
            window.gridajustes = $("#tblajustes").bootgrid({
                ajax: true,
                post: function () {
                    return {
                        'params': "",
                        'class': 'Entradas',
                        'method': 'AjusteList'
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
                window.gridajustes.find(".command-edit").on("click", function (e) {
                    id = $(this).data("row-id")
                    params = {};
                    params.id = id;
                    MethodService("Entradas", "AjustesGet", JSON.stringify(params), 'EndCallbackGet');
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
            window.gridajustes.bootgrid('reload');

        $('#ModalAjuste').modal({ backdrop: 'static', keyboard: false }, "show");
    });

    $('#btnRev').click(function () {
        if ($('#id_ajuste').val() != '0' && $('#id_ajuste').val().trim() != '') {
            if (confirm("Desea revertir el ajuste?")) {
                var sJon = {};
                sJon.id = ($('#id_ajuste').val().trim() == "") ? "0" : $('#id_ajuste').val();
                MethodService("Entradas", "RevertirAjuste", JSON.stringify(sJon), "CallbackReversion");
            }
        }
    });




    $('#btnPrint').click(function () {
        var idajuste = $('#id_ajuste').val();
        param = 'id|' + idajuste + ';'
        PrintDocument(param, 'MOVAJUSTE', 'CODE');
    });

    $('#btnnew').click(function () {
        newAjuste();
    });

    $('#btnSave').click(function () {
        if (validate(JsonValidate)) {
            if (window.tblcommodity.bootgrid("getTotalRowCount") > 0) {
                if ($('#opTipoAjustes').val() == 'T') {
                    var sJon = {};
                    sJon.id_tipodoc = $('#cd_tipodoc').val();
                    sJon.id_centrocosto = ($('#id_ccostos').val() == "") ? '0' : $('#id_ccostos').val();
                    sJon.Fecha = SetDate($('#Text_Fecha').val());
                    sJon.idToken = $('#idToken').val();
                    sJon.id_concepto = $('#cd_concepto').val();
                    sJon.detalle = $('#descripcion').val();
                    $('#btnSave').button('loading');
                    
                    MethodService("Entradas", "FacturarAjuste", JSON.stringify(sJon), "CallbackComodity");
                } else {
                    toastr.warning("Ajuste ha sido realizado.", 'Sintesis ERP');
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

    $('#cd_wineridef').change(function () {
        val = $(this).val();
        element = $("#cd_wineri");
        if (val != '0' && val != null && val.trim() != '') {
            element.val(val).attr('disabled', 'disabled');
        }
        else {
            element.val('').removeAttr('disabled');
        }
        element.selectpicker('refresh');
    });

    function loadlog() {
        if (window.gridenlog === undefined) {
            window.gridenlog = $("#tbllog").bootgrid({
                ajax: true,
                columnSelection: false,
                post: function () {
                    return {
                        'params': "{id:" + $('#id_proce').val() + ", tipo:'AJ'}",
                        'class': 'DiasFact',
                        'method': 'LogContabilizado'
                    };
                },
                url: window.appPath + "/Pages/Connectors/ConnectorList.ashx"
            });
        }
        else
            window.gridenlog.bootgrid('reload');

        $('#ModalLog').modal({ backdrop: 'static', keyboard: false }, "show");
    }
});

function LoadTable() {
    window.tblcommodity = $("#tblcommodity").bootgrid({
        ajax: true,
        rowCount: [100],
        post: function () {
            return {
                'params': function () {
                    var param = {};
                    param.id_entrada = ($('#opTipoAjustes').val() == 'A') ? $('#id_ajuste').val() : $('#idToken').val();
                    param.opcion = $('#opTipoAjustes').val();
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
                if ($('#opTipoAjustes').val() == 'T')
                    return "<a class=\"action command-delete\" data-row-id=\"" + row.id + "\"><span class=\"fa fa-2x fa-trash-o text-danger iconfa\"></span></a>";
                else
                    return '';
            },
            "total": function (column, row) {
                return row.total.Money();
            },
            "costo": function (column, row) {
                return "<span class='tdedit action command-edit' data-type='numeric' data-column='costo' data-min='0' data-max='999999999999999999' data-simbol='$' data-value='" + row.costo + "' data-id='" + row.id + "'>" + row.costo.Money() + "</span>";
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
            params.id_proveedor = null;
            params.flete = 0;
            params.id_proveedorfle = 0;
            params.id_entrada = $('#idToken').val();
            MethodService("Entradas", "EntradasDelArticulo", JSON.stringify(params), 'EndCallbackupdate');
        }).end().find(".command-lote").on("click", function (e) {
            id = $(this).data("id");
            count = $(this).data("count");
            CallSearchLoteSerie(id, 0, 'LF', $('#opTipoAjustes').val(), count, 'EndCallbackArticleLote');

        }).end().find(".command-serie").on("click", function (e) {
            count = $(this).data("count");
            id = $(this).data("id");
            if (count < 0 || $('#opTipoAjustes').val() != 'T') {
                $('#btnSaveSeries').attr('data-id', id)
                $('#btnSaveSeries').attr('data-count', count)
                CallSearchLoteSerie(id, $(this).data('bodega'), 'SF', (($('#opTipoAjustes').val() == 'T') ? 'P' : 'A'), 0, 'EndCallbackArticleSerie');
            } else {
                params = {};
                params.id_articulo = id;
                params.count = count;
                params.op = $('#opTipoEntrada').val();
                MethodService("Entradas", "EntradasGetSeriesTemp", JSON.stringify(params), 'EndCallbackGetSeries');
            }
        }).end().find(".command-edit").on("dblclick", function (e) {
            params = {};
            $(this).hide();
            data = $(this).data();
            tr = $(this).closest('td');
            ifmin = $(this).attr('data-colum') == 'costo' ? 1 : -9999999999999999999;//valido si el evento esta colocado en el input de costo para asi establecer el dato minimo
            if ($(this).attr('data-type') == 'numeric') {
                max = $(this).data('value') > 0 ? $(this).attr('data-max') : -1;
                min = $(this).data('value') > 0 ? 1 : ifmin;
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
                    params.id_proveedorfle = 0;
                    params.column = row.column;
                    params.id_proveedor = 0;
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

    newAjuste();
}
function EndCallbackAddArticle(Parameter, Result) {
    if (!Result.Error) {
        $('#v_code, #nombre').val('');
        $('#cd_iva,#cd_inc').val('').selectpicker('refresh');
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

    $('#addarticle').button('reset');
}


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

function newAjuste() {
    window.edit = true;
    $('.divarticleadd').show();
    $('#opTipoAjustes').val('T');
    $('input.form-control').val('');
    $('[money]').val('0.00');
    $('#m_quantity').val('1.00');
    $('div.divserie').hide();
    JsonCommodity[2].required = false;
    $('#cd_wineridef').removeAttr('disabled');
    ifartycle = false;
    fieldsMoney();
    datepicker();
    $('.entradanumber').html('0');
    $('#btnSave, #btnTemp,  #btnconf, #btnLoad, #btnSaveSeries,#v_code,#addarticle').removeAttr('disabled');
    $('.dropify-clear').click();
    $('#btnRev, #btnPrint').attr('disabled', 'disbled');
    $('#id_ajuste, #id_ccostos').val('0');
    $('#cd_tipodoc').val('');
    $('#cd_wineridef,#descripcion').val('');
    $('#cd_tipodoc').val('0').selectpicker('refresh');
    $('#cd_wineridef').val('0').selectpicker('refresh').trigger('change');
    JsonCommodity[2].required = false;
    $('.activelote').removeClass('activelote').addClass('desactivelote');
    Data = { Ttotal: 0 };
    $('#Tcosto').text('$ ' + Data.Ttotal.Money());
    EncabezadoEnabled(false);
    var div = $('#diventrada');
    div.find('.divarticleadd').show();
    div.find('[money], #addarticle, select.selectpicker, .btnsearch, input.form-control').not('#nombre').removeAttr('disabled');
    div.find('select').selectpicker('refresh');

    var Parameter = {};
    MethodService("Entradas", "EntradasSaveConsecutivo", JSON.stringify(Parameter), "EndCallbackTempEntrada");
}
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
        (row.estado == 'REVERSION') ? $('#id_ajuste').val(row.id_reversion) : $('#id_ajuste').val(row.id);
        $('#Text_Fecha').val(row.fecha);
        $('#cd_concepto').val(row.id_concepto);
        $('#ds_concepto').val(row.concepto);
        $('#cd_tipodoc').val(row.id_tipodoc).selectpicker('refresh');
        $('#id_ccostos').val(row.id_centrocosto);
        $('#codigoccostos').val(row.centrocosto);
        $('#descripcion').val(row.detalle);
        EncabezadoEnabled(true);
        $('#v_code,#addarticle').attr('disabled','disabled');
        $('#btnPrint').removeAttr('disabled');
        var div = $('.diventrada');
        $('#opTipoAjustes').val('A');
        Data = Result.Row;
        $('#Tcosto').text('$ ' + Data.Ttotal.Money());
        window.tblcommodity.bootgrid('reload');
        $('#ModalAjuste').modal('hide');
    }
    else {
        toastr.error(Result.Message, 'Sintesis ERP');
    }
}


function TotalizarAjuste(Data) {
    $('#Ttotal').text('$ ' + Data.Ttotal.Money());
}

function CallbackReversion(Parameter, Result) {
    json = JSON.parse(Parameter);
    if (!Result.Error) {
        datos = Result.Row;
        $('.entradanumber').html(datos.id);
        $('#id_ajuste').val(datos.id);
        $('#btnSave, #btnRev').attr('disabled', 'disabled');
        var div = $('.diventrada');
        div.find('[money], .addarticle, select.selectpicker, .btnsearch, input.form-control').attr('disabled', true);
        div.find('select').selectpicker('refresh');
        $('#tblcommodity').find('a.command-delete').remove();
        toastr.success('Ajuste Revertido.', 'Sintesis ERP');
    }
    else
        toastr.error(Result.Message, 'Sintesis ERP');
}

function CallbackComodity(Parameter, Result) {
    json = JSON.parse(Parameter);
    if (!Result.Error) {
        datos = Result.Row;
        $('.entradanumber').html(datos.id);
        $('#opTipoAjustes').val('A');
        $('#id_ajuste').val(datos.id);
        $('#btnSave,#v_code,#addarticle').attr('disabled', 'disabled');
        $('#btnRev,#btnPrint').removeAttr('disabled');
        var div = $('.diventrada');
        div.find('[money], .addarticle, select.selectpicker, .btnsearch, input.form-control').attr('disabled', true);
        EncabezadoEnabled(true);
        div.find('select').selectpicker('refresh');
        window.tblcommodity.bootgrid('reload');
        $('#btnSave').button('reset');
        $('#tblcommodity').find('a.command-delete').remove();
        toastr.success('Ajuste facturado.', 'Sintesis ERP');
    }
    else
        toastr.error(Result.Message, 'Sintesis ERP');


    $('#btnSave').button('reset');
}



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
    params.id_proveedor = null;
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
    params.modulo = 'A';
    MethodService("Entradas", "EntradasSetArticulo", JSON.stringify(params), callback);
}

function EndCallbackGetSeries(params, answer) {
    if (!answer.Error) {
        par = JSON.parse(params);
        table = answer.Table;
        $('#listseries').html('');
        $('#btnSaveSeriesPos').attr('data-id', par.id_articulo);
        var count = (par.count > table.length) ? par.count : table.length;

        var del = (par.count < table.length) ? true : false;
        for (i = 0; i < count; i++) {
            var div = $('<div class="form-group"/>');
            var value = (table[i] != undefined) ? table[i].serie : "";
            var label = $('<label class="active"/>').html('Serie ' + (i + 1));
            if (del) {
                var span = $('<span class="fa fa-2x fa-remove text-danger" style="float: right;font-size: 16px;"/>');
                span.click(function () {
                    $(this).closest('div.form-group').remove();
                });
                label.prepend(span);
            }
            div.append(label);
            var input = "<input class='inputserie form-control' value=\"" + value + "\" />"
            div.append(input);
            $('#listseries').append(div);
        }
        $('#ModalSeriesPos').modal({ backdrop: 'static', keyboard: false }, 'show');
    }
    else {
        toastr.warning(answer.Message, 'Sintesis ERP');
    }
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
            if (row.serie) {
                answer.data = answer.series;
                par = { op: 'T' };
                EndCallbackArticleSerie(JSON.stringify(par), answer);
            }
            else {
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

        if (par.op == 'A') {
            $('#btnSaveSeries').css('display', 'none');

        } else {
            $('#btnSaveSeries').css('display', 'inline-block');

        }
    }
    else {
        toastr.warning(answer.Message, 'Sintesis ERP');
        $('#cd_series').html('').selectpicker('refres');
    }

}




function DatosArticulo() {
    var atr = $('#cd_wineri').attr('disabled');
    if (typeof atr !== typeof undefined && atr !== false) {
        $('#cd_wineri').trigger('change');
        $('#m_quantity').focus().select()
    }
    else
        $('#cd_wineri').siblings('button.dropdown-toggle').focus();
}
function cleanartycle() {
    $('#v_presen').val('0');
    $('#cd_serie').val('0');
    $('#cd_lote').val('0');
    $('#existencia').val('0.00');
    $('Select.article').html('').selectpicker('refresh');

}


window.gridajustes;


function EndCallbackConsuCosto(Parameter, Result) {
    if (!Result.Error) {
        Data = Result.Row;
        if (Data.costo) {
            $('#m_cost').val('$ ' + Data.costo.Money());
            $('#existencia').val(Data.existencia.Money());
        }
        else {
            $('#m_cost').val('$ 0.00');
            $('#existencia').val('0.00');
        }
    }
    else {
        toastr.error(Result.Message, 'Sintesis ERP');
    }
}

function EndCallbackcontab(params, answer) {
    if (!answer.Error) {
        toastr.success("Contabilización Exitosa", 'Sintesis ERP');
        window.gridajustes.bootgrid('reload');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
    $('#ModalLoad').modal('hide');
}

function EncabezadoEnabled(boolean) {
    $('#cd_tipodoc,#Button2,#Text_Fecha,#cd_wineridef,#descripcion,.btnsearch').attr('disabled', boolean);
}
