using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;

namespace BRH_Plubic.NovelCorona
{
    public partial class Report : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["nc"] == null || Request.QueryString["key"] == null)
            {
                Response.Redirect("CheckDocument.aspx");
            }
            else
            {
                if (!CoronaReport(Request.QueryString["nc"].ToString(), Request.QueryString["key"].ToString()))
                {
                    Response.Write("<script>alert('Key กับ หมายเลขเอกสารไม่ถูกต้อง !!'); window.location.href='CheckDocument.aspx';</script>");
                }
            }
        }

        private Boolean CoronaReport(string id, string key)
        {
            Boolean bl = false;

            sql = "select * from novelcorona as nc " +
                "\nleft join novelcorona_clinic as ncc on ncc.ncc_ncid=nc.nc_id " +
                "\nwhere nc.nc_id='" + id + "' and nc_key='" + key + "'; ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                bl = true;

                if (dt.Rows[0]["ncc_reporter"].ToString() == "")
                {
                    div_reporter.Visible = true;
                    div_report.Visible = false;
                }
                else
                {
                    div_reporter.Visible = false;
                    div_report.Visible = true;

                    DateTime DOB = DateTime.Parse(dt.Rows[0]["nc_dob"].ToString());
                    DateTime Today = DateTime.Now;

                    int YearDOB = Today.Year - DOB.Year;
                    if (YearDOB < 0) { YearDOB = 543 + YearDOB; }
                    int MonthDOB = DOB.Month - Today.Month;
                    if (DOB.Month > Today.Month)
                    {
                        YearDOB = YearDOB - 1;
                        MonthDOB = 12 - MonthDOB;
                    }
                    else
                    {
                        MonthDOB = MonthDOB * (-1);
                    }
                    dt.Columns.Add("nc_ageYear", typeof(string));
                    dt.Columns.Add("nc_ageMonth", typeof(string));
                    dt.Rows[0]["nc_ageYear"] = YearDOB.ToString();
                    dt.Rows[0]["nc_ageMonth"] = MonthDOB.ToString();

                    string baan = dt.Rows[0]["nc_baan"].ToString();
                    if (baan == "บ้าน")
                    {
                        dt.Rows[0]["nc_baan"] = "";
                    }

                    //string travelDate = dt.Rows[0]["nc_rh_travel_date"].ToString();

                    LV_novelcorona.DataSource = dt;
                    LV_novelcorona.DataBind();
                }
            }
            else
            {
                bl = false;
            }

            return bl;
        }

        protected void btn_reporter_ServerClick(object sender, EventArgs e)
        {
            string id = Request.QueryString["nc"].ToString();
            string key = Request.QueryString["key"].ToString();

            string reporter = txt_reporter.Value.ToString().Trim();
            string reporterdept = txt_reporterdept.Value.ToString().Trim();
            string reportertel = txt_reportertel.Value.ToString().Trim();

            sql = "update novelcorona_clinic set ncc_reporter='" + reporter + "', ncc_reporterdept='" + reporterdept + "', ncc_reportertel='" + reportertel + "' " +
                "\nwhere ncc_ncid='" + id + "' ";
            if (cl_Sql.Modify(sql))
            {
                Response.Redirect("Report.aspx?nc=" + id + "&key=" + key);
            }
            else
            {
                Response.Write("<script>alert('ไม่สามารถบันทึกข้อมูลผู้รายงานได้ กรุณาติดต่อผู้ดูแลระบบ !!');</script>");
            }
        }
    }
}