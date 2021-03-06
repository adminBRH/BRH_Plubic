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
    public partial class Result_dass21 : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass CL_Sql = new SQLclass();
        string id = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            string m_id = Request.QueryString["id"].ToString();
            CheckID(m_id);
        }

        public void CheckID(string m_id)
        {
            sql = "select * from mentalhealthrecord where m_id = '" + m_id + "'; ";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                int colorID = int.Parse(dt.Rows[0]["color_id"].ToString());
                if (colorID > 7)
                {
                    Response.Redirect("ColorRedPositive.aspx?id=" + m_id + "");
                }
                else
                {
                    if (colorID < 5)
                    {
                        Response.Redirect("ColorGreen.aspx?id=" + m_id + "");
                    }
                }
            }
        }

        public Boolean InsertDataDassResult(string id)
        {
            Boolean result = false;

            string m_id = id;

            string fname = txt_fname.Value.ToString().Trim();
            string lname = txt_lname.Value.ToString().Trim();
            string pnumber = txt_phone.Value.ToString().Trim();
            string line = txt_line.Value.ToString().Trim();
            string empid = txt_empid.Value.ToString().Trim();

            string accommodation = dd_accommodation.SelectedValue.ToString();
            string roomNumber = txt_roomnumber.Value.ToString().Trim();

            sql = "UPDATE mentalhealthrecord " +
                "SET fname = '" + fname + "', lname = '" + lname + "', p_number = '" + pnumber + "', line_id = '" + line + "', emp_id = '" + empid + "' " +
                ",accommodation = '" + accommodation + "', room_number = '" + roomNumber + "' " +
                "WHERE m_id = '" + m_id + "';";
            if (CL_Sql.Modify(sql))
            {
                result = true;
            }

            return result;
        }

        public Boolean Linenotify()
        {
            Boolean bl = false;

            string m_id = "";
            m_id = Request.QueryString["id"].ToString();

            string token = "IcicbalDCvpgEvD4mjHhQW0199PNY9lE7f0lzW5Yh2O";
            string msg = "";

            string empid = txt_empid.Value.ToString().Trim();
            string firstname = txt_fname.Value.ToString().Trim();
            string lasttname = txt_lname.Value.ToString().Trim();
            string phonenumber = txt_phone.Value.ToString().Trim();
            string lineid = txt_line.Value.ToString().Trim();

            string accommodation = dd_accommodation.SelectedValue.ToString();
            string roomNumber = txt_roomnumber.Value.ToString().Trim();

            msg = msg + "\nรหัสพนักงาน: " + empid;
            msg = msg + "\nชื่อ: " + firstname + " " + lasttname;
            msg = msg + "\nTel: " + phonenumber;
            msg = msg + "\nLine: " + lineid;
            //msg = msg + "\nสถานที่พักรักษา: " + accommodation;
            //msg = msg + "\nหมายเลขห้อง: " + roomNumber;
            msg = msg + "\nLink: " + CL_Sql.host() + "MentalHealthClinic/Default.aspx?id=" + m_id;

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

        protected void btn_submit_result_dass_ServerClick(object sender, EventArgs e)
        {
            if (Request.QueryString["id"] != null)
            {
                string m_id = Request.QueryString["id"].ToString();

                if (InsertDataDassResult(m_id))
                {
                    Linenotify();
                    Response.Write("<script>alert('บันทึกข้อมูลของท่านเรียบร้อยแล้ว โปรดทำแบบสอบถามหน้าต่อไป'); window.location.href='ColorYellow.aspx?id=" + m_id + "'</script>");
                }
                else
                {
                    Response.Write("<script>alert('ไม่สามารถบันทึกได้กรุณาติดต่อ Admin');</script>");
                }
            }
            else
            {
                Response.Redirect("Default.aspx");
            }
        }
    }
}