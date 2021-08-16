using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;
using System.Drawing;
using System.IO;
using System.Drawing.Drawing2D;

namespace BRH_Plubic.VaccineCovid
{
    public partial class Register : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        VaccineClass cl_vaccine = new VaccineClass();

        protected void Page_Load(object sender, EventArgs e)
        {
            //StartBooking();
            CheckQuota();

            if (CheckAcknowledge())
            {
                if (!IsPostBack)
                {
                    CalendarDOB();
                    summary();
                }
            }
            else
            {
                Response.Redirect("Default");
            }
        }

        private void StartBooking()
        {
            DateTime DateNow = DateTime.Now;
            if (DateNow <= cl_vaccine.LockPage())
            {
                Response.Redirect("Default");
            }
        }

        private void CheckQuota()
        {
            int[] ar = cl_vaccine.CountDose();
            if (ar[2] <= 0)
            {
                Response.Redirect("FullQuota");
            }
        }

        private Boolean LastQuota(int book)
        {
            Boolean bl = false;

            int[] ar = cl_vaccine.CountDose();
            if (book <= ar[2])
            {
                bl = true;
            }

            return bl;
        }

        private void CalendarDOB()
        {
            DateTime nowDate = DateTime.Now;
            DateTime minDate = nowDate.AddYears(-100);
            DateTime maxDate = nowDate.AddYears(-18);
            date_dob.Attributes.Add("min", minDate.ToString("yyyy-MM-dd"));
            date_dob.Attributes.Add("max", maxDate.ToString("yyyy-MM-dd"));
            date_dob.Value = maxDate.ToString("yyyy-MM-dd");
        }

        private decimal VaccinePrice(string id)
        {
            decimal price = 0;

            sql = "select * from vaccine where vc_id = '" + id + "' ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                price = decimal.Parse(dt.Rows[0]["vc_price"].ToString());
            }

