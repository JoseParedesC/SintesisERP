var codeValidate = new Array();

codeValidate["DATE"] = "(?:[1-9]\\d\\d\\d|\\d[1-9]\\d\\d|\\d\\d[1-9]\\d|\\d\\d\\d[1-9])(\\/|-)(?:(?:0?[1-9]|1[0-2])(\\/|-)(?:0?[1-9]|1\\d|2[0-8]))$|^(?:[1-9]\\d\\d\\d|\d[1-9]\\d\\d|\\d\\d[1-9]\\d|\\d\\d\\d[1-9])(\\/|-)(?:(?:(?:0?[13578]|1[02])(\\/|-)31)|(?:(?:0?[1,3-9]|1[0-2])(\\/|-)(?:29|30)))$|^(?:(?:0[48]00|[13579][26]00|[2468][048]00)|(?:\\d\\d)?(?:0[48]|[2468][048]|[13579][26]))(\\/|-)(0?2(\\/|-)29)$";
codeValidate["TEXT"] = "\\w+";
codeValidate["WHOLE"] = "^(\\+?|\\-)\\d+$";
codeValidate["EMAIL"] = "^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,3})$";
codeValidate["WEB"] = "/^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \?=.-]*)*\/?$/";
codeValidate["REAL"] = "^(\\+?|\\-)\\d+\\.?\\d*$";
codeValidate["ONLYNUMBER"] = "^\\d+$";
codeValidate["MILITARYHOUR"] = "^(0[1-9]|1[0-9]|2[0-3]):([0-5][0-9])?(:)?([0-5][0-9])$"; //Validar Hora en formato 24H
codeValidate["COMPLETHOUR"] = "^(0[1-9]|1[0-2]):([0-5][0-9])?(:)?([0-5][0-9])$"; //Validar Hora
codeValidate["HOUR"] = "^(0[1-9]|1[0-2]):([0-5][0-9])?(:)?([ ]?[a|p]m)$";

function ValidarCampos(Campos) {
    try {
        var item;
        retorno = true;
        for (i = 0; i < Campos.length; i++) {
            item = document.getElementById(Campos[i].id);
            Tipo = Campos[i].Tipo;
            Control = Campos[i].Control;
            valor = (Tipo != 'REAL') ? item.value : item.value.replace(/,/gi, '');
            Obligatorio = Campos[i].Obligatorio;
            if ((valor == '' || valor == undefined || valor == null) && (eval(Obligatorio != undefined ? Obligatorio : false) == true) == true) {
                if (Control == 'input')
                    item.style.backgroundColor = "#FCF894";
                else
                    alert('Seleccione campo ' + Campos[i].Nombre);
                item.focus();
                i = Campos.length;
                retorno = false;
            }
            else if (!testear(codidosValidacion[Tipo], valor) && valor != '') {
                if (Control == 'input')
                    item.style.backgroundColor = "#FCF894";
                alert('EL campo ' + Campos[i].Nombre + ' no cumple con el tipo ' + Tipo);
                item.focus();
                i = Campos.length;
                retorno = false;
            }
            else
                item.style.backgroundColor = "#fff";
        }
        return retorno;
    }
    catch (ex) {
        alert('Error en la validación de campos...');
        return false;
    }
}

function validar(valores) {
    try {
        var r = true;
        var lstObjRadio = null;

        var i = 0;
        for (i = 0; i < valores.length; i++) {
            var patron = codidosValidacion[valores[i][3]];
            var cadena = valores[i][2];
            var required = valores[i][4];
            if ((!required && cadena.trim() != "") || required) {
                r = testear(patron, cadena);
            }
            if (!r) {
                var elementId = valores[i][5];
                if ($('#' + elementId).prop("disabled") == false) {
                    $('#' + elementId).closest('.floating-label').addClass('has-error');
                    $('#' + elementId).focus();
                }

                if (cadena.trim() !== "")
                    ViewMessage('Verificar.', 'info', "El campo '" + valores[i][1] + "' no cumple con el formato [" + valores[i][3] + "]");

                break;
            }
        }
    } catch (e) {
        ViewMessage('Verificar.', 'info', e.message);
    }
    return r;
}
//--------------------------------------
function testear(p, c) {
    try {
        var patron = new RegExp(p, "gi");
        return patron.test(c);
    } catch (e) {
        ViewMessage('Advertencia', 'warning', "Validador() [ " + e.name + " - " + e.message + " ]");
        return false;
    }
}
