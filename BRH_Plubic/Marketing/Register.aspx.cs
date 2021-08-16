using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;

namespace BRH_Plubic.Marketing
{
    public partial class Register : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass CL_Sql = new SQLclass();
        string hd_id = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["basket_id"] == null || Session["basket_qty"] == null)
            {
                Response.Redirect("Default.aspx");
            }
        }

        public Boolean Insertdata()
        {
            Boolean bl = false;

            string NonShip = "No";

            string send = txt_send.Value.ToString();
            if (send == "1")
            {
                NonShip = "Yes";
                send = "รับสินค้า ณ จุดจำหน่าย";
            }
            else if (send == "2")
            {
                send = "จัดส่งสินค้าตามที่อยู่";
            }
            else { send = ""; }
            string fname = txt_fname.Value.ToString().Trim();
            string lname = txt_lname.Value.ToString().Trim();
            string phone = txt_phone.Value.ToString().Trim();
            string address = txt_address.Value.ToString().Trim();
            string moo = txt_moo.Value.ToString().Trim();
            string subdist = txt_subdistric.Value.ToString().Trim();
            string distric = txt_distric.Value.ToString().Trim();
            string province = txt_province.Value.ToString().Trim();
            string zipcode = txt_zipcode.Value.ToString().Trim();

            string key = CL_Sql.GenerateKey(11);

            sql = "INSERT INTO marketingheader " +
                "\n(hd_date, hd_fname, hd_lname, hd_address, hd_moo, hd_subdistric, hd_distric, hd_province, hd_pnumber, hd_zipcode, hd_paystatus, hd_shippingstatus, hd_shippingcost, hd_status) " +
                "\nVALUES(" +
                "current_timestamp(), " +
                "'" + fname + "', " +
                "'" + lname + "', " +
                "'" + address + "', " +
                "'" + moo + "', " +
                "'" + subdist + "', " +
                "'" + distric + "', " +
                "'" + province + "', " +
                "'" + phone + "', " +
                "'" + zipcode + "', " +
                "'no', " +
                "'"+ send + "', " +
                "NULL, " +
                "'" + key + "');";
            if (CL_Sql.Modify(sql))
            {
                
                sql = "select hd_id from marketingheader " +
                    "where convert(hd_date, date)=current_date and hd_status='" + key + "' ";
                dt = new DataTable();
                dt = CL_Sql.select(sql);
                if (dt.Rows.Count > 0)
                {
                    hd_id = dt.Rows[0]["hd_id"].ToString();
                }

                string[] cate_ar = Session["basket_cate"].ToString().Split(',');
                string[] bsid_ar = Session["basket_id"].ToString().Split(',');
                string[] bsqty_ar = Session["basket_qty"].ToString().Split(',');

                decimal Total = 0;
                decimal discountTotal = 0;
                decimal Net = 0;
                int Qty = 0;
                decimal CostShp = 0;

                string sql_detail = "";
                for (int i = 0; i < (bsid_ar.Length - 1); i++)
                {
                    string prname = "";
                    decimal price = 0;
                    decimal discount = 0;
                    sql = "select * from marketingproduct where mk_mcid = '" + cate_ar[i] + "' and mk_id = '" + bsid_ar[i] + "' ";
                    dt = new DataTable();
                    dt = CL_Sql.select(sql);
                    if (dt.Rows.Count > 0)
                    {
                        prname = dt.Rows[0]["mk_productname"].ToString();
                        price = decimal.Parse(dt.Rows[0]["mk_price"].ToString());
                        if (dt.Rows[0]["mk_discount"].ToString() == "")
                        {
                            discount = 0;
                        }
                        else
                        {
                            discount = decimal.Parse(dt.Rows[0]["mk_discount"].ToString());
                        }

                        Total = Total + (int.Parse(bsqty_ar[i]) * price);
                        discountTotal = discountTotal + (int.Parse(bsqty_ar[i]) * discount);
                        Net = Net + (int.Parse(bsqty_ar[i]) * price) - (int.Parse(bsqty_ar[i]) * discount);
                        Qty = Qty + int.Parse(bsqty_ar[i]);

                        sql_detail = sql_detail + "INSERT INTO marketingdetail " +
                            "\n(hd_id, dt_mk_id, dt_mk_productname, dt_qty, dt_price, dt_discount) " +
                            "\nVALUES('" + hd_id + "', '" + bsid_ar[i] + "', '" + prname + "', " + bsqty_ar[i] + ", " + price + ", " + discount + ");\n ";
                    }
                }
                if (CL_Sql.Modify(sql_detail))
                {
                    if (NonShip == "Yes")
                    {
                        CostShp = 0;
                    }
                    else
                    {
                        string 

                        sql = "select sum(md.dt_qty) as 'qty' from marketingdetail as md " +
                            "\nleft join marketingproduct as mp on md.dt_mk_id = mp.mk_id " +
                            "\nwhere mp.mk_delivery = 'yes' and md.hd_id = '" + hd_id + "' ";
                        dt = new DataTable();
                        dt = CL_Sql.select(sql);
                        if(dt.Rows.Count > 0){
                            Qty = int.Parse(dt.Rows[0]["qty"].ToString());
                            CostShp = ((Qty - 1) * 10) + 60;
                        }
                        else
                        {
                            CostShp = 0;
                        }
                    }
                    

                    sql = "UPDATE marketingheader SET hd_total = " + Total + ", hd_totalqty = " + Qty + ", hd_discount = " + discountTotal + ", hd_shippingcost = " + CostShp + ", hd_status='confirm' " +
                        "\nWHERE hd_id = " + hd_id + ";";
                    if (CL_Sql.Modify(sql))
                    {
                        bl = true;
                    }
                }
            }

            return bl;
        }

        protected void btn_submit_ServerClick(object sender, EventArgs e)
        {
            string scModal = "";

            if (Insertdata())
            {
                Session["PaySlip"] = "Yes";

                scModal = "fn_AlertModal('Success','บันทึกข้อมูลของท่านเรียบร้อยแล้ว','PaySlip.aspx?id=" + hd_id + "', 2000)";
            }
            else
            {
                scModal = "fn_AlertModal('Warning','ไม่สามารถบันทึกข้อมูลของท่านได้ กรุณาติดต่อผู้ดูแลระบบ !!', '', 0)";
            }

            Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
        }
    }
}