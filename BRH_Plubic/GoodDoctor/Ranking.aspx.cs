using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;

namespace BRH_Plubic.GoodDoctor
{
    public partial class Ranking : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                search();
            }
        }

        private void Department(string lastDay)
        {
            string alert = "<font color='red'>No Data !!</font>";
            sql = "select dl.dl_id,dl.dl_name,ifnull(drr.SUMscore,0) as 'SUMscore',ifnull(drr.COUNTrow,0) as 'COUNTrow', " + lastDay + " as 'lastDay' " +
                "\nfrom doctor_location as dl " +
                "\nleft join( " +
                "\n    select dl.dl_id, sum(drr.drr_score) as 'SUMscore', COUNT(drr.drr_id) as 'COUNTrow' " +
                "\n    from doctor_rating as drr " +
                "\n    left join doctor_location as dl on dl.dl_id = drr.drr_dlid " +
                "\n    where dl.dl_active = 'yes' and drr.drr_active = 'yes' " +
                "\n    and(convert(drr.drr_submitdate, date) >= CURRENT_DATE - INTERVAL " + lastDay + " DAY) " +
                "\n    and(convert(drr.drr_submitdate, date) < CURRENT_DATE) " +
                "\n    group by dl.dl_id " +
                "\n) as drr on drr.dl_id = dl.dl_id " +
                "\nwhere dl.dl_active = 'yes' " +
                "\norder by ifnull(drr.COUNTrow,0) desc, dl.dl_name ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                alert = "";
            }
            lbl_alert_department.Text = alert;

            listview_department.DataSource = dt;
            listview_department.DataBind();
        }

        private void Doctor(string lastDay ,string minQTY, string star)
        {
            string alert = "<font color='red'>No Data !!</font>";
            string imgTOP = "...";
            sql = "SELECT * FROM ( " +
                "\n select drr.drr_drid,dr.dr_doctorid,dr.dr_forename,dr.dr_surname,dr.dr_img " +
                "\n ,sum(drr.drr_score) as 'SUMscore' ,sum(1) as 'COUNTrow' " +
                "\n ,convert(sum(drr.drr_score) / sum(1),decimal(11,2)) as 'AVGStar' " +
                "\n FROM doctor_rating as drr " +
                "\n left join doctor as dr on dr.dr_id = drr.drr_drid " +
                "\n where drr.drr_active = 'yes' and dr.dr_active = 'yes' " +
                "\n and (convert(drr.drr_submitdate, date) >= CURRENT_DATE - INTERVAL " + lastDay + " DAY) " +
                "\n and (convert(drr.drr_submitdate, date) < CURRENT_DATE) " +
                "\n group by drr.drr_drid,dr.dr_doctorid,dr.dr_forename,dr.dr_surname,dr.dr_img " +
                //"\n order by (sum(drr.drr_score) / sum(1)) desc " +
                "\n) as a where LEFT(convert(a.AVGStar,char),1) = '" + star + "' and a.COUNTrow >= " + minQTY + " " +
                "\norder by a.COUNTrow desc; ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                alert = "";
                imgTOP = dt.Rows[0]["dr_img"].ToString();
            }
            lbl_alert_doctor.Text = alert;
            txtH_imgTOP.Value = imgTOP;

            listview_doctor.DataSource = dt;
            listview_doctor.DataBind();
        }

        public void search()
        {
            string lastDay = dd_lastDay.SelectedValue.ToString();
            Department(lastDay);

            string minQTY = dd_minQTY.SelectedValue.ToString();
            string star = dd_rank.SelectedValue.ToString();
            Doctor(lastDay, minQTY, star);
        }

        protected void dd_lastDay_SelectedIndexChanged(object sender, EventArgs e)
        {
            search();
        }

        protected void dd_minQTY_SelectedIndexChanged(object sender, EventArgs e)
        {
            search();
        }

        protected void dd_rank_SelectedIndexChanged(object sender, EventArgs e)
        {
            search();
        }
    }
}