var JsonValidate = [{ id: 'Text_Fecha', type: 'DATE', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];

var JsonCommodity = [{ id: 'v_presen', type: 'WHOLE', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
{ id: 'm_quantity', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];


var JsonPagosCre = [
    { id: 'tipo_cartera', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
    { id: 'nrocuotas2', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'Text_FechaVenIni2', type: 'DATE', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'id_tipoven', type: 'TEXT', htmltype: 'SELECT', required: false, depends: false, iddepends: '' },
    { id: 'valorFianza', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];

var JsonCabecera = [
    { id: 'cd_tipodoc', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
    { id: 'codigoccostos', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'id_cliente', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'fact', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'id_ctamorads', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];



window.tblpagoscre = null;
window.tblcommodity = null;

window.gridfacturas;
window.gridbod = undefined;



function LoadCuota() {
    if (window.gridbod === undefined) {
        window.gridbod = $("#tblcommodity").bootgrid({
            ajax: true,
            post: function () {
                return {
                    'params': function () {
                        var param = {};
                        param.id = $('#id_refinan').val();
                        return JSON.stringify(param);
                    },
                    'class': 'Refinanciacion',
                    'method': 'RefinanciacionCuotasList'
                };
            },
            url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
            formatters: {
                "id": function (column, row) {
                    return row.id;
                },

                "numfactura": function (column, row) {
                    return row.numfactura;
                },

                "cuota": function (column, row) {
                    return row.cuota;
                },

                "valorCuota": function (column, row) {
                    return '$ ' + row.valorcuota.Money();
                },

                "saldo": function (column, row) {
                    return '$ ' + row.saldo.Money();
                },
                "interes": function (column, row) {
                    return '$ ' + row.interes.Money();
                },

                "capital": function (column, row) {
                    return '$ ' + row.acapital.Money();
                },

                "vencimiento": function (column, row) {
                    return row.vencimiento;
                }
            }
        });
    }
    else
        window.gridbod.bootgrid('reload');
}

$(document).ready(function () {
    newDevFactura();

    window.tblpagoscre = $("#tblpagoscre").bootgrid({
        rowCount: -1,
        columnSelection: false,
        identifier: null,
        searchSettings: false,
        formatters: {
            "valor": function (column, row) {
                return '$ ' + row.cuota.Money(0);
            },
            "saldo": function (column, row) {
                return '$ ' + row.saldo.Money(0);
            }
        }
    });

    $('#btnList').click(function () {
        if (window.gridfacturas === undefined) {
            window.gridfacturas = $("#tblfacturas").bootgrid({
                ajax: true,
                post: function () {
                    return {
                        'params': "",
                        'class': 'Refinanciacion',
                        'method': 'RefinanciacionListFinan'
                    };
                },
                url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
                formatters: {
                    "edit": function (column, row) {
                        if (row.estado == 'REVERTIDO' || row.estado == 'PROCESADO') {
                            return "<a class=\"action command-edit\" data-row-id=\"" + row.Consecutivo + "\" ><span class=\"fa-2x fa fa-eye iconfa\"></span></a>";
                        }
                    },
                    "total": function (column, row) {
                        return '$ ' + row.valor.Money();
                    },
                    "Consecutivo": function (column, row) {
                        return row.Consecutivo;
                    },
                    "fecha": function (column, row) {
                        return row.fecha;
                    },
                    "numfactura": function (column, row) {
                        return row.numfactura;
                    },
                    "estado": function (column, row) {
                        return row.estado;
                    }
                }
            }).on("loaded.rs.jquery.bootgrid", function () {
                // Executes after data is loaded and rendered 
                window.gridfacturas.find(".command-edit").on("click", function (e) {
                    id = $(this).data("row-id");
                    params = {};
                    params.id = id;
                    params.op = 'Y';
                    MethodService("Refinanciacion", "Refinanciacionget", JSON.stringify(params), 'EndCallbackGet');
                })
            });
        }
        else
            window.gridfacturas.bootgrid('reload');

        $('#ModalFacturas').modal({ backdrop: 'static', keyboard: false }, "show");
    });


    $('#btnPrint').click(function () {
        var idfactura = $('#id_devfactura').val()
        param = 'id|' + idfactura + ';'
        PrintDocument(param, 'REFINANAMORTIZACION', 'CODE');
    });

    $('#btnnew').click(function () {
        newDevFactura();

    });

    $('#actCuotas').click(function () {
        var opt = $(this).attr('data-option');
        addCuota(opt)
    });


    $('#DetalleCuota').click(function () {
        $('#ContenedorCuota').toggle();

    });

    $('#btnRev').click(function () {
        if ($('#id_refinan').val() != '0' && $('#id_refinan').val().trim() != '') {
            if (confirm("Desea revertir la refinanciacion?")) {
                var sJon = {};
                sJon.id = ($('#id_refinan').val().trim() == "") ? "0" : $('#id_refinan').val();
                MethodService("Refinanciacion", "RevertirRefinanciacion", JSON.stringify(sJon), "CallbackReversion");
            }
        }
    });

    $('#btnSave').click(function () {

        valorcuota = parseFloat(SetNumber($("#valorCuotacre").val()));
        valorfianza = parseFloat(SetNumber($("#valorFianza").val()));


        if (validate(JsonCabecera)) {
            if (window.tblpagoscre.bootgrid("getTotalRowCount") > 0) {

                if (valorfianza > valorcuota) {
                    sJon = {};
                    sJon.cd_tipodoc = $('#cd_tipodoc').val();
                    sJon.id_ccostos = $('#id_ccostos').val();
                    sJon.fecha = SetDate($('#Text_Fecha').val());
                    sJon.cd_cliente = $("#cd_cliente").val();
                    sJon.cd_factu = $("#cd_factu").val();
                    sJon.vrlfianza = ($('#valorFianza').val().trim() == "") ? "0" : parseFloat(SetNumber($("#valorFianza").val()));
                    sJon.id_ctamora = $('#id_ctamora').val();
                    datac = $("#tblpagoscre");
                    var opc = $("#ValorPago").val();
                    sJon.cuotas = datac.attr('data-cuotas');
                    sJon.inicial = datac.attr('data-inicial');
                    sJon.id_formacred = $('#tipo_cartera').val(); 
                    var credito = SetNumber($('#cd_factu').attr('data-credito'));
                    sJon.totalcredito = credito;

                    if (confirm("Desea realizar la refinanciacion?")) {
                        MethodService("Refinanciacion", "RefinanciacionFactura", JSON.stringify(sJon), "CallbackComodity");
                    }

                } else {
                    toastr.warning("El valor cuota Fianza no puede ser menor que la cuota financiada.", 'Sintesis ERP');
                 
                }
            }
        }
        else
            toastr.warning("No ha agregado ninguna refinanciacion.", 'Sintesis ERP');
    });

    $('#cd_cliente').change(function () {
        var valor = $(this).val()
        $('#fact').val('').attr('data-params', "op:U;o:N;id_prod:"+valor+';tipo:' + $('#Text_Fecha').val()).removeData('params').data('params');
        $('#fact').attr('disabled', false);
        $('#fact').focus();
        $('#TFactura').text('$ ' + (0).Money());
        $('#nrocuotas2').val(0);
    });

    $('#cd_factu').change(function () {
        var idfact = $(this).val();
        if (idfact == '0' || idfact == '') {
            $('#TFactura').text('$ ' + (0).Money());
            $('#nrocuotas2').val(0);
        }
    });

});

function SelecFactura(select) {
    $('#TFactura').text('$ ' + select.saldoactual.Money());
    $('#TMora').text('$ ' + select.interesmora.Money());
    $('#Tcredito').text('$ ' + (select.interesmora + select.saldoactual).Money());
    $('#cd_factu').attr({ 'data-valor': (select.interesmora + select.saldoactual), "data-credito": select.saldoactual});
    $('#nrocuotas2').val(select.cuotas);
}

function newDevFactura() {
    $('#TableCuotas').hide();
    $('#ContenedorCuota').show();
    $('#generarcuotas').show();
    $('#actCuotas').attr('disabled', false);

    $('input.form-control').val('');
    $('[money]').val('0.00');

    fieldsMoney();
    datepicker();
    $('.entradanumber').html('0');
    $("#tbdcuotas").empty()
    $('#cd_tipodoc').val(0).selectpicker('refresh');
    $('#tipo_cartera').val(0).selectpicker('refresh');
    $('#btnSave').removeAttr('disabled');
    $('#btnRev, #btnPrint').attr('disabled', 'disbled');
    $('#id_devolucion').val('0');
    $('#opTipoFactura').val('T');
    $('#divpago').hide();
    Data = {
        Tiva: 0, Tprecio: 0, Tdctoart: 0, Ttotal: 0, Tdesc: 0, Tinc: 0
    };
    var div = $('#divfact, #generarcuotas');
    div.find('[money], select.selectpicker, .btnsearch, input.form-control').removeAttr('disabled');
    div.find('select').selectpicker('refresh');
    $('#esFE').prop('checked', false).iCheck('update');
    TotalizarFactura(Data);
    $('#Tcredito').text('$ 0.00');
    $('#TMora').text('$ 0.00');
    $('#VCuota').text('$ 0.00');
    $('#valorCuotacre').attr('disabled', 'disbled');
    $('#fact').attr('disabled', 'disbled');
}



function EndCallbackGet(Parameter, Result) {
    if (!Result.Error) {
        var row = Result.Row;
        idcuota = $('#id_refinan').val(row.id);

         
        LoadCuota(idcuota);

        if (row.estados == 'PROCESADO') {
            $('#btnPrint, #btnRev ').removeAttr('disabled')
            $('#btnSave').attr('disabled', 'disabled');

        }
        else {
            $('#btnSave').attr('disabled', 'disabled');
        }
        $('#cd_tipodoc').val(row.id_tipodoc);
        $('#Text_Fecha').removeAttr('disabled');
        $('#cd_tipodoc').val(row.id_tipodoc).selectpicker('refresh');
        $('#codigoccostos').val(row.centrocosto);
        $('#Text_Fecha').val(row.fecha);
        $('#id_cliente').val(row.id_cliente);
        $('#fact').val(row.numfactura);
        $('#tipo_cartera').val(row.formapago);
        $('#tipo_cartera').val(row.formapago).selectpicker('refresh');
        $('#nrocuotas2').val(row.cuotas);
        $('#valorCuotacre').val(row.valorcuota.Money());
        $('#valorFianza').val(row.fianza.Money());
        $('#Text_FechaVenIni2').val(row.fecha_inicial);

        $('#id_ctamorads').val(row.CuentaMora);
        $('#id_ctamora').val(row.id_cuenta);


        $('#actCuotas').attr('disabled', 'disabled');
        $('#valorCuotacre').attr('disabled', 'disabled');
        var div = $('#divfact, #generarcuotas');
        div.find('[money],  select.selectpicker, input.form-control').attr('disabled', true);
        div.find('select').selectpicker('refresh');

        $('#TableCuotas').show();
        $('#ContenedorCuota').hide();
        $('#generarcuotas').show();
        $('#Tcredito').text('$' + row.total.Money());
        $('#VCuota').text('$' + row.valorcuota.Money());
        $('#TFactura').text('$' + row.totalcredito.Money());
        $('#TMora').text('$' + row.interesmora.Money());
        $('.entradanumber').text(row.id);
        $('#id_devfactura').val(row.id_fact)

        if (row.estados == 'REVERTIDO') {
            $('#btnPrint').attr('disabled', 'disabled');
        }

        window.setTimeout(function () {
            $('#ModalFacturas').modal('hide');
        }, 4);
    }
    else {
        toastr.error(Result.Message, 'Sintesis ERP');
    }
}

function addCuota() {

    if (validate(JsonPagosCre)) {
        var json = {};
        json.op = 'F';
        json.SelectCredito = ($('#tipo_cartera').val().trim() == "") ? "0" : $('#tipo_cartera').val();
        json.dias = 0;
        json.ven = 0;
        json.cuotas = SetNumber($('#nrocuotas2').val());
        json.inicial = SetDate($('#Text_FechaVenIni2').val());
        json.idToken = $('#idToken').val();
        json.valor = $('#cd_factu').attr('data-valor');
        $("#tblpagoscre").attr({ 'data-cuotas': json.cuotas, 'data-inicial': json.inicial, 'data-tipoven': json.ven, 'data-dias': json.dias });
        MethodService("Refinanciacion", "FacturasRecalCuotas", JSON.stringify(json), "EndCallbackGetCuotas");
    }
}

function TotalizarFactura(Data) {
    $('#Tiva').text('$ ' + Data.Tiva.Money());
    $('#Tinc').text('$ ' + Data.Tinc.Money());
    $('#Ttventa').text('$ ' + Data.Tprecio.Money());
    $('#TdescArt').text('$ ' + Data.Tdctoart.Money());
    $('#TFactura').text('$ ' + Data.Ttotal.Money());
}

function CallbackComodity(Parameter, Result) {
    json = JSON.parse(Parameter);
    if (!Result.Error) {
        datos = Result.Row;
        toastr.success('Factura Realizada.', 'Sintesis ERP');
        $('#id_refinan').val(datos.id)
        $('#id_devfactura').val(datos.id_factura)
        $('#valorCuotacre').attr('disabled', 'disabled');

        $('.entradanumber').html(datos.id);
        $('#opTipoFactura').val('D');
        $('#id_devfactura').val(datos.id_factura);
        $('#btnSave').attr('disabled', 'disabled');
        $('#btnRev, #btnPrint').removeAttr('disabled');
        $("#ModalFormas").modal('hide');
        var div = $('.diventrada');
        div.find('[money], .addarticle, select.selectpicker, .btnsearch, input.form-control').attr('disabled', true);
        div.find('select').selectpicker('refresh');
    }
    else
        toastr.error(Result.Message, 'Sintesis ERP');
}


function CallbackReversion(Parameter, Result) {
    json = JSON.parse(Parameter);
    if (!Result.Error) {
        datos = Result.Row;
        $('.pagonumber').html(datos.id_factura);
        $('#id_devfactura').val(datos.id_factura);
        $('#btnSave, #btnRev, #btnPrint').attr('disabled', 'disabled');
        window.gridbod.bootgrid('reload');
        toastr.success('Documento Revertido.', 'Sintesis ERP');
    }
    else
        toastr.error(Result.Message, 'Sintesis ERP');
}



function EndCallbackGetCuotas(Parameter, Result) {
    if (!Result.Error) {
        var par = JSON.parse(Parameter);
        $('#valorCuotacre').val('');
        $('#valorCuotacre').val(Result.Table[0].cuota.Money());
        $('#VCuota').text('$' + Result.Table[0].cuota.Money());
        var drDestroy = window.tblpagoscre.data('.rs.jquery.bootgrid');
        drDestroy.clear();
        drDestroy.append(Result.Table);
        $('#Tcambio').text('$ 0.00').removeClass('text-danger');
     }
    else {
        toastr.error(Result.Message, 'Sintesis ERP');
    }
}