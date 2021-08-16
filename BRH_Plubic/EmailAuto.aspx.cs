using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;

using System.Net.Mail;

namespace BRH_Plubic
{
    public partial class EmailAuto : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_sendmail_Click(object sender, EventArgs e)
        {
            ClassEmail cl_email = new ClassEmail();

            string mailTo = "brh.hito@brh.co.th";
            string subject = "Test auto email";

            string body = "<h3>Dear Mr.XXXXX,</h3>" +
                          "\n<br /><br />" +
                          "\ntest<br />" +
                          "\ntest" +
                          "\n<br /><br />" +
                          "\n<h3>Best regards,</h3>" +
                          "\n<h3>Mr.ZZZZZ</h3>";

            cl_email.Send(mailTo, subject, body);
        }
    }
}