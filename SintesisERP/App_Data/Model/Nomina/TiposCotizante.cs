using J_W.Estructura;
using SintesisERP.Pages.Connectors;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web.Script.Serialization;

namespace SintesisERP.App_Data.Model.Nomina
{
    public class TiposCotizantes : J_W.Vinculation.Session_Entity
    {
        // GET: TiposCotizante

        private JavaScriptSerializer jsSerialize;
        public TiposCotizantes()
        {
            jsSerialize = new JavaScriptSerializer();
        }

        //Tipo de Cotizante
        #region
        public object TipoCotizanteList(Dictionary<string,object> dc_params)
        {
            try
            {
                Dictionary<string, object> outparam; 
                Result data = dbase.Procedure("[NOM].[ST_TiposCotizanteList]",
                    "@page:int", dc_params.GetString("start"),
                    "@numpage:int", dc_params.GetString("length"),
                    "@filter:varchar:50", dc_params.GetString("filter"),
                    "@countpage:int:output", 0,
                    "@id_user:BIGINT", dc_params["userID"]).RunData(out outparam);

                if (!data.Error)
                {
                    return jsSerialize.Serialize(new { Data = Props.table2List(data.Data.Tables[0]), totalpage = outparam["countpage"] });
                }
                else
                {
                    return new { error = 1, errorMesage = "No hay resultado" };
                }

            }catch(Exception ex)
            {
                return new { Error = true, Message = ex.Message };
            }

        }

        public object TipoCotizanteSaveUpdate(Dictionary<string, object> dc_params)
        {
            Result data = dbase.Procedure("[NOM].[ST_TiposCotizanteSave]",
                "@id:BIGINT", dc_params["id"],
                "@code:VARCHAR:20", dc_params["code"],
                "@code_externo:VARCHAR:20", dc_params["code_ext"],
                "@detalle:VARCHAR:-1", dc_params["detalle"],
                "@id_subtipo:-1", dc_params["id_subtipo"],
                "@id_user:BIGINT", dc_params["userID"]).RunRow();

            return new { Error = data.Error, Message = data.Message };
        }


        public object TipoCotizanteDelete(Dictionary<string, object> dc_params)
        {
            Result data = dbase.Procedure("[NOM].[ST_TiposCotizanteDelete]",
                "@id:BIGINT", dc_params["id"],
                "@id_user:BIGINT", dc_params["userID"]).RunRow();

            return new { Error = data.Error, Message = data.Message };
        }


        public object TipoCotizanteGet(Dictionary<string, object> dc_params)
        {
            List<Dictionary<string, object>> lista;
            Result data = dbase.Procedure("[NOM].[ST_TiposCotizanteGet]",
                "@id:BIGINT", dc_params["id"],
                "@id_user:BIGINT", dc_params["userID"]).RunData();

            lista = data.Data.Tables[0].ToList();

            return new { Error = data.Error, Message = data.Message, Row = lista[0] };
        }

        public object TipootizanteState(Dictionary<string, object> dc_params)
        {
            Result data = dbase.Procedure("[NOM].[ST_TiposCotizanteState]",
                "@id:BIGINT", dc_params["id"],
                "@id_user:BIGINT", dc_params["userID"]).RunRow();

            return new { Error = data.Error, Message = data.Message };
        }

        #endregion


        //TreeList
        #region

        public Result TipoCotizanteTreeList(Dictionary<string, object> dc_params)
        {
            Result res = dbase.Procedure("[NOM].[TiposCotizanteTreeList]", "@id_user:int", dc_params["userID"], "@filtro:VARCHAR:25", dc_params["buscador"]).RunData();

            res.Message = LoadTreeTiposCotizante(res.Data, (dc_params["buscador"].ToString().Equals("")));
            res.Data = null;

            return res;
        }

