var JsonValidate = [
    { id: 'fecha', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'ds_centro', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'ds_cancel', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'ds_cierre', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'ano', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }
];

window.gridcierre;
function Loadtable() {
    window.gridcierre = $("#tblcierre").bootgrid({
        ajax: true,
        navigation: false,
        post: function () {
            return {
                'params': function () {
                    var params = {};
                    params.id_cierre = $('#btnRev').attr('data-id') == undefined ? 0 : $('#btnRev').attr('data-id');
                    return JSON.stringify(params);
                },
                'class': 'CierreContable',
                'method': 'CierreContableList' 
            };
        },
        url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
        formatters: {
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
window.gridmovcierre;
function loadTableMov() {
    window.gridmovcierre = $("#tblmovcierre").bootgrid({
        ajax: true,
        post: function () {
            return {
                'params': '',
                'class': 'CierreContable',
                'method': 'CierreContableMovList'
            };
        },
        url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
        formatters: {
            "ver": function (column, row) {
                return "<a class=\"action command-edit\" data-row-id=\"" + row.id + "\"><span class=\"fa-2x fa fa-eye iconfa\"></span></a>";
            }
        }
    }).on("loaded.rs.jquery.bootgrid", function () {
        window.gridmovcierre.find(".command-edit").on("click", function (e) {
            id = $(this).data("row-id")
            $('#btnRev').attr('data-id', id);
            params = {};
            params.id = id;
            MethodService("CierreContable", "CierreContableGet", JSON.stringify(params), "EndCallBackGet");
        })
    });
}

$('#btnList').click(function (e) {
    loadTableMov();
    $('#ModalCierreContable').modal('show');
})

$('#btnSave').click(function (e) {
    if (validate(JsonValidate)) {
        params = {};
        params.cancel = $('#id_cancel').val();
        params.cierre = $('#id_cierre').val();
        params.fecha = SetDate($('#fecha').val());
        params.descrip = $('#descrip').val();
        params.centro = $('#id_centro').val();
        params.ano = $('#ano').val()+'12';
        params.id = $('#btnRev').attr('data-id') == undefined ? 0 : $('#btnRev').attr('data-id');
        MethodService("CierreContable", "CierreContableSave", JSON.stringify(params), "EndCallBackSave");
    }
});

$('#btnRev').click(function (e) {
    if (confirm("Desea revertir el cierre contable?")) {
        params = {};
        params.cancel = $('#id_cancel').val();
        params.cierre = $('#id_cierre').val();
        params.fecha = SetDate($('#fecha').val());
        params.descrip = $('#descrip').val();
        params.centro = $('#id_centro').val();
        params.ano = $('#ano').val() + '12';
        params.id = $('#btnRev').attr('data-id') == undefined ? 0 : $('#btnRev').attr('data-id');
        MethodService("CierreContable", "CierreContableSave", JSON.stringify(params), "EndCallBackSave");
    }
});

$('#btnnew').click(function () {
    Resest();
    window.gridcierre.bootgrid('reload');
    $('#btnSave').attr('disabled', false);
    $('#btnRev').attr('disabled', true);
})

function EndCallBackSave(params, answer) {
    if (!answer.Error) {
        consc = answer.Value;
        toastr.success(answer.Message, 'Sintesis ERP');
        window.gridmovcierre.bootgrid('reload');
        window.gridcierre.bootgrid('reload');
        $('#consecutivo').text(consc);
    } else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}

function EndCallBackGet(params, result) {
    if (!result.Error) {
        $('#btnSave').attr('disabled', true);
        $('#btnRev').attr('disabled', false);
        data = result.Row;
        $('#consecutivo').text($('#btnRev').attr('data-id'));
        $('#fecha').val(data.fecha);
        $('#ds_centro').val(data.centro);
        $('#ds_cancel').val(data.cancel);
        $('#ds_cierre').val(data.cierre);
        $('#descrip').val(data.descrip);
        $('#ano').val(data.anomes);
        window.gridcierre.bootgrid('reload');
        $('#ModalCierreContable').modal('hide');
    } else {
        toastr.error(result.Message, 'Sintesis ERP');
    }
}

function Resest() {
    $('#btnRev').attr('data-id', 0);
    $('input.form-control').val('');
    $('#fecha').text(datepicker()).selectpicker('refresh');
    $('#descrip').val('');
    $('#consecutivo').text('0');
}

$(document).ready(function () {
    datepicker();
    Loadtable();
});