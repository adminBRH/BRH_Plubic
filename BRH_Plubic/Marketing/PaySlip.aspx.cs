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
namespace BRH_Plubic.Marketing
{
    public partial class PaySlip : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass CL_Sql = new SQLclass();
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["id"] == null || Session["PaySlip"] == null)
            {
                div_docno.Visible = false;
                div_checknumber.Visible = true;
                div_PaySlip.Visible = false;
                div_account.Visible = false;
            }
            else
            {
                div_docno.Visible = true;
                div_checknumber.Visible = false;
                div_PaySlip.Visible = true;
                div_account.Visible = true;

                Data(Request.QueryString["id"].ToString(), txt_phone.Value.ToString().Trim());


                txt_hour.Value = DateTime.Now.Hour.ToString();
                txt_minute.Value = DateTime.Now.Minute.ToString();
            }
        }

        public string Data(string number, string phone)
        {
            string bl = "";

            sql = "select concat(hd_fname,' ',hd_lname) as 'name',hd_total,hd_discount,hd_totalqty,hd_shippingcost,hd_paystatus,hd_pnumber,hd_receive " +
                "from marketingheader where hd_id = '" + number + "' and hd_pnumber like '%" + phone + "%' ";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                lbl_docno.Text = "เลขที่การสั่งซื้อของคุณคือ : " + number;
                lbl_phone.Text = "หมายเลขโทรศัพท์ของคุณคือ : " + dt.Rows[0]["hd_pnumber"].ToString();
                lbl_name.Text = "ชื่อ : " + dt.Rows[0]["name"].ToString();
                string total = dt.Rows[0]["hd_total"].ToString();
                string discount = dt.Rows[0]["hd_discount"].ToString();
                string qty = dt.Rows[0]["hd_totalqty"].ToString();
                string costSP = dt.Rows[0]["hd_shippingcost"].ToString();
                string nettotal = ( (decimal.Parse(total) - decimal.Parse(discount)) + decimal.Parse(costSP) ).ToString();
                lbl_qty.Text = "ยอดรวมค่าสินค้าและบริการ " + total + " บาท";
                lbl_discount.Text = "ยอดรวมค่าส่วนลด " + discount + " บาท";
                lbl_ship.Text = "ค่าจัดส่ง " + costSP + " บาท";
                lbl_total.Text = "ยอดเงินที่ต้องชำระ " + nettotal + " บาท";
                lbl_total.ForeColor = System.Drawing.Color.Blue;

                lbl_name.ForeColor = System.Drawing.Color.Black;

                string paystatus = dt.Rows[0]["hd_paystatus"].ToString();
                if (paystatus == "confirm")
                {
                    string receive = dt.Rows[0]["hd_receive"].ToString();
                    if (receive == "no")
                    {
                        bl = "Receive No";
                    }
                    else if (receive == "yes")
                    {
                        bl = "Receive Yes";
                    }
                    else
                    {
                        bl = "";
                    }
                }
                else if (paystatus == "cancel")
                {
                    bl = "Cancel";
                }
                else
                {
                    bl = "Pay";
                }
            }
            else
            {
                bl = "";
            }

            return bl;
        }

        protected void btn_check_ServerClick(object sender, EventArgs e)
        {
            string id = txt_docno.Value.ToString().Trim();
            string phone = txt_phone.Value.ToString().Trim();
            if (phone.Length >= 4)
            {
                string result = Data(id, phone);

                if (result == "Pay")
                {
                    Session["PaySlip"] = "Yes";
                    Response.Redirect("PaySlip.aspx?id=" + id);
                }
                else if (result == "Receive No")
                {
                    lbl_nodata.Text = "อยู่ระหว่างการเตรียมสินค้า บัญชียืนยันยอดการชำระแล้ว";
                    lbl_nodata.ForeColor = System.Drawing.Color.Green;
                }
                else if (result == "Receive Yes")
                {
                    lbl_nodata.Text = "จัดส่งสินค้าแล้ว หรือ ลูกค้ามารับสินค้าแล้ว";
                    lbl_nodata.ForeColor = System.Drawing.Color.Green;
                }
                else if (result == "Cancel")
                {
                    lbl_nodata.Text = "รายการสั่งซื้อนี้ถูกยกเลิก หากมีข้อสงสัยสามารถติดต่อสอบถามเข้ามาได้ที่เบอร์โทร +66 3310 8999, +66 3892 1999, ต่อ 3151 ถึง 3153";
                }
                else
                {
                    lbl_nodata.Text = "ไม่พบเลขที่การสั่งซื้อ กับหมายเลขโทรศัพท์นี้ !!";
                }
            }
            else
            {
                lbl_nodata.Text = "กรุณาระบุหมายเลขโทรศัพท์อย่างน้อย 4 ตัวเลข !!";
            }
        }

        public Boolean Save_img(string id)
        {
            Boolean result = false;
                                
            if (uploadimg.HasFile)
            {
                if (uploadimg.PostedFile.ContentType == "image/jpeg" || uploadimg.PostedFile.ContentType == "image/png")
                {

                    if (uploadimg.PostedFile.ContentLength < 1024000)
                    {
                        string filename = Path.GetFileName(uploadimg.FileName);
                        string[] File_ar = filename.ToString().Split('.');
                        filename = File_ar[0] + ",id_" + id + "." + File_ar[1];
                        string part = "~/Marketing/fileupload/";


                        DirectoryInfo myDirInfo;
                        myDirInfo = new DirectoryInfo(Server.MapPath("fileupload/"));
                        FileInfo[] myFileInfo = myDirInfo.GetFiles("*,id_" + id + "*");

                        if (myFileInfo.Length > 0)
                        {
                            string strFileFullPath = Server.MapPath("fileupload/") + myFileInfo[0].ToString();

                            if (System.IO.File.Exists(strFileFullPath))
                            {
                                System.IO.File.Delete(strFileFullPath);
                            }
                        }
                        uploadimg.SaveAs(System.IO.Path.Combine(Server.MapPath(part), filename));

                        string dateupload = date_slip.Value.ToString();
                        string HH = txt_hour.Value.ToString().Trim();
                        if (HH.Length < 2) { HH = "0" + HH; }
                        string mm = txt_minute.Value.ToString().Trim();
                        if (mm.Length < 2) { mm = "0" + mm; }
                        string timeupload = HH + ":" + mm;
                        string priceupload = txt_money.Value.ToString().Trim();

                        sql = "UPDATE marketingheader SET hd_dateslip = '" + dateupload + "', hd_timeslip = '" + timeupload + "' , hd_priceslip = '" + priceupload + "', hd_paystatus = 'yes' WHERE hd_id = '" + id + "';";

                        if (CL_Sql.Modify(sql))
                        {
                            result = true;
                        }
                        else
                        {
                            result = false;
                        }

                    }
                }
            }
            return result;
        }

        protected void btn_success_ServerClick(object sender, EventArgs e)
        {
            string id = Request.QueryString["id"];

            string scModal = "no";

            string date = date_slip.Value.ToString();
            string hour = txt_hour.Value.ToString().Trim();
            string minute = txt_minute.Value.ToString().Trim();
            string money = txt_money.Value.ToString().Trim();
            if (date == "" || hour == "" || minute == "" || money == "")
            {
                scModal = "fn_AlertModal('Info','กรุณากรอกข้อมูลการโอนเงินให้ครบถ้วน','', 0)";
            }
            else
            {
                if (uploadimg.HasFile)
                {
                    if (Save_img(id))
                    {
                        scModal = "fn_AlertModal('Success','บันทึกสำเร็จ','Result.aspx?id=" + id + "', 2000)";
                    }
                    else
                    {
                        scModal = "fn_AlertModal('Warning','ไม่สามารถบันทึกข้อมูลได้ กรุณาติดต่อผู้ดูแลระบบ','', 0)";
                    }
                }
                else
                {
                    scModal = "fn_AlertModal('Info','กรุณาแนบสลิปหลักฐานการโอนเงิน','', 0)";
                }
            }

            Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
        }
    }
}