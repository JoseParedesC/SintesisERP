var JsonValidate = [{ id: 'code', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'descripcion', type: 'TEXT', htmltype: 'TEXTAREA', required: true, depends: false, iddepends: '' }];

window.commodity;
function LoadTable() {
    window.commodity = $('#tblcommodity').bootgrid({
        ajax: true,
        post: function () {
            return {
                'params': "",
                'class': 'Nomina',
                'method': 'DiagnosticoList'
            };
        },
        url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
        formatters: {
            "edit": function (column, row) {
                return "<a class=\"action command-edit\" data-id=\"" + row.id + "\"><span class=\"fa-2x fa fa-pencil text-princ iconfa\"></span></a>";
            },
            "delete": function (column, row) {
                return "<a class=\"action command-delete\" data-id=\"" + row.id + "\"><span class=\"fa-2x fa fa-trash-o text-danger iconfa\"></span></a>";
            },
            "state": function (column, row) {
                clas = row.estado == 1 ? "fa-square-o text-danger" : "fa-check-square-o text-success"
                return "<a class=\"action command-state\" data-id=\"" + row.id + "\"><span class=\"fa-2x fa " + clas + " iconfa\"></span></a>";
            }
        }
    }).on("loaded.rs.jquery.bootgrid", function () {
        window.commodity.find(".command-edit").on("click", function (e) {
            params = {};
            params.id = $(this).attr("data-id");
            MethodService("Nomina", "Diagnosticoget", JSON.stringify(params), "EndCallBackGet");
        }).end().find(".command-delete").on("click", function (e) {
            if (confirm("Está seguro que desea eliminarlo?")) {
                params = {};
                params.id = $(this).attr("data-id");
                MethodService("Nomina", "DiagnosticoDelete", JSON.stringify(params), "EndCallBackDelete");
            }
        }).end().find(".command-state").on("click", function () {
            params = {};
            params.id = $(this).attr("data-id");
            MethodService("Nomina", "DiagnosticoState", JSON.stringify(params), "EndCallBackState");
        })
    });

}

$(document).ready(function() {

    LoadTable();

    $('.iconnew').click(function (e) {
        formReset();
        $('#ModalDiagnostico').modal({ backdrop: 'static', keyboard: false }, 'show');
    });

    $("#btnSave").click(function () {
        if (validate(JsonValidate)) {
            var params = {}
            params.id = ($('#btnSave').attr('data-id') == undefined ? 0 : $('#btnSave').attr('data-id'))
            params.code = $('#code').val()
            params.descripcion = $('#descripcion').val()
            MethodService("Nomina", "DiagnosticoSave", JSON.stringify(params), "EndCallBackSaveUpdate");
        }
    });
});

function formReset() {
    $("#btnSave").removeAttr('data-id');
    $('input').val('')
    $('textarea').val('')
    $('input').closest('.error').removeClass('error')
}

function EndCallBackGet(params, answer) {
    if (!answer.Error) {
        data = answer.Row
        $("#btnSave").attr('data-id', data.id);
        $('#code').val(data.codigo)
        $('#descripcion').val(data.descripcion)
        $('input').closest('.error').removeClass('error')
        $('#ModalDiagnostico').modal({ backdrop: 'static', keyboard: false }, 'show');
    } else {
        toastr.error(answer.Message, "Sintesis ERP");
    }
}

function EndCallBackDelete(params, answer) {
    if (!answer.Error) {
        window.commodity.bootgrid('reload');
        toastr.success("Proceso ejecutado correctamente", "Sintesis ERP");
    } else {
        toastr.error(answer.Message, "Sintesis ERP");
    }
}

function EndCallBackState(params, answer) {
    if (!answer.Error) {
        window.commodity.bootgrid('reload');
        toastr.success("Registro Exitoso", "Sintesis ERP");
    } else {
        toastr.error(answer.Message, "Sintesis ERP");
    }
}

function EndCallBackSaveUpdate(params, answer) {
    if (!answer.Error) {
        formReset();
        $('#ModalDiagnostico').modal('hide');
        window.commodity.bootgrid('reload');
        toastr.success("Registro Exitoso", "Sintesis ERP");
    } else {
        toastr.error(answer.Message, "Sintesis ERP");
    }
}