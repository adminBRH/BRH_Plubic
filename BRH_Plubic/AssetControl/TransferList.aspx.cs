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
    public partial class TransferList : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();
        ClassEmail cl_email = new ClassEmail();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userid"] == null)
            {
                Response.Redirect("../Default.aspx?back=AssetControl/TransferList&login=require");
            }
            else
            {
                if (!IsPostBack)
                {
                    string astid = "";
                    if (Request.QueryString["id"] != null)
                    {
                        astid = Request.QueryString["id"].ToString();
                    }
                    string user = Session["userid"].ToString();
                    string date = "";
                    string fromDept = "";
                    string toDept = "";
                    string fromAction = "";
                    string ToAction = "";
                    ListTransfer(astid, user, date, fromDept, toDept, fromAction, ToAction);

                    DateDropDown();
                }
            }
        }

        protected void Search()
        {
            string astid = "";
            if (Request.QueryString["id"] != null)
            {
                astid = Request.QueryString["id"].ToString();
            }
            string user = Session["userid"].ToString();
            string date = DD_date.SelectedValue.ToString();
            string fromDept = "";
            string toDept = "";
            string fromAction = "";
            string ToAction = "";
            ListTransfer(astid, user, date, fromDept, toDept, fromAction, ToAction);
        }

        protected void ListTransfer(string astid,string user, string date,string fromDept, string toDept,string fromAction, string ToAction)
        {
            if (Session["status"].ToString() == "admin")
            {
                user = "";
            }

            string WhereAstID = "";
            if (astid != "")
            {
                WhereAstID = "and ast_id = '" + astid + "'";
            }

            if (date != "")
            {
                date = DateTime.Parse(date).ToString("yyyy-MM-dd");
            }

            sql = "SELECT ast.*, emp.emp_pname_th, ifnull(emp.emp_fname_th,'IT') as 'emp_fname_th', ifnull(emp.emp_lname_th,'Clinic') as 'emp_lname_th', " +
                "\nifnull(concat(emp2.emp_pname_th,' ',emp2.emp_fname_th,' ',emp2.emp_lname_th),'IT Clinic') as 'from_hod_name_th', " +
                "\nconcat(emp3.emp_pname_th,' ',emp3.emp_fname_th,' ',emp3.emp_lname_th) as 'to_hod_name_th', " +
                "\ndfrom.deptname as deptFrom, dto.deptname as deptTo " +
                "\nFROM `asset_transfer` as ast " +
                "\nleft join employee as emp on emp.emp_id COLLATE utf8_general_ci = ast.ast_from_user " +
                "\nleft join employee as emp2 on emp2.emp_id COLLATE utf8_general_ci = ast.ast_from_hod " +
                "\nleft join employee as emp3 on emp3.emp_id COLLATE utf8_general_ci = ast.ast_to_hod " +
                "\nleft join department as dfrom on dfrom.deptid COLLATE utf8_general_ci = ast.ast_from_dept " +
                "\nleft join department as dto on dto.deptid COLLATE utf8_general_ci = ast.ast_to_dept " +
                "\nwhere ast_active = 'yes' " + WhereAstID + " and convert(ast_from_date, date) like '%" + date + "%' " +
                "\nand ast_from_dept like '%" + fromDept + "%' and ast_to_dept like '%" + toDept + "%' " +
                "\nand ast_from_action like '%" + fromAction + "%' and ast_to_action like '%" + ToAction + "%' " +
                "\nand (ast_from_user like '%" + user + "%' or ast_from_hod like '%" + user + "%' or ast_to_hod like '%" + user + "%') " +
                "\norder by ast_id";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            { }

            LV_Transfer.DataSource = dt;
            LV_Transfer.DataBind();
        }

        protected void DateDropDown()
        {
            sql = "select distinct convert(ast_from_date, date) as 'ast_from_date' from asset_transfer where ast_active = 'yes'; ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {

            }
            DD_date.DataSource = dt;
            DD_date.DataTextField = "ast_from_date";
            DD_date.DataTextFormatString  = " {0:yyyy-MM-dd} ";
            DD_date.DataValueField = "ast_from_date";
            DD_date.DataBind();
            DD_date.Items.Insert(0, new ListItem("ทั้งหมด", ""));
        }

        protected void btn_details_ServerClick(object sender, EventArgs e)
        {
            string id = txtH_details.Value.ToString().Trim();
            if (id != "")
            {
                string alert = "";
                sql = "select * from asset_details where asd_id in (" + id + ") ";
                dt = new DataTable();
                dt = cl_Sql.select(sql);
                if (dt.Rows.Count > 0)
                {
                    foreach (DataRow dr in dt.Rows) 
                    {
                        alert += "<b>[" + dr["asd_sn"].ToString() + "]</b> : " + dr["asd_displayname"].ToString() + "<br />";
                    }
                    div_detais_id.Attributes.Add("hidden","hidden");
                    div_details_list.Attributes.Remove("hidden");
                }
                else
                {
                    alert = "ไม่พบข้อมูล !!";
                }

                div_details_btn.Attributes.Add("hidden","hidden");

                lbl_details_list.Text = alert;
            }
        }

        protected Boolean CheckPermission(string action)
        {
            Boolean bl = false;
            
            if (Session["status"].ToString() == "admin")
            {
                bl = true;
            }
            else
            {
                if (action == "to")
                {
                    string user = Session["userid"].ToString();
                    sql = "select * from asset_transfer where ast_to_hod = '" + user + "'; ";
                    dt = new DataTable();
                    dt = cl_Sql.select(sql);
                    if (dt.Rows.Count > 0)
                    {
                        bl = true;
                    }
                }
            }

            return bl;
        }

        protected void ClearReserve(string detailID)
        {
            // Status 1 = In Use
            sql = "update asset_details set asd_status = '1', asd_transfer_dept = null where asd_id in (" + detailID + ");";
            cl_Sql.Modify(sql);
        }
        
        protected void UseReserve(string detailsID, string dept)
        {
            // Status 1 = In Use
            sql = "update asset_details set asd_status = '1', asd_transfer_dept = null, asd_dept = '" + dept + "' where asd_id in (" + detailsID + ");";
            cl_Sql.Modify(sql);
        }

        protected void btn_reject_ServerClick(object sender, EventArgs e)
        {
            string scModal = "";
            string action = txtH_action.Value.ToString().Trim();
            if (CheckPermission(action))
            {
                string id = txtH_id.Value.ToString();
                string remark = txt_remark.Value.ToString().Trim();

                string sendMail = "";

                if (action == "from")
                {
                    sql = "update asset_transfer set ast_from_hod_remark = '" + remark + "' " +
                        "\n,ast_from_action = 'reject', ast_from_action_date = CURRENT_TIMESTAMP " +
                        "\nwhere ast_id = '" + id + "'; ";
                    if (cl_Sql.Modify(sql))
                    {
                        sendMail = "yes";
                    }
                }
                else if (action == "to")
                {
                    sql = "update asset_transfer set ast_to_hod_remark = '" + remark + "' " +
                        "\n,ast_to_action = 'reject', ast_to_action_date = CURRENT_TIMESTAMP " +
                        "\nwhere ast_id = '" + id + "'; ";
                    if (cl_Sql.Modify(sql))
                    {
                        sendMail = "yes";
                    }
                }
                else
                { }

                if (sendMail == "yes")
                {
                    sql = "select * from asset_transfer where ast_id = '" + id + "'; ";
                    dt = new DataTable();
                    dt = cl_Sql.select(sql);
                    if (dt.Rows.Count > 0)
                    {
                        string detailID = dt.Rows[0]["ast_asdid_array"].ToString();

                        sql = "select * from employee where emp_id = '" + dt.Rows[0]["ast_from_user"].ToString() + "'; ";
                        dt = new DataTable();
                        dt = cl_Sql.select(sql);
                        if (dt.Rows.Count > 0)
                        {
                            string mailTo = dt.Rows[0]["emp_email"].ToString();
                            string subject = "รายการโอนย้ายทรัพย์สินของคุณ เอกสารเลขที่ " + id;
                            string body = "<br /><b>ไม่ได้รับการอนุมัติโอนย้ายทรัพย์สิน</b>" +
                                "<br />Link: <a href=\"" + Request.UserHostAddress + Request.Path + "?id=" + id + "\"> " + Request.UserHostAddress + Request.Path + "?id=" + id + " </a>" +
                                "<br /><br /><br />อีเมลฉบับนี้เป็นอีเมลอัตโนมัติ ไม่สามารถตอบกลับได้";
                            if (cl_email.Send(mailTo, subject, body))
                            {
                                Search();
                            }
                        }

                        ClearReserve(detailID);
                    }

                    Search();
                }

                scModal = "$('Modal_WaitLoad').modal('hide');";
            }
            else
            {
                scModal = "$('Modal_WaitLoad').modal('hide'); fn_AlertModal('Warning','คุณไม่มีสิทธิ์กระทำการในส่วนนี้ !!','',0);";
            }
            Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
        }

        protected void btn_approve_ServerClick(object sender, EventArgs e)
        {
            string scModal = "";
            string action = txtH_action.Value.ToString().Trim();
            if (CheckPermission(action))
            {
                string id = txtH_id.Value.ToString();
                string remark = txt_remark.Value.ToString().Trim();

                if (action == "from")
                {
                    sql = "select * from asset_transfer where ast_id = '" + id + "'; ";
                    dt = new DataTable();
                    dt = cl_Sql.select(sql);
                    if (dt.Rows.Count > 0)
                    {
                        string userRequest = dt.Rows[0]["ast_from_user"].ToString();
                        string deptTO = dt.Rows[0]["ast_to_dept"].ToString();

                        sql = "select * from department where deptid = '" + deptTO + "'; ";
                        dt = new DataTable();
                        dt = cl_Sql.select(sql);
                        if (dt.Rows.Count > 0)
                        {
                            string hod1 = dt.Rows[0]["depthod1"].ToString();
                            string mailTo = dt.Rows[0]["email_hod1"].ToString();

                            sql = "update asset_transfer set ast_from_hod_remark = '" + remark + "' " +
                                "\n,ast_from_action = 'approve', ast_from_action_date = CURRENT_TIMESTAMP " +
                                "\n,ast_to_hod = '" + hod1 + "', ast_to_action = 'transfer' " +
                                "\nwhere ast_id = '" + id + "'; ";
                            if (cl_Sql.Modify(sql))
                            {
                                string subject = "รายการโอนย้ายทรัพย์สิน เอกสารเลขที่ " + id;
                                string body = "<br /><b>มีคำร้องขอ รออนุมัติการโอนย้ายทรัพย์สิน</b>" +
                                    "<br />Link: <a href=\"" + Request.UserHostAddress + Request.Path + "?id=" + id + "\"> " + Request.UserHostAddress + Request.Path + "?id=" + id + " </a>" +
                                    "<br /><br /><br />อีเมลฉบับนี้เป็นอีเมลอัตโนมัติ ไม่สามารถตอบกลับได้";
                                if (cl_email.Send(mailTo, subject, body))
                                {
                                    sql = "select * from employee where emp_id = '" + userRequest + "'; ";
                                    dt = new DataTable();
                                    dt = cl_Sql.select(sql);
                                    if (dt.Rows.Count > 0)
                                    {
                                        mailTo = dt.Rows[0]["emp_email"].ToString();
                                        subject = "รายการโอนย้ายทรัพย์สินของคุณ เอกสารเลขที่ " + id;
                                        body = "<br /><b>ได้รับการอนุมัติโอนย้ายทรัพย์สิน จากเจ้าหน้าที่ IT Clinic แล้ว</b>" +
                                            "<br />Link: <a href=\"" + Request.UserHostAddress + Request.Path + "?id=" + id + "\"> " + Request.UserHostAddress + Request.Path + "?id=" + id + " </a>" +
                                            "<br /><br /><br />อีเมลฉบับนี้เป็นอีเมลอัตโนมัติ ไม่สามารถตอบกลับได้";
                                        cl_email.Send(mailTo, subject, body);
                                    }
                                }
                                Search();
                            }
                        }
                    }
                }
                else if (action == "to")
                {
                    sql = "update asset_transfer set ast_to_hod_remark = '" + remark + "' " +
                        "\n,ast_to_action = 'approve', ast_to_action_date = CURRENT_TIMESTAMP " +
                        "\nwhere ast_id = '" + id + "'; ";
                    if (cl_Sql.Modify(sql))
                    {
                        sql = "select * from asset_transfer where ast_id = '" + id + "'; ";
                        dt = new DataTable();
                        dt = cl_Sql.select(sql);
                        if (dt.Rows.Count > 0)
                        {
                            string detailID = dt.Rows[0]["ast_asdid_array"].ToString();
                            string dept = dt.Rows[0]["ast_to_dept"].ToString();

                            sql = "select * from employee where emp_id = '" + dt.Rows[0]["ast_from_user"].ToString() + "'; ";
                            dt = new DataTable();
                            dt = cl_Sql.select(sql);
                            if (dt.Rows.Count > 0)
                            {
                                string mailTo = dt.Rows[0]["emp_email"].ToString();
                                string subject = "รายการโอนย้ายทรัพย์สินของคุณ เอกสารเลขที่ " + id;
                                string body = "<br /><b>ได้รับการอนุมัติโอนย้ายเข้าแผนกปลายทาง เรียบร้อยแล้ว</b>" +
                                    "<br />Link: <a href=\"" + Request.UserHostAddress + Request.Path + "?id=" + id + "\"> " + Request.UserHostAddress + Request.Path + "?id=" + id + " </a>" +
                                    "<br /><br /><br />อีเมลฉบับนี้เป็นอีเมลอัตโนมัติ ไม่สามารถตอบกลับได้";
                                if (cl_email.Send(mailTo, subject, body))
                                {
                                    Search();
                                }
                            }
                            UseReserve(detailID, dept);
                        }
                    }
                }
                else
                { }
                scModal = "$('Modal_WaitLoad').modal('hide');";
            }
            else
            {
                scModal = "$('Modal_WaitLoad').modal('hide'); fn_AlertModal('Warning','คุณไม่มีสิทธิ์กระทำการในส่วนนี้ !!','',0);";
            }
            Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
        }

        protected void DD_date_SelectedIndexChanged(object sender, EventArgs e)
        {
            Search();
        }
    }
}