using System;
using System.IO;
using J_W.Herramientas;
using J_W.Vinculation;
using Newtonsoft.Json;
using J_W.Estructura;
using System.Collections.Generic;
using SintesisERP.App_Data.Model.Parametrizacion;

namespace SintesisERP.Systems
{
    public partial class Default : Session_Entity
    {
        public General general = new General();
        static string sToken;
        protected void PageLoad()
        {
            try
            {
                if (this.SesionStoken != null)
                {
                    sToken = this.SesionStoken.ToString();
                    string sArchivo = this.sCarpeta + "\\" + sToken + ".indice";
                    if (!IsPostBack)
                    {
                        if (System.IO.File.Exists(sArchivo))
                        {
                            try
                            {
                                File.Delete(sArchivo);
                            }
                            catch (Exception){}
                        }
                        Serializacion<Usuario_Entity>.SetIndice(String.Format("{0}", this.sCarpeta), sToken, JsonConvert.SerializeObject(this.Usuario));
                    }

                    Result a = dbase.Procedure("dbo.ST_Dashboard", "@id_user:int", SUserID).RunRow();
                    if (!a.Error)
                    {
                        this.CargarValIniciales(a.Row);
                    }
                }
                else
                {
                    Response.Redirect("../index.aspx?ms=Usuario no logueado.");
                }
            }
            catch (Exception ex)
            {
                Response.Redirect("../index.aspx?ms=" + ex.Message);
            }
        }

        protected void CargarValIniciales(Dictionary<string, object> data)
        {
            string xml = data.GetString("xml");
            string RUTAXSLT = System.IO.Path.Combine(AppDomain.CurrentDomain.BaseDirectory, @"") + "Pages\\Xslt\\Dashboard.xslt";
            General gen = new General();
            string html = gen.TransformationXSLT(RUTAXSLT, xml);
          

            tblhtml.InnerHtml = html;
        }
    }
}
