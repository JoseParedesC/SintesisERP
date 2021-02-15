using J_W.Estructura;
using J_W.Vinculation;
using SintesisERP.App_Data.Model;
using SintesisERP.App_Data.Model.Contabilidad;
using System.Collections.Generic;

public partial class CNTCuenta : Session_Entity
{
    protected void PageLoad()
    {
        Result data = dbase.FW_LoadSelector("TIPOCUENTA", Usuario.UserId).RunData();
        cd_tipo.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione");
       
        CNTCuentas cntcuentas = new CNTCuentas();
        Dictionary<string, object> dir = new Dictionary<string, object>();
        dir.Add("buscador", "");
        dir.Add("userID", Usuario.UserId);
        data = cntcuentas.CNTCuentasTreeList(dir);
        if (!data.Error)
            lbcnttree.Text = data.Message;
        else
            lbcnttree.Text = "";

      
    }

}