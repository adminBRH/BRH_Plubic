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
    public partial class GAD7Postive : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass CL_Sql = new SQLclass();
        string id = "";
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public Boolean InsertDataGAD7POST()
        {
            Boolean result = false;


            string m_id = id;
            m_id = Request.QueryString["id"];

            string gadp_fname = gad7post_fname.Value.ToString().Trim();
            string gadp_lname = gad7post_lname.Value.ToString().Trim();
            string gadp_pnumber = gad7post_pnumber.Value.ToString().Trim();
            string gadp_line = gad7post_line.Value.ToString().Trim();

            sql = "UPDATE mentalhealthrecord SET fname = '" + gadp_fname + "', lname = '" + gadp_lname + "', p_number = '" + gadp_pnumber + "', line_id = '" + gadp_line + "'" + "WHERE m_id = '" + m_id + "';";

            if (CL_Sql.Modify(sql))
            {
                result = true;
            }

            return result;
        }

        protected void btn_submit_gad7post_ServerClick(object sender, EventArgs e)
        {
            if (InsertDataGAD7POST())
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