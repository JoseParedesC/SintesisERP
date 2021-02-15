using System.Data;
using J_W.Vinculation;
using J_W.Estructura;

public partial class FacturasRecurrentes : Session_Entity
{
    protected void PageLoad()
    {
        Result data = dbase.FW_LoadSelector("FORMAPAGOS", Usuario.UserId, "CARTERA").RunData();
        cd_formapagos.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione");        
        data = dbase.FW_LoadSelector("TIPODOCUMENTOS", Usuario.UserId, "VENTAS").RunData();
        cd_tipodoc.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione", ds_atribute: "data-centro");

    }
}