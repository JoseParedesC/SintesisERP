var JsonValidate = [{ id: 'code', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
    { id: 'code_ext', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
    { id: 'detalle', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' }];

$Accountselect = $('div.tree-anchor.selectted');

$('.iconnew').click(function (e) {
    formReset();
    $('#ModalAddTipo').modal({ backdrop: 'static', keyboard: false }, 'show');
});

$("#btnSave").click(function () {
    SendJuzgado()
});

$('#BtnTipoCotizante').on('click', function () {
    params = {}
    var btn = $(this);
    btn.button('loading');
    params.buscador = $('#ds_buscadorTipoCotizante').val();
    MethodHtml("TiposCotizantes", "TipoCotizanteTreeList", JSON.stringify(params), "EndCallbackHtmlTree");
});

$(document).on('click', 'div.tree-anchor.selectted', function (ev) {
    if ($(this).hasClass("tree-selected")) {
        $(this).removeClass('tree-selected');
        $("#btnSave").removeAttr('data-idpadre');
    } else {
        $("div.tree-selected").removeClass('tree-selected');
        $("#btnSave").attr('data-idpadre', $(this).closest('.tree-node').attr('data-id'));
        $(this).addClass('tree-selected');
    }
});

$(document).on("dblclick", 'div.tree-anchor.selectted', function (ev) {
    id = $(this).closest('li.tree-node').attr('data-id');
    tipo = $(this).closest('li.tree-node').attr('data-tipo');    
    params = {};
    params.id = id;
    if (tipo != '')
        MethodService("TiposCotizantes", "TipoCotizanteGet", JSON.stringify(params), 'EndCallBackGet');
});

$(document).on('click', '.tree-icon', function (ev) {
    var $lu = $(this).parent();
    var $li = $(this).closest('li.tree-node');

    if ($li.is('.tree-open')) {
        $li.removeClass('tree-open').addClass('tree-closed');
    } else {
        $li.removeClass('tree-closed').addClass('tree-open');
    }
});

$(document).on('click', 'span.tree-remove', function (ev) {
    if (confirm("Desea eliminar el Tipo de Cotizante?")) {
        id = $(this).closest('li.tree-node').data("id");
        params = {};
        params.id = id;
        MethodService("TiposCotizantes", "TipoCotizanteDelete", JSON.stringify(params), 'EndCallBackDelete');
    }
});

function formReset() {
    $("#btnSave").removeAttr('data-id');
    $('#code, #code_ext, #detalle ').val('')
    $('#tipocot').val('').selectpicker('refresh');
}

function SendJuzgado() {
    if (validate(JsonValidate)) {
        var params = {}
        params.id = ($('#btnSave').attr('data-id') == undefined ? 0 : $('#btnSave').attr('data-id'))
        params.code = $('#code').val()
        params.code_ext = $('#code_ext').val()
        params.detalle = $('#detalle').val()
        params.id_padre = !$('#btnSave').attr('data-idpadre') ? 0 : $('#btnSave').attr('data-idpadre');
        params.id_subtipo = setMultiSelect('tipocot')//$('#tipocot').val();
        MethodService("TiposCotizantes", "TipoCotizanteSaveUpdate", JSON.stringify(params), "EndCallBackSaveUpdate");
    }
}

function EndCallBackGet(params, answer) {
    if (!answer.Error) {
        data = answer.Row
        $("#btnSave").attr('data-id', data.id);
        $('#code').val(data.codigo)
        $('#code_ext').val(data.codigo_ext)
        $('#detalle').val(data.descr)
        if (data.is_subtipo != '') {
            subtipo = data.id_subtipo.split(',');
            $('#tipocot').val(subtipo).selectpicker('refresh');
        }

        $('#ModalAddTipo').modal({ backdrop: 'static', keyboard: false }, 'show');
    } else {
        toastr.error(answer.Message, "Sintesis ERP");
    }
}

function EndCallBackDelete(params, answer) {
    if (!answer.Error) {
        $('#BtnTipoCotizante').trigger('click');
        toastr.success("Proceso ejecutado correctamente", "Sintesis ERP");
    } else {
        toastr.error(answer.Message, "Sintesis ERP");
    }
}

function EndCallBackSaveUpdate(params, answer) {
    if (!answer.Error) {
        formReset();
        $('#ModalAddTipo').modal('hide');
        $('#BtnTipoCotizante').trigger('click');
        toastr.success("Registro Exitoso", "Sintesis ERP");
    } else {
        toastr.error(answer.Message, "Sintesis ERP");
    }
}

function EndCallbackHtmlTree(Parameter, Result) {
    if (!Result.error) {
        $('#ultipostree').html(Result.Message);
    }
    else {
        $('#ultipostree').html("");
        toastr.error(Result.Message, 'Sintesis ERP');
    }
    $('#BtnTipoCotizante').button('reset');
}