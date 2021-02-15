using System;
using System.Collections.Generic;
using System.Web.Security;
using J_W.Vinculation;
using J_W.Estructura;
using J_W.SintesisSecurity;
using J_W.Herramientas;
using System.IO;
using Newtonsoft.Json;

public partial class UserCaja : Session_Entity
{
    //static Conexion conexion;
    protected void PageLoad()
    {
        try
        {
            if (!IsPostBack)
            {
                Result data = dbase.Query("SELECT C.id id_caja, B.id id_bodega, ISNULL(C.id_centrocosto,0) AS id_ccosto, C.centrocosto FROM [dbo].[CajasProceso] CP " +
                                      "INNER JOIN Dbo.VW_cajas C ON C.id = CP.id_caja INNER JOIN Dbo.Bodegas B ON C.id_bodega = B.id WHERE CP.id_userapertura = " + Usuario.UserId + " " +
                                      "AND CP.estado = 1 AND CONVERT(VARCHAR(10), CP.fechaapertura, 120) = CONVERT(VARCHAR(10), GETDATE(), 120)", true).RunRow();
                if (data.Error)
                    throw new Exception(data.Message);
                if (data.Row.Count == 0)
                {
                    data = dbase.FW_LoadSelector("USERCAJA", Usuario.UserId).RunData();
                    cajas.CargarSelect(data.Data.Tables[0], "id", "name");
                    if (data.Data.Tables[0].Rows.Count == 1)
                    {
                        cajas.SelectedIndex = 0;
                        //cajas.Attributes.Add("disabled", "disabled");
                    }
                }
                else
                {
                    ReloadUser(data.Row);
                    Response.Redirect("Systems/Default.aspx");
                }
            }
        }
        catch (Exception ex)
        {
            MessageIndex(ex.Message, "error");
        }
    }
    protected void IniciarSesion_Click(object sender, EventArgs e)
    {
        try
        {
            object monto = startmoney.Value.Replace("$ ", "").Replace(",", "");
            object caja = Request.Form[cajas.UniqueID];
            if (!string.IsNullOrEmpty(caja.ToString().Trim()))
            {
                Result res = dbase.Procedure("[Dbo].[ST_CajasSelect]", "@id_caja:BIGINT", caja, "@id_user:BIGINT", SUserID, "@monto:numeric", monto).RunRow();
                if (res.Error)
                    throw new Exception(res.Message);
                else
                {
                    ReloadUser(res.Row);
                    Response.Redirect("Systems/Default.aspx");
                }
            }
            else
                MessageIndex("No ha seleccionado ninguna caja, Verifique.", "error");
        }
        catch (Exception ex)
        {
            MessageIndex(ex.Message, "error");
        }
    }

    protected void ReloadUser(Dictionary<string, object> Row)
    {
        this.Usuario.codCaja = Row.GetString("id_caja");
        this.Usuario.codBodega = Row.GetString("id_bodega");
        this.Usuario.codCCosto = Row.GetString("id_ccosto");
        this.Usuario.sNombreModulo = Row.GetString("centrocosto");
        string sArchivo = sCarpeta + "\\" + this.SesionStoken.ToString() + ".indice";
        if (File.Exists(sArchivo))
        {
            try
            { File.Delete(sArchivo); }
            catch (Exception ex) { }
        }
        Serializacion<Usuario_Entity>.SetIndice(String.Format("{0}", this.sCarpeta), this.SesionStoken.ToString(), JsonConvert.SerializeObject(this.Usuario));
    }

    protected void MessageIndex(string msg, string type)
    {
        mensajescript.Text = "<script>$(document).ready(function(){ toastr." + type + "(\"" + msg + "\", 'Sintesis ERP',{'timeOut':'0', 'extendedTImeout': '0'}); });</script>";
    }
}