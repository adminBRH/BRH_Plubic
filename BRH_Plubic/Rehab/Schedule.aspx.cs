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
    public partial class Schedule : System.Web.UI.Page
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
                        UpdateStatus();

                        string date = DateTime.Now.ToString("yyyy-MM-dd");
                        lbl_Adddatetask.Text = cl_Sql.DateTH(date);
                        date_Task.Value = date;
                        if (Request.QueryString["d"] != null)
                        {
                            string dateID = Request.QueryString["d"].ToString();
                            CalendarSelected(dateID);
                        }
                        else
                        {
                            CLD_Task.SelectedDate = DateTime.Parse(date);
                            ScheduleTask(date);
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
                Response.Redirect("../Default.aspx?back=Rehab/Schedule&login=require");
            }
        }

        private void UpdateStatus()
        {
            sql = "update rehab_book set rhb_status='finish' " +
                "\nwhere rhb_active = 'yes' and rhb_timeen <= current_timestamp and rhb_status = 'onjob'; ";
            cl_Sql.Modify(sql);
        }

        protected void CalendarSelected(string dateID)
        {
            sql = "select * from rehab_taskdates where rhd_id = '" + dateID + "'; ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                string date = dt.Rows[0]["rhd_date"].ToString();
                CLD_Task.SelectedDate = DateTime.Parse(date);
                ScheduleTask(date);
            }
            else
            {
                CLD_Task.SelectedDate = DateTime.Now.Date;
            }
        }

        protected void CLD_Task_DayRender(object sender, DayRenderEventArgs e)
        {
            DateTime date7 = DateTime.Now.Date.AddDays(7);

            string Days = DateTime.Parse(e.Day.Date.ToString()).ToString("yyyy-MM-dd");
            sql = "select * from rehab_taskdates where rhd_active = 'yes' and rhd_date = '" + Days + "'; ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                e.Day.IsSelectable = true;
                e.Cell.BackColor = System.Drawing.Color.LightSkyBlue;
            }
        }

        public void ScheduleTask(string date)
        {
            string dateID = "";
            string scheduleID = "";
            string timeMin = "";
            string timeMax = "";
            string timeSplit = "";

            div_AddDate.Visible = false;
            div_EditDate.Visible = false;
            div_AddTask.Visible = false;

            string dateTH = DateTime.Parse(date).Day + "/" + DateTime.Parse(date).ToString("MMM") + "/" + DateTime.Parse(date).Year;
            lbl_date.Text = dateTH;
            lbl_dateTask.Text = dateTH;

            lbl_tdHead.Text = "";

            date = DateTime.Parse(date).ToString("yyyy-MM-dd");

            sql = "select rhs.*,rhd.*,concat(emp.emp_pname_th,' ',emp.emp_pnamefull_th) as 'Name' " +
                "\nfrom rehab_taskschedule as rhs " +
                "\nleft join rehab_taskdates as rhd on rhd.rhd_id=rhs.rhs_rhdid " + 
                "\nleft join employee as emp on emp.emp_id=rhs.rhs_empid " +
                "\nwhere rhd.rhd_active='yes' and rhs_active = 'yes' and rhd.rhd_date='" + date + "' " +
                "order by rhs_child desc, rhs_id; ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                div_EditDate.Visible = true;
                div_AddTask.Visible = true;

                timeMin = DateTime.Parse(dt.Rows[0]["rhd_timestart"].ToString()).ToString("HH:mm");
                timeMax = DateTime.Parse(dt.Rows[0]["rhd_timeend"].ToString()).ToString("HH:mm");

                timeSplit = dt.Rows[0]["rhd_timesplit"].ToString();

                foreach (DataRow dr in dt.Rows)
                {
                    dateID = dr["rhd_id"].ToString();
                    scheduleID = dr["rhs_id"].ToString();

                    string empid = dr["rhs_empid"].ToString();
                    string timeSt = dr["rhd_timestart"].ToString();
                    string timeEn = dr["rhd_timeend"].ToString();
                    int timeSp = int.Parse(dr["rhd_timesplit"].ToString());
                    string workSt = dr["rhs_timeSt"].ToString();
                    string workEn = dr["rhs_timeEn"].ToString();
                    string breakSt = dr["rhs_breakSt"].ToString();
                    string breakEn = dr["rhs_breakEn"].ToString();
                    string child = dr["rhs_child"].ToString();

                    int Num = dt.Rows.IndexOf(dr);
                    if (Num == 0)
                    {
                        dt.Columns.Add("Num", typeof(string));
                        dt.Columns.Add("TableTimes", typeof(string)); // Add column form to datatable
                    }
                    dr["Num"] = (Num + 1).ToString();

                    string TDTimes = tdTime(dateID, scheduleID, date, timeSt, timeEn, timeSp, workSt, workEn, breakSt, breakEn, child);
                    dr["TableTimes"] = TDTimes;
                }
            }
            else
            {
                sql = "select * from rehab_taskdates where rhd_date='" + date + "' and rhd_active='yes'; ";
                DataTable dt2 = new DataTable();
                dt2 = cl_Sql.select(sql);
                if (dt2.Rows.Count > 0)
                {
                    div_EditDate.Visible = true;
                    div_AddTask.Visible = true;
                    dateID = dt2.Rows[0]["rhd_id"].ToString();

                    timeMin = DateTime.Parse(dt2.Rows[0]["rhd_timestart"].ToString()).ToString("HH:mm");
                    timeMax = DateTime.Parse(dt2.Rows[0]["rhd_timeend"].ToString()).ToString("HH:mm");

                    timeSplit = dt2.Rows[0]["rhd_timesplit"].ToString();
                }
                else
                {
                    div_AddDate.Visible = true;
                }
            }

            lbl_editdate.Text = cl_Sql.DateTH(date);

            txt_dateid.Value = dateID;

            time_taskSt.Value = timeMin;
            time_taskSt.Attributes.Add("min", timeMin);
            time_taskSt.Attributes.Add("max", timeMax);
            time_taskEn.Value = timeMax;
            time_taskEn.Attributes.Add("min", timeMin);
            time_taskEn.Attributes.Add("max", timeMax);

            time_editSt.Value = timeMin;
            time_editEn.Value = timeMax;
            number_editSplit.Value = timeSplit;

            time_breakSt.Attributes.Add("min", timeMin);
            time_breakSt.Attributes.Add("max", timeMax);
            time_breakEn.Attributes.Add("min", timeMin);
            time_breakEn.Attributes.Add("max", timeMax);

            LV_time.DataSource = dt;
            LV_time.DataBind();
        }

        public string tdTime(string rhdid, string rhsid,string date, string timeSt, string timeEn, int timeSp, string workSt, string workEn, string breakSt, string breakEn, string child)
        {
            string result = "";

            date = DateTime.Parse(date).ToString("yyyy-MM-dd");
            timeSt = DateTime.Parse(timeSt).ToString("HH:mm:ss");
            timeEn = DateTime.Parse(timeEn).ToString("HH:mm:ss");

            workSt = DateTime.Parse(workSt).ToString("HH:mm:ss");
            workEn = DateTime.Parse(workEn).ToString("HH:mm:ss");
            breakSt = DateTime.Parse(breakSt).ToString("HH:mm:ss");
            breakEn = DateTime.Parse(breakEn).ToString("HH:mm:ss");

            DateTime StTime = DateTime.Parse(date + " " + timeSt);
            DateTime EnTime = DateTime.Parse(date + " " + timeEn);

            DateTime Stwork = DateTime.Parse(date + " " + workSt);
            DateTime Enwork = DateTime.Parse(date + " " + workEn);
            DateTime Stbreak = DateTime.Parse(date + " " + breakSt);
            DateTime Enbreak = DateTime.Parse(date + " " + breakEn);

            string CustName = "";

            string tdHead = "";
            string OnClick = "";

            int n = 1;
            while (StTime <= EnTime)
            {
                string color = "";
                CustName = "";
                if (StTime >= Stwork && StTime <= Enwork)
                {
                    if (StTime >= Stbreak && StTime < Enbreak)
                    {
                        // break
                        color = "lightgrey"; 
                    }
                    else
                    {
                        // on
                        string ResultBook = SlotBooked(rhdid, rhsid, StTime.ToString("yyyy-MM-dd HH:mm:ss"));
                        if (ResultBook != "")
                        {
                            string[] BookAr = ResultBook.Split('_');
                            string rhbid = BookAr[0];
                            CustName = BookAr[1];
                            string status = BookAr[2];

                            if (status == "finish")
                            {
                                color = "forestgreen; cursor: pointer";
                            } 
                            else if (status == "onjob")
                            {
                                color = "cornflowerblue; cursor: pointer";
                            }
                            else
                            {
                                color = "Highlight; cursor: pointer";
                            }
                            
                            OnClick = "data-toggle=\"modal\" data-target=\"#modalDetails\" onclick=\"fn_details('" + rhbid + "')\" ";
                        }
                        else
                        {
                            if (child == "yes")
                            {
                                color = "greenyellow";
                            }
                            else
                            {
                                color = "darkgoldenrod";
                            }
                        }
                    }
                }
                else
                {
                    color = "white"; // off
                }

                tdHead = tdHead + "<td style=\"width: @%;\">" + StTime.ToString("HH:mm") + "</td>";

                //Stwork = Stwork.AddMinutes(timeSp);
                StTime = StTime.AddMinutes(timeSp);

                result = result + "<td style=\"background-color: " + color + "; color: white;\" " + OnClick + ">" + CustName + "</td>";

                n++;
            }

            string width = (75 / n).ToString();

            lbl_tdHead.Text = tdHead.Replace("@", width);

            return result;
        }

        protected string SlotBooked(string rhdid, string rhsid, string TimeSt)
        {
            string result = "";

            sql = "select * from rehab_book " +
                "\nwhere rhb_active = 'yes' and rhb_rhdid = '" + rhdid + "' and rhb_rhsid = '" + rhsid + "' " +
                "\nand rhb_timest <= '" + TimeSt + "' and rhb_timeen > '" + TimeSt + "' " +
                "\norder by rhb_timest; ";
            DataTable dtSb = new DataTable();
            dtSb = cl_Sql.select(sql);
            if (dtSb.Rows.Count > 0)
            {
                result = dtSb.Rows[0]["rhb_id"].ToString() + "_" + dtSb.Rows[0]["rhb_fname"].ToString() + "_" + dtSb.Rows[0]["rhb_status"].ToString();
            }

            return result;
        }

        protected void CLD_Task_SelectionChanged(object sender, EventArgs e)
        {
            string date = CLD_Task.SelectedDate.ToString();
            ScheduleTask(date);
            string SelectDate = DateTime.Parse(date).ToString("yyyy-MM-dd");
            lbl_Adddatetask.Text = cl_Sql.DateTH(SelectDate);
            date_Task.Value = SelectDate;
        }

        protected void btn_addDate_ServerClick(object sender, EventArgs e)
        {
            string scModal = "";

            string date = date_Task.Value.ToString();
            if (date == "")
            {
                scModal = "fn_AlertModal('Info','กรุณาเลือกวันที่ !!','',0);";
            }
            else
            {
                date = DateTime.Parse(date).ToString("yyyy-MM-dd");
                sql = "select * from rehab_taskdates where rhd_date='" + date + "' and rhd_active='yes'; ";
                dt = new DataTable();
                dt = cl_Sql.select(sql);
                if (dt.Rows.Count > 0)
                {
                    scModal = "fn_AlertModal('Warning','วันที่เลือก มีเวลาทำงานอยู่แล้ว ไม่สามารถเพิ่มได้อีก !!','',0);";
                }
                else
                {
                    string timeSt = time_St.Value.ToString();
                    string timeEn = time_En.Value.ToString();
                    if (timeSt == "" || timeEn == "")
                    {
                        scModal = "fn_AlertModal('Info','กรุณาเลือกเวลา !!','',0);";
                    }
                    else
                    {
                        if (DateTime.Parse(timeSt) >= DateTime.Parse(timeEn))
                        {
                            scModal = "fn_AlertModal('Warning','เวลาเริ่มต้น มากกว่า เวลาสิ้นสุด ไม่ได้ !!','',0);";
                        }
                        else
                        {
                            if (number_split.Value.ToString() == "")
                            {
                                scModal = "fn_AlertModal('Info','กรุณาระบุการแบ่งช่วง !!','',0);";
                            }
                            else
                            {
                                int timeSp = int.Parse(number_split.Value.ToString().Trim());
                                if (timeSp < 30)
                                {
                                    number_split.Value = "30";
                                    scModal = "fn_AlertModal('Warning','สามารถแบ่งช่วงได้ต่ำที่สุดแค่ 30 นาที !!','',0);";
                                }
                                else
                                {
                                    string cuser = Session["userid"].ToString();
                                    sql = "INSERT INTO rehab_taskdates " +
                                        "(rhd_date, rhd_timestart, rhd_timeend, rhd_timesplit, rhd_cuser, rhd_cdate) " +
                                        "VALUES('" + date + "', '" + timeSt + "', '" + timeEn + "', " + timeSp + ", '" + cuser + "', current_timestamp); ";
                                    if (cl_Sql.Modify(sql))
                                    {
                                        string dateID = "";
                                        sql = "select max(rhd_id) as 'rhd_id' from rehab_taskdates ";
                                        dt = new DataTable();
                                        dt = cl_Sql.select(sql);
                                        if (dt.Rows.Count > 0)
                                        {
                                            dateID = "?d=" + dt.Rows[0]["rhd_id"].ToString();
                                        }
                                        scModal = "fn_AlertModal('Success','Success !!','Schedule" + dateID + "',1500);";
                                    }
                                    else
                                    {
                                        scModal = "fn_AlertModal('Warning','ไม่สามารถบันทึกได้ กรุณาติดต่อผู้ดูแลระบบ !!','',0);";
                                    }
                                }
                            }
                        }
                    }
                }
            }
            Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
        }

        protected void btn_checkEmp_ServerClick(object sender, EventArgs e)
        {
            string empid = txt_emp.Value.ToString().Trim();
            sql = "select * from employee where emp_id = '" + empid + "' ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                string Name = dt.Rows[0]["emp_pname_th"].ToString() +" "+ dt.Rows[0]["emp_fname_th"].ToString() +" "+ dt.Rows[0]["emp_lname_th"].ToString();
                time_taskSt.Focus();
            }
            else
            {
                txt_emp.Focus();
            }
        }

        protected void btn_submitTask_ServerClick(object sender, EventArgs e)
        {
            string scModal = "";

            string dateID = txt_dateid.Value.ToString();
            string empid = txt_emp.Value.ToString().Trim();
            int qtySlot = int.Parse(txt_qtyslot.Value.ToString());
            string taskSt = time_taskSt.Value.ToString();
            string taskEn = time_taskEn.Value.ToString();
            string breakSt = time_breakSt.Value.ToString();
            string breakEn = time_breakEn.Value.ToString();
            string chlid = txt_child.Value.ToString();

            string cuser = Session["userid"].ToString();

            //sql = "select * from employee where emp_id = '" + empid + "'; ";
            //dt = new DataTable();
            //dt = cl_Sql.select(sql);
            //if (dt.Rows.Count > 0)
            //{
            //    sql = "select * from rehab_taskschedule where rhs_active='yes' and rhs_rhdid='" + dateID + "' and rhs_empid='" + empid + "' ";
            //    dt = new DataTable();
            //    dt = cl_Sql.select(sql);
            //    if (dt.Rows.Count > 0)
            //    {
            //        scModal = "fn_AlertModal('Info','พนักงานคนนี้ มีเวลาทำงานในวันนี้อยู่แล้ว !!','',0);";
            //    }
            //    else
            //    {
            //        // ---------------------------
            //    }
            //}
            //else
            //{
            //    scModal = "fn_AlertModal('Info','รหัสพนักงานไม่ถูกต้อง !!','',0);";
            //}

            if (dateID == "")
            {
                scModal = "fn_AlertModal('Warning','กรุณาทำการเพิ่มช่วงเวลาก่อน !!','',0);";
            }
            else
            {
                sql = "";
                for (int i = 0; i < qtySlot; i++)
                {
                    sql = sql + "INSERT INTO rehab_taskschedule " +
                                "\n(rhs_rhdid, `rhs_timeSt`, `rhs_timeEn`, `rhs_breakSt`, `rhs_breakEn`, rhs_datecreate, rhs_empcreate, rhs_child) " +
                                "\nVALUES(" + dateID + ", '" + taskSt + "', '" + taskEn + "', '" + breakSt + "', '" + breakEn + "', current_timestamp, '" + cuser + "', '" + chlid + "');\n";
                }

                if (cl_Sql.Modify(sql))
                {
                    scModal = "fn_AlertModal('Success','Success !!','Schedule?d=" + dateID + "',1500);";
                }
                else
                {
                    scModal = "fn_AlertModal('Warning','ไม่สามารถบันทึกได้กรุณาติดต่อผู้ดูแลระบบ !!','',0);";
                }
            }

            Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
        }

        protected void btn_editTime_ServerClick(object sender, EventArgs e)
        {
            string scModal = "";

            string dateID = txt_dateid.Value.ToString();
            if (EditTime(dateID))
            {
                scModal = "fn_AlertModal('Success','Success !!','Schedule?d=" + dateID + "',1500);";
            }
            else
            {
                scModal = "fn_AlertModal('Warning','ไม่สามารถแก้ไขเวลาได้กรุณาติดต่อผู้ดูแลระบบ !!','',0);";
            }
            Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
        }

        protected Boolean EditTime(string dateID)
        {
            Boolean bl = false;
            
            string timeSt = time_editSt.Value.ToString();
            string timeEn = time_editEn.Value.ToString();
            string split = number_editSplit.Value.ToString();

            sql = "update rehab_taskdates set rhd_timestart='" + timeSt + "', rhd_timeend='" + timeEn + "', rhd_timesplit=" + split + "" +
                "\nwhere rhd_id='" + dateID + "' ";
            if (cl_Sql.Modify(sql))
            {
                bl = true;
            }
            
            return bl;
        }

        protected void btn_submitEditTask_ServerClick(object sender, EventArgs e)
        {
            string scModal = "";

            string dateID = txt_dateid.Value.ToString();

            string rhsID = txt_taskid.Value.ToString();
            string empid = txt_emp.Value.ToString().Trim();
            string timeSt = DateTime.Parse(time_EdittaskSt.Value.ToString()).ToString("HH:mm:ss");
            string timeEn = DateTime.Parse(time_EdittaskEn.Value.ToString()).ToString("HH:mm:ss");
            string breakSt = time_EditbreakSt.Value.ToString();
            string breakEn = time_EditbreakEn.Value.ToString();
            string child = "";
            if (cb_Editchild_y.Checked)
            {
                child = "yes";
            }
            else
            {
                child = "no";
            }

            sql = "select * from employee where emp_active='yes' and emp_id='" + empid + "'; ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                if (CheckBook(dateID, rhsID, timeSt, timeEn))
                {
                    sql = "update rehab_taskschedule set rhs_empid='" + empid + "', rhs_timeSt='" + timeSt + "', rhs_timeEn='" + timeEn + "', rhs_breakSt='" + breakSt + "', rhs_breakEn='" + breakEn + "', rhs_child='" + child + "' " +
                        "\nwhere rhs_rhdid='" + dateID + "' and rhs_id='" + rhsID + "' ";
                    if (cl_Sql.Modify(sql))
                    {
                        scModal = "fn_AlertModal('Success','Success !!','Schedule?d=" + dateID + "',1500);";
                    }
                    else
                    {
                        scModal = "fn_AlertModal('Warning','ไม่สามารถแก้ไขตารางการทำงานได้ กรุณาติดต่อผู้ดูแลระบบ !!','',0);";
                    }
                }
                else
                {
                    scModal = "fn_AlertModal('Warning','ไม่สามารถแก้ไขเป็นเวลาตามที่ต้องการได้ เนื่องจากมีรายการจองที่อยู่นอกเหนือเวลาดังกล่าว !!','',0);";
                }
            }
            else
            {
                scModal = "fn_AlertModal('Warning','ไม่พบรหัสพนักงานนี้ในระบบ !!','',0);";
            }

            Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
        }

        protected Boolean CheckBook(string rhdid, string rhsid, string TimeSt, string TimeEn)
        {
            Boolean bl = true;

            sql = "select min(rb.rhb_timest) as 'MinTime', max(rb.rhb_timeen) as 'MaxTime' from rehab_book as rb " +
                "where rb.rhb_active = 'yes' and rb.rhb_rhdid='" + rhdid + "' and rb.rhb_rhsid='" + rhsid + "'; ";
            DataTable dt2 = new DataTable();
            dt2 = cl_Sql.select(sql);
            if (dt2.Rows.Count > 0)
            {
                if (dt2.Rows[0]["MinTime"].ToString() != "" && dt2.Rows[0]["MaxTime"].ToString() != "")
                {
                    DateTime MinTime = DateTime.Parse(dt2.Rows[0]["MinTime"].ToString());
                    DateTime MaxTime = DateTime.Parse(dt2.Rows[0]["MaxTime"].ToString());
                    DateTime StTime = DateTime.Parse(MinTime.ToString("yyyy-MM-dd") + " " + TimeSt);
                    DateTime EnTime = DateTime.Parse(MaxTime.ToString("yyyy-MM-dd") + " " + TimeEn);
                    if (StTime > MinTime || MaxTime > EnTime)
                    {
                        bl = false;
                    }
                }
            }

            return bl;
        }

        protected Boolean HasBook(string rhdid, string rhsid)
        {
            Boolean bl = false;

            sql = "select* from rehab_book where rhb_active = 'yes' and rhb_rhdid='" + rhdid + "' and rhb_rhsid='" + rhsid + "' ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                bl = true;
            }

            return bl;
        }

        protected void btn_cancelTask_ServerClick(object sender, EventArgs e)
        {
            string scModal = "";

            string dateID = txt_dateid.Value.ToString();
            string rhsID = txt_taskid.Value.ToString();

            string empid = Session["userid"].ToString();

            if (HasBook(dateID, rhsID))
            {
                scModal = "fn_AlertModal('Warning','ไม่สามารถลบได้ เนื่องจากมีการจองเข้ามาแล้ว !!','',0);";
            }
            else
            {
                sql = "update rehab_taskschedule set rhs_active='no', rhs_dateedit=current_timestamp, rhs_empedit='" + empid + "' " +
                    "\nwhere rhs_id='" + rhsID + "' ";
                if (cl_Sql.Modify(sql))
                {
                    scModal = "fn_AlertModal('Success','ลบข้อมูลเรียบร้อยแล้ว','Schedule?d=" + dateID + "',1500);";
                }
                else
                {
                    scModal = "fn_AlertModal('Warning','ไม่สามารถแก้ไขตารางการทำงานได้ กรุณาติดต่อผู้ดูแลระบบ !!','',0);";
                }
            }

            Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
        }

        protected void btn_details_ServerClick(object sender, EventArgs e)
        {
            string rhbid = txt_bookid.Value.ToString();
            sql = "select * from rehab_book where rhb_id='" + rhbid + "' and rhb_active='yes'; ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                string rhsid = dt.Rows[0]["rhb_rhsid"].ToString();
                string Selectdate = cl_Sql.DateTH(dt.Rows[0]["rhb_timest"].ToString());
                string Selecttime = DateTime.Parse(dt.Rows[0]["rhb_timest"].ToString()).ToString("HH:mm") + " น. ถึง " + DateTime.Parse(dt.Rows[0]["rhb_timeen"].ToString()).ToString("HH:mm") + " น.";
                string status = dt.Rows[0]["rhb_status"].ToString();
                DateTime timeNow = DateTime.Parse(DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
                DateTime timeEnd = DateTime.Parse(DateTime.Parse(dt.Rows[0]["rhb_timeen"].ToString()).ToString("yyyy-MM-dd HH:mm:ss"));
                btnonjob.Visible = false;
                if (timeNow <= timeEnd)
                {
                    if (status == "booked")
                    {
                        btnonjob.Visible = true;
                    }
                }
                if (status == "onjob")
                {

                }

                string gender = dt.Rows[0]["rhb_gender"].ToString();
                if (gender == "male")
                {
                    gender = "ชาย";
                }
                else
                {
                    gender = "หญิง";
                }
                string customer = dt.Rows[0]["rhb_fname"].ToString() + " " + dt.Rows[0]["rhb_lname"].ToString();
                string HN = dt.Rows[0]["rhb_hn"].ToString();
                string OI = dt.Rows[0]["rhb_oi"].ToString();
                string tool = dt.Rows[0]["rhb_rhtid"].ToString();
                string toolqty = dt.Rows[0]["rhb_toolqty"].ToString();
                string remark = dt.Rows[0]["rhb_remark"].ToString();

                string[] ArTool = tool.Split('|');
                string[] ArToolQty = toolqty.Split('|');
                string ToolShow = "";

                for (int i = 0; i < ArTool.Length; i++)
                {
                    sql = "select * from rehab_tool where rht_id='" + ArTool[i] + "'; ";
                    dt = new DataTable();
                    dt = cl_Sql.select(sql);
                    if (dt.Rows.Count > 0)
                    {
                        if (i > 0)
                        {
                            ToolShow = ToolShow + "<br />";
                        }
                        ToolShow = ToolShow + dt.Rows[0]["rht_name"].ToString() + " &nbsp;&nbsp;จำนวน " + ArToolQty[i] + " ครั้ง";
                    }
                    else
                    {
                        ToolShow = "ไม่ใช้";
                    }
                }

                sql = "select rhs.*,emp.emp_pname_th,emp.emp_pnamefull_th " +
                    "\nfrom rehab_taskschedule as rhs " +
                    "\nleft join employee as emp on emp.emp_id=rhs.rhs_empid " +
                    "\nwhere rhs_id='" + rhsid + "' ";
                dt = new DataTable();
                dt = cl_Sql.select(sql);
                if (dt.Rows.Count > 0)
                {
                    string child = dt.Rows[0]["rhs_child"].ToString();
                    if (child == "yes")
                    {
                        child = "เด็ก";
                    }
                    else
                    {
                        child = "ผู้ใหญ่";
                    }
                    string staffname = dt.Rows[0]["emp_pname_th"].ToString() + " " + dt.Rows[0]["emp_pnamefull_th"].ToString();
                    if (staffname == " ") { staffname = "ยังไม่มี"; }

                    lbl_dateTH.Text = Selectdate;
                    lbl_time.Text = Selecttime;
                    lbl_child.Text = child;
                    lbl_staff.Text = staffname;

                    lbl_gender.Text = gender;
                    lbl_customer.Text = customer;
                    lbl_hn.Text = HN;
                    lbl_oi.Text = OI;

                    txt_remark.Value = remark;

                    lbl_tool.Text = ToolShow;
                }
                else
                {

                }
            }
            else
            {

            }
        }

        protected void btn_cancel_ServerClick(object sender, EventArgs e)
        {
            string scModal = "";

            string dateID = txt_dateid.Value.ToString();
            string rhbid = txt_bookid.Value.ToString();
            string empid = Session["userid"].ToString();

            sql = "update rehab_book set rhb_active='no',rhb_muser='" + empid + "',rhb_mdate=current_timestamp where rhb_id='" + rhbid + "'; ";
            if (cl_Sql.Modify(sql))
            {
                scModal = "fn_AlertModal('Success','ลบข้อมูลเรียบร้อยแล้ว','Schedule?d=" + dateID + "',1500);";
            }
            else
            {
                scModal = "fn_AlertModal('Warning','ไม่สามารถลบข้อมูลการจองได้ กรุณาติดต่อผู้ดูแลระบบ !!','',0);";
            }

            Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
        }

        protected void btnonjob_ServerClick(object sender, EventArgs e)
        {
            string dateID = txt_dateid.Value.ToString();
            string rhb_id = txt_bookid.Value.ToString();

            sql = "update rehab_book set rhb_status='onjob' where rhb_id='" + rhb_id + "'; ";
            if (cl_Sql.Modify(sql))
            {
                Response.Redirect("Schedule?d=" + dateID);
            }
        }
    }
}