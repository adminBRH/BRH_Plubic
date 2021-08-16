using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Net.Mail;

public class ClassEmail
{
    public Boolean Send(string mailTo, string subject, string body)
    {
        Boolean bl = false;

        SmtpClient smtpClient = new SmtpClient("smtp.gmail.com", 587);

        smtpClient.Credentials = new System.Net.NetworkCredential("brh.hito@gmail.com", "beer@dminbrh");
        // smtpClient.UseDefaultCredentials = true; // uncomment if you don't want to use the network credentials
        smtpClient.DeliveryMethod = SmtpDeliveryMethod.Network;
        smtpClient.EnableSsl = true;
        MailMessage mail = new MailMessage();

        //Setting From , To and CC
        mail.From = new MailAddress("info@brh.co.th", "BRH Automail service");
        mail.To.Add(new MailAddress(mailTo));
        mail.Subject = subject;
        mail.Body = body;
        mail.IsBodyHtml = true;
        //mail.CC.Add(new MailAddress(""));

        try
        {
            smtpClient.Send(mail);
            bl = true;
        }
        catch
        { }

        return bl;
    }
}