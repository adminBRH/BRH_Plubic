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
    public partial class FollowQ : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Cookies["QERCookie"] == null)
            {
                lbl_CallModal.Text = "<script> alertModal('#ModalFollowQ'); </script>";
                div_CheckQ.Visible = true;
                div_Details.Visible = false;
            }
            else
            {
                ShowData();
            }

        }

        protected void ShowData()
        {
            div_CheckQ.Visible = false;
            div_Details.Visible = true;

            Details(Request.Cookies["QERCookie"]["QID"]);
        }

        protected void btn_submit_ServerClick(object sender, EventArgs e)
        {
            string Q = txt_Queue.Value.ToString().Trim();
            if (CheckQueue(Q))
            {
                Response.Redirect(Request.RawUrl + "?Queue=" + Q);
            }
            else
            {
                lbl_CallModal.Text = "<script> alertModalInfo('#Modal_Info','ไม่พบหมายเลขคิวในระบบ !!'); </script>";
            }
        }

        private Boolean CheckQueue(string Q)
        {
            Boolean bl = false;

            sql = "select * from qer_register where qer_qnumber= '" + Q + "' and qer_status in ('wait','process'); ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                string qer_id = dt.Rows[0]["qer_id"].ToString();
                string qer_qnumber = dt.Rows[0]["qer_qnumber"].ToString();

                HttpCookie Cook = new HttpCookie("QERCookie");
                Cook["QID"] = qer_id;
                Cook["QNUMBER"] = qer_qnumber;

                Cook.Expires = DateTime.Now.AddHours(12);
                Response.Cookies.Add(Cook);

                bl = true;
            }

            return bl;
        }

        protected void Details(string ID)
        {
            sql = "select * from qer_register as qr " +
                "left join qer_triage as qt on qt.qer_triage_id=qr.qer_triage " +
                "where qer_id = '" + ID + "' ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                string Queue = dt.Rows[0]["qer_qnumber"].ToString();
                string Bed = dt.Rows[0]["qer_bed"].ToString();
                string status = dt.Rows[0]["qer_status"].ToString();
                string triage = dt.Rows[0]["qer_triage_detail"].ToString();
                string triageColor = dt.Rows[0]["qer_triage_color"].ToString();

                lbl_Queue.Text = "คิว " + Queue;

                if (Bed == "12") 
                { 
                    Bed = "อยู่ในห้อง หัตถการ"; 
                }
                else if (Bed == "13") 
                { 
                    Bed = "อยู่ในห้อง ฟื้นคืนชีพ"; 
                }
                else
                {
                    Bed = "อยู่ที่เตียง : " + Bed;
                }
                lbl_bed.Text = Bed;

                string process = dt.Rows[0]["qer_process"].ToString();
                if (status == "finish")
                {
                    lbl_process.Text = "<img src='img/Happy.png' style='width: 120px;' >";
                    lbl_triage.Text = "การรักษาเสร็จสิ้นแล้ว";
                    lbl_bed.Text = "";
                    //ClearCookie();
                }
                else
                {
                    lbl_triage.Text = triage;

                    if (process != "")
                    {
                        ProcessList(process);
                    }
                }
            }
        }

        protected void ProcessList(string process)
        {
            sql = "select * from qer_list where qer_list_id in (" + process + "); ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            string pd = "";
            if (dt.Rows.Count > 0)
            {
                foreach (DataRow dr in dt.Rows)
                {
                    if (pd != "") { pd = pd + "&nbsp;&nbsp;&nbsp;"; }
                    pd = pd + dr["qer_listname"] + "<img src='img/" + dr["qer_list_id"] + ".png' class='iconSize' >";
                }
            }
            lbl_process.Text = pd;
        }

        protected void btn_CearQueue_Click(object sender, EventArgs e)
        {
            if (ClearCookie())
            {
                lbl_CallModal.Text = "<script> alertModal('#Modal_Success'); setTimeout(function(){window.location.href='../Marketing/Default.aspx';},3000);</script>";
            }
        }

        protected Boolean ClearCookie()
        {
            Boolean bl = true;

            HttpCookie delCook = new HttpCookie("QERCookie");
            delCook.Expires = DateTime.Now.AddDays(-1D);
            Response.Cookies.Add(delCook);

            return bl;
        }

        protected void Timer1_Tick(object sender, EventArgs e)
        {
            ShowData();
        }
    }
}