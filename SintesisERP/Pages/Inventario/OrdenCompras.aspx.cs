using System.Data;
using J_W.Vinculation;
using J_W.Estructura;

public partial class OrdenCompras : Session_Entity
{    
    protected void PageLoad()
    {
        Result data = dbase.FW_LoadSelector("BODEGAS", Usuario.UserId).RunData();
        cd_wineridef.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione");
        data = dbase.FW_LoadSelector("TIPODOCUMENTOS", Usuario.UserId, "COMPRAS").RunData();
        cd_tipodoc.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione", ds_atribute:"data-centro");


    }

}