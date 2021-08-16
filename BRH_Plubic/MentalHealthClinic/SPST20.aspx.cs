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
    public partial class SPST20 : System.Web.UI.Page
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
                    if (Request.QueryString["id"] != null)
                    {
                        Reportyl();
                    }
                    btn_submit_spst20.Visible = false;
                    printdiv.Visible = true;
                }
            }
            else
            {
                btn_submit_spst20.Visible = true;
                btn_next11.Visible = false;
                printdiv.Visible = false;
            }
        }

        public string Reportyl()
        {
            string result = "";

            string m_id = "";
            m_id = Request.QueryString["id"].ToString();

            sql = "SELECT * FROM mentalhealt_spst20 WHERE m_id = '" + m_id + "';";
            dt = new DataTable(); //ต้อง new data table ใหม่ทุกครั้งเมื่อรับค่า
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0) //หาข้อมูลว่ามีบรรทัดนั้นหรือไม่ 
            {
                string script = "";
                for (int i = 1; i <= 20; i++)
                {
                    string spst20 = "spst_" + i.ToString();
                    result = dt.Rows[0][spst20].ToString();

                    if (result == "2")
                    {
                        script = script + "document.getElementById('SPST20_" + i.ToString() + "_02').checked = true; ";
                    }
                    else if (result == "3")
                    {
                        script = script + "document.getElementById('SPST20_" + i.ToString() + "_03').checked = true; ";
                    }
                    else if (result == "4")
                    {
                        script = script + "document.getElementById('SPST20_" + i.ToString() + "_04').checked = true; ";
                    }
                    else if (result == "5")
                    {
                        script = script + "document.getElementById('SPST20_" + i.ToString() + "_05').checked = true; ";
                    }
                    else
                    {

                    }
                }
                script = "<script>" + script + "function PrintReport(){ " + script + " }</script>";
                lb_script.Text = script;
            }
            return result;
        }

        public Boolean InsertDataSPST20()
        {
            Boolean result = false;
            string m_id = id;
            m_id = Request.QueryString["id"];

            string spst20_1 = txtH_SPST20_1.Value.ToString().Trim();
            string spst20_2 = txtH_SPST20_2.Value.ToString().Trim();
            string spst20_3 = txtH_SPST20_3.Value.ToString().Trim();
            string spst20_4 = txtH_SPST20_4.Value.ToString().Trim();
            string spst20_5 = txtH_SPST20_5.Value.ToString().Trim();
            string spst20_6 = txtH_SPST20_6.Value.ToString().Trim();
            string spst20_7 = txtH_SPST20_7.Value.ToString().Trim();
            string spst20_8 = txtH_SPST20_8.Value.ToString().Trim();
            string spst20_9 = txtH_SPST20_9.Value.ToString().Trim();
            string spst20_10 = txtH_SPST20_10.Value.ToString().Trim();
            string spst20_11 = txtH_SPST20_11.Value.ToString().Trim();
            string spst20_12 = txtH_SPST20_12.Value.ToString().Trim();
            string spst20_13 = txtH_SPST20_13.Value.ToString().Trim();
            string spst20_14 = txtH_SPST20_14.Value.ToString().Trim();
            string spst20_15 = txtH_SPST20_15.Value.ToString().Trim();
            string spst20_16 = txtH_SPST20_16.Value.ToString().Trim();
            string spst20_17 = txtH_SPST20_17.Value.ToString().Trim();
            string spst20_18 = txtH_SPST20_18.Value.ToString().Trim();
            string spst20_19 = txtH_SPST20_19.Value.ToString().Trim();
            string spst20_20 = txtH_SPST20_20.Value.ToString().Trim();

            sql = "select * from mentalhealt_spst20 where m_id = '" + m_id + "' ";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                sql = "UPDATE mentalhealt_spst20 SET " +
                    "spst_1 = '" + spst20_1 + "', spst_2 = '" + spst20_2 + "', spst_3 = '" + spst20_3 + "', spst_4 = '" + spst20_4 + "', spst_5 = '" + spst20_5 + "'," + 
                    "spst_6 = '" + spst20_6 + "', spst_7 = '" + spst20_7 + "', spst_8 = '" + spst20_8 + "', spst_9 = '" + spst20_9 + "', spst_10 = '" + spst20_10 + "', " + 
                    "spst_11 = '" + spst20_11 + "', spst_12 = '" + spst20_12 + "', spst_13 = '" + spst20_13 + "', spst_14 = '" + spst20_14 + "', spst_15 = '" + spst20_15 + "'," + 
                    "spst_16 = '" + spst20_16 + "', spst_17 = '" + spst20_17 + "', spst_18 = '" + spst20_18 + "', spst_19 = '" + spst20_19 + "', spst_20 = '" + spst20_20 + "'" +
                    "WHERE m_id = '" + m_id + "'; ";

                if (CL_Sql.Modify(sql))
                {
                    result = true;
                }
            }
            else
            {
                sql = "INSERT INTO mentalhealt_spst20" +
                  "(m_id, spst_1, spst_2, spst_3, spst_4, spst_5, spst_6, spst_7, spst_8, spst_9, spst_10, spst_11, spst_12, spst_13, spst_14, spst_15, spst_16, spst_17, spst_18, spst_19, spst_20)" +
                  "VALUES('" + m_id + "', '" + spst20_1 + "', '" + spst20_2 + "', '" + spst20_3 + "', '" + spst20_4 + "', '" + spst20_5 + "', '" + spst20_6 + "', '" + spst20_7 + "', '" + spst20_8 + "', '" + spst20_9 + "', '" + spst20_10 + "', '" + spst20_11 + "', '" + spst20_12 + "', '" + spst20_13 + "', '" + spst20_14 + "', '" + spst20_15 + "', '" + spst20_16 + "', '" + spst20_17 + "', '" + spst20_18 + "', '" + spst20_19 + "', '" + spst20_20 + "');";

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

        protected void btn_submit_spst20_ServerClick(object sender, EventArgs e)
        {
            string m_id = id;
            m_id = Request.QueryString["id"].ToString();


           

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

            if (InsertDataSPST20())
            {
                string link = txtH_link.Value.ToString();

                if (selectdata(m_id, "phq9"))
                {
                    if (link == "SPST20Positive")
                    {
                        Response.Redirect("SPSTtoPHQ9pos.aspx?id=" + m_id + "&type=SPST20positive&spst20=" + txtS + "&phq9=" + txtD);
                    }
                    else
                    {
                        Response.Redirect("SPSTtoPHQ9neg.aspx?id=" + m_id + "&type=SPST20negative&spst20=" + txtS + "&phq9=" + txtD);
                    }
                    //Response.Redirect("ColorRedPHQ9Positive.aspx?id=" + m_id + "");
                }
                else
                {
                    if (link == "SPST20Positive")
                    {
                        Response.Redirect("Result.aspx?id=" + m_id + "&type=SPST20positive");
                    }
                    else
                    {
                        Response.Redirect("Result.aspx?id=" + m_id + "&type=SPST20negative");
                    }
                }
            }
        }

        protected void btn_next11_Click1(object sender, EventArgs e)
        {
            string m_id = id;
            m_id = Request.QueryString["id"];

            string link = txtH_link.Value.ToString();

            if (selectdata(m_id, "phq9"))
            {
                Response.Redirect("PHQ9.aspx?id=" + m_id + "&report=yes");
            }
            else
            {
                Response.Redirect("Default.aspx?id=" + m_id + "&report=yes");

            }
        }
    }
}