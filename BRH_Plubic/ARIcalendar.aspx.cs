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
    public partial class ARIcalendar : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        string SelectDates = "";

        string type = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            //Session["ARIType"] = "Adult"; // <------ For Test
            //Session["ARIKEy"] = "1234654674"; // <-- For Test

            if (Session["ARIType"] == null || Session["ARIKEy"] == null)
            {
                Response.Redirect("ARIclinic.aspx");
            }
            else
            {
                if (!IsPostBack)
                {
                    DateTime DateX = DateTime.Now.Date;
                    Times(DateX);

                    txtH_date.Value = CLD_book.TodaysDate.Year.ToString() + '-' + CLD_book.TodaysDate.Month.ToString() + '-' + CLD_book.TodaysDate.Day.ToString();

                }
            }
        }

        public Boolean Times(DateTime DateX)
        {
            Boolean bl = false;

            type = Session["ARIType"].ToString();
            if (type == "Child") { type = "child"; } else { type = "adult"; }

            string bookdate = DateX.ToString("yyyy-MM-dd");

            sql = "select a.at_id,a.at_times from ( " +
                "\n    select b.*, concat(at_time_start, ' to ', at_time_end) as 'at_times' " +
                "\n    from ari_time as b " +
                "\n    where at_active = 'Yes' ";

            if (bookdate == DateTime.Now.ToString("yyyy-MM-dd"))
            {
                sql = sql + "\n    and convert(at_time_start,time) > convert(current_timestamp + INTERVAL 20 MINUTE,time) ";
            }

            sql = sql + "\n) as a " +
                "\nleft join( " +
                "\n    select a.ab_bookdate, a.ab_at_id,a.ab_type, count(1) as 'ab_cnt' " +
                "\n    from ari_book as a " +
                "\n    where a.ab_bookdate = '" + bookdate + "' " +
                "\n    group by a.ab_bookdate,a.ab_at_id,a.ab_type " +
                "\n) as b on a.at_id = b.ab_at_id and a.at_" + type + " = b.ab_cnt " +
                "\nwhere b.ab_bookdate is null ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                DD_Times.DataSource = dt;
                DD_Times.DataTextField = "at_times";
                DD_Times.DataValueField = "at_id";
                DD_Times.DataBind();

                bl = true;
            }

            return bl;
        }

        protected void CLD_book_SelectionChanged(object sender, EventArgs e)
        {
            Times(CLD_book.SelectedDate);
            txtH_date.Value = CLD_book.SelectedDate.Year.ToString() + '-' + CLD_book.SelectedDate.Month.ToString() + '-' + CLD_book.SelectedDate.Day.ToString();
        }

        protected void CLD_book_DayRender(object sender, DayRenderEventArgs e)
        {
            string Days = e.Day.Date.Day.ToString();
            string months = e.Day.Date.Month.ToString();
            string years = e.Day.Date.Year.ToString();
            string Dates = e.Day.Date.ToString(); //years + '-' + months + '-' + Days;

            DateTime ToDay = DateTime.Now;
            if (e.Day.IsToday) {
                ToDay = e.Day.Date;
            }

            DateTime OtherDay = e.Day.Date;

            if (OtherDay < ToDay)
            {
                e.Day.IsSelectable = false;
                e.Cell.ForeColor = System.Drawing.Color.DarkGray;
            }

            type = Session["ARIType"].ToString();

            sql = "select convert(ab_bookdate,date) as 'ab_bookdate', count(1) as 'ab_cnt' from ari_book " +
                "where convert(ab_bookdate, date) >= convert(current_timestamp(), date) and ab_type = '" + type + "' " +
                "group by convert(ab_bookdate,date) " +
                "order by convert(ab_bookdate, date) ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                string Progress1 = "<br /><span class='progress bg-secondary'> <span class='progress-bar bg-";
                string PColor = "";
                string Progress2 = "' role='progressbar' style='width: ";
                int Width = 0;
                string Progress3 = "%' aria-valuenow='";
                int Left = 0;
                string Progress4 = "' aria-valuemin='0' aria-valuemax='";
                int Max = 0;
                string Progress5 = "'>";
                string Progress6 = "</span></span>";

                string Progress = "";

                if (type == "Child") { Max = 36; } else { Max = 69; }

                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    string BookDate = dt.Rows[i]["ab_bookdate"].ToString();
                    int Qty = int.Parse(dt.Rows[i]["ab_cnt"].ToString());

                    if (Dates == BookDate)
                    {
                        Left = Max - Qty;
                        Width = (Max - Left) * 100 / Max;

                        if (Width < 15) { Width = 15; }
                        if (Width < 50) { PColor = "success"; } else if (Width < 80) { PColor = "warning"; } else { PColor = "danger"; }

                        Progress = Progress1 + PColor + Progress2 + Width.ToString() + Progress3 + Left + Progress4 + Max + Progress5 + Left + Progress6;

                        e.Cell.Controls.Add(new LiteralControl(Progress));
                    }
                }
            }
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            if (UpdateTimes())
            {
                Response.Redirect("ARIResult.aspx");
            }
            else
            {
                Response.Write("<script>alert('ระบบขัดข้องไม่สามารถบันทึกข้อมูลได้ กรุณาติดต่อผู้ดูแลระบบ !!');</script>");
            }
        }

        public Boolean UpdateTimes()
        {
            Boolean bl = false;

            string key = Session["ARIKEy"].ToString();

            string ab_id = "";

            sql = "select * from ari_book where convert(ab_adddate,date) = convert(current_timestamp(),date) and ab_cardnum = '" + key + "' order by ab_adddate desc ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                ab_id = dt.Rows[0]["ab_id"].ToString();

                SelectDates = txtH_date.Value;
                string timesID = DD_Times.SelectedValue.ToString();
                
                sql = "update ari_book set ab_bookdate = '" + SelectDates + "', ab_at_id = '" + timesID + "' where ab_id = '" + ab_id + "' ";
                if (cl_Sql.Modify(sql))
                {
                    Session.Remove("ARIType");
                    Session.Remove("ARIKEy");

                    sql = "select * from ari_time where at_id = '" + timesID + "' ";
                    dt = new DataTable();
                    dt = cl_Sql.select(sql);
                    if (dt.Rows.Count > 0)
                    {
                        Session["ARIfinish"] = DateTime.Parse(SelectDates).ToString("dd/MM/yyyy") + "|" + dt.Rows[0]["at_time_start"].ToString() + " ถึง " + dt.Rows[0]["at_time_end"].ToString();
                    }
                    bl = true;
                }
            }

            return bl;
        }

    }
}