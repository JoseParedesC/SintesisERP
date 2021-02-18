using System.Data;
using J_W.Vinculation;
using J_W.Estructura;
using System.Web.UI.HtmlControls;
using System.Collections.Generic;

public partial class CNTObsequios : Session_Entity
{

    protected void PageLoad()
    {
        Result data = dbase.FW_LoadSelector("TIPODOCUMENTOS", Usuario.UserId, "VENTAS").RunData();
        cd_tipodoc.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione", ds_atribute: "data-centro");

        data = dbase.FW_LoadSelector("FORMAPAGOOBS", Usuario.UserId).RunData();

        data.Row = data.Data.Tables[0].Rows[0].ToDictionary();

        //formapago.InnerText = data.Row["name"].ToString();
        formadepago.Attributes.Add("value", data.Row["name"].ToString());
        formadepago.Attributes.Add("data-id", data.Row["id"].ToString());
    }
}
