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
                    if (!IsPostBack)
                    {
                        DateSelect();
                        string DateNow = DD_Date.SelectedValue.ToString();
                        Report(DateNow,"no");
                    }
                }
                else
                {
                    Response.Write("<script>alert('คุณไม่มีสิทธิ์ใช้งานหน้านี้ !!'); window.location.href='../default.aspx';</script>");
                }
            }
            else
            {
                Response.Redirect("../Default.aspx?back=NovelCorona/CheckDocument&login=require");
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

        protected void DateSelect()
        {
            sql = "select distinct date_format(nc_datetime,'%d-%b-%Y') as nc_date, convert(nc_datetime, date) as nc_datetime from novelcorona where nc_active='yes' order by nc_datetime desc ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {

            }

            DD_Date.DataSource = dt;
            DD_Date.DataTextField = "nc_date";
            DD_Date.DataValueField = "nc_datetime";
            DD_Date.DataBind();
        }

        protected void Report(string date, string status)
        {
            date = DateTime.Parse(date).ToString("yyyy-MM-dd");

            string wh = "";
            if (status == "print")
            {
                wh = "\nand nc_staffcheck='yes' and ncc_reporter<>'' ";
            }
            else if (status == "yes")
            {
                wh = "\nand nc_staffcheck='" + status + "' and ncc_reporter is null ";
            }
            else if (status == "no")
            {
                wh = "\nand nc_staffcheck='" + status + "' ";
            }
            else
            {
                wh = "";
            }

            sql = "select * from novelcorona as nc " +
                "\nleft join novelcorona_clinic as ncc on ncc.ncc_ncid=nc.nc_id " +
                "\nwhere nc_active = 'yes' " +
                "\nand convert(nc_datetime, date) = '" + date + "' " + wh +
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

        protected void Grid1(string date)
        {
            date = DateTime.Parse(date).ToString("yyyy-MM-dd");
            sql = "select * from novelcorona as nc " +
                "\nleft join novelcorona_clinic as ncc on ncc.ncc_ncid=nc.nc_id " +
                "\nwhere nc.nc_active = 'yes' " +
                "\nand convert(nc.nc_datetime, date) = convert('" + date +"', date) " +
                "\norder by nc.nc_id desc ";
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
            string DateTimes = DD_Date.SelectedValue.ToString();
            DateTimes = DateTime.Parse(DateTimes).ToString("yyyyMMdd");

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

                Response.Write("<h3>Novel Corona 2019 Report</h3>");
                Response.Write("<h5>Novel Corona 2019 report</h5>");

                string date = DD_Date.SelectedValue.ToString();
                Grid1(date);

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

        public void Refresh()
        {
            string DateNow = DD_Date.SelectedValue.ToString();
            string status = dd_status.SelectedValue.ToString();
            Report(DateNow, status);
        }

        protected void DD_Date_SelectedIndexChanged(object sender, EventArgs e)
        {
            Refresh();
        }

        protected void dd_status_SelectedIndexChanged(object sender, EventArgs e)
        {
            Refresh();
        }

        protected void btn_refresh_ServerClick(object sender, EventArgs e)
        {
            Refresh();
        }

        protected void btn_delete_ServerClick(object sender, EventArgs e)
        {
            string id = txtH_id.Value.ToString();
            sql = "update novelcorona set nc_active='no' where nc_id='" + id + "'; ";
            if (cl_Sql.Modify(sql))
            {
                Refresh();
            }
        }
    }
}