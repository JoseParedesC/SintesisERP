var JsonValidate = [{ id: 'cd_tipodoc', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
{ id: 'codigoccostos', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
{ id: 'Text_Fecha', type: 'DATE', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'ds_provider', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'cd_wineridef', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];

var JsonCommodity = [{ id: 'v_code', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'nombre', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'm_quantity', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'cd_wineridef', type: 'WHOLE', htmltype: 'SELECT', required: true, depends: false, iddepends: '' }];

window.tblcommodity = null;
window.gridentradas = null;
window.gridordencomprastemp = null;

function LoadTable() {
    window.tblcommodity = $("#tblcommodity").bootgrid({
        ajax: true,
        rowCount: [100],
        post: function () {
            return {
                'params': function () {
                    var param = {};
                    param.id_entrada = $('#opcion').val() == 'T' ? $('#id_entradatemp').val() : $('#id_entrada').val();
                    param.opcion = $('#opcion').val();
                    return JSON.stringify(param);
                },

                'class': "Entradas",
                'method': 'EntradasItemList'
            };
        },
        url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
        formatters: {
            "costototal": function (column, row) {
                return row.costototal.Money();
            },
            "costo": function (column, row) {
                return "<span class='tdedit action ' data-column='costo' data-value='" + row.costo + "' data-id='" + row.id + "'>" + row.costo.Money() + "</span>";
            },
            "cantidad": function (column, row) {
                return "<span class='tdedit action command-edit' data-column='cantidad' data-value='" + row.cantidad + "' data-id='" + row.id + "'>" + row.cantidad.Money() + "</span>";
            },
            "delete": function (column, row) {
                return $('#opcion').val() == 'T' ? "<a class=\"action command-delete\" data-row-id=\"" + row.id + "\"><span class=\"fa fa-2x fa-trash-o text-danger iconfa\"></span></a>" : "";
            }
        }
    }).on("loaded.rs.jquery.bootgrid", function () {
        if ($('#opTipoEntrada').val() == 'C') {
            window.tblcommodity.find(".command-delete").remove();
        } else {
            window.tblcommodity.find(".command-delete").on("click", function (e) {
                id = $(this).data("row-id");
                params = {};
                params.id_articulo = id;
                params.id_proveedor = 0;
                params.id_proveedorfle = 0;
                params.flete = 0;
                params.id_entrada = $('#id_entradatemp').val();
                MethodService("Entradas", "EntradasDelArticulo", JSON.stringify(params), 'EndCallbackupdate');
            }).end().find(".command-edit").on("dblclick", function (e) {
                params = {};
                $(this).hide();
                data = $(this).data();
                tr = $(this).closest('td');
                input = $('<input class="form-control rowedit" data-oldvalue="' + data.value + '" data-column="' + data.column + '" data-id="' + data.id + '" value="' + data.value + '" money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="0.01" data-v-max="999999999.99">');
                input.blur(function () {
                    var row = $(this).data();
                    newvalue = $(this).val();
                    oldvalue = $(this).data('oldvalue');
                    if (SetNumber(newvalue) != oldvalue) {
                        params = {};
                        params.id = row.id;
                        params.column = row.column;
                        params.id_proveedor = '0';
                        params.id_proveedorfle = 0;
                        params.flete = 0;
                        params.value = SetNumber(newvalue);
                        params.id_entrada = $('#id_entradatemp').val();
                        params.oldvalue = oldvalue;
                        MethodService("Entradas", "EntradasSetArticulo", JSON.stringify(params), 'EndCallbackupdate');
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
            });
        }
    });
}

$(document).ready(function () {

    newOrden();

    $('#v_code').autocomplete({
        serviceUrl: window.appPath + "/Pages/Connectors/Connector.ashx",
        type: 'post',
        datatype: 'json',
        paramName: 'keyword',
        params: { 'class': 'Productos', method: 'ArticulosBuscador' },
        noCache: true,
        onSelect: function (select) {
            if (select.data != 0) {
                loadpresentation(select.data, 0, 0);
            }
            else {
                $('#addarticle').attr('data-id', '0');
                $('#nombre').val("");
            }
        },
        onSearchStart: function (query) {
            query.params = JSON.stringify({ filtro: query.keyword, op: 'O', o: '', formula: 0, id_prod: 0 });
        },
        minChars: 2,
        transformResult: function (response) {
            json = JSON.parse(response).ans;
            var object = json.data;
            if (object.length > 0) {
                return {
                    suggestions: $.map(object, function (dataItem) { return { value: dataItem.name, data: dataItem.id }; })
                };
            }
            else {
                return { suggestions: [] }
            }
        }
    });
});

$(document).ready(function () {
    $('#btnList').click(function () {
        if (window.gridentradas === null) {
            window.gridentradas = $("#tblOrdenCompras").bootgrid({
                ajax: true,
                post: function () {
                    return {
                        'params': "",
                        'class': 'OrdenCompras',
                        'method': 'OrdenComprasList'
                    };
                },
                url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
                formatters: {
                    "edit": function (column, row) {
                        return "<a class=\"action command-edit\" data-row-id=\"" + row.id + "\"><span class=\"fa-2x fa fa-eye iconfa\"></span></a>";
                    },
                    "costo": function (column, row) {
                        return '$ ' + row.costo.Money();
                    }
                }
            }).on("loaded.rs.jquery.bootgrid", function () {
                // Executes after data is loaded and rendered 
                window.gridentradas.find(".command-edit").on("click", function (e) {
                    id = $(this).data("row-id")
                    params = {};
                    params.id = id;
                    MethodService("OrdenCompras", "OrdenComprasGet", JSON.stringify(params), 'EndCallbackGet');
                })
            });
        }
        else 
            window.gridentradas.bootgrid('reload');

        $('#ModalEntrada').modal({ backdrop: 'static', keyboard: false }, "show");
    });

    $('#btntraslate').click(function () {
        if ($('#estadopedido').val() == 'PROCESADO') {
            var ordencompra = $('#id_entrada').val();
            localStorage.setItem("id_orden", ordencompra);
            window.location = "entradas.aspx";
        }
        else {
            toastr.warning('No se puede transferir ya que su estado no es procesado.', 'Sintesis ERP');
        }
    });

    $('#btnListarTemp').click(function () {
        if (window.gridordencomprastemp === undefined) {
            window.gridordencomprastemp = $("#tblOrdenComprasTemp").bootgrid({
                ajax: true,
                post: function () {
                    return {
                        'params': "",
                        'class': 'OrdenCompras',
                        'method': 'OrdenComprasTempList'
                    };
                },
                url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
                formatters: {
                    "edit": function (column, row) {
                        return "<a class=\"action command-edit\" data-row-id=\"" + row.id + "\"><span class=\"fa-2x fa fa-pencil iconfa\"></span></a>";
                    },
                    "valor": function (column, row) {
                        return '$ ' + row.valor.Money();
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
                window.gridordencomprastemp.find(".command-edit").on("click", function (e) {
                    id = $(this).data("row-id")
                    params = {};
                    params.id = id;
                    MethodService("OrdenCompras", "OrdenComprasTempGet", JSON.stringify(params), 'EndCallbackGetTemp');
                })
            });
        }
        else
            window.gridordencomprastemp.bootgrid('reload');

        $('#ModalOrdenCompraTemp').modal({ backdrop: 'static', keyboard: false }, "show");
    });

    $('#btnRev').click(function () {
        if ($('#id_entrada').val() != '0' && $('#id_entrada').val().trim() != '') {
            if (confirm("Desea revertir la Orden de Compra?")) {
                var sJon = {};
                sJon.id = ($('#id_entrada').val().trim() == "") ? "0" : $('#id_entrada').val();
                MethodService("OrdenCompras", "RevertirOrdenCompra", JSON.stringify(sJon), "CallbackReversion");
            }
        }
    });

    $('#addarticle').click(function () {
        if (validate(JsonCommodity)) {
            var Parameter = {};
            Parameter.id_orden = $('#id_entradatemp').val();
            Parameter.id_article = $('#addarticle').attr('data-id');
            Parameter.id_bodega = $('#cd_wineridef').val();
            Parameter.quantity = SetNumber($('#m_quantity').val());
            MethodService("OrdenCompras", "OrdenCompraAddArticulo", JSON.stringify(Parameter), "EndCallbackAddArticle");
        }
    });

    $('#btnPrint').click(function () {
        var identrada = $('#id_entrada').val();
        param = 'id|' + identrada + ';'
        PrintDocument(param, 'MOVORDENCOMPRA', 'CODE');
    });

    $('#btnnew').click(function () {
        newOrden();
    });

    $("#btnconf").click(function () {
        $('#ModalConfig').modal({ backdrop: 'static', keyboard: false }, 'show');
    });

    $('#btnSave').click(function () {

        if (validate(JsonValidate)) {
            if (window.tblcommodity.bootgrid("getTotalRowCount") > 0) {
                var sJon = {};
                sJon.Id = $('#id_entrada').val();
                sJon.Fecha = SetDate($('#Text_Fecha').val());
                sJon.Proveedor = $('#cd_provider').val();
                sJon.id_tipodoc = $('#cd_tipodoc').val();
                sJon.id_centrocostos = ($('#id_ccostos').val() == "") ? '0' : $('#id_ccostos').val(); 
                sJon.id_ordentemp = $('#id_entradatemp').val();
                sJon.id_bodega = $('#cd_wineridef').val();
                MethodService("OrdenCompras", "FacturarOrdenCompra", JSON.stringify(sJon), "CallbackComodity");
            }
            else
                toastr.warning("No ha agregado ningun artículo.", 'Sintesis ERP');
        }
    });

    $('#btnTemp').click(function () {
        var Parameter = {};
        Parameter.id_orden = $('#id_entradatemp').val();
        Parameter.fechadocumen = SetDate($('#Text_Fecha').val());
        Parameter.id_proveedor = ($('#cd_provider').val().trim() == "") ? 0 : $('#cd_provider').val();
        Parameter.id_bodega = ($('#id_bodega').val().trim() == "") ? 0 : $('#id_bodega').val();

        MethodService("OrdenCompra", "OrdenCompraSaveTemp", JSON.stringify(Parameter), "EndCallbackTempEntrada");
    });

    $('#cd_tipodoc').change(function () {
        if ($("#id_entrada").val() == '0') {
            var valores = $(this).find('option:selected').attr('data-centro');
            var split = valores.split('|~|');
            $('#id_ccostos').val(split[1]);
            $('#codigoccostos').val(split[2]);
        }

        JsonValidate[1].required = (split[0] == '1') ? true : false;
    });
});

function loadpresentation(v_code) {
    params = {};
    params.filtro = v_code;
    params.op = 'P';
    params.o = 'PR';
    params.formula = 0;
    params.id_prod = v_code;
    MethodService("Productos", "ArticulosBuscador", JSON.stringify(params), "EndCallbackArticle");
}

function EndCallbackArticle(params, answer) {
    if (!answer.Error) {
        if (answer.data.length > 0) {
            var row = answer.data[0];
            $('#addarticle').attr('data-id', row.id)
            $('#nombre').val(row.nombre);
            $('#m_quantity').focus().select();
        }
    }
    else {
        toastr.warning(answer.Message, 'Sintesis ERP');
    }
}

function newOrden() {
    $('.divarticleadd').show();
    $('input.form-control').val('');
    $('[money]').val('0.00');
    $('#m_quantity').val('1.00');
    $('#opcion').val('T');
    fieldsMoney();
    datepicker();
    $('.entradanumber').html('0');
    $('#btnSave, #btnTemp,  #btnconf').removeAttr('disabled');
    $('#btnRev,#btntraslate').attr('disabled', 'disbled');
    $('#id_entrada, #id_ccostos').val('0');
    $('#cd_tipodoc').val('');
    $('#cd_wineridef').val('');
    var div = $('#diventrada');
    div.find('[money], #addarticle, select.selectpicker, .btnsearch, input.form-control').not('#nombre').removeAttr('disabled');
    $('select').selectpicker('refresh');
    $('#Tcosto').text('$ 0.00');
    var Parameter = {};
    MethodService("Entradas", "EntradasSaveConsecutivo", JSON.stringify(Parameter), "EndCallbackTempEntrada");
}

function ValidarProducto(id_articulo, ordenCompra) {
    removeerror();
    params = {};
    params.id_orden = ordenCompra;
    params.id_articulo = id_articulo;
    MethodService("OrdenCompras", "OrdenComprasItemTempGet", JSON.stringify(params), "EndCallExistArtycle");
}

function EndCallbackTraslate(params, answer) { // actualiza la grilla
    if (!answer.Error) {
        toastr.success('Orden Comprada Convertida en Entrada.', 'Sintesis ERP');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}

function EndCallbackUnLoad(Parameter, Result) {
    if (!Result.Error) {
        var drDestroy = window.tblcommodity.data('.rs.jquery.bootgrid');
        drDestroy.clear();
        $('#flete').trigger('change');
        $('#btnLoad, #addarticle').removeAttr('disabled');
    }
    else {
        toastr.error(Result.Message, 'Sintesis ERP');
    }
    $('#btnsupri').button('reset');
}

function EndCallbackGet(Parameter, Result) {
    if (!Result.Error) {
        var row = Result.Row;
        $('#estadopedido').val(row.estado);
        if (row.estado == 'PROCESADO') {
            $('#btnSave, #btnTemp, #btnconf').attr('disabled', 'disabled');
            $('#btnRev, #btntraslate').removeAttr('disabled');
        }
        else {
            $('#btnSave, #btnTemp, #btnRev, #btnconf, #btntraslate').attr('disabled', 'disabled');
        }
        $('#opcion').val('C');
        $('#id_entrada').val(row.id);
        $('.entradanumber').text(row.id);
        $('#Text_Fecha').val(row.fechadocumen);
        $('#cd_provider').val(row.id_proveedor);
        $('#cd_tipodoc').val(row.id_tipodoc);
        $('#ds_cliente').val(row.proveedor);
        $('#id_ccostos').val(row.id_cencostos);
        $('#codigoccostos').val(row.centrocosto);
        $('#cd_wineridef').val(row.bodega);
        $('select').selectpicker('refresh');
        $('#Tcosto').text('$ ' + row.Tcosto.Money());
        var div = $('#diventrada');
        div.find('.divarticleadd').hide();
        div.find('[money], #addarticle, select.selectpicker, .btnsearch, input.form-control').not('.search-field').attr('disabled', true);
        div.find('select').selectpicker('refresh');
        $('#ModalEntrada').modal('hide');
        window.tblcommodity.bootgrid('reload');
    }
    else {
        toastr.error(Result.Message, 'Sintesis ERP');
    }
}

function EndCallbackGetTemp(Parameter, Result) {
    if (!Result.Error) {
        var row = Result.Row;
        $('#opcion').val('T');
        $(this).attr('data-option');
        $('#id_entradatemp').val(row.id);
        $('.entradanumber').text(row.id);
        $('#Text_Fecha').val(row.fechadocumen);
        $('#cd_provider').val(row.id_proveedor);
        $('#ds_provider').val(row.proveedor);
        $('#codigobodega').val(row.nombrebodega);
        $('#id_bodega').val(row.bodega);
        $('#btnSave').attr('disabled', false);
        var div = $('#diventrada');
        div.find('[money], #addarticle, select.selectpicker, .btnsearch, input.form-control').removeAttr('disabled');

        window.tblcommodity.bootgrid('reload');

        //$.each(Result.Table, function (i, Data) {
        //    drDestroy.append([{ 'id': Data.id, 'codigo': Data.codigo, 'presentacion': Data.presentacion, 'bodega': Data.bodega, 'cantidad': Data.cantidad.Money(), 'iva': Data.iva.Money(), 'costo': Data.costo.Money(), 'descuento': Data.descuento.Money(), 'total': Data.costototal.Money() }])
        //});

        //TotalizarEntrada(row);
        window.setTimeout(function () {
            $('#tblcommodity').find('a.command-delete').remove();
            $('#ModalOrdenCompraTemp').modal('hide');
        }, 4);
    }
    else {
        toastr.error(Result.Message, 'Sintesis ERP');
    }
}

function EndCallbackRecalculo(Parameter, Result) {
    if (!Result.Error) {
        Data = Result.Row;
        TotalizarEntrada(Data);
    }
    else {
        toastr.error(Result.Message, 'Sintesis ERP');
    }
}

function EndCallbackupdate(params, Result) {
    if (!Result.Error) {
        param = JSON.parse(params);
        Data = Result.Row;
        $('#Tcosto').text('$ ' + Data.Tcosto.Money());
        window.tblcommodity.bootgrid('reload');
    }
    else {
        par = JSON.parse(params);
        $('.rowedit').val(par.oldvalue);
        toastr.error(Result.Message, 'Sintesis ERP');
    }
}

function EndCallbackAddArticle(Parameter, Result) {
    if (!Result.Error) {
        Data = Result.Row;
        $('#v_code, #nombre').val('');
        $('#addarticle').attr('data-id', 0);
        $('#m_quantity').val('1.00');
        $('#Tcosto').text('$ ' + Data.Tcosto.Money());
        window.tblcommodity.bootgrid('reload');
        $('#v_code').focus();
    }
    else {
        toastr.error(Result.Message, 'Sintesis ERP');
    }
}

function EndCallbackTempEntrada(Parameter, Result) {
    if (!Result.Error) {
        Data = Result.Row;
        $('#id_entradatemp').val(Data.id);
        if (window.tblcommodity == null)
            LoadTable();
        else
            window.tblcommodity.bootgrid('reload');
        var par = JSON.parse(Parameter);
        if (par.id_entrada != '0' && par.id_entrada != 0 && par.id_entrada !== undefined)
            toastr.info("Guardado temporal realizado.", 'Sintesis ERP');
    }
    else {
        toastr.error(Result.Message, 'Sintesis ERP');
    }
}

function CallbackReversion(Parameter, Result) {
    json = JSON.parse(Parameter);
    if (!Result.Error) {
        datos = Result.Row;
        $('.entradanumber').html(datos.id);
        $('#id_entrada').val(datos.id);
        $('#btnSave, #btnTemp, #btnRev').attr('disabled', 'disabled');
        var div = $('#diventrada');
        div.find('[money], #addarticle, select.selectpicker, .btnsearch, input.form-control').attr('disabled', true);
        div.find('select').selectpicker('refresh');
        $('#tblcommodity').find('a.command-delete').remove();
        toastr.success('Orden de Compra Revertida.', 'Sintesis ERP');
    }
    else
        toastr.error(Result.Message, 'Sintesis ERP');
}

function CallbackComodity(Parameter, Result) {
    json = JSON.parse(Parameter);
    if (!Result.Error) {
        datos = Result.Row;
        $('#opcion').val('C')
        $('.entradanumber').html(datos.id);
        $('#id_entrada').val(datos.id);
        $('#btnSave, #btnTemp').attr('disabled', 'disabled');
        $('#btnRev,#btntraslate').removeAttr('disabled');
        var div = $('#diventrada');
        div.find('.divarticleadd').hide();
        div.find('[money], #addarticle, select.selectpicker, .btnsearch, input.form-control').not('.search-field').attr('disabled', true);
        div.find('select').selectpicker('refresh');
        toastr.success('Orden Guardada.', 'Sintesis ERP');
        window.tblcommodity.bootgrid('reload');
    }
    else
        toastr.error(Result.Message, 'Sintesis ERP');
}
