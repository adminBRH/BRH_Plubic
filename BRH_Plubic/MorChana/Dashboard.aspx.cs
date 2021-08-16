using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;
using System.IO;
using System.Drawing;

namespace BRH_Plubic.MorChana
{
    public partial class Dashboard : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userid"] == null)
            {
                Response.Redirect("../Default.aspx?back=MorChana/Dashboard&login=require");
            }
            else
            {
                string empStatus = Session["status"].ToString();
                if (empStatus == "admin" || empStatus == "brh" || empStatus == "hod")
                {
                    if (!IsPostBack)
                    {
                        AllQtyColor("", DateTime.Now.ToString("yyyy-MM-dd"));
                        Department();
                    }
                }
                else
                {
                    string scModal = "fn_AlertModal('Warning','คุณไม่มีสิทธิ์ใช้งานในหน้านี้ !!','../Default.aspx',2000);";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
                }
            }
        }

        public void Department()
        {
            sql = "select 3 as num,emp_group,emp_deptid,concat(emp_group,' ',emp_deptdesc) as 'emp_deptdesc' from employee " +
                "\ngroup by emp_group,emp_deptid,concat(emp_group, ' ', emp_deptdesc) " +
                "\nunion select 2 as num,os_group,os_deptid,concat(os_group,' ',os_deptname) as 'emp_deptdesc' from outsource  " +
                "\nunion select 1 as num,'','doctor','หมอทั้งหมด' " +
                "\nunion select 0 as num,'','','ภาพรวมโรงพยาบาล' " +
                "\norder by emp_group,emp_deptdesc ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {

            }

            DD_dept.DataSource = dt;
            DD_dept.DataTextField = "emp_deptdesc";
            DD_dept.DataValueField = "emp_deptid";
            DD_dept.DataBind();
        }

        public void AllQtyColor(string dept, string date)
        {
            string empInDept = "";
            if (dept == "")
            {
                empInDept = "";
            }
            else if (dept == "doctor")
            {
                empInDept = "and mc_empstatus = '" + dept + "'";
            }
            else
            {
                empInDept = "and mc_empid in (select emp_id from employee where emp_deptid like '%" + dept + "%' union select os_id from outsource where os_deptid like '%" + dept + "%')";
            }

            sql = "select count(mc_id) as 'mc_qty',mc_color,convert(mc_datetime, date) as 'mc_date' from morchana " +
                "\nwhere mc_active = 'yes' and convert(mc_datetime, date) = '" + date + "' " + empInDept + " " +
                "\ngroup by mc_color,convert(mc_datetime, date); ";

            lbl_QtyGreen.Text = "";
            lbl_QtyYellow.Text = "";
            lbl_QtyOrange.Text = "";
            lbl_QtyRed.Text = "";

            int Total = 0;

            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                DateTime datetimes = DateTime.Parse(dt.Rows[0]["mc_date"].ToString());
                string DateThai = datetimes.ToString("dd") + " " + datetimes.ToString("MMMM") + " " + datetimes.ToString("yyyy");//(int.Parse(datetimes.ToString("yyyy"))+543).ToString();
                lbl_datetime.Text = DateThai;

                foreach (DataRow dr in dt.Rows)
                {
                    string Qty = dr["mc_qty"].ToString();
                    string Color = dr["mc_color"].ToString();

                    Total = Total + int.Parse(Qty);

                    switch (Color)
                    {
                        case "green":
                            lbl_QtyGreen.Text = Qty + "<br />คน";
                            break;
                        case "yellow":
                            lbl_QtyYellow.Text = Qty + "<br />คน";
                            break;
                        case "orange":
                            lbl_QtyOrange.Text = Qty + "<br />คน";
                            break;
                        case "red":
                            lbl_QtyRed.Text = Qty + "<br />คน";
                            break;
                        default:
                            break;
                    }
                }
            }
            else
            {
                
            }

            lbl_total.Text = Total.ToString();

            GenderColor(dept, date);

            Details(dept, date);
        }

        public void GenderColor(string dept, string date)
        {
            string whereDept = "";
            if (dept == "")
            {

            }
            else if (dept == "Doctor")
            {
                whereDept = "and mc_empstatus='doctor' ";
            }
            else
            {
                whereDept = "and mc_empid in (select emp_id from employee where emp_deptid like '%" + dept + "%' union select os_id from outsource where os_deptid like '%" + dept + "%') ";
            }

            lbl_man_green.Text = "";lbl_man_yellow.Text = "";lbl_man_orange.Text = "";lbl_man_red.Text = "";
            lbl_woman_green.Text = "";lbl_woman_yellow.Text = "";lbl_woman_orange.Text = "";lbl_woman_red.Text = "";

            img_man_green.Visible = false;
            img_man_yellow.Visible = false;
            img_man_orange.Visible = false;
            img_man_red.Visible = false;

            img_woman_green.Visible = false;
            img_woman_yellow.Visible = false;
            img_woman_orangew.Visible = false;
            img_woman_red.Visible = false;

            sql = "select mc_gender,mc_color,count(mc_empid) as 'mc_qty' from morchana " +
                "\nwhere mc_active='yes' and convert(mc_datetime, date) = '" + date + "' " + whereDept +
                "\ngroup by mc_gender,mc_color; ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                foreach (DataRow dr in dt.Rows)
                {
                    string Gender = dr["mc_gender"].ToString();
                    string Color = dr["mc_color"].ToString();
                    string Qty = dr["mc_qty"].ToString();

                    if (Gender == "male")
                    {
                        switch (Color)
                        {
                            case "green": lbl_man_green.Text = Qty; img_man_green.Visible = true; break;
                            case "yellow": lbl_man_yellow.Text = Qty; img_man_yellow.Visible = true; break;
                            case "orange": lbl_man_orange.Text = Qty; img_man_orange.Visible = true; break;
                            case "red": lbl_man_red.Text = Qty; img_man_red.Visible = true; break;
                            default: break;
                        }
                    }
                    else
                    {
                        switch (Color)
                        {
                            case "green": lbl_woman_green.Text = Qty; img_woman_green.Visible = true; break;
                            case "yellow": lbl_woman_yellow.Text = Qty; img_woman_yellow.Visible = true; break;
                            case "orange": lbl_woman_orange.Text = Qty; img_woman_orangew.Visible = true; break;
                            case "red": lbl_woman_red.Text = Qty; img_woman_red.Visible = true; break;
                            default: break;
                        }
                    }
                }
            }
        }

        public void Details(string dept,string date)
        {
            string WhereDate = "and convert(mc_datetime, date) = '" + date + "' ";

            if (dept == "")
            {
                sql = "select *,'' as 'emp_name' from morchana where mc_active='yes' and mc_id='0' " + WhereDate + "; ";
            }
            else if (dept == "doctor")
            {
                sql = "select mc.*,dr.drs_fullname as 'emp_name' " +
                    "\nfrom morchana as mc " +
                    "\nleft join doctors as dr on dr.drs_id=mc.mc_empid " +
                    "\nwhere mc.mc_active='yes' and drs_id is not null " + WhereDate + " and mc_empstatus = '" + dept + "' " +
                    "\norder by mc.mc_datetime desc; ";
            }
            else
            {
                sql = "SELECT * FROM ( " +
                    "    select mc.*,concat(em.emp_pname_th, ' ', em.emp_pnamefull_th) as 'emp_name' " +
                    "    from morchana as mc " +
                    "    left join employee as em on em.emp_id = mc.mc_empid " +
                    "    where mc.mc_active = 'yes' and em.emp_id is not null " +
                    "    " + WhereDate + " and em.emp_deptid = '" + dept + "' " +
                    "    UNION " +
                    "    select mc.*,concat(os_fname, ' ', os_lname) as 'emp_name' " +
                    "    from morchana as mc " +
                    "    left join outsource as os on os.os_id = mc.mc_empid " +
                    "    where mc.mc_active = 'yes' and os_id is not null " +
                    "    " + WhereDate + " and mc_empstatus = 'outsource' and os_deptid = '" + dept + "' " +
                    ") a " +
                    "order by a.mc_datetime desc; ";
            }

            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                foreach (DataRow dr in dt.Rows)
                {
                    if (dt.Rows.IndexOf(dr) == 0)
                    {
                        dt.Columns.Add("mc_index", typeof(string));
                    }
                    dr["mc_index"] = (int.Parse(dt.Rows.IndexOf(dr).ToString()) + 1).ToString();
                }
            }

            LV_Details.DataSource = dt;
            LV_Details.DataBind();
        }

        protected void btn_search_ServerClick(object sender, EventArgs e)
        {
            string date = DateTime.Now.ToString("yyyy-MM-dd");
            if (date_search.Value != "")
            {
                date = DateTime.Parse(date_search.Value.ToString()).ToString("yyyy-MM-dd");
            }
            AllQtyColor(DD_dept.SelectedValue.ToString(), date);
        }

        public Boolean Grid1(string dept, string date)
        {
            Boolean bl = false;

            string whereDept = "";
            if (dept == "")
            {

            }
            else if (dept == "doctor")
            {
                whereDept = "and mc_empstatus='doctor' ";
            }
            else if (dept == "outsource")
            {
                whereDept = "and mc_empstatus='outsource' ";
            }
            else
            {
                whereDept = "and mc_empid in (select emp_id from employee where emp_deptid='" + dept + "') ";
            }

            sql = "select * from morchana where convert(mc_datetime, date) = '" + date + "' " + whereDept + " order by mc_id ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0) 
            {
                bl = true;
            }

            GridView1.DataSource = dt;
            GridView1.DataBind();

            return bl;
        }

        protected void btn_export_ServerClick(object sender, EventArgs e)
        {
            string scModal = "";

            div_grid.Visible = true;

            string date = DateTime.Now.ToString("yyyy-MM-dd");
            if (date_search.Value != "")
            {
                date = DateTime.Parse(date_search.Value.ToString()).ToString("yyyy-MM-dd");
            }

            if (Grid1(DD_dept.SelectedValue.ToString(), date))
            {
                string DateTimes = "";
                DateTimes = DateTime.Now.ToString("yyyyMMdd");

                string FileName = "BRH_morchana_" + DateTimes + ".xls";

                Response.Clear();
                Response.Buffer = true;
                Response.AddHeader("content-disposition", "attachment;filename=" + FileName + "");
                //Response.Charset = "tis-620";
                Response.ContentType = "application/vnd.ms-excel";

                //confix language for Thai
                Response.ContentEncoding = System.Text.Encoding.Unicode;
                Response.BinaryWrite(System.Text.Encoding.Unicode.GetPreamble());

                using (StringWriter sw = new StringWriter())
                {
                    HtmlTextWriter hw = new HtmlTextWriter(sw);

                    //To Export all pages
                    GridView1.AllowPaging = false;

                    Response.Write("<center><h3>Capture norchana Report</h3>");

                    //GridView1.HeaderRow.BackColor = Color.Black; // ตัวหนังสือ
                    foreach (TableCell cell in GridView1.HeaderRow.Cells)
                    {
                        cell.BackColor = GridView1.HeaderStyle.BackColor;
                    }
                    foreach (GridViewRow row in GridView1.Rows)
                    {
                        row.BackColor = Color.White; // พื้นหลัง
                        foreach (TableCell cell in row.Cells)
                        {
                            if (row.RowIndex % 2 == 0)
                            {
                                cell.BackColor = GridView1.AlternatingRowStyle.BackColor;
                            }
                            else
                            {
                                cell.BackColor = GridView1.RowStyle.BackColor;
                            }
                            cell.CssClass = "textmode";
                        }
                    }

                    GridView1.RenderControl(hw);

                    //style to format numbers to string
                    string style = @"<style> .textmode { } </style>";
                    Response.Write(style);
                    Response.Output.Write(sw.ToString());
                    Response.Flush();
                    Response.End();

                    div_grid.Visible = false;
                }
            }
            else
            {
                scModal = "fn_AlertModal('Info','ไม่พบข้อมูล !!','',0);";
            }
            Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
        }
        public override void VerifyRenderingInServerForm(Control control)
        {
            /* Verifies that the control is rendered */
        }
    }
}