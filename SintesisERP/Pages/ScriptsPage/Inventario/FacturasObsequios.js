var JsonValidate = [
    { id: 'Text_Fecha', type: 'DATE', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'cd_tipodoc', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
    { id: 'codigoccostos', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'ds_vendedor', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'ds_cliente', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'ds_ctaobs', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'id_ctaobs', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'ds_bod', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];

var JsonCommodity = [
    { id: 'v_code', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'nombre', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'existencia', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'm_quantity', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'm_costo', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'm_precio', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'cd_series', type: 'TEXT', htmltype: 'SELECT', required: false, depends: false, iddepends: '' },
    { id: 'cd_wineridef', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
    { id: 'ds_bod', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];

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
            "costo": function (column, row) {
                return row.costo.Money();
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


    $('#cd_tipodoc').change(function () {
        if ($("#id_factura").val() == '0') {
            var valores = $(this).find('option:selected').attr('data-centro');
            var split = valores.split('|~|');
            $('#id_ccostos').val(split[1]);
            $('#codigoccostos').val(split[2]);
            JsonValidate[1].required = (split[0] == '1') ? true : false;
        }
    });

    newFactura();
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
                        'method': 'FacturasListObsequio'
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
                    params.idtemp = "0";
                    params.op = '';
                    MethodService("Facturas", "FacturasGet", JSON.stringify(params), 'EndCallbackGet');
                })
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

    $('#m_quantity').on('keyup', function () {
        $('#hidden_quantity').val($(this).val());
    });

    $('#addarticle').click(function () {
        var idarticle = $('#addarticle').attr('data-id');
        if (validate(JsonCommodity)) {
            var Parameter = {};
            Parameter.idToken = $('#idToken').val();
            Parameter.id_bodega = ($('#addarticle').attr('data-idbodega') == '') ? '0' : $('#addarticle').attr('data-idbodega');
            Parameter.id_article = idarticle;
            Parameter.quantity = SetNumber($('#m_quantity').val());
            Parameter.precio = SetNumber($('#m_costo').val());
            Parameter.precioobs = SetNumber($('#m_precio').val());
            Parameter.porcendsc = 0;
            Parameter.descuento = 0;
            Parameter.lote = ($('#divaddart').attr('data-lote') == 'true') ? true : false;
            Parameter.serie = ($('#divaddart').attr('data-serie') == 'true') ? true : false;
            Parameter.series = setMultiSelect('cd_series');
            Parameter.inventarial = ($('#divaddart').attr('data-inventario') == 'true') ? true : false;
            Parameter.anticipo = 0;
            if (!Parameter.serie || ($('#cd_series').val() != null && $('#cd_series').val().length == Parameter.quantity))
                MethodService("Facturas", "FacturasAddArticulo", JSON.stringify(Parameter), "EndCallbackAddArticle");
            else
                toastr.warning('La cantidad de series seleccionadas no es la misma que la que desea agregar.', 'Sintesis ERP');
        } else {
            toastr.error('Hay campos requeridos vacíos o iguales a 0', 'Sintesis ERP');
        }
    });

    $('#btnSaveSeries').click(function () {
        if ($('#opTipoFactura').val() == 'T') {
            var serie = ($('#divaddart').attr('data-serie') == 'true') ? true : false;
            var quantity = SetNumber($('#hidden_quantity').val());

            if (!serie || ($('#setseries').val() != null && $('#setseries').val().length == quantity)) {
                id = $(this).attr('data-id');
                value = setMultiSelect('setseries');
                SetCalueColumn(id, 'SERIE', 0, value, '', '', 'EndCallbackSaveLote');
            }
            else
                toastr.warning('La cantidad de series seleccionadas no es la misma que la que desea agregar.', 'Sintesis ERP');
        }
        else
            $('#ModalSeries').modal('hide');
    });

    $('#btnPrint').click(function () {
        var idfactura = $('#id_factura').val();
        param = 'id|' + idfactura + ';'
        PrintDocument(param, 'MOVFACTURASFE', 'CODE');
    });


    $('#btnnew').click(function () {
        newFactura();
    });

    $('#btnCance, #btncancemodal').click(function () {
        $('#valorCuotacre, #nrocuotas2').val('');
        $('#tblpagos').hide();
        $('#tipo_cartera').val('').selectpicker('refresh');
        $('#pagoContado, #ContenedorCuota, #pagoLineasCredi, #pagoCredito, #tblpagos').hide();
    });

    $('#DetalleCuota').click(function () {
        $('#ContenedorCuota').toggle();
        $('#CuotaCredi').toggle();
    });


    $('#btnSave').on('click', function () {
        if (validate(JsonValidate)) {
            if (window.tblcommodity.bootgrid("getTotalRowCount") > 0) {
                var sJon = {};
                sJon.id_centrocostos = ($('#id_ccostos').val().trim() == "") ? "0" : $('#id_ccostos').val();
                sJon.Fecha = SetDate($('#Text_Fecha').val());
                sJon.id_tipodoc = $('#cd_tipodoc').val();
                sJon.id_tercero = $('#cd_cliente').val();
                sJon.id_ctaobs = ($('#id_ctaobs').val().trim() == "") ? "0" : $('#id_ctaobs').val();
                sJon.anticipo = 0;
                sJon.idToken = $('#idToken').val();
                sJon.id_vendedor = $('#cd_vendedor').val();
                sJon.totalpago = SetNumber($('#Ttotal').text());
                sJon.idToken = $('#idToken').val();

                $('#formadepago').attr('data-price', SetNumber($('#Ttotal').text()));
                sJon.forma = Getxmlforma();

                MethodService("Facturas", "FacturarFacturaObs", JSON.stringify(sJon), "CallbackComodity");
            }
            else
                toastr.warning("No ha agregado ningun artículo o concepto.", 'Sintesis ERP');
        }

    });

    //$('#Text_Fecha').on("dp.change", function (e) {
    //    var newdate = (e.date == null) ? '' : $(this).val();
    //    var olddate = (e.oldDate == null) ? newdate : e.oldDate._i;
    //    //if (newdate != olddate)
    //    //    RecalcularFactura($(this))
    //});
});

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
    params.anticipo = 0;
    params.obs = 'JP';
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
            $('#m_costo').val(row.costo.Money());
            $('#existencia').val(row.existencia.Money());
            $('#Text_Descuento').val(row.pordcto.Money()).trigger('blur');
            $('#divaddart select').selectpicker('refresh');
            $('#divaddart').attr({ 'data-serie': row.serie, 'data-lote': row.lote, 'data-inventario': row.inventario });
            JsonCommodity[5].required = row.serie;
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

function newFactura() {
    $('#tbdpagos').empty();
    $('#opTipoFactura').val('T');
    $('#id_ctaobs, #cd_cliente, #cd_vendedor').val('0');
    var inputs = $('input.form-control');
    $.each(inputs, function () {
        ($(this).attr('data-id') == 0 | $(this).attr('data-id') == undefined ? $(this).val('') : '');
    });
    $('select').val('');
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
    $('#TCredito').text('$ 0.00');
}

function Getxmlforma() {
    var xml = "";
    trs = $('#formadepago');
    xml += '<item idforma="' + trs.attr('data-id') + '" vouch="' + trs.attr('data-voucher') + '" valor="' + trs.attr('data-price') + '" />'
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
        $('#btnSave').attr('disabled', 'disabled');

        $('#opTipoFactura').val('F');
        $('#id_factura').val(row.id);
        $('#idToken').val('0');
        $('.entradanumber').text(row.id);
        $('#cd_tipodoc').val(row.id_tipodoc);
        $('#codigoccostos').val(row.centrocosto);
        $('#Text_Fecha').val(row.fechafac);
        $('#cd_cliente').val(row.id_cliente);
        $('#ds_cliente').val(row.cliente);
        $('#ds_vendedor').val(row.vendedor);
        $('#id_ctaobs').val(row.id_ctaobs);
        $('#ds_ctaobs').val(row.cuentaant);
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
        $('#m_costo,#m_precio, #m_discount, #Text_Descuento, #existencia').val('0.00');
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

function RecalcularPagos(totalpago) {
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
    json = JSON.parse(Parameter);
    if (!Result.Error) {
        datos = Result.answer;
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

function EndCallbackGetCuotas(Parameter, Result) {
    if (!Result.Error) {
        var par = JSON.parse(Parameter);
        $('#valorCuotacre').val('');
        $('#valorCuotacre').val(Result.Table[0].cuota.Money());
        $('#Tcambio').text('$ 0.00').removeClass('text-danger');
        $('#TCredito').text('$' + par.valor.Money());
    }
    else {
        toastr.error(Result.Message, 'Sintesis ERP');
    }
}

function EndCallbackGetCuotasAcreditos(Parameter, Result) {
    if (!Result.Error) {
        var par = JSON.parse(Parameter);
        $('#valorCuotacre').val('');
        $('#valorCuotacre').val(Result.Table[0].cuota.Money());
        drDestroy.append(Result.Table);
        $('#Tcambio').text('$ 0.00').removeClass('text-danger');
        $('#TCredito').text('$' + par.valor.Money());
    }
}

function SelecProducto(select) {
    if ($('#ds_bod').val() != '' )
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