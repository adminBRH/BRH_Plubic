using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;

namespace BRH_Plubic.Evaluate360
{
    public partial class Default : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string YE = YearEvaluate();
                if (YE == "")
                {
                    div_evaluate.Visible = true;
                    ClearData();
                }
                else
                {
                    lbl_CallModal.Text = "<script> " +
                        "alertModalWarning('#Modal_Warning','" + YE + "'); " +
                        "</script>";
                }
            }
        }

        public string YearEvaluate()
        {
            string result = "";

            sql = "select * from evaluate360_due where ed_active = 'yes' " +
                //"and (ed_startdate <= convert(current_timestamp,date) and ed_enddate >= convert(current_timestamp,date)); ";
                "and convert(ed_enddate,date)>=CURRENT_DATE \norder by ed_id";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                string year = dt.Rows[0]["ed_enddate"].ToString();
                lbl_year.Text = (DateTime.Parse(year).Year).ToString();

                DateTime stDate = DateTime.Parse(dt.Rows[0]["ed_startdate"].ToString());
                DateTime enDate = DateTime.Parse(dt.Rows[0]["ed_enddate"].ToString());

                DateTime nowDate = DateTime.Now.Date;
                if (nowDate < stDate || nowDate > enDate)
                {
                    result = "ระบบจะเปิดให้ใช้งานในวันที่ ";
                    result = result + stDate.Day.ToString() + " " + stDate.ToString("MMM") + " " + stDate.Year.ToString();// + " 00:00:00";
                    result = result + " ถึง ";
                    result = result + enDate.Day.ToString() + " " + enDate.ToString("MMM") + " " + enDate.Year.ToString();// + " 23:59:59";
                }
            }
            else
            {
                result = "ยังไม่มีการประเมินที่จะเปิดให้ใช้งานในเร็วๆนี้ !!";
            }

            return result;
        }

        public Boolean Department(string status)
        {
            Boolean bl = false;

            sql = "select '' as 'eu_deptid','Please Select' as 'eu_deptname' union " +
                "select eu_deptid, eu_deptname from evaluate360_user where eu_status = '" + status + "' " +
                "group by eu_deptid, eu_deptname order by eu_deptid ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                
            }
            DD_Department.DataSource = dt;
            DD_Department.DataTextField = "eu_deptname";
            DD_Department.DataValueField = "eu_deptid";
            DD_Department.DataBind();

            return bl;
        }

        public Boolean Name(string status, string dept)
        {
            Boolean bl = false;

            sql = "select '' as 'eu_empid','Please Select' as 'eu_name' union " +
                "select eu_empid,eu_name from evaluate360_user where eu_status = '" + status + "' and eu_deptid = '" + dept + "' order by eu_empid ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {

            }
            DD_name.DataSource = dt;
            DD_name.DataTextField = "eu_name";
            DD_name.DataValueField = "eu_empid";
            DD_name.DataBind();

            return bl;
        }

        protected void DD_mode_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DD_mode.SelectedValue.ToString() == "")
            {
                div_dept.Visible = false;
            }
            else
            {
                div_dept.Visible = true;

                txtH_mode.Value = "1";
                string status = "";
                if (DD_mode.SelectedValue.ToString() == "EMPLOYEE LEVEL")
                {
                    status = "staff";
                }
                else
                {
                    if (DD_mode.SelectedValue.ToString() == "EMPLOYEE LEVEL (for chief assessment)")
                    {
                        txtH_mode.Value = "2";
                    }
                    status = "chief";
                }
                txtH_status.Value = status;

                Department(status);
            }
        }

        protected void DD_Department_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DD_Department.SelectedValue.ToString() != "")
            {
                string status = txtH_status.Value.ToString();
                string dept = DD_Department.SelectedValue.ToString();

                Name(status, dept);
            }
        }

        public Boolean ClearData()
        {
            Boolean bl = true;

            div_1.Visible = false;
            div_2.Visible = false;
            div_3.Visible = false;
            div_4.Visible = false;
            div_5.Visible = false;
            div_6.Visible = false;
            div_7.Visible = false;
            div_8.Visible = false;
            div_9.Visible = false;
            div_remark.Visible = false;
            //div_submit.Visible = false;

            RDB_1.SelectedValue = "3";
            RDB_2.SelectedValue = "3";
            RDB_3.SelectedValue = "3";
            RDB_4.SelectedValue = "3";
            RDB_5.SelectedValue = "3";
            RDB_6.SelectedValue = "3";
            RDB_7.SelectedValue = "3";
            RDB_8.SelectedValue = "3";
            RDB_9.SelectedValue = "3";

            return bl;

        }

        protected void DD_name_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DD_name.SelectedValue.ToString() != "" && DD_Department.SelectedValue.ToString() != "")
            {
                string mode = txtH_mode.Value.ToString();

                div_1.Visible = true;
                div_2.Visible = true;
                div_3.Visible = true;
                div_4.Visible = true;
                div_5.Visible = true;
                div_6.Visible = true;
                div_7.Visible = true;

                RDB_1.SelectedValue = "3";
                RDB_2.SelectedValue = "3";
                RDB_3.SelectedValue = "3";
                RDB_4.SelectedValue = "3";
                RDB_5.SelectedValue = "3";
                RDB_6.SelectedValue = "3";
                RDB_7.SelectedValue = "3";
                
                if (mode == "1")
                {
                    lbl_1_1.Visible = true;
                    lbl_1_2.Visible = true;
                    lbl_1_3.Visible = true;
                    lbl_1_4.Visible = true;
                    lbl_1_5.Visible = true;
                    lbl_1_6.Visible = true;
                    lbl_1_7.Visible = true;
                    lbl_1_rm.Visible = true;

                    lbl_2_1.Visible = false;
                    lbl_2_2.Visible = false;
                    lbl_2_3.Visible = false;
                    lbl_2_4.Visible = false;
                    lbl_2_5.Visible = false;
                    lbl_2_6.Visible = false;
                    lbl_2_7.Visible = false;
                    div_8.Visible = false;
                    div_9.Visible = false;
                    lbl_2_rm.Visible = false;
                }

                if (mode == "2")
                {
                    lbl_2_1.Visible = true;
                    lbl_2_2.Visible = true;
                    lbl_2_3.Visible = true;
                    lbl_2_4.Visible = true;
                    lbl_2_5.Visible = true;
                    lbl_2_6.Visible = true;
                    lbl_2_7.Visible = true;
                    div_8.Visible = true;
                    div_9.Visible = true;
                    lbl_2_rm.Visible = true;

                    lbl_1_1.Visible = false;
                    lbl_1_2.Visible = false;
                    lbl_1_3.Visible = false;
                    lbl_1_4.Visible = false;
                    lbl_1_5.Visible = false;
                    lbl_1_6.Visible = false;
                    lbl_1_7.Visible = false;
                    lbl_1_rm.Visible = false;

                    RDB_8.SelectedValue = "3";
                    RDB_9.SelectedValue = "3";
                }

                div_remark.Visible = true;
                //div_submit.Visible = true;
            }
        }

        protected void btn_submit_ServerClick(object sender, EventArgs e)
        {
            if (DD_name.SelectedValue.ToString() != "" && DD_Department.SelectedValue.ToString() != "")
            {
                string result = InsertData();
                if (result == "success")
                {
                    lbl_CallModal.Text = "<script> alertModal('#Modal_Success'); </script>";
                }
                else
                {
                    if (result == "soon")
                    {
                        lbl_CallModal.Text = "<script> " +
                                "alertModalWarning('#Modal_Warning','ไม่ได้อยู่ในช่วงเปิดให้ทำการประเมิน !!'); " +
                                "</script>";
                    }
                    else
                    {
                        lbl_CallModal.Text = "<script> " +
                                "alertModalWarning('#Modal_Warning',''ไม่สามารถบันทึกข้อมูลได้ กรุณาติดต่อผู้ดูแลระบบ !!'); " +
                                "</script>";
                    }
                }
            }
            else
            {
                lbl_CallModal.Text = "<script> " +
                        "alertModalInfo('#alertModalInfo',''กรุณาเลือกและกรอกข้อมูลให้ครบ !!'); " +
                        "</script>";
            }
        }

        public string InsertData()
        {
            string bl = "";

            string Topic_1 = RDB_1.SelectedValue.ToString();
            string Topic_2 = RDB_2.SelectedValue.ToString();
            string Topic_3 = RDB_3.SelectedValue.ToString();
            string Topic_4 = RDB_4.SelectedValue.ToString();
            string Topic_5 = RDB_5.SelectedValue.ToString();
            string Topic_6 = RDB_6.SelectedValue.ToString();
            string Topic_7 = RDB_7.SelectedValue.ToString();
            string mode = txtH_mode.Value.ToString();
            string Topic_8 = "NULL";
            string Topic_9 = "NULL";
            if (mode == "2")
            {
                Topic_8 = RDB_8.SelectedValue.ToString();
                Topic_9 = RDB_9.SelectedValue.ToString();
            }
            string remark = txt_remark.Value.ToString().Trim();

            string modeName = "";
            string dueid = "";
            string empid = "";
            string name = "";
            string deptid = "";
            string deptname = "";
            string eustatus = "";

            sql = "select * from evaluate360_due where ed_active = 'yes' and (ed_startdate <= convert(current_timestamp,date) and ed_enddate >= convert(current_timestamp,date)) ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                modeName = DD_mode.SelectedItem.Text;
                dueid = dt.Rows[0]["ed_id"].ToString();
                empid = DD_name.SelectedValue.ToString();
                name = DD_name.SelectedItem.Text;
                deptid = DD_Department.SelectedValue.ToString();
                deptname = DD_Department.SelectedItem.Text;
                eustatus = txtH_status.Value.ToString();

                bl = "insert";
            }
            else
            {
                bl = "soon";
            }

            if (bl == "insert")
            {
                sql = "INSERT INTO evaluate360 " +
                    "\n(ev_edid, ev_empid, ev_name, ev_deptid, ev_deptname, ev_mode, ev_eustatus, ev_adddate, ev_status, ev_topic1, ev_topic2, ev_topic3, ev_topic4, ev_topic5, ev_topic6, ev_topic7, ev_topic8, ev_topic9, ev_remark) " +
                    "\nVALUES(" + dueid + ", '" + empid + "', '" + name + "', '" + deptid + "', '" + deptname + "', '" + modeName + "', '" + eustatus + "', current_timestamp(), 'yes', " + Topic_1 + ", " + Topic_2 + ", " + Topic_3 + ", " + Topic_4 + ", " + Topic_5 + ", " + Topic_6 + ", " + Topic_7 + ", " + Topic_8 + ", " + Topic_9 + ", '" + remark + "');";
                if (cl_Sql.Modify(sql))
                {
                    bl = "success";
                }
                else
                {
                    bl = "fail";
                }
            }

            return bl;
        }
    }
}