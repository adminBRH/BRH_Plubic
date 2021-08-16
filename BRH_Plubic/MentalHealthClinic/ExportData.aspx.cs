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
    public partial class ExportData : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass CL_Sql = new SQLclass();
        string m_id = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SelectData("mentalhealthrecord");
            }
            
        }

        public Boolean SelectData(string table)
        {
            Boolean result = false;


            sql = "SELECT * FROM " + table;

            dt = new DataTable(); //ต้อง new data table ใหม่ทุกครั้งเมื่อรับค่า
            dt = CL_Sql.select(sql);

            if (dt.Rows.Count > 0) //หาข้อมูลว่ามีบรรทัดนั้นหรือไม่ 
            {
                result = true;
            }

            GridView1.DataSource = dt;
            GridView1.DataBind();


                return result;
        }

        protected void select_table_SelectedIndexChanged(object sender, EventArgs e)
        {
            string val = ddl_table.SelectedValue.ToString();

            string table = "";

            if (val == "dass21")
            {
                table = "mentalhealt_dass21";
            }
            else if (val == "yellow")
            {
                table = "mentalhealt_temp_yellow";
            }
            else if (val == "phq9")
            {
                table = "mentalhealt_phq9";
            }
            else if (val == "phq8")
            {
                table = "mentalhealt_phq8";
            }
            else if (val == "gad7")
            {
                table = "mentalhealt_gad7";
            }
            else if (val == "SPST20")
            {
                table = "mentalhealt_spst20";
            }
            else
            {
                table = "mentalhealthrecord";
            }

            SelectData(table);
        }
    }
}