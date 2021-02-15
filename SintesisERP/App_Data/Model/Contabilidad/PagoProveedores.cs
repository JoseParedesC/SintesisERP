using System;
using System.Collections.Generic;
using System.Data;
using SintesisERP.Pages.Connectors;
using System.Web.Script.Serialization;
using J_W.Estructura;

namespace SintesisERP.App_Data.Model.Contabilidad
{
    public class PagoProveedores : J_W.Vinculation.Session_Entity
    {
        private JavaScriptSerializer jsSerialize;
        public PagoProveedores()
        {
            jsSerialize = new JavaScriptSerializer();
        }

        public object PagoProveedoresList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[CNT].[ST_EntradasxPagarList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0, "@id_proveedor:BIGINT", dc_params["id_proveedor"], "@id_comprobante:BIGINT", dc_params["id_comprobante"], "@fecha:VARCHAR:50", dc_params["fecha"]).RunData(out outoaram);
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

        public object PagoProveedoresConceptoList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[CNT].[ST_MOVComprobantesEgresosConceptoList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0, "@id_comprobante:BIGINT", dc_params["id_comprobante"]).RunData(out outoaram);
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
        public Result PagoProveedor(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[CNT].[ST_MOVSaldoProveedor]",
                "@Opcion:VARCHAR:5", dc_params["op"],
                "@id:BIGINT", dc_params["id"],
                "@id_proveedor:BIGINT", dc_params["id_proveedor"],
                "@tipo:CHAR", dc_params["tipo"],
                "@pago:NUMERIC", dc_params["valorpagar"],
                "@formapago:BIGINT", dc_params["formapago"],
                "@id_user:NUMERIC", dc_params["userID"]).RunScalar();
        }
        public Result ComprobantesEgresosSave(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[CNT].[ST_MOVComprobantesEgresosSave]",
                "@id:BIGINT", dc_params["id"],
                "@id_tipodoc:BIGINT", dc_params["id_tipodoc"],
                "@id_centrocosto:BIGINT", dc_params["id_centrocostos"],
                "@fecha:VARCHAR:10", dc_params["fecha"],
                "@id_proveedor:BIGINT", dc_params["id_proveedor"],
                 "@cambio:NUMERIC", dc_params["cambio"],
                "@valorprov:NUMERIC", dc_params["valorproveedor"],
                "@valorconcepto:NUMERIC", dc_params["valorconcepto"],
                "@pagosXml:VARCHAR:-1", dc_params["pagosXML"],
                "@detalle:VARCHAR:-1", dc_params["detalle"],
                "@conceptosxml:VARCHAR:-1", dc_params["xmlconceptos"],
                "@formapago:XML", dc_params["formapago"],
				"@id_ctaant:BIGINT", dc_params["id_ctaant"],
                "@valoranticipo:NUMERIC", dc_params["anticipo"],											
                "@id_user:NUMERIC", dc_params["userID"]).RunRow();
        }

        public Result RevertirPago(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[CNT].[ST_MOVRevertirComprobantesEgresos]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunRow();
        }

        public Result PagoProveedoresGet(Dictionary<string, object> dc_params)
        {
            Result res = dbase.Procedure("[CNT].[ST_MOVComprobantesEgresosGet]", "@id:BIGINT", dc_params["id"]).RunRow();
            return res;
        }
        public object ComprobantesEgresosList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[CNT].[ST_MOVComprobantesEgresosList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0).RunData(out outoaram);
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