using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Portal.Views
{
    public partial class Main : System.Web.UI.MasterPage
    {
        public string BodyClass { set {Body.Attributes.Add("class", value);} }

        protected void Page_Load(object sender, EventArgs e)
        {
        }
    }
}