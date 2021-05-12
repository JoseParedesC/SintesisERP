using System;
using System.Collections.Generic;
using J_W.Vinculation;
using J_W.Estructura;

public partial class Seg_social : Session_Entity
{    
    protected void PageLoad()
    {
        Result data = dbase.FW_LoadSelector("TIPOSEGSOCIAL", Usuario.UserId).RunData();
        id_tiposegsocial.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione", ds_atribute: "param");
        /*data = dbase.FW_LoadSelector("CITY", Usuario.UserId).RunData();
        cd_city.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione");
        data = dbase.FW_LoadSelector("PERSONERIA", Usuario.UserId).RunData();
        pn_type.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione",ds_atribute:"data-option");
        data = dbase.FW_LoadSelector("TIPOSTER", Usuario.UserId).RunData();
        cd_tipoterce.CargarSelect(data.Data.Tables[0], "id", "name", ds_atribute:"data-option");
        data = dbase.FW_LoadSelector("CATFISCAL", Usuario.UserId).RunData();
        cd_catfiscal.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione");
    */
    }

}