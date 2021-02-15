using DynamicClassLoader;
using J_W.Estructura;
using J_W.Herramientas;
using SintesisERP.App_Data.Model.Parametrizacion;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.Script.Serialization;


namespace SintesisERP.Pages.Connectors
{
    /// <summary>
    /// Descripción breve de Connector
    /// </summary>
    public class ConnectorHtml : IHttpHandler, System.Web.SessionState.IReadOnlySessionState
    {
        public string sCarpeta = String.Format("{0}TokenString", System.AppDomain.CurrentDomain.BaseDirectory);
        private DateTime start, stop;
        private JavaScriptSerializer jsSerialize;

        public ConnectorHtml()
        {
            jsSerialize = new JavaScriptSerializer();
        }

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "application/json";
            string className = context.Request.Params["class"];
            string method = context.Request.Params["method"];
            try
            {
                Dictionary<string, object> table = jsSerialize.Deserialize<Dictionary<string, object>>(context.Request.Params["params"]);
                object userID = null, tokenID = null, tokenApp = null;
                if (context.Session["SesionUserID"] != null)
                    userID = context.Session["SesionUserID"].ToString();
                if (userID != null)
                {
                    tokenID = context.Session["SesionStoken"].ToString();
                    tokenApp = context.Session["SesionTokenApp"].ToString();
                    Usuarios users = new Usuarios();
                    Result valid = users.UsuarioValidTokenApp(tokenID, tokenApp.ToString());
                    if (!valid.Error)
                    {
                        Usuario_Entity user = (Usuario_Entity)Serializacion<Usuario_Entity>.GetIndice(sCarpeta, tokenID.ToString());
                        table.Add("userID", userID);
                        table.Add("tokenID", tokenID);
                        table.Add("idcaja", user.codCaja);
                        table.Add("idbodega", user.codBodega);
                        string ds_serealize = jsSerialize.Serialize(table);
                        object[] jparams = { jsSerialize.DeserializeObject(ds_serealize) };
                        start = DateTime.Now;
                        object resp = DynaClassInfo.InvokeMethod(DllPath.AssemblyPath, className, method, jparams);
                        stop = DateTime.Now;
                        context.Response.Write(jsSerialize.Serialize(new { ans = resp, startDate = start, stopTime = stop, timeLoading = stop.Subtract(start).TotalSeconds }));
                    }
                    else
                    {
                        context.Response.Write(jsSerialize.Serialize(new { ans = valid }));
                    }
                }
                else
                {
                    context.Response.Write(jsSerialize.Serialize(new { ans = new Result("Usuario desconectado.", true) }));
                }
            }
            catch (Exception ex)
            {
                context.Response.Write(jsSerialize.Serialize(new { ans = new Result("Error procesando la solicitud " + ex.Message + "; En la clase (" + className + "), Metodo (" + method + ")", true) }));
            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }

    }
}