window.gridfacturas;
window.gridcuotas;
window.gridpagos;
$(document).ready(function () {
   
    //grilla de listado de facturas
    window.gridfacturas = $("#tblcommodity").bootgrid({
        ajax: true,
        post: function () {
            return {
                'params': function () {
                    var param = {};
                    param.id_tercero = $('#cd_tercero').val();
                    param.tipotercero = $('#tipotercero1').val();
                    param.all = $('#pagadas').prop('checked') == false ? 0 : 1;
                    param.Fecha = SetDate($('#Text_Fecha').val());
                    return JSON.stringify(param);
                },
                'class': 'CNTTerceros',
                'method': 'TerceroFacturasList'
            };
        },
        url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
        formatters: {
            "ver": function (column, row) {
                return "<a class=\"action command-print\" data-row-id=\"" + row.id + "\"><span class=\"fa fa-2x fa-print iconfa\"></span></a>";
            },
            "viewc": function (column, row) {
                return "<a class=\"action command-viewc\" data-row-id=\"" + row.id + "\" data-row-factura=\"" + row.consecutivo + "\"><span class=\"fa-2x fa fa-eye iconfa\"></span></a>";
            },
            "state": function (column, row) {
                return "<a class=\"action command-state\"   data-row-id=\"" + row.id + "\" data-row-factura=\"" + row.consecutivo + "\" data-row-idcuenta=\"" + row.idcuenta + "\"  >" +
                    "<span id='state" + row.id + "' class=\"fa fa-2x fa-fw fa-square-o text-danger  iconfa\"></span></a>";
            },
            "total": function (column, row) {
                return '$ ' + row.total.Money();
            },
            "totalcredito": function (column, row) {
                return '$ ' + row.totalcredito.Money();
            }
        }
    }).on("loaded.rs.jquery.bootgrid", function () {
        // Executes after data is loaded and rendered 
        window.gridfacturas.find(".command-state").on("click", function (e) {
            state = $(this).children();
            id = $(this).data("row-factura");
            id_cuenta = $(this).data("row-idcuenta");
            if (state.attr('class') == 'fa fa-2x fa-fw fa-square-o text-danger  iconfa') {
                window.gridfacturas.find('.command-state').children().attr('class', 'fa fa-2x fa-fw fa-square-o text-danger  iconfa');
                state.attr('class', 'fa fa-2x fa-fw fa-check-square-o text-success  iconfa');
                $('#id_factura').val(id);
                $('#id_cuenta').val(id_cuenta);
            } else {
                state.attr('class', 'fa fa-2x fa-fw fa-square-o text-danger  iconfa');
                $('#id_factura').val(0);;
            }
            window.gridcuotas.bootgrid('reload');
            //$('#cd_tipoterce option:selected').data('option') == 'CL' ? window.gridcuotas.bootgrid('reload'): window.gridpagos.bootgrid('reload');

        }).end().find(".command-print").on("click", function (e) {
            $('#ModalLoad').modal({ backdrop: 'static', keyboard: false }, "show");
            id = $(this).data("row-id")
            if ($('#cd_tipoterce option:selected').data('option') == 'CL') {
                var idfactura = id
                param = 'id|' + idfactura + ';'
                PrintDocument(param, 'MOVFACTURASFE', 'CODE');
            }
            if ($('#cd_tipoterce option:selected').data('option') == 'PR') {
                var identrada = id;
                param = 'id|' + identrada + ';'
                PrintDocument(param, 'MOVENTRADA', 'CODE');
            }
        }).end().find(".command-viewc").on("click", function (e) {
            factura = $(this).data("row-factura");
            $('#numFactura').text(factura);
            window.gridcuotasxfact.bootgrid('reload');
            $('#Modalcuotas').modal({ backdrop: 'static', keyboard: false }, 'show');

        });
    })

    //GRILLA DE LISTADOS DE CUOTAS/PAGOS
    window.gridcuotas = $("#tblcuotas").bootgrid({
        ajax: true,
        post: function () {
            return {
                'params': function () {
                    var param = {};
                    param.id_factura = $('#id_factura').val();
                    param.tipotercero = $('#tipotercero1').val();
                    param.id_cuenta = $('#id_cuenta').val();
                    param.Fecha = SetDate($('#Text_Fecha').val());
                    return JSON.stringify(param);
                },
                'class': 'CNTTerceros',
                'method': 'TerceroPagosList'
            };
        },
        url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
        formatters: {
            "ver": function (column, row) {
                $('#saldoactual').text('$ '+row.saldoactual.Money());
                return "<a class=\"action command-ver\" data-row-id=\"" + row.nrodocumento + "\" data-row-tipodoc=\"" + row.tipodocumento + "\"><span class=\"fa fa-2x fa-print iconfa\"></span></a>";

            }
        }
    }).on("loaded.rs.jquery.bootgrid", function () {
        // Executes after data is loaded and rendered 
        window.gridcuotas.find(".command-ver").on("click", function (e) {
            id = $(this).data("row-id");
            tipodoc = $(this).data("row-tipodoc");
            let informe = '';
            if (tipodoc === 'FV')
                informe = 'MOVFACTURASFE';
            else if (tipodoc === 'RC')
                informe = 'MOVRECIBO';
            else if (tipodoc === 'DV')
                informe = 'DEVOLFACTURA';
            else if (tipodoc === 'NC')
                informe = 'MOVNOTACARTERA';
            else if (tipodoc === 'EN')
                informe = 'MOVENTRADA';
            else if (tipodoc === 'DC')
                informe = 'MOVDEVENTRADA';
            else if (tipodoc === 'CE')
                informe = 'PAGOPROVE';
            else if (tipodoc === 'CC')
                informe = 'MOVCOMPROCONTA';
            var id_doc = id;
            param = 'id|' + id_doc + ';'
            PrintDocument(param, informe, 'CODE');

        })
    })
    window.gridcuotasxfact;
    //Funcion donde se carga las cuotas por numero de factura en un modal diferente
        window.gridcuotasxfact = $("#tblcuotasxfact").bootgrid({
            ajax: true,
            post: function () {
                return {
                    'params': function () {
                        var param = {};
                        param.id_factura = $('#numFactura').text();
                        param.porceinteres = $('#porceinteres').val();
                        param.fecha = SetDate($('#Text_Fecha').val());
                        param.all = true;//parametro que me indica que me listara solo las cuotas pendientes por pagar al colocar valor 0
                        return JSON.stringify(param);
                    },
                    'class': 'ReciboCaja',
                    'method': 'MOvFacturaList'
                };
            },
            url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
            formatters: {
                "state": function (column, row) {
                    if (row.saldo > 0)
                        return "<a class=\"action command-state\"  data-row-cuota=\"" + row.cuota + "\"  data-row-id=\"" + row.id + "\"   data-row-vlr=\"" + row.vlrcuota + "\" data-row-saldoc=\"" + (row.saldo + (row.interes - row.Ainteres)) + "\"   data-row-dias=\"" + row.diasvencido + "\"  >" +
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
                "Ainteres": function (column, row) {
                    return '$ ' + row.Ainteres.Money();
                },
                "Tinteres": function (column, row) {
                    return '$ ' + (row.saldo == 0 ? ((row.interes - row.Ainteres) * -1) : (row.interes - row.Ainteres)).Money();
                }

            }
        })
    
    $('#cd_tipoterce').change(function () {
        tipotercero = $('#cd_tipoterce option:selected').data('option');
        $('#tipotercero1').val(tipotercero);        
        //if (tipotercero == 'PR') {
        //    $('#cliente').css('display', 'none');
        //    $('#proveedor').css('display', 'block');
        //} else {
        //    $('#proveedor').css('display', 'none');
        //    $('#cliente').css('display', 'block');
        //}

    });

    $('#btnRefreshTer').click(function () {
        id = ($('#cd_tercero').val() == "") ? "0" : $('#cd_tercero').val();
        params = {};
        params.id = id;
        MethodService("CNTTerceros", "CNTTercerosGet", JSON.stringify(params), 'EndCallbackGet');

    });
});
function cleantercero() {
    $('#Text_direccion,#ds_tercero').val('')
    $('#cd_tercero,#id_factura').val(0);
    $('#pagadas').prop('checked', false).iCheck('update')
    $('#cd_type,#pn_type,#cd_catfiscal,#cd_city').val('').selectpicker('refresh');
    window.gridfacturas.bootgrid('reload');
    window.gridcuotas.bootgrid('reload');
    window.gridpagos.bootgrid('reload');
}

function EndCallbackGet(params, answer) {
    if (!answer.Error) {
        data = answer.Row;
        $('#cd_type').val(data.tipoiden);
        $('#pn_type').val(data.id_personeria);
        $('#cd_city').val(data.id_ciudad);
        $('#cd_catfiscal').val(data.id_catfiscal)
        $('#Text_direccion').val(data.direccion);

        window.gridfacturas.bootgrid('reload');


        $('.i-checks').iCheck('update');
        $('select').selectpicker('refresh');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}