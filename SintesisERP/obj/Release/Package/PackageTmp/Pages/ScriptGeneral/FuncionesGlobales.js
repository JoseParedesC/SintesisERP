var codeValidate = new Array();

codeValidate["DATE"] = "(?:[1-9]\\d\\d\\d|\\d[1-9]\\d\\d|\\d\\d[1-9]\\d|\\d\\d\\d[1-9])(\\/|-)(?:(?:0?[1-9]|1[0-2])(\\/|-)(?:0?[1-9]|1\\d|2[0-8]))$|^(?:[1-9]\\d\\d\\d|\d[1-9]\\d\\d|\\d\\d[1-9]\\d|\\d\\d\\d[1-9])(\\/|-)(?:(?:(?:0?[13578]|1[02])(\\/|-)31)|(?:(?:0?[1,3-9]|1[0-2])(\\/|-)(?:29|30)))$|^(?:(?:0[48]00|[13579][26]00|[2468][048]00)|(?:\\d\\d)?(?:0[48]|[2468][048]|[13579][26]))(\\/|-)(0?2(\\/|-)29)$";
codeValidate["TEXT"] = "\\w+";
codeValidate["WHOLE"] = "^(\\+?|\\-)\\d+$";
codeValidate["EMAIL"] = "^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,3})$";
codeValidate["WEB"] = "/^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \?=.-]*)*\/?$/";
codeValidate["REAL"] = "^(\\+?|\\-)\\d+\\.?\\d*$";
codeValidate["ONLYNUMBER"] = "^\\d+$";
codeValidate["MILITARYHOUR"] = "^(0[0-9]|1[0-9]|2[0-3]):([0-5][0-9])$"; //Validar Hora en formato 24H
codeValidate["COMPLETHOUR"] = "^(0[1-9]|1[0-2]):([0-5][0-9])?(:)?([0-5][0-9])$"; //Validar Hora
codeValidate["HOUR"] = "^(0[1-9]|1[0-2]):([0-5][0-9])?(:)?([ ]?[a|p]m)$";

// Archivo JScript
var aFinMes = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
var APOS = "'"; QUOTE = '"'
var ESCAPED_QUOTE = {}
ESCAPED_QUOTE[QUOTE] = '&quot;'
ESCAPED_QUOTE[APOS] = '&apos;'
var giContadorSignosVitales = '';

function maxLength(e, obj, num) {
    k = (document.all) ? e.keyCode : e.which;
    if (k == 8 || k == 0) { return true; }
    else { return obj.value.length < num; }
}

function procesarEnter(e, f) {
    if (navigator.appName == "Netscape") tecla = e.which;
    else tecla = e.keyCode;
    if (tecla == 13) { f(); return false; }
    else return true;
}
//-----------------------------------------
function Redondear(numero, X) {
    X = (!X ? 2 : X);
    return Math.round(parseFloat(numero) * Math.pow(10, X)) / Math.pow(10, X);
}
//-----------------------------------------
function fecha(cadena) {

    //Separador para la introduccion de las fechas   
    var separador = "/"

    //Separa por dia, mes y año   
    if (cadena.indexOf(separador) != -1) {
        var posi1 = 0
        var posi2 = cadena.indexOf(separador, posi1 + 1)
        var posi3 = cadena.indexOf(separador, posi2 + 1)
        this.dia = cadena.substring(posi1, posi2)
        this.mes = cadena.substring(posi2 + 1, posi3)
        this.anio = cadena.substring(posi3 + 1, cadena.length)
    } else {
        this.dia = 0
        this.mes = 0
        this.anio = 0
    }
}
//------------------------------------------
function diferenciaFechas(fec1, fec2, periodo) {

    var fecha1 = new fecha(fec1);
    var fecha2 = new fecha(fec2);

    var miFecha1 = new Date(fecha1.anio, fecha1.mes, fecha1.dia);
    var miFecha2 = new Date(fecha2.anio, fecha2.mes, fecha2.dia);

    var diferencia = miFecha1.getTime() - miFecha2.getTime();
    var dias = Math.floor(diferencia / (1000 * 60 * 60 * 24));
    if (periodo == "Años") {
        return Redondear((dias / 365), 3);
    } else if (periodo == "Meses") {
        return Redondear((dias / 30), 3);
    } else {
        return Redondear(dias, 3);
    }

}
//Maxima longitud
function maximaLongitud(texto, maxlong) {
    var tecla, in_value, out_value;

    if (texto.value.length > maxlong) {
        in_value = texto.value;
        out_value = in_value.substring(0, maxlong);
        texto.value = out_value;
        return false;
    }
    return true;
}

