window.gridterc;
//Funcion para el cargado de la información en la tabla de listado de las bodegas ya guardadas.
function Loadtable() {
    window.gridterc = $("#tbltipo").bootgrid({
        ajax: true,
        post: function () {
            return {
                'params': "",
                'class': 'Solicitudes',
                'method': 'HistorialsolList'
            };
        },
        url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
        formatters: {
            "ver": function (column, row) {
                return "<a class=\"action command-ver\" data-row-id=\"" + row.id + "\"data-row-id_per=\"" + row.id_persona + "\"><span class=\"fa-2x fa fa-eye iconfa\"></span></a>";
            }
        }
    }).on("loaded.rs.jquery.bootgrid", function () {
        // Executes after data is loaded and rendered 
        window.gridterc.find(".command-ver").on("click", function (e) {

            removeerror();
            id = $(this).data("row-id")
            id_per = $(this).data("row-id_per")
            params = {};
            params.id_solicitud = id;
            params.id_persona = id_per;
            MethodService("Analisis", "AnalisisGetCredito", JSON.stringify(params), 'EndCallbackGet');
        });
    });
}

$(document).ready(function () {
    Loadtable();

});

//Resetear los campos del formulario
function formReset() {
    div = $('#ModalThirds');
    div.find('input.form-control').val('');
    $('#cd_catfiscal').attr('disabled', true);
    $('#Text_CodigoBarra').focus();
    $('#btnSave').attr('data-id', '0');
    $('#btncuenta').attr('disabled', 'disabled');
    $('#data-idtipoter').attr('data-id', '0');
    $('#v_razonsocial').val('');
    $('.i-checks').prop('checked', false);
    div.find('select').val('').selectpicker('refresh');
    $('.i-checks').iCheck('update');
}

