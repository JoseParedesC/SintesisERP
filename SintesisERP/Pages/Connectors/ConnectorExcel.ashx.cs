using FastReport;
using FastReport.Export.Pdf;
using J_W.Estructura;
using J_W.Herramientas;
using SintesisERP.App_Data.Code;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Web;

namespace SintesisERP.Pages.Connectors
{
    public class ConnectorExcel : IHttpHandler, System.Web.SessionState.IReadOnlySessionState
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

                if (!string.IsNullOrEmpty(idreport))
                {
                    string pathfile = createReport(context, idreport, ds_jsonparam, type);
                    context.Response.Clear();
                    context.Response.ContentType = "application/vnd.ms-excel";
                    context.Response.AppendHeader("content-disposition", "attachment; filename=" + Path.GetFileName(pathfile));
                    filePath = System.Web.HttpContext.Current.Server.MapPath(@"~\Informes\Generados\" + Path.GetFileName(pathfile));
                    context.Response.BinaryWrite(File.ReadAllBytes(filePath));
                    if (File.Exists(filePath))
                    {
                        try
                        {
                            File.Delete(filePath);
                        }
                        catch (Exception) { }
                    }
                    context.Response.Flush();
                    context.Response.SuppressContent = true;
                    context.ApplicationInstance.CompleteRequest();
                }
            }
            catch (Exception e)
            {
                context.Response.Write("Error al generar el .xls : " + e.Message);
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
                string nombre = _row.GetString("nombre");
                string procedimiento = _row.GetString("nombreproce");
                string paramadi = _row.GetString("paramadicionales");
                string ds_date = DateTime.Now.ToString("yyyyMMdd_HHmmss");
                nombre += "_" + ds_date;
                string url = context.Request.PhysicalApplicationPath + "Informes/Generados/" + nombre + ".xls";
                if (File.Exists(url))
                {
                    try
                    {
                        File.Delete(url);
                    }
                    catch (Exception) { }
                }
                try
                {
                    db = new Dbase(connString);
                    int countfields = (!paramadi.Equals("") && param.ToString().Equals("")) ? 1 : 0;
                    param += paramadi;
                    string[] vcparam = null;
                    int countpar = 0;
                    if (!param.ToString().Equals(""))
                    {
                        vcparam = param.ToString().Split(';');
                        countpar = vcparam.Count() - countfields;
                    }
                    object[] excelParams = new object[(countpar * 2)];
                    int parameter = 0;
                    if (vcparam != null)
                        foreach (var item in vcparam)
                        {
                            if (!item.Equals(""))
                            {
                                string[] vcpara2 = item.Split('|');
                                excelParams[parameter] = vcpara2[0];
                                excelParams[parameter + 1] = vcpara2[1];
                                parameter += 2;
                            }
                        }

                    Result resultado = db.Procedure(procedimiento, excelParams).RunData();
                    CrearExcel excel = new CrearExcel(url, resultado.Data.Tables[0]);
                    excel.CrearReportExcel();
                    return url;
                }
                catch (Exception e)
                {
                    throw new Exception("Error al generar el reporte... [" + e.Message + "]");
                }
            }
            else
                throw new Exception("Inicie Sesion...");
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