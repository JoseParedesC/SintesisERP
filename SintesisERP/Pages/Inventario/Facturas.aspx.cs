using System.Data;
using J_W.Vinculation;
using J_W.Estructura;

public partial class Facturas : Session_Entity
{
    protected void PageLoad()
    {
		Result data = dbase.FW_LoadSelector("FORMAPAGOS", Usuario.UserId, "CONVENCIO").RunData();
        id_forma.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione", ds_atribute: "data-voucher");
																						
																				   
        data = dbase.FW_LoadSelector("VENCREDITO", Usuario.UserId).RunData();        
        id_tipoven.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione");
        data = dbase.FW_LoadSelector("TIPODOCUMENTOS", Usuario.UserId, "VENTAS").RunData();
        cd_tipodoc.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione", ds_atribute: "data-centro");
        data = dbase.FW_LoadSelector("PAGOCREDI", Usuario.UserId).RunData();
        SelectForma.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione", ds_atribute: "data-op");	
    }
}