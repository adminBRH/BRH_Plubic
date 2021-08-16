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
    public partial class ColorYellow : System.Web.UI.Page
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
                    btn_submit_yellow.Visible = false;
                    printdiv.Visible = true;
                }
            }
            else
            { 
                btn_submit_yellow.Visible = true;
                btn_next11.Visible = false;
                printdiv.Visible = false;
            }

        }

        public string Reportyl()
        {
            string result = "";

            string m_id = "";
            m_id = Request.QueryString["id"].ToString();

            sql = "SELECT * FROM mentalhealt_temp_yellow WHERE m_id = '" + m_id + "';";

            dt = new DataTable(); //ต้อง new data table ใหม่ทุกครั้งเมื่อรับค่า
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0) //หาข้อมูลว่ามีบรรทัดนั้นหรือไม่ 
            {
                string script = "";
                int sum_1 = 0;
                int sum_2 = 0;
                int sum_3 = 0;

                for (int i = 1; i <= 15; i++)
                {
                    string yel = "yel_" + i.ToString();
                    result = dt.Rows[0][yel].ToString();
                    if (result == "1")
                    {
                        if (i>=1 && i<=5)
                        {
                            sum_1 = sum_1 + 1;
                        }
                        if (i>=6 && i<=10)
                        {
                            sum_2 = sum_2 + 1;
                        }
                        if (i>=11 && i<=15)
                        {
                            sum_3 = sum_3 + 1;
                        }
                        script = script + "document.getElementById('Yel_" + i.ToString() + "_2').checked = true; ";
                    }
                }
                lbl_summary_1.Text = sum_1.ToString();
                lbl_summary_2.Text = sum_2.ToString();
                lbl_summary_3.Text = sum_3.ToString();

                script = "<script>" + script + "function PrintReport(){ " + script + " }</script>";
                lb_script.Text = script;
            }


                return result;
        }

        public Boolean InsertDataYellow()
        {
            Boolean result = false;

            string m_id = id;
            m_id = Request.QueryString["id"];

            string yel_1 = txtH_Yel_1.Value.ToString().Trim();
            string yel_2 = txtH_Yel_2.Value.ToString().Trim();
            string yel_3 = txtH_Yel_3.Value.ToString().Trim();
            string yel_4 = txtH_Yel_4.Value.ToString().Trim();
            string yel_5 = txtH_Yel_5.Value.ToString().Trim();
            string yel_6 = txtH_Yel_6.Value.ToString().Trim();
            string yel_7 = txtH_Yel_7.Value.ToString().Trim();
            string yel_8 = txtH_Yel_8.Value.ToString().Trim();
            string yel_9 = txtH_Yel_9.Value.ToString().Trim();
            string yel_10 = txtH_Yel_10.Value.ToString().Trim();
            string yel_11 = txtH_Yel_11.Value.ToString().Trim();
            string yel_12 = txtH_Yel_12.Value.ToString().Trim();
            string yel_13 = txtH_Yel_13.Value.ToString().Trim();
            string yel_14 = txtH_Yel_14.Value.ToString().Trim();
            string yel_15 = txtH_Yel_15.Value.ToString().Trim();
            //string yel_16 = txtH_Yel_16.Value.ToString().Trim();
            //string yel_17 = txtH_Yel_17.Value.ToString().Trim();
            //string yel_18 = txtH_Yel_18.Value.ToString().Trim();
            //string yel_19 = txtH_Yel_19.Value.ToString().Trim();
            //string yel_20 = txtH_Yel_20.Value.ToString().Trim();
            //string yel_21 = txtH_Yel_21.Value.ToString().Trim();
            //string yel_22 = txtH_Yel_22.Value.ToString().Trim();
            //string yel_23 = txtH_Yel_23.Value.ToString().Trim();
            //string yel_24 = txtH_Yel_24.Value.ToString().Trim();
            //string yel_25 = txtH_Yel_25.Value.ToString().Trim();
            //string yel_26 = txtH_Yel_26.Value.ToString().Trim();
            //string yel_27 = txtH_Yel_27.Value.ToString().Trim();
            //string yel_28 = txtH_Yel_28.Value.ToString().Trim();
            //string yel_29 = txtH_Yel_29.Value.ToString().Trim();
            //string yel_30 = txtH_Yel_30.Value.ToString().Trim();
            //string yel_31 = txtH_Yel_31.Value.ToString().Trim();
            //string yel_32 = txtH_Yel_32.Value.ToString().Trim();
            //string yel_33 = txtH_Yel_33.Value.ToString().Trim();
            //string yel_34 = txtH_Yel_34.Value.ToString().Trim();
            //string yel_35 = txtH_Yel_35.Value.ToString().Trim();
            //string yel_36 = txtH_Yel_36.Value.ToString().Trim();

            sql = "select * from mentalhealt_temp_yellow where m_id = '" + m_id + "' ";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                sql = "UPDATE mentalhealt_temp_yellow SET yel_1 = '" + yel_1 + "', yel_2 = '" + yel_2 + "', yel_3 = '" + yel_3 + "', yel_4 = '" + yel_4 + "', yel_5 = '" + yel_5 + "'," +
                 "yel_6 = '" + yel_6 + "', yel_7 = '" + yel_7 + "', yel_8 = '" + yel_8 + "', yel_9 = '" + yel_9 + "', yel_10 = '" + yel_10 + "'," +
                 "yel_11 = '" + yel_11 + "', yel_12 = '" + yel_12 + "', yel_13 = '" + yel_13 + "', yel_14 = '" + yel_14 + "', yel_15 = '" + yel_15 + "' " +
                 "WHERE m_id = '" + m_id + "'; ";

                if (CL_Sql.Modify(sql))
                {
                    result = true;
                }
            }
            else
            {
                sql = "INSERT INTO mentalhealt_temp_yellow" +
                  "(m_id, yel_1, yel_2, yel_3, yel_4, yel_5, yel_6, yel_7, yel_8, yel_9, yel_10, yel_11, yel_12, yel_13, yel_14, yel_15)" +
                  "VALUES('" + m_id + "', '" + yel_1 + "', '" + yel_2 + "', '" + yel_3 + "', '" + yel_4 + "', '" + yel_5 + "', '" + yel_6 + "', '" + yel_7 + "', '" + yel_8 + "', '" + yel_9 + "', '" + yel_10 + "', '" + yel_11 + "', '" + yel_12 + "', '" + yel_13 + "', '" + yel_14 + "', '" + yel_15 + "');";

                if (CL_Sql.Modify(sql))
                {
                    result = true;
                }
            }

            return result;
        }

        protected void btn_submit_yellow_ServerClick(object sender, EventArgs e)
        {
            if (Request.QueryString["id"] != null)
            {
                string m_id = id;
                m_id = Request.QueryString["id"].ToString();

                string lbl_sum1 = no1.Value.ToString();
                string lbl_sum2 = no2.Value.ToString();
                string lbl_sum3 = no3.Value.ToString();

                if (InsertDataYellow())
                {
                    string link = txtH_link.Value.ToString();

                    if (link == "Yellow")
                    {
                        Response.Redirect("Yellow.aspx?id=" + m_id + "&type=Yellow&1=" + lbl_sum1 + "&2=" + lbl_sum2 + "&3=" + lbl_sum3 + "");
                    }
                    else
                    {
                        Response.Redirect("Default.aspx");
                    }
                }
            }
        }

        protected void btn_next11_Click(object sender, EventArgs e)
        {

        }
    }
}