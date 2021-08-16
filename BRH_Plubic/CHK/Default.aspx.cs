using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;

namespace BRH_Plubic.CHK
{
    public partial class Default : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Login"] == null)
            {
                Response.Redirect("../Default.aspx?back=CHK&login=require");
            }
            else
            {
                string status = Session["status"].ToString();
                if (status == "admin" || status == "hr" || status == "checkup" || status == "xray" || status == "mao")
                {

                }
                else
                {
                    Response.Write("<script>alert('คุณไม่มีสิทธิ์ ใช้งานระบบนี้ !!'); window.location.href='../Default.aspx';</script>");
                }
            }
            
        }

        protected void btn_ClearDB_Click(object sender, EventArgs e)
        {
            //sql = "truncate table bookingdetail; "+
            //    "truncate table bookingrecord; " +
            //    "truncate table bookingslot; " +
            //    "truncate table bookingforminputlist; " +
            //    "truncate table bookingforminput; " +
            //    "truncate table bookingform; " +
            //    "INSERT INTO bookingform (bf_editby, bf_formname) VALUES('admin', 'ไม่ใช้'); ";
            //if (cl_Sql.Modify(sql))
            //{
            //    lbl_alertModal.Text = "<script>alertModal('#Modal_Success');</script>";
            //}
        }
    }
}