using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;

namespace BRH_Plubic.CHK
{
    public partial class ModernaList : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            GridData();
        }

        private void GridData()
        {
            sql = "select cm.ce_empid, cm.ce_name_th, cm.ce_vaccine, br.br_datetime " +
                "\nfrom bookingdetail as bd " +
                "\nleft join bookingrecord as br on br.br_id = bd.bd_brid " +
                "\nleft join company_employee as cm on cm.ce_empid = bd.bd_value " +
                "\nwhere br.br_bsid = '59' and br.br_active = 'yes' and bd.bd_column = 'หมายเลขบัตรประชาชน' and cm.ce_active='yes'; ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {

            } 

            Grid1.DataSource = dt;
            Grid1.DataBind();
        }
    }
}