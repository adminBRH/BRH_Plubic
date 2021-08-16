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
    public partial class PHQ9Negative : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass CL_Sql = new SQLclass();
        string id = "";
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public Boolean InsertPHQNeg()
        {
            Boolean result = false;

            string m_id = id;
            m_id = Request.QueryString["id"];

            string phqnegfname = phqneg_fname.Value.ToString().Trim();
            string phqneglname = phqneg_lname.Value.ToString().Trim();
            string phqnegpnumber = phqneg_pnumber.Value.ToString().Trim();
            string phqnegline = phqneg_line.Value.ToString().Trim();

            sql = "UPDATE mentalhealthrecord SET fname = '" + phqnegfname + "', lname = '" + phqneglname + "', p_number = '" + phqnegpnumber + "', line_id = '" + phqnegline + "'" + "WHERE m_id = '" + m_id + "';";

            if (CL_Sql.Modify(sql))
            {
                result = true;
            }
            return result;
    
        }

        protected void btn_submit_phqneg_ServerClick(object sender, EventArgs e)
        {
            if (InsertPHQNeg())
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