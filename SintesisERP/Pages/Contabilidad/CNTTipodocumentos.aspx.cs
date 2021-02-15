using J_W.Vinculation;
using System.Data;
using J_W.Estructura;
public partial class CNTTipodocumentos : Session_Entity
{
    public void PageLoad()
    {
        Result data = dbase.FW_LoadSelector("DOCTIPOC", Usuario.UserId).RunData();
        cd_tipo.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione");

    }

}