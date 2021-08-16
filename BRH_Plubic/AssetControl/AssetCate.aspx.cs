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
    public partial class AssetCate : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userid"] != null)
            {
                if (!IsPostBack)
                {
                    ListView_Category();
                    Branch();
                    Department("");
                }
            }
            else
            {
                Response.Redirect("../Default.aspx?back=AssetControl/AssetCate&login=require");
            }
        }

        private void Branch()
        {
            sql = "select * from branch where br_active='yes' order by br_id; ";
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {

            }
            DD_branch.DataSource = dt;
            DD_branch.DataValueField = "br_id";
            DD_branch.DataTextField = "br_name";
            DD_branch.DataBind();
            DD_branch.Items.Insert(0, new ListItem("เลือก รพ.", ""));
        }

        private void Department(string br)
        {
            string ALL = "";
            sql = "select * from department_service where ds_active='yes' and ds_branch = '" + br + "' " +
                "\norder by ds_branch,ds_desc";
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                ALL = "yes";
            }
            DD_department.DataSource = dt;
            DD_department.DataValueField = "ds_id";
            DD_department.DataTextField = "ds_desc";
            DD_department.DataBind();
            DD_department.Items.Insert(0, new ListItem("เลือก แผนก", ""));
            if (ALL == "yes")
            {
                DD_department.Items.Insert(1, new ListItem("ใช้กับทุกแผนก", "ALL"));
            }
        }

        public void ListView_Category()
        {
            sql = "select * from asset_cate where asc_active='yes'; ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {

            }
            LV_Cate.DataSource = dt;
            LV_Cate.DataBind();
        }

        protected void DD_branch_SelectedIndexChanged(object sender, EventArgs e)
        {
            string br = DD_branch.SelectedValue.ToString();
            Department(br);
        }

        protected void btn_addcate_ServerClick(object sender, EventArgs e)
        {
            string alert = "";

            lbl_alertAdd.ForeColor = System.Drawing.Color.Red;

            string cuser = Session["userid"].ToString();
            string br = DD_branch.SelectedValue.ToString();
            string dept = DD_department.SelectedValue.ToString();
            string cateName = txt_catename.Value.ToString().Trim();

            if (br == "" || dept == "" || cateName == "")
            {
                alert = "กรุณากรอกข้อมูลให้ครบถ้วน !!";
            }
            else
            {
                sql = "insert into asset_cate(asc_name,asc_cuser,asc_branch,asc_dept) value('" + cateName + "','" + cuser + "','" + br + "','" + dept + "');";
                if (cl_Sql.Modify(sql))
                {
                    lbl_alertAdd.Text = "Success !!";
                    lbl_alertAdd.ForeColor = System.Drawing.Color.Blue;
                    Response.Redirect("AssetCate");
                }
                else
                {
                    alert = "Can't insert please contact administrator.";
                }
            }
            lbl_alertAdd.Text = alert;
        }
    }
}