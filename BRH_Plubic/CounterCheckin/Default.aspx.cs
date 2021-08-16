using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Drawing;
using System.Data;
using System.Text;
using MySql.Data.MySqlClient;

namespace BRH_Plubic.CounterCheckin
{
    public partial class Default : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        ClassEmail cl_email = new ClassEmail();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["eval"] != null)
            {
                div_branch.Visible = false;
                div_dept.Visible = false;
                if (Evaluate())
                {
                    div_alert.Visible = true;
                    lbl_eval.ForeColor = System.Drawing.Color.Green;
                    lbl_eval.Text = "ขอบคุณสำหรับการประเมินของท่าน";
                }
                else
                {
                    Response.Write("<script>alert(ไม่สามารถทำการประเมินได้ หรือได้ทำการประเมินไปแล้ว !!);</script>");
                }
            }
            else
            {
                CheckLogin();
                if (!IsPostBack)
                {
                    DepartmentList();
                }
            }
        }

        public Boolean CheckLogin()
        {
            Boolean bl = false;

            if (Session["Login"] == null)
            {
                Response.Redirect("../Default.aspx?back=CounterCheckin&login=require");
            }
            else
            {
                string UserStatus = Session["status"].ToString();
                if (UserStatus == "admin" || UserStatus == "employee" || UserStatus == "hod")
                {
                    bl = true;

                    if (Request.QueryString["br"] == null)
                    {
                        div_department.Visible = false;
                    }
                    else
                    {
                        div_branch.Visible = false;
                        div_department.Visible = true;

                        string empid = Session["userid"].ToString();
                        txt_empid.Value = empid;
                        txt_empid.Disabled = true;

                        ForgotCheckOut(empid); // ------------ Clear Forgot check out
                        InOutButton(empid); // Select Button In Out

                        string branch = "BRH";
                        if (Request.QueryString["br"] != null)
                        {
                            branch = Request.QueryString["br"].ToString();
                        }

                        string ImgLogo = "images/LOGO-BRH_Rayong.png";
                        if (branch == "SRH")
                        {
                            ImgLogo = "images/LOGO-SRI_Rayong.png";
                        }
                        img_logo.Src = ImgLogo;

                        if (Request.QueryString["dept"] == null)
                        {
                            div_back.Visible = false;
                            div_CheckIn.Visible = false;
                        }
                        else
                        {
                            div_back.Visible = true;
                            div_CheckIn.Visible = true;
                            div_dept.Visible = false;

                            lb_department.Text = "Department : " + Department();

                            if (Request.QueryString["check"] != null)
                            {
                                string check = Request.QueryString["check"].ToString();
                                if (check == "in")
                                {
                                    lb_alert.Text = "Check In success.";
                                    lb_alert.ForeColor = Color.Green;
                                }
                                else if (check == "out")
                                {
                                    lb_alert.Text = "Check Out success.";
                                    lb_alert.ForeColor = Color.Green;
                                    System.Threading.Thread.Sleep(2000);
                                }
                                else
                                {

                                }
                            }

                            if (!IsPostBack)
                            {
                                Grid1();
                            }
                        }
                    }
                }
                else
                {
                    Response.Write("<script>alert('คุณไม่มีสิทธิ์ใช้งานระบบนี้ !!'); window.location.href='../Default.aspx';</script>");
                }
            }

            return bl;
        }

        public Boolean DepartmentList()
        {
            Boolean bl = false;

            string branch = "BRH";
            if (Request.QueryString["br"] != null)
            {
                branch = Request.QueryString["br"].ToString();
            }

            sql = "select * from department_service where ds_active = 'yes' and ds_branch = '" + branch + "' order by ds_desc ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                bl = true;
            }

            DD_department.DataSource = dt;
            DD_department.DataTextField = "ds_desc";
            DD_department.DataValueField = "ds_id";
            DD_department.DataBind();

            return bl;
        }

        protected void btn_dept_ServerClick(object sender, EventArgs e)
        {
            string br = "";
            if (Request.QueryString["br"] != null)
            {
                br = Request.QueryString["br"].ToString();
                string deptid = DD_department.SelectedValue.ToString();
                Response.Redirect("Default.aspx?br=" + br + "&dept=" + deptid);
            }
            else
            {
                Response.Redirect("Default.aspx");
            }
        }

        public string Department()
        {
            string result = "";

            string dept = Request.QueryString["dept"].ToString();

            sql = "select * from department_service where ds_active = 'yes' and ds_id = '" + dept + "' ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                result = dt.Rows[0]["ds_desc"].ToString();
            }

            return result;
        }

        public string Group()
        {
            string group = "";

            if (Request.QueryString["dept"] != null)
            {
                string dept = Request.QueryString["dept"].ToString();

                
                sql = "select * from department_service where ds_id = '" + dept + "' ";
                dt = new DataTable();
                dt = cl_Sql.select(sql);
                if (dt.Rows.Count > 0)
                {
                    group = dt.Rows[0]["ds_group"].ToString();
                }
            }

            return group;
        }

        public Boolean InOutButton(string empid)
        {
            Boolean bl = false;

            string group = Group();

            sql = "select * from countercheckin where cc_empid = '" + empid + "' ";
            if (group == "IPD")
            {
                sql = sql + "and cc_datein >= DATE_ADD(current_date, INTERVAL -1 DAY) ";
            }
            else
            {
                sql = sql + "and cc_datein = current_date ";
            }
            sql = sql + "order by cc_id desc ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                if (dt.Rows[0]["cc_timeout"].ToString() == "")
                {
                    btn_submit.Text = "Check-Out";
                    btn_submit.Attributes.Add("Class", "btn btn-outline-warning");
                }
                else
                {
                    btn_submit.Text = "Check-In";
                    btn_submit.Attributes.Add("Class", "btn btn-outline-success");
                }
            }
            else
            {
                btn_submit.Text = "Check-In";
                btn_submit.Attributes.Add("Class", "btn btn-outline-success");
            }

            return bl;
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            //string empid = txt_empid.Value.ToString().Trim();
            string empid = Session["userid"].ToString();
            if (empid == "")
            {
                lb_alert.Text = "กรุณากรอกรหัสพนักงาน !!";
            }
            else
            {
                string br = Request.QueryString["br"].ToString();
                string deptid = Request.QueryString["dept"].ToString();
                string alert =  CheckEmp(empid, br);
                if (alert == "CheckIn")
                {
                    sql = "select * from department_service where ds_id = '" + deptid + "' ";
                    dt = new DataTable();
                    dt = cl_Sql.select(sql);
                    if (dt.Rows.Count > 0)
                    {
                        if (checkIn(empid, deptid))
                        {
                            Response.Redirect("Default.aspx?br=" + br + "&dept=" + deptid + "&check=in");
                        }
                    }
                    else
                    {
                        lb_alert.Text = "ไม่สามารถ Check-In ได้ เนื่องจากแผนกไม่ถูกต้อง !!";
                        lb_alert.ForeColor = Color.Red;
                    }
                }
                else if (alert == "CkeckOut")
                {
                    if (checkOut(empid))
                    {
                        Response.Redirect("Default.aspx?br=" + br + "&dept=" + deptid + "&check=out");
                    }
                }
                else
                {
                    lb_alert.Text = alert.ToString();
                    lb_alert.ForeColor = Color.Red;
                }
            }
        }

        public string CheckEmp(string empid, string br)
        {
            string result = "";

            sql = "select * from employee where emp_id = '" + empid + "' ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                string branch = dt.Rows[0]["emp_group"].ToString();
                if (branch != br)
                {
                    result = "รหัสพนักงาน " + empid + " ไม่ได้อยู่ในโรงพยาบาลนี้ !!";
                }
                else
                {
                    string dept = Request.QueryString["dept"].ToString();

                    string group = Group();

                    sql = "select * from countercheckin where cc_empid = '" + empid + "' ";
                    if (group == "IPD")
                    {
                        sql = sql + "and cc_datein >= DATE_ADD(current_date, INTERVAL -1 DAY) ";
                    }
                    else
                    {
                        sql = sql + "and cc_datein = current_date ";
                    }
                    sql = sql + "order by cc_id desc ";
                    dt = new DataTable();
                    dt = cl_Sql.select(sql);
                    if (dt.Rows.Count > 0)
                    {
                        if (dt.Rows[0]["cc_timeout"].ToString() == "")
                        {
                            string cc_deptid = dt.Rows[0]["cc_deptid"].ToString();
                            if (cc_deptid == dept)
                            {
                                result = "CkeckOut";
                            }
                            else
                            {
                                sql = "select * from department where deptid = '" + cc_deptid + "' ";
                                dt = new DataTable();
                                dt = cl_Sql.select(sql);
                                if (dt.Rows.Count > 0)
                                {
                                    result = dt.Rows[0]["deptname"].ToString();
                                }
                                result = "ยังไม่ได้ Check Out จากแผนก " + result + " !!";
                            }
                        }
                        else
                        {
                            //if (dt.Rows[0]["cc_deptid"].ToString() == dept)
                            //{
                            //    result = "คุณได้ทำการ Check Out ไปแล้ว !!";
                            //}
                            //else
                            //{
                            //    result = "CheckIn";
                            //}
                            result = "CheckIn";
                        }
                    }
                    else
                    {
                        result = "CheckIn";
                    }
                }
            }
            else
            {
                result = "ไม่มีรหัสพนักงานนี้ในระบบ !!";
            }

            return result;
        }

        protected void ForgotCheckOut(string empid)
        {
            sql = "update countercheckin set cc_status='forgot checkout' " +
                ",cc_dateout = CONVERT((CONVERT(CONCAT(cc_datein, ' ', cc_timein), datetime) + INTERVAL 8 hour),date) " +
                ",cc_timeout = CONVERT((CONVERT(CONCAT(cc_datein, ' ', cc_timein), datetime) + INTERVAL 8 hour),time) " +
                "where cc_status = 'working' and cc_empid like '%" + empid + "%' and cc_timeout is null " +
                "and CONVERT(CONCAT(cc_datein, ' ', cc_timein), datetime) < (CURRENT_TIMESTAMP - INTERVAL 18 hour)";
            cl_Sql.Modify(sql);
        }

        public Boolean checkIn(string empid, string deptid)
        {
            Boolean bl = false;

            string type = rd_type.SelectedValue.ToString();
            
            sql = "INSERT INTO countercheckin " +
                "(cc_datein, cc_timein, cc_dateout, cc_timeout, cc_empid, cc_deptid, cc_status, cc_type) " +
                "VALUES(current_date, current_time, NULL, NULL, '" + empid + "', '" + deptid + "', 'working', '" + type + "'); ";
            if (cl_Sql.Modify(sql))
            {
                bl = true;
            }

            return bl;
        }

        public Boolean checkOut(string empid)
        {
            Boolean bl = false;

            string group = Group();

            sql = "Update countercheckin set cc_dateout = current_date, cc_timeout = current_time, cc_status = 'waiting' " +
                "where cc_timeout is null and cc_empid = '" + empid + "' ";
            if (group == "IPD")
            {
                sql = sql + "and cc_datein >= DATE_ADD(current_date, INTERVAL -1 DAY) ";
            }
            else
            {
                sql = sql + "and cc_datein = current_date ";
            }

            if (cl_Sql.Modify(sql))
            {
                bl = true;

                string cc_id = "";
                sql = "select max(cc_id) as cc_id from countercheckin where cc_empid = '" + empid + "' ";
                dt = new DataTable();
                dt = cl_Sql.select(sql);
                if (dt.Rows.Count > 0)
                {
                    cc_id = dt.Rows[0]["cc_id"].ToString();
                }

                string deptid = Request.QueryString["dept"].ToString();

                sql = "select * from department_service where ds_id = '" + deptid + "' ";
                dt = new DataTable();
                dt = cl_Sql.select(sql);
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
                        dt = cl_Sql.select(sql);
                        if (dt.Rows.Count > 0)
                        {
                            string br = Request.QueryString["br"].ToString();

                            string empname = dt.Rows[0]["emp_pname_th"].ToString() + " " + dt.Rows[0]["emp_pnamefull_th"].ToString();
                            string deptName = dt.Rows[0]["emp_deptdesc"].ToString();

                            string body = "<h3>เรียน หัวหน้าแผนก " + deptname + ",</h3>" +
                                      "\n<br />" +
                                      "\n<h3>รบกวนช่วยประเมิน " + empname + "</h3><br />" +
                                      "\n<h3>สังกัดแผนก " + deptName + "</h3><br />" +
                                      "\n<table width=\"100%\">" +
                                      "\n<tr>" +
                                      "\n<td width=\"20%\"><a href='http://brh.seedoctor.asia/CounterCheckin/Default?id=" + cc_id + "&br=" + br +"&eval=1'><img src=\"http://brh.seedoctor.asia/CounterCheckin/images/eval_1.png\" width=\"64\" />แย่มาก</a></td>" +
                                      "\n<td width=\"20%\"><a href='http://brh.seedoctor.asia/CounterCheckin/Default?id=" + cc_id + "&br=" + br + "&eval=2'><img src=\"http://brh.seedoctor.asia/CounterCheckin/images/eval_2.png\" width=\"64\" />แย่</a></td>" +
                                      "\n<td width=\"20%\"><a href='http://brh.seedoctor.asia/CounterCheckin/Default?id=" + cc_id + "&br=" + br + "&eval=3'><img src=\"http://brh.seedoctor.asia/CounterCheckin/images/eval_3.png\" width=\"64\" />ปานกลาง</a></td>" +
                                      "\n<td width=\"20%\"><a href='http://brh.seedoctor.asia/CounterCheckin/Default?id=" + cc_id + "&br=" + br + "&eval=4'><img src=\"http://brh.seedoctor.asia/CounterCheckin/images/eval_4.png\" width=\"64\" />ดี</a></td>" +
                                      "\n<td width=\"20%\"><a href='http://brh.seedoctor.asia/CounterCheckin/Default?id=" + cc_id + "&br=" + br + "&eval=5'><img src=\"http://brh.seedoctor.asia/CounterCheckin/images/eval_5.png\" width=\"64\" />ดีมาก</a></td>" +
                                      "\n</tr>" +
                                      "\n</table>" +
                                      "\n<br /><br />" +
                                      "\n<h3>อีเมลฉบับนี้ เป็นอีเมลแบบอัตโนมัติ</h3>" +
                                      "\n<h3>หากมีข้อสงสัยกรุณาติดต่อที่ฝ่ายบุคคล โทร.xxxx</h3>";

                            bl = true;

                            if(cl_email.Send(mailTo, subject, body))
                            {
                                sql = "update countercheckin set cc_mailto='" + mailTo + "' where cc_id='" + cc_id + "'; ";
                                cl_Sql.Modify(sql);
                            }
                            
                        }
                    }
                }
            }

            return bl;
        }

        public Boolean Grid1()
        {
            Boolean bl = false;

            string dept = Request.QueryString["dept"].ToString();

            string group = Group();

            sql = "select cc.*,concat(em.emp_pname_th,' ',em.emp_pnamefull_th) as 'emp_Name' from countercheckin as cc " +
                "left join employee as em on em.emp_id = cc.cc_empid " +
                "where cc_status in ('working','waiting','forgot checkout') and cc_deptid = '" + dept + "' ";
            if (group == "IPD")
            {
                sql = sql + "and cc_datein >= DATE_ADD(current_date, INTERVAL -1 DAY) ";
            }
            else
            {
                sql = sql + "and cc_datein = current_date ";
            }
            sql = sql + "order by cc_id desc ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                bl = true;
            }

            GridView1.DataSource = dt;
            GridView1.DataBind();

            return bl;
        }

        public Boolean Evaluate()
        {
            Boolean bl = false;

            string cc_id = Request.QueryString["id"].ToString();
            string eval = Request.QueryString["eval"].ToString();
            string suggess = txt_sugges.Value.ToString().Trim();

            sql = "update countercheckin set cc_evaluate='" + eval + "', cc_status = 'confirm', cc_suggestion = '" + suggess + "' " +
                "where cc_status = 'waiting' and cc_id = '" + cc_id + "' ";
            if (cl_Sql.Modify(sql))
            {
                bl = true;
            }

            return bl;
        }

        protected void btn_sugges_Click(object sender, EventArgs e)
        {
            string cc_id = Request.QueryString["id"].ToString();
            string eval = Request.QueryString["eval"].ToString();

            string sugges = txt_sugges.Value.ToString().Trim();

            sql = "update countercheckin set cc_suggestion='" + sugges + "' where cc_id = '" + cc_id + "' ";
            if (cl_Sql.Modify(sql))
            {
                Response.Write("<script>alert('ส่งข้อเสนอแนะ เรียบร้อยแล้ว !!'); window.location.href='Default?id=" + cc_id + "&eval=" + eval + "';</script>");
            }
        }
    }
}