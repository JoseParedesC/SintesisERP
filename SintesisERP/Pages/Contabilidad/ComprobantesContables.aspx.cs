using System.Data;
using J_W.Vinculation;
using J_W.Estructura;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Comprobantes: Session_Entity
{    
    protected void PageLoad()
    {
        Result data = dbase.FW_LoadSelector("TIPODOCUMENTOS", Usuario.UserId, "CONTABLES").RunData();
        cd_tipodoc.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione", ds_atribute:"data-centro");
      

    }    
}