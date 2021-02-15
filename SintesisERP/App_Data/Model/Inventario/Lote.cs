using System;
using System.Collections.Generic;
using System.Data;
using SintesisERP.Pages.Connectors;
using System.Web.Script.Serialization;
using J_W.Estructura;

namespace SintesisERP.App_Data.Model.Inventario
{
    public class Lote : J_W.Vinculation.Session_Entity
    {
        private JavaScriptSerializer jsSerialize;
        public Lote()
        {
            jsSerialize = new JavaScriptSerializer();
        }
        /// <summary>
        /// Metodo Cargar Lotes de Productos
        /// Este metodo es utilizado para recibir el filtro de busqueda y conectarse a la BD 
        /// Lotes de Productos  
        /// </summary>
        /// <returns> 
        /// La lista de Lotes de Productos encontrados
        /// </returns>
        public object LotesList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[dbo].[LotesList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0).RunData(out outoaram);
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
        /// <summary>
        /// Metodo  Guardar Lotes de Productos
        /// Este metodo es utilizado para guardar o editar en BD
        /// Lotes de Productos
        /// </summary>
        /// <returns> 
        /// id Lotes de Productos
        /// </returns>
        public Result LotesSave(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[dbo].LotesSave", "@id:BIGINT", dc_params["id"],
            "@lote:VARCHAR:30", dc_params["lote"],
            "@vencimiento:VARCHAR:10", dc_params["vencimiento"],
            "@id_user:bigint", dc_params["userID"]).RunScalar();

            
        }
        /// <summary>
        /// Metodo consultar Lotes de Productos
        /// Este metodo es utilizado para consultar en BD atra vez de id
        /// Lotes de Productos
        /// </summary>
        /// <returns> 
        /// Datos de la Lotes de Productos
        /// </returns>
        public Result LotesGet(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[dbo].[LotesGet]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunRow();
        }

        /// <summary>
        /// Metodo Cargar Lotes
        /// Este metodo es utilizado para recibir el filtro de busqueda y conectarse a la BD y mostrarlo en una caja de texto
        /// Productos  
        /// </summary>
        /// <returns> 
        /// La lista de Productos encontradas
        /// </returns>
        public object LotesBuscador(Dictionary<string, object> dc_params)
        {
            try
            {                
                Result result = dbase.Procedure("[Dbo].[LotesBuscador]", "@filtro:VARCHAR:50", dc_params["filtro"], "@opcion:CHAR:2", dc_params["op"], "@id:BIGINT", dc_params["id"]).RunData();
                if (!result.Error)
                {
                    return new { data = Props.table2List(result.Data.Tables[0]) };
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