using System;
using System.Data;
using System.Linq;
using J_W.Herramientas;
using J_W.Vinculation;
using SintesisERP.App_Data.Model;
using J_W.Estructura;
using SintesisERP.Components.Masters;
using System.IO;
using System.Web.UI;
using SintesisERP.App_Data.Model.Parametrizacion;
using System.Collections.Generic;

namespace SintesisERP.Masters
{
    public partial class SintesisLayout : MasterPage
    {
        public Session_Entity session;
        public General general = new General();
        static string sCarpeta = String.Format("{0}TokenString", System.AppDomain.CurrentDomain.BaseDirectory);
        public string sNameUser = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            session = (Session_Entity)this.Page;
            if (Session["SesionUserID"] != null && !string.IsNullOrEmpty(Session["SesionUserID"].ToString()))
            {
                Usuario_Entity ue_user = (Usuario_Entity)Serializacion<Usuario_Entity>.GetIndice(sCarpeta, session.SesionStoken.ToString());
                string activemenu = Path.GetFileName(base.Request.Path);

                Result obj_Resultado = session.dbase.ListMenus(activemenu, ue_user.IdRol.ToString(), ue_user.UserId.ToString()).RunData();
                Dictionary<string, string> menuStr = moddedMenu(obj_Resultado, activemenu);
                lblmenus.Text = menuStr["MENUS"].ToString();
                LiteralMasters.Text = menuStr["MASTERES"].ToString();

                obj_Resultado = session.dbase.SearchAlert(ue_user.UserId.ToString()).RunData();
                Dictionary<string, object> Notificaciones = UserAlert(obj_Resultado.Data);
                hiddenalert.Text = Notificaciones.GetString("notificaciones");
                count.Text = Notificaciones.GetString("cantidad");

                sNameUser = ue_user.Name;
                UserName.Text = ue_user.Name;
            }
            else
            {
                Response.Redirect("../index.aspx");
            }
        }

        protected Dictionary<string, string> moddedMenu(Result obj_Resultado, string menuactive)
        {
            string menuStr = "";
            Dictionary<string, string> menus = new Dictionary<string, string>();
            string ds_title = "Página Inicio";
            DataTable dtb_Menus = obj_Resultado.Data.Tables[1];
            if (obj_Resultado.Data.Tables[0].Rows.Count > 0)
                ds_title = obj_Resultado.Data.Tables[0].Rows[0]["NombrePagina"].ToString();
            var parents = from myRow in dtb_Menus.AsEnumerable() where myRow.Field<int>("id_parent") == 0 select myRow;
            DataTable p = parents.CopyToDataTable();

            titlemaster.Text = ds_title;

            foreach (DataRow row in p.Rows)
            {
                if (hasChildren(dtb_Menus, Int32.Parse(row["id"].ToString())))
                {
                    menuStr += "<li class='dropdown'><a href='#' aria-expanded='true' role='button' class='dropdown-toggle' data-toggle='dropdown'>" + "<i class='fa fa-21x " + row["icon"] + "'></i>" + "<span class='nav-label'>" + row["menu"].ToString() + "<span class='caret'></span></span></a>";
                    menuStr += "<ul class='dropdown-menu'>";
                    menuStr += findChildren(dtb_Menus, Int32.Parse(row["id"].ToString()));
                    menuStr += "</ul></li>";
                }
                else
                {
                    menuStr += "<li><a href='" + row["filepage"].ToString() + "'>" + row["menu"].ToString() + "</a></li>";
                }
            }
            menus.Add("MENUS", menuStr);
            menus.Add("MASTERES", LoadMasters(obj_Resultado));
            return menus;
        }

        private bool hasChildren(DataTable c, int idParent)
        {
            int counter = 0;
            foreach (DataRow row in c.Rows)
            {
                if (row["id_parent"].ToString().Equals(idParent.ToString()))
                    ++counter;
            }
            return (counter != 0);
        }

        public string findChildren(DataTable c, int parentId, bool nested = false)
        {
            string output = "";

            foreach (DataRow row in c.Rows)
            {
                if (row["id_parent"].ToString().Equals(parentId.ToString()))
                {
                    if (hasChildren(c, Int32.Parse(row["id"].ToString())))
                    {
                        output += "<li><a>" + row["menu"].ToString() + "<span class='fa fa-chevron-down'></span></a>";
                        output += "<ul class='nav nav-second-level'>";
                        output += findChildren(c, Int32.Parse(row["id"].ToString()), true);
                        output += "</ul></li>";
                    }
                    else
                    {
                        //it's a child, no more nesting 
                        output += "<li><a href='" + row["filepage"] + "'>" + row["menu"].ToString() + "</a></li><li class='divider'></li>";
                    }
                }
            }

            return output;
        }

        public static Dictionary<string, object> UserAlert(DataSet dts_alert)
        {

            Dictionary<string, object> ret = new Dictionary<string, object>();
            DataTable dtb_alert = dts_alert.Tables[0];
            int countalert = 0, countrows = dtb_alert.Rows.Count;
            string output = "";


            foreach (DataRow row in dtb_alert.Rows)
            {
                countrows -= 1;
                output += "<li><a href='#'>" + row["title"] + "<span id='" + row["type"] + "' class='pull-right number'>" + row["cantidad"] + "</span></a></li>" + ((countrows > 0) ? "<li class='divider'></li>" : "");
                countalert += (int)row["cantidad"];
            }

            ret.Add("notificaciones", output);
            ret.Add("cantidad", countalert);
            return ret;
        }

        public static string LoadMasters(Result obj_Resultado)
        {
            string menuStr = "";
            DataTable dt_title = obj_Resultado.Data.Tables[2];
            if (dt_title.Rows.Count > 0)
            {
                menuStr += "<div class='list-group' style='width:100%'>";
                foreach (DataRow row in dt_title.Rows)
                {
                    menuStr += "<div class=' col-lg-6 col-md-6 col-sm-12'><li class='list-group-item list-group-item-action'><i class='fa fa-bullseye'></i><a data-ref='" + row["PathPAgina"].ToString().ToUpper() + "' href='" + row["PathPAgina"] + "'>" + row["NombrePagina"] + " </a></li></div>";
                }
                menuStr += "</div>";
            }

            return menuStr;
        }
    }
}