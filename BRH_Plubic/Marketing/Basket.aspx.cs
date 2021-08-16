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
    public partial class Basket : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass CL_Sql = new SQLclass();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["basket_id"] != null && Session["basket_qty"] != null)
            {
                ShowDetail();
            }
            else
            {
                Response.Redirect("Default.aspx");
            }
        }

        public Boolean ShowDetail()
        {
            Boolean bl = false;

            string[] cate_ar = Session["basket_cate"].ToString().Split(',');
            string[] id_ar = Session["basket_id"].ToString().Split(',');
            string[] qty_ar = Session["basket_qty"].ToString().Split(',');

            string html = "";
            decimal Total = 0;
            int qtyDeli = 0;

            for (int i=0; i<(id_ar.Length - 1); i++)
            {
                sql = "select * from marketingproduct where mk_mcid = '" + cate_ar[i] + "' and mk_id = '" + id_ar[i] + "' ";
                dt = new DataTable();
                dt = CL_Sql.select(sql);
                if (dt.Rows.Count > 0)
                {
                    string name = dt.Rows[0]["mk_productname"].ToString(); 
                    decimal price = decimal.Parse(dt.Rows[0]["mk_price"].ToString());
                    string discount = dt.Rows[0]["mk_discount"].ToString();
                    if (discount == "")
                    {
                        discount = "0";
                    }
                    html = html + Detail(name, qty_ar[i], price, decimal.Parse(discount), i);

                    Total = Total + (int.Parse(qty_ar[i]) * price) - (int.Parse(qty_ar[i]) * decimal.Parse(discount));

                    if (cate_ar[i] =="1")
                    {
                        qtyDeli = qtyDeli + int.Parse(qty_ar[i]);
                    }

                    bl = true;
                }
            }
            lbl_Detail.Text = html;


            if (qtyDeli > 0) { lbl_delivary.Text = "* หากต้องการให้จัดส่ง คิดค่าบริการจัดส่งชิ้นแรก 60 บาท ชิ้นต่อไปชิ้นละ 10 บาท * (เฉพาะสินค้าที่สามารถจัดส่งได้เท่านั้น)"; }
            int payTS = 60 + ((qtyDeli - 1) * 10); // <-------------------- ค่าจัดส่ง

            lbl_total.Text = Total.ToString() + " บาท";

            //lbl_ship.Text = payTS.ToString();

            Total = Total + payTS;

            return bl;
        }

        public string Detail(string name,string qty,decimal price, decimal discount, int index)
        {
            string html = "";

            decimal totalprice = price * int.Parse(qty);
            discount = discount * int.Parse(qty);
            decimal net = totalprice - discount;

            html = "<tr>"+
                   "     <td class=\"text-left\" style=\"font-size: X-Large;\">" + name + "</td>"+
                   "     <td class=\"text-center\" style=\"font-size: X-Large;\">&nbsp;" + qty + "</td>" +
                   "     <td class=\"text-right\" style=\"font-size: X-Large;\">" + price + "&nbsp;</td>" +
                   "     <td class=\"text-right\" style=\"font-size: X-Large;\">" + totalprice + "&nbsp;</td>" +
                   "     <td class=\"text-right\" style=\"font-size: X-Large;\">" + discount + "&nbsp;</td>" +
                   "     <td class=\"text-right\" style=\"font-size: X-Large;\">" + net + "&nbsp;</td>" +
                   "</tr>";

            return html;
        }

        protected void btn_confirm_ServerClick(object sender, EventArgs e)
        {
            Response.Redirect("Register.aspx");
        }

        protected void btn_del_Click(object sender, EventArgs e)
        {
            if (txtH_del.Value == "Yes")
            {
                Session.Remove("basket_cate");
                Session.Remove("basket_id");
                Session.Remove("basket_qty");
                Response.Redirect("Default.aspx");
            }
        }
    }
}