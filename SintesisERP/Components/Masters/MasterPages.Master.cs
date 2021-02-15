using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using J_W.Vinculation;

namespace SintesisERP.Components.Masters
{
    public partial class MasterPages : MasterPage
    {
        //Session_Entity Session = new Session_Entity();

        protected void Page_Load(object sender, EventArgs e)
        {
            if ((Session["SesionUserID"] == null || string.IsNullOrEmpty(Session["SesionUserID"].ToString())) && this.Page.ToString().ToUpper().Contains("USERCAJA"))
            {
                Response.Redirect("index.aspx");
            }
        }
    }
}