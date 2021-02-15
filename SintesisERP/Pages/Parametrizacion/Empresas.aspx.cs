using J_W.Estructura;
using J_W.Vinculation;
public partial class Empresas : Session_Entity
{
    protected void PageLoad()
    {
        Result data = dbase.FW_LoadSelector("CITY", Usuario.UserId).RunData();
        id_city.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione");        
        data = dbase.FW_LoadSelector("TYPEID", Usuario.UserId).RunData();
        id_tipoid.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione");
        data = dbase.FW_LoadSelector("AMBIENTE", Usuario.UserId).RunData();
        id_ambiente.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione");
    }
}