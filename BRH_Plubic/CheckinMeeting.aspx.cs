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
                select_room();
                Grid1("desc");
            }
        }

        public Boolean select_room()
        {
            Boolean result = false;

            string slot_name = Request.QueryString["slot"].ToString();

            sql = "SELECT * FROM checkinmeetingslot WHERE cms_id = '" + slot_name + "'; ";

            dt = new DataTable(); //ต้อง new data table ใหม่ทุกครั้งเมื่อรับค่า
            dt = cl_Sql.select(sql);

            if (dt.Rows.Count > 0) //หาข้อมูลว่ามีบรรทัดนั้นหรือไม่
            {
                lbl_room.Text = "ห้องประชุม " + dt.Rows[0]["cms_room"].ToString();
                lbl_topic.Text = dt.Rows[0]["cms_sj"].ToString();
                string Startdate = DateTime.Parse(dt.Rows[0]["cms_timestart"].ToString()).ToString("dd/MM/yyyy HH:mm");
                string Enddate = DateTime.Parse(dt.Rows[0]["cms_timeend"].ToString()).ToString("dd/MM/yyyy HH:mm");
                lbl_dateslot.Text = Startdate + " น. ถึง " + Enddate + " น.";
                result = true;
            }

            return result;
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            CheckEmp();
        }

        public Boolean CheckEmp()
        {
            Boolean bl = false;

            room = Request.QueryString["room"];
            slot = Request.QueryString["slot"];

            string empid = txt_empid.Value.ToString().Trim();
            sql = "select * from employee where emp_id = '" + empid + "' ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                string timest_timeend = Request.QueryString["slot"].ToString();
                

                sql = "SELECT * FROM checkinmeetingslot WHERE cms_id = '" + timest_timeend + "'; ";

                dt = new DataTable(); //ต้อง new data table ใหม่ทุกครั้งเมื่อรับค่า
                dt = cl_Sql.select(sql);

                if (dt.Rows.Count > 0) //หาข้อมูลว่ามีบรรทัดนั้นหรือไม่
                {
                    string timest = dt.Rows[0]["cms_timestart"].ToString();
                    string timeend = dt.Rows[0]["cms_timeend"].ToString();

                    string time_now = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");

                    DateTime DateNow = DateTime.Parse(time_now);
                    int DateNow_H = DateNow.Hour;
                    int DateNow_M = DateNow.Minute;
                    int DateNow_HM = (DateNow_H * 60) + DateNow_M;

                    DateTime DateStart = DateTime.Parse(timest);
                    int DateStart_H = DateStart.Hour;
                    int DateStart_M = DateStart.Minute;
                    int DateStart_HM = (DateStart_H * 60) + DateStart_M;
                    int DateStart_HM_adjust = DateStart_HM - 20; // scan ได้ก่อนถึงเวลา 20 นาที

                    DateTime DateEnd = DateTime.Parse(timeend);
                    int DateEnd_H = DateEnd.Hour;
                    int DateEnd_M = DateEnd.Minute;
                    int DateEnd_HM = (DateEnd_H * 60) + DateEnd_M;

                    if (DateStart.Date == DateNow.Date && DateStart_HM_adjust <= DateNow_HM)
                    {
                        if (DateNow_HM <= DateEnd_HM)
                        {
                            if (Insert(empid))
                            {
                                lbl_alert.Text = DateTime.Now.ToString();
                                lbl_alert.ForeColor = System.Drawing.Color.Green;
                                bl = true;
                                Response.Redirect("CheckinMeeting.aspx?slot=" + slot + "&room=" + room);
                            }
                            else
                            {
                                txt_empid.Value = "";
                                lbl_alert.Text = "ไม่สามารถบันทึกเข้าระบบได้ !!";
                                lbl_alert.ForeColor = System.Drawing.Color.Red;
                            }
                        }
                        else
                        {
                            txt_empid.Value = "";
                            lbl_alert.Text = "เกินเวลาเช็คชื่อแล้ว !!";
                            lbl_alert.ForeColor = System.Drawing.Color.Red;
                        }
                    }
                    else
                    {
                        txt_empid.Value = "";
                        lbl_alert.Text = "ยังไม่ถึงเวลาเช็คชื่อ !!";
                        lbl_alert.ForeColor = System.Drawing.Color.Red;
                    }
                }
            }
            else
            {
                txt_empid.Value = "";
                lbl_alert.Text = "ไม่มีรหัสพนักงานนี้ในระบบ !!";
                lbl_alert.ForeColor = System.Drawing.Color.Red;
            }

            return bl;
        }

        public Boolean Insert(string emp)
        {
            Boolean bl = false;

            room = Request.QueryString["room"];
            slot = Request.QueryString["slot"];

            sql = "select * from checkinmeeting where CONVERT(cm_indate, date)=CURRENT_DATE and cm_room = '" + room + "' and cm_slotid = '" + slot + "' and cm_empid = '" + emp + "' ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                bl = true;
            }
            else
            {
                sql = "INSERT INTO checkinmeeting " +
                    "(cm_empid, cm_indate, cm_room, cm_outdate, cm_slotid) " +
                    "VALUES('" + emp + "', '" + DateNow + "', '" + room + "', NULL, '" + slot + "'); ";
                if (cl_Sql.Modify(sql))
                {
                    bl = true;
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

            sql = "INSERT INTO checkinmeeting " +
                    "(cm_empid, cm_indate, cm_room, cm_outdate, cm_slotid) " +
                    "VALUES('', '" + DateNow + "', '" + room + "', NULL, '" + slot + "'); ";
            if (cl_Sql.Modify(sql))
            {
                sql = "select * from checkinmeeting order by cm_id desc LIMIT 5 ";
                dt = new DataTable();
                dt = cl_Sql.select(sql);
                if (dt.Rows.Count > 0)
                {
                    string cm_id = dt.Rows[0]["cm_id"].ToString();

                    sql = "INSERT INTO checkinmeetingoutsider " +
                        "(cmo_empid, cmo_fname, cmo_lname, cmo_post, cm_id) " +
                        "VALUES('" + emp + "', '" + fname + "', '" + lname + "', '" + post + "', " + cm_id + "); ";
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

        public Boolean Grid1(string sort)
        {
            Boolean bl = false;

            room = Request.QueryString["room"];
            slot = Request.QueryString["slot"];

            sql = "SELECT c.*,co.cm_id " +
                "\n,if (co.cm_id is null, c.cm_empid, co.cmo_empid) as 'empid' " +
                "\n,if (co.cm_id is null, concat(e.emp_pname_th, ' ', e.emp_fname_th, ' ', e.emp_lname_th), concat(co.cmo_fname, ' ', co.cmo_lname)) as 'emp_name' " +
                "\n,if (co.cm_id is null, e.emp_posdesc, co.cmo_post) as emp_posdesc " +
                "\n,e.emp_deptdesc " +
                "\nFROM checkinmeeting as c " +
                "\nleft join employee as e on e.emp_id = c.cm_empid " +
                "\nleft join checkinmeetingoutsider as co on co.cm_id = c.cm_id " +
                "\nWHERE cm_room = '" + room + "' and cm_slotid = '" + slot + "' " +
                //"\nand CONVERT(c.cm_indate, date)= CURRENT_DATE" +
                "\norder by c.cm_id " + sort + " ";
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