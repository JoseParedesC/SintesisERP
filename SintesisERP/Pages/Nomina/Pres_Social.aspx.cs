using System;
using System.Collections.Generic;
using J_W.Vinculation;
using J_W.Estructura;

public partial class Pres_Social : Session_Entity
{    
    protected void PageLoad()
    {
        Result data = dbase.FW_LoadSelector("EMP", Usuario.UserId).RunData();
        id_tipoprestacion.CargarSelect(data.Data.Tables[15], "id", "name", "Seleccione", ds_atribute: "data-iden");

    }

}