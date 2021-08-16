using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;

namespace BRH_Plubic.VaccineCovid
{
    public partial class Counter : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        VaccineClass cl_Invent = new VaccineClass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ShowInvent();
            }
        }

        private void ShowInvent()
        {
            int[] ar = cl_Invent.CountDose();
            lbl_doseTotal.Text = ar[0].ToString();
            lbl_book.Text = ar[1].ToString();
            lbl_invent.Text = ar[2].ToString();
        }
    }
}