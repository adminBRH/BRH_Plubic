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
    public partial class AssetType : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        string UserLogin = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userid"] != null)
            {
                UserLogin = Session["userid"].ToString();
                if (!IsPostBack)
                {
                    Branch();
                    Department("");
                }
                ListViewAssetType();
            }
            else
            {
                Response.Redirect("../Default.aspx?back=AssetControl/AssetType&login=require");
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

        protected void DD_branch_SelectedIndexChanged(object sender, EventArgs e)
        {
            string br = DD_branch.SelectedValue.ToString();
            Department(br);
        }

        public void ListViewAssetType()
        {
            sql = "select * from asset_type where ast_active='yes' order by ast_name; ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                int i = 1;
                foreach (DataRow dr in dt.Rows)
                {
                    if (dt.Rows.IndexOf(dr) == 0)
                    {
                        dt.Columns.Add("ast_index", typeof(string));
                    }
                    dr["ast_index"] = i.ToString();
                    i++;
                }
            }
            else
            {

            }

            LV_AssetTyep.DataSource = dt;
            LV_AssetTyep.DataBind();
        }

        protected Boolean DuplicateType(string typename)
        {
            Boolean bl = true;

            sql = "select * from asset_type where ast_active='yes' and ast_name like '%" + typename + "%'; ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                bl = false;
            }

            return bl;
        }

        private string InsertNewType(string typename, string br, string dept)
        {
            string result = "";

            sql = "Insert into asset_type(ast_name,ast_ds_branch,ast_dept,ast_cuser) value('" + typename + "','" + br + "','" + dept + "','" + UserLogin + "'); ";
            if (cl_Sql.Modify(sql))
            {
                result = cl_Sql.LastID("ast_id", "asset_type");
            }

            return result;
        }

        protected void btn_addtype_ServerClick(object sender, EventArgs e)
        {
            string alert = "";

            lbl_alertnewtype.ForeColor = System.Drawing.Color.Red;

            string typename = txt_typename.Value.ToString().Trim();
            string br = DD_branch.SelectedValue.ToString();
            string dept = DD_department.SelectedValue.ToString();

            if (typename != "" && br != "" && dept != "")
            {
                if (DuplicateType(typename))
                {
                    string NewID = InsertNewType(typename, br, dept);
                    if (NewID != "")
                    {
                        alert = "Success !!";
                        lbl_alertnewtype.ForeColor = System.Drawing.Color.Blue;
                    }
                    else
                    {
                        alert = "Can't insert please contact Administrator !!";
                    }
                }
                else
                {
                    alert = "Duplicate item !!";
                }
                
            }
            else
            {
                alert = "กรุณากรอกข้อมูลให้ครบถ้วน !!";
            }
            lbl_alertnewtype.Text = alert;

            if (alert == "Success !!")
            {
                //scModal = "fn_WaitLoadModal();";
                //Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);

                System.Threading.Thread.Sleep(1500);
                Response.Redirect("AssetType");
            }
        }

    }
}