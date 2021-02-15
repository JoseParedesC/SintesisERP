using J_W.Vinculation;
using J_W.Estructura;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Categoriafiscal : Session_Entity
{
    protected void PageLoad()
    {
        Result data = dbase.FW_LoadSelector("RETEFNT", Usuario.UserId).RunData();
        cd_retefuente.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione");
        data = dbase.FW_LoadSelector("RETEIVA", Usuario.UserId).RunData();
        cd_reteiva.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione");
        data = dbase.FW_LoadSelector("RETEICA", Usuario.UserId).RunData();
        cd_reteica.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione");
        data = dbase.FW_LoadSelector("RETEFNT", Usuario.UserId).RunData();
        cd_retefuenteser.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione");
        data = dbase.FW_LoadSelector("RETEIVA", Usuario.UserId).RunData();
        cd_reteivaser.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione");
        data = dbase.FW_LoadSelector("RETEICA", Usuario.UserId).RunData();
        cd_reteicaser.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione");


    }
}