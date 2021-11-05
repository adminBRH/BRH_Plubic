using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;
using Org.BouncyCastle.Asn1.Ocsp;

namespace BRH_Plubic.GoodDoctor
{
    public partial class Manage : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["login"] != null)
            {
                string status = Session["status"].ToString();
                if (status == "admin" || status == "headdept")
                {
                    if (!IsPostBack)
                    {
                        DepartmentList();

                        if (Request.QueryString["dept"] != null)
                        {
                            string dept = Request.QueryString["dept"].ToString();
                            DoctorList(dept,"yes");
                            DD_Department.SelectedValue = dept;
                        }
                    }
                }
                else
                {
                    Response.Write("<script>alert('คุณไม่มีสิทธิ์ใช้งานหน้านี้ !!'); window.location.href='../default.aspx';</script>");
                }
            }
            else
            {
                Response.Redirect("../Default.aspx?back=GoodDoctor/Manage&login=require");
                //Response.Write("<script>alert('กรุณา login ก่อนเข้าใช้งาน !!'); window.location.href='../default.aspx';</script>");
            }
            
        }

        #region SQL for select data from Bconnect insert to Doctor Table
        //--- for table doctor_location
        //select LocationUID as 'dl_id',Name as 'dl_name' 
        //,'admin' as 'dl_createby' ,CURRENT_TIMESTAMP as 'dl_createdate'
        //from VwCareProviderLocation_BEG 
        // where LocationUID > 0 group by LocationUID,Name;

        //--- for table doctor
        //select vcp.CareproviderUID,cp.ForeName,cp.SurName
        //from VwCareProviderLocation_BEG as vcp 
        //left join Careprovider as cp on cp.UID=vcp.CareproviderUID 
        //where cp.LicenseNo is not null
        // group by vcp.CareproviderUID,cp.ForeName,cp.SurName
        // order by vcp.CareproviderUID;

        //--- for table doctor_schedule
        //select LocationUID,CareproviderUID from VwCareProviderLocation_BEG 
        // where LocationUID > 0 group by LocationUID,CareproviderUID;
        #endregion

        protected void DepartmentList()
        {
            sql = "Select * from ( " +
                "select '1' as 'byindex', dl_id,dl_name from doctor_location " +
                "where dl_active='yes' " +
                "union " +
                "select '0', '', 'กรุณาเลือกแผนก' " +
                ") a order by byindex,dl_name ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            { }

            DD_Department.DataSource = dt;
            DD_Department.DataTextField = "dl_name";
            DD_Department.DataValueField = "dl_id";
            DD_Department.DataBind();
        }

        protected void DoctorList(string deptid, string active)
        {
            DateTime DateTimeNow = DateTime.Now;

            sql = "SELECT * FROM ( " +
                "\nSelect *,if(ds_status='auto',if((a.StartTime<=a.ThisTime) and (a.FinishTime>=a.ThisTime),'yes','no'),'yes') as 'Working' From ( " +
                "\nselect ds.*,dr.* " +
                "\n,concat(date_format(ds.ds_sunday_start,'%H:%i'),'<br />',date_format(ds.ds_sunday_finish,'%H:%i')) as 'ds_sunday' " +
                "\n,concat(date_format(ds.ds_monday_start, '%H:%i'), '<br />', date_format(ds.ds_monday_finish, '%H:%i')) as 'ds_monday' " +
                "\n,concat(date_format(ds.ds_tuesday_start, '%H:%i'), '<br />', date_format(ds.ds_tuesday_finish, '%H:%i')) as 'ds_tuesday' " +
                "\n,concat(date_format(ds.ds_wednesday_start, '%H:%i'), '<br />', date_format(ds.ds_wednesday_finish, '%H:%i')) as 'ds_wednesday' " +
                "\n,concat(date_format(ds.ds_thursday_start, '%H:%i'), '<br />', date_format(ds.ds_thursday_finish, '%H:%i')) as 'ds_thursday' " +
                "\n,concat(date_format(ds.ds_friday_start, '%H:%i'), '<br />', date_format(ds.ds_friday_finish, '%H:%i')) as 'ds_friday' " +
                "\n,concat(date_format(ds.ds_saturday_start, '%H:%i'), '<br />', date_format(ds.ds_saturday_finish, '%H:%i')) as 'ds_saturday' " +
                "\n,case dayname(current_date()) " +
                "\n    when 'Sunday' then ds.ds_sunday_start " +
                "\n    when 'Monday' then ds.ds_monday_start " +
                "\n    when 'Tuesday' then ds.ds_tuesday_start " +
                "\n    when 'Wednesday' then ds.ds_wednesday_start " +
                "\n    when 'Thursday' then ds.ds_thursday_start " +
                "\n    when 'Friday' then ds.ds_friday_start " +
                "\n    when 'Saturday' then ds.ds_saturday_start " +
                "\n    else null " +
                "\nend as StartTime " +
                "\n,case dayname(current_date())  " +
                "\n    when 'Sunday' then ds.ds_sunday_finish " +
                "\n    when 'Monday' then ds.ds_monday_finish " +
                "\n    when 'Tuesday' then ds.ds_tuesday_finish " +
                "\n    when 'Wednesday' then ds.ds_wednesday_finish " +
                "\n    when 'Thursday' then ds.ds_thursday_finish " +
                "\n    when 'Friday' then ds.ds_friday_finish " +
                "\n    when 'Saturday' then ds.ds_saturday_finish " +
                "\n    else null " +
                "\nend as FinishTime" +
                "\n,current_time as ThisTime " +
                "\nfrom doctor_schedule as ds " +
                "\nleft join doctor as dr on dr.dr_id = ds.ds_drid " +
                "\nwhere dr_forename is not null and ds_dlid = '" + deptid + "' " +
                "\nand ds_active = '"+ active +"' " +
                "\n) a " +
                "\n) a " +
                "\norder by ds_active desc,Working desc,dr_username; ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    if (dt.Rows.IndexOf(row) == 0)
                    {
                        dt.Columns.Add("ds_script", typeof(string));
                        dt.Columns.Add("ds_onBoard", typeof(string));
                    }
                    string check = "";
                    if (row["ds_active"].ToString() == "yes")
                    {
                        check = "checked=\"checked\"";
                    }
                    row["ds_script"] = check;
                    if (row["dr_img"].ToString() == "")
                    {
                        row["dr_img"] = "image/doctor_null.png";
                    }

                    row["ds_onBoard"] = "white";
                    if (row["Working"].ToString() == "yes")
                    {
                        row["ds_onBoard"] = "green";
                    }
                }
            }

            LV_doctor.DataSource = dt;
            LV_doctor.DataBind();
        }

        public string Department(string deptid)
        {
            string result = "";

            sql = "select * from doctor_location where dl_id='" + deptid + "' ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                result = dt.Rows[0]["dl_name"].ToString();
            }

            return result;
        }

        protected void DD_Department_SelectedIndexChanged(object sender, EventArgs e)
        {
            txt_active.Value = "yes";
            CB_Active.Checked = true;

            string deptid = DD_Department.SelectedValue.ToString();
            if (deptid == "")
            {
                a_addDoctor.Visible = false;
                div_cbActive.Visible = false;
            }
            else
            {
                a_addDoctor.Visible = true;
                div_cbActive.Visible = true;
                iframe_queue.Src = "../Queue/myWebForm.aspx?dept=" + deptid;
            }
            DoctorList(deptid,"yes");
        }

        protected void btn_updateManual_ServerClick(object sender, EventArgs e)
        {
            string ds_id = txtH_manualId.Value.ToString();
            if (ds_id != "")
            {
                string ds_status = txtH_manualstatus.Value.ToString();
                if (ds_status == "auto")
                {
                    ds_status = "manual";
                }
                else
                {
                    ds_status = "auto";
                }
                if (UpdateStatus(ds_id, ds_status))
                {
                    string dept = DD_Department.SelectedValue.ToString();
                    lbl_Modal.Text = "<script>alertModal('#Modal_Success'); setTimeout(function(){ window.location.href='Manage.aspx?dept=" + dept + "'; }, 2000);</script>";
                }
            }
        }

        protected Boolean UpdateStatus(string ds_id, string ds_status)
        {
            Boolean bl = false;

            sql = "update doctor_schedule set ds_status = '" + ds_status + "' where ds_id = '" + ds_id + "' ";
            if (cl_Sql.Modify(sql))
            {
                bl = true;
            }

            return bl;
        }

        protected void btn_updateActive_ServerClick(object sender, EventArgs e)
        {
            string ds_id = txtH_activeId.Value.ToString();
            if (ds_id != "")
            {
                string ds_active = txtH_activestatus.Value.ToString();
                if (UpdateActive(ds_id, ds_active))
                {
                    string dept = DD_Department.SelectedValue.ToString();
                    lbl_Modal.Text = "<script>alertModal('#Modal_Success'); setTimeout(function(){ window.location.href='Manage.aspx?dept=" + dept + "'; }, 2000);</script>";
                }
            }
        }

        protected Boolean UpdateActive(string ds_id, string ds_active)
        {
            Boolean bl = false;

            sql = "update doctor_schedule set ds_active = '" + ds_active + "' where ds_id = '" + ds_id + "' ";
            if (cl_Sql.Modify(sql))
            {
                bl = true;
            }

            return bl;
        }

        protected void btn_Schedule_ServerClick(object sender, EventArgs e)
        {
            string dsid = txtH_scid.Value.ToString();
            sql = "select * from doctor_schedule where ds_id = '" + dsid + "' ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                time_sun_start.Value = dt.Rows[0]["ds_sunday_start"].ToString();
                time_sun_finish.Value = dt.Rows[0]["ds_sunday_finish"].ToString();

                time_mon_start.Value = dt.Rows[0]["ds_monday_start"].ToString();
                time_mon_finish.Value = dt.Rows[0]["ds_monday_finish"].ToString();

                time_tue_start.Value = dt.Rows[0]["ds_tuesday_start"].ToString();
                time_tue_finish.Value = dt.Rows[0]["ds_tuesday_finish"].ToString();

                time_wen_start.Value = dt.Rows[0]["ds_wednesday_start"].ToString();
                time_wen_finish.Value = dt.Rows[0]["ds_wednesday_finish"].ToString();

                time_thu_start.Value = dt.Rows[0]["ds_thursday_start"].ToString();
                time_thu_finish.Value = dt.Rows[0]["ds_thursday_finish"].ToString();

                time_fri_start.Value = dt.Rows[0]["ds_friday_start"].ToString();
                time_fri_finish.Value = dt.Rows[0]["ds_friday_finish"].ToString();

                time_sat_start.Value = dt.Rows[0]["ds_saturday_start"].ToString();
                time_sat_finish.Value = dt.Rows[0]["ds_saturday_finish"].ToString();
            }
        }

        protected void btn_updateSchedule_ServerClick(object sender, EventArgs e)
        {
            string dsid = txtH_scid.Value.ToString();

            string sun_start = time_sun_start.Value.ToString();
            string sun_finish = time_sun_finish.Value.ToString();
            if (sun_start=="") { sun_start = "NULL"; } else { sun_start = "'" + sun_start + "'"; }
            if (sun_finish == "") { sun_finish = "NULL"; } else { sun_finish = "'" + sun_finish + "'"; }

            string mon_start = time_mon_start.Value.ToString();
            string mon_finish = time_mon_finish.Value.ToString();
            if (mon_start == "") { mon_start = "NULL"; } else { mon_start = "'" + mon_start + "'"; }
            if (mon_finish == "") { mon_finish = "NULL"; } else { mon_finish = "'" + mon_finish + "'"; }

            string tue_start = time_tue_start.Value.ToString();
            string tue_finish = time_tue_finish.Value.ToString();
            if (tue_start == "") { tue_start = "NULL"; } else { tue_start = "'" + tue_start + "'"; }
            if (tue_finish == "") { tue_finish = "NULL"; } else { tue_finish = "'" + tue_finish + "'"; }

            string wen_start = time_wen_start.Value.ToString();
            string wen_finish = time_wen_finish.Value.ToString();
            if (wen_start == "") { wen_start = "NULL"; } else { wen_start = "'" + wen_start + "'"; }
            if (wen_finish == "") { wen_finish = "NULL"; } else { wen_finish = "'" + wen_finish + "'"; }

            string thu_start = time_thu_start.Value.ToString();
            string thu_finish = time_thu_finish.Value.ToString();
            if (thu_start == "") { thu_start = "NULL"; } else { thu_start = "'" + thu_start + "'"; }
            if (thu_finish == "") { thu_finish = "NULL"; } else { thu_finish = "'" + thu_finish + "'"; }

            string fri_start = time_fri_start.Value.ToString();
            string fri_finish = time_fri_finish.Value.ToString();
            if (fri_start == "") { fri_start = "NULL"; } else { fri_start = "'" + fri_start + "'"; }
            if (fri_finish == "") { fri_finish = "NULL"; } else { fri_finish = "'" + fri_finish + "'"; }

            string sat_start = time_sat_start.Value.ToString();
            string sat_finish = time_sat_finish.Value.ToString();
            if (sat_start == "") { sat_start = "NULL"; } else { sat_start = "'" + sat_start + "'"; }
            if (sat_finish == "") { sat_finish = "NULL"; } else { sat_finish = "'" + sat_finish + "'"; }

            sql = "update doctor_schedule set " +
                "\nds_sunday_start="+ sun_start + ",ds_sunday_finish=" + sun_finish + " " +
                "\n,ds_monday_start=" + mon_start + ",ds_monday_finish=" + mon_finish + " " +
                "\n,ds_tuesday_start=" + tue_start + ",ds_tuesday_finish=" + tue_finish + " " +
                "\n,ds_wednesday_start=" + wen_start + ",ds_wednesday_finish=" + wen_finish + " " +
                "\n,ds_thursday_start=" + thu_start + ",ds_thursday_finish=" + thu_finish + " " +
                "\n,ds_friday_start=" + fri_start + ",ds_friday_finish=" + fri_finish + " " +
                "\n,ds_saturday_start=" + sat_start + ",ds_saturday_finish=" + sat_finish + " " +
                "\nwhere ds_id = '" + dsid + "' ";
            if (cl_Sql.Modify(sql))
            {
                string dept = DD_Department.SelectedValue.ToString();
                lbl_Modal.Text = "<script>alertModal('#Modal_Success'); setTimeout(function(){ window.location.href='Manage.aspx?dept=" + dept + "'; }, 2000);</script>";
            }
            else
            {
                lbl_Modal.Text = "<script>alertModalWarning('#Modal_Warning','ไม่สามารถบันทึกข้อมูลได้ กรุณาติดต่อผู้ดูแลระบบ !!');</script>";
            }
        }

        protected void btn_uploadImage_ServerClick(object sender, EventArgs e)
        {
            string scModal = "";
            string dsid = txtH_scid.Value.ToString();
            string drid = "";
            string filename = "";
            sql = "select * from doctor where dr_id in (select ds_drid from doctor_schedule where ds_id='" + dsid + "'); ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                drid = dt.Rows[0]["dr_id"].ToString();
                filename = dt.Rows[0]["dr_img"].ToString();
                if (upload_file(drid, filename))
                {
                    string dept = DD_Department.SelectedValue.ToString();
                    scModal = "fn_AlertModal('Success','Success !!','Manage.aspx?dept=" + dept + "',2000);";
                }
                else
                {
                    scModal = "fn_AlertModal('Warning','ไม่สามารถบันทึกได้ กรุณาติดต่อผู้ดูแลระบบ !!','',0);";
                }
            }
            else
            {
                scModal = "fn_AlertModal('Info','ไม่พบรหัสแพทย์ !!','',0);";
            }

            Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
        }

        public Boolean upload_file(string id, string name)
        {
            Boolean bl = false;
            if (FileUpload1.HasFile)
            {
                string file_name = "";
                foreach (HttpPostedFile get_file in FileUpload1.PostedFiles)
                {
                    file_name = FileUpload1.FileName;
                    string[] list_file = file_name.ToString().Split('.');
                    int maxindex = list_file.Length - 1;
                    string typefile = list_file[maxindex].ToString().ToLower();
                    if (typefile == "jpg" || typefile == "jpeg" || typefile == "png")
                    {
                        file_name = "doctor_" + id + "." + list_file[maxindex].ToString();
                        if (System.IO.File.Exists(name))
                        {
                            System.IO.File.Delete(name);
                        }
                        get_file.SaveAs(System.IO.Path.Combine(Server.MapPath("image/"), file_name));

                        bl = true;
                        
                        sql = "update doctor set dr_img = 'image/" + file_name + "' where dr_id='" + id + "' ";
                        cl_Sql.Modify(sql);
                    }
                }
            }


            return bl;
        }

        protected void btn_adddoctor_ServerClick(object sender, EventArgs e)
        {
            string scModal = "";

            string deptid = DD_Department.SelectedValue.ToString();

            string drid = txt_doctorid.Value.ToString().Trim();
            string druser = txt_doctoruser.Value.ToString().Trim();
            string fname = txt_fname.Value.ToString().Trim();
            string lname = txt_fname.Value.ToString().Trim();
            string fname_eg = txt_fname_eg.Value.ToString().Trim();
            string lname_eg = txt_lname_eg.Value.ToString().Trim();
            string name_eg = fname_eg + " " + lname_eg;

            string useradd = Session["userid"].ToString();

            sql = "insert into doctor(dr_forename,dr_surname,dr_englishname,dr_doctorid,dr_username,dr_password,dr_createby,dr_createdate) " +
                "\nvalues('" + fname + "','" + lname + "','" + name_eg + "','" + drid + "','" + druser + "',md5('" + druser + "'),'" + useradd + "',current_timestamp()); ";
            if (cl_Sql.Modify(sql))
            {
                sql = "select max(dr_id) as dr_id from doctor where dr_username = '" + druser + "' ";
                dt = new DataTable();
                dt = cl_Sql.select(sql);
                if (dt.Rows.Count > 0 )
                {
                    sql = "insert into doctor_schedule(ds_dlid,ds_drid,ds_editby) values('" + deptid + "','" + dt.Rows[0]["dr_id"].ToString() +"','" + useradd + "'); ";
                    if (cl_Sql.Modify(sql))
                    {
                        scModal = "fn_AlertModal('Success','Success !!','Manage.aspx?dept=" + deptid + "',2000);";
                    }
                    else
                    {
                        scModal = "fn_AlertModal('Info','Error 1 : บันทึกข้อมูลเข้าสู่ระบบแล้ว แต่ไม่สามารถเพิ่มตารางเวรอัตโนมัติได้ !!','',0);";
                    }
                }
                else
                {
                    scModal = "fn_AlertModal('Info','Error 2 : บันทึกข้อมูลเข้าสู่ระบบแล้ว แต่ไม่สามารถเพิ่มตารางเวรอัตโนมัติได้ !!','',0);";
                }
            }
            else
            {
                scModal = "fn_AlertModal('Warning','ไม่สามารถบันทึกได้กรุณาติดต่อผู้ดูแลระบบ !!','',0);";
            }

            Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
        }

        protected void btn_addQueue_ServerClick(object sender, EventArgs e)
        {
            string scModal = "";

            string dept = DD_Department.SelectedValue.ToString();
            string fname = txtAdd_fname.Value.ToString().Trim();
            string lname = txtAdd_lname.Value.ToString().Trim();
            string age = txtAdd_age.Value.ToString().Trim();
            string gender = "";
            if (rd_male.Checked)
            {
                gender = "ชาย";
            }
            if (rd_female.Checked)
            {
                gender = "หญิง";
            }

            string Key = cl_Sql.GenerateKey(11);

            int Queue = 0;
            sql = "select ifnull(max(queue),0)+1 as 'nextQ' from mytable where convert(datetimes,date)=current_date and dept='" + dept + "' ";
            dt = new DataTable(sql);
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                Queue = int.Parse(dt.Rows[0]["nextQ"].ToString());
            }

            sql = "insert into mytable(IP,dept,fname,lname,age,gender,keycheck,queue) " +
                    "\nvalues('manual','" + dept + "','" + fname + "','" + lname + "','" + age + "','" + gender + "','" + Key + "'," + Queue + "); ";
            if (cl_Sql.Modify(sql))
            {
                txtAdd_fname.Value = "";
                txtAdd_lname.Value = "";
                txtAdd_age.Value = "";
                rd_male.Checked = false;
                rd_female.Checked = false;

                scModal = "fn_AlertModal('Success','คิวที่ " + Queue + "','',0); windowPopup('/Queue/Generate.aspx?dept=" + dept + "','Generate Queue', 10, 10);";
            }
            else
            {
                scModal = "fn_AlertModal('Warning','ไม่สามารถกดรับคิวได้ กรุณาติดต่อผู้ดูแลระบบ!!','',0);";
            }

            Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
        }

        protected void btn_active_ServerClick(object sender, EventArgs e)
        {
            string deptid = DD_Department.SelectedValue.ToString();
            string active = txt_active.Value.ToString().Trim();
            if (active == "yes")
            {
                txt_active.Value = "no";
                active = "no";
                CB_Active.Checked = false;
            }
            else
            {
                txt_active.Value = "yes";
                active = "yes";
                CB_Active.Checked = true;
            }

            DoctorList(deptid, active);
        }
    }
}