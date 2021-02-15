using System.Data;
using J_W.Vinculation;
using J_W.Estructura;

public partial class Productos : Session_Entity
{
    protected void PageLoad()
    {
        Result data = dbase.FW_LoadSelector("CATPRO", Usuario.UserId).RunData();
        Select_Grupo.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione");
        data = dbase.FW_LoadSelector("TIPOPRODUCTO", Usuario.UserId).RunData();
        cd_tipoprod.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione", ds_atribute: "data-tipo");
        data = dbase.FW_LoadSelector("DOCTIPOC", Usuario.UserId).RunData();
        cd_tipodoc.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione");
        data = dbase.FW_LoadSelector("NATUCONCEPTO", Usuario.UserId).RunData();
        cd_naturaleza.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione");
        data = dbase.FW_LoadSelector("IVAPROD", Usuario.UserId).RunData();
        cd_iva.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione");
        data = dbase.FW_LoadSelector("INCPROD", Usuario.UserId).RunData();
        cd_inc.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione");
    }
}

