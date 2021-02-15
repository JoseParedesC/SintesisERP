using J_W.Estructura;
using J_W.Vinculation;
using SintesisERP.Pages.Connectors;
using System;
using System.Collections.Generic;
using System.Web.Script.Serialization;

namespace SintesisERP.App_Data.Model.Contabilidad
{
    public class CierreContable : Session_Entity
    {
        private JavaScriptSerializer jsSerialize;

        public CierreContable() {
            jsSerialize = new JavaScriptSerializer();
        }

        public object CierreContableList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[CNT].[CierreContableList]", "@page:int", dc_params.GetString("start"),
                    "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"),
                    "@countpage:int:output", 0, "@id:BIGINT", dc_params.GetString("id_cierre")).RunData(out outoaram);
                if (!result.Error)
                {
                    return jsSerialize.Serialize(new { Data = Props.table2List(result.Data.Tables[0]), totalpage = outoaram["countpage"] });
                }
                else
                {
                    return new { error = 1, errorMesage = "No hay resultado" };
                }
            }
            catch(Exception e)
            {
                return new { error = 1, errorMesage = e.Message };
            }
        }

        public object CierreContableMovList(Dictionary<string, object> dc_params) {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[CNT].[MOVCierreContableList]", "@page:int", dc_params.GetString("start"),
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
            catch (Exception e)
            {
                return new { error = 1, errorMesage = e.Message };
            }
        }

        public Result CierreContableSave(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[CNT].[CierreContable]", "@id_cierre:BIGINT", dc_params.GetString("cierre"),
                "@id_centro:BIGINT", dc_params.GetString("centro"), "@id_cancel", dc_params.GetString("cancel"),
                "@fecha:VARCHAR:10", dc_params.GetString("fecha"),
                "@ano:VARCHAR:6", dc_params.GetString("ano"),
                "@descripcion:VARCHAR:-1", dc_params.GetString("descrip"), "@id_user:BIGINT", dc_params.GetString("userID"),
                "@id:BIGINT", dc_params.GetString("id")).RunScalar();
        }

        public Result CierreContableGet(Dictionary<string, object> dc_params) {
            return dbase.Procedure("[CNT].[CierreContableGet]", 
                "@id:BIGINT", dc_params.GetString("id"), "@id_user:BIGINT", dc_params.GetString("userID")).RunRow();
        }
    }
}