using System;
using System.Collections.Generic;
using System.Data;
using SintesisERP.Pages.Connectors;
using System.Web.Script.Serialization;
using J_W.Estructura;

namespace SintesisERP.App_Data.Model.Contabilidad
{
    public class CNTTipodocumentos : J_W.Vinculation.Session_Entity
    {
        private JavaScriptSerializer jsSerialize;
        public CNTTipodocumentos()
        {
            jsSerialize = new JavaScriptSerializer();
        }

        /// <summary>
        /// Metodo Cargar Tipo de documento
        /// Este metodo es utilizado para recibir el filtro de busqueda y conectarse a la BD 
        /// Tipos de documentos
        /// </summary>
        /// <returns> 
        /// La lista de Tipos de documentos encontradas
        /// </returns>
        public object CNTTipodocumentosList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[CNT].[TiposDocumentosList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0).RunData(out outoaram);
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
        /// Metodo  Guardar Tipos de documentos
        /// Este metodo es utilizado para guardar o editar en BD
        /// Tipo de documento
        /// </summary>
        /// <returns> 
        /// id Tipo de documento
        /// </returns>
        public Result CNTTipodocumentossSave(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[CNT].TiposDocumentosSave", "@id:BIGINT", dc_params["id"],
            "@codigo:VARCHAR:4", dc_params["codigo"],
            "@nombre:VARCHAR:50", dc_params["nombre"],
            "@id_tipo:INT",dc_params["id_tipo"],
            "@isccosto:bit", dc_params["ISCcosto"],
            "@id_centrocosto:bigint", dc_params["id_ccostos"],
            "@id_usercreated:bigint", dc_params["userID"],
            "@id_userupdated:bigint", dc_params["userID"]).RunScalar();

            
        }
        /// <summary>
        /// Metodo Cambiar estado tipos de documentos
        /// Este metodo es utilizado para cambiar el estado en BD 
        /// tipo de documento
        /// </summary>
        /// <returns> 
        /// id tipo de documento
        /// </returns>
        public Result CNTTipodocumentosState(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[CNT].[TiposDocumentosState]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunScalar();
        }
        /// <summary>
        /// Metodo Eliminar Tipos de documentos
        /// Este metodo es utilizado para eliminar un registro en BD solo si no ha sido referenciado en otras tablas
        /// tipo de documento
        /// </summary>
        /// <returns> 
        /// id tipo de documento
        /// </returns>
        public Result CNTTipodocumentosDelete(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[CNT].[TiposDocumentosDelete]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunScalar();
        }
        /// <summary>
        /// Metodo consultar Tipos de documentos
        /// Este metodo es utilizado para consultar en BD atra vez de id
        /// Tipo de documento
        /// </summary>
        /// <returns> 
        /// Datos del Tipo de documentos
        /// </returns>
        public Result CNTTipodocumentosGet(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[CNT].[TiposDocumentosGet]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunRow();
        }
    }
}