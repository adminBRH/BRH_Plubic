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
    public partial class ColorGreen : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass CL_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public Boolean InsertData(string id)
        {
            Boolean result = false;

            string m_id = id;

            string fname = txt_fname.Value.ToString().Trim();
            string lname = txt_lname.Value.ToString().Trim();
            string pnumber = txt_phone.Value.ToString().Trim();
            string line = txt_line.Value.ToString().Trim();
            string empid = txt_empid.Value.ToString().Trim();

            string accommodation = dd_accommodation.SelectedValue.ToString();
            string roomNumber = txt_roomnumber.Value.ToString().Trim();

            sql = "UPDATE mentalhealthrecord " +
                "SET fname = '" + fname + "', lname = '" + lname + "', p_number = '" + pnumber + "', line_id = '" + line + "', emp_id = '" + empid + "' " +
                ",accommodation = '" + accommodation + "', room_number = '" + roomNumber + "' " +
                "WHERE m_id = '" + m_id + "';";
            if (CL_Sql.Modify(sql))
            {
                result = true;
            }

            return result;
        }

        protected void btn_submit_ServerClick(object sender, EventArgs e)
        {
            if (Request.QueryString["id"] != null)
            {
                string m_id = Request.QueryString["id"].ToString();

                if (InsertData(m_id))
                {
                    Response.Write("<script>alert('บันทึกข้อมูลของท่านเรียบร้อยแล้ว');</script>");
                }
                else
                {
                    Response.Write("<script>alert('ไม่สามารถบันทึกได้กรุณาติดต่อ Admin !!');</script>");
                }
            }
            else
            {
                Response.Redirect("Default.aspx");
            }
        }
    }
}