var JsonValidate = [{ id: 'cd_tipodoc', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
    { id: 'codigoccostos', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
    { id: 'cd_tipoterce', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
    { id: 'ds_tercero', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'ds_factura', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'id_tipoven', type: 'TEXT', htmltype: 'SELECT', required: false, depends: false, iddepends: '' }];



window.gridsaldos;
function Loadtable() {
    window.gridsaldos = $("#tblcommodity").bootgrid({
        ajax: true,
        post: function () {
            return {
                'params': function () {
                    var param = {};
                    param.id_factura = $('#ds_factura').val();/*$('#Modalcuotas').data('factura') === undefined ? 0 : $('#Modalcuotas').data('factura');*/
                    param.tipotercero = $('#tipotercero1').val() === "" ? 'CL' : $('#tipotercero1').val();
                    param.fecha = SetDate($('#Text_Fecha').val());
                    return JSON.stringify(param);
                },
                'class': 'NotasCartera',
                'method': 'MOvNotasItemsList'
            };
        },
        url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
        formatters: {

            "edit": function (column, row) {
                return "<a class=\"action command-edit\" data-row-id=\"" + row.id + "\"><span class=\"fa-2x fa fa-pencil iconfa\"></span></a>";
            },
            "view": function (column, row) {
                return "<a class=\"action command-view\" data-row-id=\"" + row.id + "\" ><span class=\" fa-2x fa fa-eye iconfa \"></span></a>";
            },
            "state": function (column, row) {
                return "<a class=\"action command-state\"   data-row-id=\"" + row.id + "\"   data-row-vlr=\"" + row.SaldoActual + "\"   >" +
                    "<span id='state" + row.id + "' class=\"fa fa-2x fa-fw fa-square-o text-danger  iconfa\"></span></a>";
            },
            "pay": function (column, row) {
                return "<span id='pay" + row.id + "' class='tdedit action command-edit' data-type='numeric' data-column='pay' data-min='0' data-max='999999999999999999' data-simbol='$' data-value='" + row.SaldoActual + "' data-id='" + row.id + "'>$ 0.00</span>";
            },
            "saldo": function (column, row) {
                return '$ '+row.saldo.Money();
            },
            "vlrcuota": function (column, row) {
                return '$ ' + row.vlrcuota.Money();
            },
            "abono": function (column, row) {
                return '$ ' + row.abono.Money();
            }
        }
    }).on("loaded.rs.jquery.bootgrid", function () {
        // Executes after data is loaded and rendered 
        window.gridsaldos.find(".command-state").on("click", function (e) {
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
            $('#mtotal').text('$ ' + (parseFloat(SetNumber($('#mtotal_concepto').text())) + total).Money());
        }).end().find(".command-edit").on("click", function (e) {
            params = {};
            params.id = id;
            params.tipoterce = $('#cd_tipoterce option:selected').data('option');
            MethodService("NotasCartera", "SaldosGET", JSON.stringify(params), 'EndCallbackGetSaldos');

        });
        $("#tblPagoPro [money]").autoNumeric('init');
    });

 
}

    $('#btnList').click(function () {
        if (window.gridnotas === undefined) {
            window.gridnotas = $("#tblnotas").bootgrid({
                ajax: true,
                post: function () {
                    return {
                        'params': "",
                        'class': 'NotasCartera',
                        'method': 'NotasCarteraList'
                    };
                },
                url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
                formatters: {
                    "ver": function (column, row) {
                        return "<a class=\"action command-ver\" data-row-id=\"" + row.id + "\"><span class=\"fa fa-2x fa-print iconfa\"></span></a>";
                    },
                    "edit": function (column, row) {
                        return "<a class=\"action command-edit\" data-row-id=\"" + row.id + "\"><span class=\"fa-2x fa fa-pencil iconfa\"></span></a>";
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
                window.gridnotas.find(".command-rever").on("click", function (e) {
                    id = $(this).data("row-id")
                    if (id != '0' && id != '') {
                        if (confirm("Desea revertir el pago?")) {
                            var sJon = {};
                            sJon.id = id;
                            MethodService("NotasCartera", "RevertirNotasCartera", JSON.stringify(sJon), "CallbackReversionList")
                        }
                    }
                }).end().find(".command-ver").on("click", function (e) {
                    $('#ModalLoad').modal({ backdrop: 'static', keyboard: false }, "show");
                    id = $(this).data("row-id")
                    var idpagoprov = id
                    param = 'id|' + idpagoprov + ';'
                    PrintDocument(param, 'MOVNOTACARTERA', 'CODE');

                }).end().find(".command-log").on("click", function (e) {
                    id = $(this).data("row-id");
                    $('#id_proce').val(id);
                    loadlog();
                }).end().find(".command-edit").on('click', function (e) {
                    id = $(this).data("row-id");
                    params = {};
                    params.id = id;
                    MethodService("NotasCartera", "NotasCarteraGet", JSON.stringify(params), 'EndCallbackGet');

                })
            });
        }
        else
            window.gridnotas.bootgrid('reload');

        $('#ModalNotas').modal({ backdrop: 'static', keyboard: false }, "show");
    });



$(document).ready(function () {
    Loadtable();
});

$('#btnSave').click(function () {
    if (validate(JsonValidate)) {
        params = {};
        params.id = $('#id_nota').val();
        params.id_tipodoc = $('#cd_tipodoc').val();
        params.id_centrocostos = ($('#id_ccostos').val() == "") ? '0' : $('#id_ccostos').val();
        params.fecha = SetDate($('#Text_Fecha').val());
        params.tipoterce = $('#cd_tipoterce option:selected').data('option');
        params.id_tercero = $('#cd_tercero').val();
        params.id_saldo = $('#cd_factura').val();
        params.id_cuentaant = $('#id_cuentaant').val();
        params.id_cuentaact = $('#id_ctacon').val();
        params.detalle = $('#descripcion').val();
        params.vencimientoact = $('#ischange').prop('checked') ? SetDate($('#Text_FechaVenIni2').val()) : null;
        params.saldoactual = SetNumber($('#m_saldo').val());
        params.tipovenci = $('#ischange').prop('checked') && $('#cd_tipoterce option:selected').data('option')=='CL'  ? $('#id_tipoven').val():null;
        params.dias = $('#nrodias2').val();
        params.cuota = $('#cuotanro').val();
        params.cantcuota = $('#nrocuotas2').val();
        params.changecuota = $('#isNcuota').prop('checked');
		if (parseFloat(SetNumber($('#m_interes').val())) === 0) {
            if ($('#ischange').prop('checked') == true || $('#id_ctacon').val() != 0) {
                $(this).button('loading');
                MethodService("NotasCartera", "NotasCarteraSave", JSON.stringify(params), "EndCallbackSave");
            } else {
                toastr.error('Seleccionar Proceso a realizar', 'Sintesis ERP');
            }
        } else {
            toastr.error('Esta factura tiene intereses de mora, ponerse al dia con los intereses', 'Sintesis ERP');
        }
       

    }
});
//$('#cd_tipoterce').change(function () {
//    tipotercero = $('#cd_tipoterce option:selected').data('option');
//    $('#tipotercero1').val(tipotercero);
//    $('#fechadoc').val(SetDate($('#Text_Fecha').val()));
//    (tipotercero == 'PR') ? $('#isNcuota').attr('disabled', 'disabled') && $('#isNcuota').prop('checked', false) && $('#tipo').val('PROVE') : $('#isNcuota').removeAttr('disabled') && $('#tipo').val('CRED');
    
//   // (tipotercero == 'PR') ? $('#ischange').attr('disabled', 'disabled') && $('#ischange').prop('checked', false) : $('#ischange').removeAttr('disabled') ;    
   
//});
$('#cd_tipoterce,#cd_tercero').change(function () {
    tipotercero = $('#cd_tipoterce option:selected').data('option');
    $('#tipotercero1').val(tipotercero);
    anomes = SetDate($('#Text_Fecha').val());
    hiddentercero = $('#cd_tercero').val()
    if ($(this).attr('id') == 'cd_tipoterce')
        $('#ds_cliente').val('').attr('data-params', "op:T;o:" + tipotercero).removeData('params').data('params');
    $('#ds_factura').val('').attr('data-params', "op:I;o:" + tipotercero + ';id_bodega:' + hiddentercero + ';tipo:' + anomes).removeData('params').data('params');
    $('#ds_ctacon').val('').attr('data-params', "op:J;tipo:" + ((tipotercero == 'PR')?'PROVE':'CRED')).removeData('params').data('params');
    $('.i-checks').iCheck('update');
    // (tipotercero == 'PR') ? $('#ischange').attr('disabled', 'disabled') && $('#ischange').prop('checked', false) : $('#ischange').removeAttr('disabled') ;    

});

//Evento que lista las facturas que debe el cliente seleccionado
$('#cd_factura').change(function () {
    id = $(this).val();
    params = {};
    params.id = id;
    params.tipoterce = $('#cd_tipoterce option:selected').data('option');
    params.fecha = SetDate($('#Text_Fecha').val());
    params.id_cliente = $('#cd_tercero').val();
    params.nrofactura = $('#ds_factura').val();
    MethodService("NotasCartera", "SaldosGET", JSON.stringify(params), 'EndCallbackGetSaldos');
});

$('#cd_tercero').change(function () {
    $('#fechadoc').val(SetDate($('#Text_Fecha').val()));
});
$('#Text_Fecha').blur(function () {
    $('#fechadoc').val(SetDate($('#Text_Fecha').val()));
});

//Evento que me desabilita o habilita el campo fecha
$('#ischange').on('ifChecked', function (event) {
    $('#Text_FechaVenIni2').removeAttr('disabled');
    (tipotercero == 'PR') ? $('#isNcuota').attr('disabled', 'disabled') && $('#isNcuota').prop('checked', false) && ( JsonValidate[5].required = false ): $('#isNcuota').removeAttr('disabled') && (JsonValidate[5].required = true);
    $('.i-checks').iCheck('update');
    
}).on('ifUnchecked', function () {
    $('#Text_FechaVenIni2').attr('disabled', 'disabled');
    $('#isNcuota').prop('checked', false);
    $('#isNcuota').attr('disabled', 'disabled');
    $('#pagoCredito').css('display', 'none');
    JsonValidate[5].required = false;
    $('.i-checks').iCheck('update');
});

$('#isNcuota').on('ifChecked', function (event) {
    $('#pagoCredito').css('display', 'block');
}).on('ifUnchecked', function () {
    $('#pagoCredito').css('display', 'none');
});

$('#btnnew').click(function () {
    newpay();
    window.gridsaldos.bootgrid('reload');
});



$('#cd_tipodoc').change(function () {
    if ($("#id_nota").val() == '0') {
        var valores = $(this).find('option:selected').attr('data-centro');
        var split = valores.split('|~|');
        $('#id_ccostos').val(split[1]);
        $('#codigoccostos').val(split[2]);
    }
    JsonValidate[1].required = (split[0] == '1') ? true : false;
});
$('#btnRev').click(function () {
    if ($('#id_nota').val() != '0' && $('#id_nota').val().trim() != '') {
        if (confirm("Desea revertir la nota?")) {
            var sJon = {};
            sJon.id = ($('#id_nota').val().trim() == "") ? "0" : $('#id_nota').val();
            MethodService("NotasCartera", "RevertirNotasCartera", JSON.stringify(sJon), "CallbackReversion");
        }
    }
});
$('#btnPrint').click(function () {
    var idpagoprov = $('#id_nota').val();
    param = 'id|' + idpagoprov + ';'
    PrintDocument(param, 'MOVNOTACARTERA', 'CODE');
});

function newpay() {
    $('.btnsearch').removeAttr('disabled');
    var div = $('.diventrada');
    $('.datosid,#nrocuotas2').val(0);
    $('#ds_tercero,#codigoccostos,#ds_ctacon,#ds_factura,#Text_cuenta,#tipotercero1').val('');
    $('.pagonumber').html(0);
    $('#isNcuota').prop('checked', false).attr('disabled', true);
    $('.i-checks').iCheck('update');
    $('#pagoCredito').css('display', 'none');
    $('#nrodias2').val(1);
    $('#m_saldo').val('$ 0.00');
    $('#cd_tipodoc,#cd_tipoterce,#id_tipoven').val(0).selectpicker('refresh');
    $('#Text_FechaVenIni2').val('');
    $('#btnSave,#m_valor,.btnsearch,#Text_Fecha,#cd_formapago').removeAttr('disabled');
    $('#btnRev').attr('disabled', true);
    $('#descripcion').val('')
    $('#diventrada input').removeAttr('disabled');
    $('#diventrada textarea').removeAttr('disabled');
    $('#diventrada button').removeAttr('disabled');
    $('#ds_cliente').val('')


}

function formReset() {
    div = $('#ModalWineries');
    div.find('input.form-control').val('');
    div.find('textarea').val('');
    $('#btnSave').attr('data-id', '0');
    $('#diventrada').val('').selectpicker('refresh').attr('disabled', true);
}


function CallbackReversion(Parameter, Result) {
    json = JSON.parse(Parameter);
    if (!Result.Error) {
        datos = Result.Row;
        $('.pagonumber').html(datos.id);
        $('#id_nota').val(datos.idrev);
        $('#btnSave, #btnRev').attr('disabled', 'disabled');
        window.gridsaldos.bootgrid('reload');
        toastr.success('Nota de cartera Revertida.', 'Sintesis ERP');
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
        $('#btnSave').attr('data-id', data.id);
       
        (data.nomestado == 'REVERSION') ? $('#id_nota').val(data.id_reversion) : $('#id_nota').val(data.id);
        $('.pagonumber').html(data.id);
        $('#id_nota').val(data.id);
        $('#ds_cliente').val(data.tercero);
        $('#cd_tercero').val(data.id_tercero);
        $('#cd_tipodoc').val(data.id_tipodoc).selectpicker('refresh');
        $('#cd_tipoterce').val(data.id_tipotercero).selectpicker('refresh');
        $('#id_tipoven').val(data.id_tipoven).selectpicker('refresh');
        $('#codigoccostos').val(data.Centrocostos);
        $('#cd_factura').val(data.id_saldo);
        $('#ds_factura').val(data.nrofactura);

        $('#Text_cuenta').val(data.cuentanterior);
        $('#id_ctacon').val(data.id_ctaact);
        $('#ds_ctacon').val(data.cuentaactual);
        $('#pagoCredito').css('display', 'block');

        $('#m_saldo').val('$ ' + data.saldoactual.Money()); 
        $('#nrodias2').val(data.dia); 
        $('#nrocuotas2').val(data.nrocuotas); 
        
        (data.vencimientoact != null ? $('#ischange').prop('checked', true) && $('#Text_FechaVenIni2').val(data.vencimientoact) : $('#ischange').prop('checked', false) && $('#Text_FechaVenIni2').val(''));


        $('#descripcion').val(data.detalle);
        window.gridsaldos.bootgrid('reload');
        $('#btnPay,#m_valor,.btnsearch,#Text_Fecha,#cd_formapago,#btnSave').attr('disabled', 'disabled');
        $('#btnRev').removeAttr('disabled');
        $('.i-checks').iCheck('update');

        $('#ModalNotas').modal('hide');
        $('#diventrada input').attr('disabled', true);
        $('#diventrada button').attr('disabled', true);
        $('#diventrada textarea').attr('disabled',true)
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}

function EndCallbackupdate(params, answer) {
    if (!answer.Error) {
        window.gridsaldos.bootgrid('reload');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}

function EndCallbackGetSaldos(params, answer) {
    if (!answer.Error) {
        data = answer.Row;
        $('#Text_cuenta').val(data.cuenta);
        $('#Text_FechaVenIni2').val(data.vencimientocuota);
        $('#id_cuentaant').val(data.id_cuenta);
        $('#cuotanro').val(data.cuota);
        $('#nrocuotas2').val(data.cantcuotas);
        $('#m_saldo').val('$ '+data.saldoactual.Money());
        $('#m_interes').val('$ ' + data.totalinteres.Money());	  
        window.gridsaldos.bootgrid('reload');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}
function EndCallbackSave(params, answer) {
    if (!answer.Error) {
        data = answer.Row;
        $('#btnSave').button('reset');
        $('#id_nota').val(data.id_nota);
        $('#m_valor,.btnsearch,#Text_Fecha,#cd_formapago,#btnSave').attr('disabled', 'disabled');
        var div = $('.divpagos');
        div.find('select').selectpicker('refresh');
        $('.pagonumber').html(data.id_nota);
        $('#btnRev').removeAttr('disabled');
        window.gridsaldos.bootgrid('reload');
        toastr.success('Nota Realizada Correctamente.', 'Sintesis ERP');
        
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
        $('#btnSave').button('reset');
    }
    
    

}