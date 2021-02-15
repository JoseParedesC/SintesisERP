using System.Collections.Generic;
using System.Data;
using J_W.Estructura;
using J_W.Vinculation;
using System.Web.Script.Serialization;
using System;
using SintesisERP.Pages.Connectors;
using System.Net.Mail;
using System.Text;
using System.Security.Cryptography;
using System.IO;
using System.Web;
using System.Xml;
using System.Xml.Xsl;
using System.Runtime.Remoting.Messaging;
using FacturacionIndividual.App_Data.Code;
using System.Web.Configuration;

namespace SintesisERP.App_Data.Model.Parametrizacion
{
    public class General : Session_Entity
    {
        private JavaScriptSerializer jsSerialize;
        public General()
        {
            jsSerialize = new JavaScriptSerializer();
        }

        public object SP_SearchGeneral(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[Dbo].[SP_GeneralSearch]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0).RunData(out outoaram);
                if (!result.Error)
                {
                    return jsSerialize.Serialize(new { Data = Props.table2List(result.Data.Tables[0]), totalpage = outoaram["countpage"] });
                }
                else
                {
                    return new { error = 1, errorMesage = "No hay resultado" };
                }
            }
            catch (Exception ex)
            {
                return new { error = 1, errorMesage = ex.Message };
            }
        }

        public Result GetConsecutivo(Dictionary<string, object> dc_params)
        {
            return dbase.Query("SELECT CONVERT(VARCHAR(255), NEWID()) AS idToken;", true).RunScalar();
        }


        public Result LoadSelect(Dictionary<string, object> dc_params)
        {
            Result data = dbase.FW_LoadSelector(dc_params.GetString("code"), dc_params["userID"], id_otro: dc_params.GetString("id")).RunData();
            data.Table = data.Data.Tables[0].ToList();
            data.Data = null;
            return data;
        }

        public object GetValueParam(string codigo)
        {
            Result data = dbase.Query("SELECT dbo.ST_FnGetValueParam('" + codigo + "') valor;", true).RunScalar();
            return data.Value;
        }

        public Result FacturacionSendSave(object errorsend, object sendmmessage, object errormail, object mailmessage, object id_documento)
        {
            return dbase.Procedure("ST_FacturacionSeguimientoSave", "@errorsend:bit", errorsend, "@messagesend:varchar:-1", sendmmessage, "@errormail:int", errormail, "@messagemail:varchar:-1", mailmessage, "@id_documento:bigint", id_documento).RunRow();
        }

        public string ConvertHex(int num)
        {
            return String.Format("{0:X}", num);
        }

        /// <summary>
        /// Metodo para convertir una cadena en hash
        /// </summary>
        /// <param name="code"></param>
        /// <param name="op"></param>
        /// <returns></returns>
        public string ConvertHash(string code, int op)
        {
            byte[] bytes = Encoding.UTF8.GetBytes(code);
            byte[] hashBytes = null;
            switch (op)
            {
                case 1:
                    SHA1 sha1 = SHA1.Create();
                    hashBytes = sha1.ComputeHash(bytes);
                    break;
                case 2:
                    SHA256 sha2 = SHA256.Create();
                    hashBytes = sha2.ComputeHash(bytes);
                    break;
                case 3:
                    SHA384 sha3 = SHA384.Create();
                    hashBytes = sha3.ComputeHash(bytes);
                    break;
            }

            return HexStringFromBytes(hashBytes);
        }

        /// <summary>
        /// Metodo de convertor una cadena en hexadecimal
        /// </summary>
        /// <param name="bytes"></param>
        /// <returns></returns>
        public string HexStringFromBytes(byte[] bytes)
        {
            StringBuilder sb = new StringBuilder();
            foreach (byte b in bytes)
            {
                var hex = b.ToString("x2");
                sb.Append(hex);
            }
            return sb.ToString();
        }

        /// <summary>
        /// Metodo de compresion del xml de la FE
        /// </summary>
        /// <param name="ruta"></param>
        /// <param name="file"></param>
        public void ComprimirFile(string ruta, string rutasave, string name)
        {
            try
            {
                string[] vpathfiles = ruta.Split('|');
                Ionic.Zip.ZipFile zip = new Ionic.Zip.ZipFile();
                foreach (var item in vpathfiles)
                {
                    if (!item.Equals(""))
                    {
                        zip.AddFile(item, "");
                    }
                }
                zip.Save(rutasave + name + ".zip");
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        /// <summary>
        /// Metodo de Transformacion de xsl con el xml para asi generar el de la FE
        /// </summary>
        /// <param name="_PathXLST"></param>
        /// <param name="XmlData"></param>
        /// <returns></returns>
        public string TransformationXSLT(string _PathXLST, string XmlData)
        {
            StringWriter html = new StringWriter();
            string PathXLST = _PathXLST;
            if (!File.Exists(PathXLST))
            {
                PathXLST = HttpContext.Current.Server.MapPath(string.Format("../layout/xsl/{0}.xslt", _PathXLST));
            }
            // carga XML       
            XmlDocument xml = new XmlDocument();
            try
            {
                xml.LoadXml(XmlData);
            }
            catch (XsltException ex)
            {
                throw new Exception(XsltParseError(ex));
            }
            XslCompiledTransform xsl = new XslCompiledTransform();
            XsltSettings xsltSettings = new XsltSettings(true, false);
            XsltArgumentList args = new XsltArgumentList();

            try
            {
                xsl.Load(PathXLST, xsltSettings, new XmlUrlResolver());
            }
            catch (XsltException ex)
            {
                throw new Exception(XsltParseError(ex));
            }

            try
            {
                xsl.Transform(xml, args, html);
            }
            catch (XsltException ex)
            {
                throw new Exception(XsltParseError(ex));
            }
            return html.ToString();
        }

        /// <summary>
        /// Metodo que da formato de error al parseo del xslt con el xml
        /// </summary>
        /// <param name="ex"></param>
        /// <returns></returns>
        private string XsltParseError(XsltException ex)
        {
            string msg = ex.Message;
            if (msg.Contains("InnerException")) msg += string.Format("\n[InnerException] {1}\n", ex.InnerException.Message);

            return string.Format("Ln {0}, Col {1}: [XsltException] {2}\n{3}\n", ex.LineNumber, ex.LinePosition, msg, ex.SourceUri);
        }

        /// <summary>
        /// Metodo que extrae una cadena entre dos cdenas
        /// </summary>
        /// <param name="str"></param>
        /// <param name="delimiator1"></param>
        /// <param name="delimiator2"></param>
        /// <returns></returns>
        public string STEXTRACT(string str, string delimiator1, string delimiator2)
        {
            string s = str;
            string startToken = delimiator1;
            string endToken = delimiator2;
            int startTokenPosition = s.IndexOf(startToken);
            int endTokenPosition = s.IndexOf(endToken);
            string mysubstring = "";
            if (endTokenPosition >= 0)
                mysubstring = s.Substring(startTokenPosition + startToken.Length, endTokenPosition - startTokenPosition - startToken.Length);
            else
                mysubstring = "";
            return mysubstring;
        }

        /// <summary>
        /// Metodo para convertir en base 64 el comprimido de la FE
        /// </summary>
        /// <param name="cruta"></param>
        /// <param name="cNameFile"></param>
        /// <param name="cExtFile"></param>
        /// <returns></returns>
        public string retornaBytes(string cruta, string cNameFile, string cExtFile)
        {
            // Dim _nombrearchivose As String = "face_f0830116777003a699d07_firmado"
            byte[] byteArray = File.ReadAllBytes(cruta + cNameFile + cExtFile);
            // verificar que exista archivo, de lo contrario retornar un dato que indique que no hay datos
            return Convert.ToBase64String(byteArray);
        }

        public bool EmpresaCrearXmlPdf(string xml, string folder, string cufe)
        {
            XmlDocument xmldoc;
            string xmlGen = "", rutapdf = WebConfigurationManager.AppSettings["texterror"].ToString() + folder + "\\";

            try
            {
                xmlGen = "<?xml version=\"1.0\" standalone=\"yes\"?><NWindDataSet>" + xml + "</NWindDataSet>";

                xmldoc = new XmlDocument();
                xmldoc.LoadXml(xmlGen);
                if (File.Exists(rutapdf + "XmlPdf\\" + cufe + ".xml"))
                    File.Delete(rutapdf + "XmlPdf\\" + cufe + ".xml");

                xmldoc.Save(rutapdf + "pdf\\" + cufe + ".xml");
            }
            catch (Exception)
            {
            }
            return true;
        }

    }
}