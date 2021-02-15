using System;
using System.Collections.Generic;
using System.Data;
using J_W.Vinculation;
using SintesisERP.Pages.Connectors;
using System.Web.Script.Serialization;
using J_W.Estructura;
using System.IO;
using System.Data.OleDb;
using System.Linq;
/// <summary>
/// Descripción breve de Buscadores
/// </summary>
/// 
namespace SintesisERP.App_Data.Model.Inventario
{
    public class OrdenCompras : Session_Entity
    {
        private JavaScriptSerializer jsSerialize;
        public OrdenCompras()
        {
            jsSerialize = new JavaScriptSerializer();
        }
        #region
        public object OrdenComprasList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[Dbo].[ST_MovOrdenComprasList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0).RunData(out outoaram);
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
        public object OrdenComprasTempList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[Dbo].[ST_MovOrdenComprasTempList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0).RunData(out outoaram);
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
        public object OrdenComprasItemList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[Dbo].[MovOrdenCompraItemList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0, "@id_orden:BIGINT", dc_params.GetString("id_orden"), "@op:CHAR:1", dc_params.GetString("op")).RunData(out outoaram);
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

        public Result EntradasRecalcular(Dictionary<string, object> dc_params)
        {
            return dbase.Query("SELECT R.retfuente, R.retiva, R.retica, R.costo Tcosto, R.iva Tiva, R.descuento Tdesc, R.total Ttotal FROM Dbo.ST_FnCalRetenciones(" + dc_params.GetString("id_proveedor") + ", " + dc_params.GetString("id_entrada") + ", " + dc_params.GetString("flete") + ") R", true).RunRow();
        }

