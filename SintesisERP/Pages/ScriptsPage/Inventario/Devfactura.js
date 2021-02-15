
var JsonValidate = [{ id: 'Text_Fecha', type: 'DATE', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];

var JsonCommodity = [{ id: 'v_presen', type: 'WHOLE', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
{ id: 'm_quantity', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];


window.tblcommodity = null;
window.gridfacturas;
$(document).ready(function () {

    window.tblcommodity = $("#tblcommodity").bootgrid({
        ajax: true,
        post: function () {
            return {
                'params': function () {
                    var param = {};
                    param.id_factura = $('#idToken').val();
                    param.opcion = $('#opTipoFactura').val();
                    param.id_fac = $('#id_devfactura').val();
                    return JSON.stringify(param);
                },
                'class': 'Facturas',
                'method': 'FacturasItemList'
            };
        },
        url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
        formatters: {
            "select": function (column, row) {
                if ($('#opTipoFactura').val() == 'T') return '<div class="check-mail"><input type="checkbox" ' + ((row.selected) ? 'checked="checked"' : '') + ' data-id="' + row.id + '" class="i-checks pull-right command-selected" ' + ((row.isfinanciero != 0) ? 'disabled' : '') + '  /></div>';
            },
            "cantidad": function (column, row) {
                if ($('#opTipoFactura').val() == 'T' && !row.serie && !row.lote && row.isfinanciero == 0)
                    return "<span class='tdedit action command-edit text-danger' data-type='numeric' data-column='cantidad' data-min='1' data-max='" + row.cantidad + "' data-simbol='' data-cantidad='" + row.cantidad.toFixed(2) + "' data-value='" + row.cantidaddev.toFixed(2) + "' data-id='" + row.id + "'>" + row.cantidaddev.Money() + "</span>";
                else
                    return row.cantidaddev.Money();
            },
            "serie": function (column, row) {
                return (row.serie) ? "<span class='tdedit action command-serie fa fa-2x fa-pencil text-info' data-column='serie'  data-count='" + row.cantidad + "' data-id='" + row.id + "'></span>" : '';
            },
            "lote": function (column, row) {
                return (!row.serie && row.lote) ? "<span class='tdedit action command-lote fa fa-2x fa-pencil text-error' data-column='lote'  data-count='" + row.cantidad + "' data-id='" + row.id + "'></span>" : '';
            },
            "valor": function (column, row) {
                return row[column.id].Money();
            }
        }
    }).on("loaded.rs.jquery.bootgrid", function () {
        window.tblcommodity.find(".command-serie").on("click", function (e) {
            var check = ($(this).closest('tr').find('input.command-selected').prop('checked') || ($('#opTipoFactura').val() == 'D'));
            if (check) {
                id = $(this).data("id");
                params = {};
                params.id_articulo = id;
                params.count = $(this).attr('data-count');
                params.op = $('#opTipoFactura').val();

                if ($('#opTipoFactura').val() == 'T') {
                    MethodService("Facturas", "FacturasGetSeriesTemp", JSON.stringify(params), 'EndCallbackGetSeries');
                }
                else {
                    params.id_factura = '';
                    params.opcion = 'SF';
                    params.op = 'D';
                    params.proceso = '';
                    MethodService("Facturas", "FacturasBuscadorSerieLote", JSON.stringify(params), 'EndCallbackArticleSerie');
                }
            }
        });

        $('#tblcommodity .i-checks').iCheck({
            checkboxClass: 'icheckbox_square-green',
            radioClass: 'iradio_square-green',
        });


        // Executes after data is loaded and rendered 
        if ($('#opTipoFactura').val() == 'T') {

            window.tblcommodity.find('#allcheck').on("ifChanged", function (e) {
                var valu = $(this).prop('checked') ? 1 : 0;
                SetCalueColumn(0, 'ALLSELECTED', valu, 0, 'D', '', 'EndCallbackSaveLote');
            });

            window.tblcommodity.find('.command-lote').on("click", function (e) {
                var check = ($(this).closest('tr').find('input.command-selected').prop('checked') || ($('#opTipoFactura').val() == 'D'));
                if (check) {
                    id = $(this).data("id");
                    CallSearchLoteSerie(id, 0, 'LF', $('#opTipoFactura').val(), 'EndCallbackArticleLote');
                }
            });

            window.tblcommodity.find(".command-selected").on("ifChanged", function (e) {
                id = $(this).attr("data-id");
                var valuech = ($(this).prop('checked')) ? 1 : 0;
                SetCalueColumn(id, 'SELECTED', valuech, 0, 'D', '', 'EndCallbackSaveLote');
            }).end().find(".command-edit").on("dblclick", function (e) {
                var check = $(this).closest('tr').find('input.command-selected').prop('checked');
                if (check) {
                    params = {};
                    $(this).hide();
                    data = $(this).data();
                    tr = $(this).closest('td');
                    max = $(this).attr('data-max');
                    min = $(this).attr('data-min');
                    cant = $(this).attr('data-cantidad');
                    input = $('<input class="form-control rowedit" date-type="numeric" data-cantidad="' + cant + '" data-oldvalue="' + data.value + '" data-column="' + data.column + '" data-id="' + data.id + '" value="' + data.value + '" money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="' + min + '" data-v-max="' + max + '">');
                    input.autoNumeric('init');
                    input.blur(function () {
                        var row = $(this).data();
                        newvalue = $(this).val();
                        oldvalue = $(this).attr('data-oldvalue');
                        cantid = $(this).attr('data-cantidad');
                        type = $(this).attr('date-type');
                        if (SetNumber(newvalue) != oldvalue && parseFloat(newvalue) <= parseFloat(cantid)) {
                            SetCalueColumn(row.id, 'CANTIDAD', SetNumber(newvalue), oldvalue, 'D', '', 'EndCallbackSaveLote');
                        }
                        else {
                            if (SetNumber(newvalue) > SetNumber(cantid))
                                toastr.warning('No puede devolver una cantidad mayor a la de la disponible.', 'Sintesis ERP');
                            tr = $(this).closest('td');
                            var ret = parseFloat(oldvalue).Money();
                            tr.find('.tdedit').html(ret).show();
                            $(this).remove();
                        }
                    });
                    tr.find('.tdedit').hide();
                    tr.append(input);
                    input.focus().select();
                }
            });
        }
    });

    newDevFactura();

    $('#btnList').click(function () {
        if (window.gridfacturas === undefined) {
            window.gridfacturas = $("#tblfacturas").bootgrid({
                ajax: true,
                post: function () {
                    return {
                        'params': "",
                        'class': 'Devoluciones',
                        'method': 'FacturarDevList'
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
                    MethodService("Devoluciones", "FacturasDevGet", JSON.stringify(params), 'EndCallbackGet');
                })
            });
        }
        else
            window.gridfacturas.bootgrid('reload');

        $('#ModalFacturas').modal({ backdrop: 'static', keyboard: false }, "show");
    });

    $('#btnRev').click(function () {
        if (validate(JsonValidate)) {
            if ($('#id_devfactura').val() != '0' && $('#id_devfactura').val().trim() != '') {
                if (confirm("Desea revertir la devolución?")) {
                    var sJon = {};
                    sJon.id = $('#id_devfactura').val();
                    sJon.fecha = SetDate($('#Text_Fecha').val());
                    MethodService("Devoluciones", "RevertirDevFactura", JSON.stringify(sJon), "CallbackReversion");
                }
            }
        }
    });

    $('#addarticle').click(function () {
        var idarticle = $('#v_presen').val();
        if (validate(JsonCommodity)) {
            var Parameter = {};
            Parameter.idToken = $('#idToken').val();
            Parameter.id_article = idarticle;
            Parameter.quantity = SetNumber($('#m_quantity').val());
            Parameter.id_factura = SetNumber($('#cd_factura').val());
            MethodService("Devoluciones", "DevFacturaAddArticulo", JSON.stringify(Parameter), "EndCallbackAddArticle");
        }
    });

    $('#btnPrint').click(function () {
        var idfactura = $('#id_devfactura').val();
        param = 'id|' + idfactura + ';'
        PrintDocument(param, 'DEVOLFACTURA', 'CODE');
    });

    $('#btnnew').click(function () {
        newDevFactura();

    });

    $('#btnSave').click(function () {
        if (validate(JsonValidate)) {
            if (window.tblcommodity.bootgrid("getTotalRowCount") > 0) {
                sJon = {};
                sJon.id = ($('#id_devfactura').val().trim() == "") ? "0" : $('#id_devfactura').val();
                sJon.fecha = SetDate($('#Text_Fecha').val());
                sJon.id_factura = $("#cd_factura").val();
                sJon.idToken = $('#idToken').val();
                $('#btnSave').button('loading');
                MethodService("Devoluciones", "FacturarDevFactura", JSON.stringify(sJon), "CallbackComodity");
            }
            else
                toastr.warning("No ha agregado ningun artículo ó ningun concepto.", 'Sintesis ERP');
        }
    });

    $('#cd_factura').change(function () {
        id = $(this).val();
        if (id != '0' && id != '') {
            params = {};
            params.id = (id == '') ? "0" : id;
            params.idtemp = ($('#idToken').val() != "") ? $('#idToken').val() : "0";
            params.op = 'D';
            MethodService("Facturas", "FacturasGet", JSON.stringify(params), 'EndCallbackGetFac');
        }
        else
            cleanform();
    });

    $('#btnSaveSeries').click(function () {
        series = '';
        var len = $("#listtreeccostos input:checked").length;
        if (len > 0) {
            $.each($("#listtreeccostos input:checked"), function (e, i) {
                series += $(i).attr('data-id') + ',';
            });
        }
        params = {};
        params.id = $(this).attr('data-id');
        params.id_factura = $('#idToken').val();
        params.value = 0;
        params.column = 'SERIE';
        params.extravalue = series;
        params.op = 'D';
        params.xml = '<items></items>';
        params.anticipo = 0;
        var btn = $(this);
        btn.button('loading');
        MethodService("Facturas", "FacturaSetArticulo", JSON.stringify(params), 'EndCallbackupdate');
    });

    $('#btnSaveLotes').click(function () {
        if ($('#opTipoFactura').val() == 'T') {
            id = $(this).attr('data-id');
            xml = '';
            $.each($('input.inputlote'), function (i, e) {
                element = $(e);
                xml += '<item idlote="' + element.attr('data-id') + '" cant="' + SetNumber(element.val()) + '" />>'
            })
            SetCalueColumn(id, 'LOTE', 0, '', 'D', xml, 'EndCallbackSaveLote');
        }
        else
            $('#ModalLotes, #ModalSeries').modal('hide');
    });
});

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
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}

function loadpresentation(v_code) {
    params = {};
    params.filtro = v_code;
    params.option = 'P';
    params.op = 'FA';
    params.id = $('#cd_factura').val();
    params.id_bodega = "0";
    MethodService("Devoluciones", "ArticulosDevBuscador", JSON.stringify(params), "EndCallbackArticle");
}

function EndCallbackArticleSerie(params, answer) {
    par = JSON.parse(params);
    if (!answer.Error) {
        table = answer.data;
        $('#listtreeccostos').html('');
        $('#btnSaveSeries').attr('data-id', par.id_articulo);
        var count = table.length;
        for (i = 0; i < count; i++) {
            var value = table[i].serie;
            var subdiv = $('<div class="check-mail pull-right"></div>');
            var div = $('<div class="list-group-item"/>').append(subdiv, value);
            $('#listtreeccostos').append(div);
        }

        $('#ModalSeries').modal({ backdrop: 'static', keyboard: false }, 'show');
    }
    else {
        toastr.warning(answer.Message, 'Sintesis ERP');
        $('#cd_series').html('').selectpicker('refres');
    }
    if (par.op == 'T')
        $('div.divserie').show();
}

function CallSearchLoteSerie(id_articulo, id_bodega, opcion, op, callback) {
    params = {};
    params.id_articulo = id_articulo;
    params.id_bodega = id_bodega;
    params.opcion = opcion;
    params.op = op;
    params.id_factura = $('#idToken').val();
    params.proceso = 'D';
    $('#btnSaveLotes').attr('data-id', id_articulo)
    MethodService("Facturas", "FacturasBuscadorSerieLote", JSON.stringify(params), callback);
}
function EndCallbackArticle(params, answer) {
    if (!answer.Error) {
        var options = "";
        $.each(answer.data, function (i, e) {
            options += '<option data-price="' + e.cantidad + '" value="' + e.id + '" ' + ((i == 0) ? 'selected="selected"' : '') + '>' + e.name + '</option>';
        });
        $('#v_presen').html(options).selectpicker('refresh');
        if (answer.data.length == 1) {
            $('#m_quantity').focus().select();
            val = $('#v_presen option:selected').attr('data-price');
            value = Number(val).Money();
            $('#existencia').val(value);
        }
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}
function EndCallbackGetSeries(params, answer) {
    if (!answer.Error) {
        par = JSON.parse(params);
        table = answer.Table;
        $('#listtreeccostos').html('');
        $('#btnSaveSeries').attr('data-id', par.id_articulo);
        var count = table.length;
        for (i = 0; i < count; i++) {
            var value = table[i].serie;
            var subdiv = $('<div class="check-mail pull-right"><input type="checkbox" ' + ((table[i].selected) ? 'checked="checked"' : '') + ' data-id="' + table[i].id + '" class="i-checks pull-right"  /></div>');
            var div = $('<div class="list-group-item"/>').append(subdiv, value);
            $('#listtreeccostos').append(div);
        }

        $('#ModalSeries').modal({ backdrop: 'static', keyboard: false }, 'show');
    }
    else {
        toastr.warning(answer.Message, 'Sintesis ERP');
    }
}

function newDevFactura() {
    cleanform();
    var Parameter = {};
    MethodService("General", "GetConsecutivo", JSON.stringify(Parameter), "EndCallbackTempFactura");
}

function cleanform() {
    $('input.form-control, select.form-control').val('');
    $('[money]').val('0.00');
    fieldsMoney();
    datepicker();
    $('.entradanumber').html('0');
    $('#btnSave,.btnsearch,#Text_Fecha').removeAttr('disabled');
    $('#btnRev, #btnPrint').attr('disabled', 'disbled');
    $('#id_devolucion').val('0');
    $('#opTipoFactura').val('T');

    Data = {
        Tiva: 0, Tprecio: 0, Tdctoart: 0, Ttotal: 0, Tdesc: 0, Tinc: 0
    };
    var div = $('#idvdevent');
    div.find('[money], select.selectpicker, .btnsearch, input.form-control').removeAttr('disabled');
    div.find('select').selectpicker('refresh');
    $('#esFE').prop('checked', false).iCheck('update');
    TotalizarFactura(Data);
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
    MethodService("Facturas", "FacturaSetArticulo", JSON.stringify(params), callback);
}

function EndCallbackTempFactura(Parameter, Result) {
    if (!Result.Error) {
        Data = Result.Value;
        $('#idToken').val(Data);
        if (window.tblcommodity == null)
            Loadtable();
        else
            window.tblcommodity.bootgrid('reload');
        window.tblcommodity.find('#allcheck').attr({ 'checked': false }).removeAttr('disabled').iCheck('update');
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
            $('#btnRev').removeAttr('disabled');
        }
        else {
            $('#btnSave, #btnRev').attr('disabled', 'disabled');
        }
        $('#idToken').val(row.id);
        $('#opTipoFactura').val('D');
        $('#tabla').val('MovDevFacturaItems');
        $('#isList').val(true);
        $(this).attr('data-option');
        $('#id_devfactura').val(row.id);
        $('.entradanumber').text(row.id);
        $('#Text_Fecha').val(row.fecha);
        $('#cd_factura').val(row.id_factura);
        $('#ds_factura').val(row.factura);
        $('#cd_tipodoc').val(row.id_tipodoc).selectpicker('refresh');
        $('#codigoccostos').val(row.Centrocosto);
        $('#ds_cliente').val(row.cliente);
        $('#esFE').prop('checked', row.isFE).iCheck('update');
        $('#ds_ctaant').val(row.cuenta_ant);
        $('#m_anticipo').val(row.valoranticipo.Money());
        $('#ds_vendedor').val(row.vendedor);

        var div = $('.diventrada');
        div.find('[money], .addarticle, select.selectpicker, .btnsearch, input.form-control, textarea').attr('disabled', true);
        $('#Text_Fecha').removeAttr('disabled');
        div.find('select').selectpicker('refresh');

        window.tblcommodity.bootgrid('reload');
        TotalizarFactura(row);
        window.setTimeout(function () {
            $('#ModalFacturas').modal('hide');
        }, 4);
    }
    else {
        toastr.error(Result.Message, 'Sintesis ERP');
    }
}

function EndCallbackGetFac(Parameter, Result) {
    if (!Result.Error) {
        var row = Result.Row;
        $('#btnPrint').removeAttr('disabled');

        $('#opTipoFactura').val('T');
        window.tblcommodity.bootgrid('reload');
        $('#id_factura').val(row.id);
        $('#cd_tipodoc').val(row.id_tipodoc);
        $('#codigoccostos').val(row.centrocosto);
        $('#Text_Fecha').val(row.fechafac);
        $('#ds_cliente').val(row.cliente);
        $('#ds_vendedor').val(row.vendedor);
        $('#ds_ctaant').val(row.cuentaant);
        $('#m_anticipo').val(row.valoranticipo.Money());//Acutalizado 29/01/2021
        $('#m_discountfin').val(row.dsctoFinanciero.Money());//Acutalizado 29/01/2021
        $('#ds_ctadscto').val(row.CuentaDescuentoFin);//Acutalizado 29/01/2021							  
        $('#esFE').prop('checked', row.isfe).iCheck('disable');

        var div = $('#divfact');
        div.find('[money], select.selectpicker, .btnsearch, input.form-control, textarea').not('.search-field').attr('disabled', true);
        div.find('select').selectpicker('refresh');
        div.find('.i-checks').iCheck('update');
        if (row.financiera > 0)
            window.tblcommodity.find('#allcheck').prop('checked', true).attr({ 'disabled': 'disabled' }).iCheck('update');
        else
            window.tblcommodity.find('#allcheck').prop('checked', false).removeAttr('disabled').iCheck('update');

        TotalizarFactura(row);
        $('#ModalFacturas').modal('hide');
    }
    else {
        toastr.error(Result.Message, 'Sintesis ERP');
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
                input = $('<input class="form-control inputlote" money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="0" data-v-max="' + e.cantidad + '" data-id="' + e.id + '" value="' + e.cantidaddev + '"/>');
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
function EndCallbackupdate(params, Result) {
    if (!Result.Error) {
        param = JSON.parse(params);
        $('#isList').val(true);
        window.tblcommodity.bootgrid('reload');
        $('#ModalSeries').modal('hide');
        $('.rowedit').remove();
        Data = Result.Row;
        TotalizarFactura(Data);


    }
    else {
        par = JSON.parse(params);
        $('.rowedit').val(par.oldvalue);
        toastr.error(Result.Message, 'Sintesis ERP');
    }
    $('#btnSaveSeries').button('reset');
}

function TotalizarFactura(Data) {
    $('#Tiva').text('$ ' + Data.Tiva.Money());
    $('#Tinc').text('$ ' + Data.Tinc.Money());
    $('#Ttventa').text('$ ' + Data.Tprecio.Money());
    $('#TdescArt').text('$ ' + Data.Tdctoart.Money());
    $('#Ttotal').text('$ ' + Data.Ttotal.Money());
}

function CallbackComodity(Parameter, Result) {
    json = JSON.parse(Parameter);
    if (!Result.Error) {
        datos = Result.Row;
        $('.entradanumber').html(datos.id);
        $('#opTipoFactura').val('D');
        $('#id_devfactura').val(datos.id);
        $('#btnSave,.btnsearch,#Text_Fecha').attr('disabled', 'disabled');
        $('#btnRev, #btnPrint').removeAttr('disabled');
        $("#ModalFormas").modal('hide');
        var div = $('.diventrada');
        div.find('[money], .addarticle, select.selectpicker, .btnsearch, input.form-control').attr('disabled', true);
        div.find('select').selectpicker('refresh');
        $('#tblcommodity').find('a.command-delete').remove();
        $('#tblconcepto').find('div.check').remove();

        window.tblcommodity.bootgrid('reload');
        toastr.success('Factura Realizada.', 'Sintesis ERP');
    }
    else
        toastr.error(Result.Message, 'Sintesis ERP');
    $('#btnSave').button('reset');
}

