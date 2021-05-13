using System;
using System.Collections.Generic;
using J_W.Vinculation;
using J_W.Estructura;

public partial class Pres_Social : Session_Entity
{    
    protected void PageLoad()
    {
        Result data = dbase.FW_LoadSelector("TIPOPRESTACION", Usuario.UserId).RunData();
        id_tipoprestacion.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione", ds_atribute: "data-iden");

    }

}