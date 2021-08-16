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
    public partial class CheckSlip : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["login"] != null)
            {
                string status = Session["status"].ToString();
                if (status == "admin" || status == "finance")
                {
                    if (!IsPostBack)
                    {
                        ListStatus();
                        string find = "pay";
                        dd_status.SelectedValue = find;
                        Data(find);
                        //ClearThisScript();
                    }
                }
                else
                {
                    Response.Write("<script>alert('คุณไม่มีสิทธิ์ใช้งานหน้านี้ !!'); window.location.href='../default.aspx';</script>");
                }
            }
            else
            {
                Response.Redirect("../Default.aspx?back=VaccineCovid/CheckSlip&login=require");
            }
            
        }

        public void ClearThisScript()
        {
            lbl_modal.Text = "";
        }

        public void ListStatus()
        {
            sql = "select distinct pv_status from pay_vaccine where pv_active='yes' ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {

            }
            dd_status.DataSource = dt;
            dd_status.DataTextField = "pv_status";
            dd_status.DataValueField = "pv_status";
            dd_status.DataBind();
            dd_status.Items.Insert(0, new ListItem("ทั้งหมด", ""));
        }

        private void Data(string status)
        {
            sql = "select * from pay_vaccine where pv_active='yes' and pv_status like '%" + status + "%' order by pv_id ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {

            }

            LV_table.DataSource = dt;
            LV_table.DataBind();
        }

        protected void dd_status_SelectedIndexChanged(object sender, EventArgs e)
        {
            string status = dd_status.SelectedValue.ToString();
            ClearThisScript();
            Data(status);
        }

        private string FindKey(string id)
        {
            string key = "";

            sql = "select * from pay_vaccine where pv_id = '" + id + "' ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                key = dt.Rows[0]["pv_bvkey"].ToString(); ;
            }

            return key;
        }

        protected void btn_details_ServerClick(object sender, EventArgs e)
        {
            string id = txtH_id.Value.ToString();
            string key = FindKey(id);
            string status = dd_status.SelectedValue.ToString();

            sql = "select * from book_vaccine as bv " +
            "\nleft join customer as cm on cm.cm_cardnumber = bv.bv_cardid " +
            "\nwhere bv_key = '" + key + "' " +
            //"\nandbv_active='yes' " +
            //"\nand bv_status = '" + status + "' " +
            "\norder by bv_id ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                lbl_modal.Text = "<script> alertModal('#ModalDetail'); </script>";
                img_slip.Src = "image/slip/" + key + ".jpg";

                status = dt.Rows[0]["bv_status"].ToString();
                if (status == "pay")
                {
                    div_reject.Visible = true;
                    div_confirm.Visible = true;
                }
                else
                {
                    div_reject.Visible = false;
                    div_confirm.Visible = false;
                }
            }
            else
            {

            }
            LV_details.DataSource = dt;
            LV_details.DataBind();
        }

        protected void btn_confirm_ServerClick(object sender, EventArgs e)
        {
            string scModal = "";

            string muser = Session["userid"].ToString();

            string id = txtH_id.Value.ToString();
            string key = FindKey(id);

            sql = "update pay_vaccine set pv_status='confirm', pv_muser='" + muser + "', pv_mdate=current_timestamp where pv_id='" + id + "'; " +
                "update book_vaccine set bv_status='confirm', bv_muser='" + muser + "', bv_mdate=current_timestamp where bv_key='" + key + "'; ";
            if (cl_Sql.Modify(sql))
            {
                Response.Redirect("CheckSlip");
            }
            else
            {
                scModal = "fn_InOutAlert('Warning','ไม่สามารถบันทึกได้กรุณาติดต่อผู้ดูแลระบบ !!');";
            }

            Response.Write("<script> " + scModal + " </script>");
            //ClearThisScript();
            //Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
        }

        protected void btn_reject_ServerClick(object sender, EventArgs e)
        {
            string scModal = "";

            string muser = Session["userid"].ToString();

            string id = txtH_id.Value.ToString();
            string key = FindKey(id);
            string remark = txt_remark.Value.ToString().Trim();

            sql = "update pay_vaccine set pv_status='reject', pv_remark='" + remark + "', pv_muser='" + muser + "', pv_mdate=current_timestamp where pv_id='" + id + "'; " +
                "update book_vaccine set bv_active='no', bv_status='reject', bv_muser='" + muser + "', bv_mdate=current_timestamp where bv_key='" + key + "'; ";
            if (cl_Sql.Modify(sql))
            {
                //Response.Redirect("CheckSlip");
                scModal = "fn_AlertModal('Success','Reject success !!','CheckSlip',1000);";
            }
            else
            {
                scModal = "fn_AlertModal('Warning','ไม่สามารถบันทึกได้กรุณาติดต่อผู้ดูแลระบบ !!','',0);";
            }

            lbl_modal.Text = "<script> " + scModal + " </script>";
            //ClearThisScript();
            //Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
        }
    }
}