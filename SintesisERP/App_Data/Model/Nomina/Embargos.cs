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
    public class Embargos : Session_Entity
    {
        private JavaScriptSerializer jsSerialize;
        public Embargos()
        {
            jsSerialize = new JavaScriptSerializer();
        }
        
        #region

        /// <summary>
        /// función que llama al procedimiento [dbo].[St_EmbargosList]
        /// guardado en la BD y listandolo en la tabla de la vista Embargos.aspx
        /// </summary>
        /// <param name="dc_params"></param>
        /// <returns></returns>


        public object EmbargosList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[NOM].[ST_EmbargosList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0).RunData(out outoaram);
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

        /*función que llama al pracedimiento [dbo].[ST_EmbargosSave] 
         guardado en la BD, enviandole la información que se pidió en 
        el formulario (Embargos.aspx) para guardarlos*/
        public Result EmbargosSave(Dictionary<string, object> dc_params)
        {
            Result re = dbase.Procedure("[NOM].[ST_EmbargosSave]",
               "@id:BIGINT", dc_params["id"],
                "@nombre:VARCHAR:30", dc_params["nombre"],
                "@id_user:int", dc_params["userID"]).RunRow();

            return re;
        }

        /*función que llama al pracedimiento [dbo].[ST_EmbargosDelete] 
         guardado en la BD,enviando el parametro para obtener un registro espesifico*/
        public Result EmbargosDelete(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[NOM].[ST_EmbargosDelete]", "@id:BIGINT", dc_params["id"]).RunRow();
        }

        /*función que llama al pracedimiento [dbo].[ST_EmbargosGet] 
         guardado en la BD,enviando el parametro para obtener un registro espesifico*/
        public object EmbargosGet(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[NOM].[ST_EmbargosGet]", "@id:BIGINT", dc_params["id"]).RunRow();

        }
        #endregion

    }
}