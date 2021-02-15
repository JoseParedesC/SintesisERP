var JsonValidate = [{ id: 'v_codigo', type: 'WHOLE', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'v_nombre', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'cd_tipo', type: 'TEXT', htmltype: 'SELECT', required: false, depends: true, iddepends: 'transaccional' }];

$Accountselect = $('div.tree-anchor.selectted');
$(document).on('click', 'div.tree-anchor.selectted', function (ev) {
    ev.stopPropagation();
    $("div.tree-selected").removeClass('tree-selected');
    $(this).addClass('tree-selected');
});

$(document).on("dblclick", 'div.tree-anchor.selectted', function (ev) {
    ev.stopPropagation();
    id = $(this).closest('li.tree-node').attr('data-id');
    params = {};
    params.id = id;
    MethodService("CNTCuentas", "CNTCuentasGet", JSON.stringify(params), 'EndCallbackGet');
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
    if (confirm("Desea eliminar la cuenta?")) {
        id = $(this).closest('li.tree-node').data("id");
        params = {};
        params.id = id;
        MethodService("CNTCuentas", "CNTCuentasDelete", JSON.stringify(params), 'EndCallbackupdate');
    }
});

$('.iconnew').click(function (e) {
    var div = $('div.tree-anchor.tree-selected').closest('li.tree-node')
    var tipo = div.attr('data-tipo');

    if (tipo == undefined || tipo.length == 0) {
        toastr.warning("Debe seleccionar una cuenta.", 'Sintesis ERP');
        return;
    }

    if (tipo == 'G') {
        var grupo = div.attr('data-id');
        $('#id_hiddengrupo').val(grupo);
        params = {};
        params.id = grupo;
        MethodService("CNTCuentas", "CNTCuentasNew", JSON.stringify(params), "EndCallbackAccountNew");
    } else {
        toastr.warning("No se puede agregar un subnivel, en una cuenta transaccional", 'Sintesis ERP');
    }
});

function formReset() {
    $('#Text_Codigo').removeAttr('readonly');
    div = $('#ModalAccounts');
    div.find('input.form-control').val('');
    div.find('select').val('').selectpicker('refresh');
    $('#btnSave').attr('data-id', '0');
}

function EndCallbackAccountNew(Parameter, Result) {
    if (!Result.error) {
        $('#listtreeaccount').html(Result.Message);
        formReset();
        $('#ModalAccounts').modal({ backdrop: 'static', keyboard: false }, 'show');
    }
    else {
        $('#ulcuentastree').html("");
        toastr.error(Result.Message, 'Sintesis ERP');
    }
    $('#BtnRefresAccount').button('reset');
}

function EndCallbackHtmlCuentaTree(Parameter, Result) {
    if (!Result.error) {
        $('#ulcuentastree').html(Result.Message);
    }
    else {
        $('#ulcuentastree').html("");
        toastr.error(Result.Message, 'Sintesis ERP');
    }
    $('#BtnRefresAccount').button('reset');
}


$('#BtnRefresAccount').click(function (e) {
    params = {};
    params.buscador = $('#ds_buscadorcuenta').val();
    var btn = $(this);
    btn.button('loading');
    MethodHtml("CNTCuentas", "CNTCuentasTreeList", JSON.stringify(params), "EndCallbackHtmlCuentaTree");
});

$('#btnSave').click(function (e) {
    if (validate(JsonValidate)) {
        params = {};
        params.id = $(this).attr('data-id');
        params.codigo = $('#v_codigo').val();
        params.nombre = $('#v_nombre').val();
        params.tipo = $('#transaccional').prop('checked'); 
        params.id_padre = $('#id_hiddengrupo').val();
        params.id_tipocta = ($('#cd_tipo').val() == '') ? '0' : $('#cd_tipo').val();
        var btn = $(this);
        btn.button('loading');
        MethodService("CNTCuentas", "CNTCuentasSave", JSON.stringify(params), "EndCallbackAccounts");
    }
});

function EndCallbackAccounts(params, answer) {
    if (!answer.Error) {
        $('#ModalAccounts').modal("hide");
        $('#BtnRefresAccount').trigger('click');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
    $('#btnSave').button('reset');
}

function EndCallbackGet(params, answer) {
    if (!answer.Error) {
        data = answer.Row;
        $('#btnSave').attr('data-id', data.id);
        $('#listtreeaccount').html(answer.Message);
        $('#transaccional').prop('checked', data.tipo);
        $('#v_codigo').val(data.codigo);
        $('#v_nombre').val(data.nombre);
        $('#id_hiddengrupo').val(data.id_padre)
        $('#cd_tipo').val(data.id_tipocta).selectpicker('refresh');
        $('.i-checks').iCheck('update');
        $('#ModalAccounts').modal({ backdrop: 'static', keyboard: false }, 'show');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}

function EndCallbackupdate(params, answer) {
    if (!answer.Error) {
        toastr.success("Proceso ejecutado exitosamente", 'Sintesis ERP');
        $('#BtnRefresAccount').trigger('click');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}
