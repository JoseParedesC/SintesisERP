//Vector  de validación
var JsonValidate = [{ id: 'codigo', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'Text_Nombre', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];

/*
 * Elaborado por : jeteme
 * 
 * Funcion de carga de tabla con atributo nombre
 * de la grilla donde se le pasa caracteristica de ajax y jquery
 *
 */
//Funcion para el cargado de la información en la tabla de listado de las bodegas ya guardadas.
function Loadtable() {
    window.gridarti = $("#tbltipoDoc").bootgrid({ 
        ajax: true,
        post: function () {
            return {
                'params': "",
                'class': 'CNTTipodocumentos',
                'method': 'CNTTipodocumentosList'
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
        window.gridarti.find(".command-edit").on("click", function (e) {
            removeerror();
            id = $(this).data("row-id")
            params = {};
            params.id = id;
            MethodService("CNTTipodocumentos", "CNTTipodocumentosGet", JSON.stringify(params), 'EndCallbackGet');
        }).end().find(".command-delete").on("click", function (e) {
            if (confirm("Desea eliminar el Tipo de Documento?")) {
                id = $(this).data("row-id");
                params = {};
                params.id = id;
                MethodService("CNTTipodocumentos", "CNTTipodocumentosDelete", JSON.stringify(params), 'EndCallbackupdate');
            }
        }).end().find(".command-state").on("click", function (e) {
            id = $(this).data("row-id");
            params = {};
            params.id = id;
            MethodService("CNTTipodocumentos", "CNTTipodocumentosState", JSON.stringify(params), 'EndCallbackupdate');
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


/*
 * Elaborado por: Jeteme
 * 
 * Evento del boton +  en donde reseteas los campos del modal y muestra el modal
 * 
 * */
//Función utilizada para hacer visible el formulado de un nuevo registro
$('.iconnew').click(function (e) {
    formReset();
    $('#ModaltipoDocu').modal({ backdrop: 'static', keyboard: false }, 'show');
});

$('.i-checks').on('ifChanged', function (event) { // evento que deshabilita la bsuqueda de centro de costo si no tiene cuenta por defecto
    !(event.target.checked) ? $('#Button2').prop('disabled', true) && $('#codigoccostos').val('') && $('#id_ccostos').val('') : $('#Button2').prop('disabled', false);
});


/*
 * Elaborado por: Jeteme
 *
 * Funcion de reseteo de los campos dentro del modal y resetea a id cero el boton guardar
 *
 * */
//Resetear los campos del formulario
function formReset() {
    div = $('#ModaltipoDocu');
    div.find('input.form-control, select').val('');
    $('select').selectpicker('refresh');
    div.find('textarea').val('');
    $('#codigo').prop('disabled', false);
    $('#id_ccostos').val('');
    $('#ISCcosto').prop('checked', false);
    $('.i-checks').iCheck('update');
    $('#Button2').prop('disabled', true); 
    $('#btnSave').attr('data-id', '0');
}



/*
 * Elaborado por: Jeteme
 *
 * Evento de boton guardar  tipo de doocumentos
 *
 * */
//Funcion del boton guardar
$('#btnSave').click(function (e) {
    if (validate(JsonValidate)) { // valida si los campos cumplen con las condiciones estipuladas en el Json creado a principio de JS
        params = {};  
        params.id = $(this).attr('data-id');
        params.codigo = $('#codigo').val();
        params.nombre = $('#Text_Nombre').val();
        params.id_tipo = $('#cd_tipo').val();
        params.ISCcosto = $('#ISCcosto').prop('checked');
        params.id_ccostos = $('#id_ccostos').val() != '' ? $('#id_ccostos').val() : 0;

        var btn = $(this);
        btn.button('loading');
        MethodService("CNTTipodocumentos", "CNTTipodocumentossSave", JSON.stringify(params), "EndCallbackTipoDoc");
    }
});

/*
 * Elaborado por: Jeteme
 *
 * Funcion de llamada que oculta el modal y actualiza la grilla despues de haber realizado una accion en la base de datos
 *
 * */
//Funcion de retorno de la respuesta del servidor al guardar
function EndCallbackTipoDoc(params, answer) {
    if (!answer.Error) {
        $('#ModaltipoDocu').modal("hide");
        window.gridarti.bootgrid('reload');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP'); // mensaje de error si hay un error de base de datos
    }

    $('#btnSave').button('reset');
}

/*
 * Elaborado por: Jeteme
 *
 * Funcion de carga de informacion recibida de la base de datos
 *
 * */
//Funcion de retorno de la respuesta del servidor al consultar un tipo de documento
function EndCallbackGet(params, answer) {
    if (!answer.Error) {
        data = answer.Row;
        $('#btnSave').attr('data-id', data.id);
        $('#codigo').val(data.codigo);
        $('#Text_Nombre').val(data.nombre);
        $('#cd_tipo').val(data.id_tipo).selectpicker('refresh');
        $('#id_ccostos').val(data.id_centrocosto);
        $('#ISCcosto').prop('checked', data.isccosto)


        $('#codigoccostos').val(data.centrocosto);
        $('#codigo').prop('disabled',true);
        $('.i-checks').iCheck('update');
        $('#ModaltipoDocu').modal({ backdrop: 'static', keyboard: false }, 'show'); // muestra el modal
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}

/*
 * Elaborado por: Jeteme
 *
 * Actualiza la grilla
 *
 * */
//Funcion de retorno de la respuesta del servidor al Cambiar estado
function EndCallbackupdate(params, answer) { //
    if (!answer.Error) {
        window.gridarti.bootgrid('reload');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}





