using System;
using System.Collections.Generic;
using System.Web.Security;
using J_W.Vinculation;
using J_W.Estructura;
using J_W.SintesisSecurity;
using J_W.Herramientas;
using SintesisERP.App_Data.Model.Parametrizacion;

public partial class index : Session_Entity
{
    protected void PageLoad()
    {
        AbandonarSession();
        if (!String.IsNullOrEmpty(Request.QueryString["ms"]))
            MessageIndex(Request.QueryString["ms"], "error");

    }

    protected void IniciarSesion_Click(object sender, EventArgs e)
    {
        try
        {
            string newuser = Guid.NewGuid().ToString();
            SintesisERP.App_Data.Model.Parametrizacion.Parametros p = new SintesisERP.App_Data.Model.Parametrizacion.Parametros();
            object obj = p.ParameterValue("TIMESESSION");
            this.Session.Timeout = Convert.ToInt32(obj);
            string username = this.Text_Username.Text;
            string password = this.Text_Password.Text;
            string passencrip = Des_Encriptador.Encriptar(string.Concat(username, password));
            Usuarios usuario = new Usuarios();
            if (username != "" && password != "")
            {
                if (!Membership.ValidateUser(username, passencrip))
                {
                    this.MessageIndex("Verifique usuario y contraseña...", "warning");
                }
                else
                {
                    Result dc_result = usuario.UsuariosGetData(this.Text_Username.Text);
                    if (!dc_result.Error)
                    {
                        this.SesionStoken = Guid.Parse(dc_result.Row.GetString("UserId"));
                        this.SesionUserID = int.Parse(dc_result.Row.GetString("IdUser"));
                        Result r = usuario.UsuarioChangeTokenApp(newuser, dc_result.Row.GetString("IdUser"));
                        this.SesionTokenApp = newuser;
                        if (dc_result.Row.GetString("RoleName").ToUpper() == "VENDEDOR")
                        {
                            Response.Redirect("UserCaja.aspx");
                        }
                        else
                        {
                            Response.Redirect("Systems/Default.aspx");
                        }
                    }
                    else
                        throw new Exception("Usuario no existe");
                }
            }
            else
            {
                this.MessageIndex("Verifique usuario y contraseña...", "warning");
            }
            this.Text_Password.Text = "";
        }
        catch (Exception ex)
        {
            MessageIndex(ex.Message, "error");
        }
    }

    protected void MessageIndex(string msg, string type)
    {
        mensajescript.Text = "<script>$(document).ready(function(){ toastr." + type + "(\"" + msg + "\", 'Sintesis ERP',{'timeOut':'0', 'extendedTImeout': '0'}); });</script>";
    }
}