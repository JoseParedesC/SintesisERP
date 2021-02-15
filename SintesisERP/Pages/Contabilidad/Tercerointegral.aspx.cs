using System.Data;
using J_W.Vinculation;
using J_W.Estructura;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class TerceroIntegral : Session_Entity
{    
    protected void PageLoad()
    {
        Result data = dbase.FW_LoadSelector("TYPEID", Usuario.UserId).RunData();
        cd_type.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione");
        data = dbase.FW_LoadSelector("TIPOSTER", Usuario.UserId).RunData();
        cd_tipoterce.CargarSelect(data.Data.Tables[0], "id", "name", ds_atribute: "data-option");
        data = dbase.FW_LoadSelector("CITY", Usuario.UserId).RunData();
        cd_city.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione");
        data = dbase.FW_LoadSelector("PERSONERIA", Usuario.UserId).RunData();
        pn_type.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione", ds_atribute: "data-option");
        data = dbase.FW_LoadSelector("TIPOSTER", Usuario.UserId).RunData();
        cd_tipoterce.CargarSelect(data.Data.Tables[0], "id", "name", ds_atribute: "data-option");
        data = dbase.FW_LoadSelector("CATFISCAL", Usuario.UserId).RunData();
        cd_catfiscal.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione");


    }    
}