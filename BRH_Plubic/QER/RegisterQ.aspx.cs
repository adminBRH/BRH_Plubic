using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;

namespace BRH_Plubic.QER
{
    public partial class RegisterQ : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass CL_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["login"] != null)
            {
                string status = Session["status"].ToString();
                if (status == "admin" || status == "er")
                {

                }
                else
                {
                    Response.Write("<script>alert('คุณไม่มีสิทธิ์ใช้งานหน้านี้ !!'); window.location.href='../default.aspx';</script>");
                }
            }
            else
            {
                Response.Write("<script>alert('กรุณา login ก่อนเข้าใช้งาน !!'); window.location.href='../default.aspx';</script>");
            }

        }

        public string InsertQ(string Queue ,string idTriage)
        {
            string result = "";

            if (CheckQueue(Queue))
            {
                sql = "INSERT INTO qer_register" +
                        "(qer_triage, qer_qnumber, qer_startdate, qer_status)" +
                        "VALUES('" + idTriage + "', '" + Queue + "', current_timestamp(), 'wait'); ";
                if (CL_Sql.Modify(sql))
                {
                    result = "success";
                }
                else
                {
                    result = "not save";
                }
            }
            else
            {
                result = "duplicate";
            }
            return result;
        }

        public Boolean CheckQueue(string Q)
        {
            Boolean result = true;
            if (Q == "")
            {
                result = false;
            }
            else
            {
    
                sql = "select * from qer_register where qer_qnumber = '" + Q + "' and qer_status in ('wait','process'); ";
       
                dt = new DataTable(); //ต้อง new data table ใหม่ทุกครั้งเมื่อรับค่า
                dt = CL_Sql.select(sql);
                if (dt.Rows.Count > 0) //หาข้อมูลว่ามีบรรทัดนั้นหรือไม่ 
                {
                    result = false;
                }
            }
            return result;

        }

        protected void triage_lv_ServerClick(object sender, EventArgs e)
        {
            string textboxq = txtq_input.Value.ToString().Trim();
            string txt_triage = txtH_id_triage.Value.ToString().Trim();

            string result = InsertQ(textboxq, txt_triage);
            if (result == "success")
            {
                Response.Write("<script>alert('บันทึก Q สำเร็จ'); window.location.href='RegisterQ.aspx';</script>");
            }
            else if (result == "duplicate")
            {
                Response.Write("<script>alert('หมายเลข Q นี้ มีการใช้งานอยู่แล้ว !!');</script>");
            }
            else
            {
                Response.Write("<script>alert('ไม่สามารถบันทึกได้กรุณาติดต่อ Admin');</script>");
            }
        }

       
    }
}