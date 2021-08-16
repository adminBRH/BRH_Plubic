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
    public partial class SelfScreening : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Country();
                Provinve();
            }
        }

        protected void DD_Age_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtH_age.Value = DD_Age.SelectedValue.ToString();
        }

        protected void btn_department_ServerClick(object sender, EventArgs e)
        {
            string empid = txt_emp.Value.ToString().Trim();
            employee(empid);
        }

        protected void btn_doctor_ServerClick(object sender, EventArgs e)
        {
            string drid = txt_doctor.Value.ToString().Trim();
            string result = doctor(drid);
            if (result != "")
            {
                lbl_doctor.Text = result;
                lbl_doctor.ForeColor = System.Drawing.Color.Blue;
            }
            else
            {
                lbl_doctor.Text = "ไม่มีเลข ว. นี้ในระบบ";
                lbl_doctor.ForeColor = System.Drawing.Color.Red;
            }
        }

        public Boolean Country()
        {
            Boolean bl = false;

            sql = "select * from ( " +
                "select 0 as 'ssc_id','No' as 'ssc_name','เลือก Select 选择' as 'ssc_translation' " +
                "    Union " +
                "select ssc_id,ssc_name,ssc_translation from selfscreen_country as sc " +
                ") a order by a.ssc_id";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                DD_Country.DataSource = dt;
                DD_Country.DataTextField = "ssc_translation";
                DD_Country.DataValueField = "ssc_name";
                DD_Country.DataBind();
                bl = true;
            }

            return bl;
        }

        public Boolean Provinve()
        {
            Boolean bl = false;

            //sql = "select * from ( " +
            //    "select 0 as 'ssp_id','No' as 'ssp_name','เลือก Select' as 'ssp_translation' " +
            //    "    Union " +
            //    "select ssp_id,ssp_name,ssp_translation from selfscreen_province as sc " +
            //    ") a order by a.ssp_id";
            sql = "SELECT '' as 'province_th', '' as 'province_en', 'กรุณาเลือก จังหวัด' as 'provincename' " +
                "    UNION " +
                "SELECT province_th, province_en, provincename FROM province where province_selfscreen='yes' " +
                "order by province_th ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                DD_Province.DataSource = dt;
                //DD_Province.DataTextField = "ssp_translation";
                //DD_Province.DataValueField = "ssp_name";
                DD_Province.DataTextField = "provincename";
                DD_Province.DataValueField = "province_th";
                DD_Province.DataBind();

                bl = true;
            }

            return bl;
        }

        protected void DD_Province_SelectedIndexChanged(object sender, EventArgs e)
        {
            string PV = DD_Province.SelectedValue.ToString();
            string imgid = "";

            sql = "select distinct sra_provincedetail from selfscreen_riskarea " +
                "\nwhere sra_active = 'yes' and sra_provincedetail like '%" + PV + "%'; ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {

            }

            DD_RiskArea.DataSource = dt;
            DD_RiskArea.DataTextField = "sra_provincedetail";
            DD_RiskArea.DataValueField = "sra_provincedetail";
            DD_RiskArea.DataBind();

            DD_RiskArea.Items.Insert(0, new ListItem("กรุณาเลือก พื้นที่เสี่ยง", "0"));

            //sql = "select * from selfscreen_province where ssp_name = '" + PV + "' ";
            //dt = new DataTable();
            //dt = cl_Sql.select(sql);
            //if (dt.Rows.Count > 0)
            //{
            //    divLoRisk.Visible = true;

            //    txt_province_other.Value = imgid;

            //    imglo1.Visible = false; imglo2.Visible = false; imglo3.Visible = false; imglo4.Visible = false;
            //    imglo5.Visible = false; imglo6.Visible = false; imglo7.Visible = false; imglo8.Visible = false;
            //    imglo9.Visible = false; imglo10.Visible = false; imglo11.Visible = false; imglo12.Visible = false;
            //    imglo13.Visible = false; imglo14.Visible = false; imglo15.Visible = false; imglo16.Visible = false;
            //    imglo17.Visible = false; imglo18.Visible = false; imglo19.Visible = false; imglo20.Visible = false;
            //    imglo21.Visible = false; imglo22.Visible = false; imglo23.Visible = false; 

            //    imgid = dt.Rows[0]["ssp_id"].ToString();
            //    switch (imgid)
            //    {
            //        case "1": imglo1.Visible = true; break;
            //        case "2": imglo2.Visible = true; break;
            //        case "3": imglo3.Visible = true; break;
            //        case "4": imglo4.Visible = true; break;
            //        case "5": imglo5.Visible = true; break;
            //        case "6": imglo6.Visible = true; break;
            //        case "7": imglo7.Visible = true; break;
            //        case "8": imglo8.Visible = true; break;
            //        case "9": imglo9.Visible = true; break;
            //        case "10": imglo10.Visible = true; break;
            //        case "11": imglo11.Visible = true; break;
            //        case "12": imglo12.Visible = true; break;
            //        case "13": imglo13.Visible = true; break;
            //        case "14": imglo14.Visible = true; break;
            //        case "15": imglo15.Visible = true; break;
            //        case "16": imglo16.Visible = true; break;
            //        case "17": imglo17.Visible = true; break;
            //        case "18": imglo18.Visible = true; break;
            //        case "19": imglo19.Visible = true; break;
            //        case "20": imglo20.Visible = true; break;
            //        case "21": imglo21.Visible = true; break;
            //        case "22": imglo22.Visible = true; break;
            //        case "23": imglo23.Visible = true; break;
            //        default: break;
            //    }
            //}
            //else
            //{
            //    divLoRisk.Visible = false;
            //}
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            string Next = "";
            string alert = "";

            if (RD_emp1.Checked)
            {
                string empid = "";
                empid = txt_emp.Value.ToString().Trim();
                Next = employee(empid);
                if (Next != "Yes")
                {
                    string drname = doctor(empid);
                    if (drname != "")
                    {
                        Next = "Yes";
                    }
                    else
                    {
                        alert = "fn_AlertModal('Info','รหัสพนักงานไม่ถูกต้อง !!','',0)";
                    }
                }
            }
            else
            {
                Next = "Yes";
            }

            if (Next == "Yes")
            {
                if (City1.Checked)
                {
                    Next = "";
                    if (DD_Province.SelectedValue.ToString() == "")
                    {
                        alert = "fn_AlertModal('Info','กรุณาเลือก จังหวัด !!','',0)";
                    }
                    else
                    {
                        if (DD_RiskArea.SelectedValue.ToString() == "กรุณาเลือก พื้นที่เสี่ยง")
                        {
                            alert = "fn_AlertModal('Info','กรุณาเลือก พื้นที่เสี่ยง !!','',0)";
                        }
                        else
                        {
                            Next = "Yes";
                        }
                    }
                }
                else
                {
                    Next = "Yes";
                }
            }
            

            if (Next != "Yes")
            {
                //lbl_modal.Text = alert;
                Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", alert, true);
            }
            else
            {
                string Result = InsertData();

                Session.Timeout = 180;
                Session["Result"] = "";

                if (Result == "Normal")
                {
                    //Response.Write("<script> $('#Result1_Modal').modal('show'); </script>");
                    Session["Result"] = "Modal1";
                }
                else if (Result == "Quarantine")
                {
                    //Response.Write("<script>alert('แยกตัวเอง สังเกตอาการ'); window.location.href='SelfScreening.aspx';</script>");
                    Session["Result"] = "Modal2";
                }
                else if (Result == "Dangers")
                {
                    //Response.Write("<script>alert('รีบพบแพทย์'); window.location.href='SelfScreening.aspx';</script>");
                    Session["Result"] = "Modal3";
                }
                else
                {
                    Response.Write("<script>alert('Can't insert please contact Admin !!');</script>");
                }

                if (Session["Result"].ToString() != "")
                {
                    Response.Redirect("SelfScreeningResult.aspx#ModalShow");
                }
            }
        }

        public string employee(string id)
        {
            string Next = "";

            sql = "select * from employee where emp_id = '" + id + "' ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                Next = "Yes";
                lbl_department.Text = dt.Rows[0]["emp_deptdesc"].ToString();
                lbl_department.ForeColor = System.Drawing.Color.Blue;
                Session["employee"] = "Yes";
            }
            else
            {
                string drname = doctor(id);
                if (drname != "")
                {
                    lbl_department.Text = drname;
                    lbl_department.ForeColor = System.Drawing.Color.Blue;
                    Session["employee"] = "Yes"; // ใช้ผลลัพธ์เดียวกันกับพนักงาน
                }
                else
                {
                    lbl_department.Text = "ไม่มีรหัสนี้ในระบบ !!";
                    lbl_department.ForeColor = System.Drawing.Color.Red;
                    Session.Remove("employee");
                }
            }

            return Next;
        }

        public string doctor(string id)
        {
            string result = "";

            sql = "select * from doctors where drs_id = '" + id + "'; ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                result = dt.Rows[0]["drs_fullname"].ToString();
            }

            return result;
        }

        public string InsertData()
        {
            int Score = 0;

            string sex = "";
            if (RD_SexF.Checked) { sex = RD_SexF.Value; } else { sex = RD_SexM.Value; }
            string emp = "";
            string empid = null;
            string SelfFever = "No";
            string ScoreFever = "No";
            string SelfDrug = "No";
            string SelfDrug_date = "NULL";
            string SelfDrug_time = "NULL";
            string SelfSick_date = "NULL";
            string SelfSymptoms = "";
            string Country = "No";
            string CountryOther = null;
            string Province = "No";
            //string ProvinceRisk = "No";
            string ProvinceRisk = "";
            string ProvinceOther = null;
            string Touch = "No";
            string TouchDetail = null;
            string drid = "";

            if (RD_med1.Checked)
            {
                drid = txt_emp.Value.ToString().Trim();
            }

            // ----------=================== Check Employee ===================----------
            if (RD_emp1.Checked)
            {
                emp = RD_emp1.Value.ToString();
            }
            else
            {
                emp = RD_emp0.Value.ToString();
            }

            if (emp == "Yes")
            {
                empid = txt_emp.Value.ToString().Trim();
            }
            else
            {
                empid = null;
            }

            string feverSymptoms = "";
            // ----------=================== Check self_fever ===================---------- Score 3
            if (self_fever.Checked == true)
            {
                feverSymptoms = "Y";
                Score = Score + 3;
                SelfFever = self_fever.Value.ToString();

                if (ScoreFever1.Checked == true)
                {
                    ScoreFever = DD_ScoreFever.SelectedValue.ToString();
                }
                else
                {
                    ScoreFever = ScoreFever0.Value.ToString();
                } // end if ScoreFever

                if (TakeMedication1.Checked == true)
                {
                    SelfDrug = TakeMedication1.Value.ToString();

                    SelfDrug_date = self_drugs_date.Value.ToString();
                    SelfDrug_time = self_drugs_time.Value.ToString();
                    SelfSick_date = self_sick_date.Value.ToString();
                }
                else
                {
                    SelfDrug = TakeMedication0.Value.ToString();
                } // end if TakeMedication

            }
            else
            {
                SelfFever = self_fever_no.Value.ToString();
            } // end if self_fever

            // ----------=================== Check self_symptoms ===================----------  Score 2
            if (inlineCheckbox5.Checked == true)
            {
                SelfSymptoms = inlineCheckbox5.Value.ToString();
            }
            else
            {
                feverSymptoms = "Y";
                Score = Score + 2;
                string Separator = "";
                if (inlineCheckbox1.Checked == true)
                {
                    Separator = "|";
                    SelfSymptoms = inlineCheckbox1.Value.ToString();
                }
                if (inlineCheckbox2.Checked == true)
                {
                    if (Separator != "")
                    {
                        SelfSymptoms = SelfSymptoms + Separator;
                    }
                    SelfSymptoms = SelfSymptoms + inlineCheckbox2.Value.ToString();
                    Separator = "|";
                }
                if (inlineCheckbox3.Checked == true)
                {
                    if (Separator != "")
                    {
                        SelfSymptoms = SelfSymptoms + Separator;
                    }
                    SelfSymptoms = SelfSymptoms + inlineCheckbox3.Value.ToString();
                    Separator = "|";
                }
                if (inlineCheckbox4.Checked == true)
                {
                    if (Separator != "")
                    {
                        SelfSymptoms = SelfSymptoms + Separator;
                    }
                    SelfSymptoms = SelfSymptoms + inlineCheckbox4.Value.ToString();
                    Separator = "|";
                }
                if (inlineCheckbox6.Checked == true)
                {
                    if (Separator != "")
                    {
                        SelfSymptoms = SelfSymptoms + Separator;
                    }
                    SelfSymptoms = SelfSymptoms + inlineCheckbox6.Value.ToString();
                }
            }// end if inlineCheckbox5 (self_symptoms)

            int ScoreX = 0;

            // ----------=================== Check from Country ===================----------  Score 1
            if (Country1.Checked == true)
            {
                if (txt_country_other.Value.ToString().Trim() != "")
                {
                    Country = Country0.Value.ToString();
                    CountryOther = txt_country_other.Value.ToString();
                }
                else
                {
                    string CountrySelect = DD_Country.SelectedValue.ToString();
                    if (CountrySelect != "No")
                    {
                        ScoreX = ScoreX + 1;
                        Country = DD_Country.SelectedValue.ToString();
                    }
                    CountryOther = null;
                }
            } // end if Country

            // ----------=================== Check from Province ===================----------  Score 1
            if (City1.Checked == true)
            {
                Score = Score + 1;
                if (txt_province_other.Value.ToString().Trim() != "")
                {
                    Province = City0.Value.ToString();
                    ProvinceOther = txt_province_other.Value.ToString();
                }
                else
                {
                    string ProvinceSelect = DD_Province.SelectedValue.ToString();
                    if (ProvinceSelect != "No")
                    {
                        //ScoreX = ScoreX + 1;
                        //Province = DD_Province.SelectedValue.ToString();
                        // ----------=================== Check risk area ===================----------  Score 2
                        //if (RDLoRisk1.Checked)
                        //{
                        //    ProvinceRisk = RDLoRisk1.Value.ToString();
                        //    Score = Score + 2;
                        //}

                        Province = DD_Province.SelectedValue.ToString();
                        ProvinceRisk = DD_RiskArea.SelectedValue.ToString();
                    }
                    ProvinceOther = null;
                }
            }

            //if (ScoreX>0)
            //{
            //    if (feverSymptoms == "Y")
            //    {
            //        Score = Score + 1;
            //    }
            //}

            //if (ScoreX > 1)
            //{
            //    ScoreX = ScoreX / 2;
            //}
            //Score = Score + ScoreX;

            // ----------=================== Check self contacted virus ===================----------  Score 1
            if (Touch1.Checked == true)
            {
                Score = Score + 1;
                //int ScoreTouch = 1;
                //if (feverSymptoms=="Y")
                //{
                //    ScoreTouch = ScoreTouch + 1;
                //}
                //Score = Score + ScoreTouch;
                Touch = Touch1.Value.ToString();
                TouchDetail = self_TouchDetail.Value.ToString();
            }
            else
            {
                Touch = Touch0.Value.ToString();
                TouchDetail = null;
            } // end if Touch

            sql = "INSERT INTO selfscreen_data " +
                "(ss_sex, " +
                "ss_age, " +
                "ss_staff, " +
                "ss_staffid, " +
                "ss_lanquage, " +
                "ss_selffever, " +
                "ss_selffeverscore, " +
                "ss_selfdrug, " +
                "ss_selfdrugdate, " +
                "ss_selfdrugtime, " +
                "ss_selfsick, " +
                "ss_selfsymptoms, " +
                "ss_country, " +
                "ss_countryother, " +
                "ss_city, " +
                "ss_cityrisk, " +
                "ss_cityother, " +
                "ss_touch, " +
                "ss_touchdetail, " +
                "ss_score," +
                "ss_drid," +
                "ss_ctr) " +
                "VALUES" +
                "('" + sex + "', " +
                "'" + DD_Age.SelectedValue.ToString() + "', " +
                "'" + emp + "', " +
                "'" + empid + "', " +
                "'" + DD_Lanquage.SelectedValue.ToString() + "', " +
                "'" + SelfFever + "', " +
                "'" + ScoreFever + "', " +
                "'" + SelfDrug + "', ";

            if (SelfDrug_date == null)
            {
                sql = sql + "'" + SelfDrug_date + "', ";
            }
            else
            {
                sql = sql + "" + SelfDrug_date + ", ";
            }

            if (SelfDrug_time == null)
            {
                sql = sql + "'" + SelfDrug_time + "', ";
            }
            else
            {
                sql = sql + "" + SelfDrug_time + ", ";
            }

            if (SelfSick_date == null)
            {
                sql = sql + "'" + SelfSick_date + "', ";
            }
            else
            {
                sql = sql + "" + SelfSick_date + ", ";
            }


            //------------------------------------- Criteria ------------------
            string ctr = "";
            if (Score <= 0)
            {
                ctr = "Normal";
            }
            else if (Score > 0 && Score <= 5)
            {
                ctr = "Quarantine";
            }
            else
            {
                ctr = "Dangers";
            }
            //------------------------------------- Criteria ------------------

            sql = sql + "'" + SelfSymptoms + "', " +
                "'" + Country + "', " +
                "'" + CountryOther + "', " +
                "'" + Province + "', " +
                "'" + ProvinceRisk + "', " +
                "'" + ProvinceOther + "', " +
                "'" + Touch + "', " +
                "'" + TouchDetail + "', " +
                "'" + Score + "', " +
                "'" + drid + "', " +
                "'" + ctr + "'); ";

            cl_Sql.Modify(sql);

            //return Score;
            return ctr;
        }
    }
}