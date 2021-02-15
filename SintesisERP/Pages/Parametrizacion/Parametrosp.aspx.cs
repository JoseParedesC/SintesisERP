using J_W.Estructura;
using J_W.Vinculation;
using System;
using System.Collections.Generic;
using System.Data;
using System.Text;
using System.Web.UI;

public partial class Parametrosp : Session_Entity
{
    public void PageLoad()
    {
        Result res = dbase.Procedure("[dbo].[ST_ParametrosGet]", "@id_user:int", Usuario.UserId).RunData();
        string html = CargarFiltros(res.Data.Tables[0], Usuario.UserId);
        LiteralParametros.Text = html;
    }

    protected string CargarFiltros(DataTable dt, object UserID)
    {
        StringBuilder html = new StringBuilder();
        StringBuilder campos = new StringBuilder();
        foreach (DataRow row in dt.Rows)
        {
            string tipo = row["tipo"].ToString();
            string nombre = row["nombre"].ToString();
            string fuente = row["fuente"].ToString();
            string metadato = row["metadata"].ToString();
            string seleccion = row["seleccion"].ToString();
            string campossea = row["campos"].ToString();
            string codigo = row["codigo"].ToString();
            string parames = row["params"].ToString();
            string valor = row["valor"].ToString();
            string icon = row["icon"].ToString();
            string ancho = row["ancho"].ToString();
            string extratexto = row["extratexto"].ToString();
            campos = new StringBuilder();
            campos.Append("<div class='count col-xs-12 col-sm-6 col-lg-" + row["ancho"] + " col-md-" + row["ancho"] + "' ><div class='form-group paramform' data-codigo='" + codigo + "' data-type='" + tipo.ToUpper() + "'>");
            campos.Append("<label for='Text_FechaV' style='margin-top:20px; margin-bottom:10px;' class='active contador'> <span> " + icon + "</span>" + nombre + ":</label>");
            switch ((tipo.ToLower()))
            {
                case "datetime":
                    campos.Append(" <input type='text' data-type='" + tipo + "'  class='form-control' current='true' pick24hourformat='true' id='" + codigo + tipo + "' date='true' format='HH:mm' />");
                    break;
                case "date":
                    campos.Append(" <input type='text' data-type='" + tipo + "'s class='form-control' current='true' id='" + codigo + tipo + "' date='true' format='YYYY-MM-DD' />");
                    break;
                case "select":
                    campos.Append("<select id='" + codigo + tipo + "' data-type='" + tipo + "' data-size='8' class='form-control selectpicker' title='Bodega' data-live-search='true'><option value='' selected='selected'>Seleccione</option>");
                    DataSet result = dbase.FW_ReportSelect(fuente, UserID).RunData().Data;
                    if (result.Tables.Count > 0)
                        foreach (DataRow row2 in result.Tables[0].Rows)
                            campos.Append("<option value='" + row2["id"] + "'>" + row2["name"] + "</option>");

                    campos.Append("</select>");
                    break;
                case "list":
                    campos.Append("<select id='" + codigo + tipo + "' data-type='" + tipo + "' data-size='8' class='form-control selectpicker' title='Bodega' data-live-search='true'><option value='' selected='selected'>Seleccione</option>");
                    var pairss = metadato.Split(';');
                    foreach (string pair in pairss)
                    {
                        if (!pair.Trim().Equals(""))
                        {
                            var keyval = pair.Split(':');
                            campos.Append("<option value='" + keyval[0] + "'>" + keyval[1] + "</option>");
                        }
                    }
                    campos.Append("</select>");
                    break;
                case "search":
                    var pairs = parames.Split('|');
                    string campoparams = "";
                    foreach (string pair in pairs)
                    {
                        if (!pair.Trim().Equals(""))
                        {
                            var keyval = pair.Split(';');
                            campos.Append("<input type='hidden' id='hidenparam" + keyval[0] + "' value='" + keyval[1] + "'/>");
                            campoparams += keyval[0] + "," + "hidenparam" + keyval[0] + ";";
                        }
                    }
                    campoparams = (campoparams != "") ? "data-params='" + campoparams + "'" : "";
                    campos.Append("<div class='input-group'");
                    campos.Append("<input type='hidden' class='' data-type='" + tipo + "' id='hidden" + codigo + tipo + "'  />");
                    campos.Append("<input type = 'text' class='inputsearch form-control' placeholder='' readonly='readonly' data-idhidden='hidden" + codigo + tipo + "' id='" + codigo + tipo + "' aria-describedby='sizing-addon1' data-id='" + extratexto + "' value='" + valor + "'/> ");
                    campos.Append("<span class='input-group-addon '>");
                    campos.Append("<button type='button' class='btn btn-primary btnsearch' data-search='" + fuente + "' data-method='" + metadato + "'  data-select='" + seleccion + "' data-column='" + campossea + "' data-fields='hidden" + codigo + tipo + "," + codigo + tipo + "' " + campoparams + ">");
                    campos.Append("<i class='fa fa-fw fa-search'></i>");
                    campos.Append("</button>");
                    campos.Append("</span>");
                    campos.Append("</div>");
                    break;
                case "numero":
                    campos.Append(" <input money='true' type='text' data-type='" + tipo + "' placeholder='0.00' class='form-control col-xs-12 col-sm-6 col-lg-" + row["ancho"] + " col-md-" + row["ancho"] + "' current='true' id='" + codigo + tipo + "' value='" + row["valor"] + "' />");
                    break;
                case "checkbox":
                    campos.Append(" <input type='checkbox' data-type='" + tipo + "' class='i-checks' " + ((valor.Equals("S")) ? "checked='checked'" : "") + " current='true' id='" + codigo + tipo + "' value='N' />  ");
                    break;
            }
            campos.Append("</div></div>");
            html.Append(campos.ToString());
        }

        return html.ToString();
    }
}
