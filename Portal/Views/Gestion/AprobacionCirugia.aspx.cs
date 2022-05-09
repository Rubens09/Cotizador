using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Portal.Views.Gestion
{
    public partial class AprobacionCirugia : System.Web.UI.Page
    {
        public string NumSolicitud { set; get; }
        protected void Page_Load(object sender, EventArgs e)
        {
            string NumSolicitud = Request["NumSolicitud"] != null ? Request["NumSolicitud"].ToString() : string.Empty;
            this.NumSolicitud = NumSolicitud;
        }
    }
}