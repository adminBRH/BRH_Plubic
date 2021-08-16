using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;

namespace BRH_Plubic.Queue
{
    public partial class myWebForm : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            lbl_IPAddress.Text = GetUserIP();

            if (Request.QueryString["dept"] != null)
            {
                txt_dept.Value = Request.QueryString["dept"].ToString();
                lbl_DeptName.Text = location(txt_dept.Value);
            }
        }

        protected string location(string id)
        {
            string result = "";

            sql = "select * from doctor_location where dl_id='" + id + "'; ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                result = dt.Rows[0]["dl_name"].ToString();
            }

            return result;
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
    }
}