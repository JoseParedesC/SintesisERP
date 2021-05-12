var JsonValidate = [{ id: 'code', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
{ id: 'code_ext', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
{ id: 'detalle', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' }];

window.tblcommodity;
function LoadTable() {
    window.tblcommodity = $('#tblcommodity').bootgrid({
        ajax: true,
        post: function () {
            return {
                'params': "",
                'class': 'TiposCotizantes',
                'method': 'SubtipoCotizanteList'
            };
        },
        url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
        formatters: {
            "edit": function (column, row) {
                return "<a class=\"action command-edit\" data-id=\"" + row.id + "\"><span class=\"fa-2x fa fa-pencil text-success iconfa\"></span></a>";
            },
            "delete": function (column, row) {
                return "<a class=\"action command-delete\" data-id=\"" + row.id + "\"><span class=\"fa-2x fa fa-trash text-danger iconfa\"></span></a>";
            },
            "state": function (column, row) {
                clas = row.estado == 1 ? "fa-square-o text-danger" : "fa-check-square-o text-success"
                return "<a class=\"action command-state\" data-id=\"" + row.id + "\"><span class=\"fa-2x fa " + clas + " iconfa\"></span></a>";
            }
        }
    }).on("loaded.rs.jquery.bootgrid", function () {
        window.tblcommodity.find(".command-edit").on("click", function (e) {
            params = {};
            params.id = $(this).attr("data-id");
            MethodService("TiposCotizantes", "SubtipoCotizanteGet", JSON.stringify(params), "EndCallBackGetSubTipoCot");
        }).end().find(".command-delete").on("click", function (e) {
            if (confirm("Está seguro que desea eliminarlo?")) {
                params = {};
                params.id = $(this).attr("data-id");
                MethodService("TiposCotizantes", "SubtipoCotizanteDelete", JSON.stringify(params), "EndCallBackDelete");
            }
        }).end().find(".command-state").on("click", function () {
            params = {};
            params.id = $(this).attr("data-id");
            MethodService("TiposCotizantes", "SubtipootizanteState", JSON.stringify(params), "EndCallBackState");
        })
    });

}

$(document).ready(function () {

    $('select').selectpicker();

    LoadTable();

    $('.iconnew').click(function (e) {
        formReset();
        $('#ModalAddTipo').modal({ backdrop: 'static', keyboard: false }, 'show');
    });

    $("#btnSave").click(function () {
        SendJuzgado()
    });
});

function formReset() {
    $("#btnSave").removeAttr('data-id');
    $('#code, #code_ext, #detalle, #ds_embargo, #id_embargo').val('')
    $('#id_tipocot').val('');
    $('.selectpicker').selectpicker('refresh');
}

function SendJuzgado() {
    if (validate(JsonValidate)) {
        var params = {}
        params.id = ($('#btnSave').attr('data-id') == undefined ? 0 : $('#btnSave').attr('data-id'))
        params.code = $('#code').val()
        params.code_ext = $('#code_ext').val()
        params.detalle = $('#detalle').val()
        params.id_tipocot = $('#id_tipocot').val();
        MethodService("TiposCotizantes", "SubtipoCotizanteSaveUpdate", JSON.stringify(params), "EndCallBackSaveUpdate");
    }
}

function EndCallBackGetSubTipoCot(params, answer) {
    if (!answer.Error) {
        data = answer.Row
        $("#btnSave").attr('data-id', data.id);
        $('#code').val(data.codigo)
        $('#code_ext').val(data.codigo_ext)
        $('#detalle').val(data.detalle)
        $('#id_tipocot').val(data.id_cotizante);
        $('#id_tipocot').selectpicker('refresh');

        $('#ModalAddTipo').modal({ backdrop: 'static', keyboard: false }, 'show');
    } else {
        toastr.error(answer.Message, "Sintesis ERP");
    }
}

function EndCallBackDelete(params, answer) {
    if (!answer.Error) {
        window.tblcommodity.bootgrid('reload');
        toastr.success("Proceso ejecutado correctamente", "Sintesis ERP");
    } else {
        toastr.error(answer.Message, "Sintesis ERP");
    }
}

function EndCallBackState(params, answer) {
    if (!answer.Error) {
        window.tblcommodity.bootgrid('reload');
        toastr.success("Proceso ejecutado satisfactoriamente", "Sintesis ERP");
    } else {
        toastr.error(answer.Message, "Sintesis ERP");
    }
}

function EndCallBackSaveUpdate(params, answer) {
    if (!answer.Error) {
        formReset();
        $('#ModalAddTipo').modal('hide');
        window.tblcommodity.bootgrid('reload');
        toastr.success("Registro Exitoso", "Sintesis ERP");
    } else {
        toastr.error(answer.Message, "Sintesis ERP");
    }
}