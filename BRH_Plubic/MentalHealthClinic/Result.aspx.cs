using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;
using System.Net;
using System.IO;

namespace BRH_Plubic.MentalHealthClinic
{
    public partial class Result : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass CL_Sql = new SQLclass();
        string id = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            Checktype_massage();
        }
    
        public string Checktype_massage()  
        {
            string message = "";

            string m_id = "";
            string type = "";
            if (Request.QueryString["id"] != null && Request.QueryString["type"] != null)
            {
                m_id = Request.QueryString["id"].ToString();
                type = Request.QueryString["type"].ToString();
            }
             
            if (type == "Yellow")
            {
                message = "ส่งต่อนักจิตวิทยาเพื่อให้คำแนะนำเบื้องต้น";
                div_yellow.Visible = true;
            }
            else if (type == "ColorRednegative")
            {
                message = "DASS Negative กรุณาติดต่อกลับเพื่อให้คำแนะนำ";
                div_dass21_neg.Visible = true;
            }          
            else if (type == "PHQ9negative")
            {
                message = "PHQ9 <7";
                div_phq9_neg.Visible = true;
            }
            else if (type == "PHQ8positive")
            {
                message = "PHQ8 >= 17";
                div_phq8_pos.Visible = true;
            }
            else if (type == "PHQ8negative")
            {
                message = "PHQ8 < 17";
                div_phq8_neg.Visible = true;
            }
            else if (type == "GAD7positive")
            {
                message = "GAD7 < 10";
                div_gad7_pos.Visible = true;
            }
            else if (type == "GAD7negative")
            {
                message = "GAD7 > 10";
                div_gad7_neg.Visible = true;
            }
            else if (type == "SPST20positive")
            {
                message = "SPST20 >= 42";
                div_spst_pos.Visible = true;
            }
            else if (type == "SPST20negative")
            {
                message = "SPST20 < 42";
                div_spst_neg.Visible = true;
            }
            else
            {

            }
            return message;
        } 
       
        public Boolean InsertData()
        {
            Boolean result = false;

            string m_id = id;
            m_id = Request.QueryString["id"].ToString();

            string r_fname = register_fname.Value.ToString().Trim();
            string r_lname = register_lname.Value.ToString().Trim();
            string r_pnumber = register_pnumber.Value.ToString().Trim();
            string r_line = register_line.Value.ToString().Trim();

            sql = "UPDATE mentalhealthrecord SET fname = '" + r_fname + "', lname = '" + r_lname + "', p_number = '" + r_pnumber + "', line_id = '" + r_line + "'" + "WHERE m_id = '" + m_id + "'; ";

            if (CL_Sql.Modify(sql))
            {
                result = true;
            }

            return result;
        }

        public Boolean Linenotify(string txt)
        {
            Boolean bl = false;

            string m_id = "";
            m_id = Request.QueryString["id"].ToString();

            string token = "IcicbalDCvpgEvD4mjHhQW0199PNY9lE7f0lzW5Yh2O";
            string msg = txt;

            string firstname = register_fname.Value.ToString().Trim();
            string lasttname = register_lname.Value.ToString().Trim();
            string phonenumber = register_pnumber.Value.ToString().Trim();
            string lineid = register_line.Value.ToString().Trim();

            msg = msg + "\nชื่อ: " + firstname + " " + lasttname;
            msg = msg + "\nTel: " + phonenumber;
            msg = msg + "\nLine: " + lineid;
            msg = msg + "\nLink: http://brh.apply-apps.com/MentalHealthClinic/Default.aspx?id=" + m_id;

            try
            {
                var request = (HttpWebRequest)WebRequest.Create("https://notify-api.line.me/api/notify");
                var postData = string.Format("message={0}", msg);
                var data = Encoding.UTF8.GetBytes(postData);
                request.Method = "POST";
                request.ContentType = "application/x-www-form-urlencoded";
                request.ContentLength = data.Length;
                request.Headers.Add("Authorization", "Bearer " + token);

                using (var stream = request.GetRequestStream())
                {
                    stream.Write(data, 0, data.Length);
                }

                var response = (HttpWebResponse)request.GetResponse();
                var responseString = new StreamReader(response.GetResponseStream()).ReadToEnd();

                bl = true;
            }
            catch (Exception ex)
            {
                bl = false;
            }

            return bl;
        }

        protected void btn_submit_result_ServerClick(object sender, EventArgs e)
        {
            if (InsertData())
            {
                Linenotify(Checktype_massage());
                Response.Write("<script>alert('บันทึกข้อมูลของท่านเรียบร้อยแล้ว'); window.location.href='Default.aspx'</script>");
            }
            else
            {
                Response.Write("<script>alert('ไม่สามารถบันทึกได้กรุณาติดต่อ Admin');</script>");
            }
        }
    }
}