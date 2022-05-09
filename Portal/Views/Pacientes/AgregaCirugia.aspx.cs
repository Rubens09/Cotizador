using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Portal.Views.Pacientes
{
    public partial class AgregaCirugia : System.Web.UI.Page
    {
        public string Pacientes { set; get; }
        public string Episodio { set; get; }
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (!this.Page.User.Identity.IsAuthenticated)
            //{
            //    FormsAuthentication.RedirectToLoginPage();
            //}
            string Pacientes = Request["Pacientes"] != null ? Request["Pacientes"].ToString() : string.Empty;
            this.Pacientes = Pacientes;
            string Episodio = Request["Episodio"] != null ? Request["Episodio"].ToString() : string.Empty;
            this.Episodio = Episodio;
        }
    }
}