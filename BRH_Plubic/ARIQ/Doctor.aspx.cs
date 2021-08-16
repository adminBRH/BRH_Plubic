using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;

namespace BRH_Plubic.ARIQ
{
    public partial class Doctor : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass CL_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Login"] != null)
            {
                string status = Session["status"].ToString();
                if (status == "admin" || status == "ari")
                {

                }
                else
                {
                    Response.Write("<script>alert('คุณไม่มีสิทธิ์ใช้งานหน้านี้ !!'); window.location.href='../Default.aspx';</script>");
                }
            }
            else
            {
                Response.Write("<script>alert('กรุณา Login ก่อนเข้าใช้งาน !!'); window.location.href='../Default.aspx';</script>");
            }
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            string status = "fail";
            string doctorName = txt_doctor.Value.ToString().Trim();
            string adstatus = txt_status.Value.ToString().Trim();
            string room = rdl_room.SelectedValue.ToString();
            sql = "update ari_doctor set ad_active = 'no' where ad_id = (select ar_adid from ari_room where ar_id = '" + room + "') ";
            if (CL_Sql.Modify(sql))
            {
                sql = "insert into ari_doctor(ad_name,ad_status) value('" + doctorName + "','" + adstatus + "') ";
                if (CL_Sql.Modify(sql))
                {
                    string ad_id = "";
                    sql = "select MAX(ad_id) as 'ad_id' from ari_doctor ";
                    dt = new DataTable();
                    dt = CL_Sql.select(sql);
                    if (dt.Rows.Count > 0)
                    {
                        ad_id = dt.Rows[0]["ad_id"].ToString();
                        sql = "update ari_room set ar_adid = '" + ad_id + "' where ar_id = '" + room + "' ";
                        if (CL_Sql.Modify(sql))
                        {
                            status = "success";
                        }
                    }
                }
                    
            }

            if (status == "fail")
            {
                Response.Write("<script>alert('ไม่สามารถบันทึกข้อได้ กรุณาติดต่อผู้ดูแลระบบ !!');</script>");
            }
            else
            {
                Response.Write("<script>alert('บันทึกข้อมูลเรียบร้อยแล้ว !!');</script>");
            }
        }
    }
}