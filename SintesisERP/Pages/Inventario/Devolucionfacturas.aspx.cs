using System.Data;
using J_W.Vinculation;
using J_W.Estructura;

public partial class Devolucionfacturas : Session_Entity
{    
    protected void PageLoad()
    {
        Result data = dbase.FW_LoadSelector("TIPODOCUMENTOS", Usuario.UserId, "VENTAS").RunData();
        cd_tipodoc.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione", ds_atribute: "data-centro");

    }
}