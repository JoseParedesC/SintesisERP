using System;
using System.Collections.Generic;
using System.Data;
using J_W.Vinculation;
using SintesisERP.Pages.Connectors;
using System.Web.Script.Serialization;
using J_W.Estructura;
using SintesisERP.App_Data.Model.Contabilidad;
using SintesisERP.App_Data.Model.FE;
/// <summary>
/// Descripción breve de Buscadores
/// </summary>
/// 
namespace SintesisERP.App_Data.Model.Inventario
{
    public class Devoluciones : Session_Entity
    {
        private JavaScriptSerializer jsSerialize;
        public Devoluciones()
        {
            jsSerialize = new JavaScriptSerializer();
        }


        public object DevolucionesList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[Dbo].[ST_DevolucionesList]", "@page:int", dc_params.GetString("start"), "@numpage:int",
                    dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"),
                    "@countpage:int:output", 0, "@op:VARCHAR:2", dc_params.GetString("op"), "@id_user:INT", dc_params.GetString("userID"),
                    "@id_caja:BIGINT", 0).RunData(out outoaram);
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

        public object ArticulosDevBuscador(Dictionary<string, object> dc_params)
        {
            try
            {
                Result result = dbase.Procedure("[Dbo].[ST_BuscadorDevArticulo]", "@filtro:VARCHAR:50", dc_params["filtro"], "@opcion:CHAR:1", dc_params["option"], "@op:VARCHAR:2", dc_params["op"], "@id:INT", dc_params["id"], "@id_bodega:INT", dc_params.GetString("id_bodega")).RunData();
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

        public object ArticulosDevBuscadorPresent(Dictionary<string, object> dc_params)
        {
            try
            {
                Result result = dbase.Procedure("[Dbo].[ST_BuscadorDevArticuloPresentacion]", "@filtro:VARCHAR:50", dc_params["filtro"], "@opcion:CHAR:1", dc_params["option"], "@op:VARCHAR:2", dc_params["op"], "@id:INT", dc_params["id"], "@id_bodega:INT", dc_params.GetString("id_bodega")).RunData();
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

        #region
        public object DevFacturaInicial(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[dbo].[ST_DevFacturaInicial]",
                    "@page:int", dc_params.GetString("start"),
                    "@numpage:int", dc_params.GetString("length"),
                    "@filter:varchar:50", dc_params.GetString("filter"),
                    "@countpage:int:output", 0,
                    "@List:BIT", dc_params["list"],
                    "@idToken:VARCHAR:255", dc_params["idToken"],
                     "@tabla:VARCHAR:50", dc_params["tabla"],
                    "@id_factura:BIGINT", dc_params["id_factura"],
                    "@id_user:int", dc_params["userID"]).RunData(out outoaram);

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

        public Result DevFacturaAddArticulo(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[dbo].[ST_DevFacturaAddArticulo]",
                "@id:BIGINT", dc_params["id"],
                "@cantidad:Numeric", dc_params["cant"],
                "@sw:CHAR", dc_params["sw"],
                "@id_user:int", dc_params["userID"]).RunRow();
        }

        public object DevFacturaItemList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[Dbo].[ST_DevFacturasItems]", "@page:int", dc_params.GetString("start"), "@numpage:int",
                    dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"),
                    "@countpage:int:output", 0, "@id_factura:BIGINT", dc_params.GetString("id_factura")).RunData(out outoaram);
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

        public Result DevFacturasDelArticulo(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].ST_MovDevFacturaDelArticulo",
            "@id_articulo:INT", dc_params["id_articulo"],
            "@idToken:VARCHAR:255", dc_params["idToken"]).RunRow();
        }

        public Result DevFacturaConcpeto(Dictionary<string, object> dc_params)
        {
            try
            {
                return dbase.Procedure("[Dbo].ST_DevFacturaConcepto",
                "@idToken:VARCHAR:255", dc_params["idToken"],
                "@id_concepto:BIGINT", dc_params["id_concepto"],
                "@op:VARCHAR:2", dc_params["op"],
                "@id_factura:INT", dc_params["id_factura"],
                "@id_user:int", dc_params["userID"]).RunRow();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public Result FacturarDevFactura(Dictionary<string, object> dc_params)
        {
            Result data = dbase.Procedure("[Dbo].ST_MOVFacturarDevFactura",
            "@fechadoc:VARCHAR:10", dc_params["fecha"],
            "@id_factura:BIGINT", dc_params["id_factura"],
            "@id_devoluciontemp:VARCHAR:255", dc_params["idToken"],
            "@id_user:INT", dc_params["userID"]
            ).RunRow();
            if (!data.Error)
            {
                //if (Convert.ToBoolean(data.Row["isfe"]))
                //{
                //    FacturacionElectro FE = new FacturacionElectro();
                //    Result resFE = FE.EjecutarFacturacion(dc_params.GetString("userID"), data.Row.GetString("key"), "D");
                //}

                String id = data.Row["id"].ToString();
                String nombreview = data.Row["nombreview"].ToString();
                String fecha = data.Row["fecha"].ToString();
                String anomes = data.Row["anomes"].ToString();
                String id_user = data.Row["id_user"].ToString();
         
                new Contabilizar().ContabilizarDocumento(id, id_user, fecha, anomes, nombreview, null);
            }
            return data;         
        }


        public object FacturarDevList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[Dbo].[ST_MovDevFacturasList]", "@page:int", dc_params.GetString("start"),
                    "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"),
                    "@countpage:int:output", 0, "@id_user:int", dc_params.GetString("userID"), "@id_caja:BIGINT", dc_params.GetString("idcaja")).RunData(out outoaram);
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

