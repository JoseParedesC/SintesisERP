var JsonValidate = [{ id: 'id_ccosto', type: 'WHOLE', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
{ id: 'v_codigo', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'sd_datestar', type: 'DATE', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'sd_dateend', type: 'DATE', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'prefijo', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
{ id: 'ini', type: 'WHOLE', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'fin', type: 'WHOLE', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'factura', type: 'WHOLE', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'v_legend', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];

var JsonEditValidate = [{ id: 'id_editccosto', type: 'WHOLE', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
{ id: 'v_editlegend', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];

window.gridresol;
function Loadtable() {
    window.gridresol = $("#tblresol").bootgrid({
        ajax: true,
        post: function () {
            return {
                'params': "",
                'class': 'CNTResoluciones',
                'method': 'CNTResolucionesList'
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
            "isfe": function (column, row) {
                if (row.isfe != 0)
                    return "<a> <span class='fa fa-2x fa-fw fa-check text-success iconfa'></span></a>";
                else
                    return "<a> <span class='fa fa-2x fa-fw fa-close text-danger iconfa'></span></a>";
            },
            "delete": function (column, row) {
                return "<a class=\"action command-delete\" data-row-id=\"" + row.id + "\"><span class=\"fa fa-2x fa-trash-o text-danger iconfa\"></span></a>";
            }
        }
    }).on("loaded.rs.jquery.bootgrid", function () {
        // Executes after data is loaded and rendered 
        window.gridresol.find(".command-edit").on("click", function (e) {
            removeerror();
            id = $(this).data("row-id");
            params = {};
            params.id = id;
            MethodService("CNTResoluciones", "CNTResolucionesGet", JSON.stringify(params), 'EndCallbackGet');
        }).end().find(".command-delete").on("click", function (e) {
            if (confirm("Desea eliminar la Resolución?")) {
                id = $(this).data("row-id");
                params = {};
                params.id = id;
                MethodService("CNTResoluciones", "CNTResolucionesDelete", JSON.stringify(params), 'EndCallbackupdate');
            }
        }).end().find(".command-state").on("click", function (e) {
            if (confirm("Seguro de cambiar el estado de esta resolución?")) {
                id = $(this).data("row-id");
                params = {};
                params.id = id;
                MethodService("CNTResoluciones", "CNTResolucionesState", JSON.stringify(params), 'EndCallbackupdate');
            }
        });
    });
}


$(document).ready(function () {
    Loadtable();
});

$('.iconnew').click(function (e) {
    formReset();
    $('#ModalResolution').modal({ backdrop: 'static', keyboard: false }, 'show');
});

function formReset() {
    div = $('#ModalResolution');
    div.find('input.form-control, select').val('');
    div.find('textarea').val('');
    div.find('select').selectpicker('refresh');
    $('#btnSave').attr('data-id', '0');
}

function EndCallbackResolution(params, answer) {
    if (!answer.Error) {
        $('#ModalResolution').modal("hide");
        window.gridresol.bootgrid('reload');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }

    $('#btnSave, #btnEditSave').button('reset');
}


function EndCallbackGet(params, answer) {
    if (!answer.Error) {
        data = answer.Row;
        $('#btnSave').attr('data-id', data.id);
        $('#id_ccosto').val(data.id_ccosto).selectpicker('refresh');
        $('#v_codigo').val(data.resolucion);
        $('#sd_datestar').val(data.fechainicio);
        $('#sd_dateend').val(data.fechafin);
        $('#prefijo').val(data.prefijo);
        $('#ini').val(data.rangoini.Money(0));
        $('#fin').val(data.rangofin.Money(0));
        $('#factura').val(data.consecutivo.Money(0));
        $('#v_legend').val(data.leyenda);
        $('#electronica').prop('checked', data.isfe).iCheck('update');
        $('#ModalResolution').modal({ backdrop: 'static', keyboard: false }, 'show');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}

function EndCallbackupdate(params, answer) {
    if (!answer.Error) {
        toastr.success('Actualizacion Exitosa', 'Sintesis ERP');
        window.gridresol.bootgrid('reload');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}

$(document).ready(function () {
    $('#btnSave').click(function (e) {
        if (validate(JsonValidate)) {
            params = {};
            params.id = $(this).attr('data-id');
            params.centrocosto = $('#id_ccosto').val();
            params.codigo = $('#v_codigo').val();
            params.fechainicio = $('#sd_datestar').val();
            params.fechafin = $('#sd_dateend').val();
            params.prefijo = $('#prefijo').val();
            params.ini = SetNumber($('#ini').val());
            params.fin = SetNumber($('#fin').val());
            params.factura = SetNumber($('#factura').val());
            params.leyenda = $('#v_legend').val();
            params.isfe = $('#electronica').prop('checked');
            var btn = $(this);
            btn.button('loading');
            MethodService("CNTResoluciones", "CNTResolucionesSave", JSON.stringify(params), "EndCallbackResolution");
        }
    });
});