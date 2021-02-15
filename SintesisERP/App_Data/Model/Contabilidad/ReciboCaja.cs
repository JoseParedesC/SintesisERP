using System;
using System.Collections.Generic;
using System.Data;
using SintesisERP.Pages.Connectors;
using System.Web.Script.Serialization;
using J_W.Estructura;

namespace SintesisERP.App_Data.Model.Contabilidad
{
    public class ReciboCaja : J_W.Vinculation.Session_Entity
    {
        private JavaScriptSerializer jsSerialize;
        public ReciboCaja()
        {
            jsSerialize = new JavaScriptSerializer();
        }


        public object CuotaCLienteList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[CNT].[ST_CuotasxClienteList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0, "@id_cliente:BIGINT", dc_params["id_cliente"], "@id_recibo:BIGINT", dc_params["id_recibo"], "@fecha:VARCHAR:50", dc_params["fecha"]).RunData(out outoaram);
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

        public object ReciboCajaConceptoList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[CNT].[ST_MOVReciboCajaConceptoList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0, "@id_recibo:BIGINT", dc_params["id_recibo"]).RunData(out outoaram);
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

        public Result ReciboCajaSave(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[CNT].[ST_MOVRecibosCajaSave]",

                "@id:BIGINT", dc_params["id"],
                "@id_tipodoc:BIGINT", dc_params["id_tipodoc"],
                "@id_centrocosto:BIGINT", dc_params["id_centrocostos"],
                "@fecha:VARCHAR:10", dc_params["fecha"],
                "@id_cliente:BIGINT", dc_params["id_cliente"],
                "@formapago:XML", dc_params["formapago"],
                "@id_conceptoDescuento:BIGINT", dc_params["idconceptoDscto"],
                "@valorDescuento:NUMERIC", dc_params["valorDscto"],
                "@cambio:NUMERIC", dc_params["cambio"],
                "@valorclie:NUMERIC", dc_params["valorclie"],
                "@valorconcepto:NUMERIC", dc_params["valorconcepto"],
                "@pagosXml:VARCHAR:-1", dc_params["pagosXML"],
                "@detalle:VARCHAR:-1", dc_params["detalle"],
                "@conceptosxml:VARCHAR:-1", dc_params["xmlconceptos"],
                "@id_user:NUMERIC", dc_params["userID"]).RunRow();
        }

        public Result RevertirReciboCaja(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[CNT].[ST_MOVRevertirReciboCajas]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunRow();
        }

        public Result ReciboCajaGet(Dictionary<string, object> dc_params)
        {
            Result data = dbase.Procedure("[CNT].[ST_MOVReciboCajaGet]", "@id:BIGINT", dc_params["id"]).RunData();
            if (data.Data.Tables[0].Rows.Count > 0)
                data.Row = data.Data.Tables[0].Rows[0].ToDictionary();
            data.Table = data.Data.Tables[1].ToList();
            data.Data = null;
            return data;
        }
        public object MOvFacturaList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
				Boolean all = true;
                if (dc_params.GetString("all").Equals("0"))
                    all = false;			
                Result result = dbase.Procedure("[dbo].[ST_MOVFacturaCuotasList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@countpage:int:output", 0, "@id_factura:varchar:50", dc_params.GetString("id_factura"), "@porceinteres:NUMERIC", dc_params.GetString("porceinteres"), "@fecha:VARCHAR:10", dc_params.GetString("fecha")).RunData(out outoaram);
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

        public object RecibosCajaList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[CNT].[ST_MOVReciboCajaList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0).RunData(out outoaram);
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