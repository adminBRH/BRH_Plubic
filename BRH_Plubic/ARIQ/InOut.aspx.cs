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
    public partial class InOut : System.Web.UI.Page
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

        protected void rdl_status_SelectedIndexChanged(object sender, EventArgs e)
        {
            string status = rdl_status.SelectedValue.ToString();
            if (status == "unhold" || status == "cancel")
            {
                div_number.Visible = true;
            }
            else
            {
                div_number.Visible = false;
            }
        }

        protected void btn_room_Click(object sender, EventArgs e)
        {
            string status = rdl_status.SelectedValue.ToString();
            string roomid = txt_room.Value.ToString();
            string number = txt_number.Value.ToString().Trim();

            if (status == "next")
            {
                if (Next(roomid))
                {
                    Response.Redirect("InOut.aspx");
                }
            }
            else if (status == "hold")
            {
                if (hold(roomid))
                {
                    Response.Redirect("InOut.aspx");
                }
            }
            else if (status == "unhold")
            {
                if(unhold(roomid, number))
                {
                    Response.Redirect("InOut.aspx");
                }
            }
            else if (status == "cancel")
            {
                Cancel(number);
            }
            else
            {

            }
        }

        public Boolean Next(string roomid)
        {
            Boolean bl = false;

            string aqid = "";

            sql = "select * from ari_queue " +
                "where convert(aq_datetime,date) = current_date and aq_cancel = 'no' and aq_status = 'checking' and aq_arid = '" + roomid + "'; ";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                aqid = dt.Rows[0]["aq_id"].ToString();

                sql = "update ari_queue set aq_status = 'finish' where aq_id = '" + aqid + "' ";
                if (CL_Sql.Modify(sql))
                {
                    bl = true;
                }
            }
            else
            {
                bl = true;
            }

            Checking(roomid);

            return bl;
        }

        public Boolean hold(string roomid)
        {
            Boolean bl = false;

            sql = "select * from ari_queue " +
                "where convert(aq_datetime,date) = current_date and aq_cancel = 'no' and aq_status = 'checking' and aq_arid = '" + roomid + "'; ";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                string aqid = dt.Rows[0]["aq_id"].ToString();
                sql = "update ari_queue set aq_status = 'hold' where aq_id = '" + aqid + "' ";
                if (CL_Sql.Modify(sql))
                {
                    bl = true;
                }
            }

            return bl;
        }

        public Boolean unhold(string roomid, string number)
        {
            Boolean bl = false;

            sql = "select * from ari_queue " +
                "where convert(aq_datetime,date) = current_date and aq_cancel = 'no' and aq_status = 'hold' and aq_arid = '" + roomid + "'" +
                "and aq_number = '" + number + "'; ";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                string aqid = dt.Rows[0]["aq_id"].ToString();
                sql = "update ari_queue set aq_status = 'waiting' where aq_id = '" + aqid + "' ";
                if (CL_Sql.Modify(sql))
                {
                    bl = true;
                }
            }

            return bl;
        }

        public Boolean Checking(string roomid)
        {
            Boolean bl = false;

            sql = "select * from ari_queue " +
                 "where convert(aq_datetime,date) = current_date and aq_cancel = 'no' and aq_status = 'waiting' and aq_arid = '" + roomid + "' order by aq_datetime; ";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                string aqid = dt.Rows[0]["aq_id"].ToString();
                sql = "update ari_queue set aq_status = 'checking' where aq_id = '" + aqid + "' ";
                if (CL_Sql.Modify(sql))
                {
                    bl = true;
                }
            }
            else
            {
                bl = true;
            }

            return bl;
        }

        public Boolean Cancel(string number)
        {
            Boolean bl = false;

            sql = "select * from ari_queue " +
                "where convert(aq_datetime,date) = current_date and aq_cancel = 'no' and aq_status not in ('finish','cancel') and aq_number = '" + number + "'; ";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                string aqid = dt.Rows[0]["aq_id"].ToString();
                sql = "update ari_queue set aq_status = 'cancel' where aq_id = '" + aqid + "' ";
                if (CL_Sql.Modify(sql))
                {
                    bl = true;
                }
            }

            return bl;
        }
    }
}