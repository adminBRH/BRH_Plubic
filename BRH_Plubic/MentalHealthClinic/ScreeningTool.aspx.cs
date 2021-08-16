using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BRH_Plubic.MentalHealthClinic
{
    public partial class ScreeningTool : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        Boolean Respond_page()
        {
            Boolean result = false;

            string value = "";
            bool isCheck = SCT_10.Checked;
            if (isCheck) { 
                value = SCT_10.ToString();
                value = SCT_9.ToString();
                value = SCT_8.ToString();
                value = SCT_7.ToString();
                value = SCT_6.ToString();
                value = SCT_5.ToString();
                value = SCT_4.ToString();
                value = SCT_3.ToString();
                value = SCT_2.ToString();
                value = SCT_1.ToString();
                value = SCT_0.ToString();
            }

            string SCT_No10 = SCT_10.Value.ToString();
            string SCT_No9 = SCT_9.Value.ToString();
            string SCT_No8 = SCT_8.Value.ToString();
            string SCT_No7 = SCT_7.Value.ToString();
            string SCT_No6 = SCT_6.Value.ToString();
            string SCT_No5 = SCT_5.Value.ToString();
            string SCT_No4 = SCT_4.Value.ToString();
            string SCT_No3 = SCT_3.Value.ToString();
            string SCT_No2 = SCT_2.Value.ToString();
            string SCT_No1 = SCT_1.Value.ToString();
            string SCT_No0 = SCT_0.Value.ToString();


            return result;
        }

        protected void btn_submit_ServerClick(object sender, EventArgs e)
        {
            string SCT_No10 = SCT_10.Value.ToString();
            string SCT_No9 = SCT_9.Value.ToString();
            string SCT_No8 = SCT_8.Value.ToString();
            string SCT_No7 = SCT_7.Value.ToString();
            string SCT_No6 = SCT_6.Value.ToString();
            string SCT_No5 = SCT_5.Value.ToString();
            string SCT_No4 = SCT_4.Value.ToString();
            string SCT_No3 = SCT_3.Value.ToString();
            string SCT_No2 = SCT_2.Value.ToString();
            string SCT_No1 = SCT_1.Value.ToString();
            string SCT_No0 = SCT_0.Value.ToString();


            if (SCT_No10 == "10" || SCT_No9 == "9" || SCT_No8 == "8")
            {
                Response.Redirect("ColorRed.aspx");
            }
            else
            {
                Response.Redirect("ColorGreen.aspx");
            }
            
        }
    }
}