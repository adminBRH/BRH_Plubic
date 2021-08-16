using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;

namespace BRH_Plubic.Appointment
{
    public partial class Default : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_search_Click(object sender, EventArgs e)
        {
            string diag = txt_diag.Value.ToString().Trim();
            if (diag != "")
            {
                string[] diag_ar = diag.Split(' ');
                for (int i = 0; i < diag_ar.Length; i++)
                {
                    if (diag_ar[i].ToString() != "")
                    {
                        Response.Write("<script>alert('" + diag_ar[i].ToString() + "');</script>");
                        //SelectDepartment(diag_ar[i].ToString());
                    }
                }
            }
        }

        public string SelectDepartment(string key)
        {
            string result = "";

            sql = "select * from criteriabooking where cb_detail like '%" + key + "%' ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                result = dt.Rows[0]["cb_department"].ToString();
            }

            return result;
        }
    }
}