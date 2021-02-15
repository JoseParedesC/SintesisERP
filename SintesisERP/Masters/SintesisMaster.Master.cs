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
using FastReport.Data;
using System.Collections.Generic;
using DocumentFormat.OpenXml.Office.CustomUI;

namespace SintesisERP.Masters
{
    public partial class SintesisMaster : MasterPage
    {
        public Session_Entity session;
        static string sCarpeta = String.Format("{0}TokenString", System.AppDomain.CurrentDomain.BaseDirectory);
        public string sNameUser = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                session = (Session_Entity)this.Page;
                if (Session["SesionUserID"] != null && !string.IsNullOrEmpty(Session["SesionUserID"].ToString()))
                {
                    Usuario_Entity ue_user = (Usuario_Entity)Serializacion<Usuario_Entity>.GetIndice(sCarpeta, session.SesionStoken.ToString());
                    string activemenu = Path.GetFileName(base.Request.Path);
                    Result obj_Resultado = session.dbase.ListMenus(activemenu, ue_user.IdRol.ToString(), ue_user.UserId.ToString()).RunData();
                    if (session.dbase.ValidMenu(activemenu, obj_Resultado))
                    {
                        Dictionary<string, string> menuStr = moddedMenu(obj_Resultado, activemenu);
                        lblmenus.Text = menuStr["MENUS"].ToString();
                        lblsubmenus.Text = menuStr["SUBMENUS"].ToString();
                        LiteralMasters.Text = menuStr["MASTERES"].ToString();

                        obj_Resultado = session.dbase.SearchAlert(ue_user.UserId.ToString()).RunData();
                        Dictionary<string, object> Notificaciones = UserAlert(obj_Resultado.Data);
                        hiddenalert.Text = Notificaciones.GetString("notificaciones");
                        count.Text = Notificaciones.GetString("cantidad");
                        userName.Text = ue_user.Name;
                    }
                    else
                    {
                        Response.Redirect("Default.aspx", false);
                    }
                }
                else
                {
                    Response.Redirect("../index.aspx");
                }
            }
            catch (Exception ex)
            {
                Response.Redirect("../index.aspx?ms=" + ex.Message);
            }
        }
        protected Dictionary<string, string> moddedMenu(Result obj_Resultado, string menuactive)
        {
            Dictionary<string, string> menus = new Dictionary<string, string>();
            string menuStr = "";
            string submenus = "";
            string ds_title = "Página Inicio";
            DataTable dt_title = obj_Resultado.Data.Tables[0];
            if (dt_title.Rows.Count > 0)
                ds_title = dt_title.Rows[0]["NombrePagina"].ToString();

            titlemaster.Text = ds_title;

            DataTable dtb_Menus = obj_Resultado.Data.Tables[1];
            var parents = from myRow in dtb_Menus.AsEnumerable() where myRow.Field<int>("id_parent") == 0 select myRow;
            DataTable p = (parents.Count() > 0) ? parents.CopyToDataTable() : new DataTable();
            foreach (DataRow row in p.Rows)
            {
                if (hasChildren(dtb_Menus, Int32.Parse(row["id"].ToString())))
                {
                    menuStr += "<li class='lichildren'><a href='javascript: void(0)' class='parent' data-id='divsubm" + row["id"].ToString() + "'><i class='fa fa-23x " + row["icon"] + "'></i><span class='nav-label'>" + row["menu"].ToString() + "</span> <span class='fa arrow fa-2x'></span></a>";
                    submenus += findChildren(dtb_Menus, Int32.Parse(row["id"].ToString()));
                    menuStr += "<div class='triangle'></div></li>";
                }
                else
                {
                    menuStr += "<li><a href='" + row["filepage"].ToString() + "'>" + row["menu"].ToString() + "</a></div></li>";
                }
            }

            menuStr += "<script>$(function(){var idmenu = $('a[data-ref=\"" + menuactive.ToUpper() + "\"]').closest('ul.childNav').attr('id'); idmenu =  (idmenu != undefined? idmenu: 'divsubm0'); $('.lichildren a[data-id=\"'+idmenu+'\"]').closest('.lichildren').addClass('desactive')})</script>";
            menus.Add("MENUS", menuStr);
            menus.Add("SUBMENUS", submenus);
            menus.Add("MASTERES", LoadMasters(obj_Resultado));
            return menus;
        }

        private bool hasChildren(DataTable c, int idParent)
        {
            int counter = 0;
            foreach (DataRow row in c.Rows)
            {
                if (row["id_parent"].ToString().Equals(idParent.ToString()))
                {
                    ++counter;
                    break;
                }
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
                        output += "<li class='nav-item'><a data-ref='" + row["filepage"].ToString().ToUpper() + "' href='" + row["filepage"] + "'>" + row["menu"].ToString() + "</a></li>";
                    }
                }
            }

            return "<ul class='childNav d-none' id='divsubm" + parentId.ToString() + "'>" + output + "</ul>";
        }

        public static Dictionary<string, object> UserAlert(DataSet dts_alert)
        {
            Dictionary<string, object> ret = new Dictionary<string, object>();


            DataTable dtb_alert = dts_alert.Tables[0];
            string output = "";
            int sum = 0;

            foreach (DataRow row in dtb_alert.Rows)
            {
                output += "<a href='#' class='dropdown-item'>" + row["title"] + "<span id='" + row["type"] + "' class='pull-right number'>" + row["cantidad"] + "</span></a>";
                sum += (int)row["cantidad"];
            }
            ret.Add("notificaciones", output);
            ret.Add("cantidad", sum);
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