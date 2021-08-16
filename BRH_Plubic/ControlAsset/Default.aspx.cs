using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;

namespace BRH_Plubic.ControlAsset
{
    public partial class Default : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userid"] == null)
            {
                Response.Redirect("../Default.aspx?back=ControlAsset&login=require");
            }
            else
            {
                if (!IsPostBack)
                {
                    Department();
                }
            }
        }

        public void Department()
        {
            sql = "select * from v_alldepartment where emp_deptid <> ''; ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            { }

            DD_dept.DataSource = dt;
            DD_dept.DataTextField = "emp_deptdesc";
            DD_dept.DataValueField = "emp_deptid";
            DD_dept.DataBind();
        }

        protected void btn_check_ServerClick(object sender, EventArgs e)
        {
            string scModal = "";
            string alert = "";

            string SN = txt_SN.Value.ToString().Trim();

            if (SN == "")
            {
                scModal = "<script>alertModalInfo('','กรุณากรอก SN !!');</script>";
            }
            else
            {
                string username = Session["name"].ToString();
                string deptname = DD_dept.SelectedItem.Text;

                
                sql = "Select * from (" +
                    "\nselect 'Laptop' as 'asset_cate',asset_serial_number,asset_department from asset_laptop " +
                    "\nunion " +
                    "\nselect 'Desktop' as 'asset_cate',asset_serial_number,asset_location from asset_desktop " +
                    "\n) as a " +
                    "\nwhere replace(a.asset_serial_number,'-','') = replace('" + SN + "','-',''); ";
                dt = new DataTable();
                dt = cl_Sql.select(sql);
                if (dt.Rows.Count > 0)
                {
                    alert = "<b>ประเภททรัพย์สิน : </b>" + dt.Rows[0]["asset_cate"].ToString();
                    alert = alert + "<br />";
                    alert = alert + "<b>อยู่ในความดูแลของ : </b>" + dt.Rows[0]["asset_department"].ToString();
                    alert = alert + "<br /><br />";
                    alert = alert + "<b>ดำเนินการโดย : </b>" + username;
                    alert = alert + "<br />";
                    alert = alert + "<b>หน่วยงาน/แผนก : </b>" + deptname;
                    lbl_asset.ForeColor = System.Drawing.Color.Blue;
                }
                else
                {
                    CB_ct_check.Value = "add";

                    alert = "ไม่พบ Service Tag [<b>" + SN + "</b>] นี้ในระบบ !!";
                    alert = alert + "<br /><br />";
                    alert = alert + "<b>ดำเนินการโดย : </b>" + username;
                    alert = alert + "<br />";
                    alert = alert + "<b>หน่วยงาน/แผนก : </b>" + deptname;
                    lbl_asset.ForeColor = System.Drawing.Color.Red;
                }

                scModal = "<script>alertModal('#modalAsset');</script>";
            }

            
            lbl_asset.Text = alert;
            lbl_script.Text = scModal;
        }

        protected void btn_submit_ServerClick(object sender, EventArgs e)
        {
            string scModal = "";
            lbl_script.Text = scModal;

            string SN = txt_SN.Value.ToString().Trim();
            string dept = DD_dept.SelectedValue.ToString();
            string userid = Session["userid"].ToString();
            string action = "";
            if (CB_ct_check.Checked)
            {
                action = CB_ct_check.Value.ToString();
            }
            else if (CB_ct_return.Checked)
            {
                action = CB_ct_return.Value.ToString();
            }
            else { }

            sql = "select * from asset_return where asr_active='yes' and replace(asr_sn,'-','') = replace('" + SN + "','-',''); ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            sql = "";
            if (dt.Rows.Count > 0)
            {
                sql = "update asset_return set asr_active='no' where asr_active='yes' and replace(asr_sn,'-','') = replace('" + SN + "','-',''); ";
            }

            sql = sql + "insert into asset_return(asr_sn,asr_deptid,asr_action,asr_user) value('" + SN + "','" + dept + "','" + action + "','" + userid + "'); ";
            if (cl_Sql.Modify(sql))
            {
                txt_SN.Value = "";
                scModal = "fn_AlertModal('Success','ดำเนินการเรียบร้อยแล้ว !!','',0);";
            }
            else
            {
                scModal = "fn_AlertModal('Warning','ไม่สามารถดำเนินการได้ กรุณาติดต่อผู้ดูแลระบบ !!','',0);";
            }

            Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
        }
    }
}