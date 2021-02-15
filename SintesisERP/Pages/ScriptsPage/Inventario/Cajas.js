//Vector  de validación
var JsonValidate = [
    { id: 'Text_codigo', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'Text_Nombre', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'Text_Bodega', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
    { id: 'ds_cliente', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'ds_vendedor', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'ds_cuenta', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
    { id: 'ds_cuentaant', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];

window.gridcaj;
//Funcion para el cargado de la información en la tabla de listado de las bodegas ya guardadas.
function Loadtable() {
    window.gridcaj = $("#tblcaja").bootgrid({
        ajax: true,
        post: function () {
            return {
                'params': "",
                'class': 'Cajas',
                'method': 'CajasList'
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
        window.gridcaj.find(".command-edit").on("click", function (e) {
            removeerror();
            id = $(this).data("row-id")
            params = {};
            params.id = id;
            MethodService("Cajas", "CajasGet", JSON.stringify(params), 'EndCallbackGet');
        }).end().find(".command-delete").on("click", function (e) {
            if (confirm("Desea eliminar el Caja?")) {
                id = $(this).data("row-id");
                params = {};
                params.id = id;
                MethodService("Cajas", "CajasDelete", JSON.stringify(params), 'EndCallbackupdate');
            }
        }).end().find(".command-state").on("click", function (e) {
            id = $(this).data("row-id");
            params = {};
            params.id = id;
            MethodService("Cajas", "CajasState", JSON.stringify(params), 'EndCallbackupdate');
        });
    });
}


$(document).ready(function () {
    Loadtable();
});

//Función utilizada para hacer visible el formulado de un nuevo registro
$('.iconnew').click(function (e) {
    formReset();
    $('#ModalBoxes').modal({ backdrop: 'static', keyboard: false }, 'show');
});

//Resetear los campos del formulario
function formReset() {
    div = $('#ModalBoxes');
    div.find('input.form-control').val('');
    div.find('textarea').val('');
    div.find('select').val('').selectpicker('refresh');
    $('#Text_codigo').removeAttr('disabled').focus();
    $('#btnSave').attr('data-id', '0');
}

//Funcion del boton guardar
$('#btnSave').click(function (e) {
    if (validate(JsonValidate)) {
        params = {};
        params.id = $(this).attr('data-id');
        params.codigo = $('#Text_codigo').val();
        params.nombre = $('#Text_Nombre').val();
        params.id_wineri = $('#Text_Bodega').val();
        params.headpage = $('#v_headpage').val();
        params.foodpage = $('#v_foodpage').val();
        params.id_account = ($('#id_cuenta').val() == '') ? '0' : $('#id_cuenta').val();
        params.id_client = $('#cd_cliente').val();
        params.id_centrocosto = $('#id_ccostos').val();
        params.id_vendedor = $('#id_vendedor').val();
        params.id_accountant = ($('#id_cuentaant').val() == '') ? '0' : $('#id_cuentaant').val();
        var btn = $(this);
        btn.button('loading');
        MethodService("Cajas", "CajasSave", JSON.stringify(params), "EndCallbackBoxes");
    }
});

//Funcion de retorno de la respuesta del servidor al guardar
function EndCallbackBoxes(params, answer) {
    if (!answer.Error) {
        $('#ModalBoxes').modal("hide");
        window.gridcaj.bootgrid('reload');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }

    $('#btnSave').button('reset');
}

//Funcion de retorno de la respuesta del servidor al consultar una bodega
function EndCallbackGet(params, answer) {
    if (!answer.Error) {
        data = answer.Row;
        $('#btnSave').attr('data-id', data.id);
        $('#Text_codigo').val(data.codigo).attr('disabled', true);
        $('#Text_Nombre').val(data.nombre);
        $('#Text_Bodega').val(data.id_bodega);
        $('#v_headpage').val(data.cabecera);
        $('#v_foodpage').val(data.piecera);
        $('#id_cuenta').val(data.id_cuenta);
        $('#ds_cuenta').val(data.cuentacod);
        $('#id_ccostos').val(data.id_centrocosto);
        $('#codigoccostos').val(data.centrocosto);
        $('#id_vendedor').val(data.id_vendedor);
        $('#ds_vendedor').val(data.vendedor);
        $('#ds_cliente').val(data.cliente);
        $('#id_client').val(data.id_cliente);
        $('#id_resolucion').val(data.id_resolucion);
        $('#id_cuentaant').val(data.id_ctaant);
        $('#ds_cuentaant').val(data.cuentacodant);
        $('select').selectpicker('refresh');
        $('#ModalBoxes').modal({ backdrop: 'static', keyboard: false }, 'show');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}

//Funcion de retorno de la respuesta del servidor al Cambiar estado
function EndCallbackupdate(params, answer) {
    if (!answer.Error) {
        window.gridcaj.bootgrid('reload');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}