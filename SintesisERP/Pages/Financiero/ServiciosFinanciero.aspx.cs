using J_W.Vinculation;
using J_W.Estructura;

public partial class ServiciosFinanciero : Session_Entity
{
    protected void PageLoad()
    {
        Result data = dbase.FW_LoadSelector("TIPOTERCEROANT", Usuario.UserId).RunData();
        cd_tipoter.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione", ds_atribute: "data-iden");
    }
}