const JsonValidate = [{ id: 'Text_Fecha', type: 'DATE', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'codigoccostos', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'ds_bod', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
];

const JsonCommodity = [{ id: 'ds_bod', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'v_code', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'm_quantity', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];

window.tblcommodity = null;
$(document).ready(function () {
    window.tblcommodity = $("#tblcommodity").bootgrid({
        ajax: true,
        rowCount: [100],
        post: function () {
            return {
                'params': function () {
                    var param = {};
                    param.id_entrada = ($('#opTipoEntrada').val() == 'Z') ? $('#id_entrada').val() : $('#id_entradatemp').val();
                    param.opcion = $('#opTipoEntrada').val();
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
            "delete": (column, row) => {
                return ($('#id_entrada').val() == '0' ? "<a class=\"action command-delete\" data-row-id=\"" + row.id + "\"><span class=\"fa fa-2x fa-trash-o text-danger iconfa\"></span></a>" : "");
            },
            "cantidad": (column, row) => {
                return row.cantidad.Money();
            },
            "costo": (column, row) => {
                return row.costo.Money();
            },
            "costototal": (column, row) => {
                return row.costototal.Money();
            },
            "serie": function (column, row) {
                return (row.serie) ? "<a class=\"action command-tdedit-serie\" data-row-cant=\"" + row.cantidad + "\"  data-row-id=\"" + row.id + "\"><span class='tdedit fa fa-2x fa-pencil text-info'></span>" : '';
            },
            "configuracion": function (column, row) {
                return (row.config) ? "<a class=\"action command-tdedit-config\" data-count='" + row.cantidad + "'  data-bodega='" + row.bodega + "'  data-row-id=\"" + row.id + "\"><span class='tdedit action command-lote fa fa-2x fa-wrench text-error' data-column='lote'  data-count='" + row.cantidad + "' data-id='" + row.id + "' data-bodega='" + row.bodega + "'></span>" : '';
            }
        }
    }).on("loaded.rs.jquery.bootgrid", () => {
        window.tblcommodity.find(".command-delete").on("click", function (e) {
            let id = $(this).data("row-id");
            let params = {};
            params.id_articulo = id;
            params.id_entrada = $('#id_entradatemp').val();
            params.factura = $('#facturatemp').val();
            MethodService("Entradas", "ConversionDelArticulo", JSON.stringify(params), 'EndCallbackupdate');
        }).end().find(".command-tdedit-serie").on("click", function (e) {
            let id = $(this).data("row-id");
            params = {};
            params.id_articulo = id;
            params.count = $(this).data("row-cant");
            if ($('.entradanumber').html() != 0) { params.op = 'X' } else { params.op = 'Z' }
            CallSearchLoteSerie(id, 0, 'SF', params.op, 'EndCallbackGetSeries', params.count);
        }).end().find(".command-tdedit-config").on("click", function (e) {
            let id = $(this).data("row-id");
            let cant = $(this).data("count");
            let id_bodega = $(this).data("bodega");
            $('#id_artconf').val(id);
            $('#cantconf').val(cant);
            $('#id_bodegaconf').val(id_bodega);
            window.tbconfig.bootgrid('reload');
            $('#ModalConfigSerieLote').modal({ backdrop: 'static', keyboard: false }, "show");
        })
    });
    window.tbconfig = $("#tbconfig").bootgrid({
        ajax: true,
        post: function () {
            return {
                'params': function () {
                    var param = {};
                    param.id_articulo = $('#id_artconf').val();
                    param.factura = $('#facturatemp').val();
                    param.cantidad = $('#cantconf').val();
                    param.op = $('#opTipoEntrada').val();
                    return JSON.stringify(param);
                },

                'class': "Entradas",
                'method': 'ConversionSearchConfig'
            };
        },
        url: window.appPath + "/Pages/Connectors/ConnectorList.ashx", //conecta los metodos con los controladores*/        
        columnSelection: false,
        formatters: {
            "series": function (column, row) {
                if (row.serie)
                    return "<select multiple name='select' title='Seleccione' data-select='' data-count='" + row.cantidad + "'  data-live-search='true' id='select" + row.id + "' data-id='" + row.id + "' data-size='8' data-bodega='" + row.id_bodega + "' class='selectseries selectpciker form-control'>" + row.series + "</select>"
                else
                    return '';
            }
        }
    }).on("loaded.rs.jquery.bootgrid", () => {
        window.tbconfig.find('select').selectpicker('refresh');
    });

    newEntrada();

});

$('#btnSaveConfig').click(function () {
    error = false;
    xml = "";
    $.each($('#tbconfig select.selectseries'), function (i, e) {
        var $element = $(e);
        count = parseInt($element.attr('data-count'));
        cant = ($element.val() != null) ? $element.val().length : 0;

        if (count != cant) {
            error = true;
            $element.closest('div.btn-group').addClass('errorselect');
        }
        else {
            xml += "<item value='" + setMultiSelect($element.attr("id")) + "' id='" + $element.attr('data-id') + "'/>"
            $element.closest('div.btn-group').removeClass('errorselect');
        }
    });
    if (error)
        toastr.warning("La cantidad de series seleccionadas no es la misma que la que debe agregar.", "Sintesis ERP")
    else if ($('.entradanumber').html() != "0") {
        toastr.error("No se puede guardar series a esta conversion ya creada", 'Sintesis ERP');
    }
    else {
        Parameter = {}
        Parameter.factura = $('#facturatemp').val()
        Parameter.xml = '<root>' + xml + '</root>'
        MethodService("Facturas", "ConversionSaveItemFac", JSON.stringify(Parameter), "EndCallbackTempEntradaConfig");
    }

});

const loadpresentation = (v_code) => {
    let params = {};
    params.filtro = v_code;
    params.op = 'A';
    params.o = 'PR';
    params.formula = 0
    params.id_prod = $('#v_produ').val()
    params.id_articulo = $('#v_produ').val()
    params.idbodega = $('#cd_wineri').val()
    params.id_factura = "";
}

function EndCallbackLoteSerie(params, answer) {
    par = JSON.parse(params);
    if (!answer.Error) {
        let options = "";
        let serie = "";
        let id_articulo = par.id_articulo;

        $.each(answer.data, function (i, e) {
            options += '<option  value="' + e.serie + '" ' + ((e.selected) ? 'selected="true"' : '') + '>' + e.serie + '</option > ';
        });
        $('#select' + id_articulo).html(options).selectpicker('refresh');
    }


}
function EndCallbackArticle(params, answer) {
    if (!answer.Error) {
        if (answer.data.length > 0) {
            var row = answer.data[0];
            $('#addarticle').attr('data-id', row.id)
            $('#nombre').val(row.nombre);
            $('#cd_iva').val(row.id_iva);
            $('#cd_inc').val(row.id_inc);
            $('#divaddart select').selectpicker('refresh');

            $('#divaddart').attr({ 'data-serie': row.serie, 'data-lote': row.lote, 'data-inventario': row.inventario });
            $('.activeserie, .desactiveserie, .activelote, .desactivelote,.activeservice,.desactiveservice').find('input').val('');
            $('#m_quantity').focus().select();
            JsonCommodity[5].required = row.lote;
            JsonCommodity[6].required = row.lote;
            if (row.lote) {
                $('.activelote, .desactivelote').removeClass('desactivelote').addClass('activelote');
            }
            else {
                $('.activelote, .desactivelote').removeClass('activelote').addClass('desactivelote');
            }
            if (row.nombreTipoProducto == 'SERVICIOS' || row.nombreTipoProducto == 'CONSUMO') {
                $('.activeservice, .desactiveservice').removeClass('desactiveservice').addClass('activeservice');
                row.id_retefuente != null ? $('#cd_retefuente').val(row.id_retefuente).selectpicker('refresh') : $('#cd_retefuente').val('').selectpicker('refresh');
                row.id_reteiva != null ? $('#cd_reteiva').val(row.id_reteiva).selectpicker('refresh') : $('#cd_reteiva').val('').selectpicker('refresh');
                row.id_reteica == null ? $('#cd_reteica').val(row.id_reteica).selectpicker('refresh') : $('#cd_reteica').val('').selectpicker('refresh');
            }
            else {
                $('.activeservice, .desactiveservice').removeClass('activeservice').addClass('desactiveservice');
            }

        }
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}



const newEntrada = () => {
    let drDestroy = window.tblcommodity.data('.rs.jquery.bootgrid');
    drDestroy.clear()
    $('#opTipoEntrada').val('T')
    $('input.form-control, select.form-control').val('');
    $('[money]').val('0.00');
    $('#m_quantity').val('0.00');
    fieldsMoney();
    datepicker();
    $('.entradanumber').html('0');
    $('#btnSave').removeAttr('disabled');
    $('#btnRev').attr('disabled', 'disbled');
    $('#id_entrada').val('0');
    let Data = { Ttotal: 0 };
    let div = $('#diventrada');
    div.find('[money], .addarticle, select.selectpicker, .btnsearch, input.form-control').removeAttr('disabled');
    div.find('select').selectpicker('refresh');
    TotalizarEntrada(Data);
    let Parameter = {};
    $('#tblcommodity').bootgrid('reload');
    MethodService("Entradas", "EntradasSaveConsecutivo", JSON.stringify(Parameter), "EndCallbackTempEntrada");
}

window.gridentradas;
$(document).ready(() => {
    $('#btnList').click(() => {
        if (window.gridentradas === undefined) {
            window.gridentradas = $("#tblentradas").bootgrid({
                ajax: true,
                post: () => {
                    return {
                        'params': "",
                        'class': 'Entradas',
                        'method': 'ConversionList'
                    };
                },
                url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
                formatters: {
                    "edit": function (column, row) {
                        return "<a class=\"action command-edit\" data-row-id=\"" + row.id + "\"><span class=\"fa-2x fa fa-pencil iconfa\"></span></a>";
                    },
                    "costo": function (column, row) {
                        return '$ ' + row.costo.Money();
                    },
                    "serie": function (column, row) {

                        return (row.serie) ? "<span class='tdedit action command-serie fa fa-2x fa-pencil text-info' data-column='serie'  data-row-idtemp=\"" + row.idtemp + "\" data-count='" + row.cantidad + "' data-id='" + row.id + "'></span>" : '';
                    },
                    "configuracion": function (column, row) {
                        return (!row.serie && row.lote) ? "<span class='tdedit action command-lote fa fa-2x fa-wrench text-error' data-column='lote'  data-count='" + row.cantidad + "' data-id='" + row.id + "'></span>" : '';
                    }
                }
            }).on("loaded.rs.jquery.bootgrid", () => {
                // Executes after data is loaded and rendered 
                window.gridentradas.find(".command-edit").on("click", function (e) {
                    id = $(this).data("row-id")
                    params = {};
                    params.id = id;
                    MethodService("Entradas", "ConversionGet", JSON.stringify(params), 'EndCallbackGet');
                })
            });
        }
        else
            window.gridentradas.bootgrid('reload');

        $('#ModalEntrada').modal({ backdrop: 'static', keyboard: false }, "show");
    });

    $('#btnRev').click(() => {
        if ($('#id_entrada').val() != '0' && $('#id_entrada').val().trim() != '') {
            if (confirm("Desea revertir la conversión?")) {
                var sJon = {};
                sJon.id = ($('#id_entrada').val().trim() == "") ? "0" : $('#id_entrada').val();
                sJon.factura = ($('#facturatemp').val().trim() == "") ? "0" : $('#facturatemp').val();
                MethodService("Entradas", "RevertirConversion", JSON.stringify(sJon), "CallbackReversion");
            }
        }
    });

    $('#addarticle').click(() => {
        let idarticle = $('#v_produ').val();
        if (validate(JsonCommodity)) {
            var Parameter = {};
            Parameter.id_entrada = $('#id_entradatemp').val();
            Parameter.id_article = idarticle;
            Parameter.id_wineri = SetNumber($('#cd_wineridef').val());
            Parameter.s_wineri = $('#ds_bod').val();
            Parameter.quantity = SetNumber($('#m_quantity').val());
            Parameter.series = ($('#addarticle').attr('data-serie')) != "" ? 1 : 0
            Parameter.lote = 0
            Parameter.factura = $('#facturatemp').val();
            if (Parameter.id_wineri != '' && idarticle != '' && Parameter.quantity != 0)
                MethodService("Entradas", "ConversionAddArticulo", JSON.stringify(Parameter), "EndCallbackAddArticle");
            else
                WriteMessage("Verifique bodega, Producto o Cantidad", 'W');
        }
        $('#addarticle').attr('data-serie', "")
    });

    $('#btnPrint').click(() => {
        var identrada = $('#id_entrada').val();
        param = 'id|' + identrada + ';'
        PrintDocument(param, 'MOVENTRADA', 'CODE');
    });

    $('#btnnew').click(() => {
        $('#tblcommodity').bootgrid('reload');
        newEntrada();
    });

    $('#btnSave').click(() => {
        if (validate(JsonValidate)) {
            if (window.tblcommodity.bootgrid("getTotalRowCount") > 0) {
                var sJon = {};
                sJon.fecha = SetDate($('#Text_Fecha').val());
                sJon.concepto = $('#cd_concepto').val();
                sJon.id_entradatemp = $('#id_entradatemp').val();
                sJon.factura = $('#facturatemp').val();
                sJon.bodegadef = $('#cd_wineridef').val()
                sJon.id_tipodoc = $('#cd_tipodoc').val();
                sJon.centrocosto = $('#id_ccostos').val();
                $('#btnSave').button('loading');
                MethodService("Entradas", "FacturarConversion", JSON.stringify(sJon), "CallbackComodity");
            }
            else
                toastr.warning("No ha agregado ningun artículo.", 'Sintesis ERP');
        }
    });
});

const EndCallbackGet = (Parameter, Result) => {
    if (!Result.Error) {
        var row = Result.Row;
        $('#tblcommodity').find('a.command-delete').remove();
        if (row.estado == 'PROCE') {
            $('#btnSave').attr('disabled', 'disabled');
            $('#btnRev').removeAttr('disabled');
        }
        else {
            $('#btnSave, #btnRev').attr('disabled', 'disabled');
        }

        $('#opTipoEntrada').val('Z')
        $(this).attr('data-option');
        $('#id_entrada').val(row.id);
        $('#facturatemp').val(row.id);
        $('.entradanumber').text(row.id);
        $('#Text_Fecha').val(row.fechadocumen);
        $('#id_ccostos').val(row.id_centrocosto);
        $('#codigoccostos').val(row.centrocosto);
        $('#cd_wineridef').val(row.id_bodegadef);
        $('#cd_tipodoc').val(row.id_tipodoc);
        $('#ds_bod').val(row.bodega);

        var div = $('#diventrada');
        div.find('[money], .addarticle, select.selectpicker, .btnsearch, input.form-control, textarea').attr('disabled', true);
        div.find('select').selectpicker('refresh');

        var drDestroy = window.tblcommodity.data('.rs.jquery.bootgrid');
        drDestroy.clear();
        drDestroy.append(Result.Table);
        window.tblcommodity.bootgrid('reload');


        TotalizarEntrada(row);
        window.setTimeout(() => {
            $('#tblcommodity').find('a.command-delete').remove();
            $('#ModalEntrada').modal('hide');
        }, 4);
    }
    else {
        toastr.error(Result.Message, 'Sintesis ERP');
    }
}

const EndCallbackupdate = (params, Result) => {
    if (!Result.Error) {
        param = JSON.parse(params);
        window.tblcommodity.bootgrid('reload');
        Data = Result.Row;
        TotalizarEntrada(Data);
        $('#ModalSeries').modal('hide');
    }
    else {
        toastr.error(Result.Message, 'Sintesis ERP');
    }
}

const EndCallbackAddArticle = (Parameter, Result) => {
    if (!Result.Error) {
        $('#v_code').val('');
        $('#v_presen').html('').selectpicker('refresh');
        if ($('#cd_wineridef').val() == '0' || $('#cd_wineridef').val() == null)
            $('#cd_wineri').val('0').selectpicker('refresh');
        $('.addart').val('0.00');
        $('#m_quantity').val('1.00');
        cjson = JSON.parse(Parameter);
        Data = Result.Row;
        window.tblcommodity.bootgrid('reload');
        TotalizarEntrada(Data);
        $('#v_code').focus();
    }
    else {
        toastr.error(Result.Message, 'Sintesis ERP');
    }
}

const TotalizarEntrada = (Data) => {
    $('#Tcosto').text('$ ' + Data.Ttotal.Money());
}

const EndCallbackTempEntrada = (Parameter, Result) => {
    if (!Result.Error) {
        Data = Result.Row;
        $('#id_entradatemp').val(Data.id);
        $('#facturatemp').val(Data.factura);
        window.tblcommodity.bootgrid('reload');
    }
    else {
        toastr.error(Result.Message, 'Sintesis ERP');
    }
}

const EndCallbackTempEntradaConfig = (Parameter, Result) => {
    if (!Result.Error) {
        Data = Result.Row;
        toastr.info("Guardado temporal realizado.", 'Sintesis ERP');
        $('#ModalConfigSerieLote').modal('hide');
    }
    else {
        toastr.error(Result.Message, 'Sintesis ERP');
    }
}

const CallbackReversion = (Parameter, Result) => {
    json = JSON.parse(Parameter);
    if (!Result.Error) {
        datos = Result.Row;
        $('.entradanumber').html(datos.id);
        $('#id_entrada').val(datos.id);
        $('#btnSave, #btnRev').attr('disabled', 'disabled');
        var div = $('#diventrada');
        div.find('[money], .addarticle, select.selectpicker, .btnsearch, input.form-control').attr('disabled', true);
        div.find('select').selectpicker('refresh');
        $('#tblcommodity').find('a.command-delete').remove();
        toastr.success('Conversión Revertida.', 'Sintesis ERP');
    }
    else
        toastr.error(Result.Message, 'Sintesis ERP');
}

const CallbackComodity = (Parameter, Result) => {
    if (!Result.Error) {
        let datos = Result.Row;
        $('#btnSave').button('reset');

        $('.entradanumber').html(datos.id);
        $('#id_entrada').val(datos.id);
        setTimeout(function () {
            $('#btnSave').attr('disabled', 'disabled');
        }, 0);

        $('#btnRev').removeAttr('disabled');
        let div = $('#diventrada');
        div.find('[money], .addarticle, select.selectpicker, .btnsearch, input.form-control').attr('disabled', true);
        div.find('select').selectpicker('refresh');
        $('#tblcommodity').find('a.command-delete').remove();

        toastr.success('Conversión facturada.', 'Sintesis ERP');

    }
    else {
        toastr.error(Result.Message, 'Sintesis ERP');
    }
}


function EndCallbackArticleSerie(params, answer) {
    par = JSON.parse(params);
    if (!answer.Error) {
        var options = "";
        var serie = "";
        var id_articulo = "";

        $.each(answer.data, function (i, e) {
            options += '<option  value="' + e.serie + '" ' + ((e.selected) ? 'selected="true"' : '') + '>' + e.serie + '</option > ';
        });
        if (par.op == 'T') {
            $('#cd_series').html(options).selectpicker('refresh');
        }
        else {
            $('#setseries').html(options).selectpicker('refresh');
            if ($('#opTipoFactura').val() != 'T')
                $('#ModalSeries').modal({ backdrop: 'static', keyboard: false }, "show");
        }
    }
    else {
        toastr.warning(answer.Message, 'Sintesis ERP');
        $('#cd_series').html('').selectpicker('refresh');
    }
    if (par.op == 'T') {
        $('div.conf').show();
    }
}

function EndCallbackGetSeries(params, answer) {
    if (!answer.Error) {

        par = JSON.parse(params);
        table = answer.data;
        $('#listseries').html('');
        $('#btnSaveSeries').attr('data-id', par.id_articulo);
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
        $('#ModalSeries').modal({ backdrop: 'static', keyboard: false }, 'show');
    }
    else {
        toastr.warning(answer.Message, 'Sintesis ERP');
    }
}

$('#btnSaveSeries').click(function () {
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
        params.id_proveedor = 0
        params.id_proveedorfle = 0
        params.flete = 0;
        params.value = "0";
        params.extravalue = series;
        params.id_entrada = $('#id_entradatemp').val();
        params.oldvalue = "";
        params.modulo = 'E';
        $('#addarticle').attr('data-serie', series)
        var btn = $(this);
        if ($('.entradanumber').html() != "0") {
            toastr.error("No se puede guardar series a esta conversion ya creada", 'Sintesis ERP');
        } else {
            MethodService("Entradas", "EntradasSetArticulo", JSON.stringify(params), 'EndCallbackupdate');
        }
    }
});


function ValidarSerie(vector, serie) {
    if (vector.indexOf(serie) != -1)
        return true;
    else
        return false;
}



function CallSearchLoteSerie(id_articulo, id_bodega, opcion, op, callback, contador) {
    params = {};
    params.id_articulo = id_articulo;
    params.id_bodega = id_bodega;
    params.opcion = opcion;
    params.op = op;
    params.id_factura = $('#id_entradatemp').val();
    params.proceso = op;
    params.count = contador
    MethodService("Facturas", "FacturasBuscadorSerieLote", JSON.stringify(params), callback);
}

const SelecProducto = (select) => {
    if (($('#id_bod').val() != '' && select.inventarial) || !select.inventarial)
        if (select.data != 0) {
            $('#addarticle').attr('data-idbodega', $('#id_bod').val());
            loadpresentation(select.data, 0, select.data, $('#id_bod').val());
        }
        else {
            $('#addarticle').attr('data-id', '0');
            $('#nombre').val("");
        }
    else {
        $('#v_code').val("");
        toastr.info('Para seleccionar el producto, debe seleccionar la bodega.', 'Sintesis ERP');
    }
}

$('#v_lote').autocomplete({
    serviceUrl: window.appPath + "/Pages/Connectors/Connector.ashx",
    type: 'post',
    datatype: 'json',
    paramName: 'keyword',
    params: { 'class': 'Lote', method: 'LotesBuscador' },
    noCache: true,
    onSelect: function (select) {
        if (select.data != '') {
            $('#v_lote').val(select.value);
            $('#Text_FechaV2').attr('disabled', true).val(select.data);
        }
        else {
            $('#Text_FechaV2').removeAttr('disabled').val('');
        }
    },
    onSearchStart: function (query) {
        query.params = JSON.stringify({ filtro: query.keyword, op: 'ET', id: $('#id_entradatemp').val() });
        $('#Text_FechaV2').removeAttr('disabled').val('');
    },
    minChars: 2,
    transformResult: function (response) {
        json = JSON.parse(response).ans;
        var object = json.data;
        if (object.length > 0) {
            return {
                suggestions: $.map(object, function (dataItem) { return { value: dataItem.id, data: dataItem.name }; })
            };
        }
        else {
            return { suggestions: [] }
        }
    }
});



