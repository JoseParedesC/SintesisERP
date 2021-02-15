using J_W.Vinculation;
using J_W.Estructura;

public partial class LineasCredito : Session_Entity
{
    protected void PageLoad()
    {
        Result data = dbase.FW_LoadSelector("SERVICESFINAN", Usuario.UserId).RunData();
        id_forma.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione");
    }
}