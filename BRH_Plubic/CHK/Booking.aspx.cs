﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;
using Nexmo.Api.Voice.EventWebhooks;
using System.Web.UI.HtmlControls;
using BRH_Plubic.Service;

using System.Threading;
using System.Threading.Tasks;
using System.Diagnostics;

namespace BRH_Plubic.CHK
{
    public partial class Booking : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        MakeControler MConT = new MakeControler();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["key"] == null || Request.QueryString["slot"] == null)
            {
                Response.Redirect("../Default.aspx");
            }
            else
            {
                string key = Request.QueryString["key"].ToString();
                string slot = Request.QueryString["slot"].ToString();
                if (Request.QueryString["permiss"] == null)
                {
                    string url = HttpContext.Current.Request.Url.AbsoluteUri;
                    Response.Redirect(url + "&permiss=yes");
                }
                else
                {
                    if (CheckKey(slot, key))
                    {
                        if (!IsPostBack)
                        {
                            AlertSubmit(slot);
                        }
                    }
                    else
                    {
                        Response.Redirect("../Default.aspx");
                    }
                }
            }
        }

        private Boolean CheckKey(string id, string key)
        {
            Boolean bl = false;

            sql = "select * from bookingslot where bs_id = '" + id + "' and bs_key = '" + key + "' ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                DateTime curDate = DateTime.Now;
                DateTime stDate = DateTime.Parse(dt.Rows[0]["bs_startdate"].ToString());
                if (stDate.Date > curDate.Date)
                {
                    string DateSelect = stDate.ToString("yyyy-MM-dd");
                    cld_booking.SelectedDate = Convert.ToDateTime(DateSelect);
                    cld_booking.VisibleDate = cld_booking.SelectedDate;
                }

                string NameSlot = dt.Rows[0]["bs_name"].ToString();
                string DetailSlot = dt.Rows[0]["bs_alertonform"].ToString();
                lbl_Title.Text = NameSlot;
                lbl_Detail.Text = DetailSlot;
                bl = true;

                if (dt.Rows[0]["bs_sync"].ToString() == "sync")
                {
                    div_CheckSync.Visible = true;
                    div_submit.Visible = false;
                }
            }

            return bl;
        }

        protected void AlertSubmit(string slotID)
        {
            lbl_alertSubmimt.Text = "";
            if (Request.QueryString["bsid"] != null && Request.QueryString["success"] != null)
            {
                string bsid = Request.QueryString["bsid"].ToString();
                string success = Request.QueryString["success"].ToString();
                if (bsid != "" && success.ToString() == "yes")
                {
                    sql = "select * from bookingslot where bs_id = '" + slotID + "' ";
                    dt = new DataTable();
                    dt = cl_Sql.select(sql);
                    if (dt.Rows.Count > 0)
                    {
                        lbl_alertSubmimt.Text = dt.Rows[0]["bs_alertsubmit"].ToString();

                        if (dt.Rows[0]["bs_sync"].ToString() == "sync")
                        {
                            sql = "select * from bookingdetail where bd_brid='" + bsid + "' ";
                            dt = new DataTable();
                            dt = cl_Sql.select(sql);
                            if (dt.Rows.Count > 0)
                            {
                                string name = "";
                                string program = "";
                                foreach (DataRow dr in dt.Rows)
                                {
                                    string column = dr["bd_column"].ToString();
                                    string value = dr["bd_value"].ToString();

                                    if (column == "ชื่อ-นามสกุล") { name = value; }
                                    else
                                    {
                                        if (column == "โปรแกรมที่ตรวจ")
                                        {
                                            program = value;
                                            if (program != "")
                                            {
                                                program = "<br />โปรแกรมที่ตรวจ: " + program;
                                            }
                                        }
                                    }
                                }
                                lbl_syncData.Text = name + program;
                            }
                        }

                        sql = "select date_format(br_datetime,'%d-%b-%Y %H:%i') as 'BookingDateTime' " +
                            "from bookingrecord where br_id = '" + bsid + "' ";
                        dt = new DataTable();
                        dt = cl_Sql.select(sql);
                        if (dt.Rows.Count > 0)
                        {
                            lbl_docno.Text = "Booking number : " + bsid;
                            string bookDateTime = dt.Rows[0]["BookingDateTime"].ToString();
                            string bookDate = DateTime.Parse(bookDateTime).ToString("dd MMM yyyy");
                            string bookTime = DateTime.Parse(bookDateTime).ToString("HH:mm");
                            if (bookTime == "00:00") { bookTime = ""; } else { bookTime = " เวลา " + bookTime + " น."; }
                            lbl_KeyRecord.Text = "วันที่จอง " + bookDate + " " + bookTime;
                        }

                        lbl_script.Text = "<script>alertModal('#ModalAlertSubmit');</script>";
                    }
                }
            }
        }

        protected void cld_booking_DayRender(object sender, DayRenderEventArgs e)
        {
            DateTime DateNow = DateTime.Parse(DateTime.Now.ToString("yyyy-MM-dd"));
            DateTime DateStart = DateTime.Parse("1999-01-01");
            DateTime DateEnd = DateTime.Parse("1999-01-01");
            string breakSt = "";
            string breakEn = "";
            string startAfterBreak = "";
            string splittime = "";
            string splittimeUnit = "";
            string qty = "";
            int maxqty = 0;
            string formID = "";

            string Sync = "";

            string id = Request.QueryString["slot"].ToString();
            string key = Request.QueryString["key"].ToString();

            string hiddenDate = "";

            sql = "select * from bookingslot where bs_id='" + id + "' and bs_key='" + key + "' ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                Sync = dt.Rows[0]["bs_sync"].ToString();

                DateStart = DateTime.Parse(dt.Rows[0]["bs_startdate"].ToString());
                DateEnd = DateTime.Parse(dt.Rows[0]["bs_enddate"].ToString());
                if (dt.Rows[0]["bs_break_startdate"].ToString() != "" && dt.Rows[0]["bs_break_enddate"].ToString() != "")
                {
                    breakSt = DateTime.Parse(dt.Rows[0]["bs_break_startdate"].ToString()).ToString("HH:mm:ss");
                    breakEn = DateTime.Parse(dt.Rows[0]["bs_break_enddate"].ToString()).ToString("HH:mm:ss");
                    startAfterBreak = dt.Rows[0]["bs_startaftetbreak"].ToString();
                }
                hiddenDate = dt.Rows[0]["bs_hiddendate"].ToString();
                splittime = dt.Rows[0]["bs_splittime"].ToString();
                txtH_splittime.Value = splittime;
                splittimeUnit = dt.Rows[0]["bs_splittimeunit"].ToString();
                qty = dt.Rows[0]["bs_splittimeqty"].ToString();
                if (dt.Rows[0]["bs_maxqty"].ToString() != "") 
                {
                    maxqty = int.Parse(dt.Rows[0]["bs_maxqty"].ToString());
                }
                txtH_splittimeQty.Value = qty;
                formID = dt.Rows[0]["bs_bfid"].ToString();

                string CreateConT = txtH_CreateConT.Value.ToString();
                if (CreateConT == "")
                {
                    Controler(formID);
                    CreateConT = "Yes";
                }
            }

            if (e.Day.Date < DateNow || (e.Day.Date < DateTime.Parse(DateStart.ToString("yyyy-MM-dd")) || e.Day.Date > DateTime.Parse(DateEnd.ToString("yyyy-MM-dd"))) )
            {
                e.Day.IsSelectable = false;
                e.Cell.ForeColor = System.Drawing.Color.LightGray;
                e.Cell.BackColor = System.Drawing.Color.WhiteSmoke;
            }
            else
            {
                string LockSlot = "no";

                if (hiddenDate != "")
                {
                    string WeekDay = e.Day.Date.DayOfWeek.ToString();
                    string[] hiddenDate_ar = hiddenDate.Split('|');
                    foreach (string hiddenWeekDay in hiddenDate_ar)
                    {
                        if (hiddenWeekDay == WeekDay)
                        {
                            e.Day.IsSelectable = false;
                            e.Cell.ForeColor = System.Drawing.Color.LightGray;
                            e.Cell.BackColor = System.Drawing.Color.WhiteSmoke;
                            LockSlot = "yes";
                            break;
                        }
                        else
                        {
                            LockSlot = "no";
                        }
                    }
                }

                if (LockSlot == "no")
                {
                    if (e.Day.IsSelected)
                    {
                        e.Cell.Text = e.Day.DayNumberText;
                        string dateSelect = e.Day.Date.ToString("yyyy-MM-dd");
                        txtH_bookdate.Value = dateSelect;
                        string timeStart = DateStart.ToString("HH:mm:ss");
                        txtH_bookTimeStart.Value = dateSelect + " " + timeStart;
                        string timeEnd = DateEnd.ToString("HH:mm:ss");
                        txtH_bookTimeEnd.Value = dateSelect + " " + timeEnd;

                        if (splittime == "0")
                        {
                            if (CounterBooking(id, dateSelect, "yes"))
                            {
                                txtH_booktime.Value = "00:00:00";
                            }
                            else
                            {
                                txtH_bookdate.Value = "";
                                txtH_booktime.Value = "";

                                e.Day.IsSelectable = false;
                                e.Cell.ForeColor = System.Drawing.Color.LightGray;
                                e.Cell.BackColor = System.Drawing.Color.WhiteSmoke;
                            }
                        }
                        else
                        {
                            TimeSlot(txtH_bookTimeStart.Value, txtH_bookTimeEnd.Value, splittime, splittimeUnit, breakSt, breakEn, maxqty, startAfterBreak);
                        }
                    }
                    else
                    {
                        string Limitfull = "";
                        if (splittime == "0")
                        {
                            if (CounterBooking(id, e.Day.Date.ToString("yyyy-MM-dd"), "no") == false)
                            {
                                Limitfull = "yes";
                            }
                        }
                        else
                        {
                            DateTime StartDate = DateTime.Parse(e.Day.Date.ToString());
                            if (CheckBookSlot(StartDate.ToString("yyyy-MM-dd HH:mm:ss")))
                            {
                                Limitfull = "yes";
                            }
                        }


                        if (Limitfull == "yes")
                        {
                            e.Day.IsSelectable = false;
                            e.Cell.ForeColor = System.Drawing.Color.LightGray;
                            e.Cell.BackColor = System.Drawing.Color.WhiteSmoke;
                        }
                        else
                        {
                            e.Cell.BackColor = System.Drawing.Color.LightGray;
                            e.Cell.Text = e.Day.DayNumberText;
                            e.Cell.Attributes.Add("OnClick", e.SelectUrl);
                        }
                    }
                }
            }

            if (Sync == "sync" && txtSync_empid.Value.ToString().Trim() != "")
            {
                string slot = Request.QueryString["slot"].ToString();
                string empid = txtSync_empid.Value.ToString().Trim();
                //string bookDate = txtH_bookdate.Value.ToString();
                string bookDate = cld_booking.SelectedDate.ToString("yyyy-MM-dd");
                string bookTime = txtH_booktime.Value.ToString();
                string bookDateTime = DateTime.Parse(bookDate + " " + bookTime).ToString("yyyy-MM-dd HH:mm:ss");
                callSync(slot, empid, bookDateTime);
                if (splittime != "0")
                {
                    TimeSlot(txtH_bookTimeStart.Value, txtH_bookTimeEnd.Value, splittime, splittimeUnit, breakSt, breakEn, maxqty, startAfterBreak);
                    if (txtH_booktime.Value != "")
                    {
                        string script = "SelectTime('" + txtH_booktimeID.Value + "','" + txtH_booktime.Value + "')";
                        ScriptManager.RegisterStartupScript(UpdatePanel_script, UpdatePanel_script.GetType(), "scriptUpdatePanal", script, true);
                    }
                }
                cld_booking.SelectedDate = DateTime.Parse(bookDate);
            }
        }

        public Boolean CounterBooking(string slot, string bookDate, string notify)
        {
            Boolean bl = false;

            string Qty = "";
            string Qtyless = "";
            string Qtymore = "";
            string AgeCondition = "";
            string AgeLess = "";
            string AgeMore = "";

            sql = "select * from bookingslot where bs_id = '" + slot + "' ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                AgeLess = dt.Rows[0]["bs_age_lessequal"].ToString();
                AgeMore = dt.Rows[0]["bs_age_moreequal"].ToString();

                AgeCondition = dt.Rows[0]["bs_age_condition"].ToString();
                if (AgeCondition == "yes")
                {
                    Qtyless = dt.Rows[0]["bs_age_lessequalqty"].ToString();
                    Qtymore = dt.Rows[0]["bs_age_moreequalqty"].ToString();

                    Qty = ( int.Parse(Qtyless) + int.Parse(Qtymore) ).ToString();
                }
                else
                {
                    Qty = dt.Rows[0]["bs_splittimeqty"].ToString();
                }
            }

            int CNT = 0;
            sql = "select * from bookingrecord where br_bsid='" + slot + "' and br_datetime like '" + bookDate + "%' and br_active='yes' ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            string alert = "";
            int balance = 0;
            lbl_TimeSlot.ForeColor = System.Drawing.Color.Blue;
            if (dt.Rows.Count > 0)
            {
                CNT = dt.Rows.Count;
            }
            balance = (int.Parse(Qty) - CNT);

            if (CNT >= int.Parse(Qty))
            {
                alert = "วันที่ " + cl_Sql.DateTH(bookDate) + " เต็มแล้ว !!";
                lbl_TimeSlot.ForeColor = System.Drawing.Color.Red;
                div_submit.Visible = false;
            }
            else
            {
                bl = true;
                if (AgeCondition == "yes")
                {
                    string balanceLess = "0";
                    string balanceMore = "0";

                    sql = "select ifnull(sum(if(convert(bd.bd_value,int) <= bs.bs_age_lessequal,1,0)),0) as 'balanceLess' " +
                        "\n,ifnull(sum(if (convert(bd.bd_value, int) >= bs.bs_age_moreequal,1,0)),0) as 'balanceMore' " +
                        "\nfrom bookingrecord as br " +
                        "\nleft join bookingslot as bs on br.br_bsid = bs.bs_id " +
                        "\nleft join bookingdetail as bd on br.br_id = bd.bd_brid " +
                        "\nwhere br.br_bsid='" + slot + "' and br.br_datetime like '" + bookDate + "%' and br.br_active='yes' " +
                        "\nand bd.bd_column = 'อายุ' ";
                    dt = new DataTable();
                    dt = cl_Sql.select(sql);
                    if (dt.Rows.Count > 0)
                    {
                        balanceLess = dt.Rows[0]["balanceLess"].ToString();
                        balanceLess = (int.Parse(Qtyless) - int.Parse(balanceLess)).ToString();
                        
                        balanceMore = dt.Rows[0]["balanceMore"].ToString();
                        balanceMore = (int.Parse(Qtymore) - int.Parse(balanceMore)).ToString();


                        if (dateSync_DOB.Value.ToString() != "")
                        {
                            DateTime DOB = DateTime.Parse(dateSync_DOB.Value.ToString());
                            int Age = cl_Sql.Date2YearOld(DOB);

                            if (Age <= int.Parse(AgeLess))
                            {
                                if (int.Parse(balanceLess) <= 0) { bl = false; }
                            }
                            if (Age >= int.Parse(AgeMore))
                            {
                                if (int.Parse(balanceMore) <= 0) { bl = false; }
                            }
                        }
                    }

                    alert = "อายุ <= " + AgeLess + " ปี เหลืออีก " + balanceLess.ToString() + " คน";
                    alert = alert + "<br />อายุ >= " + AgeMore + " ปี เหลืออีก " + balanceMore.ToString() + " คน";

                }
                else
                {
                    alert = "เหลืออีก " + balance.ToString() + " คน";
                }
            }

            if (notify != "yes")
            {
                alert = "";
            }
            else
            {
                lbl_TimeSlot.Text = alert;
                lbl_TimeSlot.Attributes.Add("style", "font-size: XX-Large;");
            }

            return bl;
        }

        public Boolean TimeSlot(string St, string En, string Sp, string SpUnit, string breakSt, string breakEn, int max, string startAfterBreak)
        {
            Boolean bl = false;

            if (max == 0)
            {
                max = 99999;
            }

            DateTime StartDate = DateTime.Parse(St);
            DateTime EndDate = DateTime.Parse(En);

            string Html = "";

            for (int i = 1; i <= max; i++)
            {
                if (StartDate <= EndDate)
                {
                    if (CheckBookSlot(StartDate.ToString("yyyy-MM-dd HH:mm:ss"))) 
                    { }
                    else
                    {
                        string hide = "no";

                        if (breakSt != "" && breakEn != "")
                        {
                            if (breakSt != "00:00:00" && breakEn != "00:00:00")
                            {
                                DateTime STbreak = DateTime.Parse(StartDate.ToString("yyyy-MM-dd") + " " + DateTime.Parse(breakSt).ToString("HH:mm:ss"));
                                DateTime ENbreak = DateTime.Parse(StartDate.ToString("yyyy-MM-dd") + " " + DateTime.Parse(breakEn).ToString("HH:mm:ss"));

                                if (STbreak <= StartDate && StartDate < ENbreak)
                                {
                                    hide = "yes";
                                    if (startAfterBreak == "yes") { startAfterBreak = "start"; }
                                }
                            }
                        }

                        if (hide == "yes")
                        {
                            i--;
                        }
                        else
                        {
                            Html = Html + "<a id=\"btn_slot_" + i.ToString() + "\" class=\"col-lg-2 col-sm-3 btn btn-outline-success mx-auto my-auto\" style=\"font-size:xx-large; cursor: pointer;\" onclick=\"SelectTime('" + i.ToString() + "','" + StartDate.ToShortTimeString() + "')\">" + StartDate.ToShortTimeString() + "</a> ";
                        }
                    }
                }
                else
                {
                    break;
                }

                if (SpUnit == "hour")
                {
                    StartDate = StartDate.AddHours(int.Parse(Sp));
                }
                else
                {
                    StartDate = StartDate.AddMinutes(int.Parse(Sp));
                }

                if (startAfterBreak == "start")
                {
                    StartDate = DateTime.Parse(StartDate.ToString("yyyy-MM-dd") + " " + DateTime.Parse(breakEn).ToString("HH:mm:ss"));

                    startAfterBreak = "stop";
                }
                
            }

            if (Html != "")
            {
                bl = true;
            }

            lbl_TimeSlot.Text = Html;

            return bl;
        }

        public Boolean CheckBookSlot(string bookDateTime)
        {
            Boolean bl = false;

            string slot = Request.QueryString["slot"].ToString();
            sql = "select * from bookingrecord as br " +
                "\nleft join bookingslot as bs on bs.bs_id=br.br_bsid " +
                "\nwhere br_active='yes' and br_bsid='" + slot + "' and br_datetime = '" + bookDateTime + "' ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                int CNT = int.Parse(dt.Rows[0]["bs_splittimeqty"].ToString());

                string AgeCondition = dt.Rows[0]["bs_age_condition"].ToString();
                if (AgeCondition == "yes")
                {
                    bl = true;

                    string AgeLess = dt.Rows[0]["bs_age_lessequal"].ToString();
                    string AgeMore = dt.Rows[0]["bs_age_moreequal"].ToString();
                    string lessqty = dt.Rows[0]["bs_age_lessequalqty"].ToString();
                    string moreqty = dt.Rows[0]["bs_age_moreequalqty"].ToString();
                    string lessmoreqty = (int.Parse(lessqty) + int.Parse(moreqty)).ToString();

                    int qtyless = 0;
                    int qtymore = 0;

                    sql = "select sum(if(bd_value<=" + AgeLess + ",1,0)) as 'less', sum(if(bd_value>=" + AgeMore + ",1,0)) as 'more' from bookingdetail " +
                        "where bd_column = 'อายุ' " +
                        "and bd_brid in (select br_id from bookingrecord where br_active='yes' and br_bsid = '" + slot + "' and br_datetime = '" + bookDateTime + "' ); ";
                    dt = new DataTable();
                    dt = cl_Sql.select(sql);
                    if (dt.Rows.Count > 0)
                    {
                        qtyless = int.Parse(dt.Rows[0]["less"].ToString());
                        qtymore = int.Parse(dt.Rows[0]["more"].ToString());
                        int qtylessmore = qtyless + qtymore;

                        if (dateSync_DOB.Value.ToString().Trim() == "")
                        {
                            if (int.Parse(lessmoreqty) <= qtylessmore)
                            {
                                bl = false;
                            }
                        }
                        else
                        {
                            DateTime DOB = DateTime.Parse(dateSync_DOB.Value.ToString());
                            int Age = cl_Sql.Date2YearOld(DOB);
                            if (Age <= int.Parse(AgeLess))
                            {
                                if (qtyless <= int.Parse(lessqty)) { bl = false; }
                            }
                            else if (Age >= int.Parse(AgeMore))
                            {
                                if (qtymore <= int.Parse(moreqty)) { bl = false; }
                            }
                            else
                            { }
                        }
                    }
                }
                else
                {
                    if (dt.Rows.Count >= CNT)
                    {
                        bl = true;
                    }
                }
            }

            return bl;
        }

        public Boolean Controler(string formID)
        {
            Boolean bl = false;

            sql = "select * from bookingforminput where bfi_bfid = '" + formID + "' order by bfi_index ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                string HTML = "";
                for (int i=0; i<dt.Rows.Count; i++)
                {
                    string inputID = dt.Rows[i]["bfi_id"].ToString();
                    string type = dt.Rows[i]["bfi_type"].ToString();
                    string index = dt.Rows[i]["bfi_index"].ToString();
                    string title = dt.Rows[i]["bfi_title"].ToString();
                    string placeholder = dt.Rows[i]["bfi_placeholder"].ToString();

                    if (HTML == "") { HTML = HTML + "<div class=\"col-12 mx-auto\"><hr></div>"; }
                    HTML = HTML + MConT.Controler(inputID, type, index, title, placeholder);
                    HTML = HTML + "<div class=\"col-12 mx-auto\"><hr></div>";
                }
                lbl_controler.Text = HTML;
            }

            return bl;
        }

        protected void btn_Sync_Click(object sender, EventArgs e)
        {
            string slot = Request.QueryString["slot"].ToString();
            string empid = txtSync_empid.Value.ToString().Trim();
            string bookDate = txtH_bookdate.Value.ToString();
            string bookTime = txtH_booktime.Value.ToString();

            if (bookDate == "" || bookTime == "")
            {
                lbl_alert.Text = "กรุณาเลือกวันเวลาที่ต้องการจอง แล้วลองใหม่อีกครั้ง !!";
                lbl_alert.ForeColor = System.Drawing.Color.Red;
            }
            else
            {
                string bookDateTime = DateTime.Parse(bookDate + " " + bookTime).ToString("yyyy-MM-dd HH:mm:ss");
                callSync(slot, empid, bookDateTime);
            }
        }

        private void callSync(string slot, string empid, string bookDate)
        {
            string result = empSync(slot, empid, bookDate);
            if (result == "success")
            {
                lbl_alert.Text = "";
                lblSync_alert.Text = "";
                div_Sync.Visible = true;
                div_submit.Visible = true;
            }
            else
            {
                txtSync_fullname.Value = "";
                dateSync_DOB.Value = "";
                lblSync_program.Text = "";
                div_Sync.Visible = false;
                div_program.Visible = false;
                div_submit.Visible = false;

                lblSync_alert.Text = result;
            }
            cld_booking.SelectedDate = DateTime.Parse(bookDate);
        }

        protected string empSync(string slot, string empid, string bookDate)
        {
            string result = "";

            string cpid = "";
            string DuplicateNextDay = "";
            sql = "select * from bookingslot where bs_id='" + slot + "' ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                if(dt.Rows[0]["bs_duplicatenextday"].ToString() == "yes") // Can Book Duplicate Next Day
                {
                    DuplicateNextDay = "and br_datetime = convert('" + bookDate + "', datetime) ";
                }
                cpid = dt.Rows[0]["bs_cpid"].ToString();
            }

            sql = "select * from company_employee where ce_active='yes' and ce_cp_id='" + cpid + "' and ce_empid='" + empid + "' ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                string fullname = dt.Rows[0]["ce_name_th"].ToString();
                string DOB = "";
                if (dt.Rows[0]["ce_dob"].ToString() != "")
                {
                    DOB = DateTime.Parse(dt.Rows[0]["ce_dob"].ToString()).ToString("yyyy-MM-dd");
                }
                string program = dt.Rows[0]["ce_program"].ToString();

                sql = "select * from bookingdetail where bd_bfiid=0 and bd_brid in (select br_id from bookingrecord where br_active='yes' and br_bsid='" + slot + "' " + DuplicateNextDay + ") and bd_value='" + empid + "'; ";
                dt = new DataTable();
                dt = cl_Sql.select(sql);
                if (dt.Rows.Count > 0)
                {
                    txtSync_empid.Value = empid;
                    result = "ท่านได้ทำการจองในวันที่เลือกไว้แล้ว ไม่สามารถทำซ้ำได้ !!";
                }
                else
                {
                    txtSync_fullname.Value = fullname;
                    dateSync_DOB.Value = DOB;
                    if (DOB != "")
                    {
                        lbl_age.Text = "อายุ " + cl_Sql.Date2YearOld(DateTime.Parse(DOB)).ToString() + " ปี";
                    }

                    if (program != "")
                    {
                        div_program.Visible = true;
                        lblSync_program.Text = program;
                    }

                    result = "success";
                    lblSync_alert.Text = "";
                }
            }
            else
            {
                result = "ไม่พบข้อมูล !!";
            }
            cld_booking.SelectedDate = DateTime.Parse(bookDate);

            return result;
        }

        public Boolean checkDuplicate(string DuplicateNextDay, string slot, string empid, string bookDate)
        {
            Boolean bl = false;

            if (DuplicateNextDay == "yes") 
            { 
                DuplicateNextDay = "and br_datetime = convert('" + bookDate + "', datetime) "; 
            }
            else
            {
                DuplicateNextDay = "";
            }

            sql = "select * from bookingdetail where bd_bfiid=0 and bd_brid in (select br_id from bookingrecord where br_active='yes' and br_bsid='" + slot + "' " + DuplicateNextDay + ") and bd_value='" + empid + "'; ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                bl = true;
            }

            return bl;
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            lbl_alert.Text = "";

            string slot = Request.QueryString["slot"].ToString();
            string key = Request.QueryString["key"].ToString();

            string bookDate = txtH_bookdate.Value.ToString();
            string bookTime = txtH_booktime.Value.ToString();

            if (bookDate == "" || bookTime == "")
            {
                lbl_alert.Text = "กรุณาเลือกวันเวลาที่ต้องการจอง !!";
            }
            else
            {
                string next = "Yes";
                string SQLs = "";
                string replace = key + "_" + cl_Sql.GenerateKey(4);

                string bookDateTime = DateTime.Parse(bookDate + " " + bookTime).ToString("yyyy-MM-dd HH:mm:ss");

                sql = "select * from bookingforminput " +
                    "where bfi_bfid in (select bs_bfid from bookingslot where bs_id = '" + slot + "') order by bfi_index ";
                dt = new DataTable();
                dt = cl_Sql.select(sql);
                if (dt.Rows.Count > 0)
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        string ConTID = dt.Rows[i]["bfi_id"].ToString();
                        string type = dt.Rows[i]["bfi_type"].ToString();
                        string index = dt.Rows[i]["bfi_index"].ToString();
                        string required = dt.Rows[i]["bfi_required"].ToString();

                        string input = "";
                        string conID = "conT_" + index;
                        if (type == "checkbox")
                        {
                            sql = "select * from bookingforminputlist where bfil_bfiid = '" + ConTID + "' ";
                            DataTable dt2 = new DataTable();
                            dt2 = cl_Sql.select(sql);
                            if (dt2.Rows.Count > 0)
                            {
                                for (int j = 0; j < dt2.Rows.Count; j++)
                                {
                                    string checkboxID = conID + "_" + dt2.Rows[j]["bfil_index"].ToString();
                                    string value = String.Format("{0}", Request.Form[checkboxID]);
                                    if (input != "" && value != "") { input = input + ","; }
                                    input = input + value;
                                }
                            }
                        }
                        else
                        {
                            input = String.Format("{0}", Request.Form[conID]);
                        }
                        if (required == "yes" && input.Trim() == "")
                        {
                            next = "Null";
                        }
                        else
                        {
                            SQLs = SQLs + "insert into bookingdetail(bd_brid, bd_bfiid, bd_value) values(" + replace + ", " + ConTID + ", '" + input.Trim() + "'); \n";
                        }
                    }
                }

                if (next == "Null")
                {
                    lbl_alert.Text = "กรุณากรอกข้อมูลให้ครบถ้วน !!";
                    lbl_alert.ForeColor = System.Drawing.Color.Red;
                }
                else
                {
                    string id = Request.QueryString["slot"].ToString();
                    string splittime = txtH_splittime.Value.ToString().Trim();
                    string splittimeQty = txtH_splittimeQty.Value.ToString().Trim();
                    string Limitfull = "";
                    if (splittime == "0") // Condition No splittime
                    {
                        if (CounterBooking(id, bookDateTime, "no") == false)
                        {
                            Limitfull = "yes";
                        }
                    }
                    else // Condition for splittime
                    {
                        DateTime SelectDate = DateTime.Parse(bookDateTime);
                        if (CheckBookSlot(SelectDate.ToString("yyyy-MM-dd HH:mm:ss")))
                        {
                            Limitfull = "yes";
                        }
                    }


                    if (Limitfull == "yes")
                    {
                        lbl_alert.Text = "วันเวลาที่ทำการจองเต็มแล้ว กรุณาเลือกวันเวลาอื่น !!";
                        lbl_alert.ForeColor = System.Drawing.Color.Red;
                        lbl_TimeSlot.Text = "";
                    }
                    else
                    {
                        string alert = "ไม่สามารถบันทึกการจองได้ กรุณาติดต่อผู้ดูแลระบบ !!";
                        lbl_alert.ForeColor = System.Drawing.Color.Red;

                        string Key = cl_Sql.GenerateKey(5);

                        string br_id = "";
                        string sqlSync = "";
                        string saveStaus = "no";

                        sql = "select bs_duplicatenextday, bs_sync from bookingslot where bs_id = '" + slot + "'";
                        dt = new DataTable();
                        dt = cl_Sql.select(sql);
                        if (dt.Rows.Count > 0)
                        {
                            string duplicatenextday = dt.Rows[0]["bs_duplicatenextday"].ToString();
                            string sync = dt.Rows[0]["bs_sync"].ToString();
                            if (sync == "sync")
                            {
                                string Sync_empid = txtSync_empid.Value.ToString().Trim();
                                string Sync_fullname = txtSync_fullname.Value.ToString().Trim();

                                string resultSync = empSync(slot, Sync_empid, bookDate);

                                if (resultSync == "success")
                                {
                                    if (checkDuplicate(duplicatenextday, slot, Sync_empid, bookDate))
                                    {
                                        saveStaus = "duplicate";
                                    }
                                    else
                                    {
                                        sqlSync = sqlSync + "insert into bookingdetail(bd_brid, bd_bfiid, bd_value, bd_column) values(" + replace + ", 0, '" + Sync_empid + "', 'รหัสพนักงาน'); ";
                                        sqlSync = sqlSync + "insert into bookingdetail(bd_brid, bd_bfiid, bd_value, bd_column) values(" + replace + ", 0, '" + Sync_fullname + "', 'ชื่อ-นามสกุล'); ";

                                        if (dateSync_DOB.Value.ToString() != "")
                                        {
                                            //string Sync_DOB = DateTime.Parse(dateSync_DOB.Value.ToString()).ToString("yyyy-MM-dd");
                                            //sqlSync = sqlSync + "insert into bookingdetail(bd_brid, bd_bfiid, bd_value, bd_column) values(" + replace + ", 0, '" + Sync_DOB + "', 'วันเกิด'); ";
                                            int Age = cl_Sql.Date2YearOld(DateTime.Parse(dateSync_DOB.Value.ToString()));
                                            sqlSync = sqlSync + "insert into bookingdetail(bd_brid, bd_bfiid, bd_value, bd_column) values(" + replace + ", 0, '" + Age + "', 'อายุ'); ";
                                        }

                                        string Sync_program = lblSync_program.Text;
                                        sqlSync = sqlSync + "insert into bookingdetail(bd_brid, bd_bfiid, bd_value, bd_column) values(" + replace + ", 0, '" + Sync_program + "', 'โปรแกรมที่ตรวจ'); ";

                                        sql = "insert into bookingrecord(br_bsid, br_datetime,br_key) values('" + slot + "','" + bookDateTime + "','" + Key + "') ";
                                        if (cl_Sql.Modify(sql))
                                        {
                                            sql = "select * from bookingrecord where br_key = '" + Key + "' ";
                                            dt = new DataTable();
                                            dt = cl_Sql.select(sql);
                                            if (dt.Rows.Count > 0)
                                            {
                                                br_id = dt.Rows[0]["br_id"].ToString();
                                                saveStaus = "yes";
                                            }
                                            else
                                            {
                                                saveStaus = "NoDetails";
                                            }
                                        }
                                    }
                                }
                                else
                                {
                                    saveStaus = "NoEmp";
                                }
                            }
                        }

                        if (saveStaus == "yes")
                        {
                            SQLs = sqlSync + SQLs;
                            if (SQLs == "")
                            {
                                alert = "success";
                            }
                            else
                            {
                                SQLs = SQLs.Replace(replace, br_id);
                                if (cl_Sql.Modify(SQLs))
                                {
                                    alert = "success";

                                }
                            }

                            if (alert == "success")
                            {
                                lbl_alert.ForeColor = System.Drawing.Color.Green;
                                Response.Redirect("Booking.aspx?key=" + key + "&slot=" + slot + "&bsid=" + br_id + "&success=yes");
                            }
                        }
                        else
                        {
                            lbl_alert.ForeColor = System.Drawing.Color.Red;
                            if (saveStaus == "NoEmp")
                            {
                                alert = "รหัสพนักงานไม่ถูกต้อง !!";
                            }
                            else if (saveStaus == "duplicate")
                            {
                                alert = "ไม่สามารถจองซ้ำในวันเดียวกันได้ กรุณาเลือกวันอื่นๆ !!";
                            }
                            else if (saveStaus == "NoDetails")
                            {
                                alert = "บันทึกการจองแล้ว เลขที่[" + br_id + "] แต่ไม่สามารถบันทึกรายละเอียดได้ กรุณาติดต่อผู้ดูแลระบบ !!";
                            }
                            else
                            {
                                alert = "ไม่สามารถบันทึกข้อมูลได้ กรุณาติดต่อผู้ดูแลระบบ !!";
                            }
                        }

                        lbl_alert.Text = alert;
                    }
                }
            }
        }

        public override void VerifyRenderingInServerForm(Control control)
        {
            /* Confirms that an HtmlForm control is rendered for the specified ASP.NET
          server control at run time. */
        }
    }
}