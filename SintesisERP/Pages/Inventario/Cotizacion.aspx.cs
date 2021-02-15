using System.Data;
using J_W.Vinculation;
using J_W.Estructura;

public partial class Cotizacion : Session_Entity
{    
    protected void PageLoad()
    {
        /*Result data = dbase.FW_LoadSelector("BODEGASUSER", Usuario.UserId).RunData();
        cd_wineridef.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione");
        if (data.Data.Tables[0].Rows.Count == 1)
        {
            cd_wineridef.SelectedIndex = 1;
            cd_wineridef.Attributes.Add("disabled", "disabled");
        }*/
        Result data = dbase.FW_LoadSelector("LINEACREDIT", Usuario.UserId).RunData();

        lineacredit.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione");
    }    
}