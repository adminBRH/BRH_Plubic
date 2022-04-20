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
    public partial class Transfer : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DepartmentFrom();
            }
        }

        protected void DepartmentFrom()
        {
            sql = "select * from department_service where ds_active='yes' and ds_clinic = 'yes' " +
                "order by ds_desc; ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {

            }
            dd_department.DataSource = dt;
            dd_department.DataTextField = "ds_desc";
            dd_department.DataValueField = "ds_id";
            dd_department.DataBind();
            dd_department.Items.Insert(0, new ListItem("กรุณาเลือก แผนก", ""));
        }

        protected void DepartmentTo(string deptFrom)
        {
            sql = "select * from department_service where ds_active='yes' and ds_clinic = 'yes' " +
                "and ds_id <> '" + deptFrom + "' " +
                "order by ds_desc; ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            { }
            dd_departmentTo.DataSource = dt;
            dd_departmentTo.DataTextField = "ds_desc";
            dd_departmentTo.DataValueField = "ds_id";
            dd_departmentTo.DataBind();
            dd_departmentTo.Items.Insert(0, new ListItem("กรุณาเลือก แผนก", ""));
        }

        protected void dd_department_SelectedIndexChanged(object sender, EventArgs e)
        {
            string deptFrom = dd_department.SelectedValue.ToString();
            DepartmentTo(deptFrom);
        }
    }
}