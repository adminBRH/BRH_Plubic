using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;

namespace BRH_Plubic.Happymoney
{
    public partial class Approve : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["login"] != null)
            {
                string status = Session["status"].ToString();
                if (status == "admin" || status == "hr")
                {
                    if (!IsPostBack)
                    {
                        Status();
                        ListData("Waiting");
                    }
                }
                else
                {
                    Response.Write("<script>alert('คุณไม่มีสิทธิ์ใช้งานหน้านี้ !!'); window.location.href='../default.aspx';</script>");
                }
            }
            else
            {
                Response.Redirect("../Default.aspx?back=Happymoney/Approve&login=require");
            }
        }

        private void Status()
        {
            string wait = "";
            sql = "select distinct mo_money_active from mon_savemoney; ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                foreach (DataRow dr in dt.Rows)
                {
                    if (dr["mo_money_active"].ToString() == "Waiting")
                    {
                        wait = "yes";
                    }
                }
            }
            DD_status.DataSource = dt;
            DD_status.DataTextField = "mo_money_active";
            DD_status.DataValueField = "mo_money_active";
            DD_status.DataBind();
            DD_status.Items.Insert(0, new ListItem("ALL", ""));

            if (wait == "yes")
            {
                DD_status.SelectedValue = "Waiting";
            }
        }

        private void ListData(string status)
        {
            sql = "select *,'' as 'mo_hidden', '' as 'mo_date_th', '' as 'mo_craetedate_th' " +
                "\nfrom mon_savemoney as ms " +
                "\nleft join employee as em on (em.emp_id=ms.mo_empid COLLATE utf8_general_ci) " +
                "\nwhere ms.mo_money_active like '%" + status + "%' " +
                "\norder by mo_id desc";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                foreach (DataRow dr in dt.Rows)
                {
                    DateTime mo_date = DateTime.Parse(dr["mo_date"].ToString());
                    dr["mo_date_th"] = mo_date.ToString("dd") + "/" + mo_date.ToString("MM") + "/" + mo_date.ToString("yyyy");
                    DateTime mo_craetedate = DateTime.Parse(dr["mo_craetedate"].ToString());
                    dr["mo_craetedate_th"] = mo_craetedate.ToString("dd") + "/" + mo_craetedate.ToString("MM") + "/" + mo_craetedate.ToString("yyyy");

                    string hidden = "";
                    if (dr["mo_money_active"].ToString() != "Waiting")
                    {
                        hidden = "hidden=\"hidden\"";
                    }
                    dr["mo_hidden"] = hidden;
                }
            }
            LV_data.DataSource = dt;
            LV_data.DataBind();
        }

        protected void btn_search_ServerClick(object sender, EventArgs e)
        {

        }

        protected void DD_status_SelectedIndexChanged(object sender, EventArgs e)
        {
            string Status = DD_status.SelectedValue.ToString();
            ListData(Status);
        }

        protected void btn_reject_ServerClick(object sender, EventArgs e)
        {
            string scModal = "";

            string id = txtH_id.Value.ToString().Trim();
            string comment = txt_comment.Value.ToString().Trim();
            if (comment == "")
            {
                comment = "No comment";
            }

            sql = "update mon_savemoney set mo_money_active = 'NoApprove', mo_commend='" + comment + "', mo_updatedate=CURRENT_TIMESTAMP " +
                "\nwhere mo_id = '" + id + "'; ";
            if (cl_Sql.Modify(sql))
            {
                scModal = "fn_AlertModal('Success','Reject success !!','Approve',1500);";
            }
            else
            {
                scModal = "fn_AlertModal('Warning','ไม่สามารถ Reject ได้ กรุณาติดต่อผู้ดูแลระบบ !!','',0);";
            }

            Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
        }

        protected void btn_approve_ServerClick(object sender, EventArgs e)
        {
            string scModal = "";

            string id = txtH_id.Value.ToString().Trim();
            string comment = txt_comment.Value.ToString().Trim();
            if (comment == "")
            {
                comment = "No comment";
            }

            sql = "update mon_savemoney set mo_money_active = 'Approve', mo_commend='" + comment + "', mo_updatedate=CURRENT_TIMESTAMP " +
                "\nwhere mo_id = '" + id + "'; ";
            if (cl_Sql.Modify(sql))
            {
                scModal = "fn_AlertModal('Success','Approve success !!','Approve',1000);";
            }
            else
            {
                scModal = "fn_AlertModal('Warning','ไม่สามารถ Approve ได้ กรุณาติดต่อผู้ดูแลระบบ !!','',0);";
            }

            Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
        }
    }
}