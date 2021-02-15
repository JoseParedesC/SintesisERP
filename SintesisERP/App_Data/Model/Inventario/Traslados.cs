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
namespace SintesisERP.App_Data.Model.Inventario
{
    public class Traslados : Session_Entity
    {
        private JavaScriptSerializer jsSerialize;
        public Traslados()
        {
            jsSerialize = new JavaScriptSerializer();
        }
        public object TrasladosList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[Dbo].[ST_MovTrasladosList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0).RunData(out outoaram);
                if (!result.Error)
                {
                    return jsSerialize.Serialize(new { Data = result.Data.Tables[0].ToList(), totalpage = outoaram["countpage"] });
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

        public Result TrasladoGetConsecutivo(Dictionary<string, object> dc_params)
        {
            return dbase.Query("SELECT CONVERT(VARCHAR(255), NEWID()) AS idToken;", true).RunScalar();
        }

        public Result TrasladosGet(Dictionary<string, object> dc_params)
        {
            Result data = dbase.Procedure("[Dbo].ST_MovTrasladoGet", "@id:int", dc_params.GetString("id")).RunData();
            if(data.Data.Tables[0].Rows.Count > 0)
                data.Row = data.Data.Tables[0].Rows[0].ToDictionary();
            data.Table = data.Data.Tables[1].ToList();
            data.Data = null;
            return data;
        }
                
        public Result TrasladosAddArticulo(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].ST_MovTrasladoAddArticulo",           
            "@id_articulo:INT", dc_params["id_article"],
            "@serie:VARCHAR:255", dc_params["serie"],
            "@id_lote:BIGINT", dc_params["id_lote"],
            "@id_bodega:INT", dc_params["id_wineri"],
            "@id_bodegades:INT", dc_params["id_winerides"],
            "@cantidad:NUMERIC", dc_params["quantity"],
            "@idToken:VARCHAR:255", dc_params["idToken"],
            "@id_user:int", dc_params["userID"]).RunRow();            
        }
        public Result TrasladosDelArticulo(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].ST_MovTrasladoDelArticulo",
            "@id_articulo:INT", dc_params["id_articulo"],
            "@idtoken:VARCHAR:255", dc_params["idToken"]).RunRow();
        }

        public Result FacturarTraslado(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].ST_MOVFacturarTraslado",
            "@id_tipodoc:BIGINT", dc_params["id_tipodoc"],
            "@id_centrocostos:BIGINT", dc_params["id_centrocostos"],           
            "@fechadoc:VARCHAR:10", dc_params["Fecha"],
            "@idToken:VARCHAR:255", dc_params["idToken"],
            "@descripcion:VARCHAR:500", dc_params["descripcion"],
            "@id_user:INT", dc_params["userID"]
            ).RunRow();
        }

        public Result RevertirTraslado(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].[ST_MOVRevertirTraslado]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunRow();
        }
        
    }
}