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
    public partial class PHQ9 : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass CL_Sql = new SQLclass();
        string id = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["report"] != null)
            {
                if (Request.QueryString["report"].ToString() == "yes")
                {
                    Reportyl();
                    btn_submit.Visible = false;
                    printdiv.Visible = true;
                }
            }
            else
            {
                btn_submit.Visible = true;
                btn_next11.Visible = false;
                printdiv.Visible = false;
            }
        }

        public string Reportyl()
        {
            string result = "";

            string m_id = "";
            m_id = Request.QueryString["id"].ToString();

            sql = "SELECT * FROM mentalhealt_phq9 WHERE m_id = '" + m_id + "';";

            dt = new DataTable(); //ต้อง new data table ใหม่ทุกครั้งเมื่อรับค่า
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0) //หาข้อมูลว่ามีบรรทัดนั้นหรือไม่ 
            {
                string script = "";
                for (int i = 1; i <= 10; i++)
                {
                    string phq9 = "phq_" + i.ToString();
                    result = dt.Rows[0][phq9].ToString();
                    if (result == "1")
                    {
                        script = script + "document.getElementById('PHQ9_" + i.ToString() + "_01').checked = true; ";
                    }
                    else if (result == "2")
                    {
                        script = script + "document.getElementById('PHQ9_" + i.ToString() + "_02').checked = true; ";
                    }
                    else if (result == "3")
                    {
                        script = script + "document.getElementById('PHQ9_" + i.ToString() + "_03').checked = true; ";
                    }
                    else
                    {

                    }
                }

                script = "<script>" + script + "function PrintReport(){ " + script + " }</script>";
                lb_script.Text = script;

                result = dt.Rows[0]["type_status"].ToString();
            }

            return result;
        }

        public Boolean InsertDataPHQ9()
        {
            Boolean result = false;

            string m_id = id;
            m_id = Request.QueryString["id"];

            string phq1 = txtH_PHQ1.Value.ToString().Trim();
            string phq2 = txtH_PHQ2.Value.ToString().Trim();
            string phq3 = txtH_PHQ3.Value.ToString().Trim();
            string phq4 = txtH_PHQ4.Value.ToString().Trim();
            string phq5 = txtH_PHQ5.Value.ToString().Trim();
            string phq6 = txtH_PHQ6.Value.ToString().Trim();
            string phq7 = txtH_PHQ7.Value.ToString().Trim();
            string phq8 = txtH_PHQ8.Value.ToString().Trim();
            string phq9 = txtH_PHQ9.Value.ToString().Trim();
            string phq10 = txtH_PHQ10.Value.ToString().Trim();
            string txt_link = txtH_link.Value.ToString().Trim();

            sql = "select * from mentalhealt_phq9 where m_id = '" + m_id + "' ";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                sql = "UPDATE mentalhealt_phq9 SET phq_1 = '" + phq1 + "', phq_2 = '" + phq2 + "', phq_3 = '" + phq3 + "', phq_4 = '" + phq4 + "', phq_5 = '" + phq5 + "', phq_6 = '" + phq6 + "', phq_7 = '" + phq7 + "', phq_8 = '" + phq8 + "', phq_9 = '" + phq9 + "', " +
                    "mentalhealt_phq8 = 'yes', type_status = '" + txt_link + "', phq_10 = '" + phq10 + "'" +
                    " WHERE m_id = '" + m_id + "'; ";

                if (CL_Sql.Modify(sql))
                {
                    result = true;
                }
            }
            else
            {
                sql = "INSERT INTO mentalhealt_phq9" + "(m_id, phq_1, phq_2, phq_3, phq_4, phq_5, phq_6, phq_7, phq_8, phq_9, mentalhealt_phq8, type_status, phq_10)" +
                  "VALUES('" + m_id + "', '" + phq1 + "', '" + phq2 + "', '" + phq3 + "', '" + phq4 + "', '" + phq5 + "', '" + phq6 + "', '" + phq7 + "', '" + phq8 + "', '" + phq9 + "', 'yes', '" + txt_link + "', '" + phq10 + "');";

                if (CL_Sql.Modify(sql))
                {
                    result = true;
                }
            }

            return result;
        }

        public Boolean selectdata(string id, string filed)
        {
            Boolean bl = false;

            string m_id = "";
            m_id = Request.QueryString["id"].ToString();

            sql = "SELECT * FROM mentalhealt_dass21 where " + filed + " = 'yes' and m_id = '" + id + "' ;";

            dt = new DataTable(); //ต้อง new data table ใหม่ทุกครั้งเมื่อรับค่า
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0) //หาข้อมูลว่ามีบรรทัดนั้นหรือไม่ 
            {
                bl = true;
            }
            return bl;
        } 

        protected void btn_submit_ServerClick(object sender, EventArgs e)
        {

            string m_id = id;
            m_id = Request.QueryString["id"];

            string txtA = "";
            if (Request.QueryString["gad7"] != null)
            {
                txtA = Request.QueryString["gad7"].ToString();
            }

            string txtS = "";
            if (Request.QueryString["spst20"] != null)
            {
                txtS = Request.QueryString["spst20"].ToString();
            }

            string txtD = "";
            if (Request.QueryString["phq9"] != null)
            {
                txtD = Request.QueryString["phq9"].ToString();
            }

            if (InsertDataPHQ9())
            {
                string link = txtH_link.Value.ToString();

                if (link == "PHQ8")
                {
                    Response.Redirect("PHQ9positive.aspx?id=" + m_id + "&spst20=" + txtS + "&phq9=" + txtD);
                }
                else
                {     
                    Response.Redirect("Result.aspx?id=" + m_id + "&type=PHQ9negative");                
                }
            }
        }

        protected void btn_next11_Click(object sender, EventArgs e)
        {
            string m_id = "";
            
            if (Request.QueryString["id"] != null)
            {
                m_id = Request.QueryString["id"].ToString(); 

                string color1 = Reportyl();

                if (color1 == "PHQ8")
                {
                    Response.Redirect("PHQ8.aspx?id=" + m_id + "&report=yes");
                }
                else
                {                   
                    Response.Redirect("Default.aspx?id=" + m_id + "&report=yes");                 
                }
            }
        }
    }
}