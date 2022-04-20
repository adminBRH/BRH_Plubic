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

namespace BRH_Plubic.GoodDoctor
{
    public partial class AutoExport : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["key"] != null)
            {
                if (Request.QueryString["key"].ToString() == "BRHhito@Gooddoctor$2022")
                {
                    Export();
                }
            }
        }

        private void report()
        {
            sql = "SELECT drr.*, dl.dl_name, dr.dr_doctorid, dr.dr_forename, dr.dr_surname, dr.dr_englishname, dr.dr_img " +
                "\nFROM doctor_rating as drr " +
                "\nLEFT JOIN doctor_location as dl on dl.dl_id = drr.drr_dlid " +
                "\nLEFT JOIN doctor as dr on dr.dr_id = drr.drr_drid " +
                "\nWHERE drr.drr_active = 'yes' and dl.dl_active = 'yes' ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {}
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

        protected void Export()
        {
            string DateTimes = DateTime.Now.ToString("yyyyMMdd_HHmmss");

            //string FileName = "BRH_GoodDoctor_" + DateTimes + ".xls";
            string FileName = "BRH_GoodDoctor.xls";

            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("Content-Disposition", "Attachment;Filename=" + FileName);
            //Response.AddHeader("content-disposition", "attachment;filename=" + FileName + "");
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
                report();

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