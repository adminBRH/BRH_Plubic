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

namespace BRH_Plubic.Evaluate360
{
    public partial class Report : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Login"] == null)
            {
                Response.Write("<script>alert('ไม่มีสิทธิ์ใช้งานกรุณา Login !!'); window.location.href='Default.aspx';</script>");
            }
            else
            {
                string status = Session["status"].ToString();
                if (status == "admin" || status == "hr")
                {
                    if (!IsPostBack)
                    {
                        string Due = DueID();
                        SelectDate(Due);
                        sql = "select convert(max(ev_adddate),date) as 'ev_date' from evaluate360 where ev_edid = '" + Due + "' ";
                        dt = new DataTable();
                        dt = cl_Sql.select(sql);
                        if (dt.Rows.Count > 0)
                        {
                            Grid1(Due, dt.Rows[0]["ev_date"].ToString());
                        }
                    }
                }
                else
                {
                    Response.Write("<script>alert('คุณไม่มีสิทธิ์ใช้งานหน้านี้ !!'); window.location.href='Default.aspx';</script>");
                }

            }
        }

        public string DueID()
        {
            string ID = "";

            sql = "select max(ed_id) as 'ed_id' from evaluate360_due where ed_active='yes' ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                ID = dt.Rows[0]["ed_id"].ToString();
            }

            return ID;
        }

        public Boolean SelectDate(string DueID)
        {
            Boolean bl = false;

            sql = "Select * from ( " +
                "select '' as 'ev_date','ALL' as 'ev_text' union "+
                "select convert(ev_adddate, date) as 'ev_date',convert(ev_adddate, date) as 'ev_text' " +
                "from evaluate360 where ev_edid = '" + DueID + "' group by convert(ev_adddate, date)" +
                ") as a order by ev_date desc ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                DD_date.DataSource = dt;
                DD_date.DataTextField = "ev_text";
                DD_date.DataValueField = "ev_date";
                DD_date.DataBind();
                bl = true;
            }

            return bl;
        }

        public Boolean Grid1(string DueID, string DateVal)
        {
            Boolean bl = false;

            if (DateVal != "")
            {
                DateVal = DateTime.Parse(DateVal).ToString("yyyy-MM-dd");
            }

            sql = "select * from evaluate360 where ev_status='yes' and ev_edid = '" + DueID + "' and ev_adddate like '%" + DateVal + "%' ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                bl = true;
            }
            else
            {

            }
            GridView1.DataSource = dt;
            GridView1.DataBind();

            return bl;
        }

        protected void DD_date_SelectedIndexChanged(object sender, EventArgs e)
        {
            string DateVal = DD_date.SelectedValue.ToString();
            if (DateVal != "")
            {
                DateVal = DateTime.Parse(DD_date.SelectedValue.ToString()).ToString("yyyy-MM-dd");
            }
            Grid1(DueID(), DateVal);
        }

        protected void btnExport_Click(object sender, EventArgs e)
        {

            string header_lb = "Report การประเมิน 360 องศา";
            string year = "";
            year = DateTime.Now.ToString("yyyyMMdd");

            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=BRH_Evaluate360_" + year + ".xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel";
            using (StringWriter sw = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(sw);

                //To Export all pages
                GridView1.AllowPaging = false;

                string Due = DueID();
                string DateVal = DD_date.SelectedValue.ToString();
                if (DateVal != "")
                {
                    DateVal = DateTime.Parse(DD_date.SelectedValue.ToString()).ToString("yyyy-MM-dd");
                }
                Grid1(Due, DateVal);

                Response.Write("<h1>" + header_lb + "</h1>");
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