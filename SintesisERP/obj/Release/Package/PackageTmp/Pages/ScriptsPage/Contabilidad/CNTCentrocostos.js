//Vector  de validación
var JsonValidate = [{ id: 'codigo', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'Text_Nombre', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];


$Accountselect = $('div.tree-anchor.selectted');
$(document).on('click', 'div.tree-anchor.selectted', function (ev) {
    ev.stopPropagation();
    if ($(this).hasClass("tree-selected")) {
        $(this).removeClass('tree-selected');
    } else {
        $("div.tree-selected").removeClass('tree-selected');
        $(this).addClass('tree-selected');
    }
});

$(document).on("dblclick", 'div.tree-anchor.selectted', function (ev) {
    ev.stopPropagation();
    id = $(this).closest('li.tree-node').attr('data-id');
    params = {};
    params.id = id;
    MethodService("CNTCentrosCostos", "CNTCentrosCostosGet", JSON.stringify(params), 'EndCallbackGet');
});

$(document).on('click', '.tree-icon', function (ev) {
    ev.stopPropagation();
    var $lu = $(this).parent();
    var $li = $(this).closest('li.tree-node');

    if ($li.is('.tree-open')) {
        $li.removeClass('tree-open').addClass('tree-closed');
    } else {
        $li.removeClass('tree-closed').addClass('tree-open');
    }
});

$(document).on('click', 'span.tree-remove', function (ev) {
    ev.stopPropagation();
    if (confirm("Desea eliminar el centro de costo?")) {
        id = $(this).closest('li.tree-node').data("id");
        params = {};
        params.id = id;
        MethodService("CNTCentrosCostos", "CNTCentrosCostosDelete", JSON.stringify(params), 'EndCallbackupdate');
    }
});

/*
 * Elaborado por: Jeteme
 * Evento del boton +  en donde reseteas los campos del modal y muestra el modal
 * */
//Función utilizada para hacer visible el formulado de un nuevo registro
$('.iconnew').click(function (e) {

    var div = $('div.tree-anchor.tree-selected').closest('li.tree-node')
    var tipo = div.attr('data-tipo');
    var grupo = "0";

    if (tipo == undefined || tipo.length == 0) {
        $('#id_hiddengrupo').val('0');
        tipo = 'G';
    } else {
        grupo = div.attr('data-id');
        $('#id_hiddengrupo').val(grupo);
    }

    if (tipo == 'G') {
        params = {};
        params.id = grupo;
        MethodService("CNTCentrosCostos", "CNTCCostosNew", JSON.stringify(params), "EndCallbackCcostosNew");
    } else {
        toastr.warning("No se puede agregar un subnivel, en una cuenta transaccional", 'Sintesis ERP');
    }
});

function EndCallbackCcostosNew(Parameter, Result) {
    if (!Result.error) {
        formReset();
        $('#listtreeccostos').html(Result.Message);
        $('#ModalCcostos').modal({ backdrop: 'static', keyboard: false }, 'show');
    }
    else {
        $('#ulcuentastree').html("");
        toastr.error(Result.Message, 'Sintesis ERP');
    }
    $('#BtnRefresAccount').button('reset');
}

$('#BtnRefresCCostos').click(function (e) {
    params = {};
    params.buscador = $('#ds_buscadorccostos').val();
    var btn = $(this);
    btn.button('loading');
    MethodHtml("CNTCentrosCostos", "CNTCentroCostosTreeList", JSON.stringify(params), "EndCallbackHtmlCCostoTree");
});

function EndCallbackHtmlCCostoTree(Parameter, Result) {
    if (!Result.error) {
        $('#ulccostostree').html(Result.Message);
    }
    else {
        $('#ulccostostree').html("");
        toastr.error(Result.Message, 'Sintesis ERP');
    }
    $('#BtnRefresCCostos').button('reset');
}
/*
 * Elaborado por: Jeteme
 * funcion de reseteo de los campos dentro del modal y resetea a id cero el boton guardar
 * */
//Resetear los campos del formulario
function formReset() {
    div = $('#ModalCcostos');
    div.find('input.form-control').val('');
    div.find('textarea').val('');
    $('#ISdetalle').prop("checked", false);
    $('#codigo').prop('disabled', false);
    $('#btnSave').attr('data-id', '0');
    $('.i-checks').iCheck('update');
}

/*
 * Elaborado por: Jeteme
 * evento de boton guardar  tipo de doocumentos
 * */
//Funcion del boton guardar
$('#btnSave').click(function (e) {
    if (validate(JsonValidate)) {// valida si los campos cumplen con las condiciones estipuladas en el Json creado a principio de JS
        params = {};
        params.id = $(this).attr('data-id');
        params.codigo = $('#codigo').val();
        params.nombre = $('#Text_Nombre').val();
        params.id_padre = $('#id_hiddengrupo').val();
        params.ISdetalle = $('#ISdetalle').prop('checked');

        var btn = $(this);
        btn.button('loading');
        MethodService("CNTCentrosCostos", "CNTCentrosCostosSave", JSON.stringify(params), "EndCallbackCCosto");
    }
});
/*
 * Elaborado por: Jeteme
 * Funcion de llamada que oculta el modal y actualiza la grilla despues de haber realizado una accion en la base de datos
 * */
//Funcion de retorno de la respuesta del servidor al guardar
function EndCallbackCCosto(params, answer) { // 
    if (!answer.Error) {
        $('#BtnRefresCCostos').trigger('click');
        $('#ModalCcostos').modal("hide");
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
//Funcion de retorno de la respuesta del servidor al consultar una bodega
function EndCallbackGet(params, answer) {
    if (!answer.Error) {
        data = answer.Row;
        $('#btnSave').attr('data-id', data.id);
        $('#listtreeccostos').html(answer.Message);
        $('#codigo').val(data.codigo);
        $('#Text_Nombre').val(data.nombre);
        $('#id_hiddengrupo').val(data.id_padre)
        $('#ISdetalle').prop('checked', data.tipo);
        $('.i-checks').iCheck('update');
        $('#ModalCcostos').modal({ backdrop: 'static', keyboard: false }, 'show');  // muestra el modal
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}

//Funcion de retorno de la respuesta del servidor al Cambiar estado
function EndCallbackupdate(params, answer) {
    if (!answer.Error) {
        toastr.success("Proceso ejecutado exitosamente", 'Sintesis ERP');
        $('#BtnRefresCCostos').trigger('click');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}