        private string LoadTreeTiposCotizante(DataSet data, bool filtro)
        {
            string menuStr = "";
            bool hassons = false;
            DataTable dtb_parents = data.Tables[0];
            DataTable dtb_parentson = data.Tables[1];
            foreach (DataRow row in dtb_parents.Rows)
            {
                hassons = hasChildren(dtb_parentson, row["id"].ToString());
                menuStr += "<li role='treeitem' data-tipo='" + row["tipo"] + "' data-level='" + row["indice"] + "' data-id='" + row["id"] + "' draggable='false' class='" + ((row["tipo"].ToString().Equals("D")) ? "tree-leaf" : "") + " tree-node tree-" + ((!filtro) ? "open" : "closed") + "'><i role='presentation' class='tree-icon tree-ocl'></i><div class='tree-anchor selectted'>"
                                  + ((row["tipo"].ToString().Equals("G")) ? "<i role='presentation' class='tree-fa-folder fa fa-folder'></i>" : "") + "<span>" + row["nombre"] + "</span><span title='Eliminar' class='fa fa-2x fa-trash-o tree-remove text-danger iconfa' style='margin-left: 10px;'></span></div>";
                if (hassons)
                {

                    menuStr += "<ul role='group' class='tree-children' style='position: relative; transition-duration: 300ms; transition-property: max-height;'>";
                    menuStr += findChildren(dtb_parentson, row["id"].ToString(), filtro);
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
                haveson = hasChildren(Sons, row["id"].ToString());

                output += "<li role='treeitem' data-tipo='" + row["tipo"] + "' data-level='" + row["indice"] + "' data-id='" + row["id_padre"] + "' draggable='false' class='tree-node tree-" + ((!filtro) ? "open" : "closed") + (" tree-leaf") + "'><i role='presentation' class='tree-icon tree-ocl'></i><div class='tree-anchor selectted'>"
                + ((row["tipo"].ToString().Equals("G")) ? "<i class='tree-fa-folder fa fa-folder'></i>" : "") + "<span>" + row["nombre"] + "</span></div>";

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

        #endregion


        //Subtipo Cotizante
        #region

        public object SubtipoCotizanteList(Dictionary<string, object> dc_params)
        {
            try
            {
                Dictionary<string, object> outparam;
                Result data = dbase.Procedure("[NOM].[ST_SubtiposCotizanteList]",
                    "@page:int", dc_params.GetString("start"),
                    "@numpage:int", dc_params.GetString("length"),
                    "@filter:varchar:50", dc_params.GetString("filter"),
                    "@countpage:int:output", 0,
                    "@id_user:BIGINT", dc_params["userID"]).RunData(out outparam);

                if (!data.Error)
                {
                    return jsSerialize.Serialize(new { Data = Props.table2List(data.Data.Tables[0]), totalpage = outparam["countpage"] });
                }
                else
                {
                    return new { error = 1, errorMesage = "No hay resultado" };
                }

            }
            catch (Exception ex)
            {
                return new { Error = true, Message = ex.Message };
            }

        }

        public object SubtipoCotizanteSaveUpdate(Dictionary<string, object> dc_params)
        {
            Result data = dbase.Procedure("[NOM].[ST_SubtiposCotizanteSave]",
                "@id:BIGINT", dc_params["id"],
                "@code:VARCHAR:20", dc_params["code"],
                "@code_externo:VARCHAR:20", dc_params["code_ext"],
                "@detalle:VARCHAR:-1", dc_params["detalle"],
                "@id_user:BIGINT", dc_params["userID"]).RunRow();

            return new { Error = data.Error, Message = data.Message };
        }


        public object SubtipoCotizanteDelete(Dictionary<string, object> dc_params)
        {
            Result data = dbase.Procedure("[NOM].[ST_SubtiposCotizanteDelete]",
                "@id:BIGINT", dc_params["id"],
                "@id_user:BIGINT", dc_params["userID"]).RunRow();

            return new { Error = data.Error, Message = data.Message };
        }


        public object SubtipoCotizanteGet(Dictionary<string, object> dc_params)
        {
            List<Dictionary<string, object>> lista;
            Result data = dbase.Procedure("[NOM].[ST_SubtiposCotizanteGet]",
                "@id:BIGINT", dc_params["id"],
                "@id_user:BIGINT", dc_params["userID"]).RunData();

            lista = data.Data.Tables[0].ToList();

            return new { Error = data.Error, Message = data.Message, Row = lista[0] };
        }

        public object SubtipootizanteState(Dictionary<string, object> dc_params)
        {
            Result data = dbase.Procedure("[NOM].[ST_SubtiposCotizanteState]",
                "@id:BIGINT", dc_params["id"],
                "@id_user:BIGINT", dc_params["userID"]).RunRow();

            return new { Error = data.Error, Message = data.Message };
        }

        #endregion
    }
}