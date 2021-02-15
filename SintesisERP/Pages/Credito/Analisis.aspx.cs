using J_W.Estructura;
using J_W.Herramientas;
using J_W.Vinculation;
using System;
using System.Collections.Generic;
using System.IO;
using System.Web;
using System.Web.Services;

public partial class Analisis : Session_Entity
{
    public Session_Entity session;
    static string Carpeta = String.Format("{0}TokenString", System.AppDomain.CurrentDomain.BaseDirectory);
    protected void PageLoad()
    {
        analisis.dbase = dbase;
        analisis.iduser = Usuario.UserId;

        Result data = dbase.FW_LoadSelector("ESTACIONES", Usuario.UserId, id_otro: Usuario.IdEstacion).RunData();
        id_estacionfil.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione");
        data = dbase.FW_LoadSelector("ASESORESESTA", Usuario.UserId).RunData();
        id_asesorfil.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione");
        //Desde aqui
        data = dbase.FW_LoadSelector("LINEACREDIT", Usuario.UserId).RunData();
        lineacredit.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione");
        //Hasta aqui

        session = (Session_Entity)this.Page;
        String namepage = this.Page.ToString();

        Usuario_Entity ue_user = (Usuario_Entity)Serializacion<Usuario_Entity>.GetIndice(sCarpeta, session.SesionStoken.ToString());
        String user = ue_user.Name; 

        if (namepage.Equals("ASP.systems_analisis_aspx"))
        {
            scripts.Text = "<script src='../Pages/ScriptsPage/Credito/Analisis.js'></script>";
        }
        else
        {
            scripts.Text = "<script src='../Pages/ScriptsPage/Credito/AnalisisExc.js'></script>";
        }

    }
}