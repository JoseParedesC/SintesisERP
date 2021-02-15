using System;
using System.Collections.Generic;
using System.Data;
using SintesisERP.Pages.Connectors;
using System.Web.Script.Serialization;
using J_W.Estructura;

namespace SintesisERP.App_Data.Model.Contabilidad
{
    public class CNTImpuestotipoimp : J_W.Vinculation.Session_Entity
    {
        private JavaScriptSerializer jsSerialize;
        public CNTImpuestotipoimp()
        {
            jsSerialize = new JavaScriptSerializer();
        }

        public object CNTImpuestotipoimpList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[CNT].[ImpuestosTipoImpuestoList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0, "@idtipoimp:BIGINT", dc_params["id_tipoimp"]).RunData(out outoaram);
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

        public Result CNTImpuestotipoimpSave(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[CNT].TipoImpuestosSave", "@id:BIGINT", dc_params["id"],
            "@codigo:VARCHAR:4", dc_params["codigo"],
            "@nombre:VARCHAR:50", dc_params["nombre"],
            "@id_cuenta:BIGINT", dc_params["id_cuenta"],
            "@id_tipoimp:BIGINT", dc_params["id_tipoimp"],
            "@tarifa:DECIMAL", dc_params["tarifa"], 
            "@opcion:CHAR(1)", dc_params["opcion"],
            "@id_usercreated:BIGINT", dc_params["userID"],
            "@id_userupdated:BIGINT", dc_params["userID"]).RunScalar();
           
            
        }

        public Result CNTImpuestotipoimpState(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[CNT].[ImpuestosTipoImpuestosState]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunScalar();
        }

        public Result CNTImpuestotipoimpDelete(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[CNT].[ImpuestosTipoImpuestosDelete]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunScalar();
        }

        public Result CNTImpuestotipoimpGet(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[CNT].[ImpuestosTipoImpuestosGet]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunRow();
        }
    }
}