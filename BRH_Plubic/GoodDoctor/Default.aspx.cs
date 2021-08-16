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
    public partial class Default : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["location"] == null)
            {
                string scModal = "fn_AlertModal('Warning','URL ไม่ถูกต้อง !!','../Marketing',2000);";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
            }
            else
            {
                string location = Request.QueryString["location"].ToString();

                string IP = GetUserIP();
                string queue = CheckQueueByIP(location, IP);
                if (queue != "")
                {
                    txt_key.Value = queue;
                    doctor(queue);
                }
            }
        }

        private string GetUserIP()
        {
            //Gets a comma-delimited list of IP Addresses
            string ipList = Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

            //If any are available - use the first one
            if (!string.IsNullOrEmpty(ipList))
            {
                return ipList.Split(',')[0];
            }

            //Otherwise return the Remote Address
            return Request.ServerVariables["REMOTE_ADDR"];
        }

        public string CheckQueueByIP(string dept, string IP)
        {
            string result = "";

            sql = "select * from mytable where convert(datetimes,date)=current_date and status='seedoctor' and active='yes' " +
                "and dept='" + dept + "' and IP = '" + IP + "'; ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                if (dt.Rows[0]["IP"].ToString() != "manual")
                {
                    result = dt.Rows[0]["queue"].ToString();
                }
            }

            return result;
        }

        protected void btn_key_ServerClick(object sender, EventArgs e)
        {
            string en = txt_key.Value.ToString().Trim().Replace("-","");
            if (en != "")
            {
                doctor(en);
            }
        }

        protected void doctor(string en)
        {
            string alert = "";

            string location = Request.QueryString["location"].ToString();

            sql = "select * from doctor_rating where drr_active='no' and drr_dlid='" + location + "' and drr_en='" + en + "' and CONVERT(drr_datetime,date)=CURRENT_DATE; ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                string loID = dt.Rows[0]["drr_dlid"].ToString();
                string drid = dt.Rows[0]["drr_drid"].ToString();

                txtH_lo.Value = loID;

                div_key.Visible = false;
                div_doctor.Visible = true;

                ListView(en, loID);
            }
            else
            {
                div_key.Visible = true;
                div_doctor.Visible = false;

                alert = "<script>alertModalInfo('#Modal_Info','ไม่พบหมายเลขคิวหรือ EN นี้ ในระบบ !!');</script>";
            }

            lbl_Modal.Text = alert;
        }

        protected void ListView(string EN, string lo)
        {
            //sql = "call sp_doctorRating('" + EN + "','" + lo + "');";
            dt = new DataTable();
            dt = cl_Sql.sp_doctorRating(EN, lo);
            if (dt.Rows.Count > 0)
            {

                foreach (DataRow dr in dt.Rows)
                {
                    if (dt.Rows.IndexOf(dr) == 0)
                    {
                        dt.Columns.Add("dr_pathimg", typeof(string));
                        dt.Columns.Add("dr_hidden", typeof(string));
                    }
                    dr["dr_hidden"] = "";
                    dr["dr_pathimg"] = "<img src=\"" + dr["dr_img"] + "\" class=\"rounded-circle imgDoctor\">";
                }
            }
            else
            {
                div_key.Visible = false;
                div_doctor.Visible = false;
                div_thank.Visible = true;
                lbl_alert.Text = "ขอบคุณท่านที่เสียสละเวลาในการประเมินแพทย์";
                lbl_alert.ForeColor = System.Drawing.Color.Blue;
            }

            LV_Doctor.DataSource = dt;
            LV_Doctor.DataBind();
        }

        protected void btn_submit_ServerClick(object sender, EventArgs e)
        {
            string scModal = "";

            string drid = txtH_id.Value.ToString();
            string score = txtH_rating.Value.ToString();
            string comment = txt_comment.Value.ToString().Trim();
            string loID = txtH_lo.Value.ToString();

            string key = txt_key.Value.ToString().Trim().Trim().Replace("-", "");

            string alert = "";
            sql = "select * from doctor_rating " +
                "where drr_active='no' and drr_dlid='" + loID + "' and drr_drid='" + drid + "' and drr_en = '" + key + "'; ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                string drr_id = dt.Rows[0]["drr_id"].ToString();
                string en = dt.Rows[0]["drr_en"].ToString();

                sql = "UPDATE doctor_rating Set drr_active='yes', drr_score=" + score + ", drr_comment='" + comment + "', drr_submitdate=current_timestamp() " +
                    "where drr_id = '" + drr_id + "'; ";
                if (cl_Sql.Modify(sql))
                {
                    scModal = "fn_AlertModal('Success','Success !!','',0);";

                    sql = "update mytable set status='finish' where active='yes' and queue='" + en + "' ";
                    cl_Sql.Modify(sql);
                    ListView(key, loID);
                }
                else
                {
                    scModal = "fn_AlertModal('Warning','ขออภัยระบบขัดข้อง ไม่สามารถให้คะแนนได้ !!','',0);";
                }
            }
            else
            {
                div_key.Visible = false;
                div_doctor.Visible = false;
                div_thank.Visible = true;
                lbl_alert.Text = "ไม่สามารถทำการประเมินซ้ำได้ !!";
                lbl_alert.ForeColor = System.Drawing.Color.Red;
            }

            lbl_Modal.Text = alert;

            Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
        }
    }
}