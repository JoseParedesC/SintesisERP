using System;
using System.Collections.Generic;
using System.Data;
using SintesisERP.Pages.Connectors;
using System.Web.Script.Serialization;
using J_W.Estructura;

namespace SintesisERP.App_Data.Model.Contabilidad
{
    public class FormaPago : J_W.Vinculation.Session_Entity
    {
        private JavaScriptSerializer jsSerialize;
        public FormaPago()
        {
            jsSerialize = new JavaScriptSerializer();
        }
        /// <summary>
        /// Metodo Cargar Formas de Pagos
        /// Este metodo es utilizado para recibir el filtro de busqueda y conectarse a la BD 
        /// Forma de pagos  
        /// </summary>
        /// <returns> 
        /// La lista de Formas de pagos encontradas
        /// </returns>
        public object FormaPagoList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[Dbo].[FormasPagosList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0).RunData(out outoaram);
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
        /// Metodo  Guardar Formas de Pagos
        /// Este metodo es utilizado para guardar o editar en BD
        /// Forma de Pagos
        /// </summary>
        /// <returns> 
        /// id Forma de pagos
        /// </returns>
        public Result FormaPagoSave(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].FormasPagosSave", "@id:BIGINT", dc_params["id"],
            "@codigo:VARCHAR:20", dc_params["codigo"],
            "@nombre:VARCHAR:50", dc_params["nombre"],
            "@tipo:int", dc_params["id_tipo"],
            "@voucher:bit", dc_params["voucher"],
            "@id_typeFE:int", dc_params["id_typoFE"],
            "@id_cuenta:BIGINT", dc_params["id_cuenta"],
            "@id_usercreated:BIGINT", dc_params["userID"],
            "@id_userupdated:BIGINT", dc_params["userID"]).RunScalar();
        }
        /// <summary>
        /// Metodo Cambiarestado estado
        /// Este metodo es utilizado para cambiar el estado en BD 
        /// Forma de Pagos
        /// </summary>
        /// <returns> 
        /// id Forma de Pagos
        /// </returns>
        public Result FormaPagoState(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].[FormasPagosState]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunScalar();
        }
        /// <summary>
        /// Metodo Eliminar Forma de pagos
        /// Este metodo es utilizado para eliminar un registro en BD solo si no ha sido referenciado en otras tablas
        /// Forma de Pagos
        /// </summary>
        /// <returns> 
        /// id Forma de Pagos
        /// </returns>
        public Result FormaPagoDelete(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].[FormasPagosDelete]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunScalar();
        }
        /// <summary>
        /// Metodo consultar Forma de pagos
        /// Este metodo es utilizado para consultar en BD atra vez de id
        /// Forma de Pagos
        /// </summary>
        /// <returns> 
        /// Datos de Forma de pagos
        /// </returns>
        public Result FormaPagoGet(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].[FormasPagosGet]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunRow();
        }
        public object CargaListadoFormaPago(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[Dbo].[ST_CargarListado]", "@c_op:VARCHAR:20", dc_params["tipoListado"], "@v_param:VARCHAR:50", null, "@id_user:int", dc_params["userID"]).RunData(out outoaram);
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