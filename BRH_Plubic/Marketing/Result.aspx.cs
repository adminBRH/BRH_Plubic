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
    public partial class Result : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass CL_Sql = new SQLclass();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["id"] == null)
            {
                Response.Redirect("PaySlip.aspx");
            }
            else
            {
                string id = Request.QueryString["id"].ToString();
                SelectData(id);
            }
        }

        public Boolean SelectData(string id)
        {
            Boolean bl = false;

            sql = "select md.*,concat(mh.hd_fname,' ',mh.hd_lname) as 'name',mh.hd_total,mh.hd_discount,mh.hd_totalqty,mh.hd_shippingcost " +
                "\nfrom marketingdetail as md left join marketingheader as mh on mh.hd_id = md.hd_id " +
                "\nwhere md.hd_id = '" + id +"'";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                lbl_name.Text = "คุณ " + dt.Rows[0]["name"].ToString();
                lbl_total.Text = dt.Rows[0]["hd_total"].ToString();
                lbl_discount.Text = dt.Rows[0]["hd_discount"].ToString();
                lbl_ship.Text = dt.Rows[0]["hd_shippingcost"].ToString();
                lbl_nettotal.Text = ( (decimal.Parse(dt.Rows[0]["hd_total"].ToString()) - decimal.Parse(dt.Rows[0]["hd_discount"].ToString())) + decimal.Parse(dt.Rows[0]["hd_shippingcost"].ToString()) ).ToString() + " บาท";

                string html = "";
                for (int i=0; i < dt.Rows.Count; i++ )
                {
                    string total = (float.Parse(dt.Rows[i]["dt_qty"].ToString()) * float.Parse(dt.Rows[i]["dt_price"].ToString())).ToString();
                    string discount = (float.Parse(dt.Rows[i]["dt_qty"].ToString()) * float.Parse(dt.Rows[i]["dt_discount"].ToString())).ToString();
                    string net = (float.Parse(total) - float.Parse(discount)).ToString();

                    html = html + "<tr>" +
                                  "  <td class=\"text-left\" style=\"font-size: X-Large;\">" +
                                  "     " + dt.Rows[i]["dt_mk_productname"].ToString() +"" +
                                  "  </td>" +
                                  "  <td class=\"text-center\" style=\"font-size: X-Large;\">" +
                                  "     " + dt.Rows[i]["dt_qty"].ToString() + "" +
                                  "  </td>" +
                                  "  <td class=\"text-right\" style=\"font-size: X-Large;\">" +
                                  "     " + dt.Rows[i]["dt_price"].ToString() + "" +
                                  "  </td >" +
                                  "  <td class=\"text-right\" style=\"font-size: X-Large;\">" +
                                  "     " + total + "" +
                                  "  </td >" +
                                  "  <td class=\"text-right\" style=\"font-size: X-Large;\">" +
                                  "     " + discount + "" +
                                  "  </td >" +
                                  "  <td class=\"text-right\" style=\"font-size: X-Large;\">" +
                                  "     " + net + "" +
                                  "  </td >" +
                                  "</tr> ";
                }
                lbl_Detail.Text = html;
            }

            return bl;
        }

        protected void btn_newOrder_ServerClick(object sender, EventArgs e)
        {
            Session.RemoveAll();
            Response.Redirect("Default.aspx");
        }
    }
}