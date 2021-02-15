/*json que se usa para verificar que los campos no esten vacios*/
var JsonValidate = [
    { id: 'Selectipoper', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
    { id: 'id_tipoiden', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
    { id: 'iden', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'pnombre', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'papellido', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'ecivil', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
    { id: 'pcargo', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'escolaridad', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
    { id: 'scorreo', type: 'EMAIL', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
    { id: 'genero', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
    { id: 'estrato', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
    { id: 'scelular', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'direccion', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'Text_city', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
    { id: 'vinmueble', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
    { id: 'TipEmpleo', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, traiddepends: '' },
    { id: 'sempresa', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'sedireccion', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
    { id: 'setelefono', type: 'TEXT', htmltype: 'INPUT', required: false, depends: false, iddepends: '' },
    { id: 'secargoactual', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'setiemposer', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
    { id: 'sesalario', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'foto', type: 'DROPIFY', htmltype: 'DROPIFY', required: true, depends: false, iddepends: '' }
    //,{ id: 'seconceptooi', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }

];

let validateConcepto = [{ id: 'seconceptooi', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }]

/*json que se usa para verificar que los campos no esten vacios*/
var JsonValidateCon = [
    { id: 'nconyuge', type: 'TEXT', htmltype: 'INPUT', required: true, depends: true, iddepends: '' },
    { id: 'ctelefono', type: 'TEXT', htmltype: 'INPUT', required: true, depends: true, iddepends: '' },
    { id: 'elaboraconyuge', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
    { id: 'esalario', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' }
];

/*json que se usa para verificar que los campos no esten vacios*/
var JsonValidateDir = [{ id: 'tmpdireccion', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];

/*json que se usa para verificar que los campos no esten vacios*/
var JsonValidateSave = [{ id: 'ds_cliente', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' }];

/*json que se usa para verificar que los campos no esten vacios*/
var JsonValidateRef = [
    { id: 'refnobre', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'refdireccion', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'reftelefono', type: 'TEXT', htmltype: 'INPUT', required: true, depends: false, iddepends: '' },
    { id: 'tiporef', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' },
    { id: 'id_parentez', type: 'TEXT', htmltype: 'SELECT', required: true, depends: false, iddepends: '' }];

window.gridcotizaciones;
window.iubi;


$(document).ready(function () {

    /*carga la parte visual de los botones de la foto*/
    window.img = $('.dropify').dropify({
        messages: {
            default: '',
            replace: '',
            remove: 'Quitar',
            error: 'Lo sentimos, el archivo es demasiado grande'
        },
        error: {
            fileSize: 'El tamaño del archivo es muy grande ({{ value }} max).',
            minWidth: 'El ancho de la imagen es muy pequeño ({{ value }}}px min).',
            maxWidth: 'El ancho de la imagen es muy grande ({{ value }}}px max).',
            minHeight: 'La altura de la imagen es muy pequeña ({{ value }}}px min).',
            maxHeight: 'La altura de la imagen es muy grande ({{ value }}px max).',
            imageFormat: 'El formato de la imagen no esta permitido ({{ value }} solamente).',
            fileExtension: 'El archivo no es permitido ({{ value }} solamente).'
        }
    });

    $('select').selectpicker();

    newCotizacion();

    /*envia la solicitud seleccionada a el metodo "SolicitudesState"*/
    $('#btnNext').click(function () {
        var id = $('#id_solicitud').val();
        var params = {};
        var mensaje = $(this).attr('title');
        $('#atras').hide();
        if (params.valor != '0') {
            if (confirm('Desea mandar a ' + mensaje + ' esta solicitud?')) {
                params.id = id;
                params.estado = $(this).attr('data-estado');
                var btn = $(this);
                //btn.button('loading');
                MethodService("Solicitudes", "SolicitudesState", JSON.stringify(params), 'EndCallbackEstado');
            }
        } else {
            toastr.warning('No ha Seleccionado ninguna solicitud.', 'Sintesis Creditos');
        }
    });


    $('#atras').click(function () {
        $('#atras').hide();
        var Json = GetDatosForm();
        Json.urlimg = null;

        CrearAgregado(Json)
        $('#divregistro').hide();
        $('#divagregados').show();
        $('#btnguardar').attr('disabled', 'disabled');
    });

    $('#cd_cotizacion').change(function () {
        var idsol = $('#id_solicitud').val();
        if (idsol == "" || idsol == "0") {
            params = {};
            params.iden = $(this).val();
            if (params.iden != "") {
                MethodService("Solicitudes", "CotizacionesGet", JSON.stringify(params), "EndCallbackGetCliente");
            }
        }
        else {
            if (confirm('Desea cambiar la cotización?')) {
                var params = {};
                params.id = idsol;
                params.id_cotizacion = $(this).val();
                //params.id_cotizacion = ((params.id_cotizacion == "") ? "0" : params.id_cotizacion);
                MethodService("Solicitudes", "SolicitudesUpdateCotizacion", JSON.stringify(params), 'EndCallbackupdateCotzacion');
            }
        }

    });

    $('#iden').change(function () {
        params = {};
        params.iden = $(this).val();
        if (params.iden != "") {
            MethodService("Solicitudes", "PersonaGet", JSON.stringify(params), "EndCallbackGetCliente");
        }
    });

    /*valida que cuando el select de tipo de vivienda valga arriendo 
     el campo de valor de arriendo se active*/
    $('#vinmueble').change(function () {

        val = $(this).val();
        atr = $(this).find('option:selected').attr('param');
        if (val != "" && atr == 'ARRD')
            $('#varriendo').removeAttr('disabled');
        else {
            $('#varriendo').val('').attr('disabled', 'disbled');
        }


    });

    /*valida que cuando el select de estado civil sea soltero se bloqueen 
     todos los campos que tengan que ver con conyugue*/
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


    $('.inputaddress').click(function () {
        $('.inputaddress').removeClass('active');
        $(this).addClass('active');
        $('#comboaddress').val('').selectpicker('refresh');
        $('#tmpdireccion').focus();
    });

    $('#comboaddress').change(function () {
        $('.inputaddress').removeClass('active');
        $('#tmpdireccion').focus();

    });


    $('#btnSaveAdd').click(function () {
        var dir = $('#tempdir').val();
        $('#direccion').val(dir);
        $('#tmpdireccion, #tempdir').val('');
        $('#ModalDireccion').modal('hide');
    });

    /*agrega (concatena) la dirección escrita en el imput tmpdireccion y
     lo carga en el imput tempdir*/
    $('#adddirec').click(function () {
        if (validate(JsonValidateDir)) {
            var val = $('#comboaddress option:selected').attr('data-dian');
            val = (val == undefined || val == '') ? $('.inputaddress.active').attr('data-dian') : val;
            val = val = (val == undefined) ? '' : val;
            if (val != '') {
                vald = $('#tmpdireccion').val();
                dir = $('#tempdir').val();
                $('#tempdir').val(dir + ((dir == "") ? val + '' + vald : ' ' + val + ' ' + vald));
                $('.inputaddress').removeClass('active');
                $('#tmpdireccion').val('');
                $('#comboaddress').val('').selectpicker('refresh');
            }
            else {
                toastr.warning("Seleccione Nomenclatura.", 'Sintesis Creditos');
            }
        }
    });

    /*agrega la referencia creada a la tabla de referencias (XML)*/
    $('#addref').click(function () {
        if (validate(JsonValidateRef)) {
            tipo = $('#tiporef').val();
            texttipo = $('#tiporef option:selected').text();
            nom = $('#refnobre').val();
            dir = $('#refdireccion').val();
            tel = $('#reftelefono').val();
            parente = $('#id_parentez').val();
            textparente = $('#id_parentez option:selected').text();
            var body = $('#tbodyreferen');
            tr = $('<tr/>').attr({ 'data-id': '0', 'data-nombre': nom, 'data-direccion': dir, 'data-telefono': tel, 'data-tipo': tipo, 'data-ref': texttipo, 'data-par': parente });
            a = $('<a/>').html('<span class="fa fa-2x fa-trash-o text-danger iconfa"></span>').click(function () {
                $(this).closest('tr').remove();
            })
            td = $('<td class="text-center"/>').append(a);
            td1 = $('<td class="text-center"/>').html(nom);
            td2 = $('<td class="text-center"/>').html(dir);
            td3 = $('<td class="text-center"/>').html(tel);
            td4 = $('<td class="text-center"/>').html(texttipo);
            td5 = $('<td class="text-center"/>').html(textparente);
            td6 = $('<td class="text-center"/>').html();
            tr.append(td, td1, td2, td3, td4, td5, td6);
            body.append(tr);
            $('#refnobre, #refdireccion, #reftelefono, #tiporef, #id_parentez').val('');
            $('#tiporef, #id_parentez').selectpicker('refresh');
        }
    });

    /*elimina la dirección escrita en el imput tmpdireccion*/
    $('#remdirec').click(function () {
        if (confirm('Desea eliminar la Dirección?'))
            $('#tempdir').val('');
    });

    /*muestra el modal de dirección*/
    $('#direccion').click(function () {
        $('#ModalDireccion').modal({ backdrop: 'static', keyboard: false }, "show");
    });
});

/*abre un nuevo formulario ya sea para el cliente o para el codeudor*/
$('#btnSol, #btnCod').click(function (e) {
    $('.in').attr('aria-expanded', 'false');
    $('.in').attr('class', 'collapse');
    $('.in').attr('style', 'height: 0px;');
    $('#btnguardar').removeAttr('disabled');
    $('#id_persona').val(0);

    val = $(this).attr('data-tipo');
    $('#tipoper').val(val);
    var returns = false;
    var sol = $('div[data-tipoper="SOLICITANTE"]');

    var titlesol = "";

    if (val == 'CL') {
        if (sol == undefined || sol.length == 0) {

            returns = true;
            titlesol = "DEUDOR";
            $('#iden').val($('#identi_per').val());
        }
        else {
            toastr.warning("Ya existe un solicitante.", 'Sintesis Creditos');
        }
    }
    else if (val == 'CO') {
        cantcod();


    }
    if (returns) {
        cleanForm();
        ResetTituloSol(titlesol);
        $('#divregistro').show();
        $('#divagregados').hide();
        $("#btnCan").removeAttr('disabled');
    }
});

/*muestra un mensaje afirmando que el estado se cambió*/
function EndCallbackEstado(params, answer) {
    if (!answer.Error) {
        toastr.success('Solicitud a pasado a analisis exitosamente.', 'Sintesis Creditos');
        setTimeout(function () { $('#btnnew').trigger('click'); }, 300);
    }
    else {
        toastr.error(answer.Message, 'Sintesis Creditos');
    }
}

/*envia toda la información recogida a el metodo SolicitudesSave y el 
 base64 de la imagen con la ruta a Verificarcarpeta*/
function GuardarSolicitud() {
    if (validate(JsonValidateSave)) {
        var params = GetDatosForm();
        MethodService("Solicitudes", "SolicitudesSave", JSON.stringify(params), "EndCallbackSave");
    }
}

/* despues de convertir la imagen, guarda la ruta de la foto en 
 params.urlimg para guardarlo en la solicitud */
function EndCallbackRuta(param, answer) {
    if (!answer.Error) {
        var data = new FormData();
        var params = JSON.parse(param);
        params.urlimg = answer;

    }
    else {
        toastr.error('la imagen no se puede guardar', 'Sintesis Creditos');
    }

}

/*captura todos los datos de la solicitud*/
function GetDatosForm() {
    var params = {};
    var temp = foto.split("token=");
    var temp2 = temp[0].split("Pages");

    if ((foto == null || foto == "") || temp2[1] == '/Connectors/ConnectorGetFile.ashx?') {

        params.urlimg = temp[1];
    } else {
        params.urlimg = foto;
    }
    params.tipoper = $("#Selectipoper").val();
    params.tipo = $("#tipoper").val();
    if (params.tipo == 'CL') {
        params.class = "solicitante";
    } else if (
        params.tipo == 'CO') {
        params.class = "codeudor";
    }
    params.id_solicitud = $('#id_solicitud').val();
    params.id_solicitud = (params.id_solicitud == "" ? "0" : params.id_solicitud);
    params.id_cotizacion = $('#cd_cotizacion').val();
    params.iden = $('#iden').val();
    params.verificacion = $('#identificacion').text();
    params.nameFile = "PF" + $('#iden').val();
    params.id_tipoiden = $('#id_tipoiden').val();
    params.pnombre = $('#pnombre').val();
    params.snombre = $('#snombre').val();
    params.papellido = $('#papellido').val();
    params.sapellido = $('#sapellido').val();
    params.estadocivil = $('#ecivil').val();
    params.id_escola = $('#escolaridad').val();
    params.percargo = $('#pcargo').val();
    params.celular = $('#scelular').val();
    params.otro = $('#sotrotel').val();
    params.id_ciudad = $("#Text_city").val();
    params.direccion = $('#direccion').val();
    params.correo = $('#scorreo').val();
    params.genero = $('#genero').val();
    params.estrato = $('#estrato').val();
    params.viveinmu = $('#vinmueble').val();
    params.valorinm = SetNumber(($('#varriendo').val() == "") ? "0" : $('#varriendo').val());
    params.connombre = $('#nconyuge').val();
    params.contelefono = $('#ctelefono').val();
    params.conempresa = $('#elaboraconyuge').val();
    params.consalario = SetNumber(($('#esalario').val() == "") ? "0" : $('#esalario').val());
    params.tipoempleo = ($('#TipEmpleo').val() == "") ? "0" : $('#TipEmpleo').val();
    params.empresalab = $('#sempresa').val();
    params.direccionem = $('#sedireccion').val();
    params.telefonoemp = $('#setelefono').val();
    params.cargoempr = $('#secargoactual').val();
    params.tiempoemp = ($('#setiemposer').val() == "") ? "0" : $('#setiemposer').val();
    params.salarioemp = SetNumber(($('#sesalario').val() == "") ? "0" : $('#sesalario').val());
    params.otrosing = SetNumber(($('#seotroing').val() == "") ? "0" : $('#seotroing').val());
    params.concepto = $('#seconceptooi').val();
    params.referencias = GenerarXMLReferencias();
    params.observaciones = ($.trim($('#observaciones').val()) != '') ? '<b>Observación General</b></br>' + $('#observaciones').val() : '';
    params.fecha = $('#Text_Fecha').val();
    params.id_persona = $('#id_persona').val();
    params.detalleobser = $('#observaciones').val();
    //params.id_persona = (params.id_persona == "" ? "0" : params.id_persona);

    return params;
}


function updatePerson(id, par, datos) {
    if (validate(JsonValidateSave)) {
        var params = GetDatosForm();
        params.id_solicitud = $('#id_solicitud').val();;
        params.id_solicitudper = id;
        params.par = par;
        params.datos = datos;
        EnabledFinish(true);
        MethodService("Solicitudes", "SolicitudesUpdate", JSON.stringify(params), "EndCallbackUpdate");
    }
}

/*carga la tabla con la información que trae de la base de datos*/
function GenerarXMLReferencias() {
    trs = $('#tbodyreferen').find('tr');
    xml = "";
    if (trs.length > 0) {
        $.each(trs, function (i, e) {
            data = $(e).data();
            xml += '<item id="' + data.id + '" nombre="' + data.nombre + '" telefono="' + data.telefono + '" direccion="' + data.direccion + '" tipo="' + data.tipo + '" parentezco="' + ((data.par == undefined) ? '0' : data.par) + '" />'
        });
        xml = "<items>" + xml + "</items>"
    }
    return xml;
}

/*carga la lista de las solicitudes creadas, en reproceso y solicitadas*/
$('#btnList').click(function () {
    if (window.gridcotizaciones === undefined) {
        window.gridcotizaciones = $("#tblsolicitudes").bootgrid({
            ajax: true,
            post: function () {
                return {
                    'params': "{estado:'CREATED|REPROCES'}",
                    'class': 'Solicitudes',
                    'method': 'SolicitudesList'
                };
            },
            url: window.appPath + "/Pages/Connectors/ConnectorList.ashx",
            formatters: {
                "edit": function (column, row) {
                    return "<a class=\"action command-edit\" data-row-id=\"" + row.id + "\"><span class=\"fa-2x fa fa-eye iconfa\"></span></a>";
                }
            }
        }).on("loaded.rs.jquery.bootgrid", function () {
            // Executes after data is loaded and rendered 
            window.gridcotizaciones.find(".command-edit").on("click", function (e) {
                removeerror();
                $('#btnguardar').attr('disabled', 'disabled');
                id = $(this).data("row-id")
                params = {};
                params.id = id;
                newCotizacion();
                $('#ModalCotizaciones').modal('hide');
                $('#atras').hide();
                $('#divloading').show();
                setTimeout(function () { MethodService("Solicitudes", "SolicitudesGet", JSON.stringify(params), 'EndCallbackGet'); }, 1000);
            });
        });
    }
    else
        window.gridcotizaciones.bootgrid('reload');

    $('#ModalCotizaciones').modal({ backdrop: 'static', keyboard: false }, "show");

});

/*limpia todos los campos de la parte "nueva Solicitud" y oculta el formulario
 (limpia la cotización y los campos de #solicitud, Estado y fecha)*/
$('#btnnew').click(function () {
    newCotizacion();
    $('#cd_cotizacion, #ds_cliente').val('');
    $('#id_solicitud').val('0');
    $('#observaciones').val('');
    $('#btnNext').attr('disabled', 'disabled');
    $("#btnCan").attr('disabled', 'disabled');
    $('#btnguardar').attr('disabled', 'disabled');
    $('#atras').hide();
});

/*envia el id de la solicitud para generar el reporte*/
$('#btnPrint').click(function () {
    var idfactura = $('#id_solicitud').val();
    param = 'id|' + idfactura;
    PrintDocument(param, 'SOLICITCREDITO', 'CODE');
});

/*limpia la informacion del formulario de solicitud*/
$('#btnCan').click(function () {
    if (confirm("Al cancelar se eliminara el formulario, desea realmente cancelar?")) {
        $('#divregistro').hide();
        $('#divagregados').show();
        $("#btnCan").attr('disabled', 'disabled');
        $('#btnguardar').attr('disabled', 'disabled');
    }
});

/*muestra los datos que se listan cuando presionas btnlist*/
function EndCallbackGet(params, answer) {
    if (!answer.Error) {
        $("#btnCan").attr('disabled', 'disabled');
        data = answer.Row;
        $('#id_solicitud').val(data.id);
        $('#numsolic').val(data.consecutivo);
        $('#estado').val(data.estado);
        $('#observaciones').val(data.observaciones);
        $('#Text_Fecha').val(data.fecha);
        var id_cod = data.cotizacion.split(" ");

        $('#cd_cotizacion').val(id_cod[0]);
        $('#ds_cliente').val(data.cotizacion).removeClass('inputsearch');

        $.each(answer.Table, function (i, e) {
            CrearAgregado(e);
        });

        $('#divloading').hide();
        $('#btnNext').removeAttr('disabled');
    }
    else {
        toastr.error(answer.Message, 'Sintesis Creditos');
    }
}

function EndCallbackGetCliente(params, answer) {
    if (!answer.Error) {
        data = answer.Row;
        if (data.opcion == 1) {
            SetDataPerson(data, false);
        } else {
            $('#Selectipoper').val(data.tipo_persona == "" ? "0" : $('#Selectipoper').val());
            $('#id_tipoiden').val(data.id_tipoiden == "" ? "0" : $('#id_tipoiden').val());
            $('#pnombre').val(data.primernombre);
            $('#snombre').val(data.segundonombre);
            $('#papellido').val(data.primerapellido);
            $('#sapellido').val(data.segundoapellido);
            $('#Text_city').val(data.id_ciudad);
            $('#scelular').val(data.celular);
            $('#sotrotel').val(data.otrotel);
            $('#scorreo').val(data.correo);
            $('#vinmueble').val(data.id_viveinmueble);
            var div = $('#form');
            div.find('select').selectpicker('refresh');
        }
    }
}


/*identifica si es un formulario nuevo y si lo es muestra el mensaje 
 de guardado y lo envia a divagregados y si existe muestra el mensaje 
 de actualizado*/
function EndCallbackSave(params, answer) {
    if (!answer.Error) {
        if ($('#id_persona').val() != 0) {
            toastr.success("Actualización Exitosa.", 'Sintesis Creditos');
            var parametros = JSON.parse(params);
            parametros.id_persona = answer.Row.id_persona;
            parametros.id_solicitud = answer.Row.id;
            parametros.urlimg = null;
            CrearAgregado(parametros);
            $('#divregistro').hide();
            $('#divagregados').show();
        } else if ($('#id_persona').val() == 0) {
            $('#numsolic').val(answer.Row.consecutivo);
            $('#id_solicitud').val(answer.Row.id);
            $('#id_solper').val(answer.Row.clavesolicitud);
            $('#estado').val(answer.Row.estado);
            $('#Text_Fecha').val(answer.Row.fecha);
            var id_cod = answer.Row.cotizacion.split(" ");

            $('#cd_cotizacion').val(id_cod[0]);
            $('#ds_cliente').val(answer.Row.cotizacion);
            jsonp = JSON.parse(params);
            jsonp.id_persona = answer.Row.id_persona;
            jsonp.id_solicitud = answer.Row.id;

            CrearAgregado(jsonp);
            toastr.success("Formulario Guardado.", 'Sintesis Creditos');
            $('#divregistro').hide();
            $('#divagregados').show();
        }
        $('#btnguardar').attr('disabled', 'disabled');
        $('#atras').hide();
        UploadFiles(params, answer);
    }
    else {
        toastr.error(answer.Message, 'Sintesis Creditos');
        EnabledFinish(false);
    }


}

/* guarda los archivos que se suben en la parte inferior del formulario */
function UploadFiles(Params, datos) {
    EnabledFinish(true);
    var data = new FormData();
    var ds_fileUpload = $('#archivos').get(0);
    var ds_files = ds_fileUpload.files;
    var archivos = false;
    for (var i = 0; i < ds_files.length; i++) {
        filename = ds_files[i].name;
        data.append(ds_files[i].name, ds_files[i]);
    }

    var temp = foto.split("token=");
    var temp2 = temp[0].split("Pages")

    if (temp2[1] != '/Connectors/ConnectorGetFile.ashx?') {

        var file = dataURLtoFile($canvas.toDataURL(), 'FotoPerfil_Sintesis.png');
        data.append(file.name, file);
    }
    if (data != undefined)
        archivos = true;
    if (archivos) {
        toastr.info("Subiendo Archivos.", 'Sintesis Creditos');
        var par = JSON.parse(Params);
        params = {};
        params.iden = par.iden;
        params.numcredito = datos.Row.consecutivo;
        params.id_solicitud = datos.Row.clavesolicitud;
        params.tipoper = par.tipo;
        params.fileDate = "S";
        MethodUploadsFiles("Solicitudes", "SolicitudesSaveFiles", data, JSON.stringify(params), "EndCallbackSaveFile");
    }
    else {
        toastr.warning("No hay archivos para subir", 'Sintesis Creditos');
        EnabledFinish(false);
    }
}

/* si la respuesta al guardar la solicitud es incorrecta envia un mensaje 
 con el error de lo contrario envia "Archivos subidos exitosamente." */
function EndCallbackSaveFile(params, answer) {
    if (!answer.Error) {
        toastr.success("Archivos subidos exitosamente.", 'Sintesis Creditos');
    }
    else {
        toastr.error(answer.Message, 'Sintesis Creditos');
    }
    EnabledFinish(false);
}

/* si la respuesta al eliminar un archivo es incorrecta envia un mensaje
 con el error de lo contrario elimina el div de dicho archivo y envia 
 "Archivos eliminado exitosamente." */
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


function EndCallbackupdateCotzacion(params, answer) {
    if (!answer.Error) {
        toastr.success("Cotización actualizada exitosamente.", 'Sintesis Creditos');
    }
    else {
        toastr.error(answer.Message, 'Sintesis Creditos');
    }
}


function newCotizacion() {
    $('#divregistro').hide();
    $('#divagregados').show();
    $('input.form-control, select').not('#cd_cotizacion, #ds_cliente').val('');
    cleanForm();
    $('#form-t-0').click();
    $('div[data-tipoper="SOLICITANTE"], div[data-tipoper="CODEUDOR"]').remove();

    var file = $('#filesaves');
    $('#btnNext').attr('disabled', 'disabled');
    file.empty();
}

/*crea un recuadro con la informacion basica tanto de el deudor
 como de el/los codeudor/es de una solicitud*/
function CrearAgregado(Json) {
    var imgperfil = (Json.urlimg == null ? ['data'] : Json.urlimg.split(":"));
    var content = $('#divagregados');
    var div = $('<div id="' + Json.id_persona + '" class="col-lg-4 col-md-4 col-sm-12 col-xs-12 contactTop ' + Json.class + '"/>').attr('data-tipoper', ((Json.tipo == 'CL') ? "SOLICITANTE" : "CODEUDOR"));
    var divinf = $('<div class="contact bg-info"/>');
    var trash = $('<span class="trash"><i class="fa fa-trash text-danger"></i></span>').attr('data-id', Json.id_persona);
    var a = $('<a class="clearfix" title="Detalle del ' + ((Json.tipo == 'CL') ? "SOLICITANTE" : "CODEUDOR") + '" href="#"/>').attr('data-id_sol', Json.id_solicitud);
    var html = '<div class=" visible-lg col-lg-4 roundImgParent ' + Json.id_persona + '"><img class="roundImg" src="' + ((imgperfil[0] == 'data') ? ((foto == null) ? fotoget : foto) : window.appPath + '/Pages/Connectors/ConnectorGetFile.ashx?token=' + Json.urlimg) + '' + '"></div>' +
        '<div class="col-lg-8"><p><strong>' + ((Json.tipo == 'CL') ? "SOLICITANTE" : "CODEUDOR") + '</strong><br>' + Json.pnombre + ' ' + Json.snombre + ' ' + Json.papellido + ' ' + Json.sapellido + '<br>' + Json.correo + '<br>' + ((Json.telefono == null) ? "0" : Json.telefono) + ' - ' + Json.celular + '</p></div>';
    fotoget = ((imgperfil[0] == 'data') ? ((foto == null) ? fotoget : foto) : window.appPath + '/Pages/Connectors/ConnectorGetFile.ashx?token=' + Json.urlimg);
    /*elimina al codeudor*/
    trash.click(function (e) {
        e.stopPropagation();
        if (confirm('Desea eliminar el codeudor?')) {
            var params = {};
            params.id = $(this).attr('data-id');
            MethodService("Solicitudes", "SolicitudesDeleteCodeudor", JSON.stringify(params), 'EndCallbackDeleteCodeudor');
            $('#' + Json.id_persona).remove();
        }
    });

    /*al precionar en el cuadro, abre el formulario con la información 
     del la persona seleccionada*/
    a.click(function () {
        $('.collapse').attr('aria-expanded', 'true');
        $('.collapse').attr('class', 'collapse in');
        $('.collapse').attr('style', '');
        $('#btnguardar').removeAttr('disabled');
        cleanForm();
        $("#btnCan").removeAttr('disabled');
        var titlesol = $(this).closest('div.contactTop').attr('data-tipoper');
        var id_personas = Json.id_persona;
        var params = {};
        params.id = $(this).attr('data-id_sol');
        params.id_persona = id_personas;
        params.tipoper = titlesol;
        //$('#id_solper').val(params.id);
        MethodService("Solicitudes", "SolicitudesGetPersona", JSON.stringify(params), 'EndCallbackGetPersona');
        $('#' + Json.id_persona).remove();

    });
    a.html(html);
    if (Json.tipo != 'CL')
        divinf.append(trash);
    divinf.append(a);
    div.append(divinf);
    content.append(div);
}


/*muestra todos los datos guardados de la persona (Deudor o 
 codeudor), en la solicitud respectiva*/
function EndCallbackGetPersona(params, answer) {
    if (!answer.Error) {
        $('#atras').show();
        var dara = answer.Row;
        SetDataPerson(dara, true);
        $('#form-t-0').click();
        var body = $('#tbodyreferen');
        body.empty();
        $.each(answer.Table, function (i, e) {
            tr = $('<tr/>').attr({ 'data-id': e.id, 'data-nombre': e.nombre, 'data-direccion': e.direccion, 'data-telefono': e.telefono, 'data-tipo': e.id_tipo, 'data-ref': e.tipo, 'data-par': e.id_paren });
            a = $('<a/>').html('<span class="fa fa-2x fa-trash-o text-danger iconfa"></span>').click(function () {
                $(this).closest('tr').remove();
            })
            td = $('<td class="text-center"/>').append(a);
            td1 = $('<td class="text-center"/>').html(e.nombre);
            td2 = $('<td class="text-center"/>').html(e.direccion);
            td3 = $('<td class="text-center"/>').html(e.telefono);
            td4 = $('<td class="text-center"/>').html(e.tipo);
            td5 = $('<td class="text-center"/>').html(e.parentezco);
            td6 = $('<td class="text-center"/>').html();
            tr.append(td, td1, td2, td3, td4, td5);
            body.append(tr);
        })
        var file = $('#filesaves');
        file.empty();
        $.each(answer.Files, function (i, e) {
            var li = $('<li class="list-group-item fist-item"/>').attr({ 'data-token': e.token, 'data-id_persol': e.id_persol, 'data-id': e.id, 'title': 'Ver archivo', 'data-op': e.op }).html('<span class="label label-info" style="margin-right: 5px;"><i class="fa fa fa-file-o fa-fw"></i></span>' + e.name);
            var span = $('<span class="pull-right text-danger" style="margin-right: 30px;font-size: 20px;margin-top: -10px; position: sticky"><i class="fa fa-trash fa-fw"></i></span>');
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
                token = token + '&op=' + $(this).attr('data-op');
                var file = window.appPath + "/Pages/Connectors/ConnectorGetFile.ashx?token=" + token;
                PrintDocumentos(file);
            });
            li.append(span);
            file.append(li);
        })
        //BlockForm();
        var dataparam = JSON.parse(params);
        var titlesol = dataparam.tipoper;
        ResetTituloSol(titlesol)
        $('#divregistro').show();
        $('#divagregados').hide();
    }
    else {
        toastr.error(answer.Message, 'Sintesis Creditos');
    }
}

/*carga todos los imputs y los select del formulario*/
function SetDataPerson(dara, TP) {



    if ($("#titulosol").text() == '(CODEUDOR)')
        $("#tipoper").val('CO');
    else
        $("#tipoper").val('CL');

    if (TP)
        $("#tipoper").val(dara.tipoper);

    $('#iden').val(dara.identificacion);
    $('#Selectipoper').val(dara.tipo_persona);
    $('#id_tipoiden').val(dara.id_tipoiden);
    $('#identificacion').text(dara.verificacion)
    $('#pnombre').val(dara.primernombre);
    $('#snombre').val(dara.segundonombre);
    $('#papellido').val(dara.primerapellido);
    $('#sapellido').val(dara.segundoapellido);
    $('#Text_city').val(dara.id_ciudad);
    $('#ecivil').val(dara.id_estadocivil);
    $('#pcargo').val(dara.percargo);
    $('#escolaridad').val(dara.id_escolaridad);
    $('#genero').val(dara.id_genero);
    $('#estrato').val(dara.id_estrato);
    $('#id_persona').val(dara.id_persona == null ? "0" : dara.id_persona);
    $('#scelular').val(dara.celular);
    $('#sotrotel').val(dara.otrotel);
    $('#direccion').val(dara.direccion);
    $('#scorreo').val(dara.correo);
    $('#vinmueble').val(dara.id_viveinmueble);
    $('#varriendo').val(dara.valorarriendo == null ? "0" : dara.valorarriendo.Money());

    $('#nconyuge').val(dara.connombre);

    $('#ctelefono').val(dara.contelefono);

    $('#elaboraconyuge').val(dara.conempresa);
    $('#esalario').val(dara.consalario == null ? "0" : dara.consalario.Money());
    $('#TipEmpleo').val(dara.id_tipoemp);
    $('#sempresa').val(dara.empresalab);
    $('#sedireccion').val(dara.direccionemp);
    $('#setelefono').val(dara.telefonoemp);
    $('#secargoactual').val(dara.cargo);
    $('#setiemposer').val(dara.id_tiempoemp);
    $('#sesalario').val(dara.salarioemp == null ? "0" : dara.salarioemp.Money());
    $('#seotroing').val(dara.otroingreso == null ? "0" : dara.otroingreso.Money());
    $('#seconceptooi').val(dara.concepto);
    if (dara.urlimg == "" || dara.urlimg == null) {
        $('.dropify-clear').click();
    } else {
        $('.dropify-wrapper').attr('class', 'dropify-wrapper has-preview');
        $('.dropify-preview').attr('style', 'display: block;');
        $('.dropify-render').append('<img src="' + window.appPath + '/Pages/Connectors/ConnectorGetFile.ashx?token=' + dara.urlimg + '">');
        $('.dropify-filename').append('<span class="dropify-filename-inner">' + dara.tipoper + '' + dara.identificacion + '</span>');
        foto = window.appPath + '/Pages/Connectors/ConnectorGetFile.ashx?token=' + dara.urlimg;
    }

    var div = $('#form');
    div.find('select').selectpicker('refresh');

    $('#ecivil').trigger('change');
}
var fotoget;

/* bloque los  , select y los botones que se deban bloquear */
function BlockForm() {
    var div = $('#form');
    div.find('input.form-control, select, textarea, button.btn-sin').attr('disabled', 'disabled');
    div.find('select').selectpicker('refresh');
    $('#id_AccountBox, #ds_cliente').attr('disabled', 'disabled');
    $('#ds_cliente').removeClass('inputsearch');
    $('.notbloque').prop('disabled', false);
    $('.notbloque').closest('.bootstrap-select').find('input.form-control').prop('disabled', false);
    $('select.notbloque').selectpicker('refresh');
}

/*limpia todos los campos de el formulario*/
function cleanForm() {
    ResetTituloSol("");
    $('.dropify-clear').click();
    var div = $('#form');
    //div.find('input.form-control, select, textarea, button').not('#direccion').removeAttr('disabled');
    //$('#id_AccountBox, #ds_cliente').removeAttr('disabled');
    $('#ds_cliente').addClass('inputsearch');
    div.find('input.form-control, select, textarea').val('');
    div.find('select').selectpicker('refresh');
    $("#archivos").fileinput('destroy');
    $("#archivos").fileinput({
        theme: 'fa',
        showUpload: false,
        uploadUrl: "D:\Proyectos Sintesis\Creditos\SintesisCloud\Clientes",
        dropZoneEnabled: false,
        maxFileCount: 12,
        mainClass: "input-group-lg",
        allowedFileExtensions: ["pdf"]
    });
    $('#tbodyreferen').empty();
    fieldsMoney();
    datepicker();
    $('#fexpe, #fnaci').val('');
    EnabledFinish(false);
    $('#id_solper').val('0');
    $('#identificacion').text('0')

    $('#filesaves').empty();
}

/*se utiliza para validar la cantidad minima de 
 referencias personales y familiares*/
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

/*asigna el titulo al formulario*/
function ResetTituloSol(val) {
    val = (val == "SOLICITANTE") ? "(DEUDOR)" : '(' + val + ')';
    $('#titulosol').text(val);
}

/* si la respuesta al eliminar un codeudor es incorrecta envia un mensaje
 con el error de lo contrario envia "Archivos subidos exitosamente." */
function EndCallbackDeleteCodeudor(params, answer) {
    if (!answer.Error) {
        toastr.success('Codeudor eliminado.', 'Sintesis Creditos');
        $('#' + params.id_persona).remove();
    }
    else {
        toastr.error(answer.Message, 'Sintesis Creditos');
        $('#btnPre').button('reset');
    }
}

/*al preciopnar el botón para guardar, ejecuta 
 todas la funciones internas, para poder guardar 
 la información suministrada*/
$('#btnguardar').click(function () {


    if (validate(JsonValidate)) {
        if (validateReferencia()) {
            atr = $('#ecivil').find('option:selected').attr('param');
            if (atr != 'SOL') {
                if (validate(JsonValidateCon)) {
                    GuardarSolicitud();
                }
            }
            else {
                GuardarSolicitud();
            }
        }
    }
});

if ($('#seotroing').val() > 0) {
    $('#seconceptooi').prop('required')
}

/*al cambiar el tipo de persona (Natural o Juridica), 
 se carga el tipo de identificación segun la opción escogida*/
$('#Selectipoper').change(function () {
    params = {};
    params.op = 'SELTIPOIDEN';
    params.Selectipoper = ($('#Selectipoper').val() == '') ? '0' : $('#Selectipoper').val();
    MethodService("Solicitudes", "CargarListadotipoiden", JSON.stringify(params), 'EndCallbackGetSelect');
});

/*carga el select de tipo de identificación, con el resultado 
 según la consulta realizada en "$('#Selectipoper').change"*/
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
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}

/*al salir de el input de identificación, se carga el 
 digito de verificación*/
$('#iden').blur(function () {
    var value = $(this).val();
    $('#identificacion').text(calcularDigitoVerificacion(value));

});
//cargar esta funcion en la master, para que sea general
/*calcula el digito de verificación, teniendo en cuenta 
 el valor de cada digito y la pocición del mismo*/
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
        toastr.info("La Identificación '" + myNit + "' no tiene Digito de verificación.", 'Sintesis Creditos');

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
        // console.log ( y + "x" + vpri[z-i] + ":" ) ;
        x += (y * vpri[z - i]);
        // console.log ( x ) ; 
    }

    y = x % 11;
    // console.log ( y ) ;
    return (y > 1) ? 11 - y : y;
}


/*al cambiar el tipo de referencia (Familiar, Personal) 
 se carga el select de tipo parentezco*/
$('#tiporef').change(function () {
    params = {};
    params.op = 'SELTIPOREF';
    params.tiporef = ($('#tiporef').val() == '') ? '0' : $('#tiporef').val();
    MethodService("Solicitudes", "CargarListadotiporef", JSON.stringify(params), 'EndCallbackGetref');
});

/*carga el select de parentezco, con el resultado
según la consulta realizada en "$('#tiporef').change"*/
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
        toastr.error(answer.Message, 'Sintesis ERP');
    }
}

/*verifica la cantidad de codeudores permitidos según
 la la tabla "Parametros" de la base de datos mediante una consulta*/
function cantcod() {
    params = {};
    params.op = 'VERICOD';
    params.valcod = null;
    MethodService("Solicitudes", "Verificarcod", JSON.stringify(params), 'EndCallbackGetverificacion');
}

/*verifica que el solicitante se haya creado primero y según la respuesta 
 de "cantcod()" emitira un mensaje de que ya tiene la cantidad maxima de 
 codeudores; o si no ha superado el numero de codeudores dejará que el proceso siga*/
function EndCallbackGetverificacion(params, answer) {
    if (!answer.Error) {
        if (!answer.Table.length == 0) {
            var cod = $('div[data-tipoper="CODEUDOR"]');
            var sol = $('div[data-tipoper="SOLICITANTE"]');
            var returns = false;
            valcod = answer.Table[0].valor;


            if (cod == undefined || cod.length < valcod) {
                if (sol.length == 0 || sol == undefined) {
                    toastr.warning("Debe ingresar primero el solicitante.", 'Sintesis Creditos');
                }
                else {
                    returns = true;
                    titlesol = "CODEUDOR";
                }
            }
            else
                toastr.warning("La solicitud tiene el numero maximo de codeudores.", 'Sintesis Creditos');
            if (returns) {
                cleanForm();
                ResetTituloSol(titlesol);
                $('#divregistro').show();
                $('#divagregados').hide();
                $("#btnCan").removeAttr('disabled');
            }
        } else {
            toastr.error('No se encuentra el parametro en la base de datos', 'Sintesis ERP');
        }
    }
    else {
        toastr.error(answer.Message, 'Sintesis ERP');
    }

}

/*al precionar el campo de foto, muestra el modal, detecta las camaras conectadas 
 (incluyendo la web cam si nes portatil) y la activa, dando prioridad a la camara conectada*/
$('#foto').click(function () {




    $('#ModalFoto').modal({ backdrop: 'static', keyboard: false }, "show");
    $('#previa').val($('#foto').val());



    //$('.dropify-clear').click();

    (function () {
        // Comenzamos viendo si tiene soporte, si no, nos detenemos
        if (!tieneSoporteUserMedia()) {
            alert("Lo siento. Tu navegador no soporta esta característica");
            $estado.innerHTML = "Parece que tu navegador no soporta esta característica. Intenta actualizarlo.";
            return;
        }
        //Aquí guardaremos el stream globalmente
        let stream;


        // Comenzamos pidiendo los dispositivos
        navigator
            .mediaDevices
            .enumerateDevices()
            .then(function (dispositivos) {
                // Vamos a filtrarlos y guardar aquí los de vídeo
                const dispositivosDeVideo = [];

                // Recorrer y filtrar
                dispositivos.forEach(function (dispositivo) {
                    const tipo = dispositivo.kind;
                    if (tipo === "videoinput") {
                        dispositivosDeVideo.push(dispositivo);
                    }
                });

                // Vemos si encontramos algún dispositivo, y en caso de que si, entonces llamamos a la función
                // y le pasamos el id de dispositivo
                if (dispositivosDeVideo.length > 0) {
                    // Mostrar stream con el ID del primer dispositivo, luego el usuario puede cambiar
                    if (dispositivosDeVideo[1] != null) {
                        mostrarStream(dispositivosDeVideo[1].deviceId);
                    }
                    mostrarStream(dispositivosDeVideo[0].deviceId);
                }
            });

        const mostrarStream = idDeDispositivo => {
            _getUserMedia(
                {
                    video: {
                        // Justo aquí indicamos cuál dispositivo usar
                        deviceId: idDeDispositivo,
                    }
                },
                function (streamObtenido) {
                    // Aquí ya tenemos permisos, ahora sí llenamos el select,
                    // pues si no, no nos daría el nombre de los dispositivos
                    //llenarSelectConDispositivosDisponibles();

                    // Escuchar cuando seleccionen otra opción y entonces llamar a esta función
                    $listaDeDispositivos.onchange = () => {
                        // Detener el stream
                        if (stream) {
                            $localstream = stream;
                            stream.getTracks().forEach(function (track) {
                                track.stop();
                            });
                        }
                        // Mostrar el nuevo stream con el dispositivo seleccionado
                        mostrarStream($listaDeDispositivos.value);
                    }

                    // Simple asignación
                    stream = streamObtenido;

                    // Mandamos el stream de la cámara al elemento de vídeo
                    $video.srcObject = stream;
                    $video.play();

                    //Escuchar el click del botón para tomar la foto
                    $boton.addEventListener("click", function () {

                        //Pausar reproducción
                        $video.pause();

                        //Obtener contexto del canvas y dibujar sobre él
                        let contexto = $canvas.getContext("2d");
                        $canvas.width = $video.videoWidth;
                        $canvas.height = $video.videoHeight;
                        contexto.drawImage($video, 0, 0, $canvas.width, $canvas.height);

                        let foto = $canvas.toDataURL(); //Esta es la foto, en base 64

                        //Reanudar reproducción
                        $video.play();
                    });
                }, function (error) {
                    toastr.error("Permiso denegado o error: ", error);
                    $estado.innerHTML = "No se puede acceder a la cámara, o no diste permiso.";
                });
        }
    })();


});

/*verifica que el navegador pueda soportar la carga de la transmición 
 de la camara sea externa o la webcam*/
function tieneSoporteUserMedia() {
    return !!(navigator.getUserMedia || (navigator.mozGetUserMedia || navigator.mediaDevices.getUserMedia) || navigator.webkitGetUserMedia || navigator.msGetUserMedia)
}

/*en conjunto co ls función anterior*/
function _getUserMedia() {
    return (navigator.getUserMedia || (navigator.mozGetUserMedia || navigator.mediaDevices.getUserMedia) || navigator.webkitGetUserMedia || navigator.msGetUserMedia).apply(navigator, arguments);
}


/*Declaramos estas constasntes que son necesarias para 
 manejar el funcionamiento de la camara y capturar la imagen*/
const $video = document.querySelector("#video"),
    $canvas = document.querySelector("#canvas"),
    $boton = document.querySelector("#boton"),
    $estado = document.querySelector("#estado"),
    $listaDeDispositivos = document.querySelector("#listaDeDispositivos");
/*y estas vaiables se declaran de manera global puesto que 
 se utilizan en 2 funciones completamente diferentes*/
var localstream = null;
foto = '';

/*La función que es llamada después de que ya se dieron los permisos
 Lo que hace es verifica los dispositivos obtenidos*/
const llenarSelectConDispositivosDisponibles = () => {

    navigator
        .mediaDevices
        .enumerateDevices()
        .then(function (dispositivos) {
            const dispositivosDeVideo = [];
            dispositivos.forEach(function (dispositivo) {
                const tipo = dispositivo.kind;
                if (tipo === "videoinput") {
                    dispositivosDeVideo.push(dispositivo);
                }
            });

            // Vemos si encontramos algún dispositivo, y en caso de que si, entonces llamamos a la función
            if (dispositivosDeVideo.length > 0) {
                // Llenar el select
                dispositivosDeVideo.forEach(dispositivo => {
                    const option = document.createElement('option');
                    option.value = dispositivo.deviceId;
                    option.text = dispositivo.label;
                    $listaDeDispositivos.appendChild(option);
                    //$('#listaDeDispositivos').attr($listaDeDispositivos);
                    //console.log("$listaDeDispositivos => ", $listaDeDispositivos)
                });
            }
        });
}

/*al hacer clic ya sea en el botón de la camara o en el recuadro de la 
 vista previa, captuta la imagen que sevea en la camara*/
$('#boton, #previa').click(function () {

    //Pausar reproducción
    $video.pause();

    //Obtener contexto del canvas y dibujar sobre él
    var contexto = $canvas.getContext("2d");
    $canvas.width = $video.videoWidth;
    $canvas.height = $video.videoHeight;
    contexto.drawImage($video, 0, 0, $canvas.width, $canvas.height);

    foto = $canvas.toDataURL(); //Esta es la foto, en base 64



    $('.dropify-render').empty();
    $('.dropify-filename').empty();
    $('.dropify-wrapper').attr('class', 'dropify-wrapper has-preview');
    $('.dropify-preview').attr('style', 'display: block;');
    $('.dropify-render').append('<img src="' + foto + '" style="max-heigth:205px">');
    $('.dropify-filename').append('<span class="dropify-filename-inner">' + $('#tipoper').val() + '' + $('#iden').val() + '</span>');


    //Reanudar reproducción
    $video.play();
});

/*cancela la foto tomada y borra los 2 recuadros de vista previa*/
$('#btnCancelPhoto, .salgo').click(function () {

    $('.dropify-clear').click();

    video.srcObject.getTracks().forEach(function (track) {
        track.stop();
    });
});

/*guarda la imagen tomada y la muestra en el lugar de la foto*/
$('#btnSavePhoto').click(function () {


    video.srcObject.getTracks().forEach(function (track) {
        track.stop();
    });

});


