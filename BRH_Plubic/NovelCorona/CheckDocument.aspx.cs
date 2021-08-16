using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;
using System.Drawing;
using System.IO;

namespace BRH_Plubic.NovelCorona
{
    public partial class CheckDocument : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Login"] != null)
            {
                string status = Session["status"].ToString();
                if (status == "admin" || status == "novelcovid")
                {
                    Report();
                }
                else
                {
                    Response.Write("<script>alert('คุณไม่มีสิทธิ์ใช้งานหน้านี้ !!'); window.location.href='../default.aspx';</script>");
                }
            }
            else
            {
                Response.Write("<script>alert('กรุณา login ก่อนเข้าใช้งาน !!'); window.location.href='../default.aspx';</script>");
            }
        }

        protected void btn_submit_ServerClick(object sender, EventArgs e)
        {
            string id = txt_docno.Value.ToString().Trim();
            sql = "select * from novelcorona where nc_id='" + id + "'; ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                Response.Redirect("Default.aspx?nc=" + id);
            }
        }

        protected void Report()
        {
            sql = "select * from novelcorona as nc " +
                "\nleft join novelcorona_clinic as ncc on ncc.ncc_ncid=nc.nc_id " +
                "\nwhere nc_active = 'yes' " +
                "\norder by nc_staffcheck, nc_id desc ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                //foreach (DataRow dr in dt.Rows)
                //{
                //    string ncDate = dr["nc_datetime"].ToString();
                //    dr["nc_datetime"] = cl_Sql.DateTimeTH(ncDate);
                //}
            }

            LV_Report.DataSource = dt;
            LV_Report.DataBind();
        }

        protected void Grid1()
        {
            sql = "select * from novelcorona as nc " +
                "\nleft join novelcorona_clinic as ncc on ncc.ncc_ncid=nc.nc_id " +
                "\nwhere nc_active = 'yes' " +
                "\norder by nc_id desc ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {

            }
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

        protected void btn_Export_ServerClick(object sender, EventArgs e)
        {
            string DateTimes = "";
            DateTimes = DateTime.Now.ToString("yyyyMMdd");

            string FileName = "BRH_NovelCorona_" + DateTimes + ".xls";

            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=" + FileName + "");
            //Response.Charset = "tis-620";
            Response.ContentType = "application/vnd.ms-excel";

            //confix language for Thai
            Response.ContentEncoding = System.Text.Encoding.Unicode;
            Response.BinaryWrite(System.Text.Encoding.Unicode.GetPreamble());

            using (StringWriter sw = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(sw);

                //To Export all pages
                GridView1.AllowPaging = false;

                Response.Write("<center><h3>Novel Corona 2019 Report</h3>");
                Response.Write("<h5>Novel Corona 2019 report</h5>");

                Grid1();

                //GridView1.HeaderRow.BackColor = Color.Black; // ตัวหนังสือ
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