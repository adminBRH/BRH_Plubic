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

namespace BRH_Plubic.DentalBook
{
    public partial class Default : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Calendar1_DayRender(object sender, DayRenderEventArgs e)
        {
            string Days = e.Day.Date.DayOfWeek.ToString();
            //Response.Write("<script>alert('" + Days + "');</script>");

            DateTime DateNow = DateTime.Parse(DateTime.Now.ToString("yyyy-MM-dd"));
            DateTime DateEnd = DateTime.Parse("2020-11-30");
            if (e.Day.Date < DateNow || e.Day.Date > DateEnd)
            {
                e.Day.IsSelectable = false;
                e.Cell.ForeColor = Color.LightGray;
                e.Cell.BackColor = Color.WhiteSmoke;
            }

            if (Days == "Wednesday" || Days == "Thursday" || Days == "Friday")
            { }
            else
            {
                e.Day.IsSelectable = false;
                e.Cell.ForeColor = Color.LightGray;
                e.Cell.BackColor = Color.WhiteSmoke;
            }
        }

        protected void Calendar1_SelectionChanged(object sender, EventArgs e)
        {
            string Days = Calendar1.SelectedDate.Date.ToString("yyyy-MM-dd");
            //Response.Write("<script>alert('" + Days + "');</script>");

            sql = "select * from dentalbooking where de_bookdate like '%" + Days + "%' ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    string slot = dt.Rows[i]["de_bookslot"].ToString();
                    switch (slot)
                    {
                        case "1":
                            Dentist1_1.Visible = false;
                            txtH_time1.Value = "2";
                            break;
                        case "2":
                            Dentist1_2.Visible = false;
                            txtH_time1.Value = "3";
                            break;
                        case "3":
                            Dentist1_3.Visible = false;
                            CB_Time1.Disabled = true;
                            break;
                        case "4":
                            Dentist2_1.Visible = false;
                            txtH_time2.Value = "5";
                            break;
                        case "5":
                            Dentist2_2.Visible = false;
                            txtH_time2.Value = "6";
                            break;
                        case "6":
                            Dentist2_3.Visible = false;
                            CB_Time2.Disabled = true;
                            break;
                        default:
                            txtH_time1.Value = "1";
                            txtH_time2.Value = "4";
                            break;
                    }
                }
            }
            else
            {
                txtH_time1.Value = "1";
                txtH_time2.Value = "4";
                Dentist1_1.Visible = true;
                Dentist1_2.Visible = true;
                Dentist1_3.Visible = true;
                Dentist2_1.Visible = true;
                Dentist2_2.Visible = true;
                Dentist2_3.Visible = true;
            }
        }

        public string CheckEmp(string empid)
        {
            string result = "";

            sql = "select * from employee where emp_id = '" + empid + "' ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                sql = "select * from dentalbooking where de_empid = '" + empid + "' and de_status = 'confirm' and year(de_adddate) = year(current_timestamp()) ";
                dt = new DataTable();
                dt = cl_Sql.select(sql);
                if (dt.Rows.Count > 0)
                {
                    result = "คุณได้ทำการจองไว้แล้ว ไม่สามารถจองซ้ำได้ !!";
                }
                else
                {
                    result = "Yes";
                }
            }
            else
            {
                result = "ไม่มีรหัสพนักงานนี้ในระบบ !!";
            }

            return result;
        }

        public Boolean CheckDate()
        {
            Boolean bl = false;

            if (Calendar1.SelectedDate.Date.ToShortDateString() != "")
            {
                bl = true;
            }

            return bl;
        }

        public string SlotTime()
        {
            string result = "";

            if (CB_Time1.Checked)
            {
                result = txtH_time1.Value.ToString();
            }
            if (CB_Time2.Checked)
            {
                result = txtH_time2.Value.ToString();
            }

            return result;
        }

        public string Insert(string empid)
        {
            string result = "";

            string bookdate = Calendar1.SelectedDate.Date.ToString("yyyy-MM-dd") + " " + txtH_selectTime.Value.ToString();
            string slot = SlotTime();

            sql = "INSERT INTO dentalbooking " +
               "(de_adddate, de_empid, de_bookdate, de_bookslot, de_status, de_come, de_comedate) " +
               "VALUES(current_timestamp(), '" + empid + "', '" + bookdate + "', '" + slot + "', 'confirm', 'no', NULL); ";
            if (cl_Sql.Modify(sql))
            {
                result = "Yes";
            }

            return result;
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {

            string empid = txt_empid.Value.ToString().Trim();
            string empResult = CheckEmp(empid);
            if (empResult == "Yes")
            {
                if (CheckDate())
                {
                    if (SlotTime() != "")
                    {
                        string InsertResult = Insert(empid);
                        if (InsertResult == "Yes")
                        {
                            Response.Write("<script>alert('บันทึกข้อมูลการจองเรียบร้อยแล้ว ^_^'); window.location.href='Default.aspx';</script>");
                        }
                        else
                        {
                            Response.Write("<script>alert('ไม่สามารถบันทึกข้อมูลการจองได้ กรุณาติดต่อ Admin !!');</script>");
                        }
                    }
                    else
                    {
                        Response.Write("<script>alert('กรุณาเลือกช่วงเวลา !!');</script>");
                    }
                }
                else
                {
                    Response.Write("<script>alert('กรุณาเลือกวันที่ !!');</script>");
                }
            }
            else
            {
                Response.Write("<script>alert('" + empResult + "');</script>");
            }
        }
    }
}