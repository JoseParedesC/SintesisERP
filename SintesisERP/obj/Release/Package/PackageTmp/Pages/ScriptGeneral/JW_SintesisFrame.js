

/*******************************************************************************************************************************
Región:         FUNCIONES AJAX
Descripción:    Archivo JS Utilizado Para los llamados al Servidor Por medio de WebMethod aspx
Autor:          SintesisTecnologia JD
/*******************************************************************************************************************************/


/// <summary>
///  Formatear una función para obtener los valores de la fuente de datos mencionados en ella
/// </summary>
/// <param name="Controller" type="String">Nombre del controlador a invocar</param>
/// <param name="Parameter" type="Objet">Objeto que sirve para enviar información desde cliente a servidor</param>
/// <param name="Internal" type="Boolean">Determina si el llamado del controlador es interno ó externo</param>
/// <param name="EndCallBack" type="String">Función que se dispara al terminar el llamado Ajax</param>
function WebServiceMetodo(sUrl, sMetodo, Criterios, EndCallBack) {

    /*Llamado Ajax*/
    $.ajax({
        url: sUrl + '.aspx/' + sMetodo,
        type: "POST",
        contentType: "application/json;charset=utf-8",
        dataType: "json",
        data: JSON.stringify({ Criterio: Criterios }),
        success: function (data) {

            var sResult = jQuery.parseJSON(data.d);

            /*Validar si la función utiliza EndAjax*/
            if (EndCallBack != undefined) {
                var sFuncion = (EndCallBack + "(x,y);");
                var myFuntion = new Function("x", "y", sFuncion);
                myFuntion(Criterios, sResult);
            }

        },
        error: function (xhr) {
            parent.MensajeError(false, 'Sintesis', "Error al llamar metodo: " + sUrl + ' - ' + sMetodo + ' (ajax).', "");
        }
    });
}

function MethodService(Class, Method, Params, EndCallBack) {
    $.post("../Pages/Connectors/Connector.ashx",
        { "class": Class, method: Method, params: Params },
        function (ans) {
            var sResult = ans.ans;
            if (EndCallBack != undefined) {
                var sFuncion = (EndCallBack + "(x,y);");
                var myFuntion = new Function("x", "y", sFuncion);
                myFuntion(Params, sResult);
            }
        }, 'json').error(function (e) {
            console.log(e);
        }
        );
}

function MethodHtml(Class, Method, Params, EndCallBack) {
    $.post("../Pages/Connectors/ConnectorHtml.ashx",
        { "class": Class, method: Method, params: Params },
        function (ans) {
            var sResult = ans.ans;
            if (EndCallBack != undefined) {
                var sFuncion = (EndCallBack + "(x,y);");
                var myFuntion = new Function("x", "y", sFuncion);
                myFuntion(Params, sResult);
            }
        }, 'json').error(function (e) {
            console.log(e);
        }
        );
}

function MethodUploads(Class, Method, Data, Params, EndCallBack) {
    Data.append("class", Class);
    Data.append("method", Method);
    Data.append("params", Params);
    $.ajax({
        url: "../Pages/Connectors/ConnectorUpload.ashx",
        type: "POST",
        data: Data,
        contentType: false,
        processData: false,
        success: function (ans) {
            var sResult = ans.ans;
            if (EndCallBack != undefined) {
                var sFuncion = (EndCallBack + "(x,y);");
                var myFuntion = new Function("x", "y", sFuncion);
                myFuntion(Params, sResult);
            }
        },
        error: function (err) {
            console.log(err);
        }
    });
}

//se agregó porque no podía guardar varios archivos en el programa

function MethodUploadsFiles(Class, Method, Data, Params, EndCallBack) {
    Data.append("class", Class);
    Data.append("method", Method);
    Data.append("params", Params);
    $.ajax({
        url: "../Pages/Connectors/ConnectorFilesFolder.ashx",
        type: "POST",
        data: Data,
        contentType: false,
        processData: false,
        success: function (ans) {
            var sResult = ans.ans;
            if (EndCallBack != undefined) {
                var sFuncion = (EndCallBack + "(x,y);");
                var myFuntion = new Function("x", "y", sFuncion);
                myFuntion(Params, sResult);
            }
        },
        error: function (err) {
            console.log(err);
        }
    });
}