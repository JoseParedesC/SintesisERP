using DynamicClassLoader;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Script.Serialization;
using System.Globalization;
using System.IO;
using J_W.Estructura;

namespace SintesisERP.Pages.Connectors
{
    /// <summary>
    /// Descripción breve de RFileUpload
    /// </summary>
    public class ConnectorUpload : IHttpHandler, System.Web.SessionState.IReadOnlySessionState
    {
        private DateTime start, stop;
        private JavaScriptSerializer jsSerialize;
        public ConnectorUpload()
        {
            jsSerialize = new JavaScriptSerializer();
        }

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "application/json";
            string className = context.Request.Params["class"];
            string method = context.Request.Params["method"];
            HttpPostedFile file = null;
            try
            {
                Dictionary<string, object> table = jsSerialize.Deserialize<Dictionary<string, object>>(context.Request.Params["params"]);
                string ds_folder = (String.IsNullOrEmpty(context.Request.Params["folder"])) ? "" : context.Request.Params["folder"];
                string tPath = "~/" + ds_folder + "/";
                string ds_urlname = "", urlrelative = "";
                HttpFileCollection files = context.Request.Files;

                try
                {
                    if (files.Count > 0)
                    {
                        for (int i = 0; i < files.Count; ++i)
                        {
                            file = files[i];
                            ds_urlname = context.Server.MapPath(tPath + file.FileName);
                            urlrelative = "../" + ds_folder + "/" + file.FileName;
                            if (!File.Exists(ds_urlname))
                                file.SaveAs(ds_urlname);
                        }
                    }
                }
                catch (Exception ex)
                {
                    throw new Exception("Error al subir los archivos" + ex.Message);
                }
                object userID = null;
                if (context.Session["SesionUserID"] != null)
                    userID = context.Session["SesionUserID"].ToString();
                if (userID != null)
                {
                    table.Add("userID", userID);
                    table.Add("url", urlrelative);
                    table.Add("urlfisica", ds_urlname);
                    string ds_serealize = jsSerialize.Serialize(table);
                    object[] jparams = { jsSerialize.DeserializeObject(ds_serealize) };
                    start = DateTime.Now;
                    object resp = DynaClassInfo.InvokeMethod(DllPath.AssemblyPath, className, method, jparams);
                    stop = DateTime.Now;
                    context.Response.Write(jsSerialize.Serialize(new { ans = resp, startDate = start, stopTime = stop, timeLoading = stop.Subtract(start).TotalSeconds }));
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