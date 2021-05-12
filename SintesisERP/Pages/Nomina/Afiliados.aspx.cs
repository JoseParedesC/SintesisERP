using System;
using System.Collections.Generic;
using J_W.Vinculation;
using J_W.Estructura;

public partial class Afiliados : Session_Entity
{    
    protected void PageLoad()
    {
        Result data = dbase.FW_LoadSelector("EMP", Usuario.UserId).RunData();
        contra.CargarSelect(data.Data.Tables[10], "id", "name", "Seleccione");

        data = dbase.FW_LoadSelector("SOLICREDIT", Usuario.UserId).RunData();
        id_tipoiden.CargarSelect(data.Data.Tables[9], "id", "name", "Seleccione", ds_atribute: "param");
    }

}