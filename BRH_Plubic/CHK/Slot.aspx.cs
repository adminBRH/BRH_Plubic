using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;
using BRH_Plubic.Service;

namespace BRH_Plubic.CHK
{
    public partial class Slot : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        MakeControler MConT = new MakeControler();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Login"] == null)
            {
                Response.Redirect("../Default.aspx?back=CHK&login=require");
            }
            else
            {
                string status = Session["status"].ToString();
                if (status == "admin" || status == "hr" || status == "checkup" || status == "xray" || status == "mao")
                {
                    if (!IsPostBack)
                    {
                        Company();
                        DataList("yes");
                        FormList();
                    }
                }
                else
                {
                    Response.Write("<script>alert('คุณไม่มีสิทธิ์ ใช้งานระบบนี้ !!'); window.location.href='../Default.aspx';</script>");
                }
            }
        }

        protected void Company()
        {
            sql = "Select * from (" +
                "select '0' as 'rank','0' as 'cp_id','ไม่ระบุ' as 'cp_name_th' union " +
                "select '1' as 'rank',cp_id,cp_name_th from company where cp_active='Yes'" +
                ") as a order by a.rank,a.cp_name_th ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                DD_company.DataSource = dt;
                DD_company.DataTextField = "cp_name_th";
                DD_company.DataValueField = "cp_id";
                DD_company.DataBind();
            }
        }

        protected void DataList(string active)
        {
            sql = "update bookingslot set bs_active='no' where bs_active='yes' and bs_enddate < CURRENT_TIMESTAMP; ";
            cl_Sql.Modify(sql);

            sql = "select * from bookingslot where bs_active like '%" + active + "%'; ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                
            }

            Listview_slot.DataSource = dt;
            Listview_slot.DataBind();
        }

        protected void FormList()
        {
            sql = "select '' as 'bf_id','Please select form' as 'bf_formname' union " +
                "select bf_id,bf_formname from bookingform " +
                "where bf_active='yes' " +
                "order by bf_id ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            { }
            DD_Form.DataSource = dt;
            DD_Form.DataTextField = "bf_formname";
            DD_Form.DataValueField = "bf_id";
            DD_Form.DataBind();
        }

        protected void Controler(string FormID)
        {
            sql = "select * from bookingforminput where bfi_required='yes' and bfi_bfid='" + FormID + "' order by bfi_index ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            string HTML = "";
            if (dt.Rows.Count > 0)
            {
                for (int i=0; i<dt.Rows.Count; i++)
                {
                    string inputID = dt.Rows[i]["bfi_id"].ToString();
                    string type = dt.Rows[i]["bfi_type"].ToString();
                    string inputIndex = dt.Rows[i]["bfi_id"].ToString();
                    string title = dt.Rows[i]["bfi_title"].ToString();
                    string PH = dt.Rows[i]["bfi_placeholder"].ToString();

                    if (HTML == "") { HTML = HTML + "<div class=\"col-12 mx-auto\"><hr></div>"; }
                    HTML = HTML + MConT.Controler(inputID, type, inputIndex, title, PH);
                    HTML = HTML + "<div class=\"col-12 mx-auto\"><hr></div>";
                }
            }
            else
            {
                txtH_Sync.Value = "";
            }
            lbl_controler.Text = HTML;
        }

        protected void DD_Form_SelectedIndexChanged(object sender, EventArgs e)
        {
            string FormID = DD_Form.SelectedValue.ToString();
            if (FormID != "") 
            { 
                div_submit.Visible = true; 
            } 
            else 
            { 
                div_submit.Visible = false; 
            }

            string Company = DD_company.SelectedValue.ToString();
            if (Company != "0")
            {
                if (CB_SyncEmployee.Checked)
                {
                    CB_SyncEmployee.Checked = true;

                    div_AgeCondition.Attributes.Remove("hidden");

                    if (CB_ageCondition.Checked)
                    {
                        div_QtyCondition.Attributes.Remove("hidden");
                        div_Qty.Attributes.Add("hidden", "hidden");
                    }
                    else
                    {
                        div_QtyCondition.Attributes.Add("hidden", "hidden");
                        div_Qty.Attributes.Remove("hidden");
                    }
                }
            }

            Controler(FormID);
        }

        public string Insert()
        {
            string result = "";

            string name = txt_name.Value.ToString().Trim();
            if (name == "")
            {
                result = "nameEmpty";
            }
            else
            {
                string Form = DD_Form.SelectedValue.ToString();

                string company = DD_company.SelectedValue.ToString();
                string StartDate = DateTime.Parse(date_start.Value.ToString()).ToString("yyyy-MM-dd");
                StartDate = StartDate + " " + DateTime.Parse(time_start.Value.ToString()).ToString("HH:mm:ss");
                string EndDate = DateTime.Parse(date_end.Value.ToString()).ToString("yyyy-MM-dd");
                EndDate = EndDate + " " + DateTime.Parse(time_end.Value.ToString()).ToString("HH:mm:ss");
                string ageCondition = "no";
                if (CB_ageCondition.Checked)
                {
                    ageCondition = CB_ageCondition.Value.ToString();
                }
                string age_lessequal = txt_age_lessthan.Value.ToString();
                string age_lessequalQty = num_age_lessthan.Value.ToString();
                string age_morethan = txt_age_morethan.Value.ToString();
                string age_morethanQty = num_age_morethan.Value.ToString();

                string breakSt = "NULL";
                string breakEn = "NULL";
                string startAfterBreak = "no";

                string splittime = "0";
                string splittimeunit = "";
                string splittimeQty = num_qty.Value.ToString().Trim();
                string DuplicateNextDay = "no"; if (CB_DuplicateNextDay.Checked) { DuplicateNextDay = "yes"; }
                string maxqty = splittimeQty;

                string splitType = txtH_FullSplit.Value.ToString();
                if (splitType == "split")
                {
                    splittime = txt_time.Value.ToString().Trim();
                    splittimeunit = DD_timeunit.SelectedValue.ToString();

                    breakSt = "'" + txt_breakSt.Value.ToString() + "'";
                    breakEn = "'" + txt_breakEn.Value.ToString() + "'";

                    if (cb_StartSlotEndBreak.Checked)
                    {
                        startAfterBreak = cb_StartSlotEndBreak.Value;
                    }

                    maxqty = txt_maxqty.Value.ToString().Trim();
                }
                if (splitType == "manual")
                {
                    splittimeunit = "manual";
                    splittimeQty = "1";
                    maxqty = "0";
                }

                string alertSubmit = txt_NotifySubmit.Value.ToString().Trim();
                if (alertSubmit == "")
                {
                    alertSubmit = "Success !!";
                }

                //string Sync = txtH_Sync.Value.ToString();
                string Sync = "";
                if (CB_SyncEmployee.Checked)
                {
                    Sync = "sync";
                }

                string Hiddendate = "";
                string TxtHiddendate = txt_hiddendate.Value.ToString().Trim();
                string[] hd_ar = TxtHiddendate.Split('|');
                foreach (string num in hd_ar)
                {
                    if (Hiddendate != "") { Hiddendate = Hiddendate + "|"; }
                    Hiddendate = Hiddendate + cl_Sql.WeekDayEng(num);
                }

                string userid = Session["userid"].ToString();

                string alertonform = txt_alertonform.Value.ToString().Trim();

                sql = "insert into bookingslot" +
                    "(bs_createby, bs_name, bs_alertonform, bs_startdate, bs_enddate, bs_age_condition, bs_age_lessequal, bs_age_lessequalqty, bs_age_moreequal, bs_age_moreequalqty, bs_splittime, bs_splittimeunit, bs_splittimeqty, bs_cpid, bs_key, bs_bfid, bs_alertsubmit, bs_sync, bs_break_startdate, bs_break_enddate, bs_maxqty, bs_hiddendate, bs_startaftetbreak, bs_duplicatenextday) " +
                    "\nvalues" +
                    "('" + userid + "','" + name + "','" + alertonform + "','" + StartDate + "','" + EndDate + "','" + ageCondition + "','"+ age_lessequal + "','"+ age_lessequalQty + "','"+ age_morethan + "','"+ age_morethanQty + "','" + splittime + "','" + splittimeunit + "','" + splittimeQty + "','" + company + "', '" + cl_Sql.GenerateKey(11) + "', '" + Form + "', '" + alertSubmit + "', '" + Sync + "', " + breakSt + ", " + breakEn + ", " + maxqty + ", '" + Hiddendate + "', '" + startAfterBreak + "', '" + DuplicateNextDay + "'); ";
                if (cl_Sql.Modify(sql))
                {
                    result = "success";

                    if (splitType == "manual")
                    {
                        result = "";

                        string bsID = "";

                        sql = "select max(bs_id) as 'bs_id' from bookingslot where bs_name='" + name + "'; ";
                        dt = new DataTable();
                        dt = cl_Sql.select(sql);
                        if (dt.Rows.Count > 0)
                        {
                            bsID = dt.Rows[0]["bs_id"].ToString();

                            sql = "\ninsert into bookingslot_manual(bsm_bsid,bsm_time_st,bsm_time_en,bsm_qty) values ";
                            string[] AR = txtH_splitMe.Value.ToString().Split('|');
                            string sqlVal = "";
                            for (int i = 0; i < AR.Length; i++)
                            {
                                string[] AR2 = AR[i].ToString().Split(',');

                                string timeST = AR2[0].ToString();
                                string timeEN = AR2[1].ToString();
                                string QTY = AR2[2].ToString();

                                sqlVal += "\n('" + bsID + "','" + timeST + "','" + timeEN + "','" + QTY + "')";
                                if (i == (AR.Length - 1))
                                {
                                    sqlVal += ";";
                                }
                                else
                                {
                                    sqlVal += ",";
                                }
                            }
                            sql = sql + sqlVal;
                            if (cl_Sql.Modify(sql))
                            {
                                result = "success";
                            }
                            else
                            {
                                result = "manual fail";
                                sql = "update bookingslot set bs_active='no' where bs_id = '" + bsID + "'; ";
                                cl_Sql.Modify(sql);
                            }
                        }
                    }
                }
            }

            return result;
        }

        protected void btn_submit_ServerClick(object sender, EventArgs e)
        {
            string result = Insert();
            string alert = "";
            string reload = "";
            if (result == "success")
            {
                alert = "alertModal('#Modal_Success'); ";
                reload = "setTimeout(function(){window.location.href='Slot.aspx';},3000); ";
            }
            else if (result == "nameEmpty")
            {
                alert = "alertModalInfo('#Modal_Info','กรุณาระบุ Slot name !!'); ";
            }
            else if (result == "manual fail")
            {
                alert = "alertModalWarning('#Modal_Warning','ไม่สามารถบันทึกการแบ่งช่วงเวลาแบบ Manual ได้ กรุณาติดต่อผู้ดูแลระบบ !!'); ";
            }
            else
            {
                alert = "alertModalWarning('#Modal_Warning','ไม่สามารถบันทึกได้ กรุณาติดต่อผู้ดูแลระบบ !!'); ";
            }

            lbl_Modal.Text = "<script>" + alert + reload + "</script>";
        }

        protected void DD_company_SelectedIndexChanged(object sender, EventArgs e)
        {
            string contacts = DD_company.SelectedValue.ToString();
            
            lbl_contactsName.Text = "";
            txtH_Sync.Value = "";

            if (contacts == "0")
            {
                CB_SyncEmployee.Checked = false;
                CB_ageCondition.Checked = false;
                div_Qty.Attributes.Remove("hidden");
                div_QtyCondition.Attributes.Add("hidden", "hidden");
            }

            if (CheckSync(contacts))
            {
                div_Sync.Visible = true;
            }
            else
            {
                div_Sync.Visible = false;
            }
        }

        protected Boolean CheckSync(string contactsID)
        {
            Boolean bl = false;

            sql = "select * from company where cp_active='Yes' and cp_id = '" + contactsID + "' ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                lbl_contactsName.Text = dt.Rows[0]["cp_name_th"].ToString();

                sql = "select * from company_employee where ce_active='Yes' and ce_cp_id = '" + contactsID + "' limit 1; ";
                dt = new DataTable();
                dt = cl_Sql.select(sql);
                if (dt.Rows.Count > 0)
                {
                    bl = true;
                }
            }

            return bl;
        }


        protected void DiractionSlot(string bsid)
        {
            string userid = Session["userid"].ToString();

            string whereUser = "'and bs_createby = " + userid + "'";
            if (userid == "admin")
            {
                whereUser = "";
            }
            
            sql = "select * from bookingslot where bs_active='yes' and bs_id<>'" + bsid + "' " + whereUser + " order by bs_id desc ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {

            }

            DD_direction.DataSource = dt;
            DD_direction.DataTextField = "bs_name";
            DD_direction.DataValueField = "bs_id";
            DD_direction.DataBind();
        }

        protected void btn_direction_ServerClick(object sender, EventArgs e)
        {
            string bsid = txtH_direction.Value.ToString();
            sql = "select * from bookingslot where bs_id='" + bsid + "' ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                lbl_slotmain.Text = dt.Rows[0]["bs_name"].ToString();
            }
            
            DiractionSlot(bsid);

            string scModal = "<script>alertModal('#modalDirection');</script>";
            lbl_script.Text = scModal;
        }

        protected void btn_direction_save_ServerClick(object sender, EventArgs e)
        {
            string DirectionID = txtH_direction.Value.ToString();
            

            if (CB_direction.Checked)
            {
                if (CB_direction_dayless.Checked)
                {
                    DirectionID = "";
                }
                else if (CB_direction_daymore.Checked)
                {

                }
                else
                {

                }
            }
            sql = "update bookingslot set bs_directid='' ";

            string scModal = "<script>alertModalWarning('','ขออภัย ระบบเชื่อมต่อ SLOT ยังไม่เปิดให้ใช้บริการ !!');</script>";
            lbl_script.Text = scModal;
        }
    }
}