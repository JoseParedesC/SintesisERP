var JsonValidate = [{ id: 'cd_tipodoc', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
{ id: 'codigoccostos', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
{ id: 'Text_Fecha', type: 'DATE', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'Text_FechaFac', type: 'DATE', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'Text_Numero', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'Text_Dias', type: 'WHOLE', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'Text_FechaV', type: 'DATE', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'ds_provider', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'cd_formapago', type: 'WHOLE', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
{ id: 'cd_wineridef', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'flete', type: 'REAL', htmltype: 'INPUT', required: false, depends: false, iddepends: '' }];

var JsonCommodity = [
    { id: 'v_code', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'nombre', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'm_quantity', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'm_cost', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'm_discount', type: 'REAL', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
    { id: 'v_lote', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
    { id: 'Text_FechaV2', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' }];

window.tblcommodity = null;
window.gridentradas = null;

$(document).ready(function () {

    newEntrada();

    $('#v_code').autocomplete({
        serviceUrl: window.appPath + "/Pages/Connectors/Connector.ashx",
        type: 'post',
        datatype: 'json',
        paramName: 'keyword',
        params: { 'class': 'Productos', method: 'ArticulosBuscador' },
        noCache: true,
        tabDisabled: true,
        onSelect: function (select) {
            if ($('#cd_provider').val() != 0)
                if (select.data != 0) {
                    loadpresentation(select.data, 0, select.data);
                }
                else {
                    $('#addarticle').attr('data-id', '0');
                    $('#nombre').val("");
                }
            else {
                $('#v_code').val("");
                toastr.info('Para seleccionar el producto, debe seleccionar Proveedor.', 'Sintesis ERP');
            }
        },
        onSearchStart: function (query) {
            query.params = JSON.stringify({ filtro: query.keyword, op: 'C', o: '', formula: 0, id_prod: 0 });
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

    $('#v_lote').autocomplete({
        serviceUrl: window.appPath + "/Pages/Connectors/Connector.ashx",
        type: 'post',
        datatype: 'json',
        paramName: 'keyword',
        params: { 'class': 'Lote', method: 'LotesBuscador' },
        noCache: true,
        onSelect: function (select) {
            if (select.data != '') {
                $('#v_lote').val(select.value);
                $('#Text_FechaV2').attr('disabled', true).val(select.data);
            }
            else {
                $('#Text_FechaV2').removeAttr('disabled').val('');
            }
        },
        onSearchStart: function (query) {
            query.params = JSON.stringify({ filtro: query.keyword, op: 'ET', id: $('#id_entradatemp').val() });
            $('#Text_FechaV2').removeAttr('disabled').val('');
        },
        minChars: 2,
        transformResult: function (response) {
            json = JSON.parse(response).ans;
            var object = json.data;
            if (object.length > 0) {
                return {
                    suggestions: $.map(object, function (dataItem) { return { value: dataItem.id, data: dataItem.name }; })
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
        if (window.gridentradas == null) {
            window.gridentradas = $("#tblentradas").bootgrid({
                ajax: true,
                post: function () {
                    return {
                        'params': "",
                        'class': 'Entradas',
                        'method': 'EntradasList'
                    };
                },
                url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
                formatters: {
                    "edit": function (column, row) {
                        return "<a class=\"action command-edit\" data-row-id=\"" + row.id + "\"><span class=\"fa-2x fa fa-eye iconfa\"></span></a>";
                    },
                    "valor": function (column, row) {
                        return '$ ' + row.valor.Money();
                    }
                }
            }).on("loaded.rs.jquery.bootgrid", function () {
                // Executes after data is loaded and rendered 
                window.gridentradas.find(".command-edit").on("click", function (e) {
                    id = $(this).data("row-id")
                    params = {};
                    params.id = id;
                    params.idtemp = 0;
                    params.op = 'E';
                    MethodService("Entradas", "EntradasGet", JSON.stringify(params), 'EndCallbackGet');
                }).end().find(".command-contab").on("click", function (e) {
                    if (confirm("Desea contabilizar?")) {
                        $('#ModalLoad').modal({ backdrop: 'static', keyboard: false }, "show");
                        id = $(this).data("row-id");
                        params = {};
                        params.id = id;
                        params.tipo = "EN";
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
        if ($('#id_entrada').val() != '0' && $('#id_entrada').val().trim() != '') {
            if (confirm("Desea revertir la entrada?")) {
                var sJon = {};
                sJon.id = ($('#id_entrada').val().trim() == "") ? "0" : $('#id_entrada').val();
                MethodService("Entradas", "RevertirEntrada", JSON.stringify(sJon), "CallbackReversion");
            }
        }
    });

    $('#addarticle').click(function () {
        if (validate(JsonCommodity)) {
            var Parameter = {};
            Parameter.id_proveedor = ($('#cd_provider').val().trim() == "") ? 0 : $('#cd_provider').val();
            Parameter.id_proveedorfle = ($('#cd_provconf').val() != '') ? $('#cd_provconf').val() : '0';
            Parameter.id_entrada = $('#id_entradatemp').val();
            Parameter.flete = SetNumber($('#flete').val());
            Parameter.id_article = $('#addarticle').attr('data-id');
            Parameter.id_lote = $('#v_lote').val();
            Parameter.vencimiento = SetDate($('#Text_FechaV2').val());
            Parameter.id_inc = ($('#cd_inc').val().trim() == "") ? 0 : $('#cd_inc').val();
            Parameter.id_iva = ($('#cd_iva').val().trim() == "") ? 0 : $('#cd_iva').val();
            Parameter.id_retefuente = ($('#cd_retefuente').val().trim() == "") ? 0 : $('#cd_retefuente').val();
            Parameter.id_reteiva = ($('#cd_reteiva').val().trim() == "") ? 0 : $('#cd_reteiva').val();
            Parameter.id_reteica = ($('#cd_reteica').val().trim() == "") ? 0 : $('#cd_reteica').val();
            Parameter.quantity = SetNumber($('#m_quantity').val());
            Parameter.cost = SetNumber($('#m_cost').val());
            Parameter.discount = SetNumber($('#m_discount').val());
            Parameter.pordiscount = SetNumber($('#Text_Descuento').val());
            Parameter.lote = ($('#divaddart').attr('data-lote') == 'true') ? true : false;
            Parameter.serie = ($('#divaddart').attr('data-serie') == 'true') ? true : false;
            Parameter.inventario = ($('#divaddart').attr('data-inventario') == 'true') ? true : false;
            Parameter.anticipo = SetNumber($('#m_anticipo').val());
            $('#addarticle').button('loading');
            MethodService("Entradas", "EntradasAddArticulo", JSON.stringify(Parameter), "EndCallbackAddArticle");
        }
    });

    $('#btnPrint').click(function () {
        var identrada = $('#id_entrada').val();
        param = 'id|' + identrada + ';'
        PrintDocument(param, 'MOVENTRADA', 'CODE');
    });

    $('#btnnew').click(function () {
        newEntrada();
    });

    $("#btnconf").click(function () {
        $('#ModalConfig').modal({ backdrop: 'static', keyboard: false }, 'show');
    });

    $("#btnload").click(function () {
        $('#ModalLoadPlano').modal({ backdrop: 'static', keyboard: false }, 'show');
    });

    $('#btnSaveSeries').click(function () {
        valid = false;
        series = '';
        var vectorseries = [];
        $.each($('.inputserie'), function (e, i) {
            val = $(i).val();
            if (val != '') {
                $(i).removeClass('is-focused, error');
                if (!ValidarSerie(vectorseries, val)) {
                    vectorseries.push(val);
                    series += val + ','
                    valid = true;
                }
                else {
                    $(i).addClass('is-focused, error').focus().select();
                    valid = false;
                    toastr.warning("Esta serie ya se encuentra en el listado.", 'Sintesis ERP');
                    return false;
                }
            }
            else {
                $(i).addClass('is-focused, error');
                valid = false;
                return false;
            }
        });
        if (valid) {
            params = {};
            params.id = $(this).attr('data-id');
            params.column = 'series';
            params.id_proveedor = ($('#cd_provider').val().trim() == "") ? 0 : $('#cd_provider').val();
            params.id_proveedorfle = ($('#cd_provconf').val() != '') ? $('#cd_provconf').val() : '0';
            params.flete = SetNumber($('#flete').val());
            params.value = "0";
            params.extravalue = series;
            params.id_entrada = $('#id_entradatemp').val();
            params.oldvalue = "";
            params.modulo = 'E';
            var btn = $(this);
            btn.button('loading');
            MethodService("Entradas", "EntradasSetArticulo", JSON.stringify(params), 'EndCallbackupdate');
        }
    });

    $('#btnSave').click(function () {
        if (validate(JsonValidate) && $('#opTipoEntrada').val() == 'T') {
            if (window.tblcommodity.bootgrid("getTotalRowCount") > 0) {
                if ($('#totalItems').val() == 0) {
                    var sJon = {};
                    sJon.Id = ($('#id_entrada').val().trim() == "") ? "0" : $('#id_entrada').val();
                    sJon.id_tipodoc = $('#cd_tipodoc').val();
                    sJon.id_centrocosto = ($('#id_ccostos').val() == "") ? '0' : $('#id_ccostos').val();
                    sJon.Fecha = SetDate($('#Text_Fecha').val());
                    sJon.FechaFac = SetDate($('#Text_FechaFac').val());
                    sJon.NumeroFac = $('#Text_Numero').val();
                    sJon.Dias = $('#Text_Dias').val();
                    sJon.FechaVen = SetDate($('#Text_FechaV').val());
                    sJon.id_wineri = $('#cd_wineridef').val();
                    sJon.id_formapago = $('#cd_formapago').val();
                    sJon.Proveedor = $('#cd_provider').val();
                    sJon.Flete = SetNumber($('#flete').val());
                    sJon.id_entradatemp = $('#id_entradatemp').val();
                    sJon.tipoprorrat = $('#typeprorrateo').val();
                    sJon.prorratea = $('#prorratear').prop('checked');
                    sJon.id_proveflete = ($('#cd_provconf').val() == '') ? '0' : $('#cd_provconf').val();
                    sJon.id_orden = ($('#idOrden').val() == '') ? '0' : $('#idOrden').val();
                    sJon.id_formapagoFlete = ($('#cd_formapagoFlete').val() == '') ? '0' : $('#cd_formapagoFlete').val();
                    sJon.id_ctaant = ($('#id_ctaant').val().trim() == "") ? "0" : $('#id_ctaant').val();
                    sJon.anticipo = SetNumber($('#m_anticipo').val());
                    //var btn = $(this);
                    if (parseFloat(SetNumber($('#Ttotal').text())) >= 0) {
                        $('#btnSave').button('loading');
                        MethodService("Entradas", "FacturarEntrada", JSON.stringify(sJon), "CallbackComodity");
                    } else {
                        toastr.warning("Valor de anticipo es mayor a la compra.", 'Sintesis ERP');
                    }
                } else {
                    if ($('#cd_formapagoFlete').val() != '') {
                        $('#btnSave').button('loading');
                        MethodService("Entradas", "FacturarEntrada", JSON.stringify(sJon), "CallbackComodity");
                    } else {
                        toastr.warning("Favor definir la forma de pago del Flete.", 'Sintesis ERP');
                    }
                }
            }
            else
                toastr.warning("No ha agregado ningun producto.", 'Sintesis ERP');
        }
    });

    $('#Text_Descuento, #m_quantity, #m_discount, #m_cost').change(function () {
        opt = $(this).attr('data-option');
        var id = (opt == 'P') ? '#Text_Descuento' : '#m_discount';
        val = SetNumber($(id).val());
        costo = SetNumber($('#m_cost').val());
        cantidad = SetNumber($('#m_quantity').val());
        if (costo > 0) {
            if (opt == 'P') {
                valor = costo * (val / 100) * cantidad;
                $('#m_discount').val(valor.Money());
            }
            else if (opt == 'V') {
                valor = (costo <= 0) ? 0.00 : ((val / cantidad) * 100 / costo);
                $('#Text_Descuento').val(valor.Money());
            }
        }
        else {
            if ($(this).hasClass('addart'))
                $(this).val('0.00')
        }
    });

    $('#flete,#cd_provider,#cd_provconf,#id_ctaant,#m_anticipo').change(function () {
        var Parameter = {};
        Parameter.id_proveedor = ($('#cd_provider').val() != '') ? $('#cd_provider').val() : '0';
        Parameter.flete = SetNumber($('#flete').val());
        Parameter.id_entrada = $('#id_entradatemp').val();
        Parameter.id_proveedorfle = ($('#cd_provconf').val() != '') ? $('#cd_provconf').val() : '0';
        Parameter.anticipo = (SetNumber($('#m_anticipo').val()) == '') ? 0 : SetNumber($('#m_anticipo').val());
        Parameter.id_cta = ($('#id_ctaant').val() == '' ? '0' : $('#id_ctaant').val());
        Parameter.fecha = SetDate($('#Text_Fecha').val());
        Parameter.op = $(this).attr('data-op');
        MethodService("Entradas", "EntradasRecalcular", JSON.stringify(Parameter), "EndCallbackRecalculo");
    });

    $('#btnLoad').click(function () {
        var data = new FormData();
        var ds_fileUpload = $('#File1').get(0);
        var ds_files = ds_fileUpload.files;
        if (ds_files.length > 0) {
            if (confirm("Se eliminaran todos los artículos que ya ha insertado, desea seguir?")) {
                for (var i = 0; i < ds_files.length; i++) {
                    filename = ds_files[i].name;
                    data.append(ds_files[i].name, ds_files[i]);
                }
                data.append("folder", 'Filetemp');
                Parameter = {};
                Parameter.id_proveedor = ($('#cd_provider').val().trim() == "") ? 0 : $('#cd_provider').val();
                Parameter.flete = SetNumber($('#flete').val());
                Parameter.id_entrada = $('#id_entradatemp').val();
                var btn = $(this);
                btn.button('loading');
                MethodUploads("Entradas", "EntradaCargarArticulos", data, JSON.stringify(Parameter), "EndCallbackLoad");
            }
        }
        else
            toastr.warning('No ha seleccionado ningun archivo.', 'Sintesis ERP');
    });

    $('#btnsupri').click(function () {
        $('.dropify-clear').click();
        var Parameter = {};
        Parameter.id_entrada = $('#id_entradatemp').val();

        MethodService("Entradas", "EntradaDescargar", JSON.stringify(Parameter), "EndCallbackUnLoad");
    });

    $('#prorratear').on('ifChecked', function (event) {
        $('#cd_provconf').val('0');
        $('#ds_provconf').val('');
        $('#typeprorrateo').removeAttr('disabled');
    }).on('ifUnchecked',
        function () {
            $("#btnproviderconf").removeAttr('disabled');
            $('#typeprorrateo').attr('disabled', 'disabled');
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

    $('#Text_FechaV').blur(function () {
        fin = $(this).val();
        ini = $("#Text_FechaFac").val();
        inicial = ini.split("-");
        final = fin.split("-");
        resultado = '0';
        var dateStart = new Date(inicial[0], (inicial[1] - 1), inicial[2]);
        var dateEnd = new Date(final[0], (final[1] - 1), final[2]);
        if (dateStart <= dateEnd) {
            resultado = (((dateEnd - dateStart) / 86400) / 1000);
        }
        $('#Text_Dias').val(resultado);
    });

    $('#Text_Dias').blur(function () {
        val = $(this).val();
        fecha = SumarDias(val, $("#Text_FechaFac").val());
        $('#Text_FechaV').val(fecha);
    });

});

function LoadTable() {
    window.tblcommodity = $("#tblcommodity").bootgrid({
        ajax: true,
        rowCount: [100],
        post: function () {
            return {
                'params': function () {
                    var param = {};
                    param.id_entrada = ($('#opTipoEntrada').val() == 'E') ? $('#id_entrada').val() : $('#id_entradatemp').val();
                    param.opcion = $('#opTipoEntrada').val();
                    return JSON.stringify(param);
                },

                'class': "Entradas",
                'method': 'EntradasItemList'
            };
        },
        url: window.appPath + "/Pages/Connectors/ConnectorList.ashx", //conecta los metodos con los controladores*/
        // rowCount: -1,
        columnSelection: false,
        formatters: {
            "delete": function (column, row) {
                return ($('#id_entrada').val() == '0' ? "<a class=\"action command-delete\" data-row-id=\"" + row.id + "\"><span class=\"fa fa-2x fa-trash-o text-danger iconfa\"></span></a>" : "");
            },
            "costototal": function (column, row) {
                return row.costototal.Money();
            },
            "costo": function (column, row) {
                return "<span class='tdedit action command-edit' data-type='numeric' data-column='costo' data-min='0' data-max='999999999999999999' data-simbol='$' data-value='" + row.costo + "' data-id='" + row.id + "'>" + row.costo.Money() + "</span>";
            },
            "cantidad": function (column, row) {
                return "<span class='tdedit action command-edit' data-type='numeric' data-column='cantidad' data-min='1' data-max='9999999999999999999' data-simbol='' data-value='" + row.cantidad + "' data-id='" + row.id + "'>" + row.cantidad.Money() + "</span>";
            },
            "lote": function (column, row) {
                if (row.lote)
                    return "<div class='tdedit action command-edit' style='min-width:80px' data-type='text' data-column='lote' data-value='" + row.id_lote + "' data-id='" + row.id + "'>" + row.id_lote + "</div>";
                else
                    row.id_lote;
            },
            "vencimiento": function (column, row) {
                if (row.lote)
                    return "<div class='tdedit action command-edit' data-type='date' data-column='vencimiento' data-value='" + row.id_lote + "' data-id='" + row.id + "'> " + (row.vencimiento == '' ? '.' : row.vencimiento) + "</div>";
                else
                    row.vencimiento;
            },
            "iva": function (column, row) {
                return "<span class='tdedit action command-edits' data-type='numeric' data-column='iva' data-value='" + row.iva + "'  data-idvalue='" + row.id_iva + "' data-id='" + row.id + "'>" + row.iva.Money() + "</span>";
            },
            "serie": function (column, row) {
                return (row.serie == '1') ? "<span class='tdedit action command-serie fa fa-2x fa-pencil text-info' data-column='serie'  data-count='" + row.cantidad + "' data-id='" + row.id + "'></span>" : '';
            },
            "inc": function (column, row) {
                return "<span class='tdedit action command-edits' data-type='numeric' data-column='inc' data-value='" + row.inc + "'  data-idvalue='" + row.id_inc + "' data-id='" + row.id + "'>" + row.inc.Money() + "</span>";
            },
            "descuento": function (column, row) {
                return "<span class='tdedit action command-edit' data-type='numeric' data-column='descuento' data-min='0' data-max='100' data-simbol='%' data-value='" + row.pordescuento + "' data-id='" + row.id + "'>" + row.descuento.Money() + "</span>";
            }
        }
    }).on("loaded.rs.jquery.bootgrid", function () {
        window.tblcommodity.find(".command-serie").on("click", function (e) {
            id = $(this).data("id");
            params = {};
            params.id_articulo = id;
            params.count = $(this).attr('data-count');
            params.op = $('#opTipoEntrada').val();
            MethodService("Entradas", "EntradasGetSeriesTemp", JSON.stringify(params), 'EndCallbackGetSeries');
        });

        if ($('#opTipoEntrada').val() == 'E') {
            window.tblcommodity.find(".command-delete").remove();
        } else {
            window.tblcommodity.find(".command-delete").on("click", function (e) {
                id = $(this).data("row-id");
                params = {};
                params.id_articulo = id;
                params.id_proveedor = ($('#cd_provider').val().trim() == "") ? 0 : $('#cd_provider').val();
                params.flete = SetNumber($('#flete').val());
                params.id_entrada = $('#id_entradatemp').val();
                params.id_proveedorfle = ($('#cd_provconf').val() != '') ? $('#cd_provconf').val() : '0';
                params.anticipo = (SetNumber($('#m_anticipo').val()) != '') ? SetNumber($('#m_anticipo').val()) : '0';
                MethodService("Entradas", "EntradasDelArticulo", JSON.stringify(params), 'EndCallbackupdate');
            }).end().find(".command-edit").on("dblclick", function (e) {
                params = {};
                $(this).hide();
                data = $(this).data();
                tr = $(this).closest('td');
                if ($(this).attr('data-type') == 'numeric') {
                    max = $(this).attr('data-max');
                    min = $(this).attr('data-min');
                    input = $('<input class="form-control rowedit" date-type="numeric" data-oldvalue="' + data.value + '" data-column="' + data.column + '" data-id="' + data.id + '" value="' + data.value + '" money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="' + min + '" data-v-max="' + max + '">');
                    input.autoNumeric('init');
                }
                else if ($(this).attr('data-type') == 'date') {
                    input = $('<input class="form-control rowedit" date-type="date" data-oldvalue="' + data.value + '" data-column="' + data.column + '" data-id="' + data.id + '" value="' + data.value + '" current="true" date="true" format="YYYY-MM-DD" />');
                    console.log('entro');
                    iddatepicker(input);
                }
                else {
                    input = $('<input class="form-control rowedit" date-type="text" data-oldvalue="' + data.value + '" data-column="' + data.column + '" data-id="' + data.id + '" value="' + data.value + '" />');
                }

                input.blur(function () {
                    var row = $(this).data();
                    newvalue = $(this).val();
                    oldvalue = $(this).attr('data-oldvalue');
                    type = $(this).attr('date-type');
                    if ((type == 'numeric' && SetNumber(newvalue) != oldvalue) || (type != 'numeric' && newvalue != oldvalue)) {
                        params = {};
                        params.id = row.id;
                        params.column = row.column;
                        params.id_proveedor = ($('#cd_provider').val().trim() == "") ? 0 : $('#cd_provider').val();
                        params.flete = SetNumber($('#flete').val());
                        params.id_proveedorfle = ($('#cd_provconf').val() != '') ? $('#cd_provconf').val() : '0';
                        params.value = (type != 'numeric') ? '0' : SetNumber(newvalue);
                        params.extravalue = newvalue;
                        params.id_entrada = $('#id_entradatemp').val();
                        params.oldvalue = oldvalue;
                        params.anticipo = SetNumber($('#m_anticipo').val());
                        params.modulo = 'E';
                        MethodService("Entradas", "EntradasSetArticulo", JSON.stringify(params), 'EndCallbackupdate');
                    }
                    else {
                        tr = $(this).closest('td');
                        var ret = (type == 'numeric') ? parseFloat(oldvalue).Money() : oldvalue;
                        tr.find('.tdedit').html(ret).show();
                        $(this).remove();
                    }
                });
                tr.find('.tdedit').hide();
                tr.append(input);
                input.focus().select();
            }).end().find(".command-edits").on("dblclick", function (e) {
                params = {};
                $(this).hide();
                data = $(this).data();
                tr = $(this).closest('td');
                select = $('<select class="select-css rowedit" data-value="' + data.value + '" data-oldvalue="' + data.idvalue + '" data-size="2" data-column="' + data.column + '" data-id="' + data.id + '"/>');
                html = '';
                if (data.column == 'inc')
                    html = $('#cd_inc').html();
                else if (data.column == 'iva')
                    html = $('#cd_iva').html();
                select.html(html);
                select.blur(function () {
                    var row = $(this).data();
                    newvalue = ($(this).val() == '' || $(this).val() == null) ? '0' : $(this).val();
                    oldvalue = $(this).attr('data-oldvalue');
                    value = parseFloat($(this).attr('data-value')).Money();
                    tr = $(this).closest('td');
                    tr.find('span.tdedit').html(value).show();
                    $(this).remove();
                });
                select.change(function () {
                    var row = $(this).data();
                    newvalue = $(this).val();
                    oldvalue = $(this).attr('data-oldvalue');
                    if (newvalue != oldvalue) {
                        params = {};
                        params.id = row.id;
                        params.column = row.column;
                        params.id_proveedor = ($('#cd_provider').val().trim() == "") ? 0 : $('#cd_provider').val();
                        params.flete = SetNumber($('#flete').val());
                        params.id_proveedorfle = ($('#cd_provconf').val() != '') ? $('#cd_provconf').val() : '0';
                        params.value = (newvalue != '') ? newvalue : 0;
                        params.id_entrada = $('#id_entradatemp').val();
                        params.oldvalue = oldvalue;
                        params.modulo = 'E';
                        params.anticipo = SetNumber($('#m_anticipo').val());
                        MethodService("Entradas", "EntradasSetArticulo", JSON.stringify(params), 'EndCallbackupdate');
                    }
                    else {
                        tr = $(this).closest('td');
                        tr.find('span.tdedit').html(parseFloat(oldvalue).Money()).show();
                        $(this).closest('.bootstrap-select.rowedit').remove();
                    }
                });
                tr.find('span.tdedit').hide();
                tr.append(select);
                data.idvalue = (data.idvalue == '0') ? '' : data.idvalue;
                tr.find('select').val(data.idvalue).focus();
            });
        }
    });
}

function newEntrada() {
    window.edit = true;
    $('.divarticleadd').show();
    $('#opTipoEntrada').val('T');
    $('input.form-control').val('');
    $('[money]').val('0.00');
    $('#Text_Dias').val('0');
    $('#m_quantity').val('1.00');
    $('#m_cuotas').val('0');
    $('#cd_wineridef').removeAttr('disabled');
    ifartycle = false;
    fieldsMoney();
    $('#isOrden').val('0');
    $('#idOrden').val('0');
    datepicker();
    $('.entradanumber').html('0');
    $('#btnSave, #btnTemp,  #btnconf, #btnLoad, #btnSaveSeries').removeAttr('disabled');
    $('.dropify-clear').click();
    $('#btnRev, #btnPrint').attr('disabled', 'disbled');
    $('#id_entrada, #id_ccostos').val('0');
    $('#cd_tipodoc').val('');
    $('#cd_wineridef').val('');
    $('#cd_formapago').val('');
    $('#cd_formapagoFlete').val('');
    JsonCommodity[5].required = false;
    JsonCommodity[6].required = false;
    $('.activelote').removeClass('activelote').addClass('desactivelote');
    $('.activeservice').removeClass('activeservice').addClass('desactiveservice');
    Data = {
        retica: 0, retiva: 0, retfuente: 0, Tiva: 0, Tinc: 0, Tcosto: 0, Tdesc: 0, Ttotal: 0, porica: 0, poriva: 0, porfuente: 0, valoranticipo : 0
    };
    var div = $('#diventrada');
    div.find('.divarticleadd').show();
    div.find('[money], #addarticle, select.selectpicker, .btnsearch, input.form-control').not('#nombre').removeAttr('disabled');
    div.find('select').selectpicker('refresh');
    $('#ModalConfig').find('select').val('').selectpicker('refresh');
    $('#prorratear').prop('checked', true).iCheck('update').trigger('ifChecked');
    // $('#btnproviderconf').attr('disabled', 'disabled');

    TotalizarEntrada(Data);

    var id_orden = localStorage.getItem('id_orden');
    if (id_orden != '' && id_orden != null && id_orden != '0' && id_orden != 'null' && id_orden != undefined) {
        params = {};
        params.id_Orden = id_orden;
        $('#isOrden').val(id_orden);
        $('#idOrden').val(id_orden);
        localStorage.clear();
        MethodService("Entradas", "TraslaOrdenCompraEntrada", JSON.stringify(params), 'EndCallbackGetOrdenEntrada');
    } else {
        var Parameter = {};
        MethodService("Entradas", "EntradasSaveConsecutivo", JSON.stringify(Parameter), "EndCallbackTempEntrada");
    }
}

function loadpresentation(v_code, formula, id) {
    params = {};
    params.filtro = v_code;
    params.op = 'P';
    params.o = 'PR';
    params.formula = formula;
    params.id_prod = id;
    MethodService("Productos", "ArticulosBuscador", JSON.stringify(params), "EndCallbackArticle");
}

function EndCallbackGetSeries(params, answer) {
    if (!answer.Error) {
        par = JSON.parse(params);
        table = answer.Table;
        $('#listseries').html('');
        $('#btnSaveSeries').attr('data-id', par.id_articulo);
        var count = (par.count > table.length) ? par.count : table.length;
        var del = (par.count < table.length) ? true : false;
        for (i = 0; i < count; i++) {
            var div = $('<div class="form-group"/>');
            var value = (table[i] != undefined) ? table[i].serie : "";
            var label = $('<label class="active"/>').html('Serie ' + (i + 1));
            if (del) {
                var span = $('<span class="fa fa-2x fa-remove text-danger" style="float: right;font-size: 16px;"/>');
                span.click(function () {
                    $(this).closest('div.form-group').remove();
                });
                label.prepend(span);
            }
            div.append(label);
            var input = "<input class='inputserie form-control' value=\"" + value + "\" />"
            div.append(input);
            $('#listseries').append(div);
        }
        $('#ModalSeries').modal({ backdrop: 'static', keyboard: false }, 'show');
    }
    else {
        toastr.warning(answer.Message, 'Sintesis ERP');
    }
}

function EndCallbackArticle(params, answer) {
    if (!answer.Error) {
        if (answer.data.length > 0) {
            var row = answer.data[0];
            $('#addarticle').attr('data-id', row.id)
            $('#nombre').val(row.nombre);
            $('#cd_iva').val(row.id_iva);
            $('#cd_inc').val(row.id_inc);
            $('#divaddart select').selectpicker('refresh');

            $('#divaddart').attr({ 'data-serie': row.serie, 'data-lote': row.lote, 'data-inventario': row.inventario });
            $('.activeserie, .desactiveserie, .activelote, .desactivelote,.activeservice,.desactiveservice').find('input').val('');
            $('#m_quantity').focus().select();
            JsonCommodity[5].required = row.lote;
            JsonCommodity[6].required = row.lote;
            if (row.lote) {
                $('.activelote, .desactivelote').removeClass('desactivelote').addClass('activelote');
            }
            else {
                $('.activelote, .desactivelote').removeClass('activelote').addClass('desactivelote');
            }
            if (row.nombreTipoProducto == 'SERVICIOS' || row.nombreTipoProducto == 'CONSUMO') {
                $('.activeservice, .desactiveservice').removeClass('desactiveservice').addClass('activeservice');
                row.id_retefuente != null ? $('#cd_retefuente').val(row.id_retefuente).selectpicker('refresh') : $('#cd_retefuente').val('').selectpicker('refresh');
                row.id_reteiva != null ? $('#cd_reteiva').val(row.id_reteiva).selectpicker('refresh') : $('#cd_reteiva').val('').selectpicker('refresh');
                row.id_reteica == null ? $('#cd_reteica').val(row.id_reteica).selectpicker('refresh') : $('#cd_reteica').val('').selectpicker('refresh');
            }
            else {
                $('.activeservice, .desactiveservice').removeClass('activeservice').addClass('desactiveservice');
            }

        }
    }
    else {
        toastr.warning(answer.Message, 'Sintesis ERP');
    }
}

function ValidarSerie(vector, serie) {
    if (vector.indexOf(serie) != -1)
        return true;
    else
        return false;
}

function EndCallbackUnLoad(Parameter, Result) {
    if (!Result.Error) {
        window.tblcommodity.bootgrid('reload');
        $('#flete').trigger('change');
        $('#btnLoad, #addarticle').removeAttr('disabled');

    }
    else {
        toastr.error(Result.Message, 'Sintesis ERP');
    }
    $('#btnsupri').button('reset');
}

function EndCallbackGetOrdenEntrada(Parameter, Result) {
    if (!Result.Error) {
        var row = Result.Row;
        $('#opTipoEntrada').val('T');
        $('#id_entradatemp').val(row.id);
        $('#cd_wineridef').val(row.id_bodega).attr('disabled', true).selectpicker('refresh');
        $('#totalItems').val(row.totalregistro);
        $('#cd_provider').val(row.id_proveedor);
        $('#ds_cliente').val(row.proveedor).attr('disabled', true);
        $('#ds_bod').val(row.proveedor).attr('disabled', true);
        $('#id_providersearch').attr('disabled', true);
        TotalizarEntrada(row);
        localStorage.clear();
        if (window.tblcommodity == null)
            LoadTable();
        else
            window.tblcommodity.bootgrid('reload');

    }
    else {
        $('#isOrden').val('0');
        $('#idOrden').val('0');
        toastr.error(Result.Message, 'Sintesis ERP');
    }
}

function EndCallbackLoad(Parameter, Result) {
    if (!Result.Error) {
        console.log(Result);
        var row = Result.Row;

        var drDestroy = window.tblcommodity.data('.rs.jquery.bootgrid');
        drDestroy.clear();
        drDestroy.append(Result.Table);


        window.tblcommodity.bootgrid('reload');
        TotalizarEntrada(row);
        $('#ModalLoadPlano').modal("hide");
        window.setTimeout(function () {
            $('#tblcommodity').find('a.command-delete').remove();
        }, 4);

        $('#btnLoad').button('reset');
        $('#btnLoad, #addarticle').attr('disabled', 'disabled');
    }
    else {
        toastr.error(Result.Message, 'Sintesis ERP');
        $('#btnLoad').button('reset');
    }
}

function EndCallbackGet(Parameter, Result) {
    if (!Result.Error) {
        var row = Result.Row;
        if (row.estado == 'PROCESADO') {
            $('#btnSave, #btnTemp, #btnconf, #btnSaveSeries').attr('disabled', 'disabled');
            $('#btnRev').removeAttr('disabled');
        }
        else {
            $('#btnSave, #btnTemp, #btnRev, #btnconf').attr('disabled', 'disabled');
        }

        $('#btnPrint').removeAttr('disabled');
        $('#opTipoEntrada').val('E');
        $('#id_entrada').val(row.id);
        $('.entradanumber').text(row.id);
        $('#id_entradatemp').val('0');
        $('#cd_tipodoc').val(row.id_tipodoc);
        $('#codigoccostos').val(row.centrocosto);
        $('#id_ccostos').val(row.id_centro);
        $('#Text_Fecha').val(row.fechadocumen);
        $('#Text_FechaFac').val(row.fechafactura);
        $('#Text_Numero').val(row.numfactura);
        $('#cd_wineridef').val(row.id_bodega)
        $('#ds_bod').val(row.nombrebodega);
        $('#cd_formapago').val(row.id_formaPagos).selectpicker('refresh');
        $('#Text_Dias').val(row.diasvence);
        $('#Text_FechaV').val(row.fechavence);
        $('#cd_provider').val(row.id_proveedor);
        $('#ds_cliente').val(row.proveedor);
        $('#flete').val(row.flete.Money());
        $('#id_pedido').val(row.id_pedido);
        $('#ds_pedido').val(row.id_pedido);
        $('#ds_ctaant').val(row.ctaanticipo);
        $('#m_anticipo').val('$ ' + row.valoranticipo.Money());
        var div = $('#diventrada');
        div.find('.divarticleadd').hide();
        div.find('[money], #addarticle, select.selectpicker, .btnsearch, input.form-control, textarea').not('.search-field').attr('disabled', true);
        div.find('select').selectpicker('refresh');
        window.tblcommodity.bootgrid('reload');
        TotalizarEntrada(row);

        $('#ModalEntrada').modal('hide');
    }
    else {
        toastr.error(Result.Message, 'Sintesis ERP');
    }
}

function EndCallbackRecalculo(Parameter, Result) {
    if (!Result.Error) {
        Data = Result.Row;
        par = JSON.parse(Parameter);
        if (par.op == 'C' && Data.anticipo == 0)
            $('#m_anticipo').attr({ 'data-v-max': 0, 'disabled': 'disabled' }).val('0.00').autoNumeric('init');
        else
            $('#m_anticipo').attr('data-v-max', (Data.anticipo)).val((Data.anticipo).Money()).removeAttr('disabled').autoNumeric('init');
        
        Data.valoranticipo = SetNumber($('#m_anticipo').val());
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

function EndCallbackAddArticle(Parameter, Result) {
    if (!Result.Error) {
        $('#opTipoEntrada').val('T');
        $('#v_code, #nombre').val('');
        $('#cd_iva,#cd_inc').val('').selectpicker('refresh');
        $('#m_quantity').val('1.00');
        $('#m_cost,#m_discount, #Text_Descuento').val('0.00');
        $('#addarticle').attr('data-id', 0);
        $('#v_lote,#Text_FechaV2').val('');
        JsonCommodity[5].required = false;
        JsonCommodity[6].required = false;
        $('.activelote').removeClass('activelote').addClass('desactivelote');
        $('.activeservice').removeClass('activeservice').addClass('desactiveservice');
        cjson = JSON.parse(Parameter);
        Data = Result.Row;
        TotalizarEntrada(Data);
        window.tblcommodity.bootgrid('reload');
        $('#ModalSeries').modal("hide");
        $('#v_code').focus();
    }
    else {
        toastr.error(Result.Message, 'Sintesis ERP');
    }

    $('#addarticle').button('reset');
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
    $('#Tsubtotal').text('$ ' + Data.Ttotal.Money());
    $('#Ttotal').text('$ ' + (Data.Ttotal - (Data.valoranticipo === undefined ? 0 : Data.valoranticipo)).Money());
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
        var div = $('.diventrada');
        div.find('[money], .addarticle, select.selectpicker, .btnsearch, input.form-control').attr('disabled', true);
        div.find('select').selectpicker('refresh');
        toastr.success('Entrada Revertida.', 'Sintesis ERP');
    }
    else
        toastr.error(Result.Message, 'Sintesis ERP');
}

function CallbackComodity(Parameter, Result) {

    if (!Result.Error) {
        datos = Result.Row;
        $('#btnSave').button('reset');
        $('#opTipoEntrada').val('E');
        $('.entradanumber').html(datos.id);
        $('#id_entrada').val(datos.id);
        $('#btnSaveSeries').attr('data-id', '0');
        $('#btnSave, #btnTemp, #btnSaveSeries').attr('disabled', 'disabled');
        $('#btnRev, #btnPrint').removeAttr('disabled');
        var div = $('#diventrada');
        div.find('.divarticleadd').hide();
        div.find('[money], #addarticle, select.selectpicker, .btnsearch, input.form-control').not('.search-field').attr('disabled', true);
        div.find('select').selectpicker('refresh');
        window.tblcommodity.bootgrid('reload');

        toastr.success('Entrada facturada.', 'Sintesis ERP');
    }
    else {
        $('#btnSave').button('reset');
        toastr.error(Result.Message, 'Sintesis ERP');

    }
}

function SumarDias(d, fecha) {
    var fechaFinal = '';
    if (d == 0 || d == '') {
        fechaFinal = fecha;
    }
    else {
        var Fecha = new Date();
        var sFecha = fecha || (Fecha.getFullYear() + "-" + (Fecha.getMonth() + 1) + "-" + Fecha.getDate());
        var sep = sFecha.indexOf('-') != -1 ? '-' : '-';
        var aFecha = sFecha.split(sep);
        var fecha = aFecha[0] + '-' + aFecha[1] + '-' + aFecha[2];
        fecha = new Date(fecha);
        fecha.setDate(fecha.getDate() + (parseInt(d) + 1));
        var anno = fecha.getFullYear();
        var mes = fecha.getMonth() + 1;
        var dia = fecha.getDate();
        mes = (mes < 10) ? ("0" + mes) : mes;
        dia = (dia < 10) ? ("0" + dia) : dia;
        fechaFinal = anno + sep + mes + sep + dia;
    }
    return fechaFinal;
}
