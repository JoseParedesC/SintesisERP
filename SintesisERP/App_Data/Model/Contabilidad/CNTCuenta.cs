using System;
using System.Collections.Generic;
using System.Data;
using J_W.Vinculation;
using SintesisERP.Pages.Connectors;
using System.Web.Script.Serialization;
using J_W.Estructura;
using System.Linq;

/// <summary>
/// Descripción breve de Buscadores
/// </summary>
/// 
namespace SintesisERP.App_Data.Model.Contabilidad
{
    public class CNTCuentas : Session_Entity
    {
        private JavaScriptSerializer jsSerialize;
        public CNTCuentas()
        {
            jsSerialize = new JavaScriptSerializer();
        }
        /// <summary>
        /// Metodo Cargar Cuentas
        /// Este metodo es utilizado para recibir el filtro de busqueda y conectarse a la BD 
        /// Cuentas  
        /// </summary>
        /// <returns> 
        /// La lista de Cuentas encontradas
        /// </returns>
        public object CNTCuentasList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[Dbo].[CNTCuentasList]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0).RunData(out outoaram);
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
        /// Metodo Cargar Cuentas de grupo
        /// Este metodo es utilizado para recibir el filtro de busqueda y conectarse a la BD 
        /// Cuentas  
        /// </summary>
        /// <returns> 
        /// La lista de Cuentas encontradas
        /// </returns>
        public object CNTCuentasGrupo(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[Dbo].[CNTCuentasListGrupo]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0).RunData(out outoaram);
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
        /// Metodo Cargar Cuentas de detalle
        /// Este metodo es utilizado para recibir el filtro de busqueda y conectarse a la BD 
        /// Cuentas  
        /// </summary>
        /// <returns> 
        /// La lista de Cuentas encontradas
        /// </returns>
        public object CNTCuentasDetalle(Dictionary<string, object> dc_params)
        {
            try
            {
                string tipo = dc_params.GetString("tipo").Equals("") ? "" : dc_params.GetString("tipo");
                Dictionary<string, object> outoaram;
                Result result = dbase.Procedure("[Dbo].[CNTCuentasListDetalle]", "@page:int", dc_params.GetString("start"), "@numpage:int", dc_params.GetString("length"), 
                    "@filter:varchar:50", dc_params.GetString("filter"), "@countpage:int:output", 0, "@tipo:VARCHAR:6", tipo).RunData(out outoaram);
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
        /// Metodo  Guardar Cuentas
        /// Este metodo es utilizado para guardar o editar en BD
        /// Cuentas
        /// </summary>
        /// <returns> 
        /// id Cuenta
        /// </returns>
        public Result CNTCuentasSave(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].[CNTCuentasSave]",
            "@id:BIGINT", dc_params["id"],
            "@codigo:VARCHAR:2", dc_params["codigo"],
            "@nombre:VARCHAR:50", dc_params["nombre"],
            "@tipo:BIT", dc_params["tipo"],
            "@id_padre:bigint", dc_params["id_padre"],
            "@id_tipocta:bigint", dc_params["id_tipocta"],
            "@id_user:int", dc_params["userID"]).RunScalar();
        }
        /// <summary>
        /// Metodo Cambiarestado Marca
        /// Este metodo es utilizado para cambiar el estado en BD 
        /// Cuentas
        /// </summary>
        /// <returns> 
        /// id Marca
        /// </returns>
        public Result CNTCuentasState(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].[CNTCuentasState]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunScalar();
        }
        /// <summary>
        /// Metodo Eliminar Cuenta
        /// Este metodo es utilizado para eliminar un registro en BD solo si no ha sido referenciado en otras tablas
        /// Cuenta
        /// </summary>
        /// <returns> 
        /// id cuenta
        /// </returns>
        public Result CNTCuentasDelete(Dictionary<string, object> dc_params)
        {
            return dbase.Procedure("[Dbo].[CNTCuentasDelete]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunScalar();
        }

        /// <summary>
        /// Metodo consultar Marca
        /// Este metodo es utilizado para consultar en BD atra vez de id
        /// Cuentas
        /// </summary>
        /// <returns> 
        /// Datos de la cuenta
        /// </returns>
        public Result CNTCuentasGet(Dictionary<string, object> dc_params)
        {
            Result data = dbase.Procedure("[Dbo].[CNTCuentasGet]", "@id:BIGINT", dc_params["id"], "@id_user:int", dc_params["userID"]).RunData();
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
        /// Metodo consultar Marca
        /// Este metodo es utilizado para consultar en BD atra vez de id
        /// Cuentas
        /// </summary>
        /// <returns> 
        /// Datos de la cuenta
        /// </returns>
        public Result CNTCuentasNew(Dictionary<string, object> dc_params)
        {
            Result data = dbase.Query("SELECT id, codigo,  nombre, nivel, id_padre FROM Dbo.ST_FnNivelesCuentasCostos('C', " + dc_params.GetString("id") + ");", true).RunData();
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

        public Result CNTCuentasTreeList(Dictionary<string, object> dc_params)
        {
            Result res = dbase.Procedure("[Dbo].[CNTCuentasTreeList]", "@id_user:int", dc_params["userID"], "@filtro:VARCHAR:25", dc_params["buscador"]).RunData();

            res.Message = LoadTreeCuentas(res.Data, (dc_params["buscador"].ToString().Equals("")));
            res.Data = null;

            return res;
        }

        private string LoadTreeCuentas(DataSet data, bool filtro)
        {
            string menuStr = "";
            DataTable dtb_parents = data.Tables[0];
            DataTable dtb_parentson = data.Tables[1];
            foreach (DataRow row in dtb_parents.Rows)
            {
                menuStr += "<li role='treeitem' draggable='false' class='tree-node tree-" + ((!filtro) ? "open" : "closed") + "'><div role='presentation' class='tree-wholerow'>&nbsp;</div><i role='presentation' class='tree-icon tree-ocl'></i>" +
                                  "<div class='tree-anchor'><i role='presentation' class='tree-fa-folder fa fa-folder'></i><span>" + row["nombre"] + "</span></div>";
                if (hasChildren(dtb_parentson, row["codigo"].ToString()))
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
                + ((row["bloqued"].ToString().Equals("S")) ? "<span title='Eliminar' class='fa fa-2x fa-trash-o tree-remove text-danger iconfa' style='margin-left: 10px;'></span>" : "") + "</div>";

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