using System;
using System.Collections.Generic;
using System.Data;
using J_W.Estructura;
using J_W.Vinculation;
using SintesisERP.Pages.Connectors;
using System.Web.Script.Serialization;
using J_W.Herramientas;
using System.Web.Security;
using J_W.SintesisSecurity;
/// <summary>
/// Descripción breve de Buscadores
/// </summary>
/// 
namespace SintesisERP.App_Data.Model.Parametrizacion
{
    public class Usuarios : Session_Entity
    {
        private JavaScriptSerializer jsSerialize;
        public Usuarios()
        {
            jsSerialize = new JavaScriptSerializer();
        }
        
        /// <summary>
        /// USUARIOS
        /// </summary>        
        #region
        public object UsuariosList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[Dbo].[ST_UsuariosList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0).RunData(out outoaram);
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

        public Result UsuariosSave(Dictionary<string, object> dc_params)
        {
            Result res = new Result();
            string codmess = "", message = "";
            Dictionary<string, object> empresa;
            res.Error = true;
            Result dicdatabase = dbase.GetDB().RunRow();
            string tokenempresa = dicdatabase.Row.GetString("description");
            string database = dicdatabase.Row.GetString("db");

            string password = Des_Encriptador.Encriptar(dc_params["username"] + "sintesis123");
            return dbase.Procedure("[Dbo].ST_UsuarioSave",
            "@id:BIGINT", dc_params["id"],
            "@username:VARCHAR:50", dc_params["username"],
            "@identificacion:VARCHAR:50", dc_params["identification"],
            "@nombre:VARCHAR:150", dc_params["name"],
            "@id_turno:BIGINT", dc_params["id_shift"],
            "@telefono:VARCHAR:50:", dc_params["phone"],
            "@email:VARCHAR:100", dc_params["email"],
            "@id_cajas:VARCHAR:100", dc_params["ids_boxes"],
            "@id_perfil:INT", dc_params["id_profile"],
            "@password:varchar:255", password,
            "@id_user:int", dc_params["userID"]).RunScalar();

        }

        public Result UsuariosState(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].[ST_UsuarioState]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunScalar();
        }

        public Result UsuariosDelete(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].[ST_UsuariosDelete]", "@id:BIGINT", dc_params["id"]).RunScalar();
        }

        public Result UsuariosGet(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].[ST_UsuarioGet]", "@id:BIGINT", dc_params["id"]).RunRow();
        }

        public Result UsuariosGetData(object v_username)
        {
            return dbase.Query("SELECT U.id IdUser, userid UserId, R.RoleName FROM Dbo.Usuarios U INNER JOIN aspnet_Roles R ON R.id = U.id_perfil WHERE  U.UserName = '" + v_username + "';", true).RunRow();
        }

        public object UsuariosLicencias()
        {
            Result res = dbase.Query("SELECT COUNT(1) FROM Dbo.aspnet_Users;", true).RunScalar();
            return res.Value;
        }

        public Result UsuarioChangePass(Dictionary<string, object> dc_params)
        {
            Usuario_Entity us = (Usuario_Entity)Serializacion<Usuario_Entity>.GetIndice(sCarpeta, dc_params.GetString("tokenID"));
            Result res = new Result();
            res.Error = true;
            if (us != null)
            {
                string sUsuario = us.UserName;
                string sPass = dc_params.GetString("oldpass");
                string password = Des_Encriptador.Encriptar(sUsuario + sPass);
                if (Membership.ValidateUser(sUsuario, password))
                {
                    sPass = dc_params.GetString("newpass");
                    password = Des_Encriptador.Encriptar(sUsuario + sPass);
                    res = dbase.Procedure("[Dbo].[ST_UsuarioChangePass]", "@id_user:BIGINT", dc_params["userID"], "@password:varchar:255", password, "@tokenId:varchar:255", dc_params.GetString("tokenID")).RunRow();
                    if (!res.Error)
                        AbandonarSession();
                }
                else
                    res.Message = "Verifique clave anterior, no es valida.";
            }
            else
            {
                res.Message = "No se pudo cargar la informacion del token del usuario.";
            }
            return res;
        }

        public Result UsuariosRestoreKey(Dictionary<string, object> dc_params)
        {
            string password = Des_Encriptador.Encriptar(dc_params["username"] + "sintesis123");
            return dbase.Procedure("[Dbo].ST_UsuarioRestoreKey",
            "@id:BIGINT", dc_params["id"],
            "@password:VARCHAR:255", password,
            "@id_user:BIGINT", dc_params["userID"]).RunScalar();
        }

        public Result UsuarioChangeTokenApp(string stoken, string id)
        {
            return dbase.Query(String.Format("UPDATE Dbo.Usuarios SET apptoken = '{0}' WHERE id = {1};", stoken, id), true).RunVoid();
        }

        public Result UsuarioValidTokenApp(object id, string token)
        {

            Result result = dbase.LoadUser(id).RunRow();
            Dictionary<string, object> row = result.Row;
            if (!result.Error)
            {
                if (token.ToUpper().Equals(row.GetString("apptoken").ToUpper()))
                {
                    result.Error = false;
                }
                else
                {
                    Session["SesionUserID"] = null;
                    Session["SesionStoken"] = null;
                    result.Error = true;
                    result.Message = "Usuario desconectado. Por inicio de sesion en otro puesto de trabajo.";
                }
            }

            return result;
        }

        public object UsuariosPermisosMenu(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[dbo].[ST_UsuariosPermisosMenu]",
                    "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"),
                    "@countpage:int:output", 0, "@id_user:BIGINT", dc_params["id"]).RunData(out outoaram);
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

        public Result UsuariosPermisosSave(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[dbo].[ST_UsuariosPermisosSave]",
            "@user_id:BIGINT", dc_params["id"],
            "@permisosXml:XML", dc_params["xml"],
            "@id_user:BIGINT", dc_params["userID"]).RunScalar();
        }
        #endregion

        #region
        public object VendedoresList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[Dbo].[VendedoresList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0).RunData(out outoaram);
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

        public Result VendedoresSave(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].VendedoresSave",
            "@id:BIGINT", dc_params["id"],
            "@codigo:VARCHAR:20", dc_params["codigo"],
            "@nombre:VARCHAR:150", dc_params["nombre"],
            "@id_user:int", dc_params["userID"]).RunScalar();

        }

        public Result VendedoresState(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].[VendedoresState]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunScalar();
        }

        public Result VendedoresDelete(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].[VendedoresDelete]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunScalar();
        }

        public Result VendedoresGet(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].[VendedoresGet]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunRow();
        }
        #endregion
    }
}

