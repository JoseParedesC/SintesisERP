using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

using J_W.Herramientas;
using J_W.Vinculation;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using J_W.Estructura;

public partial class GestionCartera : Session_Entity
{
    protected void PageLoad()
    {

        Result data = dbase.FW_LoadSelector("GESTIONCLI", Usuario.UserId).RunData();
        estadocon.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione");
        data = dbase.FW_LoadSelector("CUENTA", Usuario.UserId).RunData();
        id_cuenta.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione");
        Result data2 = dbase.Query("SELECT COUNT(1) FROM CNT.TipoTerceros WHERE id_tipotercero = [dbo].[ST_FnGetIdList]('CL')", true).RunScalar();
        countclient.InnerText = data2.Value.ToString();
    }
}