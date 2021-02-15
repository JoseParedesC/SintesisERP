var JsonValidate = [{ id: 'v_starttime', type: 'MILITARYHOUR', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
                    { id: 'v_endtime', type: 'MILITARYHOUR', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];

window.gridtur;

function Loadtable() {
    window.gridtur = $("#tblturnos").bootgrid({
        ajax: true,
        navigation : false,
        post: function () {
            return {
                'params': "",
                'class': 'Turno',
                'method': 'TurnosList'
            };
        },
        url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
        formatters: {
            "edit": function (column, row) {
                return "<a class=\"action command-edit\" data-row-id=\"" + row.id + "\"><span class=\"fa-2x fa fa-pencil iconfa\"></span></a>";
            },
            "state": function (column, row) {
                console.log(row.estado)
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
        window.gridtur.find(".command-edit").on("click", function (e) {
            removeerror();
            id = $(this).data("row-id")
            params = {};
            params.id = id;
            MethodService("Turno", "TurnosGet", JSON.stringify(params), 'EndCallbackGet');
        }).end().find(".command-delete").on("click", function (e) {
            if (confirm("Desea eliminar el Turno?")) {
                id = $(this).data("row-id");
                params = {};
                params.id = id;
                MethodService("Turno", "TurnosDelete", JSON.stringify(params), 'EndCallbackupdate');
            }
        }).end().find(".command-state").on("click", function (e) {
            id = $(this).data("row-id");
            params = {};
            params.id = id;
            MethodService("Turno", "TurnosState", JSON.stringify(params), 'EndCallbackupdate');
        });
    });
}

$(document).ready(function () {
    Loadtable();
});

$('.iconnew').click(function (e) {
    formReset();
    $('#ModalShifts').modal({ backdrop: 'static', keyboard: false }, 'show');
});

function formReset() {
    div = $('#ModalShifts');
    div.find('input.form-control').val('');
    $('#btnSave').attr('data-id', '0');
}

$('#btnSave').click(function (e) {
    if (validate(JsonValidate)) {
        params = {};
        params.id = $(this).attr('data-id');
        params.horainicio = $('#v_starttime').val();
        params.horafin = $('#v_endtime').val();
        var btn = $(this);
        btn.button('loading');
        MethodService("Turno", "TurnosSave", JSON.stringify(params), "EndCallbackGroup");
    }
});

function EndCallbackGroup(params, answer) {
    if (!answer.Error) {        
        $('#ModalShifts').modal("hide");
        window.gridtur.bootgrid('reload');
    }
    else {
        toastr.error(answer.Message, 'Sintesis POS');
    }

    $('#btnSave').button('reset');
}

function EndCallbackGet(params, answer) {
    if (!answer.Error) {
        data = answer.Row;
        $('#btnSave').attr('data-id', data.id);
        $('#v_starttime').val(data.horainicio);
        $('#v_endtime').val(data.horafin);
        $('#ModalShifts').modal({ backdrop: 'static', keyboard: false }, 'show');
    }
    else {
        toastr.error(answer.Message, 'Sintesis POS');
    }
}

function EndCallbackupdate(params, answer) {
    if (!answer.Error) {
        window.gridtur.bootgrid('reload');
    }
    else {
        answer.Message
        toastr.error(answer.Message, 'Sintesis POS');
    }
}

