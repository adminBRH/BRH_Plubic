using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;

namespace BRH_Plubic
{
    public partial class CheckinMeetingReport : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass CL_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Topic();

                string SJ = "AA Training";
                dd_topic.SelectedValue = SJ;

                CreateChart(SJ);
            }
        }

        protected void Topic()
        {
            sql = "select distinct cms_sj from checkinmeetingslot where cms_status='CONFIRM' order by cms_sj; ";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0)
            { }
            dd_topic.DataSource = dt;
            dd_topic.DataTextField = "cms_sj";
            dd_topic.DataValueField = "cms_sj";
            dd_topic.DataBind();
        }

        private void CreateChart(string SJ)
        {
            PersonByDate(SJ);
            PersonByTime(SJ);
            PersonHODStaff(SJ);
        }

        public void PersonByDate(string SJ)
        {
            string result = "";
            string label = "";
            string data = "";
            sql = "select sum(1) as 'cm_cnt' ,convert(cm_indate,date) as 'cm_date' from checkinmeeting " +
                "\nwhere cm_slotid in (select cms_id from checkinmeetingslot where cms_sj like '%" + SJ + "%') " +
                "\ngroup by convert(cm_indate,date) " +
                "\norder by convert(cm_indate,date); ";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                foreach (DataRow dr in dt.Rows)
                {
                    if (label != "")
                    {
                        label = label + ",";
                        data = data + ",";
                    }
                    DateTime cmDate = DateTime.Parse(dr["cm_date"].ToString());
                    label = label + cmDate.ToString("dd") + " " + cmDate.ToString("MMM") + " " + cmDate.ToString("yy");
                    data = data + dr["cm_cnt"].ToString();
                }
                result = label + "@" + data;
            }
            txtH_bar.Value = result;
        }

        public void PersonByTime(string SJ)
        {
            string result = "";
            string label = "";
            string data = "";
            sql = "select sum(1) as 'cm_cnt' ,hour(cm_indate) as 'cm_hour' from checkinmeeting " +
                "\nwhere cm_slotid in (select cms_id from checkinmeetingslot where cms_sj like '%" + SJ + "%') " +
                "\ngroup by hour(cm_indate) " +
                "\norder by hour(cm_indate); ";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                int cnt8 = 0;
                int cnt10 = 0;
                int cnt13 = 0;
                int cnt15 = 0;
                int cnt17 = 0;
                foreach (DataRow dr in dt.Rows)
                {
                    if (label != "")
                    {
                        label = label + ",";
                        data = data + ",";
                    }
                    int cmCnt = int.Parse(dr["cm_cnt"].ToString());
                    int cmHour = int.Parse(dr["cm_hour"].ToString());
                    if (cmHour < 10)
                    {
                        cnt8 = cnt8 + cmCnt;
                    }
                    else if (cmHour < 13)
                    {
                        cnt10 = cnt10 + cmCnt;
                    }
                    else if (cmHour < 15)
                    {
                        cnt13 = cnt13 + cmCnt;
                    }
                    else if (cmHour < 17)
                    {
                        cnt15 = cnt15 + cmCnt;
                    }
                    else if (cmHour < 19)
                    {
                        cnt17 = cnt17 + cmCnt;
                    }
                    else { }
                }

                label = "08:00-10:00,10:00-12:00,13:00-15:00,15:00-17:00,17:00-19:00";
                data = cnt8 + "," + cnt10 + "," + cnt13 + "," + cnt15 + "," + cnt17;
                
                result = label + "@" + data;
            }
            txtH_line.Value = result;
        }

        public void PersonHODStaff(string SJ)
        {
            string result = "";
            string label = "";
            string data = "";
            sql = "select sum(1) as 'cm_cnt' ,emp_status from checkinmeeting as cm " +
                "\nleft join employee as em on em.emp_id=cm.cm_empid " +
                "\nwhere cm_slotid in (select cms_id from checkinmeetingslot where cms_sj like '%" + SJ + "%') " +
                "\ngroup by emp_status " +
                "\norder by emp_status; ";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                int HOD = 0;
                int Staff = 0;
                foreach (DataRow dr in dt.Rows)
                {
                    int cmCnt = int.Parse(dr["cm_cnt"].ToString());
                    string empStatus = dr["emp_status"].ToString();
                    if (empStatus == "hod")
                    {
                        HOD = HOD + cmCnt;
                    }
                    else
                    {
                        Staff = Staff + cmCnt;
                    }
                }

                label = "HOD,STAFF";
                data = HOD + "," + Staff;

                result = label + "@" + data;
            }
            txtH_doughnut.Value = result;
        }

        protected void dd_topic_SelectedIndexChanged(object sender, EventArgs e)
        {
            string SJ = dd_topic.SelectedValue.ToString();
            CreateChart(SJ);
        }
    }
}