using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;

namespace BRH_Plubic.MentalHealthClinic
{
    public partial class ReportDetail : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass CL_Sql = new SQLclass();
        string id = "";

   
        protected void Page_Load(object sender, EventArgs e)
        {
            SELECTDATA();
        }

        public Boolean SELECTDATA()
        {
            Boolean result = false;

            sql = "SELECT * FROM mentalhealthrecord ORDER BY m_id DESC;";

            dt = new DataTable(); //ต้อง new data table ใหม่ทุกครั้งเมื่อรับค่า
            dt = CL_Sql.select(sql);

            if (dt.Rows.Count > 0) //หาข้อมูลว่ามีบรรทัดนั้นหรือไม่
            {
                Report_user.DataSource = dt;
                Report_user.DataBind();
            }

            return result;

        }

    }
}