        public object FacturasDevGet(Dictionary<string, object> dc_params)
        {
            try
            {
                Result data = dbase.Procedure("[Dbo].ST_MovDevFacturasGet", "@id:int", dc_params.GetString("id")).RunRow();
                return data;
               
            }
            catch (Exception ex)
            {
                return new { Error = true, Message = ex.Message };
            }
        }

        #endregion

        #region
        public object DevolucionesItemList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[Dbo].[ST_MovDevEntradasItemList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0, "@id_devolucion:BIGINT", dc_params.GetString("id_entrada"),
                    "@op:CHAR:1", dc_params.GetString("opcion")).RunData(out outoaram);
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

        public Result FacturarDevEntrada(Dictionary<string, object> dc_params)
        {
            Result data = dbase.Procedure("[Dbo].ST_MOVFacturarDevEntrada",
            "@fechadoc:VARCHAR:10", dc_params["fecha"],
            "@id_entrada:BIGINT", dc_params["id_entrada"],
            "@id_devoluciontemp:INT", dc_params["id_devolucion"],
            "@id_user:INT", dc_params["userID"]
            ).RunRow();

            if (!(data.Row == null))
            {
                String id = data.Row["id"].ToString();
                String nombreview = data.Row["nombreview"].ToString();
                String fecha = data.Row["fecha"].ToString();
                String anomes = data.Row["anomes"].ToString();
                String id_user = data.Row["id_user"].ToString();

                new Contabilizar().ContabilizarDocumento(id, id_user, fecha, anomes, nombreview, null);
            }
            return data;
        }

        public Result RevertirDevEntrada(Dictionary<string, object> dc_params)
        {
            Result res = dbase.Procedure("[Dbo].[ST_MOVRevertirDevoEntrada]", "@id:BIGINT", dc_params["id"],
                                    "@id_user:int", dc_params["userID"]).RunRow();
            if (!(res.Row == null))
            {
                String id = res.Row["id"].ToString();
                String nombreview = res.Row["nombreview"].ToString();
                String fecha = res.Row["fecha"].ToString();
                String anomes = res.Row["anomes"].ToString();
                String id_user = res.Row["id_user"].ToString();
                String id_rev = res.Row["idrev"].ToString();

                new Contabilizar().ContabilizarDocumento(id, id_user, fecha, anomes, nombreview, id_rev);
            }
            return res;
        }

        public object EntradasDevList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[Dbo].[ST_MovDevEntradasList]", "@page:int", dc_params.GetString("start"),
                    "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"),
                    "@countpage:int:output", 0, "@id_user:int", dc_params.GetString("userID")).RunData(out outoaram);
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

        public object EntradasDevGet(Dictionary<string, object> dc_params)
        {
            try
            {
                Result data = dbase.Procedure("[Dbo].ST_MovDevEntradasGet", "@id:int", dc_params.GetString("id")).RunRow();
                return data;
            }
            catch (Exception ex)
            {
                return new { Error = true, Message = ex.Message };
            }
        }
        #endregion

        public Result FacturasAddConcepto(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].ST_MovFacturaAddConcepto",
           "@idToken:VARCHAR:255", dc_params["idToken"],
           "@id_concepto:INT", dc_params["id_concepto"],
           "@valor:NUMERIC", dc_params["valor"],
           "@descuento:NUMERIC", dc_params["descuento"],
           "@id_user:int", dc_params["userID"]).RunRow();
        }

        public Result FacturasRecalcular(Dictionary<string, object> dc_params)
        {
            return dbase.Query("SELECT iva Tiva, precio Tprecio, descuentoart Tdctoart, (" + dc_params.GetString("id_proveedor") + " + descuentoart)Tdesc, total Ttotal FROM Dbo.ST_FnCalTotalFactura('" + dc_params.GetString("idToken") + "', " + dc_params.GetString("descuento") + ")", true).RunRow();
        }

        public Result FacturasDelArticulo(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].ST_MovFacturaDelArticulo",
            "@id_articulo:INT", dc_params["id_articulo"],
            "@descuento:NUMERIC", dc_params["descuento"],
            "@idToken:VARCHAR:255", dc_params["idToken"]).RunRow();
        }

        public Result FacturasDelConcepto(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].ST_MovFacturaDelConcepto",
            "@id_concepto:INT", dc_params["id_concepto"],
            "@descuento:NUMERIC", dc_params["descuento"],
            "@idToken:VARCHAR:255", dc_params["idToken"]).RunRow();
        }

        public object FacturasDevConceptosGet(Dictionary<string, object> dc_params)
        {
            try
            {
                List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
                Result data = dbase.Procedure("[Dbo].ST_MovDevFacturaConceptosGet", "@id:int", dc_params.GetString("id")).RunData();
                data.Table = data.Data.Tables[0].ToList();
                data.Data = null;
                return data;
            }
            catch (Exception ex)
            {
                return new { Error = true, Message = ex.Message };
            }
        }
    }

}