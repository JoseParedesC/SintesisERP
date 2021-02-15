using System;
using System.Collections.Generic;
using System.Data;
using J_W.Vinculation;
using SintesisERP.App_Data.Model;
using J_W.Estructura;

public partial class Usuariosp : Session_Entity
{   
    protected void Page_Load(object sender, EventArgs e)
    {
        Result data = dbase.FW_LoadSelector("BOXES", Usuario.UserId).RunData();
        ids_boxes.CargarSelect(data.Data.Tables[0], "id", "name");
        data = dbase.FW_LoadSelector("PROFILES", Usuario.UserId).RunData();
        id_profile.CargarSelect(data.Data.Tables[0], "id", "name", "Perfil");
        data = dbase.FW_LoadSelector("SHIFTS", Usuario.UserId).RunData();
        id_shift.CargarSelect(data.Data.Tables[0], "id", "name", "Turno");        
        
    }
}