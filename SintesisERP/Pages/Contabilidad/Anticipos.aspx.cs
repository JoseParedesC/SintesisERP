using J_W.Vinculation;
using J_W.Estructura;

public partial class Anticipos : Session_Entity
{
    protected void PageLoad()
    {
        Result data = dbase.FW_LoadSelector("FORMAPAGOS", Usuario.UserId, "CONVENCIO").RunData();
        id_forma.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione", ds_atribute: "data-voucher");
        data = dbase.FW_LoadSelector("TIPODOCUMENTOS", Usuario.UserId, "ANTICIPOS").RunData();
        cd_tipodoc.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione", ds_atribute: "data-centro");
        data = dbase.FW_LoadSelector("TIPOTERCEROANT", Usuario.UserId).RunData();
        cd_tipoter.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione", ds_atribute: "data-iden");
    }
}