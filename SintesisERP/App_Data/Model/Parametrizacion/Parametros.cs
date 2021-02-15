using System;
using System.Collections.Generic;
using System.Data;
using J_W.Vinculation;
using SintesisERP.Pages.Connectors;
using System.Web.Script.Serialization;
using J_W.Estructura;
using System.Text;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace SintesisERP.App_Data.Model.Parametrizacion
{
    public class Parametros : Session_Entity
    {
        private JavaScriptSerializer jsSerialize;
        public Parametros()
        {
            jsSerialize = new JavaScriptSerializer();
        }

        public object ParameterValue(string codigo)
        {
            Result result = dbase.Procedure("[Dbo].ST_ParametroValue", "@codigo:VARCHAR", codigo).RunScalar();
            if (result.Error)
                return 40000;
            else
                return result.Value;
        }

        protected string CargarFiltros(DataTable dt, object UserID)
        {
            StringBuilder html = new StringBuilder();
            StringBuilder campos = new StringBuilder();
            foreach (DataRow row in dt.Rows)
            {
                string tipo = row["tipo"].ToString();
                string nombre = row["nombre"].ToString();
                string requerido = row["requerido"].ToString().Equals("True") ? "required" : "";
                string fuente = row["fuente"].ToString();
                string metadato = row["metadata"].ToString();
                string seleccion = row["seleccion"].ToString();
                string campossea = row["campos"].ToString();
                string codigo = row["codigo"].ToString();
                string parametro = row["parametro"].ToString();
                campos = new StringBuilder();
                campos.Append("<div class='col-xs-12 col-sm-6 col-lg-" + row["ancho"] + " col-md-" + row["ancho"] + "' ><div class='form-group'>");
                campos.Append("<label for='Text_FechaV' class='active'>" + nombre + ":</label>");
                switch (tipo)
                {
                    case "datetime":
                        campos.Append(" <input type='text' data-type='" + tipo + "' data-param='" + parametro+"' class='form-control " + requerido + "' current='true' pick24hourformat='true' id='" + codigo+tipo+"' date='true' format='HH:mm' />");
                        break;
                    case "date":
                        campos.Append(" <input type='text' data-type='" + tipo + "' data-param='" + parametro + "' class='form-control " + requerido + "' current='true' id='"+ codigo + tipo + "' date='true' format='YYYY-MM-DD' />");                        
                        break;
                    case "select":
                    case "list":
                        campos.Append("<select id='" + codigo + tipo + "' data-type='" + tipo + "' data-param='" + parametro + "' data-size='8' class='form-control selectpicker  " + requerido + "' title='Bodega' data-live-search='true'><option value='' selected='selected'>Seleccione</option>");
                        if (tipo.Equals("list"))
                        {
                            var pairs = metadato.Split(';');
                            foreach (string pair in pairs)
                            {
                                if (!pair.Trim().Equals(""))
                                {
                                    var keyval = pair.Split(':');
                                    campos.Append("<option value='"+keyval[0]+"'>"+keyval[1]+"</option>");
                                }
                            }
                        }
                        else
                        {
                            DataSet result = dbase.FW_ReportSelect(fuente, UserID).RunData().Data;
                            if (result.Tables.Count > 0)
                                foreach (DataRow row2 in result.Tables[0].Rows)
                                    campos.Append("<option value='" + row2["id"] + "'>" + row2["name"] + "</option>");
                        }
                        campos.Append("</select>");
                        break;
                    case "search":
                        campos.Append("<div class='input-group'>");
                        campos.Append("<input type='hidden' class='" + requerido + "' data-type='" + tipo+"' data-param='" + parametro + "' id='hidden" + codigo + tipo + "'  />");
                        campos.Append("<input type = 'text' class='inputsearch form-control  " + requerido + "' placeholder=' ' readonly='readonly' id='" + codigo + tipo + "' aria-describedby='sizing-addon1' />");
                        campos.Append("<span class='input-group-addon '>");
                        campos.Append("<button type='button' class='btn btn-primary btnsearch' data-search='" + fuente + "' data-method='" + metadato + "'  data-select='" + seleccion + "' data-column='"+campossea+"' data-fields='hidden" + codigo + tipo + "," + codigo + tipo + "'>");
                        campos.Append("<i class='fa fa-fw fa-search'></i>");
                        campos.Append("</button>");
                        campos.Append("</span>");
                        campos.Append("</div>");
                        break;
                }
                campos.Append("</div></div>");
                html.Append(campos.ToString());
            }

            return html.ToString();
        }

        public Result ParametrosSave(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[dbo].[ST_ParametrosSave]",
                 "@IdUser:BIGINT", dc_params["userID"],
                  "@xml:XML", dc_params["xml"]
                 ).RunRow();
        }
    }
}