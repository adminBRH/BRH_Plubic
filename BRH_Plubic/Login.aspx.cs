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
    public partial class Login : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["clear"] != null)
            {
                if (Request.QueryString["clear"].ToString() == "user")
                {
                    Session.Clear();
                    Response.Redirect("Default.aspx");
                }
            }
        }

        protected void btn_login_Click(object sender, EventArgs e)
        {
            string user = txt_user.Value.ToString().Trim();
            string pass = txt_pass.Value.ToString().Trim();
            if (CheckUserPass(user, pass))
            {
                lbl_alert.Text = "";

                string page = "Default";

                if (Request.QueryString["page"] != null)
                {
                    page = Request.QueryString["page"].ToString();
                }

                page = page + ".aspx";
                Response.Redirect(page);
            }
            else
            {
                lbl_alert.Text = "User or Password incorrect !!";
            }
        }

        public Boolean CheckUserPass(string user, string pass)
        {
            Boolean bl = false;

            sql = "select * from users where user_active ='yes' and user_id = '" + user + "' and user_password = md5('" + pass + "') ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                Session.Timeout = 60;

                Session["Login"] = "Yes";
                Session["userid"] = dt.Rows[0]["user_id"].ToString();
                Session["status"] = dt.Rows[0]["user_status"].ToString();
                Session["name"] = dt.Rows[0]["user_showname"].ToString();

                bl = true;
            }

            return bl;
        }
    }
}