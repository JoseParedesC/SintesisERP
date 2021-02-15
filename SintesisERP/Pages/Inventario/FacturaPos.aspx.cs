using System.Data;
using J_W.Vinculation;
using J_W.Estructura;

public partial class FacturaPos : Session_Entity
{
    protected void PageLoad()
    {
        Result data = data = dbase.FW_LoadSelector("FORMAPAGOSPOS", Usuario.UserId, "CONVENCIO").RunData();
        id_forma.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione", ds_atribute: "data-voucher");
        data = dbase.FW_LoadSelector("FORMAPAGOS", Usuario.UserId, "CARTERA").RunData();
        tipo_cartera.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione");
        data = dbase.FW_LoadSelector("VENCREDITO", Usuario.UserId).RunData();        
        id_tipoven.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione");
        id_ccostos.Value = Usuario.codCCosto;
        codigoccostos.InnerText = Usuario.sNombreModulo;
    }
}