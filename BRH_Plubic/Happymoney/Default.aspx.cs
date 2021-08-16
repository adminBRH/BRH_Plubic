using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;

namespace BRH_Plubic.Happymoney
{
    public partial class Default : System.Web.UI.Page
    {

        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();
        protected void Page_Load(object sender, EventArgs e)
        {
            //Response.Redirect("http://brh.apply-apps.com/Happymoney/Default");

            if (Session["Login"] == null)
            {
                Response.Write("<script>alert('กรุณา Login ก่อนเข้าใช้งาน');window.location.href='../Default.aspx';</script>");
                //Response.Write("<script>alert('กรุณา Login ก่อนเข้าใช้งาน !!'); window.location.href='../Default.aspx';</script>");
            }
            else
            {
                string UserStatus = Session["status"].ToString();
                if (UserStatus == "admin" || UserStatus == "hr")
                {
                    Response.Redirect("Approve");
                }
                else
                {
                    if (select_user())
                    {
                        div_showmoney.Visible = true;
                        div_menu.Visible = true;
                        btn_summit.Visible = false;
                    }
                    else
                    {

                        div_showmoney.Visible = false;
                    }

                    get_summoney();
                    data_sumusermoney();
                }
            }
         
        }
        protected void get_summoney()
        {
            sql = "select sum(mo_money) as mo_money from mon_savemoney where mo_money_active = 'Approve'";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count >0)
            {
                lb_summoney.Text = dt.Rows[0]["mo_money"].ToString();
            }
        }
        protected void data_sumusermoney()
        {
            string empid = "";
            if (Session["userid"] != null)
            {
                empid = Session["userid"].ToString();
            }
            sql = "select sum(mo_money) as money from mon_savemoney  where mo_empid = '" + empid + "' and mo_money_active='Approve'";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                lbl_sumusermoney.Text = dt.Rows[0]["money"].ToString();
            }
        }
        public bool select_user()
        {
            bool result = false;
            string empid = "";
            if (Session["userid"] != null)
            {
                empid = Session["userid"].ToString();
            }
            sql = "select * from mon_account where ma_empid='" + empid +"'";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if(dt.Rows.Count > 0)
            {
                result = true;
            }
            
            return result;
        }
        
        public Boolean insert_user()
        {
            Boolean bl = false;
                string empid = "";
                if (Session["userid"] != null)
                {
                    empid = Session["userid"].ToString();
                }
                if (select_user() == false)
                {
                    sql = "insert into mon_account (ma_empid) values('" + empid + "')";
                    
                    if (cl_Sql.Modify(sql))
                    {
                        return bl = true;
                    }
                }
            return bl;
        }

        protected void btn_adduser_ServerClick(object sender, EventArgs e)
        {
            if (insert_user())
            {
                Response.Write("<script>alert('success'); window.location.href='Default.aspx';</script>");
            }
            else
            {
                Response.Write("<script>alert(' NO success');</script>");
            }
        }
    }
}