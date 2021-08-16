using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;

namespace BRH_Plubic.ARIQ
{
    public partial class Default : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass CL_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["Focus"] == null)
            {
                Response.Redirect("Default.aspx?Focus=yes#ShowQ");
            }
            
        }

        public Boolean Doctor()
        {
            Boolean bl = false;

            sql = "select ar.*,ad.ad_name " +
                "from ari_room as ar " +
                "left join ari_doctor as ad on ad.ad_id = ar.ar_adid " +
                "order by ar_id ";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                for (int i=0; i<dt.Rows.Count; i++)
                {
                    string roomid = dt.Rows[i]["ar_id"].ToString();
                    string doctor = dt.Rows[i]["ad_name"].ToString();

                    switch (roomid)
                    {
                        case "1":
                            lbl_doctor1.Text = doctor;
                            break;
                        case "2":
                            lbl_doctor2.Text = doctor;
                            break;
                        case "3":
                            lbl_doctor3.Text = doctor;
                            break;
                        case "4":
                            lbl_doctor4.Text = doctor;
                            break;
                        case "5":
                            lbl_doctor5.Text = doctor;
                            break;
                        case "6":
                            lbl_doctor6.Text = doctor;
                            break;
                        case "7":
                            lbl_doctor7.Text = doctor;
                            break;
                    }

                }
            }

            return bl;
        }

        public Boolean ShowQ()
        {
            Boolean bl = false;

            string R1 = ""; string RH1 = ""; string RN1 = "";
            string R2 = ""; string RH2 = ""; string RN2 = "";
            string R3 = ""; string RH3 = ""; string RN3 = "";
            string R4 = ""; string RH4 = ""; string RN4 = "";
            string R5 = ""; string RH5 = ""; string RN5 = "";
            string R6 = ""; string RH6 = ""; string RN6 = "";
            string R7 = ""; string RH7 = ""; string RN7 = "";

            sql = "select * from ari_queue " +
                "where convert(aq_datetime,date) = current_date and aq_cancel = 'no' and aq_status != 'finish' order by aq_datetime ";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                
                string status = "";
                string roomid = "";
                string number = "";
                for (int i=0; i<dt.Rows.Count; i++)
                {
                    status = dt.Rows[i]["aq_status"].ToString();
                    roomid = dt.Rows[i]["aq_arid"].ToString();
                    number = dt.Rows[i]["aq_number"].ToString();

                    switch (roomid)
                    {
                        case "1":
                            if (status== "checking") { R1 = number; } 
                            else if (status == "hold") { if (RH1 != "") { RH1 = RH1 + "&nbsp;↔&nbsp;"; } RH1 = RH1 + number; } 
                            else if (status == "waiting") { if (RN1 != "") { RN1 = RN1 + "&nbsp;←&nbsp;"; } RN1 = RN1 + number; }
                            else { }
                            break;
                        case "2":
                            if (status == "checking") { R2 = number; }
                            else if (status == "hold") { if (RH2 != "") { RH2 = RH2 + "&nbsp;↔&nbsp;"; } RH2 = RH2 + number; }
                            else if (status == "waiting") { if (RN2 != "") { RN2 = RN2 + "&nbsp;←&nbsp;"; } RN2 = RN2 + number; }
                            else { }
                            break;
                        case "3":
                            if (status == "checking") { R3 = number; }
                            else if (status == "hold") { if (RH3 != "") { RH3 = RH3 + "&nbsp;/&nbsp;"; } RH3 = RH3 + number; }
                            else if (status == "waiting") { if (RN3 != "") { RN3 = RN3 + "&nbsp;←&nbsp;"; } RN3 = RN3 + number; }
                            else { }
                            break;
                        case "4":
                            if (status == "checking") { R4 = number; }
                            else if (status == "hold") { if (RH4 != "") { RH4 = RH4 + "&nbsp;↔&nbsp;"; } RH4 = RH4 + number; }
                            else if (status == "waiting") { if (RN4 != "") { RN4 = RN4 + "&nbsp;←&nbsp;"; } RN4 = RN4 + number; }
                            else { }
                            break;
                        case "5":
                            if (status == "checking") { R5 = number; }
                            else if (status == "hold") { if (RH5 != "") { RH5 = RH5 + "&nbsp;↔&nbsp;"; } RH5 = RH5 + number; }
                            else if (status == "waiting") { if (RN5 != "") { RN5 = RN5 + "&nbsp;←&nbsp;"; } RN5 = RN5 + number; }
                            else { }
                            break;
                        case "6":
                            if (status == "checking") { R6 = number; }
                            else if (status == "hold") { if (RH6 != "") { RH6 = RH6 + "&nbsp;↔&nbsp;"; } RH6 = RH6 + number; }
                            else if (status == "waiting") { if (RN6 != "") { RN6 = RN6 + "&nbsp;←&nbsp;"; } RN6 = RN6 + number; }
                            else { }
                            break;
                        case "7":
                            if (status == "checking") { R7 = number; }
                            else if (status == "hold") { if (RH7 != "") { RH7 = RH7 + "&nbsp;↔&nbsp;"; } RH7 = RH7 + number; }
                            else if (status == "waiting") { if (RN7 != "") { RN7 = RN7 + "&nbsp;←&nbsp;"; } RN7 = RN7 + number; }
                            else { }
                            break;
                        default:
                            break;
                    } // end switch
                } // end for

                
            } // end dt select

            lbl_R1.Text = R1; lbl_RH1.Text = RH1; lbl_RN1.Text = RN1;
            lbl_R2.Text = R2; lbl_RH2.Text = RH2; lbl_RN2.Text = RN2;
            lbl_R3.Text = R3; lbl_RH3.Text = RH3; lbl_RN3.Text = RN3;
            lbl_R4.Text = R4; lbl_RH4.Text = RH4; lbl_RN4.Text = RN4;
            lbl_R5.Text = R5; lbl_RH5.Text = RH5; lbl_RN5.Text = RN5;
            lbl_R6.Text = R6; lbl_RH6.Text = RH6; lbl_RN6.Text = RN6;
            lbl_R7.Text = R7; lbl_RH7.Text = RH7; lbl_RN7.Text = RN7;

            return bl;
        }

        protected void Timer1_Tick(object sender, EventArgs e)
        {
            ShowQ();
            Doctor();
            timeShow.Text = DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss");
        }
    }
}