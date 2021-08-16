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
    public partial class BookVaccinate : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                NamePrefix();
            }
        }

        public Boolean NamePrefix()
        {
            Boolean bl = false;

            sql = "select * from nameprefix where np_active = 'Yes' ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                DD_pname.DataSource = dt;
                DD_pname.DataTextField = "np_full";
                DD_pname.DataValueField = "np_initial";
                DD_pname.DataBind();
            }

            return bl;
        }

        protected void CLD_book_DayRender(object sender, DayRenderEventArgs e)
        {
            DateTime DateStart = DateTime.Parse("2020-05-11");
            if (DD_Location.SelectedValue == "รพ.ศรีระยอง") { DateStart = DateTime.Parse("2020-05-20"); }
            DateTime DateEnd = DateTime.Parse("2020-07-15");

            DateTime DateNow = DateTime.Parse(DateTime.Now.ToString("yyyy-MM-dd"));
            if (DateNow > DateStart)
            {
                DateStart = DateNow;
            }

            if (e.Day.Date < DateStart || e.Day.Date > DateEnd)
            {
                e.Day.IsSelectable = false;
                e.Cell.ForeColor = System.Drawing.Color.LightGray;
                e.Cell.BackColor = System.Drawing.Color.WhiteSmoke;
            }
            else
            {
                if (e.Day.IsSelected)
                {
                    txtH_bookdate.Value = e.Day.Date.ToString("yyyy-MM-dd");
                }
                else
                {
                    e.Cell.BackColor = System.Drawing.Color.LightGray;
                }
            }

            string Progress1 = "<br /><span class='progress bg-secondary'> <span class='progress-bar bg-";
            string PColor = "";
            string Progress2 = "' role='progressbar' style='width: ";
            int Width = 0;
            string Progress3 = "%' aria-valuenow='";
            int Left = 0;
            string Progress4 = "' aria-valuemin='0' aria-valuemax='";
            int Max = 60; // <------------------------------------------------ MAX
            string Progress5 = "'>";
            string Progress6 = "</span></span>";

            string Progress = "";

            string Dates = e.Day.Date.ToString();

            string location = DD_Location.SelectedValue.ToString();

            sql = "select convert(vb_bookdate,date) as 'vb_bookdate', vb_location, count(1) as 'vb_cnt' " +
                "from vaccinate_book where vb_location = '" + location + "' " +
                "group by convert(vb_bookdate, date), vb_location " +
                "order by convert(vb_bookdate, date), vb_location";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    string BookDate = dt.Rows[i]["vb_bookdate"].ToString();
                    int Qty = int.Parse(dt.Rows[i]["vb_cnt"].ToString());

                    if (Dates == BookDate)
                    {
                        if (Qty == Max) 
                        { 
                            e.Day.IsSelectable = false;
                            //e.Cell.ForeColor = System.Drawing.Color.WhiteSmoke;
                        }

                        Left = Max - Qty;
                        Width = (Max - Left) * 100 / Max;

                        if (Width < 15) { Width = 15; }
                        if (Width < 50) { PColor = "success"; } else if (Width < 80) { PColor = "warning"; } else { PColor = "danger"; }

                        Progress = Progress1 + PColor + Progress2 + Width.ToString() + Progress3 + Left + Progress4 + Max + Progress5 + Qty + Progress6;
                        e.Cell.Controls.Add(new LiteralControl(Progress));
                    }
                }
            }
        }

        protected void DD_goto_SelectedIndexChanged(object sender, EventArgs e)
        {
            string howgoto = "";
            howgoto = DD_goto.SelectedValue;
            if (howgoto == "Drive thru")
            {
                txt_brand.Visible = true;
                txt_vehicle.Visible = true;
            }
            else
            {
                txt_brand.Visible = false;
                txt_vehicle.Visible = false;
            }
        }

        protected void DD_AllergicVaccines_SelectedIndexChanged(object sender, EventArgs e)
        {
            string algVac = DD_AllergicVaccines.SelectedValue;
            if (algVac == "Yes")
            {
                txt_AllergicVaccines.Visible = true;
            }
            else
            {
                txt_AllergicVaccines.Visible = false;
            }
        }

        protected void CLD_book_SelectionChanged(object sender, EventArgs e)
        {

        }

        protected void btn_Submit_ServerClick(object sender, EventArgs e)
        {
            if (CheckInput())
            {
                if (Insert())
                {
                    Response.Redirect("BookVaccinateResult.aspx#Result");
                    //Response.Write("<script>alert('บันทึกข้อมูลเรียบร้อยแล้ว !!'); window.location.href='BookVaccinate.aspx';</script>");
                }
                else
                {
                    Response.Write("<script>alert('ระบบขัดข้องไม่สามารถบันทึกข้อมูลได้ กรุณาติดต่อผู้ดูแลระบบ !!');</script>");
                }
            }
        }

        public Boolean CheckInput()
        {
            Boolean bl = false;

            string next = "";

            if (txt_fname.Value == "" || txt_lname.Value == "" || txt_cardnum.Value == "" || tel_phone.Value == "")
            {
                name_title.Attributes.Add("class", "card-title bg-danger");
            }
            else
            {
                name_title.Attributes.Add("class", "card-title");
                if (txt_empid.Value == "")
                {
                    emp_tilte.Attributes.Add("class", "card-title bg-danger");
                }
                else
                {
                    emp_tilte.Attributes.Add("class", "card-titler");
                    if (date_dob.Value == "")
                    {
                        dob_title.Attributes.Add("class", "card-title bg-danger");
                    }
                    else
                    {
                        dob_title.Attributes.Add("class", "card-titler");
                        if (txtH_bookdate.Value == "" || txt_time.Value == "")
                        {
                            cld_title.Attributes.Add("class", "card-title bg-danger");
                        }
                        else
                        {
                            cld_title.Attributes.Add("class", "card-titler");
                            if (DD_goto.SelectedValue == "Drive thru")
                            {
                                if (txt_brand.Value == "" || txt_vehicle.Value == "")
                                {
                                    goto_tilte.Attributes.Add("class", "card-title bg-danger");
                                }
                                else
                                {
                                    next = "Yes";
                                }
                            }
                            else
                            {
                                txt_brand.Value = "";
                                txt_vehicle.Value = "";
                                next = "Yes";
                            }
                            if (next == "Yes")
                            {
                                goto_tilte.Attributes.Add("class", "card-titler");

                                bl = true;
                            }
                        }
                    }
                }
            }

            return bl;
        }

        public Boolean Insert()
        {
            Boolean bl = false;

            string company = "2";
            string pname = DD_pname.SelectedValue.ToString();
            string fname = txt_fname.Value.ToString().Trim();
            string lname = txt_lname.Value.ToString().Trim();
            string phone = tel_phone.Value.ToString().Trim();
            string gender = "";
            if (CB_Men.Checked) { gender = CB_Men.Value; } else { gender = CB_Women.Value; }
            string HaveBeen = "";
            if (CB_service_Y.Checked) { HaveBeen = CB_service_Y.Value; } else { HaveBeen = CB_service_N.Value; }
            string location = DD_Location.SelectedValue.ToString();
            string Status = txtH_status.Value;
            string empid = txt_empid.Value.ToString().Trim();
            string[] dateDOB = date_dob.Value.Split(' ');
            string DOB = DateTime.Parse(dateDOB[0]).ToString("yyyy-MM-dd");

            int age = DateTime.Now.Year - DateTime.Parse(DOB).Year;
            if ((DateTime.Parse(DOB).Month - DateTime.Now.Month) > 0) { age = age - 1; }

            string payer = DD_payer.SelectedValue.ToString();
            string ComeBy = DD_goto.SelectedValue.ToString();
            string carBrand = "";
            string carNumber = "";
            if (ComeBy == "Drive thru")
            {
                carBrand = txt_brand.Value.ToString().Trim();
                carNumber = txt_vehicle.Value.ToString().Trim();
            }
            string cong = txt_CongenitalDisease.Value.ToString().Trim();
            string drug = txt_DrugAllergy.Value.ToString().Trim();
            string eggs = DD_AllergicEggs.SelectedValue.ToString();
            string vaccine = DD_AllergicVaccines.SelectedValue.ToString().Trim();
            string vaccines = "";
            if (vaccine == "Yes")
            {
                vaccines = txt_AllergicVaccines.Value.ToString().Trim();
            }
            string fever = DD_Fever.SelectedValue.ToString();
            string pregnant = DD_Pregnant.SelectedValue.ToString();
            string gillenbarre = DD_GillenBarre.SelectedValue.ToString();
            string BookDate = CLD_book.SelectedDate.ToString("yyyy-MM-dd");
            string BookTime = txt_time.Value.ToString();
            string BookDateTime = BookDate + " " + BookTime;

            sql = "SELECT * FROM vaccinate_book where vb_fname = '" + fname + "' and vb_lname = '" + lname + "' " +
                "and LEFT(CONVERT(vb_adddate, Datetime),16) = LEFT(CURRENT_TIMESTAMP, 16) ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                bl = true;
            }
            else
            {
                sql = "INSERT INTO vaccinate_book " +
                    "(vb_adddate, vb_company, vb_status, vb_empid, vb_dob, vb_age, vb_payer, vb_bookdate, vb_pname, vb_fname, vb_lname, vb_phone, vb_gender, " +
                    "vb_havebeen, vb_location, vb_comeby, vb_carbrand, vb_carnumber, vb_congenitaldisease, vb_drugallergy, vb_allergiceggs, vb_allergicvaccines, " +
                    "vb_allergicvaccinesdesc, vb_fever, vb_pregnant, vb_gillenbarre, vb_confirm) " +
                    "VALUES(" +
                    "current_timestamp(), " +
                    "'" + company + "', " +
                    "'" + Status + "', " +
                    "'" + empid + "', " +
                    "'" + DOB + "', " +
                    "'" + age + "', " +
                    "'" + payer + "', " +
                    "'" + BookDateTime + "', " +
                    "'" + pname + "', " +
                    "'" + fname + "', " +
                    "'" + lname + "', " +
                    "'" + phone + "', " +
                    "'" + gender + "', " +
                    "'" + HaveBeen + "', " +
                    "'" + location + "', " +
                    "'" + ComeBy + "', " +
                    "'" + carBrand + "', " +
                    "'" + carNumber + "', " +
                    "'" + cong + "', " +
                    "'" + drug + "', " +
                    "'" + eggs + "', " +
                    "'" + vaccine + "', " +
                    "'" + vaccines + "', " +
                    "'" + fever + "', " +
                    "'" + pregnant + "', " +
                    "'" + gillenbarre + "', " +
                    "'confirm'); ";

                if (cl_Sql.Modify(sql))
                {
                    Session["BookVaccinate"] = "Yes";
                    Session["name"] = pname + " " + fname + " " + lname;
                    Session["location"] = location;
                    Session["comeby"] = ComeBy;
                    Session["bookdate"] = DateTime.Parse(BookDate).ToString("dd/MM/yyyy") + "... เวลา ..." + txt_time.Value;
                    Session["payer"] = payer;
                    bl = true;
                }
            }

            return bl;
        }

        protected void DD_Location_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DD_Location.SelectedValue == "รพ.ศรีระยอง")
            {
                txtH_bookdate.Value = "";
            }
        }
    }
}