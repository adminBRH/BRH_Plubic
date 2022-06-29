using System;
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

        string CheckCode = "";

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

                if (!IsPostBack)
                {
                    DataState(slot, key);
                    DataLoad(slot, key);
                    DataHybrid(slot, key);
                }

                if (Session["status"] == null)
                {
                    VIPSlot(slot);
                }

                if (Request.QueryString["permiss"] == null)
                {
                    string url = HttpContext.Current.Request.Url.AbsoluteUri;
                    Response.Redirect(url + "&permiss=yes");
                }
                else
                {
                    if (CheckKey(slot, key))
                    {
                        if (!LimitTimeBook(slot))
                        {
                            string scModal = "";
                            scModal = "fn_AlertModal('Warning','ขออภัยวันนี้ระบบปิดให้ทำการจองแล้ว กรุณากลับมาใหม่ในวันถัดไป !','../Default.aspx',5000);";
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
                        }
                        else
                        {
                            if (!IsPostBack)
                            {
                                AlertSubmit(slot);
                            }

                            string empid = txtSync_empid.Value.ToString().Trim();
                            if (empid != "")
                            {
                                string bookDate = txtH_bookdate.Value.ToString();
                                string bookTime = txtH_booktime.Value.ToString();
                                string bookDateTime = DateTime.Parse(bookDate + " " + bookTime).ToString("yyyy-MM-dd HH:mm:ss");

                                callSync(slot, empid, bookDateTime);
                            }

                        }
                    }
                    else
                    {
                        Response.Redirect("../Default.aspx");
                    }
                }
            }
        }

        private void DataState(string id, string key)
        {
            sql = "select * from bookingslot where bs_id='" + id + "' and bs_key='" + key + "' ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            //Session["dt_bookingslot"] = dt;
            ViewState["bookingslot"] = dt;

            sql = "select * from company_employee where ce_active='yes' and ce_cp_id in (select bs_cpid from bookingslot where bs_id = '" + id+ "') ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            //Session["dt_company_employee"] = dt;
            ViewState["company_employee"] = dt;

            sql = "select * from bookingforminput where bfi_bfid in (select bs_bfid from bookingslot where bs_id = '" + id + "') order by bfi_index";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            //Session["dt_bookingforminput"] = dt;
            ViewState["bookingforminput"] = dt;

            sql = "select * from bookingslot_manual " +
                "\nwhere bsm_active='yes' and bsm_bsid='" + id + "' " +
                "\norder by bsm_time_st ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            //Session["dt_bookingslot_manual"] = dt;
            ViewState["bookingslot_manual"] = dt;
        }

        private void DataLoad(string id, string key)
        {
            sql = "select *,convert(br_datetime, date) as 'br_date' from bookingrecord where br_bsid='" + id + "' and br_active='yes' ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            //Session["dt_bookingrecord"] = dt;
            ViewState["bookingrecord"] = dt;

            sql = "select convert(br_datetime,date) as 'br_date', count(br_id) as 'br_count' " +
                "\nfrom bookingrecord where br_active='yes' and br_bsid='" + id + "' " +
                "\ngroup by convert(br_datetime,date) ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            //Session["dt_bookingrecordCount"] = dt;
            ViewState["bookingrecordCount"] = dt;

            sql = "select ifnull(sum(if(convert(bd.bd_value,decimal(11,0)) <= bs.bs_age_lessequal,1,0)),0) as 'balanceLess' " +
                "\n,ifnull(sum(if (convert(bd.bd_value, decimal(11,0)) >= bs.bs_age_moreequal,1,0)),0) as 'balanceMore' " +
                "\nfrom bookingrecord as br " +
                "\nleft join bookingslot as bs on br.br_bsid = bs.bs_id " +
                "\nleft join bookingdetail as bd on br.br_id = bd.bd_brid " +
                "\nwhere br.br_bsid='" + id + "' and br.br_active='yes' " +
                "\nand bd.bd_column = 'อายุ' ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            //Session["dt_bookingSlotDetail"] = dt;
            ViewState["bookingSlotDetail"] = dt;

            sql = "select *,convert(br_datetime,date) as 'br_date' from bookingrecord as br " +
                "\nleft join bookingslot as bs on bs.bs_id=br.br_bsid " +
                "\nwhere br_active='yes' and br_bsid='" + id + "' ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            //Session["dt_bookingRecordSlot"] = dt;
            ViewState["bookingRecordSlot"] = dt;
        }

        private void DataHybrid(string id, string key)
        {
            string DuplicateNextDay = "";

            string bookDate = txtH_bookdate.Value.ToString();
            if (bookDate != "")
            {
                dt = new DataTable();
                dt = ViewState["bookingslot"] as DataTable;
                if (dt.Rows.Count > 0)
                {
                    if (dt.Rows[0]["bs_duplicatenextday"].ToString() == "yes") // Can Book Duplicate Next Day
                    {
                        DuplicateNextDay = "and br_datetime = convert('" + bookDate + "', datetime) ";
                    }
                }

                sql = "select * from bookingdetail where bd_bfiid=0 and bd_brid in (select br_id from bookingrecord where br_active='yes' and br_bsid='" + id + "' " + DuplicateNextDay + "); ";
                dt = new DataTable();
                dt = cl_Sql.select(sql);
            }
            else
            {
                dt = new DataTable();
                dt = null;
            }
            //Session["dt_bookingdetail_bfiid0"] = dt;
            ViewState["bookingdetail_bfiid0"] = dt;
        }

        protected void VIPSlot(string slot)
        {
            if (slot == "59")
            {
                Response.Redirect("LimitOver"); // Full slot

                string companyID = "";
                if (Request.QueryString["co"] != null)
                {
                    companyID = Request.QueryString["co"].ToString();
                }
                string privateID = "";
                if (Request.QueryString["privateid"] != null)
                {
                    privateID = Request.QueryString["privateid"].ToString();
                }

                string next = "no";
                if (companyID != "" && privateID != "")
                {
                    if (PrivateKey(companyID, privateID))
                    {
                        next = "yes";
                    }
                }

                if (next == "yes")
                {
                    if (!IsPostBack)
                    {
                        string now = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
                        if (!LimitUser(slot, now))
                        {
                            Response.Redirect("../CHK/LimitOver");
                        }
                    }
                }
                else
                {
                    Response.Redirect("../VaccineCovid/Lot1Confirm");
                }
            }
        }

        protected Boolean LimitUser(string slot, string now)
        {
            Boolean bl = false;

            if (Session["onlineUser"] != null)
            {
                bl = true;
            }
            else
            {
                sql = "select bl_id,bl_count,bl_limit from bookinglimit " +
                    "\nwhere bl_bsid='" + slot + "' " +
                    "\nand (bl_timest <= convert('" + now + "', datetime) and convert('" + now + "', datetime) <= bl_timeen) ";
                dt = new DataTable();
                dt = cl_Sql.select(sql);
                if (dt.Rows.Count > 0)
                {
                    string id = dt.Rows[0]["bl_id"].ToString();
                    int count = int.Parse(dt.Rows[0]["bl_count"].ToString());
                    int limit = int.Parse(dt.Rows[0]["bl_limit"].ToString());
                    if (count < limit)
                    {
                        Session.Timeout = 10;
                        Session["onlineUser"] = id;

                        sql = "update bookinglimit set bl_count = '" + (count + 1) + "' where bl_id = '" + id + " ' ";
                        if (cl_Sql.Modify(sql))
                        {
                            bl = true;
                        }

                    }
                }
            }

            return bl;
        }

        public Boolean PrivateKey(string cpid, string id)
        {
            Boolean bl = false;

            sql = "select ce_active from company_employee where ce_active='yes' and ce_cp_id='" + cpid + "' and ce_empid='" + id + "' ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                if (dt.Rows[0]["ce_active"].ToString() == "yes")
                {
                    bl = true;
                }
            }

            return bl;
        }

        private Boolean CheckKey(string id, string key)
        {
            Boolean bl = false;

            sql = "select * from bookingslot where bs_id = '" + id + "' and bs_key = '" + key + "' ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                string dateSelect = DateTime.Parse(cld_booking.SelectedDate.ToString()).ToString("yyyy-MM-dd");
                //lbl_test.Text = dateSelect;

                DateTime curDate = DateTime.Now;
                DateTime stDate = DateTime.Parse(dt.Rows[0]["bs_startdate"].ToString());
                if (dateSelect == "0001-01-01") // No Select date
                {
                    if (stDate.Date > curDate.Date)
                    {
                        string DateSelect = stDate.ToString("yyyy-MM-dd");
                        cld_booking.SelectedDate = Convert.ToDateTime(DateSelect);
                        cld_booking.VisibleDate = cld_booking.SelectedDate;
                    }
                }

                string NameSlot = dt.Rows[0]["bs_name"].ToString();
                string DetailSlot = dt.Rows[0]["bs_alertonform"].ToString();
                lbl_Title.Text = NameSlot;
                lbl_Detail.Text = DetailSlot;
                bl = true;

                if (dt.Rows[0]["bs_sync"].ToString() == "sync")
                {
                    lbl_syncName.Text = dt.Rows[0]["bs_syncname"].ToString();
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
                            string text = "วันที่จอง " + bookDate + " " + bookTime;
                            if (slotID == "59")
                            {
                                string nextDate = DateTime.Parse(bookDateTime).AddDays(28).ToString("dd MMM yyyy");
                                string cpid = Request.QueryString["co"].ToString();
                                string empid = Request.QueryString["privateid"].ToString();
                                int VaccineQTY = 0;
                                sql = "select ce_vaccine from company_employee " +
                                    "\nwhere ce_active='yes' and ce_empid='" + empid + "' and ce_cp_id = '" + cpid + "' ";
                                dt = new DataTable();
                                dt = cl_Sql.select(sql);
                                if (dt.Rows.Count > 0)
                                {
                                    VaccineQTY = int.Parse(dt.Rows[0]["ce_vaccine"].ToString());
                                }
                                if (VaccineQTY > 1)
                                {
                                    text += "<br /><br />ครั้งถัดไปวันที่ " + nextDate;
                                }
                            }
                            lbl_KeyRecord.Text = text;
                        }

                        lbl_script.Text = "<script>alertModal('#ModalAlertSubmit');</script>";
                    }
                }
            }
            else
            {
                if (Request.QueryString["co"] != null && Request.QueryString["privateid"] != null)
                {
                    string companyID = Request.QueryString["co"].ToString().Trim();
                    string privateID = Request.QueryString["privateid"].ToString().Trim();
                    txtSync_empid.Value = privateID;
                    Sync();
                    btn_Sync.Visible = false;
                }
            }
        }

        protected void cld_booking_DayRender(object sender, DayRenderEventArgs e)
        {
            //lblTest.Text = " ***" + cld_booking.SelectedDate.ToString() + "*** ";
            string cldSelectDate = DateTime.Parse(cld_booking.SelectedDate.ToString()).ToString("yyyy-MM-dd");
            txtH_bookdate.Value = cldSelectDate;
            if (txtH_booktime.Value == "")
            {
                txtH_booktime.Value = "00:00:00";
            }

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
            int preDate = 0;
            DateTime CloseTime = DateTime.Now.AddDays(1);
            string CloseTimeTXT = CloseTime.ToString();

            string Sync = "";
            string ahead = "";

            string id = Request.QueryString["slot"].ToString();
            string key = Request.QueryString["key"].ToString();

            string hiddenDate = "";

            //sql = "select * from bookingslot where bs_id='" + id + "' and bs_key='" + key + "' ";
            //dt = new DataTable();
            //dt = cl_Sql.select(sql);

            dt = new DataTable();
            dt = ViewState["bookingslot"] as DataTable;

            if (dt.Rows.Count > 0)
            {
                Sync = dt.Rows[0]["bs_sync"].ToString();
                ahead = dt.Rows[0]["bs_ahead"].ToString();

                DateStart = DateTime.Parse(dt.Rows[0]["bs_startdate"].ToString());
                string DS = DateStart.ToString("yyyy-MM-dd HH:mm:ss");
                DateEnd = DateTime.Parse(dt.Rows[0]["bs_enddate"].ToString());
                string DE = DateEnd.ToString("yyyy-MM-dd HH:mm:ss");
                if (dt.Rows[0]["bs_break_startdate"].ToString() != "" && dt.Rows[0]["bs_break_enddate"].ToString() != "")
                {
                    breakSt = dt.Rows[0]["bs_break_startdate"].ToString();
                    if (breakSt != "")
                    {
                        breakSt = DateTime.Parse(breakSt).ToString("HH:mm:ss");
                    }
                    breakEn = dt.Rows[0]["bs_break_enddate"].ToString();
                    if (breakEn != "")
                    {
                        breakEn = DateTime.Parse(breakEn).ToString("HH:mm:ss");
                    }
                    startAfterBreak = dt.Rows[0]["bs_startaftetbreak"].ToString();
                }
                hiddenDate = dt.Rows[0]["bs_hiddendate"].ToString();
                splittime = dt.Rows[0]["bs_splittime"].ToString();
                txtH_splittime.Value = splittime;
                splittimeUnit = dt.Rows[0]["bs_splittimeunit"].ToString();
                if (splittimeUnit != "manual" && splittime == "0")
                {
                    div_bookdate.Attributes.Remove("hidden");
                    lbl_bookDate.Text = cl_Sql.DateTH(cldSelectDate);
                }
                else
                {
                    div_bookdate.Attributes.Add("hidden", "hidden");
                    lbl_bookDate.Text = "";
                }
                
                qty = dt.Rows[0]["bs_splittimeqty"].ToString();
                if (dt.Rows[0]["bs_maxqty"].ToString() != "")
                {
                    maxqty = int.Parse(dt.Rows[0]["bs_maxqty"].ToString());
                }
                txtH_splittimeQty.Value = qty;
                formID = dt.Rows[0]["bs_bfid"].ToString();

                preDate = int.Parse(dt.Rows[0]["bs_predate"].ToString());
                DateNow = DateNow.AddDays(preDate);

                string limitTime = dt.Rows[0]["bs_limittime"].ToString();
                if (limitTime != "")
                {
                    CloseTime = DateTime.Parse(DateNow.ToString("yyyy-MM-dd") + " " + limitTime);
                }
                CloseTimeTXT = CloseTime.ToString("yyyy-MM-dd HH:mm:ss");

                string CreateConT = txtH_CreateConT.Value.ToString();
                if (CreateConT == "")
                {
                    Controler(formID);
                    CreateConT = "Yes";
                }
            }

            DateTime Eday = DateTime.Parse(e.Day.Date.ToString("yyyy-MM-dd"));
            string E_day = Eday.ToString("yyyy-MM-dd");
            string DateStartTXT = DateStart.ToString("yyyy-MM-dd");
            string DateEndTXT = DateEnd.ToString("yyyy-MM-dd");

            string hideDate = "no";
            if (Eday < DateNow) 
            {
                hideDate = "yes";
            }
            else
            {
                if (Eday.Date < DateStart.Date)
                {
                    hideDate = "yes";
                }
                else
                {
                    if (Eday.Date > DateEnd.Date)
                    {
                        hideDate = "yes";
                    }
                    else
                    {
                        hideDate = "no";
                    }
                }
            }

            if (hideDate == "yes")
            {
                e.Day.IsSelectable = false;
                e.Cell.ForeColor = System.Drawing.Color.LightGray;
                e.Cell.BackColor = System.Drawing.Color.WhiteSmoke;
            }
            else
            {
                e.Day.IsSelectable = true;

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
                    //CheckCode += E_day + " == " + cldSelectDate; // ------------------------------- CheckCode
                    if (e.Day.IsSelected)
                    //if (E_day == cldSelectDate)
                    {
                        //CheckCode += " Yes <br>";
                        e.Cell.Text = e.Day.DayNumberText;
                        string dateSelect = e.Day.Date.ToString("yyyy-MM-dd");
                        txtH_bookdate.Value = dateSelect;
                        string timeStart = DateStart.ToString("HH:mm:ss");
                        txtH_bookTimeStart.Value = dateSelect + " " + timeStart;
                        string timeEnd = DateEnd.ToString("HH:mm:ss");
                        txtH_bookTimeEnd.Value = dateSelect + " " + timeEnd;
                        //CheckCode += "St:" + txtH_bookTimeStart.Value + "<br>En:" + txtH_bookTimeEnd.Value + "<br>";
                        txtH_TimeSlot.Value = "yes";

                        if (splittimeUnit == "manual")
                        {
                            if (!ManualSlot(id, dateSelect, CloseTimeTXT))
                            {
                                lbl_TimeSlot.Text = "<font size='20px;'>เต็มแล้ว !!</font>";
                                lbl_TimeSlot.ForeColor = System.Drawing.Color.Red;
                            }
                        }
                        else
                        {

                        }

                        //-----------------------------------
                        if (splittime == "0")
                        {
                            txtH_TimeSlot.Value = "no";
                            //CheckCode += "e.Day.Select:" + dateSelect + "<br>";
                            if (CounterBooking(id, dateSelect, "yes"))
                            {
                                txtH_booktime.Value = "00:00:00";
                            }
                            else
                            {
                                lbl_ManualSlot.Text = "";

                                txtH_bookdate.Value = "";
                                txtH_booktime.Value = "";

                                e.Day.IsSelectable = false;
                                e.Cell.ForeColor = System.Drawing.Color.LightGray;
                                e.Cell.BackColor = System.Drawing.Color.WhiteSmoke;
                            }
                        }
                        else
                        {
                            lbl_bookDate.Text = "วันที่จองคือ : " + cldSelectDate;

                            TimeSlot(txtH_bookTimeStart.Value, txtH_bookTimeEnd.Value, splittime, splittimeUnit, breakSt, breakEn, maxqty, startAfterBreak, CloseTime);
                        }
                        //-----------------------------------
                    }
                    else
                    {
                        //CheckCode += " No <br>";
                        string Limitfull = "";

                        if (splittimeUnit == "manual")
                        {
                            if (!CountRecord(id, e.Day.Date.ToString("yyyy-MM-dd"), 0))
                            {
                                Limitfull = "yes";
                            }
                        }
                        else
                        {
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
                            //e.Cell.Attributes.Add("onclick","alert('"+ e.Day.Date +"')");
                            e.Cell.Attributes.Add("style", "cursor: pointer;");
                            //CheckCode += e.SelectUrl + "<br>";
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
                //callSync(slot, empid, bookDateTime);
                if (splittime != "0")
                {
                    TimeSlot(txtH_bookTimeStart.Value, txtH_bookTimeEnd.Value, splittime, splittimeUnit, breakSt, breakEn, maxqty, startAfterBreak, CloseTime);
                    if (txtH_booktime.Value != "")
                    {
                        string script = "SelectTime('" + txtH_booktimeID.Value + "','" + txtH_booktime.Value + "')";
                        ScriptManager.RegisterStartupScript(UpdatePanel_script, UpdatePanel_script.GetType(), "scriptUpdatePanal", script, true);
                    }
                }
                cld_booking.SelectedDate = DateTime.Parse(bookDate);
            }

            lbl_check.Text = CheckCode;
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
            string Unit = "";

            //sql = "select * from bookingslot where bs_id = '" + slot + "' ";
            //dt = new DataTable();
            //dt = cl_Sql.select(sql);

            dt = new DataTable();
            dt = ViewState["bookingslot"] as DataTable;

            if (dt.Rows.Count > 0)
            {
                AgeLess = dt.Rows[0]["bs_age_lessequal"].ToString();
                AgeMore = dt.Rows[0]["bs_age_moreequal"].ToString();

                AgeCondition = dt.Rows[0]["bs_age_condition"].ToString();
                if (AgeCondition == "yes")
                {
                    Qtyless = dt.Rows[0]["bs_age_lessequalqty"].ToString();
                    Qtymore = dt.Rows[0]["bs_age_moreequalqty"].ToString();

                    Qty = (int.Parse(Qtyless) + int.Parse(Qtymore)).ToString();
                }
                else
                {
                    Qty = dt.Rows[0]["bs_splittimeqty"].ToString();

                    Unit = dt.Rows[0]["bs_splittimeunit"].ToString();
                    if (Unit == "manual")
                    {
                        if (Session["QuotaManualBooking"] != null)
                        {
                            Qty = Session["QuotaManualBooking"].ToString();
                            Session.Remove("QuotaManualBooking");
                        }  
                    }
                }
            }

            int CNT = 0;
            //sql = "select * from bookingrecord where br_bsid='" + slot + "' and br_datetime like '" + bookDate + "%' and br_active='yes' ";
            //dt = new DataTable();
            //dt = cl_Sql.select(sql);

            dt = new DataTable();
            dt = ViewState["bookingrecord"] as DataTable;
            int RowCount = 0;
            try
            {
                dt = dt.Select("br_date = '" + bookDate + "'").CopyToDataTable();
                RowCount = dt.Rows.Count;
            }
            catch { }

            string alert = "";
            int balance = 0;
            lbl_TimeSlot.ForeColor = System.Drawing.Color.Blue;
            if (RowCount > 0)
            {
                CNT = RowCount;
            }
            balance = (int.Parse(Qty) - CNT);

            if (CNT >= int.Parse(Qty))
            {
                //alert = "วันที่ " + cl_Sql.DateTH(bookDate) + " เต็มแล้ว !!";
                alert = "วันที่เลือก เต็มแล้ว !!";
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


                    //sql = "select ifnull(sum(if(convert(bd.bd_value,decimal(11,0)) <= bs.bs_age_lessequal,1,0)),0) as 'balanceLess' " +
                    //    "\n,ifnull(sum(if (convert(bd.bd_value, decimal(11,0)) >= bs.bs_age_moreequal,1,0)),0) as 'balanceMore' " +
                    //    "\nfrom bookingrecord as br " +
                    //    "\nleft join bookingslot as bs on br.br_bsid = bs.bs_id " +
                    //    "\nleft join bookingdetail as bd on br.br_id = bd.bd_brid " +
                    //    "\nwhere br.br_bsid='" + slot + "' and br.br_datetime like '" + bookDate + "%' and br.br_active='yes' " +
                    //    "\nand bd.bd_column = 'อายุ' ";
                    //dt = new DataTable();
                    //dt = cl_Sql.select(sql);

                    dt = new DataTable();
                    dt = ViewState["bookingSlotDetail"] as DataTable;
                    RowCount = 0;
                    try
                    {
                        dt = dt.Select("br_datetime like '" + bookDate + "%'").CopyToDataTable();
                        RowCount = dt.Rows.Count;
                    }
                    catch { }

                    if (RowCount > 0)
                    {
                        balanceLess = dt.Rows[0]["balanceLess"].ToString();
                        balanceLess = (int.Parse(Qtyless) - int.Parse(balanceLess)).ToString();

                        balanceMore = dt.Rows[0]["balanceMore"].ToString();
                        balanceMore = (int.Parse(Qtymore) - int.Parse(balanceMore)).ToString();


                        if (dateSync_DOB.Value.ToString() != "")
                        {
                            int Age = 0;
                            if (ageSync.Value == "")
                            {
                                Age = cl_Sql.Date2YearOld(DateTime.Parse(dateSync_DOB.Value.ToString()));
                            }
                            else
                            {
                                Age = int.Parse(ageSync.Value); //cl_Sql.Year2YearOld(DateTime.Parse(dateSync_DOB.Value.ToString()));
                            }

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

        public Boolean TimeSlot(string St, string En, string Sp, string SpUnit, string breakSt, string breakEn, int max, string startAfterBreak, DateTime CloseTime)
        {
            Boolean bl = false;

            if (max == 0)
            {
                max = 99999;
            }

            DateTime DateNow = DateTime.Now;
            string timeNow = DateNow.ToString("HH:mm:ss");
            string DateSelect = cld_booking.SelectedDate.ToString("yyyy-MM-dd");
            DateTime limitDate = DateTime.Parse(CloseTime.ToString("yyyy-MM-dd"));
            DateTime limitTime = DateTime.Parse(CloseTime.ToString("HH:mm:ss"));

            DateTime StartDate = DateTime.Parse(St);
            DateTime EndDate = DateTime.Parse(En);

            string Html = "";
            string headSlot = "";
            string barcolor = "bg-gradient-blue";

            if (DateTime.Parse(DateSelect) <= limitDate && DateTime.Parse(timeNow) > limitTime)
            {
                headSlot = "หมดเวลาการจองสำหรับวันที่คุณเลือก กรุณาเลือกวันถัดไป !!";
                Html = " ";
                barcolor = "bg-danger";
            }
            else
            {
                headSlot = "เลือกเวลาที่ต้องการจอง";
                for (int i = 1; i <= max; i++)
                {
                    if (StartDate <= EndDate)
                    {
                        if (CheckBookSlot(StartDate.ToString("yyyy-MM-dd HH:mm:ss")) == false)
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

                            if (StartDate < DateNow)
                            {
                                hide = "yes";
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
            }

            if (Html != "")
            {
                Html = "<span class='col-11 mx-auto mb-2 text-center boxShadow " + barcolor + "' style='font-size: x-large; color: white;'>" + headSlot + "</span>" + Html;
                bl = true;
            }

            lbl_TimeSlot.Text = Html;

            return bl;
        }

        public Boolean CheckBookSlot(string bookDateTime)
        {
            Boolean bl = false;

            string slot = Request.QueryString["slot"].ToString();

            //sql = "select * from bookingrecord as br " +
            //    "\nleft join bookingslot as bs on bs.bs_id=br.br_bsid " +
            //    "\nwhere br_active='yes' and br_bsid='" + slot + "' and br_datetime = '" + bookDateTime + "' ";
            //dt = new DataTable();
            //dt = cl_Sql.select(sql);

            dt = new DataTable();
            dt = ViewState["bookingRecordSlot"] as DataTable;
            //dt = Session["dt_bookingRecordSlot"] as DataTable;

            int RowCount = 0;
            try
            {
                dt = dt.Select("br_datetime = '" + DateTime.Parse(bookDateTime).ToString("yyyy-MM-dd HH:mm:ss") + "'").CopyToDataTable();
                RowCount = dt.Rows.Count;
            }
            catch { }

            if (RowCount > 0)
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
                    if (RowCount >= CNT)
                    {
                        bl = true;
                    }
                }
            }

            return bl;
        }

        public Boolean ManualSlot(string bsid, string dateRun, string CloseTimeTXT)
        {
            Boolean bl = false;

            string Html = "";
            string headSlot = "";
            string barcolor = "bg-gradient-blue";

            //sql = "select * from bookingslot_manual " +
            //    "\nwhere bsm_active='yes' and bsm_bsid='" + bsid + "' " +
            //    "\norder by bsm_time_st ";
            //dt = new DataTable();
            //dt = cl_Sql.select(sql);

            dt = new DataTable();
            dt = ViewState["bookingslot_manual"] as DataTable;

            int rowDT = dt.Rows.Count;

            int rowMn = 0;
            try
            {
                dt = dt.Select("bsm_date = '" + dateRun + "'").CopyToDataTable();
                rowMn = dt.Rows.Count;
            }
            catch { }

            if (rowMn <= 0)
            {
                dt = new DataTable();
                dt = ViewState["bookingslot_manual"] as DataTable;
                try
                {
                    dt = dt.Select("bsm_date is null").CopyToDataTable();
                    rowMn = dt.Rows.Count;
                }
                catch { }
            }

            if (rowMn > 0)
            {
                DateTime DateNow = DateTime.Now;
                string timeNow = DateNow.ToString("HH:mm:ss");
                string DateSelect = cld_booking.SelectedDate.ToString("yyyy-MM-dd");
                DateTime SelectDate = DateTime.Parse(DateSelect);
                DateTime CloseTime = DateTime.Parse(CloseTimeTXT);
                DateTime limitDate = DateTime.Parse(CloseTime.ToString("yyyy-MM-dd"));
                DateTime limitTime = DateTime.Parse(CloseTime.ToString("HH:mm:ss"));

                string lockTime = "no";
                if (SelectDate.Date < CloseTime.Date)
                {
                    lockTime = "yes";
                }
                else
                {
                    if (SelectDate.Date == CloseTime.Date && DateTime.Parse(timeNow) > limitTime)
                    {
                        lockTime = "yes";
                    }
                }

                if (lockTime == "yes")
                {
                    headSlot = "หมดเวลาการจองสำหรับวันที่คุณเลือก กรุณาเลือกวันถัดไป !!";
                    barcolor = "bg-danger";
                    bl = true;
                }
                else
                {
                    int Quota = 0;
                    headSlot = "เลือกเวลาที่ต้องการจอง";
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        string date = dt.Rows[i]["bsm_date"].ToString();
                        string time = dt.Rows[i]["bsm_time_st"].ToString();
                        string runDateTime = DateSelect + " " + time;
                        int limit = int.Parse(dt.Rows[i]["bsm_qty"].ToString());
                        if (DateTime.Parse(runDateTime) > DateNow)
                        {
                            if (CountRecord(bsid, runDateTime, limit))
                            {
                                string TimeShow = DateTime.Parse(time).ToString("HH:mm");
                                Html = Html + "<a id=\"btn_slot_" + i.ToString() + "\" class=\"col-lg-2 col-sm-3 btn btn-outline-success mx-auto my-auto\" style=\"font-size:xx-large; cursor: pointer;\" onclick=\"SelectTime('" + i.ToString() + "','" + TimeShow + "')\">" + TimeShow + "</a> ";
                                bl = true;
                            }
                        }
                        Quota = Quota + limit;
                    }
                    Session["QuotaManualBooking"] = Quota;
                }
            }

            Html = "<span class='col-11 mx-auto mb-2 text-center boxShadow " + barcolor + "' style='font-size: x-large; color: white;'>" + headSlot + "</span>" + Html;
            lbl_ManualSlot.Text = Html;

            return bl;
        }

        public Boolean CountRecord(string bsid, string datetime, int limit)
        {
            Boolean bl = false;

            DataTable dtRC = new DataTable();
            int RowCount = 0;

            //string where = "";
            //if (limit == 0)
            //{
            //    where = "br_date = '" + DateTime.Parse(datetime).ToString("yyyy-MM-dd") + "'";
            //}
            //else
            //{
            //    where = "br_datetime = '" + datetime + "'";
            //}

            //dtRC = cl_Sql.select(sql);
            //dtRC = ViewState["bookingrecordCount"] as DataTable;
            //try
            //{
            //    dtRC = dtRC.Select(where).CopyToDataTable();
            //    RowCount = dtRC.Rows.Count;
            //}
            //catch { }

            sql = "select convert(br_datetime,date) as 'br_date', count(br_id) as 'br_count' " +
                "\nfrom bookingrecord where br_active='yes' and br_bsid='" + bsid + "' " +
                "\nand br_datetime = '" + datetime + "' " +
                "\ngroup by convert(br_datetime,date) ";
            dtRC = cl_Sql.select(sql);
            RowCount = dtRC.Rows.Count;
            if (RowCount > 0)
            {
                int CNT = int.Parse(dtRC.Rows[0]["br_count"].ToString());

                if (limit == 0)
                {
                    sql = "Select a.*,b.bsm_sumqty_b from ( " +
                        "\n select '" + bsid + "' as 'bsm_bsid', ifnull(sum(bsm_qty), 0) as 'bsm_sumqty_a' from bookingslot_manual where bsm_active = 'yes' and bsm_date = convert('" + datetime + "', date) and bsm_bsid = '" + bsid + "' " +
                        "\n) a left join( " +
                        "\n select '" + bsid + "' as 'bsm_bsid', ifnull(sum(bsm_qty), 0) as 'bsm_sumqty_b' from bookingslot_manual where bsm_active = 'yes' and bsm_date is null and bsm_bsid = '" + bsid + "' " +
                        "\n) b on a.bsm_bsid = b.bsm_bsid ";
                    dtRC = new DataTable();
                    dtRC = cl_Sql.select(sql);
                    if (dtRC.Rows.Count > 0)
                    {
                        limit = int.Parse(dtRC.Rows[0]["bsm_sumqty_a"].ToString());
                        if (limit == 0)
                        {
                            limit = int.Parse(dtRC.Rows[0]["bsm_sumqty_b"].ToString());
                        }
                    }
                }
                if (CNT < limit)
                {
                    bl = true;
                }
            }
            else
            {
                bl = true;
            }

            return bl;
        }

        public Boolean Controler(string formID)
        {
            Boolean bl = false;
            
            //sql = "select * from bookingforminput where bfi_bfid = '" + formID + "' order by bfi_index ";
            //dt = new DataTable();
            //dt = cl_Sql.select(sql);

            dt = new DataTable();
            dt = ViewState["bookingforminput"] as DataTable;

            if (dt.Rows.Count > 0)
            {
                string HTML = "";
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    string inputID = dt.Rows[i]["bfi_id"].ToString();
                    string type = dt.Rows[i]["bfi_type"].ToString();
                    string index = dt.Rows[i]["bfi_index"].ToString();
                    string title = dt.Rows[i]["bfi_title"].ToString();
                    string placeholder = dt.Rows[i]["bfi_placeholder"].ToString();
                    string required = dt.Rows[i]["bfi_required"].ToString();

                    if (HTML == "") { HTML = HTML + "<div class=\"col-12 mx-auto\"><hr></div>"; }
                    if (required == "yes") { HTML = HTML + "<font color='red' size='12px' style='position: absolute;margin-top: 0px; left: 10px; '>*</font>"; }
                    HTML = HTML + MConT.Controler(inputID, type, index, title, placeholder);
                    HTML = HTML + "<div class=\"col-12 mx-auto\"><hr></div>";
                }
                lbl_controler.Text = HTML;
            }

            return bl;
        }

        protected void btn_Sync_Click(object sender, EventArgs e)
        {
            Sync();
        }

        private void Sync()
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
            string key = Request.QueryString["key"].ToString();

            DataHybrid(slot, key);

            string result = "";

            string cpid = "";
            string DuplicateNextDay = "";

            //sql = "select * from bookingslot where bs_id='" + slot + "' ";
            //dt = new DataTable();
            //dt = cl_Sql.select(sql);

            dt = new DataTable();
            dt = ViewState["bookingslot"] as DataTable;

            if (dt.Rows.Count > 0)
            {
                if (dt.Rows[0]["bs_duplicatenextday"].ToString() == "yes") // Can Book Duplicate Next Day
                {
                    //DuplicateNextDay = "and br_datetime = convert('" + bookDate + "', datetime) ";
                    string br_datetime = DateTime.Parse(bookDate).ToString("yyyy-MM-dd HH:mm:ss");
                    DuplicateNextDay = " and br_datetime = '" + br_datetime + "' ";
                }
                cpid = dt.Rows[0]["bs_cpid"].ToString();
            }

            //sql = "select * from company_employee where ce_active='yes' and ce_cp_id='" + cpid + "' and ce_empid='" + empid + "' ";
            //dt = new DataTable();
            //dt = cl_Sql.select(sql);

            dt = new DataTable();
            dt = ViewState["company_employee"] as DataTable;
            int RowCount = 0;
            try
            {
                dt = dt.Select("ce_empid='" + empid + "'").CopyToDataTable();
                RowCount = dt.Rows.Count;
            }
            catch { }

            if (RowCount > 0)
            {
                string fullname = dt.Rows[0]["ce_name_th"].ToString();
                string ce_age = dt.Rows[0]["ce_age"].ToString();
                string DOB = "";
                if (dt.Rows[0]["ce_dob"].ToString() != "")
                {
                    div_DOB_title.Visible = true;
                    div_DOB_detail.Visible = true;
                    DOB = DateTime.Parse(dt.Rows[0]["ce_dob"].ToString()).ToString("yyyy-MM-dd");
                }
                if (dt.Rows[0]["ce_vaccine"].ToString() != "")
                {
                    div_vaccine.Visible = true;
                    lbl_vaccine.Text = dt.Rows[0]["ce_vaccine"].ToString();
                }
                string program = dt.Rows[0]["ce_program"].ToString();

                //sql = "select * from bookingdetail where bd_bfiid=0 and bd_brid in (select br_id from bookingrecord where br_active='yes' and br_bsid='" + slot + "' " + DuplicateNextDay + ") and bd_value='" + empid + "'; ";
                //dt = new DataTable();
                //dt = cl_Sql.select(sql);
                //RowCount = dt.Rows.Count;

                dt = new DataTable();
                dt = ViewState["bookingdetail_bfiid0"] as DataTable;
                RowCount = 0;
                try
                {
                    dt = dt.Select("bd_value='" + empid + "'").CopyToDataTable();
                    RowCount = dt.Rows.Count;
                }
                catch { }

                if (RowCount > 0)
                {
                    txtSync_empid.Value = empid;
                    result = "ท่านได้ทำการจองไว้แล้ว ไม่สามารถทำซ้ำได้ !!";
                }
                else
                {
                    txtSync_fullname.Value = fullname;
                    dateSync_DOB.Value = DOB;
                    if (DOB != "")
                    {
                        string age = "0";
                        if (ce_age != "")
                        {
                            age = cl_Sql.Year2YearOld(DateTime.Parse(DOB)).ToString();
                            ageSync.Value = age;

                            div_DOB_title.Visible = false;
                            dateSync_DOB.Attributes.Add("hidden", "hidden");
                        }
                        else
                        {
                            age = cl_Sql.Date2YearOld(DateTime.Parse(DOB)).ToString();
                            ageSync.Value = "";

                            div_DOB_title.Visible = true;
                            dateSync_DOB.Attributes.Remove("hidden");
                        }
                        lbl_age.Text = "อายุ " + age + " ปี";
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

            //if (DuplicateNextDay == "yes")
            //{
            //    //DuplicateNextDay = " and br_datetime = convert('" + bookDate + "', datetime) ";
            //    string br_datetime = DateTime.Parse(bookDate).ToString("yyyy-MM-dd HH:mm:ss");
            //    DuplicateNextDay = " and br_datetime = '" + br_datetime + "' ";
            //}
            //else
            //{
            //    DuplicateNextDay = "";
            //}

            //sql = "select * from bookingdetail where bd_bfiid=0 and bd_brid in (select br_id from bookingrecord where br_active='yes' and br_bsid='" + slot + "' " + DuplicateNextDay + ") and bd_value='" + empid + "'; ";
            //dt = new DataTable();
            //dt = cl_Sql.select(sql);

            dt = new DataTable();
            dt = ViewState["bookingdetail_bfiid0"] as DataTable;
            int RowCount = 0;
            try
            {
                dt = dt.Select("bd_value = '" + empid + "'").CopyToDataTable();
                RowCount = dt.Rows.Count;
            }
            catch { }

            if (RowCount > 0)
            {
                bl = true;
            }

            return bl;
        }

        protected Boolean LimitTimeBook(string slot)
        {
            Boolean bl = false;

            //sql = "select bs_predate, bs_limittime from bookingslot where bs_id = '" + slot + "'; ";
            //dt = new DataTable();
            //dt = cl_Sql.select(sql);

            dt = new DataTable();
            dt = ViewState["bookingslot"] as DataTable;

            if (dt.Rows.Count > 0)
            {
                int preDate = int.Parse(dt.Rows[0]["bs_predate"].ToString());
                string limit = dt.Rows[0]["bs_limittime"].ToString();
                if (limit == "")
                {
                    bl = true;
                }
                else
                {
                    limit = DateTime.Now.AddDays(preDate).ToString("yyyy-MM-dd") + " " + limit;
                    DateTime now = DateTime.Parse(DateTime.Now.ToString("yyyy-MM-dd HH:mm"));
                    if (now <= DateTime.Parse(limit))
                    {
                        bl = true;
                    }
                }
            }

            return bl;
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            lbl_alert.Text = "";
            string alert = "";

            string slot = Request.QueryString["slot"].ToString();
            string key = Request.QueryString["key"].ToString();

            DataLoad(slot, key);
            DataHybrid(slot, key);

            string syncName = "รหัสพนักงาน";

            string bookDate = txtH_bookdate.Value.ToString();

            if (txtH_bookdate.Value != "" && txtH_bookTimeStart.Value != "")
            {
                DateTime DateBookST = DateTime.Parse(txtH_bookTimeStart.Value.ToString());
                string txtDateST = DateBookST.ToString("yyyy-MM-dd");
                string txtTimeST = DateBookST.ToString("HH:mm:ss");
                DateTime DateBookEN = DateTime.Parse(txtH_bookTimeEnd.Value.ToString());
                string txtDateEN = DateBookEN.ToString("yyyy-MM-dd");
                string txtTimeEN = DateBookEN.ToString("HH:mm:ss");
                if (bookDate != txtDateST)
                {
                    txtH_bookTimeStart.Value = bookDate + " " + txtTimeST;
                    txtH_bookTimeEnd.Value = bookDate + " " + txtTimeEN;
                }
            }

            string bookTime = txtH_booktime.Value.ToString();

            string TimeSlot = txtH_TimeSlot.Value.ToString();

            if (bookDate == "")
            {
                alert = "กรุณาเลือกวันที่ต้องการจอง !!";
            }
            else
            {
                if (TimeSlot == "yes" && bookTime == "")
                {
                    alert = "กรุณาเลือกเวลาที่ต้องการจอง !!";
                }
                else
                {
                    if (!LimitTimeBook(slot))
                    {
                        alert = "ขออภัยวันนี้ระบบปิดให้ทำการจองแล้ว กรุณากลับมาใหม่ในวันถัดไป !!";
                    }
                    else
                    {
                        string next = "Yes";
                        string SQLs = "";
                        string replace = key + "_" + cl_Sql.GenerateKey(4);

                        string bookDateTime = DateTime.Parse(bookDate + " " + bookTime).ToString("yyyy-MM-dd HH:mm:ss");

                        //sql = "select * from bookingforminput " +
                        //    "where bfi_bfid in (select bs_bfid from bookingslot where bs_id = '" + slot + "') order by bfi_index ";
                        //dt = new DataTable();
                        //dt = cl_Sql.select(sql);

                        dt = new DataTable();
                        dt = ViewState["bookingforminput"] as DataTable;

                        if (dt.Rows.Count > 0)
                        {
                            string scCRTL = "";
                            for (int i = 0; i < dt.Rows.Count; i++)
                            {
                                string ConTID = dt.Rows[i]["bfi_id"].ToString();
                                string type = dt.Rows[i]["bfi_type"].ToString();
                                string title = dt.Rows[i]["bfi_title"].ToString();
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

                                string sc = "document.getElementById('<%= " + conID + " %'>).setAttribute('style','border: solid; border-color: red;'); ";
                                if (required == "yes" && input.Trim() == "")
                                {
                                    next = "Null";
                                }
                                else
                                {
                                    sc = "document.getElementById('<%= " + conID + " %'>).removeAttribute('style'); ";
                                    SQLs = SQLs + "insert into bookingdetail(bd_brid, bd_bfiid, bd_value, bd_column) values(" + replace + ", " + ConTID + ", '" + input.Trim() + "', '" + title + "'); \n";
                                }
                                scCRTL += sc;
                            }
                            lbl_scCTRL.Text = "<script>" + scCRTL + "</script>";
                        }

                        if (next == "Null")
                        {
                            alert = "กรุณากรอกข้อมูลให้ครบถ้วน !!";
                            lbl_alert.ForeColor = System.Drawing.Color.Red;
                        }
                        else
                        {
                            string id = Request.QueryString["slot"].ToString();
                            string splittime = txtH_splittime.Value.ToString().Trim();
                            string splittimeQty = txtH_splittimeQty.Value.ToString().Trim();
                            string Limitfull = "";

                            string splitUnit = "";
                            string dateSt = "";
                            string dateEnd = "";

                            //sql = "select * from bookingslot where bs_id = '" + slot + "' and bs_key = '" + key + "' ";
                            //dt = new DataTable();
                            //dt = cl_Sql.select(sql);

                            dt = new DataTable();
                            dt = ViewState["bookingslot"] as DataTable;

                            if (dt.Rows.Count > 0)
                            {
                                splitUnit = dt.Rows[0]["bs_splittimeunit"].ToString();
                                dateSt = dt.Rows[0]["bs_startdate"].ToString();
                                dateEnd = dt.Rows[0]["bs_enddate"].ToString();
                            }

                            if (splitUnit == "manual")
                            {
                                sql = "select * from bookingslot_manual where bsm_active = 'yes' and bsm_time_st = '" + bookTime + "'; ";
                                dt = new DataTable();
                                dt = cl_Sql.select(sql);
                                if (dt.Rows.Count > 0)
                                {
                                    if (!CountRecord(id, DateTime.Parse(bookDateTime).ToString("yyyy-MM-dd"), 0))
                                    {
                                        Limitfull = "yes";
                                    }
                                }
                                else
                                {
                                    Limitfull = "timeWrong";
                                }
                            }
                            else
                            {
                                if (splittime == "0") // Condition No splittime
                                {
                                    if (CounterBooking(id, bookDateTime, "no") == false)
                                    {
                                        Limitfull = "yes";
                                    }
                                }
                                else // Condition for splittime
                                {
                                    DateTime timeSt = DateTime.Parse(bookDate + " " + DateTime.Parse(dateSt).ToString("HH:mm:ss"));
                                    DateTime timeEnd = DateTime.Parse(bookDate + " " + DateTime.Parse(dateEnd).ToString("HH:mm:ss"));
                                    DateTime timeBook = DateTime.Parse(bookDateTime);
                                    if (timeBook < timeSt || timeBook > timeEnd)
                                    {
                                        Limitfull = "timeWrong";
                                    }
                                    else
                                    {
                                        DateTime SelectDate = DateTime.Parse(bookDateTime);
                                        if (CheckBookSlot(SelectDate.ToString("yyyy-MM-dd HH:mm:ss")))
                                        {
                                            Limitfull = "yes";
                                        }
                                    }
                                }
                            }


                            if (Limitfull == "yes")
                            {
                                lbl_alert.Text = "วันเวลาที่ทำการจองเต็มแล้ว กรุณาเลือกวันเวลาอื่น !!";
                                lbl_alert.ForeColor = System.Drawing.Color.Red;
                                lbl_TimeSlot.Text = "";
                            }
                            else if (Limitfull == "timeWrong")
                            {
                                lbl_alert.Text = "กรุณาเลือกเวลาที่ต้องการจอง !!";
                                lbl_alert.ForeColor = System.Drawing.Color.Red;
                                lbl_TimeSlot.Text = "";
                                alert = "กรุณาเลือกเวลาที่ต้องการจอง !!";
                            }
                            else
                            {
                                alert = "ไม่สามารถบันทึกการจองได้ กรุณาติดต่อผู้ดูแลระบบ !!";
                                lbl_alert.ForeColor = System.Drawing.Color.Red;

                                string Key = cl_Sql.GenerateKey(5);
                                while (true)
                                {
                                    sql = "select br_id from bookingrecord where convert(br_createdate, date)=CURRENT_DATE and br_active='yes' and br_key = '" + Key + "' ";
                                    dt = new DataTable();
                                    dt = cl_Sql.select(sql);
                                    if (dt.Rows.Count > 0)
                                    { }
                                    else
                                    {
                                        break;
                                    }
                                }

                                string br_id = "";
                                string sqlSync = "";
                                string saveStaus = "no";

                                //sql = "select bs_duplicatenextday, bs_sync, bs_syncname from bookingslot where bs_id = '" + slot + "'";
                                //dt = new DataTable();
                                //dt = cl_Sql.select(sql);

                                dt = new DataTable();
                                dt = ViewState["bookingslot"] as DataTable;

                                if (dt.Rows.Count > 0)
                                {
                                    string duplicatenextday = dt.Rows[0]["bs_duplicatenextday"].ToString();
                                    string sync = dt.Rows[0]["bs_sync"].ToString();
                                    syncName = dt.Rows[0]["bs_syncname"].ToString();
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
                                                saveStaus = "record";

                                                sqlSync = sqlSync + "insert into bookingdetail(bd_brid, bd_bfiid, bd_value, bd_column) values(" + replace + ", 0, '" + Sync_empid + "', '" + syncName + "'); ";
                                                sqlSync = sqlSync + "insert into bookingdetail(bd_brid, bd_bfiid, bd_value, bd_column) values(" + replace + ", 0, '" + Sync_fullname + "', 'ชื่อ-นามสกุล'); ";

                                                if (dateSync_DOB.Value.ToString() != "")
                                                {
                                                    //string Sync_DOB = DateTime.Parse(dateSync_DOB.Value.ToString()).ToString("yyyy-MM-dd");
                                                    //sqlSync = sqlSync + "insert into bookingdetail(bd_brid, bd_bfiid, bd_value, bd_column) values(" + replace + ", 0, '" + Sync_DOB + "', 'วันเกิด'); ";
                                                    int Age = 0;
                                                    if (ageSync.Value == "")
                                                    {
                                                        Age = cl_Sql.Date2YearOld(DateTime.Parse(dateSync_DOB.Value.ToString()));
                                                    }
                                                    else
                                                    {
                                                        Age = cl_Sql.Year2YearOld(DateTime.Parse(dateSync_DOB.Value.ToString()));
                                                    }
                                                    sqlSync = sqlSync + "insert into bookingdetail(bd_brid, bd_bfiid, bd_value, bd_column) values(" + replace + ", 0, '" + Age + "', 'อายุ'); ";
                                                }

                                                string Sync_program = lblSync_program.Text;
                                                sqlSync = sqlSync + "insert into bookingdetail(bd_brid, bd_bfiid, bd_value, bd_column) values(" + replace + ", 0, '" + Sync_program + "', 'โปรแกรมที่ตรวจ'); ";
                                            }
                                        }
                                        else
                                        {
                                            saveStaus = "NoEmp";
                                        }
                                    }
                                    else
                                    {
                                        saveStaus = "record";
                                    }

                                    if (saveStaus == "record")
                                    {
                                        // --------------------------------------------------------------------- Break Booking ---------
                                        if (slot == "")
                                        {
                                            alert = "ยังไม่เปิดให้ทำการจอง !!";
                                        }
                                        else
                                        {
                                            sql = "insert into bookingrecord(br_bsid, br_datetime,br_key) values('" + slot + "','" + bookDateTime + "','" + Key + "') ";
                                            if (cl_Sql.Modify(sql))
                                            {
                                                sql = "select * from bookingrecord where convert(br_createdate, date)=CURRENT_DATE and br_active='yes' and br_key = '" + Key + "' ";
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
                                        // --------------------------------------------------------------------- Break Booking ---------
                                        if (slot == "")
                                        {
                                            alert = "ยังไม่เปิดให้ทำการจอง !!";
                                        }
                                        else
                                        {
                                            SQLs = SQLs.Replace(replace, br_id);
                                            if (cl_Sql.Modify(SQLs))
                                            {
                                                alert = "success";
                                            }
                                        }
                                    }

                                    if (alert == "success")
                                    {
                                        lbl_alert.ForeColor = System.Drawing.Color.Green;
                                        string link = "Booking.aspx?key=" + key + "&slot=" + slot + "&bsid=" + br_id + "&success=yes";
                                        if (slot == "59" && splitUnit == "manual")
                                        {
                                            string co = Request.QueryString["co"].ToString();
                                            string privateID = Request.QueryString["privateid"].ToString();
                                            link += "&co=" + co + "&privateid=" + privateID;
                                        }
                                        Response.Redirect(link);
                                    }
                                }
                                else
                                {
                                    lbl_alert.ForeColor = System.Drawing.Color.Red;
                                    if (saveStaus == "NoEmp")
                                    {
                                        alert = "" + syncName + "ไม่ถูกต้อง !!";
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
                            }
                        }
                    }
                }
            }
            lbl_alert.Text = alert;
        }

        public override void VerifyRenderingInServerForm(Control control)
        {
            /* Confirms that an HtmlForm control is rendered for the specified ASP.NET
          server control at run time. */
        }
    }
}