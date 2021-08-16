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
    public partial class ScreenCovidBeforToWorkReport : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Login"] != null)
            {
                string status = Session["status"].ToString();
                if (status == "admin" || status == "brh")
                {
                    Session["BeforToWork"] = "Print";
                    if (!IsPostBack)
                    {
                        Grid1();
                    }
                }
                else
                {
                    Response.Write("<script>alert('คุณไม่มีสิทธิ์ใช้งานหน้านี้ !!'); window.location.href='Default.aspx';</script>");
                }
            }
            else
            {
                Response.Write("<script>alert('กรุณา Login ก่อนเข้าใช้งาน !!'); window.location.href='Default.aspx';</script>");
            }
        }

        public Boolean Grid1()
        {
            Boolean bl = false;

            sql = "select s.*,concat(sc_fname,' ',sc_lname) as 'sc_fullname' ,c.cp_name_en,c.cp_name_th from screencovid as s " +
                "left join( " +
                "    select 0 as 'cp_id', 'BRH' as 'cp_name_en', 'รพ.กรุงเทพระยอง' as 'cp_name_th' " +
                "        Union " +
                "    select cp_id, cp_name_en, cp_name_th from company as c " +
                ") as c on c.cp_id = s.cp_id where s.cp_id<>'BRH' " +
                "order by s.sc_id desc ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0) {
                GridView1.DataSource = dt;
                GridView1.DataBind();
                bl = true;
            }
            else
            {
                GridView1.DataBind();
            }

            return bl;
        }
    }
}