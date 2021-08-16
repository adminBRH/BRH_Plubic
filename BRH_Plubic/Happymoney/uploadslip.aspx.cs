using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;

namespace BRH_Plubic.Happymoney
{
    public partial class uploadslip : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Login"] == null)
            {
                Response.Write("<script>alert('กรุณา Login ก่อนเข้าใช้งาน');window.location.href='../Default.aspx';</script>");
                //Response.Write("<script>alert('กรุณา Login ก่อนเข้าใช้งาน !!'); window.location.href='../Default.aspx';</script>");
            }
        }

        public Boolean upload_slip() 
        {        
            Boolean bl = false;

            string empid = "";
            string txtdateslip = txt_dateslip.Value.ToString().Trim();
            string txtmoney = txt_money.Value.ToString().Trim();

            if (Session["userid"] != null)
            {
                empid = Session["userid"].ToString();           
            }         
            
            sql = "insert into mon_savemoney(mo_empid, mo_date, mo_craetedate, mo_money,mo_money_active) " +
                "VALUE('"+ empid +"','"+txtdateslip+"',CURRENT_TIMESTAMP(),"+txtmoney+ ",'Waiting');";
            if (cl_Sql.Modify(sql))
            {
                string id = cl_Sql.LastID("mo_id", "mon_savemoney");
                if (upload_file(id))
                {
                    bl = true;
                }
                else
                {                 
                    sql = "update mon_savemoney set mo_money_active = 'cancel' where mo_id = '"+ id +"'";
                    cl_Sql.Modify(sql);
                }               
            }          
            return bl;
        }

        protected void btn_uploadslip_ServerClick(object sender, EventArgs e)
        {
            if (upload_slip())
            {
                Response.Write("<script>alert('ส่งสลิปสำเร็จ');</script>");
            }
            else
            {
                Response.Write("<script>alert('ไม่สามารถส่งสลิปได้ กรุณาติดต่อผู้ดูแลระบบ !!');</script>");
            }
        }
        public Boolean upload_file(string id)
        {
            Boolean bl = false;
            if (fu_slip.HasFile)
            {
                string file_name = "";
                foreach (HttpPostedFile get_file in fu_slip.PostedFiles )
                {
                    file_name = fu_slip.FileName;
                    string[] list_file = file_name.ToString().Split('.');
                    int maxindex = list_file.Length -1;
                    if (list_file[maxindex].ToString() == "jpg" || list_file[maxindex].ToString() == "jpeg" || list_file[maxindex].ToString() == "png")
                    {
                        file_name = "id" + id + ",savemoney." + list_file[maxindex].ToString();
                        txt_filename.Value = list_file[maxindex].ToString();
                        get_file.SaveAs(System.IO.Path.Combine(Server.MapPath("~/Happymoney/image/slip/"), file_name));

                        bl = true;
                        string typefile = txt_filename.Value.ToString().Trim();
                        sql = "update mon_savemoney set `mo_imageSlip` = '" + typefile + "' where mo_id='" + id + "'";
                        cl_Sql.Modify(sql);
                    }
                }
            }


            return bl;
        }
    }
}