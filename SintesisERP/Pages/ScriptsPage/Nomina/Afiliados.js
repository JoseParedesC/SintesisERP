//Vector  de validación
var JsonValidate = [{ id: 'identificacion', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'primnombre', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
    { id: 'segnombre', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
    { id: 'primape', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
    { id: 'segape', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
    { id: 'contra', type: 'TEXT', htmltype: 'SELECT', required: false, depends: false, iddepends: '' }
];


window.gridaplasos;
//Funcion para el cargado de la información en la tabla de listado de las bodegas ya guardadas.
function Loadtable() {
    window.gridaplasos = $("#tbleps").bootgrid({
        ajax: true,
        post: function () {
            return {
                'params': "",
                'class': 'Afiliados',
                'method': 'AfiliadosList'
            };
        },
        url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
        formatters: {
            "edit": function (column, row) {
                return "<a class=\"action command-edit\" data-row-id=\"" + row.id + "\"><span class=\"fa-2x fa fa-pencil iconfa\"></span></a>";
            },
            "delete": function (column, row) {
                return "<a class=\"action command-delete\" data-row-id=\"" + row.id + "\"><span class=\"fa fa-2x fa-trash-o text-danger iconfa\"></span></a>";
            }
        }
    }).on("loaded.rs.jquery.bootgrid", function () {
        // Executes after data is loaded and rendered 
        window.gridaplasos.find(".command-edit").on("click", function (e) {
            removeerror();
            id = $(this).data("row-id")
            params = {};
            params.id = id;
            MethodService("Afiliados", "AfiliadosGet", JSON.stringify(params), 'EndCallbackGet');
        }).end().find(".command-delete").on("click", function (e) {
            if (confirm("Desea eliminar este Cargo?")) {
                id = $(this).data("row-id");
                params = {};
                params.id = id;
                MethodService("Afiliados", "AfiliadosDelete", JSON.stringify(params), 'EndCallbackupdate');
            }
        });
    });
}

$(document).ready(function () {
    Loadtable();

});


//Función utilizada para hacer visible el formulado de un nuevo registro
$('.iconnew').click(function (e) {
    formReset();

    $('#ModalAfiliados').modal({ backdrop: 'static', keyboard: false }, 'show');
});

//Resetear los campos del formulario
function formReset() {
    div = $('#ModalAfiliados');
    div.find('input.form-control').val('');
    div.find('select.form-control').val('');
    $('#idafiliado').val(0);
    $('select').selectpicker();
}


//Funcion del boton guardar
$('#btnSave').click(function (e) {
    if (validate(JsonValidate)) {
        params = {};
        params.id = $('#idafiliado').val();
        params.tipoiden = $('#id_tipoiden').val();
        params.identi = $('#identificacion').val();
        params.pnombre = $('#primnombre').val();
        params.snombre = $('#segnombre').val();
        params.papellido = $('#primape').val();
        params.sapellido = $('#segape').val();
        params.contrato = $('#contra').val(); //($('#contra').val() == '' ? 0 : $('#contra').val());
        MethodService("Afiliados", "AfiliadosSave", JSON.stringify(params), "EndCallbackAfiliados");
    }
});

//Funcion de retorno de la respuesta del servidor al guardar
function EndCallbackAfiliados(params, answer) {
    if (!answer.Error) {
        $('#ModalAfiliados').modal("hide");
        window.gridaplasos.bootgrid('reload');
        formReset();
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}

//Funcion de retorno de la respuesta del servidor al consultar una bodega
function EndCallbackGet(params, answer) {
    if (!answer.Error) {
        data = answer.Row;

        $('#idafiliado').val(data.id);
        $('#identificacion').val(data.identificacion);
        $('#id_tipoiden').val(data.tipoiden);
        $('#primnombre').val(data.primer_nombre);
        $('#segnombre').val(data.segundo_nombre);
        $('#primape').val(data.primer_apellido);
        $('#segape').val(data.segundo_apellido);
        $('#contra').val(data.id_contrato);

        $('#ModalAfiliados').modal({ backdrop: 'static', keyboard: false }, 'show');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}
//Funcion de retorno de la respuesta del servidor al Cambiar estado
function EndCallbackupdate(params, answer) {
    if (!answer.Error) {
        window.gridaplasos.bootgrid('reload');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}