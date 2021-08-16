using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;
using Org.BouncyCastle.Ocsp;

using System.IO;

namespace BRH_Plubic.VaccineCovid
{
    public partial class Payment : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        VaccineClass cl_vaccine = new VaccineClass();

        protected void Page_Load(object sender, EventArgs e)
        {
            //StartBooking(); 

            if (!IsPostBack)
            {
                if (Request.QueryString["key"] != null)
                {
                    string scModal = "";

                    string key = Request.QueryString["key"].ToString();
                    if (TimeEnd(key) == "book")
                    {
                        Summary(key);
                    }
                    else if (TimeEnd(key) == "pay")
                    {
                        Summary(key);
                        lbl_docno.Text = DocNo(key);
                        lbl_script.Text = "<script> alertModal('#ModalSubmit'); </script>";
                    }
                    else
                    {
                        if (Disqualify(key))
                        {
                            scModal = "fn_AlertModal('Warning','ระบบตัดสิทธิ์อัตโนมัติ เนื่องจากโอนจ่ายชำระช้าเกิน 1 ชั่วโมง !!','Default', 3000);";
                        }
                        else
                        {
                            Summary(key);
                            lbl_script.Text = "<script> alertModal('#ModalSubmit'); </script>";
                        }
                    }

                    Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
                }
                else
                {
                    Response.Redirect("Default");
                }
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

        private string TimeEnd(string key)
        {
            string result = "";

            string endTime = (10000).ToString(); // 1hour for SQL

            sql = "select *,convert(addtime(bv_cdate, '" + endTime + "'), time) as 'end_time' from book_vaccine as bv " +
                "\nleft join customer as cm on cm.cm_cardnumber = bv.bv_cardid " +
                "\nwhere bv_active = 'yes' and bv_status in ('book','pay') " +
                "\nand addtime(bv_cdate, '" + endTime + "') >= current_timestamp " +
                "\nand bv_key = '" + key + "' " +
                "\norder by bv_id ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                string end_time = dt.Rows[0]["end_time"].ToString();
                lbl_endtime.Text = end_time;

                result = dt.Rows[0]["bv_status"].ToString();
            }

            LV_details.DataSource = dt;
            LV_details.DataBind();

            LV_alert.DataSource = dt;
            LV_alert.DataBind();

            return result;
        }

        private string DocNo(string key)
        {
            string result = "";

            sql = "select * from pay_vaccine where pv_bvkey='" + key + "'; ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                result = dt.Rows[0]["pv_id"].ToString();
            }

            return result;
        }

        private Boolean Disqualify(string key)
        {
            Boolean bl = false;

            sql = "select * from book_vaccine where bv_status='book' and bv_key='" + key + "' ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                sql = "update book_vaccine set bv_active='no', bv_muser='auto', bv_mdate=current_timestamp where bv_key='" + key + "' ";
                if (cl_Sql.Modify(sql))
                {
                    bl = true;
                }
            }

