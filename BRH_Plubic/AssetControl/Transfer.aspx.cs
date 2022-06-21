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
        ClassEmail cl_email = new ClassEmail();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userid"] == null)
            {
                Response.Redirect("../Default.aspx?back=AssetControl/Transfer&login=require");
            }
            else
            {
                if (!IsPostBack)
                {
                    DepartmentFrom();
                    lbl_transferby.Text = Session["name"].ToString();
                }
            }
        }

        protected void DepartmentFrom()
        {
            string userid = Session["userid"].ToString();
            string lockdept = "";

            if (Session["status"].ToString() != "admin")
            {
                sql = "select * from employee where emp_id='" + userid + "'; ";
                dt = new DataTable();
                dt = cl_Sql.select(sql);
                if (dt.Rows.Count > 0)
                {
                    lockdept = "and deptid='" + dt.Rows[0]["emp_deptid"].ToString() + "' ";
                }
            }

            string onlyClinic = "";
            if (Session["status"].ToString() != "admin")
            {
                onlyClinic = "and deptzone is not null ";
            }

            sql = "select * from department where deptactive='yes' " + onlyClinic + lockdept + " order by deptname; ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            { }
            
            dd_department.DataSource = dt;
            dd_department.DataTextField = "deptname";
            dd_department.DataValueField = "deptid";
            dd_department.DataBind();
            dd_department.Items.Insert(0, new ListItem("กรุณาเลือก แผนก", ""));
        }

        protected void DepartmentTo(string deptFrom)
        {
            string onlyClinic = "";
            if (Session["status"].ToString() != "admin")
            {
                onlyClinic = "and deptzone is not null ";
            }

            sql = "select * from department " +
                "\nwhere deptactive='yes' and deptid like 'BRH%' " + onlyClinic +
                "\nand deptid <> '" + deptFrom + "' " +
                "\norder by deptname; ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            { }
            dd_departmentTo.DataSource = dt;
            dd_departmentTo.DataTextField = "deptname";
            dd_departmentTo.DataValueField = "deptid";
            dd_departmentTo.DataBind();
            dd_departmentTo.Items.Insert(0, new ListItem("กรุณาเลือก แผนก", ""));
        }

        protected void dd_department_SelectedIndexChanged(object sender, EventArgs e)
        {
            string deptFrom = dd_department.SelectedValue.ToString();
            DepartmentTo(deptFrom);
            ListViewFrom(deptFrom);
        }

        protected void ListViewFrom(string deptid)
        {
            string html = "";
            string lblBox1 = "";

            sql = "SELECT a.*,b.ast_logo " +
                "\nFROM asset_details as a " +
                "\nleft join asset_type as b on b.ast_id = a.asd_type " +
                "\nwhere asd_status = '1' and asd_transfer_dept is null and asd_dept = '" + deptid + "' " +
                "\norder by b.ast_cate, b.ast_id ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0) 
            {
                foreach (DataRow dr in dt.Rows)
                {

                    string asdid = dr["asd_id"].ToString();
                    html += "<div id=\"divTo_" + asdid + "\" class=\"col-5 mx-auto my-1 bg-secondary comTo\" ondrop=\"drop2(event)\" onmouseover=\"divName('divTo_" + asdid + "')\" ondragover=\"allowDrop(event)\"></div> ";
                    
                    if (lblBox1 != "") { lblBox1 += ","; }
                    lblBox1 += dr["asd_id"].ToString();
                }
            }
            if (html != "")
            {
                html = "<div class=\"row col-12 mx-auto\"> " + html + "</div>";
            }
            lbl_to.Text = html;
            lbl_box1.Text = lblBox1;

            LV_from.DataSource = dt;
            LV_from.DataBind();
        }

        protected void dd_departmentTo_SelectedIndexChanged(object sender, EventArgs e)
        {
            string deptTo = dd_departmentTo.SelectedValue.ToString();
            if (deptTo == "")
            {
                lbl_to.Visible = false;
                div_submit.Visible = false;
            }
            else
            {
                lbl_to.Visible = true;
                div_submit.Visible = true;
            }
        }

        protected Boolean CheckEmail()
        {
            Boolean bl = false;

            if (Session["status"].ToString() == "admin")
            {
                bl = true;
            }
            else
            {
                string empid = Session["userid"].ToString();

                string txtEmail = txt_email.Value.ToString().Trim();
                if (txtEmail != "")
                {
                    sql = "update employee set emp_email = '" + txtEmail + "' where emp_id = '" + empid + "'; ";
                    cl_Sql.Modify(sql);
                }
                
                sql = "select * from employee where emp_id = '" + empid + "'; ";
                dt = new DataTable();
                dt = cl_Sql.select(sql);
                if (dt.Rows.Count > 0)
                {
                    if (dt.Rows[0]["emp_email"].ToString() != "")
                    {
                        bl = true;
                    }
                }
            }

            return bl;
        }

        protected void btn_submit_ServerClick(object sender, EventArgs e)
        {
            string scModal = "";
            if (CheckEmail())
            {
                string idArray = txtH_id.Value.ToString().Trim();
                string user = Session["userid"].ToString();
                string remark = txt_remark.Value.ToString().Trim();
                string deptFrom = dd_department.SelectedValue.ToString();
                string deptTo = dd_departmentTo.SelectedValue.ToString();

                if (idArray == "")
                {
                    scModal = "fn_AlertModal('Info','Please Drag & Drop Asset !!','',0);";
                }
                else
                {
                    sql = "insert into asset_transfer(ast_asdid_array,ast_from_user,ast_from_user_remark,ast_from_dept,ast_from_hod,ast_to_dept) " +
                        "\nvalue('" + idArray + "','" + user + "','" + remark + "','" + deptFrom + "','itclinic','" + deptTo + "'); ";
                    if (cl_Sql.Modify(sql))
                    {
                        // Status 4 = Moving
                        sql = "update asset_details set asd_status = '4', asd_transfer_dept = '" + deptTo + "' where asd_id in (" + idArray + "); ";
                        if (cl_Sql.Modify(sql))
                        {
                            string iconAlert = "<span id=\"🔔\">🔔</span>";

                            sql = "select max(ast_id) as 'ast_id' from asset_transfer " +
                                "\nwhere convert(ast_from_date, date)=CURRENT_DATE and ast_asdid_array='" + idArray + "' ";
                            dt = new DataTable();
                            dt = cl_Sql.select(sql);
                            if (dt.Rows.Count > 0)
                            {
                                string astID = dt.Rows[0]["ast_id"].ToString();

                                //sql = "select * from department where deptid='" + deptFrom + "'; ";
                                //dt = new DataTable();
                                //dt = cl_Sql.select(sql);
                                //if (dt.Rows.Count > 0)
                                //{
                                //    string emailTo = dt.Rows[0]["email_hod1"].ToString();
                                //    string subject = "มีรายการโอนย้ายทรัพย์สินถูกสร้างขึ้นใหม่ เอกสารเลขที่ " + astID;
                                //    string body = "<br /><b> " + iconAlert + " กรุณาเข้าระบบเพื่อทำการรับทราบการโอนย้ายทรัพย์สิน</b>" +
                                //        "<br />Link: <a href=\"" + cl_Sql.host() + "AssetControl/TransferList?id=" + astID + "\">Go to Transfer list.</a>" +
                                //        "<br /><br /><br />อีเมลฉบับนี้เป็นอีเมลอัตโนมัติ ไม่สามารถตอบกลับได้";
                                //    cl_email.Send(emailTo, subject, body);

                                //    scModal = "fn_AlertModal('Success','Success !!','../AssetControl/Transfer',2500);";
                                //}
                                //else
                                //{
                                //    scModal = "fn_AlertModal('Info','No this department !!','',0);";
                                //}

                                string emailTo = "brh.coo@brh.co.th"; // To IT Clinic
                                string subject = "มีรายการโอนย้ายทรัพย์สินถูกสร้างขึ้นใหม่ เอกสารเลขที่ " + astID;
                                string body = "<br /><b> " + iconAlert + " กรุณาเข้าระบบเพื่อทำการรับทราบการโอนย้ายทรัพย์สิน</b>" +
                                    "<br />Link: <a href=\"" + cl_Sql.host() + "AssetControl/TransferList?id=" + astID + "\">Go to Transfer list.</a>" +
                                    "<br /><br /><br />อีเมลฉบับนี้เป็นอีเมลอัตโนมัติ ไม่สามารถตอบกลับได้";
                                cl_email.Send(emailTo, subject, body);

                                scModal = "fn_AlertModal('Success','Success !!','../AssetControl/Transfer',2500);";
                            }
                            else
                            {
                                scModal = "fn_AlertModal('Warning','Find not found document number !!','',0);";
                            }
                        }
                        else
                        {
                            scModal = "fn_AlertModal('Warning','Unable to reserve assets !!','',0);";
                        }
                    }
                    else
                    {
                        scModal = "fn_AlertModal('Warning','Can't insert data !!','',0);";
                    }
                }
            }
            else
            {
                scModal = "$('#modalEmail').modal('show');";
            }

            Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
        }
    }
}