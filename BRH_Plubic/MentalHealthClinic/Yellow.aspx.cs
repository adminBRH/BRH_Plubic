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
    public partial class Yellow : System.Web.UI.Page
    {

        string sql = "";
        DataTable dt;
        SQLclass CL_Sql = new SQLclass();
        string id = "";

        protected void Page_Load(object sender, EventArgs e)
        {

                lbl_summary_1.Text = Request.QueryString["1"].ToString();
                lbl_summary_2.Text = Request.QueryString["2"].ToString();
                lbl_summary_3.Text = Request.QueryString["3"].ToString();
         
        }

        public Boolean InsertDataYellowPost()
        {
            Boolean result = false;

            string m_id = id;
            m_id = Request.QueryString["id"];

            string yelp_fname = yelpost_fname.Value.ToString().Trim();
            string yelp_lname = yelpost_lname.Value.ToString().Trim();
            string yelp_pnumber = yelpost_pnumber.Value.ToString().Trim();
            string yelp_line = yelpost_line.Value.ToString().Trim();

            sql = "UPDATE mentalhealthrecord SET fname = '" + yelp_fname + "', lname = '" + yelp_lname + "', p_number = '" + yelp_pnumber + "', line_id = '" + yelp_line + "'" + "WHERE m_id = '" + m_id + "';";

            if (CL_Sql.Modify(sql))
            {
                result = true;
            }

            return result;

        }


        protected void btn_submit_ylpost_ServerClick(object sender, EventArgs e)
        {
            if (InsertDataYellowPost())
            {
                Response.Write("<script>alert('บันทึกข้อมูลของท่านเรียบร้อยแล้ว'); window.location.href='Default.aspx'</script>");

            }
            else
            {
                Response.Write("<script>alert('ไม่สามารถบันทึกได้กรุณาติดต่อ Admin');</script>");
            }
        }
    }
}