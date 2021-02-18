var JsonValidate = [{ id: 'cd_tipodoc', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
{ id: 'codigoccostos', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
{ id: 'ds_cliente', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];
var JsonValidateConcepto = [{ id: 'ds_concepto', type: 'INPUT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
{ id: 'm_valor', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];
var JsonValidateConceptoDscto = [{ id: 'ds_conceptoDscto', type: 'INPUT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
{ id: 'm_valorCliente', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];
var JsonPagos = [
    { id: 'cd_formapago', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'voucher', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' }];

window.gridbod;
window.gridrecibos;

function Loadtable() {
    //Grilla de tabla donde se relaciona las facturas y cuotas por pagar de los clientes.
    window.gridbod = $("#tblcommodity").bootgrid({
        ajax: true,
        post: function () {
            return {
                'params': function () {
                    var param = {};
                    param.id_cliente = ($('#cd_cliente').val() == '') ? 0 : $('#cd_cliente').val();
                    param.id_recibo = $('#id_recibo').val();
                    param.fecha = SetDate(($('#Text_Fecha').val()));
                    return JSON.stringify(param);
                },
                'class': 'RecaudoCartera',
                'method': 'CuotaCLienteList'
            };
        },
        url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
        formatters: {

            "view": function (column, row) {
                return "<a class=\"action command-view\" data-row-id=\"" + row.id + "\"   data-row-factura=\"" + row.factura + "\"><span class=\" fa-2x fa fa-eye iconfa \"></span></a>";
            },
            "state": function (column, row) {
                return "<a class=\"action command-state\" data-row-creditointeres=\"" + row.creditointeres + "\" data-row-valorIva=\"" + row.valorIva + "\"  data-row-Capital=\"" + row.Capital + "\"  data-row-DiasAnticipado=\"" + row.DiasAnticipado + "\"  data-row-total=\"" + row.total + "\"  data-row-porcentaje=\"" + row.porcentaje + "\" data-row-id=\"" + row.id + "\" data-row-factura=\"" + row.factura + "\"   data-row-vlr=\"" + row.valorcuota + "\" data-row-saldoc=\"" + row.saldocuota + "\"   data-row-dias=\"" + row.diasvencido + "\"  >" +
                    "<span id='state" + row.id + "' class=\"fa fa-2x fa-fw fa-square-o text-danger  iconfa\"></span></a>";
            },

            "interes": function (column, row) {
                if (row.fechavencimiento.length != 0)
                    return "<span id='interes" + row.id + "' class='tdedit action command-edit' data-type='numeric' data-column='interes' data-min='0' data-max='999999999999999999' data-simbol='' data-value='10' data-id='" + row.id + "' data-row-vlr='" + row.saldocuota + "' data-row-dias='" + row.diasvencido + "'>" + row.pormora.Money() + "</span>";
                else
                    return "<span id='interes" + row.id + "' class='tdedit action command-edit' data-type='numeric' data-column='interes' data-min='0' data-max='999999999999999999' data-simbol='' data-value='0' data-id='" + row.id + "' data-row-vlr='" + row.saldocuota + "' data-row-dias='" + row.diasvencido + "'>0.00 </span>";
            },

            "pay": function (column, row) {
                return "<span id='pay" + row.id + "' class='tdedit action command-edit' data-type='numeric' data-column='pay' data-min='0' data-max='999999999999999999' data-simbol='$' data-value='" + row.saldocuota + "' data-id='" + row.id + "'>$ 0.00</span>";
            },
            "total": function (column, row) {
                return '$ ' + row.total.Money();
            },

            "valorcuota": function (column, row) {
                return '$ ' + row.valorcuota.Money();
            },
            "saldocuota": function (column, row) {
                return '$ ' + row.saldocuota.Money();
            },

            "porcentaje": function (column, row) {

                return ' ' + row.porcentaje.Money();
            },
            "capital": function (column, row) {

                return "<input type='checkbox' class='form-control' id='capital_" + row.factura + "' disabled='disabled' />";
            },


            "interescre": function (column, row) {
                if (row.creditointeres != null)
                    return "<span id='interescre" + row.id + "' class='tdedit action command-edit' data-type='numeric' data-column='interescre' data-min='0' data-max='999999999999999999' data-simbol='$' data-value='" + row.creditointeres + "' data-id='" + row.id + "'>" + row.creditointeres.Money() + "</span>";
                else
                    return "<span id='interescre" + row.id + "' class='tdedit action command-edit' data-type='numeric' data-column='interescre' data-min='0' data-max='999999999999999999' data-simbol='$' data-value='0' data-id='" + row.id + "'>$ 0.00 </span>";
            },

            "Iva": function (column, row) {
                if (row.valorIva != null)
                    return "<span id='Iva" + row.id + "' class='tdedit action command-edit' data-type='numeric' data-column='Iva' data-min='0' data-max='999999999999999999' data-simbol='$' data-value='" + row.valorIva + "' data-id='" + row.id + "'>" + row.valorIva.Money() + "</span>";
                else
                    return "<span id='Iva" + row.id + "' class='tdedit action command-edit' data-type='numeric' data-column='Iva' data-min='0' data-max='999999999999999999' data-simbol='$' data-value='0' data-id='" + row.id + "'>$ 0.00 </span>";
            },

            "Tinteres": function (column, row) {
                return "<span id='Tinteres" + row.id + "' class='tdedit action command-edit' data-type='numeric' data-column='Tinteres' data-min='0' data-max='999999999999999999' data-simbol='$' data-value='" + row.valorcuota + "' data-id='" + row.id + "'>$ 0.00 </span>";
            },

            "Tinteresabono": function (column, row) {
                if (row.interesabono != null)
                    return "<span id='Tinteresabono" + row.id + "' class='tdedit action command-edit' data-type='numeric' data-column='Tinteresabono' data-min='0' data-max='999999999999999999' data-simbol='$' data-value='" + row.interesabono + "' data-id='" + row.id + "'>" + row.interesabono.Money() + "</span>";
                else
                    return "<span id='Tinteresabono" + row.id + "' class='tdedit action command-edit' data-type='numeric' data-column='Tinteresabono' data-min='0' data-max='999999999999999999' data-simbol='$' data-value='0' data-id='" + row.id + "'>$ 0.00 </span>";
            },
            "saldointeres": function (column, row) {
                return "<span id='saldointeres" + row.id + "' class='tdedit action command-edit' data-type='numeric' data-column='saldointeres' data-min='0' data-max='999999999999999999' data-simbol='$' data-value='" + row.valorcuota + "' data-id='" + row.id + "'>$ 0.00 </span>";
            }
        }


    }).on("loaded.rs.jquery.bootgrid", function () {
        // Executes after data is loaded and rendered 
        window.gridbod.find(".command-state").on("click", function (e) {
            data = $(this).data();

            dias = $(this).data("row-dias");
            capital = $(this).data("row-Capital"); /// Capital de la cuota
            //InterCred = $(this).data("row-creditointeres");/// ineteres diarios
            saldocuota = $(this).data("row-saldoc");// Se escoje el valor del saldo de la cuota que esta pendiente
            valrcuota = $(this).data("row-vlr");// Se escoje el valor del saldo de la cuota que esta pendiente
            //ValorIva = $(this).data("row-valoriva");


            porceinteres = parseFloat(SetNumber($('#interes' + data.rowId).html())) / 30 //Capturamos el valor por defecto del interfes parametizado
            interes = (capital * porceinteres * dias / 100);// calculamos el valos a pagar en interes teniendo en cuenta la cantidad de dias vencidos
            interesabonado = parseFloat($('#Tinteresabono' + data.rowId).data().value)


            //INTERES MORA
            $('#Tinteres' + data.rowId).html('$ ' + (interes - interesabonado).Money());
            $('#saldointeres' + data.rowId).html('$ ' + (interes - interesabonado).Money());
            //totalInteres = SetNumber($('#saldointeres' + data.rowId).html());



            if (dias <= 0) {
                if (saldocuota != valrcuota) {
                    totalapagar = saldocuota;
                    total = parseFloat(SetNumber($('#mtotal_cliente').text()))
                } else {
                    totalapagar = saldocuota + (interes - interesabonado);
                    total = parseFloat(SetNumber($('#mtotal_cliente').text()))
                }
            } else {
                totalapagar = (saldocuota + (interes - interesabonado));
                total = parseFloat(SetNumber($('#mtotal_cliente').text()))
            }

            $('#pay' + data.rowId).attr('data-value', totalapagar)
            state = $(this).children();
            if (state.attr('class') == 'fa fa-2x fa-fw fa-square-o text-danger  iconfa') {
                $('#capital_' + $(this).attr('data-row-factura')).prop('checked', false).removeAttr('disabled');
                state.attr('class', 'fa fa-2x fa-fw fa-check-square-o text-success  iconfa');
                $('#pay' + data.rowId).html('$ ' + totalapagar.Money());
                total = total + totalapagar;
            } else {
                $('#capital_' + $(this).attr('data-row-factura')).prop('checked', false).attr('disabled', true);
                total = total - SetNumber($('#pay' + data.rowId).html());
                state.attr('class', 'fa fa-2x fa-fw fa-square-o text-danger  iconfa');
                $('#pay' + data.rowId).html('$0.00 ');
            }
            $('#mtotal_cliente').text('$ ' + total.Money());
            $('#mtotal').text('$ ' + (parseFloat(SetNumber($('#mtotal_concepto').text())) + total).Money());
        }).end().find(".command-view").on("click", function (e) {
            id = $(this).data("row-id");
            factura = $(this).data("row-factura");
            porceinteres = parseFloat(SetNumber($('#interes' + id).html()));
            $('#idfactura,#numFactura').val(id);
            $('#numFactura').text(factura);
            $('#porceinteres').val(porceinteres);
            $('#mtotalclienteTemp').val(parseFloat(SetNumber($('#mtotal_cliente').text())) - parseFloat(SetNumber($('#pay' + id).html())));
            $('#vlrpagar').val(0);
            window.gridcuotasxfact.bootgrid('reload');
            $('#tblcuotasxfact thead  th:first-of-type').find('a').remove();
            $('#tblcuotasxfact thead  th:first-of-type').find('span').remove();
            $('#tblcuotasxfact thead  th a').removeClass('sortable')
            $('#tblcuotasxfact-footer').remove();
            $('#tblcuotasxfact thead  th:first-of-type').append('<span id="marcarAll" class= "fa fa-2x fa-fw fa-square-o text-danger  iconfa" style="margin-top:3px; color:white"></span>')
            $('#tblcuotasxfact thead  th:first-of-type').find('span').on('click', () => {
                total = parseFloat(SetNumber($('#vlrpagar').val()));
                if ($('#tblcuotasxfact thead  th:first-of-type').find('span').attr('class') == 'fa fa-2x fa-fw fa-square-o text-danger  iconfa') {
                    window.gridcuotasxfact.find('.command-state').children().attr('class', 'fa fa-2x fa-fw fa-check-square-o text-success  iconfa');
                    $.each(window.gridcuotasxfact.find('.command-state'), function (i, e) {
                        data = $(e).data();
                        total = total + data.rowVlr;
                    });
                    ($('#tblcuotasxfact thead  th:first-of-type').find('span').attr('class', 'fa fa-2x fa-fw fa-check-square-o text-success  iconfa'));
                } else {
                    window.gridcuotasxfact.find('.command-state').children().attr('class', 'fa fa-2x fa-fw fa-square-o text-danger  iconfa');
                    $.each(window.gridcuotasxfact.find('.command-state'), function (i, e) {
                        data = $(e).data();
                        total = total - data.rowVlr;
                    });
                    $('#tblcuotasxfact thead  th:first-of-type').find('span').attr('class', 'fa fa-2x fa-fw fa-square-o text-danger  iconfa');
                }
                $('#vlrpagar').val(total);
            });
            $('#Modalcuotas').modal({ backdrop: 'static', keyboard: false }, 'show');

        }).end().find(".command-edit").on("dblclick", function (e) {
            params = {};
            data = $(this).data();
            tr = $(this).closest('td');
            column = $(this).data().column;
            selector = $(this);
            state = ($('#state' + data.id).attr('class'));
            if ((column == 'interes' || column == 'pay') && state == 'fa fa-2x fa-fw fa-check-square-o text-success  iconfa') {
                $(this).hide();
                max = 9999999999.99;
                min = 0;
                input = $('<input class="form-control rowedit" date-type="numeric" data-oldvalue="' + data.value + '" data-column="' + data.column + '" data-id="' + data.id + '" value="' + SetNumber(selector.html()) + '" money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="' + min + '" data-v-max="' + max + '">');
                input.autoNumeric('init');

                input.blur(function () {
                    var row = $(this).data();
                    newvalue = $(this).val();

                    if (column == 'pay') {
                        total = parseFloat(SetNumber($('#mtotal_cliente').text()));
                        total = total - parseFloat(SetNumber(selector.html()));
                        total = total + parseFloat(SetNumber(newvalue));
                        $('#mtotal_cliente').text('$ ' + total.Money());
                        $('#mtotal').text('$ ' + (parseFloat(SetNumber($('#mtotal_concepto').text())) + total).Money());
                        $('#pay' + row.id).attr('data-value', newvalue);
                        ($(this).remove());
                        $('#pay' + row.id).html('$ ' + newvalue);
                        $('#pay' + row.id).show();
                    }
                    if (column == 'interes') {
                        dataInteres = $('#interes' + row.id).data();
                        interes = Math.round(dataInteres.rowVlr * (((parseFloat(newvalue) / 30 * dataInteres.rowDias) / 100)));
                        interesabonado = parseFloat($('#Tinteresabono' + dataInteres.id).data().value)
                        $('#Tinteres' + dataInteres.id).html('$ ' + interes.Money());
                        $('#saldointeres' + dataInteres.id).html('$ ' + (interes - interesabonado).Money());
                        $('#pay' + row.id).html('$ ' + (dataInteres.rowVlr + (interes - interesabonado)).Money());
                        ($(this).remove());
                        $('#interes' + row.id).html('% ' + newvalue);
                        $('#interes' + row.id).show();
                    }
                });
                tr.find('.tdedit').hide();
                tr.append(input);
                input.focus().select();
            }

        });
        $("#tblPagoPro [money]").autoNumeric('init');
    });
    //Grilla donde se relaciona las cuotas pagadas en el recibo de caja seleccionado
    window.gridrecibos = $("#tblrecibos").bootgrid({
        ajax: true,
        post: function () {
            return {
                'params': function () {
                    var param = {};
                    param.id_cliente = $('#cd_cliente').val();
                    param.id_recibo = $('#id_recibo').val();
                    param.fecha = SetDate(($('#Text_Fecha').val()));
                    return JSON.stringify(param);
                },
                'class': 'RecaudoCartera',
                'method': 'CuotaCLienteList'
            };
        },
        url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
        formatters: {
            "factura": function (column, row) {
                return row.factura;
            },

            "valorCuota": function (column, row) {
                return '$ ' + row.valorCuota.Money();
            },

            "pagoCuota": function (column, row) {
                return '$ ' + row.pagoCuota.Money();
            },

            "pagoInteres": function (column, row) {
                return '$ ' + row.InteresMora.Money();
            },
            "totalpagado": function (column, row) {
                return '$ ' + row.totalpagado.Money();
            },

            "porceInteres": function (column, row) {
                return '% ' + row.porceInMora.Money();
            },

            "valorIva": function (column, row) {
                return '$ ' + row.valorIva.Money();
            },

            "Interes_credito": function (column, row) {
                return '$ ' + row.interesCorriente.Money();
            },
            "porceInterescre": function (column, row) {
                return '% ' + row.porcenInCorriente.Money();
            }
        }
    })
}
window.gridpagosreal;

$(document).ready(function () {
    //Evento donde se lista los recibos de cajas realizados
    $('#btnList').click(function () {
        if (window.gridpagosreal === undefined) {
            window.gridpagosreal = $("#tblpagos").bootgrid({
                ajax: true,
                post: function () {
                    return {
                        'params': "",
                        'class': 'RecaudoCartera',
                        'method': 'recaudocarteraList'
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
                    "valorcli": function (column, row) {
                        return '$ ' + row.valorcliente.Money();
                    },
                    "valor": function (column, row) {
                        return '$ ' + row.valorconcepto.Money();
                    },
                    "rever": function (column, row) {
                        if (row.estado == 'PROCESADO') {
                            $('.rever').hide();
                            return "<a class=\"action command-rever\" data-row-id=\"" + row.id + "\"><span class=\"fa fa-2x fa-fw fa-exclamation-triangle text-warning  iconfa\" /></a>";
                        }

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
                            MethodService("RecaudoCartera", "RevertirRecaudoCartera", JSON.stringify(sJon), "CallbackReversionList")
                        }
                    }
                }).end().find(".command-ver").on("click", function (e) {
                    $('#ModalLoad').modal({ backdrop: 'static', keyboard: false }, "show");
                    id = $(this).data("row-id")
                    var idrecibo = id
                    param = 'id|' + idrecibo + ';'
                    PrintDocument(param, 'MOVRECAUDOC', 'CODE');

                }).end().find(".command-edit").on('click', function (e) {
                    id = $(this).data("row-id");
                    params = {};
                    params.id = id;
                    MethodService("RecaudoCartera", "recaudocarteraGet", JSON.stringify(params), 'EndCallbackGet');

                })
            });
        }
        else
            window.gridpagosreal.bootgrid('reload');

        $('#Modalpagos').modal({ backdrop: 'static', keyboard: false }, "show");
    });

    $('#liuno').css('display', 'inline-block');
    $('#tab-2').removeClass('active');
    $('#tab-1').addClass('active');
    $('#tabuno').parent().addClass('active');
    $('#tabdos').parent().removeClass('active');

    Loadtable();
    cargarTablaCuotas();
    newpay();
});

window.gridcuotasxfact;
//Funcion donde se carga las cuotas por numero de factura en un modal diferente
function cargarTablaCuotas() {
    window.gridcuotasxfact = $("#tblcuotasxfact").bootgrid({
        ajax: true,
        post: function () {
            return {
                'params': function () {
                    var param = {};
                    param.id_factura = $('#numFactura').val();
                    param.porceinteres = $('#porceinteres').val();
                    param.fecha = SetDate($('#Text_Fecha').val());
                    param.id_tercero = $('#cd_cliente').val();
                    return JSON.stringify(param);
                },
                'class': 'RecaudoCartera',
                'method': 'MOvFacturaList'
            };
        },
        url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
        formatters: {
            "state": function (column, row) {
                if (row.saldo > 0)
                    return "<a class=\"action command-state\"  data-row-cuota=\"" + row.cuota + "\" data-row-intmora=\"" + row.interes + "\"  data-row-id=\"" + row.id + "\"   data-row-vlr=\"" + row.vlrcuota + "\" data-row-saldoc=\"" + (row.saldo + (row.interes)) + "\" data-row-diasdevenci=\"" + row.diasdevenci + "\" data-row-acapital=\"" + row.acapital + "\" data-row-interescredito=\"" + row.interescredito + "\" >" +
                        "<span id='statecuotas" + row.cuota + "' class=\"fa fa-2x fa-fw fa-square-o text-danger  iconfa\"></span></a>";
            },
            "vlrcuota": function (column, row) {
                return '$ ' + row.vlrcuota.Money();
            },
            "abono": function (column, row) {
                return '$ ' + row.abono.Money();
            },
            "saldo": function (column, row) {
                return '$ ' + row.saldo.Money();
            },

            "interes": function (column, row) {
                return '$ ' + row.interes.Money();
            },

            "IntCausado": function (column, row) {
                return '$ ' + row.InteresCausado.Money();
            },

            "Causacion": function (column, row) {
                if (row.causada == 0)
                    return "<a class=\"action command-CausarFactura\"  data-row-cuota=\"" + row.cuota + "\" data-row-id_cliente=\"" + row.id_cliente + "\" data-row-venci=\"" + row.vencimiento_cuota + "\"  data-row-id=\"" + row.id + "\"   data-row-factura=\"" + row.factura + "\"><span class=\"fa fa-2x fa-check-circle fa-fw \"></span></a>";
                else
                    return "";
            }
        }
    }).on("loaded.rs.jquery.bootgrid", function () {
        // Executes after data is loaded and rendered 

        window.gridcuotasxfact.find(".command-state").on("click", function (e) {

            data = $(this).data();
            state = $(this).children();
            saldo = $(this).data("row-saldoc");
            total = parseFloat(SetNumber($('#vlrpagar').val()));///Total cuando ya esta vencido la cuota normal mas interes mora          

            if ($('#statecuotas' + (data.rowCuota - 1)).attr('class') == 'fa fa-2x fa-fw fa-check-square-o text-success  iconfa' || $('#statecuotas' + (data.rowCuota - 1)).attr('class') == undefined)
                if (state.attr('class') == 'fa fa-2x fa-fw fa-square-o text-danger  iconfa') {
                    state.attr('class', 'fa fa-2x fa-fw fa-check-square-o text-success  iconfa');

                    total = total + saldo;

                    if ($('#statecuotas' + (data.rowCuota + 1)).attr('class') == undefined) {
                        $('#marcarAll').attr('class', 'fa fa-2x fa-fw fa-check-square-o text-success  iconfa');
                    }
                } else {
                    if ($('#statecuotas' + (data.rowCuota + 1)).attr('class') == 'fa fa-2x fa-fw fa-square-o text-danger  iconfa' || $('#statecuotas' + (data.rowCuota + 1)).attr('class') == undefined) {
                        state.attr('class', 'fa fa-2x fa-fw fa-square-o text-danger  iconfa');

                        total = total - saldo;

                        $('#marcarAll').attr('class', 'fa fa-2x fa-fw fa-square-o text-danger  iconfa');
                    }
                }
            $('#vlrpagar').val(total);
        }).end().find(".command-CausarFactura").on('click', function (e) {
            cuota = $(this).data("row-cuota");
            numfactura = $(this).data("row-factura");
            id_cliente = $(this).data("row-id_cliente");
            venci = SetDate($('#Text_Fecha').val());

            params = {};
            params.cuota = cuota;
            params.numfactura = numfactura;
            params.id_cliente = id_cliente;
            params.venci = venci;

            MethodService("RecaudoCartera", "CausarFacturaRecaudoCartera", JSON.stringify(params), 'EndCallbackCausacion');

        });
    });
}

//Evento que lista las facturas que debe el cliente seleccionado
$('#cd_cliente').change(function () {
    ChangeReloadCuota();
});

$('#Text_Fecha').on('dp.change', function (e) {
    var newtime = e.date.format(e.date._f);
    var oldtime = (e.oldDate != null) ? e.oldDate._i : newtime
    if (newtime != oldtime)
        ChangeReloadCuota();
});

function ChangeReloadCuota() {
    $('#m_valor,#m_valorCliente').val('$ 0.00');
    $('#id_concepto,#id_conceptoDscto').val(0);
    $('#ds_concepto,#ds_conceptoDscto').val('');
    $('#id_recibo').val(0);
    $('#mtotal_cliente').text('$ 0.00');
    $('#mtotal').text('$ 0.00');
    window.gridbod.bootgrid('reload');
}
//Evento que activa el tab de conceptos y habilita el campo valor
$('#id_concepto').change(function () {
    $('#tab-1').removeClass('active');
    $('#tab-2').addClass('active');
    ($('#tabdos').parent().addClass('active'));
    ($('#tabuno').parent().removeClass('active'));
    $('#m_valor').removeAttr('disabled');
    $('#m_valor').focus();
    cleanTableConcepto();
});
$('#id_conceptoDscto').change(function () {
    window.gridbod.bootgrid("getTotalRowCount") > 0 ? $('#m_valorCliente').removeAttr('disabled') : $('#m_valorCliente').attr('disabled', true);
});


$('#cd_tipodoc').change(function () {
    if ($("#id_recibo").val() == '0') {
        var valores = $(this).find('option:selected').attr('data-centro');
        var split = valores.split('|~|');
        $('#id_ccostos').val(split[1]);
        $('#codigoccostos').val(split[2]);
    }
    JsonValidate[1].required = (split[0] == '1') ? true : false;
});
$('#cd_formapago').change(function () {
    if ($("#id_recibo").val() == '0') {
        var valores = $(this).find('option:selected').attr('data-voucher');
        JsonPagos[1].required = (valores.toUpperCase() == 'TRUE') ? true : false;
        $('#voucher').val('');
    }
});
$('#m_valorCliente').blur(function () {
    value = parseFloat(SetNumber($(this).val()));
    $('#mtotaldesct_cliente').text('$ ' + (value).Money());
    $('#mtotal').text('$ ' + (parseFloat(SetNumber($('#mtotal_cliente').text())) + parseFloat(SetNumber($('#mtotal_concepto').text())) - value).Money());

});

//Evento que acciona un nuevo recibo de caja
$('#btnnew').click(function () {
    newpay();
});
//Evento que agrega a la grilla de conceptos un item de tipo concepto con su valor
$('#addarticle').click(function (e) {
    if (validate(JsonValidateConcepto)) {
        code = $('#hiddencode').val();
        id_concepto = $('#id_concepto').val();
        nombre = $('#ds_concepto').val();
        total = parseFloat(SetNumber($('#mtotal_concepto').text()));
        valor = parseFloat(SetNumber($('#m_valor').val()));
        if (valor > 0) {
            var body = $('#tbodconceptos');
            count = body.find('tr[data-concepto="' + id_concepto + '"]');
            if (count == undefined || count.length == 0) {
                tr = $('<tr/>').attr({ 'data-concepto': id_concepto, 'data-valor': valor });
                a = $('<a/>').html('<span class="fa fa-2x fa-trash-o text-danger iconfa"></span>').click(function () {
                    $(this).closest('tr').remove();
                    total -= tr.data().valor
                    $('#mtotal_concepto').text('$ ' + total.Money());
                    $('#mtotal').text('$ ' + (parseFloat(SetNumber($('#mtotal_cliente').text())) + total).Money());
                })
                td = $('<td class="text-center"/>').append(a);
                td1 = $('<td class="text-center"/>').html(id_concepto);
                td2 = $('<td class="text-center"/>').html(nombre);
                td3 = $('<td class="text-center"/>').html('$ ' + Number(valor).Money(2));
                tr.append(td, td1, td2, td3);
                body.append(tr);
                total = total + valor;
                $('#id_concepto').val('');
                $('#ds_concepto').val('');
                $('#m_valor').val('0.00');
                $('#tab-1').removeClass('active') && $('#tab-2').addClass('active')
                $('#tabuno').parent().removeClass('active');
                ($('#tabdos').parent().addClass('active'));
                $('#mtotal_concepto').text('$ ' + total.Money());
                $('#mtotal').text('$ ' + (parseFloat(SetNumber($('#mtotal_cliente').text())) + total).Money());
            }
            else
                toastr.warning("Este Concepto ya esta dentro de la formulación", 'Sintesis ERP');
        }
        else
            toastr.warning("El valor no puede ser menor ni igual a 0.", 'Sintesis ERP');

        $('#hiddencode').val('');
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
            if (SetNumber($('#Tcambio').text()) < 0) {
                if (window.tblpagoscre.bootgrid("getTotalRowCount") > 0) {
                    if ($('#tbdcuotas tr').length > 0)
                        addCuota('F');
                }
            } else {
                cleanpagocred();
            }
        }
    }
});

//Evento de guardar recibo de caja
$('#btnSave').click(function () {
    if (validate(JsonValidate)) {
        $('#Ttotalfac').text($('#Ttotal').text());
        $('#Tpagado').text("$ 0.00");
        $('#Tcambio').text("$ 0.00");
        $('#valorforma').val("$ 0.00");
        $('#tbdpagos').empty();
        if (SetNumber($('.pagonumber').html()) == 0) {
            if (SetNumber($('#mtotal').text()) > 0) {
                $('#Ttotalfac').text($('#mtotal').text());
                var opt = $(this).attr('data-option');
                if (opt == 'F') {
                    $('#ModalFormas').modal({ backdrop: 'static', keyboard: false }, 'show');
                }
            } else {
                toastr.warning("No ha realizado ningun movimiento en el documento.", 'Sintesis ERP');
            }
        } else {
            toastr.warning("Recibo de caja fue realizado.", 'Sintesis ERP');

        }
    }
});

//Evento de Impresion de documento generado a Recibo de Caja
$('#btnFact').click(function () {
    var pagosXML = '<root>'
    let facturar = true;
    window.gridbod.find(".command-state").each(function () {
        var state = $(this).children();
        if (state.attr('class') == 'fa fa-2x fa-fw fa-check-square-o text-success  iconfa') {
            if (SetNumber($('#pay' + $(this).data("row-id")).html()) > 0) {
                pagosXML += '<pago id_factura="' + $(this).data("row-factura") + '" valor="' + SetNumber(($('#pay' + $(this).data("row-id")).html())) + '" porceInteres="' + SetNumber(($('#interes' + $(this).data("row-id")).html())) + '" capital="' + $('#capital_' + $(this).data("row-factura")).prop('checked') + '"/>'
            } else {
                facturar = false;
                toastr.warning('Item ' + $(this).data('row-factura') + ' ha sido seleccionado favor colocar valor a pagar', 'Sintesis ERP');
            }
        }
    });
    pagosXML += '</root>';
    params = {};
    params.id = $('#id_recibo').val();
    params.id_tipodoc = $('#cd_tipodoc').val();
    params.id_centrocostos = ($('#id_ccostos').val() == "") ? '0' : $('#id_ccostos').val();
    params.fecha = SetDate($('#Text_Fecha').val());
    params.voucher = $('#voucher').val();
    params.id_cliente = $('#cd_cliente').val();
    params.valorclie = SetNumber($('#mtotal_cliente').text());
    params.valorconcepto = SetNumber($('#mtotal_concepto').text());
    params.cambio = SetNumber($('#Tcambio').text());
    params.idconceptoDscto = $('#id_conceptoDscto').val();
    params.valorDscto = parseFloat(SetNumber($('#m_valorCliente').val()));
    params.pagosXML = pagosXML;
    params.xmlconceptos = GenerarXMLConceptos();
    params.detalle = $('#descripcion').val();
    var cambio = SetNumber($('#Tcambio').text());
    if (cambio >= 0) {
        var formas = Getxmlforma();
        params.formapago = "<Formas>" + Getxmlforma() + "</Formas>";
        if (facturar)
            MethodService("RecaudoCartera", "recaudocarterasave", JSON.stringify(params), "EndCallbackPago");

    } else {
        toastr.warning("El valor pagado no puede ser menor al de la factura.", 'Sintesis ERP');

    }



});

//Evento de reversion de recaudo cartera
$('#btnRev').click(function () {
    if ($('#id_recibo').val() != '0' && $('#id_recibo').val().trim() != '') {
        if (confirm("Desea revertir el pago?")) {
            var sJon = {};
            sJon.id = ($('#id_recibo').val().trim() == "") ? "0" : $('#id_recibo').val();
            MethodService("RecaudoCartera", "RevertirRecaudoCartera", JSON.stringify(sJon), "CallbackReversion");
        }
    }
});
//Evento de Impresion de documento generado a recaudo cartera
$('#btnPrint').click(function () {
    var idrecibo = $('#id_recibo').val();
    param = 'id|' + idrecibo + ';'
    PrintDocument(param, 'MOVRECAUDOC', 'CODE');
});

//Funcion de reseteo para nuevo recaudo cartera
function newpay() {

    $('#ds_cliente').removeAttr('disabled');
    $('#cd_formapago').removeAttr('disabled');
    var div = $('#diventrada');
    ////////modificado////////////////
    $('#cd_cliente,#id_recibo,#isDescuento,#id_ccostos,#id_conceptoDscto,#cd_tipodoc').val(0);
    /////////////////
    $('#ds_cliente,#codigoccostos,#ds_conceptoDscto, #descripcion').val('');
    $('#m_valor,#m_valorCliente').val('$ 0.00');
    $('#m_valor,#m_valorCliente').attr('disabled', true);
    $('#mtotal,#mtotal_cliente,#mtotal_concepto').text('$ 0.00');
    $('.pagonumber').html(0);
    $('#cd_formapago').val(0).selectpicker('refresh');
    $('#cd_tipodoc').val(0).selectpicker('refresh');
    $('#tbodconceptos').empty();
    $('#btnFact').attr('disabled', 'disabled');

    ////////////////////////////modificado////////////////////////
    $('#btnSave,#m_valor,.btnsearch,#Text_Fecha,#cd_formapago, #btnAdd, #cd_tipodoc, #codigoccostos').removeAttr('disabled');
    ////////////////////////////////////////////////7
    $('#btnRev').attr('disabled', true);
    $('#Tpagado').text("$ 0.00");
    $('#Tcambio').text("$ 0.00");
    $('#valorforma').val("$ 0.00");
    $('#tbdpagos').empty();
    window.gridbod.bootgrid('reload');
    $('#cajarecibos').hide();
    $('#cajacuotas').show();
    div.find('select').selectpicker('refresh');
}

function formReset() {
    div = $('#ModalWineries');
    div.find('input.form-control').val('');
    div.find('textarea').val('');
    $('#btnSave').attr('data-id', '0');
}
$('#btnAdd').click(function () {
    if (!($('#state' + $('#idfactura').val()).attr('class') == 'fa fa-2x fa-fw fa-square-o text-danger  iconfa')) {
        valorpagar = parseFloat(SetNumber($('#vlrpagar').val()));
        if (valorpagar > 0) {
            $('#pay' + $('#idfactura').val()).html('$ ' + valorpagar.Money());
            $('#mtotal_cliente').text('$ ' + (valorpagar + parseFloat(SetNumber($('#mtotalclienteTemp').val()))).Money());
            $('#mtotal').text('$ ' + ((parseFloat(SetNumber($('#mtotal_concepto').text())) + (parseFloat(SetNumber($('#mtotal_cliente').text())))).Money()));
            $('#Modalcuotas').modal('hide');
        } else {
            toastr.info('Debe seleccionar minimo una cuota!', 'Sintesis ERP');
        }
    } else {
        toastr.warning("Primero debe seleccionar factura a pagar.", 'Sintesis ERP');
    }
});
//Funcion CallBack que se activa despues de facturado el recaudo cartera
function EndCallbackPago(params, answer) {
    if (!answer.Error) {
        data = answer.Row;
        $('#id_recibo').val(data.id);
        toastr.success('Pagos Realizados Correctamente.', 'Sintesis ERP');
        $('#btnSave,#m_valor,.btnsearch,#Text_Fecha,#cd_formapago,#btnAdd').attr('disabled', 'disabled');
        var div = $('.divpagos');
        div.find('select').selectpicker('refresh');
        $('.pagonumber').html(data.id);
        $("#ModalFormas").modal('hide');
        $('#btnRev').removeAttr('disabled');
        $('#tblcommodity').find('a.command-state').remove();
        window.gridrecibos.bootgrid('reload');
        $('#cajacuotas').hide();
        $('#cajarecibos').show();
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }

}
//Funcion CallBack que se activa despues de revertir un recaudo cartera
function CallbackReversion(Parameter, Result) {
    json = JSON.parse(Parameter);
    if (!Result.Error) {
        datos = Result.Row;
        $('.pagonumber').html(datos.id);
        $('#id_recibo').val(datos.id);
        $('#btnSave, #btnRev').attr('disabled', 'disabled');
        window.gridbod.bootgrid('reload');
        toastr.success('Documento Revertido.', 'Sintesis ERP');
    }
    else
        toastr.error(Result.Message, 'Sintesis ERP');
}

function CallbackReversionList(Parameter, Result) {
    json = JSON.parse(Parameter);
    if (!Result.Error) {
        window.gridpagosreal.bootgrid('reload');
        toastr.success('Recaudo cartera revertido.', 'Sintesis ERP');
    }
    else
        toastr.error(Result.Message, 'Sintesis ERP');
}

//Funcion CallBack que se activa despues de Seleccionar un recaudo cartera
function EndCallbackGet(params, answer) {
    if (!answer.Error) {
        data = answer.Row;
        $('#btnSave').attr('data-id', data.id);
        (data.estado == 'REVERSION') ? $('#id_recibo').val(data.id_reversion) : $('#id_recibo').val(data.id);
        //$('#id_recibo').val(data.id);
        $('.pagonumber').html(data.id);
        $('#ds_cliente').val(data.cliente);
        $('#cd_tipodoc').val(data.id_tipodoc);
        $('#codigoccostos').val(data.Centrocostos);
        $('#ds_conceptoDscto').val(data.conceptoDescuento);
        $('#m_valorCliente').val(data.valorDescuento.Money());
        data.valorcliente > 0 ? $('#liuno').css('display', 'inline-block') && $('#isReca').prop('checked', true) && (data.valorconcepto == 0 ? ($('#tab-2').removeClass('active') && $('#tab-1').addClass('active') && ($('#tabuno').parent().addClass('active')) && ($('#tabdos').parent().removeClass('active'))) : ($('#tab-1').removeClass('active') && $('#tab-2').addClass('active') && ($('#tabdos').parent().addClass('active')) && ($('#tabuno').parent().removeClass('active')))) : $('#liuno').css('display', 'none') && $('#isReca').prop('checked', false) && ($('#tab-1').removeClass('active') && $('#tab-2').addClass('active'));
        data.valorcliente > 0 ? $('#liuno').css('display', 'inline-block') && $('#isReca').prop('checked', true) && (data.valorconcepto == 0 ? ($('#tab-2').removeClass('active') && $('#tab-1').addClass('active') && ($('#tabuno').parent().addClass('active')) && ($('#tabdos').parent().removeClass('active'))) : ($('#tab-1').removeClass('active') && $('#tab-2').addClass('active') && ($('#tabdos').parent().addClass('active')) && ($('#tabuno').parent().removeClass('active')))) : $('#liuno').css('display', 'none') && $('#isReca').prop('checked', false) && ($('#tab-1').removeClass('active') && $('#tab-2').addClass('active'));
        $('.i-checks').iCheck('update');
        $('#cajacuotas').css('display', 'none');
        $('#cajarecibos').css('display', 'block');
        $('#mtotal_cliente').text('$ ' + data.valorcliente.Money());
        $('#mtotal_concepto').text('$ ' + data.valorconcepto.Money());
        $('#mtotaldesct_cliente').text('$ ' + data.valorDescuento.Money());
        $('#mtotal').text('$ ' + (data.valorconcepto + data.valorcliente - data.valorDescuento).Money());

        //////////modificado////////////////////////////////
        $('#btnSave,#m_valor,.btnsearch,#Text_Fecha,#cd_formapago, #codigoccostos, #ds_cliente').attr('disabled', 'disabled');
        var div = $('#diventrada');
        div.find('input.form-control,  select.selectpicker, #cd_tipodoc').attr('disabled', 'disabled');
        div.find('select').selectpicker('refresh');
        ////////////////////////////////////77
        $('#btnRev').removeAttr('disabled');
        $('#factura,#m_valor').attr('disabled', 'disabled');
        $('#tabdos').attr('href', "#tab-2");
        window.gridrecibos.bootgrid('reload');

        $('#Modalpagos').modal('hide');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
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

function EndCallbackCausacion(params, answer) {
    if (!answer.Error) {
        toastr.success("Proceso ejecutado exitosamente.", 'Sintesis ERP');
        window.gridcuotasxfact.bootgrid('reload');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
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
    $('#TtotalfacCre2').text('$ ' + (SetNumber($('#Tcambio').text()) * -1).Money());
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

//Funcion limpia los campos relacionados con el concepto
function cleanTableConcepto() {
    if ($('#tbodconceptos').find('tr').length > 0)
        if ($('#tbodconceptos').find('tr')[0].children[0].innerHTML === 'No hay resultado!')
            $('#tbodconceptos').empty();
}
function cleanpago() {
    $('#valorforma').val('$ 0.00');
    $('#cd_formapago').val('').selectpicker('refresh');
    $('#voucher').val('');

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
