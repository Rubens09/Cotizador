using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.NetworkInformation;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Portal.PageTest
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Write(getIPAddress(this) + "<br/>");
            Response.Write(GetIP4Address() + "<br/>");
            Response.Write(GetMACAddress() + "<br/>");
        }

        public static string getIPAddress(Page page)
        {
            string szRemoteAddr = page.Request.ServerVariables["REMOTE_ADDR"];
            string szXForwardedFor = page.Request.ServerVariables["X_FORWARDED_FOR"];
            string szIP = "";

            if (szXForwardedFor == null)
            {
                szIP = szRemoteAddr;
            }
            else
            {
                szIP = szXForwardedFor;

                if (szIP.IndexOf(",") > 0)
                {
                    string[] arIPs = szIP.Split(',');

                    foreach (string item in arIPs)
                    {
                        if (!IsPrivateIP(item))
                        {
                            if (item == "::1")
                                return "127.0.0.1";
                            else
                                return item;
                        }
                    }
                }
            }
            if (szIP == "::1")
                szIP = "127.0.0.1";
            return szIP;
        }

        private static bool IsPrivateIP(string s)
        {
            return (s.StartsWith("192.168.") || s.StartsWith("10.") || s.StartsWith("::1"));
        }

        private string GetIP4Address()
        {
            string IP4Address = String.Empty;


            foreach (IPAddress IPA in Dns.GetHostAddresses(Dns.GetHostName()))
            {
                if (IPA.AddressFamily.ToString() == "InterNetwork")
                {
                    IP4Address = IPA.ToString();
                    break;
                }
            }
            if (IP4Address == "::1")
                IP4Address = "127.0.0.1";
            return IP4Address;
        }

        public string GetMACAddress()
        {
            string Result = string.Empty;

                NetworkInterface[] Nics = NetworkInterface.GetAllNetworkInterfaces();

                foreach (NetworkInterface Adapter in Nics)
                {
                    if ((Adapter.OperationalStatus == OperationalStatus.Up) && (Adapter.GetPhysicalAddress().ToString() != string.Empty) && (Adapter.NetworkInterfaceType != NetworkInterfaceType.Tunnel) && (Adapter.NetworkInterfaceType != NetworkInterfaceType.Loopback))
                    {
                        Result = Adapter.GetPhysicalAddress().ToString();
                        break;
                    }
                }

            return Result;
        }
    }
}