//Funcion Validarformulario
//Recibe como parametro el xml del formulario que se va a validar. 
//Se utiliza  para validar x formulario que contenga su estructura xml.
function ValidarXmlFormulario(objXmlRegistro) {
    var lstCampos = null;
    var bRequerido = null;
    var vCampos = new Array();
    var iIndexArray = -1;
    var sCampo = "";
    var sMensaje = "";
    var sValor = "";
    var sControl = "";
    var lstObjetos;
    if (objXmlRegistro != undefined && objXmlRegistro != null && objXmlRegistro.childNodes != undefined && objXmlRegistro.childNodes != null && objXmlRegistro.childNodes.length > 0) {
        try {
            lstCampos = objXmlRegistro.getElementsByTagName("Campos");
            if (lstCampos != null) {
                for (var k = 0; k < lstCampos.length; k++) {
                    bRequerido = (eval(lstCampos[k].attributes.getNamedItem("Requerido") != undefined ? lstCampos[k].attributes.getNamedItem("Requerido").value : false) == true);
                    sControl = lstCampos[k].attributes.getNamedItem("Control") != undefined ? lstCampos[k].attributes.getNamedItem("Control").value : "";
                    sCampo = lstCampos[k].attributes.getNamedItem("Identificador") != undefined ? lstCampos[k].attributes.getNamedItem("Identificador").value : "";
                    sMensaje = lstCampos[k].attributes.getNamedItem("Mensaje") != undefined ? lstCampos[k].attributes.getNamedItem("Mensaje").value : "";
                    sTipoValidacion = lstCampos[k].attributes.getNamedItem("TipoValor") != undefined ? lstCampos[k].attributes.getNamedItem("TipoValor").value : "";
                    $('#' + sCampo).closest('.floating-label').removeClass('has-error');
                    if (sControl.toLowerCase() !== "checkbox") {
                        if (document.getElementById(sCampo) !== null && $("#" + sCampo).is(':visible')) {
                            sValor = $('#' + sCampo).val();
                            vCampos[++iIndexArray] = new Array($('#' + sCampo), sMensaje, sValor, sTipoValidacion, bRequerido, sCampo);
                        }
                    }
                }
                if (!validar(vCampos)) {
                    return false;
                }
                return true;
            } else {
                ViewMessage('Error', 'error', 'Método Validar Formulario():\nNo se encontró la estructura de bloques en el XML del registro, por favor comuníquese con el administrador de sistemas.');
                return false;
            }
        } catch (e) {
            ViewMessage('Error', 'error', 'Método Validar Formulario():\n' + e.message + '\nArchivo: FuncionesGScripts.js');
            return false;
        }
    }
    else {
        ViewMessage('Error', 'error', 'Método Validar Formulario():\n" + "No se pudo leer el xml del registro" + "\nArchivo: FuncionesGScripts.js');
    }
}

