using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;

namespace BRH_Plubic.CounterCheckin
{
    public partial class Self : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass CL_Sql = new SQLclass();
        ClassEmail cl_email = new ClassEmail();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Login"] == null)
            {
                Response.Redirect("../Default.aspx?back=CounterCheckin/Self&login=require");
            }
            else
            {
                string UserID = Session["userid"].ToString();
                string UserStatus = Session["status"].ToString();
                string startDate = DateTime.Now.Date.AddDays(-1).ToString();
                string endDate = DateTime.Now.Date.ToString();
                if (!IsPostBack)
                {
                    DataStatus();
                    ddl_status.SelectedValue = "working";

                    DataList(UserID, "working", startDate, endDate);
                }
            }
                
        }

        protected void DataStatus()
        {
            sql = "select 'All' as 'cc_status' union select distinct cc_status from countercheckin ";
            dt = new DataTable();
            dt = CL_Sql.select(sql);

            ddl_status.DataSource = dt;
            ddl_status.DataValueField = "cc_status";
            ddl_status.DataTextField = "cc_status";
            ddl_status.DataBind();
        }

        protected void DataList(string empid, string status, string dateStart, string dateEnd)
        {
            if (dateStart == "") 
            { 
                dateStart = "1991-01-01"; 
            }
            else
            {
                dateStart = DateTime.Parse(dateStart).ToString("yyyy-MM-dd");
            }
            if (dateEnd == "")
            {
                dateEnd = DateTime.Now.Date.ToString("yyyy-MM-dd");
            }
            else
            {
                dateEnd = DateTime.Parse(dateEnd).ToString("yyyy-MM-dd");
            }

            if (status == "All")
            {
                status = "";
            }

            sql = "select cc.*, if(cc_type='Help','ช่วยงาน','ฝึกงาน') as 'cc_typename', if(cc_evaluate is null,'0',cc_evaluate) as 'cc_score' " +
                "\n, CONCAT(cc.cc_datein,' ',cc.cc_timein,' น.') as 'datein', CONCAT(cc.cc_dateout,' ',cc.cc_timeout,' น.') as 'dateout' " +
                "\n, if(cc_suggestion is null,'',CONCAT('คำแนะนำ ติชม : ',cc_suggestion)) as 'suggestion' " +
                "\n, ds.ds_desc, CONCAT(em.emp_pname_th,' ',em.emp_fname_th,' ',em.emp_lname_th) as 'empname' " +
                "\nfrom countercheckin as cc " +
                "\nleft join department_service ds on ds.ds_id = cc.cc_deptid " +
                "\nleft join employee em on em.emp_id = cc.cc_empid " +
                "\nwhere cc_empid like '%" + empid + "%'" +
                "\nand (cc_datein >= '" + dateStart + "' and  cc_datein <= '" + dateEnd + "') " +
                "\nand cc_status like '%" + status + "%' " +
                "\norder by CONVERT(CONCAT(cc.cc_datein,' ',cc.cc_timein),date) desc ";
            dt = new DataTable();
            dt = CL_Sql.select(sql);

            lv_list.DataSource = dt;
            lv_list.DataBind();
        }

        protected void btnSearch_ServerClick(object sender, EventArgs e)
        {
            string UserID = Session["userid"].ToString();
            string dateStart = date_Start.Value.ToString();
            string dateEnd = date_end.Value.ToString();
            string status = ddl_status.SelectedValue.ToString();

            DataList(UserID, status, dateStart, dateEnd);
        }

        protected void btn_cancel_ServerClick(object sender, EventArgs e)
        {
            string id = txtH_ID.Value.ToString();
            sql = "update countercheckin set cc_status = 'cancel' where cc_id = '" + id + "' ";
            if (CL_Sql.Modify(sql)) 
            {
                Response.Write("<script>alert('ยกเลิกรายการเรียบร้อยแล้ว !!'); window.location.href='Self.aspx';</script>");
            }
            else
            {
                Response.Write("<script>alert('ไม่สามารถยกเลิกรายการได้ กรุณาติดต่อผู้ดูแลระบบ !!'); window.location.href='Self.aspx';</script>");
            }
        }

        protected void btn_CheckOut_ServerClick(object sender, EventArgs e)
        {
            string id = txtH_ID.Value.ToString();
            string empid = Session["userid"].ToString();
            string deptid = txtH_deptID.Value.ToString();

            if (checkOut(id, empid, deptid))
            {
                Response.Write("<script>alert('Check-out เรียบร้อยแล้ว !!'); window.location.href='Self.aspx';</script>");
            }
            else
            {
                Response.Write("<script>alert('ไม่สามารถ Check-out ได้ กรุณาติดต่อผู้ดูแลระบบ !!'); window.location.href='Self.aspx';</script>");
            }
            
        }

        public string Group()
        {
            string group = "";

            string deptid = txtH_deptID.Value.ToString();

            sql = "select * from department_service where ds_id = '" + deptid + "' ";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                group = dt.Rows[0]["ds_group"].ToString();
            }

            return group;
        }

        protected void ForgotCheckOut(string id)
        {
            sql = "update countercheckin set cc_status='forgot checkout' " +
                ",cc_dateout = CONVERT((CONVERT(CONCAT(cc_datein, ' ', cc_timein), datetime) + INTERVAL 8 hour),date) " +
                ",cc_timeout = CONVERT((CONVERT(CONCAT(cc_datein, ' ', cc_timein), datetime) + INTERVAL 8 hour),time) " +
                "where cc_status = 'working' and cc_id = '" + id + "' and cc_timeout is null " +
                "and CONVERT(CONCAT(cc_datein, ' ', cc_timein), datetime) < (CURRENT_TIMESTAMP - INTERVAL 12 hour)";
            CL_Sql.Modify(sql);
        }

        public Boolean checkOut(string id, string empid, string deptid)
        {
            Boolean bl = false;

            string group = Group();

            ForgotCheckOut(empid);

            sql = "Update countercheckin set cc_dateout = current_date, cc_timeout = current_time, cc_status = 'waiting' " +
                "where cc_timeout is null and cc_id = '" + id + "' ";
            if (group == "IPD")
            {
                sql = sql + "and cc_datein >= DATE_ADD(current_date, INTERVAL -1 DAY) ";
            }
            else
            {
                sql = sql + "and cc_datein = current_date ";
            }

            if (CL_Sql.Modify(sql))
            {
                bl = true;

                sql = "select * from department_service where ds_id = '" + deptid + "' ";
                dt = new DataTable();
                dt = CL_Sql.select(sql);
                if (dt.Rows.Count > 0)
                {
                    string mailTo = dt.Rows[0]["ds_email"].ToString();
                    if (mailTo != "")
                    {
                        bl = false;

                        string dateNow = DateTime.Now.Date.ToString("dd/MM/yyyy");
                        string subject = "ประเมินผู้ที่มาช่วยงานหรือฝึกงานในแผนกของท่าน วันที่ " + dateNow;

                        string deptname = dt.Rows[0]["ds_desc"].ToString();

                        sql = "select * from employee where emp_id = '" + empid + "' ";
                        dt = new DataTable();
                        dt = CL_Sql.select(sql);
                        if (dt.Rows.Count > 0)
                        {
                            //string br = Request.QueryString["br"].ToString();
                            string br = dt.Rows[0]["emp_group"].ToString();

                            string empname = dt.Rows[0]["emp_pname_th"].ToString() + " " + dt.Rows[0]["emp_pnamefull_th"].ToString();
                            string deptName = dt.Rows[0]["emp_deptdesc"].ToString();

                            string body = "<h3>เรียน หัวหน้าแผนก " + deptname + ",</h3>" +
                                      "\n<br />" +
                                      "\n<h3>รบกวนช่วยประเมิน " + empname + "</h3><br />" +
                                      "\n<h3>สังกัดแผนก " + deptName + "</h3><br />" +
                                      "\n<table width=\"100%\">" +
                                      "\n<tr>" +
                                      "\n<td width=\"20%\"><a href='http://brh.seedoctor.asia/CounterCheckin/Default?id=" + id + "&br=" + br + "&eval=1'><img src=\"http://brh.seedoctor.asia/CounterCheckin/images/eval_1.png\" width=\"64\" />แย่มาก</a></td>" +
                                      "\n<td width=\"20%\"><a href='http://brh.seedoctor.asia/CounterCheckin/Default?id=" + id + "&br=" + br + "&eval=2'><img src=\"http://brh.seedoctor.asia/CounterCheckin/images/eval_2.png\" width=\"64\" />แย่</a></td>" +
                                      "\n<td width=\"20%\"><a href='http://brh.seedoctor.asia/CounterCheckin/Default?id=" + id + "&br=" + br + "&eval=3'><img src=\"http://brh.seedoctor.asia/CounterCheckin/images/eval_3.png\" width=\"64\" />ปานกลาง</a></td>" +
                                      "\n<td width=\"20%\"><a href='http://brh.seedoctor.asia/CounterCheckin/Default?id=" + id + "&br=" + br + "&eval=4'><img src=\"http://brh.seedoctor.asia/CounterCheckin/images/eval_4.png\" width=\"64\" />ดี</a></td>" +
                                      "\n<td width=\"20%\"><a href='http://brh.seedoctor.asia/CounterCheckin/Default?id=" + id + "&br=" + br + "&eval=5'><img src=\"http://brh.seedoctor.asia/CounterCheckin/images/eval_5.png\" width=\"64\" />ดีมาก</a></td>" +
                                      "\n</tr>" +
                                      "\n</table>" +
                                      "\n<br /><br />" +
                                      "\n<h3>อีเมลฉบับนี้ เป็นอีเมลแบบอัตโนมัติ</h3>" +
                                      "\n<h3>หากมีข้อสงสัยกรุณาติดต่อที่ฝ่ายบุคคล โทร.1506</h3>";

                            bl = true;

                            //mailTo = "brh.hito@brh.co.th"; // ----- For Test

                            cl_email.Send(mailTo, subject, body);

                        }
                    }
                }
            }

            return bl;
        }
    }
}