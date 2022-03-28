using MySqlX.XDevAPI.Relational;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;
using Renci.SshNet.Security;

namespace BRH_Plubic.NovelCorona
{
    public partial class Default : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        string styleRequired = "border: groove; border-color: red; background-color: lightgoldenrodyellow; color: red;";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session.Remove("key");
                txt_step.Value = "Step1";
            }

            if (Request.QueryString["nc"] != null)
            {
                if (Session["Login"] != null)
                {
                    string status = Session["status"].ToString();
                    if (status == "admin" || status == "novelcovid")
                    {
                        string id = Request.QueryString["nc"].ToString();
                        if (id == "staff")
                        {
                            div_1.Visible = true;
                            div_2.Visible = true;
                            div_3.Visible = true;
                            btn_submit_1.Visible = false;

                            btn_submit_4.Visible = true;
                        }
                        else
                        {
                            if (!IsPostBack)
                            {
                                StaffDetails(id);
                            }
                        }
                    }
                    else
                    {
                        Response.Write("<script>alert('คุณไม่มีสิทธิ์ใช้งานหน้านี้ !!'); window.location.href='../default.aspx';</script>");
                    }
                }
                else
                {
                    // Open for user self input
                    DateTime DateNow = DateTime.Now;
                    string id = Request.QueryString["nc"].ToString();
                    if (id == "staff")
                    {
                        txt_B.Attributes.Add("min", (DateNow.Year + 443).ToString());
                        txt_B.Attributes.Add("max", (DateNow.Year + 543).ToString());
                        if (!IsPostBack)
                        {
                            if (txt_B.Value == "")
                            {
                                txt_B.Value = (DateNow.Year + 543).ToString();
                            }
                        }

                        div_1.Visible = true;
                        div_2.Visible = true;
                        div_3.Visible = true;
                        btn_submit_1.Visible = false;

                        btn_submit_4.Visible = true;
                    }
                    else
                    {
                        if (!IsPostBack)
                        {
                            StaffDetails(id);
                        }
                    }
                    //----------------------------------

                    //Response.Write("<script>alert('กรุณา login ก่อนเข้าใช้งาน !!'); window.location.href='../default.aspx';</script>");
                }
            }
            else
            {
                Response.Redirect("Default?nc=staff");

                //if (!IsPostBack)
                //{
                //    DateTime DateNow = DateTime.Now;
                //    txt_B.Attributes.Add("min", (DateNow.Year + 443).ToString());
                //    txt_B.Attributes.Add("max", (DateNow.Year + 543).ToString());
                //    txt_B.Value = (DateNow.Year + 543).ToString();
                //}
            }
        }

        protected void StaffDetails(string id)
        {
            sql = "select * from novelcorona as a " +
                "\nleft join novelcorona_clinic as b on b.ncc_ncid=a.nc_id " +
                "\nwhere a.nc_id='" + id + "'; ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                if (dt.Rows[0]["nc_staffcheck"].ToString() == "no")
                {
                    div_1.Visible = true;
                    div_2.Visible = true;
                    div_3.Visible = true;

                    btn_submit_1.Visible = false;
                    btn_submit_2.Visible = true;

                    SelectData(dt);
                }
                else
                {
                    Response.Redirect("Report.aspx?nc=" + id + "&key=" + dt.Rows[0]["nc_key"].ToString());
                }
            }
            else
            {
                lbl_modal.Text = "<script>alertModalInfo('#Modal_Info','ไม่พบข้อมูล !!'); setTimeout(function(){ window.location.href='CheckDocument.aspx'; }, 2000);</script>";
            }
        }

        public string setDate(string date)
        {
            string result = "";
            if (date != "")
            {
                result = DateTime.Parse(date).ToString("yyyy-MM-dd");
            }
            return result;
        }

        private void SelectData(DataTable dt)
        {
            // Div 1 --------------------------------------------------------- Start
            txt_fname.Value = dt.Rows[0]["nc_fname"].ToString();
            txt_lname.Value = dt.Rows[0]["nc_lname"].ToString();

            string sex = dt.Rows[0]["nc_sex"].ToString();
            if (sex == "male")
            {
                rd_sex_M.Checked = true;
            }
            else
            {
                rd_sex_F.Checked = true;
            }

            DateTime DOB = DateTime.Parse(dt.Rows[0]["nc_dob"].ToString());

            date_DOB.Value = DOB.ToString("yyyy-MM-dd");

            txt_D.Value = DOB.Day.ToString();
            txt_O.Value = DOB.Month.ToString();
            txt_B.Value = (DOB.Year+543).ToString();

            txt_career.Value = dt.Rows[0]["nc_career"].ToString();
            txt_nationality.Value = dt.Rows[0]["nc_nationality"].ToString();
            txt_race.Value = dt.Rows[0]["nc_race"].ToString();

            string rd_baan = dt.Rows[0]["nc_baan"].ToString();
            if (rd_baan == "บ้าน")
            {
                rd_baan_1.Checked = true;
            }
            else
            {
                rd_baan_2.Checked = true;
                txt_baan_2.Value = rd_baan;
            }

            txt_adr_number.Value = dt.Rows[0]["nc_adr_number"].ToString();
            txt_adr_moo.Value = dt.Rows[0]["nc_adr_moo"].ToString();
            txt_adr_baan.Value = dt.Rows[0]["nc_adr_baan"].ToString();
            txt_adr_alley.Value = dt.Rows[0]["nc_adr_alley"].ToString();
            txt_adr_road.Value = dt.Rows[0]["nc_adr_road"].ToString();
            txt_adr_subdistrict.Value = dt.Rows[0]["nc_adr_subdistrict"].ToString();
            txt_adr_district.Value = dt.Rows[0]["nc_adr_district"].ToString();
            txt_adr_province.Value = dt.Rows[0]["nc_adr_province"].ToString();
            //txt_adr_phone.Value = dt.Rows[0]["nc_adr_phone"].ToString();
            //txt_adr_tel.Value = dt.Rows[0]["nc_adr_tel"].ToString();
            txt_adr_mobile.Value = dt.Rows[0]["nc_adr_mobile"].ToString();
            if (dt.Rows[0]["nc_pregnant"].ToString() == "yes")
            {
                rd_yespregnant.Checked = true;
                rd_nopregnant.Checked = false;

                num_pregnan.Value = dt.Rows[0]["nc_pregnant_num"].ToString();
                num_pregnanweek.Value = dt.Rows[0]["nc_pregnant_week"].ToString();
            }
            txt_workplace.Value = dt.Rows[0]["nc_workplace"].ToString();
            txt_morchana_mobile.Value = dt.Rows[0]["nc_telmorchana"].ToString();
            txt_congenitalDisease.Value = dt.Rows[0]["nc_congenitaldisease"].ToString();
            txtH_smoking.Value = dt.Rows[0]["nc_smoking"].ToString();
            // Div 1 --------------------------------------------------------- End 

            // Div 2 --------------------------------------------------------- Start
            if (dt.Rows[0]["ncc_whensick"].ToString() != "")
            {
                cb_ail_yes.Checked = true;
            }
            else
            {
                cb_ail_no.Checked = true;
            }
            date_whenSick.Value = setDate(dt.Rows[0]["ncc_whensick"].ToString());
            date_firstVisit.Value = setDate(dt.Rows[0]["ncc_firstvisit"].ToString());
            txt_firstHospital.Value = dt.Rows[0]["ncc_firsthospital"].ToString();
            txt_firstHospital_province.Value = dt.Rows[0]["ncc_firsthospital"].ToString();
            txt_firstHospital_province.Value = dt.Rows[0]["ncc_firsthospital_province"].ToString();
            txt_currenHospital.Value = dt.Rows[0]["ncc_currenhospital"].ToString();
            txt_currenHospital_province.Value = dt.Rows[0]["ncc_currenhospital_province"].ToString();
            if (dt.Rows[0]["ncc_sick"].ToString() == "yes")
            {
                cb_sickyes.Checked = true;
            }
            txt_temperature.Value = dt.Rows[0]["ncc_temperature"].ToString();
            txt_O2sat.Value = dt.Rows[0]["ncc_o2sat"].ToString();
            if (dt.Rows[0]["ncc_respirator"].ToString() == "yes")
            {
                cb_respirator.Checked = true;
            }
            if (dt.Rows[0]["ncc_symptom_1"].ToString() != "")
            {
                cb_symptom_1.Checked = true;
            } 
            if (dt.Rows[0]["ncc_symptom_2"].ToString() != "")
            {
                cb_symptom_2.Checked = true;
            }
            if (dt.Rows[0]["ncc_symptom_3"].ToString() != "")
            {
                cb_symptom_3.Checked = true;
            }
            if (dt.Rows[0]["ncc_symptom_4"].ToString() != "")
            {
                cb_symptom_4.Checked = true;
            }
            if (dt.Rows[0]["ncc_symptom_5"].ToString() != "")
            {
                cb_symptom_5.Checked = true;
            } 
            if (dt.Rows[0]["ncc_symptom_6"].ToString() != "")
            {
                cb_symptom_6.Checked = true;
            } 
            if (dt.Rows[0]["ncc_symptom_7"].ToString() != "")
            {
                cb_symptom_7.Checked = true;
            } 
            if (dt.Rows[0]["ncc_symptom_8"].ToString() != "")
            {
                cb_symptom_8.Checked = true;
            } 
            if (dt.Rows[0]["ncc_symptom_9"].ToString() != "")
            {
                cb_symptom_9.Checked = true;
            }
            if (dt.Rows[0]["ncc_symptom_10"].ToString() != "")
            {
                cb_symptom_10.Checked = true;
            } 
            if (dt.Rows[0]["ncc_symptom_11"].ToString() != "")
            {
                cb_symptom_11.Checked = true;
                txt_symptom_11.Value = dt.Rows[0]["ncc_symptom_11_location"].ToString();
            }
            string symptonOther = dt.Rows[0]["ncc_symptomother"].ToString();
            if (symptonOther != "")
            {
                cb_symptom_other.Checked = true;
                txt_symptomOther.Value = symptonOther;
            }
            string xray = dt.Rows[0]["ncc_xray"].ToString();
            if (xray == "ทำ")
            {
                rd_xray_yes.Checked = true;
            }
            else if (xray == "ไม่ได้ทำ")
            {
                rd_xray_no.Checked = true;
            }
            else { }
            date_xray.Value = setDate(dt.Rows[0]["ncc_xraydate"].ToString());
            txt_xray_result.Value = dt.Rows[0]["ncc_xrayresult"].ToString();
            date_cbc.Value = setDate(dt.Rows[0]["ncc_cbc_date"].ToString());
            txt_cbc_hb.Value = dt.Rows[0]["ncc_cbc_hb"].ToString();
            txt_cbc_hct.Value = dt.Rows[0]["ncc_cbc_hct"].ToString();
            txt_cbc_wbc.Value = dt.Rows[0]["ncc_cbc_wbc"].ToString();
            txt_pc_x.Value = dt.Rows[0]["ncc_pc_x"].ToString();
            txt_pc_n.Value = dt.Rows[0]["ncc_pc_n"].ToString();
            txt_pc_l.Value = dt.Rows[0]["ncc_pc_l"].ToString();
            txt_pc_al.Value = dt.Rows[0]["ncc_pc_al"].ToString();
            txt_pc_mn.Value = dt.Rows[0]["ncc_pc_mn"].ToString();
            txt_influenza.Value = dt.Rows[0]["ncc_influenza_test"].ToString();
            string influenzaNP = dt.Rows[0]["ncc_influenza"].ToString();
            if (influenzaNP == "Negative")
            {
                rd_Influenza_N.Checked = true;
            } else if (influenzaNP == "Positive")
            {
                rd_Influenza_P.Checked = true;
            }
            else { }
            if (dt.Rows[0]["ncc_flu_a"].ToString() != "")
            {
                cb_flu_A.Checked = true;
            }
            if (dt.Rows[0]["ncc_flu_b"].ToString() != "")
            {
                cb_flu_B.Checked = true;
            }

            string sc_table = "";
            // SARS -----
            string ARpcr = dt.Rows[0]["ncc_pcr_array"].ToString();
            if (ARpcr != "")
            {
                if (ARpcr == "no")
                {
                    cb_pcr_no.Checked = true;
                }
                else
                {
                    txtH_pcr.Value = ARpcr;
                    sc_table += "<script>lblPcr.innerHTML = fn_table_show('pcr','" + ARpcr + "');</script> ";
                }
            }
            // SARS -----
            // ATK ------
            string ARanti = dt.Rows[0]["ncc_antibody_array"].ToString();
            if (ARanti != "")
            {
                if (ARanti == "no")
                {
                    cb_antibody_no.Checked = true;
                }
                else
                {
                    txtH_antibody.Value = ARanti;
                    sc_table += "<script>lblAnti.innerHTML = fn_table_show('antibody','" + ARanti + "');</script> ";
                }
            }
            // ATK ------

            lbl_sc_table.Text = sc_table;

            if (dt.Rows[0]["ncc_opd"].ToString() != "")
            {
                cb_opd.Checked = true;
            }
            if (dt.Rows[0]["ncc_admit"].ToString() != "")
            {
                cb_admit.Checked = true;
            }
            date_admit.Value = setDate(dt.Rows[0]["ncc_admit_date"].ToString());
            txt_diagnosis.Value = dt.Rows[0]["ncc_diagnosis"].ToString();
            string antiviral = dt.Rows[0]["ncc_antiviral"].ToString();
            if (antiviral == "yes")
            {
                rd_antiviral_yes.Checked = true;
                date_antiviral.Value = setDate(dt.Rows[0]["ncc_antiviral_date"].ToString());
            }
            else if (antiviral == "no")
            {
                rd_antiviral_yes.Checked = true;
            } else { }
            if (dt.Rows[0]["ncc_re"].ToString() != "")
            {
                cb_re.Checked = true;
            }
            if (dt.Rows[0]["ncc_fa"].ToString() != "")
            {
                cb_fa.Checked = true;
            }
            if (dt.Rows[0]["ncc_lori"].ToString() != "")
            {
                cb_lori.Checked = true;
            }
            if (dt.Rows[0]["ncc_da"].ToString() != "")
            {
                cb_da.Checked = true;
            }
            if (dt.Rows[0]["ncc_ri"].ToString() != "")
            {
                cb_ri.Checked = true;
            }
            if (dt.Rows[0]["ncc_chhy"].ToString() != "")
            {
                cb_chhy.Checked = true;
            }
            string antiOther = dt.Rows[0]["ncc_anti_other"].ToString();
            if (antiOther != "")
            {
                cb_other.Checked = true;
                txt_cb_other.Value = antiOther;
            }
            string pt_status = dt.Rows[0]["ncc_pt_status"].ToString();
            if (pt_status == "หาย")
            {
                rd_pt_status_1.Checked = true;
            }
            else if (pt_status == "ยังรักษาอยู่")
            {
                rd_pt_status_2.Checked = true;
            }
            else if (pt_status == "เสียชีวิต")
            {
                rd_pt_status_3.Checked = true;
            }
            else
            {
                string pt_status4 = dt.Rows[0]["ncc_pt_status_4"].ToString();
                if (pt_status4 != "")
                {
                    txt_pt_status_4.Value = pt_status4;
                    rd_pt_status_4.Checked = true;
                }
                string pt_status5 = dt.Rows[0]["ncc_pt_status_5"].ToString();
                if (pt_status5 != "")
                {
                    txt_pt_status_5.Value = pt_status5;
                    rd_pt_status_5.Checked = true;
                }
            }

            // Div 2 --------------------------------------------------------- End

            // Div 3 --------------------------------------------------------- Start 
            txtH_VacCovid.Value = dt.Rows[0]["nc_covidvaccine"].ToString();
            txtH_VacCovidBook.Value = dt.Rows[0]["nc_covidvaccine_book"].ToString();
            string Vacdate1 = dt.Rows[0]["nc_covidvaccine1_date"].ToString();
            if (Vacdate1 != "")
            {
                date_Vac1.Value = DateTime.Parse(Vacdate1).ToString("yyyy-MM-dd");
            }
            txt_nameVac1.Value = dt.Rows[0]["nc_covidvaccine1_name"].ToString();
            txt_locationVac1.Value = dt.Rows[0]["nc_covidvaccine1_location"].ToString();
            string Vacdate2 = dt.Rows[0]["nc_covidvaccine2_date"].ToString();
            if (Vacdate2 != "")
            {
                date_Vac_2.Value = DateTime.Parse(Vacdate2).ToString("yyyy-MM-dd");
            }
            txt_nameVac_2.Value = dt.Rows[0]["nc_covidvaccine2_name"].ToString();
            txt_locationVac_2.Value = dt.Rows[0]["nc_covidvaccine2_location"].ToString();
            string Vacdate3 = dt.Rows[0]["nc_covidvaccine3_date"].ToString();
            if (Vacdate3 != "")
            {
                date_Vac_3.Value = DateTime.Parse(Vacdate3).ToString("yyyy-MM-dd");
            }
            txt_nameVac_3.Value = dt.Rows[0]["nc_covidvaccine3_name"].ToString();
            txt_locationVac_3.Value = dt.Rows[0]["nc_covidvaccine3_location"].ToString();
            string Vacdate4 = dt.Rows[0]["nc_covidvaccine4_date"].ToString();
            if (Vacdate4 != "")
            {
                date_Vac_4.Value = DateTime.Parse(Vacdate4).ToString("yyyy-MM-dd");
            }
            txt_nameVac_4.Value = dt.Rows[0]["nc_covidvaccine4_name"].ToString();
            txt_locationVac_4.Value = dt.Rows[0]["nc_covidvaccine4_location"].ToString();

            string rd_4 = dt.Rows[0]["nc_rh_4"].ToString();
            if (rd_4 == "yes")
            {
                rd_yes_4.Checked = true;
                txt_yes_4.Value = dt.Rows[0]["nc_rh_4"].ToString();
            }
            else
            {
                rd_no_4.Checked = true;
            }

            if (dt.Rows[0]["nc_rh_travel_date"].ToString() != "")
            {
                date_travel.Value = DateTime.Parse(dt.Rows[0]["nc_rh_travel_date"].ToString()).ToString("yyyy-MM-dd");
                txt_travel_airline.Value = dt.Rows[0]["nc_rh_travel_airline"].ToString();
                txt_travel_flight.Value = dt.Rows[0]["nc_rh_travel_flight"].ToString();
                txt_travel_seatnumber.Value = dt.Rows[0]["nc_rh_travel_seatnumber"].ToString();
            }

            string rd_5 = dt.Rows[0]["nc_rh_5"].ToString();
            if (rd_5 == "yes")
            {
                rd_yes_5.Checked = true;
            }
            else
            {
                rd_no_5.Checked = true;
            }

            string rd_6 = dt.Rows[0]["nc_rh_6"].ToString();
            if (rd_6 == "yes")
            {
                rd_yes_6.Checked = true;
            }
            else
            {
                rd_no_6.Checked = true;
            }

            //string rd_7 = dt.Rows[0]["nc_rh_7"].ToString();
            //if (rd_7 == "no")
            //{
            //    rd_no_7.Checked = true;
            //}
            //else
            //{
            //    rd_yes_7.Checked = true;
            //}

            string rd_8 = dt.Rows[0]["nc_rh_8"].ToString();
            if (rd_8 == "yes")
            {
                rd_yes_8.Checked = true;
            }
            else
            {
                rd_no_8.Checked = true;
            }

            string rd_9 = dt.Rows[0]["nc_rh_9"].ToString();
            if (rd_9 == "yes")
            {
                rd_yes_9.Checked = true;
            }
            else
            {
                rd_no_9.Checked = true;
            }

            string rd_10 = dt.Rows[0]["nc_rh_10"].ToString();
            if (rd_10 != "no")
            {
                rd_yes_10.Checked = true;
                txt_yes_10.Value = dt.Rows[0]["nc_rh_10"].ToString();
            }
            else
            {
                rd_no_10.Checked = true;
            }

            string rd_11 = dt.Rows[0]["nc_rh_11"].ToString();
            if (rd_11 == "yes")
            {
                rd_yes_11.Checked = true;
            }
            else
            {
                rd_no_11.Checked = true;
            }

            string rd_12 = dt.Rows[0]["nc_rh_12"].ToString();
            if (rd_12 != "no")
            {
                rd_yes_12.Checked = true;
                txt_yes_12.Value = dt.Rows[0]["nc_rh_12"].ToString();
            }
            else
            {
                rd_no_12.Checked = true;
            }

            string rd_13 = dt.Rows[0]["nc_rh_13"].ToString();
            if (rd_13 == "yes")
            {
                rd_yes_13.Checked = true;
            }
            else
            {
                rd_no_13.Checked = true;
            }

            txt_other.Value = dt.Rows[0]["nc_rh_other"].ToString();

            txt_History.Value = dt.Rows[0]["nc_history"].ToString();
            // Div 3 --------------------------------------------------------- End 
        }

        public Boolean checkValueNull(string val)
        {
            Boolean bl = false;

            if (val == "")
            {
                bl = true;
            }

            return bl;
        }

        protected void btn_submit_1_ServerClick(object sender, EventArgs e)
        {
            string scModal = "";
            string result = SaveBlock_1("insert");
            if (result == "Missing")
            {
                scModal = "fn_AlertModal('Info','กรุณากรอกข้อมูลในส่วนที่จำเป็นให้ครบถ้วน !!','',0);";
            }
            else if (result == "Notsave")
            {
                scModal = "fn_AlertModal('Warning','ไม่สามารถบันทึกข้อมูลได้กรุณาติดต่อเจ้าหน้าที่ !!','',0);";
            }
            else
            { }
            Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
        }

        protected void btn_submit_2_ServerClick(object sender, EventArgs e)
        {
            string scModal = "";

            string result = "";

            result = SaveBlock_1("check");
            if (result == "Success")
            {
                result = SaveBlock_3();
                if (result == "Success")
                {
                    string id = Request.QueryString["nc"].ToString();

                    string[] KR = SaveBlock_2(id).Split('_');
                    string keyReport = KR[0];
                    result = KR[1];
                    if (result == "Success")
                    {
                        scModal = "fn_AlertModal('Success','บันทึกสำเร็จ','Report.aspx?nc=" + id + "&key=" + keyReport + "',2000);";
                    }
                    else if (result == "Notsave")
                    {
                        scModal = "fn_AlertModal('Warning','ไม่สามารถบันทึกข้อมูล(ส่วนที่ 2)ได้กรุณาติดต่อเจ้าหน้าที่ !!','',0);";
                    }
                    else { }
                }
                else
                {
                    if (result == "Notsave")
                    {
                        scModal = "fn_AlertModal('Warning','ไม่สามารถอัพเดทข้อมูล(ส่วนที่ 3-5)ข้อมูลได้กรุณาติดต่อเจ้าหน้าที่ !!','',0);";
                    }
                    else if (result == "Missing")
                    {
                        scModal = "fn_AlertModal('Info','กรุณากรอกข้อมูล(ส่วนที่ 3-5)ในส่วนที่จำเป็นให้ครบถ้วน !!','',0);";
                    }
                    else if (result == "KeyExpire")
                    {
                        scModal = "fn_AlertModal('Warning','Session(ส่วนที่ 3-5)หมดอายุ !!','',0);";
                    }
                    else if (result == "Nodata")
                    {
                        scModal = "fn_AlertModal('Info','ไม่พบข้อมูล(ส่วนที่ 3-5)ในฐานข้อมูล !!','',0);";
                    }
                }
            }
            else
            {
                if (result == "Missing")
                {
                    scModal = "fn_AlertModal('Info','กรุณากรอกข้อมูล(ส่วนที่ 1)ในส่วนที่จำเป็นให้ครบถ้วน !!','',0);";
                }
                else if (result == "Notsave")
                {
                    scModal = "fn_AlertModal('Warning','ไม่สามารถอัพเดทข้อมูล(ส่วนที่ 1)ได้กรุณาติดต่อเจ้าหน้าที่ !!','',0);";
                }
                else { }
            }
            Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
            //"Success'); setTimeout(function(){window.location.href='Report.aspx?nc=" + id + "';}, 2000);</script>";
        }

        protected void btn_submit_3_ServerClick(object sender, EventArgs e)
        {
            string scModal = "";
            string result = SaveBlock_3();
            if (result == "Success")
            {
                div_result.Visible = true;
                scModal = "fn_AlertModal('Success','Success !!','',0);";
            }
            else if (result == "Notsave")
            {
                scModal = "fn_AlertModal('Warning','ไม่สามารถบันทึกข้อมูลได้กรุณาติดต่อเจ้าหน้าที่ !!','',0);";
            }
            else if (result == "Missing" || result == "MissingVac")
            {
                scModal = "fn_AlertModal('Info','กรุณากรอกข้อมูลในส่วนที่จำเป็นให้ครบถ้วน !!','',0);";
            }
            else if (result == "KeyExpire")
            {
                scModal = "fn_AlertModal('Warning','Seccion การกรอกข้อมูลหมดอายุ !!','',0);";
            }
            else if (result == "Nodata")
            {
                scModal = "fn_AlertModal('Info','ไม่พบข้อมูล !!','',0);";
            }
            else
            { }
            Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
        }

        public string OffensiveWord(string text)
        {
            string result = text.Replace("'","\'");

            return result;
        }

        protected string SaveBlock_1(string type)
        {
            string result = "";

            string save = "yes";

            string fname = txt_fname.Value.ToString().Trim();
            if (checkValueNull(fname))
            {
                save = "no";
                txt_fname.Attributes.Add("style", styleRequired);
            }
            else
            {
                txt_fname.Attributes.Remove("style");
            }

            string lname = txt_lname.Value.ToString().Trim();
            if (checkValueNull(lname))
            {
                save = "no";
                txt_lname.Attributes.Add("style", styleRequired);
            }
            else
            {
                txt_lname.Attributes.Remove("style");
            }

            string sex = "";
            if (rd_sex_M.Checked)
            {
                sex = rd_sex_M.Value.ToString();
            }
            else
            {
                if (rd_sex_F.Checked)
                {
                    sex = rd_sex_F.Value.ToString();
                }
            }
            if (checkValueNull(sex))
            {
                save = "no";
                div_rd_sex.Attributes.Add("style", styleRequired);
            }
            else
            {
                div_rd_sex.Attributes.Remove("style");
            }

            //string DOB = date_DOB.Value.ToString();
            //if (checkValueNull(DOB))
            //{
            //    save = "no";
            //    date_DOB.Attributes.Add("style", styleRequired);
            //}
            //else
            //{
            //    date_DOB.Attributes.Remove("style");
            //}

            string D = txt_D.Value.ToString().Trim();
            if (checkValueNull(D))
            {
                save = "no";
                txt_D.Attributes.Add("style", styleRequired);
            }
            else
            {
                txt_D.Attributes.Remove("style");
            }

            string O = txt_O.Value.ToString().Trim();
            if (checkValueNull(O))
            {
                save = "no";
                txt_O.Attributes.Add("style", styleRequired);
            }
            else
            {
                txt_O.Attributes.Remove("style");
            }

            string B = txt_B.Value.ToString().Trim();
            if (checkValueNull(B))
            {
                save = "no";
                txt_B.Attributes.Add("style", styleRequired);
            }
            else
            {
                txt_B.Attributes.Remove("style");
            }

            int intB = int.Parse(B);
            if (intB > DateTime.Now.Year)
            {
                intB = intB - 543;
            }

            string DOB = intB.ToString() + "-" + O + "-" + D;


            string career = txt_career.Value.ToString().Trim();
            if (checkValueNull(career))
            {
                save = "no";
                txt_career.Attributes.Add("style", styleRequired);
            }
            else
            {
                txt_career.Attributes.Remove("style");
            }

            string nationality = txt_nationality.Value.ToString().Trim();
            if (checkValueNull(nationality))
            {
                save = "no";
                txt_nationality.Attributes.Add("style", styleRequired);
            }
            else
            {
                txt_nationality.Attributes.Remove("style");
            }

            string race = txt_race.Value.ToString().Trim();
            if (checkValueNull(race))
            {
                save = "no";
                txt_race.Attributes.Add("style", styleRequired);
            }
            else
            {
                txt_race.Attributes.Remove("style");
            }

            string baan = "";
            string baanOther = "";
            if (rd_baan_1.Checked)
            {
                baan = rd_baan_1.Value.ToString();
            }
            else
            {
                if (rd_baan_2.Checked)
                {
                    baan = "";
                    baanOther = txt_baan_2.Value.ToString().Trim();
                    if (checkValueNull(baanOther))
                    {
                        save = "no";
                        txt_baan_2.Attributes.Add("style", styleRequired);
                    }
                    else
                    {
                        baan = baanOther;
                        txt_baan_2.Attributes.Remove("style");
                    }
                }
            }
            if (checkValueNull(baan)) 
            {
                div_rd_baan.Attributes.Add("style", styleRequired);
                save = "no"; 
            }
            else
            {
                div_rd_baan.Attributes.Remove("style");
            }

            string adr_number = txt_adr_number.Value.ToString().Trim();
            if (checkValueNull(adr_number))
            {
                save = "no";
                txt_adr_number.Attributes.Add("style", styleRequired);
            }
            else
            {
                txt_adr_number.Attributes.Remove("style");
            }

            string adr_moo = txt_adr_moo.Value.ToString().Trim();
            //if (checkValueNull(adr_moo))
            //{
            //    save = "no";
            //    txt_adr_moo.Attributes.Add("style", styleRequired);
            //}
            //else
            //{
            //    txt_adr_moo.Attributes.Remove("style");
            //}

            string adr_baan = txt_adr_baan.Value.ToString().Trim();
            string adr_alley = txt_adr_alley.Value.ToString().Trim();
            string adr_road = txt_adr_road.Value.ToString().Trim();

            string adr_subdistrict = txt_adr_subdistrict.Value.ToString().Trim();
            if (checkValueNull(adr_subdistrict))
            {
                save = "no";
                txt_adr_subdistrict.Attributes.Add("style", styleRequired);
            }
            else
            {
                txt_adr_subdistrict.Attributes.Remove("style");
            }

            string adr_district = txt_adr_district.Value.ToString().Trim();
            if (checkValueNull(adr_district))
            {
                save = "no";
                txt_adr_district.Attributes.Add("style", styleRequired);
            }
            else
            {
                txt_adr_district.Attributes.Remove("style");
            }

            string adr_province = txt_adr_province.Value.ToString().Trim();
            if (checkValueNull(adr_province))
            {
                save = "no";
                txt_adr_province.Attributes.Add("style", styleRequired);
            }
            else
            {
                txt_adr_province.Attributes.Remove("style");
            }

            //string adr_phone = txt_adr_phone.Value.ToString().Trim();
            //string adr_tel = txt_adr_tel.Value.ToString().Trim();

            string adr_mobile = txt_adr_mobile.Value.ToString().Trim();
            if (checkValueNull(adr_mobile))
            {
                save = "no";
                txt_adr_mobile.Attributes.Add("style", styleRequired);
            }
            else
            {
                txt_adr_mobile.Attributes.Remove("style");
            }

            string pregnant = "no";
            string pregnant_num = "";
            string pregnant_week = "";
            if (rd_sex_F.Checked)
            {
                if (rd_yespregnant.Checked)
                {
                    pregnant = "yes";
                    pregnant_num = num_pregnan.Value.ToString();
                    pregnant_week = num_pregnanweek.Value.ToString();
                }
            }

            string workplace = txt_workplace.Value.ToString().Trim();
            string telMorchana = txt_morchana_mobile.Value.ToString();
            string congenitaldisease = txt_congenitalDisease.Value.ToString().Trim();
            string smoking = txtH_smoking.Value.ToString().Trim();

            
            if (save == "yes")
            {
                if (type == "insert")
                {
                    string key = cl_Sql.GenerateKey(11);

                    int i = 0;
                    while (i == 0)
                    {
                        sql = "select * from novelcorona where convert(nc_datetime,date)=current_date and nc_key = '" + key + "'; ";
                        dt = new DataTable();
                        dt = cl_Sql.select(sql);
                        if (dt.Rows.Count > 0)
                        {
                            key = cl_Sql.GenerateKey(11);
                        }
                        else
                        {
                            i = 1;
                            break;
                        }
                    }

                    sql = "INSERT INTO novelcorona " +
                        "\n(nc_key" +
                        ", nc_fname" +
                        ", nc_lname" +
                        ", nc_sex" +
                        ", nc_dob" +
                        ", nc_career" +
                        ", nc_nationality" +
                        ", nc_race" +
                        ", nc_baan" +
                        ", nc_adr_number" +
                        ", nc_adr_moo" +
                        ", nc_adr_baan" +
                        ", nc_adr_alley" +
                        ", nc_adr_road" +
                        ", nc_adr_subdistrict" +
                        ", nc_adr_district" +
                        ", nc_adr_province" +
                        //", nc_adr_phone" +
                        //", nc_adr_tel" +
                        ", nc_adr_mobile" +
                        ", nc_workplace" +
                        ", nc_telmorchana" +
                        ", nc_congenitaldisease" +
                        ", nc_smoking" +
                        ", nc_pregnant" +
                        ", nc_pregnant_num" +
                        ", nc_pregnant_week) " +
                        "\nVALUES('" + key + "', '" + fname + "', '" + lname + "', '" + sex + "', '" + DOB + "', '" + career + "', '" + nationality + "', '" + race + "', '" + baan + "', '" + adr_number + "', '" + adr_moo + "', '" + adr_baan + "', '" + adr_alley + "', '" + adr_road + "', '" + adr_subdistrict + "', '" + adr_district + "', '" + adr_province + "', '" + adr_mobile + "', '" + workplace + "', '" + telMorchana + "', '" + congenitaldisease + "', '" + smoking + "','" + pregnant + "','" + pregnant_num + "','" + pregnant_week + "'); ";
                    if (cl_Sql.Modify(sql))
                    {
                        sql = "select * from novelcorona where convert(nc_datetime,date)=current_date and nc_key = '" + key + "'; ";
                        dt = new DataTable();
                        dt = cl_Sql.select(sql);
                        if (dt.Rows.Count > 0)
                        {
                            //Session.Timeout = 60;
                            //Session["key"] = key + "_" + dt.Rows[0]["nc_id"].ToString();
                            txt_key.Value = key + "_" + dt.Rows[0]["nc_id"].ToString();
                        }

                        div_1.Visible = false;
                        div_3.Visible = true;
                        btn_submit_1.Visible = false;
                        btn_submit_3.Visible = true;

                        result = "Success";
                    }
                    else
                    {
                        result = "Notsave";
                    }
                }
                else
                {
                    string ncid = Request.QueryString["nc"].ToString();

                    sql = "UPDATE novelcorona SET "+
                        "\nnc_fname = '" + fname + "', nc_lname = '" + lname + "', " +
                        "nc_sex = '" + sex + "', nc_dob = '" + DOB + "', " +
                        "nc_career = '" + career + "', " +
                        "nc_nationality = '" + nationality + "', " +
                        "nc_race = '" + race + "', " +
                        "nc_baan = '" + baan + "', " +
                        "nc_adr_number = '" + adr_number + "', " +
                        "nc_adr_moo = '" + adr_moo + "', " +
                        "nc_adr_baan = '" + adr_baan + "', " +
                        "nc_adr_alley = '" + adr_alley + "', " +
                        "nc_adr_road = '" + adr_road + "', " +
                        "nc_adr_subdistrict = '" + adr_subdistrict + "', " +
                        "nc_adr_district = '" + adr_district + "', " +
                        "nc_adr_province = '" + adr_province + "', " +
                        "nc_adr_mobile = '" + adr_mobile + "', " +
                        "nc_workplace = '" + workplace + "', " +
                        "nc_telmorchana = '" + telMorchana + "', " +
                        "nc_congenitaldisease = '" + congenitaldisease + "', " +
                        "nc_smoking = '" + smoking + "', " +
                        "nc_pregnant = '" + pregnant + "', " +
                        "nc_pregnant_num = '" + pregnant_num + "', " +
                        "nc_pregnant_week = '" + pregnant_week + "' " +
                        "\nWHERE nc_id = '" + ncid + "'; ";
                    if (cl_Sql.Modify(sql))
                    {
                        result = "Success";
                    }
                    else
                    {
                        result = "Notsave";
                    }
                }
            }
            else
            {
                result = "Missing";
            }

            return result;
        }

        protected string SaveBlock_2(string id)
        {
            string result = "alert";
            string key = "key";

            string next = "yes";

            string whenSick = "NULL";
            if (date_whenSick.Value.ToString() == "")
            {
                next = "no";
                date_whenSick.Attributes.Add("style", styleRequired);
            }
            else
            {
                whenSick = "'" + DateTime.Parse(date_whenSick.Value.ToString()).ToString("yyyy-MM-dd") + "'";
                date_whenSick.Attributes.Remove("style");
            }
            string firstVisit = "NULL";
            if (date_firstVisit.Value.ToString() != "")
            {
                firstVisit = "'" + DateTime.Parse(date_firstVisit.Value.ToString()).ToString("yyyy-MM-dd") + "'";
            }
            string firstHospital = txt_firstHospital.Value.ToString().Trim();
            string firstHospital_province = txt_firstHospital_province.Value.ToString().Trim();
            string currenHospital = txt_currenHospital.Value.ToString().Trim();
            string currenHospital_province = txt_currenHospital_province.Value.ToString().Trim();
            string sick = "no";
            if (cb_sickyes.Checked)
            {
                sick = cb_sickyes.Value.ToString();
            }
            string temperature = txt_temperature.Value.ToString().Trim();
            string O2sat = txt_O2sat.Value.ToString().Trim();
            string symptom = "no";
            string respirator = "no";
            if (cb_sickyes.Checked)
            {
                symptom = "yes";
            }
            if (cb_respirator.Checked)
            {
                symptom = "yes";
                respirator = cb_respirator.Value.ToString();
            }
            string symptom_1 = ""; if (cb_symptom_1.Checked) { symptom_1 = cb_symptom_1.Value.ToString(); symptom = "yes"; }
            string symptom_2 = ""; if (cb_symptom_2.Checked) { symptom_2 = cb_symptom_2.Value.ToString(); symptom = "yes"; }
            string symptom_3 = ""; if (cb_symptom_3.Checked) { symptom_3 = cb_symptom_3.Value.ToString(); symptom = "yes"; }
            string symptom_4 = ""; if (cb_symptom_4.Checked) { symptom_4 = cb_symptom_4.Value.ToString(); symptom = "yes"; }
            string symptom_5 = ""; if (cb_symptom_5.Checked) { symptom_5 = cb_symptom_5.Value.ToString(); symptom = "yes"; }
            string symptom_6 = ""; if (cb_symptom_6.Checked) { symptom_6 = cb_symptom_6.Value.ToString(); symptom = "yes"; }
            string symptom_7 = ""; if (cb_symptom_7.Checked) { symptom_7 = cb_symptom_7.Value.ToString(); symptom = "yes"; }
            string symptom_8 = ""; if (cb_symptom_8.Checked) { symptom_8 = cb_symptom_8.Value.ToString(); symptom = "yes"; }
            string symptom_9 = ""; if (cb_symptom_9.Checked) { symptom_9 = cb_symptom_9.Value.ToString(); symptom = "yes"; }
            string symptom_10 = ""; if (cb_symptom_10.Checked) { symptom_10 = cb_symptom_10.Value.ToString(); symptom = "yes"; }
            string symptom_11 = "";
            string symptom_11_location = "";
            if (cb_symptom_11.Checked) 
            {
                symptom = "yes";
                symptom_11 = cb_symptom_11.Value.ToString(); 
                symptom_11_location = txt_symptom_11.Value.ToString().Trim(); 
            }
            //cb_symptom_8 >> ใส่เครื่องช่วยหายใจ
            //cb_symptom_9 >> อื่นๆ
            string symptomOther = txt_symptomOther.Value.ToString().Trim();
            if (symptomOther != "") { symptom = "yes"; }

            if (symptom == "no")
            {
                next = "no";
                div_symptom.Attributes.Add("style", styleRequired);
            }
            else
            {
                div_symptom.Attributes.Remove("style");
            }

            string xray = "";
            if (rd_xray_no.Checked)
            {
                xray = rd_xray_no.Value.ToString();
            }
            else if (rd_xray_yes.Checked)
            {
                xray = rd_xray_yes.Value.ToString();
            }
            else
            {
                xray = "";
            }
            string xrayDate = "NULL";
            if (date_xray.Value.ToString() != "")
            {
                xrayDate = "'" + DateTime.Parse(date_xray.Value.ToString()).ToString("yyyy-MM-dd") + "'";
            }
            string xrayResult = txt_xray_result.Value.ToString().Trim();
            string cbc_date = "NULL";
            if (date_cbc.Value.ToString() != "")
            {
                cbc_date = "'" + DateTime.Parse(date_cbc.Value.ToString()).ToString("yyyy-MM-dd") + "'";
            }
            string cbc_hb = txt_cbc_hb.Value.ToString().Trim();
            string cbc_hct = txt_cbc_hct.Value.ToString().Trim();
            string cbc_wbc = txt_cbc_wbc.Value.ToString().Trim();
            string pc_x = txt_pc_x.Value.ToString().Trim();
            string pc_n = txt_pc_n.Value.ToString().Trim();
            string pc_l = txt_pc_l.Value.ToString().Trim();
            string pc_al = txt_pc_al.Value.ToString().Trim();
            string pc_mn = txt_pc_mn.Value.ToString().Trim();
            string influenza_test = txt_influenza.Value.ToString().Trim();
            string influenza = "";
            if (rd_Influenza_N.Checked)
            {
                influenza = rd_Influenza_N.Value.ToString();
            }
            else if (rd_Influenza_P.Checked)
            {
                influenza = rd_Influenza_P.Value.ToString();
            }
            else
            {
                influenza = "";
            }
            string flu_A = ""; if (cb_flu_A.Checked) { flu_A = cb_flu_A.Value.ToString(); }
            string flu_B = ""; if (cb_flu_B.Checked) { flu_B = cb_flu_B.Value.ToString(); }
            string influenza_type = "";
            //influenza_type = txt_influenza_type.Value.ToString().Trim();
            string influenza_date = "NULL";
            //if (date_influenza.Value.ToString() != "")
            //{
            //    influenza_date = "'" + DateTime.Parse(date_influenza.Value.ToString()).ToString("yyyy-MM-dd") + "'";
            //}

            string pcr_ar = txtH_pcr.Value.ToString().Trim();
            if (cb_pcr_no.Checked)
            {
                pcr_ar = cb_pcr_no.Value.ToString();
            }

            // เปลี่ยนจาก Antibody ไปเป็น >>> ATK
            string antibody_ar = txtH_antibody.Value.ToString().Trim();
            if (cb_antibody_no.Checked)
            {
                antibody_ar = cb_antibody_no.Value.ToString();
            }
            else
            {
                if (antibody_ar == "")
                {
                    next = "no";
                    div_antibody.Attributes.Add("style", styleRequired);
                }
                else
                {
                    div_antibody.Attributes.Remove("style");
                }
            }

            string opd = ""; if (cb_opd.Checked) { opd = cb_opd.Value.ToString(); }
            string admit = ""; if (cb_admit.Checked) { admit = cb_admit.Value.ToString(); }
            string admit_date = "NULL";
            if (date_admit.Value.ToString() != "")
            {
                admit_date = "'" + DateTime.Parse(date_admit.Value.ToString()).ToString("yyyy-MM-dd") + "'";
            }
            string diagnosis = txt_diagnosis.Value.ToString().Trim();
            string antiviral = "";
            if (rd_antiviral_no.Checked)
            {
                antiviral = rd_antiviral_no.Value.ToString();
            }
            else if (rd_antiviral_yes.Checked)
            {
                antiviral = rd_antiviral_yes.Value.ToString();
            }
            else
            {
                antiviral = "";
            }
            string antiviral_date = "NULL";
            if (date_antiviral.Value.ToString() != "")
            {
                antiviral_date = "'" + DateTime.Parse(date_antiviral.Value.ToString()).ToString("yyyy-MM-dd") + "'";
            }

            string anti_re = ""; if (cb_re.Checked) { anti_re = cb_re.Value.ToString(); }
            string anti_fa = ""; if (cb_fa.Checked) { anti_fa = cb_fa.Value.ToString(); }
            string anti_lori = ""; if (cb_lori.Checked) { anti_lori = cb_lori.Value.ToString(); }
            string anti_da = ""; if (cb_da.Checked) { anti_da = cb_da.Value.ToString(); }
            string anti_ri = ""; if (cb_ri.Checked) { anti_ri = cb_ri.Value.ToString(); }
            string anti_chhy = ""; if (cb_chhy.Checked) { anti_chhy = cb_chhy.Value.ToString(); }
            string anti_other = ""; if (cb_other.Checked) { anti_other = txt_cb_other.Value.ToString(); }

            string pt_status = "";
            if (rd_pt_status_1.Checked) { pt_status = rd_pt_status_1.Value.ToString(); }
            if (rd_pt_status_2.Checked) { pt_status = rd_pt_status_2.Value.ToString(); }
            if (rd_pt_status_3.Checked) { pt_status = rd_pt_status_3.Value.ToString(); }
            if (rd_pt_status_4.Checked) { pt_status = rd_pt_status_4.Value.ToString(); }
            if (rd_pt_status_5.Checked) { pt_status = rd_pt_status_5.Value.ToString(); }

            string pt_status_4 = txt_pt_status_4.Value.ToString().Trim();
            string pt_status_5 = txt_pt_status_5.Value.ToString().Trim();

            string user = "customer";
            if (Session["userid"] != null)
            {
                user = Session["userid"].ToString();
            }

            if (cb_ail_no.Checked) { next = "yes"; } // ติ๊ก ไม่มี อาการเจ็บป่วย >> ไม่ต้องเช็ค

            if (next == "yes")
            {
                sql = "select ncc_id from novelcorona_clinic where ncc_ncid='" + id + "'; ";
                dt = new DataTable();
                dt = cl_Sql.select(sql);
                if (dt.Rows.Count > 0)
                {
                    string ncc_id = dt.Rows[0]["ncc_id"].ToString();
                    sql = "update novelcorona_clinic set " +
                    "\nncc_user='" + user + "', " +
                    "ncc_whensick=" + whenSick + ", " +
                    "ncc_firstvisit=" + firstVisit + ", " +
                    "ncc_firsthospital='" + firstHospital + "', " +
                    "ncc_firsthospital_province='" + firstHospital_province + "', " +
                    "ncc_currenhospital='" + currenHospital + "', " +
                    "ncc_currenhospital_province='" + currenHospital_province + "', " +
                    "ncc_sick='" + sick + "', " +
                    "ncc_temperature='" + temperature + "', " +
                    "ncc_o2sat='" + O2sat + "', " +
                    "ncc_respirator='" + respirator + "', " +
                    "ncc_symptom_1='" + symptom_1 + "', " +
                    "ncc_symptom_2='" + symptom_2 + "', " +
                    "ncc_symptom_3='" + symptom_3 + "', " +
                    "ncc_symptom_4='" + symptom_4 + "', " +
                    "ncc_symptom_5='" + symptom_5 + "', " +
                    "ncc_symptom_6='" + symptom_6 + "', " +
                    "ncc_symptom_7='" + symptom_7 + "', " +
                    "ncc_symptom_8='" + symptom_8 + "', " +
                    "ncc_symptom_9='" + symptom_9 + "', " +
                    "ncc_symptom_10='" + symptom_10 + "', " +
                    "ncc_symptom_11='" + symptom_11 + "', " +
                    "ncc_symptom_11_location='" + symptom_11_location + "', " +
                    "ncc_symptomother='" + symptomOther + "', " +
                    "ncc_xray='" + xray + "', " +
                    "ncc_xraydate=" + xrayDate + ", " +
                    "ncc_xrayresult='" + xrayResult + "', " +
                    "ncc_cbc_date=" + cbc_date + ", " +
                    "ncc_cbc_hb='" + cbc_hb + "', " +
                    "ncc_cbc_hct='" + cbc_hct + "', " +
                    "ncc_cbc_wbc='" + cbc_wbc + "', " +
                    "ncc_pc_x='" + pc_x + "', " +
                    "ncc_pc_n='" + pc_n + "', " +
                    "ncc_pc_l='" + pc_l + "', " +
                    "ncc_pc_al='" + pc_al + "', " +
                    "ncc_pc_mn='" + pc_mn + "', " +
                    "ncc_influenza_test='" + influenza_test + "', " +
                    "ncc_influenza='" + influenza + "', " +
                    "ncc_flu_a='" + flu_A + "', " +
                    "ncc_flu_b='" + flu_B + "', " +
                    "ncc_influenza_type='" + influenza_type + "', " +
                    "ncc_influenza_date=" + influenza_date + ", " +
                    "ncc_pcr_array='" + pcr_ar + "', " +
                    "ncc_antibody_array='" + antibody_ar + "', " +
                    "ncc_opd='" + opd + "', " +
                    "ncc_admit='" + admit + "', " +
                    "ncc_admit_date=" + admit_date + ", " +
                    "ncc_diagnosis='" + diagnosis + "', " +
                    "ncc_antiviral='" + antiviral + "', " +
                    "ncc_antiviral_date=" + antiviral_date + ", " +
                    "ncc_re='" + anti_re + "', ncc_fa='" + anti_fa + "', ncc_lori='" + anti_lori + "', ncc_da='" + anti_da + "', ncc_ri='" + anti_ri + "', ncc_chhy='" + anti_chhy + "', ncc_anti_other='" + anti_other + "', " +
                    "ncc_pt_status='" + pt_status + "', " +
                    "ncc_pt_status_4='" + pt_status_4 + "', " +
                    "ncc_pt_status_5='" + pt_status_5 + "' " +
                    "\nwhere ncc_id='" + ncc_id + "'; ";
                }
                else
                {
                    sql = "INSERT INTO novelcorona_clinic " +
                        "\n(ncc_user, " +
                        "ncc_ncid, " +
                        "ncc_whensick, " +
                        "ncc_firstvisit, " +
                        "ncc_firsthospital, " +
                        "ncc_firsthospital_province, " +
                        "ncc_currenhospital, " +
                        "ncc_currenhospital_province, " +
                        "ncc_sick, " +
                        "ncc_temperature, " +
                        "ncc_o2sat, " +
                        "ncc_respirator, " +
                        "ncc_symptom_1, " +
                        "ncc_symptom_2, " +
                        "ncc_symptom_3, " +
                        "ncc_symptom_4, " +
                        "ncc_symptom_5, " +
                        "ncc_symptom_6, " +
                        "ncc_symptom_7, " +
                        "ncc_symptom_8, " +
                        "ncc_symptom_9, " +
                        "ncc_symptom_10, " +
                        "ncc_symptom_11, " +
                        "ncc_symptom_11_location, " +
                        "ncc_symptomother, " +
                        "ncc_xray, " +
                        "ncc_xraydate, " +
                        "ncc_xrayresult, " +
                        "ncc_cbc_date, " +
                        "ncc_cbc_hb, " +
                        "ncc_cbc_hct, " +
                        "ncc_cbc_wbc, " +
                        "ncc_pc_x, " +
                        "ncc_pc_n, " +
                        "ncc_pc_l, " +
                        "ncc_pc_al, " +
                        "ncc_pc_mn, " +
                        "ncc_influenza_test, " +
                        "ncc_influenza, " +
                        "ncc_flu_a, " +
                        "ncc_flu_b, " +
                        "ncc_influenza_type, " +
                        "ncc_influenza_date, " +
                        "ncc_pcr_array, " +
                        "ncc_antibody_array, " +
                        "ncc_opd, " +
                        "ncc_admit, " +
                        "ncc_admit_date, " +
                        "ncc_diagnosis, " +
                        "ncc_antiviral, " +
                        "ncc_antiviral_date, " +
                        "ncc_re, ncc_fa, ncc_lori, ncc_da, ncc_ri, ncc_chhy, ncc_anti_other, " +
                        "ncc_pt_status, " +
                        "ncc_pt_status_4, " +
                        "ncc_pt_status_5) " +
                        "\nVALUES('" + user + "', " + id + ", " + whenSick + ", " + firstVisit + ", '" + firstHospital + "', '" + firstHospital_province + "', '" + currenHospital + "', '" + currenHospital_province + "', '" + sick + "', '" + temperature + "', '" + O2sat + "', '" + respirator + "', '" + symptom_1 + "', '" + symptom_2 + "', '" + symptom_3 + "', '" + symptom_4 + "', '" + symptom_5 + "', '" + symptom_6 + "', '" + symptom_7 + "', '" + symptom_8 + "', '" + symptom_9 + "', '" + symptom_10 + "', '" + symptom_11 + "', '" + symptom_11_location + "', '" + symptomOther + "', '" + xray + "', " + xrayDate + ", '" + xrayResult + "', " + cbc_date + ", '" + cbc_hb + "', '" + cbc_hct + "', '" + cbc_wbc + "', '" + pc_x + "', '" + pc_n + "', '" + pc_l + "', '" + pc_al + "', '" + pc_mn + "', '" + influenza_test + "', '" + influenza + "', '" + flu_A + "', '" + flu_B + "', '" + influenza_type + "', " + influenza_date + ", '" + pcr_ar + "', '" + antibody_ar + "', '" + opd + "', '" + admit + "', " + admit_date + ", '" + diagnosis + "', '" + antiviral + "', " + antiviral_date + ", '" + anti_re + "','" + anti_fa + "','" + anti_lori + "','" + anti_da + "','" + anti_ri + "','" + anti_chhy + "','" + anti_other + "', '" + pt_status + "', '" + pt_status_4 + "', '" + pt_status_5 + "'); ";
                }

                string reporter = txt_fname.Value.ToString().Trim() + " " + txt_lname.Value.ToString().Trim();
                sql += "\nupdate novelcorona_clinic set ncc_reporter='" + reporter + "'; "; // ใส่ชื่อลูกค้าเป้นคนกรอกข้อมูล

                if (cl_Sql.Modify(sql))
                {
                    string staffcheck = "no";
                    if(Session["status"] != null)
                    {
                        string status = Session["status"].ToString();
                        if (status == "admin" || status == "novelcovid")
                        {
                            staffcheck = "yes";
                        }
                    }
                    staffcheck = "yes"; // ผ่านไปเลย พยาบาลไม่ต้องเช็คอีก

                    sql = "update novelcorona set nc_staffcheck = '" + staffcheck + "' where nc_id = '" + id + "'; ";
                    if (cl_Sql.Modify(sql))
                    {
                        sql = "select * from novelcorona where nc_id='" + id + "' ";
                        dt = new DataTable();
                        dt = cl_Sql.select(sql);
                        if (dt.Rows.Count > 0)
                        {
                            key = dt.Rows[0]["nc_key"].ToString();
                            result = "Success";

                            sql = "update novelcorona set nc_active='yes' where nc_id = '" + id + "'; ";
                            cl_Sql.Modify(sql);
                        }
                    }
                    else
                    {
                        result = "Notsave";
                    }
                }
                else
                {
                    result = "Notsave";
                }
            }
            else
            {
                result = "Missing";

                sql = "update novelcorona set nc_active='no' where nc_id = '" + id + "'; ";
                cl_Sql.Modify(sql);
            }

            return key + "_" + result;
        }

        protected string SaveBlock_3()
        {
            string result = "";

            string save = "yes";

            string RH_1 = "";
            //if (rd_no_1.Checked)
            //{
            //    RH_1 = rd_no_1.Value.ToString();
            //}
            //else
            //{
            //    if (rd_yes_1.Checked)
            //    {
            //        RH_1 = rd_yes_1.Value.ToString();
            //    }
            //}
            //if (checkValueNull(RH_1))
            //{
            //    save = "no";
            //    div_rd_1.Attributes.Add("style", styleRequired);
            //}
            //else
            //{
            //    div_rd_1.Attributes.Remove("style");
            //}
            // -----------------------------------------------------------------------
            string RH_2 = "";
            //if (rd_no_2.Checked)
            //{
            //    RH_2 = rd_no_2.Value.ToString();
            //}
            //else
            //{
            //    if (rd_yes_2.Checked)
            //    {
            //        RH_2 = "";
            //        string txt_2 = txt_yes_2.Value.ToString().Trim();
            //        if (checkValueNull(txt_2))
            //        {
            //            save = "no";
            //            txt_yes_2.Attributes.Add("style", styleRequired);
            //        }
            //        else
            //        {
            //            RH_2 = txt_2;
            //            txt_yes_2.Attributes.Remove("style");
            //        }
            //    }
            //}
            //if (checkValueNull(RH_2))
            //{
            //    save = "no";
            //    div_rd_2.Attributes.Add("style", styleRequired);
            //}
            //else
            //{
            //    div_rd_2.Attributes.Remove("style");
            //}
            // -----------------------------------------------------------------------
            string RH_3 = "";
            //if (rd_no_3.Checked)
            //{
            //    RH_3 = rd_no_3.Value.ToString();
            //}
            //else
            //{
            //    if (rd_yes_3.Checked)
            //    {
            //        RH_3 = "";
            //        string txt_3 = txt_yes_3.Value.ToString().Trim();
            //        if (checkValueNull(txt_3))
            //        {
            //            save = "no";
            //            txt_yes_3.Attributes.Add("style", styleRequired);
            //        }
            //        else
            //        {
            //            RH_3 = txt_3;
            //            txt_yes_3.Attributes.Remove("style");
            //        }
            //    }
            //}
            //if (checkValueNull(RH_3))
            //{
            //    save = "no";
            //    div_rd_3.Attributes.Add("style", styleRequired);
            //}
            //else
            //{
            //    div_rd_3.Attributes.Remove("style");
            //}
            // -----------------------------------------------------------------------
            string RH_4 = "";
            //if (rd_no_4.Checked)
            //{
            //    RH_4 = rd_no_4.Value.ToString();
            //}
            //else
            //{
            //    if (rd_yes_4.Checked)
            //    {
            //        RH_4 = "";
            //        string txt_4 = txt_yes_4.Value.ToString().Trim();
            //        if (checkValueNull(txt_4))
            //        {
            //            save = "no";
            //            txt_yes_4.Attributes.Add("style", styleRequired);
            //        }
            //        else
            //        {
            //            RH_4 = txt_4;
            //            txt_yes_4.Attributes.Remove("style");
            //        }
            //    }
            //}
            //if (checkValueNull(RH_4))
            //{
            //    save = "no";
            //    div_rd_4.Attributes.Add("style", styleRequired);
            //}
            //else
            //{
            //    div_rd_4.Attributes.Remove("style");
            //}
            // -----------------------------------------------------------------------
            string RH_travel_date = "";
            string RH_travel_airline = "";
            string RH_travel_flight = "";
            string RH_travel_seatnumber = "";
            //if (date_travel.Value.ToString() != "")
            //{
            //    RH_travel_date = DateTime.Parse(date_travel.Value.ToString()).ToString("yyyy-MM-dd");

            //    RH_travel_airline = txt_travel_airline.Value.ToString().Trim();
            //    if (checkValueNull(RH_travel_airline))
            //    {
            //        save = "no";
            //        txt_travel_airline.Attributes.Add("style", styleRequired);
            //    }
            //    else
            //    {
            //        txt_travel_airline.Attributes.Remove("style");
            //    }

            //    RH_travel_flight = txt_travel_flight.Value.ToString().Trim();
            //    if (checkValueNull(RH_travel_flight))
            //    {
            //        save = "no";
            //        txt_travel_flight.Attributes.Add("style", styleRequired);
            //    }
            //    else
            //    {
            //        txt_travel_flight.Attributes.Remove("style");
            //    }

            //    RH_travel_seatnumber = txt_travel_seatnumber.Value.ToString().Trim();
            //    if (checkValueNull(RH_travel_seatnumber))
            //    {
            //        save = "no";
            //        txt_travel_seatnumber.Attributes.Add("style", styleRequired);
            //    }
            //    else
            //    {
            //        txt_travel_seatnumber.Attributes.Remove("style");
            //    }
            //}
            // -----------------------------------------------------------------------
            string RH_5 = "";
            //if (rd_no_5.Checked)
            //{
            //    RH_5 = rd_no_5.Value.ToString();
            //}
            //else
            //{
            //    if (rd_yes_5.Checked)
            //    {
            //        RH_5 = rd_yes_5.Value.ToString();
            //    }
            //}
            //if (checkValueNull(RH_5))
            //{
            //    save = "no";
            //    div_rd_5.Attributes.Add("style", styleRequired);
            //}
            //else
            //{
            //    div_rd_5.Attributes.Remove("style");
            //}
            // -----------------------------------------------------------------------
            string RH_6 = "";
            //if (rd_no_6.Checked)
            //{
            //    RH_6 = rd_no_6.Value.ToString();
            //}
            //else
            //{
            //    if (rd_yes_6.Checked)
            //    {
            //        RH_6 = rd_yes_6.Value.ToString();
            //    }
            //}
            //if (checkValueNull(RH_6))
            //{
            //    save = "no";
            //    div_rd_6.Attributes.Add("style", styleRequired);
            //}
            //else
            //{
            //    div_rd_6.Attributes.Remove("style");
            //}
            // -----------------------------------------------------------------------
            string RH_7 = "";
            //if (rd_no_7.Checked)
            //{
            //    RH_7 = rd_no_7.Value.ToString();
            //}
            //else
            //{
            //    if (rd_yes_7.Checked)
            //    {
            //        RH_7 = rd_yes_7.Value.ToString();
            //    }
            //}
            //if (checkValueNull(RH_7))
            //{
            //    save = "no";
            //    div_rd_7.Attributes.Add("style", styleRequired);
            //}
            //else
            //{
            //    div_rd_7.Attributes.Remove("style");
            //}
            // -----------------------------------------------------------------------
            string RH_8 = "";
            if (rd_no_8.Checked)
            {
                RH_8 = rd_no_8.Value.ToString();
            }
            else
            {
                if (rd_yes_8.Checked)
                {
                    RH_8 = rd_yes_8.Value.ToString();
                }
            }
            if (checkValueNull(RH_8))
            {
                save = "no";
                div_rd_8.Attributes.Add("style", styleRequired);
            }
            else
            {
                div_rd_8.Attributes.Remove("style");
            }
            // -----------------------------------------------------------------------
            string RH_9 = "";
            //if (rd_no_9.Checked)
            //{
            //    RH_9 = rd_no_9.Value.ToString();
            //}
            //else
            //{
            //    if (rd_yes_9.Checked)
            //    {
            //        RH_9 = rd_yes_9.Value.ToString();
            //    }
            //}
            //if (checkValueNull(RH_9))
            //{
            //    save = "no";
            //    div_rd_9.Attributes.Add("style", styleRequired);
            //}
            //else
            //{
            //    div_rd_9.Attributes.Remove("style");
            //}
            // -----------------------------------------------------------------------
            string RH_10 = "";
            if (rd_no_10.Checked)
            {
                RH_10 = rd_no_10.Value.ToString();
            }
            else
            {
                if (rd_yes_10.Checked)
                {
                    RH_10 = "";
                    string txt_10 = txt_yes_10.Value.ToString().Trim();
                    if (checkValueNull(txt_10))
                    {
                        save = "no";
                        txt_yes_10.Attributes.Add("style", styleRequired);
                    }
                    else
                    {
                        RH_10 = txt_10;
                        txt_yes_10.Attributes.Remove("style");
                    }
                }
            }
            if (checkValueNull(RH_10))
            {
                save = "no";
                div_rd_10.Attributes.Add("style", styleRequired);
            }
            else
            {
                div_rd_10.Attributes.Remove("style");
            }
            // -----------------------------------------------------------------------
            string RH_11 = "";
            if (rd_no_11.Checked)
            {
                RH_11 = rd_no_11.Value.ToString();
            }
            else
            {
                if (rd_yes_11.Checked)
                {
                    RH_11 = rd_yes_11.Value.ToString();
                }
            }
            if (checkValueNull(RH_11))
            {
                save = "no";
                div_rd_11.Attributes.Add("style", styleRequired);
            }
            else
            {
                div_rd_11.Attributes.Remove("style");
            }
            // -----------------------------------------------------------------------
            string RH_12 = "";
            if (rd_no_12.Checked)
            {
                RH_12 = rd_no_12.Value.ToString();
            }
            else
            {
                if (rd_yes_12.Checked)
                {
                    RH_12 = "";
                    string txt_12 = txt_yes_12.Value.ToString().Trim();
                    if (checkValueNull(txt_12))
                    {
                        save = "no";
                        txt_yes_12.Attributes.Add("style", styleRequired);
                    }
                    else
                    {
                        RH_12 = txt_12;
                        txt_yes_12.Attributes.Remove("style");
                    }
                }
            }
            if (checkValueNull(RH_12))
            {
                save = "no";
                div_rd_12.Attributes.Add("style", styleRequired);
            }
            else
            {
                div_rd_12.Attributes.Remove("style");
            }
            // -----------------------------------------------------------------------
            string RH_13 = "";
            //if (rd_no_13.Checked)
            //{
            //    RH_13 = rd_no_13.Value.ToString();
            //}
            //else
            //{
            //    if (rd_yes_13.Checked)
            //    {
            //        RH_13 = rd_yes_13.Value.ToString();
            //    }
            //}
            //if (checkValueNull(RH_13))
            //{
            //    save = "no";
            //    div_rd_13.Attributes.Add("style", styleRequired);
            //}
            //else
            //{
            //    div_rd_13.Attributes.Remove("style");
            //}
            // -----------------------------------------------------------------------

            string risk = save;

            string VacCovid = rd_havebeenVac.Value.ToString();
            if (rd_neverVac.Checked)
            {
                VacCovid = rd_neverVac.Value.ToString();
            }
            string VacCovidBook = rd_bookVac_yes.Value.ToString();
            if (rd_bookVac_no.Checked)
            {
                VacCovidBook = rd_bookVac_no.Value.ToString();
            }

            string vac = "no";
            
            string VacCovid1_date = date_Vac1.Value.ToString();
            string VacCovid1_name = txt_nameVac1.Value.ToString().Trim();
            string VacCovid1_location = txt_locationVac1.Value.ToString().Trim();
            if (VacCovid1_date != "" && VacCovid1_name != "")
            {
                vac = "yes";
            }

            string VacCovid2_date = date_Vac_2.Value.ToString();
            string VacCovid2_name = txt_nameVac_2.Value.ToString().Trim();
            string VacCovid2_location = txt_locationVac_2.Value.ToString().Trim();
            if (VacCovid2_date != "" && VacCovid2_name != "")
            {
                vac = "yes";
            }

            string VacCovid3_date = date_Vac_3.Value.ToString();
            string VacCovid3_name = txt_nameVac_3.Value.ToString().Trim();
            string VacCovid3_location = txt_locationVac_3.Value.ToString().Trim();
            if (VacCovid3_date != "" && VacCovid3_name != "")
            {
                vac = "yes";
            }

            string VacCovid4_date = date_Vac_4.Value.ToString();
            string VacCovid4_name = txt_nameVac_4.Value.ToString().Trim();
            string VacCovid4_location = txt_locationVac_4.Value.ToString().Trim();
            if (VacCovid4_date != "" && VacCovid4_name != "")
            {
                vac = "yes";
            }

            if (VacCovid == "เคยได้รับ")
            {
                if (vac == "yes")
                {
                    div_vac.Attributes.Remove("style");
                }
                else
                {
                    div_vac.Attributes.Add("style", styleRequired);
                }
            }
            else
            {
                vac = "yes";
                if (risk == "no")
                {
                    save = "yes";
                }
                div_vac.Attributes.Remove("style");
            }

            string RH_Other = txt_other.Value.ToString().Trim();

            string history = txt_History.Value.ToString().Trim();


            if (save == "yes")
            {
                string id = "";
                if (Request.QueryString["nc"] != null)
                {
                    id = Request.QueryString["nc"].ToString();
                    if (id == "staff")
                    {
                        id = "";
                    }
                }

                string next = "no";
                if (id == "")
                {
                    if (txt_key.Value != null)
                    {
                        string[] key_ar = txt_key.Value.ToString().Split('_');
                        id = key_ar[1].ToString();
                        string key = key_ar[0].ToString();

                        sql = "select * from novelcorona where nc_id = '" + id + "' and nc_key = '" + key + "'; ";
                        dt = new DataTable();
                        dt = cl_Sql.select(sql);
                        if (dt.Rows.Count > 0)
                        {
                            next = "yes";
                        }
                    }
                }
                else
                {
                    next = "yes";
                }

                if (next == "yes")
                {
                    sql = "Update novelcorona set " +
                        "nc_covidvaccine='" + VacCovid + "', " +
                        "nc_covidvaccine_book='" + VacCovidBook + "', ";
                    if (date_Vac1.Value.ToString() != "")
                    {
                        sql = sql + "nc_covidvaccine1_date=convert('" + date_Vac1.Value.ToString() + "', date), ";
                    }
                    sql = sql + "nc_covidvaccine1_name='" + VacCovid1_name + "', " +
                        "nc_covidvaccine1_location='" + VacCovid1_location + "', ";
                    if (date_Vac_2.Value.ToString() != "")
                    {
                        sql = sql + "nc_covidvaccine2_date=convert('" + date_Vac_2.Value.ToString() + "', date), ";
                    }
                    sql = sql + "nc_covidvaccine2_name='" + VacCovid2_name + "', " +
                        "nc_covidvaccine2_location='" + VacCovid2_location + "', ";
                    if (date_Vac_3.Value.ToString() != "")
                    {
                        sql = sql + "nc_covidvaccine3_date=convert('" + date_Vac_3.Value.ToString() + "', date), ";
                    }
                    sql = sql + "nc_covidvaccine3_name='" + VacCovid3_name + "', " +
                        "nc_covidvaccine3_location='" + VacCovid3_location + "', ";
                    if (date_Vac_4.Value.ToString() != "")
                    {
                        sql = sql + "nc_covidvaccine4_date=convert('" + date_Vac_4.Value.ToString() + "', date), ";
                    }
                    sql = sql + "nc_covidvaccine4_name='" + VacCovid4_name + "', " +
                        "nc_covidvaccine4_location='" + VacCovid4_location + "', " +
                        "nc_rh_1='" + RH_1 + "', " +
                        "nc_rh_2='" + RH_2 + "', " +
                        "nc_rh_3='" + RH_3 + "', " +
                        "nc_rh_4='" + RH_4 + "', ";
                    if (RH_travel_date != "")
                    {
                        sql = sql + "nc_rh_travel_date='" + RH_travel_date + "', " +
                                "nc_rh_travel_airline='" + RH_travel_airline + "', " +
                                "nc_rh_travel_flight='" + RH_travel_flight + "', " +
                                "nc_rh_travel_seatnumber='" + RH_travel_seatnumber + "', ";
                    }
                    sql = sql + "nc_rh_5='" + RH_5 + "', " +
                        "nc_rh_6='" + RH_6 + "', " +
                        "nc_rh_7='" + RH_7 + "', " +
                        "nc_rh_8='" + RH_8 + "', " +
                        "nc_rh_9='" + RH_9 + "', " +
                        "nc_rh_10='" + RH_10 + "', " +
                        "nc_rh_11='" + RH_11 + "', " +
                        "nc_rh_12='" + RH_12 + "', " +
                        "nc_rh_13='" + RH_13 + "', " +
                        "nc_rh_other='" + RH_Other + "', " +
                        "nc_history='" + history + "', " +
                        "nc_datetime=CURRENT_TIMESTAMP " +
                        "where nc_id = '" + id + "'; ";
                    if (cl_Sql.Modify(sql))
                    {
                        lbl_docno.Text = id;

                        sql = "select * from novelcorona where nc_id = '" + id + "'; ";
                        dt = new DataTable();
                        dt = cl_Sql.select(sql);
                        if (dt.Rows.Count > 0)
                        {
                            string ncDate = cl_Sql.DateTimeTH(dt.Rows[0]["nc_datetime"].ToString());
                            lbl_dateadd.Text = ncDate;
                        }

                        if (vac == "yes")
                        {
                            if (risk == "yes")
                            {
                                div_3.Visible = false;
                                btn_submit_3.Visible = false;
                                result = "Success";
                            }
                            else
                            {
                                result = "Missing";
                            }
                        }
                        else
                        {
                            result = "MissingVac";
                        }
                    }
                    else
                    {
                        result = "Notsave";
                    }
                }
                else
                {
                    result = "KeyExpire";
                }
            }
            else
            {
                if (vac == "no")
                {
                    result = "MissingVac";
                }
                else
                {
                    result = "Missing";
                }
            }

            return result;
        }

        protected void btn_submit_4_ServerClick(object sender, EventArgs e)
        {
            string scModal = "";

            string linkback = "Default?nc=staff";

            if (txt_step.Value.ToString() == null)
            {
                scModal = "fn_AlertModal('Warning','ทำไม่ถูกขั้นตอนกรุณาเริ่มกรอกใหม่อีกครั้ง !!','" + linkback + "',3000);";
            }
            else
            {
                string result = "";

                // --------------------------------------------------------------------------------------
                if (txt_step.Value.ToString() == "Step1")
                {
                    result = SaveBlock_1("insert");
                    if (result == "Success")
                    {
                        div_1.Visible = true;
                        btn_submit_3.Visible = false;
                        txt_step.Value = "Step2";
                    }
                    else if (result == "Missing")
                    {
                        scModal = "fn_AlertModal('Info','กรุณากรอกข้อมูลทั่วไป ในส่วนที่จำเป็นให้ครบถ้วน !!','',0);";
                    }
                    else if (result == "Notsave")
                    {
                        scModal = "fn_AlertModal('Warning','ไม่สามารถบันทึกข้อมูลทั่วไปได้ กรุณาติดต่อเจ้าหน้าที่ !!','',0);";
                    }
                    else
                    { }
                }
                // --------------------------------------------------------------------------------------
                // --------------------------------------------------------------------------------------
                if (txt_step.Value.ToString() == "Step2")
                {
                    string Keyid = txt_key.Value.ToString();
                    result = SaveBlock_3();
                    if (result == "Success")
                    {
                        div_3.Visible = true;
                        txt_step.Value = "Step3";
                    }
                    else if (result == "Notsave")
                    {
                        scModal = "fn_AlertModal('Warning','ไม่สามารถบันทึกข้อมูลประวัติเสี่ยง ได้กรุณาติดต่อเจ้าหน้าที่ !!','',0);";
                    }
                    else if (result == "Missing")
                    {
                        scModal = "fn_AlertModal('Info','กรุณากรอกข้อมูลประวัติเสี่ยง ในส่วนที่จำเป็นให้ครบถ้วน !!','',0);";
                    }
                    else if (result == "MissingVac")
                    {
                        scModal = "fn_AlertModal('Info','กรุณากรอกข้อมูลในส่วนข้อ 3 และ 4 ที่จำเป็นให้ครบถ้วน !!','',0);";
                    }
                    else if (result == "KeyExpire")
                    {
                        scModal = "fn_AlertModal('Warning','ทำไม่ถูกขั้นตอนกรุณาเริ่มกรอกใหม่อีกครั้ง !!','" + linkback + "',3000);";
                    }
                    else if (result == "Nodata")
                    {
                        scModal = "fn_AlertModal('Info','ไม่พบข้อมูล !!','',0);";
                    }
                    else
                    { }
                }
                // --------------------------------------------------------------------------------------
                // --------------------------------------------------------------------------------------
                if (txt_step.Value.ToString() == "Step3")
                {
                    string keyReport = "";
                    string id = Request.QueryString["nc"].ToString();
                    if (id == "staff")
                    {
                        string[] key = txt_key.Value.Split('_');
                        keyReport = key[0];
                        id = key[1];
                    }

                    string[] KR = SaveBlock_2(id).Split('_');
                    result = KR[1];
                    if (result == "Success")
                    {
                        div_result.Visible = true;
                        btn_submit_4.Visible = false;

                        txt_step.Value = "";

                        string status = "customer";
                        if (Session["status"] != null)
                        {
                            status = Session["status"].ToString();
                        }
                        if (status == "admin" || status == "novelcovid")
                        {
                            scModal = "fn_AlertModal('Success','Success !!','Report.aspx?nc=" + id + "&key=" + keyReport + "',2000);";
                        }
                        else
                        {
                            div_1.Visible = false;
                            div_2.Visible = false;
                            div_3.Visible = false;
                            div_result.Visible = true;
                            scModal = "fn_AlertModal('Success','Success !!','',0);";
                        }
                    }
                    else if (result == "Missing")
                    {
                        scModal = "fn_AlertModal('Info','กรุณากรอกข้อมูลทางคลินิก ในส่วนที่จำเป็นให้ครบถ้วน !!','',0);";
                    }
                    else if (result == "Notsave")
                    {
                        scModal = "fn_AlertModal('Warning','ไม่สามารถบันทึกข้อมูลทางคลินิกได้ กรุณาติดต่อเจ้าหน้าที่ !!','',0);";
                    }
                    else
                    { }
                }
                // --------------------------------------------------------------------------------------
            }

            Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
        }
    }
}