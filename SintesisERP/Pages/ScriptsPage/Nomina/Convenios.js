//Vector  de validación
var JsonValidate = [{ id: 'carnombre', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'descripcion', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' }]/*,
    { id: 'funciones', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];*/


window.gridcargo;
//Funcion para el cargado de la información en la tabla de listado de las bodegas ya guardadas.
function Loadtable() {
    window.gridcargo = $("#tblcargo").bootgrid({
        ajax: true,
        post: function () {
            return {
                'params': "",
                'class': 'Cargos',
                'method': 'CargosList'
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
        window.gridcargo.find(".command-edit").on("click", function (e) {
            removeerror();
            id = $(this).data("row-id")
            params = {};
            params.id = id;
            MethodService("Cargos", "CargosGet", JSON.stringify(params), 'EndCallbackGet');
        }).end().find(".command-delete").on("click", function (e) {
            if (confirm("Desea eliminar este Cargo?")) {
                id = $(this).data("row-id");
                params = {};
                params.id = id;
                MethodService("Cargos", "CargosDelete", JSON.stringify(params), 'EndCallbackupdate');
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

    $('#ModalCargo').modal({ backdrop: 'static', keyboard: false }, 'show');
});

//Resetear los campos del formulario
function formReset() {
    div = $('#ModalCargo');
    div.find('input.form-control').val('');
    $('#descripcion').val('');
    $('#funciones').text('');
    $('#idcargo').val(0);
    $('#v_razonsocial').val('');
}


//Funcion del boton guardar
$('#btnSave').click(function (e) {
    if (validate(JsonValidate)) {
        params = {};
        params.id = $('#idcargo').val();
        params.nombre = $('#carnombre').val();
        params.descripcion = $('#descripcion').val();
        params.funciones = $('#funciones')[0].innerText;
        MethodService("Cargos", "CargosSave", JSON.stringify(params), "EndCallbackThirds");
    }
});

//Funcion de retorno de la respuesta del servidor al guardar
function EndCallbackThirds(params, answer) {
    if (!answer.Error) {
        $('#ModalCargo').modal("hide");
        window.gridcargo.bootgrid('reload');
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
        console.log(data);
        $('#idcargo').val(data.id);
        $('#carnombre').val(data.nombre);
        $('#descripcion').val(data.descripcion);
        $('#funciones')[0].innerText = data.funciones;
       
        $('#ModalCargo').modal({ backdrop: 'static', keyboard: false }, 'show');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}
//Funcion de retorno de la respuesta del servidor al Cambiar estado
function EndCallbackupdate(params, answer) {
    if (!answer.Error) {
        window.gridcargo.bootgrid('reload');
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