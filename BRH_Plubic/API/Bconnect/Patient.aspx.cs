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

namespace BRH_Plubic.API.Bconnect
{
    public partial class Patient : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            //var json = new WebClient().DownloadString("http://10.121.10.212:4001/API/user");
        }
    }
}