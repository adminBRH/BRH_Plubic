using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;
    
using System.Net;
using System.IO;

namespace BRH_Plubic.MentalHealthClinic
{
    public partial class Default : System.Web.UI.Page
    { 
        string sql = "";
        DataTable dt;
        SQLclass CL_Sql = new SQLclass();
        string m_id = "";
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["id"] != null)
            {
                Report();
                btn_next.Visible = false;
                btn_next1.Visible = true;
                printdiv.Visible = true;
            }
            else
            {
                btn_next1.Visible = false;
                printdiv.Visible = false;
                SCT_0.Checked = true;
            } 
        }

        public string InsertData(string color)
        {
            string result = "";

            string screen_temp = txtH_Score.Value.ToString();

            sql = "INSERT INTO mentalhealthrecord" +
                  "(fname, lname, color_temp, color_id, p_number, line_id)" + "VALUES('', '', '"+ color +"', '"+ screen_temp +"', NULL, NULL);";

            if (CL_Sql.Modify(sql))
            {
                
                sql = "SELECT MAX(m_id) as 'm_id' FROM mentalhealthrecord;";
                dt = new DataTable(); //ต้อง new data table ใหม่ทุกครั้งเมื่อรับค่า
                dt = CL_Sql.select(sql);

                if (dt.Rows.Count > 0) //หาข้อมูลว่ามีบรรทัดนั้นหรือไม่
                {
                    result = dt.Rows[0]["m_id"].ToString();                  
                }

            }

            return result;
        }

        public string Report()
        {
            string result = "";

            string m_id = "";
            m_id = Request.QueryString["id"].ToString();

            sql = "SELECT * FROM mentalhealthrecord WHERE m_id = '" + m_id + "';";

            dt = new DataTable(); //ต้อง new data table ใหม่ทุกครั้งเมื่อรับค่า
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0) //หาข้อมูลว่ามีบรรทัดนั้นหรือไม่ 
            {
                result = dt.Rows[0]["color_id"].ToString();
                if (result == "0")
                {
                    SCT_0.Checked = true;
                }
                else if (result == "1")
                {
                    SCT_1.Checked = true;
                }
                else if (result == "2")
                {
                    SCT_2.Checked = true;
                }
                else if (result == "3")
                {
                    SCT_3.Checked = true;
                }
                else if (result == "4")
                {
                    SCT_4.Checked = true;
                }
                else if (result == "5")
                {
                    SCT_5.Checked = true;
                }
                else if (result == "6")
                {
                    SCT_6.Checked = true;
                }
                else if (result == "7")
                {
                    SCT_7.Checked = true;
                }
                else if (result == "8")
                {
                    SCT_8.Checked = true;
                }
                else if (result == "9")
                {
                    SCT_9.Checked = true;
                }
                else if (result == "10")
                {
                    SCT_10.Checked = true;
                }
                else
                {

                }

                result = dt.Rows[0]["color_temp"].ToString();

            }
            return result;
        }

        protected void btn_next_Click(object sender, EventArgs e)
        {
            int score = int.Parse(txtH_Score.Value.ToString());
            
            string color = "";
            
                if (score >= 8)
                {               
                color = "Red";
                m_id = InsertData(color);              
                    Response.Redirect("ColorRedPositive.aspx?id=" + m_id + "");
                }
                else if (score >= 5)
                {
                color = "Yellow";
                m_id = InsertData(color);
                    Response.Redirect("Result_dass21.aspx?id=" + m_id + "");
                }
                else
                {
                color = "Green";
                m_id = InsertData(color);
                    Response.Redirect("ColorGreen.aspx?id=" + m_id + "");
                }                
        }

        protected void btn_next1_Click(object sender, EventArgs e)
        {
            string m_id = "";
            m_id = Request.QueryString["id"].ToString();

            string color1 = Report();
            if (color1 == "Yellow")
            {
                Response.Redirect("ColorYellow.aspx?id=" + m_id +"&report=yes");
            }else if (color1 == "Red")
            {
                Response.Redirect("ColorRed.aspx?id=" + m_id + "&report=yes");
            }
        }
    }
}