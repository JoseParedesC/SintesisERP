var JsonValidate = [{ id: 'Text_Fecha', type: 'DATE', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'ds_vendedor', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'ds_cliente', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'ds_bod', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];

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
                return '<span class="text-center total" style="">' + row.total.Money() + '</span>'
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
                return "<span class='tdedit action command-edit' data-type='numeric' data-column='cantidad' data-min='1' data-max='9999999999999999999' data-simbol='' data-value='" + row.descuento + "' data-id='" + row.id + "'>" + row.descuento.Money() + "</span>";
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
        }).end().find(".command-edit").on("click", function (e) {
            params = {};
            $(this).hide();
            data = $(this).data();
            tr = $(this).closest('td');
            max = $(this).attr('data-max');
            min = $(this).attr('data-min');
            input.autoNumeric('init');

        });
    });
    $('#descuento,#v_inicial').blur(function () {

        var count = new Array()
        $('#tblcommodity td').find('.total').each(function () {
            count.push(parseFloat(SetNumber($(this).text())))
        })

        var suma = 0
        count.forEach(function (numero) {

            suma = parseFloat(numero) + suma
        });

        Data = {
            Tiva: parseFloat(SetNumber($('#Tiva').text())),
            Tprecio: parseFloat(SetNumber($('#Ttventa').text())),
            Tdctoart: 0,
            Ttotal: suma,
            Tdesc: parseFloat(SetNumber($('#Tinicial').text())) ,
            Tinc: parseFloat(SetNumber($('#Tinc').text())),
            descuento: 0,
            costo: 0,
            Tinicial: parseFloat(SetNumber($('#Tinicial').text()))
        };
        
        TotalizarFactura(Data);
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
        total = parseFloat(SetNumber($('#m_precio').val()))
        total = Number(total) + anticipo;
            if (opt == 'P') {
                valor = total * (val / 100);
                $('#m_discount').val(Number(valor.toFixed(0)).Int());
            }
            else if (opt == 'V') {
                valor = (total <= 0) ? 0.00 : ((val * 100) / total);
                $('#Text_Descuento').val(Number(valor.toFixed(0)).Int());
            }
    });
    $('#id_cal').attr('disabled', 'disabled')
    $('#financiero').on('click', function () {
        if ($(this).prop('checked')) {
            $(' #div_cuotas, #div_btn, #div_cal, #PagoAcreditos, #div_calcular').removeClass('inactive')
            $(' #div_cuotas, #div_btn, #div_cal, #PagoAcreditos, #div_calcular').addClass('active')
        }
        else {
            $(' #div_cuotas, #div_btn, #div_cal, #PagoAcreditos, #div_calcular').removeClass('active')
            $(' #div_cuotas, #div_btn, #div_cal, #PagoAcreditos, #div_calcular').addClass('inactive')
        }
    })
    fieldsMoney();
    $('#descuento').keyup(function () {
        var value = parseFloat(SetNumber($(this).val()));
        $("#Tdescuento").text((value != undefined && value != '') ? '$ ' + value.Money() : '$ ' + (0).Money());
    }).keyup();

    $('#descuento').change(function () {
        if ($(this).val() == '') {
            $(this).val((0).Money())
            $("#Tdescuento").text('$ ' + (0.00).Money())
        }
    })
    $('#v_inicial').change(function () {
        if ($(this).val() == '') {
            $(this).val((0).Money())
            $("#Tinicial").text('$ ' + (0.00).Money())
        }
    })

    $('#v_inicial').keyup(function () {
        var value = parseFloat(SetNumber($(this).val()));
        $("#Tinicial").text((value != undefined && value != '') ? '$ ' + value.Money() : '$ ' + (0).Money());

    }).keyup();

    $('#Text_Descuento, #m_discount').attr('disabled', 'disabled')

    $('#nrocuotas2, #lineacredit').change(function () {

        $('#financiero').attr('data-validate','false')
    })

    
});

