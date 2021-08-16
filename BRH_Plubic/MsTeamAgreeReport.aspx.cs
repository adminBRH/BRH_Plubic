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
    public partial class MsTeamAgreeReport : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Login"] == null)
            {
                Response.Write("<script>alert('ไม่มีสิทธิ์ใช้งานกรุณา Login !!'); window.location.href='../Default.aspx';</script>");
            }
            else
            {
                string status = Session["status"].ToString();
                if (status == "admin" || status == "brh")
                {
                    if (!IsPostBack)
                    {
                        Session["MsTeamAgree"] = "Print";
                        Grid1();
                    }
                }
                else
                {
                    Response.Write("<script>alert('คุณไม่มีสิทธิ์ใช้งานหน้านี้ !!'); window.location.href='../Default.aspx';</script>");
                }
                
            }
        }

        public Boolean Grid1()
        {
            Boolean bl = false;

            sql = "select *,concat(ms_fname,' ',ms_lname) as 'FullName' " +
                ",concat(ms_fnameth, ' ', ms_lnameth) as 'FullNameTH' " +
                "from msteamagree order by ms_id desc ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                GridView1.DataSource = dt;
                GridView1.DataBind();
                bl = true;
            }

            return bl;
        }

        protected void btnExport_Click(object sender, EventArgs e)
        {
            string year = "";
            year = DateTime.Now.ToString("yyyy_MM_dd");

            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=BRH_MsTeamAgree_" + year + ".xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel";
            using (StringWriter sw = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(sw);

                //To Export all pages
                GridView1.AllowPaging = false;
                this.Grid1();

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