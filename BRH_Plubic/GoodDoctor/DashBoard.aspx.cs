using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;

using System.Net.NetworkInformation;

namespace BRH_Plubic.GoodDoctor
{
    public partial class DashBoard : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["location"] != null)
            {
                CheckLocation(Request.QueryString["location"].ToString());
            }
        }

        public string CheckLocation(string dlid)
        {
            string result = "";

            sql = "select * from doctor_location where dl_id = '" + dlid + "' ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                result = dlid;

                doctorList(result);
            }

            return result;
        }

        protected void doctorList(string dlid)
        {
            string html = "<div class=\"slideshow-container full-screen\">\n";
            string dot = "";
            int cnt = 0;
            int TimeRefesh = 0;

            sql = "call sp_doctorScheduleToday('" + dlid + "', ''); ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                int i = 1; int j = 1;
                
                foreach (DataRow dr in dt.Rows)
                {
                    if (dr["Working"].ToString() == "yes")
                    {
                        cnt++;

                        if (i == 1)
                        {
                            html = html + " <div class=\"mySlides ^fade^\">\n";
                            dot = dot + "<span class=\"dot\"></span>\n";
                            TimeRefesh++;
                        }
                        if (j == 1)
                        {
                            string half = "top";
                            if (i > 4) { half = "bottom"; }
                            html = html + "     <div class=\"row col-12 mx-auto my-auto half-" + half + "-screen\">\n";
                        }

                        string img = dr["dr_img"].ToString();
                        if (img == "")
                        {
                            img = "image/doctor_null.png";
                        }

                        html = html + "         <div class=\"col-3 full-box\" style=\"background-image: url('" + img + "');\">\n";
                        html = html + "             <div class=\"star-box\"><script> LoopStar(5," + dr["dr_rating"] + ",4); </script></div>\n";
                        html = html + "             <div class=\"text-box\">" + dr["dr_forename"] + " " + dr["dr_surname"] + "</div>\n";
                        html = html + "         </div>\n";

                        if (j == 4)
                        {
                            html = html + "     </div>\n";
                            j = 1;
                        }
                        else
                        {
                            j = j + 1;
                        }
                        if (i == 8)
                        {
                            html = html + " </div>\n";
                            i = 1;
                        }
                        else
                        {
                            i = i + 1;
                        }
                    }
                } // end foreach

                if (j > 1)
                {
                    html = html + "     </div>\n";
                }
                if (i > 1)
                {
                    html = html + " </div>\n";
                }
            }

            html = html + "</div>\n";

            if (cnt > 8) 
            {
                html = html.Replace("^",""); 
            } 
            else 
            {
                html = html.Replace("^fade^", "");
            }

            if (TimeRefesh == 0)
            {
                TimeRefesh = 5;
                lbl_HTML.Text = "<div class=\"col-12 mx-auto my-5 text-center\" style=\"font-size: xx-large;\">ไม่มีแพทย์ในแผนก ในช่วงเวลานี้</div>";
            }
            else
            {
                lbl_HTML.Text = html;
                lbl_dot.Text = dot;
            }

            TimeRefesh = (TimeRefesh * 20000) - 2000;
            lbl_refresh.Text = "<script> fn_Refresh(" + TimeRefesh + "); </script>";
        }
    }
}