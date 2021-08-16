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
    public partial class Default : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass CL_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["cate"] != null)
            {
                div_category.Visible = false;

                string cate = Request.QueryString["cate"].ToString();
                txt_cate.Text = cate;
                if (ShowProduct(cate))
                {
                    if (cate == "4") // <<------------------------------------ พิเศษ มีปุ่มดูรายละเอียด
                    {
                        a_Detail.Visible = true;
                    }
                }
                else
                {
                    Response.Redirect("Default.aspx");
                }

                div_product.Visible = true;
            }
            else
            {
                txt_cate.Text = "";
                div_category.Visible = true;
                div_product.Visible = false;
            }

            ImgMain();

            if (Session["basket_qty"] != null)
            {
                CartAmt();
            }
        }

        public Boolean ImgMain()
        {
            Boolean bl = false;

            string html = "";
            string htmlIN = "";
            string htmlPM = "";

            sql = "select * from marketingcategory where mc_active = 'yes' order by mc_id desc ";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    string cateID = dt.Rows[i]["MC_id"].ToString();
                    if (cateID != "")
                    {
                        DateTime NowDate = DateTime.Now.Date;
                        DateTime StartDate = DateTime.Parse(dt.Rows[i]["mc_startdate"].ToString());
                        DateTime EndDate = DateTime.Parse(dt.Rows[i]["mc_enddate"].ToString());

                        if (StartDate <= NowDate && NowDate < EndDate)
                        {
                            html = html + "<div class=\"col-lg-4 col-sm-12 btn btn-light mx-auto text-center\"><a href=\"Default.aspx?cate=" + cateID + "\"><img src=\"image/main/id" + cateID + "_Home-Category.jpg\" width=\"90%\" /></a></div>\n";

                            string active = "";
                            ;
                            if (i == 0)
                            {
                                active = "active";
                            }

                            htmlIN = htmlIN = "<li data-target=\"#carouselExampleIndicators\" data-slide-to=\"" + i + "\" class=\"bg-gradient " + active + "\"></li>";

                            htmlPM = htmlPM + "<div class=\"carousel-item " + active + "\">" +
                                              "<a href=\"Default.aspx?cate=" + cateID + "\">" +
                                              "<img class=\"d-block w-100\" src=\"image/main/id" + cateID + "_Home-Category.jpg\" alt=\"" + cateID + " slide\">" +
                                              "</a>" +
                                              "</div>";
                        }
                    }
                }
            }

            lbl_imgMain.Text = html;
            lbl_promotion_indi.Text = htmlIN;
            lbl_promotion_img.Text = htmlPM;

            return bl;
        }

        public Boolean ShowProduct(string mc_id)
        {
            Boolean bl = false;

            sql = "select * from marketingcategory where mc_id = '" + mc_id + "' ";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                if (dt.Rows[0]["mc_active"].ToString() == "yes")
                {
                    DateTime NowDate = DateTime.Now.Date;
                    DateTime StartDate = DateTime.Parse(dt.Rows[0]["mc_startdate"].ToString());
                    DateTime EndDate = DateTime.Parse(dt.Rows[0]["mc_enddate"].ToString());

                    if (StartDate <= NowDate && NowDate < EndDate)
                    {
                        sql = "select * from marketingproduct where mk_mcid = '" + mc_id + "' and mk_active = 'yes' order by mk_index ";
                        dt = new DataTable();
                        dt = CL_Sql.select(sql);
                        if (dt.Rows.Count > 0)
                        {
                            string div = "";
                            for (int i = 0; i < dt.Rows.Count; i++)
                            {
                                string mkid = dt.Rows[i]["mk_id"].ToString();
                                string mkindex = dt.Rows[i]["mk_index"].ToString();
                                string prname = dt.Rows[i]["mk_productname"].ToString();
                                string price = dt.Rows[i]["mk_price"].ToString();
                                string discount = dt.Rows[i]["mk_discount"].ToString();
                                string delivery = dt.Rows[i]["mk_delivery"].ToString();
                                string condition = dt.Rows[i]["mk_condition"].ToString();
                                if (condition == "")
                                {
                                    condition = "-";
                                }
                                div = div + Product(mc_id, mkid, mkindex, prname, price, discount, delivery, condition);
                            }
                            lbl_product.Text = div;
                            bl = true;
                        }
                    }
                    else
                    {

                    }
                }
            }

            return bl;
        }

        public string Product(string mcid, string id, string index, string name, string price, string discount, string delivery, string condition)
        {
            string html = "";
            string img = "image/product/id" + mcid + "_imageProduct" + index + ".jpg";


            if (delivery == "yes")
            {
                delivery = "มีค่าจัดส่งชิ้นแรก 60 บาท ชิ้นต่อไปชิ้นละ 10 บาท (หากมารับด้วยตนเองไม่คิดค่าจัดส่ง)";
            }
            else 
            {
                delivery = "ลูกค้าแจ้งนัดวันเข้าตรวจสุขภาพ พร้อมรับคูปองตรวจสุขภาพตามวันนัด ณ ศูนย์จำหน่ายบัตรชีววัฒนะ ชั้น 1 เวลา 08.00 - 17.00 น.ทุกวัน โทร. 038 921999 ต่อ 1887, 8888";
            }

            string Htmlprice = "";
            string Htmldiscount = "";
            if (discount == "" || discount == "0")
            {
                Htmldiscount = "";
                Htmlprice = "฿ " + price;
            }
            else
            {
                Htmldiscount = (decimal.Parse(price) - decimal.Parse(discount)).ToString();
                Htmldiscount = "<u style='color:blue;'>฿ " + Htmldiscount + "</u>";
                Htmlprice = "<del style='color:red;'>฿ " + price + "</del>";
            }

            html = "<div class=\"col-lg-3 col-sm-6 mb-5\">" +
                    "   <div hidden=\"hidden\">" +
                    "       <input id=\"txth_title_" + id + "\" value=\"" + name + "\" />" +
                    "       <input id=\"txth_price_" + id + "\" value=\"" + price + "\" />" +
                    "       <input id=\"txth_discount_" + id + "\" value=\"" + discount + "\" />" +
                    "       <input id=\"txth_delivery_" + id + "\" value=\"" + delivery + "\" />" +
                    "       <input id=\"txth_condition_" + id + "\" value=\"" + condition + "\" />" +
                    "   </div>" +
                    "   <div class=\"card card-body bg-transparent boxShadow\">" +
                    "       <div class=\"col-12 mx-auto\">" +
                    "           <img src=\"" + img + "\" id=\"setProduct" + id + "\" class=\"\" onclick=\"SetItem('" + index + "','" + mcid + "','" + id +"')\" width=\"100%\"  data-toggle=\"modal\" data-target=\"#exampleModalCenter\"  /> " +
                    "           <div class=\"col-12 text-left mt-3\" style=\"font-size:xx-large;\"> " + name + "</div> " +
                    "           <div class=\"row col-12 mx-auto\"> " +
                    "               <div class=\"col-6 text-left\" style=\"font-size:xx-large; color:blue;\">" + Htmlprice + "</div> " +
                    "               <div class=\"col-6 text-right\" style=\"font-size:xx-large; color:orangered;\">" + Htmldiscount + "</div> " +
                    "           </div> " +
                    "       </div>" +
                    "   </div>" +
                    "</div> ";

            return html;
        }

        protected void btn_submit_ServerClick(object sender, EventArgs e)
        {
            string cate = Request.QueryString["cate"].ToString();

            string id = txth_item.Value.ToString();
            string qty = txt_order.Value.ToString();
            if (int.Parse(qty) > 0)
            {
                Session["basket_cate"] = Session["basket_cate"] + cate + ",";
                Session["basket_id"] = Session["basket_id"] + id + ",";
                Session["basket_qty"] = Session["basket_qty"] + qty + ",";

                CartAmt();

                //Response.Redirect("Default.aspx?cate=" + cate + "#Cart");
            }
        }

        public Boolean CartAmt()
        {
            Boolean bl = false;

            int amt = 0;

            string[] amt_ar = Session["basket_qty"].ToString().Split(',');

            for (int i = 0; i < (amt_ar.Length - 1); i++)
            {
                amt = amt + int.Parse(amt_ar[i]);

                bl = true;
            }

            lbl_amt.Text = "+ " + amt.ToString();

            return bl;
        }

        protected void btn_basket_ServerClick(object sender, EventArgs e)
        {
            Response.Redirect("Basket.aspx");
        }

        protected void btn_pay_ServerClick(object sender, EventArgs e)
        {
            Response.Redirect("PaySlip.aspx");
        }

    }
}