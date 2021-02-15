var JsonValidate = [{ id: 'ds_email', type: 'EMAIL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }]

window.gridsuccess = undefined;
window.griderror = undefined;
window.gridPrevent = undefined;
window.gridenlog = undefined;
function Loadtable(table, op, state) {
    return $("#" + table).bootgrid({
        ajax: true,
        rowCount: [50, 100, 150, 200],
        search: false,
        post: function () {
            return {
                'params': function () {
                    var param = {};
                    param.fecha = $('#startDate' + op).val();
                    param.fechafin = $('#endDate' + op).val();
                    param.factura = $('#factura' + op).val();
                    param.state = state;
                    return JSON.stringify(param);
                },
                'class': 'Facturas',
                'method': 'FacturacionElectronicaList'
            };
        },
        url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
        formatters: {
            "edit": function (column, row) {
                return "<a title='Enviar' class=\"action command-edit\" data-row-op='" + row.op + "' data-row-id=\"" + row.keyid + "\"><span class=\"fa-2x fa fa-sign-in text-danger iconfa\"></span></a>";
            },
            "log": function (column, row) {
                return "<a title='Facturar' class=\"action command-log\" data-row-tipodoc='" + row.tipodocumento + "' data-row-id=\"" + row.keyid + "\"><span class=\"fa-12x fa fa-warning text-warning iconfa\"></span></a>";
            },
            "mail": function (column, row) {
                return "<a title='Enviar Email' class=\"action command-mail\" data-row-tipodoc=\"" + row.tipodocumento + "\" data-row-id=\"" + row.keyid + "\"><span class=\"fa-12x fa fa-envelope text-success iconfa\"></span></a>";
            },
            "accion": function (column, row) {
                var ret =
                    '<a title="Visualizar" class="action command-view"' +
                    ' data-row-id="' + row.keyid + '"' +
                    ' data-row-tipodoc="' + row.tipodocumento + '"' +
                    ' data-row-cufe="' + row.cufe + '">' +
                    '<span class="fa fa-12x fa-eye text-info"></span></a>&nbsp;&nbsp;' +

                    '<a  title="Descargar"class="action command-zip"' +
                    ' data-row-id="' + row.keyid + '"' +
                    ' data-row-tipodoc="' + row.tipodocumento + '"' +
                    ' data-row-cufe="' + row.cufe + '">' +
                    '<span class="fa fa-12x fa-download text-purple"></span></a>';

                return ret;
            }
        }
    });
}

function ajax_download(url, data) {
    var $iframe,
        iframe_doc,
        iframe_html;

    if (($iframe = $('#download_iframe')).length === 0) {
        $iframe = $("<iframe id='download_iframe'" +
            " style='display: none' src='about:blank'></iframe>"
        ).appendTo("body");
    }

    iframe_doc = $iframe[0].contentWindow || $iframe[0].contentDocument;
    if (iframe_doc.document) {
        iframe_doc = iframe_doc.document;
    }

    iframe_html = "<html><head></head><body><form method='POST' action='" +
        url + "'>"

    Object.keys(data).forEach(function (key) {
        iframe_html += "<input type='hidden' name='" + key + "' value='" + data[key] + "'>";
    });

    iframe_html += "</form></body></html>";

    iframe_doc.open();
    iframe_doc.write(iframe_html);
    $(iframe_doc).find('form').submit();
}

function download(dataurl, filename) {
    var a = document.createElement("a");
    a.href = dataurl;
    a.setAttribute("download", filename);
    a.click();
}

$(document).ready(function () {
    loadtableSuccess();
    loadtablePrevent();
    loadtableError();


    $('#btnSuccess').click(function () {
        if (window.gridsuccess === undefined) {
            loadtableSuccess();
        }
        else {
            window.gridsuccess.bootgrid('reload');
        }
    });

    $('#btnPendiente').click(function () {
        if (window.gridPrevent === undefined) {
            loadtablePrevent();
        }
        else {
            window.gridPrevent.bootgrid('reload');
        }
    });

    $('#btnListError').click(function () {
        if (window.griderror === undefined) {
            loadtableError();
        }
        else {
            window.griderror.bootgrid('reload');
        }
    });

    $('#btnSave').click(function () {
        if (confirm("Desea enviar los documentos?")) {
            var cant = $("#tblfacpendietes").bootgrid("getTotalRowCount");
            if (cant > 0) {
                params = {};
                params.fechaini = $('#startDateP').val();
                params.fechafin = $('#endDateP').val();
                MethodService("Facturas", "FacturarElectronicamente", JSON.stringify(params), 'EndCallbackPrevent');
            }
        }
    });

    $('#btnSend').click(function (e) {
        if (validate(JsonValidate)) {
            key = $(this).attr("data-id");
            params = {};
            params.key = key;
            params.tipodoc = $(this).attr("data-tipodoc");
            params.email = $('#ds_email').val();
            $('#btnSend').button('loading');
            MethodService("Facturas", "FacturacionReSendMail", JSON.stringify(params), 'EndCallbackupdate');
        }
    });

});

function loadlog() {
    if (window.gridenlog === undefined) {
        window.gridenlog = $("#tbllog").bootgrid({
            ajax: true,
            columnSelection: false,
            post: function () {
                return {
                    'params': "{id:'" + $('#id_proce').val() + "', tipo :" + $('#tipodocument').val() + "}",
                    'class': 'Facturas',
                    'method': 'FacturarListLog'
                };
            },
            url: window.appPath + "/Pages/Connectors/ConnectorList.ashx"
        });
    }
    else
        window.gridenlog.bootgrid('reload');

    $('#ModalLog').modal({ backdrop: 'static', keyboard: false }, "show");
}

function EndCallbackGet(params, answer) {
    if (!answer.Error) {
        toastr.success(answer.Message, 'Sintesis ERP');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
    window.griderror.bootgrid('reload');
}

function EndCallbackupdate(params, answer) {
    if (!answer.Error) {
        $('#ModalMail').modal('hide');
        toastr.success(answer.Message, 'Sintesis ERP');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
    $('#btnSend').button('reset');
}

function EndCallbackPrevent(params, answer) {
    if (!answer.Error) {
        loadtablePrevent();
        toastr.success(answer.Message, 'Sintesis ERP');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}

function loadtableSuccess() {
    window.gridsuccess = Loadtable('tblfactsuccess', 'S', 'SUCCESS');
    window.gridsuccess.on("loaded.rs.jquery.bootgrid", function () {
        // Executes after data is loaded and rendered 
        window.gridsuccess.find(".command-zip").on("click", function (e) {
            tipodoc = $(this).data("row-tipodoc");
            code = (tipodoc == '1') ? "MOVFACTURAE" : "MOVDEVFACTURAE";
            cufe = $(this).data("row-cufe");
            parametros = "cufe|" + cufe;

            var href = window.appPath + "/Pages/Connectors/ConnectorReport.ashx?op=zip&params=" + parametros + "&idreport=" + code + "&type=CODE";
            download(href, cufe + ".zip");

        }).end().find(".command-view").on("click", function (e) {
            tipodoc = $(this).data("row-tipodoc");
            code = (tipodoc == '1') ? "MOVFACTURAE" : "MOVDEVFACTURAE";
            cufe = $(this).data("row-cufe");
            parametros = "cufe|" + cufe;

            PrintDocument(parametros, code, 'CODE');

        }).end().find(".command-log").on("click", function (e) {
            id = $(this).data("row-id");
            $('#id_proce').val(id);
            loadlog();
        }).end().find(".command-mail").on("click", function (e) {
            id = $(this).data("row-id");
            $('#btnSend').attr({ 'data-id': id, 'data-tipodoc': $(this).data("row-tipodoc") });
            $('#ds_email').val('');
            $('#ModalMail').modal({ backdrop: 'static', keyboard: false }, 'show');
        });
    });
}

function loadtablePrevent() {
    window.gridPrevent = Loadtable('tblfacpendietes', 'P', 'PREVIA');
}

function loadtableError() {
    window.griderror = Loadtable('tblfacerror', 'E', 'ERROR');
    window.griderror.on("loaded.rs.jquery.bootgrid", function () {
        // Executes after data is loaded and rendered 
        window.griderror.find(".command-edit").on("click", function (e) {
            if (confirm("Desea enviar este documento?")) {
                id = $(this).data("row-id");
                params = {};
                params.key = id;
                params.op = $(this).data("row-op");
                MethodService("Facturas", "ProcesoFacturarToken", JSON.stringify(params), 'EndCallbackGet');
            }
        }).end().find(".command-log").on("click", function (e) {
            id = $(this).data("row-id");
            $('#id_proce').val(id);
            $('#tipodocument').val($(this).data("row-tipodoc"))
            loadlog();
        });
    });
}