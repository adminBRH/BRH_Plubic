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
    public partial class GAD7Negative : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass CL_Sql = new SQLclass();
        string id = "";
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public Boolean InsertDataGAD7Neg()
        {
            Boolean result = false;

            string m_id = id;
            m_id = Request.QueryString["id"];

            string gadn_fname = gad7neg_fname.Value.ToString().Trim();
            string gadn_lname = gad7neg_lname.Value.ToString().Trim();
            string gadn_pnumber = gad7neg_pnumber.Value.ToString().Trim();
            string gadn_line = gad7neg_line.Value.ToString().Trim();

            sql = "UPDATE mentalhealthrecord SET fname = '" + gadn_fname + "', lname = '" + gadn_lname + "', p_number = '" + gadn_pnumber + "', line_id = '" + gadn_line + "'" + "WHERE m_id = '" + m_id + "';";

            if (CL_Sql.Modify(sql))
            {
                result = true;
            }

            return result;

        }

        protected void btn_submit_gad7neg_ServerClick(object sender, EventArgs e)
        {
            if (InsertDataGAD7Neg())
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