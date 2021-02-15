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
    public class DiasFact : Session_Entity
    {
        private JavaScriptSerializer jsSerialize;
        public DiasFact()
        {
            jsSerialize = new JavaScriptSerializer();
        }

        public object PeriodosList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[Dbo].[ST_PeriodosList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50",
                    dc_params.GetString("filter"), "@countpage:int:output", 0, "@anomes:VARCHAR:10", dc_params.GetString("anomes")).RunData(out outoaram);
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

        public Result DiasFactSave(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].[ST_DiasFactSave]",
            "@anomes:VARCHAR:10", dc_params["anomes"],
            "@fechas:VARCHAR:-1", dc_params["fechas"],
            "@id_user:int", dc_params["userID"]).RunScalar();
        }

        public Result PeriodosState(Dictionary<string, object> dc_params)
        {
            Result res = dbase.Query("SELECT valor FROM Parametros WHERE codigo = 'ANOMESSTAR'", true).RunScalar();
            int anomesstar = Convert.ToInt32(res.Value);
            int anomes = Convert.ToInt32(dc_params.GetString("anomes"));

            if (anomes < anomesstar)
            {
                res.Error = true;
                res.Message = "No puede modificar periodos anteriores al periodo inicial que es " + anomesstar.ToString();
                return res;
            }
            else
                return dbase.Procedure("[Dbo].[ST_DiasPeriodoState]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"], "@anomes:VARCHAR:10", dc_params.GetString("anomes"), "@mod:CHAR:1", dc_params.GetString("mod")).RunRow();
        }

        public Result DiasGetMonth(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].[ST_DiasPeriodoGet]", "@anomes:VARCHAR:10", dc_params.GetString("anomes")).RunRow();
        }

        public object CierreCajaList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[Dbo].[ST_CajasProcesoList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0, "@id_user:int", dc_params["userID"]).RunData(out outoaram);
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

        public Result CierreCajaClose(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].[ST_CajaProcesoCierre]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunRow();
        }
    }
}