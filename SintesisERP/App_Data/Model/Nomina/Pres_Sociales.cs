using System;
using System.Collections.Generic;
using System.Data;
using J_W.Estructura;
using J_W.Vinculation;
using SintesisERP.Pages.Connectors;
using System.Web.Script.Serialization;
/// <summary>
/// Descripción breve de Buscadores
/// </summary>
/// 
namespace SintesisERP.App_Data.Model.Nomina
{
    public class Pres_Sociales : Session_Entity
    {
        private JavaScriptSerializer jsSerialize;
        public Pres_Sociales()
        {
            jsSerialize = new JavaScriptSerializer();
        }



        #region
        public object PrestacionesList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result data = dbase.Procedure("[NOM].[ST_PrestacionesList]",
                    "@op:VARCHAR:10", dc_params["op"],
                    "@page:int", dc_params.GetString("start"),
                    "@numpage:int", dc_params.GetString("length"),
                    "@filter:varchar:50", dc_params.GetString("filter"),
                    "@countpage:int:output", 0,
                    "@id_user:BIGINT", dc_params["userID"]).RunData(out outoaram);

                if (!data.Error)
                {
                    return jsSerialize.Serialize(new { Data = Props.table2List(data.Data.Tables[0]), totalpage = outoaram["countpage"] });
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


        public object PrestacionesSave(Dictionary<string, object> dc_params)
        {
            Result data = dbase.Procedure("[NOM].[ST_PrestacionesSave]",
                "@id:BIGINT", dc_params["id"],
                "@codigo:BIGINT", dc_params["codigo"],
                "@nombre:VARCHAR:60", dc_params["nombre"],
                "@contrapartida:BIGINT", dc_params["contrapartida"],
                "@provisiones:NUMERIC", dc_params["provisiones"],
                "@tipo_prestacion:NUMERIC", dc_params["tipo_prestacion"],
                "@id_user:BIGINT", dc_params["userID"]).RunRow();

            return new { Error = data.Error, Message = data.Message };
        }


        public object PrestacionesDelete(Dictionary<string, object> dc_params)
        {
            Result data = dbase.Procedure("[NOM].[ST_PrestacionesDelete]",
                "@id:BIGINT", dc_params["id"],
                "@id_user:BIGINT", dc_params["userID"]).RunRow();

            return new { Error = data.Error, Message = data.Message };
        }


        public object PrestacionesGet(Dictionary<string, object> dc_params)
        {
            List<Dictionary<string, object>> lista;
            Result data = dbase.Procedure("[NOM].[ST_PrestacionesGet]",
                "@id:BIGINT", dc_params["id"],
                "@id_user:BIGINT", dc_params["userID"]).RunData();

            lista = data.Data.Tables[0].ToList();

            return new { Error = data.Error, Message = data.Message, Row = lista[0] };
        }

        #endregion
    }

}