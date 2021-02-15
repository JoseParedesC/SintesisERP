using System;
using System.Collections.Generic;
using System.Data;
using SintesisERP.Pages.Connectors;
using System.Web.Script.Serialization;
using J_W.Estructura;
using System.Linq;

namespace SintesisERP.App_Data.Model.Contabilidad
{
    public class CNTCentrosCostos : J_W.Vinculation.Session_Entity
    {
        private JavaScriptSerializer jsSerialize;
        public CNTCentrosCostos()
        {
            jsSerialize = new JavaScriptSerializer();
        }
        /// <summary>
        /// Metodo Cargar Centro de Costos
        /// Este metodo es utilizado para recibir el filtro de busqueda y conectarse a la BD 
        /// centros de costos
        /// </summary>
        /// <returns> 
        /// La lista de centros de costos encontradas
        /// </returns>
        public object CNTCentrosCostosList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[CNT].[CentrosCostosList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0).RunData(out outoaram);
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
        /// <summary>
        /// Metodo Cargar Centro de Costos
        /// Este metodo es utilizado para recibir el filtro de busqueda y conectarse a la BD 
        /// centros de costos de detalles
        /// </summary>
        /// <returns> 
        /// La lista de centros de costos de detalles encontradas
        /// </returns>
        public object CNTCentroCostosListEsDetalle(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[CNT].[CentrosCostosListEsDetalle]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0).RunData(out outoaram);
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
        /// <summary>
        /// Metodo consultar Centro de costo
        /// Este metodo es utilizado para consultar en BD atra vez de id
        /// Centro de costo
        /// </summary>
        /// <returns> 
        /// Datos de la Centro de costo
        /// </returns>

        public Result CNTCentrosCostosGet(Dictionary<string, object> dc_params)
        {
            Result data = dbase.Procedure("[CNT].[CentrosCostosGet]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunData();
            if (!data.Error)
            {
                if (data.Data.Tables[0].Rows.Count > 0)
                    data.Row = data.Data.Tables[0].Rows[0].ToDictionary();
                string html = "";
                foreach (DataRow row in data.Data.Tables[1].Rows)
                {
                    html += "<div class='list-group-item'>" + row["nombre"] + "</div>";
                }
                data.Message = html;
            }
            data.Data = null;

            return data;
        }

        /// <summary>
        /// Metodo  Guardar Centros de Costos
        /// Este metodo es utilizado para guardar o editar en BD
        /// Centros de Costos
        /// </summary>
        /// <returns> 
        /// id Centro de costo
        /// </returns>
        public Result CNTCentrosCostosSave(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[CNT].CentrosCostosSave", "@id:BIGINT", dc_params["id"],
            "@codigo:VARCHAR:4", dc_params["codigo"],
            "@nombre:VARCHAR:50", dc_params["nombre"],
            "@idpadre:bigint", dc_params["id_padre"],
            "@detalle:bit", dc_params["ISdetalle"],
            "@id_usercreated:bigint", dc_params["userID"],
            "@id_userupdated:bigint", dc_params["userID"]).RunScalar();


        }
        /// <summary>
        /// Metodo Cambiar estado 
        /// Este metodo es utilizado para cambiar el estado en BD 
        /// Centro de costo
        /// </summary>
        /// <returns> 
        /// id centro de costo
        /// </returns>
        public Result CNTCentrosCostosState(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[CNT].[CentrosCostosState]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunScalar();
        }
        /// <summary>
        /// Metodo Eliminar Centro de costo
        /// Este metodo es utilizado para eliminar un registro en BD solo si no ha sido referenciado en otras tablas
        /// Centro de costos
        /// </summary>
        /// <returns> 
        /// id Centro de costo
        /// </returns>
        public Result CNTCentrosCostosDelete(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[CNT].[CentrosCostosDelete]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunScalar();
        }

        public Result CNTCCostosNew(Dictionary<string, object> dc_params)
        {
            Result data = dbase.Query("SELECT id, codigo,  nombre, nivel, id_padre FROM Dbo.ST_FnNivelesCuentasCostos('O', " + dc_params.GetString("id") + ");", true).RunData();
            if (!data.Error)
            {
                string html = "";
                foreach (DataRow row in data.Data.Tables[0].Rows)
                {
                    html += "<div class='list-group-item'>" + row["nombre"] + "</div>";
                }
                data.Message = html;
            }
            data.Data = null;

            return data;
        }

