using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BRH_Plubic
{
    public partial class ScreenCovidBeforToWorkResult : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Session["scsend"] = "scgreen";  // << -- for test

            if (Session["scsend"] != null)
            {
                if (Session["scsend"].ToString() == "scgreen")
                {
                    divgreen.Visible = true;
                }
                else if (Session["scsend"].ToString() == "scred")
                {
                    divred.Visible = true;
                }
                else { }
            }
            else
            {
                Response.Redirect("ScreenCovidBeforToWork.aspx");
            }
        }
    }
}