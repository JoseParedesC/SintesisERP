var JsonValidate = [
    { id: 'fecha', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];

window.gridconsol;
function Loadtable() {
    window.gridconsol = $("#tblconsoli").bootgrid({
        ajax: true,
        navigation: false,
        post: function () {
            return {
                'params': function () {
                    var params = {};
                    params.fecha = $('#fecha').val();
                    params.consolidado = $('#consolidados').is(':checked') ? 1 : 0;
                    params.id_conciliado = $('#btnRev').attr('data-id') == undefined ? 0 : $('#btnRev').attr('data-id');
                    return JSON.stringify(params);
                },
                'class': 'Consolidacion',
                'method': 'ConsolidacionList'
            };
        },
        url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
        formatters: {
            "estado": function (column, row) {
                return "<div class='check-mail'><input id='check-consol' type='checkbox' data-row-estado = " + row.estado + " class=\"action i-checks consol\" " + (row.estado === 1 ? "checked='checked', disabled='disabled'" : '') + "data-row-id=\"" + row.id + "\"/></div>";
            },
            "debito": function (column, row) {
                return '$ ' + row.debito.Money();
            },
            "credito": function (column, row) {
                return '$ ' + row.credito.Money();
            }
        }
    }).on("loaded.rs.jquery.bootgrid", function () {
        $('.i-checks').iCheck({
            checkboxClass: 'icheckbox_square-green',
            radioClass: 'iradio_square-green',
        });
    });
}
window.gridconciliado;
function loadConciliados() {
    window.gridconciliado = $('#tblmovconciliado').bootgrid({
        ajax: true,
        post: function () {
            return {
                'params': "",
                'class': 'Consolidacion',
                'method': 'ConsolidacionMovList'
            };
        },
        url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
        formatters: {
            "ver": function (column, row) {
                return "<a class=\"action command-edit\" data-row-id=\"" + row.id + "\"><span class=\"fa-2x fa fa-eye iconfa\"></span></a>";
            },
            "debito_t": function (column, row) {
                return '$ ' + row.debito_t.Money();
            },
            "credito_t": function (column, row) {
                return '$ ' + row.credito_t.Money();
            }
        }
    }).on("loaded.rs.jquery.bootgrid", function () {
        // Executes after data is loaded and rendered 
        window.gridconciliado.find(".command-edit").on("click", function (e) {
            id = $(this).data("row-id")
            $('#btnRev').attr('data-id', id);
            params = {};
            $('#fecha').val('');
            $('#consolidados').is(':checked') ? $('#consolidados').removeAttr('checked') : ''
            params.id_conciliado = id;
            MethodService("Consolidacion", "ConsolidacionGet", JSON.stringify(params), 'EndCallbackGet');
        })
    });
}

$('#btnRefreshTer').click(function (e) {
    if (validate(JsonValidate)) {
        window.gridconsol.bootgrid('reload');
    }
})

$('#btnList').click(function (e) {
    loadConciliados();
    window.gridconciliado.bootgrid('reload');
    $('#ModalConciliados').modal('show');
})

$('#btnSave').click(function (a) {
    var xml = '';
    $.each($('.i-checks'), function (i, e) {
        id = $(e).attr('data-row-id');
        estado = $(e).attr('data-row-estado');
        if ($(this).is(':checked') & id !== undefined & estado === "0") {
            xml += '<item id="' + id + '"/>'
        }
    });
    if (xml.length>0) {
        xml = '<items>' + xml + '</items>';
        params = {};
        params.xml = xml;
        params.id_conciliado = $('#btnRev').attr('data-id') == undefined ? 0 : $('#btnRev').attr('data-id');
        MethodService("Consolidacion", "ConsolidacionSave", JSON.stringify(params), "EndCallBackConsolidacion");
    } else {
        toastr.warning('Seleccione las transacciones que quiere conciliar', 'Sintesis ERP');
    }
});

$('#btnRev').click(function (e) {
    if (confirm('Desea revertir la conciliación?')) {
    var xml = '';
    xml = '<items>' + xml + '</items>';
    params = {};
    params.xml = xml;
    params.id_conciliado = $('#btnRev').attr('data-id') == undefined ? 0 : $('#btnRev').attr('data-id');
    MethodService("Consolidacion", "ConsolidacionSave", JSON.stringify(params), "EndCallBackConsolidacion");
    }
});

$('#btnnew').click(function (e) {
    $('#fecha, #consolidados').removeAttr('disabled');
    $('#btnSave').attr('disabled', false);
    $('#fecha').text(datepicker()).selectpicker('refresh');
    $('#btnRev').attr('disabled', true);
    $('#btnRev').attr('data-id', 0);
    $('#consecutivo').text(0);
    window.gridconsol.bootgrid('reload');
})

function getCounts() {
    params = {};
    MethodService("Consolidacion", "ConsolidacionCount", JSON.stringify(params), 'EndCallbackGetCount');
}

function EndCallbackGetCount(params, Result) {
    if (!Result.Error) {
        data = Result.Row;
        $('#noconciliados').text(data.porconciliar);
        $('#conciliados').text(data.conciliados);
    } else {
        toastr.warning('Seleccione una transaccion para conciliar', 'Sintesis ERP');
    }
}

function EndCallbackGet(params, Result) {
    if (!Result.Error) {
        data = Result.Row;
        $('#fecha, #consolidados').attr('disabled', true);
        $('#btnSave').attr('disabled', true);
        $('#btnRev, #btnnew').attr('disabled', false);
        $('#ModalConciliados').modal('hide');
        $('#consecutivo').text(data.id);
        window.gridconsol.bootgrid('reload');
    } else {
        toastr.error(Result.Message, 'Sintesis ERP');
    }
}

function EndCallBackConsolidacion(params, answer) {
    if (!answer.Error) {
        $('#consecutivo').text(answer.Value);
        getCounts();
        toastr.success(answer.Message, 'Sintesis ERP');
        window.gridconsol.bootgrid('reload');
    } else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}

$(document).ready(function () {
    Loadtable();
    getCounts();
    $('.i-checks').iCheck({
        checkboxClass: 'icheckbox_square-green',
        radioClass: 'iradio_square-green',
    });
    datepicker();
});