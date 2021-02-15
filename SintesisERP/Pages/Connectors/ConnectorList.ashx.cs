using DynamicClassLoader;
using J_W.Estructura;
using J_W.Herramientas;
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
    /// Descripción breve de ConnectorList
    /// </summary>
    public class ConnectorList : IHttpHandler, System.Web.SessionState.IReadOnlySessionState
    {
        public string sCarpeta = String.Format("{0}TokenString", System.AppDomain.CurrentDomain.BaseDirectory);
        private DateTime start, stop;
        private JavaScriptSerializer jsSerialize;

        public ConnectorList()
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
                if (table == null)
                    table = new Dictionary<string, object>();
                object userID = null, tokenID = null;
                if (context.Session["SesionUserID"] != null)
                    userID = context.Session["SesionUserID"].ToString();
                if (userID != null)
                {
                    tokenID = context.Session["SesionStoken"].ToString();
                    Usuario_Entity user = (Usuario_Entity)Serializacion<Usuario_Entity>.GetIndice(sCarpeta, tokenID.ToString());
                    string page = context.Request.Params["page"];
                    string quantity = context.Request.Params["quantity"];
                    string filter = context.Request.Params["search"];
                    string column = context.Request.Params["column"];
                    string sort = context.Request.Params["sort"];
                    table.Add("userID", userID);
                    table.Add("length", quantity);
                    table.Add("start", page);
                    table.Add("filter", filter);
                    table.Add("column", column);
                    table.Add("idcaja", user.codCaja);
                    table.Add("sort", sort);
                    string ds_serealize = jsSerialize.Serialize(table);
                    object[] jparams = { jsSerialize.DeserializeObject(ds_serealize) };
                    start = DateTime.Now;
                    object resp = DynaClassInfo.InvokeMethod(DllPath.AssemblyPath, className, method, jparams);
                    Dictionary<string, object> Result = jsSerialize.Deserialize<Dictionary<string, object>>(resp.ToString());
                    stop = DateTime.Now;
                    context.Response.Write(jsSerialize.Serialize(new { current = page, rowCount = quantity, total = Result["totalpage"], rows = Result["Data"] }));
                }
                else
                {
                    context.Response.Write(jsSerialize.Serialize(
                        new
                        {
                            err = "usuario desconectado.",
                            metodo = method,
                            clase = className
                        }));

                }
            }
            catch (Exception ex)
            {
                context.Response.Write(jsSerialize.Serialize(
                    new
                    {
                        err = "Error procesando la solicitud " + ex.Message,
                        metodo = method,
                        clase = className
                    }));
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
