var JsonValidate = [{ id: 'cd_tipodoc', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
{ id: 'codigoccostos', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
{ id: 'ds_provider', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];
var JsonPagos = [
    { id: 'cd_formapago', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'voucher', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' }];


window.gridbod;
function Loadtable() {
    window.gridbod = $("#tblcommodity").bootgrid({
        ajax: true,
        post: function () {
            return {
                'params': function () {
                    var param = {};
                    param.id_proveedor = $('#cd_provider').val();
                    param.id_comprobante = $('#id_pagoprove').val();
                    param.fecha = SetDate(($('#Text_Fecha').val()));
                    return JSON.stringify(param);
                },
                'class': 'PagoProveedores',
                'method': 'PagoProveedoresList'
            };
        },
        url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
        formatters: {


            "view": function (column, row) {
                return "<a class=\"action command-view\" data-row-id=\"" + row.id_documento + "\" ><span class=\" fa-2x fa fa-eye iconfa \"></span></a>";
            },
            "state": function (column, row) {
                return "<a class=\"action command-state\"   data-row-id=\"" + row.id + "\"  data-row-factura=\"" + row.numfactura + "\" data-row-vlr=\"" + row.SaldoActual + "\"   >" +
                    "<span id='state" + row.id + "' class=\"fa fa-2x fa-fw fa-square-o text-danger  iconfa\"></span></a>";
            },
            "pay": function (column, row) {
                return "<span id='pay" + row.id + "' class='tdedit action command-edit' data-type='numeric' data-column='pay' data-min='0' data-max='999999999999999999' data-simbol='$' data-value='" + row.SaldoActual + "' data-id='" + row.id + "'>$ 0.00</span>";
            },
            "saldo": function (column, row) {
                return row.SaldoActual.Money();
            }
        }
    }).on("loaded.rs.jquery.bootgrid", function () {
        // Executes after data is loaded and rendered 
        window.gridbod.find(".command-state").on("click", function (e) {
            data = $(this).data();
            valor = $(this).data("row-vlr");
            total = parseFloat(SetNumber($('#mtotal_proveedor').text()))
            var state = $(this).children();
            if (state.attr('class') == 'fa fa-2x fa-fw fa-square-o text-danger  iconfa') {
                state.attr('class', 'fa fa-2x fa-fw fa-check-square-o text-success  iconfa');
                $('#pay' + data.rowId).html('$ ' + valor.Money());
                total = total + valor;
            } else {
                total = total - SetNumber($('#pay' + data.rowId).html());
                state.attr('class', 'fa fa-2x fa-fw fa-square-o text-danger  iconfa');
                $('#pay' + data.rowId).html('$ 0.00 ');
            }
            $('#mtotal_proveedor').text('$ ' + total.Money());
            $('#mtotal').text('$ ' + (parseFloat(SetNumber($('#mtotal_concepto').text())) + total - parseFloat(SetNumber($('#mtotalanticipo').text()))).Money());
        }).end().find(".command-edit").on("dblclick", function (e) {
            params = {};
            data = $(this).data();
            tr = $(this).closest('td');
            column = $(this).data().column;
            selector = $(this);
            state = ($('#state' + data.id).attr('class'));
            if ((column == 'pay') && state == 'fa fa-2x fa-fw fa-check-square-o text-success  iconfa') {
                $(this).hide();
                max = 9999999999.99;
                min = 0;
                input = $('<input class="form-control rowedit" date-type="numeric" data-oldvalue="' + data.value + '" data-column="' + data.column + '" data-id="' + data.id + '" value="' + SetNumber(selector.html()) + '" money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="' + min + '" data-v-max="' + max + '">');
                input.autoNumeric('init');

                input.blur(function () {
                    var row = $(this).data();
                    newvalue = $(this).val();
                    if (column == 'pay') {
                        total = parseFloat(SetNumber($('#mtotal_proveedor').text()));
                        total = total - parseFloat(SetNumber(selector.attr('data-value')));
                        total = total + parseFloat(SetNumber(newvalue));
                        $('#mtotal_proveedor').text('$ ' + total.Money());
                                                $('#mtotal').text('$ ' + (parseFloat(SetNumber($('#mtotal_concepto').text())) + total - parseFloat(SetNumber($('#mtotalanticipo').text()))).Money());
                        $('#pay' + row.id).attr('data-value', newvalue);
                        ($(this).remove());
                        $('#pay' + row.id).html('$ ' + newvalue);
                        $('#pay' + row.id).show();
                    }
                });
                tr.find('.tdedit').hide();
                tr.append(input);
                input.focus().select();
            }

        }).end().find(".command-view").on("click", function (e) {
            var identrada = $(this).data().rowId;
            param = 'id|' + identrada + ';'
            PrintDocument(param, 'MOVENTRADA', 'CODE');
        });
        $("#tblPagoPro [money]").autoNumeric('init');
    });


}
window.gridpagosreal;
$(document).ready(function () {
    window.gridrecibos = $("#tblrecibos").bootgrid({
        ajax: true,
        post: function () {
            return {
                'params': function () {
                    var param = {};
                    param.id_proveedor = $('#cd_provider').val();
                    param.id_comprobante = $('#id_pagoprove').val();
                    param.fecha = SetDate(($('#Text_Fecha').val()));
                    return JSON.stringify(param);
                },
                'class': 'PagoProveedores',
                'method': 'PagoProveedoresList'
            };
        },
        url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
        formatters: {
            "valorFactura": function (column, row) {
                return '$ ' + row.totalEntrada.Money();
            },
            "valor": function (column, row) {
                return '$ ' + row.valor.Money();
            },
            "ver": function (column, row) {
                return "<a class=\"action command-ver\" data-row-id=\"" + row.id + "\"><span class=\"fa fa-2x fa-print iconfa\"></span></a>";
            },
            "rever": function (column, row) {
                return "<a class=\"action command-rever\" data-row-id=\"" + row.id + "\"><span class=\"fa fa-2x fa-fw fa-exclamation-triangle text-warning  iconfa\" /></a>";

            }
        }
    })
});

$('#btnList').click(function () {
    if (window.gridpagosreal === undefined) {
        window.gridpagosreal = $("#tblpagos").bootgrid({
            ajax: true,
            post: function () {
                return {
                    'params': "",
                    'class': 'PagoProveedores',
                    'method': 'ComprobantesEgresosList'
                };
            },
            url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
            formatters: {
                "ver": function (column, row) {
                    return "<a class=\"action command-ver\" data-row-id=\"" + row.id + "\"><span class=\"fa fa-2x fa-print iconfa\"></span></a>";
                },
                "edit": function (column, row) {
                    return "<a class=\"action command-edit\" data-row-id=\"" + row.id + "\"><span class=\"fa-2x fa fa-eye iconfa\"></span></a>";
                },
                "valor": function (column, row) {
                    return '$ ' + row.valorproveedor.Money();
                },
                "valorconce": function (column, row) {
                    return '$ ' + row.valorconcepto.Money();
                },
                "rever": function (column, row) {
                    if (row.nomestado == 'PROCESADO') {
                        return "<a class=\"action command-rever\" data-row-id=\"" + row.id + "\"><span class=\"fa fa-2x fa-fw fa-exclamation-triangle text-warning  iconfa\" /></a>";
                    }
                    else
                        return "";
                }
            }
        }).on("loaded.rs.jquery.bootgrid", function () {
            // Executes after data is loaded and rendered 
            window.gridpagosreal.find(".command-rever").on("click", function (e) {
                id = $(this).data("row-id")
                if (id != '0' && id != '') {
                    if (confirm("Desea revertir el pago?")) {
                        var sJon = {};
                        sJon.id = id;
                        MethodService("PagoProveedores", "RevertirPago", JSON.stringify(sJon), "CallbackReversionList")
                    }
                }
            }).end().find(".command-ver").on("click", function (e) {
                $('#ModalLoad').modal({ backdrop: 'static', keyboard: false }, "show");
                id = $(this).data("row-id")
                var idpagoprov = id
                param = 'id|' + idpagoprov + ';'
                PrintDocument(param, 'PAGOPROVE', 'CODE');

            }).end().find(".command-log").on("click", function (e) {
                id = $(this).data("row-id");
                $('#id_proce').val(id);
                loadlog();
            }).end().find(".command-edit").on('click', function (e) {
                id = $(this).data("row-id");
                params = {};
                params.id = id;
                MethodService("PagoProveedores", "PagoProveedoresGet", JSON.stringify(params), 'EndCallbackGet');

            })
        });
    }
    else
        window.gridpagosreal.bootgrid('reload');

    $('#Modalpagos').modal({ backdrop: 'static', keyboard: false }, "show");
});

$(document).ready(function () {
    Loadtable();
    CargarTablaConcepto();

});

function CargarTablaConcepto() {
    window.gridconceptos = $("#tblconceptos").bootgrid({
        ajax: true,
        post: function () {
            return {
                'params': function () {
                    var param = {};
                    param.id_comprobante = $('.pagonumber').text();
                    return JSON.stringify(param);
                },
                'class': 'PagoProveedores',
                'method': 'PagoProveedoresConceptoList'
            };
        },
        url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
        formatters: {

            "valor": function (column, row) {
                return row.valor.Money();
            }
        }
    })
}

//Evento que lista las facturas que debe el cliente seleccionado
$('#cd_provider').change(function () {
    $('#m_valor,#mtotal_proveedor').val('$ 0.00');
    $('#id_concepto,#id_conceptoDscto').val(0);
    $('#ds_concepto,#ds_conceptoDscto').val('');
    cleanTableConcepto();
    $('#id_pagoprove').val(0);
    $('#mtotal_proveedor').text('$ 0.00');
    $('#mtotal').text('$ ' + (parseFloat(SetNumber($('#mtotal_concepto').text())) + 0 - parseFloat(SetNumber($('#mtotalanticipo').text()))).Money());
    window.gridbod.bootgrid('reload');
});
$('#Text_Fecha').blur(function () {
    window.gridbod.bootgrid('reload');
});
$('#id_concepto').change(function () {
    $('#tab-1').removeClass('active');
    $('#tab-2').addClass('active');
    ($('#tabdos').parent().addClass('active'));
    ($('#tabuno').parent().removeClass('active'));
    $('#m_valor').removeAttr('disabled');
    $('#m_valor').focus();
    cleanTableConcepto();
});
$('.recalculo').change(function () {
    var Parameter = {};
    Parameter.id_proveedor = ($('#cd_provider').val() != '') ? $('#cd_provider').val() : '0';
    Parameter.flete = 0;
    Parameter.id_entrada = 0;
    Parameter.id_proveedorfle = 0;
    Parameter.anticipo = SetNumber($('#m_anticipo').val());
    Parameter.id_cta = ($('#id_ctaant').val() == '' ? '0' : $('#id_ctaant').val());
    Parameter.fecha = SetDate($('#Text_Fecha').val());
    Parameter.op = $(this).attr('data-op');
    MethodService("Entradas", "EntradasRecalcular", JSON.stringify(Parameter), "EndCallbackRecalculo");
}); 
$('#btnnew').click(function () {
    newpay();
    window.gridbod.bootgrid('reload');
});

$('#addarticle').click(function (e) {
    //if (validate(JsonCommodity)) {
    code = $('#hiddencode').val();
    id_concepto = $('#id_concepto').val();
    nombre = $('#ds_concepto').val();
    total = parseFloat(SetNumber($('#mtotal_concepto').text()));
    valor = parseFloat(SetNumber($('#m_valor').val()));

    if (valor > 0 && id_concepto != 0) {
        var body = $('#tbodconceptos');
        count = body.find('tr[data-concepto="' + id_concepto + '"]');
        valor = valor;
        if (count == undefined || count.length == 0) {
            tr = $('<tr/>').attr({ 'data-concepto': id_concepto, 'data-valor': valor });
            a = $('<a/>').html('<span class="fa fa-2x fa-trash-o text-danger iconfa"></span>').click(function () {
                total = parseFloat(SetNumber($('#mtotal_concepto').text())) - $(this).closest('tr').data().valor;
                $(this).closest('tr').remove();
                
                $('#mtotal_concepto').text('$ ' + total.Money());
                $('#mtotal').text('$ ' + (parseFloat(SetNumber($('#mtotal_proveedor').text())) + total - parseFloat(SetNumber($('#mtotalanticipo').text()))).Money());
            })
            td = $('<td class="text-center"/>').append(a);
            td1 = $('<td class="text-center"/>').html(id_concepto);
            td2 = $('<td class="text-center"/>').html(nombre);
            td3 = $('<td class="text-center"/>').html('$ ' + Number(valor).Money(2));
            tr.append(td, td1, td2, td3);
            body.append(tr);
            total = total + valor;
            $('#cd_concepto').val('');
            $('#ds_concepto').val('');
            $('#m_valor').val('0.00');
            $('#mtotal_concepto').text('$ ' + total.Money());
            $('#mtotal').text('$ ' + (parseFloat(SetNumber($('#mtotal_proveedor').text())) + total - parseFloat(SetNumber($('#mtotalanticipo').text()))).Money());
        }
        else
            toastr.warning("Este Concepto ya esta dentro de la formulación", 'Sintesis ERP');
    }
    else
        toastr.warning("El valor debe ser mayor a 0, ó seleccione concepto.", 'Sintesis ERP');

    $('#hiddencode').val('');
});

$('#btnSave').click(function () {
    if (validate(JsonValidate)) {
        $('#Ttotalfac').text($('#Ttotal').text());
        $('#Tpagado').text("$ 0.00");
        $('#Tcambio').text("$ 0.00");
        $('#valorforma').val("$ 0.00");
        $('#tbdpagos').empty();
        if (SetNumber($('.pagonumber').html()) == 0) {
            if (SetNumber($('#mtotal').text()) >= 0) {
                if (!(SetNumber($('#mtotal').text()) == 0 && SetNumber($('#mtotalanticipo').text()) == 0)) {
                    $('#Ttotalfac').text($('#mtotal').text());
                    var opt = $(this).attr('data-option');
                    if (opt == 'F') {
                        $('#ModalFormas').modal({ backdrop: 'static', keyboard: false }, 'show');
                    }
                } else {
                    toastr.warning("No hay movimientos existente.", 'Sintesis ERP');
                }
            } else {
                toastr.warning("Valor de anticipo es mayor al comprobante.", 'Sintesis ERP');
            }
        } else {
            toastr.warning("Comprobante de egreso fue realizado.", 'Sintesis ERP');

        }
    }
});

$('#addPago').click(function () {

    if (validate(JsonPagos)) {
        json = {};
        json.valor = SetNumber($('#valorforma').val());
        json.id = $('#cd_formapago').val();
        json.tipo = $('#cd_formapago option:selected').text();
        json.voucher = $('#voucher').val();
        total = SetNumber($('#Ttotalfac').text());
        if (json.valor > 0 && json.id != '' && total > 0) {

            var body = $('#tbdpagos');
            tr = $('<tr/>').attr({ 'data-tipo': json.tipo, 'data-valor': json.valor, 'data-id': json.id, 'data-voucher': json.voucher });
            a = $('<a/>').html('<span class="fa fa-2x fa-trash-o text-danger iconfa"></span>').click(function () {
                $(this).closest('tr').remove();
                RecalcularPagos();
            })
            td = $('<td/>').append(a);
            td1 = $('<td />').html(json.tipo);
            td2 = $('<td />').html(Number(json.valor).Money());
            td3 = $('<td/>').html(json.voucher);
            tr.append(td, td1, td2, td3);
            body.append(tr);
            RecalcularPagos();
            cleanpago();
        }
    }
});

//Evento de Impresion de documento generado a Recibo de Caja
$('#btnFact').click(function () {
    var pagosXML = '<root>'
    window.gridbod.find(".command-state").each(function () {
        var state = $(this).children();
        if (state.attr('class') == 'fa fa-2x fa-fw fa-check-square-o text-success  iconfa') {
            pagosXML += '<pago identrada="' + $(this).data("row-id") + '" valor="' + SetNumber(($('#pay' + $(this).data("row-id")).html())) + '" factura="' + $(this).data("row-factura") + '"/>'

        }
    });
    pagosXML += '</root>';
    params = {};
    params.id = $('#id_pagoprove').val();
    params.fecha = SetDate($('#Text_Fecha').val());
    params.id_proveedor = $('#cd_provider').val();
    params.id_tipodoc = $('#cd_tipodoc').val();
    params.id_centrocostos = ($('#id_ccostos').val() == "") ? '0' : $('#id_ccostos').val();
    params.valorproveedor = SetNumber($('#mtotal_proveedor').text());
    params.valorconcepto = SetNumber($('#mtotal_concepto').text());
    params.voucher = $('#voucher').val();
	 params.id_ctaant = ($('#id_ctaant').val().trim() == "") ? "0" : $('#id_ctaant').val();
    params.anticipo = SetNumber($('#m_anticipo').val());
    params.cambio = SetNumber($('#Tcambio').text());
    params.pagosXML = pagosXML;
    params.xmlconceptos = GenerarXMLConceptos();
    params.detalle = $('#descripcion').val();
    var cambio = SetNumber($('#Tcambio').text());
    if (cambio >= 0) {
        var formas = Getxmlforma();
        params.formapago = "<Formas>" + Getxmlforma() + "</Formas>";
        MethodService("PagoProveedores", "ComprobantesEgresosSave", JSON.stringify(params), "EndCallbackPago");

    } else {
        toastr.warning("El valor pagado no puede ser menor al de la factura.", 'Sintesis ERP');

    }
});

$('#cd_tipodoc').change(function () {
    if ($("#id_pagoprove").val() == '0') {
        var valores = $(this).find('option:selected').attr('data-centro');
        var split = valores.split('|~|');
        $('#id_ccostos').val(split[1]);
        $('#codigoccostos').val(split[2]);
    }
    JsonValidate[1].required = (split[0] == '1') ? true : false;
});

$('#cd_formapago').change(function () {
    if ($("#id_pagoprove").val() == '0') {
        var valores = $(this).find('option:selected').attr('data-voucher');
        JsonPagos[1].required = (valores.toUpperCase() == 'TRUE') ? true : false;
        $('#voucher').val('');
    }
});
$('#btnRev').click(function () {
    if ($('#id_pagoprove').val() != '0' && $('#id_pagoprove').val().trim() != '') {
        if (confirm("Desea revertir el pago?")) {
            var sJon = {};
            sJon.id = ($('#id_pagoprove').val().trim() == "") ? "0" : $('#id_pagoprove').val();
            MethodService("PagoProveedores", "RevertirPago", JSON.stringify(sJon), "CallbackReversion");
        }
    }
});
$('#btnPrint').click(function () {
    var idpagoprov = $('#id_pagoprove').val();
    param = 'id|' + idpagoprov + ';'
    PrintDocument(param, 'PAGOPROVE', 'CODE');
});

function newpay() {
    $('#ds_provider,#btnFact').removeAttr('disabled');
    $('#cd_formapago,#cd_tipodoc,#descripcion').removeAttr('disabled');
    $('#cd_provider,#id_pagoprove,#id_ccostos,#id_ctaant').val(0);
    $('#ds_provider,#codigoccostos,#ds_ctaant, #descripcion').val('');
    $('#m_valor,#mtotal_proveedor,#m_anticipo').val('$ 0.00');
    $('#m_valor,#mtotal_proveedor').attr('disabled', true);
    $('#mtotal,#mtotal_proveedor,#mtotal_concepto').text('$ 0.00');
    $('.pagonumber').html(0);
    $('#cajacuotas').css('display', 'block');
    $('#cajarecibos').css('display', 'none');
    $('.i-checks').prop('checked', false).iCheck('update');
    $('#cd_formapago').val(0).selectpicker('refresh');
    $('#cd_tipodoc').val(0).selectpicker('refresh');
    $('#tbodconceptos').empty();
    $('#btnFact').attr('disabled', 'disabled');
    $('#btnSave,#m_valor,.btnsearch,#Text_Fecha,#cd_formapago').removeAttr('disabled');
    $('#btnRev').attr('disabled', true);
    $('#Tpagado').text("$ 0.00");
    $('#Tcambio').text("$ 0.00");
    $('#valorforma').val("$ 0.00");
    $('#tbdpagos').empty();

    var div = $('#diventrada');
    div.find('[money], #addarticle, select.selectpicker, .btnsearch, input.form-control, textarea').not('.search-field').attr('disabled', false);
    div.find('select').selectpicker('refresh');
}

function formReset() {
    div = $('#ModalWineries');
    div.find('input.form-control').val('');
    div.find('textarea').val('');
    $('#btnSave').attr('data-id', '0');
}

function EndCallbackWineries(params, answer) {
    if (!answer.Error) {
        $('#ModalWineries').modal("hide");
        window.gridbod.bootgrid('reload');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
    $('#btnSave').button('reset');
}

function EndCallbackPago(params, answer) {
    if (!answer.Error) {
        data = answer.Row;
        $('#id_pagoprove').val(data.id_pagoprov);
        toastr.success('Pagos Realizados Correctamente.', 'Sintesis ERP');
        $('#btnSave,#m_valor,.btnsearch,#Text_Fecha,#cd_formapago,#cd_tipodoc,#descripcion').attr('disabled', 'disabled');
        var div = $('.divpagos');
        div.find('select').selectpicker('refresh');
        $('.pagonumber').html(data.id_pagoprov);
        $('#btnRev').removeAttr('disabled');
        $("#ModalFormas").modal('hide');
        $('#btnRev').removeAttr('disabled');
        $('#tblcommodity').find('a.command-state').remove();
        $('#tblconceptos').find('.text-danger').remove();
		$('#btnFact').button('reset');							  

    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }

}
function CallbackReversion(Parameter, Result) {
    json = JSON.parse(Parameter);
    if (!Result.Error) {
        datos = Result.Row;
        $('.pagonumber').html(datos.id);
        $('#id_pagoprove').val(datos.idrev);
        $('#btnSave, #btnRev').attr('disabled', 'disabled');
        window.gridbod.bootgrid('reload');
        toastr.success('Entrada Revertida.', 'Sintesis ERP');
    }
    else
        toastr.error(Result.Message, 'Sintesis ERP');
}

function CallbackReversionList(Parameter, Result) {
    json = JSON.parse(Parameter);
    if (!Result.Error) {
        data = Result.Row;
        $('#id_pagoprove').val(data.idrev);
        window.gridrecibos.bootgrid('reload');
        toastr.success('Comprobante de Egreso Revertido.', 'Sintesis ERP');
    }
    else
        toastr.error(Result.Message, 'Sintesis ERP');
}
function EndCallbackGet(params, answer) {
    if (!answer.Error) {
        data = answer.Row;
        if (data.nomestado == 'PROCESADO') {
            $('#btnSave').attr('disabled', 'disabled');
            $('#btnRev').removeAttr('disabled');
        }
        else {
            $('#btnSave,  #btnRev').attr('disabled', 'disabled');
        }
        $('#btnSave').attr('data-id', data.id);
        (data.nomestado == 'REVERSION') ? $('#id_pagoprove').val(data.id_reversion) : $('#id_pagoprove').val(data.id);
        $('.pagonumber').html(data.id);
        $('#descripcion').val(data.detalle);
        $('#ds_provider').val(data.proveedor);
        $('#cd_tipodoc').val(data.id_tipodoc).selectpicker('refresh');
        $('#codigoccostos').val(data.centrocosto);
        if (data.valorconcepto > 0 && data.valorproveedor == 0) {
            paned('#tab-2', '#tabdos', '#tab-1', '#tabuno');
        } else {
            paned('#tab-1', '#tabuno', '#tab-2', '#tabdos');
        }
        $('.i-checks').iCheck('update');
        $('#cajacuotas').css('display', 'none');
        $('#cajarecibos').css('display', 'block');
        $('#mtotal_proveedor').text('$ ' + data.valorproveedor.Money());
        $('#mtotal_concepto').text('$ ' + data.valorconcepto.Money());
		$('#mtotalanticipo').text('$ ' + data.valoranticipo.Money());
        $('#mtotal').text((data.valorconcepto + data.valorproveedor - data.valoranticipo).Money());
        $('#ds_ctaant').val(data.ctaanticipo);
        $('#m_anticipo').val('$ ' + data.valoranticipo.Money());
        window.gridrecibos.bootgrid('reload');
        window.gridconceptos.bootgrid('reload');
        $('#btnPay,#m_valor,.btnsearch,#Text_Fecha,#cd_formapago').attr('disabled', 'disabled');
        $('#btnRev').removeAttr('disabled');

        var div = $('#diventrada');
        div.find('[money], #addarticle, select.selectpicker, .btnsearch, input.form-control, textarea').not('.search-field').attr('disabled', true);
        div.find('select').selectpicker('refresh');

        $('#Modalpagos').modal('hide');

    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}
function EndCallbackRecalculo(Parameter, Result) {
    if (!Result.Error) {
        Data = Result.Row;
        par = JSON.parse(Parameter);
        if (par.op == 'C' && Data.anticipo == 0)
            $('#m_anticipo').attr({ 'data-v-max': 0, 'disabled': 'disabled' }).val('0.00').autoNumeric('init');
        else
            $('#m_anticipo').attr('data-v-max', (Data.anticipo)).val((Data.anticipo).Money()).removeAttr('disabled').autoNumeric('init');
        $('#mtotalanticipo').text('$ ' + (Data.anticipo).Money());
        $('#mtotal').text('$ ' + (parseFloat(SetNumber($('#mtotal_concepto').text())) - Data.anticipo + parseFloat(SetNumber($('#mtotal_proveedor').text()))).Money());

    }
    else {
        toastr.error(Result.Message, 'Sintesis ERP');
    }
}
function EndCallbackupdate(params, answer) {
    if (!answer.Error) {
        window.gridbod.bootgrid('reload');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}
function cleanTableConcepto() {
    if ($('#tbodconceptos').find('tr').length > 0)
        if ($('#tbodconceptos').find('tr')[0].children[0].innerHTML === 'No hay resultado!')
            $('#tbodconceptos').empty();
}
//Funcion que genera el xml de conceptos en la grilla
function GenerarXMLConceptos() {
    var xml = "";
    trs = $('#tbodconceptos').find('tr');
    if (trs.length > 0) {
        $.each(trs, function (i, e) {
            data = $(e).data();
            xml += '<item id_concepto="' + data.concepto + '"  valor="' + data.valor + '" />'
        });
        xml = "<items>" + xml + "</items>"
    }
    return xml;
}

function RecalcularPagos() {
    $('#btnFact').removeAttr('disabled');
    var totalpago = 0;
    var totalfact = SetNumber($('#Ttotalfac').text());
    var cambio = 0;
    trs = $('#tbdpagos').find('tr');
    if (trs.length > 0) {
        $.each(trs, function (i, e) {
            data = $(e).data();
            totalpago += Number(data.valor);
        });
    }
    cambio = totalpago - totalfact;
    $('#Tpagado').text('$ ' + Number(totalpago).Money());

    if (cambio < 0) {
        $('#Tcambio').text('$' + cambio.Money()).addClass("text-danger");

    }
    else {
        $('#Tcambio').text('$' + cambio.Money()).removeClass("text-danger");
    }
};
function Getxmlforma() {
    var xml = "";
    trs = $('#tbdpagos').find('tr');
    if (trs.length > 0) {
        $.each(trs, function (i, e) {
            data = $(e).data();
            xml += '<item idforma="' + data.id + '" vouch="' + data.voucher + '" valor="' + data.valor + '" />'

        });

    }
    return xml;
}
function cleanpago() {
    $('#valorforma').val('$ 0.00');
    $('#cd_formapago').val('').selectpicker('refresh');
    $('#voucher').val('');

}
//Funcion que habilita y deshabilita los tabed 
function paned(x, x1, y, y1) {
    $(x).addClass('active') && $(x1).parent().addClass('active') && $(y).removeClass('active') && $(y1).parent().removeClass('active')
}