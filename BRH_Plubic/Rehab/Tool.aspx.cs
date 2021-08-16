using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;

namespace BRH_Plubic.Rehab
{
    public partial class Tool : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["login"] != null)
            {
                string status = Session["status"].ToString();
                if (status == "admin" || status == "rehab")
                {
                    if (!IsPostBack)
                    {
                        ListTool("yes");
                    }
                }
                else
                {
                    Response.Write("<script>alert('คุณไม่มีสิทธิ์ใช้งานหน้านี้ !!'); window.location.href='../default.aspx';</script>");
                }
            }
            else
            {
                Response.Redirect("../Default.aspx?back=Rehab/Tool&login=require");
            }
            
        }

        public void ListTool(string active)
        {
            sql = "select * ,if(rb.OnJob is null,0,rb.OnJob) as QtyOnJob " +
                "\nfrom rehab_tool as rt " +
                "\nleft join (" +
                "\n select rhb_rhtid as rhtid,count(*) as OnJob from rehab_book as rb " +
                "\n where rhb_active = 'yes' " +
                "\n and(rhb_timest <= current_timestamp and current_timestamp <= rhb_timeen) " +
                "\n group by rhb_rhtid " +
                ") as rb on rb.rhtid = rt.rht_id " +
                "\nwhere rht_active='" + active + "' " +
                "\norder by rht_id ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            { }

            LV_list.DataSource = dt;
            LV_list.DataBind();
        }

        protected void cbs_active_CheckedChanged(object sender, EventArgs e)
        {
            string active = "";
            if (cbs_active.Checked)
            {
                active = "yes";
            }
            else
            {
                active = "no";
            }
            ListTool(active);
        }

        protected void btn_add_ServerClick(object sender, EventArgs e)
        {
            string scModal = "";

            string toolname = txt_toolname.Value.ToString().Trim();
            string qty = num_toolqty.Value.ToString();

            string empid = Session["userid"].ToString();

            sql = "select * from rehab_tool where rht_name = '" + toolname + "'; ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                scModal = "fn_AlertModal('Warning','ชื่อเครื่องมือนี้มีในระบบอยู่แล้ว !!','',0);";
            }
            else
            {
                sql = "insert into rehab_tool(rht_name,rht_qty,rht_cuser) values('" + toolname + "','" + qty + "','" + empid + "'); ";
                if (cl_Sql.Modify(sql))
                {
                    scModal = "fn_AlertModal('Success','Success !!','/Rehab/Tool',1500);";
                }
                else
                {
                    scModal = "fn_AlertModal('Warning','ไม่สามารถบันทึกได้ กรุณาติดต่อผู้ดูแลระบบ !!','',0);";
                }
            }

            Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
        }

        protected void btn_SelectEdit_ServerClick(object sender, EventArgs e)
        {
            string scModal = "";

            string rhtid = txt_id.Value.ToString();
            sql = "select * from rehab_tool where rht_id = '" + rhtid + "'; ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                txt_edit_toolname.Value = dt.Rows[0]["rht_name"].ToString();
                num_edit_toolqty.Value = dt.Rows[0]["rht_qty"].ToString();
                string active = dt.Rows[0]["rht_active"].ToString();
                if (active == "yes")
                {
                    cb_active.Checked = true;
                }
                else
                {
                    cb_active.Checked = false;
                }
            }
            else
            {
                scModal = "fn_AlertModal('Warning','ไม่พบข้อมูล กรุณาติดต่อผู้ดูแลระบบ !!','',0);";
            }

            Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
        }

        protected void btn_edit_ServerClick(object sender, EventArgs e)
        {
            string scModal = "";

            string rhtid = txt_id.Value.ToString();
            string toolname = txt_edit_toolname.Value.ToString().Trim();
            string qty = num_edit_toolqty.Value.ToString();
            string active = "yes";
            if (cb_active.Checked == false)
            {
                active = "no";
            }

            string empid = Session["userid"].ToString();

            sql = "update rehab_tool set rht_active='" + active + "', rht_name='" + toolname + "',rht_qty='" + qty + "',rht_muser='" + empid + "',rht_mdate=current_timestamp() " +
                "\nwhere rht_id='" + rhtid + "' ";
            if (cl_Sql.Modify(sql))
            {
                scModal = "fn_AlertModal('Success','Success !!','/Rehab/Tool',1500);";
            }
            else
            {
                scModal = "fn_AlertModal('Warning','ไม่สามารถแก้ไขข้อมูลได้ กรุณาติดต่อผู้ดูแลระบบ !!','',0);";
            }

            Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
        }
    }
}