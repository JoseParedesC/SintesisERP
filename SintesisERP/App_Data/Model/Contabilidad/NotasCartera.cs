using System;
using System.Collections.Generic;
using System.Data;
using J_W.Vinculation;
using SintesisERP.Pages.Connectors;
using System.Web.Script.Serialization;
using J_W.Estructura;
using J_W.Herramientas;
/// <summary>
/// Descripción breve de Buscadores
/// </summary>
/// 
namespace SintesisERP.App_Data.Model.Contabilidad
{
    public class NotasCartera : Session_Entity
    {
        private JavaScriptSerializer jsSerialize;
        public NotasCartera()
        {
            jsSerialize = new JavaScriptSerializer();
        }
        /// <summary>
        /// Metodo listar saldos
        /// Este metodo es utilizado para listar los saldos del tercero seleccionado (cliente o proveedor)
        /// Saldos  
        /// </summary>
        /// <returns> 
        /// La lista de Saldos encontrados
        /// </returns>
        public object SaldosList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[CNT].[ST_SaldosList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0, "@id_tercero:BIGINT", dc_params["id_tercero"], "@tipoterce:VARCHAR:2", dc_params["tipoterce"], "@fecha:VARCHAR:50", dc_params["fecha"], "@id_cuenta:VARCHAR:50", dc_params["cuenta"]).RunData(out outoaram);
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
        /// Metodo listar saldos
        /// Este metodo es utilizado para listar los saldos del tercero seleccionado (cliente o proveedor)
        /// Saldos  
        /// </summary>
        /// <returns> 
        /// La lista de SaldosCuotas encontrados
        /// </returns>
        public object SaldosCuotaList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[CNT].[ST_SaldosCuotasList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0, "@id_tercero:BIGINT", dc_params["id_tercero"], "@nrofactura:VARCHAR:100", dc_params["nrofactura"], "@fecha:VARCHAR:50", dc_params["fecha"], "@id_cuenta:VARCHAR:50", dc_params["cuenta"]).RunData(out outoaram);
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
        /// Metodo consultar Anticipos
        /// Este metodo es utilizado para consultar en BD atra vez de id
        /// Anticipo
        /// </summary>
        /// <returns> 
        /// Datos de Anticipo
        /// </returns>
        public Result SaldosGET(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[CNT].[ST_SaldosGET]", "@id_saldo:bigint", dc_params.GetString("id"), "@tipoterce:VARCHAR:2", dc_params.GetString("tipoterce"), "@fecha:VARCHAR:10", dc_params.GetString("fecha"), "@id_cliente:BIGINT", dc_params.GetString("id_cliente"), "@nrofactura:VARCHAR:50", dc_params.GetString("nrofactura"), "@id_cuenta: BIGINT", dc_params["cuenta"]).RunRow();
        }
        /// <summary>
        /// Metodo  Facturar Anticipo
        /// Este metodo es utilizado para guardar o editar en BD
        /// Anticipos
        /// </summary>
        /// <returns> 
        /// id Anticipo
        /// </returns>
        public Result NotasCarteraSave(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[CNT].ST_MOVNotasCarteraSave",
            "@id_tipodoc:BIGINT", dc_params["id_tipodoc"],
            "@id_centrocostos:BIGINT", dc_params["id_centrocostos"],
            "@fecha:VARCHAR:10", dc_params["fecha"],
            "@tipo_tercero:VARCHAR:2", dc_params["tipoterce"],
            "@id_tercero:BIGINT", dc_params["id_tercero"],
            "@id_saldo:BIGINT", dc_params["id_saldo"],
            "@id_ctaant:BIGINT", dc_params["id_cuentaant"],
            "@id_ctaact:BIGINT", dc_params["id_cuentaact"],
            "@detalle:VARCHAR:-1", dc_params["detalle"],
            "@vencimientoact:VARCHAR:10", dc_params["vencimientoact"],
            "@saldoActual:NUMERIC", dc_params["saldoactual"],
            "@tipoVenci:INT", dc_params["tipovenci"],
            "@Dias:INT", dc_params["dias"],
            "@cuota:INT", dc_params["cuota"],
            "@Numcuota:INT", dc_params["cantcuota"],
            "@ChangeCuote:BIT", dc_params["changecuota"],
            "@id_user:int", dc_params["userID"]
            ).RunRow();
        }
        /// <summary>
        /// Metodo  Reversion Anticipo
        /// Este metodo revierte un anticipo facturado
        /// Anticipos
        /// </summary>
        /// <returns> 
        /// id Anticipo
        /// </returns>
        public Result RevertirNotasCartera(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[CNT].[ST_MOVRevertirNotasCartera]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunRow();
        }
        public object MOvNotasItemsList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[CNT].[ST_MOVNotasCarteraItemsList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@countpage:int:output", 0, "@id_factura:varchar:50", dc_params.GetString("id_factura"), "@tipotercero:VARCHAR", dc_params.GetString("tipotercero"), "@fecha:VARCHAR:10", dc_params.GetString("fecha")).RunData(out outoaram);
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
        /// Metodo listar anticipos por cliente
        /// Este metodo es utilizado para recibir el filtro de busqueda y conectarse a la BD 
        /// Bodega  
        /// </summary>
        /// <returns> 
        /// La lista de anticipos encontrados por cliente
        /// </returns>
        public object NotasCarteraList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[CNT].[ST_MOVNotasCarteraList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0).RunData(out outoaram);
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
        /// Metodo Consultar notas de cartera
        /// Este metodo es consultar por id una nota de cartera creada
        /// NotasCartera  
        /// </summary>
        /// <returns> 
        ///Datos de nota de cartera seleccionada
        /// </returns>
        public Result NotasCarteraGet(Dictionary<string, object> dc_params)
        {
            Result data = dbase.Procedure("[CNT].[ST_MOVNotasCarteraGet]", "@id:BIGINT", dc_params["id"]).RunData();
            if (data.Data.Tables[0].Rows.Count > 0)
                data.Row = data.Data.Tables[0].Rows[0].ToDictionary();

            data.Data = null;
            return data;
        }
    }
}
