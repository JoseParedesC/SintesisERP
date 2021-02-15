using System;
using System.Collections.Generic;
using System.Data;
using J_W.Vinculation;
using SintesisERP.Pages.Connectors;
using System.Web.Script.Serialization;
using J_W.Estructura;
using SintesisERP.App_Data.Model.Contabilidad;
/// <summary>
/// Descripción breve de Buscadores
/// </summary>
/// 
namespace SintesisERP.App_Data.Model.Inventario
{
    public class FacturasRecurrentes : Session_Entity
    {
        private JavaScriptSerializer jsSerialize;
        public FacturasRecurrentes()
        {
            jsSerialize = new JavaScriptSerializer();
        }

        #region 
        /// <summary>
        /// Facturació
        /// </summary>
        /// <param name="dc_params"></param>
        /// <returns></returns>
        public object FacturasRecurrList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[dbo].[ST_MovFacturasRecurrentesList]", "@page:int", dc_params.GetString("start"), "@numpage:int",
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



        public object FacturasRecurrGet(Dictionary<string, object> dc_params)
        {
            try
            {
                Result data = dbase.Procedure("[dbo].[ST_MovFacturasRecurrGet]", "@id:int", dc_params.GetString("id"), "@op:CHAR:1", dc_params.GetString("op"), "@id_temp:VARCHAR:255", dc_params.GetString("idtemp")).RunRow();
                return data;
            }
            catch (Exception ex)
            {
                return new { Error = true, Message = ex.Message };
            }
        }


        public object FacturasRecurrItemList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[dbo].[ST_MovFacturaRecurrItemList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"),
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
    

        public Result FacturasRecurrenteDelArticulo(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[dbo].[ST_MOVFacturarRecurrenteDelArticulo]",
            "@id_articulo:INT", dc_params["id_articulo"],
            "@id_anticipo:BIGINT", dc_params["id_anticipo"],
            "@idToken:VARCHAR:255", dc_params["idToken"]).RunRow();
        }


        public Result FacturasRecurrente(Dictionary<string, object> dc_params)
        {
            Result res = dbase.Procedure("[dbo].[ST_MOVFacturasRecurrentes]",
            "@id:BIGINT", dc_params["id"],
            "@id_tipodoc:BIGINT", dc_params["id_tipodoc"],
            "@id_centrocostos:BIGINT", dc_params["id_centrocostos"],
            "@id_formapagos:BIGINT", dc_params["cd_formapagos"],
            "@fechadoc:VARCHAR:10", dc_params["Fecha"],
            "@id_tercero:BIGINT", dc_params["id_tercero"],
            "@id_vendedor:BIGINT", dc_params["id_vendedor"],
            "@idToken:VARCHAR:255", dc_params["idToken"],
            "@id_user:INT", dc_params["userID"]
            ).RunRow();
            return res;
        }


        public object MovFacturasSave(Dictionary<string, object> dc_params)
        {
            try
            {
                String facturas = dc_params["facturaSelect"].ToString();
                char coma = ',';
                string[] datos = facturas.Split(coma);
                Result res = null;
                for (var i = 0; i < datos.Length - 1; i++)
                {
                    res = dbase.Procedure("[dbo].[ST_MOVFacturaRecurrenteSave]",
                     "@Id:BIGINT", datos[i]
                     ).RunRow();
                    if (res.Error)
                    {
                        i = datos.Length;
                    }
                }

                return res;
            }
            catch(Exception ex)
            {
                return new { error = 1, errorMesage = ex.Message };
            }
        }

        public Result ServicioSetRecurrente(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[dbo].[ST_MovServicioSetRecurrenteItem]",
                    "@id:INT", dc_params["id"],
                    "@column:VARCHAR:20", dc_params["column"],
                    "@valor:NUMERIC", dc_params["value"]
            ).RunRow();
        }


        #endregion
    }
}