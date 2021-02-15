//Vector  de validación
var JsonValidate = [
    { id: 'codigo', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'Text_Nombre', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];


/*
 * Elaborado Por: Jeteme
 * 
 *Funcion de carga de tabla con atributo nombre 
 * de la grilla donde se le pasa caracteristica de ajax y jquery 
 */
//Funcion para el cargado de la información en la tabla de listado de las Marcas ya guardadas.
function Loadtable() {
    window.gridmarca = $("#tblVendedores").bootgrid({ //  
        ajax: true,
        post: function () {
            return {
                'params': "",
                'class': 'Usuarios',
                'method': 'VendedoresList'
            };
        },
        url: window.appPath + "/Pages/Connectors/ConnectorList.ashx", //conecta los metodos con los controladores
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
        window.gridmarca.find(".command-edit").on("click", function (e) {
            removeerror();
            id = $(this).data("row-id")
            params = {};
            params.id = id;
            MethodService("Usuarios", "VendedoresGet", JSON.stringify(params), 'EndCallbackGet');
        }).end().find(".command-delete").on("click", function (e) {
            if (confirm("Desea eliminar el Vendedor?")) {
                id = $(this).data("row-id");
                params = {};
                params.id = id;
                MethodService("Usuarios", "VendedoresDelete", JSON.stringify(params), 'EndCallbackupdate');
            }
        }).end().find(".command-state").on("click", function (e) {
            id = $(this).data("row-id");
            params = {};
            params.id = id;
            MethodService("Usuarios", "VendedoresState", JSON.stringify(params), 'EndCallbackupdate');
        });
    });
}

/*
 * Elaborado por: Jeteme
 * carga la grilla de tipo documentos al momento que el documento este listo
 * */
$(document).ready(function () {
    Loadtable();
});


//Función utilizada para hacer visible el formulado de un nuevo registro
$('.iconnew').click(function (e) {
    formReset();

    $('#ModalVendedores').modal({ backdrop: 'static', keyboard: false }, 'show');
});

//Resetear los campos del formulario
function formReset() {
    div = $('#ModalVendedores');
    div.find('input.form-control').val('');
    div.find('textarea').val('');
    $('#btnSave').attr('data-id', '0');

}



//Funcion del boton guardar
$('#btnSave').click(function (e) {
    if (validate(JsonValidate)) {// valida si los campos cumplen con las condiciones estipuladas en el Json creado a principio de JS
        params = {};
        params.id = $(this).attr('data-id');
        params.codigo = $('#codigo').val();
        params.nombre = $('#Text_Nombre').val();
        var btn = $(this);
        btn.button('loading');
        MethodService("Usuarios", "VendedoresSave", JSON.stringify(params), "EndCallbackMarca");
    }
});

//Funcion de retorno de la respuesta del servidor al guardar
function EndCallbackMarca(params, answer) { // 
    if (!answer.Error) {
        $('#ModalVendedores').modal("hide");
        window.gridmarca.bootgrid('reload');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP'); // mensaje de error si hay un error de base de datos
    }

    $('#btnSave').button('reset');
}

//Funcion de retorno de la respuesta del servidor al consultar una categoria
function EndCallbackGet(params, answer) {
    if (!answer.Error) {
        data = answer.Row;
        $('#btnSave').attr('data-id', data.id);
        $('#codigo').val(data.codigo);
        $('#Text_Nombre').val(data.nombre);


        $('#ModalVendedores').modal({ backdrop: 'static', keyboard: false }, 'show');  // muestra el modal
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}
//Funcion de retorno de la respuesta del servidor al Cambiar estado
function EndCallbackupdate(params, answer) { // actualiza la grilla
    if (!answer.Error) {
        window.gridmarca.bootgrid('reload');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}



