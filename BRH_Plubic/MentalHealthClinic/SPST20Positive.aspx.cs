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
    public partial class SPST20Positive : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass CL_Sql = new SQLclass();
        string id = "";
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public Boolean InsertDataSPST20()
        {
            Boolean result = false;

            string m_id = id;
            m_id = Request.QueryString["id"];

            string spstp_fname = spst20post_fname.Value.ToString().Trim();
            string spstp_lname = spst20post_lname.Value.ToString().Trim();
            string spstp_pnumber = spst20post_pnumber.Value.ToString().Trim();
            string spstp_line = spst20post_line.Value.ToString().Trim();

            sql = "UPDATE mentalhealthrecord SET fname = '" + spstp_fname + "', lname = '" + spstp_lname + "', p_number = '" + spstp_pnumber + "', line_id = '" + spstp_line + "'" + "WHERE m_id = '" + m_id + "';";

            if (CL_Sql.Modify(sql))
            {
                result = true;
            }

            return result;
        }

        protected void btn_submit_spst20post_ServerClick(object sender, EventArgs e)
        {
            if (InsertDataSPST20())
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