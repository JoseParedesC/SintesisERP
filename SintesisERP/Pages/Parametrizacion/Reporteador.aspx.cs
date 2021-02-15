using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Script.Serialization;
using System.Web.UI.HtmlControls;
using J_W.Vinculation;
using J_W.Estructura;

public partial class Reporteador : Session_Entity
{
    protected void PageLoad()
    {
        Result data = dbase.FW_LoadSelector("REPORTES", Usuario.UserId).RunData();
        id_report.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione reporte");
    }    
}