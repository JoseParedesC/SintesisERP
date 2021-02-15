using System;
using System.Collections.Generic;
using System.Data;
using SintesisERP.Pages.Connectors;
using System.Web.Script.Serialization;
using J_W.Estructura;

namespace SintesisERP.App_Data.Model.Contabilidad
{
    public class CNTImpuestos : J_W.Vinculation.Session_Entity
    {
        private JavaScriptSerializer jsSerialize;
        public CNTImpuestos()
        {
            jsSerialize = new JavaScriptSerializer();
        }
        /// <summary>
        /// Metodo Cargar Impuestos
        /// Este metodo es utilizado para recibir el filtro de busqueda y conectarse a la BD 
        /// Impuestos  
        /// </summary>
        /// <returns> 
        /// La lista de Impuestos encontradas
        /// </returns>
        public object CNTImpuestosList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[CNT].[ImpuestosList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0).RunData(out outoaram);
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
        /// Metodo  Guardar Impuestos
        /// Este metodo es utilizado para guardar o editar en BD
        /// Impuestos
        /// </summary>
        /// <returns> 
        /// id Impuestos
        /// </returns>
        public Result CNTImpuestosSave(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[CNT].ImpuestosSave", "@id:BIGINT", dc_params["id"],
            "@codigo:VARCHAR:4", dc_params["codigo"],
            "@nombre:VARCHAR:50", dc_params["nombre"],
            "@id_tipoimp:BIGINT", dc_params["id_tipoimp"],
            "@Valor:NUMERIC", dc_params["valor"],
            "@id_ctaventa:bigint", dc_params["id_ctaventa"],
            "@id_ctadevventa:bigint", dc_params["id_ctadevventa"],
            "@id_ctacompra:bigint", dc_params["id_ctacompra"],
            "@id_ctadevcompra:bigint", dc_params["id_ctadevcompra"], 
            "@id_usercreated:bigint", dc_params["userID"],
            "@id_userupdated:bigint", dc_params["userID"]).RunScalar();
           
            
        }
        /// <summary>
        /// Metodo Cambiarestado Impuesto
        /// Este metodo es utilizado para cambiar el estado en BD 
        /// Impuestos
        /// </summary>
        /// <returns> 
        /// id impuesto
        /// </returns>
        public Result CNTImpuestosState(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[CNT].[ImpuestosState]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunScalar();
        }
        /// <summary>
        /// Metodo Eliminar Impuesto
        /// Este metodo es utilizado para eliminar un registro en BD solo si no ha sido referenciado en otras tablas
        /// Impuestos
        /// </summary>
        /// <returns> 
        /// id impuesto
        /// </returns>
        public Result CNTImpuestosDelete(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[CNT].[ImpuestosDelete]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunScalar();
        }
        /// <summary>
        /// Metodo consultar Impuesto
        /// Este metodo es utilizado para consultar en BD atra vez de id
        /// Impuesto
        /// </summary>
        /// <returns> 
        /// Datos de la Impuesto
        /// </returns>
        public Result CNTImpuestosGet(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[CNT].[ImpuestosGet]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunRow();
        }
    }
}