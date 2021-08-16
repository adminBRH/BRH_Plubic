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
    public partial class PHQ9positive : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass CL_Sql = new SQLclass();
        string id = "";

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_submit_phq9pos_ServerClick(object sender, EventArgs e)
        {
            string m_id = id;
            m_id = Request.QueryString["id"];
            
            string txtS = Request.QueryString["spst20"].ToString();
            string txtD = Request.QueryString["phq9"].ToString();

            Response.Redirect("PHQ8.aspx?id=" + m_id + "&type=PHQ8&spst20=" + txtS + "&phq9=" + txtD);
        }
    }
}