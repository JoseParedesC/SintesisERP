using System;
using System.Collections.Generic;
using System.Data;
using SintesisERP.Pages.Connectors;
using System.Web.Script.Serialization;
using J_W.Estructura;

namespace SintesisERP.App_Data.Model.Parametrizacion
{
    public class Turno : J_W.Vinculation.Session_Entity
    {
        private JavaScriptSerializer jsSerialize;
        public Turno()
        {
            jsSerialize = new JavaScriptSerializer();
        }

        public object TurnosList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[Dbo].[ST_TurnosList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0).RunData(out outoaram);
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

        public Result TurnosSave(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[dbo].ST_TurnosSave", "@id:BIGINT", dc_params["id"],
            "@horainicio:VARCHAR:5", dc_params["horainicio"],
            "@horafin:VARCHAR:5", dc_params["horafin"],
            "@id_user:int", dc_params["userID"]).RunRow();
        }

        public Result TurnosState(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[dbo].[ST_TurnosState]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunRow();
        }

        public Result TurnosDelete(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[dbo].[ST_TurnosDelete]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunRow();
        }

        public Result TurnosGet(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[dbo].[ST_TurnosGet]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunRow();
        }
    }
}