$('#btnCalcular').on('click', function () {
    param = {};
    param.cuota = SetNumber($('#nrocuotas2').val());
    param.valor = SetNumber($('#Ttotal').text());
    param.dias = SetDate($('#Text_Fecha').val());
    param.lineacredit = $('#lineacredit').val();
    MethodService("Analisis", "CuotaMensual", JSON.stringify(param), "EndCallBackCuotaMensual");
})
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
            $('#Text_Descuento').val(row.pordcto.Money()).trigger('blur');
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
    $('input[type=checkbox]').prop('checked', false);
    $('#lineacredit').val('').selectpicker('refresh')
    $('#PagoAcreditos, #div_cuotas, #div_cal, #div_calcular').removeClass('active').addClass('inactive')
    $('input.form-control').val('');
    $('#Tdescuento, #Tinicial').text('$ ' + (0).Money())
    $('#Ttotal').text('$ ' + (0).Money())
    $('[money]').val('0.00');
    $('#m_quantity').val('1.00');
    fieldsMoney();
    datepicker();
    $('.entradanumber').html('0');
    $('#btnSave,.btnsearch,#cd_wineridef, #financiero').removeAttr('disabled');
    $('#btnRev, #btnPrint').attr('disabled', 'disbled');
    $('#btnCalcular').attr('disabled',false)
    $('#id_factura').val('0');
    $('#cd_wineridef').val('').selectpicker('refresh');
    Data = {
        Tiva: 0,
        Tprecio: 0, Tdctoart: 0, Ttotal: 0, Tdesc: 0, Tinc: 0, descuento: 0, costo: 0
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
            Parameter.descuento =(SetNumber($('#m_discount').val()))
            Parameter.cuota_ini = SetNumber($('#v_inicial').val());
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
                if ($('#financiero').prop('checked') && $('#id_cal').val() == '$ 0.00') {
                    toastr.error('El valor de las cuotas debe ser mayor a 0', 'Sintesis ERP')
                } else if ($('#financiero').attr('data-validate') == 'false') {
                    toastr.error('Debe volver a calcular la financiación', 'Sintesis ERP')
                }

                else {
                    var sJon = {};
                    sJon.id = ($('#id_factura').val().trim() == "") ? "0" : $('#id_factura').val();
                    sJon.id_vendedor = $('#cd_vendedor').val();
                    sJon.id_cliente = ($('#cd_cliente').val().trim() == "") ? "0" : $('#cd_cliente').val();
                    sJon.id_bodega = ($('#addarticle').attr('data-idbodega') == '') ? '0' : $('#addarticle').attr('data-idbodega');
                    sJon.descuento = SetNumber($('#descuento').val());
                    sJon.valorpagado = 0;
                    sJon.cuota_ini = SetNumber($('#v_inicial').val())
                    sJon.financiero = ($('#financiero').prop('checked')) ? 1 : 0
                    sJon.num_cuot = parseInt($('#nrocuotas2').val());
                    sJon.valor_cuot = SetNumber($('#id_cal').val())
                    sJon.id_lincred = ($('#lineacredit').val().trim() == '' ? null : $('#lineacredit').val())
                    var total = SetNumber($('#Ttotalfac').text());
                    sJon.idToken = $('#idToken').val();
                    MethodService("Facturas", "FacturarCotizacion", JSON.stringify(sJon), "CallbackComodity");
                }
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
        $('#btnCalcular').attr('disabled','disabled')
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
        $('#descuento').val((row.descuento).Money())
        $('#v_inicial').val((row.cuota_ini).Money())
        if (row.financiero == true) {
            $('#financiero').prop('checked', true)
            $(' #div_cuotas, #div_btn, #div_cal, #PagoAcreditos, #div_calcular').removeClass('inactive')
            $(' #div_cuotas, #div_btn, #div_cal, #PagoAcreditos, #div_calcular').addClass('active')
        } else {
            $('#financiero').prop('checked', false)
            $(' #div_cuotas, #div_btn, #div_cal, #PagoAcreditos, #div_calcular').removeClass('active')
            $(' #div_cuotas, #div_btn, #div_cal, #PagoAcreditos, #div_calcular').addClass('inactive')
        }
        $('#lineacredit').val(row.lineacredit)
        $('#nrocuotas2').val(row.num_cuot)
        $('#id_cal').val((row.valor_cuot).Money())


        var div = $('#diventrada');
        div.find('.divarticleadd').hide();
        div.find('[money], .addarticle, select.selectpicker, .btnsearch, input.form-control, textarea, input').not('.search-field').attr('disabled', true);
        div.find('select').selectpicker('refresh');
        div.find('.i-checks').iCheck('update');

        $('#Tdescuento').text('$ ' + (row.descuento).Money())
        $('#Tinicial').text('$ ' + (row.cuota_ini).Money())
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
        window.tblcommodity.bootgrid("reload");
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
    calculos = {
        descuento: parseFloat(SetNumber($('#Tdescuento').text())),
        cuotaini: parseFloat(SetNumber($('#Tinicial').text()))
    }
    $('#Tiva').text('$ ' + Data.Tiva.Money());
    $('#Tinc').text('$ ' + Data.Tinc.Money());
    $('#TdescArt').text('$ ' + Data.Tdctoart.Money());
    $('#Ttventa').text('$ ' + Data.Tprecio.Money());
    if ($('.entradanumber').text() != '0') {
        $('#Ttotal').text('$ ' + (Data.Ttotal).Money());
    } else {
        $('#Ttotal').text('$ ' + (Data.Ttotal - calculos.descuento - calculos.cuotaini).Money());
    }



}

