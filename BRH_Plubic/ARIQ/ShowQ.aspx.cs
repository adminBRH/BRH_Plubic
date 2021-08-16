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
    public partial class ShowQ : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass CL_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        public Boolean Doctor()
        {
            Boolean bl = false;

            sql = "select ar.*,ad.ad_name,ad.ad_status " +
                "from ari_room as ar " +
                "left join ari_doctor as ad on ad.ad_id = ar.ar_adid " +
                "order by ar_id ";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    string roomid = dt.Rows[i]["ar_id"].ToString();
                    string doctor = dt.Rows[i]["ad_name"].ToString();
                    string status = dt.Rows[i]["ad_status"].ToString();

                    switch (roomid)
                    {
                        case "1":
                            lbl_doctor1.Text = doctor;
                            lbl_status1.Text = status;
                            break;
                        case "2":
                            lbl_doctor2.Text = doctor;
                            lbl_status2.Text = status;
                            break;
                        case "3":
                            lbl_doctor3.Text = doctor;
                            lbl_status3.Text = status;
                            break;
                        case "4":
                            lbl_doctor4.Text = doctor;
                            lbl_status4.Text = status;
                            break;
                        case "5":
                            lbl_doctor5.Text = doctor;
                            lbl_status5.Text = status;
                            break;
                        case "6":
                            lbl_doctor6.Text = doctor;
                            lbl_status6.Text = status;
                            break;
                        case "7":
                            lbl_doctor7.Text = doctor;
                            lbl_status7.Text = status;
                            break;
                    }

                }
            }

            return bl;
        }

        public Boolean SelectData()
        {
            Boolean bl = false;

            sql = "select * from ari_queue "+
                "where convert(aq_datetime, date) = current_date and aq_cancel = 'no' and aq_status not in ('finish','cancel') and aq_arid=1 " +
                "order by aq_status ,aq_arid, aq_datetime ";
            DataTable dt1 = new DataTable();
            dt1 = CL_Sql.select(sql);

            sql = "select * from ari_queue " +
                "where convert(aq_datetime, date) = current_date and aq_cancel = 'no' and aq_status not in ('finish','cancel') and aq_arid=2 " +
                "order by aq_status ,aq_arid, aq_datetime ";
            DataTable dt2 = new DataTable();
            dt2 = CL_Sql.select(sql);
            
            sql = "select * from ari_queue " +
                "where convert(aq_datetime, date) = current_date and aq_cancel = 'no' and aq_status not in ('finish','cancel') and aq_arid=3 " +
                "order by aq_status ,aq_arid, aq_datetime ";
            DataTable dt3 = new DataTable();
            dt3 = CL_Sql.select(sql);

            sql = "select * from ari_queue " +
                "where convert(aq_datetime, date) = current_date and aq_cancel = 'no' and aq_status not in ('finish','cancel') and aq_arid=4 " +
                "order by aq_status ,aq_arid, aq_datetime ";
            DataTable dt4 = new DataTable();
            dt4 = CL_Sql.select(sql);

            sql = "select * from ari_queue " +
                "where convert(aq_datetime, date) = current_date and aq_cancel = 'no' and aq_status not in ('finish','cancel') and aq_arid=5 " +
                "order by aq_status ,aq_arid, aq_datetime ";
            DataTable dt5 = new DataTable();
            dt5 = CL_Sql.select(sql);

            sql = "select * from ari_queue " +
                "where convert(aq_datetime, date) = current_date and aq_cancel = 'no' and aq_status not in ('finish','cancel') and aq_arid=6 " +
                "order by aq_status ,aq_arid, aq_datetime ";
            DataTable dt6 = new DataTable();
            dt6 = CL_Sql.select(sql);

            sql = "select * from ari_queue " +
                "where convert(aq_datetime, date) = current_date and aq_cancel = 'no' and aq_status not in ('finish','cancel') and aq_arid=7 " +
                "order by aq_status ,aq_arid, aq_datetime ";
            DataTable dt7 = new DataTable();
            dt7 = CL_Sql.select(sql);

            int CNT1 = dt1.Rows.Count;
            int CNT2 = dt2.Rows.Count;
            int CNT3 = dt3.Rows.Count;
            int CNT4 = dt4.Rows.Count;
            int CNT5 = dt5.Rows.Count;
            int CNT6 = dt6.Rows.Count;
            int CNT7 = dt7.Rows.Count;
            string black1 = "";
            string black2 = "";
            string black3 = "";
            string black4 = "";
            string black5 = "";
            string black6 = "";
            string black7 = "";

            string HTML = "";

            int i = 0;
            int j = 0;
            while (j == 0)
            {
                int Stop = 0;

                HTML = HTML + "<tr>";

                // ------------------------------------- ========= ROOM 1 =========
                if (CNT1 > i)
                {
                    int ii = i;
                    if (black1 == "yes") { ii = ii - 1; }
                    Stop = Stop + 1;
                    string status = dt1.Rows[ii]["aq_status"].ToString();
                    string room = dt1.Rows[ii]["aq_arid"].ToString();
                    string number = dt1.Rows[ii]["aq_number"].ToString();
                    if (i == 0 && status != "checking") { HTML = HTML + CreateTD("", "", ""); CNT1 = CNT1 + 1; black1 = "yes"; }
                    else { HTML = HTML + CreateTD(status, room, number); }
                }
                else { HTML = HTML + CreateTD("", "", ""); }
                // ------------------------------------- ========= ROOM 2 =========
                if (CNT2 > i)
                {
                    int ii = i;
                    if (black2 == "yes") { ii = ii - 1; }
                    Stop = Stop + 1;
                    string status = dt2.Rows[ii]["aq_status"].ToString();
                    string room = dt2.Rows[ii]["aq_arid"].ToString();
                    string number = dt2.Rows[ii]["aq_number"].ToString();
                    if (i == 0 && status != "checking") { HTML = HTML + CreateTD("", "", ""); CNT2 = CNT2 + 1; black2 = "yes"; }
                    else { HTML = HTML + CreateTD(status, room, number); }
                }
                else { HTML = HTML + CreateTD("", "", ""); }
                // ------------------------------------- ========= ROOM 3 =========
                if (CNT3 > i)
                {
                    int ii = i;
                    if (black3 == "yes") { ii = ii - 1; }
                    Stop = Stop + 1;
                    string status = dt3.Rows[ii]["aq_status"].ToString();
                    string room = dt3.Rows[ii]["aq_arid"].ToString();
                    string number = dt3.Rows[ii]["aq_number"].ToString();
                    if (i == 0 && status != "checking") { HTML = HTML + CreateTD("", "", ""); CNT3 = CNT3 + 1; black3 = "yes"; }
                    else { HTML = HTML + CreateTD(status, room, number); }
                }
                else { HTML = HTML + CreateTD("", "", ""); }
                // ------------------------------------- ========= ROOM 4 =========
                if (CNT4 > i) 
                {
                    int ii = i;
                    if (black4 == "yes") { ii = ii - 1; }
                    Stop = Stop + 1;
                    string status = dt4.Rows[ii]["aq_status"].ToString();
                    string room = dt4.Rows[ii]["aq_arid"].ToString();
                    string number = dt4.Rows[ii]["aq_number"].ToString();
                    if (i == 0 && status != "checking") { HTML = HTML + CreateTD("", "", ""); CNT4 = CNT4 + 1; black4 = "yes"; }
                    else { HTML = HTML + CreateTD(status, room, number); }
                }
                else { HTML = HTML + CreateTD("", "", ""); }
                // ------------------------------------- ========= ROOM 5 =========
                if (CNT5 > i)
                {
                    int ii = i;
                    if (black5 == "yes") { ii = ii - 1; }
                    Stop = Stop + 1;
                    string status = dt5.Rows[ii]["aq_status"].ToString();
                    string room = dt5.Rows[ii]["aq_arid"].ToString();
                    string number = dt5.Rows[ii]["aq_number"].ToString();
                    if (i == 0 && status != "checking") { HTML = HTML + CreateTD("", "", ""); CNT5 = CNT5 + 1; black5 = "yes"; }
                    else { HTML = HTML + CreateTD(status, room, number); }
                }
                else { HTML = HTML + CreateTD("", "", ""); }
                // ------------------------------------- ========= ROOM 6 =========
                if (CNT6 > i)
                {
                    int ii = i;
                    if (black6 == "yes") { ii = ii - 1; }
                    Stop = Stop + 1;
                    string status = dt6.Rows[ii]["aq_status"].ToString();
                    string room = dt6.Rows[ii]["aq_arid"].ToString();
                    string number = dt6.Rows[ii]["aq_number"].ToString();
                    if (i == 0 && status != "checking") { HTML = HTML + CreateTD("", "", ""); CNT6 = CNT6 + 1; black6 = "yes"; }
                    else { HTML = HTML + CreateTD(status, room, number); }
                }
                else { HTML = HTML + CreateTD("", "", ""); }
                // ------------------------------------- ========= ROOM 7 =========
                if (CNT7 > i)
                {
                    int ii = i;
                    if (black7 == "yes") { ii = ii - 1; }
                    Stop = Stop + 1;
                    string status = dt7.Rows[ii]["aq_status"].ToString();
                    string room = dt7.Rows[ii]["aq_arid"].ToString();
                    string number = dt7.Rows[ii]["aq_number"].ToString();
                    if (i == 0 && status != "checking") { HTML = HTML + CreateTD("", "", ""); CNT7 = CNT7 + 1; black7 = "yes"; }
                    else { HTML = HTML + CreateTD(status, room, number); }
                }
                else { HTML = HTML + CreateTD("", "", ""); }

                HTML = HTML + "</tr>";

                if (Stop == 0)
                {
                    j = 1;
                    break;
                }

                i++;
            }

            lbl_html.Text = HTML;

            return bl;
        }

        public string CreateTD(string status,string room,string number)
        {
            string result = "";

            string TD = "";

            if (status == "")
            {
                TD = "<td width=\"14%\"><div class=\"col-8 btn\" style=\"font-size:75px;\">&nbsp;</div></td>";
            }
            else
            {
                if (status == "checking")
                {
                    TD = "<td width=\"14%\"><div class=\"col-8 btn text-center\" style=\"background-image: url(images/Qme.gif); background-position-x:center; background-size:contain; background-repeat:no-repeat; font-size:85px; color:white;\">" + number + "</div></td>";
                }
                else if (status == "hold")
                {
                    TD = "<td width=\"14%\"><div class=\"col-8 rounded-circle btn btn-light bg-warning\" style=\"font-size:75px; color:white\">" + number + "</div></td>";
                }
                else if (status == "waiting")
                {
                    TD = "<td width=\"14%\"><div class=\"col-8 rounded-circle btn btn-light bg-danger\" style=\"font-size:75px; color:white\">" + number + "</div></td>";
                }
                else
                {
                    TD = "<td width=\"14%\">&nbsp;</td>";
                }
            }

            result = TD;

            return result;
        }

        protected void Timer1_Tick(object sender, EventArgs e)
        {
            Doctor();
            SelectData();
        }
    }
}