            return bl;
        }

        private void Summary(string key)
        {
            sql = "select sum(bv_net) as 'bv_net',sum(bv_qty) as 'bv_qty' from book_vaccine where bv_active='yes' and bv_key='" + key + "' ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                string net = dt.Rows[0]["bv_net"].ToString() + ".00";  //decimal.Parse(dt.Rows[0]["bv_net"].ToString()).ToString("#,##0.##");
                string qty = dt.Rows[0]["bv_qty"].ToString();
                lbl_net.Text = net;
                if (txt_money.Value == "")
                {
                    txt_money.Value = net;
                    lbl_net_alert.Text = net;
                    lbl_dose_alert.Text = qty;
                }
                string timeNow = DateTime.Now.ToString("HH:mm") + ":00";
                if (txt_time.Value == "")
                {
                    txt_time.Value = timeNow;
                }
            }
        }

        public string Save_img(string id)
        {
            string result = "";

            string filename = Path.GetFileName(uploadSlip.PostedFile.FileName);
            //string[] File_ar = filename.ToString().Split('.');
            //filename = File_ar[0] + ",id_" + id + "." + "jpg"; //+ File_ar[1];

            filename = id + ".jpg";

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
                result = "success";
            }
            catch
            {

            }

            return result;
        }

        private string CheckData(string key)
        {
            string result = "";

            string style = "border: none; border-bottom: 2px solid red;";

            string pay = txt_money.Value.ToString().Trim();
            string time = txt_time.Value.ToString().Trim();
            string phone = txt_phone.Value.ToString().Trim();

            txt_money.Attributes.Remove("style");
            txt_time.Attributes.Remove("style");
            txt_phone.Attributes.Remove("style");

            div_upload.Attributes.Add("style", style);
            if (uploadSlip.PostedFile.FileName != "")
            {
                string fileExtention = uploadSlip.PostedFile.ContentType;
                if (fileExtention == "image/jpeg" || fileExtention == "image/png" || fileExtention == "image/x-png")
                {
                    if (uploadSlip.PostedFile.ContentLength < 1024000)
                    {
                        if (Save_img(key) == "success")
                        {
                            result = "next";
                        }
                        else
                        {
                            result = "ไม่สามารถแนบสลิปได้ กรุณาติดต่อผู้ดูแลระบบ !!";
                        }
                    }
                    else
                    {
                        result = "ไฟล์มีขนาดใหญ่เกินไป !!";
                    }
                }
                else
                {
                    result = "แนบได้เฉพาะไฟล์นามสกุล .JPG หรือ .PNG เท่านั้น !!";
                }
            }
            else
            {
                if (txtH_slip_pt.Value == "")
                {
                    result = "กรุณาแนบสลิปการโอนเงิน !!";
                }
                else
                {
                    result = "next";
                }
            }

            if (result == "next")
            {
                div_upload.Attributes.Remove("style");
                previewSlip.ImageUrl = txtH_slip_pv.Value;

                if (pay == "" || time == "" || phone == "" || phone.Length < 9)
                {
                    if (pay == "")
                    {
                        txt_money.Attributes.Add("style", style);
                    }
                    if (time == "")
                    {
                        txt_time.Attributes.Add("style", style);
                    }
                    if (phone == "" || phone.Length < 9)
                    {
                        txt_phone.Attributes.Add("style", style);
                    }
                    result = "กรุณากรอกข้อมูลให้ครบถ้วน !!";
                }
                else
                {
                    result = "success";
                }
            }

            return result;
        }

        protected void btn_submit_ServerClick(object sender, EventArgs e)
        {
            string scModal = "";
            string key = Request.QueryString["key"].ToString();

            string ResultCheck = CheckData(key);
            if (ResultCheck == "success")
            {
                if (TimeEnd(key) == "book")
                {
                    sql = "select * from pay_vaccine where pv_active='yes' and pv_bvkey='" + key + "' ";
                    dt = new DataTable();
                    dt = cl_Sql.select(sql);
                    if (dt.Rows.Count > 0)
                    {
                        scModal = "alertModal('#ModalSubmit'); ";
                    }
                    else
                    {
                        string bank = txt_bank.Value.ToString();
                        string account = "";
                        if (bank == "kma")
                        {
                            bank = "ธนาคารกรุงศรีอยุธยา";
                            account = "123-456789-0";
                        }
                        if (bank == "bkk")
                        {
                            bank = "ธนาคารกรุงเทพ";
                            account = "277-3-07232-3";
                        }
                        else
                        {
                            bank = "ธนาคารกสิกรไทย";
                            account = "140-2-83629-2";
                        }
                        string pay = txt_money.Value.ToString().Trim();

                        string time = DateTime.Now.ToString("yyyy-MM-dd") + " " + DateTime.Parse(txt_time.Value.ToString()).ToString("HH:mm") + ":00";
                        string phone = txt_phone.Value.ToString().Trim();

                        sql = "insert into pay_vaccine(pv_bank,pv_account,pv_slip_pay,pv_slip_time,pv_phone,pv_bvkey) value" +
                            "\n('" + bank + "','" + account + "'," + decimal.Parse(pay) + ",'" + time + "','" + phone + "','" + key + "'); ";
                        if (cl_Sql.Modify(sql))
                        {
                            sql = "update book_vaccine set bv_status='pay' where bv_key='" + key + "' ";
                            if (cl_Sql.Modify(sql))
                            {
                                scModal = "alertModal('#ModalSubmit'); ";
                            }
                            else
                            {
                                scModal = "alert('ไม่สามารถอัพเดทข้อมูลได้ กรุณาติดต่อผู้ดูแลระบบ !!');";
                            }
                        }
                        else
                        {
                            scModal = "alert('ไม่สามารถบันทึกได้ กรุณาติดต่อผู้ดูแลระบบ !!');";
                        }
                    }
                }
                else
                {
                    Response.Redirect("Payment?key=" + key);
                }

                scModal = "<script> " + scModal + " </script>";
                lbl_script.Text = scModal;
            }
            else
            {
                scModal = "fn_AlertModal('Warning','" + ResultCheck + "','',0);";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
            }
        }
    }
}