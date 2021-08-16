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
    public partial class TimelineList : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            string scModal = "";

            if (Session["status"] == null)
            {
                Response.Redirect("../Default.aspx?back=Covid19/Timelinelist&login=require");
            }
            else
            {
                string status = Session["status"].ToString();
                if (status == "admin" || status == "novelcovid")
                {
                    if (!IsPostBack)
                    {
                        Lits();
                    }
                }
                else
                {
                    scModal = "fn_AlertModal('Warning','คุณไม่มีสิทธิ์ใช้งานในหน้านี้ !!','Covid19/Timeline',1500);";
                }
            }

            Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
        }

        protected void Lits()
        {
            sql = "select *, if(ct_editdate is null,'Waiting','Checked') as ct_status,0 as ct_index " +
                "\nfrom covid_timeline where ct_active='yes' ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                int i = 1;
                foreach (DataRow dr in dt.Rows)
                {
                    dr["ct_index"] = i.ToString();
                    i ++;
                }
            }
            LV_list.DataSource = dt;
            LV_list.DataBind();
        }

        protected void LV_list_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            DataPager dp = (DataPager)LV_list.FindControl("DataPager1");
            dp.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            Lits();
        }
    }
}