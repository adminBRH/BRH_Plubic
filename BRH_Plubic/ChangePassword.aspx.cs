using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;

namespace BRH_Plubic
{
    public partial class ChangePassword : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass CL_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_submit_ServerClick(object sender, EventArgs e)
        {
            string new_pass = txt_newpass.Value.ToString();
            string conf_pass = txt_confpass.Value.ToString();
            string old_pass = txt_oldpass.Value.ToString();

            if (new_pass != conf_pass)
            {
                lbl_alert.Text = "รหัสผ่านใหม่ไม่ตรงกัน !!";
            }
            else
            {
                string userid = Session["userid"].ToString();
                string userStatus = Session["status"].ToString();

                string table = "";
                string fieldID = "";
                string fieldpass = "";

                if (userStatus == "customer")
                {
                    table = "customer set cus_editdate = current_timestamp, cus_password";
                    fieldID = "cus_id";
                    fieldpass = "cus_password";
                }
                else if (userStatus == "employee")
                {
                    table = "employee set emp_editdate = current_timestamp, emp_password";
                    fieldID = "emp_id";
                    fieldpass = "emp_password";
                }
                else 
                {
                    table = "users set user_password";
                    fieldID = "user_id";
                    fieldpass = "user_password";
                }

                sql = "Update " + table + " = md5('" + conf_pass + "') where " + fieldID + " = '" + userid + "' and " + fieldpass + " = md5('" + old_pass + "') ";
                if (CL_Sql.Modify(sql))
                {
                    Session.Clear();

                    HttpCookie delCook = new HttpCookie("myCookie");
                    delCook.Expires = DateTime.Now.AddDays(-1D);
                    Response.Cookies.Add(delCook);

                    Response.Write("<script>alert('บันทึกข้อมูลเรียบร้อยแล้ว'); window.location.href='Default.aspx'</script>");
                }
                else
                {
                    lbl_alert.Text = "Password ไม่ถูกต้อง !!";
                }
            }
        }
    }
}