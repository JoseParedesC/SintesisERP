//Vector  de validación
var JsonValidate = [{ id: 'codigo', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'Text_Nombre', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'cd_tipoimp', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
{ id: 'm_valor', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'ds_ctaVenta', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'ds_ctadevVenta', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'ds_ctaCompra', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'ds_ctadevCompra', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }
];





window.gritipoImp;
/*
 * Elaborado por : jeteme
 *
 * Funcion de carga de tabla con atributo nombre
 * de la grilla donde se le pasa caracteristica de ajax y jquery
 * para la grilla tipo impuesto 
 *
 */
function Loadtable() {
    window.gritipoImp = $("#tbltipoimpuesto").bootgrid({
        ajax: true,
        post: function () {
            return {
                'params': "",
                'class': "CNTImpuestos",
                'method': 'CNTImpuestosList'
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
        window.gritipoImp.find(".command-edit").on("click", function (e) {
            removeerror();
            id = $(this).data("row-id")
            params = {};
            params.id = id;
            MethodService("CNTImpuestos", "CNTImpuestosGet", JSON.stringify(params), 'EndCallbackGet');

        }).end().find(".command-delete").on("click", function (e) {
            if (confirm("Desea eliminar el Tipo de impuesto?")) {
                id = $(this).data("row-id");
                params = {};
                params.id = id;
                MethodService("CNTImpuestos", "CNTImpuestosDelete", JSON.stringify(params), 'EndCallbackupdate');
            }
        }).end().find(".command-state").on("click", function (e) {
            id = $(this).data("row-id");
            params = {};
            params.id = id;
            MethodService("CNTImpuestos", "CNTImpuestosState", JSON.stringify(params), 'EndCallbackupdate');
        });
    });
}

/*
 * Elaborado por : jeteme
 *
 * evento del boton +  en donde reseteas los campos del modal y muestra el modal
 *
 */
$(document).ready(function () {
    Loadtable();
});
/*
 * Elaborado por : jeteme
 *
 * evento del boton +  en donde reseteas los campos del modal y muestra el modal
 *
 */
//Función utilizada para hacer visible el formulado de un nuevo registro
$('.iconnew').click(function (e) { //
    formReset();
    $('#ModaltipoImp').modal({ backdrop: 'static', keyboard: false }, 'show');
});

/*
 * Elaborado por : jeteme
 *
 * funcion de reseteo de los campos dentro del modal y resetea a id cero el boton guardar
 *
 */
//Resetear los campos del formulario
function formReset() {
    div = $('#ModaltipoImp');
    div.find('input.form-control, select').val('');
    $('select').selectpicker('refresh');
    $('#codigo').prop('disabled', false);
    $('#btnSave').attr('data-id', '0');
}

/*
 * Elaborado por: Jeteme
 *
 * Evento de boton guardar  tipo de impuestos
 *
 * */
//Funcion del boton guardar
$('#btnSave').click(function (e) {
    if (validate(JsonValidate)) {
        params = {};
        params.id = $(this).attr('data-id');
        params.codigo = $('#codigo').val();
        params.nombre = $('#Text_Nombre').val();
        params.id_tipoimp = $('#cd_tipoimp').val();
        params.valor = SetNumber($('#m_valor').val());
        params.id_ctaventa = $('#id_ctaVenta').val();
        params.id_ctadevventa = $('#id_ctadevVenta').val();
        params.id_ctacompra = $('#id_ctaCompra').val();
        params.id_ctadevcompra = $('#id_ctadevCompra').val();


        var btn = $(this);
        btn.button('loading');
        MethodService("CNTImpuestos", "CNTImpuestosSave", JSON.stringify(params), "EndCallbackTipoimp");
    }
});

/*
 * Elaborado por: Jeteme
 *
 * Funcion de llamada que oculta el modal y actualiza la grilla despues de haber realizado una accion en la base de datos para tipoimpuesto
 *
 * */
//Funcion de retorno de la respuesta del servidor al guardar
function EndCallbackTipoimp(params, answer) {
    if (!answer.Error) {
        data = answer.Value;
        $('#btnSave').attr('data-id', data);
        toastr.success('Se guardo exitosamente', 'Sintesis ERP');
        window.gritipoImp.bootgrid('reload');
        $('#ModaltipoImp').modal("hide");
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }

    $('#btnSave').button('reset');
}
/*
 * Elaborado por: Jeteme
 *
 * Funcion de carga de informacion recibida de la base de datos de Tipoimpuesto
 *
 * */
//Funcion de retorno de la respuesta del servidor al consultar una Impuesto
function EndCallbackGet(params, answer) {
    if (!answer.Error) {
        data = answer.Row;
        $('#btnSave').attr('data-id', data.id);
        $('#codigo').val(data.codigo);
        $('#Text_Nombre').val(data.nombre);
        $('#codigo').prop('disabled', true);

        $('#m_valor').val(data.valor);

        $('#id_ctaVenta').val(data.id_ctaventa);
        $('#id_ctadevVenta').val(data.id_ctadevVenta);
        $('#id_ctaCompra').val(data.id_ctacompra);
        $('#id_ctadevCompra').val(data.id_ctadevCompra);
        $('#ds_ctaVenta').val(data.nomctaventa);
        $('#ds_ctadevVenta').val(data.nomctadevVenta);
        $('#ds_ctaCompra').val(data.nomctacompra);
        $('#ds_ctadevCompra').val(data.nomctadevcompra);
        $('#cd_tipoimp').val(data.id_tipoimp).selectpicker('refresh');

        $('#ModaltipoImp').modal({ backdrop: 'static', keyboard: false }, 'show');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}

/*
 * Elaborado por: Jeteme
 *
 * Actualiza la grilla de tipoimpuestos
 *
 * */
//Funcion de retorno de la respuesta del servidor al Cambiar estado

function EndCallbackupdate(params, answer) {
    if (!answer.Error) {
        window.gritipoImp.bootgrid('reload');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}
