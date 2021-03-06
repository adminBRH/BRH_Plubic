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
    public partial class BookVaccinateReport : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Login"] != null)
            {
                string status = Session["status"].ToString();
                if (status == "admin" || status == "brh" || status == "srh")
                {
                    if (!IsPostBack)
                    {
                        Grid1("", "");
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

        protected void CLD_book_DayRender(object sender, DayRenderEventArgs e)
        {
            DateTime DateStart = DateTime.Parse("2020-05-11");
            DateTime DateEnd = DateTime.Parse("2020-07-15");

            //DateTime DateNow = DateTime.Parse(DateTime.Now.ToString("yyyy-MM-dd"));
            //if (DateNow > DateStart)
            //{
            //    DateStart = DateNow;
            //}

            if (e.Day.Date < DateStart || e.Day.Date > DateEnd)
            {
                e.Day.IsSelectable = false;
                e.Cell.ForeColor = System.Drawing.Color.LightGray;
                e.Cell.BackColor = System.Drawing.Color.WhiteSmoke;
            }
            else
            {
                if (e.Day.IsSelected)
                {
                    txtH_bookdate.Value = e.Day.Date.ToString("yyyy-MM-dd");
                }
                else
                {
                    e.Cell.BackColor = System.Drawing.Color.LightGray;
                }
            }

            string Progress1 = "<br /><span class='progress bg-secondary'> <span class='progress-bar bg-";
            string PColor = "";
            string Progress2 = "' role='progressbar' style='width: ";
            int Width = 0;
            string Progress3 = "%' aria-valuenow='";
            int Left = 0;
            string Progress4 = "' aria-valuemin='0' aria-valuemax='";
            int Max = 60; // <------------------------------------------------ MAX
            string Progress5 = "'>";
            string Progress6 = "</span></span>";

            string Progress = "";

            string Dates = e.Day.Date.ToString();

            string location = DD_location.SelectedValue;
            if (location == "")
            {
                Max = Max * 4;
                sql = "select convert(vb_bookdate,date) as 'vb_bookdate', count(1) as 'vb_cnt' " +
                    "from vaccinate_book " +
                    "group by convert(vb_bookdate, date) " +
                    "order by convert(vb_bookdate, date)";
            }
            else
            {
                sql = "select convert(vb_bookdate,date) as 'vb_bookdate', vb_location, count(1) as 'vb_cnt' " +
                    "from vaccinate_book where vb_location = '" + location + "' " +
                    "group by convert(vb_bookdate, date), vb_location " +
                    "order by convert(vb_bookdate, date), vb_location";
            }
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    string BookDate = dt.Rows[i]["vb_bookdate"].ToString();
                    int Qty = int.Parse(dt.Rows[i]["vb_cnt"].ToString());

                    if (Dates == BookDate)
                    {
                        //if (Qty == Max)
                        //{
                        //    e.Day.IsSelectable = false;
                        //    e.Cell.ForeColor = System.Drawing.Color.WhiteSmoke;
                        //}

                        Left = Max - Qty;
                        Width = (Max - Left) * 100 / Max;

                        if (Width < 15) { Width = 15; }
                        if (Width < 50) { PColor = "success"; } else if (Width < 80) { PColor = "warning"; } else { PColor = "danger"; }

                        Progress = Progress1 + PColor + Progress2 + Width.ToString() + Progress3 + Left + Progress4 + Max + Progress5 + Qty + Progress6;
                        e.Cell.Controls.Add(new LiteralControl(Progress));
                    }
                }
            }
        }

        protected void CLD_book_SelectionChanged(object sender, EventArgs e)
        {
            string Dates = CLD_book.SelectedDate.ToString("yyyy-MM-dd");
            string location = DD_location.SelectedValue;
            Grid1(Dates, location);
        }

        public Boolean Grid1(string Dates, string location)
        {
            Boolean bl = false;

            sql = "select * ,concat(vb_pname,' ',vb_fname,' ',vb_lname) as 'FullName' " +
                ",if (vb_comeby = 'Drive thru',concat('Drive thru (', vb_carbrand, ' ทะเบียน ', vb_carnumber, ')'),vb_comeby) as 'vb_ComeHow' " +
                "from vaccinate_book " +
                "where vb_bookdate like '%" + Dates + "%' and vb_location like '%" + location + "%' " +
                "order by vb_bookdate,vb_id ";
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
            Response.AddHeader("content-disposition", "attachment;filename=BRH_BookVaccinate_" + year + ".xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel";
            using (StringWriter sw = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(sw);

                //To Export all pages
                GridView1.AllowPaging = false;

                string Dates = txtH_bookdate.Value;
                string location = DD_location.SelectedValue;
                Grid1(Dates, location);

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

        protected void DD_location_SelectedIndexChanged(object sender, EventArgs e)
        {
            string Dates = txtH_bookdate.Value;
            string location = DD_location.SelectedValue;
            Grid1(Dates, location);
        }
    }
}