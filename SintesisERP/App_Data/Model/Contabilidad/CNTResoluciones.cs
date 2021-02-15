using System;
using System.Collections.Generic;
using System.Data;
using J_W.Vinculation;
using SintesisERP.Pages.Connectors;
using System.Web.Script.Serialization;
using J_W.Estructura;
/// <summary>
/// Descripción breve de Buscadores
/// </summary>
/// 
namespace SintesisERP.App_Data.Model.Contabilidad
{
    public class CNTResoluciones : Session_Entity
    {
        private JavaScriptSerializer jsSerialize;
        public CNTResoluciones()
        {
            jsSerialize = new JavaScriptSerializer();
        }

        public object CNTResolucionesList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[Dbo].[ST_CNTResolucionesList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0).RunData(out outoaram);
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


        public Result CNTResolucionesSave(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].[ST_CNTResolucionesSave]",
            "@id:BIGINT", dc_params["id"],
            "@id_centrocosto:BIGINT", dc_params["centrocosto"],
            "@codigo:VARCHAR:50", dc_params["codigo"],
            "@fechainicio:VARCHAR:10", dc_params["fechainicio"].ToString().Replace("-", ""),
            "@fechafin:VARCHAR:10", dc_params["fechafin"].ToString().Replace("-", ""),
            "@prefijo:VARCHAR:20", dc_params["prefijo"],
            "@conini:INT", dc_params["ini"],
            "@confin:INT", dc_params["fin"],
            "@confac:INT", dc_params["factura"],
            "@leyenda:VARCHAR:-1", dc_params["leyenda"],
            "@isfe:BIT", dc_params["isfe"],
            "@id_user:int", dc_params["userID"]).RunScalar();
        }


        public Result CNTResolucionesState(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].[ST_CNTResolucionesState]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunScalar();
        }

        public Result CNTResolucionesDelete(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].[ST_CNTResolucionesDelete]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunScalar();
        }

        public Result CNTResolucionesGet(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].[ST_CNTResolucionesGet]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunRow();
        }
    }
}