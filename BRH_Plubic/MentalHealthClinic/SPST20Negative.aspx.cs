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
    public partial class SPST20Negative : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass CL_Sql = new SQLclass();
        string id = "";
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public Boolean InsertDataSPST20Neg()
        {
            Boolean result = false;

            string m_id = id;
            m_id = Request.QueryString["id"];

            string spstn_fname = spst20neg_fname.Value.ToString().Trim();
            string spstn_lname = spst20neg_lname.Value.ToString().Trim();
            string spstn_pnumber = spst20neg_pnumber.Value.ToString().Trim();
            string spstn_line = spst20neg_line.Value.ToString().Trim();

            sql = "UPDATE mentalhealthrecord SET fname = '" + spstn_fname + "', lname = '" + spstn_lname + "', p_number = '" + spstn_pnumber + "', line_id = '" + spstn_line + "'" + "WHERE m_id = '" + m_id + "';";

            if (CL_Sql.Modify(sql))
            {
                result = true;
            }


            return result;
        }

        protected void btn_submit_spst20neg_ServerClick(object sender, EventArgs e)
        {
            if (InsertDataSPST20Neg())
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