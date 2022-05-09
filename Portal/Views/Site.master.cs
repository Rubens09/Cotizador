using DocumentFormat.OpenXml.Office2010.Drawing.Charts;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Portal.Views
{
    public partial class Site : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ((Main)Master).BodyClass = "page-container-bg-solid page-footer-fixed page-header-fixed page-sidebar-closed-hide-logo";
            
            if (Request.Cookies["UserSettings"] != null)
            {
                //string UserId = Request.Cookies["UserSettings"]["Id"] != null ? Request.Cookies["UserSettings"]["Id"] : "";
                //string UserPermiso = Request.Cookies["UserSettings"]["Permiso"] != null ? Request.Cookies["UserSettings"]["Permiso"] : "";
                //string UserEmail = Request.Cookies["UserSettings"]["Email"] != null ? Request.Cookies["UserSettings"]["Email"] : "";
                string Region = Request.Cookies["UserSettings"]["RegionElegida"] != null ? Request.Cookies["UserSettings"]["RegionElegida"] : "";
                string permiso = Request.Cookies["UserSettings"]["Permiso"] != null ? Request.Cookies["UserSettings"]["Permiso"] : "";
                string UserAvatar = Request.Cookies["UserSettings"]["Avatar"] != null ? Request.Cookies["UserSettings"]["Avatar"] : "";

                if (UserAvatar != string.Empty)
                    ImgAvatar.ImageUrl = "data:image/jpeg;base64," + UserAvatar;


                if (permiso == "1")
                {
                    //Servicios Bloqueados
                    //PageAgregaOxigeno.Visible = false;
                    //PageVerOxi.Visible = false;
                    //Menus Bloqueados
                    //MenuReportes.Visible = false;
                    //MenuGetsion.Visible = false;
                    //Estudios.Visible = false;
                    //MenuConsultas.Visible = false;
                    //MenuEnfermeria.Visible = false;
                }

            }
        }
    }
}