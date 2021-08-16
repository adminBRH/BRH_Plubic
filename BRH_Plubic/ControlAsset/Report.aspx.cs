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

namespace BRH_Plubic.ControlAsset
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
                Response.Redirect("../Default.aspx?back=ControlAsset/Report&login=require");
            }
            else
            {
                string status = Session["status"].ToString();
                if (status == "admin")
                {
                    if (!IsPostBack)
                    {
                        Department();
                        string DateNow = DateTime.Now.ToString("yyyy-MM-dd");
                        Grid1("", "");
                    }
                }
                else
                {
                    string scModal = "fn_AlertModal('Info','คุณไม่มีสิทธิ์ใช้งานหน้านี้ !!','../Default',2000); fn_preview();";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
                }
            }
        }

        protected void Department()
        {
            sql = "select * from v_alldepartment ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {

            }
            DD_Dept.DataSource = dt;
            DD_Dept.DataTextField = "emp_deptdesc";
            DD_Dept.DataValueField = "emp_deptid";
            DD_Dept.DataBind();
        }

        protected void Grid1(string dept, string date)
        {
            sql = "update asset_return set asr_action = 'checked' where asr_action = 'add' and asr_sn in ( " +
                "select asr.asr_sn from asset_return as asr " +
                "left join v_asset_sn as sn on sn.asset_serial_number = asr.asr_sn collate utf8_unicode_ci " +
                "where asr_action = 'add' and sn.asset_serial_number is not null );  ";
            cl_Sql.Modify(sql);

            sql = "select asr_datetime, asr_user, au.emp_name, asr_deptid, dp.emp_deptdesc, asr.asr_action, asr.asr_sn, sn.asset_cate, sn.asset_department " +
                "from asset_return as asr " +
                "left join(select* from v_allusers where emp_active = 'yes') as au on au.emp_id = asr.asr_user " +
                "left join v_asset_sn as sn on sn.asset_serial_number = asr.asr_sn collate utf8_unicode_ci " +
                "left join v_alldepartment as dp on dp.emp_deptid = asr.asr_deptid " +
                "where asr_active = 'yes' and asr_deptid like '%" + dept + "%' and convert(asr_datetime, date) like '%" + date + "%' order by asr_id ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                //foreach (DataRow dr in dt.Rows)
                //{
                //    dr["asr_datetime"] = DateTime.Parse(dr["asr_datetime"].ToString()).ToString("dd/MM/yyyy HH:mm:ss");
                //}
            }
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

        protected void DD_Dept_SelectedIndexChanged(object sender, EventArgs e)
        {
            string dept = DD_Dept.SelectedValue.ToString();
            Grid1(dept, "");
        }

        protected void btn_Export_ServerClick(object sender, EventArgs e)
        {
            
            string dept = DD_Dept.SelectedValue.ToString();
            Grid1(dept,"");

            string DateTimes = "";
            DateTimes = DateTime.Now.ToString("yyyyMMdd_HHmm");

            string FileName = "BRH_CheckAsset_" + DateTimes + ".xls";

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

                Response.Write("<center><h3>รายงานการตรวจสอบข้อมูล Desktop & Laptop</h3>");

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