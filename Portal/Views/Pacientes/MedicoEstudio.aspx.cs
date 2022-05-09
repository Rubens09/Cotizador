using Utility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace Portal.Views.Pacientes
{
    public partial class MedicoEstudio : System.Web.UI.Page
    {
        public string Pacientes { set; get; }
        public string Episodio { set; get; }
        public string Motivo { set; get; }
        public string Hospital { set; get; }
        public string IDRegion { set; get; }
        public string NomPac { set; get; }
        public string Region { set; get; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.Page.User.Identity.IsAuthenticated)
            {
                FormsAuthentication.RedirectToLoginPage();
            }
            string Pacientes = Request["Pacientes"] != null ? Request["Pacientes"].ToString() : string.Empty;
            this.Pacientes = Pacientes;
            string Episodio = Request["Episodio"] != null ? Request["Episodio"].ToString() : string.Empty;
            this.Episodio = Episodio;
            string Motivo = Request["Motivo"] != null ? Request["Motivo"].ToString() : string.Empty;
            this.Motivo = Motivo;
            string Hospital = Request["Hospital"] != null ? Request["Hospital"].ToString() : string.Empty;
            this.Hospital = Hospital;
            string IDRegion = Request["IDRegion"] != null ? Request["IDRegion"].ToString() : string.Empty;
            this.IDRegion = IDRegion;

            string NomPac = Request["NomPac"] != null ? Request["NomPac"].ToString() : string.Empty;
            this.NomPac = NomPac;

            string Region = Request["Region"] != null ? Request["Region"].ToString() : string.Empty;
            this.Region = Region;
        }
    }
}