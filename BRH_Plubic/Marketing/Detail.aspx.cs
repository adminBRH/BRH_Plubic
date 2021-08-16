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
    public partial class Detail : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass CL_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Login"] == null)
            {
                Response.Redirect("Report.aspx");
            }
            else
            {
                if (Request.QueryString["id"] == null)
                {
                    Response.Redirect("Report.aspx");

                }
                else
                {
                    Data();
                }
            }
        }

        public Boolean Data()
        {
            Boolean bl = false;

            string id = Request.QueryString["id"].ToString();
            sql = "select *, concat(hd_fname,' ',hd_lname) as 'name', concat(hd_address,' ',hd_moo,' ',hd_subdistric,' ',hd_distric,' ',hd_province,' ',hd_zipcode) as 'address' " +
                ",concat(hd_dateslip,' ',hd_timeslip) as 'SlipDatetime' " +
                "from marketingheader where hd_id = '" + id + "'; ";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                lbl_docno.Text = id;
                lbl_date.Text = dt.Rows[0]["hd_date"].ToString();
                lbl_name.Text = dt.Rows[0]["name"].ToString();
                lbl_shipping.Text = dt.Rows[0]["hd_shippingstatus"].ToString();
                lbl_phone.Text = dt.Rows[0]["hd_pnumber"].ToString();
                lbl_address.Text = dt.Rows[0]["address"].ToString();

                decimal total = decimal.Parse(dt.Rows[0]["hd_total"].ToString());
                lbl_total.Text = total.ToString();
                decimal discont = decimal.Parse(dt.Rows[0]["hd_discount"].ToString());
                lbl_discont.Text = discont.ToString();
                decimal send = decimal.Parse(dt.Rows[0]["hd_shippingcost"].ToString());
                lbl_send.Text = send.ToString();
                lbl_pay.Text = ((total - discont) + send).ToString();

                string status = Session["status"].ToString();
                string paystatus = dt.Rows[0]["hd_paystatus"].ToString();
                if (status == "admin" || status == "finance")
                {
                    div_confirm.Visible = true;
                    if (paystatus == "confirm" || paystatus == "cancel")
                    {
                        div_confirm.Visible = false;
                    }
                }

                if (dt.Rows[0]["hd_receive"].ToString() == "no" && paystatus == "confirm" && status == "marketing")
                {
                    btn_send.Visible = true;
                }

                if (paystatus == "confirm")
                {
                    paystatus = "บัญชียืนยันการชะรำแล้ว";
                }
                else if (paystatus == "yes")
                {
                    paystatus = "แจ้งชำระแต่บัญชียังไม่ตรวจสอบ";
                }
                else if (paystatus == "no")
                {
                    paystatus = "ยังไม่ชำระเข้ามา";
                }
                else if (paystatus == "cancel")
                {
                    paystatus = "การชำระไม่ถูกต้องถูกปฏิเสธ";
                }
                else { }

                lbl_paystatus.Text = paystatus;

                lbl_payslip.Text = dt.Rows[0]["hd_priceslip"].ToString();
                lbl_timeslip.Text = dt.Rows[0]["SlipDatetime"].ToString();

                string receive = dt.Rows[0]["hd_receive"].ToString();
                if (receive=="no")
                {
                    receive = "ยังไม่ได้รับ/ยังไม่ได้จัดส่ง";
                }
                else if (receive == "yes")
                {
                    receive = "รับสินค้าแล้ว/จัดส่งสินค้าแล้ว";
                }
                else { }
                lbl_receive.Text = receive;
                lbl_receivedate.Text = dt.Rows[0]["hd_receivedate"].ToString();


                sql = "select * from marketingdetail where hd_id = '" + id + "' ";
                dt = new DataTable();
                dt = CL_Sql.select(sql);
                if (dt.Rows.Count > 0)
                {
                    string html = "";
                    
                    for (int i=0; i < dt.Rows.Count; i++)
                    {
                        int qty = int.Parse(dt.Rows[i]["dt_qty"].ToString());
                        decimal price = decimal.Parse(dt.Rows[i]["dt_price"].ToString());
                        decimal discount = (qty * decimal.Parse(dt.Rows[i]["dt_discount"].ToString()));
                        decimal sum = (qty * price);
                        decimal net = sum - discount;
                        html = html +  "<tr>" +
                                       "     <td style=\"text-align: left\">" + dt.Rows[i]["dt_mk_productname"].ToString() +"</td>" +
                                       "     <td style=\"text-align: center\">" + qty.ToString() + "</td>" +
                                       "     <td style=\"text-align: right\">" + price.ToString() + "</td>" +
                                       "     <td style=\"text-align: right\">" + sum + "</td>" +
                                       "     <td style=\"text-align: right\">" + discount + "</td>" +
                                       "     <td style=\"text-align: right\">" + net + "</td>" +
                                       "</tr> ";
                    }

                    lbl_detail.Text = html;


                    DirectoryInfo myDirInfo;
                    myDirInfo = new DirectoryInfo(Server.MapPath("fileupload/"));
                    FileInfo[] myFileInfo = myDirInfo.GetFiles("*,id_" + id + "*");

                    if (myFileInfo.Length > 0)
                    {
                        string strFileFullPath = Server.MapPath("fileupload/") + myFileInfo[0].ToString();

                        if (System.IO.File.Exists(strFileFullPath))
                        {
                            string img = "~/Marketing/fileupload/" + myFileInfo[0];
                            imgSlip.ImageUrl = img;
                        }
                    }
                }

                
            }

            return bl;
        }

        protected void btn_confirmSlip_Click(object sender, EventArgs e)
        {
            string id = Request.QueryString["id"].ToString();
            string status = txtH_confirm.Value;
            if (status == "confirm")
            {
                sql = "update marketingheader set hd_paystatus = '" + status + "' where hd_id = '" + id + "' ";
                if (CL_Sql.Modify(sql))
                {
                    Response.Redirect("Detail.aspx?id=" + id);
                }
            }
        }

        protected void btn_cancelSlip_Click(object sender, EventArgs e)
        {
            string id = Request.QueryString["id"].ToString();
            string status = txtH_confirm.Value;
            if (status == "cancel")
            {
                sql = "update marketingheader set hd_paystatus = '" + status + "' where hd_id = '" + id + "' ";
                if (CL_Sql.Modify(sql))
                {
                    Response.Redirect("Detail.aspx?id=" + id);
                }
            }
        }

        protected void btn_send_ServerClick(object sender, EventArgs e)
        {
            string status = Session["status"].ToString();
            if (status == "admin" || status == "marketing")
            {
                string id = Request.QueryString["id"].ToString();
                sql = "update marketingheader set hd_receive = 'yes', hd_receivedate = current_timestamp() where hd_id = '" + id + "' ";
                if (CL_Sql.Modify(sql))
                {
                    Response.Write("<script>alert('บึกทึกเรียบร้อยแล้ว'); window.location.href='Report.aspx';</script>");
                }
                else
                {
                    Response.Write("<script>alert(ไม่สามารถบันทึกข้อมูลได้ กรุณาติดต่อผู้ดูแลระบบ !!);</script>");
                }
            }
            else
            {
                Response.Write("<script>alert(คุณไม่มีสิทธิ์ใช้งานปุ่มนี้ !!);</script>");
            }
        }
    }
}