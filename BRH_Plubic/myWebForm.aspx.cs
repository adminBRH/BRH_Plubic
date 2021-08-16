using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Web;
using System.Web.Services.Protocols;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BRH_Plubic
{
    public partial class myWebForm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lbl_IPAddress.Text = GetUserIP();
        }

        private string GetUserIP()
        {
            //Gets a comma-delimited list of IP Addresses
            string ipList = Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

            //If any are available - use the first one
            if (!string.IsNullOrEmpty(ipList))
            {
                return ipList.Split(',')[0];
            }

            //Otherwise return the Remote Address
            return Request.ServerVariables["REMOTE_ADDR"];
        }
    }
}