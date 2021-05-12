//Vector  de validación
var JsonValidate = [
    { id: 'areanombre', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'ds_suelcuen_gasto', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
    { id: 'ds_hextcuen_gasto', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
    { id: 'ds_comicuen_gasto', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
    { id: 'ds_bonicuen_gasto', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
    { id: 'ds_auxtranscuen_gasto', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
    { id: 'ds_cesancuen_gasto', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
    { id: 'ds_intcasancuen_gasto', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
    { id: 'ds_primsercuen_gasto', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
    { id: 'ds_vacacuen_gasto', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
    { id: 'ds_arlcuen_gasto', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
    { id: 'ds_epscuen_gasto', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
    { id: 'ds_pencuen_gasto', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
    { id: 'ds_fspencuen_gasto', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
    { id: 'ds_cajacuen_gasto', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
    { id: 'ds_icbfcuen_gasto', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
    { id: 'ds_senacuen_gasto', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];

var JsonValidateCuenta = [
    { id: 'id_suelcuen_gasto', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
    { id: 'id_hextcuen_gasto', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
    { id: 'id_comicuen_gasto', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
    { id: 'id_bonicuen_gasto', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
    { id: 'id_auxtranscuen_gasto', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
    { id: 'id_cesancuen_gasto', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
    { id: 'id_intcasancuen_gasto', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
    { id: 'id_primsercuen_gasto', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
    { id: 'id_vacacuen_gasto', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
    { id: 'id_arlcuen_gasto', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
    { id: 'id_epscuen_gasto', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
    { id: 'id_pencuen_gasto', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
    { id: 'id_fspencuen_gasto', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
    { id: 'id_cajacuen_gasto', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
    { id: 'id_icbfcuen_gasto', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
    { id: 'id_senacuen_gasto', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];


window.gridarea;
//Funcion para el cargado de la información en la tabla de listado de las bodegas ya guardadas.
function Loadtable() {
    window.gridarea = $("#tblarea").bootgrid({
        ajax: true,
        post: function () {
            return {
                'params': "",
                'class': 'Area',
                'method': 'AreaList'
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
        window.gridarea.find(".command-edit").on("click", function (e) {
            removeerror();
            id = $(this).data("row-id")
            params = {};
            params.id = id;
            MethodService("Area", "AreaGet", JSON.stringify(params), 'EndCallbackGet');
        }).end().find(".command-delete").on("click", function (e) {
            if (confirm("Desea eliminar esta area?")) {
                id = $(this).data("row-id");
                params = {};
                params.id = id;
                MethodService("Area", "AreaDelete", JSON.stringify(params), 'EndCallbackupdate');
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

    $('#ModalArea').modal({ backdrop: 'static', keyboard: false }, 'show');
});

//Resetear los campos del formulario
function formReset() {
    div = $('#ModalArea');
    div.find('input.form-control').val('');
    $('#idarea').val(0);
    $('#id_suelcuen_gasto').val(0);
    $('#id_hextcuen_gasto').val(0);
    $('#id_comicuen_gasto').val(0);
    $('#id_bonicuen_gasto').val(0);
    $('#id_auxtranscuen_gasto').val(0);
    $('#id_cesancuen_gasto').val(0);
    $('#id_intcasancuen_gasto').val(0);
    $('#id_primsercuen_gasto').val(0);
    $('#id_vacacuen_gasto').val(0);
    $('#id_arlcuen_gasto').val(0);
    $('#id_epscuen_gasto').val(0);
    $('#id_pencuen_gasto').val(0);
    $('#id_fspencuen_gasto').val(0);
    $('#id_cajacuen_gasto').val(0);
    $('#id_icbfcuen_gasto').val(0);
    $('#id_senacuen_gasto').val(0);

}

//Funcion del boton guardar
$('#btnSave').click(function (e) {
    if (validate(JsonValidate)) {
        params = {};
        params.id = $('#idarea').val();
        params.nombre = $('#areanombre').val();
        params.sueldo = $('#id_suelcuen_gasto').val();
        params.hra_ext = $('#id_hextcuen_gasto').val();
        params.comi = $('#id_comicuen_gasto').val();
        params.boni = $('#id_bonicuen_gasto').val();
        params.auxtrans = $('#id_auxtranscuen_gasto').val();
        params.cesan = $('#id_cesancuen_gasto').val();
        params.intcesan = $('#id_intcasancuen_gasto').val();
        params.prima_ser = $('#id_primsercuen_gasto').val();
        params.vacas = $('#id_vacacuen_gasto').val();
        params.arl = $('#id_arlcuen_gasto').val();
        params.eps = $('#id_epscuen_gasto').val();
        params.pension = $('#id_pencuen_gasto').val();
        params.fspension = $('#id_fspencuen_gasto').val();
        params.cajacomp = $('#id_cajacuen_gasto').val();
        params.icbf = $('#id_icbfcuen_gasto').val();
        params.sena = $('#id_senacuen_gasto').val();
        if (params.sueldo == 0 || params.hra_ext == 0 || params.comi == 0 || params.boni == 0 || params.auxtrans == 0 || params.cesan == 0 || params.intcesan == 0 || params.prima_ser == 0 ||
            params.vacas == 0 || params.arl == 0 || params.eps == 0 || params.pension == 0 || params.fspension == 0 || params.cajacomp == 0 || params.icbf == 0 || params.sena == 0) {
            toastr.error('Asegurese de ingresar cuentas', 'Sintesis ERP');
        } else {
            MethodService("Area", "AreaSave", JSON.stringify(params), "EndCallbackThirds");
        }
    }
});

//Funcion de retorno de la respuesta del servidor al guardar
function EndCallbackThirds(params, answer) {
    if (!answer.Error) {
        $('#ModalArea').modal("hide");
        window.gridarea.bootgrid('reload');
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

        $('#idarea').val(data.id);
        $('#areanombre').val(data.nombre);
        $('#ds_suelcuen_gasto').val(data.id_sueldo);
        $('#id_suelcuen_gasto').val(data.sueldo);
        $('#ds_hextcuen_gasto').val(data.id_hextra);
        $('#id_hextcuen_gasto').val(data.hextra);
        $('#ds_comicuen_gasto').val(data.id_comi);
        $('#id_comicuen_gasto').val(data.comi);
        $('#ds_bonicuen_gasto').val(data.id_boni);
        $('#id_bonicuen_gasto').val(data.boni);
        $('#ds_auxtranscuen_gasto').val(data.id_auxtransporte);
        $('#id_auxtranscuen_gasto').val(data.auxtransporte);
        $('#ds_cesancuen_gasto').val(data.id_cesan);
        $('#id_cesancuen_gasto').val(data.cesan);
        $('#ds_intcasancuen_gasto').val(data.id_int_cesan);
        $('#id_intcasancuen_gasto').val(data.int_cesan);
        $('#ds_primsercuen_gasto').val(data.id_prima_ser);
        $('#id_primsercuen_gasto').val(data.prima_ser);
        $('#ds_vacacuen_gasto').val(data.id_vacas);
        $('#id_vacacuen_gasto').val(data.vacas);
        $('#ds_arlcuen_gasto').val(data.id_arl);
        $('#id_arlcuen_gasto').val(data.arl);
        $('#ds_epscuen_gasto').val(data.id_eps);
        $('#id_epscuen_gasto').val(data.eps);
        $('#ds_pencuen_gasto').val(data.id_afp);
        $('#id_pencuen_gasto').val(data.afp);
        $('#ds_fspencuen_gasto').val(data.id_fspension);
        $('#id_fspencuen_gasto').val(data.fspension);
        $('#ds_cajacuen_gasto').val(data.id_ccf);
        $('#id_cajacuen_gasto').val(data.ccf);
        $('#ds_icbfcuen_gasto').val(data.id_icbf);
        $('#id_icbfcuen_gasto').val(data.icbf);
        $('#ds_senacuen_gasto').val(data.id_sena);
        $('#id_senacuen_gasto').val(data.sena);

        $('#ModalArea').modal({ backdrop: 'static', keyboard: false }, 'show');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}
//Funcion de retorno de la respuesta del servidor al Cambiar estado
function EndCallbackupdate(params, answer) {
    if (!answer.Error) {
        window.gridarea.bootgrid('reload');
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