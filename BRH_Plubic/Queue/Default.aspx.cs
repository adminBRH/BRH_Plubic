using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;

namespace BRH_Plubic.Queue
{
    public partial class Default : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["dept"] == null)
            {
                Response.Redirect("../Default?url=wrong");
            }
            else
            {
                string IP = GetUserIP();
                lbl_IP.Text = IP;

                string queue = CheckQueue(IP);
                if (queue == "")
                {
                    div_input.Visible = true;
                    div_queue.Visible = false;
                }
                else
                {
                    div_input.Visible = false;
                    div_queue.Visible = true;
                    lbl_queue.Text = queue;
                }
            }
            
        }

        public string CheckQueue(string IP)
        {
            string result = "";

            sql = "select * from mytable where datetimes >= (current_timestamp - interval 1 day) " +
                "and active='yes' and IP = '" + IP + "' " +
                "order by id desc ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                string status = dt.Rows[0]["status"].ToString();
                if (status == "wait")
                {
                    result = dt.Rows[0]["queue"].ToString();
                }
                else if (status == "seedoctor")
                {
                    string dept = Request.QueryString["dept"].ToString();
                    Response.Redirect("../GoodDoctor/Default?location=" + dept);
                }
                else { }
            }

            return result;
        }

        private string GetUserIP()
        {
            //Gets a comma-delimited list of IP Addresses
            string ipList = Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

            //If any are available - use the first one
            if (!string.IsNullOrEmpty(ipList))
            {
                return ipList.Split(',')[0];
            }

            //Otherwise return the Remote Address
            return Request.ServerVariables["REMOTE_ADDR"];
        }

        protected void btn_submit_ServerClick(object sender, EventArgs e)
        {
            string scModal = "";

            string Key = cl_Sql.GenerateKey(11);

            string IP = GetUserIP();
            string dept = Request.QueryString["dept"].ToString();
            string fname = txt_fname.Value.ToString().Trim();
            string lname = txt_lname.Value.ToString().Trim();
            string age = txt_age.Value.ToString().Trim();
            string gender = "";
            if (rd_male.Checked)
            {
                gender = "ชาย";
            }
            if (rd_female.Checked)
            {
                gender = "หญิง";
            }

            sql = "select * from mytable where datetimes >= (current_timestamp - interval 1 day) and status='wait' and active='yes' and IP = '" + IP + "' ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                lbl_Modal_cancelQueue.Text = "กรุณายกเลิกคิวเดิมก่อน หากต้องการรับคิวใหม่ !!";
                scModal = "$('#Modal_cancelQueue').modal('show');";
            }
            else
            {
                int Queue = 0;
                sql = "select ifnull(max(queue),0)+1 as 'nextQ' from mytable where convert(datetimes,date)=current_date and dept='" + dept + "' ";
                dt = new DataTable(sql);
                dt = cl_Sql.select(sql);
                if (dt.Rows.Count > 0)
                {
                    Queue = int.Parse(dt.Rows[0]["nextQ"].ToString());
                }

                sql = "insert into mytable(IP,dept,fname,lname,age,gender,keycheck,queue) " +
                    "\nvalues('" + IP + "','" + dept + "','" + fname + "','" + lname + "','" + age + "','" + gender + "','" + Key + "'," + Queue + "); ";
                if (cl_Sql.Modify(sql))
                {
                    div_input.Visible = false;
                    div_queue.Visible = true;
                    lbl_queue.Text = Queue.ToString();
                    //scModal = "fn_AlertModal('Success','Success !!','',0); windowPopup('/Queue/Generate.aspx?dept=" + dept + "','Generate Queue', 10, 10);";
                    scModal = "fn_AlertModal('Success','Success !!','Default?dept=" + dept + "',2000);";
                }
                else
                {
                    div_input.Visible = true;
                    div_queue.Visible = false;
                    scModal = "fn_AlertModal('Warning','ไม่สามารถกดรับคิวได้ กรุณาติดต่อเจ้าหน้าที่ !!','',0);";
                }
            }

            Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
        }

        protected void btn_cancel_ServerClick(object sender, EventArgs e)
        {
            string scModal = "";

            string dept = Request.QueryString["dept"].ToString();
            string IP = GetUserIP();

            sql = "update mytable set active='no', status='cancel' where active='yes' and status='wait' and IP = '" + IP + "' ";
            if (cl_Sql.Modify(sql))
            {
                //scModal = "fn_AlertModal('Success','ยกเลิกคิวเรียบร้อยแล้ว !!','Default?dept=" + dept + "',2000); windowPopup('/Queue/Generate.aspx?dept=" + dept + "','Generate Queue', 10, 10);";
                scModal = "fn_AlertModal('Success','ยกเลิกคิวเรียบร้อยแล้ว !!','Default?dept=" + dept + "',2000);";
            }
            else
            {
                scModal = "fn_AlertModal('Warning','ไม่สามารถยกเลิกคิวได้ กรุณาติดต่อเจ้าหน้าที่ !!','',0);";
            }

            Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
        }

        protected void btn_doctorRating_ServerClick(object sender, EventArgs e)
        {
            string dept = Request.QueryString["dept"].ToString();

            string IP = GetUserIP();
            string queue = CheckQueue(IP);

            sql = "select * from doctor_rating where drr_active='no' and drr_en='" + queue + "' ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                Response.Redirect("../GoodDoctor/Default?location=" + dept);
            }
            else
            {
                string scModal =  "fn_AlertModal('Info','ยังไม่สามารถประเมินได้ เนื่องจากท่านยังไม่ได้เข้าพบแพทย์','',0);";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
            }
        }
    }
}