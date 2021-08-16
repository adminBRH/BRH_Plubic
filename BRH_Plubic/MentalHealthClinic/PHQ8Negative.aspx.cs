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
    public partial class PHQ8Negative : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass CL_Sql = new SQLclass();
        string id = "";
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public Boolean InsertDataPHQ8Neg()
        {
            Boolean result = false;

            string m_id = id;
            m_id = Request.QueryString["id"];

            string phq8n_fname = phq8neg_fname.Value.ToString().Trim();
            string phq8n_lname = phq8neg_lname.Value.ToString().Trim();
            string phq8n_pnumber = phq8neg_pnumber.Value.ToString().Trim();
            string phq8n_line = phq8neg_line.Value.ToString().Trim();

            sql = "UPDATE mentalhealthrecord SET fname = '" + phq8n_fname + "', lname = '" + phq8n_lname + "', p_number = '" + phq8n_pnumber + "', line_id = '" + phq8n_line + "'" + "WHERE m_id = '" + m_id + "';";

            if (CL_Sql.Modify(sql))
            {
                result = true;
            }

            return result;
        }

        protected void btn_submit_phq8neg_ServerClick(object sender, EventArgs e)
        {
            if (InsertDataPHQ8Neg())
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