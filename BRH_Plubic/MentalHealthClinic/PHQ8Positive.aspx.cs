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
    public partial class PHQ8Positive : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass CL_Sql = new SQLclass();
        string id = "";
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public Boolean InsertDataPHQ8POST()
        {
            Boolean result = false;

            string m_id = id;
            m_id = Request.QueryString["id"];

            string phq8p_fname = phq8post_fname.Value.ToString().Trim();
            string phq8p_lname = phq8post_lname.Value.ToString().Trim();
            string phq8p_pnumber = phq8post_pnumber.Value.ToString().Trim();
            string phq8p_line = phq8post_line.Value.ToString().Trim();

            sql = "UPDATE mentalhealthrecord SET fname = '" + phq8p_fname + "', lname = '" + phq8p_lname + "', p_number = '" + phq8p_pnumber + "', line_id = '" + phq8p_line + "'" + "WHERE m_id = '" + m_id + "';";

            if (CL_Sql.Modify(sql))
            {
                result = true;
            }
            return result;

        }

        protected void btn_submit_phq8post_ServerClick(object sender, EventArgs e)
        {
            if (InsertDataPHQ8POST())
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