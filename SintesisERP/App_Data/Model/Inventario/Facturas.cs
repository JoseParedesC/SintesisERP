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
    public class Facturas : Session_Entity
    {
        private JavaScriptSerializer jsSerialize;
        public Facturas()
        {
            jsSerialize = new JavaScriptSerializer();
        }

        #region 
        /// <summary>
        /// Facturació
        /// </summary>
        /// <param name="dc_params"></param>
        /// <returns></returns>
        public object FacturasList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[Dbo].[ST_MovFacturasList]", "@page:int", dc_params.GetString("start"), "@numpage:int",
                    dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0,
                    "@id_user:INT", dc_params.GetString("userID")).RunData(out outoaram);
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

        public object FacturasListPos(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[Dbo].[ST_MovFacturasListPos]", "@page:int", dc_params.GetString("start"), "@numpage:int",
                    dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0,
                    "@id_user:INT", dc_params.GetString("userID")).RunData(out outoaram);
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


        public object FacturasListProcess(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[Dbo].[ST_MovFacturasListProcess]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0).RunData(out outoaram);
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


        public object FacturasGet(Dictionary<string, object> dc_params)
        {
            try
            {
                Result data = dbase.Procedure("[Dbo].ST_MovFacturasGet", "@id:int", dc_params.GetString("id"), "@op:CHAR:1", dc_params.GetString("op"), "@id_temp:VARCHAR:255", dc_params.GetString("idtemp")).RunRow();
                return data;
            }
            catch (Exception ex)
            {
                return new { Error = true, Message = ex.Message };
            }
        }

        public Result FacturasAddArticulo(Dictionary<string, object> dc_params)
        {
            object id_bodega = (dc_params.GetString("id_bodega").Equals("") ? dc_params.GetString("idbodega") : dc_params.GetString("id_bodega"));
            string dsctofinan = (dc_params.GetString("descuentoFin").Equals("") ? "0" : dc_params.GetString("descuentoFin"));
            return dbase.Procedure("[Dbo].ST_MovFacturaAddArticulo",
            "@idToken:VARCHAR:255", dc_params["idToken"],
            "@id_articulo:INT", dc_params["id_article"],
            "@id_bodega:INT", id_bodega,
            "@cantidad:NUMERIC", dc_params["quantity"],
            "@precio:NUMERIC", dc_params["precio"],
            "@porcendsc:NUMERIC", dc_params["porcendsc"],
            "@anticipo:NUMERIC", dc_params["anticipo"],
            "@descuento:NUMERIC", dc_params["descuento"],
            "@serie:BIT", dc_params["serie"],
            "@series:VARCHAR:-1", dc_params["series"],
            "@lote:BIT", dc_params["lote"],
            "@inventarial:BIT", dc_params["inventarial"],
            "@descuentofin:NUMERIC", dsctofinan,
            "@id_user:int", dc_params["userID"]).RunRow();
        }

        public object FacturasItemList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[Dbo].[ST_MovFacturaItemList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"),
                    "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0, "@id_factura:VARCHAR:255", dc_params.GetString("id_factura"), "@id_fac:BIGINT", dc_params.GetString("id_fac"),
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

        public Result FacturasRecalcular(Dictionary<string, object> dc_params)
        {
            string descuentofin = (dc_params.GetString("descuentoFin").Equals("") ? "0" : dc_params.GetString("descuentoFin"));
            return dbase.Procedure("[Dbo].[ST_MovFacturaRecalcular]", "@idToken:VARCHAR:255", dc_params.GetString("idToken"), "@anticipo:NUMERIC", dc_params["anticipo"],
                                                                      "@id_cliente:BIGINT", dc_params["id_cliente"], "@fecha:VARCHAR:10", dc_params.GetString("fecha"), "@descuentofin:NUMERIC",
                                                                      descuentofin, "@id_ctaant:BIGINT", dc_params.GetString("id_cta"),
                                                                      "@op:CHAR:1", dc_params.GetString("op")).RunRow();
        }

        public object FacturasBuscadorSerieLote(Dictionary<string, object> dc_params)
        {
            try
            {

                string id_bodega = (dc_params.GetString("mod").Equals("P")) ? dc_params.GetString("idbodega") : dc_params.GetString("id_bodega");
                id_bodega = (id_bodega.Equals("")) ? "0" : id_bodega;
                Result result = dbase.Procedure("[Dbo].[ST_MOVFacturaBuscadorLoteSerie]", "@opcion:CHAR:2", dc_params["opcion"], "@op:CHAR:2", dc_params["op"], "@id_bodega:BIGINT", id_bodega, "@id_articulo:BIGINT", dc_params["id_articulo"], "@id_factura:VARCHAR:255", dc_params["id_factura"], "@proceso:CHAR:1", dc_params["proceso"]).RunData();
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

        public Result FacturasGetSeriesTemp(Dictionary<string, object> dc_params)
        {
            string query = (dc_params.GetString("op").Equals("E")) ? "MovFacturaSeries] WHERE id_items " : "MovFacturaSeriesTemp] WHERE id_itemstemp ";
            Result res = dbase.Query("SELECT id, serie, selected FROM[dbo].[" + query + " = " + dc_params.GetString("id_articulo"), true).RunData();

            if (!res.Error)
            {
                res.Table = res.Data.Tables[0].ToList();
                res.Data = null;
            }
            return res;
        }

        public Result FacturaSetArticulo(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].[ST_MovFacturaSetItemTemp]",
            "@id_factura:VARCHAR:255", dc_params["id_factura"],
            "@id:INT", dc_params["id"],
            "@valor:NUMERIC", dc_params["value"],
            "@anticipo:NUMERIC", dc_params["anticipo"],
            "@extravalor:VARCHAR:-1", dc_params.GetString("extravalue"),
            "@op:CHAR:1", dc_params.GetString("op"),
            "@xml:XML", dc_params.GetString("xml"),
            "@column:VARCHAR:20", dc_params["column"],
            "@id_facturaofi:BIGINT", (dc_params.GetString("id_facturaofi").Equals("") ? "0" : dc_params.GetString("id_facturaofi"))
            ).RunRow();
        }

        public Result FacturasDelArticulo(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].ST_MovFacturaDelArticulo",
            "@id_articulo:INT", dc_params["id_articulo"],
            "@id_anticipo:BIGINT", dc_params["id_anticipo"],
            "@idToken:VARCHAR:255", dc_params["idToken"]).RunRow();
        }

        public Result FacturarFactura(Dictionary<string, object> dc_params)
        {
            Result res = dbase.Procedure("[Dbo].ST_MOVFacturarFactura",
            "@id_tipodoc:BIGINT", dc_params["id_tipodoc"],
            "@id_centrocostos:BIGINT", dc_params["id_centrocostos"],
            "@fechadoc:VARCHAR:10", dc_params["Fecha"],
            "@id_tercero:BIGINT", dc_params["id_tercero"],
            "@id_vendedor:BIGINT", dc_params["id_vendedor"],
            "@id_ctaant:BIGINT", dc_params["id_ctaant"],
            "@anticipo:NUMERIC", dc_params["anticipo"],
            "@formapago:XML", dc_params["formapago"],
            "@idToken:VARCHAR:255", dc_params["idToken"],
            "@totalcredito:NUMERIC", dc_params["totalcredito"],
            "@numcuotas:INT", dc_params["cuotas"],
            "@dias:INT", dc_params["dias"],
            "@venini:VARCHAR:10", dc_params["inicial"],
            "@vencimiento:INT", dc_params["ven"],
            "@id_formacred:BIGINT", dc_params["id_formacred"],
            "@id_forma:INT", dc_params["op"],
            "@valorFianza:NUMERIC", dc_params["vrlfianza"],
            "@descuentofin:NUMERIC", dc_params.GetString("descuentoFin"),
            "@id_ctadsctoFin:BIGINT", dc_params.GetString("id_ctadscto"),
            "@id_user:INT", dc_params["userID"]
            ).RunRow();

            if (!res.Error)
            {
                //if (Convert.ToBoolean(res.Row["isfe"]))
                //{
                //    FacturacionElectro FE = new FacturacionElectro();
                //    Result resFE = FE.EjecutarFacturacion(dc_params.GetString("userID"), res.Row.GetString("key"), "F");
                //}

                String id = res.Row["id"].ToString();
                String nombreview = res.Row["nombreview"].ToString();
                String fecha = res.Row["fecha"].ToString();
                String anomes = res.Row["anomes"].ToString();
                String id_user = res.Row["id_user"].ToString();

                new Contabilizar().ContabilizarDocumento(id, id_user, fecha, anomes, nombreview, null);
            }

            return res;
        }

        public Result FacturarFacturaPos(Dictionary<string, object> dc_params)
        {
            if (!string.IsNullOrEmpty(dc_params["idcaja"].ToString()) && !dc_params["idcaja"].ToString().Equals("0"))
            {
                Result res = dbase.Procedure("[Dbo].ST_MOVFacturarFacturaPos",
                "@id_tipodoc:BIGINT", dc_params["id_tipodoc"],
                "@id_centrocostos:BIGINT", dc_params["idccosto"],
                "@id_caja:BIGINT", dc_params["idcaja"],
                "@fechadoc:VARCHAR:10", dc_params["Fecha"],
                "@id_tercero:BIGINT", dc_params["id_tercero"],
                "@isFe:BIT", dc_params["isFE"],
                "@id_vendedor:BIGINT", dc_params["id_vendedor"],
                "@id_ctaant:BIGINT", dc_params["id_ctaant"],
                "@anticipo:NUMERIC", dc_params["anticipo"],
                "@formapago:XML", dc_params["formapago"],
                "@idToken:VARCHAR:255", dc_params["idToken"],
                "@totalcredito:NUMERIC", dc_params["totalcredito"],
                "@numcuotas:INT", dc_params["cuotas"],
                "@dias:INT", dc_params["dias"],
                "@venini:VARCHAR:10", dc_params["inicial"],
                "@vencimiento:INT", dc_params["ven"],
                "@id_formacred:BIGINT", dc_params["id_formacred"],
                "@id_user:INT", dc_params["userID"]
                ).RunRow();

                if (!res.Error)
                {
                    //if (Convert.ToBoolean(res.Row["isfe"]))
                    //{
                    //    FacturacionElectro FE = new FacturacionElectro();
                    //    Result resFE = FE.EjecutarFacturacion(dc_params.GetString("userID"), res.Row.GetString("key"), "F");
                    //}

                    String id = res.Row["id"].ToString();
                    String nombreview = res.Row["nombreview"].ToString();
                    String fecha = res.Row["fecha"].ToString();
                    String anomes = res.Row["anomes"].ToString();
                    String id_user = dc_params["userID"].ToString();

                    new Contabilizar().ContabilizarDocumento(id, id_user, fecha, anomes, nombreview, null);
                }

                return res;
            }
            else
                return new Result("No tiene caja seleccionada en esta sesión.", true);
        }

        public Result RevertirFactura(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].[ST_MOVRevertirFactura]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunRow();
        }

        public Result FacturarFacturaLoadSet(Dictionary<string, object> dc_params)
        {
            Result res = dbase.FW_LoadSelector("SERVICIOCREDITO", Usuario.UserId, id_otro: dc_params.GetString("id")).RunData();
            res.Table = res.Data.Tables[0].ToList();
            res.Data = null;

            return res;
        }


        public Result FacturasRecalCuotas(Dictionary<string, object> dc_params)
        {
            Result res = dbase.Procedure("[Dbo].[ST_MovFacturaRecCuotas]", "@opcion:int", dc_params["op"], "@SelectCredito:BIGINT", dc_params["SelectCredito"], "@valor:NUMERIC", dc_params["valor"],
            "@idToken:VARCHAR:255", dc_params.GetString("idToken"), "@numcuotas:INT", dc_params["cuotas"],
            "@dias:INT", dc_params["dias"], "@venini:VARCHAR:10", dc_params["inicial"], "@vencimiento:INT", dc_params["ven"]).RunData();

            res.Table = res.Data.Tables[0].ToList();
            res.Data = null;
            return res;
        }

        //funcion que envia al sp buscadorProducto un filtro una opcion que es de char tamaño 1 y otra opcion por si se necesita en el sp
        public object CentroCostoBuscador(Dictionary<string, object> dc_params)
        {
            try
            {

                DataTable Temp = new DataTable();
                Result result = dbase.Procedure("[Dbo].[BuscadorProducto]", "@filtro:VARCHAR:50", dc_params["filtro"], "@opcion:CHAR:1", dc_params["op"], "@op:VARCHAR:2", dc_params["o"]).RunData();
                if (!result.Error)
                {
                    if (result.Data.Tables.Count > 1)
                        Temp = result.Data.Tables[1];

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

        public Result ConversionSaveItemFac(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].ST_MovConversionSaveItemsFact",
            "@factura:VARCHAR(255)", dc_params["factura"],
            "@xml:xml", dc_params["xml"],
            "@id_user:int", dc_params["userID"]).RunRow();
        }
        #endregion

        #region
        public object CotizacionList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[Dbo].[ST_MovCotizacionList]", "@page:int", dc_params.GetString("start"), "@numpage:int",
                    dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0,
                    "@id_user:INT", dc_params.GetString("userID"), "@id_caja:BIGINT", dc_params.GetString("idcaja"), "@estado:VARCHAR:20",
                    dc_params.GetString("estado")).RunData(out outoaram);
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

        public object CotizacionGet(Dictionary<string, object> dc_params)
        {
            try
            {
                Result data = dbase.Procedure("[Dbo].ST_MovCotizacionGet", "@id:int", dc_params.GetString("id")).RunRow();
                return data;
            }
            catch (Exception ex)
            {
                return new { Error = true, Message = ex.Message };
            }
        }

        public Result CotizacionAddArticulo(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].ST_MovCotizacionAddArticulo",
            "@idToken:VARCHAR:255", dc_params["idToken"],
            "@id_articulo:INT", dc_params["id_article"],
            "@id_bodega:INT", dc_params["id_bodega"],
            "@cantidad:NUMERIC", dc_params["quantity"],
            "@precio:NUMERIC", dc_params["precio"],
            "@descuento:NUMERIC", dc_params["descuento"],
            "@cuota_ini:NUMERIC", dc_params["cuota_ini"],
            "@id_user:int", dc_params["userID"]).RunRow();
        }

        public Result FacturarCotizacion(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].ST_MOVFacturarCotizacion",
                        "@id_cliente:BIGINT", dc_params["id_cliente"],
                        "@id_vendedor:BIGINT", dc_params["id_vendedor"],
                        "@id_bodega:BIGINT", dc_params["id_bodega"],
                        "@idToken:VARCHAR:255", dc_params["idToken"],
                        "@descuento:NUMERIC", dc_params["descuento"],
                        "@cuota_ini:NUMERIC", dc_params["cuota_ini"],
                        "@financiero:BIT", dc_params["financiero"],
                        "@id_lincred:BIGINT", dc_params["id_lincred"],
                        "@num_cuot:INT", dc_params["num_cuot"],
                        "@valor_cuot:NUMERIC", dc_params["valor_cuot"],
                        "@id_user:INT", dc_params["userID"]
                        ).RunRow();
        }

        #endregion

        #region
        /// <summary>
        /// FacturacionListErrada
        /// Funcion que consulta los documentos errados que se van a facturar
        /// </summary>
        /// <param name="dc_params"></param>
        /// <returns></returns>
        public object FacturacionElectronicaList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[FE].[ST_FacturacionFelectroList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"),
                                                "@countpage:int:output", 0, "@fecha:VARCHAR:10", dc_params.GetString("fecha"), "@fechafin:VARCHAR:10", dc_params.GetString("fechafin"), "@factura:VARCHAR:30", dc_params.GetString("factura")
                                                , "@estado:VARCHAR:20", dc_params.GetString("state")).RunData(out outoaram);
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

        public Result ProcesoFacturarToken(Dictionary<string, object> dc_params)
        {
            Result res = new Result();
            //FacturacionElectro FE = new FacturacionElectro();
            //res = FE.EjecutarFacturacion(dc_params.GetString("userID"), dc_params.GetString("key"), dc_params.GetString("op"), false, "", "");

            return res;
        }

        public Result FacturarElectronicamente(Dictionary<string, object> dc_params)
        {
            Result res = new Result();
            //FacturacionElectro FE = new FacturacionElectro();

            //res = FE.EjecutarFacturacion(dc_params.GetString("userID"), "", "", true, dc_params.GetString("fechaini"), dc_params.GetString("fechafin"));
            return new Result("Proceso iniciado.", false); ;
        }

        /// <summary>
        /// LogFacturacion
        /// Funcion que consulta el log de una factura errada.
        /// </summary>
        /// <param name="dc_params"></param>
        /// <returns></returns>
        public object FacturarListLog(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[FE].[ST_FacturaciolListLog]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0,
                                                                                   "@id_user:int", dc_params["userID"], "@id:VARCHAR:255", dc_params["id"], "@tipo:INT", dc_params["tipo"]).RunData(out outoaram);
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

        public Result FacturacionReSendMail(Dictionary<string, object> dc_params)
        {
            Result res = new Result();
            res = dbase.Procedure("[FE].[ST_FacturacionSendMail]", "@key:VARCHAR:255", dc_params.GetString("key"), "@tipodoc:INT", dc_params.GetString("tipodoc"), "@email:VARCHAR:200", dc_params.GetString("email"), "@id_user:BIGINT", dc_params.GetString("userID")).RunData();

            if (!res.Error)
            {
                if (res.Data.Tables.Count > 1)
                {
                    if (res.Data.Tables[1].Rows.Count > 0)
                    {
                        Dictionary<string, object> d = res.Data.Tables[0].Rows[0].ToDictionary();
                        //DataTable Tabledoc = res.Data.Tables[1];
                        //FacturacionElectro FE = new FacturacionElectro();
                        //FE.FacturarEnvioCorreo(d, Tabledoc);
                        res.Message = "Proceso de envio, iniciado con exito...";
                    }
                    else
                    {
                        res.Error = true;
                        res.Message = "No hay correos pendientes...";
                        res.Data = null;
                    }
                }
                else
                {
                    res.Error = true;
                    res.Message = "El procedimiento no devuelve la información completa, verificar la consulta ST_FacturacionListMail...";
                    res.Data = null;
                }

            }

            res.Data = null;
            return res;
        }

        #endregion
    }
}