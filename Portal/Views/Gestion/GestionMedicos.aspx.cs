using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Portal.Views.Gestion
{
    public partial class GestionMedicos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.Page.User.Identity.IsAuthenticated)
            {
                FormsAuthentication.RedirectToLoginPage();
            }

            string permiso = Request.Cookies["UserSettings"]["Permiso"] != null ? Request.Cookies["UserSettings"]["Permiso"] : "";
            Session["Permiso"]= permiso;
        }
    }
}