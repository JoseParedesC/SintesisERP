using System;
using FastReport;
using FastReport.Export.Pdf;
using System.Web.Configuration;
using System.Xml;
using System.IO;
using FastReport.Data;
using System.Data;
using SintesisERP.App_Data.Model.Parametrizacion;

namespace SintesisERP.App_Data.Code.FE
{

    public class ReporteadorFE
    {

        private General gen = new General();
        public string rutarep { get; set; }
        public string frx { get; set; }

        public ReporteadorFE(string frx){
            this.rutarep = WebConfigurationManager.AppSettings["repbinder"].ToString() + frx;
            this.frx = frx;

        }

        public string CreateReport(string rutapdf, Report rep, string conex) //string fuente, string documento, string cufe, string urlimg, string conex)
        {
            try
            {
                FastReport.Utils.Config.ReportSettings.DatabaseLogin += new DatabaseLoginEventHandler(delegate (object sender, DatabaseLoginEventArgs e) { DatabaseLogin(sender, e, conex); });                
                //rep.Load(this.rutarep);
                rep.Prepare();
                PDFExport pdf = new PDFExport();
                rep.Export(pdf, rutapdf);
                return rutapdf;
            }
            catch (Exception e)
            {
                throw new Exception("Error al generar el reporte... [" + e.Message + "]");
            }
        }

        private void DatabaseLogin(object sender, DatabaseLoginEventArgs e, string conex)
        {
            e.ConnectionString = conex;
        }


        public Report CrearReportXml(string rutaxml, string rutalogo, string rutafirma)
        {
            XmlDocument doc = new XmlDocument();
            byte[] imageArray;
            string base64ImageRepresentation = "";
            FastReport.Utils.RegisteredObjects.AddConnection(typeof(XmlDataConnection));
            string rutaxsl = System.IO.Path.Combine(AppDomain.CurrentDomain.BaseDirectory, @"") + "Pages\\Xslt\\" + "FaturacionXmlPdf.xslt";
            string xmlString = System.IO.File.ReadAllText(rutaxml);
            string xml = gen.TransformationXSLT(rutaxsl, xmlString);
            xml = "<?xml version=\"1.0\" standalone=\"yes\"?>" + xml;
            Report rep = new Report();
            doc.LoadXml(xml);

            if (File.Exists(rutalogo))
            {
                imageArray = System.IO.File.ReadAllBytes(rutalogo);
                base64ImageRepresentation = Convert.ToBase64String(imageArray);

            }
            XmlNode node = doc.CreateNode(XmlNodeType.Element, "Logo", null);
            XmlAttribute _NAME = doc.CreateAttribute("url");
            _NAME.Value = base64ImageRepresentation;
            node.Attributes.Append(_NAME);
            doc.DocumentElement.AppendChild(node);

            base64ImageRepresentation = "";
            if (File.Exists(rutafirma))
            {
                imageArray = System.IO.File.ReadAllBytes(rutafirma);
                base64ImageRepresentation = Convert.ToBase64String(imageArray);
            }
            XmlNode firma = doc.CreateNode(XmlNodeType.Element, "Firma", null);
            XmlAttribute _NAMEF = doc.CreateAttribute("url");
            _NAMEF.Value = base64ImageRepresentation;
            firma.Attributes.Append(_NAMEF);
            doc.DocumentElement.AppendChild(firma);

            XmlNodeReader reader = new XmlNodeReader(doc);
            DataSet ds = new DataSet();
            ds.ReadXml(reader);
            reader.Close();

            rep.Load(this.rutarep);
            foreach (System.Data.DataTable table in ds.Tables)
            {
                rep.RegisterData(table, table.TableName);
            }

            return rep;
        }

    }

}
