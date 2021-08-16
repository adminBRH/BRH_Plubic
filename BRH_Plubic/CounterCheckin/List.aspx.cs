using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;

namespace BRH_Plubic.CounterCheckin
{
    public partial class List : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass CL_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Login"] == null)
            {
                Response.Redirect("../Default.aspx?back=CounterCheckin/List&login=require");
            }
            else
            {
                string UserStatus = Session["status"].ToString();
                if (UserStatus == "admin" || UserStatus == "hod")
                {
                    string UserID = Session["userid"].ToString();

                    string DateStart = "1999-01-01";
                    string DateEnd = DateTime.Now.Date.ToString();

                    if (!IsPostBack)
                    {
                        DataStatus();

                        ddl_status.SelectedValue = "waiting";

                        DateEnd = DateTime.Parse(DateEnd).ToString("yyyy-MM-dd");

                        EndDate.Value = DateEnd;

                        DataList(UserID, DateStart, DateEnd, "waiting");
                    }
                }
                else
                {
                    Response.Write("<script>alert('คุณไม่มีสิทธิ์ใช้งานระบบนี้ !!'); window.location.href='../Default.aspx';</script>");
                }
            }
        }

        protected void DataStatus()
        {
            sql = "select 'All' as 'cc_status' union select distinct cc_status from countercheckin ";
            dt = new DataTable();
            dt = CL_Sql.select(sql);

            ddl_status.DataSource = dt;
            ddl_status.DataValueField = "cc_status";
            ddl_status.DataTextField = "cc_status";
            ddl_status.DataBind();
        }

        protected void DataList(string hodID, string dateStart, string dateEnd, string status)
        {
            if (hodID == "admin") { hodID = ""; }
            if (status == "All") { status = ""; }

            if (dateStart == "") { dateStart = "1999-01-01"; }

            sql = "select cc.*, if(cc_type='Help','ช่วยงาน','ฝึกงาน') as 'cc_typename', if(cc_evaluate is null,'0',cc_evaluate) as 'cc_score' " +
                "\n, CONCAT(cc.cc_datein,' ',cc.cc_timein,' น.') as 'datein', CONCAT(cc.cc_dateout,' ',cc.cc_timeout,' น.') as 'dateout' " +
                "\n, if(cc_suggestion is null,'',CONCAT('คำแนะนำ ติชม : ',cc_suggestion)) as 'suggestion' " +
                "\n, ds.ds_desc, CONCAT(em.emp_pname_th,' ',em.emp_fname_th,' ',em.emp_lname_th) as 'empname' " +
                "\nfrom countercheckin as cc " +
                "\nleft join department_service ds on ds.ds_id = cc.cc_deptid " +
                "\nleft join employee em on em.emp_id = cc.cc_empid " +
                "\nwhere ds_hod like '%" + hodID + "%'" +
                "\nand (cc_datein >= '" + dateStart + "' and  cc_datein <= '" + dateEnd + "') " +
                "\nand cc_status like '%" + status + "%' " +
                "\norder by CONVERT(CONCAT(cc.cc_datein,' ',cc.cc_timein),date) desc ";
            dt = new DataTable();
            dt = CL_Sql.select(sql);

            lv_list.DataSource = dt;
            lv_list.DataBind();
        }

        protected void btn_submit_ServerClick(object sender, EventArgs e)
        {
            string id = txtH_id.Value.ToString();
            string score = txtH_score.Value.ToString();
            string remark = txt_remark.Value.ToString().Trim();
            sql = "update countercheckin set cc_evaluate = '" + score + "', cc_status = 'confirm', cc_suggestion = '" + remark + "' where cc_id = '" + id + "' ";
            if (CL_Sql.Modify(sql))
            {
                Response.Redirect(Request.Url.AbsoluteUri); // Refresh page
            }
        }

        protected void btnSearch_ServerClick(object sender, EventArgs e)
        {
            string UserID = Session["userid"].ToString();
            string dateStart = StartDate.Value.ToString();
            string dateEnd = EndDate.Value.ToString();
            string status = ddl_status.SelectedValue.ToString();

            DataList(UserID, dateStart, dateEnd, status);
        }
    }
}