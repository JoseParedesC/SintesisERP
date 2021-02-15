var JsonValidate = [
    { id: 'Text_Fecha', type: 'DATE', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'cd_tipodoc', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
    { id: 'codigoccostos', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
    { id: 'ds_vendedor', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'ds_cliente', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'SelectForma', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
    { id: 'ds_ctadscto', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
    { id: 'valorFianza', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' }];


var JsonCommodity = [
    { id: 'v_code', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'nombre', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'm_quantity', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'm_precio', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'cd_series', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
    { id: 'cd_wineridef', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' }];

var JsonPagos = [
    { id: 'id_forma', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'voucher', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' }];


var JsonPagosCre = [
    { id: 'tipo_cartera', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
    { id: 'nrocuotas2', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'Text_FechaVenIni2', type: 'DATE', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'id_tipoven', type: 'TEXT', htmltype: 'SELECT', required: false, depends: false, iddepends: '' },
    { id: 'nrodias2', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];

window.tblcommodity = null;
window.tblpagos = null;
window.tblpagoscre = null;
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
            "total": function (column, row) {
                return row.total.Money();
            },
            "precio": function (column, row) {
                return row.precio.Money();
            },
            "cantidad": function (column, row) {
                return row.cantidad.Money();
            },
            "serie": function (column, row) {
                return (row.serie) ? "<span class='tdedit action command-serie fa fa-2x fa-pencil text-info' data-column='serie'  data-count='" + row.cantidad + "' data-id='" + row.id + "'></span>" : '';
            },
            "lote": function (column, row) {
                return (!row.serie && row.lote) ? "<span class='tdedit action command-lote fa fa-2x fa-pencil text-error' data-column='lote'  data-count='" + row.cantidad + "' data-id='" + row.id + "'></span>" : '';
            },
            "iva": function (column, row) {
                return row.iva.Money();
            },
            "inc": function (column, row) {
                return row.inc.Money();
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
            params.id_anticipo = 0;
            MethodService("Facturas", "FacturasDelArticulo", JSON.stringify(params), 'EndCallbackupdate');
        }).end().find(".command-lote").on("click", function (e) {
            id = $(this).data("id");
            CallSearchLoteSerie(id, 0, 'LF', $('#opTipoFactura').val(), 'EndCallbackArticleLote');
        }).end().find(".command-serie").on("click", function (e) {
            id = $(this).data("id");
            $('#btnSaveSeries').attr('data-id', id)
            CallSearchLoteSerie(id, 0, 'SF', (($('#opTipoFactura').val() == 'T') ? 'P' : 'F'), 'EndCallbackArticleSerie');
        });
    });

    window.tblpagoscre = $("#tblpagoscre").bootgrid({
        rowCount: -1,
        columnSelection: false,
        identifier: null,
        searchSettings: false,
        formatters: {
            "valor": function (column, row) {
                return '$ ' + row.cuota.Money(2);
            },
            "saldo": function (column, row) {
                return '$ ' + row.saldo.Money(2);
            }
        }
    });

    newFactura();

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

    $('#cd_tipodoc').change(function () {
        if ($("#id_factura").val() == '0') {
            var valores = $(this).find('option:selected').attr('data-centro');
            var split = valores.split('|~|');
            $('#id_ccostos').val(split[1]);
            $('#codigoccostos').val(split[2]);
            JsonValidate[1].required = (split[0] == '1') ? true : false;
        }
    });
    $('.recalculo').change(function () {
        RecalcularFactura($(this));
        if ($(this).attr('id') == 'm_discountfin') {
            JsonValidate[6].required = SetNumber($(this).val()) > 0 ? true : false;
        }
    })
});

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
                        'method': 'FacturasList'
                    };
                },
                url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
                formatters: {
                    "edit": function (column, row) {
                        return "<a class=\"action command-edit\" data-row-id=\"" + row.id + "\"><span class=\"fa-2x fa fa-eye iconfa\"></span></a>";
                    },
                    "total": function (column, row) {
                        return '$ ' + row.total.Money();
                    },

                    "Imprimir": function (column, row) {
                        if (row.Finan != null)
                            return "<a class=\"action command-ver\" data-row-id=\"" + row.id + "\"><span class=\"fa fa-2x fa-print iconfa\"></span></a>";
                    }
                }
            }).on("loaded.rs.jquery.bootgrid", function () {
                // Executes after data is loaded and rendered 
                window.gridfacturas.find(".command-edit").on("click", function (e) {
                    id = $(this).data("row-id")
                    params = {};
                    params.id = id;
                    params.idtemp = "0";
                    params.op = '';
                    MethodService("Facturas", "FacturasGet", JSON.stringify(params), 'EndCallbackGet');
                }).end().find(".command-ver").on("click", function (e) {    ////////////modificado 20/01 
                    $('#ModalLoad').modal({ backdrop: 'static', keyboard: false }, "show");
                    id = $(this).data("row-id")
                    param = 'id|' + id + ';'
                    PrintDocument(param, 'MOVAMORTIZACION', 'CODE');
                });
            });
        }
        else
            window.gridfacturas.bootgrid('reload');

        $('#ModalFacturas').modal({ backdrop: 'static', keyboard: false }, "show");
    });

    $('#btnRev').click(function () {
        if ($('#id_factura').val() != '0' && $('#id_factura').val().trim() != '') {
            if (confirm("Desea revertir la factura?")) {
                var sJon = {};
                sJon.id = $('#id_factura').val();
                MethodService("Facturas", "RevertirFactura", JSON.stringify(sJon), "CallbackReversion");
            }
        }
    });

    $('#addPago').click(function () {

        if (validate(JsonPagos)) {
            json = {};
            json.valor = SetNumber($('#valorforma').val());
            json.id = $('#id_forma').val();
            json.tipo = $('#id_forma option:selected').text();
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
                $('#tblpagos').show();
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

    $('#actCuotas').click(function () {
        var opt = $(this).attr('data-option');
        opCredi = $("#ValorPago").val();

        if (opCredi == 'CREDI') {
            JsonPagosCre[3].required = true;
        } else {
            JsonPagosCre[3].required = false;
        }
        addCuota(opt);
    });

    $('#addarticle').click(function () {
        var idarticle = $('#addarticle').attr('data-id');
        if (validate(JsonCommodity)) {
            var Parameter = {};
            Parameter.idToken = $('#idToken').val();
            Parameter.id_bodega = ($('#addarticle').attr('data-idbodega') == '') ? '0' : $('#addarticle').attr('data-idbodega');
            Parameter.id_article = idarticle;
            Parameter.quantity = SetNumber($('#m_quantity').val());
            Parameter.precio = SetNumber($('#m_precio').val());
            Parameter.porcendsc = SetNumber($('#Text_Descuento').val());
            Parameter.descuento = SetNumber($('#m_discount').val());
            Parameter.lote = ($('#divaddart').attr('data-lote') == 'true') ? true : false;
            Parameter.serie = ($('#divaddart').attr('data-serie') == 'true') ? true : false;
            Parameter.series = setMultiSelect('cd_series');
            Parameter.inventarial = ($('#divaddart').attr('data-inventario') == 'true') ? true : false;
            Parameter.anticipo = SetNumber($('#m_anticipo').val());
            Parameter.descuentoFin = SetNumber($('#m_discountfin').val());//Modificado 28/01/2021																											  
            if (!Parameter.serie || ($('#cd_series').val() != null && $('#cd_series').val().length == Parameter.quantity))
                MethodService("Facturas", "FacturasAddArticulo", JSON.stringify(Parameter), "EndCallbackAddArticle");
            else
                toastr.warning('La cantidad de series seleccionadas no es la misma que la que desea agregar.', 'Sintesis ERP');
        }
    });

    $('#btnSaveLotes').click(function () {
        if ($('#opTipoFactura').val() == 'T') {
            id = $(this).attr('data-id');
            xml = '';
            $.each($('input.inputlote'), function (i, e) {
                element = $(e);
                xml += '<item idlote="' + element.attr('data-id') + '" cant="' + SetNumber(element.val()) + '" />>'
            })
            SetCalueColumn(id, 'LOTE', 0, '', '', xml, 'EndCallbackSaveLote');
        }
        else
            $('#ModalLotes, #ModalSeries').modal('hide');
    });

    $('#btnSaveSeries').click(function () {
        if ($('#opTipoFactura').val() == 'T') {
            id = $(this).attr('data-id');
            value = setMultiSelect('setseries');
            SetCalueColumn(id, 'SERIE', 0, value, '', '', 'EndCallbackSaveLote');
        }
        else
            $('#ModalSeries').modal('hide');
    });

    $('#btnPrint').click(function () {
        var idfactura = $('#id_factura').val();
        param = 'id|' + idfactura + ';'
        PrintDocument(param, 'MOVFACTURASFE', 'CODE');
    });

    $('#btnPrintt').click(function () {
        var idfactura = $('#id_factura').val();
        param = 'id|' + idfactura + ';'
        PrintDocument(param, 'MOVFACTURASFE', 'CODE');
    });


    $('#btnPrintTableCuota').click(function () {
        var idfactura = $('#id_factura').val();
        param = 'id|' + idfactura + ';'
        PrintDocument(param, 'MOVAMORTIZACION', 'CODE');
    });
    $('#btnnew').click(function () {
        newFactura();
    });

    $('#btnCance, #btncancemodal').click(function () {
        $('#valorCuotacre, #nrocuotas2').val('');
        $('#valorforma, #voucher').val('');
        $('#tblpagos').hide();
        $('#id_forma').val('').selectpicker('refresh');
        $('#SelectForma').val('').selectpicker('refresh');
        $('#tipo_cartera').val('').selectpicker('refresh');
        $('#pagoContado, #ContenedorCuota, #pagoLineasCredi, #pagoCredito, #tblpagos').hide();
        var drDestroy = window.tblpagoscre.data('.rs.jquery.bootgrid');
        drDestroy.clear();

    });

    $('#DetalleCuota').click(function () {
        $('#ContenedorCuota').toggle();
        $('#CuotaCredi').toggle();

    });

    //----------------------FORMA DE PAGO SELECT---------------------------------------------
    $(document).ready(function () {
        $('#pagoContado').hide();
        $('#pagoLineasCredi').hide();
        $('#pagoCredito').hide();
        $('#tblpagos').hide();
        $('#CuotaCredi').hide();
        $('#PagoAcreditos').hide();
        $('#Tipovencimi').hide();
        $('#ValorCuotaFinanza').hide();
        $('#numdias').hide();


        var opcionF = '';
        $('#SelectForma').change(function () {
            if ($("#id_factura").val() == '0') {
                var valores = $(this).find('option:selected').attr('data-op');
                $("#ValorPago").val(valores);

                opcionF = valores;
                if (valores == 'CONV') {
                    $('#pagoContado').show();
                    $('#pagoCredito').hide();
                    $('#ContenedorCuota').hide();
                    $('#CuotaCredi').hide();
                    $('#pagoLineasCredi').hide();

                } else if (valores == 'CREDI') {
                    $('#PagoAcreditos').show();
                    $('#pagoContado').show();
                    $('#pagoCredito').show();
                    $('#CuotaCredi').show();
                    $('#Tipovencimi').show();
                    $('#pagoLineasCredi').hide();

                    $('#ValorCuotaFinanza').hide();
                    $('#numdias').show();


                } else if (valores == 'FINAN') {
                    $('#PagoAcreditos').show();
                    $('#CuotaCredi').show();
                    $('#pagoContado').show();
                    $('#ContenedorCuota').hide();
                    $('#Tipovencimi').hide();
                    $('#pagoCredito').show();
                    $('#ValorCuotaFinanza').show();
                    $('#numdias').hide();

                }

            }
        });


    });
    //-------------------------------------------------------------------																		 

    $('#btnSave').click(function () {
        LoadSave();
    });

    $('#btnFact').click(function () {
        var totalfactsinact = parseFloat(SetNumber($('#Ttventa').text())) - parseFloat(SetNumber($('#TdescArt').text())) + parseFloat(SetNumber($('#Tiva').text())) + parseFloat(SetNumber($('#Tinc').text()))
        opfianza = $("#ValorPago").val();
        valorcuota = parseFloat(SetNumber($("#valorCuotacre").val()));
        valorfianza = parseFloat(SetNumber($("#valorFianza").val()));

        if (opfianza == 'FINAN') {
            JsonValidate[7].required = true;
        } else {
            JsonValidate[7].required = false;
            valorfianza = 1;
            valorcuota = 0;
        }

        if (validate(JsonValidate)) {
            var sJon = {};
            sJon.id_tipodoc = $('#cd_tipodoc').val();
            sJon.id_centrocostos = ($('#id_ccostos').val().trim() == "") ? "0" : $('#id_ccostos').val();
            sJon.Fecha = SetDate($('#Text_Fecha').val());
            sJon.id_tercero = $('#cd_cliente').val();
            sJon.id_vendedor = $('#cd_vendedor').val();
            sJon.id_ctaant = ($('#id_ctaant').val().trim() == "") ? "0" : $('#id_ctaant').val();
            sJon.anticipo = SetNumber($('#m_anticipo').val());
            sJon.op = $("#SelectForma").val();
            sJon.vrlfianza = ($('#valorFianza').val().trim() == "") ? "0" : parseFloat(SetNumber($("#valorFianza").val()));
            sJon.descuentoFin = SetNumber($('#m_discountfin').val());//Modificado 28/01/2021
            sJon.id_ctadscto = $('#id_ctadscto').val();//Modificado 28/01/2021

            var cambio = SetNumber($('#Tcambio').text());

            if (valorfianza >= valorcuota) {
                if (cambio >= 0) {
                    if (cambio >= 0) {
                        var formas = Getxmlforma();
                        sJon.formapago = "<Formas>" + Getxmlforma() + "</Formas>";
                        sJon.idToken = $('#idToken').val();
                        var credito = SetNumber($('#TCredito').text());
                        sJon.totalcredito = credito;
                        if (parseFloat(credito) > 0) {
                            datac = $("#tblpagoscre");
                            var opc = $("#ValorPago").val();
                            sJon.dias = datac.attr('data-dias');
                            sJon.ven = datac.attr('data-tipoven');
                            sJon.cuotas = datac.attr('data-cuotas');
                            sJon.inicial = datac.attr('data-inicial');
                            sJon.id_formacred = $('#tipo_cartera').val();
                        }
                        else {
                            sJon.dias = 0;
                            sJon.ven = 0;
                            sJon.cuotas = 0;
                            sJon.inicial = ''
                            sJon.id_formacred = 0;
                        }
                        $('#btnFact').button('loading');
                        MethodService("Facturas", "FacturarFactura", JSON.stringify(sJon), "CallbackComodity");

                    } else {
                        toastr.warning("El valor pagado no puede ser menor al de la factura.", 'Sintesis ERP');

                    }
                }
                else {
                    toastr.warning("No ha completado el valor a pagar.", 'Sintesis ERP');
                }

            } else {
                toastr.warning("El valor cuota Fianza no puede ser menor que la cuota financiada.", 'Sintesis ERP');
            }
        }

    });

    $('#Text_Descuento, #m_discount').blur(function () {
        opt = $(this).attr('data-option');
        val = SetNumber($(this).val());
        val = (val != '') ? val : 0;
        precio = SetNumber($('#m_precio').val());
        cantidad = SetNumber($('#m_quantity').val());
        if (precio > 0) {
            if (opt == 'P') {
                valor = precio * (val / 100) * cantidad;
                $('#m_discount').val(valor.Money());
            }
            else if (opt == 'V') {
                valor = (precio <= 0) ? 0.00 : ((val / cantidad) * 100 / precio);
                $('#Text_Descuento').val(valor.Money());
            }

        }
        else
            $(this).val('0.00')

    });

    $('#Text_Fecha').on("dp.change", function (e) {
        var newdate = (e.date == null) ? '' : $(this).val();
        var olddate = (e.oldDate == null) ? newdate : e.oldDate._i;
        if (newdate != olddate)
            RecalcularFactura($(this))
    });

    $('.recalculo').change(function () {
        RecalcularFactura($(this))
    });

    $('#id_forma').change(function () {
        if ($("#id_factura").val() == '0') {
            var valores = $(this).find('option:selected').attr('data-voucher');
            JsonPagos[1].required = (valores.toUpperCase() == 'TRUE') ? true : false;
            $('#voucher').val('');
        }
    });
});

function LoadSave() {
    var opt = $('#btnSave').attr('data-option');
    var anticipo = parseFloat(SetNumber($('#m_anticipo').val()));
    var totalfac = parseFloat(SetNumber($('#Ttotal').text()));
    var pagado = anticipo >= totalfac ? parseFloat(SetNumber($('#Ttotal').text())) : anticipo;
    pagado - totalfac >= 0 ? $('#addPago').attr('disabled', 'disabled') : $('#addPago').removeAttr('disabled');

    if (totalfac >= 0) {
        if (validate(JsonValidate)) {
            sJon = {};
            sJon.id = $('#SelectForma').val();
            MethodService("Facturas", "FacturarFacturaLoadSet", JSON.stringify(sJon), "CallbackLoadSet");

            if (window.tblcommodity.bootgrid("getTotalRowCount") > 0) {
                $('#Ttotalfac').text('$ ' + (totalfac).Money());


                $('#Tpagado').text("$ 0.00");
                $('#TCredito').text('$ 0.00');
                $('#Tcambio').text("$ 0.00");
                $('#valorforma').val("$ 0.00");
                $('#nrodias').val("1");
                $('#nrocuotas2').val('');
                $('#valorFianza').val('');
                $('#tbdpagos').empty();
                cleanpagocred();

                if (opt == 'F') {
                    $('#ModalFormas').modal({ backdrop: 'static', keyboard: false }, 'show');
                }
                else if (opt == 'C') {
                    $('#ModalCredit').modal({ backdrop: 'static', keyboard: false }, 'show');
                }
            }
            else
                toastr.warning("No ha agregado ningun artículo o concepto.", 'Sintesis ERP');
        }
    }
    else
        toastr.warning("EL valor de la factura no puede ser negativo", 'Sintesis ERP');
}

function RecalcularFactura(elemento) {
    var Parameter = {};
    Parameter.idToken = $('#idToken').val();
    Parameter.anticipo = (SetNumber($('#m_anticipo').val()) == "") ? 0 : SetNumber($('#m_anticipo').val());
    Parameter.id_cta = ($('#id_ctaant').val() == '' ? '0' : $('#id_ctaant').val());
    Parameter.id_cliente = ($('#cd_cliente').val() == '' ? '0' : $('#cd_cliente').val());
    Parameter.fecha = SetDate($('#Text_Fecha').val());
    Parameter.descuentoFin = SetNumber($('#m_discountfin').val()); //Modificado 28/01/2021										
    Parameter.op = elemento.attr('data-op');
    MethodService("Facturas", "FacturasRecalcular", JSON.stringify(Parameter), "EndCallbackRecalculo");
}

function CallSearchLoteSerie(id_articulo, id_bodega, opcion, op, callback) {
    params = {};
    params.id_articulo = id_articulo;
    params.id_bodega = id_bodega;
    params.opcion = opcion;
    params.op = op;
    params.id_factura = $('#idToken').val();
    params.proceso = 'F';
    $('#btnSaveLotes').attr('data-id', id_articulo)
    MethodService("Facturas", "FacturasBuscadorSerieLote", JSON.stringify(params), callback);
}

function SetCalueColumn(id_articulo, column, value, valorex, op, xml, callback) {
    params = {};
    params.id = id_articulo;
    params.id_factura = $('#idToken').val();
    params.value = value;
    params.column = column;
    params.extravalue = valorex;
    params.op = op;
    params.xml = '<items>' + xml + '</items>';
    params.anticipo = SetNumber($('#m_anticipo').val());
    MethodService("Facturas", "FacturaSetArticulo", JSON.stringify(params), callback);
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
        if (par.op == 'T')
            $('#cd_series').html(options).selectpicker('refresh');
        else {
            $('#setseries').html(options).selectpicker('refresh');
            if ($('#opTipoFactura').val() != 'T')
                $('#btnSaveSeries').attr('data-id', 0).attr('disabled', 'disabled');
            $('#ModalSeries').modal({ backdrop: 'static', keyboard: false }, "show");
        }
    }
    else {
        toastr.warning(answer.Message, 'Sintesis ERP');
        $('#cd_series').html('').selectpicker('refres');
    }
    if (par.op == 'T')
        $('div.divserie').show();
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
            $('#Text_Descuento').val(row.pordcto.Money()).trigger('blur');
            $('#divaddart select').selectpicker('refresh');
            $('#divaddart').attr({ 'data-serie': row.serie, 'data-lote': row.lote, 'data-inventario': row.inventario });
            JsonCommodity[4].required = row.serie;
            if (row.serie) {
                answer.data = answer.series;
                par = { op: 'T' };
                EndCallbackArticleSerie(JSON.stringify(par), answer);
            }
            else {
                $('div.divserie').hide();
                $('#cd_series').html('').selectpicker('refres');
            }
            $('#m_quantity').focus().select();
        }
    }
    else {
        toastr.warning(answer.Message, 'Sintesis ERP');
    }
}

