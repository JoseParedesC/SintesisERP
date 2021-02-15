using System;
using System.Collections.Generic;
using System.Data;
using J_W.Vinculation;
using SintesisERP.Pages.Connectors;
using System.Web.Script.Serialization;
using J_W.Estructura;
using System.IO;
using SintesisERP.App_Data.Model.FE;
/// <summary>
/// Descripción breve de Buscadores
/// </summary>
/// 
namespace SintesisERP.App_Data.Model.Parametrizacion
{
    public class Empresa : Session_Entity
    {
        private JavaScriptSerializer jsSerialize;
        public Empresa()
        {
            jsSerialize = new JavaScriptSerializer();
        }
        public object EmpresasList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[Dbo].[ST_EmpresasList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0).RunData(out outoaram);
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

        public Result EmpresasSave(Dictionary<string, object> dc_params)
        {
            Result re = dbase.Query("SELECT [dbo].[GETParametrosValor]('FILEFACTURE')", false).RunScalar();
            if (!re.Error)
            {
                string root = re.Value.ToString();
                if (dc_params["id"].Equals("0"))
                {
                    if (!Directory.Exists(root + dc_params["carpeta"]))
                    {
                        Directory.CreateDirectory(root + dc_params["carpeta"]);
                        Directory.CreateDirectory(root + dc_params["carpeta"] + "\\Firmados");
                        Directory.CreateDirectory(root + dc_params["carpeta"] + "\\Pdf");
                    }
                    else
                    {
                        if (!Directory.Exists(root + dc_params["carpeta"] + "\\Firmados"))
                        {
                            Directory.CreateDirectory(root + dc_params["carpeta"] + "\\Firmados");
                        }

                        if (!Directory.Exists(root + dc_params["carpeta"] + "\\Pdf"))
                        {
                            Directory.CreateDirectory(root + dc_params["carpeta"] + "\\Pdf");
                        }
                    }
                }

                re = dbase.Procedure("[Dbo].[ST_EmpresasSave]",
                   "@id:BIGINT", dc_params["id"],
                   "@razon:VARCHAR:200", dc_params["razon"],
                   "@nombrecomercial:VARCHAR:200", dc_params["namecomercial"],
                   "@nit:VARCHAR:200", dc_params["nit"],
                   "@direccion:VARCHAR:200", dc_params["direccion"],
                   "@telefono:VARCHAR:200", dc_params["telefono"],
                   "@ciudad:BIGINT", dc_params["ciudad"],
                   "@email:VARCHAR:200", dc_params["email"],
                   "@urlimg:VARCHAR:200", dc_params["url"],
                   "@urlimgrpt:VARCHAR:200", dc_params["urlfisica"],
                   "@softid:VARCHAR:100", dc_params["softid"],
                   "@softpin:VARCHAR:100", dc_params["softpin"],
                   "@digveri:INT", dc_params["digverificacion"],
                   "@softtecnikey:VARCHAR:200", dc_params["softtecnikey"],
                   "@carpeta:VARCHAR:100", dc_params["carpeta"],
                   "@certificado:VARCHAR:100", dc_params["certificate"],
                   "@clavecer:VARCHAR:100", dc_params["passcertifi"],
                   "@tipoamb:INT", dc_params["ambiente"],
                   "@testid:VARCHAR:100", dc_params["testid"],
                   "@id_tipoid:BIGINT", dc_params["id_tipoid"],
                   "@id_user:int", dc_params["userID"]).RunRow();
            }
            return re;
        }

        public Result EmpresasGet(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].[ST_EmpresasGet]", "@id:BIGINT", dc_params["id"]).RunRow();
        }

        public Result EmpresasConsultarRango(Dictionary<string, object> dc_params)
        {
            Result re = EmpresasGet(dc_params);
            Dictionary<string, object> dicempresa = re.Row;

            if (!re.Error)
            {
                bool AMBIENTE_PRUEBAS = (dicempresa["tipoambiente"].Equals("2")) ? true : false;
                //if (!AMBIENTE_PRUEBAS && !re.Error)
                //{
                //    FacturacionElectro Fac = new FacturacionElectro();
                //    string xml = Fac.FacturaConsultarRangos(re.Row);
                //    re = dbase.Procedure("[dbo].[ST_EmpresasSaveRange]", "@xml:XML", xml, "@id_user:BIGINT", dc_params.GetString("userID")).RunRow();
                //}
            }
            return re;
        }

    }
}