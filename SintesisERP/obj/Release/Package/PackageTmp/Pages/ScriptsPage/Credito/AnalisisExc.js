window.gridusuar = undefined;
window.gridreference;
id_referencia_persona = 0;

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
                    param.op = "EXCEPCI";
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
                BlockForm();
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
            $('.btn').removeAttr('disabled');
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
                        //$('#actCuotas').attr('data-idprod', thi.attr('data-idarticulo'));
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
                        'data-descuento="' + row.descuento + '" data-total="' + row.total + '" data-idart="' + row.id_producto + '" data-bodega="' + row.id_bodega + '" data-codigo="' + row.codigo + '"><span><i class="fa-2x fa fa-eye-slash text-primary"></i></span></a>';

                    $('#idToken').val(row.id_factura);

                    return a;
                },
                "delete": function (column, row) {
                    return '<a class="action command-delete" data-idart="' + row.id_producto + '"><span class="fa-2x fa fa-ban text-danger"></span></a>'
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
                toastr.warning('Usted no puede realizar esta operacion', 'Sintesis Creditos');
            }).end().find(".command-delete").on("click", function () {
                toastr.warning('Usted no puede realizar esta operacion', 'Sintesis Creditos');
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
    datepicker();

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

    $('.x_title').children('.title-master').html('<span class="fa fa-eye fa-fw"></span>Análisis Excepcionados');

    $('select').selectpicker();
    var tdadd = $('<td class="text-center"/>').html('#');
    $('#tblreferen thead tr').append(tdadd);

    $('#btnBack').on('click', function () {
        $('#acordeonSol').hide();
        $('#divagregados').show();
        $('#filesaves').empty();
        $(this).css('display', 'none');
    });

    $('#detalleCot').on('click', function () {
        $('.ob').css('display', 'none');
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
                'data-estado': false
            });

            a = $('<a/>').html('<span class="fa fa-2x fa-trash-o text-danger iconfa"></span>').click(function () {

                alerta = confirm('Esta seguro que desea eliminarlo?');
                if (alert) {

                } else {
                    toastr.warning('No se eliminó', 'Sintesis Creditos');
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

    $('.actionCredi').click(function () {
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
    });

});

$('#btnList').on('click', function () {
    window.gridusuar.bootgrid('reload');
    $('#id_solicitud').val('0');
    $('#divlist, #divfilter').show();
    $('#divinfo').hide();
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
    $('.new').attr('disabled', 'disabled');
});


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
        $('#cuotaini').val('$ ' + data.cuotainicial.Money());
        $('#precio').text('$ ' + data.precio.Money());
        $('#descuento').val('$ ' + data.descuentos.Money());
        $('#valfinan').val(data.valorfinanciar.Money());
        $('#valfinan').text('$ ' + data.valorfinanciar.Money());
        $('#hidden_valfinan').val(data.valorfinanciar);
        $('#valoriva').val((data.iva == 0 | "" | undefined ? 0 : data.iva.Money()));
        $('#valoriva').text('$ ' + (data.iva == 0 | "" | undefined ? 0 : data.iva.Money()));
        $('#cuotas').val(data.numcuotas);
        $('#valcuotamen').val('$ ' + (data.valorcuotadia == 0 | undefined | "" ? 0 : data.valorcuotadia.Money()));
        $('#observaciones').val(data.observaciones);
        $('#fecha_venc').val(data.fechaini);
        $('#lineacredit').val(data.lineacredit);
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

        var thi = $('#detalleCot');
        thi.html('');
        var i = '<i class="fa fa-calendar"></i>'
        thi.append(i);
        $('.bloque').attr('disabled', 'disabled');
    }
    else {
        toastr.error(answer.Message, 'Sintesis Creditos');
    }
}

function CrearAgregado(Json) {
    var content = $('#divagregados');
    var div = $('<div id="newdivagg" class="col-lg-6 col-md-6 col-sm-10 col-xs-12 contactTop ' + Json.class + '" style="margin-top:10px;" />').attr('data-tipoper', ((Json.tipo == 'CL') ? "SOLICITANTE" : "CODEUDOR"));
    var divinf = $('<div class="contact bg-info" style="max-height: 120px;"/>');
    var a = $('<a id="image_icon" data-icon="' + Json.id_persona + '" class="clearfix" title="Detalle del ' + ((Json.tipo == 'CL') ? "SOLICITANTE" : "CODEUDOR") + '" href="#"/>').attr('data-id', Json.id);
    var html = '<div class="col-lg-6 col-md-6 col-sm-4 roundImgParent ' + Json.id_persona + '"><img class="roundImg" src="' + ((Json.urlimg == null) ? foto : window.appPath + '/Pages/Connectors/ConnectorGetFile.ashx?token=' + Json.urlimg) + '"></div>' +
        '<div class="col-lg-6 col-md-6 col-sm-8"><p><b>' + ((Json.tipo == 'CL') ? "SOLICITANTE" : "CODEUDOR") + '</b><br>' + Json.pnombre + ' ' + Json.snombre + '</br> ' + Json.papellido + ' ' + Json.sapellido + '<br>' + Json.iden + '</p></div>';

    $('#tipoter').val(Json.tipo);
    a.on('click', function () {
        $('#loadingDiv').show();
        $("#loadingDiv").fadeOut(3000);
        $('#divagregados').hide();
        $('#acordeonSol').show();
        $('#btnBack').css('display', 'block');
        $('.accordion').addClass('acordion');
        $('#btnBack').css('display', 'block');
        var params = {};
        var titlesol = $(this).closest('div.contactTop').attr('data-tipoper');
        params.id = $(this).attr('data-id');
        params.tipoper = titlesol;
        params.id_persona = a.attr('data-icon');
        $('#id_solper').val(Json.id_solper);
        console.log(params);
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
                toastr.warning('Usted no puede realizar esta acción', 'Sintesis Creditos');
            });
            clas = "fa-eye-slash text-danger"
            if (e.estado)
                clas = "fa-eye text-primary";
            view = $('<a/>').html('<span class="fa fa-2x ' + clas + ' iconfa iconreferenc"></span>').click(function () {
                toastr.warning('Usted no puede realizar esta acción', 'Sintesis Creditos');
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
            var li = $('<li class="fist-item"/>').attr({ 'data-token': e.token, 'data-id_persol': e.id_persol, 'data-id': e.id, 'title': 'Ver archivo', 'data-op': e.op }).html('<span class="label label-info second-item" style="margin-right: 5px;"><i class="fa fa fa-file-o fa-fw"></i></span>' + e.name);

            li.click(function () {
                var token = $(this).attr('data-token');
                var file = window.appPath + "/Pages/Connectors/ConnectorGetFile.ashx?&token=" + token;
                $("#iframeprint").attr('data', file);
                $('#reportviewer').modal({ backdrop: 'static', keyboard: false }, 'show');
                $('#iframeprint').attr('src', window.location.origin + '/' + file);
            });
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


function BlockForm() {

    $('.form-control').attr('disabled', 'disabled');
    $('.search-field').removeAttr('disabled');
    $('.selectpicker').attr('disabled', 'disabled');
    $('.select').removeAttr('disabled');
    $('.text').removeAttr('disabled');
    $('.select').selectpicker('refresh');
    $('.btn-add').remove();
    $('.add').remove();

    var conc = '<button title="Concluir" style="border-radius: 6px; height: 35px; width: 35px; color: #4389b5; font-size: 20px; text-align: center" id="btnConc" data-option="UC" class="btn btn-outline btn-success dim  pull-right btn-add dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" type="button" disabled="disabled"><i class="fa fa-sort-down" style="position: relative; bottom: 5px;"></i></button>';
    var item = '<a class="dropdown-item pull-right" href="#">' +
        '<button title="Aprobar" id="btnSave" style="background-color:white; border-radius:6px;" data-option="I" class="group2 add new btn btn-outline btn-primary dim  pull-right actionCredi" type="button" data-estado="APROVED"><i class="fa fa-paste"></i></button> </a>' +
        '<a class="dropdown-item" href="#">' +
        '<button title="Rechazar" id="btnRev" style="background-color:white; border-radius:6px;" class="group2 add new btn btn-outline btn-danger dim pull-right actionCredi" type="button"  data-estado="RECHA"><i class="fa-file-o fa"></i></button></a>' +
        '<a class="dropdown-item" href="#">' +
        '<button title="Reprocesar" id="btnRep" style="background-color:white; border-radius:6px;" data-option="I" class="group2 add new btn btn-outline btn-success dim  pull-right actionCredi" type="button" disabled="disabled" data-estado="REPROCES"><i class="fa fa-rotate-left"></i></button>' +
        '</a>';

    $('.group1').append(conc);
    $('#dropdown-menu').css('right', '0px');
    $('#dropdown-menu').append(item);

    $('.new').click(function () {
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

        $('.notbloque').attr('disabled', 'disabled');
    });

}

function EnabledFinish(enabled) {
    if (enabled) {
        var button = $("#form").find('a[href="#' + "finish" + '"]');
        button.attr("href", '#' + "finish" + '-disabled');
    }
    else {
        var button = $("#form").find('a[href="#' + "finish-disabled" + '"]');
        button.attr("href", '#' + "finish");
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
        $('.EditCot').show();
    } else {
        toastr.error(answer.Message, "Sintesis Creditos");
    }
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