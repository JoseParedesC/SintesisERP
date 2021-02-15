//var JsonValidate = [{ id: 'Text_FechaDev', type: 'DATE', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
//{ id: 'ds_factura', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];

//var JsonCommodity = [{ id: 'v_presen', type: 'WHOLE', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
//{ id: 'cd_wineri', type: 'WHOLE', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
//{ id: 'm_quantity', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];

window.tblcommodity = null;
$(document).ready(function () {
    window.tblcommodity = $("#tblcommodity").bootgrid({
        ajax: true,
        post: function () {
            return {
                'params': function () {
                    var param = {};
                    param.fecha = SetDate($('#startDate').val());
                    param.fechafin = SetDate($('#endDate').val());
                    return JSON.stringify(param);
                },

                'class': "Contabilizar",
                'method': 'DocumentList'
            };
        },
        url: window.appPath + "/Pages/Connectors/ConnectorList.ashx", //conecta los metodos con los controladores*/
        //rowCount: -1,
        columnSelection: false,
        formatters: {
            "select": function (column, row) {
                return '<div class="check-mail"><input type="checkbox" ' + ((row.selected) ? 'checked="checked"' : '') + ' data-id="' + row.id + '" data-view="' + row.vista + '"  data-fecha="' + row.fecha + '" class="i-checks pull-right command-selected"  /></div>';
            },
            "total": function (column, row) {
                return row[column.id].Money();
            }
        }
    }).on("loaded.rs.jquery.bootgrid", function () {
        $('#tblcommodity .i-checks').iCheck({
            checkboxClass: 'icheckbox_square-green',
            radioClass: 'iradio_square-green',
        });
        $('#allcheck').on("ifChanged", function (e) {
            if ($(this).prop('checked')) {
                window.tblcommodity.find(".i-checks").prop('checked', true);
            } else {
                window.tblcommodity.find(".i-checks").prop('checked', false);
            }
            $('.i-checks').iCheck('update');
        })
        
    });
    //boton que refresca la busqueda con los datos ingresados en el filtro de fechas
    $('#btnRefreshTer').click(function () {
        window.tblcommodity.bootgrid('reload');
    });
    //Boton de contabilizar documentos seleccionados
    $('#btnSave').click(function () {
        var count = 0;
        if (!$('#allcheck').prop('checked')) {
            var XML = '<root>'
            window.tblcommodity.find(".i-checks").each(function (i,e) {
                var Data = $(e).data();
                if ($(e).prop('checked') == true) {
                    XML += '<cont><id>' + Data.id + '</id> <vista>' + Data.view + '</vista><fecha>' + (Data.fecha) + '</fecha><anomes>' + SetDate(Data.fecha) + '</anomes></cont>'
                    count=count+1
                }
            
            });
                XML += '</root>';
        }
        params = {};
        params.fecha    = SetDate($('#startDate').val());
        params.fechafin = SetDate($('#endDate').val());
        params.xml = count > 0 ? XML : null;
        $(this).button('loading');
        MethodService("Contabilizar", "ContabilizarPendientes", JSON.stringify(params), "EndCallback");
    });
});

//Funcion CallBack que se activa despues de facturado el recibo de caja
function EndCallback(params, answer) {
    if (!answer.Error) {
        toastr.success('Proceso Terminado.', 'Sintesis ERP');
        window.tblcommodity.bootgrid('reload');
        window.tblcommodity.find(".i-checks").prop('checked', false);
        $('#btnSave').button('reset');
        $('.i-checks').iCheck('update');

    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
        $('#btnSave').button('reset');
    }

}


