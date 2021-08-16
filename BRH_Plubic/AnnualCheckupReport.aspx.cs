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
    public partial class AnnualCheckupReport : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Login"] != null)
            {
                string status = Session["status"].ToString();
                if (status == "admin" || status == "brh")
                {
                    if (Session["Login"].ToString() == "Yes")
                    {
                        if (!IsPostBack)
                        {
                            Grid1("ALL", "");
                        }
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

        protected void btn_search_ServerClick(object sender, EventArgs e)
        {
            string field = DD_field.SelectedValue.ToString();
            string text = txt_search.Value.ToString().Trim();
            Grid1(field, text);

            txtH_field.Value = field;
            txtH_search.Value = text;
        }

        public Boolean Grid1(string field, string text)
        {
            Boolean bl = false;
            string search = "";

            if (field == "ALL")
            { }
            else
            {
                if (field == "FullName")
                {
                    search = "where (a.book_pname like '%" + text + "%' or a.book_fname like '%" + text + "%' or a.book_lname like '%" + text + "%') ";
                }
                else
                {
                    search = "where a." + field + " like '%" + text + "%' ";
                }
            }

            sql = "Select * from ( " +
                "select b.*, concat(b.book_pname,' ',b.book_fname,' ',b.book_lname) as 'FullName', ifnull(e.emp_register,'No') as 'emp_register', q.quota_date " +
                "from annualcheckup_emp as e " +
                "left join annualcheckup_book as b on b.book_empid = e.emp_id " +
                "left join annualcheckup_quota as q on b.book_quotaid = q.quota_id " +
                "where e.emp_year = year(now()) and year(b.book_adddate)= year(now()) and year(q.quota_date)= year(now()) " +
                ") a " + search + "; ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            GridView1.DataSource = dt;
            GridView1.DataBind();

            if (GridView1.PageCount > 0)
            {
                bl = true;
            }
            else
            {
                bl = false;
            }

            return bl;
        }

        protected void btnExport_Click(object sender, EventArgs e)
        {
            string year = "";
            year = DateTime.Now.ToString("yyyy");

            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=BRH_Annual_Checkup_" + year + ".xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel";
            using (StringWriter sw = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(sw);

                //To Export all pages
                GridView1.AllowPaging = false;

                string field = txtH_field.Value.ToString();
                if (field == "") { field = "ALL"; }
                string text = txtH_search.Value.ToString();
                this.Grid1(field, text);

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

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            string field = txtH_field.Value.ToString();
            if (field == "") { field = "ALL"; }
            string text = txtH_search.Value.ToString();

            GridView1.PageIndex = e.NewPageIndex;
            Grid1(field, text);
        }
    }
}