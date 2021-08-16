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

namespace BRH_Plubic.VaccineCovid
{
    public partial class Report : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass CL_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["login"] != null)
            {
                string status = Session["status"].ToString();
                if (status == "admin" || status == "finance")
                {
                    if (!IsPostBack)
                    {
                        Status();
                        Data("paid");
                    }
                }
                else
                {
                    Response.Write("<script>alert('คุณไม่มีสิทธิ์ใช้งานหน้านี้ !!'); window.location.href='../default.aspx';</script>");
                }
            }
            else
            {
                Response.Redirect("../Default.aspx?back=VaccineCovid/Report&login=require");
            }
        }

        protected void Status()
        {
            sql = "select distinct cm_status from confirmslip_moderna ";
            dt = new DataTable();
            dt = CL_Sql.select(sql);

            dd_status.DataSource = dt;
            dd_status.DataTextField = "cm_status";
            dd_status.DataValueField = "cm_status";
            dd_status.DataBind();

            dd_status.SelectedValue = "paid";
        }

        protected void Data(string status)
        {
            sql = "update paidslip_moderna set pm_active = 'no' " +
                "where pm_key not in (select cm_key from confirmslip_moderna where cm_key <> '')";
            CL_Sql.Modify(sql);

            sql = "select cm_cardid,cm_cardtype,cm_phone,cm_name, sum(cm_qty) as 'book_qty', sum(cm_total) as 'sale_total', cm_status " +
                "\n,pm_want_qty as 'want_qty', pm_pay as 'pay_total', pm_slipdatetime, pm_id, concat('image/slip/' , pm_key , '.jpg') as 'pm_slip' " +
                "\nfrom confirmslip_moderna as cm " +
                "\nleft join paidslip_moderna as pm on pm_active='yes' and cm.cm_key=pm.pm_key " +
                "\nwhere cm_active='yes' " +
                "\ngroup by cm_cardid,cm_cardtype,cm_phone,cm_name,cm_status " +
                "\norder by pm_id,cm_payid ";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {

            }

            DataView dv = new DataView(dt);
            dv.RowFilter = "cm_status = '" + status + "'";

            LV_data.DataSource = dv;
            LV_data.DataBind();

            Grid1(dt);
        }

        protected void Grid1(DataTable dt)
        {
            foreach (DataRow dr in dt.Rows)
            {
                if (dr["pm_slip"].ToString() != "")
                {
                    dr["pm_slip"] = "http://brh.apply-apps.com/VaccineCovid/" + dr["pm_slip"].ToString();
                }
            }
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

        protected void btn_Export_ServerClick(object sender, EventArgs e)
        {
            string dateNow = DateTime.Now.ToString("yyyyMMddHHmmss");

            string FileName = "BRH_SlipVaccineModerna_" + dateNow + ".xls";

            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=" + FileName + "");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel";
            using (StringWriter sw = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(sw);

                //To Export all pages
                GridView1.AllowPaging = false;

                Response.Write("<center><h3>BRH Slip vaccine Moderna Report.</h3>");

                GridView1.HeaderRow.BackColor = Color.White; // ตัวหนังสือ
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

        protected void dd_status_SelectedIndexChanged(object sender, EventArgs e)
        {
            string status = dd_status.SelectedValue.ToString();
            Data(status);
        }

        protected void btn_confirm_ServerClick(object sender, EventArgs e)
        {
            string payid = txtH_payid.Value.ToString();
            sql = "update confirmslip_moderna set cm_status='confirm' where cm_key in (select pm_key from paidslip_moderna where pm_id = '" + payid + "'); ";
            if (CL_Sql.Modify(sql))
            {
                Response.Redirect("Report");
            }
            else
            {
                Response.Write("<script>alert('ไม่สามารถอัพเดทได้ กรุณาติดต่อผู้ดูแลระบบ !!');</script>");
            }
        }
    }
}