//Funcion ObtenerValoresFormulario
//Recibe el vector o arreglo que con los datos de los campos
//Se utiliza  para obtener los valores del formularo x.
function ObtenerValoresFormulario(XmlRegistro) {
    var objCuerpo = new Object();
    var Campo = [];
    var listBloques = null;
    var sFormato = '';
    var sIdentificadorSecundario = '';
    var sValorVacio = '';
    var bGuardarRiesgo = true;
    var sValorFormatoFecha4725 = '';
    var sTipoValorFormatoFecha = '';
    var sCodigo = "";
    // var VariablesRegistro = [];
    var lstVariablesRegistro = [];
    var sFormatoResolucion = "";
    try {
        var listCampos = XmlRegistro.getElementsByTagName("Campos");
        //se recorren los campos obtenidos  de la seccion
        for (k = 0; k < listCampos.length; k++) {
            Campos = new Object();
            CamposReg = new Object();
            if (listCampos[k].attributes != null && listCampos[k].attributes != undefined) {
                bErrorGuardar = false;
                bGuardarRiesgo = true;
                //Se obtienen los valores necesario de los atributos de las campos del XML
                sCampo = listCampos[k].attributes.getNamedItem("Nombre").value;
                sTipoValor = listCampos[k].attributes.getNamedItem("TipoValor").value.toLowerCase();
                sControl = listCampos[k].attributes.getNamedItem("Control").value.toLowerCase();
                sIdentificador = listCampos[k].attributes.getNamedItem("Identificador").value;
                //Condicion para guardar Nodo Formato
                if (listCampos[k].attributes.getNamedItem("Formato") != null) {

                    sFormato = listCampos[k].attributes.getNamedItem("Formato").value;
                    if (sFormato != "") {
                        sFormatoResolucion = sFormato;
                    }
                } else {
                    sFormato = '';
                }
                //Condicion para guardar Nodo IdentificadorSecundario
                if (listCampos[k].attributes.getNamedItem("IdentificadorSecundario") != null) {
                    sIdentificadorSecundario = listCampos[k].attributes.getNamedItem("IdentificadorSecundario").value;
                }


                //Condicion para guardar Nodo Codigo4725
                if (listCampos[k].attributes.getNamedItem("Codigo") != null) {
                    sCodigo = listCampos[k].attributes.getNamedItem("Codigo").value;
                } else {
                    sCodigo = "";

                }

                //Condicion Toma el formato de la variable fecha
                if (listCampos[k].attributes.getNamedItem("FormatoCampo") != null) {
                    sTipoValorFormatoFecha = listCampos[k].attributes.getNamedItem("FormatoCampo").value;
                } else { sTipoValorFormatoFecha = '' }


                //Condicion para guardar Nodo ValorVacio
                if (listCampos[k].attributes.getNamedItem("ValorVacio") != null) {
                    sValorVacio = listCampos[k].attributes.getNamedItem("ValorVacio").value;
                }

                var sValorCampo = "";
                var sValorCampoText = "";
                var existecampo = true;
                if ((eval(sIdentificador) == null || eval(sIdentificador) == undefined) && sControl.toLowerCase() != "aspxhiddenfield") {
                    existecampo = false;
                }

                if (!existecampo) {
                    alert("El Identificador: " + sIdentificador + " no existe.");
                    return false;
                }

                ///Se valida  por el tipo de contro para saber 
                switch (sControl) {

                    case "textbox":
                        if (document.getElementById(sIdentificador) != null) {
                            CamposReg.ValorCampo = document.getElementById(sIdentificador).value;
                            CamposReg.Codigo = sCodigo;
                            CamposReg.ValorTexto = document.getElementById(sIdentificador).value;;
                            sValorCampo = document.getElementById(sIdentificador).value;
                        }
                        break;

                    case "textarea":
                        sValorCampo = $("#" + sIdentificador + "").val();
                        CamposReg.ValorCampo = document.getElementById(sIdentificador).value;
                        CamposReg.Codigo = sCodigo;
                        CamposReg.ValorTexto = document.getElementById(sIdentificador).value;
                        if (sValorCampo == undefined) {
                            bErrorGuardar = true;
                        }
                        break;

                    case "input":
                        if ($("#" + sIdentificador).is(':visible')) {
                            sValorCampo = $("#" + sIdentificador + "").val().replace(/[`~!#$%^&¢+¿£()¨´Œ|œ+\=?§;:'"^,|<>\{\}\[\]\\\/]/gi, '');
                            Campos.Nombre = sCampo;
                            Campos.Valor = sValorCampo;
                            Campos.TipoValor = sTipoValor;
                            Campos.Control = sControl;
                            Campos.Formato = sFormato;
                            Campos.TipoValorFormatoFecha = sValorFormatoFecha4725;
                            Campos.CodigoVariable = sCodigo;
                            Campos.Identificador = sIdentificador;
                            Campos.Valortexto = sValorCampoText;
                            Campo.push(Campos);
                        }
                        break;

                    case "radio":
                        sValorFormatoFecha4725 = '';
                        var lstRadios = document.getElementsByName(sIdentificador);
                        if ($("#" + lstRadios[0].id).is(':visible')) {
                            for (l = 0; l < lstRadios.length; l++) {
                                if (lstRadios[l].checked) {
                                    CamposReg.ValorCampo = lstRadios[l].value;
                                    CamposReg.Codigo = sCodigo;
                                    CamposReg.ValorTexto = "";
                                    sValorCampo = lstRadios[l].value;
                                    sIdentificador = lstRadios[l].id;
                                }
                            }
                        }
                        break;

                    case "checkbox":
                        if (sTipoValor == "seleccionmultiple") {
                            var objSeleccionMultiple = document.getElementsByName(sIdentificador);
                            if (objSeleccionMultiple != null) {
                                //Validar que almenos este escogida una opción.
                                if ($("#" + objSeleccionMultiple[0].id).is(':visible')) {
                                    if ($('input:checkbox[name=' + sIdentificador + ']:checked').length == 0) {
                                        sValorCampo = "";
                                        sTipoValor = "TEXTO";
                                    } else {
                                        for (var iIndex = 0; iIndex < objSeleccionMultiple.length; iIndex++) {
                                            Campos = new Object();

                                            sValorCampo = objSeleccionMultiple[iIndex].checked;
                                            sCampo = objSeleccionMultiple[iIndex].id;

                                            Campos.Nombre = sCampo;
                                            Campos.Valor = sValorCampo;
                                            Campos.TipoValor = sTipoValor;
                                            Campos.Control = sControl;
                                            Campos.Formato = sFormato;
                                            Campos.TipoValorFormatoFecha = sValorFormatoFecha4725;
                                            Campos.CodigoVariable = sCodigo;
                                            Campos.Identificador = sIdentificador;
                                            Campos.Valortexto = sValorCampoText;
                                            Campo.push(Campos);
                                        }

                                    }
                                }
                            }
                            else {
                                bErrorGuardar = true;
                            }
                        }
                        else {

                            if (document.getElementById(sIdentificador) != null) {

                                sValorCampo = $("#" + sIdentificador + "").is(":checked");//val().replace(/[`~!@#$%^&¢+¿£()¨´Œ|œ+\=?§;:'"^,|.<>\{\}\[\]\\\/]/gi, '');
                                Campos.Nombre = sCampo;
                                Campos.Valor = sValorCampo;
                                Campos.TipoValor = sTipoValor;
                                Campos.Control = sControl;
                                Campos.Formato = sFormato;
                                Campos.TipoValorFormatoFecha = sValorFormatoFecha4725; //jmejia
                                Campos.CodigoVariable = sCodigo;
                                Campos.Identificador = sIdentificador;
                                Campos.Valortexto = sValorCampoText;
                                Campo.push(Campos);
                            }
                            else {
                                bErrorGuardar = true;
                            }
                        }
                        break;
                }

                if (bErrorGuardar) {
                    alert('Error al obtener los datos para guardar:\nno se encontró el elemento con el identificador ' + sIdentificador + ' o está mal configurado en el XML (Bloque: ' + Bloques.Nombre + ' Sección: ' + Secciones.Nombre + ', por favor verifique.');
                    return false;
                }
            }
        }
        return Campo;
    } catch (e) {
        alert("ERROR: Método Obtener Valores Formulario:\n" + e.message + "\nArchivo: FuncionesGlobales.js");
    }
}

//Funcion CargarSelec
//Recibe el id del select y el vector de los dastos
//Se utiliza  para lenar los select que son uniseleccion.
function CargarSelec(identificador, Vector) {
    var sSelect = '<option value="">Seleccione</option>';
    if (Vector != undefined && Vector != null) {
        for (i = 0; i < Vector.length; i++) {
            sSelect += '<option value="' + Vector[i].Valor + '">' + Vector[i].Texto + '</option>';
        }
    }
    $('#' + identificador)[0].innerHTML = sSelect;
}

//Funcion CargarSelectMulti
//Recibe el id del select y el vector de los dastos
//Se utiliza  para lenar los select que son multiples seleccion.
function CargarSelecMulti(identificador, Vector) {
    var sSelect = '';
    if (Vector != undefined && Vector != null) {
        for (i = 0; i < Vector.length; i++) {
            sSelect += '<option value="' + Vector[i].Valor + '">' + Vector[i].Texto + '</option>';
        }
    }
    $('#' + identificador)[0].innerHTML = sSelect;
}

//Funcion doShearch
//Recibe el id de la tabla como parametro
//Se utiliza  para buscar en las tablas precargadas.
function doSearch(idTabla) {
    var tableReg = document.getElementById(idTabla);
    var searchText = document.getElementById('searchTerm').value.toLowerCase();
    for (var i = 1; i < tableReg.rows.length; i++) {
        var cellsOfRow = tableReg.rows[i].getElementsByTagName('td');
        var found = false;
        for (var j = 0; j < cellsOfRow.length && !found; j++) {
            var compareWith = cellsOfRow[j].innerHTML.toLowerCase();
            if (searchText.length == 0 || (compareWith.indexOf(searchText) > -1)) {
                found = true;
            }
        }
        if (found) {
            tableReg.rows[i].style.display = '';
        } else {
            tableReg.rows[i].style.display = 'none';
        }
    }
}

//Funcion Solonumero
//Recibe la tecla precionada como parametro
//Se utiliza en loa textos donde solamente se puede escribir numeros.
function solonumeros(e) {
    key = e.keyCode || e.which;
    tecla = String.fromCharCode(key).toLowerCase();
    letras = "0123456789.";
    especiales = "8-37-39-46";

    tecla_especial = false
    for (var i in especiales) {
        if (key == especiales[i]) {
            tecla_especial = true;
            break;
        }
    }

    if (letras.indexOf(tecla) == -1 && !tecla_especial) {
        return false;
    }
}

function solonumero(e) {
    key = e.keyCode || e.which;
    tecla = String.fromCharCode(key).toLowerCase();
    letras = "0123456789";
    especiales = "8-37-39-46";

    tecla_especial = false
    for (var i in especiales) {
        if (key == especiales[i]) {
            tecla_especial = true;
            break;
        }
    }

    if (letras.indexOf(tecla) == -1 && !tecla_especial) {
        return false;
    }
}

function disableTable(table) {
    tab = document.getElementById(table);
    for (i = 0; ele = tab.getElementsByTagName('a')[i]; i++) {
        ele.style.display = 'none';
    }
    for (i = 0; ele = tab.getElementsByTagName('input')[i]; i++) {
        ele.disabled = true;
    }
}

function DesenMascar(Id) {
    nValor = $('#' + Id).maskMoney('unmasked')[0];
    return nValor;
}

function fn_LimpiarCampo(id) {
    document.getElementById(id).value = '';
}

var xmlDoc;
function crearObjetoXML(archivoXML) {
    try {
        var navegador = navigator.appName;
        if (navegador == "Microsoft Internet Explorer") //IE
        {
            xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
        }
        else if (navegador == "Netscape") //otros safari, chrome
        {
            var xmlhttp = new window.XMLHttpRequest();
            xmlhttp.open("GET", archivoXML, false);
            xmlhttp.send(null);
            xmlDoc = xmlhttp.responseXML.documentElement;
            return xmlDoc;
        }
        else //firefox
        {
            xmlDoc = document.implementation.createDocument("", "", null);
        }
        xmlDoc.async = false;
        xmlDoc.load(archivoXML);


    }
    catch (e) {
        try {

        }
        catch (e) {
            return undefined;
        }

    }
    return xmlDoc;

}

function ViewMessage(title, type, text) {
    new PNotify({
        title: title,
        text: text,
        type: type,
        styling: 'bootstrap3'
    });
}