using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BRH_Plubic.VaccineCovid
{
    public partial class Default1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        //Response.Redirect("UploadSlip");
            Response.Redirect("https://script.google.com/macros/s/AKfycbxczEog1gZ9CAdcbfajpFyZXrdvkzo_vBxGD8HIbQe-OSUSQLIe/exec");
        }
    }
}