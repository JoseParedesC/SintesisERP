
window.gridcaj;
window.gridenlog;
function Loadtable() {
    window.gridcaj = $("#tblcajas").bootgrid({
        ajax: true,
        post: function () {
            return {
                'params': "",
                'class': 'DiasFact',
                'method': 'CierreCajaList'
            };
        },
        url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
        formatters: {
            "state": function (column, row) {
                if (!row.estado) {
                    return "<a><span class=\"fa fa-2x fa-fw fa-square-o text-danger iconfa\"/></a>";
                }
                else {
                    return "<a class=\"action command-state\" data-row-id=\"" + row.id + "\"><span class=\"fa fa-2x fa-fw fa-check-square-o text-success  iconfa\" /></a>";
                }
            }
        }
    }).on("loaded.rs.jquery.bootgrid", function () {
        window.gridcaj.find(".command-state").on("click", function (e) {
            if (confirm("Desea cerrar esta caja?")) {
                $('#ModalLoad').modal({ backdrop: 'static', keyboard: false }, "show");
                id = $(this).data("row-id");
                params = {};
                params.id = id;
                MethodService("DiasFact", "CierreCajaClose", JSON.stringify(params), 'EndCallbackupdate');
            }
        });
    });
}

$(document).ready(function () {
    Loadtable();
});

function EndCallbackupdate(params, answer) {
    if (!answer.Error) {
        window.gridcaj.bootgrid('reload');
        toastr.success("Caja cerrada Exitosamente", 'Sintesis POS');
    }
    else {
        toastr.error(answer.Message, 'Sintesis POS');
    }
    $('#ModalLoad').modal('hide');
}