//esta funcion solo deja ingresar numeros enteros
function entero(e) {
    var caracter
    caracter = e.keyCode
    status = caracter

    if (caracter > 47 && caracter < 58) {
        return true
    }
    return false

}

//esta funcion solo deja ingresar numeros enteros
function enteroPunto(e) {
    var caracter
    caracter = e.keyCode
    status = caracter

    if ((caracter > 47 && caracter < 58) || caracter == 46) {
        return true
    }
    return false

}

function soloNumeros() {
    var dato = event.keyCode;
    if (((dato < 48) || (dato > 57)) && ((dato < 96) || (dato > 105)) && (dato != 8) && ((dato < 35) || (dato > 40)) && (dato != 9) && (dato != 46) && (dato != 16))
        return false;
}

function isNumerico(valor) {
    var dato = valor;
    if (((dato < 48) || (dato > 57)) && ((dato < 96) || (dato > 105)) && (dato != 8) && ((dato < 35) || (dato > 40)) && (dato != 9) && (dato != 46) && (dato != 16))
        return false;
}

function testear(p, c) {
    try {
        var patron = new RegExp(p, "gi");
        return patron.test(c);
    } catch (e) {
        console.log(e.name + " - " + e.message);
        return false;
    }
}

function validate(json) {
    removeerror();
    var returns = true;
    $.each(json, function (i, e) {
        id = (e.id === undefined) ? '' : e.id;
        type = (e.type === undefined) ? '' : e.type;
        required = (e.required === undefined) ? false : e.required;
        depends = (e.depends === undefined) ? false : e.depends;
        iddepends = (e.iddepends === undefined) ? '' : e.iddepends;
        htmltype = (e.htmltype === undefined) ? '' : e.htmltype;
        patron = codeValidate[type];
        element = $('#' + id);
        value = '';
        //Se agregó CREDIFORM en el if para poder extender el acordeon de la solicitud
        if ((htmltype.toUpperCase() == 'INPUT' && (element.is(':visible') || element.hasClass("CREDIFORM"))) || htmltype.toUpperCase() == 'SELECT') {
            if (htmltype.toUpperCase() == 'SELECT' && element.prop('multiple'))
                value = setMultiSelect(e.id);
            else
                value = element.val();
            if (type == 'WHOLE' || type == 'REAL' || type == 'ONLYNUMBER') {
                value = value.replace('$', '').replace('%', '').replace(/,/gi, '').replace(/ /gi, '');
            }
            if (testear(patron, value) || (type == 'TEXT' && value.trim() == '')) {
                if (required && (value == null || value.trim() == '')) {
                    if (element.hasClass("CREDIFORM")) {
                        element.closest('.collapse').addClass('in');
                        element.closest('.collapse').attr('aria-expanded', 'true');
                        element.closest('.collapse').attr('style', '');
                    }
                    adderror(element, '');
                    returns = false;
                    return false;
                }
                else if (depends) {
                    if ($('#' + iddepends).prop('checked') && value.trim() == '') {
                        adderror(element, '');
                        returns = false;
                        return false;
                    } else {
                        element.closest('.form-group').removeClass('error');
                    }
                }
                else {
                    element.closest('.form-group').removeClass('error');
                }
            }
            else {
                adderror(element, '');
                returns = false;
                return false;
            }
        }
        else if (htmltype.toUpperCase() == 'CHECK') {
            value = element.prop('checked');
        }
    });
    return returns;
}

function WriteMessage(msg, type) {
    if (type.toUpperCase() == 'S')
        toastr.success(msg, 'Sintesis ERP');
    else if (type.toUpperCase() == 'E')
        toastr.error(msg, 'Sintesis ERP');
    else if (type.toUpperCase() == 'W')
        toastr.warning(msg, 'Sintesis ERP');
    else
        toastr.info(msg, 'Sintesis ERP');
}

function adderror(element, type) {
    element.closest('.form-group').addClass('error is-focused');
}

function removeerror() {
    $('.form-group.error').removeClass('error');
}

function newID(id) {
    var newid = 'SI' + s4() + s4() + '-' + s4() + '-' + s4() + '-' + s4() + '-' + s4() + s4() + s4();
    $('#' + id).val(newid);
}

function s4() {
    return Math.floor((1 + Math.random()) * 0x10000).toString(16).substring(1);
}

function SetNumber(value) {
    var valor = value.replace(/,/gi, '').replace('$', '').replace('%', '').replace(/ /gi, '');
    return valor;
}

