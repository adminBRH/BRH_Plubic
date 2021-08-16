using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;

namespace BRH_Plubic.MentalHealthClinic
{
    public partial class ColorRedSPST20Positive : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass CL_Sql = new SQLclass();
        string id = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["id"] != null)
            {
                
                string txtS = Request.QueryString["spst20"].ToString();
                string txtD = Request.QueryString["phq9"].ToString();

               
                if (txtS == "yes")
                {
                    lbl_s.Text = "เครียด ";
                }

                if (txtD == "yes")
                {
                    lbl_d.Text = "ซึมเศร้า ";
                }
            }
        }

        protected void btn_submit_SPST20_ServerClick(object sender, EventArgs e)
        {
            string m_id = id;
            
            string txtS = Request.QueryString["spst20"].ToString();
            string txtD = Request.QueryString["phq9"].ToString();

            if (Request.QueryString["id"] != null)
            {
                m_id = Request.QueryString["id"].ToString();
            }

            Response.Redirect("SPST20.aspx?id=" + m_id + "&spst20=" + txtS + "&phq9=" + txtD);           
        }
    }
}