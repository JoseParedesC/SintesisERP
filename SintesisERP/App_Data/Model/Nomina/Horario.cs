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
    public class Horario : Session_Entity
    {
        private JavaScriptSerializer jsSerialize;
        public Horario()
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
        public object HorarioList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[NOM].[ST_HorarioList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0).RunData(out outoaram);
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
        public object CargosListTipo(Dictionary<string, object> dc_params)
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
        public Result HorarioSave(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[NOM].[ST_HorarioSave]",
             "@id:BIGINT", dc_params["id"],
             "@nombre:VARCHAR:60", dc_params["nombre"],
             "@tipo_Horario:BIGINT", dc_params["tipohor"],
             "@identipo_horario:VARCHAR:5", dc_params["iden"],
             "@cadaxdia:INT", dc_params["cantdias"],
             "@diastrab:INT", dc_params["candiastrab"],
             "@diasdesc:INT", dc_params["cantdiasdes"],
             "@sabado:BIT", dc_params["sabado"],

             "@hinicio:VARCHAR:5", dc_params["horaini"],
             "@hiniciodesc:VARCHAR:5", dc_params["horainides"],
             "@hfinaldesc:VARCHAR:5", dc_params["horafindes"],
             "@hfinal:VARCHAR:5", dc_params["horafin"],
             "@hiniciosab:VARCHAR:5", dc_params["horainisab"],
             "@hfinalsab:VARCHAR:5", dc_params["horafinsab"],
             "@irregular:XML", dc_params["xmlhorario"],
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
        public Result CargosState(Dictionary<string, object> dc_params)
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
        public Result HorarioDelete(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[NOM].[ST_HorarioDelete]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunScalar();
        }
        /// <summary>
        /// Metodo consultar Terceros
        /// Este metodo es utilizado para consultar en BD atra vez de id
        /// Terceros
        /// </summary>
        /// <returns> 
        /// Datos de la Terceros
        /// </returns>
        public object HorarioGet(Dictionary<string, object> dc_params)
        {
            try
            {
                List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
                Result data = dbase.Procedure("[NOM].[ST_HorarioGet]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunData();
                if (data.Data.Tables[0].Rows.Count > 0)
                    data.Row = data.Data.Tables[0].Rows[0].ToDictionary();
                data.Table = data.Data.Tables[0].ToList();

                return new { Row = data.Row, Table = data.Table };
            }
            catch (Exception ex)
            {
                return new { Error = true, Message = ex.Message };
            }
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