        public Result OrdenComprasTempGet(Dictionary<string, object> dc_params)
        {
            Result data = dbase.Procedure("[Dbo].ST_MovOrdenComprasTempGet", "@id:int", dc_params.GetString("id")).RunData();
            if (data.Data.Tables[0].Rows.Count > 0)
                data.Row = data.Data.Tables[0].Rows[0].ToDictionary();
            data.Table = data.Data.Tables[1].ToList();
            data.Data = null;
            return data;
        }
        public Result OrdenComprasItemTempGet(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].ST_MovOrdenComprasItemTempGet", "@idorden:int", dc_params.GetString("id_orden"), "@id_producto:bigint", dc_params.GetString("id_articulo")).RunRow();
           
        }
        public Result OrdenComprasGet(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].ST_MovOrdenComprasGet", "@id:int", dc_params.GetString("id")).RunRow();            
        }

        public Result OrdenCompraAddArticulo(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].ST_MovOrdenCompraAddArticulo",
            "@id_orden:int", dc_params["id_orden"],
            "@id_articulo:INT", dc_params["id_article"],
            "@id_bodega:INT", dc_params["id_bodega"],
            "@cantidad:NUMERIC", dc_params["quantity"],
            "@id_user:int", dc_params["userID"]).RunRow();
        }

        public Result OrdenComprasTraslEntrada(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[dbo].[MOVOrdenCompraTrasEntrada]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunScalar();
        }

        public Result OrdenComprasDelArticulo(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].ST_MovOrdenCompraDelArticulo",
            "@id_articulo:INT", dc_params["id_articulo"]).RunRow();
        }

        public Result OrdenCompraSaveTemp(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].ST_MovOrdenCompraTemp",
             "@id:Bigint", dc_params["id_orden"],
             "@fechadocumen:VARCHAR:10", dc_params["fechadocumen"],
             "@id_proveedor:Bigint", dc_params["id_proveedor"],
             "@id_bodega:bigint", dc_params["id_bodega"],
             "@id_user:int", dc_params["userID"]).RunRow();
        }

        public Result OrdenCompraConsecutivo(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].ST_MovOrdenCompraTemp",
            "@id_user:int", dc_params["userID"]).RunRow();
        }

        public Result FacturarOrdenCompra(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].ST_MovFacturarOrdenCompra",
            "@id:BIGINT", dc_params["Id"],
            "@fechadoc:VARCHAR:10", dc_params["Fecha"],
            "@id_tipodoc:BIGINT", dc_params["id_tipodoc"],
            "@id_centrocostos:BIGINT", dc_params["id_centrocostos"],
            "@id_proveedor:BIGINT", dc_params["Proveedor"],
            "@id_ordentemp:BIGINT", dc_params["id_ordentemp"],
            "@id_bodega:BIGINT", dc_params["id_bodega"],
            "@id_user:INT", dc_params["userID"]).RunRow();
        }

        public Result RevertirOrdenCompra(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].[ST_MOVRevertirOrdenCompra]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunRow();
        }

        
        public Result EntradaDescargar(Dictionary<string, object> dc_params)
        {
            return dbase.Query(" DELETE[dbo].[MOVEntradasItemsTemp] WHERE id_entrada = " + dc_params.GetString("id_entrada"), true).RunVoid();
        }

   
        #endregion

        #region
        public object AjusteList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[Dbo].[ST_MovAjustesList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0).RunData(out outoaram);
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

        public Result AjustesGet(Dictionary<string, object> dc_params)
        {
            Result data = dbase.Procedure("[Dbo].ST_MOVAjusteGet", "@id:int", dc_params.GetString("id")).RunData();
            if (data.Data.Tables[0].Rows.Count > 0)
                data.Row = data.Data.Tables[0].Rows[0].ToDictionary();
            data.Table = data.Data.Tables[1].ToList();
            data.Data = null;
            return data;
        }

        public Result AjustesConsulCosto(Dictionary<string, object> dc_params)
        {
            return dbase.Query("SELECT costo, existencia FROM Dbo.Existencia WHERE id_articulo = " + dc_params.GetString("id_article") + " AND id_bodega = " + dc_params.GetString("id_wineri") + ";", true).RunRow();
        }


        public Result AjustesAddArticulo(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].ST_MovAjusteAddArticulo",
            "@idToken:varchar:255", dc_params["idToken"],
            "@id_articulo:INT", dc_params["id_article"],
            "@id_bodega:INT", dc_params["id_wineri"],
            "@cantidad:NUMERIC", dc_params["quantity"],
            "@costo:NUMERIC", dc_params["costo"],
            "@id_user:int", dc_params["userID"]).RunRow();
        }

        public Result AjustesDelArticulo(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].ST_MovAjusteDelArticulo",
            "@id_articulo:INT", dc_params["id_articulo"],
            "@idToken:varchar:255", dc_params["idToken"]).RunRow();
        }

        public Result FacturarAjuste(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].ST_MOVFacturarAjuste",
            "@fecha:VARCHAR:10", dc_params["Fecha"],
            "@id_concepto:BIGINT", dc_params["id_concepto"],
            "@idToken:VARCHAR:255", dc_params["idToken"],
            "@id_user:INT", dc_params["userID"]
            ).RunRow();
        }

        public Result RevertirAjuste(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].[ST_MOVRevertirAjuste]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunRow();
        }

        #endregion

        #region
        public object ConversionList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[Dbo].[ST_MovConversionList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0).RunData(out outoaram);
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
        
        public Result ConversionGet(Dictionary<string, object> dc_params)
        {
            Result data = dbase.Procedure("[Dbo].ST_MovConversionGet", "@id:int", dc_params.GetString("id")).RunData();
            if (data.Data.Tables[0].Rows.Count > 0)
                data.Row = data.Data.Tables[0].Rows[0].ToDictionary();
            data.Table = data.Data.Tables[1].ToList();
            data.Data = null;
            return data;
        }

        public Result ConversionAddArticulo(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].ST_MovConversionAddArticulo",
            "@id_entrada:int", dc_params["id_entrada"],
            "@id_articulo:INT", dc_params["id_article"],
            "@id_bodega:INT", dc_params["id_wineri"],
            "@cantidad:NUMERIC", dc_params["quantity"],
            "@id_user:int", dc_params["userID"]).RunRow();
        }

        public Result ConversionDelArticulo(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].ST_MovConversionDelArticulo",
            "@id_articulo:INT", dc_params["id_articulo"],
            "@id_entrada:int", dc_params["id_entrada"]).RunRow();
        }

        public Result FacturarConversion(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].ST_MOVFacturarConversion",
            "@fechadoc:VARCHAR:10", dc_params["fecha"],
            "@id_concepto:BIGINT", dc_params["concepto"],
            "@id_entradatemp:BIGINT", dc_params["id_entradatemp"],
            "@id_user:INT", dc_params["userID"]).RunRow();
        }

        public Result RevertirConversion(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].[ST_MOVRevertirConversion]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunRow();
        }        
        #endregion
        
    }
}