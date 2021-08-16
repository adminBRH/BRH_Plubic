using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BRH_Plubic
{
    public partial class SelfScreeningResult : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Session["Result"] = "Modal3"; // for test
            //Session["employee"] = "Yes"; // for test

            if (Session["Result"] == null)
            {
                Response.Redirect("SelfScreening.aspx");
            }
            else
            {
                string emp = "";
                if (Session["employee"] != null)
                {
                    if (Session["employee"].ToString() == "Yes")
                    {
                        emp = Session["employee"].ToString();
                        divEmp_1.Visible = true;
                        divEmp_2.Visible = true;
                        divEmp_3.Visible = true;
                        div_1.Visible = false;
                        div_2.Visible = false;
                        div_3.Visible = false;
                    }
                }
                else
                {
                    div_1.Visible = true;
                    div_2.Visible = true;
                    div_3.Visible = true;
                    divEmp_1.Visible = false;
                    divEmp_2.Visible = false;
                    divEmp_3.Visible = false;
                }

                lbl_date_1.Text = DateTime.Now.ToString("dd/MM/yyyy");
                lbl_date_2.Text = DateTime.Now.ToString("dd/MM/yyyy");
                lbl_date_3.Text = DateTime.Now.ToString("dd/MM/yyyy");

                string Result = Session["Result"].ToString();

                if (Result == "Modal1")
                {
                    DivModal1.Visible = true;
                    DivModal2.Visible = false;
                    DivModal3.Visible = false;
                    if (emp == "Yes") { img_green_emp.Visible = true; } else { img_green.Visible = true; }
                }
                else if (Result == "Modal2")
                {
                    DivModal2.Visible = true;
                    DivModal1.Visible = false;
                    DivModal3.Visible = false;
                    if (emp == "Yes") { img_yellow_emp.Visible = true; } else { img_yellow.Visible = true; }
                }
                else if (Result == "Modal3")
                {
                    DivModal3.Visible = true;
                    DivModal1.Visible = false;
                    DivModal2.Visible = false;
                    if (emp == "Yes") { img_red_emp.Visible = true; } else { img_red.Visible = true; }
                }
                else
                {

                }
            }
        }
    }
}