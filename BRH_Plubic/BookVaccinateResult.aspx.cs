using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BRH_Plubic
{
    public partial class BookVaccinateResult : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["BookVaccinate"] == null)
            {
                Response.Redirect("BookVaccinate.aspx");
            }
            else
            {
                lbl_name.Text = Session["name"].ToString();
                lbl_comby.Text = Session["comeby"].ToString();
                lbl_location.Text = Session["location"].ToString();
                lbl_bookdate.Text = Session["bookdate"].ToString();
                lbl_payer.Text = Session["payer"].ToString();

                Session.Remove("BookVaccinate");
                Session.Remove("name");
                Session.Remove("comeby");
                Session.Remove("location");
                Session.Remove("bookdate");
                Session.Remove("payer");
            }
        }
    }
}