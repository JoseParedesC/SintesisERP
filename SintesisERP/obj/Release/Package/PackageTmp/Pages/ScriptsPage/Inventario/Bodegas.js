//Vector  de validación
var JsonValidate = [{ id: 'codigo', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'Text_Nombre', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'ds_ctainv', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'ds_ctacos', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'ds_ctades', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'ds_ctaing', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'ds_ctaingex', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'ds_ctaivaflete', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];


window.gridbod;
//Funcion para el cargado de la información en la tabla de listado de las bodegas ya guardadas.
function Loadtable() {
    window.gridbod = $("#tbltipo").bootgrid({
        ajax: true,
        post: function () {
            return {
                'params': "",
                'class': 'Bodegas',
                'method': 'BodegasList'
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
        window.gridbod.find(".command-edit").on("click", function (e) {
            removeerror();
            id = $(this).data("row-id")
            params = {};
            params.id = id;
            MethodService("Bodegas", "BodegasGet", JSON.stringify(params), 'EndCallbackGet');
        }).end().find(".command-delete").on("click", function (e) {
            if (confirm("Desea eliminar la Bodega?")) {
                id = $(this).data("row-id");
                params = {};
                params.id = id;
                MethodService("Bodegas", "BodegasDelete", JSON.stringify(params), 'EndCallbackupdate');
            }
        }).end().find(".command-state").on("click", function (e) {
            id = $(this).data("row-id");
            params = {};
            params.id = id;
            MethodService("Bodegas", "BodegasState", JSON.stringify(params), 'EndCallbackupdate');
        });
    });
}

$(document).ready(function () {
    Loadtable();
});

//Función utilizada para hacer visible el formulado de un nuevo registro
$('.iconnew').click(function (e) {
    formReset();
    $('#ModalWineries').modal({ backdrop: 'static', keyboard: false }, 'show');
});

//Resetear los campos del formulario
function formReset() {
    div = $('#ModalWineries');
    div.find('input.form-control').val('');
    div.find('textarea').val('');
    $('#btnSave').attr('data-id', '0');
}

//Funcion del boton guardar
$('#btnSave').click(function (e) {
    if (validate(JsonValidate)) {
        params = {};
        params.id = $(this).attr('data-id');
        params.codigo = $('#codigo').val();
        params.nombre = $('#Text_Nombre').val();
        params.ctainv = $('#id_ctainv').val();
        params.ctacos = $('#id_ctacos').val();
        params.ctades = $('#id_ctades').val();
        params.ctaing = $('#id_ctaing').val();
        params.ctaingexc = $('#id_ctaingex').val();
        params.ctaivaflete = $('#id_ctaivaflete').val();
        var btn = $(this);
        btn.button('loading');
        MethodService("Bodegas", "BodegasSave", JSON.stringify(params), "EndCallbackWineries");
    }
});

//Funcion de retorno de la respuesta del servidor al guardar
function EndCallbackWineries(params, answer) {
    if (!answer.Error) {
        $('#ModalWineries').modal("hide");
        window.gridbod.bootgrid('reload');
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
        $('#codigo').val(data.codigo);
        $('#Text_Nombre').val(data.nombre);
        $('#id_ctainv').val(data.ctainven);
        $('#id_ctades').val(data.ctadescuento);
        $('#id_ctaing').val(data.ctaingreso);
        $('#id_ctacos').val(data.ctacosto);
        $('#id_ctaingex').val(data.ctaingresoexc);
        $('#id_ctaivaflete').val(data.ctaivaflete);


        $('#ds_ctainv').val(data.nomctainven);
        $('#ds_ctades').val(data.nomctadescuento);
        $('#ds_ctaing').val(data.nomctaingreso);
        $('#ds_ctacos').val(data.nomctacosto);
        $('#ds_ctaingex').val(data.nomctaingexc);
        $('#ds_ctaivaflete').val(data.nomctaivaflete);
        $('#ModalWineries').modal({ backdrop: 'static', keyboard: false }, 'show');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}

//Funcion de retorno de la respuesta del servidor al Cambiar estado
function EndCallbackupdate(params, answer) {
    if (!answer.Error) {
        window.gridbod.bootgrid('reload');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}