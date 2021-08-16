using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;

namespace BRH_Plubic.Covid19
{
    public partial class TimelineReport : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            string scModal = "";

            if (Request.QueryString["id"] != null)
            {
                string ctid = Request.QueryString["id"].ToString();
                if (ctid == "")
                {
                    Response.Redirect("Timelinelist");
                }
                else
                {
                    if (Heads(ctid))
                    {
                        Details(ctid);
                    }
                    else
                    {
                        scModal = "fn_AlertModal('Warning','ไม่มีเลขที่เอกสารนี้ในระบบ !!','Covid19/Timeline',1500);";
                    }
                }
            }
            else
            {
                Response.Redirect("Timelinelist");
            }

            Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
        }

        public Boolean Heads(string ctid)
        {
            Boolean bl = false;

            sql = "select * ,concat(day(ct_symptomdate),'/',month(ct_symptomdate),'/',year(ct_symptomdate)) as ct_symptomdateTH " +
                ",concat(day(ct_pcrdate),'/',month(ct_pcrdate),'/',year(ct_pcrdate)) as ct_pcrdateTH " +
                "\nfrom covid_timeline where ct_id = '" + ctid + "'; ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                lbl_name.Text = dt.Rows[0]["ct_fname"].ToString() + " " + dt.Rows[0]["ct_lname"].ToString();
                lbl_phone.Text = dt.Rows[0]["ct_phone"].ToString();

                string symptomYN = dt.Rows[0]["ct_symptom"].ToString();
                if (symptomYN == "yes")
                {
                    lbl_symptomYes.Text = "<i class=\"ti-check\"></i>";
                    lbl_symptomDate.Text = dt.Rows[0]["ct_symptomdateTH"].ToString();
                }
                else
                {
                    lbl_symptomNo.Text = "<i class=\"ti-check\"></i>";
                }

                lbl_pcrdate.Text = dt.Rows[0]["ct_pcrdateTH"].ToString();

                bl = true;
            }
            else
            {
                lbl_name.Text = "";
                lbl_phone.Text = "";
                lbl_symptomYes.Text = "";
                lbl_symptomDate.Text = "";
                lbl_symptomNo.Text = "";
            }

            return bl;
        }

        public void Details(string ctid)
        {
            sql = "select *, concat(day(ctd_date),'/',month(ctd_date),'/',year(ctd_date)) as ctd_dateTH " +
                "\nfrom covid_timelinedate where ctd_ctid='" + ctid + "' and ctd_active='yes' order by ctd_index; ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {

            }

            LV_Details.DataSource = dt;
            LV_Details.DataBind();
        }
    }
}