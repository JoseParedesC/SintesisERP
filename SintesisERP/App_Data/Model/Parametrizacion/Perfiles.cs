using J_W.Estructura;
using J_W.Vinculation;
using SintesisERP.Pages.Connectors;
using System;
using System.Collections.Generic;
using System.Web.Script.Serialization;

namespace SintesisERP.App_Data.Model.Parametrizacion
{
    public class Perfiles : Session_Entity
    {
        private JavaScriptSerializer jsSerialize;

        public Perfiles()
        {
            jsSerialize = new JavaScriptSerializer();
        }
        //Método para guardar la información que ingrese el usuario en la interfaz
        public Result PerfilesSave(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[dbo].[ST_PerfilesSave]",
            "@id:BIGINT", dc_params["id"],
            "@app:VARCHAR:-1", dc_params["app"],
            "@nombre:VARCHAR:50", dc_params["nombre"],
            "@descripcion:VARCHAR:-1", dc_params["descripcion"],
            "@id_menus:VARCHAR:-1",dc_params["menus"],
            "@id_reportes:VARCHAR:-1", dc_params["reportes"],
            "@id_user:int", dc_params["userID"]).RunScalar();
        }
        //Método para listar la información que existe en la base de datos
        public object PerfilesList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[dbo].[ST_PerfilesList]", "@page:int", dc_params.GetString("start"),
                    "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0).RunData(out outoaram);
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
        //Método traer la información de un perfil de la base de datos
        public Result PerfilesGet(Dictionary<string, object> dc_params) {
            return dbase.Procedure("[dbo].[ST_PerfilesGet]","@id:BIGINT", dc_params["id"]).RunRow();
        }
        //Método para eliminar un perfil en la base de datos
        public Result PerfilesDelete(Dictionary<string, object> dc_params) {
            return dbase.Procedure("[dbo].[ST_PerfilesDelete]", "@id:BIGINT", dc_params["id"]).RunScalar();
        }
        //Método para actualizar el estado de un perfil en la base de datos 
        public Result PerfilesState(Dictionary<string, object> dc_params) {
            return dbase.Procedure("[dbo].[ST_PerfilesState]", "@id:BIGINT", dc_params["id"]).RunScalar();
        }
    }
}