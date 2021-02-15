using J_W.Estructura;
using J_W.Vinculation;
using SintesisERP.Pages.Connectors;
using System;
using System.Collections.Generic;
using System.Web.Script.Serialization;

namespace SintesisERP.App_Data.Model.Parametrizacion
{
    public class Consolidacion : Session_Entity
    {
        private JavaScriptSerializer jsSerialize;

        public Consolidacion()
        {
            jsSerialize = new JavaScriptSerializer();
        }

        public object ConsolidacionList(Dictionary<string, object> dc_params) {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[dbo].[ConciliacionList]", "@page:int", dc_params.GetString("start"),
                    "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"),
                    "@countpage:int:output", 0, "@fecha:VARCHAR:10", dc_params.GetString("fecha"),
                    "@consolidado:INT", dc_params.GetString("consolidado"), "@id_conciliado:BIGINT", dc_params.GetString("id_conciliado")).RunData(out outoaram);
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

        public Result ConsolidacionSave(Dictionary<string, object> dc_params) {
            return dbase.Procedure("[CNT].[MOVConciliacion]",
                                    "@xml:XML", dc_params.GetString("xml"),
                                    "@id_conciliado:BIGINT", dc_params.GetString("id_conciliado"),
                                    "@id_user:BIGINT",dc_params.GetString("userID")).RunScalar();            
        }

        public Result ConsolidacionGet(Dictionary<string, object> dc_params) {
            Result data = dbase.Procedure("[CNT].[MOVConciliacionGet]","@id_user:BIGINT", dc_params.GetString("userID"),
                "@id_conciliado:BIGINT", dc_params.GetString("id_conciliado")).RunRow();
            return data;
        }

        public Result ConsolidacionCount(Dictionary<string, object> dc_params) {
            return dbase.Procedure("[CNT].[MOVConciliacionesCount]", "@id_user:BIGINT", dc_params.GetString("userID")).RunRow();
        }

        public object ConsolidacionMovList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[CNT].[MOVConciliacionList]", "@page:int", dc_params.GetString("start"),
                    "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"),
                    "@countpage:int:output", 0).RunData(out outoaram);
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
    }
}