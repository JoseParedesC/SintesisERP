//Vector  de validación
var JsonValidate = [{ id: 'Text_Nombre', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];

window.gridtip;
//Funcion para el cargado de la información en la tabla de listado de las categorias ya guardadas.
function Loadtable() {
    window.gridtip = $("#tbltipo").bootgrid({
        ajax: true,
        post: function () {
            return {
                'params': "",
                'class': 'CategoriaProducto',
                'method': 'CategoriaProductoList'
            };
        },
        url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
        formatters: {
            "edit": function (column, row) {
                return "<a class=\"action command-edit\" data-row-id=\"" + row.id + "\"><span class=\"fa-2x fa fa-pencil iconfa\"></span></a>";
            },
            "state": function (column, row) {
                return "<a class=\"action command-state\" data-row-id=\"" + row.id + "\">"+
                    "<span class=\"fa fa-2x fa-fw "+
                    ((!row.estado) ? "fa-square-o text-danger" : "fa-check-square-o text-success") + "  iconfa\"></span></a>";
            },
            "delete": function (column, row) {
                return "<a class=\"action command-delete\" data-row-id=\"" + row.id + "\"><span class=\"fa fa-2x fa-trash-o text-danger iconfa\"></span></a>";
            }
        }
    }).on("loaded.rs.jquery.bootgrid", function () {        
        window.gridtip.find(".command-edit").on("click", function (e) {
            removeerror();
            id = $(this).data("row-id")
            params = {};
            params.id = id;
            MethodService("CategoriaProducto", "CategoriaProductoGet", JSON.stringify(params), 'EndCallbackGet');
        }).end().find(".command-delete").on("click", function (e) {
            if (confirm("Desea eliminar la categoria?")) {
                id = $(this).data("row-id");
                params = {};
                params.id = id;
                MethodService("CategoriaProducto", "CategoriaProductoDelete", JSON.stringify(params), 'EndCallbackupdate');
            }
        }).end().find(".command-state").on("click", function (e) {
            id = $(this).data("row-id");
            params = {};
            params.id = id;
            MethodService("CategoriaProducto", "CategoriaProductoState", JSON.stringify(params), 'EndCallbackupdate');
        });
    });
}

$(document).ready(function () {
    Loadtable();
});

//Función utilizada para hacer visible el formulado de un nuevo registro
$('.iconnew').click(function (e) {
    formReset();
    $('#ModalTipoArticle').modal({ backdrop: 'static', keyboard: false }, 'show');
});

//Resetear los campos del formulario
function formReset() {
    div = $('#ModalTipoArticle');
    div.find('input.form-control').val('');
    $('#Text_CodigoBarra').focus();
    $('#btnSave').attr('data-id', '0');
}

//Funcion del boton guardar
$('#btnSave').click(function (e) {
    if (validate(JsonValidate)) {
        params = {};
        params.id = $(this).attr('data-id');
        params.nombre = $('#Text_Nombre').val();
        var btn = $(this);
        btn.button('loading');
        MethodService("CategoriaProducto", "CategoriaProductoSave", JSON.stringify(params), "EndCallbackSave");
    }
});

//Funcion de retorno de la respuesta del servidor al guardar
function EndCallbackSave(params, answer) {
    if (!answer.Error) {
        $('#ModalTipoArticle').modal("hide");
        window.gridtip.bootgrid('reload');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
    $('#btnSave').button('reset');
}

//Funcion de retorno de la respuesta del servidor al consultar una categoria
function EndCallbackGet(params, answer) {
    if (!answer.Error) {
        data = answer.Row;
        $('#btnSave').attr('data-id', data.id);
        $('#Text_Nombre').val(data.nombre);
        $('#ModalTipoArticle').modal({ backdrop: 'static', keyboard: false }, 'show');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}

//Funcion de retorno de la respuesta del servidor al Cambiar estado
function EndCallbackupdate(params, answer) {
    if (!answer.Error) {
        toastr.success("Proceso ejecutado exitosamente", 'Sintesis ERP');
        window.gridtip.bootgrid('reload');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}
