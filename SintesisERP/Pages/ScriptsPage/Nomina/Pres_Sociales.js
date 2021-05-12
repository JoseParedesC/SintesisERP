//Vector  de validación
var JsonValidate = [{ id: 'id_tipoprestacion', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'codigo', type: 'NUMERIC', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
    { id: 'nombre', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'ds_cesancontra', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'provisional', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }
]


//Funcion para el cargado de la información en la tabla de listado de las bodegas ya guardadas.

function Loadtable(thi) {

    var table = $(`<table class="table table-striped jambo_table" id="tblPresSocial">
        <thead>
            <tr>
                <th data-column-id="edit" data-formatter="edit" data-sortable="false" style="max-width: 30px !important;">Editar</th>
                <th data-column-id="nombre">Nombre</th>
                ${$(thi).attr('data-nav') == 'tblcesantia' ? '<th data-column-id="codigo">Codigo</th>' : ''}
                <th data-column-id="delete" data-formatter="delete" data-sortable="false" style="max-width: 30px">Eliminar</th>
            </tr>
        </thead>
        <tbody></tbody>
 </table>`);

    nav = $(thi).attr('data-nav')

    $('#' + nav).html(table)

    window.gridcesan = $("#tblPresSocial").bootgrid({
        ajax: true,
        post: function () {
            return {
                'params': function () {
                    params = {
                        op: $(thi).attr('data-nav') == undefined ? $('li.active').attr('data-iden') : $(thi).attr('data-iden')
                    }
                    return JSON.stringify(params);  
                },
                'class': 'Pres_Sociales',
                'method': 'PrestacionesList'
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
        window.gridcesan.find(".command-edit").on("click", function (e) {
            removeerror();
            id = $(this).data("row-id")
            params = {};
            params.id = id;
            MethodService("Pres_Sociales", "PrestacionesGet", JSON.stringify(params), 'EndCallBackGet');
        }).end().find(".command-delete").on("click", function (e) {
            if (confirm("Desea eliminar esta prestacion?")) {
                id = $(this).data("row-id");
                params = {};
                params.id = id;
                MethodService("Pres_Sociales", "PrestacionesDelete", JSON.stringify(params), 'EndCallbackupdateCesan');
            }
        });
    });
}


$(document).ready(function () {

    Loadtable($('li.active'))

    $('.nav-item').on('click', function () {
        $('#tblPresSocial').remove()
        $('.card').find('.container-fluid').remove()
        Loadtable($(this));
    })

    $('#id_tipoprestacion').on('change', function () {
        loadSelect();
    })
});

$('#btnSave').click(function (e) {
    if (validate(JsonValidate)) {
        params = {};
        params.id = $(this).attr('data-id') == undefined ? 0 : $(this).attr('data-id');
        params.nombre = $('#nombre').val();
        params.codigo = $('#codigo').attr('visible') === "true" ? $('#codigo').val() : 0;
        params.contrapartida = $('#id_cesancontra').val();
        params.provisiones = SetNumber($('#provisional').val());
        params.tipo_prestacion = $('#id_tipoprestacion').val();
        MethodService("Pres_Sociales", "PrestacionesSave", JSON.stringify(params), "EndCallBackSaveUpdate");
    }
});


$('.iconnew').click(function (e) {
    formReset();
    $('.selectpicker').val('').selectpicker('refresh')
    loadSelect();
    $('#ModalPrestaciones').modal({ backdrop: 'static', keyboard: false }, 'show');
});

function loadSelect() {
    var div = $('#id_tipoprestacion').closest('.sn-padding');
    var required = false
    if ($('#id_tipoprestacion').find('option:selected').attr('data-iden') == 'CESAN') {
        div.removeClass('col-lg-12')
        div.addClass('col-lg-6')
        $('.codigo').css('display', 'block')
        required = true;
    } else {
        div.removeClass('col-lg-6')
        div.addClass('col-lg-12')
        $('.codigo').css('display', 'none')
        required = false;
    }
    JsonValidate[1].required = required;
    $('#codigo').attr('visible', required)
}

function formReset() {
    div = $('#ModalPrestaciones');
    div.find('input.form-control').val('');
    $('#btnSave').removeAttr('data-id')
    $('#idcesan').val(0);
}


function EndCallBackSaveUpdate(params, answer) {
    if (!answer.Error) {
        $('#ModalPrestaciones').modal("hide");
        window.gridcesan.bootgrid('reload');
        formReset();
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}


function EndCallBackGet(params, answer) {
    if (!answer.Error) {
        data = answer.Row;
        console.log(data)

        $('#btnSave').attr('data-id', data.id_prestacion);
        $('#nombre').val(data.nombre);
        $('#codigo').val(data.codigo);
        $('#id_cesancontra').val(data.id_cuenta);
        $('#ds_cesancontra').val(data.ds_cuenta);
        $('#provisional').val('$ ' + data.provision.Money());
        $('#id_tipoprestacion').val(data.tipo_prestacion).selectpicker('refresh');
        loadSelect()


        $('#ModalPrestaciones').modal({ backdrop: 'static', keyboard: false }, 'show');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}



function EndCallbackupdateCesan(params, answer) {
    if (!answer.Error) {
        window.gridcesan.bootgrid('reload');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}
