using System;
using System.Collections.Generic;
using System.Data;
using J_W.Vinculation;
using SintesisERP.Pages.Connectors;
using System.Web.Script.Serialization;
using System.IO;
using J_W.Estructura;
/// <summary>
/// Descripción breve de Buscadores
/// </summary>
/// 
namespace SintesisERP.App_Data.Model.Inventario
{
    public class Productos : Session_Entity
    {
        private JavaScriptSerializer jsSerialize;
        public Productos()
        {
            jsSerialize = new JavaScriptSerializer();
        }
        /// <summary>
        /// Metodo Cargar Productos
        /// Este metodo es utilizado para recibir el filtro de busqueda y conectarse a la BD 
        /// Productos  
        /// </summary>
        /// <returns> 
        /// La lista de Productos encontradas
        /// </returns>
        public object ProductosList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[Dbo].[ProductosList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0).RunData(out outoaram);
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
        /// Metodo  Guardar Producto
        /// Este metodo es utilizado para guardar o editar en BD
        /// Producto
        /// </summary>
        /// <returns> 
        /// id Producto
        /// </returns>
        public Result ProductosSave(Dictionary<string, object> dc_params)
        {
            Result re = dbase.Procedure("[Dbo].[ProductosSave]",
                "@id:BIGINT", dc_params["id"],
                "@codigo:VARCHAR:20", dc_params["code"],
                "@codigobarra:VARCHAR:100", dc_params["codeBar"],
                "@presentacion:VARCHAR:50", dc_params["present"],
                "@nombre:VARCHAR:100", dc_params["nombre"],
                "@modelo:VARCHAR:100", dc_params["modelo"],
                "@color:VARCHAR:50", dc_params["color"],
                "@categoria:BIGINT", dc_params["categoria"],
                "@marca:BIGINT", dc_params["marca"],
                "@impuesto:BIT", dc_params["impuesto"],
                "@ivaincluido:BIT", dc_params["ivainclu"],
                "@id_iva:BIGINT", dc_params["id_iva"],
                "@id_inc:BIGINT", dc_params["id_inc"],
                "@porcendescto:NUMERIC", dc_params["pordesc"],
                "@formulado:BIT", dc_params["formulado"],
                "@stock:INT", dc_params["stock"],
                "@inventario:BIT", dc_params["inventario"],
                "@tipoProducto:BIGINT", dc_params["tipoproducto"],
                "@facturable:BIT", dc_params["facturable"],
                "@precio:NUMERIC", dc_params["precio"],
                "@id_cuenta:BIGINT", dc_params["id_cuenta"],
                "@id_tipodoc:BIGINT", dc_params["tipodocume"],
                "@id_naturaleza:BIGINT", dc_params["naturaleza"],
                "@esDescuento:BIGINT", dc_params["esdescuento"],
                "@urlimg:VARCHAR:-1", dc_params["url"],
                "@xmlFormulado:xml", dc_params["xmlformulado"],
                "@serie:BIT", dc_params["serie"],
                "@lote:BIT", dc_params["lote"],
                "@id_user:int", dc_params["userID"]).RunRow();
            string url = re.Row.GetString("url").Trim();
            if (!url.Equals(""))
            {
                string dir = Server.MapPath("~/" + url.Replace("../", ""));
                if (File.Exists(dir))
                    File.Delete(dir);
            }
            return re;
        }
        /// <summary>
        /// Metodo Cambiarestado producto
        /// Este metodo es utilizado para cambiar el estado en BD 
        /// Producto
        /// </summary>
        /// <returns> 
        /// id producto
        /// </returns>
        public Result ProductosState(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].[ProductosState]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunScalar();
        }
        /// <summary>
        /// Metodo Eliminar Productos
        /// Este metodo es utilizado para eliminar un registro en BD solo si no ha sido referenciado en otras tablas
        /// Productos
        /// </summary>
        /// <returns> 
        /// id Productos
        /// </returns>
        public Result ProductosDelete(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].[ProductosDelete]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunScalar();
        }
        /// <summary>
        /// Metodo consultar Productos
        /// Este metodo es utilizado para consultar en BD atra vez de id
        /// Productos
        /// </summary>
        /// <returns> 
        /// Datos del Producto
        /// </returns>
        public object ProductosGet(Dictionary<string, object> dc_params)
        {
            try
            {
                List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
                Result data = dbase.Procedure("[Dbo].[ProductosGet]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunData();
                if (data.Data.Tables[0].Rows.Count > 0)
                    data.Row = data.Data.Tables[0].Rows[0].ToDictionary();
                data.Table = data.Data.Tables[1].ToList();
                return new { Row = data.Row, Table = data.Table };
            }
            catch (Exception ex)
            {
                return new { Error = true, Message = ex.Message };
            }
        }
        /// <summary>
        /// Metodo Cargar Productos
        /// Este metodo es utilizado para recibir el filtro de busqueda y conectarse a la BD y mostrarlo en una caja de texto
        /// Productos  
        /// </summary>
        /// <returns> 
        /// La lista de Productos encontradas
        /// </returns>
        public object ArticulosBuscador(Dictionary<string, object> dc_params)
        {
            try
            {
                string id_bodega = (dc_params.GetString("mod").Equals("P")) ? dc_params.GetString("idbodega") : dc_params.GetString("id_bodega");
                id_bodega = (id_bodega.Equals("")) ? "0" : id_bodega;
                object id_articulo = (dc_params.GetString("id_articulo").Equals("") ? "0" : dc_params.GetString("id_articulo"));
                object id_cliente = (dc_params.GetString("id_cliente").Equals("") ? "0" : dc_params.GetString("id_cliente"));
                object id_factura = (dc_params.GetString("id_factura").Equals("") ? "" : dc_params.GetString("id_factura"));
                DataTable Temp = new DataTable();
                Result result = dbase.Procedure("[Dbo].[BuscadorProducto]", "@filtro:VARCHAR:50", dc_params["filtro"], "@opcion:CHAR:1", dc_params["op"], "@op:VARCHAR:2", dc_params["o"],
                     "@formulado:BIT", dc_params["formula"], "@id_prod:BIGINT", dc_params["id_prod"],
                     "@id_bodega:BIGINT", id_bodega, "@id_articulo:BIGINT", id_articulo, "@id_factura:VARCHAR:255", id_factura).RunData();
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


        public object ServiciosBuscador(Dictionary<string, object> dc_params)
        {
            try
            {
                string id_bodega = (dc_params.GetString("mod").Equals("P")) ? dc_params.GetString("idbodega") : dc_params.GetString("id_bodega");
                id_bodega = (id_bodega.Equals("")) ? "0" : id_bodega;
                object id_articulo = (dc_params.GetString("id_articulo").Equals("") ? "0" : dc_params.GetString("id_articulo"));
                object id_cliente = (dc_params.GetString("id_cliente").Equals("") ? "0" : dc_params.GetString("id_cliente"));
                object id_factura = (dc_params.GetString("id_factura").Equals("") ? "" : dc_params.GetString("id_factura"));
                DataTable Temp = new DataTable();
                Result result = dbase.Procedure("[dbo].[BuscadorProductoRecurrentes]", "@filtro:VARCHAR:50", dc_params["filtro"], "@opcion:CHAR:1", dc_params["op"], "@op:VARCHAR:2", dc_params["o"],
                     "@formulado:BIT", dc_params["formula"], "@id_prod:BIGINT", dc_params["id_prod"],
                     "@id_bodega:BIGINT", id_bodega, "@id_articulo:BIGINT", id_articulo, "@id_factura:VARCHAR:255", id_factura).RunData();
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
        /// Metodo Cargar Lotes
        /// Este metodo es utilizado para recibir el filtro de busqueda y conectarse a la BD y mostrarlo en una caja de texto
        /// Lotes  
        /// </summary>
        /// <returns> 
        /// La lista de Lotes encontradas
        /// </returns>
        public object LotesBuscador(Dictionary<string, object> dc_params)
        {
            try
            {
                object id_cliente = (dc_params.GetString("id_cliente").Equals("") ? "0" : dc_params.GetString("id_cliente"));
                Result result = dbase.Procedure("[Dbo].[ST_BuscadorLotes]", "@filtro:VARCHAR:50", dc_params["filtro"]).RunData();
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
        /// <summary>
        /// Metodo Cargar Productos x Bodegas
        /// Este metodo es utilizado para recibir el filtro de busqueda y conectarse a la BD
        /// </summary>
        /// <returns> 
        /// La lista de Productos encontradas
        /// </returns>
        public object ProductosBodegaList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[Dbo].[BodegasProductosList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0, "@id_producto:BIGINT", dc_params["id_producto"]).RunData(out outoaram);
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
        /// Metodo  Guardar stock maximo y stock minimo Productos 
        /// Este metodo es utilizado para guardar o editar stock maximo y stock minimo de Productos por bodegas
        /// Producto
        /// </summary>
        /// <returns> 
        /// id Producto,bodega
        /// </returns>
        public Result ProductosBodegaSave(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].BodegasProductosSave", "@id:BIGINT", dc_params["id"],
            "@id_producto:BIGINT", dc_params["idproducto"],
            "@id_bodega:BIGINT", dc_params["id_bodega"],
            "@stockmin:decimal(18,2)", dc_params["stockmin"],
            "@stockmax:decimal(18,2)", dc_params["stockmax"],
            "@id_usercreated:BIGINT", dc_params["userID"],
            "@id_userupdated:BIGINT", dc_params["userID"]).RunScalar();
        }
        /// <summary>
        /// Metodo consultar Productos x bodegas
        /// Este metodo es utilizado para consultar en BD atra vez de id de producto e id de bodega
        /// Productos
        /// </summary>
        /// <returns> 
        /// Datos del Producto x bodega
        /// </returns>
        public Result ProductosBodegasGet(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[dbo].[BodegasProductosGet]", "@id:INT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunRow();
        }
        /// <summary>
        /// Metodo Eliminar stock de Productos x Bodegas
        /// Este metodo es utilizado para eliminar un registro en BD solo si no ha sido referenciado en otras tablas
        /// Productos
        /// </summary>
        /// <returns> 
        /// id Productos,id_bodega
        /// </returns>
        public Result ProductosBodegaDelete(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].[BodegasProductosDelete]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunScalar();
        }

        public object ConceptosList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[Dbo].[ST_ConceptosList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0, "@esDesc:INT", dc_params.GetString("esDesc"), "@tipodocu:VARCHAR:10", dc_params.GetString("tipodocu")).RunData(out outoaram);
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


    }


}