function EndCallbackArticleLote(params, answer) {
    if (!answer.Error) {
        var body = $('#listlotes');
        var par = JSON.parse(params);
        body.html('');
        var totaltol = 0;
        $.each(answer.data, function (i, e) {
            var tr = $('<tr/>');
            var td1 = $('<td>' + e.lote + '</td>');
            var td2 = $('<td>' + e.existencia.Money() + '</td>');
            var td3 = $('<td/>');
            var input = null;
            totaltol += parseFloat(e.cantidad);
            if (par.op == 'T') {
                input = $('<input class="form-control inputlote" money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="0" data-v-max="' + e.existencia.toFixed(2) + '" data-id="' + e.id + '" value="' + e.cantidad + '"/>');
                input.change(function () {
                    var total = 0;
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
        TotalizarFactura(Data);
        $('#ModalLotes, #ModalSeries').modal('hide');
        window.tblcommodity.bootgrid('reload');
    }
    else {
        par = JSON.parse(params);
        $('.rowedit').val(par.oldvalue);
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}

function CallbackLoadSet(params, answer) {
    if (!answer.Error) {
        var options = "";
        $.each(answer.Table, function (i, e) {
            options += '<option  value="' + e.id + '" ' + ((e.selected) ? 'selected="true"' : '') + '>' + e.name + '</option > ';
        });

        $('#tipo_cartera').html(options).selectpicker('refresh');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}
function newFactura() {
    $('#btngrupo').hide();
    $('#btnPrint').show();
    $('#tbdpagos').empty();
    cleanpagocred();
    $('#opTipoFactura').val('T');
    $('#id_ctaant, #cd_cliente, #cd_vendedor').val('0');
    $('input.form-control, select').val('');
    $('[money]').val('0.00');
    $('#m_quantity').val('1.00');
    fieldsMoney();
    datepicker();
    $('.entradanumber').html('0');
    $('#btnSave, #btnCredit,#addarticle').removeAttr('disabled');
    $('#btnRev, #btnPrint').attr('disabled', 'disbled');
    $('#id_factura').val('0');
    $('#esFE').prop('checked', false).iCheck('enable')
    Data = {
        Tiva: 0,
        Tprecio: 0, Tdctoart: 0, Ttotal: 0, Tdesc: 0
    };
    $('#pagoCredito').hide();
    $('#pagoContado').hide();
    $('#tblpagos').hide();
    $('#ContenedorCuota').hide();
    var div = $('#diventrada');
    div.find('.divarticleadd').show();
    div.find('[money], .addarticle, select.selectpicker, .btnsearch, input.form-control, #btnSaveSeries').not('#nombre').removeAttr('disabled');
    div.find('select').selectpicker('refresh');
    TotalizarFactura(Data);
    var Parameter = {};
    MethodService("General", "GetConsecutivo", JSON.stringify(Parameter), "EndCallbackTempFactura");
}

function cleanpago() {
    $('#valorforma').val('$ 0.00');
    $('#id_forma').val('').selectpicker('refresh');
    $('#voucher').val('');
    var drDestroy = window.tblpagoscre.data('.rs.jquery.bootgrid');
    drDestroy.clear();
    $('#TCredito').text('$ 0.00');
}

function cleanpagocred() {
    $('#tbdcuotas').empty();
    $('#nrodias2').val('1');
    $('#id_tipoven').val('').selectpicker('refresh');

    var drDestroy = window.tblpagoscre.data('.rs.jquery.bootgrid');
    drDestroy.clear();
    $("#tblpagoscre").attr({ 'data-cuotas': 0, 'data-inicial': '', 'data-tipoven': 0, 'data-dias': 0 });
    $('#TCredito').text('$ 0.00');
}

function addCuota() {
    var valor = parseFloat(SetNumber($('#Ttotalfac').text())) - parseFloat(SetNumber($('#Tpagado').text()));
    if (validate(JsonPagosCre) && valor > 0) {
        var json = {};
        json.op = $("#SelectForma").val();
        json.SelectCredito = ($('#tipo_cartera').val().trim() == "") ? "0" : $('#tipo_cartera').val();
        json.dias = parseInt(SetNumber($('#nrodias2').val()));
        json.ven = ($('#id_tipoven').val().trim() == "") ? "0" : $('#id_tipoven').val();
        json.cuotas = SetNumber($('#nrocuotas2').val());
        json.inicial = SetDate($('#Text_FechaVenIni2').val());
        json.idToken = $('#idToken').val();
        json.valor = valor;
        $("#tblpagoscre").attr({ 'data-cuotas': json.cuotas, 'data-inicial': json.inicial, 'data-tipoven': json.ven, 'data-dias': json.dias });
        MethodService("Facturas", "FacturasRecalCuotas", JSON.stringify(json), "EndCallbackGetCuotasAcreditos");
    }
}

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

function EndCallbackRecalculo(Parameter, Result) {
    if (!Result.Error) {
        Data = Result.Row;
        par = JSON.parse(Parameter);
        if (par.op == 'C' && Data.anticipo == 0)
            $('#m_anticipo').attr({ 'data-v-max': 0, 'disabled': 'disabled' }).val('0.00').autoNumeric('init');
        else
            $('#m_anticipo').attr('data-v-max', Data.anticipo).val(Data.anticipo.Money()).removeAttr('disabled').autoNumeric('init');

        TotalizarFactura(Data);
    }
    else {
        toastr.error(Result.Message, 'Sintesis ERP');
    }
}

function EndCallbackTempFactura(Parameter, Result) {
    if (!Result.Error) {
        Data = Result.Value;
        $('#idToken').val(Data);
        window.tblcommodity.bootgrid('reload');
    }
    else {
        toastr.error(Result.Message, 'Sintesis ERP');
    }
}

function EndCallbackGet(Parameter, Result) {
    if (!Result.Error) {
        var row = Result.Row;
        $('#btnPrint').removeAttr('disabled');
        if (row.estado == 'PROCESADO') {
            $('#btnSave').attr('disabled', 'disabled');
        }
        else {
            $('#btnSave').attr('disabled', 'disabled');
        }

        if (row.pagoFinan != null) {
            $('#btngrupo').show();
            $('#btnPrint').hide();
        }
        else {
            $('#btnPrint').show();
            $('#btngrupo').hide();
        }
        $('#opTipoFactura').val('F');
        $('#id_factura').val(row.id);
        $('#idToken').val('0');
        $('.entradanumber').text(row.id);
        $('#cd_tipodoc').val(row.id_tipodoc);
        $('#SelectForma').val(row.FormaPago);
        $('#codigoccostos').val(row.centrocosto);
        $('#Text_Fecha').val(row.fechafac);
        $('#cd_cliente').val(row.id_cliente);
        $('#ds_cliente').val(row.cliente);
        $('#ds_vendedor').val(row.vendedor);
        $('#id_ctaant').val(row.id_ctaant);
        $('#ds_ctaant').val(row.cuentaant);
        $('#m_anticipo').val(row.valoranticipo.Money());
        $('#ds_ctadscto').val(row.CuentaDescuentoFin);//Modificado 28/01/2021
        $('#m_discountfin').val(row.dsctoFinanciero.Money());//Modificado 28/01/2021
        $('#cd_wineridef').val(row.id_bodega);
        $('#esFE').prop('checked', row.isfe).iCheck('disable');
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
        toastr.error(Result.Message, 'Sintesis ERP');
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
        $('#Text_Descuento, #m_discount').val('0');
        $('#v_code, #nombre').val('');
        $('#cd_iva,#cd_inc').val('').selectpicker('refresh');
        $('#m_precio, #m_discount, #Text_Descuento, #existencia').val('0.00');
        $('#addarticle').attr('data-id', 0);
        $('#m_quantity').val('1.00');
        Data = Result.Row;
        TotalizarFactura(Data);
        window.tblcommodity.bootgrid('reload');
        $('#v_code').focus();
        $('div.divserie').hide();
    }
    else {
        toastr.error(Result.Message, 'Sintesis ERP');
    }
}

function TotalizarFactura(Data) {
    $('#Tiva').text('$ ' + Data.Tiva.Money());
    $('#Tinc').text(Data.Tinc === undefined ? 0 : '$ ' + Data.Tinc.Money());
    $('#Ttventa').text('$ ' + Data.Tprecio.Money());
    $('#TdescArt').text('$ ' + Data.Tdctoart.Money());
    $('#Ttotal').text('$ ' + Data.Ttotal.Money());
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

function CallbackComodity(Parameter, Result) {
    $('#btnFact').button('reset');
    json = JSON.parse(Parameter);
    if (!Result.Error) {
        datos = Result.Row;
        if (datos.pagoFinan != null) {
            $('#btngrupo').show();
            $('#btnPrint').hide();
        } else {
            $('#btnPrint').show();
        }
        $('#opTipoFactura').val('F');
        $('.entradanumber').html(datos.id);
        $('#id_factura').val(datos.id);
        $('#idToken').val('0');
        $('#btnSave').attr('disabled', 'disabled');
        $('#btnPrint').removeAttr('disabled');
        $("#ModalFormas").modal('hide');
        var div = $('#diventrada');
        div.find('.divarticleadd').hide();
        div.find('[money], #addarticle, select.selectpicker, .btnsearch, input.form-control').attr('disabled', true);
        div.find('select').selectpicker('refresh');
        window.tblcommodity.bootgrid('reload');
        toastr.success('Factura Realizada.', 'Sintesis ERP');
    }
    else
        toastr.error(Result.Message, 'Sintesis ERP');
}

function EndCallbackGetCuotasAcreditos(Parameter, Result) {
    if (!Result.Error) {
        var par = JSON.parse(Parameter);
        $('#valorCuotacre').val('');
        $('#valorCuotacre').val(Result.Table[0].cuota.Money());
        var drDestroy = window.tblpagoscre.data('.rs.jquery.bootgrid');
        drDestroy.clear();
        drDestroy.append(Result.Table);
        $('#Tcambio').text('$ 0.00').removeClass('text-danger');
        $('#TCredito').text('$' + par.valor.Money());
    }
    else {
        toastr.error(Result.Message, 'Sintesis ERP');
    }
}

function SelecProducto(select) {
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

$(document).bind("keyup keydown", function (e) {
    if (e.ctrlKey && e.keyCode == 80) {
        if (!$('#btnPrint').is(':disabled') || $('#btnPrintt').is(':visible')) {
            var idfactura = $('#id_factura').val();
            param = 'id|' + idfactura + ';'
            PrintDocument(param, 'MOVFACTURASFE', 'CODE');
        }
        return false;
    }
    else if (e.ctrlKey && e.keyCode == 83) {
        LoadSave();
        return false;
    }
});