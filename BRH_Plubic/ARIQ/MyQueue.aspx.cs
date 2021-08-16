using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;
using System.Drawing;

namespace BRH_Plubic.ARIQ
{
    public partial class MyQueue : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass CL_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["number"] != null)
            {
                lbl_alert.Text = "";
                div_check.Visible = false;
                div_ShowQ.Visible = true;
            }
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            string number = txt_number.Value.ToString().Trim();
            string aqid = SelectQueue(number);
            if (aqid == "")
            {
                lbl_alert.Text = "หมายเลขคิวที่ " + number + " ไม่มีในลำดับคิว ณ ตอนนี้";
                lbl_alert.ForeColor = Color.Red;

                div_check.Visible = true;
                div_ShowQ.Visible = false;
            }
            else
            {
                Response.Redirect("MyQueue.aspx?number=" + number);
            }
        }

        public string SelectQueue(string number)
        {
            string result = "";

            sql = "select * from ari_queue where convert(aq_datetime, date) = current_date and aq_cancel = 'no' and aq_status not in ('finish','cancel') and aq_number = '" + number + "' ";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                string aqid = dt.Rows[0]["aq_id"].ToString();

                string status = dt.Rows[0]["aq_status"].ToString();
                string room = dt.Rows[0]["aq_arid"].ToString();

                lbl_room.Text = "ห้องที่ " + room;

                lbl_html.Text = CreateHTML(status, number);
                Detail(room, status, aqid);

                result = aqid;
            }
            else
            {
                lbl_detail.Text = "หมายเลขคิวที่ " + number + " ไม่มีในลำดับคิว ณ ตอนนี้";
                lbl_detail.ForeColor = Color.Red;
            }

            return result;
        }

        public string CreateHTML(string status, string number)
        {
            string result = "";

            if (status == "waiting")
            {
                result = "<div class=\"col-8 rounded-circle btn btn-light bg-danger\" style=\"font-size:75px; color:white\">" + number + "</div>";
            }
            else if (status == "hold")
            {
                result = "<div class=\"col-8 rounded-circle btn btn-light bg-warning\" style=\"font-size:75px; color:white\">" + number + "</div>";
            }
            else if (status == "checking")
            {
                result = "<div class=\"col-8 btn text-center\" style=\"background-image: url(images/Qme.gif); background-position-x:center; background-size:contain; background-repeat:no-repeat; font-size:85px; color:white;\">" + number + "</div>";
            }
            else 
            {
                result = "<div class=\"col-8 btn\" style=\"font-size:75px;\">&nbsp;</div>";
            }

            return result;
        }

        public Boolean Detail(string room, string status, string aqid)
        {
            Boolean bl = false;

            sql = "select count(aq_id) as 'qty' from ari_queue " +
                "where convert(aq_datetime, date) = current_date and aq_cancel = 'no' and aq_status in ('checking','waiting')  " +
                "and aq_arid = '" + room + "' and aq_id <= '" + aqid + "' ";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                int Qty = int.Parse(dt.Rows[0]["qty"].ToString()) - 1;
                if (status == "waiting")
                {
                    if (Qty == 0)
                    {
                        lbl_detail.Text = "รอเข้าพบแพทย์";
                    }
                    else
                    {
                        lbl_detail.Text = "รออีก " + Qty.ToString() + " คิว";
                    }
                    lbl_detail.CssClass = "bg-danger";
                }
                else if (status == "hold")
                {
                    lbl_detail.Text = "รอฟังผลตรวจ";
                    lbl_detail.CssClass = "bg-warning";
                }
                else if (status == "checking")
                {
                    lbl_detail.Text = "เข้าพบแพทย์";
                    lbl_detail.CssClass = "bg-success";
                }
                else
                {

                }
                bl = true;
            }

            return bl;
        }

        protected void Timer1_Tick(object sender, EventArgs e)
        {
            if (Request.QueryString["number"] != null)
            {
                lbl_alert.Text = "";
                div_check.Visible = false;
                div_ShowQ.Visible = true;

                string number = Request.QueryString["number"].ToString();
                SelectQueue(number);
            }
        }
    }
}