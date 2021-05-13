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
    public class Bancos : Session_Entity
    {
        private JavaScriptSerializer jsSerialize;
        public Bancos()
        {
            jsSerialize = new JavaScriptSerializer();
        }

        #region

        /// <summary>
        /// función que llama al procedimiento [dbo].[St_BancosList]
        /// guardado en la BD y listandolo en la tabla de la vista Bancos.aspx
        /// </summary>
        /// <param name="dc_params"></param>
        /// <returns></returns>


        public object BancosList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[CNT].[ST_BancosList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0).RunData(out outoaram);
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

        /*función que llama al pracedimiento [dbo].[ST_BancosSave] 
         guardado en la BD, enviandole la información que se pidió en 
        el formulario (Bancos.aspx) para guardarlos*/
        public Result BancosSave(Dictionary<string, object> dc_params)
        {
            Result re = dbase.Procedure("[CNT].[ST_BancosSave]",
               "@id:BIGINT", dc_params["id"],
                "@nombre:VARCHAR:30", dc_params["nombre"],
                "@coidgo:VARCHAR:30", dc_params["codigo_compensacion"],
                "@id_user:int", dc_params["userID"]).RunRow();

            return re;
        }

        /*función que llama al pracedimiento [dbo].[ST_BancosDelete] 
         guardado en la BD,enviando el parametro para obtener un registro espesifico*/
        public Result BancosDelete(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[CNT].[ST_BancosDelete]", "@id:BIGINT", dc_params["id"]).RunRow();
        }

        /*función que llama al pracedimiento [dbo].[ST_BancosGet] 
         guardado en la BD,enviando el parametro para obtener un registro espesifico*/
        public object BancosGet(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[CNT].[ST_BancosGet]", "@id:BIGINT", dc_params["id"]).RunRow();

        }

        public object BancosState(Dictionary<string, object> dc_params)
        {
            Result data = dbase.Procedure("[CNT].[ST_BancosState]", "@id:BIGINT", dc_params["id"], "@id_user:BIGINT", dc_params["userID"]).RunRow();

            return new {Error = data.Error, Message = data.Message};
        }
        #endregion

    }
}