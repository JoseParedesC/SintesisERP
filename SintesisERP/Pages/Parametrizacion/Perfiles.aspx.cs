using J_W.Estructura;
using J_W.Vinculation;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

    public partial class Perfiles : Session_Entity
{
        protected void Page_Load(object sender, EventArgs e)
        {
            Result data = dbase.FW_LoadSelector("APP", Usuario.UserId).RunData();
            app.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione...");
            menus.CargarSelect(data.Data.Tables[1], "id", "name");
            reportes.CargarSelect(data.Data.Tables[2], "id", "name");
        }
    }