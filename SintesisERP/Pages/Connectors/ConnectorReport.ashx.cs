using FastReport;
using FastReport.Export.Pdf;
using J_W.Estructura;
using J_W.Herramientas;
using SintesisERP.App_Data.Code.FE;
using SintesisERP.App_Data.Model.Parametrizacion;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Configuration;

namespace SintesisERP.Pages.Connectors
{
    /// <summary>
    /// Descripción breve de doGetQuote
    /// </summary>
    public class ConnectorReport : IHttpHandler, System.Web.SessionState.IReadOnlySessionState
    {
        public string connString = "Sintesis";
        public string sCarpeta = String.Format("{0}TokenString", System.AppDomain.CurrentDomain.BaseDirectory);
        public void ProcessRequest(HttpContext context)
        {
            string filePath = "";
            try
            {
                string ds_jsonparam = context.Request.QueryString["params"];
                string idreport = context.Request.QueryString["idreport"];
                string type = context.Request.QueryString["type"];
                string op = context.Request.QueryString["op"];

                if (!string.IsNullOrEmpty(idreport))
                {
                    string pathfile = createReport(context, idreport, ds_jsonparam, type);
                    if (!string.IsNullOrEmpty(op) && op.ToString().Equals("zip"))
                    {
                        pathfile = CreateZip(context, ds_jsonparam, pathfile);
                        context.Response.Clear();
                        context.Response.ContentType = "application/x-zip-compressed";
                    }
                    else
                    {
                        context.Response.Clear();
                        context.Response.ContentType = "application/pdf";
                    }

                    string[] vcparam = pathfile.Split('|');
                    pathfile = vcparam[0];
                    filePath = System.Web.HttpContext.Current.Server.MapPath(@"~\Informes\Generados\" + Path.GetFileName(pathfile));
                    context.Response.BinaryWrite(File.ReadAllBytes(filePath));

                    foreach (var item in vcparam)
                    {
                        if (File.Exists(item))
                        {
                            try
                            {
                                File.Delete(item);
                            }
                            catch (Exception) { }
                        }
                    }
                    context.Response.Flush();
                    context.Response.SuppressContent = true;
                    context.ApplicationInstance.CompleteRequest();
                }
            }
            catch (Exception e)
            {
                context.Response.Write("Error al generar el pdf : " + e.Message);
            }
        }

        public string createReport(HttpContext context, object idreport, object param, object type)
        {
            object userID = null;
            object tokenID = context.Session["SesionStoken"].ToString();
            if (context.Session["SesionUserID"] != null)
                userID = context.Session["SesionUserID"].ToString();
            if (userID != null)
            {
                Usuario_Entity user = (Usuario_Entity)Serializacion<Usuario_Entity>.GetIndice(sCarpeta, tokenID.ToString());
                Dbase db = new Dbase();
                Dictionary<string, object> _row = db.GetReport(idreport, userID, type).RunRow().Row;
                string ds_name = _row.GetString("nombre");
                string ds_rpt = _row.GetString("frx");
                string ds_date = DateTime.Now.ToString("yyyyMMdd_HHmmss");
                ds_name += "_" + ds_date;
                string cufe = "";
                string[] vcparam = param.ToString().Split(';');
                if (_row.GetString("tipo").Equals("XML"))
                {
                    foreach (var item in vcparam)
                    {
                        if (!item.Equals(""))
                        {
                            string[] vcpara2 = item.Split('|');
                            if (vcpara2[0].ToUpper().Equals("CUFE"))
                                cufe = vcpara2[1];
                            break;
                        }
                    }
                }

                ds_name = (!cufe.Equals("")) ? cufe : ds_name;

                if (File.Exists(context.Request.PhysicalApplicationPath + "Informes/Generados/" + ds_name + ".pdf"))
                {
                    try
                    {
                        File.Delete(context.Request.PhysicalApplicationPath + "Informes/Generados/" + ds_name + ".pdf");
                    }
                    catch (Exception) { }
                }

                try
                {
                    var path = context.Request.PhysicalApplicationPath + "Informes\\Generados\\" + ds_name + ".pdf";

                    if (_row.GetString("tipo").Equals("XML"))
                    {
                        ReporteadorFE repor = new ReporteadorFE(ds_rpt);
                        string rutaxml = WebConfigurationManager.AppSettings["texterror"].ToString() + _row.GetString("folder") + "pdf\\" + cufe + ".xml";
                        Report rep = repor.CrearReportXml(rutaxml, _row.GetString("urlimg"), _row.GetString("urlfirma"));

                        rep.Prepare(true);
                        PDFExport pdf = new PDFExport();

                        rep.Export(pdf, path);
                    }
                    else
                    {
                        FastReport.Utils.Config.ReportSettings.DatabaseLogin += new DatabaseLoginEventHandler(DatabaseLogin);
                        Report rep = new Report();
                        rep.Load(context.Request.PhysicalApplicationPath + "Informes/" + ds_rpt);
                        foreach (var item in vcparam)
                        {
                            if (!item.Equals(""))
                            {
                                string[] vcpara2 = item.Split('|');
                                rep.SetParameterValue(vcpara2[0], vcpara2[1]);
                            }
                        }
                        rep.SetParameterValue("id_caja", user.codCaja);
                        rep.SetParameterValue("id_user", userID);
                        rep.Prepare();
                        PDFExport pdf = new PDFExport();
                        rep.Export(pdf, path);
                    }
                    return path;
                }
                catch (Exception e)
                {
                    throw new Exception("Error al generar el reporte... [" + e.Message + "]");
                }
            }
            else
                throw new Exception("Inicie Sesion...");
        }

        public string CreateZip(HttpContext context, string data, string pathpdf)
        {
            Dbase db = new Dbase();
            Dictionary<string, object> _row = db.Procedure("[dbo].ST_EmpresasGet", "@id:BIGINT", 0).RunRow().Row;
            string[] vcparam = data.Split(';');

            string cufe = "";
            foreach (var item in vcparam)
            {
                if (!item.Equals(""))
                {
                    string[] vcpara2 = item.Split('|');
                    if (vcpara2[0].ToUpper().Equals("CUFE"))
                        cufe = vcpara2[1];
                }
            }

            string rutasave = context.Request.PhysicalApplicationPath + "Informes/Generados/";
            string file = pathpdf + "|" + _row.GetString("folder") + "\\XmlDian\\" + cufe + ".xml";
            if (File.Exists(rutasave + cufe + "zip"))
            {
                try
                {
                    File.Delete(cufe + "zip");
                }
                catch (Exception) { }
            }

            try
            {
                General G = new General();
                G.ComprimirFile(file, rutasave, cufe);
                return rutasave + cufe + ".zip" + "|" + pathpdf;
            }
            catch (Exception e)
            {
                throw new Exception("Error al generar el comprimido... [" + e.Message + "]");
            }
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