Number.prototype.Money = function (fixed) {
    var fix = (fixed == undefined) ? 2 : fixed;
    try {
        if (fix == 0)
            return this.toFixed(fix).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        else
            return this.toFixed(fix).replace(/(\d)(?=(\d{3})+\.)/g, '$1,');

    } catch (ex) {
        return this;
    }
}

Number.prototype.Int = function () {
    try {
        return this.toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,').split('.')[0];
    } catch (ex) {
        return this;
    }
}

function SetDate(value) {
    var valor = value.replace(/-/gi, '');
    return valor;
}

function fieldsMoney() {
    //Documentación: http://www.decorplanit.com/plugin/
    $("[money]").each(function (i, control) {
        $(control).autoNumeric('init');
        //Get Value: $(control).autoNumeric('get');
    });

}

function PrintDocument(params, id, type) {
    if (isMobile() != null) {
        window.open(elem.url, window.appPath + "/Pages/Connectors/ConnectorReport.ashx?params=" + params + "&idreport=" + id + "&type=" + type);
    }
    else {
        loadingReporte();
        $("#reportviewer").modal({ backdrop: 'static', keyboard: false }, 'show');
        $('#iframeprint').attr('src', window.location.origin + '/' + window.appPath + "/Pages/Connectors/ConnectorReport.ashx?params=" + params + "&idreport=" + id + "&type=" + type)
        //$('#pdf_content').attr('data', window.appPath + "/Pages/Connectors/ConnectorReport.ashx?params=" + params + "&idreport=" + id + "&type=" + type);
    }
}


function PrintDocumentos(url) {
    if (isMobile() != null) {
        window.open(elem.url, url);
    }
    else {
        loadingReporte();
        $("#reportviewer").modal({ backdrop: 'static', keyboard: false }, 'show');
        $('#iframeprint').attr('src', url);
    }
}

function loadingReporte() {
    $("#loadingDiv").show();
}

$('#iframeprint').load(function () {
    $('#loadingDiv').hide();
}); 

function isMobile() {
    return (
        (navigator.userAgent.match(/Android/i)) ||
        (navigator.userAgent.match(/webOS/i)) ||
        (navigator.userAgent.match(/iPhone/i)) ||
        (navigator.userAgent.match(/iPod/i)) ||
        (navigator.userAgent.match(/iPad/i)) ||
        (navigator.userAgent.match(/BlackBerry/i))
    );
}

function replacetemp(template, data) {
    return template.replace(/\{([\w\.]*)\}/g, function (str, key) {
        var keys = key.split("."), v = data[keys.shift()];
        for (var i = 0, l = keys.length; i < l; i++) v = v[keys[i]];
        return (typeof v !== "undefined" && v !== null) ? v : "";
    });
}

//$('.modal-dialog').draggable({
//    handle: ".modal-header"
//});


function nano(template, data) {
    return template.replace(/\{([\w\.]*)\}/g, function (str, key) {
        var keys = key.split("."), v = data[keys.shift()];
        for (var i = 0, l = keys.length; i < l; i++) v = v[keys[i]];
        return (typeof v !== "undefined" && v !== null) ? v : "";
    });
}

function CalcularDv(nit) {
    var arreglo, x, y, z, i, nit1, dv1;
    nit1 = nit;
    if (isNaN(nit1)) {
        toastr.warning('Número del Nit no valido, ingrese un número sin puntos, ni comas, ni guiones, ni espacios');
    } else {
        arreglo = new Array(16);
        x = 0;
        y = 0;
        z = nit1.length;
        arreglo[1] = 3;
        arreglo[2] = 7;
        arreglo[3] = 13;
        arreglo[4] = 17;
        arreglo[5] = 19;
        arreglo[6] = 23;
        arreglo[7] = 29;
        arreglo[8] = 37;
        arreglo[9] = 41;
        arreglo[10] = 43;
        arreglo[11] = 47;
        arreglo[12] = 53;
        arreglo[13] = 59;
        arreglo[14] = 67;
        arreglo[15] = 71;
        for (i = 0; i < z; i++) {
            y = nit1.substr(i, 1);
            x += y * arreglo[z - i];
        }
        y = x % 11;
        if (y > 1) {
            dv1 = 11 - y;
        }
        else {
            dv1 = y;
        }
        return dv1;
    }
}

//Esta función fue agregada para convertir la URL del archivo
function dataURLtoFile(dataurl, filename) {

    var arr = dataurl.split(','),
        mime = arr[0].match(/:(.*?);/)[1],
        bstr = atob(arr[1]),
        n = bstr.length,
        u8arr = new Uint8Array(n);

    while (n--) {
        u8arr[n] = bstr.charCodeAt(n);
    }

    return new File([u8arr], filename, { type: mime });
}