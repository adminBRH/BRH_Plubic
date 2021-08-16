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
    public partial class Live : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userid"] == null)
            {
                Response.Redirect("Default.aspx?back=Live&login=require");
            }
            else
            {
                if (!IsPostBack)
                {
                    CheckTime();
                }
            }
        }

        protected void Timer1_Tick(object sender, EventArgs e)
        {
            CheckTime();
        }

        public Boolean CheckTime()
        {
            Boolean bl = false;

            if (Session["liveid"] == null)
            {
                insertusertime();
            }
            else
            {
                updateusertime();
            }

            return bl;
        }

        public Boolean insertusertime()
        {
            Boolean bl = false;

            string key = cl_Sql.GenerateKey(6);

            string userid = Session["userid"].ToString();
            string indate = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");

            sql = "insert into live_userlist(lu_indate,lu_outdate,lu_empid,lu_key) " +
            "value('" + indate + "', current_timestamp,'" + userid + "','" + key + "');";
            if (cl_Sql.Modify(sql))
            {
                sql = "select * from live_userlist where lu_indate='" + indate + "' and lu_key='" + key + "';  ";
                dt = new DataTable();
                dt = cl_Sql.select(sql);
                if (dt.Rows.Count > 0)
                {
                    Session["liveid"] = dt.Rows[0]["lu_id"].ToString();
                }
            }

            return bl;
        }

        public Boolean updateusertime()
        {
            Boolean bl = false;

            string userid = Session["userid"].ToString();
            string liveid = Session["liveid"].ToString();

            sql = "update live_userlist set lu_outdate=current_timestamp where lu_id='" + liveid + "' and lu_empid='" + userid + "' ";
            cl_Sql.Modify(sql);

            return bl;
        }
    }
}