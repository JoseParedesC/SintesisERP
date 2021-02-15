var JsonValidate = [
    { id: 'Text_Fecha', type: 'DATE', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'cd_tipodoc', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
    { id: 'codigoccostos', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'ds_vendedor', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'ds_cliente', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'cd_formapagos', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' }];


var JsonCommodity = [
    { id: 'v_code', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'nombre', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'm_quantity', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'm_precio', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];

var JsonPagos = [
    { id: 'id_forma', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'voucher', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' }];


var JsonPagosCre = [
    { id: 'nrocuotas2', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'Text_FechaVenIni2', type: 'DATE', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'id_tipoven', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
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
                'class': "FacturasRecurrentes",
                'method': 'FacturasRecurrItemList'
            };
        },
        url: window.appPath + "/Pages/Connectors/ConnectorList.ashx", //conecta los metodos con los controladores*/       
        columnSelection: false,
        formatters: {
            "delete": function (column, row) {
                if ($('#opTipoFactura').val() == 'T')
                    return "<a class=\"action command-delete\" data-row-id=\"" + row.id + "\"><span class=\"fa fa-2x fa-trash-o text-danger iconfa\"></span></a>";
                if ($('#mostrarIcon').val() == 'K')
                    return "<a class=\"action command-deleteEditar\" data-row-id=\"" + row.id + "\"><span class=\"fa fa-2x fa-trash-o text-danger iconfa\"></span></a>";
            },
            "total": function (column, row) {
                return row.total.Money();
            },

            "precio": function (column, row) {
                return "<span class='tdedit action command-edit' data-column='precio' data-value='" + row.precio + "' data-id='" + row.id + "'>" + row.precio.Money(); + "</span>";
            },
            "cantidad": function (column, row) {
                return "<span class='tdedit action command-edit' data-column='cantidad' data-value='" + row.cantidad + "' data-id='" + row.id + "'>" + row.cantidad.Money(); + "</span>";

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

        }).end().find(".command-deleteEditar").on("click", function (e) {
            id = $(this).data("row-id");
            params = {};
            params.id_articulo = id;
            params.idToken = $('#idToken').val();
            params.id_anticipo = 0;
            MethodService("FacturasRecurrentes", "FacturasRecurrenteDelArticulo", JSON.stringify(params), 'EndCallbackupdate');
            
        }).end().find(".command-edit").on("dblclick", function (e) {
            if ($('#edittable').val() != 'N') {
                params = {};
                $(this).hide();
                data = $(this).data();
                tr = $(this).closest('td');
                input = $('<input  class="form-control rowedit" data-oldvalue="' + data.value + '" data-column="' + data.column + '" data-id="' + data.id + '" value="' + data.value + '" money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="0.01" data-v-max="999999999.99">');
                input.blur(function () {
                    var row = $(this).data();
                    newvalue = $(this).val();
                    oldvalue = $(this).data('oldvalue');
                    if (SetNumber(newvalue) != oldvalue) {
                        params = {};
                        params.id = row.id;
                        params.column = row.column;
                        params.value = SetNumber(newvalue);
                        MethodService("FacturasRecurrentes", "ServicioSetRecurrente", JSON.stringify(params), 'EndCallbackupdate');
                    }
                    else {
                        tr = $(this).closest('td');
                        tr.find('span.tdedit').html(oldvalue.Money()).show();
                        $(this).remove();
                    }
                });
                input.autoNumeric('init');
                tr.find('span.tdedit').hide();
                tr.append(input);
                input.focus().select();
            }
        });
    });

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

    newFactura();

    $('#v_code').autocomplete({
        serviceUrl: window.appPath + "/Pages/Connectors/Connector.ashx",
        type: 'post',
        datatype: 'json',
        paramName: 'keyword',
        params: { 'class': 'Productos', method: 'ServiciosBuscador' },
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

    $('#cd_tipodoc').change(function () {
        if ($("#id_factura").val() == '0') {
            var valores = $(this).find('option:selected').attr('data-centro');
            var split = valores.split('|~|');
            $('#id_ccostos').val(split[1]);
            $('#codigoccostos').val(split[2]);
            JsonValidate[1].required = (split[0] == '1') ? true : false;
        }
    });
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
                        'class': 'FacturasRecurrentes',
                        'method': 'FacturasRecurrList'
                    };
                },
                url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
                formatters: {
                    "edit": function (column, row) {
                        return "<a class=\"action command-edit\" data-row-id=\"" + row.id + "\"><span class=\"fa-2x fa fa-eye iconfa\"></span></a>";
                    },

                    "editar": function (column, row) {
                        return "<a class=\"action command-editar\" data-row-id=\"" + row.id + "\"><span class=\"fa-2x fa fa-pencil iconfa\"></span></a>";
                    },

                    "factu": function (column, row) {
                        return "<input type='checkbox' value=" + row.id + " name='facrecu'/>";
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
                    MethodService("FacturasRecurrentes", "FacturasRecurrGet", JSON.stringify(params), 'EndCallbackGet');
                });

                window.gridfacturas.find(".command-editar").on("click", function (e) {
                    id = $(this).data("row-id")
                    params = {};
                    params.id = id;
                    params.idtemp = "0";
                    params.op = '';
                    MethodService("FacturasRecurrentes", "FacturasRecurrGet", JSON.stringify(params), 'EndCallbackGetEditar');
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
                MethodService("FacturasRecurrentes", "RevertirFactura", JSON.stringify(sJon), "CallbackReversion");
            }
        }
    });

    $('#addarticle').click(function () {
        var idarticle = $('#addarticle').attr('data-id');
        if (validate(JsonCommodity)) {
            var Parameter = {};
            Parameter.idToken = $('#idToken').val();
            Parameter.id_bodega = 0;
            Parameter.id_article = idarticle;
            Parameter.quantity = SetNumber($('#m_quantity').val());
            Parameter.precio = SetNumber($('#m_precio').val());
            Parameter.porcendsc = SetNumber($('#Text_Descuento').val());
            Parameter.descuento = SetNumber($('#m_discount').val());
            Parameter.lote = ($('#divaddart').attr('data-lote') == 'true') ? true : false;
            Parameter.serie = ($('#divaddart').attr('data-serie') == 'true') ? true : false;
            Parameter.series = setMultiSelect('cd_series');
            Parameter.inventarial = ($('#divaddart').attr('data-inventario') == 'true') ? true : false;
            Parameter.anticipo = 0;
            if (!Parameter.serie || ($('#cd_series').val() != null && $('#cd_series').val().length == Parameter.quantity))
                MethodService("Facturas", "FacturasAddArticulo", JSON.stringify(Parameter), "EndCallbackAddArticle");
            else
                toastr.warning('La cantidad de series seleccionadas no es la misma que la que desea agregar.', 'Sintesis ERP');
        }
    });

    $('#btnnew').click(function () {

        newFactura();
    });

    $('#btnFactu').click(function () {
        if (validate(JsonValidate)) {
            if (window.tblcommodity.bootgrid("getTotalRowCount") > 0) {
                var sJon = {};
                sJon.id = $('#id_factura').val();
                sJon.id_tipodoc = $('#cd_tipodoc').val();
                sJon.id_centrocostos = ($('#id_ccostos').val().trim() == "") ? "0" : $('#id_ccostos').val();
                sJon.cd_formapagos = $('#cd_formapagos').val();
                sJon.Fecha = $('#Text_Fecha').val();
                sJon.id_tercero = $('#cd_cliente').val();
                sJon.id_vendedor = $('#cd_vendedor').val();
                sJon.idToken = $('#idToken').val();
                $('#btnFactu').button('loading');
                MethodService("FacturasRecurrentes", "FacturasRecurrente", JSON.stringify(sJon), "CallbackComodity");

            } else
                toastr.warning("No ha agregado ningun producto.", 'Sintesis ERP');


        }
        else {
            toastr.warning("No ha agregado ningun servicio o concepto.", 'Sintesis ERP');
        }
    });

    $('#btnguardar').click(function () {

        var sJonn = {};
        var selected = '';
        $('input[name=facrecu]').each(function () {
            if (this.checked) {
                selected += $(this).val() + ', ';
            }
        });
        if (selected == "") {
            toastr.warning("No ha seleccionado ninguna factura recurrente.", 'Sintesis ERP');
        } else {
            sJonn.facturaSelect = selected;
            $('#btnguardar').button('loading');
            MethodService("FacturasRecurrentes", "MovFacturasSave", JSON.stringify(sJonn), "CallbackComodity");
        }

    });

    $('#btnAcred').click(function () {
        $('#pagoCredito').toggle();
        $('#pagoContado').toggle();
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

function RecalcularFactura(elemento) {
    var Parameter = {};
    Parameter.idToken = $('#idToken').val();
    Parameter.anticipo = 0;
    Parameter.id_cta = 0;
    Parameter.id_cliente = ($('#cd_cliente').val() == '' ? '0' : $('#cd_cliente').val());
    Parameter.fecha = SetDate($('#Text_Fecha').val());
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
    MethodService("FacturasRecurrentes", "FacturasBuscadorSerieLote", JSON.stringify(params), callback);
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
    MethodService("FacturasRecurrentes", "FacturaSetArticulo", JSON.stringify(params), callback);
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
            $('#Text_Descuento').val(row.pordcto.Money()).trigger('blur');
            $('#divaddart select').selectpicker('refresh');
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
    cleanpagocred();
    $('#opTipoFactura').val('T');
    $('#id_ctaant, #cd_cliente, #cd_vendedor').val('0');
    $('input.form-control, select').val('');
    $('[money]').val('0.00');
    $('#m_quantity').val('1.00');
    fieldsMoney();
    datepicker();
    $('.entradanumber').html('0');
    $('#btnFactu, #btnCredit,#addarticle').removeAttr('disabled');
    $('#btnRev, #btnPrint').attr('disabled', 'disbled');
    $('#id_factura').val('0');
    $('#esFE').prop('checked', false).iCheck('enable')
    Data = {
        Tiva: 0,
        Tprecio: 0, Tdctoart: 0, Ttotal: 0, Tdesc: 0
    };
    $('#pagoCredito').hide();
    $('#pagoContado').show();
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
    $('#nrocuotas2').val('0.00');
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
        json.dias = parseInt(SetNumber($('#nrodias2').val()));
        json.ven = $('#id_tipoven').val();
        json.cuotas = SetNumber($('#nrocuotas2').val());
        json.inicial = SetDate($('#Text_FechaVenIni2').val());
        json.idToken = $('#idToken').val();
        json.valor = valor;
        $("#tblpagoscre").attr({ 'data-cuotas': json.cuotas, 'data-inicial': json.inicial, 'data-tipoven': json.ven, 'data-dias': json.dias });
        MethodService("Facturas", "FacturasRecalCuotas", JSON.stringify(json), "EndCallbackGetCuotas");
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

function EndCallbackGetEditar(Parameter, Result) {
    if (!Result.Error) {
        var row = Result.Row;
        $('#btnFactu').removeAttr('disabled');
        $('#mostrarIcon').val('K');
        $('#opTipoFactura').val('F');
        $('#edittable').val('T');
        $('#id_factura').val(row.id);
        $('#idToken').val(row.id);
        $('.entradanumber').text(row.id);
        $('#cd_tipodoc').val(row.id_tipodoc);
        $('#codigoccostos').val(row.centrocosto);
        $('#Text_Fecha').val(row.fechafac);
        $('#cd_cliente').val(row.id_cliente);
        $('#ds_cliente').val(row.cliente);
        $('#ds_vendedor').val(row.vendedor);
        $('#cd_vendedor').val(row.id_vendedor);
        $('#cd_formapagos').val(row.id_formapagos);
        $('#id_ctaant').val(row.id_ctaant);
        $('#ds_ctaant').val(row.cuentaant);
        $('#m_anticipo').val(row.valoranticipo.Money());
        $('#cd_wineridef').val(row.id_bodega);
        $('#esFE').prop('checked', row.isfe).iCheck('disable');
        var div = $('#diventrada');
        div.find('.divarticleadd').show();
        div.find('[money], .addarticle, select.selectpicker, .btnsearch, input.form-control, textarea').not('.search-field').attr('disabled', false);
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

function EndCallbackGet(Parameter, Result) {
    if (!Result.Error) {
        var row = Result.Row;

        if (row.estado == 'TEMPORAL') {
            $('#btnFactu').attr('disabled', 'disabled');
            $('#addarticle').removeAttr('disabled');
        }
        else {
            $('#btnFactu').attr('disabled', 'disabled');
            $('#addarticle').removeAttr('disabled');
        }

        $('#mostrarIcon').val('F');
        $('#opTipoFactura').val('F');
        $('#id_factura').val(row.id);
        $('#idToken').val(row.id);
        $('.entradanumber').text(row.id);
        $('#cd_tipodoc').val(row.id_tipodoc);
        $('#codigoccostos').val(row.centrocosto);
        $('#Text_Fecha').val(row.fechafac);
        $('#cd_cliente').val(row.id_cliente);
        $('#ds_cliente').val(row.cliente);
        $('#ds_vendedor').val(row.vendedor);
        $('#cd_vendedor').val(row.id_vendedor);
        $('#cd_formapagos').val(row.id_formapagos);
        $('#id_ctaant').val(row.id_ctaant);
        $('#ds_ctaant').val(row.cuentaant);
        $('#m_anticipo').val(row.valoranticipo.Money());
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
    $('#btnFactu').removeAttr('disabled');
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
    $('#btnFactu').button('reset');
    $('#btnguardar').button('reset');
    json = JSON.parse(Parameter);
    if (!Result.Error) {
        datos = Result.Row;
        $('#opTipoFactura').val('F');
        $('.entradanumber').html(datos.id);
        $('#id_factura').val(datos.id);
        $('#idToken').val('0');
        $('#btnFactu').attr('disabled', 'disabled');
        $('#btnPrint').removeAttr('disabled');
        $("#ModalFacturas").modal('hide');
        var div = $('#diventrada');
        div.find('.divarticleadd').hide();
        div.find('[money], #addarticle, select.selectpicker, .btnsearch, input.form-control').attr('disabled', true);
        div.find('select').selectpicker('refresh');
        window.tblcommodity.bootgrid('reload');
        newFactura();
        toastr.success('Factura Realizada.', 'Sintesis ERP');
    }
    else
        toastr.error(Result.Message, 'Sintesis ERP');
}

function EndCallbackGetCuotas(Parameter, Result) {
    if (!Result.Error) {
        var par = JSON.parse(Parameter);
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