            return price;
        }

        private void summary()
        {
            int qty = 0;
            decimal price = VaccinePrice("2"); // 2 = Vaccine Moderna
            lbl_qty.Text = qty.ToString();
            lbl_price.Text = price.ToString("#,##0.##");
            lbl_net.Text = (qty * price).ToString("#,##0.##");
        }

        public Boolean CheckAcknowledge()
        {
            Boolean bl = false;

            if (Request.QueryString["acknowledge"] != null)
            {
                if (Request.QueryString["acknowledge"].ToString() == "yes")
                {
                    bl = true;
                }
            }

            return bl;
        }

        protected void btn_search_adr_ServerClick(object sender, EventArgs e)
        {
            CheckQuota();

            string zip = txt_adr_zip.Value.ToString().Trim();
            if (zip == "") { zip = "XXXXX"; }
            sql = "select * from locationthai where lo_postcode like '" + zip + "%' ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                div_adr_search.Visible = true;
            }
            else
            {
                Auto_ADR("0");
                div_adr_search.Visible = false;
            }

            LV_ADR.DataSource = dt;
            LV_ADR.DataBind();

            txt_adr_zip.Attributes["onfocus"] = "var value = this.value; this.value = ''; this.value = value; onfocus = null;";

            txt_adr_zip.Focus();
        }

        protected void btn_Auto_ADR_ServerClick(object sender, EventArgs e)
        {
            string id = txt_auto_id.Value.ToString().Trim();
            Auto_ADR(id);
        }

        public void Auto_ADR(string id)
        {
            sql = "select * from locationthai where lo_id = '" + id + "' ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                txt_adr_zip.Value = dt.Rows[0]["lo_postcode"].ToString();
                txt_adr_tambon.Value = dt.Rows[0]["lo_tambon_th"].ToString();
                txt_adr_district.Value = dt.Rows[0]["lo_district_th"].ToString();
                txt_adr_province.Value = dt.Rows[0]["lo_province_th"].ToString();
                div_adr_search.Visible = false;
            }
            else
            {
                txt_adr_zip.Value = "";
                txt_adr_tambon.Value = "";
                txt_adr_district.Value = "";
                txt_adr_province.Value = "";
            }
        }

        protected void btn_checkIDcard_ServerClick(object sender, EventArgs e)
        {
            string vaccineID = "2"; // Moderna
            string duplicate = "no";
            string ListPerson = txtH_ArPerson.Value.ToString();
            string CardID = txt_cardID.Value.ToString().Trim();
            if (CardID != "")
            {
                sql = "select * from book_vaccine where bv_active='yes' and bv_vcid='" + vaccineID + "' and bv_cardid='" + CardID + "' ";
                dt = new DataTable();
                dt = cl_Sql.select(sql);
                if (dt.Rows.Count > 0)
                {
                    duplicate = "yes";
                    lbl_alert_person.Text = "หมายเลขบัตร [" + CardID + "] เคยลงทะเบียนไปแล้ว !!";
                }
                else
                {
                    if (ListPerson.Contains(CardID) == true)
                    {
                        duplicate = "yes";
                        lbl_alert_person.Text = "หมายเลขบัตร [" + CardID + "] ซ้ำกับข้อมูลเดิมที่กรอกไว้ !!";
                    }
                }

                if (duplicate == "yes")
                {
                    lbl_alert_person.ForeColor = System.Drawing.Color.Red;
                    div_alert_person.Attributes.Remove("hidden");
                }
                else
                {
                    lbl_alert_person.Text = "";
                    div_alert_person.Attributes.Add("hidden", "hidden");

                    int QtyBook = 0;
                    QtyBook = int.Parse(lbl_qty.Text);
                    int newQty = int.Parse(txt_qty.Value);
                    if (newQty > 2) { newQty = 2; }
                    if (newQty < 0) { newQty = 1; }
                    QtyBook = QtyBook + newQty;

                    if (!LastQuota(QtyBook))
                    {
                        lbl_alert_person.Text = "ขออภัย ขณะนี้จำนวนคงเหลือไม่ถึง " + QtyBook + "เข็ม แนะนำให้จองเท่าจำนวนที่คงเหลืออยู่ !!";
                        lbl_alert_person.ForeColor = System.Drawing.Color.Red;
                        div_alert_person.Attributes.Remove("hidden");
                    }
                }
            }
            else
            {
                lbl_alert_person.Text = "กรุณากรอก หมายเลขบัตรประชาชน หรือ Passport number !!";
                lbl_alert_person.ForeColor = System.Drawing.Color.Red;
                div_alert_person.Attributes.Remove("hidden");
            }
        }

        private Boolean CheckDuplicate(string cardID)
        {
            Boolean bl = true;

            string sqlDup = "select * from book_vaccine where bv_active='yes' and bv_cardid='" + cardID + "'; ";
            dt = new DataTable();
            dt = cl_Sql.select(sqlDup);
            if (dt.Rows.Count > 0)
            {
                bl = false;

                //DateTime nowtime = DateTime.Now;
                //DateTime booktime = DateTime.Parse(dt.Rows[0]["bv_cdate"].ToString());
                //DateTime endtime = booktime.AddMinutes(15);
            }

            return bl;
        }

        private Boolean OriginalCardID(string cardID)
        {
            Boolean bl = true;

            string sqlOrg = "select * from customer where cm_active='yes' and cm_cardnumber='" + cardID + "' ";
            dt = new DataTable();
            dt = cl_Sql.select(sqlOrg);
            if (dt.Rows.Count > 0)
            {
                bl = false;
            }

            return bl;
        }

        private string CheckKey()
        {
            string key = "";
            string Duplicate = "yes";
            while (Duplicate == "yes")
            {
                key = cl_Sql.GenerateKey(100);
                sql = "select * from book_vaccine where bv_key='" + key + "' ";
                dt = new DataTable();
                dt = cl_Sql.select(sql);
                if (dt.Rows.Count > 0)
                { }
                else
                {
                    Duplicate = "no";
                    break;
                }
            }
            return key;
        }

        protected void btn_resize_ServerClick(object sender, EventArgs e)
        {
            string part = "~/VaccineCovid/image/tmp/";
            string cardID = txt_cardID.Value.ToString().Trim();
            string path = Save_img(part, cardID);
            if (path == "success")
            {
                lbl_script.Text = "<script>fn_showPerson(); location.href='#person_top';</script>";
            }
            else
            {
                Response.Write("<script>alert('ไม่สามารถอัพโหลดภาพถ่ายได้ กรุณาติดต่อผู้ดูแลระบบ !!');</script>");
            }
        }

        public string Save_img(string part, string id)
        {
            string result = "";

            string PFN = uploadSlip.PostedFile.FileName;
            string filename = Path.GetFileName(PFN);
            //string[] File_ar = filename.ToString().Split('.');
            //filename = File_ar[0] + ",id_" + id + "." + "jpg"; //+ File_ar[1];

            filename = id + ".jpg";

            DirectoryInfo myDirInfo;
            myDirInfo = new DirectoryInfo(Server.MapPath(part));
            FileInfo[] myFileInfo = myDirInfo.GetFiles(filename);

            string strFileFullPath = "";

            if (myFileInfo.Length > 0)
            {
                strFileFullPath = Server.MapPath(part) + myFileInfo[0].ToString();

                if (System.IO.File.Exists(strFileFullPath))
                {
                    System.IO.File.Delete(strFileFullPath);
                }
            }
            try
            {
                // Save image --------------------------------------------------
                uploadSlip.PostedFile.SaveAs(System.IO.Path.Combine(Server.MapPath(part), filename));

                result = "success";

                // Resize image ------------------------------------------------
                System.Drawing.Image img = System.Drawing.Image.FromFile(string.Concat(Server.MapPath(part), filename));

                Bitmap b = new Bitmap(img);
                System.Drawing.Image i = cl_Sql.resizeImage(b, new Size(400, 200));
                i.Save(System.IO.Path.Combine(Server.MapPath("~/images/CardID/"), filename));
                img.Dispose();
            }
            catch
            {

            }

            return result;
        }

        protected void btn_submit_ServerClick(object sender, EventArgs e)
        {
            CheckQuota();

            string zip = txt_adr_zip.Value.ToString().Trim(); // ***
            string baanNum = txt_adr_no.Value.ToString().Trim(); // ***
            string moo = txt_adr_moo.Value.ToString().Trim(); 
            string baanName = txt_adr_bann.Value.ToString().Trim();
            string rode = txt_adr_rode.Value.ToString().Trim();
            string subrode = txt_adr_subrode.Value.ToString().Trim();
            string tambon = txt_adr_tambon.Value.ToString().Trim(); // ***
            string district = txt_adr_district.Value.ToString().Trim(); // ***
            string provine = txt_adr_province.Value.ToString().Trim(); // ***
            string country = txt_adr_country.Value.ToString().Trim();

            if (zip == "" || baanNum == "" || tambon == "" || district == "" || provine == "")
            {
                Response.Write("<script> alert('ไม่อนุญาตให้มีการดัดแปลงหรือแต่งเติมข้อมูลระหว่างทาง !'); </script>");
            }
            else
            {
                string vaccineID = "2"; // 2 = VVaccine Moderna
                int Qty = 1;
                Decimal price = VaccinePrice(vaccineID); 
                

                string ADRcolumn = "cm_adr_zip,cm_adr_no,cm_adr_baan,cm_adr_moo,cm_adr_subrode,cm_adr_rode,cm_adr_tambon,cm_adr_district,cm_adr_province,cm_country ";
                string ADRvalue = "'" + zip + "','" + baanNum + "','" + baanName + "','" + moo + "','" + subrode + "','" + rode + "','" + tambon + "','" + district + "','" + provine + "','" + country + "' ";

                string key = CheckKey(); // Key 

                string ListPerson = txtH_ArPerson.Value.ToString();
                if (ListPerson == "")
                {
                    Response.Write("<script> alert('ไม่อนุญาตให้มีการดัดแปลงหรือแต่งเติมข้อมูลระหว่างทาง !'); </script>");
                }
                else
                {
                    string next = "yes";
                    string getnewsfrom = txt_getnewsfrom.Value.ToString().Trim();

                    sql = "";
                    string[] ArPerson = ListPerson.Split('|');
                    for (int i = 0; i < ArPerson.Length; i++)
                    {
                        string[] ArColumn = ArPerson[i].Split('+');

                        string cardID = ArColumn[0];
                        if (CheckDuplicate(cardID))
                        {
                            string DOB = ArColumn[1];
                            string pname = ArColumn[2];
                            string fname = ArColumn[3];
                            string lname = ArColumn[4];
                            string havebeen = ArColumn[5];
                            string career = ArColumn[6];
                            string work = ArColumn[7];
                            string phone = ArColumn[8];
                            Qty = int.Parse(ArColumn[9]); 
                            if (Qty > 2) { Qty = 2; }
                            if (Qty < 0) { Qty = 1; }

                            if (DOB == "" || pname == "" || fname == "" || lname == "" || phone == "")
                            {
                                next = "no";
                                Response.Write("<script> alert('ไม่อนุญาตให้มีการดัดแปลงหรือแต่งเติมข้อมูลระหว่างทาง !'); </script>");
                                break;
                            } 
                            else
                            {
                                if (OriginalCardID(cardID))
                                {
                                    if (sql != "") { sql = sql + "\n"; }
                                    sql = sql + "insert into customer(cm_cardnumber,cm_phone,cm_pname,cm_fname,cm_lname,cm_dob,cm_career,cm_workplace,cm_havebeento," + ADRcolumn + ") values ";
                                    sql = sql + "\n('" + cardID + "','" + phone + "','" + pname + "','" + fname + "','" + lname + "','" + DOB + "','" + career + "','" + work + "','" + havebeen + "'," + ADRvalue + "); ";
                                }

                                Decimal net = price * Qty;

                                sql = sql + "\ninsert into book_vaccine(bv_cardid,bv_vcid,bv_qty,bv_price,bv_net,bv_getnews,bv_key) values ";
                                sql = sql + "\n('" + cardID + "'," + vaccineID + "," + Qty + "," + price + "," + net + ",'" + getnewsfrom + "','" + key + "'); ";
                            }
                        }
                    }

                    if (next == "yes")
                    {
                        lbl_script.Text = "";

                        if (Qty <= cl_vaccine.CountDose()[2])
                        {
                            if (cl_Sql.Modify(sql))
                            {
                                //Response.Redirect("Payment?key=" + key);
                                string alert = "alertModal('#Modal_Success'); ";
                                string reload = "setTimeout(function(){window.location.href='Payment?key=" + key + "';},1500); ";
                                lbl_script.Text = "<script> " + alert + reload + " </script>";
                            }
                            else
                            {

                            }
                        }
                        else
                        {
                            lbl_alert_person.Text = "ขออภัย จำนวนคงเหลือไม่พอสำหรับการจองนี้ แนะนำให้จองเท่าจำนวนที่คงเหลืออยู่ !!";
                            lbl_alert_person.ForeColor = System.Drawing.Color.Red;
                            div_alert_person.Attributes.Remove("hidden");
                            lbl_script.Text = "<script> fn_showPerson(); location.href='#person_top'; alert('ขออภัย จำนวนคงเหลือไม่พอสำหรับการจองนี้ แนะนำให้จองเท่าจำนวนที่คงเหลืออยู่ !!'); </script>";
                        }
                    }
                }
            }
        }
    }
}