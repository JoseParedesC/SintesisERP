using J_W.Estructura;
using J_W.Vinculation;
using SintesisERP.App_Data.Model.Nomina;
using System.Collections.Generic;

public partial class TiposCotizante : Session_Entity
{
    protected void PageLoad()
    {
        Result data = dbase.FW_LoadSelector("TIPOSCOT", Usuario.UserId, id_otro: Usuario.IdEstacion).RunData();
        tipocot.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione");
        TiposCotizantes tiposcot = new TiposCotizantes();
        Dictionary<string, object> dir = new Dictionary<string, object>();
        dir.Add("buscador", "");
        dir.Add("userID", Usuario.UserId);

        data = tiposcot.TipoCotizanteTreeList(dir);

        if (!data.Error)
            treeCotizante.Text = data.Message;
        else
            treeCotizante.Text = "";
    }
}