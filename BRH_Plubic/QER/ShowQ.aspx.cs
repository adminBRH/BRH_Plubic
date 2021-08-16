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
    public partial class ShowQ : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass CL_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                TypeIcon();
            }
        }

        public Boolean ListViewQ()
        {
            Boolean result = false;

            sql = "SELECT * FROM qer_register as qr " +
                "LEFT JOIN qer_triage as q on q.qer_triage_lv = qr.qer_triage " +
                "where qer_status = 'wait' " +
                "ORDER BY qer_triage_lv,qer_id;";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            //string html = "<div class='col-12 mx-auto my-auto text-center'><span class='mx-auto my-auto text-center texticonDetail' style='background-color:#0094ff;'>คิวที่รอ</span></div> ";
            string html = "<span class='col-12 mx-auto text-center texticonDetail' style='background-color:#0094ff; border-radius: 10px;'>คิวที่รอ</span> ";
            if (dt.Rows.Count > 0)
            {
                string color = "";
                string number = "";
                for (int i=0; i<dt.Rows.Count; i++)
                {
                    color = dt.Rows[i]["qer_triage_color"].ToString();
                    number = dt.Rows[i]["qer_qnumber"].ToString();
                    //html = html + "<div class='col-12 mx-auto my-auto text-center'><span class='MycircleQ mx-auto my-auto text-center textQueue' style='background-color:" + color + ";'>" + number + "</span></div> ";
                    html = html + "<span class='col-12 mx-auto text-center textQueue' style='background-color:" + color + "; border-radius: 10px;'>" + number + "</span> ";
                }
                
                result = true;
            }
            //List_Q.DataSource = dt;
            //List_Q.DataBind();

            lbl_QueueTriage.Text = html;

            return result;
        }

        public Boolean ShowData()
        {
            Boolean bl = false;

            lbl_queue_1.Text = "";
            lbl_iconstatus_1.Text = "";
            lbl_queue_2.Text = "";
            lbl_iconstatus_2.Text = "";
            lbl_queue_3.Text = "";
            lbl_iconstatus_3.Text = "";
            lbl_queue_4.Text = "";
            lbl_iconstatus_4.Text = "";
            lbl_queue_5.Text = "";
            lbl_iconstatus_5.Text = "";
            lbl_queue_6.Text = "";
            lbl_iconstatus_6.Text = "";
            lbl_queue_7.Text = "";
            lbl_iconstatus_7.Text = "";
            lbl_queue_8.Text = "";
            lbl_iconstatus_8.Text = "";
            lbl_queue_9.Text = "";
            lbl_iconstatus_9.Text = "";
            lbl_queue_10.Text = "";
            lbl_iconstatus_10.Text = "";
            lbl_queue_11.Text = "";
            lbl_iconstatus_11.Text = "";
            lbl_queue_12.Text = "";
            lbl_iconstatus_12.Text = "";
            lbl_queue_13.Text = "";
            lbl_iconstatus_13.Text = "";

            string imgIcom = "";

            sql = "select * from qer_register as qr left join qer_triage as qt on qt.qer_triage_id=qr.qer_triage " +
                "where qer_status = 'process' order by qer_bed ";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                bl = true;

                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    string Queue = dt.Rows[i]["qer_qnumber"].ToString();
                    string iconid = dt.Rows[i]["qer_process"].ToString();
                    string[] ArIcon = iconid.Split(',');
                    string Bed = dt.Rows[i]["qer_bed"].ToString();
                    string color = dt.Rows[i]["qer_triage_color"].ToString();
                    string triageLevel = dt.Rows[i]["qer_triage"].ToString();

                    string style = "font-size:x-large; " +
                        "box-shadow: rgb(128, 128, 128) 2px 2px; " +
                        "background-color:" + color + ";";
                    string styleRed = "background-image: url(img/Alarm.gif); background-repeat: no-repeat; background-size: cover;";

                    imgIcom = "";

                    if (Bed == "1")
                    {
                        lbl_bed1.Attributes.Add("style", style);
                        lbl_queue_1.Text = Queue;

                        if (iconid != "")
                        {
                            for (int j = 0; j < ArIcon.Length; j++)
                            {
                                imgIcom = imgIcom + "<img src='img/" + ArIcon[j] + ".png' class='iconSize' > ";
                            }
                        }
                        lbl_iconstatus_1.Text = imgIcom;

                        div_bed_1.Attributes.Remove("style");
                        if (triageLevel == "1")
                        {
                            div_bed_1.Attributes.Add("style", styleRed);
                        }
                    }
                    if (Bed == "2")
                    {
                        lbl_bed2.Attributes.Add("style", style);
                        lbl_queue_2.Text = Queue;
                        
                        if (iconid != "")
                        {
                            for (int j = 0; j < ArIcon.Length; j++)
                            {
                                imgIcom = imgIcom + "<img src='img/" + ArIcon[j] + ".png' class='iconSize' > ";
                            }
                        }
                        lbl_iconstatus_2.Text = imgIcom;

                        div_bed_2.Attributes.Remove("style");
                        if (triageLevel == "1")
                        {
                            div_bed_2.Attributes.Add("style", styleRed);
                        }
                    }
                    if (Bed == "3")
                    {
                        lbl_bed3.Attributes.Add("style", style);
                        lbl_queue_3.Text = Queue;

                        if (iconid != "")
                        {
                            for (int j = 0; j < ArIcon.Length; j++)
                            {
                                imgIcom = imgIcom + "<img src='img/" + ArIcon[j] + ".png' class='iconSize' > ";
                            }
                        }
                        lbl_iconstatus_3.Text = imgIcom;

                        div_bed_3.Attributes.Remove("style");
                        if (triageLevel == "1")
                        {
                            div_bed_3.Attributes.Add("style", styleRed);
                        }
                    }
                    if (Bed == "4")
                    {
                        lbl_bed4.Attributes.Add("style", style);
                        lbl_queue_4.Text = Queue;

                        if (iconid != "")
                        {
                            for (int j = 0; j < ArIcon.Length; j++)
                            {
                                imgIcom = imgIcom + "<img src='img/" + ArIcon[j] + ".png' class='iconSize' > ";
                            }
                        }
                        lbl_iconstatus_4.Text = imgIcom;

                        div_bed_4.Attributes.Remove("style");
                        if (triageLevel == "1")
                        {
                            div_bed_4.Attributes.Add("style", styleRed);
                        }
                    }
                    if (Bed == "5")
                    {
                        lbl_bed5.Attributes.Add("style", style);
                        lbl_queue_5.Text = Queue;

                        if (iconid != "")
                        {
                            for (int j = 0; j < ArIcon.Length; j++)
                            {
                                imgIcom = imgIcom + "<img src='img/" + ArIcon[j] + ".png' class='iconSize' > ";
                            }
                        }
                        lbl_iconstatus_5.Text = imgIcom;

                        div_bed_5.Attributes.Remove("style");
                        if (triageLevel == "1")
                        {
                            div_bed_5.Attributes.Add("style", styleRed);
                        }
                    }
                    if (Bed == "6")
                    {
                        lbl_bed6.Attributes.Add("style", style);
                        lbl_queue_6.Text = Queue;

                        if (iconid != "")
                        {
                            for (int j = 0; j < ArIcon.Length; j++)
                            {
                                imgIcom = imgIcom + "<img src='img/" + ArIcon[j] + ".png' class='iconSize' > ";
                            }
                        }
                        lbl_iconstatus_6.Text = imgIcom;

                        div_bed_6.Attributes.Remove("style");
                        if (triageLevel == "1")
                        {
                            div_bed_6.Attributes.Add("style", styleRed);
                        }
                    }
                    if (Bed == "7")
                    {
                        lbl_bed7.Attributes.Add("style", style);
                        lbl_queue_7.Text = Queue;

                        if (iconid != "")
                        {
                            for (int j = 0; j < ArIcon.Length; j++)
                            {
                                imgIcom = imgIcom + "<img src='img/" + ArIcon[j] + ".png' class='iconSize' > ";
                            }
                        }
                        lbl_iconstatus_7.Text = imgIcom;

                        div_bed_7.Attributes.Remove("style");
                        if (triageLevel == "1")
                        {
                            div_bed_7.Attributes.Add("style", styleRed);
                        }
                    }
                    if (Bed == "8")
                    {
                        lbl_bed8.Attributes.Add("style", style);
                        lbl_queue_8.Text = Queue;

                        if (iconid != "")
                        {
                            for (int j = 0; j < ArIcon.Length; j++)
                            {
                                imgIcom = imgIcom + "<img src='img/" + ArIcon[j] + ".png' class='iconSize' > ";
                            }
                        }
                        lbl_iconstatus_8.Text = imgIcom;

                        div_bed_8.Attributes.Remove("style");
                        if (triageLevel == "1")
                        {
                            div_bed_8.Attributes.Add("style", styleRed);
                        }
                    }
                    if (Bed == "9")
                    {
                        lbl_bed9.Attributes.Add("style", style);
                        lbl_queue_9.Text = Queue;

                        if (iconid != "")
                        {
                            for (int j = 0; j < ArIcon.Length; j++)
                            {
                                imgIcom = imgIcom + "<img src='img/" + ArIcon[j] + ".png' class='iconSize' > ";
                            }
                        }
                        lbl_iconstatus_9.Text = imgIcom;

                        div_bed_9.Attributes.Remove("style");
                        if (triageLevel == "1")
                        {
                            div_bed_9.Attributes.Add("style", styleRed);
                        }
                    }
                    if (Bed == "10")
                    {
                        lbl_bed10.Attributes.Add("style", style);
                        lbl_queue_10.Text = Queue;

                        if (iconid != "")
                        {
                            for (int j = 0; j < ArIcon.Length; j++)
                            {
                                imgIcom = imgIcom + "<img src='img/" + ArIcon[j] + ".png' class='iconSize' > ";
                            }
                        }
                        lbl_iconstatus_10.Text = imgIcom;

                        div_bed_10.Attributes.Remove("style");
                        if (triageLevel == "1")
                        {
                            div_bed_10.Attributes.Add("style", styleRed);
                        }
                    }
                    if (Bed == "11")
                    {
                        lbl_bed11.Attributes.Add("style", style);
                        lbl_queue_11.Text = Queue;

                        if (iconid != "")
                        {
                            for (int j = 0; j < ArIcon.Length; j++)
                            {
                                imgIcom = imgIcom + "<img src='img/" + ArIcon[j] + ".png' class='iconSize' > ";
                            }
                        }
                        lbl_iconstatus_11.Text = imgIcom;

                        div_bed_11.Attributes.Remove("style");
                        if (triageLevel == "1")
                        {
                            div_bed_11.Attributes.Add("style", styleRed);
                        }
                    }
                    if (Bed == "12")
                    {
                        lbl_bed12.Attributes.Add("style", style);
                        lbl_queue_12.Text = Queue;

                        if (iconid != "")
                        {
                            for (int j = 0; j < ArIcon.Length; j++)
                            {
                                imgIcom = imgIcom + "<img src='img/" + ArIcon[j] + ".png' class='iconSize' > ";
                            }
                        }
                        lbl_iconstatus_12.Text = imgIcom;

                        div_bed_12.Attributes.Remove("style");
                        if (triageLevel == "1")
                        {
                            div_bed_12.Attributes.Add("style", styleRed);
                        }
                    }
                    if (Bed == "13")
                    {
                        lbl_bed13.Attributes.Add("style", style);
                        lbl_queue_13.Text = Queue;

                        if (iconid != "")
                        {
                            for (int j = 0; j < ArIcon.Length; j++)
                            {
                                imgIcom = imgIcom + "<img src='img/" + ArIcon[j] + ".png' class='iconSize' > ";
                            }
                        }
                        lbl_iconstatus_13.Text = imgIcom;

                        div_bed_13.Attributes.Remove("style");
                        if (triageLevel == "1")
                        {
                            div_bed_13.Attributes.Add("style", styleRed);
                        }
                    }

                    //string s_Queue = "lbl_queue_" + Bed;
                    //Label lbl_Queue = new Label();
                    //lbl_Queue.FindControl(s_Queue);
                    //lbl_Queue.Text = Queue;

                    //string s_Icon = "lbl_iconstatus_" + Bed;
                    //Label lbl_Icon = new Label();
                    //lbl_Icon.FindControl(s_Icon);
                    //lbl_Icon.Text = "<img src='img/" + iconid + ".png' class='iconSize' >";
                }
            }

            return bl;
        }

        protected void Timer1_Tick(object sender, EventArgs e)
        {
            ListViewQ();
            ShowData();
            CounterQueue();


        }
        
        public string CounterQueue()
        {
            string result = "";

            string text = "";
            string qwait = CntQ_wait();
            string qprocess = CntQ_process();
            text = "คิวที่รอ: " + qwait + " คิว<br />คิวที่รักษา: " + qprocess + " คิว";

            lbl_cnt_wait.Text = text;

            return result;
        }

        public string CntQ_wait()
        {
            string result = "";

            sql = "select count(qer_status) as Cnt_status from qer_register where qer_status = 'wait';";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                result = dt.Rows[0]["Cnt_status"].ToString();
            }

            return result;
        }

        public string CntQ_process()
        {
            string result = "";

            sql = "select count(qer_status) as Cnt_status from qer_register where qer_status = 'process';";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                result = dt.Rows[0]["Cnt_status"].ToString();
            }

            return result;
        }

        protected void TypeIcon()
        {
            
            sql = "select * from qer_list;";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
               
                string html = "";
                for (int i=0; i<dt.Rows.Count; i++)
                {
                    string id = dt.Rows[i]["qer_list_id"].ToString();
                    string text = dt.Rows[i]["qer_listname"].ToString();
                    string name = "img/" + id + ".png";
                    html = html + "<div class=\"col-12 mx-auto texticonDetail\"><img src=\"" + name + "\" class=\"iconDetailSize\" style=\"background-color:white; border-radius: 20%;\"/> = " + text +"</div>";
                }
                lbl_typeIcon.Text = html;
            }
            sql = "select * from qer_triage;";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {                
                string div = "";
                for(int i=0; i<dt.Rows.Count; i++)
                {
                    string id = dt.Rows[i]["qer_triage_id"].ToString();
                    string text = dt.Rows[i]["qer_triage_detail"].ToString();
                    string color = dt.Rows[i]["qer_triage_color"].ToString();

                    string col = "col-12";
                    if (i == (dt.Rows.Count - 1)) { col = "col-12"; }

                    div = div + "<div class=\""+ col + " text-right my-1 texticonDetail\"><span class=\"col-12 mx-auto text-right\" style=\"background-color:" + color + "; border-radius: 20px;\">&nbsp;&nbsp;&nbsp;" + text + "</span></div>";
                }
                lbl_typeColor.Text = div;
            }
               
        }

    }
}