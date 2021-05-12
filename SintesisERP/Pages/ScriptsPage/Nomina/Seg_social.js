//Vector  de validación
var JsonValidate = [
    { id: 'id_tiposegsocial', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
    { id: 'nombre', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'cod_ext', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
    { id: 'ds_contra', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },]

window.gridseg_social;

//Funcion para el cargado de la información en la tabla de listado de las bodegas ya guardadas.
function Loadtable() {
    window.gridseg_social = $("#tblsegsocial").bootgrid({
        ajax: true,
        post: function () {
            return {
                'params': function () {
                    param = {
                        id_seg: ($('#hidseg').val() == '' ? 0 : $('#hidseg').val())
                    };
                    return JSON.stringify(param);
                },
                'class': 'Seg_social',
                'method': 'SegsocialList'
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
        window.gridseg_social.find(".command-edit").on("click", function (e) {
            removeerror();
            id = $(this).data("row-id")
            params = {};
            params.id = id;
            MethodService("Seg_social", "SegsocialGet", JSON.stringify(params), 'EndCallbackGet');
        }).end().find(".command-delete").on("click", function (e) {
            if (confirm("Desea eliminar esta Seguridad Social?")) {
                id = $(this).data("row-id");
                params = {};
                params.id = id;
                MethodService("Seg_social", "SegsocialDelete", JSON.stringify(params), 'EndCallbackupdate');
            }
        });
    });
}

$(document).ready(function () {   
    Loadtable();   
});

$('.nav-item').click(function () {
    var valorid = []
    var valorparam = []
    var item = $(this)[0].children
    $.each($('#id_tiposegsocial option'), (i, e) => {
        if (i > 0) {
            valorparam[i] = $(e).attr('param')
            valorid[i] = $(e).val()            
        }
    });
    switch (item[0].innerText) {
        case 'Salud':
            $('#hidseg').val(valorid[2] * 1);
            break;
        case 'Pensión':
            $('#hidseg').val(valorid[3] * 1);
            break;
        case 'Caja de Compenzación':
            $('#hidseg').val(valorid[4] * 1);
            break;
        case 'ARL':
            $('#hidseg').val(valorid[5] * 1);
            break;
    }
    window.gridseg_social.bootgrid('reload');
});

//Resetear los campos del formulario
function formReset() {    
    div = $('#ModalSegsocial');
    div.find('input.form-control').val('');
    $('#idsegsocial').val(0);
}

//Función utilizada para hacer visible el formulado de un nuevo registro
$('.iconnew').click(function (e) {
    formReset();
    $('#ModalSegsocial').modal({ backdrop: 'static', keyboard: false }, 'show');
});

//Funcion del boton guardar
$('#btnSave').click(function (e) {
    if (validate(JsonValidate)) {
        params = {};
        params.id = $('#idsegsocial').val();
        params.id_tiposeg = $('#id_tiposegsocial').val();
        params.nombre = $('#nombre').val();
        params.codext = $('#cod_ext').val();
        params.contrapartida = $('#id_contra').val();
        MethodService("Seg_social", "SegsocialSave", JSON.stringify(params), "EndCallback");
    }
});

//Funcion de retorno de la respuesta del servidor al guardar
function EndCallback(params, answer) {
    if (!answer.Error) {
        $('#ModalSegsocial').modal("hide");
        window.gridseg_social.bootgrid('reload');
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
        $('#idsegsocial').val(data.id);
        $('#id_tiposegsocial').val(data.id_tiposeg);
        $('#nombre').val(data.nombre);
        $('#cod_ext').val(data.cod_ext);
        $('#id_contra').val(data.id_contrapartida);
        $('#ds_contra').val(data.contrapartida);
        $('select.selectpicker').selectpicker('refresh');
        $('#ModalSegsocial').modal({ backdrop: 'static', keyboard: false }, 'show');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}

//Funcion de retorno de la respuesta del servidor al Cambiar estado
function EndCallbackupdate(params, answer) {
    if (!answer.Error) {
        window.gridseg_social.bootgrid('reload');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}