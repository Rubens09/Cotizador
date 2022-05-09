using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utility;

namespace Portal.Views.Home
{
    public partial class Index : System.Web.UI.Page
    {

        //public string Permiso { set; get; }
        protected void Page_Load(object sender, EventArgs e)
        {
           
            try
            {

                if (!this.Page.User.Identity.IsAuthenticated)
                {
                    FormsAuthentication.RedirectToLoginPage();
                }
               

            }
            catch (Exception ex)
            {

                throw new Exception("debugId:" + ex.Message);
                
            }
        }
    }
}