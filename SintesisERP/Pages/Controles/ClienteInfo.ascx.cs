using J_W.Estructura;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;

public partial class ClienteInfo : System.Web.UI.UserControl
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

    protected void Page_Load(object sender, EventArgs e)
    {
    }
}