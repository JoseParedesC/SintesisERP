var JsonValidate = [{ id: 'Text_FechaDev', type: 'DATE', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'ds_factura', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];

var JsonCommodity = [{ id: 'v_presen', type: 'WHOLE', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
{ id: 'cd_wineri', type: 'WHOLE', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'm_quantity', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];

window.tblcommodity = null;
$(document).ready(function () {
    window.tblcommodity = $("#tblcommodity").bootgrid({
        ajax: true,
        post: function () {
            return {
                'params': function () {
                    var param = {};
                    param.id_entrada = $('#id_devoluciontemp').val();
                    param.opcion = $('#opTipoEntrada').val();
                    return JSON.stringify(param);
                },

                'class': "Entradas",
                'method': 'EntradasItemList'
            };
        },
        url: window.appPath + "/Pages/Connectors/ConnectorList.ashx", //conecta los metodos con los controladores*/
        //rowCount: -1,
        columnSelection: false,
        formatters: {
            "select": function (column, row) {
                if ($('#opTipoEntrada').val() == 'T')
                    return '<div class="check-mail"><input type="checkbox" ' + ((row.selected) ? 'checked="checked"' : '') + ' data-id="' + row.id + '" class="i-checks pull-right command-selected"  /></div>';
            },
            "cantidad": function (column, row) {
                if ($('#opTipoEntrada').val() == 'T' && (row.serie == '0'))
                    return "<span class='tdedit action command-edit text-danger' data-type='numeric' data-column='cantidad' data-min='1' data-max='9999999999999999999' data-simbol='' data-cantidad='" + row.cantidad.toFixed(2) + "' data-value='" + row.cantidaddev.toFixed(2) + "' data-id='" + row.id + "'>" + row.cantidaddev.Money() + "</span>";
                else
                    return row.cantidaddev.Money();
            },
            "valor": function (column, row) {
                return row[column.id].Money();
            },
            "serie": function (column, row) {
                return (row.serie == '1') ? "<span class='tdedit action command-serie fa fa-2x fa-pencil text-info' data-column='serie'  data-count='" + row.cantidad + "' data-id='" + row.id + "'></span>" : '';
            },
        }
    }).on("loaded.rs.jquery.bootgrid", function () {
        window.tblcommodity.find(".command-serie").on("click", function (e) {
            var check = ($(this).closest('tr').find('input.command-selected').prop('checked') || ($('#opTipoEntrada').val() == 'D'));
            if (check) {
                id = $(this).data("id");
                params = {};
                params.id_articulo = id;
                params.count = $(this).attr('data-count');
                params.op = $('#opTipoEntrada').val();
                MethodService("Entradas", "EntradasGetSeriesTemp", JSON.stringify(params), 'EndCallbackGetSeries');
            }
        });
        $('#tblcommodity .i-checks').iCheck({
            checkboxClass: 'icheckbox_square-green',
            radioClass: 'iradio_square-green',
        });
        if ($('#opTipoEntrada').val() == 'T') {
            $('#allcheck').on("ifChanged", function (e) {
                params = {};
                params.id = 0;
                params.column = 'ALLSELECTED';
                params.id_proveedor = 0;
                params.id_proveedorfle = 0;
                params.flete = 0;
                params.value = ($(this).prop('checked')) ? 1 : 0;;
                params.extravalue = '';
                params.id_entrada = $('#id_devoluciontemp').val();
                params.oldvalue = '';
                params.op = 'D';
                params.id_entradaoficial = $('#cd_factura').val();
                MethodService("Entradas", "EntradasSetArticulo", JSON.stringify(params), 'EndCallbackupdate');
            });

            window.tblcommodity.find(".command-selected").on("ifChanged", function (e) {
                id = $(this).attr("data-id");
                params = {};
                params.id = id;
                params.column = 'selected';
                params.id_proveedor = 0;
                params.id_proveedorfle = 0;
                params.flete = 0;
                params.value = ($(this).prop('checked')) ? 1 : 0;
                params.extravalue = '';
                params.id_entrada = $('#id_devoluciontemp').val();
                params.oldvalue = '';
                params.op = 'D';
                params.id_entradaoficial = $('#cd_factura').val();
                MethodService("Entradas", "EntradasSetArticulo", JSON.stringify(params), 'EndCallbackupdate');
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
                            params = {};
                            params.id = row.id;
                            params.column = row.column;
                            params.id_proveedor = 0;
                            params.id_proveedorfle = 0;
                            params.flete = 0;
                            params.value = SetNumber(newvalue);
                            params.extravalue = '';
                            params.id_entrada = $('#id_devoluciontemp').val();
                            params.oldvalue = oldvalue;
                            params.op = 'D';
                            params.id_entradaoficial = $('#cd_factura').val();
                            MethodService("Entradas", "EntradasSetArticulo", JSON.stringify(params), 'EndCallbackupdate');
                        }
                        else {
                            if (SetNumber(newvalue) > SetNumber(cantid))
                                toastr.warning('No puede devolver una cantidad mayor a la de la compra.', 'Sintesis ERP');
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
            })
        }
    });

    newDevEntrada();

});

function newDevEntrada() {
    $('#opTipoEntrada').val('T');
    $('input.form-control').val('');
    $('[money]').val('0.00');
    $('#cd_factura').val('0');
    fieldsMoney();
    datepicker();
    $('.entradanumber').html('0');
    $('#btnSave, #btnTemp,  #btnconf, #btnLoad').removeAttr('disabled');
    $('.dropify-clear').click();
    $('#btnRev').attr('disabled', 'disbled');
    $('#id_devolucion').val('0');
    $('#cd_wineridef, #cd_tipodoc').val('');

    Data = {
        retica: 0, retiva: 0, retfuente: 0, Tiva: 0, Tinc: 0, Tcosto: 0, Tdesc: 0, Ttotal: 0, porica: 0, poriva: 0, porfuente: 0
    };
    var div = $('#idvdevent');
    div.find('.btnsearch, input.form-control').removeAttr('disabled');
    $('select').selectpicker('refresh');
    TotalizarEntrada(Data);
    var Parameter = {};

    MethodService("Entradas", "EntradasSaveConsecutivo", JSON.stringify(Parameter), "EndCallbackTempEntrada");
}



window.gridentradas;
$(document).ready(function () {
    $('#btnList').click(function () {
        if (window.gridentradas === undefined) {
            window.gridentradas = $("#tblentradas").bootgrid({
                ajax: true,
                post: function () {
                    return {
                        'params': "",
                        'class': 'Devoluciones',
                        'method': 'EntradasDevList'
                    };
                },
                url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
                formatters: {
                    "edit": function (column, row) {
                        return "<a class=\"action command-edit\" data-row-id=\"" + row.id + "\"><span class=\"fa-2x fa fa-eye iconfa\"></span></a>";
                    },
                    "valor": function (column, row) {
                        return '$ ' + row[column.id].Money();
                    },
                    "contab": function (column, row) {
                        if (row.conta == 1 || row.conta == '1') {
                            return "<a class=\"action command-contab\" data-row-id=\"" + row.id + "\"><span class=\"fa fa-2x fa-fw fa-money text-info  iconfa\" /></a>";
                        }
                        else
                            return '';
                    },
                    "log": function (column, row) {
                        if (row.conta == 1 || row.conta == '1') {
                            return "<a class=\"action command-log\" data-row-id=\"" + row.id + "\"><span class=\"fa fa-2x fa-fw fa-exclamation-triangle text-warning  iconfa\" /></a>";
                        }
                        else
                            return "";
                    }
                }
            }).on("loaded.rs.jquery.bootgrid", function () {
                // Executes after data is loaded and rendered 
                window.gridentradas.find(".command-edit").on("click", function (e) {
                    id = $(this).data("row-id")
                    params = {};
                    params.id = id;
                    MethodService("Devoluciones", "EntradasDevGet", JSON.stringify(params), 'EndCallbackGet');
                }).end().find(".command-contab").on("click", function (e) {
                    if (confirm("Desea contabilizar?")) {
                        $('#ModalLoad').modal({ backdrop: 'static', keyboard: false }, "show");
                        id = $(this).data("row-id");
                        params = {};
                        params.id = id;
                        params.tipo = "DE";
                        MethodService("Entradas", "EntradaContabilizar", JSON.stringify(params), 'EndCallbackcontab');
                    }
                }).end().find(".command-log").on("click", function (e) {
                    id = $(this).data("row-id");
                    $('#id_proce').val(id);
                    loadlog();
                })
            });
        }
        else
            window.gridentradas.bootgrid('reload');

        $('#ModalEntrada').modal({ backdrop: 'static', keyboard: false }, "show");
    });

    $('#btnRev').click(function () {
        if ($('#id_devolucion').val() != '0' && $('#id_devolucion').val().trim() != '') {
            if (confirm('Desea revertir la devolución?')) {
                var sJon = {};
                sJon.id = $('#id_devolucion').val();
                $('#btnRev').button('loading');
                MethodService("Devoluciones", "RevertirDevEntrada", JSON.stringify(sJon), "CallbackReversion");
            }
        }
    });

    $('#btnPrint').click(function () {
        var identrada = $('#id_devolucion').val();
        param = 'id|' + identrada + ';'
        PrintDocument(param, 'MOVDEVENTRADA', 'CODE');
    });

    $('#btnnew').click(function () {
        newDevEntrada();
    });

    $('#btnSave').click(function () {
        if (validate(JsonValidate) && $('#opTipoEntrada').val() == 'T') {
            if (window.tblcommodity.bootgrid("getTotalRowCount") > 0) {
                var sJon = {};
                sJon.fecha = SetDate($('#Text_FechaDev').val());
                sJon.id_devolucion = $('#id_devoluciontemp').val();
                sJon.id_entrada = $('#cd_factura').val();
                $('#btnSave').button('loading');
                MethodService("Devoluciones", "FacturarDevEntrada", JSON.stringify(sJon), "CallbackComodity");
            }
            else
                toastr.warning("No ha agregado ningun artículo.", 'Sintesis ERP');
        }
    });

    $("#cd_factura").change(function () {
        $('#v_code').val('');
        $('#Text_Fecha, #Text_FechaFac, #Text_Numero, #Text_FechaV, #ds_provider, #ds_ctaant, #codigoccostos, #cd_tipodoc, #cd_wineridef').val('');
        $('#m_quantity').val('1.00');
        $('#existencia, #m_anticipo').val('0.00');
        $('#v_presen').html("");
        $('#v_presen, #cd_tipodoc, #cd_wineridef').selectpicker('refresh');
        params = {};
        params.id = ($(this).val() != "") ? $(this).val() : "0";
        params.idtemp = ($('#id_devoluciontemp').val() != "") ? $('#id_devoluciontemp').val() : "0";
        params.op = 'D';
        MethodService("Entradas", "EntradasGet", JSON.stringify(params), 'EndCallbackGetEnt');
    });

    $('#btnSaveSeries').click(function () {
        if ($('#opTipoEntrada').val() == 'T') {
            series = '';
            var len = $("#listtreeccostos input:checked").length;
            if (len > 0) {
                $.each($("#listtreeccostos input:checked"), function (e, i) {
                    series += $(i).attr('data-id') + ',';
                });
            }
            params = {};
            params.id = $(this).attr('data-id');
            params.column = 'series';
            params.id_proveedor = 0;
            params.id_proveedorfle = 0;
            params.flete = 0;
            params.value = "0";
            params.extravalue = series;
            params.id_entrada = $('#id_devoluciontemp').val();
            params.oldvalue = "";
            params.id_entradaoficial = $('#cd_factura').val();
            params.op = 'D';
            params.modulo = 'E';
            var btn = $(this);
            btn.button('loading');
            MethodService("Entradas", "EntradasSetArticulo", JSON.stringify(params), 'EndCallbackupdate');
        }
        else {
            $('#ModalSeries').modal('hide');
        }
    });
});

function EndCallbackGetSeries(params, answer) {
    if (!answer.Error) {
        par = JSON.parse(params);
        table = answer.Table;
        disabled = ($('#opTipoEntrada').val() != 'T') ? "disabled='disabled'" : "";
        $('#listtreeccostos').html('');
        $('#btnSaveSeries').attr('data-id', par.id_articulo);
        var count = table.length;
        for (i = 0; i < count; i++) {
            var value = table[i].serie;
            var subdiv = $('<div class="check-mail pull-right"><input ' + disabled + 'type="checkbox" ' + ((table[i].selected) ? 'checked="checked"' : '') + ' data-id="' + table[i].id + '" class="i-checks pull-right"  /></div>');
            var div = $('<div class="list-group-item"/>').append(subdiv, value);
            $('#listtreeccostos').append(div);
        }
        $('#ModalSeries').modal({ backdrop: 'static', keyboard: false }, 'show');
    }
    else {
        toastr.warning(answer.Message, 'Sintesis ERP');
    }
}

function EndCallbackGet(Parameter, Result) {
    if (!Result.Error) {
        var row = Result.Row;
        if (row.estado == 'PROCESADO') {
            $('#btnSave').attr('disabled', 'disabled');
            $('#btnRev').removeAttr('disabled');
        }
        else {
            $('#btnSave, #btnRev').attr('disabled', 'disabled');
        }

        $(this).attr('data-option');
        $('#opTipoEntrada').val('D');
        $('#Text_FechaDev').val(row.fechadocumen);
        $('#cd_factura').val(row.id_entrada);
        $('#dev').val(row.numfactura + ' - ' + row.proveedor);
        $('#id_devolucion').val(row.id);
        $('#id_devoluciontemp').val(row.id);
        $('.entradanumber').text(row.id);

        $('#cd_tipodoc').val(row.id_tipodoc).selectpicker('refresh');
        $('#codigoccostos').val(row.centrocosto);
        $('#Text_Fecha').val(row.fechadocumen);
        $('#Text_FechaFac').val(row.fechafactura);
        $('#Text_Numero').val(row.numfactura);
        $('#cd_wineridef').val(row.id_bodega).selectpicker('refresh');
        $('#cd_formapago').val(row.id_formaPagos).selectpicker('refresh');
        $('#Text_FechaV').val(row.fechavence);
        $('#ds_provider').val(row.proveedor);
        $('#allcheck').prop('checked', false).attr('disabled', true).iCheck('update');
        $('#ds_ctaant').val(row.ctaanticipo);
        $('#m_anticipo').val('$ ' + row.valoranticipo.Money());

        var div = $('#diventrada');
        div.find('[money], select.selectpicker, .btnsearch, input.form-control').attr('disabled', true);
        div.find('select').selectpicker('refresh');

        TotalizarEntrada(row);
        $('#ModalEntrada').modal('hide');
        window.tblcommodity.bootgrid('reload');
    }
    else {
        toastr.error(Result.Message, 'Sintesis ERP');
    }
}

function EndCallbackGetEnt(Parameter, Result) {
    if (!Result.Error) {
        window.tblcommodity.bootgrid('reload');
        var row = Result.Row;
        if (Object.keys(row).length > 0) {

            $('#cd_tipodoc').val(row.id_tipodoc);
            $('#codigoccostos').val(row.centrocosto);
            $('#Text_Fecha').val(row.fechadocumen);
            $('#Text_FechaFac').val(row.fechafactura);
            $('#Text_Numero').val(row.numfactura);
            $('#cd_wineridef').val(row.id_bodega).selectpicker('refresh');
            $('#cd_formapago').val(row.id_formaPagos).selectpicker('refresh');
            $('#Text_FechaV').val(row.fechavence);
            $('#ds_provider').val(row.proveedor);
            $('#ds_ctaant').val(row.ctaanticipo);
            $('#m_anticipo').val('$ ' + row.valoranticipo.Money());
            $('#flete').val(row.flete.Money());
        }
        var div = $('#divfact');
        div.find('[money], #addarticle, select.selectpicker, .btnsearch, input.form-control, textarea').attr('disabled', true);
        div.find('select').selectpicker('refresh');
    }
    else {
        toastr.error(Result.Message, 'Sintesis ERP');
    }
}

function EndCallbackupdate(params, Result) {
    if (!Result.Error) {
        param = JSON.parse(params);
        Data = Result.Row;
        TotalizarEntrada(Data);
        $('#ModalSeries').modal('hide');
        $('.rowedit').remove();
        window.tblcommodity.bootgrid('reload');
    }
    else {
        par = JSON.parse(params);
        $('.rowedit').val(par.oldvalue);
        toastr.error(Result.Message, 'Sintesis ERP');
    }

    $('#btnSaveSeries').button('reset');
}

function TotalizarEntrada(Data) {
    $('#porretica').text(Data.porica.Money());
    $('#porretiva').text(Data.poriva.Money());
    $('#porrefuente').text(Data.porfuente.Money());
    $('#retica').text('$ ' + Data.retica.Money());
    $('#retiva').text('$ ' + Data.retiva.Money());
    $('#retfuente').text('$ ' + Data.retfuente.Money());
    $('#Tiva').text('$ ' + Data.Tiva.Money());
    $('#Tinc').text('$ ' + Data.Tinc.Money());
    $('#Tcosto').text('$ ' + Data.Tcosto.Money());
    $('#Tdesc').text('$ ' + Data.Tdesc.Money());
    $('#Ttotal').text('$ ' + Data.Ttotal.Money());
}

function CallbackReversion(Parameter, Result) {
    json = JSON.parse(Parameter);
    $('#btnRev').button('reset');
    if (!Result.Error) {
        datos = Result.Row;
        $('.entradanumber').html(datos.id);
        $('#id_devolucion').val(datos.id);
        $('#btnSave, #btnRev').attr('disabled', 'disabled');
        var div = $('#diventrada');
        div.find('[money], select.selectpicker, .btnsearch, input.form-control').attr('disabled', true);
        $('select').selectpicker('refresh');

        toastr.success('Devolución de Mercancia Revertida.', 'Sintesis ERP');
    }
    else
        toastr.error(Result.Message, 'Sintesis ERP');
}

function CallbackComodity(Parameter, Result) {
    json = JSON.parse(Parameter);
    $('#btnSave').button('reset');
    if (!Result.Error) {
        datos = Result.Row;
        $('.entradanumber').html(datos.id);
        $('#id_devolucion').val(datos.id);
        $('#id_devoluciontemp').val(datos.id);
        $('#opTipoEntrada').val('D');
        $('#btnSave').attr('disabled', 'disabled');
        $('#btnRev, #btnPrint').removeAttr('disabled');
        var div = $('#diventrada');
        div.find('[money], select.selectpicker, .btnsearch, input.form-control').attr('disabled', true);
        div.find('select').selectpicker('refresh');

        toastr.success('Devolución facturada.', 'Sintesis ERP');

        window.tblcommodity.bootgrid('reload');
    }
    else
        toastr.error(Result.Message, 'Sintesis ERP');
}

function EndCallbackTempEntrada(Parameter, Result) {
    if (!Result.Error) {
        Data = Result.Row;
        $('#id_devoluciontemp').val(Data.id);
        window.tblcommodity.bootgrid('reload');

    }
    else {
        toastr.error(Result.Message, 'Sintesis ERP');
    }
}