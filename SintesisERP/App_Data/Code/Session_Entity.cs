using System;
using System.Collections.Generic;
using System.Web.UI;
using J_W.Estructura;
using System.Web;
using J_W.Herramientas;
using System.Reflection;
using System.IO;

namespace J_W.Vinculation
{
    public partial class Session_Entity : Page
    {
        public string sCarpeta = String.Format("{0}TokenString", System.AppDomain.CurrentDomain.BaseDirectory);
        //Pagina de session
        public Dbase dbase;

        private object UserID;

        private object TokenID;

        private string namePage;

        protected string NamePage
        {
            get { return this.namePage; }
        }

        private Usuario_Entity usuario = new Usuario_Entity();

        public object SUserID
        {
            get
            {
                return this.UserID;
            }
            set
            {
                this.UserID = value;
            }
        }
        public object STokenID
        {
            get
            {
                return this.TokenID;
            }
            set
            {
                this.TokenID = value;
            }
        }
        public object SesUserToken
        {
            get;
            set;
        }
        public object SesionUserID
        {
            get
            {
                return this.Session["SesionUserID"];
            }
            set
            {
                this.Session["SesionUserID"] = value;
            }
        }
        public object SesionStoken
        {
            get
            {
                return this.Session["SesionStoken"];
            }
            set
            {
                this.Session["SesionStoken"] = value;
            }
        }
        public object SesionTokenApp
        {
            get
            {
                return this.Session["SesionTokenApp"];
            }
            set
            {
                this.Session["SesionTokenApp"] = value;
            }
        }
        public Usuario_Entity Usuario
        {
            get
            {
                return this.usuario;
            }
        }
        public Session_Entity()
        {
            this.dbase = new Dbase();
        }
        public void AbandonarSession()
        {
            string sArchivo = sCarpeta + "\\" + this.Session["SesionStoken"].ToString() + ".indice";
            if (System.IO.File.Exists(sArchivo))
            {
                try
                {
                    File.Delete(sArchivo);
                }
                catch (Exception) { }
            }
            this.SesionUserID = null;
            this.SesionStoken = null;
        }
        public void AddCacheUser()
        {
            var MyUser = new { stoken = this.Usuario.sToken };
            var cacheKey = "UserSintesis";
            var time = DateTime.Now.AddMinutes(11);
            var cExp = System.Web.Caching.Cache.NoSlidingExpiration;
            var cPri = System.Web.Caching.CacheItemPriority.Normal;

            HttpContext.Current.Cache.Add(cacheKey, MyUser, null, time, cExp, cPri, null);
        }

        public void DropCacheUser()
        {
            HttpContext.Current.Cache.Remove(string.Format("UserSintesis{0}", this.Usuario.sToken));
        }

        private void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (this.Session["SesionUserID"] != null)
                {
                    this.UserID = Convert.ToInt32(this.Session["SesionUserID"].ToString());
                    this.TokenID = Guid.Parse(this.Session["SesionStoken"].ToString());
                    MethodInfo method = base.GetType().GetMethod("PageLoad", BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic);
                    if ((this.Session["SesionStoken"] != null || !string.IsNullOrEmpty(this.Usuario.sToken.ToString())) && this.Usuario.UserId == 0)
                    {
                        string str = string.Format("{0}\\{1}.indice", sCarpeta, this.Session["SesionStoken"].ToString());
                        if (File.Exists(str))
                        {
                            this.usuario = (Usuario_Entity)Serializacion<Usuario_Entity>.GetIndice(sCarpeta, this.TokenID.ToString());
                        }
                        else
                        {
                            LoadSessionUser();
                        }
                    }
                    if (method != null)
                    {
                        string upper = method.ReturnType.Name.ToUpper();
                        if (upper != null && upper == "VOID")
                        {
                            method.Invoke(this, null);
                        }
                    }

                    this.namePage = base.Request.Path;
                }
            }catch(Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public Usuario_Entity LoadSessionUser()
        {
            try
            {
                Result obj_Resultado = dbase.LoadUser(STokenID.ToString()).RunRow();
                if (!obj_Resultado.Error)
                {
                    Dictionary<string, object> dt_User = obj_Resultado.Row;
                    this.Usuario.UserId = int.Parse(dt_User.GetString("id"));
                    this.Usuario.sToken = Guid.Parse(dt_User.GetString("userid"));
                    this.Usuario.IdRol = Guid.Parse(dt_User.GetString("idperfil"));
                    this.Usuario.sRol = dt_User.GetString("perfil");
                    this.Usuario.UserName = dt_User.GetString("user");
                    this.Usuario.codBodega = dt_User.GetString("idbodegas");
                    this.Usuario.codCaja = dt_User.GetString("idcajas");
                    this.Usuario.codCCosto = dt_User.GetString("idccosto");
                    this.Usuario.State = dt_User.GetString("estado");
                    this.Usuario.sPassword = Des_Encriptador.Encriptar(dt_User.GetString("Password"));
                    this.Usuario.Name = dt_User.GetString("nombre");
                    this.usuario.sNombreModulo = dt_User.GetString("centrocosto");
                }
            }
            catch (Exception ex)
            {
                this.usuario = null;
                throw new Exception("Error en Cargar Usuario: " + ex.Message);
            }

            return this.usuario;
        }
    }
}
