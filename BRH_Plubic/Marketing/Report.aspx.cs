using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;

namespace BRH_Plubic.Marketing
{
    public partial class Report : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass CL_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Login"] == null)
            {
                Response.Write("<script>alert('ไม่มีสิทธิ์ใช้งานกรุณา Login !!'); window.location.href='Default.aspx';</script>");
            }
            else
            {
                string status = Session["status"].ToString();
                if (status == "admin" || status == "finance" || status == "marketing")
                {
                    if (!IsPostBack)
                    {
                        Grid1("", "", "", "", "", "", "");
                    }
                }
                else
                {
                    Response.Write("<script>alert('คุณไม่มีสิทธิ์ใช้งานหน้านี้ !!'); window.location.href='Default.aspx';</script>");
                }

            }
            
            
        }

        public Boolean Grid1(string id, string date, string name, string phone, string paystatus, string send, string receive)
        {
            Boolean bl = false;

            sql = "select * ,concat(hd_fname,' ',hd_lname) as 'name' ,concat(hd_dateslip,' ',hd_timeslip) as 'PayDatetime' " +
                "from marketingheader where " +
                "hd_id like '%" + id + "%' " +
                "and convert(hd_date,date) like '%" + date + "%' " +
                "and concat(hd_fname,' ',hd_lname) like '%" + name + "%' " +
                "and hd_pnumber like '%" + phone + "%' " +
                "and hd_shippingstatus like '%" + send + "%' " +
                "and hd_paystatus like '%" + paystatus + "%' " +
                "and hd_receive like '%" + receive + "%' " +
                "order by hd_id desc ";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                bl = true;
            }

            GridView1.DataSource = dt;
            GridView1.DataBind();

            return bl;
        }

        protected void btn_search_ServerClick(object sender, EventArgs e)
        {
            string id = txt_id.Value.ToString().Trim();
            string date = date_order.Value;
            if (date != "") { date = DateTime.Parse(date_order.Value).ToString("yyyy-MM-dd"); } 
            string name = txt_name.Value.ToString().Trim();
            string phone = txt_phone.Value.ToString().Trim();
            string PayStatus = DD_PayStatus.SelectedValue.ToString();
            string Send = DD_Send.SelectedValue.ToString();
            string receive = DD_Receive.SelectedValue.ToString();

            Grid1(id, date, name, phone, PayStatus, Send, receive);
        }
    }
}