using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;

namespace BRH_Plubic.AssetControl
{
    public partial class TransferDocument : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            //if (Session["userid"] == null)
            //{
            //    Response.Redirect("../Default.aspx?back=AssetControl/TransferDocument&login=require");
            //}
            //else
            //{
            //    if (!IsPostBack)
            //    {

            //    }
            //}
        }
    }
}