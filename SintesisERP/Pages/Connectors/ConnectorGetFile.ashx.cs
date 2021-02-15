using FastReport;
using FastReport.Export.Pdf;
using J_W.Estructura;
using J_W.Herramientas;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Web;

namespace SintesisERP.Pages.Connectors
{
    /// <summary>
    /// Descripción breve de doGetQuote
    /// </summary>
    public class ConnectorGetFile : IHttpHandler, System.Web.SessionState.IReadOnlySessionState
    {
        public string connString = "Sintesis";
        public string sCarpeta = String.Format("{0}TokenString", System.AppDomain.CurrentDomain.BaseDirectory);
        public void ProcessRequest(HttpContext context)
        {

            string filePath = "";
            try
            {
                object userID = null;
                if (context.Session["SesionUserID"] != null)
                    userID = context.Session["SesionUserID"].ToString();

                if (userID != null)
                {
                    string ds_jsonparam = context.Request.QueryString["token"];
                    string op = context.Request.QueryString["op"];

                    if (!string.IsNullOrEmpty(ds_jsonparam))
                    {
                        context.Response.Clear();
                        //context.Response.ContentType = "image/png, jpeg, jpg";
                        op = (string.IsNullOrEmpty(op)) ? "SO" : op;
                        filePath = GetFileToken(context, ds_jsonparam, op);

                        switch (Path.GetExtension(filePath).ToLower())
                        {
                            case ".pdf":
                                context.Response.ContentType = "application/pdf";
                                break;
                            case ".png":
                                context.Response.ContentType = "image/png";
                                break;
                            case ".jpg":
                                context.Response.ContentType = "image/jpg";
                                break;
                        }
                        context.Response.BinaryWrite(File.ReadAllBytes(filePath));

                        context.Response.Flush();
                        context.Response.SuppressContent = true;
                        context.ApplicationInstance.CompleteRequest();
                    }
                }
                else
                {
                    context.Response.Write("Error al generar el pdf : Usuario desconectado.");
                }
            }
            catch (Exception e)
            {
                context.Response.Write("Error al generar el pdf : " + e.Message);
            }
        }

        public string GetFileToken(HttpContext context, object token, object op)
        {
            object userID = null;
            object tokenID = context.Session["SesionStoken"].ToString();
            if (context.Session["SesionUserID"] != null)
                userID = context.Session["SesionUserID"].ToString();
            string ds_name = "";
            if (userID != null)
            {
                Usuario_Entity user = (Usuario_Entity)Serializacion<Usuario_Entity>.GetIndice(sCarpeta, tokenID.ToString());
                Dbase db = new Dbase();
                Dictionary<string, object> _row = db.GetFileToken(token, op).RunRow().Row;
                ds_name = _row.GetString("file");
            }
            else
                throw new Exception("Inicie Sesion...");

            return ds_name;
        }

        private void DatabaseLogin(object sender, DatabaseLoginEventArgs e)
        {
            e.ConnectionString = ConfigurationManager.ConnectionStrings[connString].ConnectionString;
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