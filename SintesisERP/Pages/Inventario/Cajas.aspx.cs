using J_W.Estructura;
using J_W.Vinculation;
public partial class Cajas : Session_Entity
{
    protected void PageLoad()
    {
        Result data = dbase.FW_LoadSelector("BODEGAS", Usuario.UserId).RunData();
        Text_Bodega.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione");
       
    }
}