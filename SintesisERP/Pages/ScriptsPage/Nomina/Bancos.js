/* Se valida si las casillas del formulario
    están vacios */
var JsonValidate = [
    { id: 'nombreBanco', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }
];

window.gridbanco;
/*carga la tabla mostrada en Bancos.aspx 
utilisando la función c# BancosList*/
function Loadtable() {
    window.gridbanco = $("#tblbancos").bootgrid({
        ajax: true,
        post: function () {
            return {
                'params': "",
                'class': 'Bancos',
                'method': 'BancosList'
            };
        },
        url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
        formatters: {
            //agrega el boton del lapiz en la columna 'editar' de la tabla
            "edit": function (column, row) {
                return "<a class=\"action command-edit\" data-row-id=\"" + row.id + "\"><span class=\"fa-2x fa fa-pencil iconfa\"></span></a>";
            },
            //agrega el boton de la basura en la columna 'eliminar' de la tabla
            "delete": function (column, row) {
                return "<a class=\"action command-delete\" data-row-id=\"" + row.id + "\"><span class=\"fa fa-2x fa-trash-o text-danger iconfa\"></span></a>";
            },
            //agrega el boton de la basura en la columna 'eliminar' de la tabla
            "estado": function (column, row) {
                clas = row.estado == 0 ? "fa-square-o text-danger" : "fa-check-square-o text-success"
                return "<a class=\"action command-estado\" data-row-id=\"" + row.id + "\"><span class=\"fa-2x fa " + clas + " iconfa\"></span></a>";
            }
        }
    }).on("loaded.rs.jquery.bootgrid", function () {
        // Executes after data is loaded and rendered 

        /*reconoce la accion del click en los botones y los envia a la clase 
         * Bancos en sus respectivas funciónes para 'editar' y 'eliminar' respectivamente */
        window.gridbanco.find(".command-edit").on("click", function (e) {
            removeerror();
            id = $(this).data("row-id")
            params = {};
            params.id = id;
            MethodService("Bancos", "BancosGet", JSON.stringify(params), 'EndCallbackGet');
        }).end().find(".command-delete").on("click", function (e) {
            if (confirm("Desea eliminar esta fecha?")) {
                id = $(this).data("row-id");
                params = {};
                params.id = id;
                MethodService("Bancos", "BancosDelete", JSON.stringify(params), 'EndCallbackupdate');
            }
        });

    });
}

/*función predeterminada para verificar que el codigo 
javascript esté listo para ejecutarse*/
$(document).ready(function () {
    Loadtable();
    datepicker();
});


/*función para el boton circular diseñado en Bancos.aspx
para llamar el formulario creado en la misma*/
$('.iconnew').click(function (e) {
    $('#ModalBanco').modal({ backdrop: 'static', keyboard: false }, 'show');
    formReset();
});

//función para limpiar el formulario
function formReset() {
    $('#nombreBanco').val("");
    $('#btnSave').attr('data-id', '0');
};

/*funcion para obtener los datos del formulario 
y enviarlo a la funcion BancosSave*/
$('#btnSave').click(function (e) {
    if (validate(JsonValidate)) {
        params = {};
        params.id = $(this).attr('data-id');
        params.nombre = $('#nombreBanco').val();
        var btn = $(this);
        btn.button('loading');
        MethodService("Bancos", "BancosSave", JSON.stringify(params), "EndCallbackArticle");
    }
});

//función para cerrar el formulario, limpia el btnSave y recarga la pagina 
function EndCallbackArticle(params, answer) {
    if (!answer.Error) {
        $('#ModalBanco').modal("hide");
        window.gridbanco.bootgrid('reload');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }

    $('#btnSave').button('reset');
}

/*Carga el formulario con la información de un registro 
solicitado con el botón de la editar de la tabla */
function EndCallbackGet(params, answer) {
    if (!answer.Error) {
        data = answer.Row;
        $('#btnSave').attr('data-id', data.id);
        $('#nombreBanco').val(data.nombre);
        $('#ModalBanco').modal({ backdrop: 'static', keyboard: false }, 'show');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}

/*recarga la tabla Bancos.aspx*/
function EndCallbackupdate(params, answer) {
    if (!answer.Error) {
        window.gridbanco.bootgrid('reload');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}