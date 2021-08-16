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
    public partial class AnnualCheckup : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            //Response.Write("<script>alert('ระบบจะเปิดให้ลงทะเบียนวันที่ 01/04/2020 !!'); window.location.href='Default.aspx';</script>");

            if (!IsPostBack)
            {
                Quota();
            }
        }

        public Boolean Quota()
        {
            Boolean bl = false;

            sql = "select * ,CONCAT(CONVERT(DAY(quota_date),CHARACTER),'/',CONVERT(MONTH(quota_date),CHARACTER),'/',CONVERT(YEAR(quota_date),CHARACTER),'  เหลืออีก ',CONVERT((quota_full - quota_qty),CHARACTER),' คน') as 'TextF'  " +
                "from annualcheckup_quota " +
                "where quota_date >= CURRENT_DATE and quota_active = 'Yes' and (quota_qty < quota_full) " +
                "order by quota_date ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                DD_Quota.DataSource = dt;
                DD_Quota.DataTextField = "TextF";
                DD_Quota.DataValueField = "quota_id";
                DD_Quota.DataBind();
            }

            return bl;
        }

        protected void btn_emp_ServerClick(object sender, EventArgs e)
        {
            Quota();

            string emp = txt_empid.Value.ToString();
            CheckEMP(emp);
        }

        public Boolean CheckEMP(string emp)
        {
            Boolean bl = false;

            //sql = "select * from annualcheckup_emp where emp_year=CONVERT(year(now()),CHARACTER) and emp_id = '" + emp + "' ";
            sql = "select * from annualcheckup_emp where emp_year='2021' and emp_id = '" + emp + "' ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                string sex = "";
                string pname = "";
                string fname = "";
                string lname = "";
                string deptid = "";
                string deptdesc = "";

                sex = dt.Rows[0]["emp_sex"].ToString();

                if (dt.Rows[0]["emp_register"].ToString() == "Yes")
                {
                    string DateBook = "";
                    sql = "select *,CONCAT( CONVERT(DAY(quota_date),CHARACTER),'/',CONVERT(MONTH(quota_date),CHARACTER),'/',CONVERT(YEAR(quota_date),CHARACTER) ) as 'DateAlert' " +
                        "from annualcheckup_quota where quota_id = '" + dt.Rows[0]["emp_quotaid"].ToString() + "' ";
                    dt = new DataTable();
                    dt = cl_Sql.select(sql);
                    if (dt.Rows.Count > 0)
                    {
                        DateBook = dt.Rows[0]["DateAlert"].ToString();
                    }

                    divhide.Visible = false;
                    divAlert.Visible = true;
                    divCancel.Visible = true;
                    lbl_alert.Text = "คุณลงทะเบียนในวันที่ (" + DateBook + ") ไว้แล้ว !!";
                }
                else
                {
                    sql = "select * from employee where emp_id = '" + emp + "' ";
                    dt = new DataTable();
                    dt = cl_Sql.select(sql);
                    if (dt.Rows.Count > 0)
                    {
                        lbl_alert.Visible = false;
                        divhide.Visible = true;
                        btn_submit.Visible = true;

                        if (sex == "M") { RD_SexM.Checked = true; }
                        if (sex == "F") { RD_SexF.Checked = true; }

                        pname = dt.Rows[0]["emp_pname_th"].ToString();
                        fname = dt.Rows[0]["emp_fname_th"].ToString();
                        lname = dt.Rows[0]["emp_lname_th"].ToString();
                        txt_pname.Value = pname;
                        txt_fname.Value = fname;
                        txt_lname.Value = lname;

                        deptid = dt.Rows[0]["emp_deptid"].ToString();
                        deptdesc = dt.Rows[0]["emp_deptdesc"].ToString();
                        txt_dept.Value = deptid;
                        txt_deptdesc.Value = deptdesc;
                    }
                }
            }
            else
            {
                divAlert.Visible = true;
                divCancel.Visible = false;
                lbl_alert.Text = "คุณไม่มีสิทธิ์ตรวจสุขภาพในปีนี้ !!";
            }


            return bl;
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            string QuotaID = "0";
            QuotaID = DD_Quota.SelectedValue.ToString();
            if (CheckQuota(QuotaID) == false)
            {
                Response.Write("<script>alert('เต็มแล้ว เสียใจด้วยคุณลงทะเบียนไม่ทัน กรุณาเลือกวันอื่น !!'); window.location.href='AnnualCheckup.aspx';</script>");
            }
            else
            {
                string AlertText = InsertQuota(QuotaID);
                if (AlertText != "") {
                    Response.Write("<script>alert('บักทึกข้อมูลเรียบร้อยแล้ว !!');</script>");
                    Response.Write("<script>alert('เลขที่การจองของท่านคือ ( " + AlertText + " ) โปรดจำเลขที่นี้ไว้ เพื่อใช้สำหรับยกเลิกวันที่จองได้'); window.location.href='AnnualCheckup.aspx';</script>");
                } else if (AlertText == "Duplicate") {
                    Response.Write("<script>alert('คุณเคยลงทะเบียนไปแล้ว ไม่สามารถลงซ้ำได้อีก !!'); window.location.href='Default.aspx';</script>");
                } else {
                    Response.Write("<script>alert('ไม่สามารถลงทะเบียนได้ กรุณาติดต่อ HR !!');</script>");
                }
            }
        }

        public Boolean CheckQuota(string Qid)
        {
            Boolean bl = false;

            sql = "select * from annualcheckup_quota where quota_id = " + Qid + " and (quota_qty < quota_full) ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if(dt.Rows.Count > 0)
            {
                bl = true;
            }

            return bl;
        }

        public string InsertQuota(string Qid)
        {
            string alert = "";

            string Sex = "";
            if (RD_SexM.Checked) {
                Sex = RD_SexM.Value.ToString();
            } else if (RD_SexF.Checked) {
                Sex = RD_SexF.Value.ToString();
            } else {
                Sex = "";
            }

            string pname = "";
            pname = txt_pname.Value.ToString();

            string fname = "";
            fname = txt_fname.Value.ToString();

            string lname = "";
            lname = txt_lname.Value.ToString();

            string empid = "";
            empid = txt_empid.Value.ToString();

            string dept = "";
            dept = txt_dept.Value.ToString();

            sql = "select * from annualcheckup_book where year(book_adddate)=year(now()) and book_status = 'confirm' and book_empid = '" + empid + "' ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                alert = "Duplicate";
            }
            else
            {
                sql = "UPDATE annualcheckup_quota SET quota_qty=quota_qty+1 WHERE quota_id=" + Qid + ";";
                if (cl_Sql.Modify(sql))
                {
                    string emp_register = "Yes";
                    string quotaid = DD_Quota.SelectedValue.ToString();

                    sql = "UPDATE annualcheckup_emp " +
                        "SET emp_register = '" + emp_register + "', emp_quotaid = " + quotaid + " " +
                        "WHERE emp_year=year(now()) and emp_id = " + empid + "; ";
                    if (cl_Sql.Modify(sql))
                    {
                        sql = "INSERT INTO annualcheckup_book " +
                        "(book_adddate, book_sex, book_pname, book_fname, book_lname, book_empid, book_dept, book_quotaid, book_status) " +
                        "VALUES(current_timestamp(), '" + Sex + "', '" + pname + "', '" + fname + "', '" + lname + "', '" + empid + "', '" + dept + "', " + Qid + ", 'confirm'); ";
                        if (cl_Sql.Modify(sql))
                        {
                            sql = "select * from annualcheckup_book where year(book_adddate)=year(now()) and book_status='confirm' and book_empid='" + empid + "' and book_quotaid=" + Qid + "  ";
                            dt = new DataTable();
                            dt = cl_Sql.select(sql);
                            if (dt.Rows.Count > 0)
                            {
                                alert = dt.Rows[0]["book_id"].ToString();
                            }
                        }
                        else
                        {
                            sql = "UPDATE annualcheckup_emp " +
                            "SET emp_register = NULL, emp_quotaid = NULL " +
                            "WHERE emp_id = " + empid + " and emp_quotaid=" + Qid + "; ";
                            cl_Sql.Modify(sql);

                            sql = "UPDATE annualcheckup_quota SET quota_qty=quota_qty-1 WHERE quota_id=" + Qid + ";";
                            cl_Sql.Modify(sql);
                        }
                    }
                    else
                    {
                        sql = "UPDATE annualcheckup_quota SET quota_qty=quota_qty-1 WHERE quota_id=" + Qid + ";";
                        cl_Sql.Modify(sql);
                    }
                }
            }

            return alert;
        }

        protected void btn_cancel_Click(object sender, EventArgs e)
        {
            if (Session["Login"] == null)
            {
                Response.Write("<script>alert('ไม่สามารถยกเลิกได้ กรุณาติดต่อ HR !!'); window.location.href='AnnualCheckup.aspx';</script>");
            }
            else
            { 
                string cf = txt_cancel.Value.ToString();
                if (cf == "true")
                {
                    string empid = "";
                    empid = txt_empid.Value.ToString().Trim();
                    if (Cancel(empid))
                    {
                        Response.Write("<script>alert('ยกเลิกเรียบร้อยแล้วแล้ว !!'); window.location.href='AnnualCheckup.aspx';</script>");
                    }
                    else
                    {
                        Response.Write("<script>alert('รหัสพนักงานและเลขที่การจองของท่านไม่ถูกต้อง จึงไม่สามารถยกเลิกได้ !!'); window.location.href='AnnualCheckup.aspx';</script>");
                    }
                }
                else
                {
                    Response.Redirect("AnnualCheckup.aspx");
                }
            }
        }

        public Boolean Cancel(string empid)
        {
            Boolean bl = false;

            string bookid = "";
            string quotaid = "";

            bookid = txt_bookid.Value.ToString().Trim();

            sql = "select * from annualcheckup_book where year(book_adddate)=year(now()) and book_status='confirm' and book_empid='" + empid + "' and book_id=" + bookid + " ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                bookid = dt.Rows[0]["book_id"].ToString();
                quotaid = dt.Rows[0]["book_quotaid"].ToString();

                sql = "update annualcheckup_book set book_status='cancel' " +
                    "WHERE book_id = " + bookid + "; " +
                    "update annualcheckup_emp set emp_register = NULL, emp_quotaid = NULL " +
                    "WHERE emp_quotaid = " + quotaid + " and emp_id = '" + empid + "'; " +
                    "update annualcheckup_quota set quota_qty = quota_qty - 1 " +
                    "WHERE quota_id = " + quotaid + "; ";
                if (cl_Sql.Modify(sql))
                {
                    bl = true;
                }
            }

            return bl;
        }
    }
}