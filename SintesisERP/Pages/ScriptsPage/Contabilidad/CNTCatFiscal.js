var JsonValidate = [{ id: 'Text_Codigo', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'descripcion', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];
var JsonValidateSer = [{ id: 'ds_concepto', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];

window.gridcatfis;
window.gridcatfisser;
function Loadtable() {
    window.gridcatfis = $("#tblcatfis").bootgrid({
        ajax: true,
        post: function () {
            return {
                'params': "",
                'class': 'CNTCatFiscal',
                'method': 'CNTCatFiscalList'
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
        window.gridcatfis.find(".command-edit").on("click", function (e) {
            removeerror();
            id = $(this).data("row-id")
            params = {};
            params.id = id;
            MethodService("CNTCatFiscal", "CNTCatFiscalGet", JSON.stringify(params), 'EndCallbackGet');
        }).end().find(".command-delete").on("click", function (e) {
            if (confirm("Desea eliminar la Categoría?")) {
                id = $(this).data("row-id");
                params = {};
                params.id = id;
                MethodService("CNTCatFiscal", "CNTCatFiscalDelete", JSON.stringify(params), 'EndCallbackupdate');
            }
        }).end().find(".command-state").on("click", function (e) {
            id = $(this).data("row-id");
            params = {};
            params.id = id;
            MethodService("CNTCatFiscal", "CNTCatFiscalState", JSON.stringify(params), 'EndCallbackupdate');
        });
    });
    window.gridcatfisser = $("#tblcatfiserv").bootgrid({
        ajax: true,
        post: function () {
            return {
                'params': "",
                'class': 'CNTCatFiscal',
                'method': 'CNTCatFiscalServicioList'
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
        window.gridcatfisser.find(".command-edit").on("click", function (e) {
            removeerror();
            id = $(this).data("row-id")
            params = {};
            params.id = id;
            MethodService("CNTCatFiscal", "CNTCatFiscalServicioGet", JSON.stringify(params), 'EndCallbackGet');
        }).end().find(".command-delete").on("click", function (e) {
            if (confirm("Desea eliminar la Categoría?")) {
                id = $(this).data("row-id");
                params = {};
                params.id = id;
                MethodService("CNTCatFiscal", "CNTCatFiscalServicioDelete", JSON.stringify(params), 'EndCallbackupdate');
            }
        }).end().find(".command-state").on("click", function (e) {
            id = $(this).data("row-id");
            params = {};
            params.id = id;
            MethodService("CNTCatFiscal", "CNTCatFiscalServicioState", JSON.stringify(params), 'EndCallbackupdate');
        });
    });
}

$(document).ready(function () {
    Loadtable();
});

$('.iconnew').click(function (e) {
    formReset($(this).data('option'));
    fieldsMoney();
    if ($(this).data('option') == 'C') {
        $('#ModalCategoria').modal({ backdrop: 'static', keyboard: false }, 'show');
        $('[money]').val('0.00').attr('disabled', true);
        $('.btnsearch').attr('disabled', true);
    }
    else
        $('#ModalCategoriaSer').modal({ backdrop: 'static', keyboard: false }, 'show');

});

function formReset(option) {
    div = $('#ModalCategoria,#ModalCategoriaSer');
    div.find('input.form-control').val('').removeAttr('disabled');
    (option == 'C') ? div.find('input[type="hidden"]').val('') : $('#typedoc').val('COMPRAS') && $('#isDescuento').val(0);
    div.find('[money]').val('0.00');
    option == 'C' ? div.find('select').val('').attr('disabled', true).selectpicker('refresh') : div.find('select').val('').removeAttr('disabled').selectpicker('refresh');
    $('#retiene').prop('checked', false).iCheck('update');
    $('.btnsearch').removeAttr('disabled');
    $('#btnSave,#btnSaveSer').attr('data-id', '0');
}


$('#btnSave').click(function (e) {
    if (validate(JsonValidate)) {
        params = {};
        params.id = $(this).attr('data-id');
        params.codigo = $('#Text_Codigo').val();
        params.retiene = $('#retiene').prop('checked');

        params.descripcion = $('#descripcion').val();
        params.fuentebase = $('#retfuentebase').val().replace(/,/gi, '');;
        params.id_retefuente = $('#cd_retefuente').val();

        params.ivabase = $('#retivabase').val().replace(/,/gi, '');;
        params.id_reteiva = $('#cd_reteiva').val();

        params.icabase = $('#reticabase').val().replace(/,/gi, '');;
        params.id_reteica = $('#cd_reteica').val();
        var btn = $(this);
        btn.button('loading');
        MethodService("CNTCatFiscal", "CNTCatFiscalSave", JSON.stringify(params), "EndCallback");
    }
});


$('#btnSaveSer').click(function (e) {
    if (validate(JsonValidateSer)) {
        params = {};
        params.id = $(this).attr('data-id');
        params.id_servicio = $('#cd_concepto').val();

        params.fuentebase = $('#retfuentebaseser').val().replace(/,/gi, '');;
        params.id_retefuente = $('#cd_retefuenteser').val();

        params.ivabase = $('#retivabaseser').val().replace(/,/gi, '');;
        params.id_reteiva = $('#cd_reteivaser').val();

        params.icabase = $('#reticabaseser').val().replace(/,/gi, '');;
        params.id_reteica = $('#cd_reteicaser').val();

        if (params.id_retefuente === '' && params.fuentebase != 0) {
            toastr.error('Por favor diligenciar impuesto de retefuente', 'Sintesis ERP');
        } else {
            if (params.id_reteiva === '' && params.ivabase != 0) {
                toastr.error('Por favor diligenciar impuesto de reteiva', 'Sintesis ERP');
            } else {
                if (params.id_reteica === '' && params.icabase != 0) {
                    toastr.error('Por favor diligenciar impuesto de reteica', 'Sintesis ERP');
                } else {
                    var btn = $(this);
                    btn.button('loading');
                    MethodService("CNTCatFiscal", "CNTCatFiscalServicioSave", JSON.stringify(params), "EndCallback");
                }
            }
        }

    }
});

function EndCallback(params, answer) {
    if (!answer.Error) {
        $('#ModalCategoria,#ModalCategoriaSer').modal("hide");
        window.gridcatfis.bootgrid('reload');
        window.gridcatfisser.bootgrid('reload');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
    $('#btnSave,#btnSaveSer').button('reset');
}

function EndCallbackGet(params, answer) {
    if (!answer.Error) {
        formReset();
        data = answer.Row;
        if (data.servicio === undefined) {
            $('#btnSave').attr('data-id', data.id);
            $('#Text_Codigo').val(data.codigo).attr('disabled', true);
            $('#descripcion').val(data.descripcion);
            $('#retiene').prop('checked', data.retiene);
            if (data.retiene) {
                $('#retfuentebase').val(data.fuentebase.Money()).removeAttr('disables');
                $('#cd_retefuente').val(data.id_retefuente);
                $('#retivabase').val(data.ivabase.Money()).removeAttr('disables');;
                $('#cd_reteiva').val(data.id_reteiva);
                $('#reticabase').val(data.icabase.Money()).removeAttr('disables');;
                $('#cd_reteica').val(data.id_reteica);
                $('#ModalCategoria').find('select').removeAttr('disabled').selectpicker('refresh');
            } else {
                $('#cd_retefuente').val('').selectpicker('refresh');
                $('#cd_reteiva').val('').selectpicker('refresh');
                $('#cd_reteica').val('').selectpicker('refresh');
                $('#ModalCategoria').find('[money]').attr('disabled', true);
            }
            fieldsMoney();
            $('.i-checks').iCheck('update');
            $('#ModalCategoria').modal({ backdrop: 'static', keyboard: false }, 'show');
        } else {
            $('#btnSaveSer').attr('data-id', data.id);
            $('#ds_concepto').val(data.servicio).attr('disabled', true);
            $('#retfuentebaseser').val(data.fuentebase.Money()).removeAttr('disables');
            $('#cd_retefuenteser').val(data.id_retefuente);
            $('#retivabaseser').val(data.ivabase.Money()).removeAttr('disables');;
            $('#cd_reteivaser').val(data.id_reteiva);
            $('#reticabaseser').val(data.icabase.Money()).removeAttr('disables');;
            $('#cd_reteicaser').val(data.id_reteica);
            $('#ModalCategoriaSer').find('select').removeAttr('disabled').selectpicker('refresh');
            $('.btnsearch').attr('disabled', true);
            $('#ModalCategoriaSer').modal({ backdrop: 'static', keyboard: false }, 'show');
        }
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}

function EndCallbackupdate(params, answer) {
    if (!answer.Error) {
        window.gridcatfis.bootgrid('reload');
        window.gridcatfisser.bootgrid('reload');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}

$('#retiene').on('ifChecked', function (event) {
    $('[money]').val('0.00').removeAttr('disabled');
    $('#ModalCategoria').find('select').removeAttr('disabled').selectpicker('refresh');
    $('.btnsearch').removeAttr('disabled');
}).on('ifUnchecked', function () {
    $('.input-group').find('input.form-control').val('');
    $('.input-group').find('input[type="hidden"]').val('');
    $('#ModalCategoria').find('select').val('').attr('disabled', true).selectpicker('refresh');
    $('[money]').val('0.00').attr('disabled', true);
    $('.btnsearch').attr('disabled', true);
});
