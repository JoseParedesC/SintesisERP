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
    public class Reportes : Session_Entity
    {
        private JavaScriptSerializer jsSerialize;
        public Reportes()
        {
            jsSerialize = new JavaScriptSerializer();
        }

        public Result CargarCampos(Dictionary<string, object> dc_params)
        {
            Result res = dbase.Procedure("[Dbo].ST_ReporteCampos", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunData();
            Dictionary<string, object> dic = new Dictionary<string, object>();
            string html = CargarFiltros(res.Data.Tables[0], dc_params["userID"]);
            dic.Add("html", html);
            res.Row = dic;
            res.Data = null;
            return res;
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
                string parames = row["params"].ToString();
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
                            var pairss = metadato.Split(';');
                            foreach (string pair in pairss)
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
                        campos.Append("<div class='input-group'>");
                        campos.Append("<input type='hidden' class='" + requerido + "' data-type='" + tipo+"' data-param='" + parametro + "' id='hidden" + codigo + tipo + "'  />");
                        campos.Append("<input type = 'text' class='inputsearch form-control  " + requerido + "' placeholder=' ' readonly='readonly' id='" + codigo + tipo + "' aria-describedby='sizing-addon1' />");
                        campos.Append("<span class='input-group-addon '>");
                        campos.Append("<button type='button' class='btn btn-primary btnsearch' data-search='" + fuente + "' data-method='" + metadato + "'  data-select='" + seleccion + "' data-column='"+campossea+"' data-fields='hidden" + codigo + tipo + "," + codigo + tipo + "' "+ campoparams+" >");
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
    }
}