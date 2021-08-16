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
    public partial class GAD7 : System.Web.UI.Page
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
                    btn_submit_gad7.Visible = false;
                    printdiv.Visible = true;
                }
            }
            else
            {
                btn_submit_gad7.Visible = true;
                btn_next11.Visible = false;
                printdiv.Visible = false;
            }
        }

        public string Reportyl()
        {
            string result = "";

            string m_id = "";
            m_id = Request.QueryString["id"].ToString();

            sql = "SELECT * FROM mentalhealt_gad7 WHERE m_id = '" + m_id + "';";

            dt = new DataTable(); //ต้อง new data table ใหม่ทุกครั้งเมื่อรับค่า
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0) //หาข้อมูลว่ามีบรรทัดนั้นหรือไม่ 
            {
                string script = "";
                for (int i = 1; i <= 7; i++)
                {
                    string gad7 = "gad_" + i.ToString();
                    result = dt.Rows[0][gad7].ToString();

                    if (result == "1")
                    {
                        script = script + "document.getElementById('GAD7_" + i.ToString() + "_01').checked = true; ";
                    }
                    else if (result == "2")
                    {
                        script = script + "document.getElementById('GAD7_" + i.ToString() + "_02').checked = true; ";
                    }
                    else if (result == "3")
                    {
                        script = script + "document.getElementById('GAD7_" + i.ToString() + "_03').checked = true; ";
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

        public Boolean InsertDataGAD7()
        {
            Boolean result = false;

            string m_id = id;
            m_id = Request.QueryString["id"];

            string gad7_1 = txtH_GAD71.Value.ToString().Trim();
            string gad7_2 = txtH_GAD72.Value.ToString().Trim();
            string gad7_3 = txtH_GAD73.Value.ToString().Trim();
            string gad7_4 = txtH_GAD74.Value.ToString().Trim();
            string gad7_5 = txtH_GAD75.Value.ToString().Trim();
            string gad7_6 = txtH_GAD76.Value.ToString().Trim();
            string gad7_7 = txtH_GAD77.Value.ToString().Trim();

            sql = "select * from mentalhealt_gad7 where m_id = '" + m_id + "' ";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                sql = "UPDATE mentalhealt_gad7 SET gad_1 = '" + gad7_1 + "', gad_2 = '" + gad7_2 + "', gad_3 = '" + gad7_3 + "', gad_4 = '" + gad7_4 + "', gad_5 = '" + gad7_5 + "', gad_6 = '" + gad7_6 + "', gad_7 = '" + gad7_7 + "' " +
                    "WHERE m_id = '" + m_id + "'; ";

                if (CL_Sql.Modify(sql))
                {
                    result = true;
                }
            }
            else
            {
                sql = "INSERT INTO mentalhealt_gad7" +
                  "(m_id, gad_1, gad_2, gad_3, gad_4, gad_5, gad_6, gad_7)" + "VALUES('" + m_id + "', '" + gad7_1 + "', '" + gad7_2 + "', '" + gad7_3 + "', '" + gad7_4 + "', '" + gad7_5 + "', '" + gad7_6 + "', '" + gad7_7 + "');";

                if (CL_Sql.Modify(sql))
                {
                    result = true;
                }
            }

            return result;
        }

        public Boolean selectdata(string id,string field)
        {
            Boolean bl = false;

            string m_id = "";
            m_id = Request.QueryString["id"].ToString();

            sql = "SELECT * FROM mentalhealt_dass21 where "+ field +" = 'yes' and m_id = '" + id + "' ;";

            dt = new DataTable(); //ต้อง new data table ใหม่ทุกครั้งเมื่อรับค่า
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0) //หาข้อมูลว่ามีบรรทัดนั้นหรือไม่ 
            {
                bl = true;
            }
            return bl;
        }

        protected void btn_submit_gad7_ServerClick(object sender, EventArgs e)
        {
            string m_id = id;
            m_id = Request.QueryString["id"];
         
            if (InsertDataGAD7())
            {
                string link = txtH_link.Value.ToString();
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

                if (selectdata(m_id,"spst20"))
                {
                    if (link == "GAD7Postive")
                    {
                        Response.Redirect("GAD7toSPST20pos.aspx?id=" + m_id + "&type=GAD7positive&gad7=" + txtA + "&spst20=" + txtS + "&phq9=" + txtD);
                    }
                    else
                    {
                        Response.Redirect("GAD7toSPST20neg.aspx?id=" + m_id + "&type=GAD7negative&gad7=" + txtA + "&spst20=" + txtS + "&phq9=" + txtD);
                    }
                    //Response.Redirect("ColorRedSPST20Positive.aspx?id=" + m_id + "");                   
                    //Response.Redirect("SPST20.aspx?id=" + m_id + "");
                }
                else if (selectdata(m_id,"phq9"))
                {
                    if (link == "GAD7Postive") 
                    {
                        Response.Redirect("GAD7toPHQ9pos.aspx?id=" + m_id + "&gad7=" + txtA + "&spst20=" + txtS + "&phq9=" + txtD);
                    }
                    else
                    {
                        Response.Redirect("GAD7toPHQ9neg.aspx?id=" + m_id + "&gad7=" + txtA + "&spst20=" + txtS + "&phq9=" + txtD);
                    }
                }
                else
                { 
                    if (link == "GAD7Postive")
                    {
                        Response.Redirect("Result.aspx?id=" + m_id + "&type=GAD7positive");
                    }
                    else
                    {
                        Response.Redirect("Result.aspx?id=" + m_id + "&type=GAD7negative");
                    }
                }

            }
        }

        protected void btn_next11_Click(object sender, EventArgs e)
        {
            string m_id = id;
            m_id = Request.QueryString["id"];

            string link = txtH_link.Value.ToString();

            if (selectdata(m_id,"spst20"))
            {
                Response.Redirect("SPST20.aspx?id=" + m_id + "&report=yes");
            }
            else
            {      
                Response.Redirect("Default.aspx?id=" + m_id + "&report=yes");
                
                //if (link == "GAD7Postive")
                //{
                //    Response.Redirect("Result.aspx?id=" + m_id + "&type=GAD7positive");
                //}
                //else
                //{
                //    Response.Redirect("Result.aspx?id=" + m_id + "&type=GAD7negative");
                //}
            }
        }
    }
}