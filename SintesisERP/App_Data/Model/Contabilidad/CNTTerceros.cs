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
namespace SintesisERP.App_Data.Model.Contabilidad
{
    public class CNTTerceros : Session_Entity
    {
        private JavaScriptSerializer jsSerialize;
        public CNTTerceros()
        {
            jsSerialize = new JavaScriptSerializer();
        }
        /// <summary>
        /// Metodo Cargar Terceros
        /// Este metodo es utilizado para recibir el filtro de busqueda y conectarse a la BD 
        /// Terceros  
        /// </summary>
        /// <returns> 
        /// La lista de Terceros encontradas
        /// </returns>
        public object CNTTercerosList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[CNT].[TercerosList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0).RunData(out outoaram);
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
        /// Metodo Cargar Terceros
        /// Este metodo es utilizado para recibir el filtro de busqueda x tipos (codeudor,cliente o proveedor) y conectarse a la BD 
        /// Terceros  
        /// </summary>
        /// <returns> 
        /// La lista de Terceros encontradas
        /// </returns>
        public object CNTTercerosListTipo(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[CNT].[TercerosListTipo]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0, "@tipo:VARCHAR:2", dc_params["tipoter"]).RunData(out outoaram);
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
        public Result CNTTercerosSave(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[CNT].TercerosSave",
             "@id:BIGINT", dc_params["id"],
             "@tipoperso:INT", dc_params["tipoper"],
             "@iden:VARCHAR:50", dc_params["iden"],
             "@tipoiden:INT", dc_params["type"],
             "@id_catfiscal:BIGINT", dc_params["id_catfiscal"],
             "@digitoveri:CHAR:1", dc_params["digiveri"],
             "@primernombre:VARCHAR:50", dc_params["firstname"],
             "@segundonombre:VARCHAR:50", dc_params["secondname"],
             "@primerapellido:VARCHAR:50", dc_params["surname"],
             "@segundoapellido:VARCHAR:50", dc_params["secondsurname"],
             "@razonsocial:VARCHAR:100", dc_params["razonsocial"],
             "@sucursal:VARCHAR:50", dc_params["brash"],
             "@tiporegimen:BIT", dc_params["typeregimen"],
             "@nombrecomercio:VARCHAR:50", dc_params["tradename"],
             "@pageweb:VARCHAR:50", dc_params["pageweb"],
             "@fechaexpedicion:VARCHAR", dc_params["dateexped"],
             "@fechanacimiento:VARCHAR", dc_params["datebirth"],
             "@direccion:VARCHAR:100", dc_params["address"],
             "@telefono:VARCHAR:50", dc_params["phone"],
             "@celular:VARCHAR:50", dc_params["cellphone"],
             "@email:VARCHAR:100", dc_params["email"],
             "@id_ciudad:VARCHAR:50", dc_params["cd_city"],
             "@nombrecontacto:VARCHAR:200", dc_params["contactname"],
             "@telefonocontacto:VARCHAR:20", dc_params["contactphone"],
             "@emailcontacto:VARCHAR:100", dc_params["emailcontacto"],
             "@tiposTercero:VARCHAR:-1", dc_params["typethird"],
             "@id_user:int", dc_params["userID"]).RunScalar();
        }

        /// <summary>
        /// Metodo Cambiarestado estado
        /// Este metodo es utilizado para cambiar el estado en BD 
        /// Terceros
        /// </summary>
        /// <returns> 
        /// id Terceros
        /// </returns>
        public Result CNTTercerosState(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[CNT].[TercerosState]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunScalar();
        }
        /// <summary>
        /// Metodo Eliminar Terceros
        /// Este metodo es utilizado para eliminar un registro en BD solo si no ha sido referenciado en otras tablas
        /// Terceros
        /// </summary>
        /// <returns> 
        /// id Terceros
        /// </returns>
        public Result CNTTercerosDelete(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[CNT].[TercerosDelete]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunScalar();
        }
        /// <summary>
        /// Metodo consultar Terceros
        /// Este metodo es utilizado para consultar en BD atra vez de id
        /// Terceros
        /// </summary>
        /// <returns> 
        /// Datos de la Terceros
        /// </returns>
        public Result CNTTercerosGet(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[CNT].[TercerosGet]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunRow();
        }

        //Metodos para interfaz de Terceros integrales se consultaras facturas realizadas por el tercero seleccionado

        public object TerceroFacturasList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[CNT].[ST_TerceroFacturasList]", "@page:int", dc_params.GetString("start"), "@numpage:int",
                    dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0,
                    "@id_tercero:BIGINT", dc_params.GetString("id_tercero"), "tipoterce:VARCHAR:2", dc_params.GetString("tipotercero"), "@all:INT", dc_params.GetString("all"), "@fecha:VARCHAR:10", dc_params["Fecha"]).RunData(out outoaram);
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
        public object TerceroPagosList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[CNT].[ST_TerceropagosList]", "@page:int", dc_params.GetString("start"), "@numpage:int",
                    dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0,
                    "@id_factura:VARCHAR(50)", dc_params.GetString("id_factura"), "tipoterce:VARCHAR:2", dc_params.GetString("tipotercero"), 
                    "@fecha:VARCHAR:10", dc_params["Fecha"], "@id_user:INT", dc_params.GetString("userID"), "@id_cuenta:BIGINT", dc_params.GetString("id_cuenta")).RunData(out outoaram);
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