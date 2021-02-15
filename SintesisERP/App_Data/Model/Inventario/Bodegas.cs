using System;
using System.Collections.Generic;
using System.Data;
using SintesisERP.Pages.Connectors;
using System.Web.Script.Serialization;
using J_W.Estructura;

namespace SintesisERP.App_Data.Model.Inventario
{
    public class Bodegas : J_W.Vinculation.Session_Entity
    {
        private JavaScriptSerializer jsSerialize;
        public Bodegas()
        {
            jsSerialize = new JavaScriptSerializer();
        }
        //Buscador del autocompletado para las bodegas
        public object BodegasBuscador(Dictionary<string, object> dc_params)
        {
            try
            {
              
                DataTable Temp = new DataTable();
                Result result = dbase.Procedure("[Dbo].[BuscadorProducto]", 
                    "@filtro:VARCHAR:50", dc_params.GetString("filtro"), 
                    "@opcion:CHAR:1", dc_params.GetString("op"), 
                    "@op:VARCHAR:2", dc_params.GetString("o"),
                    "@id_articulo:BIGINT", (dc_params.GetString("id_articulo").Equals("")? "0" : dc_params.GetString("id_articulo")),
                    "@id_bodega:BIGINT", (dc_params.GetString("id_bodega").Equals("") ? "0" : dc_params.GetString("id_bodega")),
                    "@id_prod:BIGINT", (dc_params.GetString("id_prod").Equals("") ? "0" : dc_params.GetString("id_prod")),
                    "@formulado:BIT", (dc_params.GetString("formula").Equals("") ? false : Convert.ToBoolean(dc_params.GetString("formula"))),
                    "@tipo:VARCHAR:10", dc_params.GetString("tipo"),
                    "@id_factura:VARCHAR:255", dc_params.GetString("id_factura")).RunData();
                if (!result.Error)
                {
                    if (result.Data.Tables.Count > 1)
                        Temp = result.Data.Tables[1];

                    return new { data = Props.table2List(result.Data.Tables[0]), series = Props.table2List(Temp) };
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
        /// Metodo Cargar Bodegas
        /// Este metodo es utilizado para recibir el filtro de busqueda y conectarse a la BD 
        /// Bodega  
        /// </summary>
        /// <returns> 
        /// La lista de Bodegas encontradas
        /// </returns>
        public object BodegasList(Dictionary<string, object> dc_params)
        {


            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[Dbo].[BodegasList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0).RunData(out outoaram);
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
        /// Metodo  Guardar Bodega
        /// Este metodo es utilizado para guardar o editar en BD
        /// Bodega
        /// </summary>
        /// <returns> 
        /// id Bodega
        /// </returns>
        public Result BodegasSave(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].BodegasSave", "@id:BIGINT", dc_params["id"],
            "@codigo:VARCHAR:10", dc_params["codigo"],
            "@nombre:VARCHAR:100", dc_params["nombre"],
            "@ctainven:varchar:50", dc_params["ctainv"],
            "@ctacosto:varchar:50", dc_params["ctacos"],
            "@ctadescuento:varchar:50", dc_params["ctades"],
            "@ctaingreso:varchar:50", dc_params["ctaing"],
            "@ctaingresoexc:varchar:50", dc_params["ctaingexc"],
            "@ctaivaflete:varchar:50", dc_params["ctaivaflete"],
            "@id_user:int", dc_params["userID"]).RunScalar();
        }
        /// <summary>
        /// Metodo Cambiarestado estado
        /// Este metodo es utilizado para cambiar el estado en BD 
        /// Bodega
        /// </summary>
        /// <returns> 
        /// id bodega
        /// </returns>
        public Result BodegasState(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].[BodegasState]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunScalar();
        }
        /// <summary>
        /// Metodo Eliminar Bodega
        /// Este metodo es utilizado para eliminar un registro en BD solo si no ha sido referenciado en otras tablas
        /// Bodega
        /// </summary>
        /// <returns> 
        /// id Bodega
        /// </returns>
        public Result BodegasDelete(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].[BodegasDelete]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunScalar();
        }
        /// <summary>
        /// Metodo consultar Bodega
        /// Este metodo es utilizado para consultar en BD atra vez de id
        /// Bodega
        /// </summary>
        /// <returns> 
        /// Datos de la Bodega
        /// </returns>
        public Result BodegasGet(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].[BodegasGet]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunRow();
        }
    }
}