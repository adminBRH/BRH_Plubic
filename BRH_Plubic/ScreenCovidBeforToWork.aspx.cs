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
    public partial class ScreenCovidBeforToWork : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass CL_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string DT = DateTime.Now.ToString("dd/MM/yyyy");
                lbl_Date.Text = "  " + DT;

                Company();
            }

            if (Session["BeforToWork"] != null)
            {
                if (Session["BeforToWork"].ToString() == "Print")
                {
                    if (Request.QueryString["id"] == null)
                    {
                        Session.Remove("BeforToWork");
                    }
                    else
                    {
                        Print(Request.QueryString["id"].ToString().Trim());
                    }
                }
                else
                {
                    Response.Write("<script>alert('คุณไม่มีสิทธิ์ปริ้น !!'); window.location.href='ScreenCovidBeforToWork.aspx';</script>");
                }
            }
        }

        public Boolean Company()
        {
            Boolean bl = false;

            sql = "select * from company where cp_active = 'Yes' ";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                txt_cpid.Value = dt.Rows[0]["cp_id"].ToString();
                lbl_company_TH.Text = dt.Rows[0]["cp_name_th"].ToString();
                lbl_company_EN.Text = dt.Rows[0]["cp_name_en"].ToString();
            }

            return bl;
        }

        protected void btn_emp_Click(object sender, EventArgs e)
        {
            string empid = employeeid.Value.ToString().Trim();
            if (Employee(empid))
            {
                lbl_alert.Visible = false;
            }
            else
            {
                lbl_alert.Visible = true;
                lbl_alert.Text = "Does not exist in the system.";
            }
        }

        public Boolean Employee(string id)
        {
            Boolean bl = false;

            sql = "select * from company_employee " +
                "where ce_empid = '" + id + "' " +
                "and ce_cp_id in (select cp_id from company where cp_active = 'Yes') ";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                fullname.Value = dt.Rows[0]["ce_name_th"].ToString();

                string[] ArFullname = dt.Rows[0]["ce_name_th"].ToString().Split(' ');
                firstname.Value = ArFullname[0];
                string lname = "";
                if (ArFullname.Length > 2)
                {
                    for (int fn = 1; fn < ArFullname.Length; fn++)
                    {
                        lname = lname + ArFullname[fn] + " ";
                    }
                }
                else
                {
                    lname = ArFullname[1];
                }
                lastname.Value = lname;

                position.Value = dt.Rows[0]["ce_post"].ToString();
                department.Value = dt.Rows[0]["ce_dept"].ToString();
                division.Value = dt.Rows[0]["ce_division"].ToString();

                bl = true;
            }

            return bl;
        }

        protected void btnsubmit_ServerClick(object sender, EventArgs e)
        {
            Session.Timeout = 180;
            int result = InsertData();
            if (result == 1)
            {
                Session["scsend"] = "scgreen";
                Response.Redirect("ScreenCovidBeforToWorkResult.aspx");
            }
            else if (result == 2)
            {
                Session["scsend"] = "scred";
                Response.Redirect("ScreenCovidBeforToWorkResult.aspx");
            }
            else
            {
                Response.Write("<script>alert('บันทึกไม่สำเร็จกรุณาติดต่อ Admin');</script>");
            }
        }

        public int InsertData()
        {
            int bl = 0;

            // ------------------------------------------------------------------
            string cpid = txt_cpid.Value.ToString();

            string fname = firstname.Value.ToString().Trim();
            string lname = lastname.Value.ToString().Trim();
            string emp = employeeid.Value.ToString().Trim();
            string posi = position.Value.ToString().Trim();
            string dept = department.Value.ToString().Trim();
            string div = division.Value.ToString().Trim();

            string Question = "";
            string Score = "";
            string Detail = "";

            int CTR = 1;

            if (no1y.Checked)
            {
                Question = Question + "1|";
                Score = Score + no1y.Value.ToString() + "|";
                Detail = Detail + "|";
            }
            if (no1n.Checked)
            {
                Question = Question + "1|";
                Score = Score + no1n.Value.ToString() + "|";
                Detail = Detail + "|";
                CTR = 2;
            }

            if (no2y.Checked)
            {
                Question = Question + "2|";
                Score = Score + no2y.Value.ToString() + "|";
                Detail = Detail + "|";
            }
            if (no2n.Checked)
            {
                Question = Question + "2|";
                Score = Score + no2n.Value.ToString() + "|";
                Detail = Detail + "|";
                CTR = 2;
            }

            if (no3y.Checked)
            {
                Question = Question + "3|";
                Score = Score + no3y.Value.ToString() + "|";
                Detail = Detail + "|";
            }
            if (no3n.Checked)
            {
                Question = Question + "3|";
                Score = Score + no3n.Value.ToString() + "|";
                Detail = Detail + "|";
                CTR = 2;
            }

            if (no4y.Checked)
            {
                Question = Question + "4|";
                Score = Score + no4y.Value.ToString() + "|";
                Detail = Detail + "|";
            }
            if (no4n.Checked)
            {
                Question = Question + "4|";
                Score = Score + no4n.Value.ToString() + "|";
                Detail = Detail + no4d.Value.ToString().Trim() + "|";
                CTR = 2;
            }

            if (no5y.Checked)
            {
                Question = Question + "5|";
                Score = Score + no5y.Value.ToString() + "|";
                Detail = Detail + "|";
            }
            if (no5n.Checked)
            {
                Question = Question + "5|";
                Score = Score + no5n.Value.ToString() + "|";
                Detail = Detail + "|";
            }

            if (no6y.Checked)
            {
                Question = Question + "6|";
                Score = Score + no6y.Value.ToString() + "|";
                Detail = Detail + no6d.Value.ToString().Trim() + "|";
            }
            if (no6n.Checked)
            {
                Question = Question + "6|";
                Score = Score + no6n.Value.ToString() + "|";
                Detail = Detail + "|";
            }
            // ------------------------------------------------------------------

            Question = Question.Substring(0, Question.Length - 1);
            Score = Score.Substring(0, Score.Length - 1);
            Detail = Detail.Substring(0, Detail.Length - 1);

            string risk = "No";
            if (CTR > 1)
            {
                risk = "Yes";
            }


            sql = "INSERT INTO screencovid" +
                "(sc_fname, sc_lname, sc_empid, sc_position, sc_dept, sc_division, sc_question, sc_score, sc_datetime, sc_status, sc_detail, sc_risk, cp_id)" +
                "VALUES('" + fname + "', '" + lname + "', '" + emp + "', '" + posi + "', '" + dept + "', '" + div + "', '" + Question + "', '" + Score + "', current_timestamp(), 'confirm', '" + Detail + "', '" + risk + "', '"+ cpid + "');";
            if (CL_Sql.Modify(sql))
            {
                bl = CTR;
            }

            return bl;
        }

        public Boolean Print(string id)
        {
            Boolean bl = false;

            printableArea.Attributes.Remove("data-toggle");

            div_input.Visible = false;
            div_submit.Visible = false;
            div_print.Visible = true;

            sql = "select s.*,concat(s.sc_fname,' ',s.sc_lname) as 'sc_fullname', ifnull(c.cp_name_th,s.cp_id) as 'cp_name_th',c.cp_name_en " +
                "from screencovid as s left join company as c on c.cp_id = s.cp_id " +
                "where sc_id = '" + id + "' ";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                lbl_company_TH.Text = dt.Rows[0]["cp_name_th"].ToString();
                lbl_company_EN.Text = dt.Rows[0]["cp_name_en"].ToString();

                lbl_name.Text = "..." + dt.Rows[0]["sc_fullname"].ToString() + "...";
                lbl_emp.Text = "..." + dt.Rows[0]["sc_empid"].ToString() + "...";
                lbl_posi.Text = "..." + dt.Rows[0]["sc_position"].ToString() + "...";
                lbl_dept.Text = "..." + dt.Rows[0]["sc_dept"].ToString() + "...";
                lbl_div.Text = "..." + dt.Rows[0]["sc_division"].ToString() + "...";

                string question = dt.Rows[0]["sc_question"].ToString();
                string[] que = question.Split('|');

                string score = dt.Rows[0]["sc_score"].ToString();
                string[] sco = score.Split('|');

                string detail = dt.Rows[0]["sc_detail"].ToString();
                string[] Det = detail.Split('|');

                for (int n = 0; n < sco.Length; n++)
                {
                    string scoN = sco[n].ToString();
                    if (scoN == "1" || scoN == "yes")
                    {
                        switch (n)
                        {
                            case 0:
                                img_1y.Attributes.Remove("hidden");
                                break;
                            case 1:
                                img_2y.Attributes.Remove("hidden");
                                break;
                            case 2:
                                img_3y.Attributes.Remove("hidden");
                                break;
                            case 3:
                                img_4y.Attributes.Remove("hidden");
                                break;
                            case 4:
                                img_5y.Attributes.Remove("hidden");
                                break;
                            case 5:
                                img_6y.Attributes.Remove("hidden");
                                break;
                            default:
                                break;
                        }
                    }
                    else
                    {
                        switch (n)
                        {
                            case 0:
                                img_1n.Attributes.Remove("hidden");
                                break;
                            case 1:
                                img_2n.Attributes.Remove("hidden");
                                break;
                            case 2:
                                img_3n.Attributes.Remove("hidden");
                                break;
                            case 3:
                                img_4n.Attributes.Remove("hidden");
                                break;
                            case 4:
                                img_5n.Attributes.Remove("hidden");
                                break;
                            case 5:
                                img_6n.Attributes.Remove("hidden");
                                break;
                            default:
                                break;
                        }
                    }

                    string DetN = Det[n].ToString();
                    if (DetN != "")
                    {
                        switch (n)
                        {
                            case 3:
                                lbl_no4.Text = "..." + DetN + "...";
                                break;
                            case 5:
                                lbl_no6.Text = "..." + DetN + "...";
                                break;
                            default:
                                break;
                        }
                    }
                }

                lbl_signed.Text = "..." + dt.Rows[0]["sc_fullname"].ToString() + "...";
            }
            else
            {
                Response.Write("<script>alert('ไม่มีเลขที่เอกสารนี้ในระบบ !!');</script>");
            }

            return bl;
        }

    }
}