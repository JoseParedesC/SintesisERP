using System;
using System.Collections.Generic;
using J_W.Vinculation;
using J_W.Estructura;

public partial class ParametrosNomina : Session_Entity
{
    protected void PageLoad()
    {

        Result data = dbase.FW_LoadSelector("TIPOINC", Usuario.UserId).RunData();
        porcen_interes_Cesantias.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione");

    }

}