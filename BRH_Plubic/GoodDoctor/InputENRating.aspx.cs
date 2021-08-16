using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;

namespace BRH_Plubic.GoodDoctor
{
    public partial class InputENRating : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["login"] != null)
            {
                string status = Session["status"].ToString();
                if (status == "admin" || status == "headdept")
                {
                    if (Request.QueryString["sc"] == null)
                    {
                        div_register.Visible = false;
                        div_alert.Visible = true;
                        lbl_alert.ForeColor = System.Drawing.Color.Red;
                        lbl_alert.Text = "Data invalid !!";
                        lbl_script.Text = "<script>CloseWindow(3);</script>";
                    }
                }
                else
                {
                    Response.Write("<script>alert('คุณไม่มีสิทธิ์ใช้งานหน้านี้ !!'); window.close();</script>");
                }
            }
            else
            {
                Response.Write("<script>alert('กรุณา login ก่อนเข้าใช้งาน !!'); window.close();</script>");
            }
            
        }

        private string GetUserIP()
        {
            //Gets a comma-delimited list of IP Addresses
            string ipList = Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

            //If any are available - use the first one
            if (!string.IsNullOrEmpty(ipList))
            {
                return ipList.Split(',')[0];
            }

            //Otherwise return the Remote Address
            return Request.ServerVariables["REMOTE_ADDR"];
        }

        protected void btn_submit_ServerClick(object sender, EventArgs e)
        {
            string EN = txt_en.Value.ToString().Trim().Replace("-","");
            if (EN == "")
            {
                div_alert.Visible = true;
                lbl_alert.Text = "Please enter EN !!";
                lbl_alert.ForeColor = System.Drawing.Color.Red;
            }
            else
            {
                string scid = Request.QueryString["sc"].ToString();

                string alert = "";

                string dlid = "";
                string drid = "";

                sql = "select * from doctor_schedule where ds_active='yes' and ds_id = '" + scid + "'; ";
                dt = new DataTable();
                dt = cl_Sql.select(sql);
                if (dt.Rows.Count > 0)
                {
                    dlid = dt.Rows[0]["ds_dlid"].ToString();
                    drid = dt.Rows[0]["ds_drid"].ToString();

                    sql = "select * from doctor_rating " +
                        "\nwhere drr_en='" + EN + "' and convert(drr_datetime,date)=current_date " +
                        "\nand drr_dlid='" + dlid + "' and drr_drid='" + drid + "'; ";
                    dt = new DataTable();
                    dt = cl_Sql.select(sql);
                    if (dt.Rows.Count == 0)
                    {
                        sql = "INSERT INTO doctor_rating " +
                            "\n(drr_datetime, drr_score, drr_comment, drr_dlid, drr_drid, drr_active, drr_en, drr_submitdate) " +
                            "\nVALUES(current_timestamp(), 0, NULL, '" + dlid + "', '" + drid + "', 'no', '" + EN + "', NULL); ";
                        if (cl_Sql.Modify(sql))
                        {
                            sql = "update mytable set status='seedoctor' where active='yes' and IP='" + GetUserIP() + "' ";
                            cl_Sql.Modify(sql);

                            alert = "Success";
                            lbl_alert.ForeColor = System.Drawing.Color.Green;
                            lbl_script.Text = "<script>CloseWindow(3);</script>";
                        }
                        else
                        {
                            alert = "Error !!";
                            lbl_alert.ForeColor = System.Drawing.Color.Red;
                        }
                    }
                    else
                    {
                        alert = "Dulplicate data !!";
                        lbl_alert.ForeColor = System.Drawing.Color.Red;
                    }
                }
                else
                {
                    alert = "No data found !!";
                    lbl_alert.ForeColor = System.Drawing.Color.Red;
                }

                lbl_alert.Text = alert;
                div_register.Visible = false;
                div_alert.Visible = true;
            }
        }
    }
}