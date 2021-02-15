//JSON para validar que no deje los campos vacíos
var JsonValidate = [
    { id: 'nombre', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'app', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];

//Evento que se activa cuanod el ususario pulsa click en el botón de guardar
$('#btnSave').click(function (e) {
    if (validate(JsonValidate)) {
        var params = {};
        params.id = $(this).attr('data-id');
        params.nombre = $('#nombre').val();
        params.app = $('#app').val();
        params.descripcion = $('#descripcion').val();
        params.menus = setMultiSelect('menus');
        params.reportes = setMultiSelect('reportes');
        MethodService("Perfiles", "PerfilesSave", JSON.stringify(params), "EndCallBackPerfilesSave");
    }
});
//Function que da la respuesta de la base de datos luego de guardar un nuevo perfil
function EndCallBackPerfilesSave(params, answer) {
    if (!answer.Error) {
        window.gridperfil.bootgrid('reload');
        toastr.success(answer.Message, 'Sintesis ERP');
        $('#ModalPerfiles').modal("hide");
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }

    $('#btnSave').button('reset');   
}
//Function para limpiar los campos del modal
function formReset() {
    div = $('#ModalPerfiles');
    div.find('input.form-control').val('');
    div.find('textarea').val('');
    div.find('select').val('').selectpicker('refresh');
    $('#btnSave').attr('data-id', '0');
}
//Evento que muestra el modal
$('.iconnew').click(function () {
    formReset();
    $('#ModalPerfiles').modal('show');
});

window.gridperfil;
//Function para llenar la tabla de información
function Loadtable() {
    window.gridperfil = $("#tblperfiles").bootgrid({
        ajax: true,
        post: function () {
            return {
                'params': "",
                'class': 'Perfiles',
                'method': 'PerfilesList'
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
            }
        }
    }).on("loaded.rs.jquery.bootgrid", function () {
        // Executes after data is loaded and rendered 
        window.gridperfil.find(".command-edit").on("click", function (e) {
            removeerror();
            id = $(this).data("row-id")
            params = {};
            params.id = id;
            MethodService("Perfiles", "PerfilesGet", JSON.stringify(params), 'EndCallbackGet');
        }).end().find(".command-delete").on("click", function (e) {
            if (confirm("Desea eliminar el Perfil?")) {
                id = $(this).data("row-id");
                params = {};
                params.id = id;
                MethodService("Perfiles", "PerfilesDelete", JSON.stringify(params), 'EndCallbackupdate');
            }
        }).end().find(".command-state").on("click", function (e) {
            id = $(this).data("row-id");
            params = {};
            params.id = id;
            MethodService("Perfiles", "PerfilesState", JSON.stringify(params), 'EndCallbackupdate');
        });
    });
}
//Function que muestra la información proveniente de la base de datos en la interfaz
function EndCallbackGet(params, Result) {
    if (!Result.Error) {
        formReset();
        data = Result.Row;
        $('#btnSave').attr('data-id', data.id);
        $('#nombre').val(data.nombre);
        $('#app').val(data.app).selectpicker('refresh');
        $('#descripcion').val(data.descripcion);
        if (data.menus !== null) {
            menu = data.menus.split(',');
            $('#menus').val(menu).selectpicker('refresh');
        }if (data.reportes !== null) {
            reporte = data.reportes.split(',');
            $('#reportes').val(reporte).selectpicker('refresh');
        }
        $('#ModalPerfiles').modal({ backdrop: 'static', keyboard: false }, 'show');
    } else {
        toastr.error(Result.Message, 'Sintesis ERP');
    }
}
//Function para actualizar la tabla luego de eliminar una fila o actualizar un elemento de esta
function EndCallbackupdate(params, Result) {
    if (!Result.Error) {
        toastr.success(Result.Message, 'Sintesis ERP');
        window.gridperfil.bootgrid('reload');
    } else {
        toastr.error(Result.Message, 'Sintesis ERP');
    }
}

$(document).ready(function () {
    Loadtable();
});