using System;
using System.Collections.Generic;
using System.Data;
using J_W.Vinculation;
using SintesisERP.Pages.Connectors;
using System.Web.Script.Serialization;
using J_W.Estructura;

namespace SintesisERP.App_Data.Model.Gestion
{
    public class ClientesGestion : Session_Entity
    {
        private JavaScriptSerializer jsSerialize;
        public ClientesGestion()
        {
            jsSerialize = new JavaScriptSerializer();
        }

        public object ClientesList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[GSC].[ST_ClientesList]",
               "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"),
               "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0, "@id_cliente:varchar:50", dc_params.GetString("cliente"),
               "@id_time:varchar:50", dc_params.GetString("id_time"), "@programed:bit", dc_params.GetString("programed")
               , "@cuenta", dc_params.GetString("cuenta")).RunData(out outoaram);
                if (!result.Error)
                {
                    return jsSerialize.Serialize(new { Data = Props.table2List(result.Data.Tables[0]), totalpage = outoaram["countpage"] });
                }
                else
                {
                    return new { error = 1, errorMesage = "No hay resultado" };
                }
            }
            catch (Exception ex)
            {
                return new { error = 1, errorMesage = ex.Message };
            }

        }

        public object ClientesGestionGet(Dictionary<string, object> dc_params)
        {
            try
            {
                List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
                List<Dictionary<string, object>> listsegz = new List<Dictionary<string, object>>();
                List<object> content;
                Dictionary<string, object> fila;

                Result data = dbase.Procedure("[GSC].[ST_TercerosClientesFacturasGet]",
                    "@idC:BIGINT", dc_params["idC"],
                    "@id_user:int", dc_params["userID"]).RunData();

                if (data.Data.Tables[0].Rows.Count > 0)
                    data.Row = data.Data.Tables[0].Rows[0].ToDictionary();
                data.Table = data.Data.Tables[1].ToList();
                list = data.Data.Tables[2].ToList();

                foreach (DataRow rows in data.Data.Tables[3].Rows)
                {
                    fila = new Dictionary<string, object>();
                    content = new List<object>();
                    fila.Add("time", rows["time"]);
                    content.Add(new { tag = "p", content = rows["content"] });
                    fila.Add("body", content);
                    listsegz.Add(fila);
                }

                return new { Row = data.Row, Table = data.Table, Table2 = list, Tseguiz = listsegz };
            }
            catch (Exception ex)
            {
                return new { error = 1, errorMesage = ex.Message };
            }
        }

        public object ClientesGestionGetCuotas(Dictionary<string, object> dc_params)
        {
            try
            {
                List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
                List<Dictionary<string, object>> listseg = new List<Dictionary<string, object>>();
                List<Dictionary<string, object>> listter = new List<Dictionary<string, object>>();

                Result data = dbase.Procedure("[GSC].[ST_ClientesGestionGetCuotas]",
                    "@idC:BIGINT", dc_params["idC"],
                    "@numefac:VARCHAR:20", dc_params["numefac"],
                    "@id_user:BIGINT", dc_params["userID"]).RunData();

                list = data.Data.Tables[0].ToList();
                listseg = data.Data.Tables[1].ToList();
                listter = data.Data.Tables[2].ToList();

                return new { Table = list, Table1 = listseg, Table2 = listter };
            }
            catch (Exception ex)
            {
                return new { Error = true, Message = ex.Message };
            }

        }

        public object ClienteGestionSaveBitacora(Dictionary<string, object> dc_params)
        {
            try
            {
                List<Dictionary<string, object>> listsegz = new List<Dictionary<string, object>>();
                List<object> content;
                Dictionary<string, object> fila;

                Result Data = dbase.Procedure("[GSC].[ST_ClientesGestionSaveBitacora]",
                "@id_cliente:BIGINT", dc_params["id_cliente"],
                "@programacion:VARCHAR:16", dc_params["fecha"],
                "@programer:bit", dc_params["programer"],
                "@descripcion:varchar:-1", dc_params["descripcion"],
                "@tipo:varchar:20", dc_params["type"],
                "@id_user:int", dc_params["userID"]).RunData();

                if (!Data.Error)
                {

                    foreach (DataRow rows in Data.Data.Tables[0].Rows)
                    {
                        fila = new Dictionary<string, object>();
                        content = new List<object>();
                        fila.Add("time", rows["time"]);
                        content.Add(new { tag = "p", content = rows["content"] });
                        fila.Add("body", content);
                        listsegz.Add(fila);

                    }
                    Data.Data = null;
                }
                return new { Error = Data.Error, Message = Data.Message, Table = listsegz };
            }
            catch (Exception ex)
            {
                return new
                {
                    Error = true,
                    Message = ex.Message
                };
            }
        }
    }
}