function CallbackComodity(Parameter, Result) {
    json = JSON.parse(Parameter);
    if (!Result.Error) {
        datos = Result.Row;
        $('.entradanumber').html(datos.id);
        $('#id_factura').val(datos.id);
        $('#financiero, #btnCalcular').attr('disabled', 'disabled')
        $('select, input').attr('disabled', 'disabled')
        $('#btnSave,.btnsearch,#cd_wineridef, #financiero').attr('disabled', 'disabled');
        $('#btnRev, #btnPrint').removeAttr('disabled');
        var div = $('.diventrada');
        div.find('[money], .addarticle, select.selectpicker, .btnsearch, input.form-control').attr('disabled', true);
        div.find('select').selectpicker('refresh');
        $('#tblcommodity').find('a.command-delete').remove();
        toastr.success('Cotizacíon Realizada.', 'Sintesis POS');
    }
    else
        toastr.error(Result.Message, 'Sintesis POS');
}

function Reset() {
    $('#id_cal').val('$ 0.00')
    $('#nrocuotas2').val('0')
    $('#lineacredit').val('').selectpicker('refresh')
}

function EndCallBackCuotaMensual(params, answer) {
    if (!answer.Error) {
        data = answer.Table[0];
        $('#id_cal').val('$ ' + data.cuota.Money());
        $('#financiero').attr('data-validate','true')
    } else {
        toastr.error("Verifique los campos requeridos", "Sintesis ERP");
    }
}

function TotalizarFacturadesc(Data) {
    calculos = {
        descuento: parseFloat(SetNumber($('#Tdescuento').text())),
        cuotaini: parseFloat(SetNumber($('#Tinicial').text()))
    }
    $('#Tiva').text('$ ' + Data.Tiva.Money());
    $('#Tinc').text('$ ' + Data.Tinc.Money());
    $('#TdescArt').text('$ ' + Data.Tdctoart.Money());
    $('#Ttventa').text('$ ' + Data.Tprecio.Money());
        $('#Ttotal').text('$ ' + (Data.Ttotal - calculos.descuento + calculos.cuotaini).Money());
}
