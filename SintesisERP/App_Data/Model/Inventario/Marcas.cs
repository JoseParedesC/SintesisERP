using System;
using System.Collections.Generic;
using System.Data;
using SintesisERP.Pages.Connectors;
using System.Web.Script.Serialization;
using J_W.Estructura;

namespace SintesisERP.App_Data.Model.Inventario
{
    public class Marcas : J_W.Vinculation.Session_Entity
    {
        private JavaScriptSerializer jsSerialize;
        public Marcas()
        {
            jsSerialize = new JavaScriptSerializer();
        }
        /// <summary>
        /// Metodo Cargar Marcas
        /// Este metodo es utilizado para recibir el filtro de busqueda y conectarse a la BD 
        /// Marcas  
        /// </summary>
        /// <returns> 
        /// La lista de Marcas encontradas
        /// </returns>
        public object MarcasList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[dbo].[MarcasList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0).RunData(out outoaram);
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
        /// Metodo  Guardar Marca
        /// Este metodo es utilizado para guardar o editar en BD
        /// Marca
        /// </summary>
        /// <returns> 
        /// id Marca
        /// </returns>
        public Result MarcasSave(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[dbo].MarcasSave", "@id:BIGINT", dc_params["id"],
            "@codigo:VARCHAR:4", dc_params["codigo"],
            "@nombre:VARCHAR:50", dc_params["nombre"],
            "@id_usercreated:bigint", dc_params["userID"],
            "@id_userupdated:bigint", dc_params["userID"]).RunScalar();

            
        }
        /// <summary>
        /// Metodo Cambiarestado Marca
        /// Este metodo es utilizado para cambiar el estado en BD 
        /// Marca
        /// </summary>
        /// <returns> 
        /// id Marca
        /// </returns>
        public Result MarcasState(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[dbo].[MarcasState]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunScalar();
        }
        /// <summary>
        /// Metodo Eliminar Marca
        /// Este metodo es utilizado para eliminar un registro en BD solo si no ha sido referenciado en otras tablas
        /// Marca
        /// </summary>
        /// <returns> 
        /// id marca
        /// </returns>
        public Result MarcasDelete(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[dbo].[MarcasDelete]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunScalar();
        }
        /// <summary>
        /// Metodo consultar Marca
        /// Este metodo es utilizado para consultar en BD atra vez de id
        /// Marca
        /// </summary>
        /// <returns> 
        /// Datos de la Marca
        /// </returns>
        public Result MarcasGet(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[dbo].[MarcasGet]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunRow();
        }
    }
}