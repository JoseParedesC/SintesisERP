using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

using J_W.Herramientas;
using J_W.Vinculation;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using J_W.Estructura;

public partial class Empleados : Session_Entity
{
    protected void PageLoad()
    {
        Result data = dbase.FW_LoadSelector("EMP", Usuario.UserId).RunData();
        TipoSangre.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione");
        tipocontrato.CargarSelect(data.Data.Tables[1], "id", "name", "Seleccione", ds_atribute: "param");
        tiponom.CargarSelect(data.Data.Tables[2], "id", "name", "Seleccione", ds_atribute: "param");
        formapago.CargarSelect(data.Data.Tables[3], "id", "name", "Seleccione", ds_atribute: "param");
        tipojor.CargarSelect(data.Data.Tables[4], "id", "name", "Seleccione", ds_atribute: "param");
        cargo.CargarSelect(data.Data.Tables[5], "id", "name", "Seleccione", ds_atribute: "param");
        centrocostra.CargarSelect(data.Data.Tables[6], "id", "name", "Seleccione");
        filtrocen.CargarSelect(data.Data.Tables[6], "id", "name", "Seleccione");
        string estado = "";

        foreach (DataRow row in data.Data.Tables[7].Rows)
        {
            estado += "<option value='" + row["id"].ToString() + "'>" + row["name"].ToString() + "</option>";
        }
        htmlestado.Value = estado;
        contratacion.CargarSelect(data.Data.Tables[11], "id", "name", "Seleccione", ds_atribute: "param");
        proce.CargarSelect(data.Data.Tables[12], "id", "name", "Seleccione", ds_atribute: "param");
        tipocuenta.CargarSelect(data.Data.Tables[13], "id", "name", "Seleccione", ds_atribute: "param");
        horario.CargarSelect(data.Data.Tables[14], "id", "name", "Seleccione");


        data = dbase.FW_LoadSelector("CITY", Usuario.UserId).RunData();
        Text_city.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione");
        centrocosac.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione");

        data = dbase.FW_LoadSelector("SOLICREDIT", Usuario.UserId).RunData();
        ecivil.CargarSelect(data.Data.Tables[0], "id", "name", "Seleccione", ds_atribute: "param");
        estrato.CargarSelect(data.Data.Tables[4], "id", "name", "Seleccione");
        genero.CargarSelect(data.Data.Tables[5], "id", "name", "Seleccione");
        congenero.CargarSelect(data.Data.Tables[5], "id", "name", "Seleccione");
        hijo_profesion.CargarSelect(data.Data.Tables[6], "id", "name", "Seleccione");
        escolaridad.CargarSelect(data.Data.Tables[8], "id", "name", "Seleccione", ds_atribute: "param");
        id_tipoiden.CargarSelect(data.Data.Tables[9], "id", "name", "Seleccione", ds_atribute: "param");
        hijogenero.CargarSelect(data.Data.Tables[5], "id", "name", "Seleccione");

        string salario = "", salariointegral = "";
        data = dbase.FW_LoadSelector("VERISAL", Usuario.UserId).RunData();
        foreach (DataRow row in data.Data.Tables[0].Rows)
        {
            salario = row["valor"].ToString();
        }
        foreach (DataRow row in data.Data.Tables[1].Rows)
        {
            salariointegral = row["valor"].ToString();
        }
        hidsalario.Value = salario;
        hidsalarioIntegral.Value = salariointegral;

    }


}