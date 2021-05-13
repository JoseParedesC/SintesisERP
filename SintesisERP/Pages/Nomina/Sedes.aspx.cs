using J_W.Vinculation;
using J_W.Estructura;



public partial class Sede : Session_Entity
{
    protected void PageLoad()
    {
        Result data = dbase.FW_LoadSelector("CITY", Usuario.UserId).RunData();
        ds_ciudad.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione");
    }
}