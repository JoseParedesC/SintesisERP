using J_W.Estructura;
using J_W.Vinculation;
using SintesisERP.Pages.Connectors;
using System;
using System.Collections.Generic;
using System.Web.Script.Serialization;

namespace SintesisERP.App_Data.Model.Nomina
{
    public class Juzgados : Session_Entity
    {
        // GET: Analisis

        private JavaScriptSerializer jsSerialize;
        public Juzgados()
        {
            jsSerialize = new JavaScriptSerializer();
        }

        public object JuzgadosList(Dictionary<string,object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result data = dbase.Procedure("[NOM].[ST_JuzgadosList]",
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


        public object JuzgadosSaveUpdate(Dictionary<string, object> dc_params)
        {
            Result data = dbase.Procedure("[NOM].[ST_JuzgadosSave]",
                "@id:BIGINT", dc_params["id"],
                "@code:VARCHAR:20", dc_params["code"],
                "@code_externo:VARCHAR:20", dc_params["code_ext"],
                "@detalle:VARCHAR:-1", dc_params["detalle"],
                "@id_user:BIGINT", dc_params["userID"]).RunRow();

            return new { Error = data.Error , Message = data.Message};
        }


        public object JuzgadosDelete(Dictionary<string,object> dc_params)
        {
            Result data = dbase.Procedure("[NOM].[ST_JuzgadosDelete]",
                "@id:BIGINT", dc_params["id"],
                "@id_user:BIGINT", dc_params["userID"]).RunRow();

            return new { Error = data.Error, Message = data.Message };
        }


        public object JuzgadosGet(Dictionary<string, object> dc_params)
        {
            List<Dictionary<string, object>> lista;
            Result data = dbase.Procedure("[NOM].[ST_JuzgadosGet]",
                "@id:BIGINT", dc_params["id"],
                "@id_user:BIGINT", dc_params["userID"]).RunData();

            lista = data.Data.Tables[0].ToList();

            return new { Error = data.Error, Message = data.Message , Row = lista[0]};
        }

        public object JuzgadosState(Dictionary<string, object> dc_params)
        {
            Result data = dbase.Procedure("[NOM].[ST_JuzgadosState]",
                "@id:BIGINT", dc_params["id"],
                "@id_user:BIGINT", dc_params["userID"]).RunRow();

            return new { Error = data.Error, Message = data.Message };
        }
    }
}