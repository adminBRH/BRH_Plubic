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
    public partial class SPSTtoPHQ9neg : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass CL_Sql = new SQLclass();
        string id = "";

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_submit_SPST_to_PHQ9_ServerClick(object sender, EventArgs e)
        {
            string m_id = id;
            m_id = Request.QueryString["id"];
            string txtA = "";
            if (Request.QueryString["gad7"] != null)
            {
                txtA = Request.QueryString["gad7"].ToString();
            }

            string txtS = "";
            if (Request.QueryString["spst20"] != null)
            {
                txtS = Request.QueryString["spst20"].ToString();
            }

            string txtD = "";
            if (Request.QueryString["phq9"] != null)
            {
                txtD = Request.QueryString["phq9"].ToString();
            }

            Response.Redirect("PHQ9.aspx?id=" + m_id + "&gad7=" + txtA + "&spst20=" + txtS + "&phq9=" + txtD);
        }
    }
}