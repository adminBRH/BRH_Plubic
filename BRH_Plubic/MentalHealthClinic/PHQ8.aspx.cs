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
    public partial class PHQ8 : System.Web.UI.Page
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
                    btn_submit_phq8.Visible = false;
                    printdiv.Visible = true;
                }
            }
            else
            {
                btn_submit_phq8.Visible = true;
                btn_next11.Visible = false;
                printdiv.Visible = false;
            }
        }

        public string Reportyl()
        {
            string result = "";

            string m_id = "";
            m_id = Request.QueryString["id"].ToString();

            sql = "SELECT * FROM mentalhealt_phq8 WHERE m_id = '" + m_id + "';";

            dt = new DataTable(); //ต้อง new data table ใหม่ทุกครั้งเมื่อรับค่า
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0) //หาข้อมูลว่ามีบรรทัดนั้นหรือไม่ 
            {
                string script = "";
                for (int i = 1; i <= 9; i++)
                {
                    string phq8 = "phq8_" + i.ToString();
                    result = dt.Rows[0][phq8].ToString();
                    if (result != "0")
                    {
                        script = script + "document.getElementById('PHQ8_" + i.ToString() + "_01').checked = true; ";
                    }
                    else
                    {

                    }
                }
                script = "<script>" + script + " function PrintReport(){ " + script + " }</script>";
                lb_script.Text = script;

                
            }


            return result;
        }

        public Boolean InsertPHQ8()
        {
            Boolean result = false;

            string m_id = id;
            m_id = Request.QueryString["id"];

            string phq8_1 = txtH_PHQ81.Value.ToString().Trim();
            string phq8_2 = txtH_PHQ82.Value.ToString().Trim();
            string phq8_3 = txtH_PHQ83.Value.ToString().Trim();
            string phq8_4 = txtH_PHQ84.Value.ToString().Trim();
            string phq8_5 = txtH_PHQ85.Value.ToString().Trim();
            string phq8_6 = txtH_PHQ86.Value.ToString().Trim();
            string phq8_7 = txtH_PHQ87.Value.ToString().Trim();
            string phq8_8 = txtH_PHQ88.Value.ToString().Trim();
            string phq8_9 = txtH_PHQ89.Value.ToString().Trim();

            sql = "select * from mentalhealt_phq8 where m_id = '" + m_id + "' ";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                sql = "UPDATE mentalhealt_phq8 SET phq8_1 = '" + phq8_1 + "', phq8_2 = '" + phq8_2 + "', phq8_3 = '" + phq8_3 + "', phq8_4 = '" + phq8_4 + "', phq8_5 = '" + phq8_5 + "', phq8_6 = '" + phq8_6 + "', phq8_7 = '" + phq8_7 + "', phq8_8 = '" + phq8_8 + "', phq8_9 = '" + phq8_9 + "'" +
                    " WHERE m_id = '" + m_id + "'; ";

                if (CL_Sql.Modify(sql))
                {
                    result = true;
                }

            }
            else
            {
                sql = "INSERT INTO mentalhealt_phq8" +
                  "(m_id, phq8_1, phq8_2, phq8_3, phq8_4, phq8_5, phq8_6, phq8_7, phq8_8, phq8_9)" +
                  "VALUES('" + m_id + "', '" + phq8_1 + "', '" + phq8_2 + "', '" + phq8_3 + "', '" + phq8_4 + "', '" + phq8_5 + "', '" + phq8_6 + "', '" + phq8_7 + "', '" + phq8_8 + "', '" + phq8_9 + "');";

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

        protected void btn_submit_phq8_ServerClick(object sender, EventArgs e)
        {
            string m_id = id;
            m_id = Request.QueryString["id"].ToString();

            if (InsertPHQ8())
            {
                string link = txtH_link.Value.ToString();               
                  if (link == "PHQ8Positive")
                  {
                      Response.Redirect("Result.aspx?id=" + m_id + "&type=PHQ8positive");
                  }
                   else
                   {
                      Response.Redirect("Result.aspx?id=" + m_id + "&type=PHQ8negative");
                   }                 
            }
        }

        protected void btn_next11_Click(object sender, EventArgs e)
        {

            //string m_id = "";
            //m_id = Request.QueryString["id"].ToString();

            //if (selectdata(m_id, "gad7"))
            //{
            //    Response.Redirect("GAD7.aspx?id=" + m_id + "&report=yes");
            //}
            //else
            //{
            //    if (selectdata(m_id, "spst20"))
            //    {
            //        Response.Redirect("SPST20.aspx?id=" + m_id + "&report=yes");
            //    }
            //    else
            //    {
            //        Response.Redirect("Default.aspx?id=" + m_id + "&report=yes");
            //    }
            //}
        }
    } 
}