var JsonValidate = [{ id: 'nombre', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'ds_ciudad', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' }];

window.commodity;
function LoadTable() {
    window.commodity = $('#tblcommodity').bootgrid({
        ajax: true,
        post: function () {
            return {
                'params': "",
                'class': 'Nomina',
                'method': 'SedesList'
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
            MethodService("Nomina", "SedesGet", JSON.stringify(params), "EndCallBackGet");
        }).end().find(".command-delete").on("click", function (e) {
            if (confirm("Está seguro que desea eliminarlo?")) {
                params = {};
                params.id = $(this).attr("data-id");
                MethodService("Nomina", "SedesDelete", JSON.stringify(params), "EndCallBackDelete");
            }
        }).end().find(".command-state").on("click", function () {
            params = {};
            params.id = $(this).attr("data-id");
            MethodService("Nomina", "sedesState", JSON.stringify(params), "EndCallBackState");
        })
    });

}

$(document).ready(function() {

    LoadTable();

    $('.iconnew').click(function (e) {
        formReset();
        $('#ModalAddSede').modal({ backdrop: 'static', keyboard: false }, 'show');
    });

    $("#btnSave").click(function () {
        if (validate(JsonValidate)) {
            var params = {}
            params.id = ($('#btnSave').attr('data-id') == undefined ? 0 : $('#btnSave').attr('data-id'))
            params.nombre = $('#nombre').val()
            params.id_city = $('#ds_ciudad').val()
            MethodService("Nomina", "SedesSaveUpdate", JSON.stringify(params), "EndCallBackSaveUpdate");
        }
    });
});

function formReset() {
    $("#btnSave").removeAttr('data-id');
    $('#nombre, #ds_ciudad').val('')
    $('#ds_ciudad').selectpicker('refresh')

}

function EndCallBackGet(params, answer) {
    if (!answer.Error) {
        data = answer.Row
        console.log(data)
        $("#btnSave").attr('data-id', data.id);
        $('#nombre').val(data.nombre)
        $('#ds_ciudad').val(data.id_ciudad)
        $('#ds_ciudad').selectpicker('refresh')

        $('#ModalAddSede').modal({ backdrop: 'static', keyboard: false }, 'show');
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
        $('#ModalAddSede').modal('hide');
        window.commodity.bootgrid('reload');
        toastr.success("Registro Exitoso", "Sintesis ERP");
    } else {
        toastr.error(answer.Message, "Sintesis ERP");
    }
}