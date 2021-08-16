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
    public partial class Register : System.Web.UI.Page
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

        protected void btn_room_Click(object sender, EventArgs e)
        {
            string roomid = txt_room.Value.ToString();
            string number = txt_number.Value.ToString().Trim();

            sql = "select * from ari_queue " +
                "\nwhere convert(aq_datetime,date) = current_date and aq_cancel = 'no' and aq_status not in ('finish','cancel') " +
                "\nand aq_number = '" + number + "' " +
                "\norder by aq_datetime desc ";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0) 
            {
                lbl_alert.Text = "หมายเลขคิวนี้ ยังไม่จบ Process !!";
                lbl_alert.ForeColor = System.Drawing.Color.Red;
            }
            else
            {
                if (number == "")
                {
                    lbl_alert.Text = "กรุณากรอกหมายเลขคิว !!";
                    lbl_alert.ForeColor = System.Drawing.Color.Red;
                }
                else 
                {
                    string inssert = Insert(roomid, number);
                    if (inssert == "success")
                    {
                        lbl_alert.Text = "เพิ่มคิว " + number + " ที่ห้อง " + roomid + " เรียบร้อยแล้ว ☺";
                        lbl_alert.ForeColor = System.Drawing.Color.Blue;
                    }
                    else if (inssert == "NoRoom")
                    {
                        lbl_alert.Text = "ยังไม่มีแพทย์นั่งประจำห้อง !!";
                        lbl_alert.ForeColor = System.Drawing.Color.Red;
                    }
                    else
                    {
                        lbl_alert.Text = "ไมาสามารถเพิ่มหมายเลขคิวนี้ได้ กรุณาติดต่อผู้ดูแลระบบ !!";
                        lbl_alert.ForeColor = System.Drawing.Color.Red;
                    }
                }
            }
        }

        public string Insert(string Room, string Number)
        {
            string result = "";

            string ad_id = "";

            sql = "select * from ari_room where ar_id = '" + Room + "' and ar_active = 'yes' and ar_adid is not null ";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                ad_id = dt.Rows[0]["ar_adid"].ToString();

                sql = "insert into ari_queue(aq_arid,aq_number,aq_adid) value(" + Room + ",'" + Number + "','" + ad_id + "') ";
                if (CL_Sql.Modify(sql))
                {
                    result = "success";
                }
            }
            else
            {
                result = "NoRoom";
            }

            return result;
        }

        public Boolean Summary()
        {
            Boolean bl = false;

            lbl_doctor1.Text = ""; lbl_doctor2.Text = ""; lbl_doctor3.Text = ""; lbl_doctor4.Text = ""; lbl_doctor5.Text = ""; lbl_doctor6.Text = ""; lbl_doctor7.Text = "";
            lbl_f1.Text = ""; lbl_f2.Text = ""; lbl_f3.Text = ""; lbl_f4.Text = ""; lbl_f5.Text = ""; lbl_f6.Text = ""; lbl_f7.Text = "";
            lbl_h1.Text = ""; lbl_h2.Text = ""; lbl_h3.Text = ""; lbl_h4.Text = ""; lbl_h5.Text = ""; lbl_h6.Text = ""; lbl_h7.Text = "";
            lbl_n1.Text = ""; lbl_n2.Text = ""; lbl_n3.Text = ""; lbl_n4.Text = ""; lbl_n5.Text = ""; lbl_n6.Text = ""; lbl_n7.Text = "";

            sql = "select aq.aq_arid,aq.aq_status,ad.ad_name,count(aq.aq_number) as 'Qty' " +
                "\nfrom ari_queue as aq " +
                "\nleft join ari_doctor as ad on ad.ad_id = aq.aq_adid " +
                "\nwhere convert(aq.aq_datetime, date) = current_date and aq.aq_cancel = 'no' and aq_status != 'checking' " +
                "\nand aq.aq_adid in (select ar_adid from ari_room)  " +
                "\ngroup by aq.aq_arid,aq.aq_status,ad.ad_name ";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                string room = "";
                string status = "";
                string qty = "0";
                string doctor = "";

                for (int i=0; i<dt.Rows.Count; i++)
                {
                    room = dt.Rows[i]["aq_arid"].ToString();
                    status = dt.Rows[i]["aq_status"].ToString();
                    qty = dt.Rows[i]["Qty"].ToString();
                    doctor = dt.Rows[i]["ad_name"].ToString();

                    switch (room)
                    {
                        case "1":
                            lbl_doctor1.Text = doctor;
                            if (status == "finish") { lbl_f1.Text = "F=" + qty; }
                            if (status == "hold") { lbl_h1.Text = "H=" + qty; }
                            if (status == "waiting") { lbl_n1.Text = "W=" + qty; }
                            break;
                        case "2":
                            lbl_doctor2.Text = doctor;
                            if (status == "finish") { lbl_f2.Text = "F=" + qty; }
                            if (status == "hold") { lbl_h2.Text = "H=" + qty; }
                            if (status == "waiting") { lbl_n2.Text = "W=" + qty; }
                            break;
                        case "3":
                            lbl_doctor3.Text = doctor;
                            if (status == "finish") { lbl_f3.Text = "F=" + qty; }
                            if (status == "hold") { lbl_h3.Text = "H=" + qty; }
                            if (status == "waiting") { lbl_n3.Text = "W=" + qty; }
                            break;
                        case "4":
                            lbl_doctor4.Text = doctor;
                            if (status == "finish") { lbl_f4.Text = "F=" + qty; }
                            if (status == "hold") { lbl_h4.Text = "H=" + qty; }
                            if (status == "waiting") { lbl_n4.Text = "W=" + qty; }
                            break;
                        case "5":
                            lbl_doctor5.Text = doctor;
                            if (status == "finish") { lbl_f5.Text = "F=" + qty; }
                            if (status == "hold") { lbl_h5.Text = "H=" + qty; }
                            if (status == "waiting") { lbl_n5.Text = "W=" + qty; }
                            break;
                        case "6":
                            lbl_doctor6.Text = doctor;
                            if (status == "finish") { lbl_f6.Text = "F=" + qty; }
                            if (status == "hold") { lbl_h6.Text = "H=" + qty; }
                            if (status == "waiting") { lbl_n6.Text = "W=" + qty; }
                            break;
                        case "7":
                            lbl_doctor7.Text = doctor;
                            if (status == "finish") { lbl_f7.Text = "F=" + qty; }
                            if (status == "hold") { lbl_h7.Text = "H=" + qty; }
                            if (status == "waiting") { lbl_n7.Text = "W=" + qty; }
                            break;
                        default:
                            
                            break;
                    }
                }
            }

            return bl;
        }

        protected void Timer1_Tick(object sender, EventArgs e)
        {
            Summary();
        }
    }
}