using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.IO;
using System.Drawing;
using BRH_Plubic.Function;

namespace BRH_Plubic.CHK
{
    public partial class Report : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        Customize ctm = new Customize();

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
                        DropDownSlot("0");
                    }
                }
                else
                {
                    Response.Write("<script>alert('คุณไม่มีสิทธิ์ ใช้งานระบบนี้ !!'); window.location.href='../Default.aspx';</script>");
                }
            }
        }

        private void DropDownSlot(string slotID)
        {
            string Where = "";
            if (slotID == "0")
            {
                Where = "and CONVERT((bs_enddate + INTERVAL 3 DAY),date) >= CURRENT_DATE ";
            }
            else
            {
                Where = "and bs_id='" + slotID + "' ";
            }
            sql = "select bs_id,bs_name from bookingslot where bs_active in ('yes','no') " + Where + " order by bs_id ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            { }
            DD_Slot.DataSource = dt;
            DD_Slot.DataTextField = "bs_name";
            DD_Slot.DataValueField = "bs_id";
            DD_Slot.DataBind();
            DD_Slot.Items.Insert(0, new ListItem("Please select", "0"));
        }

        private void Slot(string slotID)
        {
            lbl_slotDate.Text = "";
            lbl_slotTime.Text = "";
            lbl_form.Text = "";
            lbl_SplitText.Text = "";

            sql = "select * " +
                "\n,date_format(bs_startdate,'%d %b %Y') as 'startDate' " +
                "\n,date_format(bs_startdate,'%H:%i') as 'startTime' " +
                "\n,date_format(bs_enddate,'%d %b %Y') as 'endDate' " +
                "\n,date_format(bs_enddate,'%H:%i') as 'endTime' " +
                "\nfrom bookingslot " +
                "\nwhere bs_active = 'yes' " +
                "\nand bs_id = '" + slotID + "' " +
                "\norder by bs_id ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                if (dt.Rows[0]["bs_sync"].ToString() == "sync")
                {
                    div_search_sync.Visible = true;
                }
                else
                {
                    div_search_sync.Visible = false;
                }

                lbl_slotDate.Text = dt.Rows[0]["startDate"].ToString() + " ถึง " + dt.Rows[0]["endDate"].ToString();
                lbl_slotTime.Text = dt.Rows[0]["startTime"].ToString() + " ถึง " + dt.Rows[0]["endTime"].ToString();

                DateTime stDate = DateTime.Parse(dt.Rows[0]["startDate"].ToString());
                DateTime enDate = DateTime.Parse(dt.Rows[0]["endDate"].ToString());
                DateTime nowDate = DateTime.Now;
                if (txtH_filterDate.Value == "yes")
                {
                    stDate = DateTime.Parse(date_ST.Value.ToString());
                    enDate = DateTime.Parse(date_EN.Value.ToString());
                }
                else
                {
                    if (nowDate.Date > enDate.Date)
                    {
                        stDate = enDate;
                    }
                    else
                    {
                        stDate = nowDate;
                        enDate = nowDate;
                    }
                }
                date_ST.Value = stDate.ToString("yyyy-MM-dd");
                date_EN.Value = enDate.ToString("yyyy-MM-dd");

                DataTable dtF = FormTable(dt.Rows[0]["bs_bfid"].ToString());
                lbl_form.Text = dtF.Rows[0]["bf_formname"].ToString();

                string splitText = "สามารถจองได้ ";
                string splitQty = dt.Rows[0]["bs_splittimeqty"].ToString() + "คน ";
                splitText = splitText + splitQty;
                string splitTime = dt.Rows[0]["bs_splittime"].ToString();
                string splitUnit = dt.Rows[0]["bs_splittimeunit"].ToString();
                if (splitUnit == "hour") { splitUnit = "ชั่วโมง"; } else { splitUnit = "นาที"; }
                if (splitTime == "0") 
                { 
                    splitText = splitText + " ในแต่ละวัน"; 
                } 
                else 
                { 
                    splitText = splitText + " ทุกๆ " + splitTime + " " + splitUnit; 
                }
                lbl_SplitText.Text = splitText;
            }
        }

        private DataTable FormTable(string formID)
        {
            sql = "select * from bookingform where bf_id = '" + formID + "' ";
            DataTable result = new DataTable();
            result = cl_Sql.select(sql);
            if (result.Rows.Count > 0)
            { }

            return result;
        }

        private DataTable RecordDetail(string slotID, string STdateRport, string ENdateRport)
        {
            sql = "select *,convert(br_datetime,date) as 'br_bookdate' " +
                "\n,date_format(br_datetime, '%d %b %Y') as 'BookDate' " +
                "\n,date_format(br_datetime, '%H:%i') as 'BookTime' " +
                "\nfrom bookingrecord " +
                "\nwhere br_active='yes' and br_bsid = '" + slotID + "' " +
                //"\nand ( convert('" + STdateRport + "', date) <= convert(br_createdate, date) and convert(br_createdate, date) <= convert('" + ENdateRport + "', date) ) " + 
                "and (convert(br_datetime, date) between '" + STdateRport + "' and '" + ENdateRport + "') " +
                "\norder by br_id ";
            DataTable result = new DataTable();
            result = cl_Sql.select(sql);
            if (result.Rows.Count > 0)
            {
                result.Columns.Add("RowIndex", typeof(string));
                result.Columns.Add("RowHTML", typeof(string));

                string text = "";
                string value = "";

                foreach (DataRow row in result.Rows)
                {
                    string HTMLDetail = "<table border=\"1\" style=\"width: 100%\">";
                    
                    row["RowIndex"] = result.Rows.IndexOf(row) + 1;

                    string recodeID = row["br_id"].ToString();

                    sql = "select * from bookingdetail as bd left join bookingforminput as bfi on bfi.bfi_id=bd.bd_bfiid " +
                        "\nwhere bd_brid = '" + recodeID + "' " +
                        "\norder by bd_id ";
                    DataTable resultI = new DataTable();
                    resultI = cl_Sql.select(sql);
                    if (resultI.Rows.Count > 0)
                    {
                        string tdHeader = "";
                        string tdDetail = "";
                        foreach (DataRow row2 in resultI.Rows)
                        {
                            text = row2["bfi_title"].ToString();
                            if (text == "")
                            {
                                text = row2["bd_column"].ToString();
                            }
                            value = row2["bd_value"].ToString();
                            if (result.Rows.IndexOf(row) == 0)
                            {
                                result.Columns.Add(text, typeof(string)); // Add column form to datatable
                            }
                            row[text] = value;

                            tdHeader = tdHeader + "<td class=\"text-center bg-secondary\" style=\"color:white;\"><b>" + text + "</b></td>";
                            tdDetail = tdDetail + "<td class=\"text-center\">" + value + "</td>";
                        }
                        HTMLDetail = HTMLDetail + "<tr>" + tdHeader + "</tr><tr>" + tdDetail + "</tr>";
                    }

                    HTMLDetail = HTMLDetail + "</table>";
                    row["RowHTML"] = HTMLDetail;
                }
            }

            return result;
        }

        private void ListView_Report(string slotID, string num, string name, string bookdate)
        {
            string STdate = date_ST.Value.ToString();
            string ENdate = date_EN.Value.ToString();

            DataTable dtR = new DataTable();
            dtR = RecordDetail(slotID, STdate, ENdate);
            int cc = dtR.Rows.Count;
            if (dtR.Rows.Count > 0)
            {
                DataView dv = new DataView(dtR);
                if (num != "")
                {
                    dv.RowFilter = "br_id = '" + num + "'";
                }
                if (bookdate != "")
                {
                    dv.RowFilter = "br_bookdate = '" + DateTime.Parse(bookdate).ToString("yyyy-MM-dd") + "'";
                }
                if (name != "")
                {
                    dv.RowFilter = "RowHTML like '%" + name + "%'";
                }

                LV_Report.DataSource = dv;
                LV_Report.DataBind();

                //dtR.Columns.Remove("br_id");
                dtR.Columns.Remove("br_bsid");
                dtR.Columns.Remove("br_createdate");
                dtR.Columns.Remove("br_active");
                dtR.Columns.Remove("br_key");
                dtR.Columns.Remove("RowHTML");

                dtR.Columns["RowIndex"].SetOrdinal(0);
            }
            else
            {
                LV_Report.DataSource = dtR;
                LV_Report.DataBind();

                div_detail.Visible = false;
            }

            GridView1.DataSource = dtR;
            GridView1.DataBind();
        }

        protected void DD_Slot_SelectedIndexChanged(object sender, EventArgs e)
        {
            string slotID = DD_Slot.SelectedValue.ToString();

            txtH_filterDate.Value = "";

            if (slotID != "0")
            {
                Slot(slotID);
                div_detail.Visible = true;
                ListView_Report(slotID,"","","");
            }
            else
            {
                div_detail.Visible = false;
            }
        }

        protected void btn_search_ServerClick(object sender, EventArgs e)
        {
            Search();
        }

        public void Search()
        {
            string slotID = DD_Slot.SelectedValue.ToString();

            string num = txt_search_num.Value.ToString().Trim();
            string name = txt_search_name.Value.ToString().Trim();
            string bookdate = txt_search_date.Value.ToString();

            Slot(slotID);
            div_detail.Visible = true;
            ListView_Report(slotID, num, name, bookdate);
        }

        protected void btn_Export_Click(object sender, EventArgs e)
        {
            string header_lb = DD_Slot.SelectedItem.Text;
            string year = "";
            year = DateTime.Now.ToString("yyyyMMdd");

            string FileName = "BRH_BookingSlot_" + year + ".xls";

            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=" + FileName + "");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel";
            using (StringWriter sw = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(sw);

                //To Export all pages
                GridView1.AllowPaging = false;

                Response.Write("<center><h3>Booking Slot Report</h3>");
                Response.Write("<h5>" + header_lb + "</h5>");

                GridView1.HeaderRow.BackColor = Color.White; // ตัวหนังสือ
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
            }
        }
        public override void VerifyRenderingInServerForm(Control control)
        {
            /* Verifies that the control is rendered */
        }

        protected void btn_cancel_ServerClick(object sender, EventArgs e)
        {
            string scModal = "";

            string id = txtH_bookid.Value.ToString().Trim();
            sql = "update bookingrecord set br_active='no' where br_id = '" + id + "' ";
            if (cl_Sql.Modify(sql))
            {
                scModal = "fn_AlertModal('Success','Success !!','',0);";
                Search();
            }
            else
            {
                scModal = "fn_AlertModal('Warning','ไม่สามารถยกเลิกการจองได้กรุณาติดต่อผู้ดูแลระบบ !!','',0);";
            }

            Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
        }

        protected void btn_dateSearch_ServerClick(object sender, EventArgs e)
        {
            txtH_filterDate.Value = "yes";
            Search();
        }
    }
}