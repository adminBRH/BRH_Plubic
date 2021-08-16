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
    public partial class Default : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass CL_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {           
            if (Session["Login"] != null)
            {
                string status = Session["status"].ToString();
                if (status == "admin" || status == "er")
                {
                    if (!IsPostBack)
                    {
                        IconStatus();
                        ShowData();
                        ListViewQ();
                        color();
                    }
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

        protected void add_bed_ServerClick(object sender, EventArgs e)
        {
            string Queue = ip_q.Value.ToString().Trim();           
            if (UpdateQ(Queue))
            {
                
                Response.Write("<script>alert('Success !!'); window.location.href='Default.aspx';</script>");
            }
            else
            {
                Response.Write("<script>alert('Error !!');</script>");
            }
        }

        public string CheckQueue(string Queue)
        {
            string result = "";

            sql = "select * from qer_register where qer_qnumber='"+ Queue + "' and qer_status in ('wait','process'); ";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                string qerID = dt.Rows[0]["qer_id"].ToString();
                string qerStatus = dt.Rows[0]["qer_status"].ToString();
                
                result = qerID + "$" + qerStatus;
            }

            return result;
        }

        public string NullQueue(string Bed)
        {
            string result = "";

            sql = "select * from qer_register where qer_status='process' and qer_bed = '" + Bed + "' ";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                result = dt.Rows[0]["qer_id"].ToString();
            }

            return result;
        }

        public Boolean CheckBed(string Bed)
        {
            Boolean bl = true;

            sql = "select * from qer_register where qer_bed = '" + Bed + "' and qer_status='process' ";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                bl = false;
            }

            return bl;
        }

        public Boolean UpdateQ(string Queue)
        {
            Boolean result = false;
            
            string Qnumber = ip_q.Value.ToString().Trim();
            string ip_status = txtH_StatusID.Value.ToString().Trim();
            string Bed = txtH_BedID.Value.ToString();

            string[] resultQ  = CheckQueue(Queue).Split('$');

            string qid = "";
            string qstatus = "";
            string triagelv = dd_color.SelectedValue.ToString().Trim();

            if (resultQ.Length > 1)
            {
                qid = resultQ[0].ToString();
                qstatus = resultQ[1].ToString();
            }
            else
            {
                qid = NullQueue(Bed);
            }

            
            if (CheckBed(Bed))
            {
                if (qstatus == "wait")
                {
                    sql = "update qer_register set qer_qnumber = '" + Qnumber + "', qer_bed='" + Bed + "', qer_status='process' where qer_id = '" + qid + "'; ";
                }
            }
            else
            {
                sql = "";
            }

            if (ip_status != "")
            {
                sql = sql + "update qer_register set qer_process = '" + ip_status + "' where qer_id = '" + qid + "'; ";
            }

            if (triagelv != "")
            {
                sql = sql + "update qer_register set qer_triage = '" + triagelv + "' where qer_id = '" + qid + "'; ";
            }

            if (CL_Sql.Modify(sql))
            {
                result = true;
            }
            return result;
        }

        public Boolean ListViewQ()
        {
            Boolean result = false;

            sql = "SELECT * FROM qer_register as qr LEFT JOIN qer_triage as q on q.qer_triage_lv = qr.qer_triage where qer_status = 'wait' ORDER BY qer_triage_lv,qer_id;";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                List_Q.DataSource = dt;
                List_Q.DataBind();
                            
            }

            return result;
        }

        public Boolean ShowData()
        {
            Boolean bl = false;

            sql = "select * from qer_register as qr left join qer_triage as qt on qt.qer_triage_id=qr.qer_triage " +
                "where qer_status = 'process' order by qer_bed ";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                bl = true;

                string bed1 = "";
                string bed2 = "";
                string bed3 = "";
                string bed4 = "";
                string bed5 = "";
                string bed6 = "";
                string bed7 = "";
                string bed8 = "";
                string bed9 = "";
                string bed10 = "";
                string bed11 = "";
                string bed12 = "";
                string bed13 = "";

                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    string Queue = dt.Rows[i]["qer_qnumber"].ToString();
                    string iconid = dt.Rows[i]["qer_process"].ToString();
                    string[] ArIcon = iconid.Split(',');
                    string Bed = dt.Rows[i]["qer_bed"].ToString();
                    string color = dt.Rows[i]["qer_triage_color"].ToString();
                    string moveQ = "";

                    if (Session["MoveQID"] != null)
                    {
                        moveQ = "yes";
                    }
                    
                    if (Bed == "1")
                    {
                        bed1 = "yes";
                        lbl_bed1.Attributes.Add("style", "font-size:x-large; background-color:" + color + ";");
                        lbl_queue_1.Text = Queue;
                        string imgIcom = "";
                        for (int j=0; j<ArIcon.Length; j++)
                        {
                            imgIcom = imgIcom + "<img src='img/" + ArIcon[j] + ".png' class='iconSize' > ";
                        }
                        lbl_iconstatus_1.Text = imgIcom;
                        status_success1.Attributes.Remove("data-target");
                        status_success1.Attributes.Add("data-target", "#modalConfirm");
                    }
                    else
                    {
                        if (moveQ != "yes" && bed1 == "")
                        {
                            status_success1.Attributes.Remove("data-target");
                        }
                        
                    }
                    if (Bed == "2")
                    {
                        bed2 = "yes";
                        lbl_bed2.Attributes.Add("style", "font-size:x-large; background-color:" + color + ";");
                        lbl_queue_2.Text = Queue;
                        string imgIcom = "";
                        for (int j = 0; j < ArIcon.Length; j++)
                        {
                            imgIcom = imgIcom + "<img src='img/" + ArIcon[j] + ".png' class='iconSize' > ";
                        }
                        lbl_iconstatus_2.Text = imgIcom;
                        status_success2.Attributes.Remove("data-target");
                        status_success2.Attributes.Add("data-target", "#modalConfirm");
                    }
                    else
                    {
                        if (moveQ != "yes" && bed2 == "")
                        {
                            status_success2.Attributes.Remove("data-target");
                        }

                    }
                    if (Bed == "3")
                    {
                        bed3 = "yes";
                        lbl_bed3.Attributes.Add("style", "font-size:x-large; background-color:" + color + ";");
                        lbl_queue_3.Text = Queue;
                        string imgIcom = "";
                        for (int j = 0; j < ArIcon.Length; j++)
                        {
                            imgIcom = imgIcom + "<img src='img/" + ArIcon[j] + ".png' class='iconSize' > ";
                        }
                        lbl_iconstatus_3.Text = imgIcom;
                        status_success3.Attributes.Remove("data-target");
                        status_success3.Attributes.Add("data-target", "#modalConfirm");
                    }
                    else
                    {
                        if (moveQ != "yes" && bed3 == "")
                        {
                            status_success3.Attributes.Remove("data-target");
                        }

                    }
                    if (Bed == "4")
                    {
                        bed4 = "yes";
                        lbl_bed4.Attributes.Add("style", "font-size:x-large; background-color:" + color + ";");
                        lbl_queue_4.Text = Queue;
                        string imgIcom = "";
                        for (int j = 0; j < ArIcon.Length; j++)
                        {
                            imgIcom = imgIcom + "<img src='img/" + ArIcon[j] + ".png' class='iconSize' > ";
                        }
                        lbl_iconstatus_4.Text = imgIcom;
                        status_success4.Attributes.Remove("data-target");
                        status_success4.Attributes.Add("data-target", "#modalConfirm");
                    }
                    else
                    {
                        if (moveQ != "yes" && bed4 == "")
                        {
                            status_success4.Attributes.Remove("data-target");
                        }

                    }
                    if (Bed == "5")
                    {
                        bed5 = "yes";
                        lbl_bed5.Attributes.Add("style", "font-size:x-large; background-color:" + color + ";");
                        lbl_queue_5.Text = Queue;
                        string imgIcom = "";
                        for (int j = 0; j < ArIcon.Length; j++)
                        {
                            imgIcom = imgIcom + "<img src='img/" + ArIcon[j] + ".png' class='iconSize' > ";
                        }
                        lbl_iconstatus_5.Text = imgIcom;
                        status_success5.Attributes.Remove("data-target");
                        status_success5.Attributes.Add("data-target", "#modalConfirm");
                    }
                    else
                    {
                        if (moveQ != "yes" && bed5 == "")
                        {
                            status_success5.Attributes.Remove("data-target");
                        }

                    }
                    if (Bed == "6")
                    {
                        bed6 = "yes";
                        lbl_bed6.Attributes.Add("style", "font-size:x-large; background-color:" + color + ";");
                        lbl_queue_6.Text = Queue;
                        string imgIcom = "";
                        for (int j = 0; j < ArIcon.Length; j++)
                        {
                            imgIcom = imgIcom + "<img src='img/" + ArIcon[j] + ".png' class='iconSize' > ";
                        }
                        lbl_iconstatus_6.Text = imgIcom;
                        status_success6.Attributes.Remove("data-target");
                        status_success6.Attributes.Add("data-target", "#modalConfirm");
                    }
                    else
                    {
                        if (moveQ != "yes" && bed6 == "")
                        {
                            status_success6.Attributes.Remove("data-target");
                        }

                    }
                    if (Bed == "7")
                    {
                        bed7 = "yes";
                        lbl_bed7.Attributes.Add("style", "font-size:x-large; background-color:" + color + ";");
                        lbl_queue_7.Text = Queue;
                        string imgIcom = "";
                        for (int j = 0; j < ArIcon.Length; j++)
                        {
                            imgIcom = imgIcom + "<img src='img/" + ArIcon[j] + ".png' class='iconSize' > ";
                        }
                        lbl_iconstatus_7.Text = imgIcom;
                        status_success7.Attributes.Remove("data-target");
                        status_success7.Attributes.Add("data-target", "#modalConfirm");
                    }
                    else
                    {
                        if (moveQ != "yes" && bed7 == "")
                        {
                            status_success7.Attributes.Remove("data-target");
                        }

                    }
                    if (Bed == "8")
                    {
                        bed8 = "yes";
                        lbl_bed8.Attributes.Add("style", "font-size:x-large; background-color:" + color + ";");
                        lbl_queue_8.Text = Queue;
                        string imgIcom = "";
                        for (int j = 0; j < ArIcon.Length; j++)
                        {
                            imgIcom = imgIcom + "<img src='img/" + ArIcon[j] + ".png' class='iconSize' > ";
                        }
                        lbl_iconstatus_8.Text = imgIcom;
                        status_success8.Attributes.Remove("data-target");
                        status_success8.Attributes.Add("data-target", "#modalConfirm");
                    }
                    else
                    {
                        if (moveQ != "yes" && bed8 == "")
                        {
                            status_success8.Attributes.Remove("data-target");
                        }

                    }
                    if (Bed == "9")
                    {
                        bed9 = "yes";
                        lbl_bed9.Attributes.Add("style", "font-size:x-large; background-color:" + color + ";");
                        lbl_queue_9.Text = Queue;
                        string imgIcom = "";
                        for (int j = 0; j < ArIcon.Length; j++)
                        {
                            imgIcom = imgIcom + "<img src='img/" + ArIcon[j] + ".png' class='iconSize' > ";
                        }
                        lbl_iconstatus_9.Text = imgIcom;
                        status_success9.Attributes.Remove("data-target");
                        status_success9.Attributes.Add("data-target", "#modalConfirm");
                    }
                    else
                    {
                        if (moveQ != "yes" && bed9 == "")
                        {
                            status_success9.Attributes.Remove("data-target");
                        }

                    }
                    if (Bed == "10")
                    {
                        bed10 = "yes";
                        lbl_bed10.Attributes.Add("style", "font-size:x-large; background-color:" + color + ";");
                        lbl_queue_10.Text = Queue;
                        string imgIcom = "";
                        for (int j = 0; j < ArIcon.Length; j++)
                        {
                            imgIcom = imgIcom + "<img src='img/" + ArIcon[j] + ".png' class='iconSize' > ";
                        }
                        lbl_iconstatus_10.Text = imgIcom;
                        status_success10.Attributes.Remove("data-target");
                        status_success10.Attributes.Add("data-target", "#modalConfirm");
                    }
                    else
                    {
                        if (moveQ != "yes" && bed10 == "")
                        {
                            status_success10.Attributes.Remove("data-target");
                        }

                    }
                    if (Bed == "11")
                    {
                        bed11 = "yes";
                        lbl_bed_11.Attributes.Add("style", "font-size:x-large; background-color:" + color + ";");
                        lbl_queue_11.Text = Queue;
                        string imgIcom = "";
                        for (int j = 0; j < ArIcon.Length; j++)
                        {
                            imgIcom = imgIcom + "<img src='img/" + ArIcon[j] + ".png' class='iconSize' > ";
                        }
                        lbl_iconstatus_11.Text = imgIcom;
                        status_success11.Attributes.Remove("data-target");
                        status_success11.Attributes.Add("data-target", "#modalConfirm");
                    }
                    else
                    {
                        if (moveQ != "yes" && bed11 == "")
                        {
                            status_success11.Attributes.Remove("data-target");
                        }

                    }
                    if (Bed == "12")
                    {
                        bed12 = "yes";
                        lbl_bed_12.Attributes.Add("style", "font-size:x-large; background-color:" + color + ";");
                        lbl_queue_12.Text = Queue;
                        string imgIcom = "";
                        for (int j = 0; j < ArIcon.Length; j++)
                        {
                            imgIcom = imgIcom + "<img src='img/" + ArIcon[j] + ".png' class='iconSize' > ";
                        }
                        lbl_iconstatus_12.Text = imgIcom;
                        status_success12.Attributes.Remove("data-target");
                        status_success12.Attributes.Add("data-target", "#modalConfirm");
                    }
                    else
                    {
                        if (moveQ != "yes" && bed12 == "")
                        {
                            status_success12.Attributes.Remove("data-target");
                        }

                    }
                    if (Bed == "13")
                    {
                        bed13 = "yes";
                        lbl_bed_13.Attributes.Add("style", "font-size:x-large; background-color:" + color + ";");
                        lbl_queue_13.Text = Queue;
                        string imgIcom = "";
                        for (int j = 0; j < ArIcon.Length; j++)
                        {
                            imgIcom = imgIcom + "<img src='img/" + ArIcon[j] + ".png' class='iconSize' > ";
                        }
                        lbl_iconstatus_13.Text = imgIcom;
                        status_success13.Attributes.Remove("data-target");
                        status_success13.Attributes.Add("data-target", "#modalConfirm");
                    }
                    else
                    {
                        if (moveQ != "yes" && bed13 == "")
                        {
                            status_success13.Attributes.Remove("data-target");
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

        protected void IconStatus()
        {
            sql = "select * from qer_list where qer_status = 'yes' order by qer_list_id ";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                LV_btnStatus.DataSource = dt;
                LV_btnStatus.DataBind();
            }
        }

        public Boolean Update_Success(string Queue)
        {
            Boolean result = false;

            string Bed = txtH_BedID.Value.ToString();
            string txth_status = txtH_Status_success.Value.ToString().Trim();


            string[] resultQ = CheckQueue(Queue).Split('$');

            string qid = "";
            string qstatus = "";
            if (resultQ.Length > 1)
            {
                qid = resultQ[0].ToString();
                qstatus = resultQ[1].ToString();
            }
            else
            {
                qid = NullQueue(Bed);
            }


            if (CheckBed(Bed))
            {
                if (qstatus == "process")
                {
                    sql = "update qer_register set qer_process = 'success where qer_id = '" + qid + "';";
                }
                else if (qstatus == "wait")
                {
                    Response.Write("<script>alert('ไม่สามารถ Complete Q ที่ยังไม่ได้รับการรักษาได้ !!'); window.location.href='Default.aspx';</script>");
                }
            }
            else
            {
                sql = "";
            }

            if (CL_Sql.Modify(sql))
            {
                result = true;
            }

           
            return result;
        }

        protected void status_success_ServerClick(object sender, EventArgs e)
        {
            string Bed = txtH_BedID.Value.ToString();

            sql = "update qer_register set qer_status='finish' where qer_status='process' and qer_bed='" + Bed + "' ";
            if (CL_Sql.Modify(sql))
            {
                //Response.Redirect("Default.aspx");
                Response.Write("<script>alert('Success ^_^'); window.location.href='Default.aspx';</script>");
               
            }
            else
            {
                Response.Write("<script>alert('ไม่สามารถนำคิวออกได้ กรุณาติดต่อผู้ดูแลระบบ !!');</script>");
            }
        }

        public DataTable color()
        {
            DataTable result = new DataTable();

            sql = "Select * from( " +
                "select qer_triage_id,qer_triage_name,qer_triage_color FROM qer_triage " +
                "union " +
                "select '','เลือก Triage','blue') as a " +
                "order by a.qer_triage_id";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                dd_color.DataSource = dt;
                dd_color.DataTextField = "qer_triage_name";
                dd_color.DataValueField = "qer_triage_color";
                dd_color.DataValueField = "qer_triage_id";
                dd_color.DataBind();

                result = dt;
            }

            return result;
        }

        protected void btn_move_ServerClick(object sender, EventArgs e)
        {
            
            string bedid = txtH_BedID.Value.ToString().Trim();
            sql = "select * from qer_register where qer_bed = '" + bedid + "' and qer_status = 'process' ";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                string qid = dt.Rows[0]["qer_id"].ToString();
                Session["MoveQID"] = qid;
            }
        }

        protected void btn_submit_move_ServerClick(object sender, EventArgs e)
        {
            string bedid = txtH_BedID.Value.ToString().Trim();
            if (Session["MoveQID"] == null)
            {
                
            }
            else
            {
                sql = "update qer_register set qer_bed = '" + bedid + "' where qer_id = '" + Session["MoveQID"].ToString() + "'; ";
                if (CL_Sql.Modify(sql))
                {
                    Session.Remove("MoveQID");
                    Response.Redirect("Default.aspx");
                }
            }          
        }

        protected void TimerQ_Tick(object sender, EventArgs e)
        {
            ListViewQ();
        }
    }
}