using DynamicClassLoader;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Script.Serialization;
using System.Globalization;
using System.IO;
using J_W.Estructura;
using J_W.Herramientas;
using System.Web.Configuration;

namespace SintesisERP.Pages.Connectors
{
    /// <summary>
    /// Descripción breve de RFileUpload
    /// </summary>
    public class ConnectorFilesFolder : IHttpHandler, System.Web.SessionState.IReadOnlySessionState
    {
        public string sCarpeta = String.Format("{0}TokenString", System.AppDomain.CurrentDomain.BaseDirectory);
        private DateTime start, stop;
        private JavaScriptSerializer jsSerialize;
        public ConnectorFilesFolder()
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
                Dbase db = new Dbase();
                Result path = db.Query("SELECT dbo.ST_FnGetValueParam('URLSAVEFILE') valor;", true).RunScalar();
                string tPath = path.Value.ToString();// context.Server.MapPath("~/" + "Creditos");
                HttpFileCollection files = context.Request.Files;

                object userID = null, tokenID = null;
                if (context.Session["SesionUserID"] != null)
                    userID = context.Session["SesionUserID"].ToString();
                if (userID != null)
                {
                    string xml = UploadFiles(context, files, tPath, table);
                    tokenID = context.Session["SesionStoken"].ToString();
                    Usuario_Entity user = (Usuario_Entity)Serializacion<Usuario_Entity>.GetIndice(sCarpeta, tokenID.ToString());
                    table.Add("userID", userID);
                    table.Add("xml", xml);
                    table.Add("idempresa", user.IdEmpresa);
                    table.Add("idestacion", user.IdEstacion);
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

        public string UploadFiles(HttpContext context, HttpFileCollection files, string ruta, Dictionary<string, object> table)
        {
            string rutcli = WebConfigurationManager.AppSettings["rutacreditos"].ToString()+ table.GetString("iden");
            string rutcre = rutcli + "\\CR" + table.GetString("numcredito");
            string ds_urlname = "";
            string xml = "";
            HttpPostedFile file = null;
            if (!Directory.Exists(rutcli))
            {
                Directory.CreateDirectory(rutcli);
            }

            if (!Directory.Exists(rutcre))
            {
                Directory.CreateDirectory(rutcre);
            }

            try
            {
                if (files.Count > 0)
                {
                    for (int i = 0; i < files.Count; ++i)
                    {
                        file = files[i];

                        if(!table.GetString("fileDate").Equals("") && file.FileName.ToUpper() != "FOTOPERFIL_SINTESIS.PNG")
                            ds_urlname = rutcre + "/" + DateTime.Now.ToString("yyyyMMdd_HHmmss") + "_"+ file.FileName;
                        else
                            ds_urlname = rutcli + "/" + file.FileName;

                        if (File.Exists(ds_urlname))
                            File.Delete(ds_urlname);

                        file.SaveAs(ds_urlname);
                        xml += "<item serverurl=\"" + ds_urlname + "\" relatiurl=\"" + ds_urlname + "\" name=\"" + file.FileName + "\" />";
                    }
                }

            }
            catch (Exception ex)
            {
                throw new Exception("Error al subir los archivos" + ex.Message);
            }

            return xml;

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