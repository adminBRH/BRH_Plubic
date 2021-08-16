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
    public partial class ColorRedNegative : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass CL_Sql = new SQLclass();
        string id = "";
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public Boolean InsertNegative()
        {
            Boolean result = false;

            string m_id = id;
            m_id = Request.QueryString["id"];

            string fname_neg = yelneg_fname.Value.ToString().Trim();
            string lname_neg = yelneg_lname.Value.ToString().Trim();
            string pnumber_neg = yelneg_pnumber.Value.ToString().Trim();
            string line_neg = yelneg_line.Value.ToString().Trim();

            sql = "UPDATE mentalhealthrecord SET fname = '"+ fname_neg +"', lname = '"+ lname_neg +"', p_number = '"+ pnumber_neg +"', line_id = '"+ line_neg +"'" + "WHERE m_id = '"+ m_id +"';";

            if (CL_Sql.Modify(sql))
            {
                result = true;
            }
            return result;
        }

        protected void btn_submit_ylneg_ServerClick(object sender, EventArgs e)
        {
            if (InsertNegative())
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