var id_cot
//Funcion de retorno de la respuesta del servidor al consultar una bodega
function EndCallbackGet(params, answer) {
    if (!answer.Error) {
        data = answer.Table[0];
        $('#id_solicitud').val(data.id);
        $('#producto').val(data.producto);
        $('#cuotaini').val(data.cuotainicial.Money());
        $('#descuento').val(data.descuentos.Money());
        $('#valfinan').val(data.valorfinanciar.Money());
        $('#hidden_valfinan').val(data.valorfinanciar);
        $('#cuotas').val(data.numcuotas);
        $('#subtotal').val(data.precio.Money());
        $('#valcuotamen').val(data.valorcuotadia.Money());
        $('#observaciones').val(data.observaciones);
        $('#fecha_venc').val(data.fechaini);
        $('#lineacredit').val(data.lineacredit);
        $('#lineacredit').selectpicker('refresh');
        (data.credito == true ? $('#tipo_cartera').val(1) : $('#tipo_cartera').val(0));
        $('#tipo_cartera').selectpicker('refresh');
        $('#divlist, #divfilter').hide();
        $('#divinfo').show();
        id_cot = data.id_credito;
        $('#divagregados').empty();

        $('#btnConc').removeAttr('disabled');

        $.each(answer.Table, function (i, e) {
            CrearAgregado(e);
        });

        $('#myTimeline').albeTimeline(answer.list, {
            language: 'es-ES',
            showGroup: false,
            formatDate: 'd de MMMM de yyyy HH:mm:ss'
        });

        $('#nav1').click();
        $('#ModalSolicitud').modal({ backdrop: 'static', keyboard: false }, 'show');
        LoadArticulo();
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}






function CrearAgregado(Json) {
    var content = $('#divagregados');
    var div = $('<div id="' + Json.id_persona + '" class="col-lg-4 col-md-4 col-sm-12 col-xs-12 contactTop ' + Json.class + '"/>').attr('data-tipoper', ((Json.tipo == 'CL') ? "SOLICITANTE" : "CODEUDOR"));
    var divinf = $('<div class="contact bg-info"/>');
    var a = $('<a class="clearfix" title="Detalle del ' + ((Json.tipo == 'CL') ? "SOLICITANTE" : "CODEUDOR") + '" href="#"/>').attr('data-id_sol', Json.id_solicitud);
    var html = '<div class=" hidden-md col-lg-5 col-sm-4 roundImgParent ' + Json.id_persona + '"><img class="roundImg" src="' + ((Json.urlimg == null) ? foto : window.appPath + '/Pages/Connectors/ConnectorGetFile.ashx?token=' + Json.urlimg) + '' + '"></div>' +
        '<div class="col-lg-7" style="font-size: inherit;"><p><strong>' + ((Json.tipo == 'CL') ? "SOLICITANTE" : "CODEUDOR") + '</strong><br>' + Json.pnombre + ' ' + Json.snombre + ' <br/>' + Json.papellido + ' ' + Json.sapellido + ' <br/>' + Json.iden + '</p></div>';
    fotoget = ((window.appPath + '/Pages/Connectors/ConnectorGetFile.ashx?token=' + Json.urlimg == null) ? ((foto == null) ? fotoget : foto) : window.appPath + '/Pages/Connectors/ConnectorGetFile.ashx?token=' + Json.urlimg);
    a.html(html);
    divinf.append(a);
    div.append(divinf);
    content.append(div);
}

/*envia el id de la solicitud para generar el reporte*/
$('#btnPrint').click(function () {
    var idfactura = $('#id_solicitud').val();
    param = 'id|' + idfactura;
    PrintDocument(param, 'SOLICITCREDITO', 'CODE');
});


function LoadArticulo() {
    if (window.tblarticle == null) {
        window.tblarticle = $('#tblArticulo').bootgrid({
            ajax: true,
            post: function () {
                return {
                    'params': function () {
                        var param = {};
                        thi = $(this).closest('tr');
                        //$('#actCuotas').attr('data-idprod', this.attr('data-idarticulo'));
                        param.id_cotizacion = id_cot;
                        //param.id_solicitud = $('#id_solicitud').val();
                        return JSON.stringify(param);
                    },
                    'class': 'Solicitudes',
                    'method': 'HistorialProductoList'
                };
            },
            url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
            formatters: {
                "edit": function (column, row) {
                    a = '<a class="action command-edit" "data-idart="' + row.id_producto + '" data-nombre="' + row.nombre + '" data-cantidad="' + row.cantidad + '" data-precio="' + row.precio + '" data-iva="' + row.iva + '" ' + 'data-descuento="' + row.descuento + '" data - total="' + row.total + '" data - idart="' + row.id_producto + '" data - bodega="' + row.id_bodega + '" data - codigo="' + row.codigo + '"><span><i class="fa-2x fa fa-eye text-primary"></i></span></a>';

                    return a;
                },
                "delete": function (column, row) {
                    return '<a class="action command-delete" data - idart="' + row.id_producto + '" > <span class="fa-2x fa fa-trash text-danger"></span></a > '
                }
            } 
        }).on("loaded.rs.jquery.bootgrid", function () {
            window.tblarticle.find(".command-edit").on("click",function () {
                    thi = $(this);
                    $('#hiddenart').val(thi.attr('data-idart'));
                    $('#nombreart').val(thi.attr('data-nombre'));
                    $('#cant').val(thi.attr('data-cantidad'));
                    $('#price').val(thi.attr('data-precio'));
                    $('#codprod').val(thi.attr('data-codigo'));

                    var btn = $('#btnProd');
                    btn.html('');
                    var i = '<i class="fa fa-calculator"></i>'
                    btn.html(i);
                    btn.attr('title', 'Calcular');

                }).end().find(".command-delete").on("click", function () {
                    if (confirm('Seguro que desea eliminar este articulo?')) {
                        thi = $(this);
                        params = {};
                        params.id_cotizacion = $('#cd_cotizacion').val();
                        params.id_solicitud = $('#id_solicitud').val();
                        params.id_articulo = thi.attr('data-idart');
                        params.idToken = $('#idToken').val();
                        MethodService('Analisis','AnalisisCotizacionRemoveItem', JSON.stringify(params), 'EndCallBackGetRemoveItem');
                    }
                })

        });
    } else {
        window.tblarticle.bootgrid('reload');
    }
}
