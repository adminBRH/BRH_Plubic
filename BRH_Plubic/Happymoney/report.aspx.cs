using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BRH_Plubic.Happymoney
{
    public partial class getUsers : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Login"] == null)
            {
                Response.Write("<script>alert('กรุณา Login ก่อนเข้าใช้งาน');window.location.href='../Default.aspx';</script>");
            }
            else
            {
                string Status = Session["status"].ToString();
                if (Status == "admin" || Status == "hr")
                {
                    report();
                }
                else
                {
                    Response.Write("<script>alert('คุณไม่มีสิทธิ์ใช้งานระบบนี้ !!');window.location.href='../Default.aspx';</script>");
                }
            }
        }
        protected void report()
        {
            string empid = "";
            if (Session["userid"] != null)
            {
                empid = Session["userid"].ToString();
            }
            sql = "SELECT sm.mo_empid,emp.emp_pname_th,emp.emp_pnamefull_th,sm.mo_date,sm.mo_money,emp.emp_deptdesc FROM mon_savemoney AS sm LEFT JOIN employee AS emp ON sm.mo_empid = emp.emp_id COLLATE utf8_general_ci WHERE sm.mo_money_active ='Approve' ORDER BY sm.mo_date DESC";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
        protected void btnExport_Click(object sender, EventArgs e)
        {

            string header_lb = "B+HappyMoney";
            string year = "";
            year = DateTime.Now.ToString("yyyyMMdd");

            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=HappyMoney" + year + ".xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel";
            using (StringWriter sw = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(sw);

                //To Export all pages
                GridView1.AllowPaging = false;

                Response.Write("<center><h3>รายงานผลทั้งหมดของผู้เข้าร่วมโครงการ</h3>");

                GridView1.HeaderRow.BackColor = Color.Yellow; // ตัวหนังสือ
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