window.gridusuar = undefined;
window.gridreference;
id_referencia_persona = 0;

var JsonArticle = [
    { id: 'codprod', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'hiddenart', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'id_bodega', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'cant', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'price', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
];

var JsonCuotas = [{ id: 'cuotas', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'valfinan', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'fecha_venc', type: 'DATE', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'lineacredit', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
{ id: 'descuento', type: 'REAL', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
{ id: 'tipo_cartera', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
{ id: 'valoriva', type: 'REAL', htmltype: 'SELECT', required: true, depends: false, iddepends: '' }
];

var JsonValidate = [{ id: 'fexpe', type: 'DATE', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'fnaci', type: 'DATE', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'iden', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'id_tipoiden', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'id_tipoper', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'iden', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'pnombre', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'papellido', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'sapellido', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'ciudadexp', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'genero', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'estrato', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'ecivil', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'profesion', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'pcargo', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'scorreo', type: 'EMAIL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'stelefono', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'sotrotel', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'Text_city', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'direccion', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'id_escolaridad', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'vinmueble', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'varriendo', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'fraizcual', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'vehiculo', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
// END INFO PERSONAL

{ id: 'TipoAct', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'TipoEmpleo', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'sempresa', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'sedireccion', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'setelefono', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'secargoactual', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'setiemposer', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'sesalario', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'seotroing', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'gastos', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
// END INFO LABORAL

{ id: 'sbanco', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'tipocuenta', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'ncuenta', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }
    // END INFO BANCARIA
];


var JsonValidateConyuge = [{ id: 'nconyuge', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'idenconyuge', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'idencon', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'ctelefono', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'ccorreo', type: 'EMAIL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'elaboraconyuge', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'cdireccion', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'etelefono', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
{ id: 'esalario', type: 'REAL', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }
    // END INFO CONYUGE
];

function Loadtable() {
    window.gridusuar = $("#tblsolicitudes").bootgrid({
        ajax: true,
        post: function () {
            return {
                'params': function () {
                    var param = {};
                    param.id_estacion = ($('#id_estacionfil').val() == "") ? '0' : $('#id_estacionfil').val();
                    param.id_asesor = ($('#id_asesorfil').val() == "") ? '0' : $('#id_asesorfil').val();
                    param.estado = "SOLICIT|ENANAL";
                    param.op = "ENANAL";
                    return JSON.stringify(param);
                },
                'class': 'Analisis',
                'method': 'AnalisisList'
            };
        },
        url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
        formatters: {
            "edit": function (column, row) {
                var clase = "";
                if (row.estado == 'EN ANALISIS')
                    clase = "text-anals";
                return "<a class=\"action command-edit\" data-persona=\"" + row.id_persona + "\" data-row-id=\"" + row.id_solicitud + "\"><span class=\"fa-2x fa fa-eye " + clase + " iconfa\"></span></a>";
            }
        }
    }).on("loaded.rs.jquery.bootgrid", function () {
        // Executes after data is loaded and rendered 
        window.gridusuar.find(".command-edit").on("click", function (e) {
            $('#divpersonainfo').hide();
            params = {};
            params.id_solicitud = $(this).data("row-id");
            params.id_persona = $(this).data("persona");
            $('#detalleCot').removeAttr('disabled');
            MethodService("Analisis", "AnalisisGetCredito", JSON.stringify(params), 'EndCallbackGetCredito');
        })
    });

}

function LoadArticulo() {
    if (window.tblarticle == null) {
        window.tblarticle = $('#tblArticulo').bootgrid({
            ajax: true,
            post: function () {
                return {
                    'params': function () {
                        var param = {};
                        thi = $(this).closest('tr');
                        param.id_cotizacion = $('#cd_cotizacion').val();
                        param.id_solicitud = $('#id_solicitud').val();
                        param.idToken = $('#idToken').val();
                        return JSON.stringify(param);
                    },
                    'class': 'Analisis',
                    'method': 'AnalisisGetCreditoInfo'
                };
            },
            url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
            formatters: {
                "edit": function (column, row) {
                    a = '<a class="action command-edit"  "data-idart="' + row.id_producto + '" data-nombre="' + row.nombre + '" data-cantidad="' + row.cantidad + '" data-precio="' + row.precio.Money() + '" data-iva="' + row.iva + '" ' +
                        'data-descuento="' + row.descuento + '" data-total="' + row.total + '" data-idart="' + row.id_producto + '" data-bodega="' + row.id_bodega + '" data-codigo="' + row.codigo + '"><span><i class="fa-2x fa fa-eye text-primary"></i></span></a>';

                    $('#idToken').val(row.id_factura);

                    return a;
                },
                "delete": function (column, row) {
                    return '<a class="action command-delete" data-idart="' + row.id_producto + '"><span class="fa-2x fa fa-trash text-danger"></span></a>'
                },
                'precio': function (column, row) {
                    return row.precio.Money();
                },
                "total": function (column, row) {
                    return row.total.Money();
                },
                "iva": function (column, row) {
                    return row.iva.Money();
                },
                "descuento": function (column, row) {
                    return row.descuento.Money();
                }
            }
        }).on("loaded.rs.jquery.bootgrid", function () {
            window.tblarticle.find(".command-edit").on("click", function () {
                thi = $(this);
                $('#hiddenart').val(thi.attr('data-idart'));
                $('#nombreart').val(thi.attr('data-nombre'));
                $('#cant').val(thi.attr('data-cantidad'));
                $('#price').val('$ ' + thi.attr('data-precio'));
                $('#codprod').val(thi.attr('data-codigo'));

                var btn = $('#btnProd');
                btn.html('');
                var i = '<i class="fa fa-calculator"></i>'
                btn.html(i);
                btn.attr('title', 'Calcular');

            }).end().find(".command-delete").on("click", function () {
                if ($(this).attr('data-idart') != $('#hiddenart').val()) {
                    if (confirm('Seguro que desea eliminar este articulo?')) {
                        thi = $(this);
                        params = {};
                        params.id_cotizacion = $('#cd_cotizacion').val();
                        params.id_solicitud = $('#id_solicitud').val();
                        params.descuento = 0;
                        params.id_anticipo = 0;
                        params.id_articulo = thi.attr('data-idart');
                        params.idToken = $('#idToken').val();
                        MethodService('Analisis', 'AnalisisCotizacionRemoveItem', JSON.stringify(params), 'EndCallBackGetRemoveItem');
                    }
                } else {
                    toastr.error('No puede eliminarlo si está seleccionado para edicion', 'Sintesis Creditos');
                }
            })
        });
    } else {
        window.tblarticle.bootgrid('reload');
    }
}

$('#tipoper').change(function () {
    params = {};
    params.op = 'SELTIPOIDEN';
    params.Selectipoper = ($('#tipoper').val() == '') ? '0' : $('#tipoper').val();
    MethodService("Analisis", "CargarListadotipoiden", JSON.stringify(params), 'EndCallbackGetSelect');
});

function EndCallbackGetSelect(params, answer) {
    if (!answer.Error) {
        option = "<option value=''>Seleccione</option>";
        id_tipoiden = $('#id_tipoiden');
        id_tipoiden.empty();
        data = answer.Table;
        if (!data.length == 0) {
            $.each(data, function (i, e) {
                option += "<option value='" + e.id + "'>" + e.name + "</option>";
            });
            id_tipoiden.html(option).selectpicker('refresh');
        } else {
            id_tipoiden.html("<option value=''>Seleccione</option>").selectpicker('refresh');
        }
    }
    else {
        toastr.error(answer.Message, 'Sintesis Creditos');
    }
}


$('#tiporef').change(function () {
    params = {};
    params.op = 'SELTIPOREF';
    params.tiporef = ($('#tiporef').val() == '') ? '0' : $('#tiporef').val();
    MethodService("Analisis", "CargarListadotiporef", JSON.stringify(params), 'EndCallbackGetref');
});

function EndCallbackGetref(params, answer) {
    if (!answer.Error) {
        option = "<option value=''>Seleccione</option>";
        parentezco = $('#id_parentez');
        parentezco.empty();
        data = answer.Table;
        if (!data.length == 0) {
            $.each(data, function (i, e) {
                option += "<option value='" + e.id + "'>" + e.name + "</option>";
            });
            parentezco.html(option).selectpicker('refresh');
        } else {
            parentezco.html("<option value=''>Seleccione</option>").selectpicker('refresh');
        }
    }
    else {
        toastr.error(answer.Message, 'Sintesis Creditos');
    }
}


$(document).on('click', '.penditable', function () {
    if (!$(this).hasClass('cancel')) {
        id = $('#id_solper').val();
        var params = {};
        params.id = id;
        params.valor = $(this).attr('data-evaluation');
        params.button = '';
        params.op = $(this).closest('.evaluation').attr('data-evaluation');
        params.mensaje = 'Evaluación guardada';
        params.eval = 1;
        $(this).addClass('cancel');
        MethodService("Analisis", "AnalisisSaveEvaluation", JSON.stringify(params), 'EndCallbackSeguimiento');
    }
});


$(document).ready(function () {
    Loadtable();
    fieldsMoney();

    //$('#reportviewer').draggable();

    $('#tab1').on('click', function () {
        $('#detalleCot').show();
        $('#detalleCot').removeAttr('disabled');
        $('#btnBack').hide();
    });

    $('#tab2').on('click', function () {
        $('#detalleCot').hide();
        $('#actCuotas').hide();
        $('.EditCot').hide();
        $('#btnBack').show();
    });

    $('#tab3').on('click', function () {
        $('#detalleCot').hide();
        $('#actCuotas').hide();
        $('.EditCot').hide();
        $('#btnBack').hide()
    });

    $('select').selectpicker();
    var tdadd = $('<td class="text-center"/>').html('#');
    $('#tblreferen thead tr').append(tdadd);
    $('.bloque').removeAttr('disabled');

    $('#btnBack').on('click', function () {
        $('#acordeonSol').hide();
        $('#divagregados').show();
        $('#filesaves').empty();
        $('#btnUpdate').attr('disabled', 'disabled');
        $(this).css('display', 'none');
    });

    $('#codprod').autocomplete({
        serviceUrl: window.appPath + "/Pages/Connectors/Connector.ashx",
        type: 'post',
        datatype: 'json',
        paramName: 'keyword',
        params: { 'class': 'Productos', method: 'ArticulosBuscador' },
        noCache: true,
        onSelect: function (select) {
            if (select.data != 0) {
                $('#nombreart').attr('data-idprod', select.data);
                $('#hiddenart').val(select.data);
                loadpresentation(select.data, 0, select.data, $('#cd_wineridef').val());
            }
            else {
                $('#codprod').attr('data-id', '0');
                $('#codprod').val("");
            }

        },
        onSearchStart: function (query) {
            query.params = JSON.stringify({ filtro: query.keyword, op: 'A', o: '', formula: 0, id_prod: 0 });
        },
        minChars: 2,
        transformResult: function (response) {
            json = JSON.parse(response).ans;
            var object = json.data;
            if (object.length > 0) {
                return {
                    suggestions: $.map(object, function (dataItem) { return { value: dataItem.name, data: dataItem.id, inventarial: dataItem.inventarial }; })
                };
            }
            else {
                return { suggestions: [] }
            }
        }
    });

    $('#btnProd').on('click', function () {
        if ($('#hiddenart') != 0 & $('#hiddenart') != undefined & $('#hiddenart').val() != "") {
            var params = {};
            var method = "";
            var clas = "";
            params.idToken = $('#idToken').val();
            params.id_article = $('#hiddenart').val();
            params.id_bodega = $('#id_bodega').val();
            params.quantity = SetNumber($('#cant').val());
            params.precio = SetNumber($('#price').val());

            if (validate(JsonArticle)) {
                if ($(this).attr('title') == 'Agregar') {
                    method = "CotizacionAddArticulo";
                    clas = "Analisis";
                } else {
                    method = "CotizacionUpdateArticulo";
                    clas = "Analisis";
                }

                MethodService(clas, method, JSON.stringify(params), "EndCallbackAddArticle");
            } else {
                toastr.error('Campos obligatorios incompletos o diferentes a 0', 'Sintesis Creditos');
            }
        } else {
            toastr.warning('El codigo del producto no se encuentra dentro del catálogo', 'Sinteis Creditos');
        }
    });


    $('#descuento').on('change', function (e) {
        var valor = SetNumber($('#valfinan').val());
        var desc = SetNumber($('#descuento').val());
        if (e.keyCode == 46) {
            var total = valor + desc;
        } else {
            var total = valor - desc;
        }

        $('#valfinan').val(total);
        $('#valfinan').text(total.Money());
        if (validate(JsonCuotas) & $('#cuotas').val() > 0)
            actCuotas();
        $('#detalleCot').attr('data-option', 'F');
    });

    $('#cuotaini').on('change', function (e) {
        if ($('#descuento').attr('data-estado') == "true") {
            toastr.warning('Valor de descuento inválido', 'Sintesis Creditos');
            $('#descuento').attr('data-estado', "true");
            $(this).attr('disabled', 'disabled');
        } else {
            var cuota = SetNumber($('#cuotaini').val());
            var finan = SetNumber($('#valfinan').val());
            if (e.keyCode == 46) {
                var total = finan + cuota;
            } else {
                var total = finan - cuota;
            }

            $('#valfinan').val(total.Money());
            $('#valfinan').text(total.Money());
            if (validate(JsonCuotas) & $('#cuotas').val() > 0)
                actCuotas();
            $('#detalleCot').attr('data-option', 'F');
        }
    });

    $('#valoriva').on('change', function () {
        if ($(this).val() != 0) {
            var val = SetNumber($('#valfinan').val());
            var iva = $(this).val();
            const precio = (iva / 100) * val;
            var precioiva = parseInt(val) + precio;
            $('#valoriva').val(precio);
            $('#valoriva').text(precio.Money());
            $('#valfinan').val(precioiva);
            $('#valfinan').text(precioiva.Money());
            $('#detalleCot').attr('data-option', 'F');
        }
    });

    $('#cuotas').on('blur', function () {
        if (validate(JsonCuotas)) {
            actCuotas();
            $('#detalleCot').attr('data-option', 'D');
        } else {
            if ($('#lineacredit').val() == "" & $('#lineacredit').val() == undefined & $('#lineacredit').val() == 0) {
                toastr.error('Complete todos los campos necesarios', 'Sintesis Creditos');
            }
        }

    });


    // PENDIENTE POR REVISAR
    $('#actCuotas').click(function () {
        if ($('#detalleCot').attr('data-option') == "D") {
            if (validate(JsonCuotas) & $('#cuotas').val() > 0) {
                if (SetNumber($('#valfinan').val()) > -1) {
                    params = {};
                    params.descuento = SetNumber($('#descuento').val());
                    params.valoriva = SetNumber($('#valoriva').val());
                    params.forma = ($('#tipo_cartera').val() !== "" ? 1 : 0);
                    params.cuotaini = SetNumber($('#cuotaini').val());
                    params.lineacredit = $('#lineacredit').val();
                    params.venc = SetDate($('#fecha_venc').val());
                    params.cuotas = $('#cuotas').val();
                    params.cuotamen = SetNumber($('#valcuotamen').val());
                    params.valfinan = SetNumber($('#valfinan').val());
                    params.subtotal = SetNumber($('#precio').val());
                    params.observaciones = ($('#observaciones').val() == "" ? "" : $('#observaciones').val());
                    params.id_solicitud = $('#id_solicitud').val();
                    params.id_cotizacion = $('#cd_cotizacion').val();
                    params.idToken = $('#idToken').val();
                    MethodService("Analisis", "AnalisisUpdateCreditoCuotas", JSON.stringify(params), "EndCallBackUpdateCredit");
                    $(this).attr('data-send', 'T');
                } else {
                    toastr.error('No se pueden financiar $' + $('#valfinan').val() + ', verifique el descuento, cuota inicial y subtotal', 'Sintesis Creditos');
                }
                $('#detalleCot').show();
                $('#detalleCot').removeAttr('disabled');
                $('.EditCot').hide();
                $(this).hide();
            } else {
                $('#cuotas').val(($('#cuotas').val() != 0 ? $('#cuotas').val() : ""));
                validate(JsonCuotas);
                toastr.error('Verifique todos los campos requeridos y sus valores', 'Sintesis Creditos');
            }
        } else {
            toastr.warning('El valor de las cuotas mensuales debe actializarse', 'Sintesis Creditos');
        }
    });

    $('#detalleCot').on('click', function () {
        $('#actCuotas').attr('data-send', 'F');
        $('.bloq').removeAttr('disabled');
        $('#tipo_cartera').selectpicker('refresh');
        $('#lineacredit').selectpicker('refresh');
        $('.ob').css('display', 'none');
        $('.bloque').css('display', 'block');
        var Parameter = {};
        MethodService("General", "GetConsecutivo", JSON.stringify(Parameter), "EndCallbackTempFactura");
    });

    $(window).resize(function () {
        var tamaño = document.documentElement.clientWidth
        if (tamaño < 768) {
            $('.roundImg').hide();
        } else {
            $('.roundImg').show();
        }

        if (tamaño <= 1125) {
            $('.archivo').addClass('archivos');
            $('.row').removeClass('archivo');
            var col = $('.archivos').closest('.col-md-12');
            col.removeClass('col-md-12');
            col.addClass('col-md-11 col-sm-11 col-xs-11');
        } else {
            $('.archivos').addClass('archivo');
            $('.row').removeClass('archivos');
        }

    });

    datepicker();

    $('#tooglefull').click(function () {
        $modal = $('#ModalVisor');
        if ($modal.hasClass('file-zoom-fullscreen')) {
            $modal.removeClass('file-zoom-fullscreen');
        }
        else {
            $head = $modal.find('.modal-header:visible'),
                $foot = $modal.find('.modal-footer:visible'), $body = $modal.find('.modal-body'),
                h = $(window).height(), diff = 0;
            $modal.addClass('file-zoom-fullscreen');
            $modal.find('.kv-zoom-body').height(h);
        }
    });

    $('#id_estacionfil, #id_asesorfil').change(function () {
        window.gridusuar.bootgrid('reload');
    });

    $('#btnSaveseg').click(function () {
        id = $('#id_solicitud').val();
        var params = {};
        params.id = id;
        params.observaciones = '<b>Observación General</b></br>' + $('#seguimiento').val();
        params.button = 'btnSaveseg';
        params.visible = 1;
        if (params.observaciones != '' && params.observaciones != ' ') {
            params.mensaje = 'Seguimiento guardado'
            var btn = $(this);
            btn.button('loading');
            MethodService("Analisis", "AnalisisSaveSeguimiento", JSON.stringify(params), 'EndCallbackSeguimiento');
        } else {
            toastr.warning('No ha escrito ninguna observación.', 'Sintesis Creditos');
        }

    });

    $('#saveeval').click(function () {
        id = $('#id_solper').val();
        var params = {};
        params.id = id;
        params.valor = $('#sVal').val();
        var selattr = $('#sVal').attr('data-idoption');
        if (params.valor != '0' && params.valor != null) {
            params.button = 'saveeval';
            params.op = $(this).attr('data-evaluation');
            params.mensaje = 'Evaluación guardada'
            params.idsel = selattr;
            var btn = $(this);
            btn.button('loading');
            MethodService("Analisis", "AnalisisSaveEvaluation", JSON.stringify(params), 'EndCallbackSeguimiento');
        } else {
            toastr.warning('No ha escrito ninguna observación.', 'Sintesis Creditos');
        }
    });


    $('#addref').click(function () {
        var body = $('#tbodyreferen');

        params = {};

        nombre = $('#refnobre').val();
        direccion = $('#refdireccion').val();
        telefono = $('#reftelefono').val();
        tiporef = $('#tiporef').val();
        parent = $('#id_parentez').val();

        txtref = $('#tiporef option:selected').text();
        txtparent = $('#id_parentez option:selected').text();
        id_persona = $('#image_icon').attr('data-icon');

        id_referencia_persona = id_referencia_persona + 1;
        id = id_referencia_persona;

        if (!((nombre == undefined | nombre == '') | (direccion == undefined | direccion == '') | (telefono == undefined | telefono == '') | (txtref == 'Seleccione') | (txtparent == 'Seleccione'))) {

            tr = $('<tr/>').attr({
                'data-referencia': id,
                'data-nombre': nombre,
                'data-direccion': direccion,
                'data-telefono': telefono,
                'data-id-tipo': tiporef,
                'data-id-paren': parent,
                'data-id': id_persona,
                'data-estado': false,
                'data-ref': txtref
            });

            a = $('<a/>').html('<span class="fa fa-2x fa-trash-o text-danger iconfa"></span>').click(function () {

                alerta = confirm('Esta seguro que desea eliminarlo?');
                if (alert) {
                    thi = $(this).closest('tr');
                    param = {};
                    param.id = thi.attr('data-id');
                    $(this).closest('tr').remove();
                    MethodService("Analisis", "AnalisisUpdateDeleteRef", JSON.stringify(param), "EndCallBackDeleteRef");
                }
            });

            clas = "fa-eye-slash text-danger";

            view = $('<a/>').html('<span class="fa fa-2x ' + clas + ' iconfa iconreferenc"></span>').click(function () {
                param = {};
                param.estado = $(this).closest('tr').attr('data-estado');
                param.id = $(this).closest('tr').attr('data-referencia');
                EndCallBackStateAddRef(param);
            })

            td = $('<td class="text-center"/>').append(a);
            td1 = $('<td/>').html(nombre);
            td2 = $('<td/>').html(direccion);
            td3 = $('<td/>').html(telefono);
            td4 = $('<td/>').html(txtref);
            td5 = $('<td/>').html(txtparent);
            td6 = $('<td class="text-center"/>').append(view);
            tr.append(td, td1, td2, td3, td4, td5, td6);
            body.append(tr);
            CleanReference();
        } else {
            toastr.error('Debe llenar todos los campos de la referencia.', 'Sintesis Creditos');
        }

    });

    $('#savenote').click(function () {
        id = $('#id_solicitud').val();
        var params = {};
        params.id = id;
        params.observaciones = $('#notetext').val();
        params.visible = $('#visible').prop('checked');
        params.button = 'savenote';
        if (params.observaciones != '') {
            params.mensaje = 'Seguimiento guardado'
            var nombre = '(' + $('#iden').val() + ' - ' + $('#pnombre').val() + ' ' + $('#papellido').val() + ') </b> </br>'
            params.observaciones = '<b>(' + $(this).attr('data-note') + ') ' + nombre + $('#notetext').val();
            var btn = $(this);
            btn.button('loading');
            MethodService("Analisis", "AnalisisSaveSeguimiento", JSON.stringify(params), 'EndCallbackSeguimiento');
        } else {
            toastr.warning('No ha escrito ninguna observación.', 'Sintesis Creditos');
        }
    });


    var cont = 0;
    var a = 0;
    $('.evaluation').each(function () {
        cont++;
        var dis = $(this);
        var aprob = $('<i class="fa fa-check-square-o penditable checkevaluation" id="check-' + cont + '"  style="display: none; font-size: 10px;" title="Aprobado" data-evaluation="AP" data-nivel=""></i>');
        var desapro = $('<i class="fa fa-minus-square-o penditable checkevaluation" id="cance-' + cont + '" style="display: none; font-size: 10px" title="No Aprobado" data-evaluation="NP"></i>');
        desapro.appendTo(dis);
        aprob.appendTo(dis);

        aprob.click(function (e) {
            e.stopPropagation();
            $('.NoteForm').hide();
            var coord = dis.offset();
            $('#saveeval').attr('data-evaluation', $(this).closest('.evaluation').attr('data-evaluation'));
            $('.editForm').css({ top: coord.top - 60, right: 15 });
            $('.editForm').show();
            $('#sVal').attr('data-idoption', $(this).attr('id')).val($(this).attr('data-nivel'));
            $('#sVal').selectpicker('refresh');
            desapro.removeClass("cancel");
        });

    });

    $('.notepad').each(function () {
        var dis = $(this);
        $('#visible').prop('checked', true).iCheck('update');
        var note = $('<i title="Nota" class="fa fa-file-text-o penditabletext" style="display: none; font-size: 3px;"></i>');
        note.appendTo(dis);
        note.click(function (e) {
            e.stopPropagation();
            $('.editForm').hide();
            $('.NoteForm').find('#notetext').val('');
            $('#notetext').focus();
            var coord = dis.offset();
            $('.NoteForm').css({ top: coord.top - 60, right: 15 });
            $('.NoteForm').show();
            var text = $(this).closest('.notepad').attr('data-note');
            $('#savenote').attr('data-note', text);
        });
    });

    $('.hideLay, #divregistro li a').click(function () {
        $('.editForm, .NoteForm').hide();
        window.edit = false;
    });

    $('#btnConc').click(function () {
        var title = $(this).attr('title');
        if (title == 'Concluir') {
            $('.group2').show();
            $('.actionCredi').removeAttr('disabled');
        }
    });

    $('.actionCredi').click(function () {
        if (($('#actCuotas').attr('data-send') == "T" ? true : confirm('Tiene datos de la cotizacion pendientes por guardar, desea continuar sin guardar?'))) {
            $('#actCuotas').attr('data-send', 'T');
            var id = $('#id_solicitud').val();
            var params = {};
            var mensaje = $(this).attr('title');
            if (params.valor != '0') {
                if (confirm('Desea ' + mensaje + ' esta solicitud?')) {
                    params.id = id;
                    params.button = $(this).attr('id');
                    params.estado = $(this).attr('data-estado');
                    var btn = $(this);
                    btn.button('loading');
                    MethodService("Analisis", "SolicitudesState", JSON.stringify(params), 'EndCallbackEstado');
                }
            } else {
                toastr.warning('No ha Seleccionado ninguna solicitud.', 'Sintesis Creditos');
            }
        }
    });

    $('#ecivil').change(function () {
        val = $(this).val();
        atr = $(this).find('option:selected').attr('param');
        if (val != "" && atr != 'SOL')
            $('.conyuge').removeAttr('disabled');
        else {
            $('.conyuge').val('').attr('disabled', 'disbled');
        }
        $('select.conyuge').selectpicker('refresh');
    });

});

function EndCallBackStateAddRef(data) {

    if (data.estado == "false") {
        clas = "fa-eye text-primary";
        data.estado = true;
    } else {
        clas = "fa-eye-slash text-danger"
        data.estado = false;
    }

    var a = $('#tbodyreferen tr[data-referencia="' + data.id + '"]');
    a.attr('data-estado', data.estado);
    var b = a.find('span.iconreferenc');
    b.removeClass("fa-eye-slash text-danger");
    b.removeClass("fa-eye text-primary");
    b.addClass(clas);
}


function CleanReference() {
    $('#refnobre').val('');
    $('#refdireccion').val('');
    $('#reftelefono').val('');
    $('#tiporef').val('0').selectpicker('refresh');
    $('#id_parentez').val('0').selectpicker('refresh');
}

$('#btnList').click(function () {
    if (($('#actCuotas').attr('data-send') == "T" ? true : confirm('Tiene datos de la cotizacion pendientes por guardar, desea continuar sin guardar?'))) {
        $('.bloq').attr('disabled', 'disabled');
        $('.ob').css('display', 'block');
        $('#actCuotas').attr('data-send', 'T');
        $('#actCuotas').hide();
        window.gridusuar.bootgrid('reload');
        $('#id_solicitud').val('0');
        $('#divlist, #divfilter').show();
        $('#divinfo').hide();
        $('.actionCredi').hide();
        $('.btn-add').attr('disabled', 'disabled');
        $('.btn-add').show();
        $('.collapse').removeClass('in');
        $('.EditCot').css('display', 'none');
        $('#detalleCot').show();
        $('#detalleCot').removeAttr('disabled');
        $('#divagregados').show();
        $('#btnBack').css('display', 'none');
        var nav = $('.nav-tabs').children('.active');
        nav.removeClass('active');
        $('li.list:first').addClass('active');
        $('#tab-1').addClass('active');
        $('#tab-2').removeClass('active');
        $('#tab-3').removeClass('active');
    }
});


$('#btnUpdate').click(function () {
    var idsol = $('#id_solper').val();

    if (idsol != "" && idsol != "0") {

        if (validateReferencia()) {
            var answer = GetDatosForm();
            if (!answer.Error) {
                MethodService('Analisis', 'AnalisisUpdateSolicitud', JSON.stringify(answer.params), 'EndCallBackSaveReferencia');
            } else {
                toastr.error('Faltan datos requeridos por ingresar', 'Sintesis Creditos');
            }
        }
    }
    else {
        toastr.error('No se ha seleccionado solicitud.', 'Sintesis Creditos');
    }
});

function GetDatosForm() {

    var params = {};
    var Error = false;
    var Message = "Registro Exitoso";

    if (validate(JsonValidate)) {
        //DEUDOR
        params.id_persona = $('#image_icon').attr('data-icon');
        params.tipoper = $('#tipoper').val();
        params.tipoter = $('#tipoter').val();
        params.id_tipoper = ($('#id_tipoper').val() == '' ? 0 : $('#id_tipoper').val());
        params.iden = $('#iden').val();
        params.id_solicitud = $('#id_solicitud').val();
        params.tipo_iden = $('#id_tipoiden').val();
        params.verificacion = $('#identificacion').text();
        params.primernombre = $('#pnombre').val();
        params.segundonombre = $('#snombre').val();
        params.primerapellido = $('#papellido').val();
        params.segundoapellido = $('#sapellido').val();
        params.fechanacimiento = ($('#fnaci').val() == '' ? 0 : SetDate($('#fnaci').val()));
        params.fechaexpedicion = ($('#fexpe').val() == '' ? 0 : SetDate($('#fexpe').val()));
        params.id_ciudad = $('#Text_city').val();
        params.id_ciudadexped = ($('#ciudadexp').val() == '' ? 0 : $('#ciudadexp').val());
        params.id_genero = $('#genero').val();
        params.id_estrato = $('#estrato').val();
        params.id_estadocivil = $('#ecivil').val();
        params.id_profesion = $('#profesion').val();
        params.percargo = ($('#pcargo').val() == '' ? 0 : $('#pcargo').val());
        params.telefono = $('#stelefono').val();
        params.celular = $('#scelular').val();
        params.otrotel = $('#sotrotel').val();
        params.direccion = $('#direccion').val();
        params.correo = $('#scorreo').val();
        params.viveinmueble = ($('#vinmueble').val() == '' ? 0 : $('#vinmueble').val());
        params.valorarriendo = ($('#varriendo').val() == '' ? 0 : SetNumber($('#varriendo').val()));
        params.id_fincaraiz = ($('#fraiz').val() == '' ? 0 : $('#fraiz').val());
        params.cualfinca = $('#fraizcual').val();
        params.vehiculo = $('#vehiculo').val();
        params.escolaridad = ($('#id_escolaridad').val() == '' ? 0 : $('#id_escolaridad').val());

        //CONYUGE
        if ($('.conyuge').attr('disabled') != "disabled") {
            if (validate(JsonValidateConyuge)) {
                params.connombre = $('#nconyuge').val();
                params.contipo = ($('#idenconyuge').val() == '' ? 0 : $('#idenconyuge').val());
                params.coniden = $('#idencon').val();
                params.contelefono = $('#ctelefono').val();
                params.concorreo = $('#ccorreo').val();
                params.conempresa = $('#elaboraconyuge').val();
                params.condireccionemp = $('#cdireccion').val();
                params.contelefonoemp = $('#etelefono').val();
                params.consalario = ($('#esalario').val() == '' ? 0 : SetNumber($('#esalario').val()));
            } else {
                Error = true;
                Message = "Hacen falta datos del Conyuge";
            }
        } else {
            params.connombre = '';
            params.contipo = 0;
            params.coniden = '';
            params.contelefono = '';
            params.concorreo = '';
            params.conempresa = '';
            params.condireccionemp = '';
            params.contelefonoemp = '';
            params.consalario = 0;
        }

        //INFORMACION LABORAL
        params.id_tipoact = $('#TipoAct').val();
        params.id_tipoempleo = $('#TipoEmpleo').val();
        params.empresalab = $('#sempresa').val();
        params.direccionemp = $('#sedireccion').val();
        params.telefonoemp = $('#setelefono').val();
        params.cargo = $('#secargoactual').val();
        params.id_tiempoemp = $('#setiemposer').val();
        params.salarioemp = ($('#sesalario').val() == '' ? 0 : SetNumber($('#sesalario').val()));
        params.otroingreso = ($('#seotroing').val() == '' ? 0 : SetNumber($('#seotroing').val()));
        params.gastos = ($('#gastos').val() == '' ? 0 : SetNumber($('#gastos').val()));

        if ($('#seotroing').val() > 0 & $('#seconceptooi').val() != "") {
            Error = true;
        } else {
            params.concepto = ($('#seconceptooi').val() == '' ? 0 : $('#seconceptooi').val());
        }

        //REFERENCIA BANCARIA
        params.banco = $('#sbanco').val();
        params.id_tipocuenta = ($('#tipocuenta').val() == '' ? 0 : $('#tipocuenta').val());
        params.numcuenta = $('#ncuenta').val();


        //COTIZACION
        params.id_cotizacion = ($('#cd_cotizacion').val() == '' ? 0 : $('#cd_cotizacion').val());


        //XML
        var xml = '';
        $.each($('#tbodyreferen tr'), function (i, e) {
            element = $(e);
            xml += '<item nombre="' + element.attr('data-nombre')
                + '" direccion="' + element.attr('data-direccion')
                + '" telefono="' + element.attr('data-telefono')
                + '" tiporef="' + SetNumber(element.attr('data-id-tipo'))
                + '" parent="' + SetNumber(element.attr('data-id-paren'))
                + '" data-id="' + SetNumber(element.attr('data-id'))
                + '" estado="' + element.attr('data-estado')
                + '" referencia="' + SetNumber(element.attr('data-referencia')) + '"/>';
        });

        try {
            var id = element.attr('data-id');

            params.xml_id = (id == undefined ? 0 : id);
            params.xml = '<items>' + xml + '</items>';
        } catch{
            params.xml = '';
            params.xml_id = 0;
        }

        answer = {};
        answer.params = params;
        answer.Error = Error;
        answer.Message = Message;

        return answer;
    } else {
        answer = {};
        answer.params = '';
        answer.Error = true;
        answer.Message = "Hacen falta datos del formulario";

        return answer;
    }
}

$('#iden').blur(function () {
    var value = $(this).val();
    var dig = calcularDigitoVerificacion(value)
    $('#identificacion').val(dig);
    $('#identificacion').text(dig);
});

function SetValues(param) {

    $('#check-1').attr('data-nivel', param.evaldatos);
    (param.evaldatos == "NP" ? ($('#cance-1').removeClass("aprov") & $('#cance-1').addClass("cancel")) : $('#cance-1').addClass("aprov") & $('#cance-1').removeClass("cancel"));

    $('#check-2').attr('data-nivel', param.evallaboral);
    (param.evallaboral == "NP" ? ($('#cance-2').removeClass("aprov") & $('#cance-2').addClass("cancel")) : $('#cance-2').addClass("aprov") & $('#cance-2').removeClass("cancel"));

    $('#check-3').attr('data-nivel', param.evalbancaria);
    (param.evalbancaria == "NP" ? ($('#cance-3').removeClass("aprov") & $('#cance-3').addClass("cancel")) : $('#cance-3').addClass("aprov") & $('#cance-3').removeClass("cancel"));

    $('#check-4').attr('data-nivel', param.evalreferencia);
    (param.evalreferencia == "NP" ? ($('#cance-4').removeClass("aprov") & $('#cance-4').addClass("cancel")) : $('#cance-4').addClass("aprov") & $('#cance-4').removeClass("cancel"));
}

function calcularDigitoVerificacion(myNit) {
    var vpri,
        x,
        y,
        z;

    // Se limpia el Nit
    myNit = myNit.replace(/\s/g, ""); // Espacios
    myNit = myNit.replace(/,/g, ""); // Comas
    myNit = myNit.replace(/\./g, ""); // Puntos
    myNit = myNit.replace(/-/g, ""); // Guiones

    // Se valida el nit
    if (isNaN(myNit)) {
        toastr.info("La Identificación '" + myNit + "' no tiene digito de verificacion.", 'Sintesis Creditos');
        return "";
    };

    // Procedimiento
    vpri = new Array(16);
    z = myNit.length;

    vpri[1] = 3;
    vpri[2] = 7;
    vpri[3] = 13;
    vpri[4] = 17;
    vpri[5] = 19;
    vpri[6] = 23;
    vpri[7] = 29;
    vpri[8] = 37;
    vpri[9] = 41;
    vpri[10] = 43;
    vpri[11] = 47;
    vpri[12] = 53;
    vpri[13] = 59;
    vpri[14] = 67;
    vpri[15] = 71;

    x = 0;
    y = 0;
    for (var i = 0; i < z; i++) {
        y = (myNit.substr(i, 1));
        x += (y * vpri[z - i]);
    }

    y = x % 11;
    return (y > 1) ? 11 - y : y;
}

function EndCallBackUpdateCredit(params, answer) {
    if (!answer.Error)
        toastr.success("Actualización exitosa", "Sintesis Creditos");
    else {
        toastr.error(answer.Message, "Sintesis Creditos");
    }
}

function EndCallBackSaveReferencia(params, answer) {
    if (!answer.Error) {
        toastr.success("Proceso ejecutado.", 'Sintesis Creditos');
    } else {
        toastr.error(answer.Message, 'Sintesis Creditos');
    }
}

function EndCallbackEstado(params, answer) {
    var desecrip = JSON.parse(params);

    $('#' + desecrip.button).button('reset');
    if (!answer.Error) {
        toastr.success('Cambio de estado Exitoso.', 'Sintesis Creditos');
        setTimeout(function () { $('#btnList').trigger('click'); }, 400);
    }
    else {
        toastr.error(answer.Message, 'Sintesis Creditos');
    }
}

function EndCallBackDeleteRef(params, answer) {
    if (!answer.Error) {
        toastr.success('Referencia eliminada con éxito', 'Sintesis Creditos');
    } else {
        toastr.error(answer.Message, 'Sintesis Creditos');
    }
}

function EndCallbackSeguimiento(params, answer) {
    var desecrip = JSON.parse(params);
    if (!answer.Error) {
        $('#' + desecrip.idsel).attr('data-nivel', desecrip.valor);
        $('#seguimiento').val('');
        toastr.success(desecrip.mensaje + ' Exitosamente.', 'Sintesis Creditos');

        $('#myTimeline').albeTimeline(answer.Table, {
            language: 'es-ES',
            showGroup: false,
            formatDate: 'd de MMMM de yyyy HH:mm:ss'
        });

        var datapar = JSON.parse(params);
        if (datapar.eval != undefined) {
            var evalu = $('[data-evaluation="' + datapar.op + '"]');
            evalu.find('.checkevaluation').removeClass('active');
            evalu.find('i[data-evaluation="' + datapar.valor + '"]').addClass('active');
        }
        $('.editForm, .NoteForm').hide();
    }
    else {
        toastr.error(answer.Message, 'Sintesis Creditos');
    }

    $('#' + desecrip.button).button('reset');
}

function EndCallbackGetCredito(params, answer) {
    if (!answer.Error) {
        data = answer.Row;
        $('#numsolic').val(data.consecutivo);
        $('#asesor').val(data.usuario);
        $('#estado').val(data.estado);
        $('#Text_Fecha').val(data.fecha);
        $('#cd_cotizacion').val(data.cotizacion);

        $('#addref').attr('data-solicitud', data.id);

        data = answer.Table[0];


        $('#id_bodega').val(data.id_bodega);
        $('#producto').attr('data-idprod', data.id_articulo);
        $('#producto').val(data.producto);
        $('#precio').val(data.precio.Money());
        $('#precio').text('$ ' + data.precio.Money());
        $('#descuento').val('$ ' + data.descuentos.Money());
        $('#cuotaini').val('$ ' + data.cuotainicial.Money());
        $('#valfinan').val(data.valorfinanciar);
        $('#valfinan').text('$ ' + data.valorfinanciar.Money());
        $('#hidden_valfinan').val(data.valorfinanciar);
        $('#valoriva').val((data.iva == 0 | "" | undefined ? 0 : data.iva.Money()));
        $('#valoriva').text('$ ' + (data.iva == 0 | "" | undefined ? 0 : data.iva.Money()));
        $('#cuotas').val(data.numcuotas);
        $('#valcuotamen').val('$ ' + (data.valorcuotadia == 0 | undefined | "" ? 0 : data.valorcuotadia.Money()));
        $('#observaciones').val(data.observaciones);
        $('#fecha_venc').val(data.fechaini);
        $('#lineacredit').val(data.lineacredit);
        $('.form-group').removeClass('is-focused');
        $('#lineacredit').selectpicker('refresh');
        (data.credito == true ? $('#tipo_cartera').val(1) : $('#tipo_cartera').val(0));
        $('#tipo_cartera').selectpicker('refresh');

        $('#id_solicitud').val(data.id);
        $('#divlist, #divfilter').hide();
        $('#divinfo').show();
        $('#divagregados').empty();
        $('#btnConc').removeAttr('disabled');

        $.each(answer.Table, function (i, e) {
            CrearAgregado(e);
        });

        $("#filesaves").empty();

        $('#myTimeline').albeTimeline(answer.list, {
            language: 'es-ES',
            showGroup: false,
            formatDate: 'd de MMMM de yyyy HH:mm:ss'
        });

    }
    else {
        toastr.error(answer.Message, 'Sintesis Creditos');
    }
}

function EndCallbackDeleteFile(params, answer) {
    if (!answer.Error) {
        var data = JSON.parse(params);
        $('li[data-token="' + data.token + '"]').remove();
        toastr.success("Archivos eliminado exitosamente.", 'Sintesis Creditos');
    }
    else {
        toastr.error(answer.Message, 'Sintesis Creditos');
    }
}

function CrearAgregado(Json) {
    var content = $('#divagregados');
    var div = $('<div id="newdivagg" class="col-lg-6 col-md-6 col-sm-10 col-xs-12 contactTop ' + Json.class + '" style="margin-top:10px;" />').attr('data-tipoper', ((Json.tipo == 'CL') ? "SOLICITANTE" : "CODEUDOR"));
    var divinf = $('<div class="contact bg-info"/>');
    var a = $('<a id="image_icon" data-icon="' + Json.id_persona + '" class="clearfix" title="Detalle del ' + ((Json.tipo == 'CL') ? "SOLICITANTE" : "CODEUDOR") + '" href="#"/>').attr('data-id', Json.id);
    var html = '<div class="col-lg-6 col-md-6 col-sm-4 roundImgParent ' + Json.id_persona + '"><img class="roundImg" src="' + ((Json.urlimg == null) ? foto : window.appPath + '/Pages/Connectors/ConnectorGetFile.ashx?token=' + Json.urlimg) + '"></div>' +
        '<div class="col-lg-6 col-md-6 col-sm-8"><p><b>' + ((Json.tipo == 'CL') ? "SOLICITANTE" : "CODEUDOR") + '</b><br>' + Json.pnombre + ' ' + Json.snombre + '</br> ' + Json.papellido + ' ' + Json.sapellido + '<br>' + Json.iden + '</p></div>';

    $('#tipoter').val(Json.tipo);
    a.on('click', function () {
        $('#divagregados').hide();
        $('#acordeonSol').show();
        $('#btnBack').css('display', 'block');
        $('.accordion').addClass('acordion');
        var params = {};
        var titlesol = $(this).closest('div.contactTop').attr('data-tipoper');
        params.id = $(this).attr('data-id');
        params.tipoper = titlesol;
        params.id_persona = a.attr('data-icon');
        $('#id_solper').val(Json.id_solper);
        $('#id_persona').val(a.attr('data-icon'));

        MethodService("Analisis", "AnalisisGetPersona", JSON.stringify(params), 'EndCallbackGetPersona');
        $('#btnUpdate').removeAttr('disabled');
    });

    a.html(html);
    divinf.append(a);
    div.append(divinf);
    content.append(div);

}

function EndCallbackGetPersona(params, answer) {
    if (!answer.Error) {
        $('#loadingDiv').show();
        $("#loadingDiv").fadeOut(3000);
        var dara = answer.Row;
        SetDataPerson(dara, true);

        $('#form-t-0').click();
        var body = $('#tbodyreferen');
        body.empty();

        $.each(answer.Table, function (i, e) {
            tr = $('<tr/>').attr({
                'data-nombre': e.nombre,
                'data-direccion': e.direccion,
                'data-telefono': e.telefono,
                'data-id-tipo': e.id_tipo,
                'data-tipo': e.tipo,
                'data-id-paren': e.id_paren,
                'data-id': e.id,
                'data-estado': e.estado,
                'data-referencia': 0,
                'data-ref': e.tipo
            });
            a = $('<a/>').html('<span class="fa fa-2x fa-trash-o text-danger iconfa"></span>').click(function () {
                if ($('#estadosol').val() != "EXCEPCI") {
                    if (confirm('Seguro que desea eliminarlo?')) {
                        thi = $(this).closest('tr');
                        param = {};
                        param.id = thi.attr('data-id');
                        $(this).closest('tr').remove();
                        MethodService("Analisis", "AnalisisUpdateDeleteRef", JSON.stringify(param), "EndCallBackDeleteRef");
                    }
                } else {
                    toastr.warning('Usted no puede realizar esta acción', 'Sintesis Creditos');
                }

            });
            clas = "fa-eye-slash text-danger"
            if (e.estado)
                clas = "fa-eye text-primary";
            view = $('<a/>').html('<span class="fa fa-2x ' + clas + ' iconfa iconreferenc"></span>').click(function () {
                thi = $(this).closest('tr');
                var params = {};
                params.id = thi.attr('data-id');
                params.estado = thi.attr('data-estado');
                MethodService("Analisis", "AnalisisUpdateStateRef", JSON.stringify(params), "EndCallbackStateRef");
            })
            td = $('<td class="text-center"/>').append(a);
            td1 = $('<td/>').html(e.nombre);
            td2 = $('<td/>').html(e.direccion);
            td3 = $('<td/>').html(e.telefono);
            td4 = $('<td/>').html(e.tipo);
            td5 = $('<td/>').html(e.parentezco);
            td6 = $('<td class="text-center"/>').append(view);
            $('#id_personas_referencias').val(e.id);
            tr.append(td, td1, td2, td3, td4, td5, td6);
            id_referencia_persona = tr.attr('data-id');
            body.append(tr);
        })

        var file = $('#filesaves');
        file.empty();
        $.each(answer.Files, function (i, e) {
            var li = $('<li class="fist-item"/>').attr({ 'data-token': e.token, 'data-id_persol': e.id_persol, 'data-id': e.id, 'title': 'Ver archivo', 'data-op': e.op }).html('<span class="label label-info" style="margin-right: 5px;"><i class="fa fa fa-file-o fa-fw"></i></span>' + e.name);
            var span = $('<span class="pull-right text-danger" style="margin-right: 5px;font-size: 20px;margin-top: -6px;"><i class="fa fa-trash fa-fw"></i></span>');
            span.click(function (e) {
                e.stopPropagation();
                if (confirm('Desea eliminar el archivo?')) {
                    var token = $(this).closest('li').attr('data-token');
                    params = {};
                    params.token = token;
                    params.id_solicitudper = $(this).closest('li').attr('data-id_persol');
                    MethodService("Solicitudes", "SolicitudesDeleteFile", JSON.stringify(params), "EndCallbackDeleteFile");
                }
            });
            li.click(function () {
                var token = $(this).attr('data-token');
                var file = window.appPath + "/Pages/Connectors/ConnectorGetFile.ashx?&token=" + token;
                $("#iframeprint").attr('data', file);
                $('#reportviewer').modal({ backdrop: 'static', keyboard: false }, 'show');
                $('#iframeprint').attr('src', window.location.origin + '/' + file);
            });
            if (e.op == 'PC')
                span = null;
            li.prepend(span);
            file.append(li);
        })

        var dataparam = JSON.parse(params);
        var titlesol = dataparam.tipoper;
        ResetTituloSol(titlesol)
        $('#divpersonainfo').show();
        $("#loadingDiv").fadeOut(3000);

    }
    else {
        toastr.error(answer.Message, 'Sintesis Creditos');
    }
    setTimeout('removeC()', 3000);
}

function removeC() {
    $('.accordion').removeClass('acordion');
}

function SetDataPerson(dara, TP) {
    if (TP)

        //DEUDOR
        $('#id_tipoper').val(dara.tipo_persona);
    $('#tipoper').val(dara.tipoper);
    $('#iden').val(dara.identificacion);
    $('#id_tipoiden').val(dara.id_tipoiden);
    $('#identificacion').text(calcularDigitoVerificacion(dara.identificacion));
    $('#pnombre').val(dara.primernombre);
    $('#snombre').val(dara.segundonombre);
    $('#papellido').val(dara.primerapellido);
    $('#sapellido').val(dara.segundoapellido);
    $('#fnaci').val(dara.fechanacimiento);
    $('#fexpe').val(dara.fechaexpedicion);
    $('#Text_city').val(dara.id_ciudad);
    $('#ciudadexp').val(dara.id_ciudadexp);
    $('#genero').val(dara.id_genero);
    $('#estrato').val(dara.id_estrato);
    $('#ecivil').val(dara.id_estadocivil);
    $('#profesion').val(dara.profesion);
    $('#pcargo').val(dara.percargo);
    $('#stelefono').val(dara.telefono);
    $('#scelular').val(dara.celular);
    $('#sotrotel').val(dara.otrotel);
    $('#direccion').val(dara.direccion);
    $('#scorreo').val(dara.correo);
    $('#vinmueble').val(dara.id_viveinmueble);
    $('#varriendo').val(dara.valorarriendo.Money());
    $('#fraiz').val(dara.id_fincaraiz);
    $('#fraizcual').val(dara.cualfinca);
    $('#vehiculo').val(dara.vehiculo);
    $('#id_escolaridad').val(dara.id_escolaridad);

    //CONYUGE
    $('#nconyuge').val(dara.connombre);
    $('#idenconyuge').val(dara.contipoid);
    $('#idencon').val(dara.coniden);
    $('#ctelefono').val(dara.contelefono);
    $('#ccorreo').val(dara.concorreo);
    $('#elaboraconyuge').val(dara.conempresa);
    $('#cdireccion').val(dara.condireccionemp);
    $('#etelefono').val(dara.contelefonoemp);
    $('#esalario').val(dara.consalario.Money());

    //INFORMACION LABORAL
    (dara.id_tipoact == 0 ? '' : $('#TipoAct').val(dara.id_tipoact));
    $('#TipoEmpleo').val(dara.id_tipoemp);
    $('#sempresa').val(dara.empresalab);
    $('#sedireccion').val(dara.direccionemp);
    $('#setelefono').val(dara.telefonoemp);
    $('#secargoactual').val(dara.cargo);
    $('#setiemposer').val(dara.id_tiempoemp);
    $('#sesalario').val(dara.salarioemp.Money());
    $('#seotroing').val(dara.otroingreso.Money());
    $('#gastos').val(dara.gastos.Money());
    $('#seconceptooi').val(dara.concepto);

    //REFERENCIA BANCARIA
    $('#sbanco').val(dara.banco);
    $('#tipocuenta').val(dara.id_tipocuenta);
    $('#ncuenta').val(dara.numcuenta);

    SetValues(dara);

    var div = $('#divpersonainfo');
    div.find('select').selectpicker('refresh');
    $('#ecivil').trigger('change');

}

function EndCallBackCuotaMensual(params, answer) {
    if (!answer.Error) {
        data = answer.Table[0];
        $('#valcuotamen').val('$ ' + data.cuota.Money());
    } else {
        toastr.error("Verifique los campos requeridos", "Sintesis Creditos");
    }
}

function validateReferencia() {
    var table = $('#tbodyreferen');
    var returns = false;
    var count = 0;
    count = table.find('tr[data-ref="Familiar"]').length;
    if (count >= 2) {
        count = table.find('tr[data-ref="Personal"]').length;
        if (count >= 2) {
            returns = true;
        }
        else
            toastr.warning("Debe agregar minimo 2 referencias Personales.", 'Sintesis Creditos');
    }
    else
        toastr.warning("Debe agregar minimo 2 referencias Familiares.", 'Sintesis Creditos');

    return returns;
}

function EndCallBackGetRemoveItem(param, answer) {
    if (!answer.Error) {
        Data = answer.Row[0];
        TotalizarFactura(Data);
        window.tblarticle.bootgrid('reload');

        toastr.success('Se ha eliminado satisfactoriamente', 'Sintesis Creditos');
    } else {
        toastr.error(answer.Message, 'Sintesis Creditos');
    }
}

function ResetTituloSol(val) {
    val = (val == "SOLICITANTE") ? "(DEUDOR)" : '(' + val + ')';
    $('#titulosol').text(val);
}

function EndCallbackStateRef(params, answer) {
    if (!answer.Error) {
        data = answer.Row;
        if (data.estado) {
            clas = "fa-eye text-primary";
        } else {
            clas = "fa-eye-slash text-danger"
        }

        var a = $('#tbodyreferen tr[data-id="' + data.id + '"]');
        a.attr('data-estado', data.estado);
        var b = a.find('span.iconreferenc');
        b.removeClass("fa-eye-slash text-danger");
        b.removeClass("fa-eye text-primary");
        b.addClass(clas);

        toastr.success('Cambio de estado exitoso', 'Sintesis Creditos');
    }
    else {
        toastr.error(answer.Message, 'Sintesis Creditos');
    }
}

function EndCallBackGetInsertTemp(params, answer) {
    if (!answer.Error) {
        LoadArticulo();
        TotalizarFactura(answer.Row);
        $('.EditCot').show();
    } else {
        toastr.error(answer.Message, "Sintesis Creditos");
    }
}

function loadpresentation(v_code, formula, id, idbodega) {
    params = {};
    params.filtro = v_code;
    params.op = 'P';
    params.o = 'PR';
    params.formula = formula;
    params.id_prod = id;
    params.id_bodega = idbodega;
    MethodService("Productos", "ArticulosBuscador", JSON.stringify(params), "EndCallbackArticle");
}

function EndCallbackArticle(params, answer) {

    if (!answer.Error) {
        if (answer.data.length > 0) {
            var row = answer.data[0];
            $('#addarticle').attr('data-id', row.id)
            $('#nombreart').val(row.nombre);
            $('#cant').val(0);
            $('#price').val(0);
            window.tblarticle.bootgrid('reload');
        }
    }
    else {
        toastr.warning(answer.Message, 'Sintesis Creditos');
    }
}

function EndCallbackAddArticle(Parameter, Result) {
    if (!Result.Error) {
        $('#codprod').val('');
        $('#nombreart').val('');
        $('#cant').val('1.00');
        $('#price').val('0.00');
        $('#hiddenart').val('');

        if ($('#btnProd').attr('title') != 'Agregar') {
            var btn = $('#btnProd');
            btn.html('');
            var i = '<i class="fa fa-plus"></i>'
            btn.html(i);
            btn.attr('title', 'Agregar');
        }

        Data = Result.Row;
        window.tblarticle.bootgrid('reload');
        TotalizarFactura(Data);
    }
    else {
        toastr.error(Result.Message, 'Sintesis Creditos');
    }
}

function TotalizarFactura(Data) {

    var condes = Data.Ttotal - SetNumber($('#descuento').val()); // Agrega el descuento ingresado por el usuario
    var coninic = condes - SetNumber($('#cuotaini').val()); // Agrega la cuota inicial

    $('#valoriva').text('$ ' + Data.Tiva.Money());
    $('#valoriva').val(Data.Tiva);
    $('#precio').text('$ ' + Data.Tprecio.Money());
    $('#precio').val(Data.Tprecio);
    $('#valfinan').text('$ ' + coninic.Money());
    $('#valfinan').val(coninic);
    $('#hidden_valfinan').val(Data.Ttotal); // Guarda el valor de financiacion sin descuento ni cuota inicial

    
}

function actCuotas() {
    param = {};
    param.cuota = $('#cuotas').val();
    param.valor = SetNumber($('#valfinan').val());
    param.dias = SetDate($('#fecha_venc').val());
    param.lineacredit = $('#lineacredit').val();
    MethodService("Analisis", "CuotaMensual", JSON.stringify(param), "EndCallBackCuotaMensual");
}

function EndCallbackTempFactura(Parameter, Result) {
    if (!Result.Error) {
        Data = Result.Value;
        $('#idToken').val(Data);

        var param = {};
        param.id_cotizacion = $('#cd_cotizacion').val();
        param.id_solicitud = $('#id_solicitud').val();
        param.idToken = $('#idToken').val();
        MethodService("Analisis", "AddArticleFActuraItemTemp", JSON.stringify(param), "EndCallBackGetInsertTemp");
        $('#detalleCot').attr('disabled', 'disabled');
        $('#detalleCot').hide();
    }
    else {
        toastr.error(Result.Message, 'Sintesis ERP');
    }
}