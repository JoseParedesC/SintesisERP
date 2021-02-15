using System.Data;
using J_W.Vinculation;
using J_W.Estructura;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Entradas : Session_Entity
{    
    protected void PageLoad()
    {
        Result data = dbase.FW_LoadSelector("FORMAPAGOS", Usuario.UserId, "PROVEEDOR").RunData();
        cd_formapago.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione");
        cd_formapagoFlete.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione");
        data = dbase.FW_LoadSelector("TIPODOCUMENTOS", Usuario.UserId, "COMPRAS").RunData();
        cd_tipodoc.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione", ds_atribute: "data-centro");
        data = dbase.FW_LoadSelector("IVAPROD", Usuario.UserId).RunData();
        cd_iva.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione");
        data = dbase.FW_LoadSelector("INCPROD", Usuario.UserId).RunData();
        cd_inc.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione");
        data = dbase.FW_LoadSelector("RETEFNT", Usuario.UserId).RunData();
        cd_retefuente.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione");
        data = dbase.FW_LoadSelector("RETEIVA", Usuario.UserId).RunData();
        cd_reteiva.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione");
        data = dbase.FW_LoadSelector("RETEICA", Usuario.UserId).RunData();
        cd_reteica.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione");
    }    
}