//Vector  de validación
var JsonValidate = [{ id: 'Text_codigo', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'Text_Nombre', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'cd_typeFE', type: 'REAL', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
{ id: 'cd_type', type: 'REAL', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
    { id: 'ds_cuenta', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];

window.gridforma;
function Loadtable() {
    window.gridforma = $("#tblforma").bootgrid({
        ajax: true,
        post: function () {
            return {
                'params': "",
                'class': 'FormaPago',
                'method': 'FormaPagoList'
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
        window.gridforma.find(".command-edit").on("click", function (e) {
            removeerror();
            id = $(this).data("row-id")
            params = {};
            params.id = id;
            MethodService("FormaPago", "FormaPagoGet", JSON.stringify(params), 'EndCallbackGet');
        }).end().find(".command-delete").on("click", function (e) {
            if (confirm("Desea eliminar el Forma?")) {
                id = $(this).data("row-id");
                params = {};
                params.id = id;
                MethodService("FormaPago", "FormaPagoDelete", JSON.stringify(params), 'EndCallbackupdate');
            }
        }).end().find(".command-state").on("click", function (e) {
            id = $(this).data("row-id");
            params = {};
            params.id = id;
            MethodService("FormaPago", "FormaPagoState", JSON.stringify(params), 'EndCallbackupdate');
        });
    });
}

$(document).ready(function () {
    Loadtable();

    $('#cd_type').change(function () {
        var tipo = $('#cd_type option:selected').attr('data-tipo');
        if (tipo == "CARTERA")
            tipo = 'CRED';
        else if (tipo == "PROVEEDOR")
            tipo = 'PROVE'
        else 
            tipo = 'TERCE';

        $('#tipo').val(tipo);
    });
});

//Función utilizada para hacer visible el formulado de un nuevo registro
$('.iconnew').click(function (e) {
    formReset();
    $('#Modaltblforma').modal({ backdrop: 'static', keyboard: false }, 'show');
});

//Resetear los campos del formulario
function formReset() {
    div = $('#Modaltblforma');
    div.find('input.form-control, select').val('').removeAttr('readonly');
    div.find('select').selectpicker('refresh');
    $('#btnSave').attr('data-id', '0');

}

//Funcion del boton guardar
$('#btnSave').click(function (e) {
    if (validate(JsonValidate)) {
        params = {};
        params.id = $(this).attr('data-id');
        params.codigo = $('#Text_codigo').val();
        params.nombre = $('#Text_Nombre').val();
        params.voucher = $('#voucher').prop('checked');
        var id_cuenta = $('#id_cuenta').val();
        params.id_cuenta = (id_cuenta === "") ? "0" : id_cuenta;
        params.id_tipo = $('#cd_type').val();
        params.id_typoFE = $('#cd_typeFE').val();


        var btn = $(this);
        btn.button('loading');
        MethodService("FormaPago", "FormaPagoSave", JSON.stringify(params), "EndCallbackSave");
    }
});

//Funcion de retorno de la respuesta del servidor al consultar un producto
function EndCallbackSave(params, answer) {
    if (!answer.Error) {
        $('#Modaltblforma').modal("hide");
        window.gridforma.bootgrid('reload');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
    $('#btnSave').button('reset');
}

//Funcion de retorno de la respuesta del servidor al consultar una forma de pago
function EndCallbackGet(params, answer) {
    if (!answer.Error) {
        data = answer.Row;
        $('#btnSave').attr('data-id', data.id);
        $('#Text_Nombre').val(data.nombre);
        $('#voucher').prop('checked', data.voucher);
        $('#Text_codigo').val(data.codigo).attr('readonly', 'readonly');
        $('#id_cuenta').val(data.id_cuenta);
        $('#cd_type').val(data.id_tipo).selectpicker('refresh');
        $('#cd_type').trigger('change');
        $('#cd_typeFE').val(data.id_typeFE).selectpicker('refresh');
        $('#ds_cuenta').val(data.nombrecuenta);
        $('.i-checks').iCheck('update');
        $('#Modaltblforma').modal({ backdrop: 'static', keyboard: false }, 'show');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}

//Funcion de retorno de la respuesta del servidor al Cambiar estado
function EndCallbackupdate(params, answer) {
    if (!answer.errMsg) {
        window.gridforma.bootgrid('reload');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}
