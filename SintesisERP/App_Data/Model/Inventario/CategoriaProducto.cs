using System;
using System.Collections.Generic;
using System.Data;
using J_W.Estructura;
using J_W.Vinculation;
using SintesisERP.Pages.Connectors;
using System.Web.Script.Serialization;

namespace SintesisERP.App_Data.Model.Inventario
{
    public class CategoriaProducto : Session_Entity
    {
        private JavaScriptSerializer jsSerialize;
        public CategoriaProducto()
        {
            jsSerialize = new JavaScriptSerializer();
        }

        /// <summary>
        /// Metodo Cargar Categoria de Productos
        /// Este metodo es utilizado para recibir el filtro de busqueda y conectarse a la BD 
        /// categorias encontradas 
        /// </summary>
        /// <returns> 
        /// La lista de Categorias encontradas
        /// </returns>
        public object CategoriaProductoList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[Dbo].[CategoriasProductosList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0).RunData(out outoaram);
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
        /// Metodo de Guardar Categoria de Productos
        /// Este metodo es utilizado para guardar o editar una 
        /// categoria de producto
        /// </summary>
        /// <returns> 
        /// id categoria
        /// </returns>
        public Result CategoriaProductoSave(Dictionary<string, object> dc_params)
        {
           return dbase.Procedure("[dbo].CategoriasProductosSave", "@id:BIGINT", dc_params["id"],
            "@nombre:VARCHAR:100", dc_params["nombre"],
            "@id_user:int", dc_params["userID"]).RunScalar();
        }
        /// <summary>
        /// Metodo Cambiar estado Categoria de Productos
        /// Este metodo es utilizado para cambiar el estado de una 
        /// categoria de producto
        /// </summary>
        /// <returns> 
        /// id categoria
        /// </returns>
        public Result CategoriaProductoState(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[dbo].[CategoriasProductosState]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunScalar();
        }
        /// <summary>
        /// Metodo Eliminar Categoria de Producto
        /// Este metodo es utilizado para eliminar una 
        /// categoria de producto solo si no ha sido utilizado en un producto
        /// </summary>
        /// <returns> 
        /// id categoria
        /// </returns>
        public Result CategoriaProductoDelete(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[dbo].[CategoriasProductosDelete]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunScalar();
        }
        /// <summary>
        /// Metodo consultar categoria
        /// Este metodo es utilizado para consultar una 
        /// categoria de producto recibe como parametros un id
        /// </summary>
        /// <returns> 
        /// Datos de la categoria solicitada
        /// </returns>
        public Result CategoriaProductoGet(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[dbo].[CategoriasProductosGet]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunRow();
        }
    }
}