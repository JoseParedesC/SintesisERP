using J_W.Estructura;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;

/// <summary>
/// UCDataPager
/// </summary>
public partial class AnalisisCre : System.Web.UI.UserControl
{
    private Dbase _dbase;
    private object _iduser, _idempresa, _idestacion;
    public Dbase dbase
    {
        get
        {
            return _dbase;
        }
        set { _dbase = value; }
    }

    public object idempresa
    {
        get
        {
            return _idempresa;
        }
        set { _idempresa = value; }
    }

    public object iduser
    {
        get
        {
            return _iduser;
        }
        set { _iduser = value; }
    }

    public object idestacion
    {
        get
        {
            return _idestacion;
        }
        set { _idestacion = value; }
    }
    
    //#region "Page Events"
    ///// <summary>
    ///// Page_Load
    ///// </summary>
    ///// <param name="sender"></param>
    ///// <param name="e"></param>
    protected void Page_Load(object sender, EventArgs e)
    {
        Result data = dbase.FW_LoadSelector("SOLICREDIT", iduser).RunData();
        ecivil.CargarSelect(data.Data.Tables[0], "id", "name", "", ds_atribute: "param");
        vinmueble.CargarSelect(data.Data.Tables[1], "id", "name", "", ds_atribute: "param");
        setiemposer.CargarSelect(data.Data.Tables[2], "id", "name", "", ds_atribute: "param");
        tiporef.CargarSelect(data.Data.Tables[3], "id", "name", "");
        estrato.CargarSelect(data.Data.Tables[4], "id", "name", "", "");
        genero.CargarSelect(data.Data.Tables[5], "id", "name", "");
        TipoEmpleo.CargarSelect(data.Data.Tables[6], "id", "name", "", "");
        id_tipoper.CargarSelect(data.Data.Tables[7], "id", "name", "");
        id_tipoiden.CargarSelect(data.Data.Tables[14], "id", "name", "");
        fraiz.CargarSelect(data.Data.Tables[10], "id", "name", "");
        idenconyuge.CargarSelect(data.Data.Tables[9], "id", "name", "");
        tipocuenta.CargarSelect(data.Data.Tables[11], "id", "name", "");
        ciudadexp.CargarSelect(data.Data.Tables[12], "id", "name", "");
        Text_city.CargarSelect(data.Data.Tables[12], "id", "name", "");
        id_escolaridad.CargarSelect(data.Data.Tables[8], "id", "name", "");
        TipoAct.CargarSelect(data.Data.Tables[15], "id", "name", "", "");
        //id_parentez.CargarSelect(data.Data.Tables[13], "id", "name", "");
    }
}
