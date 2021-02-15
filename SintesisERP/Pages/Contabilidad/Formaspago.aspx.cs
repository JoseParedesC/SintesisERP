using J_W.Estructura;
using J_W.Vinculation;
public partial class Formaspago : Session_Entity
{
    public void PageLoad()
    {
        Result data = dbase.FW_LoadSelector("FORMAPAGOCONT", Usuario.UserId).RunData();
        cd_type.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione tipo", ds_atribute: "data-tipo");
        data = dbase.FW_LoadSelector("TYPEFORMPAY", Usuario.UserId).RunData();
        cd_typeFE.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione tipo");
    }

}