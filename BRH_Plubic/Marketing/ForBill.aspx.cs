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

namespace BRH_Plubic.Marketing
{
    public partial class ForBill : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass CL_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            string strDate = DateTime.Now.ToString("yyyy-MM-dd");
            string endDate = DateTime.Now.ToString("yyyy-MM-dd");

            if (Session["Login"] == null)
            {
                Response.Write("<script>alert('ไม่มีสิทธิ์ใช้งานกรุณา Login !!'); window.location.href='Default.aspx';</script>");
            }
            else
            {
                string status = Session["status"].ToString();
                if (status == "admin" || status == "finance" || status == "marketing")
                {
                    if (!IsPostBack)
                    {
                        date_start.Value = strDate;
                        date_end.Value = endDate;

                        Grid1(strDate, endDate);
                    }
                }
                else
                {
                    Response.Write("<script>alert('คุณไม่มีสิทธิ์ใช้งานหน้านี้ !!'); window.location.href='Default.aspx';</script>");
                }

            }
        }

        public Boolean Grid1(string strDate, string endDate)
        {
            Boolean bl = false;

            sql = "SELECT md.* " +
                ", (dt_qty * dt_price) as dt_total " +
                ", (dt_qty * dt_discount) as dt_disc " +
                ", ((dt_qty * dt_price) - (dt_qty * dt_discount)) as dt_net " +
                ", mh.hd_date, mh.hd_dateslip, mh.hd_paystatus " +
                "FROM marketingdetail as md left join marketingheader as mh on mh.hd_id = md.hd_id " +
                "where (mh.hd_status <> 'cancel' or mh.hd_status <> 'cancel') " +
                "and (convert(mh.hd_date,date) between '" + strDate + "' and '" + endDate + "') " +
                "order by hd_id desc, dt_id ";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                lbl_alert.Text = "";
            }
            else
            {
                lbl_alert.Text = "ไม่พบข้อมูลในช่วงวันดังกล่าว !!";
            }
            GridView1.DataSource = dt;
            GridView1.DataBind();

            return bl;
        }

        protected void btnExport_Click(object sender, EventArgs e)
        {

            string header_lb = "รายละเอียดการสั่งซื้อสินค้า";
            string year = "";
            year = DateTime.Now.ToString("yyyyMMdd");

            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=BRH_MarketingSaleDetails_" + year + ".xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel";
            using (StringWriter sw = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(sw);

                //To Export all pages
                GridView1.AllowPaging = false;

                string strDate = date_start.Value.ToString();
                string endDate = date_end.Value.ToString();
                Grid1(strDate, endDate);

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

        protected void a_search_ServerClick(object sender, EventArgs e)
        {
            string Startdate = date_start.Value.ToString();
            string Enddate = date_end.Value.ToString();

            if (Startdate == "" || Enddate == "")
            {
                lbl_alert.Text = "กรุณาเลือกวันที่เริ่มต้นและสิ้นสุด !!";
            }
            else
            {
                if (DateTime.Parse(Startdate) > DateTime.Parse(Enddate))
                {
                    lbl_alert.Text = "วันที่เริ่มต้นมากกว่าวันที่สิ้นสุดไม่ได้ !!";
                }
                else
                {
                    string strDate = date_start.Value.ToString();
                    string endDate = date_end.Value.ToString();
                    Grid1(strDate, endDate);
                }
            }
        }
    }
}