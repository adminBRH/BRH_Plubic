using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;

using System.Net;
using System.IO;

namespace BRH_Plubic.AssetControl
{
    public partial class RepairList : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userid"] != null)
            {
                if (!IsPostBack)
                {
                    DDStatus();
                    string id = "";
                    if (Request.QueryString["id"] != null)
                    {
                        id = Request.QueryString["id"].ToString().Trim();
                    }
                    RepairData("", id);
                }
            }
            else
            {
                Response.Redirect("../Default.aspx?back=AssetControl/RepairList&login=require");
            }
        }

        public void DDStatus()
        {
            sql = "select distinct asr_status from asset_repair ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {

            }

            dd_status.DataSource = dt;
            dd_status.DataTextField = "asr_status";
            dd_status.DataValueField = "asr_status";
            dd_status.DataBind();

            dd_status.Items.Insert(0, new ListItem("All Status", ""));
        }

        protected void RepairData(string status, string id)
        {
            string searchID = "and asr_id = '" + id + "' ";
            if (id == "") { searchID = ""; }
            sql = "select ar.*,ds.ds_desc,ac.asc_name,at.ast_name,at.ast_logo,em.emp_pname_th,em.emp_pnamefull_th " +
                "\n,if(ar.asr_status='Notify','Acknowledge',if(ar.asr_status='Acknowledge','Repaired','Finish')) as 'asr_action' " +
                "\nfrom asset_repair as ar " +
                "\nleft join department_service as ds on ds.ds_id=ar.asr_dsid " +
                "\nleft join asset_cate as ac on ac.asc_id=ar.asr_ascid " +
                "\nleft join asset_type as at on at.ast_id=ar.asr_astid " +
                "\nleft join employee as em on em.emp_id=ar.asr_cuser " +
                "\nwhere ar.asr_status like '%" + status + "%' " + searchID;
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {

            }
            LV_Repair.DataSource = dt;
            LV_Repair.DataBind();
        }

        protected void dd_status_SelectedIndexChanged(object sender, EventArgs e)
        {
            string id = txt_id.Value.ToString().Trim();
            string status = dd_status.SelectedValue.ToString();
            RepairData(status, id);
        }

        protected void btn_search_ServerClick(object sender, EventArgs e)
        {
            string id = txt_id.Value.ToString().Trim();
            string status = dd_status.SelectedValue.ToString();
            RepairData(status, id);
        }

        protected void btn_action_ServerClick(object sender, EventArgs e)
        {
            string userStatus = Session["status"].ToString();
            string userName = Session["name"].ToString();
            string userid = Session["userid"].ToString();
            if (userStatus == "admin")
            {
                string id = txtH_ID.Value.ToString();
                if (id != "")
                {
                    sql = "select asr_status from asset_repair where asr_id='" + id + "' ";
                    dt = new DataTable();
                    dt = cl_Sql.select(sql);
                    if (dt.Rows.Count > 0)
                    {
                        string status = dt.Rows[0]["asr_status"].ToString();
                        if (status == "Notify")
                        {
                            status = "Acknowledge";
                        }
                        else if (status == "Acknowledge")
                        {
                            status = "Repaired";
                        }
                        else
                        {
                            status = "Finish";
                        }

                        sql = "update asset_repair set asr_status='" + status + "', asr_muser='" + userid + "', asr_mdate=CURRENT_TIMESTAMP " +
                            "\nwhere asr_id = '" + id + "'; ";
                        if (cl_Sql.Modify(sql))
                        {
                            string domain = Request.Url.Host;
                            string Link = "http://" + domain + "/AssetControl/RepairList?id=" + id;

                            string txt = "\nRepair ID: " + id + "\nStatus: " + status + "\nโดย: " + userName + "\nLink: " + Link;
                            Linenotify(txt, "Clinic");

                            if (status == "Finish")
                            {
                                txt = "\nRepair ID: " + id + "\nแก้ไขซ่อมแซมเรียบร้อยแล้ว !!\nLink: " + Link;
                                Linenotify(txt, "IT");
                            }

                            Response.Redirect("RepairList");
                        }
                        else
                        {
                            Response.Write("<script>alert('ไม่สามารถอัพเดทสถานะได้ กรุณาติดต่อผู้ดูแลระบบ !!');</script>");
                        }
                    }
                }
            }
            else
            {
                Response.Write("<script>alert('คุณไม่มีสิทธิ์อนุมัติ !!');</script>");
            }
        }

        public Boolean Linenotify(string txt,string sendTo)
        {
            Boolean bl = false;

            string token = "zAnirYUlJsqdbI9ISjXe7wPP0xbje3pAufQKXjs4UQ0";
            if (sendTo == "Clinic")
            {
                token = "KvQLv7ml6usGawbF7ljp5GxZDyxo2LbGzdaVL09E8h6";
            }

            string msg = txt;

            try
            {
                var request = (HttpWebRequest)WebRequest.Create("https://notify-api.line.me/api/notify");
                var postData = string.Format("message={0}", msg);
                var data = Encoding.UTF8.GetBytes(postData);
                request.Method = "POST";
                request.ContentType = "application/x-www-form-urlencoded";
                request.ContentLength = data.Length;
                request.Headers.Add("Authorization", "Bearer " + token);

                using (var stream = request.GetRequestStream())
                {
                    stream.Write(data, 0, data.Length);
                }

                var response = (HttpWebResponse)request.GetResponse();
                var responseString = new StreamReader(response.GetResponseStream()).ReadToEnd();

                bl = true;
            }
            catch (Exception ex)
            {
                bl = false;
            }

            return bl;
        }
    }
}