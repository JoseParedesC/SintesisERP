using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using J_W.Herramientas;
using J_W.Vinculation;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using J_W.Estructura;

public partial class LiquidacionNom : Session_Entity
{
    protected void PageLoad()
    {
        Result data = dbase.FW_LoadSelector("LIQUIDACION", Usuario.UserId).RunData();
        filtroliq.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione", ds_atribute: "param");
        period.CargarSelect(data.Data.Tables[1], "id", "name", "Seleccione");
        data = dbase.FW_LoadSelector("TAU", Usuario.UserId).RunData();
        ds_ausencia.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione", ds_atribute: "data-iden");


    }


}