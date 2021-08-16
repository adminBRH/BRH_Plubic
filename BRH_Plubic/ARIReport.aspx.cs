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

namespace BRH_Plubic
{
    public partial class ARIReport : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        string SelectDates = "";

        string type = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Login"] != null)
            {
                string status = Session["status"].ToString();
                if (status == "admin" || status == "brh")
                {
                    if (!IsPostBack)
                    {
                        Grid1("","");
                    }
                }
                else
                {
                    Response.Write("<script>alert('คุณไม่มีสิทธิ์ใช้งานหน้านี้ !!'); window.location.href='Default.aspx';</script>");
                }
            }
            else
            {
                Response.Write("<script>alert('กรุณา Login ก่อนเข้าใช้งาน !!'); window.location.href='Default.aspx';</script>");
            }
        }

        protected void DD_type_SelectedIndexChanged(object sender, EventArgs e)
        {
            string BookDate = txtH_bookdate.Value;
            type = DD_type.SelectedValue;
            txtH_type.Value = type;

            Grid1(BookDate, type);
        }

        protected void CLD_book_DayRender(object sender, DayRenderEventArgs e)
        {
            string Days = e.Day.Date.Day.ToString();
            string months = e.Day.Date.Month.ToString();
            string years = e.Day.Date.Year.ToString();
            string Dates = e.Day.Date.ToString(); //years + '-' + months + '-' + Days;

            DateTime ToDay = DateTime.Now;
            if (e.Day.IsToday)
            {
                ToDay = e.Day.Date;
            }

            DateTime OtherDay = e.Day.Date;

            //if (OtherDay < ToDay)
            //{
            //    e.Day.IsSelectable = false;
            //    e.Cell.ForeColor = System.Drawing.Color.DarkGray;
            //}

            if (txtH_type.Value != "")
            {
                type = txtH_type.Value;
            }

            sql = "select convert(ab_bookdate,date) as 'ab_bookdate', count(1) as 'ab_cnt' from ari_book " +
                "where convert(ab_bookdate, date) >= convert(current_timestamp(), date) and ab_type like '%" + type + "%' " +
                "group by convert(ab_bookdate,date) " +
                "order by convert(ab_bookdate, date) ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                string Progress1 = "<br /><span class='progress bg-secondary' style='height: 30px'> <span class='progress-bar bg-";
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

                if (type == "Child") { Max = 36; } else if (type == "Adult") { Max = 69; } else { Max = 69 + 36; }

                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    string BookDate = dt.Rows[i]["ab_bookdate"].ToString();
                    int Qty = int.Parse(dt.Rows[i]["ab_cnt"].ToString());

                    if (Dates == BookDate)
                    {
                        Left = Max - Qty;
                        Width = (Max - Left) * 100 / Max;

                        if (Width < 15) { Width = 15; }
                        if (Width < 50) { PColor = "danger"; } else if (Width < 80) { PColor = "warning"; } else { PColor = "success"; }

                        Progress = Progress1 + PColor + Progress2 + Width.ToString() + Progress3 + Left + Progress4 + Max + Progress5 + Qty + Progress6;

                        e.Cell.Controls.Add(new LiteralControl(Progress));
                    }
                }
            }
        }

        protected void CLD_book_SelectionChanged(object sender, EventArgs e)
        {
            string BookDate = CLD_book.SelectedDate.ToString("yyyy-MM-dd");
            txtH_bookdate.Value = BookDate;
            type = txtH_type.Value;

            Grid1(BookDate, type);
        }

        public Boolean Grid1(string BD, string TP)
        {
            Boolean bl = false;

            string BookDate = txtH_bookdate.Value;

            sql = "select a.*,concat(a.ab_pname,' ',a.ab_fname,' ',a.ab_lname) as 'ab_name' " +
                ",concat(b.at_time_start,' to ',b.at_time_end) as 'ab_times' " +
                "from ari_book as a " +
                "left join ari_time as b on b.at_id = a.ab_at_id " +
                "where ab_bookdate like '%" + BookDate + "%' and ab_type like '%" + TP + "%' ";
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

        protected void btnExport_Click(object sender, EventArgs e)
        {
            string year = "";
            year = DateTime.Now.ToString("yyyyMMdd");

            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=BRH_ARI_" + year + ".xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel";
            using (StringWriter sw = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(sw);

                //To Export all pages
                GridView1.AllowPaging = false;

                string Dates = txtH_bookdate.Value;
                type = txtH_type.Value;
                Grid1(Dates, type);

                GridView1.HeaderRow.BackColor = Color.White;
                foreach (TableCell cell in GridView1.HeaderRow.Cells)
                {
                    cell.BackColor = GridView1.HeaderStyle.BackColor;
                }
                foreach (GridViewRow row in GridView1.Rows)
                {
                    row.BackColor = Color.White;
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