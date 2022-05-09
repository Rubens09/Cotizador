using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Security;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utility;
using Utility.Widget.eraSecurity;
using System.Net.NetworkInformation;

namespace Portal.Views.Account
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Page.User.Identity.IsAuthenticated)
            {
                Response.Redirect("/", false);
            }

            ((Main)Master).BodyClass = "login";

            if (IsPostBack)
            {
                string UserName = Request["username"];
                string Password = Request["password"];
                bool IsRemember = Request["remember"] != null ? true : false;
                
                using (DBQuerys Querys = new DBQuerys())
                {
                    int errCode=0;
                    string errMsg = "" ;
                    //SAPbobsCOM.Company oCompany=new SAPbobsCOM.Company();

                    //bool Prueba = Querys.ConectarSapB1(out errCode,out errMsg,out oCompany);

                    using (Security SecurityEncrypt = new Security())
                    {
                            DataRow Data = Querys.IsValidUser(UserName, SecurityEncrypt.EncryptMD5(Password));

                        if (Data != null)
                        {

                            HttpCookie SessionCookie = new HttpCookie("UserSettings");
                            SessionCookie["UserName"] = Data["NUsuario"].ToString();
                            Session["IDUsuario"] = Data["ID_Usuario"].ToString();
                            Session["User"]= Data["NUsuario"].ToString();
                            SessionCookie["Nombre"] = Data["Nombre_U"].ToString();
                            SessionCookie["Apellidos"] = Data["ApellidoS_U"].ToString();
                            SessionCookie["Permiso"] = Data["ID_Jerarquia"].ToString();
                            Session["Permiso"]= Data["ID_Jerarquia"].ToString();
                            SessionCookie.Expires = DateTime.Now.AddDays(1);
                            Response.Cookies.Add(SessionCookie);
                            FormsAuthentication.RedirectFromLoginPage(Data["Nombre_U"] + " " + Data["Apellidos_U"], IsRemember);
                        }
                        else
                        {
                            //int Insertado = Querys.LogEntradas(UserName, Password, "0", IP, HOST,MAC);
                            AlertDisplay.Attributes.Add("style", "display: block;");
                        }
                    }
                }
            }
        }
    }

}