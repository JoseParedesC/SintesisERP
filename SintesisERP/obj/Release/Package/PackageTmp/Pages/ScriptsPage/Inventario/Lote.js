var JsonValidate = [
    { id: 'lote', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'Text_FechaV2', type: 'DATE', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];


/*
 * Elaborado Por: Jeteme
 * 
 *Funcion de carga de tabla con atributo nombre 
 * de la grilla donde se le pasa caracteristica de ajax y jquery
 * */

function Loadtable() {
    window.gridarti = $("#tbllote").bootgrid({ //  
        ajax: true,
        post: function () {
            return {
                'params': "",
                'class': 'Lote',
                'method': 'LotesList'
            };
        },
        url: window.appPath + "/Pages/Connectors/ConnectorList.ashx", //conecta los metodos con los controladores
        formatters: {
            "edit": function (column, row) {
                return "<a class=\"action command-edit\" data-row-id=\"" + row.id + "\"><span class=\"fa-2x fa fa-pencil iconfa\"></span></a>";
            }
        }
    }).on("loaded.rs.jquery.bootgrid", function () {
        // Executes after data is loaded and rendered 
        window.gridarti.find(".command-edit").on("click", function (e) {
            removeerror();
            id = $(this).data("row-id")
            params = {};
            params.id = id;
            MethodService("Lote", "LotesGet", JSON.stringify(params), 'EndCallbackGet');
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
 * funcion de reseteo de los campos dentro del modal y resetea a id cero el boton guardar
 * */
function formReset() {
    div = $('#Modallote');
    div.find('input.form-control').val('');

    $('#btnSave').attr('data-id', '0');
}

/*
 * Elaborado por: Jeteme
 * evento de boton guardar  tipo de doocumentos
 * */
$('#btnSave').click(function (e) {
    if (validate(JsonValidate)) {// valida si los campos cumplen con las condiciones estipuladas en el Json creado a principio de JS
        if (confirm("Esta seguro de modificar este lote?")) {
            params = {};
            params.id = $(this).attr('data-id');
            params.lote = $('#lote').val();
            params.vencimiento = SetDate($('#Text_FechaV2').val());
            var btn = $(this);
            btn.button('loading');
            MethodService("Lote", "LotesSave", JSON.stringify(params), "EndCallbackLote");
        }
    }
});
/*
 * Elaborado por: Jeteme
 * Funcion de llamada que oculta el modal y actualiza la grilla despues de haber realizado una accion en la base de datos
 * */
function EndCallbackLote(params, answer) { // 
    if (!answer.Error) {
        toastr.success("Proceso ejecutado exitosamente.", 'Sintesis ERP');
        window.gridarti.bootgrid('reload');
        $('#Modallote').modal("hide");
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP'); // mensaje de error si hay un error de base de datos
    }
    $('#btnSave').button('reset');
}
/*
 * Elaborado por: Jeteme
 * funcion de carga de informacion recibida de la base de datos
 * */
function EndCallbackGet(params, answer) {
    if (!answer.Error) {
        data = answer.Row;
        $('#btnSave').attr('data-id', data.id);
        $('#lote').val(data.lote);
        $('#Text_FechaV2').val(data.vencimiento_lote);

        $('#Modallote').modal({ backdrop: 'static', keyboard: false }, 'show');  // muestra el modal
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}



