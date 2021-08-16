using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BRH_Plubic
{
    public partial class ARIResult : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["ARIType"] == null || Session["ARIKEy"] == null)
            {
                if (Session["ARIfinish"] == null)
                {
                    Response.Redirect("ARIclinic.aspx");
                }
                else
                {
                    string[] id = Session["ARIfinish"].ToString().Split('|');
                    div_finish.Visible = true;
                    lbl_date.Text = id[0];
                    lbl_time.Text = id[1];
                }
            }
            else
            {
                div_next.Visible = true;
                Response.Write("<script> setTimeout(function () {window.location.href='ARIcalendar.aspx';}, 5000); </script>");
            }
        }
    }
}