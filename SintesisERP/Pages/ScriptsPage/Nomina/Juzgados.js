var JsonValidate = [{ id: 'code', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
    { id: 'code_ext', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
    { id: 'detalle', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' }];

window.tbljuzgados;
function LoadTable() {
    window.tbljuzgados = $('#tbljuzgados').bootgrid({
        ajax: true,
        post: function () {
            return {
                'params': "",
                'class': 'Juzgados',
                'method': 'JuzgadosList'
            };
        },
        url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
        formatters: {
            "edit": function (column, row) {
                return "<a class=\"action command-edit\" data-id=\"" + row.id + "\"><span class=\"fa-2x fa fa-pencil text-success iconfa\"></span></a>";
            },
            "delete": function (column, row) {
                return "<a class=\"action command-delete\" data-id=\"" + row.id + "\"><span class=\"fa-2x fa fa-trash text-danger iconfa\"></span></a>";
            },
            "state": function (column, row) {
                clas = row.estado == 1 ? "fa-square-o text-danger" : "fa-check-square-o text-success"
                return "<a class=\"action command-state\" data-id=\"" + row.id + "\"><span class=\"fa-2x fa " + clas + " iconfa\"></span></a>";
            }
        }
    }).on("loaded.rs.jquery.bootgrid", function () {
        window.tbljuzgados.find(".command-edit").on("click", function (e) {
            params = {};
            params.id = $(this).attr("data-id");
            MethodService("Juzgados", "JuzgadosGet", JSON.stringify(params), "EndCallBackGetJuzgados");
        }).end().find(".command-delete").on("click", function (e) {
            if (confirm("Está seguro que desea eliminarlo?")) {
                params = {};
                params.id = $(this).attr("data-id");
                MethodService("Juzgados", "JuzgadosDelete", JSON.stringify(params), "EndCallBackDelete");
            }
        }).end().find(".command-state").on("click", function () {
            params = {};
            params.id = $(this).attr("data-id");
            MethodService("Juzgados", "JuzgadosState", JSON.stringify(params), "EndCallBackState");
        })
    });

}

$(document).ready(function() {

    LoadTable();

    $('.iconnew').click(function (e) {
        formReset();
        $('#ModalAddJuzgado').modal({ backdrop: 'static', keyboard: false }, 'show');
    });

    $("#btnSave").click(function () {
        SendJuzgado()
    });
});

function formReset() {
    $("#btnSave").removeAttr('data-id');
    $('#code, #code_ext, #detalle').val('')

}

function SendJuzgado() {
    if (validate(JsonValidate)) {
        var params = {}
        params.id = ($('#btnSave').attr('data-id') == undefined ? 0 : $('#btnSave').attr('data-id'))
        params.code = $('#code').val()
        params.code_ext = $('#code_ext').val()
        params.detalle = $('#detalle').val()
        MethodService("Juzgados", "JuzgadosSaveUpdate", JSON.stringify(params), "EndCallBackSaveUpdate");
    }
}

function EndCallBackGetJuzgados(params, answer) {
    if (!answer.Error) {
        data = answer.Row
        console.log(data)
        $("#btnSave").attr('data-id', data.id);
        $('#code').val(data.codigo)
        $('#code_ext').val(data.codigo_ext)
        $('#detalle').val(data.detalle)

        $('#ModalAddJuzgado').modal({ backdrop: 'static', keyboard: false }, 'show');
    } else {
        toastr.error(answer.Message, "Sintesis ERP");
    }
}

function EndCallBackDelete(params, answer) {
    if (!answer.Error) {
        window.tbljuzgados.bootgrid('reload');
        toastr.success("Proceso ejecutado correctamente", "Sintesis ERP");
    } else {
        toastr.error(answer.Message, "Sintesis ERP");
    }
}

function EndCallBackState(params, answer) {
    if (!answer.Error) {
        window.tbljuzgados.bootgrid('reload');
        toastr.success("Registro Exitoso", "Sintesis ERP");
    } else {
        toastr.error(answer.Message, "Sintesis ERP");
    }
}

function EndCallBackSaveUpdate(params, answer) {
    if (!answer.Error) {
        formReset();
        $('#ModalAddJuzgado').modal('hide');
        window.tbljuzgados.bootgrid('reload');
        toastr.success("Registro Exitoso", "Sintesis ERP");
    } else {
        toastr.error(answer.Message, "Sintesis ERP");
    }
}