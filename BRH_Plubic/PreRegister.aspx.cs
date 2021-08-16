using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Drawing;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;

namespace BRH_Plubic
{
    public partial class PreRegister : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                NamePrefix();
            }

            SetTime();
        }

        public Boolean SetTime()
        {
            Boolean bl = false;

            try
            {
                string StartTime = "08:00";

                string[] HHmm = StartTime.ToString().Split(':');
                int HHst = int.Parse(HHmm[0]);
                int MMst = int.Parse(HHmm[1]);

                int HH = DateTime.Now.Hour;
                int mm = DateTime.Now.Minute;

                if (HH > HHst) { StartTime = HH.ToString() + ":" + mm.ToString(); }

                time_book.Attributes.Add("min", StartTime.ToString());
                //time_book.Value = StartTime.ToString();

                string EndTime = "20:00";
                time_book.Attributes.Add("max", EndTime.ToString());

                bl = true;
            }
            catch
            {
                bl = false;
            }

            return bl;
        }

        public Boolean NamePrefix()
        {
            Boolean bl = false;

            sql = "select * from nameprefix where np_active = 'Yes' ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                DD_pname.DataSource = dt;
                DD_pname.DataTextField = "np_full";
                DD_pname.DataValueField = "np_initial";
                DD_pname.DataBind();
            }

            return bl;
        }

        protected void CLD_book_DayRender(object sender, DayRenderEventArgs e)
        {
            DateTime DateNow = DateTime.Now.Date;
            if (e.Day.Date < DateNow)
            {
                e.Day.IsSelectable = false;
                
                e.Cell.ForeColor = Color.LightGray;
            }
            else
            {
                e.Cell.ForeColor = Color.DarkGreen;
                e.Cell.BorderColor = Color.LightGray;
            }
        }

        protected void CLD_book_SelectionChanged(object sender, EventArgs e)
        {
            txt_date.Value = CLD_book.SelectedDate.ToString("yyyy-MM-dd");
        }

        public Boolean CheckInput()
        {
            Boolean bl = false;

            string dateBook = CLD_book.SelectedDate.ToString();
            string timeBook = time_book.Value.ToString();

            return bl;
        }
    }
}