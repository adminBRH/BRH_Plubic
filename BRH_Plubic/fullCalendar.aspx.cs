using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;

namespace BRH_Plubic
{
    public partial class fullCalendar : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Times();
            }
        }

        public Boolean Times()
        {
            Boolean bl = false;

            sql = "select *,concat(at_time_start,' to ',at_time_end) as 'at_times' "+
                "from ari_time where at_active = 'Yes'";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                DD_Times.DataSource = dt;
                DD_Times.DataTextField = "at_times";
                DD_Times.DataValueField = "at_id";
                DD_Times.DataBind();

                bl = true;
            }

            return bl;
        }
    }
}