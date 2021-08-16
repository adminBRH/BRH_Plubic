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
    public partial class SelfScreeningReport : System.Web.UI.Page
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
                            Grid1("", "");
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

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            Search();
        }

        protected void DD_Field_SelectedIndexChanged(object sender, EventArgs e)
        {
            div_txt_search.Visible = false;
            div_dt_search.Visible = false;
            div_rd_search.Visible = false;

            string field = DD_Field.SelectedValue.ToString();
            if (field != "")
            {
                if (field == "ss_staff" || field == "ss_selffever" || field == "ss_cityrisk")
                {
                    div_rd_search.Visible = true;
                }
                else if (field == "ss_datetime")
                {
                    div_dt_search.Visible = true;
                }
                else
                {
                    div_txt_search.Visible = true;
                }
            }
            txtH_field.Value = DD_Field.SelectedValue.ToString();
        }

        protected void btn_search_Click(object sender, EventArgs e)
        {
            Search();
        }

        public Boolean Search()
        {
            Boolean bl = false;

            string field = txtH_field.Value.ToString();
            string search = "";
            if (field == "ss_staff" || field == "ss_selffever" || field == "ss_cityrisk")
            {
                string rd_val = "";
                if (rd_search_1.Checked)
                {
                    rd_val = rd_search_1.Value;
                }
                else
                {
                    rd_val = rd_search_2.Value;
                }
                search = rd_val;
            }
            else if (field == "ss_datetime")
            {
                search = dt_search.Value.ToString();
            }
            else
            {
                search = txt_search.Value.ToString();
            }

            Grid1(field, search);

            return bl;
        }

        public Boolean Grid1(string field, string search)
        {
            Boolean bl = false;

            
            sql = "select a.*,e.emp_deptid,e.emp_deptdesc from selfscreen_data a " +
                "left join employee as e on e.emp_id = a.ss_staffid ";
            if (field != "")
            {
                if (field == "ss_id" || field == "ss_score")
                {
                    sql = sql + "where " + field + " like '" + search + "' ";
                }
                else
                {
                    sql = sql + "where " + field + " like '%" + search + "%' ";
                }
            }
            sql = sql + "Order by ss_id desc ";

            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
            else
            {
                GridView1.DataBind();
            }

            return bl;
        }

        protected void btnExport_Click(object sender, EventArgs e)
        {
            string Dates = "";
            Dates = DateTime.Now.ToString("yyyy_MM_dd");

            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=BRH_SelfScreening_" + Dates + ".xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel";
            using (StringWriter sw = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(sw);

                //To Export all pages
                GridView1.AllowPaging = false;
                this.Search();

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