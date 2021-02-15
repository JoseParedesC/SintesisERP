var JsonValidate = [{ id: 'username', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'name', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'id_profile', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
{ id: 'email', type: 'EMAIL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'phone', type: 'REAL', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
{ id: 'id_shift', type: 'REAL', htmltype: 'SELECT', required: false, depends: false, iddepends: '' }];

window.gridusuar;
function Loadtable() {
    window.gridusuar = $("#tblusuar").bootgrid({
        ajax: true,
        post: function () {
            return {
                'params': "",
                'class': 'Usuarios',
                'method': 'UsuariosList'
            };
        },
        url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
        formatters: {
            "edit": function (column, row) {
                return "<a class=\"action command-edit\" data-row-id=\"" + row.id + "\"><span class=\"fa-2x fa fa-pencil iconfa\"></span></a>";
            },
            "state": function (column, row) {
                return "<a class=\"action command-state\" data-row-id=\"" + row.id + "\">" +
                    "<span class=\"fa fa-2x fa-fw " +
                    ((!row.estado) ? "fa-square-o text-danger" : "fa-check-square-o text-success") + "  iconfa\"></span></a>";
            },
            "delete": function (column, row) {
                return "<a class=\"action command-delete\" data-row-id=\"" + row.id + "\"><span class=\"fa fa-2x fa-trash-o text-danger iconfa\"></span></a>";
            },
            "restore": function (column, row) {
                return "<a class=\"action command-restore\" data-row-user=\"" + row.username + "\"  data-row-id=\"" + row.id + "\"><span class=\"fa fa-2x fa-key text-info iconfa\"></span></a>";
            }
        }
    }).on("loaded.rs.jquery.bootgrid", function () {
        // Executes after data is loaded and rendered 
        window.gridusuar.find(".command-edit").on("click", function (e) {
            removeerror();
            id = $(this).data("row-id")
            params = {};
            params.id = id;
            MethodService("Usuarios", "UsuariosGet", JSON.stringify(params), 'EndCallbackGet');
        }).end().find(".command-delete").on("click", function (e) {
            if (confirm("Desea eliminar el Artículo?")) {
                id = $(this).data("row-id");
                params = {};
                params.id = id;
                MethodService("Usuarios", "UsuariosDelete", JSON.stringify(params), 'EndCallbackupdate');
            }
        }).end().find(".command-state").on("click", function (e) {
            id = $(this).data("row-id");
            params = {};
            params.id = id;
            MethodService("Usuarios", "UsuariosState", JSON.stringify(params), 'EndCallbackupdate');
        }).end().find(".command-restore").on("click", function (e) {
            id = $(this).data("row-id");
            user = $(this).data("row-user");
            params = {};
            params.id = id;
            params.username = user;
            MethodService("Usuarios", "UsuariosRestoreKey", JSON.stringify(params), 'EndCallbackupdate');
        });
    });
}

$(document).ready(function () {
    Loadtable();
});

$('.iconnew').click(function (e) {
    $('#Text_Codigo').removeAttr('readonly');
    formReset();
    $('#ModalUsers').modal({ backdrop: 'static', keyboard: false }, 'show');
});

function formReset() {
    div = $('#ModalUsers');
    div.find('input.form-control').val('');
    div.find('textarea').val('');
    div.find('select').val('').selectpicker('refresh');
    $('#Text_CodigoBarra').focus();
    $('#btnSave').attr('data-id', '0');
}

$('#btnSave').click(function (e) {
    if (validate(JsonValidate)) {
        var params = {};
        params.id = $(this).attr('data-id');
        params.username = $('#username').val();
        params.identification = $('#identification').val();
        params.name = $('#name').val();
        params.id_shift = ($('#id_shift').val().trim() == "") ? "0" : $('#id_shift').val();
        params.phone = $('#phone').val();
        params.email = $('#email').val();
        params.ids_boxes = setMultiSelect('ids_boxes');
        params.id_profile = $('#id_profile').val();
        var btn = $(this);
        btn.button('loading');
        MethodService("Usuarios", "UsuariosSave", JSON.stringify(params), "EndCallbackUsersSave");
    }
});

function EndCallbackUsersSave(params, answer) {
    if (!answer.Error) {
        window.gridusuar.bootgrid('reload');
        $('#ModalUsers').modal("hide");
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }

    $('#btnSave').button('reset');
}


function EndCallbackGet(params, Result) {
    if (!Result.Error) {
        data = Result.Row;
        console.log(data)
        $('#btnSave').attr('data-id', data.id);
        $('#id_shift').val(data.id_turno);
        $('#id_profile').val(data.id_perfil).trigger('change');
        $('#username').val(data.username);
        $('#identification').val(data.identificacion);
        $('#name').val(data.nombre);
        $('#phone').val(data.telefono);
        $('#email').val(data.email);
        $('#ids_boxes').val(data.cajas.split(','));
        $('select').selectpicker('refresh')
        $('#ModalUsers').modal({ backdrop: 'static', keyboard: false }, 'show');
    }
    else {
        toastr.error(Result.Message, 'Sintesis ERP');
    }
}

function EndCallbackupdate(params, Result) {
    if (!Result.errMsg) {
        toastr.success("Proceso realizado exitosamente.", 'Sintesis Creditos');
        window.gridusuar.bootgrid('reload');
    }
    else {
        toastr.error(Result.Message, 'Sintesis Gestion Cartera');
    }
}

$('#id_profile').change(function () {
    if ($(this).val() == '3') {
        $('#ids_boxes').val('').removeAttr('disabled').selectpicker('refresh');
    }
    else {
        $('#ids_boxes').val('').attr('disabled', 'disabled').selectpicker('refresh');
    }
});