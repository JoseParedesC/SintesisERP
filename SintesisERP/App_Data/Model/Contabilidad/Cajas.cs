using System.Collections.Generic;
using System.Data;
using J_W.Estructura;
using J_W.Vinculation;
using SintesisERP.Pages.Connectors;
using System.Web.Script.Serialization;
using System;
/// <summary>
/// Descripción breve de Buscadores
/// </summary>
/// 
namespace SintesisERP.App_Data.Model.Contabilidad
{
    public class Cajas : Session_Entity
    {
        private JavaScriptSerializer jsSerialize;
        public Cajas()
        {
            jsSerialize = new JavaScriptSerializer();
        }
        /// <summary>
        /// Metodo Cargar Cajas
        /// Este metodo es utilizado para recibir el filtro de busqueda y conectarse a la BD 
        /// Cajas  
        /// </summary>
        /// <returns> 
        /// La lista de Cajas encontradas
        /// </returns>
        public object CajasList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[Dbo].[CajasList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0).RunData(out outoaram);
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
        /// Metodo Cambiarestado estado
        /// Este metodo es utilizado para cambiar el estado en BD 
        /// Cajas
        /// </summary>
        /// <returns> 
        /// id Cajas
        /// </returns>
        public Result CajasSave(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].CajasSave",
            "@id:BIGINT", dc_params["id"],
            "@codigo:VARCHAR:10", dc_params["codigo"],
            "@nombre:VARCHAR:50", dc_params["nombre"],
            "@id_bodega:BIGINT", dc_params["id_wineri"],
            "@id_cliente:BIGINT", dc_params["id_client"],
            "@id_vendedor:BIGINT", dc_params["id_vendedor"],
            "@id_centrocosto:BIGINT", dc_params["id_centrocosto"],
            "@id_cuenta:BIGINT", dc_params["id_account"],
            "@id_cuentaant:BIGINT", dc_params["id_accountant"],
            "@piecera:VARCHAR:-1", dc_params["foodpage"],
            "@cabecera:VARCHAR:-1", dc_params["headpage"],
            "@id_user:int", dc_params["userID"]).RunScalar();
        }
        
        public Result CajasState(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].[CajasState]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunScalar();
        }
        /// <summary>
        /// Metodo Eliminar Cajas
        /// Este metodo es utilizado para eliminar un registro en BD solo si no ha sido referenciado en otras tablas
        /// Cajas
        /// </summary>
        /// <returns> 
        /// id Cajas
        /// </returns>
        public Result CajasDelete(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].[CajasDelete]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunScalar();
        }
        /// <summary>
        /// Metodo consultar Cajas
        /// Este metodo es utilizado para consultar en BD atra vez de id
        /// Cajas
        /// </summary>
        /// <returns> 
        /// Datos de la Cajas
        /// </returns>
        public Result CajasGet(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].[CajasGet]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunRow();
        }

        public Result CajaUser(object idUser)
        {
            return dbase.Procedure("[Dbo].[ST_CajasUser]", "@id:BIGINT", idUser).RunRow();
        }
        
    }
}