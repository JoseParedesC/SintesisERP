var JsonValidate = [{ id: 'fecha', type: 'DATE', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];

window.gridcaj;
function Loadtable() {
    window.gridcaj = $("#tblfecha").bootgrid({
        ajax: true,
        post: function () {
            return {
                'params': function () {
                    var param = {};
                    param.anomes = $('#Text_Periodo').val();
                    return JSON.stringify(param);
                },
                'class': 'DiasFact',
                'method': 'PeriodosList'
            };
        },
        rowCount: [12],
        url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
        formatters: {
            "state": function (column, row) {
                return "<a class=\"action command-state\" data-row-mod='C' data-row-anomes='" + row.anomes + "' data-row-mesage='" + ((row.contabilidad) ? "cerrar" : "abrir") + "'data-row-id=\"" + row.id + "\">" +
                    "<span class=\"fa fa-2x fa-fw " +
                    ((!row.contabilidad) ? "fa-square-o text-danger" : "fa-check-square-o text-success") + "  iconfa\"></span></a>";
            },
            "statein": function (column, row) {
                return "<a class=\"action command-state\" data-row-mod='I' data-row-anomes='" + row.anomes + "' data-row-mesage='" + ((row.inventario) ? "cerrar" : "abrir") + "'data-row-id=\"" + row.id + "\">" +
                    "<span class=\"fa fa-2x fa-fw " +
                    ((!row.inventario) ? "fa-square-o text-danger" : "fa-check-square-o text-success") + "  iconfa\"></span></a>";
            },
            "select": function (column, row) {
                return "<a class=\"action command-select\" data-row-id=\"" + row.id + "\" data-row-anomes='" + row.anomes + "'><span class=\"fa fa-2x fa-fw fa-eye text-info iconfa\"></span></a>";
            }
        }
    }).on("loaded.rs.jquery.bootgrid", function () {
        // Executes after data is loaded and rendered 
        window.gridcaj.find(".command-state").on("click", function (e) {
            var mensaje = $(this).data("row-mesage");
            if (confirm("Desea " + mensaje + " el Periodo?")) {
                id = $(this).data("row-id");
                mod = $(this).data("row-mod");

                var ini = $(this).data("row-anomes")
                params = {};
                params.id = id;
                params.mod = mod;
                params.anomes = ini.replace('-', '');
                $('#fechasstring').empty()
                MethodService("DiasFact", "PeriodosState", JSON.stringify(params), 'EndCallbackDias');
            }
        }).end().find(".command-select").on("click", function (e) {
            var ini = $(this).data("row-anomes");
            $('#btnSave').attr('data-anomes', ini.replace('-', ''));
            params = {};
            params.anomes = ini.replace('-', '');
            params.anomesg = ini;
            MethodService("DiasFact", "DiasGetMonth", JSON.stringify(params), 'EndCallbackupdate');

        });
    });
}

$(document).ready(function () {
    Loadtable();
    var di = new Date();
    $('#Text_Dia').datepicker('setStartDate', di);
    $('#Text_Dia').datepicker('setEndDate', di);

    $("#refreshano").click(function () {
        window.gridcaj.bootgrid('reload');
    })
});


function EndCallbackDias(params, answer) {
    if (!answer.Error) {
        toastr.success("Proceso ejecutado exitosamente", "Sintesis ERP");
        window.gridcaj.bootgrid('reload');
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }

    $('#btnSave').button('reset');
}

$('#btnSave').click(function (e) {
    params = {};
    params.anomes = $(this).attr('data-anomes');
    if (params.anomes !== '') {
        var arr = $('.i-checks:checked').map(function () {
            return this.value;
        }).get();

        var str = arr.join(',');
        params.fechas = str;
        var btn = $(this);
        btn.button('loading');
        MethodService("DiasFact", "DiasFactSave", JSON.stringify(params), "EndCallbackDias");
    }
    else
        toastr.warning("Debe seleccionar un periodo.", 'Sintesis ERP');
});

function EndCallbackupdate(params, answer) {
    if (!answer.Error) {
        html = "<div class='sn_padding col-010 col-md-2 col-sm-3 col-xs-4'><div class='check-mail' style='margin-top: 2px'><input type='checkbox' {checked} class='i-checks pull-right' name='checkfecha' value='{value}' /></div><label class='checkf'>{fecha}</label></div>";
        data = answer.Row;
        par = JSON.parse(params);
        var dateAdded = data.fechas.split(',');
        $('#Text_Diastext').val(par.anomesg);

        var datePar = par.anomesg.split('-');
        ano = parseInt(datePar[0]);
        mes = parseInt(datePar[1]);
        dias = diasEnUnMes(mes, ano);
        htmls = "";
        strs = "";
        for (i = 1; i <= dias; i++) {
            checked = "";
            fechas = (i < 10) ? ("0" + i) : i;

            if (dateAdded.indexOf(i.toString()) > -1) {
                checked = "checked='checked'";
                strs += ((strs != '') ? ',' : '') + par.anomesg + '-' + fechas;
            }

            param = { fecha: fechas, checked: checked, value: par.anomesg + '-' + fechas };
            htmls += nano(html, param);
        }
        $('#fechasstring').empty().append(htmls);
        $('#valuedate').val(strs);

        $('#fechasstring .i-checks').iCheck({
            checkboxClass: 'icheckbox_square-green',
            radioClass: 'iradio_square-green',
        });

    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}

function diasEnUnMes(mes, año) {
    return new Date(año, mes, 0).getDate();
}
