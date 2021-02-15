using J_W.Estructura;
using J_W.Vinculation;
using SintesisERP.App_Data.Model;
using SintesisERP.App_Data.Model.Contabilidad;
using System.Collections.Generic;

public partial class CNTCentrocostos : Session_Entity
{
    public void PageLoad()
    {
        CNTCentrosCostos cntcuentas = new CNTCentrosCostos();
        Dictionary<string, object> dir = new Dictionary<string, object>();
        dir.Add("buscador", "");
        dir.Add("userID", Usuario.UserId);

        Result data = cntcuentas.CNTCentroCostosTreeList(dir);

        if (!data.Error)
            lbcnttree.Text = data.Message;
        else
            lbcnttree.Text = "";

    }

}