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
    public partial class ColorRed : System.Web.UI.Page
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
                    btn_print.Visible = true;
                }
            }
            else
            {
                btn_submit.Visible = true;
                btn_next11.Visible = false;
                btn_print.Visible = false;
            }
        }

        public string Reportyl()
        {
            string result = "";

            string m_id = "";
            m_id = Request.QueryString["id"].ToString();

            sql = "SELECT * FROM mentalhealt_dass21 WHERE m_id = '" + m_id + "';";

            dt = new DataTable(); //ต้อง new data table ใหม่ทุกครั้งเมื่อรับค่า
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0) //หาข้อมูลว่ามีบรรทัดนั้นหรือไม่ 
            {
                string script = "";
                for (int i = 1; i <= 20; i++)
                {
                    string dass = "dass_" + i.ToString();
                    result = dt.Rows[0][dass].ToString();
                    if (result == "1")
                    {
                        script = script + "document.getElementById('DASS_" + i.ToString() + "_01').checked = true; ";
                    }else if (result == "2")
                    {
                        script = script + "document.getElementById('DASS_" + i.ToString() + "_02').checked = true; ";
                    }else if (result == "3")
                    {
                        script = script + "document.getElementById('DASS_" + i.ToString() + "_03').checked = true; ";
                    }
                    else
                    {

                    }
                }
                script = "<script>" + script + " function PrintReport(){ " + script + " }</script>";
                lb_script.Text = script;

                result = dt.Rows[0]["question_type"].ToString();
            }


            return result;
        }

        public Boolean InsertDataDass()
        {
            Boolean result = false;

            string m_id = "";
            m_id = Request.QueryString["id"];

            string type1 = txtH_link.Value.ToString().Trim();
            string phq9_y = txtH_link_phq9.Value.ToString().Trim();
            string gad7_y = txtH_link_gad7.Value.ToString().Trim();
            string spst20_y = txtH_link_spst20.Value.ToString().Trim();
            

            string dass1 = txtH_DASS1.Value.ToString().Trim();
            string dass2 = txtH_DASS2.Value.ToString().Trim();
            string dass3 = txtH_DASS3.Value.ToString().Trim();
            string dass4 = txtH_DASS4.Value.ToString().Trim();
            string dass5 = txtH_DASS5.Value.ToString().Trim();
            string dass6 = txtH_DASS6.Value.ToString().Trim();
            string dass7 = txtH_DASS7.Value.ToString().Trim();
            string dass8 = txtH_DASS8.Value.ToString().Trim();
            string dass9 = txtH_DASS9.Value.ToString().Trim();
            string dass10 = txtH_DASS10.Value.ToString().Trim();
            string dass11 = txtH_DASS11.Value.ToString().Trim();
            string dass12 = txtH_DASS12.Value.ToString().Trim();
            string dass13 = txtH_DASS13.Value.ToString().Trim();
            string dass14 = txtH_DASS14.Value.ToString().Trim();
            string dass15 = txtH_DASS15.Value.ToString().Trim();
            string dass16 = txtH_DASS16.Value.ToString().Trim();
            string dass17 = txtH_DASS17.Value.ToString().Trim();
            string dass18 = txtH_DASS18.Value.ToString().Trim();
            string dass19 = txtH_DASS19.Value.ToString().Trim();
            string dass20 = txtH_DASS20.Value.ToString().Trim();
            string dass21 = txtH_DASS21.Value.ToString().Trim();

            sql = "select * from mentalhealt_dass21 where m_id = '" + m_id + "' ";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                //Response.Redirect("Default.aspx");

                sql = "UPDATE mentalhealt_dass21 SET " +
                    "question_type = '" + type1 + "', dass_1 = '" + dass1 + "', dass_2 = '" + dass2 + "', dass_3 = '" + dass3 + "', dass_4 = '" + dass4 + "', dass_5 = '" + dass5 + "', dass_6 = '" + dass6 + "', dass_7 = '" + dass7 + "' ,  "+
                    "dass_8 = '" + dass8 + "', dass_9 = '" + dass9 + "', dass_10 = '" + dass10 + "', dass_11 = '" + dass11 + "', dass_12 = '" + dass12 + "', dass_13 = '" + dass13 + "', dass_14 = '" + dass14 + "' ,  "+
                    "dass_15 = '" + dass15 + "', dass_16 = '" + dass16 + "', dass_17 = '" + dass17 + "', dass_18 = '" + dass18 + "', dass_19 = '" + dass19 + "', dass_20 = '" + dass20 + "', dass_21 = '" + dass21 + "'" +
                    " WHERE m_id = '" + m_id + "'; ";

                if (CL_Sql.Modify(sql))
                {
                    result = true;
                }

            }
            else
            {
                sql = "INSERT INTO mentalhealt_dass21" +
                "(m_id, question_type, dass_1, dass_2, dass_3, dass_4, dass_5, dass_6, dass_7, dass_8, dass_9, dass_10, dass_11, dass_12, dass_13, dass_14, dass_15, dass_16, dass_17, dass_18, dass_19, dass_20, dass_21, phq9, gad7, spst20)" +
                "VALUES('" + m_id + "', '" + type1 + "', '" + dass1 + "', '" + dass2 + "', '" + dass3 + "', '" + dass4 + "', '" + dass5 + "', '" + dass6 + "', '" + dass7 + "', '" + dass8 + "', '" + dass9 + "', '" + dass10 + "', '" + dass11 + "', '" + dass12 + "', '" + dass13 + "', '" + dass14 + "', '" + dass15 + "', '" + dass16 + "', '" + dass17 + "', '" + dass18 + "', '" + dass19 + "', '" + dass20 + "', '" + dass21 + "', '" + phq9_y + "', '" + gad7_y + "', '" + spst20_y + "');";

                if (CL_Sql.Modify(sql))
                {
                    result = true;
                }
            }

            return result;
        }



        protected void btn_submit_ServerClick(object sender, EventArgs e)
        {
            string m_id = "";
            string txtlink1 = txtH_link_gad7.Value.ToString().Trim();
            string txtlink2 = txtH_link_spst20.Value.ToString().Trim();
            string txtlink3 = txtH_link_phq9.Value.ToString().Trim();

            m_id = Request.QueryString["id"];

            if (InsertDataDass())
            {

                string link = txtH_link.Value.ToString();

                if (link == "GAD7")
                {
                    Response.Redirect("ColorRedGAD7Positive.aspx?id=" + m_id + "&gad7=" + txtlink1 + "&spst20=" + txtlink2 + "&phq9=" + txtlink3);
                }
                else if (link == "SPST20")
                {
                    Response.Redirect("ColorRedSPST20Positive.aspx?id=" + m_id + "&spst20=" + txtlink2 + "&phq9=" + txtlink3);
                }
                else if(link == "PHQ9")
                {
                    Response.Redirect("ColorRedPHQ9Positive.aspx?id=" + m_id + "&phq9=" + txtlink3);
                } 
                
                else
                {
                    Response.Redirect("Result.aspx?id=" + m_id + "&type=ColorRednegative");
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
                
                 if (color1 == "GAD7")
                {
                    Response.Redirect("GAD7.aspx?id=" + m_id + "&report=yes");
                }
                else if (color1 == "SPST20")
                {
                    Response.Redirect("SPST20.aspx?id=" + m_id + "&report=yes");
                }
                else if(color1 == "PHQ9")
                {
                    Response.Redirect("PHQ9.aspx?id=" + m_id + "&report=yes");
                }
                else
                {

                }

            }
        }
    }
}