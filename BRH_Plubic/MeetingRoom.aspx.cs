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
    public partial class MeetingRoom : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass CL_Sql = new SQLclass();
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Login"] != null)
            {
                string status = Session["status"].ToString();
                if (status == "admin" || status == "hod")
                {
                    Response.Write("<script>function ShowBook() { divAdd.hidden = false; }</script>");
                }
                else
                {
                    Response.Write("<script>function ShowBook() { alert('คุณไม่มีสิทธิ์ ทำการจองห้องประชุม !!'); window.location.href='../Default.aspx'; }</script>");
                }
            }
            else
            {
                Response.Write("<script>function ShowBook() { alert('กรุณา Login ก่อนทำการจองห้องประชุม !!'); window.location.href='../Default.aspx'; }</script>");
            }

            if (!IsPostBack)
            {
                Showdata("","","");
            }           
        }

        public Boolean Showdata(string dateStart, string dateEnd, string topic)
        {
            Boolean result = false;

            string date = "";
            if (dateStart == "" && dateEnd == "")
            {
                date = ">= CONVERT(DATE_ADD(current_timestamp, INTERVAL -7 DAY), date)";
            }
            else
            {
                date = "between '" + DateTime.Parse(dateStart).ToString("yyyy-MM-dd") + "' and '" + DateTime.Parse(dateEnd).ToString("yyyy-MM-dd") + "' ";
            }

            sql = "select * from ( "+
                "select *, if (convert(NOW(), date) = convert(cms_timestart, date),'0','1') as 'cms_rank' "+
                ",DATE_FORMAT(cms_timestart, '%d/%b/%Y') as 'dateStart' "+
                ",DATE_FORMAT(cms_timeend, '%d/%b/%Y') as 'dateEnd' "+
                ",DATE_FORMAT(cms_timestart, '%H:%i') as 'timeStart' "+
                ",DATE_FORMAT(cms_timeend, '%H:%i') as 'timeEnd' "+
                "\n,if(convert(cms_timestart,date)=current_date,'primary','info') as 'dateCoclor' " +
                "\n,concat('ห้อง ',cms_room,' ',cms_sj,' (',cms_timestart,'-',cms_timeend,')') as 'cmsSJ' " +
                "\n,concat('slot=',cms_id,'&room=',cms_room)as 'cms_link' " +
                "\nfrom checkinmeetingslot as c " +
                "\nwhere cms_status = 'CONFIRM' " +
                "\nAND ( convert(cms_timeend,date) " + date + " )" +
                "\nAND ( cms_sj like '%" + topic + "%' ) " +
                "\n) as a order by a.cms_rank, a.cms_timestart desc  ";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                result = true;
            }
            LV_book.DataSource = dt;
            LV_book.DataBind();

            return result;
        }
         
        public string InsertData()
        {
            string result = "";

            string meet_id = txth_room.Value.ToString();

            string texthead = txt_sj.Value.ToString().Trim();
            string datest = date_start.Value.ToString().Trim();
            string dateend = date_end.Value.ToString().Trim();
            string timest = time_start.Value.ToString().Trim();
            string timeend = time_end.Value.ToString().Trim();

            string datetimest = datest + " " + timest;
            string datetimeend = dateend + " " + timeend;

            if (BookDuplicate(meet_id, datetimest))
            {
                sql = "INSERT INTO checkinmeetingslot" +
                            "(cms_sj, cms_timestart, cms_timeend, cms_room, cms_status)" +
                            "VALUES('" + texthead + "', '" + datetimest + "' , '" + datetimeend + "', '" + meet_id + "', 'CONFIRM');";

                if (CL_Sql.Modify(sql))
                {
                    result = "success";
                }
            }
            else
            {
                result = "duplicate";
            }

            return result;
        }

        public Boolean BookDuplicate(string room, string dateStart)
        {
            Boolean bl = true;

            sql = "select * from checkinmeetingslot "+
                "where cms_status = 'CONFIRM' and cms_room = '" + room + "' " +
                "and(cms_timestart <= '" + dateStart + "' and cms_timeend >= '" + dateStart + "')";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                bl = false;
            }

            return bl;
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            //string datestart = date_start.Value +" "+ time_start.Value;
            //string dateend = date_end.Value +" "+ time_end.Value;

            //if (CB_room1.Checked)
            //{
            //    CB_room1.Checked.ToString();
            //}
            // else if (!CB_room2.Checked)
            //{
            //    CB_room2.Checked.ToString();
            //}

            string result = InsertData();
            if (result == "success")
            {
                Response.Write("<script>alert('บันทึกสำเร็จ'); window.location.href='CheckinMeeting.aspx';</script>");

            }
            else
            {
                if (result == "duplicate")
                {
                    Response.Write("<script>alert('ห้องประชุมนี้ มีคนจองในช่วงวันเวลานี้ไว้แล้ว !!');</script>");
                }
                else
                {
                    Response.Write("<script>alert('ไม่สามารถบันทึกได้กรุณาติดต่อ Admin');</script>");
                }
                
            }

        }

        protected void btn_Search_ServerClick(object sender, EventArgs e)
        {
            string Startdate = txt_dateStart.Value.ToString();
            string Enddate = txt_dateEnd.Value.ToString();
            string Topic = txt_topic.Value.ToString().Trim();

            Showdata(Startdate, Enddate, Topic);
        }
    }
}