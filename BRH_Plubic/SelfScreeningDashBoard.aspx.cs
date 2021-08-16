using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;

namespace BRH_Plubic
{
    public partial class SelfScreeningDashBoard : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        string staff = "";
        string date1 = "";
        string date2 = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            //Session["Login"] = "Yes"; // <----------- TEST
            //Session["status"] = "DashBoard"; // <----------- TEST

            if (Session["Login"] != null)
            {
                string status = Session["status"].ToString();
                if (status == "admin" || status == "brh")
                {
                    if (Session["Login"].ToString() == "Yes")
                    {
                        string D1 = DateTime.Now.Date.AddDays(-14).ToString("yyyy-MM-dd");
                        string D2 = DateTime.Now.ToString("yyyy-MM-dd");
                        if (date_search1.Value == "")
                        {
                            lbl_Date1.Text = D1;
                            lbl_Date2.Text = D2;
                        }
                        else
                        {
                            lbl_Date1.Text = date_search1.Value;
                            lbl_Date2.Text = date_search2.Value;
                        }

                        if (!IsPostBack)
                        {
                            
                            GenerateChart();
                        }
                        else
                        {
                            
                        }
                    }
                }
                else
                {
                    Response.Write("<script>alert('คุณไม่มีสิทธิ์ใช้งานหน้านี้ !!'); window.location.href='Default.aspx';</script>");
                }
            }
            else
            {
                Response.Write("<script>alert('กรุณา Login ก่อนเข้าใช้งาน !!'); window.location.href='Default.aspx';</script>");
            }
        }

        protected void btn_search_ServerClick(object sender, EventArgs e)
        {
            staff = DD_staff.SelectedValue.ToString();
            date1 = date_search1.Value.ToString();
            date2 = date_search2.Value.ToString();
            //Response.Write("<script>alert('"+ date1 + " --- " + date2 +  "');</script>");
            GenerateChart();
        }

        public Boolean SelectGender()
        {
            Boolean bl = false;

            sql = "select count(1) as 'ss_cnt',ss_sex from selfscreen_data where 1 ";
            if (staff != "")
            {
                sql = sql + "AND ss_staff = '" + staff + "' ";
            }
            if (date1 != "" && date2 != "")
            {
                sql = sql + "AND (CONVERT(ss_datetime, date) between '" + date1 + "' and '" + date2 + "') ";
            }
            else
            {
                sql = sql + "AND CONVERT(ss_datetime, date) > CONVERT(CURRENT_DATE - INTERVAL 15 day, date) ";
            }
            sql = sql + "group by ss_sex";

            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    string sex = dt.Rows[i]["ss_sex"].ToString();
                    if (sex == "Men")
                    {
                        lbl_Male.Text = dt.Rows[i]["ss_cnt"].ToString();
                    }
                    else if (sex == "Women")
                    {
                        lbl_Female.Text = dt.Rows[i]["ss_cnt"].ToString();
                    }
                    else
                    {

                    }
                }
            }
            else
            {
                lbl_Male.Text = "0";
                lbl_Female.Text = "0";
            }

            return bl;
        }

        public Boolean SelectAge()
        {
            Boolean bl = false;

            sql = "SELECT sum(a.ss_cnt) as 'ss_cnt',a.ss_age FROM ( " +
                "    SELECT 1 as 'ss_cnt',  " +
                "    ( " +
                "        IF(ss_age < '15', '1 - 15', " +
                "           IF(ss_age >= '15' && ss_age <= '30', '15 - 30', " +
                "              IF(ss_age > '30' && ss_age <= '45', '31 - 45', " +
                "                 IF(ss_age > '45' && ss_age <= '60', '41 - 60', " +
                "                    IF(ss_age > '60', '60 up', " +
                "                       ss_age " +
                "                      ) " +
                "                   ) " +
                "                ) " +
                "             ) " +
                "          ) " +
                "    ) as 'ss_age' " +
                "    FROM `selfscreen_data` WHERE ss_age > '1' ";
            if (staff != "")
            {
                sql = sql + "AND ss_staff = '" + staff + "' ";
            }
            if (date1 != "" && date2 != "")
            {
                sql = sql + "AND (CONVERT(ss_datetime, date) between '" + date1 + "' and '" + date2 + "') ";
            }
            else
            {
                sql = sql + "AND CONVERT(ss_datetime, date) > CONVERT(CURRENT_DATE - INTERVAL 15 day, date) ";
            }
            sql = sql +") as a " +
                "GROUP BY a.ss_age";

            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                string Age = "";
                string Agevalue = "";
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    Age = Age + dt.Rows[i]["ss_age"].ToString() + ",";
                    Agevalue = Agevalue + dt.Rows[i]["ss_cnt"].ToString() + ",";
                }
                Age = Age.Substring(0, Age.Length - 1); // <<------- cut last (,)
                Agevalue = Agevalue.Substring(0, Agevalue.Length - 1); // <<------- cut last (,)
                txt_Age.Value = Age;
                txt_Age_value.Value = Agevalue;
                bl = true;
            }
            else
            {
                txt_Age.Value = "";
                txt_Age_value.Value = "";
                bl = true;
            }

            return bl;
        }

        public Boolean SelectSymptoms()
        {
            Boolean bl = false;

            sql = "SELECT count(1) as 'ss_cnt', ss_selfsymptoms FROM `selfscreen_data` where ss_selfsymptoms<>'No' ";
            if (staff != "")
            {
                sql = sql + "AND ss_staff = '" + staff + "' ";
            }
            if (date1 != "" && date2 != "")
            {
                sql = sql + "AND (CONVERT(ss_datetime, date) between '" + date1 + "' and '" + date2 + "') ";
            }
            else
            {
                sql = sql + "AND CONVERT(ss_datetime, date) > CONVERT(CURRENT_DATE - INTERVAL 15 day, date) ";
            }
            sql = sql + "group by ss_selfsymptoms ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                string Symp = "";
                string Sympvalue = "";
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    Symp = Symp + dt.Rows[i]["ss_selfsymptoms"].ToString() + ",";
                    Sympvalue = Sympvalue + dt.Rows[i]["ss_cnt"].ToString() + ",";
                }
                Symp = Symp.Substring(0, Symp.Length - 1); // <<------- cut last (,)
                Sympvalue = Sympvalue.Substring(0, Sympvalue.Length - 1); // <<------- cut last (,)
                txt_Symptoms.Value = Symp;
                txt_Symptoms_value.Value = Sympvalue;
                bl = true;
            }
            else
            {
                txt_Symptoms.Value = "";
                txt_Symptoms_value.Value = "";
                bl = true;
            }

            return bl;
        }

        public Boolean SelectCriteria()
        {
            Boolean bl = false;

            sql = "select *,( IF(ss_ctr='Normal',ss_cnt/ss_total,ss_cnt*100/ss_total) ) as 'ss_percent' from ( " +
                "    select sum(ss_cnt) as 'ss_cnt',ss_ctr,(select count(1) from selfscreen_data) as 'ss_total' from( " +
                "        select count(1) as 'ss_cnt', " +
                //"           IF(ss_score < 3, 'Normal' , IF(ss_score > 3, 'Dangers', 'Quarantine')) as 'ss_ctr' " +
                "           ss_ctr " +
                "        from selfscreen_data where 1 ";
            if (staff != "")
            {
                sql = sql + "AND ss_staff = '" + staff + "' ";
            }
            if (date1 != "" && date2 != "")
            {
                sql = sql + "AND (CONVERT(ss_datetime, date) between '" + date1 + "' and '" + date2 + "') ";
            }
            else
            {
                sql = sql + "AND CONVERT(ss_datetime, date) > CONVERT(CURRENT_DATE - INTERVAL 15 day, date) ";
            }
            sql = sql +"        group by ss_score " +
                "    ) a " +
                "    group by a.ss_ctr " +
                ") a";

            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                string CTR = "";
                string CTRvalue = "";
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    string ss_ctr = dt.Rows[i]["ss_ctr"].ToString();
                    string ss_cnt = dt.Rows[i]["ss_cnt"].ToString();
                    CTR = CTR + ss_ctr + " (" + ss_cnt + ")" + ",";
                    CTRvalue = CTRvalue + dt.Rows[i]["ss_percent"].ToString() + ",";
                }
                CTR = CTR.Substring(0, CTR.Length - 1); // <<------- cut last (,)
                CTRvalue = CTRvalue.Substring(0, CTRvalue.Length - 1); // <<------- cut last (,)
                txt_CTR.Value = CTR;
                txt_CTR_value.Value = CTRvalue;
                bl = true;
            }
            else
            {
                txt_CTR.Value = "";
                txt_CTR_value.Value = "";
                bl = true;
            }

            return bl;
        }

        public Boolean SelectEmp()
        {
            Boolean bl = false;

            sql = "SELECT count(ss_staff) as 'cnt_staff',ss_staff FROM `selfscreen_data` where 1 ";
            if (staff != "")
            {
                sql = sql + "AND ss_staff = '" + staff + "' ";
            }
            if (date1 != "" && date2 != "")
            {
                sql = sql + "AND (CONVERT(ss_datetime, date) between '" + date1 + "' and '" + date2 + "') ";
            }
            else
            {
                sql = sql + "AND CONVERT(ss_datetime, date) > CONVERT(CURRENT_DATE - INTERVAL 15 day, date) ";
            }
            sql = sql + "group by ss_staff ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                string emp = "";
                string empvalue = "";
                for (int i=0; i < dt.Rows.Count; i++)
                {
                    emp = emp + dt.Rows[i]["ss_staff"].ToString() + ",";
                    empvalue = empvalue + dt.Rows[i]["cnt_staff"].ToString() + ",";
                }
                emp = emp.Substring(0,emp.Length-1); // <<------- cut last (,)
                empvalue = empvalue.Substring(0, empvalue.Length - 1); // <<------- cut last (,)
                txt_emp.Value = emp;
                txt_emp_value.Value = empvalue;
                bl = true;
            }
            else
            {
                txt_emp.Value = "";
                txt_emp_value.Value = "";
                bl = true;
            }

            return bl;
        }

        public Boolean SelectQtyByDate()
        {
            Boolean bl = false;

            sql = "Select *, CONCAT(CONVERT(day(ss_date),CHARACTER),'/',CONVERT(month(ss_date),CHARACTER),'/',CONVERT(year(ss_date),CHARACTER)) as ss_dates " +
                "\nfrom ( " +
                  "\n   SELECT CONVERT(ss_datetime,date) as 'ss_date', 'A' as 'ss_status', count(1) as 'ss_qty' " +
                  "\n   FROM `selfscreen_data` WHERE 1 ";
            if (staff != "")
            {
                sql = sql + "AND ss_staff = '" + staff + "' ";
            }
            if (date1 != "" && date2 != "")
            {
                sql = sql + "AND (CONVERT(ss_datetime, date) between '" + date1 + "' and '" + date2 + "') ";
            }
            else
            {
                sql = sql + "AND CONVERT(ss_datetime, date) > CONVERT(CURRENT_DATE - INTERVAL 15 day, date) ";
            }

            sql = sql + "\n   group by CONVERT(ss_datetime,date) " +
                "\n   UNION " +
                    "\n   SELECT CONVERT(ss_datetime,date) as 'ss_date', 'N' as 'ss_status', count(1) as 'ss_qty' " +
                    "\n   FROM `selfscreen_data` WHERE ss_ctr='Normal' ";
            if (staff != "")
            {
                sql = sql + "AND ss_staff = '" + staff + "' ";
            }
            if (date1 != "" && date2 != "")
            {
                sql = sql + "AND (CONVERT(ss_datetime, date) between '" + date1 + "' and '" + date2 + "') ";
            }
            else
            {
                sql = sql + "AND CONVERT(ss_datetime, date) > CONVERT(CURRENT_DATE - INTERVAL 15 day, date) ";
            }

            sql = sql + "\n   group by CONVERT(ss_datetime,date) " +
                "\n   UNION " +
                    "\n   SELECT CONVERT(ss_datetime, date) as 'ss_date', 'Q' as 'ss_status', count(1) as 'ss_qty' " +
                    "\n   FROM `selfscreen_data` WHERE ss_ctr='Quarantine' ";
            if (staff != "")
            {
                sql = sql + "AND ss_staff = '" + staff + "' ";
            }
            if (date1 != "" && date2 != "")
            {
                sql = sql + "AND (CONVERT(ss_datetime, date) between '" + date1 + "' and '" + date2 + "') ";
            }
            else
            {
                sql = sql + "AND CONVERT(ss_datetime, date) > CONVERT(CURRENT_DATE - INTERVAL 15 day, date) ";
            }

            sql = sql + "\n   group by CONVERT(ss_datetime,date) " +
                "\n   UNION " +
                    "\n   SELECT CONVERT(ss_datetime, date) as 'ss_date', 'D' as 'ss_status', count(1) as 'ss_qty' " +
                    "\n   FROM `selfscreen_data` WHERE ss_ctr='Dangers' ";
            if (staff != "")
            {
                sql = sql + "AND ss_staff = '" + staff + "' ";
            }
            if (date1 != "" && date2 != "")
            {
                sql = sql + "AND (CONVERT(ss_datetime, date) between '" + date1 + "' and '" + date2 + "') ";
            }
            else
            {
                sql = sql + "AND CONVERT(ss_datetime, date) > CONVERT(CURRENT_DATE - INTERVAL 15 day, date) ";
            }
            sql = sql + "\n   group by CONVERT(ss_datetime,date) " +
             "\n) a order by CONVERT(a.ss_date, date), a.ss_status ";

            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                string QBD = "";
                string QBDvalue = "";
                string QVD = "";
                string QVN = "";
                string QVQ = "";
                for (int i=0; i < dt.Rows.Count; i++)
                {
                    string ss_status = dt.Rows[i]["ss_status"].ToString();
                    if (ss_status == "A")
                    {
                        QBD = QBD + dt.Rows[i]["ss_dates"].ToString() + ",";
                        QBDvalue = QBDvalue + dt.Rows[i]["ss_qty"].ToString() + ",";
                    }
                    if (ss_status == "D") 
                    {
                        string VD = dt.Rows[i]["ss_qty"].ToString();
                        if (VD=="0") { VD = null; }
                        QVD = QVD + VD + ",";
                    }
                    if (ss_status == "N")
                    {
                        string VN = dt.Rows[i]["ss_qty"].ToString();
                        if (VN == "0") { VN = null; }
                        QVN = QVN + VN + ",";
                    }
                    if (ss_status == "Q") 
                    {
                        string VQ = dt.Rows[i]["ss_qty"].ToString();
                        if (VQ == "0") { VQ = null; }
                        QVQ = QVQ + VQ + ",";
                    }
                }
                QBD = QBD.Substring(0, QBD.Length - 1); // <<------- cut last (,)
                QBDvalue = QBDvalue.Substring(0, QBDvalue.Length - 1); // <<------- cut last (,)
                if (QVD.Length > 0) 
                {
                    QVD = QVD.Substring(0, QVD.Length - 1); // <<------- cut last (,)
                }
                QVN = QVN.Substring(0, QVN.Length - 1); // <<------- cut last (,)
                if (QVQ.Length > 0)
                {
                    QVQ = QVQ.Substring(0, QVQ.Length - 1); // <<------- cut last (,)
                }
                txt_QBD.Value = QBD;
                txt_QBDvalue.Value = QBDvalue;
                txt_QVD.Value = QVD;
                txt_QVN.Value = QVN;
                txt_QVQ.Value = QVQ;
                bl = true;
            }
            else
            {
                txt_QBD.Value = "";
                txt_QBDvalue.Value = "";
                txt_QVD.Value = "";
                txt_QVN.Value = "";
                txt_QVQ.Value = "";
                bl = true;
            }

            return bl;
        }

        public Boolean GenerateChart()
        {
            Boolean bl = false;

            int num = 0;
            if (SelectGender() == false) { num += 1; }
            if (SelectAge() == false) { num += 1; }
            if (SelectSymptoms() == false) { num += 1; }
            if (SelectCriteria() == false) { num += 1; }
            if (SelectEmp() == false) { num += 1; }
            if (SelectQtyByDate() == false) { num += 1; }

            if (num == 0) { bl = true; }

            return bl;
        }

    }
}
