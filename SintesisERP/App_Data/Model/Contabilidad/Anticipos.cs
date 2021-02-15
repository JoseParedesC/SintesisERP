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
    public class Anticipos : Session_Entity
    {
        private JavaScriptSerializer jsSerialize;
        public Anticipos()
        {
            jsSerialize = new JavaScriptSerializer();
        }
        /// <summary>
        /// Metodo listar anticipos
        /// Este metodo es utilizado para recibir el filtro de busqueda y conectarse a la BD 
        /// Bodega  
        /// </summary>
        /// <returns> 
        /// La lista de anticipos encontrados
        /// </returns>
        public object AnticiposList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[Dbo].[ST_MOVAnticipoList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"),
                    "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0, "@id_user:INT", dc_params.GetString("userID")).RunData(out outoaram);
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
        /// <summary>
        /// Metodo consultar Anticipos
        /// Este metodo es utilizado para consultar en BD atra vez de id
        /// Anticipo
        /// </summary>
        /// <returns> 
        /// Datos de Anticipo
        /// </returns>
        public Result AnticiposGet(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].ST_MovAnticipoGet", "@id:int", dc_params.GetString("id")).RunRow();
        }
        /// <summary>
        /// Metodo  Facturar Anticipo
        /// Este metodo es utilizado para guardar o editar en BD
        /// Anticipos
        /// </summary>
        /// <returns> 
        /// id Anticipo
        /// </returns>
        public Result FacturarAnticipos(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].ST_MOVFacturarAnticipo",
            "@id_tipodoc:BIGINT", dc_params["id_tipodoc"],
            "@id_centrocostos:BIGINT", dc_params["id_centrocostos"],
            "@fecha:VARCHAR:10", dc_params["fecha"],
            "@descripcion:VARCHAR:-1", dc_params["descripcion"],
            "@id_tipoanticipo:BIGINT", dc_params["id_tipoanticipo"],
            "@id_tercero:BIGINT", dc_params["id_tercero"],
            "@valor:NUMERIC", dc_params["valor"],
            "@id_forma:INT", dc_params["id_forma"],
            "@voucher:VARCHAR:200", dc_params["voucher"],
            "@id_ctaant:BIGINT", dc_params["idctaant"],
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
        public Result RevertirAnticipos(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].[ST_MOVRevertirAnticipo]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunRow();
        }



        #region
        public object DevAnticiposList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[Dbo].[ST_MOVDevAnticipoList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"),
                    "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0,
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

        public Result DevAnticiposGet(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].ST_MovDevAnticipoGet", "@id:int", dc_params.GetString("id")).RunRow();
        }

        public Result FacturarDevAnticipos(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].ST_MOVFacturarDevAnticipo",
             "@id_tipodoc:BIGINT", dc_params["id_tipodoc"],
            "@id_centrocostos:BIGINT", dc_params["id_centrocostos"],
            "@fecha:VARCHAR:10", dc_params["fecha"],
            "@descripcion:VARCHAR:-1", dc_params["descripcion"],
            "@id_cliente:BIGINT", dc_params["id_cliente"],
            "@id_tipoanticipo:BIGINT", dc_params["id_tipoanticipo"],		
            "@id_cta:BIGINT", dc_params["id_cta"],
            "@id_formapago:BIGINT", dc_params["id_forma"],
            "@valor:NUMERIC", dc_params["valor"],
            "@id_user:int", dc_params["userID"]
            ).RunRow();
        }

        public Result RevertirDevAnticipos(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].[ST_MOVRevertirDevAnticipo]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunRow();
           
        }



        #endregion

        /// <summary>
        /// Metodo listar anticipos por cliente
        /// Este metodo es utilizado para recibir el filtro de busqueda y conectarse a la BD 
        /// Bodega  
        /// </summary>
        /// <returns> 
        /// La lista de anticipos encontrados por cliente
        /// </returns>
        public object AnticiposFacturaList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[Dbo].[ST_MovFacturaAnticipoList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"),
                    "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0,
                    "@id_cliente:INT", dc_params.GetString("id_cliente"), "@id_caja:BIGINT", dc_params.GetString("idcaja")).RunData(out outoaram);
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
    }
}