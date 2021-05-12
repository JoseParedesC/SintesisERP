using System;
using System.Collections.Generic;
using System.Data;
using J_W.Estructura;
using J_W.Vinculation;
using SintesisERP.Pages.Connectors;
using System.Web.Script.Serialization;
/// <summary>
/// Descripción breve de Buscadores
/// </summary>
/// 
namespace SintesisERP.App_Data.Model.Nomina
{
    public class Seg_social : Session_Entity
    {
        private JavaScriptSerializer jsSerialize;
        public Seg_social()
        {
            jsSerialize = new JavaScriptSerializer();
        }

        #region
        /// <summary>
        /// Metodo Cargar Terceros
        /// Este metodo es utilizado para recibir el filtro de busqueda y conectarse a la BD 
        /// Terceros  
        /// </summary>
        /// <returns> 
        /// La lista de Terceros encontradas
        /// </returns>
        public object SegsocialList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[NOM].[ST_SegsocialList]", "@id_tiposeg:int", dc_params.GetString("id_seg"), "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0).RunData(out outoaram);
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
        /// Metodo  Guardar Terceros
        /// Este metodo es utilizado para guardar o editar en BD
        /// Terceros
        /// </summary>
        /// <returns> 
        /// id Terceros
        /// </returns>
        public Result SegsocialSave(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[NOM].[ST_SegsocialSave]",
             "@id:BIGINT", dc_params["id"],
             "@id_tiposeg:BIGINT", dc_params["id_tiposeg"],
             "@nombre:VARCHAR:60", dc_params["nombre"],
             "@codext:VARCHAR:10", dc_params["codext"],
             "@contrapartida:BIGINT", dc_params["contrapartida"],
             "@id_user:int", dc_params["userID"]).RunScalar();
        }

        /// <summary>
        /// Metodo Eliminar Terceros
        /// Este metodo es utilizado para eliminar un registro en BD solo si no ha sido referenciado en otras tablas
        /// Terceros
        /// </summary>
        /// <returns> 
        /// id Terceros
        /// </returns>
        public Result SegsocialDelete(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[NOM].[ST_SegsocialDelete]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunScalar();
        }
        /// <summary>
        /// Metodo consultar Terceros
        /// Este metodo es utilizado para consultar en BD atra vez de id
        /// Terceros
        /// </summary>
        /// <returns> 
        /// Datos de la Terceros
        /// </returns>
        public Result SegsocialGet(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[NOM].[ST_SegsocialGet]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunRow();
        }

        #endregion
    }


}
