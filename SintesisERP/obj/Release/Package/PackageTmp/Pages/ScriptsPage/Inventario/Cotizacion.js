var JsonValidate = [{ id: 'Text_Fecha', type: 'DATE', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'ds_vendedor', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'ds_cliente', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];

var JsonCommodity = [{ id: 'v_code', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'nombre', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'm_quantity', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'm_precio', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];


window.tblcommodity = null;
window.tblconcepto = null;
$(document).ready(function () {
    window.tblcommodity = $("#tblcommodity").bootgrid({
        ajax: true,
        rowCount: [100],
        post: function () {
            return {
                'params': function () {
                    var param = {};
                    param.id_factura = $('#idToken').val();
                    param.opcion = $('#opTipoFactura').val();
                    param.id_fac = $('#id_factura').val();
                    return JSON.stringify(param);
                },
                'class': "Facturas",
                'method': 'FacturasItemList'
            };
        },
        url: window.appPath + "/Pages/Connectors/ConnectorList.ashx", //conecta los metodos con los controladores*/
        // rowCount: -1,
        columnSelection: false,
        formatters: {
            "delete": function (column, row) {
                if ($('#opTipoFactura').val() == 'T')
                    return "<a class=\"action command-delete\" data-row-id=\"" + row.id + "\"><span class=\"fa fa-2x fa-trash-o text-danger iconfa\"></span></a>";
                else
                    return '';
            },
            'inc': function (column, row) {
                return row.inc.Money();
            },
            'valor': function (column, row) {
                return row[column.id].Money();
            },
            "total": function (column, row) {
                return row.total.Money();
            },
            "precio": function (column, row) {
                return row.precio.Money();
            },
            "cantidad": function (column, row) {
                return row.cantidad.Money();
            },
            "iva": function (column, row) {
                return row.iva.Money();
            },
            "descuento": function (column, row) {
                return row.descuento.Money();
            }
        }
    }).on("loaded.rs.jquery.bootgrid", function () {
        window.tblcommodity.find(".command-delete").on("click", function (e) {
            id = $(this).data("row-id");
            params = {};
            params.id_articulo = id;
            params.idToken = $('#idToken').val();
            params.descuento = 0;
            params.id_anticipo = 0;
            MethodService("Facturas", "FacturasDelArticulo", JSON.stringify(params), 'EndCallbackupdate');
        });
    });

    newCotizacion();

    $('#v_code').autocomplete({
        serviceUrl: window.appPath + "/Pages/Connectors/Connector.ashx",
        type: 'post',
        datatype: 'json',
        paramName: 'keyword',
        params: { 'class': 'Productos', method: 'ArticulosBuscador' },
        noCache: true,
        onSelect: function (select) {
            if (($('#cd_wineridef').val() != '' && select.inventarial) || !select.inventarial)
                if (select.data != 0) {
                    $('#addarticle').attr('data-idbodega', $('#cd_wineridef').val());
                    loadpresentation(select.data, 0, select.data, $('#cd_wineridef').val());
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
            query.params = JSON.stringify({ filtro: query.keyword, op: 'A', o: '', formula: 0, id_prod: 0 });
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

    $('#Text_Descuento, #m_discount').blur(function () {
        opt = $(this).attr('data-option');
        val = SetNumber($(this).val());
        val = (val != '') ? val : 0;
        anticipo = 0;
        total = SetNumber($('#Ttotal').attr('data-total'));
        total = Number(total) + anticipo;
        if (window.tblcommodity.bootgrid("getTotalRowCount") > 0 || window.tblconcepto.bootgrid("getTotalRowCount") > 0) {
            //if (total > 0) {
            if (opt == 'P') {
                valor = total * (val / 100);
                $('#m_discount').val(Number(valor.toFixed(0)).Int());
            }
            else if (opt == 'V') {
                valor = (total <= 0) ? 0.00 : ((val * 100) / total);
                $('#Text_Descuento').val(Number(valor.toFixed(0)).Int());
            }
            var Parameter = {};
            Parameter.idToken = $('#idToken').val();
            var val1 = SetNumber($('#m_discount').val());
            var val2 = SetNumber($('#Text_Descuento').val());
            val1 = (val1 != '') ? val1 : 0;
            val2 = (val2 != '') ? val2 : 0;
            Parameter.descuento = val2;
            Parameter.valdescuento = val1;
            Parameter.id_anticipo = 0;
            MethodService("Facturas", "FacturasRecalcular", JSON.stringify(Parameter), "EndCallbackRecalculo");
        }
        else {
            Data = {
                Tiva: 0, Tprecio: 0, Tdctoart: 0, Ttotal: 0, Tdesc: 0
            };
            TotalizarFactura(Data);
            $('#Text_Descuento, #m_discount').val('0');
        }
    });

});

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

function EndCallbackArticle(params, answer) {

    if (!answer.Error) {
        if (answer.data.length > 0) {
            var row = answer.data[0];
            $('#addarticle').attr('data-id', row.id)
            $('#nombre').val(row.nombre);
            $('#cd_iva').val(row.id_iva);
            $('#cd_inc').val(row.id_inc);
            $('#m_precio').val(row.precio.Money());
            $('#existencia').val(row.existencia.Money());
            $('#divaddart select').selectpicker('refresh');
            $('#divaddart').attr({ 'data-serie': row.serie, 'data-lote': row.lote, 'data-inventario': row.inventario });

            $('#m_quantity').focus().select();
        }
    }
    else {
        toastr.warning(answer.Message, 'Sintesis ERP');
    }
}

function newCotizacion() {
    drDestroy = window.tblcommodity.data('.rs.jquery.bootgrid');
    drDestroy.clear();

    $('input.form-control').val('');
    $('[money]').val('0.00');
    $('#m_quantity').val('1.00');
    fieldsMoney();
    datepicker();
    $('.entradanumber').html('0');
    $('#btnSave,.btnsearch,#cd_wineridef').removeAttr('disabled');
    $('#btnRev, #btnPrint').attr('disabled', 'disbled');
    $('#id_factura').val('0');
    $('#cd_wineridef').val('').selectpicker('refresh');
    Data = {
        Tiva: 0,
        Tprecio: 0, Tdctoart: 0, Ttotal: 0, Tdesc: 0, Tinc: 0
    };
    var div = $('#diventrada');
    div.find('[money], .addarticle, select.selectpicker, .btnsearch, input.form-control').removeAttr('disabled');
    div.find('select').selectpicker('refresh');
    $('.divarticleadd').css('display', 'block');
    $('#opTipoFactura').val('T');
    TotalizarFactura(Data);
    var Parameter = {};
    MethodService("General", "GetConsecutivo", JSON.stringify(Parameter), "EndCallbackTempFactura");
}

window.gridfacturas;
$(document).ready(function () {
    $('#btnList').click(function () {
        if (window.gridfacturas === undefined) {
            window.gridfacturas = $("#tblfacturas").bootgrid({
                ajax: true,
                post: function () {
                    return {
                        'params': "",
                        'class': 'Facturas',
                        'method': 'CotizacionList'
                    };
                },
                url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
                formatters: {
                    "edit": function (column, row) {
                        return "<a class=\"action command-edit\" data-row-id=\"" + row.id + "\"><span class=\"fa-2x fa fa-eye iconfa\"></span></a>";
                    },
                    "total": function (column, row) {
                        return '$ ' + row.total.Money();
                    }
                }
            }).on("loaded.rs.jquery.bootgrid", function () {
                // Executes after data is loaded and rendered 
                window.gridfacturas.find(".command-edit").on("click", function (e) {
                    id = $(this).data("row-id")
                    params = {};
                    params.id = id;
                    MethodService("Facturas", "CotizacionGet", JSON.stringify(params), 'EndCallbackGet');
                })
            });
        }
        else
            window.gridfacturas.bootgrid('reload');

        $('#ModalFacturas').modal({ backdrop: 'static', keyboard: false }, "show");
    });

    $('#addarticle').click(function () {
        var idarticle = $('#addarticle').attr('data-id');
        if (validate(JsonCommodity)) {
            var Parameter = {};
            Parameter.idToken = $('#idToken').val();
            Parameter.id_article = idarticle;
            Parameter.id_bodega = ($('#addarticle').attr('data-idbodega') == '') ? '0' : $('#addarticle').attr('data-idbodega');
            Parameter.quantity = SetNumber($('#m_quantity').val());
            Parameter.precio = SetNumber($('#m_precio').val());
            Parameter.descuento = 0;
            $('#addarticle').button('loading');
            MethodService("Facturas", "CotizacionAddArticulo", JSON.stringify(Parameter), "EndCallbackAddArticle");
        }
    });

    $('#btnPrint').click(function () {
        var idfactura = $('#id_factura').val();
        param = 'id|' + idfactura + ';'
        PrintDocument(param, 'MOVCOTIZACION', 'CODE');
    });



    $('#btnnew').click(function () {
        newCotizacion();
    });

    $('#btnSave').click(function () {
        if (validate(JsonValidate)) {
            if (window.tblcommodity.bootgrid("getTotalRowCount") > 0) {
                var sJon = {};
                sJon.id = ($('#id_factura').val().trim() == "") ? "0" : $('#id_factura').val();
                sJon.id_vendedor = $('#cd_vendedor').val();
                sJon.id_cliente = ($('#cd_cliente').val().trim() == "") ? "0" : $('#cd_cliente').val();
                sJon.id_bodega = ($('#addarticle').attr('data-idbodega') == '') ? '0' : $('#addarticle').attr('data-idbodega');
                sJon.descuento = 0;
                sJon.valorpagado = 0;
                var total = SetNumber($('#Ttotalfac').text());
                sJon.idToken = $('#idToken').val();
                $('#btnSave').button('loading');
                MethodService("Facturas", "FacturarCotizacion", JSON.stringify(sJon), "CallbackComodity");
            }
            else
                toastr.warning("No ha agregado ningun artículo o concepto.", 'Sintesis POS');
        }
    });
});

function EndCallbackRecalculo(Parameter, Result) {
    if (!Result.Error) {
        Data = Result.Row;
        TotalizarFactura(Data);
    }
    else {
        toastr.error(Result.Message, 'Sintesis POS');
    }
}

function EndCallbackTempFactura(Parameter, Result) {
    if (!Result.Error) {
        Data = Result.Value;
        $('#idToken').val(Data);
        window.tblcommodity.bootgrid('reload');
    }
    else {
        toastr.error(Result.Message, 'Sintesis POS');
    }
}

function EndCallbackGet(Parameter, Result) {
    if (!Result.Error) {
        var row = Result.Row;
        $('#btnPrint').removeAttr('disabled');
        if (row.estado == 'PROCESADO') {
            $('#btnSave, #btnTemp, #btnconf').attr('disabled', 'disabled');
            $('#btnRev').removeAttr('disabled');
        }
        else {
            $('#btnSave, #btnRev, #btnconf').attr('disabled', 'disabled');
        }

        $(this).attr('data-option');
        $('#opTipoFactura').val('C');
        $('#id_factura').val(row.id);
        $('#idToken').val('0');
        $('.entradanumber').text(row.id);
        $('#cd_cliente').val(row.id_cliente);
        $('#ds_cliente').val(row.cliente);
        $('#ds_vendedor').val(row.vendedor);
        $('#cd_wineridef').val(row.id_bodega)
        $('#ds_bod').val(row.nombre)


        var div = $('#diventrada');
        div.find('.divarticleadd').hide();
        div.find('[money], .addarticle, select.selectpicker, .btnsearch, input.form-control, textarea').not('.search-field').attr('disabled', true);
        div.find('select').selectpicker('refresh');
        div.find('.i-checks').iCheck('update');


        TotalizarFactura(row);
        $('#ModalFacturas').modal('hide');

        window.tblcommodity.bootgrid('reload');


    }
    else {
        toastr.error(Result.Message, 'Sintesis POS');
    }
}

function EndCallbackupdate(params, Result) {
    if (!Result.Error) {
        Data = Result.Row;
        TotalizarFactura(Data);
        window.tblcommodity.bootgrid('reload');
    }
    else {
        toastr.error(Result.Message, 'Sintesis ERP');
    }

}

function EndCallbackAddArticle(Parameter, Result) {
    if (!Result.Error) {
        $('#v_code').val('');
        $('#id_concepto').val('0');
        $('#nombre').val('');
        $('.addart').val('0.00');
        $('#m_quantity').val('1.00');
        $('#existencia').val('0.00');
        $('#cd_wineridef').attr('disabled', 'disabled');
        cjson = JSON.parse(Parameter);
        Data = Result.Row;
        TotalizarFactura(Data);
        window.tblcommodity.bootgrid('reload');
        $('#Ttotal').attr('data-total', Data.Ttotal);
        $('#v_code').focus();
    }
    else {
        toastr.error(Result.Message, 'Sintesis POS');
    }

    $('#addarticle').button('reset');
}

function TotalizarFactura(Data) {
    $('#Tiva').text('$ ' + Data.Tiva.Money());
    $('#Tinc').text('$ ' + Data.Tinc.Money());
    $('#TdescArt').text('$ ' + Data.Tdctoart.Money());
    $('#Ttventa').text('$ ' + Data.Tprecio.Money());
    $('#Ttotal').text('$ ' + Data.Ttotal.Money());
}

function CallbackComodity(Parameter, Result) {
    $('#btnSave').button('reset');
    if (!Result.Error) {
        datos = Result.Row;
        $('.entradanumber').html(datos.id);
        $('#id_factura').val(datos.id);
        $('#btnSave,.btnsearch,#cd_wineridef').attr('disabled', 'disabled');
        $('#btnRev, #btnPrint').removeAttr('disabled');
        var div = $('.diventrada');
        div.find('[money], .addarticle, select.selectpicker, .btnsearch, input.form-control').attr('disabled', true);
        div.find('select').selectpicker('refresh');
        $('#tblcommodity').find('a.command-delete').remove();
        toastr.success('Cotizacíon Realizada.', 'Sintesis POS');
    }
    else {
        toastr.error(Result.Message, 'Sintesis POS');
    }
}

