using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;
using System.IO;
using System.Drawing;

using BRH_Plubic.Function;

namespace BRH_Plubic
{
    public partial class CheckinMeeting : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        Customize ctm = new Customize();

        string room = "";
        string slot = "";
        string topic = "";
        string DateNow = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
        string day = DateTime.Now.DayOfWeek.ToString();
        string time = DateTime.Now.ToString("HH:mm");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["room"] == null || Request.QueryString["slot"] == null)
            {
                Response.Redirect("MeetingRoom.aspx");
            }
            else
            {
                if (!IsPostBack)
                {
                    select_room();
                    Grid1("desc");
                }
            }
        }

        public Boolean select_room()
        {
            Boolean result = false;

            string slot_name = Request.QueryString["slot"].ToString();

            sql = "SELECT * FROM checkinmeetingslot WHERE cms_id = '" + slot_name + "'; ";

            dt = new DataTable();
            dt = cl_Sql.select(sql);

            if (dt.Rows.Count > 0)
            {
                lbl_room.Text = "ห้องประชุม " + dt.Rows[0]["cms_room"].ToString();
                lbl_topic.Text = dt.Rows[0]["cms_sj"].ToString();
                DateTime Startdate = DateTime.Parse(dt.Rows[0]["cms_timestart"].ToString());
                DateTime Enddate = DateTime.Parse(dt.Rows[0]["cms_timeend"].ToString());

                string ShowDate = cl_Sql.DateTH(Startdate.ToString());
                if (Enddate.Date > Startdate.Date)
                {
                    ShowDate = cl_Sql.DateTH(Startdate.ToString()) + " ถึง " + cl_Sql.DateTH(Enddate.ToString());
                }
                string ShowTime = Startdate.ToString("HH:mm") + " - " + Enddate.ToString("HH:mm") + " น.";

                lbl_dateslot.Text = "วันที่ " + ShowDate + " เวลา " + ShowTime;
                result = true;
            }

            return result;
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            CheckEmp();
            txt_empid.Value = "";
            Grid1("desc");
        }

        public Boolean CheckEmp()
        {
            Boolean bl = false;

            string alert = "";
            string txtEmp = "";

            lbl_alert.ForeColor = System.Drawing.Color.Red;

            room = Request.QueryString["room"];
            slot = Request.QueryString["slot"];

            string empid = txt_empid.Value.ToString().Trim();
            sql = "SELECT * FROM (SELECT emp_id FROM employee UNION SELECT drs_id FROM doctors) a " +
                "where a.emp_id = '" + empid + "' ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                string timest_timeend = Request.QueryString["slot"].ToString();
                

                sql = "SELECT * FROM checkinmeetingslot WHERE cms_id = '" + timest_timeend + "'; ";
                dt = new DataTable();
                dt = cl_Sql.select(sql);
                if (dt.Rows.Count > 0) //หาข้อมูลว่ามีบรรทัดนั้นหรือไม่
                {
                    string timest = dt.Rows[0]["cms_timestart"].ToString();
                    string timeend = dt.Rows[0]["cms_timeend"].ToString();

                    string overTime = dt.Rows[0]["cms_overtime"].ToString();

                    string time_now = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");

                    DateTime DateNow = DateTime.Parse(time_now);
                    int DateNow_H = DateNow.Hour;
                    int DateNow_M = DateNow.Minute;
                    int DateNow_HM = (DateNow_H * 60) + DateNow_M;

                    DateTime StartDate = DateTime.Parse(timest);
                    DateTime EndDate = DateTime.Parse(timeend);

                    DateTime DateStart;
                    if (DateNow.Date > StartDate.Date && DateNow.Date <= EndDate.Date)
                    {
                        DateStart = DateTime.Parse(DateNow.ToString("yyyy-MM-dd") + " " + StartDate.ToString("HH:mm:ss"));
                    }
                    else
                    {
                        DateStart = StartDate;
                    }

                    int DateStart_H = DateStart.Hour;
                    int DateStart_M = DateStart.Minute;
                    int DateStart_HM = (DateStart_H * 60) + DateStart_M;
                    int DateStart_HM_adjust = DateStart_HM - 20; // scan ได้ก่อนถึงเวลา 20 นาที

                    DateTime DateEnd = DateTime.Parse(timeend);
                    int DateEnd_H = DateEnd.Hour;
                    int DateEnd_M = DateEnd.Minute;
                    int DateEnd_HM = (DateEnd_H * 60) + DateEnd_M;

                    string next = "no";

                    if (DateStart.Date == DateNow.Date && DateStart_HM_adjust <= DateNow_HM)
                    {
                        if (DateNow_HM <= DateEnd_HM)
                        {
                            next = "yes";
                        }
                        else
                        {
                            if (overTime == "yes")
                            {
                                next = "yes";
                            }
                            else
                            {
                                alert = "เลยเวลาเช็คชื่อแล้ว !!";
                            }
                        }
                    }
                    else
                    {
                        if (DateStart.Date > DateNow.Date)
                        {
                            alert = "ยังไม่ถึงเวลาเช็คชื่อ !!";
                        }
                        else
                        {
                            if (overTime == "yes")
                            {
                                next = "yes";
                            }
                            else
                            {
                                alert = "เลยเวลาเช็คชื่อแล้ว !!";
                            }
                        }
                    }

                    if (next == "yes")
                    {
                        string insertResult = Insert(empid);
                        if (insertResult == "Success")
                        {
                            alert = "Success " + DateTime.Now.ToString();
                            lbl_alert.ForeColor = System.Drawing.Color.Green;
                            bl = true;
                            //Response.Redirect("CheckinMeeting.aspx?slot=" + slot + "&room=" + room);
                        }
                        else if (insertResult == "Duplicate")
                        {
                            alert = "คุณทำการเช็คชื่อไปแล้ว !!";
                            lbl_alert.ForeColor = System.Drawing.Color.Green;
                            bl = true;
                        }
                        else
                        {
                            alert = "ไม่สามารถบันทึกเข้าระบบได้ !!";
                        }
                    }
                }
            }
            else
            {
                alert = "ไม่มีรหัสพนักงานนี้ในระบบ !!";
            }

            txt_empid.Value = txtEmp;
            lbl_alert.Text = alert;

            return bl;
        }

        public string Insert(string emp)
        {
            string result = "";

            room = Request.QueryString["room"];
            slot = Request.QueryString["slot"];

            sql = "select * from checkinmeeting where cm_active='yes' and CONVERT(cm_indate, date)=CURRENT_DATE " +
                "\nand cm_room = '" + room + "' and cm_slotid = '" + slot + "' and cm_empid = '" + emp + "'; ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                result = "Duplicate";
            }
            else
            {
                sql = "INSERT INTO checkinmeeting " +
                    "(cm_empid, cm_indate, cm_room, cm_outdate, cm_slotid) " +
                    "VALUE('" + emp + "', '" + DateNow + "', '" + room + "', NULL, '" + slot + "'); ";
                if (cl_Sql.Modify(sql))
                {
                    sql = "";
                    lbl_alert.Text = "";
                    result = "Success";
                }
            }

            return result;
        }

        private Boolean CheckName(string empid,string fname, string lname)
        {
            Boolean bl = true;

            sql = "select emp_id from employee " +
                "\nwhere emp_id = '" + empid + "' " +
                "\nor (emp_fname like '%" + fname + "%' and emp_lname like '%" + lname + "%') " +
                "\nor (emp_fname_th like '%" + fname + "%' and emp_lname_th like '%" + lname + "%') ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                bl = false;
            }
            else
            {
                string fullName = fname + " " + lname;
                sql = "select drs_id from doctors " +
                    "\nwhere drs_id = '" + empid + "' " +
                    "\nor drs_fullname like '%" + fullName + "%' " +
                    "\nor drs_fullname_eg like '%" + fullName + "%' ";
                dt = new DataTable();
                dt = cl_Sql.select(sql);
                if (dt.Rows.Count > 0)
                {
                    bl = false;
                }
            }

            return bl;
        }

        protected void btn_add_ServerClick(object sender, EventArgs e)
        {
            string emp = txtH_empid.Value.ToString().Trim();
            string fname = txtH_fname.Value.ToString().Trim();
            string lname = txtH_lname.Value.ToString().Trim();
            string post = txtH_post.Value.ToString().Trim();
            room = Request.QueryString["room"];
            slot = Request.QueryString["slot"];

            if (CheckName(emp, fname, lname))
            {
                string key = cl_Sql.GenerateKey(9);

                sql = "INSERT INTO checkinmeeting " +
                        "(cm_empid, cm_indate, cm_room, cm_outdate, cm_slotid) " +
                        "\nVALUES('" + key + "', '" + DateNow + "', '" + room + "', NULL, '" + slot + "'); ";
                if (cl_Sql.Modify(sql))
                {
                    sql = "select cm_id from checkinmeeting where cm_empid='" + key + "'; ";
                    dt = new DataTable();
                    dt = cl_Sql.select(sql);
                    if (dt.Rows.Count > 0)
                    {
                        string cm_id = dt.Rows[0]["cm_id"].ToString();

                        sql = "INSERT INTO checkinmeetingoutsider " +
                            "(cmo_empid, cmo_fname, cmo_lname, cmo_post, cm_id) " +
                            "\nVALUES('" + emp + "', '" + fname + "', '" + lname + "', '" + post + "', " + cm_id + "); " +
                            "\nUpdate checkinmeeting set cm_empid='' where cm_empid='" + key + "'; ";
                        if (cl_Sql.Modify(sql))
                        {
                            txt_empid.Value = "";
                            Response.Redirect("CheckinMeeting.aspx?slot=" + slot + "'&room=" + room);
                        }
                        else
                        {
                            txt_empid.Value = "";
                            lbl_alert.Text = "ไม่สามารถบันทึกเข้าระบบได้ !!";
                            lbl_alert.ForeColor = System.Drawing.Color.Red;
                        }
                    }
                }
            }
            else
            {
                txt_empid.Value = "";
                lbl_alert.Text = "ชื่อของคุณมีในระบบอยู่แล้ว จึงไม่สามารถทำการ ADD ได้ !!";
                lbl_alert.ForeColor = System.Drawing.Color.Red;
            }
            Grid1("desc");
        }

        public Boolean Grid1(string sort)
        {
            Boolean bl = false;

            room = Request.QueryString["room"];
            slot = Request.QueryString["slot"];

            sql = "SELECT c.*,co.cm_id " +
                "\n ,if (co.cm_id is null, c.cm_empid, co.cmo_empid) as 'empid' " +
                "\n ,if (co.cm_id is null, if(e.emp_id is null,d.drs_fullname,concat(e.emp_pname_th, ' ', e.emp_fname_th, ' ', e.emp_lname_th)), concat(co.cmo_fname, ' ', co.cmo_lname)) as 'emp_name' " +
                "\n ,if (co.cm_id is null, if(e.emp_id is null,concat('Doctor ',d.drs_worktype),e.emp_posdesc), co.cmo_post) as emp_posdesc " +
                "\n ,if (e.emp_id is null,d.drs_department,e.emp_deptdesc) as 'emp_deptdesc' " +
                "\nFROM checkinmeeting as c " +
                "\n left join employee as e on e.emp_id = c.cm_empid " +
                "\n left join doctors as d on d.drs_id = c.cm_empid " +
                "\n left join checkinmeetingoutsider as co on co.cm_id = c.cm_id " +
                "\nWHERE cm_active='yes' and cm_room = '" + room + "' and cm_slotid = '" + slot + "' " +
                "\nORDER BY c.cm_id " + sort + " ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                btnExport.Visible = true;
                bl = true;
            }

            GridView1.DataSource = dt;
            GridView1.DataBind();

            return bl;
        }

        protected void btnExport_Click(object sender, EventArgs e)
        {

            string header_lb = lbl_topic.Text.ToString();
            string year = "";
            year = DateTime.Now.ToString("yyyyMMdd");

            string FileName = "BRH_CheckInMeeting_" + year + ".xls";

            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=" + FileName + "");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel";
            using (StringWriter sw = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(sw);

                //To Export all pages
                GridView1.AllowPaging = false;

                Grid1("");

                Response.Write("<center><h3>แบบบันทึกรายชื่อผู้เข้าร่วมประชุม</h3>");
                Response.Write("<h5>การประชุม " + header_lb + "</h5>");

                string slot = Request.QueryString["slot"].ToString();
                string datetime = "";
                sql = "select * from checkinmeetingslot where cms_id = '" + slot + "' ";
                dt = new DataTable();
                dt = cl_Sql.select(sql);
                if (dt.Rows.Count > 0)
                {
                    datetime = dt.Rows[0]["cms_timestart"].ToString();
                }

                string day = DateTime.Parse(datetime).ToString("dd");
                string month = DateTime.Parse(datetime).ToString("MM");
                string monthName = ctm.MonthThai(month);
                string yearTH = (int.Parse(DateTime.Parse(datetime).ToString("yyyy")) + 543).ToString();
                Response.Write("<h5>วันที่ " + day + " เดือน " + monthName + " พ.ศ. " + yearTH + "</h5></center>");
                GridView1.HeaderRow.BackColor = Color.Black; // ตัวหนังสือ
                foreach (TableCell cell in GridView1.HeaderRow.Cells)
                {
                    cell.BackColor = GridView1.HeaderStyle.BackColor;
                }
                foreach (GridViewRow row in GridView1.Rows)
                {
                    row.BackColor = Color.White; // พื้นหลัง
                    foreach (TableCell cell in row.Cells)
                    {
                        if (row.RowIndex % 2 == 0)
                        {
                            cell.BackColor = GridView1.AlternatingRowStyle.BackColor;
                        }
                        else
                        {
                            cell.BackColor = GridView1.RowStyle.BackColor;
                        }
                        cell.CssClass = "textmode";
                    }
                }

                GridView1.RenderControl(hw);

                //style to format numbers to string
                string style = @"<style> .textmode { } </style>";
                Response.Write(style);
                Response.Output.Write(sw.ToString());
                Response.Flush();
                Response.End();
            }
        }
        public override void VerifyRenderingInServerForm(Control control)
        {
            /* Verifies that the control is rendered */
        }
    }
}