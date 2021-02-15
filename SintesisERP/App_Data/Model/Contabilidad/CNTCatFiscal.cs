using System;
using System.Collections.Generic;
using System.Data;
using SintesisERP.Pages.Connectors;
using System.Web.Script.Serialization;
using J_W.Estructura;

namespace SintesisERP.App_Data.Model.Contabilidad
{
    public class CNTCatFiscal : J_W.Vinculation.Session_Entity
    {
        private JavaScriptSerializer jsSerialize;
        public CNTCatFiscal()
        {
            jsSerialize = new JavaScriptSerializer();
        }

        public object CNTCatFiscalList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[Dbo].[ST_CNTCategoriaFiscalList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0).RunData(out outoaram);
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

        public Result CNTCatFiscalSave(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].ST_CNTCategoriaFiscalSave",
            "@id:BIGINT", dc_params["id"],
            "@codigo:VARCHAR:10", dc_params.GetString("codigo"),
            "@descripcion:VARCHAR:100", dc_params.GetString("descripcion"),
            "@id_retefuente:BIGINT", dc_params.GetString("id_retefuente").Equals("") ? null : dc_params.GetString("id_retefuente"),
            "@id_reteiva:BIGINT", dc_params.GetString("id_reteiva").Equals("") ? null : dc_params.GetString("id_reteiva"),
            "@id_reteica:BIGINT", dc_params.GetString("id_reteica").Equals("") ? null : dc_params.GetString("id_reteica"),
            "@fuentebase:numeri", dc_params.GetString("fuentebase"),
            "@ivabase:numeri", dc_params.GetString("ivabase"),
            "@icabase:numeri", dc_params.GetString("icabase"),
            "@retiene:bit", dc_params["retiene"],
            "@id_user:int", dc_params["userID"]).RunScalar();
        }

        public Result CNTCatFiscalState(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].[ST_CNTCategoriaFiscalState]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunScalar();
        }

        public Result CNTCatFiscalDelete(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].[ST_CNTCategoriaFiscalDelete]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunScalar();
        }

        public Result CNTCatFiscalGet(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].[ST_CNTCategoriaFiscalGet]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunRow();
        }

        /* Metodos de Categoria fiscal para servicios*/

        public object CNTCatFiscalServicioList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[Dbo].[ST_CNTCategoriaFiscalServicioList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0).RunData(out outoaram);
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
        public Result CNTCatFiscalServicioSave(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].ST_CNTCategoriaFiscalServicioSave",
            "@id:BIGINT", dc_params["id"],
            "@id_servicio:BIGINT", dc_params.GetString("id_servicio"),
            "@id_retefuente:BIGINT", dc_params.GetString("id_retefuente").Equals("") ? null : dc_params.GetString("id_retefuente"),
            "@id_reteiva:BIGINT", dc_params.GetString("id_reteiva").Equals("") ? null : dc_params.GetString("id_reteiva"),
            "@id_reteica:BIGINT", dc_params.GetString("id_reteica").Equals("") ? null : dc_params.GetString("id_reteica"),
            "@fuentebase:numeri", dc_params.GetString("fuentebase"),
            "@ivabase:numeri", dc_params.GetString("ivabase"),
            "@icabase:numeri", dc_params.GetString("icabase"),
            "@id_user:int", dc_params["userID"]).RunScalar();
        }
        public Result CNTCatFiscalServicioState(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].[ST_CNTCategoriaFiscalServicioState]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunScalar();
        }

        public Result CNTCatFiscalServicioDelete(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].[ST_CNTCategoriaFiscalServicioDelete]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunScalar();
        }

        public Result CNTCatFiscalServicioGet(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].[ST_CNTCategoriaFiscalServicioGet]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunRow();
        }
    }
}