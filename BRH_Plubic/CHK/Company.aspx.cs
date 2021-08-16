using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;

namespace BRH_Plubic.CHK
{
    public partial class Company : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Login"] == null)
            {
                Response.Redirect("../Default.aspx?back=CHK&login=require");
            }
            else
            {
                string status = Session["status"].ToString();
                if (status == "admin" || status == "hr" || status == "checkup" || status == "xray" || status == "mao")
                {
                    if (!IsPostBack)
                    {
                        ListDataContacts("", "Yes");
                    }
                }
                else
                {
                    Response.Write("<script>alert('คุณไม่มีสิทธิ์ ใช้งานระบบนี้ !!'); window.location.href='../Default.aspx';</script>");
                }
            }
        }

        protected void ListDataContacts(string fieldSearch, string active)
        {
            string whereField = "1";

            if (fieldSearch != "")
            {
                string TextSearch = txtH_SearchText.Value.ToString().Trim();

                switch (fieldSearch)
                {
                    case "name":
                        whereField = "(cp_name_th like '%" + TextSearch + "%' or cp_name_en like '%" + TextSearch + "%') ";
                        break;
                    case "address":
                        whereField = "cp_address like '%" + TextSearch + "%' ";
                        break;
                    case "phone":
                        whereField = "cp_phone like '%" + TextSearch + "%' ";
                        break;
                    case "email":
                        whereField = "cp_email like '%" + TextSearch + "%' ";
                        break;
                    default:
                        break;
                }
            }

            sql = "select * from company " +
                "where cp_active='" + active + "' and " + whereField + " " +
                "order by cp_active desc, cp_name_en ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {}
            listview_contacts.DataSource = dt;
            listview_contacts.DataBind();
        }

        protected void btn_search_ServerClick(object sender, EventArgs e)
        {
            string fieldSearch = txtH_fieldSearch.Value.ToString();
            string active = txtH_active.Value.ToString();
            ListDataContacts(fieldSearch, active);
        }

        protected void btn_add_ServerClick(object sender, EventArgs e)
        {
            string result = AddCompany();
            if (result == "success")
            {
                Response.Write("<script>alertModal('#Modal_Success'); setTimeout(function(){location.href='Company.aspx#div_list'} , 5000);  </script>");
            }
            else if (result == "duplicate")
            {
                Response.Write("<script>alert('Duplicate !!');</script>");
            }
            else
            {

            }
        }

        public string AddCompany()
        {
            string result = "";

            string name_th = txt_name_th.Value.ToString().Trim();
            string name_en = txt_name_en.Value.ToString().Trim();
            string address = txt_address.Value.ToString().Trim();
            string phone = txt_phone.Value.ToString().Trim();
            string email = txt_email.Value.ToString().Trim();

            sql = "select * from company where cp_name_th = '" + name_th + "' or cp_name_en = '" + name_en + "' ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                result = "duplicate";
            }
            else
            {
                sql = "insert into company(cp_name_th,cp_name_en,cp_address,cp_phone,cp_email) " +
                    "values('" + name_th + "','" + name_en + "','" + address + "','" + phone + "','" + email + "'); ";
                if (cl_Sql.Modify(sql))
                {
                    result = "success";
                }
            }

            return result;
        }

        protected void btn_update_ServerClick(object sender, EventArgs e)
        {
            string id = txtH_ID.Value.ToString();
            string result = Update(id);
            if (result == "success")
            {
                Response.Write("<script>alertModal('#Modal_Success');</script>");
            }
        }

        public string Update(string id)
        {
            string result = "";

            string name_th = "";
            string name_en = "";
            string address = "";
            string phone = "";
            string email = "";
            string active = "";

            sql = "update company " +
                "set cp_name_th='" + name_th + "', cp_name_en='" + name_en + "', cp_address='" + address + "' " +
                ", cp_phone='" + phone + "', cp_email='" + email + "', cp_active='" + active + "' " +
                "where cp_id='" + id + "' ";
            result = "success";

            return result;
        }
    }
}