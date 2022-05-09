using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Portal.Views.Pacientes
{
    public partial class VerIngresos : System.Web.UI.Page
    {
        public string permiso { set; get; }
        public string IDRegion { set; get; }
        public string Region { set; get; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.Page.User.Identity.IsAuthenticated)
            {
                FormsAuthentication.RedirectToLoginPage();
            }

            string permiso = Request.Cookies["UserSettings"]["Permiso"] != null ? Request.Cookies["UserSettings"]["Permiso"] : "";
            this.permiso = permiso;
            string IDRegion = Session["IDRegion"].ToString();
            this.IDRegion = IDRegion;
            string Region = Session["Region"].ToString();
            this.Region = Region;
        }
    }
}