        public Result CNTCentroCostosTreeList(Dictionary<string, object> dc_params)
        {
            Result res = dbase.Procedure("[CNT].[CentroCostoTreeList]", "@id_user:int", dc_params["userID"], "@filtro:VARCHAR:25", dc_params["buscador"]).RunData();

            res.Message = LoadTreeCuentas(res.Data, (dc_params["buscador"].ToString().Equals("")));
            res.Data = null;

            return res;
        }

        private string LoadTreeCuentas(DataSet data, bool filtro)
        {
            string menuStr = "";
            bool hassons = false;
            DataTable dtb_parents = data.Tables[0];
            DataTable dtb_parentson = data.Tables[1];
            foreach (DataRow row in dtb_parents.Rows)
            {
                hassons = hasChildren(dtb_parentson, row["codigo"].ToString());
                menuStr += "<li role='treeitem' data-tipo='" + row["tipo"] + "' data-level='" + row["indice"] + "' data-id='" + row["id"] + "' draggable='false' class='" + ((row["tipo"].ToString().Equals("D")) ? "tree-leaf" : "") + " tree-node tree-" + ((!filtro) ? "open" : "closed") + "'><i role='presentation' class='tree-icon tree-ocl'></i><div class='tree-anchor selectted'>"
                                  + ((row["tipo"].ToString().Equals("G")) ? "<i role='presentation' class='tree-fa-folder fa fa-folder'></i>" : "") + "<span>" + row["nombre"] + "</span><span title='Eliminar' class='fa fa-2x fa-trash-o tree-remove text-danger iconfa' style='margin-left: 10px;'></span></div>";
                if (hassons)
                {

                    menuStr += "<ul role='group' class='tree-children' style='position: relative; transition-duration: 300ms; transition-property: max-height;'>";
                    menuStr += findChildren(dtb_parentson, row["codigo"].ToString(), filtro);
                    menuStr += "</ul>";
                }
                menuStr += "</li>";
            }


            return (menuStr.Equals("") ? "No hay resultado" : menuStr);

        }
        private bool hasChildren(DataTable Sons, string idParent)
        {
            try
            {
                var son = from myRow in Sons.AsEnumerable() where myRow.Field<string>("id_padre") == idParent.ToString() select myRow;
                if (son.Count() > 0)
                    return true;
                else
                    return false;
            }
            catch (Exception e)
            {
                throw new Exception(e.Message);
            }
        }
        private string findChildren(DataTable Sons, string id_parent, bool filtro)
        {
            string output = "";
            bool haveson = false;
            var son = from myRow in Sons.AsEnumerable() where myRow.Field<string>("id_padre") == id_parent select myRow;
            DataTable sonsTable = (son.Count() > 0) ? son.CopyToDataTable() : new DataTable();
            foreach (DataRow row in sonsTable.Rows)
            {
                haveson = hasChildren(Sons, row["codigo"].ToString());

                output += "<li role='treeitem' data-tipo='" + row["tipo"] + "' data-level='" + row["indice"] + "' data-id='" + row["id"] + "' draggable='false' class='tree-node tree-" + ((!filtro) ? "open" : "closed") + ((haveson) ? "" : " tree-leaf") + "'><i role='presentation' class='tree-icon tree-ocl'></i><div class='tree-anchor selectted'>"
                + ((row["tipo"].ToString().Equals("G")) ? "<i class='tree-fa-folder fa fa-folder'></i>" : "") + "<span>" + row["nombre"] + "</span>"
                + "<span title='Eliminar' class='fa fa-2x fa-trash-o tree-remove text-danger iconfa' style='margin-left: 10px;'></span></div>";

                if (haveson)
                {
                    output += "<ul role='group' class='tree-children' style='position: relative; transition-duration: 300ms; transition-property: max-height;'>";
                    output += findChildren(Sons, row["codigo"].ToString(), filtro);
                    output += "</ul>";
                }
                output += "</li>";
            }

            return output;
        }
    }
}