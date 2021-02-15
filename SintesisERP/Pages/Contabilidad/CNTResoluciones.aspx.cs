using J_W.Estructura;
using J_W.Vinculation;
public partial class CNTResoluciones : Session_Entity
{
    protected void PageLoad()
    {
        Result data = dbase.FW_LoadSelector("CENTROCOSTOS", Usuario.UserId).RunData();
        id_ccosto.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione");
    }
}