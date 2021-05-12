using System;
using System.Collections.Generic;
using System.Data;
using J_W.Vinculation;
using SintesisERP.Pages.Connectors;
using System.Web.Script.Serialization;
using System.IO;
using J_W.Estructura;
namespace SintesisERP.App_Data.Model.Nomina
{
    public class FechaFes : Session_Entity
    {
        private JavaScriptSerializer jsSerialize;
        public FechaFes()
        {
            jsSerialize = new JavaScriptSerializer();
        }
        //esta es la region de FECHAS FESTIVAS 
        #region

        /// <summary>
        /// función que llama al procedimiento [dbo].[St_FechaFesList]
        /// guardado en la BD y listandolo en la tabla de la vista FechaFes.aspx
        /// </summary>
        /// <param name="dc_params"></param>
        /// <returns></returns>


        public object FechaFesList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[NOM].[St_FechaFesList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0).RunData(out outoaram);
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

        /*función que llama al pracedimiento [dbo].[ST_FechaFesSave] 
         guardado en la BD, enviandole la información que se pidió en 
        el formulario (FechaFes.aspx) para guardarlos*/
        public Result FechaFesSave(Dictionary<string, object> dc_params)
        {
            Result re = dbase.Procedure("[NOM].[ST_FechaFesSave]",
               "@id:BIGINT", dc_params["id"],
                "@fecha:VARCHAR:10", dc_params["fecha"],
                "@id_user:int", dc_params["userID"]).RunRow();

            return re;
        }

        /*función que llama al pracedimiento [dbo].[ST_FechaFesDelete] 
         guardado en la BD,enviando el parametro para obtener un registro espesifico*/
        public Result FechaFesDelete(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[NOM].[ST_FechaFesDelete]", "@id:BIGINT", dc_params["id"]).RunRow();
        }

        /*función que llama al pracedimiento [dbo].[ST_FechaFesGet] 
         guardado en la BD,enviando el parametro para obtener un registro espesifico*/
        public object FechaFesGet(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[NOM].[ST_FechaFesGet]", "@id:BIGINT", dc_params["id"]).RunRow();

        }
        #endregion

        //esta es la region de FiltrarRelease (Premiso)
        #region

        /// <summary>
        /// función que llama al procedimiento [dbo].[St_FiltrarReleaseList]
        /// guardado en la BD y listandolo en la tabla de la vista FiltrarRelease.aspx
        /// segun el id del release 
        /// </summary>
        /// <param name="dc_params"></param>
        /// <returns></returns>
        public object FiltrarReleaseList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[NOM].[St_FiltrarReleaseList]", "@id_release:BIGINT", dc_params.GetString("id_release"), "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0).RunData(out outoaram);
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


        #endregion
    }
}