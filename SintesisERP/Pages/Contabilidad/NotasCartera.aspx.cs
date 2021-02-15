using System.Data;
using J_W.Vinculation;
using J_W.Estructura;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class NotasCartera : Session_Entity
{
    protected void PageLoad()
    {
        Result data = dbase.FW_LoadSelector("FORMAPAGOS", Usuario.UserId, "CONVENCIO").RunData();
        data = dbase.FW_LoadSelector("TIPODOCUMENTOS", Usuario.UserId, "CONTABLES").RunData();
        cd_tipodoc.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione", ds_atribute: "data-centro");
        data = dbase.FW_LoadSelector("TIPOTERCEROANT", Usuario.UserId).RunData();
        cd_tipoterce.CargarSelect(data.Data.Tables[0], "id", "name", ds_atribute: "data-option");
        data = dbase.FW_LoadSelector("VENCREDITO", Usuario.UserId).RunData();
        id_tipoven.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione");

    }
}