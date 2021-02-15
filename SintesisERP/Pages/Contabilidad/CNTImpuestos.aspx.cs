using J_W.Vinculation;
using System.Data;
using J_W.Estructura;
public partial class CNTImpuestos : Session_Entity
{
    public void PageLoad()
    {
        Result data = dbase.FW_LoadSelector("TIPOIMP", Usuario.UserId).RunData();
        cd_tipoimp.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione");
    }
}

