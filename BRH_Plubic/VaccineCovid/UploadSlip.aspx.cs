using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;
using System.IO;

namespace BRH_Plubic.VaccineCovid
{
    public partial class UploadSlip : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass CL_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            //Response.Redirect("Default");

            if (Request.QueryString["key"] != null)
            {
                Thank(Request.QueryString["key"].ToString());
            }
        }

        protected void Thank(string key)
        {
            string alert = "";
            div_alert.Visible = true;
            alertMsg.Attributes.Remove("class");

            sql = "select * from paidslip_moderna where pm_key='" + key + "' ";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                alert = "Success. ยืนยันการโอนเงิน ทางเราได้รับสลิปเรียบร้อยแล้ว <br /><img src='image/slip/" + key + ".jpg' style='width:50%;'>";
                alertMsg.Attributes.Add("class", "alert alert-success");
            }
            else
            {
                div_alert.Visible = false;
                alertMsg.Attributes.Add("class", "alert alert-danger");
                Response.Redirect("UploadSlip");
            }

            lbl_alert.Text = alert;
        }

        protected void btn_check_ServerClick(object sender, EventArgs e)
        {
            string cardID = txt_cardID.Value.ToString().Trim();
            string phone = txt_phonenumber.Value.ToString().Trim();
            FindData(cardID, phone);
        }

        private Boolean FindData(string cardID, string phone)
        {
            Boolean bl = false;

            div_alert.Visible = true;
            lbl_script.Text = "";
            string alert = "";
            alertMsg.Attributes.Remove("class");
            alertMsg.Attributes.Add("class", "alert alert-danger");

            if (cardID.Length > 13)
            {
                alert = "Incorrect Passport number หรือ หมายเลขบัตรประชาชนไม่ถูกต้อง";
            }
            else
            {
                sql = "select cm_phone from confirmslip_moderna where cm_active='yes' and cm_cardid = '" + cardID + "' " +
                    "\norder by cm_payid ";
                dt = new DataTable();
                dt = CL_Sql.select(sql);
                if (dt.Rows.Count > 0)
                {
                    phone = dt.Rows[0]["cm_phone"].ToString();
                    sql = "select * from confirmslip_moderna where cm_active='yes' and cm_phone = '" + phone + "' " +
                    "\norder by cm_payid ";
                    dt = new DataTable();
                    dt = CL_Sql.select(sql);
                    ShowData(dt);
                    bl = true;
                }
                else
                {
                    if (phone.Length < 9 || phone.Length > 10)
                    {
                        alert = "Incorrect Phone number เบอร์โทรศัพท์";
                    }
                    else
                    {
                        sql = "select * from confirmslip_moderna where cm_active='yes' and cm_phone like '%" + phone + "' " +
                        "\norder by cm_payid ";
                        dt = new DataTable();
                        dt = CL_Sql.select(sql);
                        if (dt.Rows.Count > 0)
                        {
                            ShowData(dt);
                            bl = true;
                        }
                        else
                        {
                            alert = "Find not found. ไม่พบข้อมูล";
                        }
                    }
                }
            }

            if (alert != "")
            {
                lbl_script.Text = "<script> fn_fadeDataOut(); </script>";
            }
            lbl_alert.Text = alert;

            LV_bookdetails.DataSource = dt;
            LV_bookdetails.DataBind();

            return bl;
        }

        protected void ShowData(DataTable dt)
        {
            div_alert.Visible = false;

            if (dt.Rows[0]["cm_key"].ToString() != "")
            {
                Response.Redirect("UploadSlip?key=" + dt.Rows[0]["cm_key"].ToString());
            }

            lbl_name.Text = dt.Rows[0]["cm_name"].ToString();

            string numID = "";
            string OldCardID = dt.Rows[0]["cm_cardid"].ToString();
            int qtytotal = 0;
            int qtywant = int.Parse(dt.Rows[0]["cm_qty"].ToString());
            decimal pricetotal = 0;
            foreach (DataRow dr in dt.Rows)
            {
                if (numID != "") { numID = numID + ","; }
                numID = numID + dr["cm_id"].ToString();
                qtytotal = qtytotal + int.Parse(dr["cm_qty"].ToString());
                if (OldCardID != dr["cm_cardid"].ToString())
                {
                    qtywant = qtywant + int.Parse(dr["cm_qty"].ToString());
                }
                pricetotal = pricetotal + decimal.Parse(dr["cm_total"].ToString());
            }

            txtH_num.Value = numID;
            int countIDcard = numID.Split(',').Length;
            int maxQty = countIDcard * 2;
            if (maxQty <= qtywant)
            {
                qtywant = maxQty;
            }
            book_qtytotal.Text = qtytotal.ToString();
            lbl_price.Text = dt.Rows[0]["cm_price"].ToString();
            lbl_pricetotal.Text = pricetotal.ToString();
            txt_want.Value = qtywant.ToString();
            txtH_wantMax.Value = qtywant.ToString();
            txt_want.Attributes.Add("min", "0");
            txt_want.Attributes.Add("max", qtywant.ToString());
            if (dt.Rows[0]["cm_status"].ToString() == "pay")
            {
                txt_want.Attributes.Add("disabled", "disabled");
            }
            else
            {
                txt_want.Attributes.Remove("disabled");
            }

            txt_date.Value = DateTime.Now.ToString("yyyy-MM-dd");
            txt_time.Value = DateTime.Now.ToString("HH:mm:00");

            lbl_script.Text = "<script> fn_fadeDataIn(); </script>";
        }

        public string Save_img(string key)
        {
            string result = "";

            string filename = Path.GetFileName(uploadSlip.PostedFile.FileName);
            //string[] File_ar = filename.ToString().Split('.');
            //filename = File_ar[0] + ",id_" + id + "." + "jpg"; //+ File_ar[1];

            filename = key + ".jpg";

            string part = "~/VaccineCovid/image/slip/";


            DirectoryInfo myDirInfo;
            myDirInfo = new DirectoryInfo(Server.MapPath("image/slip/"));
            FileInfo[] myFileInfo = myDirInfo.GetFiles(filename);

            if (myFileInfo.Length > 0)
            {
                string strFileFullPath = Server.MapPath("image/slip/") + myFileInfo[0].ToString();

                if (System.IO.File.Exists(strFileFullPath))
                {
                    System.IO.File.Delete(strFileFullPath);
                }
            }
            try
            {
                uploadSlip.PostedFile.SaveAs(System.IO.Path.Combine(Server.MapPath(part), filename));

                FileInfo[] uploadFileInfo = myDirInfo.GetFiles(filename);
                long FileUploadLEN = uploadFileInfo[0].Length;
                if (FileUploadLEN > 0)
                {
                    result = "success";
                }
                else
                {
                    result = "file 0";
                }
            }
            catch
            {

            }

            return result;
        }

        protected void btn_submit_ServerClick(object sender, EventArgs e)
        {
            string alert = "";
            div_alert.Visible = true;

            string key = CL_Sql.GenerateKey(99);

            string date = txt_date.Value.ToString();
            string time = txt_time.Value.ToString();

            if (date == "")
            {
                alert = "Please input Slip date. กรุณากรอกวันที่โอนเงินในสลิป";
            }
            else
            {
                if (time == "")
                {
                    alert = "Please input Slip time. กรุณากรอกเวลาโอนเงินในสลิป";
                }
                else
                {
                    if (uploadSlip.PostedFile.FileName != "")
                    {
                        string fileExtention = uploadSlip.PostedFile.ContentType;
                        if (fileExtention == "image/jpeg" || fileExtention == "image/png" || fileExtention == "image/x-png")
                        {
                            if (uploadSlip.PostedFile.ContentLength > 0)
                            {
                                if (uploadSlip.PostedFile.ContentLength < 1024000)
                                {
                                    int bookQTY = int.Parse(book_qtytotal.Text);
                                    string newQTY = txt_want.Value.ToString().Trim();
                                    if (newQTY == "") { newQTY = "0"; }
                                    int wantQTY = int.Parse(newQTY);
                                    decimal price = decimal.Parse(lbl_price.Text);
                                    decimal total = wantQTY * price;
                                    decimal pay = total;
                                    string numID = txtH_num.Value.ToString().Trim();

                                    if (wantQTY < 0 || wantQTY > bookQTY)
                                    {
                                        alert = "ไม่สามารถกรอกจำนวนที่ต้องการ น้อยกว่าศูนย์หรือมากกว่าจำนวนที่จองไว้ทั้งหมดได้ !!";
                                    }
                                    else
                                    {
                                        string SlipDateTime = DateTime.Parse(date).ToString("yyyy-MM-dd") + " " + DateTime.Parse(time).ToString("HH:mm:00");

                                        sql = "update confirmslip_moderna set cm_key='" + key + "', cm_status='paid' where cm_id in (" + numID + "); " +
                                            "\ninsert into paidslip_moderna(pm_key,pm_book_qty,pm_want_qty,pm_price,pm_total,pm_pay,pm_slipdatetime) " +
                                            "\nvalue('" + key + "'," + bookQTY.ToString() + "," + wantQTY.ToString() + "," + price.ToString() + "," + total.ToString() + "," + pay.ToString() + ",'" + SlipDateTime + "'); ";
                                        if (CL_Sql.Modify(sql))
                                        {
                                            string saveSlip = Save_img(key);
                                            if (saveSlip == "success")
                                            {
                                                alertMsg.Attributes.Remove("class");

                                                alert = "ขอขอบพระคุณอย่างสูง ที่ท่านประสงค์เข้ารับการฉีดวัคซีน Moderna กับทางโรงพยาบาลกรุงเทพระยอง";
                                                alertMsg.Attributes.Add("class", "alert alert-success");

                                                lbl_script.Text = "<script> fn_fadeDataOut(); </script>";
                                            }
                                            else
                                            {
                                                if (saveSlip == "file 0")
                                                {
                                                    sql = "update confirmslip_moderna set cm_key = '', cm_status='booking' where cm_id in (" + numID + "); " +
                                                        "update paidslip_moderna set pm_active='no' where pm_key='" + key + "'; ";
                                                    CL_Sql.Modify(sql);

                                                    alert = "ไฟล์มีปัญหา กรุณาเลือกไฟล์แนบใหม่อีกครั้ง หรือติดต่อผู้ดูแลระบบ Email: brhinformatics@gmail.com !!";
                                                }
                                                else
                                                {
                                                    alert = "ไม่สามารถแนบสลิปได้ กรุณาติดต่อผู้ดูแลระบบ Email: brhinformatics@gmail.com !!";
                                                }
                                            }
                                        }
                                        else
                                        {
                                            alert = "ไม่สามารถบันทึกข้อมูลได้ กรุณาติดต่อผู้ดูแลระบบ Email: brhinformatics@gmail.com !!";
                                        }
                                    }
                                }
                                else
                                {
                                    alert = "ไฟล์แนบมีขนาดใหญ่เกินไป !!";
                                }
                            }
                            else
                            {
                                alert = "ไฟล์แนบนี้ใช้งานไม่ได้ กรุณาเลือกไฟล์แนบใหม่ !!";
                            }
                        }
                        else
                        {
                            alert = "แนบได้เฉพาะไฟล์นามสกุล .JPG หรือ .PNG เท่านั้น !!";
                        }
                    }
                }
            }

            lbl_alert.Text = alert;

        }
    }
}