//Vector  de validación
var JsonValidate = [{ id: 'pn_type', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
{ id: 'cd_catfiscal', type: 'TEXT', htmltype: 'SELECT', required: false, depends: false, iddepends: '' },
{ id: 'cd_type', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
{ id: 'cd_identification', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'v_firstname', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'v_surname', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'v_razonsocial', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'cd_city', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
{ id: 'v_address', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];


window.gridterc;
//Funcion para el cargado de la información en la tabla de listado de las bodegas ya guardadas.
function Loadtable() {
    window.gridterc = $("#tbltipo").bootgrid({
        ajax: true,
        post: function () {
            return {
                'params': "",
                'class': 'CNTTerceros',
                'method': 'CNTTercerosList'
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
        window.gridterc.find(".command-edit").on("click", function (e) {
            removeerror();
            id = $(this).data("row-id")
            params = {};
            params.id = id;
            MethodService("CNTTerceros", "CNTTercerosGet", JSON.stringify(params), 'EndCallbackGet');
        }).end().find(".command-delete").on("click", function (e) {
            if (confirm("Desea eliminar este Tercero?")) {
                id = $(this).data("row-id");
                params = {};
                params.id = id;
                MethodService("CNTTerceros", "CNTTercerosDelete", JSON.stringify(params), 'EndCallbackupdate');
            }
        }).end().find(".command-state").on("click", function (e) {
            id = $(this).data("row-id");
            params = {};
            params.id = id;
            MethodService("CNTTerceros", "CNTTercerosState", JSON.stringify(params), 'EndCallbackupdate');
        });
    });
}

$(document).ready(function () {
    Loadtable();

});
//Evento para calcular el digito de verificacion despues que ocurra un cambio en el campo de indentificacion 
$('#cd_identification').blur(function () {
    var value = $(this).val();
    $('#dig_verif').val(CalcularDv(value));

});

//Función utilizada para hacer visible el formulado de un nuevo registro
$('.iconnew').click(function (e) {
    formReset();

    $('#ModalThirds').modal({ backdrop: 'static', keyboard: false }, 'show');
});

//Resetear los campos del formulario
function formReset() {
    div = $('#ModalThirds');
    div.find('input.form-control').val('');
    $('#cd_catfiscal').attr('disabled', true);
    $('#Text_CodigoBarra').focus();
    $('#btnSave').attr('data-id', '0');
    $('#btncuenta').attr('disabled', 'disabled');
    $('#data-idtipoter').attr('data-id', '0');
    $('#v_razonsocial').val('');
    $('.i-checks').prop('checked', false);
    div.find('select').val('').selectpicker('refresh');
    $('.i-checks').iCheck('update');
}

//Evento que teniendo en cuenta el valor de tipo persona Oculta o muestra datos como (nombres, apellidos o razon social)
$('#pn_type').on('change', function (event) {
    if ($('#pn_type option:selected').data('option') == 'JURIDICA') {
        $('#isnatural').css('display', 'none');
        $('#isJuridica').css('display', 'block');
    } else {
        $('#isnatural').css('display', 'block');
        $('#isJuridica').css('display', 'none');
    }
});

$('#cd_tipoterce').on('change', function (event) {
    if ($('#cd_tipoterce option[data-option="PR"]').is(':selected')) {
        $('#cd_catfiscal').removeAttr('disabled');
        JsonValidate[1].required = true;
    } else {
        JsonValidate[1].required = false;
        $('#cd_catfiscal').val('');
        $('#cd_catfiscal').attr('disabled', 'disabled');
    }
    $('#cd_catfiscal').selectpicker('refresh');
});

//Funcion del boton guardar
$('#btnSave').click(function (e) {
    if (validate(JsonValidate)) {
        params = {};
        params.id = $(this).attr('data-id');
        params.tipoper = $('#pn_type').val();
        params.iden = $('#cd_identification').val();
        params.type = $('#cd_type').val();
        params.digiveri = $('#dig_verif').val();
        params.id_catfiscal = ($('#cd_catfiscal').val() != '') ? $('#cd_catfiscal').val() : '0';
        params.firstname = $('#v_firstname').val();
        params.secondname = $('#v_secondname').val();
        params.surname = $('#v_surname').val();
        params.secondsurname = $('#v_secondsurname').val();
        params.razonsocial = ($('#pn_type option:selected').data('option') == 'JURIDICA') ? $('#v_razonsocial').val() : (params.firstname + ' ' + params.secondname + ' ' + params.surname + ' ' + params.secondsurname);
        params.brash = $('#cd_sucursal').val();
        params.typeregimen = $('#esReponsable').prop('checked');
        params.tradename = $('#cd_nombrecomercial').val();
        params.pageweb = $('#cd_webpage').val();
        params.dateexped = SetDate($('#fecha_exp').val());
        params.datebirth = SetDate($('#fecha_naci').val());
        params.address = $('#v_address').val();
        params.phone = $('#v_phone').val();
        params.cellphone = $('#v_cellphone').val();
        params.email = $('#email').val();
        params.cd_city = $('#cd_city').val();
        params.contactname = $('#nombrecontacto').val();
        params.contactphone = $('#telefonocontacto').val();
        params.emailcontacto = $('#emailcont').val();
        params.typethird = GenerarXMLTipoTerceros();
        var btn = $(this);

        MethodService("CNTTerceros", "CNTTercerosSave", JSON.stringify(params), "EndCallbackThirds");
    }
});

//Funcion de retorno de la respuesta del servidor al guardar
function EndCallbackThirds(params, answer) {
    if (!answer.Error) {
        $('#ModalThirds').modal("hide");
        window.gridterc.bootgrid('reload');
        formReset();
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
        $('#pn_type').val(data.id_personeria);
        $('#cd_type').val(data.tipoiden);
        $('#cd_city').val(data.id_ciudad);
        $('#esReponsable').prop('checked', data.tiporegimen);
        $('#cd_catfiscal').val(data.id_catfiscal)
        $('#cd_identification').val(data.iden);
        $('#v_firstname').val(data.primernombre);
        $('#v_secondname').val(data.segundonombre);
        $('#v_surname').val(data.primerapellido);
        $('#v_secondsurname').val(data.segundoapellido);
        $('#cd_sucursal').val(data.sucursal);
        $('#cd_nombrecomercial').val(data.nombrecomercial);
        $('#cd_webpage').val(data.paginaweb);
        $('#fecha_exp').val(data.fechaexpedicion);
        $('#fecha_naci').val(data.fechanacimiento);
        $('#v_address').val(data.direccion);
        $('#v_phone').val(data.telefono);
        $('#v_cellphone').val(data.celular);
        $('#email').val(data.email);

        $('#cd_tipoterce').val((data.tipoterceros != null) ? f(data.tipoterceros) : "");

        $('#pn_type').trigger('change');
        $('#cd_tipoterce').trigger('change');
        $('#dig_verif').val(data.digitoverificacion);
        $('#nombrecontacto').val(data.nombrescontacto);
        $('#telefonocontacto').val(data.telefonocontacto);
        $('#emailcont').val(data.emailcontacto);
        $('#v_razonsocial').val(data.tercero);

        $('.i-checks').iCheck('update');
        $('select').selectpicker('refresh');

        $('#ModalThirds').modal({ backdrop: 'static', keyboard: false }, 'show');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}
//Funcion de retorno de la respuesta del servidor al Cambiar estado
function EndCallbackupdate(params, answer) {
    if (!answer.Error) {
        window.gridterc.bootgrid('reload');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}
//funcion que separa con coma un resultado recibe un string
function f(d) {
    return d.split(',')
}

function GenerarXMLTipoTerceros() {
    var xml = "";
    tipoterce = $('#cd_tipoterce').val();
    if (tipoterce != null) {
        $.each(tipoterce, function (i, e) {
            data = tipoterce[i];
            xml += '<tipo id_tipo="' + data + '" />'

        });
    }
    xml = "<tipoterceros>" + xml + "</tipoterceros>"
    return xml;
}