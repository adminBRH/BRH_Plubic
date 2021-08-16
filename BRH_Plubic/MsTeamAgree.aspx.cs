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

namespace BRH_Plubic
{
    public partial class MsTeamAgree : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["MsTeamAgree"] != null)
            {
                if (Session["MsTeamAgree"].ToString() == "Print")
                {
                    if (Request.QueryString["id"] == null)
                    {
                        Session.Remove("MsTeamAgree");
                    }
                    else
                    {
                        string ms_id = Request.QueryString["id"].ToString().Trim();
                        Print(ms_id);
                    }
                }
            }

            if (!IsPostBack)
            {
                string Doctitle_th = "หนังสือแสดงความยินยอมขอคำปรึกษา ตรวจรักษากับแพทย์ผ่านระบบอินเตอร์เน็ต";
                string Doctitle_en = "Consent form for Telemedicine.";
                string Modaltitle = "Consent form for Telemedicine.<br />แบบฟอร์มขอรับคำปรึกษาตรวจรักษากับแพทย์ผ่านระบบอินเตอร์เน็ต";
                string Respect_th = "ณ ที่นี้ข้าพเจ้า ขอแสดงความยินยอมเพื่อรับการรักษา";
                string Respect_en = "I hereby to receive the treatment detailed above";

                if (Request.QueryString["form"] != null)
                {
                    string docForm = Request.QueryString["form"].ToString();
                    if (docForm == "" || docForm == "1")
                    {
                        tr1_reason.Attributes.Remove("hidden");
                        tr1_accept.Attributes.Remove("hidden");

                        tr2_accept.Attributes.Add("hidden", "hidden");
                        tr2_5.Attributes.Add("hidden", "hidden");
                    }
                    else if (docForm == "2")
                    {
                        tr1_reason.Attributes.Add("hidden", "hidden");
                        tr1_accept.Attributes.Add("hidden", "hidden");

                        tr2_accept.Attributes.Remove("hidden");
                        tr2_5.Attributes.Remove("hidden");

                        Doctitle_th = "หนังสือให้ความยินยอม<br />การดูแลตนเอง ที่บ้าน";
                        Doctitle_en = "Consent Form for Home Quarantine.";
                        Modaltitle = "Consent Form for Home Quarantine.<br />แบบฟอร์มให้ความยินยอมการดูแลตนเองที่บ้าน";
                        Respect_th = "ณ ที่นี้ข้าพเจ้า ขอแสดงความยินยอม ดูแลตนเอง ที่บ้าน";
                        Respect_en = "I agree to take care of myself at home.";
                    }
                    else
                    {
                        lbl_modal.Text = "<script>alertModalWarning('#Modal_Warning','Invalid Link'); setTimeout(function(){window.location='../Default.aspx';}, 2000);</script>";
                    }
                }
                lbl_titleDoc_th.Text = Doctitle_th;
                lbl_titleDoc_en.Text = Doctitle_en;
                lbl_respect_th.Text = Respect_th;
                lbl_respect_en.Text = Respect_en;
                lbl_titleModal.Text = Modaltitle;
            }

            string dcr = DateTime.Now.ToString("yyyy-MM-dd");
            txtH_dcr.Value = dcr;
        }

        protected void RD_Card_SelectedIndexChanged(object sender, EventArgs e)
        {
            string ValSelect = RD_Card.SelectedValue.ToString();
            if (ValSelect == "Other cards")
            {
                div_cardOther.Visible = true;
                txtH_card.Value = "Other";
            }
            else
            {
                div_cardOther.Visible = false;
                if (ValSelect == "Identity card")
                {
                    txtH_card.Value = "Identity card";
                }
                else
                {
                    txtH_card.Value = "Driver license";
                }
            }
        }

        protected void RD_gender_SelectedIndexChanged(object sender, EventArgs e)
        {
            string ValSelect = RD_gender.SelectedValue.ToString();
            txt_gender.Value = ValSelect;
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            string txt = Insert();
            if (txt != "")
            {
                div_print.Visible = true;

                if (Linenotify(txt))
                {
                    lbl_alert.Text = "บันทึกข้อมูลเรียบร้อยแล้ว";
                    lbl_alert.ForeColor = System.Drawing.Color.Green;
                }
                else
                {
                    lbl_alert.Text = "บันทึกข้อมูลแล้ว แต่ไม่สามารถส่งแจ้งเตือนไปยังเจ้าหน้าที่ได้ กรุณาติดต่อเจ้าหน้าที่ !!";
                    lbl_alert.ForeColor = System.Drawing.Color.Blue;
                }
            }
            else
            {
                lbl_alert.Text = "ไม่สามารถบันทึกข้อมูลได้ กรุณาติดต่อเจ้าหน้าที่ !!";
                lbl_alert.ForeColor = System.Drawing.Color.Red;
            }
        }

        public string Insert()
        {
            string rt = "";

            string fname = txt_fname.Value.ToString().Trim();
            string lname = txt_lname.Value.ToString().Trim();
            string fnameTH = txt_fnameTH.Value.ToString().Trim();
            string lnameTH = txt_lnameTH.Value.ToString().Trim();
            string gender = txt_gender.Value.ToString().Trim();
            string DOB = txtH_dobsave.Value.ToString().Trim();
            string card = txtH_card.Value.ToString().Trim();
            string cardother = txt_CardOther.Value.ToString().Trim();
            if (card == "Other") { card = cardother; }
            string cardnum = txt_CardNumber.Value.ToString().Trim();
            string phone = txt_phone.Value.ToString().Trim();
            string email = txt_email.Value.ToString().Trim();
            string line = txt_line.Value.ToString().Trim();
            string reason = txt_reson.Value.ToString().Trim();
            string docform = "";
            string formName = "";
            if (Request.QueryString["form"] != null)
            {
                docform = Request.QueryString["form"].ToString();

                if (docform == "2")
                {
                    formName = "Consent Form Quarantine";
                }
                else
                {
                    formName = "Consent Form Telemedicine";
                }
            }
            else
            {
                formName = "Consent Form Telemedicine";
            }

            sql = "INSERT INTO msteamagree " +
            "(ms_adddatetime, ms_fname, ms_lname, ms_fnameth, ms_lnameth, ms_gender, ms_dob, ms_cardtype, ms_cardnum, ms_phone, ms_email, ms_line, ms_reason, ms_status, ms_docform) " +
            "VALUES(" +
            "current_timestamp()" +
            ",'" + fname + "' " +
            ",'" + lname + "' " +
            ",'" + fnameTH + "' " +
            ",'" + lnameTH + "' " +
            ",'" + gender + "' " +
            ",'" + DOB + "' " +
            ",'" + card + "' " +
            ",'" + cardnum + "' " +
            ",'" + phone + "' " +
            ",'" + email + "' " +
            ",'" + line + "' " +
            ",'" + reason + "' " +
            ", 'Agree' " +
            ", '" + docform + "'" +
            "); ";
            if (cl_Sql.Modify(sql))
            {
                sql = "select max(ms_id) as 'MaxID' from msteamagree ";
                dt = new DataTable();
                dt = cl_Sql.select(sql);
                if (dt.Rows.Count > 0)
                {
                    rt = formName +" (ID " + dt.Rows[0]["MaxID"].ToString() + " คุณ " + fnameTH + " เบอร์โทรศัพท์ " + phone + ")";
                }
                
            }

            return rt;
        }

        public Boolean Linenotify(string txt)
        {
            Boolean bl = false;

            string token = "wTB2dK1STDqgqQHw5WsGJdPyPZCxlXDd0r1n5D5Ugaj";
            string msg = txt;

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

        public Boolean Print(string id)
        {
            Boolean bl = false;

            sql = "select *,concat(ms_fname,' ',ms_lname) as 'ms_fullnameEN' ,concat(ms_fnameth,' ',ms_lnameth) as 'ms_fullnameTH' " +
                "from msteamagree where ms_id = '" + id + "' ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                printableArea.Attributes.Remove("data-toggle");

                btn_input.Visible = false;
                div_submit.Visible = false;

                div_print.Visible = true;

                lbl_name.Text = "..." + dt.Rows[0]["ms_fullnameEN"].ToString() + "...";

                string[] ms_dobDateTime = dt.Rows[0]["ms_dob"].ToString().Split(' ');
                lbl_dob.Text = "..." + ms_dobDateTime[0] + "...";

                string[] ms_dob = ms_dobDateTime[0].ToString().Split('-');

                int ms_year = int.Parse(ms_dob[0]);
                int age = int.Parse(DateTime.Now.ToString("yyyy")) - ms_year;

                int MM = int.Parse(DateTime.Now.ToString("MM"));
                int ms_month = int.Parse(DateTime.Parse(ms_dobDateTime[0]).ToString("MM"));

                int month = ms_month - MM;
                if (month > 1)
                {
                    age = age - 1;
                }
                lbl_age.Text = "..." + age.ToString() + "...";
                lbl_ageTH.Text = "..." + age.ToString() + "...";

                string[] ms_datetime = dt.Rows[0]["ms_adddatetime"].ToString().Split(' ');
                lbl_visitdate.Text = "..." + ms_datetime[0].ToString() + "...";

                lbl_nameTH.Text = "..." + dt.Rows[0]["ms_fullnameTH"].ToString() + "...";

                lbl_card.Text = "..." + dt.Rows[0]["ms_cardtype"].ToString() + "...";

                lbl_cardNum.Text = "..." + dt.Rows[0]["ms_cardnum"].ToString() + "...";
                
                lbl_reason.Text = "..." + dt.Rows[0]["ms_reason"].ToString() + "...";
            }

            return bl;
        }
    }
}