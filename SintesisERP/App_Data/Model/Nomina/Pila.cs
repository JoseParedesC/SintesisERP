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
    public class Pila : Session_Entity
    {
        private JavaScriptSerializer jsSerialize;
        public Pila()
        {
            jsSerialize = new JavaScriptSerializer();
        }
        //esta es la region de FECHAS FESTIVAS 
        #region

        /// <summary>
        /// función que llama al procedimiento [dbo].[St_PilaList]
        /// guardado en la BD y listandolo en la tabla de la vista Pila.aspx
        /// </summary>
        /// <param name="dc_params"></param>
        /// <returns></returns>


        public object PilaList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[NOM].[ST_PilaList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0).RunData(out outoaram);
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

        /*función que llama al pracedimiento [dbo].[ST_PilaSave] 
         guardado en la BD, enviandole la información que se pidió en 
        el formulario (Pila.aspx) para guardarlos*/
        public Result PilaSave(Dictionary<string, object> dc_params)
        {
            Result re = dbase.Procedure("[NOM].[ST_PilaSave]",
               "@id:BIGINT", dc_params["id"],
                "@nombre:VARCHAR:20", dc_params["nombre"],
                "@id_user:int", dc_params["userID"]).RunRow();

            return re;
        }

        /*función que llama al pracedimiento [dbo].[ST_PilaDelete] 
         guardado en la BD,enviando el parametro para obtener un registro espesifico*/
        public Result PilaDelete(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[NOM].[ST_PilaDelete]", "@id:BIGINT", dc_params["id"]).RunRow();
        }

        /*función que llama al pracedimiento [dbo].[ST_PilaGet] 
         guardado en la BD,enviando el parametro para obtener un registro espesifico*/
        public object PilaGet(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[NOM].[ST_PilaGet]", "@id:BIGINT", dc_params["id"]).RunRow();

        }
        #endregion

    }
}