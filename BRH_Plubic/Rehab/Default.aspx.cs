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
    public partial class Default : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CLD_book.SelectedDate = DateTime.Now.Date;
                DateTime date = DateTime.Parse(CLD_book.SelectedDate.ToString());
                TableDashboard("yes", date);

                //SetDOB();
                ToolList();
            }
        }

        //public void SetDOB()
        //{
        //    for (int i = 0; i <= 30; i++)
        //    {
        //        string val = (i + 1).ToString();
        //        dd_DOB_date.Items.Insert(i, new ListItem(val, val));
        //    }

        //    for (int i = 0; i <= 11; i++)
        //    {
        //        int val = (i + 1);
        //        string month = MonthThai(val);
        //        dd_DOB_month.Items.Insert(i, new ListItem(month, val.ToString()));
        //    }

        //    int StartYear = DateTime.Now.Year + 543;
        //    int EndYear = StartYear - 120;
        //    int j = 0;
        //    while (StartYear >= EndYear)
        //    {
        //        dd_DOB_year.Items.Insert(j, new ListItem(StartYear.ToString(), StartYear.ToString()));
        //        j++;
        //        StartYear--;
        //    }
        //}

        public string MonthThai(int NumMonth)
        {
            string month = "";

            switch (NumMonth)
            {
                case 1: month = "มกราคม"; break;
                case 2: month = "กุมภาพันธ์"; break;
                case 3: month = "มีนาคม"; break;
                case 4: month = "เมษายน"; break;
                case 5: month = "พฤษภาคม"; break;
                case 6: month = "มิถุนายน"; break;
                case 7: month = "กรกฎาคม"; break;
                case 8: month = "สิงหาคม"; break;
                case 9: month = "กันยายน"; break;
                case 10: month = "ตุลาคม"; break;
                case 11: month = "พฤศจิกายน"; break;
                case 12: month = "ธันวาคม"; break;
                default: month = ""; break;
            }

            return month;
        }

        protected void CLD_book_DayRender(object sender, DayRenderEventArgs e)
        {
            string date = e.Day.Date.ToString();
            DateTime DateNow = DateTime.Now.Date;

            if (DateTime.Parse(date) >= DateNow)
            {
                date = DateTime.Parse(date).ToString("yyyy-MM-dd");
                sql = "select * from rehab_taskdates where rhd_active='yes' and rhd_date=convert('" + date + "',date); ";
                dt = new DataTable();
                dt = cl_Sql.select(sql);
                if (dt.Rows.Count > 0)
                {
                    e.Day.IsSelectable = true;
                }
                else
                {
                    e.Day.IsSelectable = false;
                    e.Cell.BackColor = System.Drawing.Color.WhiteSmoke;
                }
            }
            else
            {
                e.Day.IsSelectable = false;
                e.Cell.BackColor = System.Drawing.Color.WhiteSmoke;
            }
        }

        protected void CLD_book_SelectionChanged(object sender, EventArgs e)
        {
            SelectDate();
        }

        protected Boolean SelectDate()
        {
            Boolean bl = false;

            DateTime date = DateTime.Parse(CLD_book.SelectedDate.ToString());
            string child = "";
            if (cb_child.Checked)
            {
                child = "yes";
            }
            else
            {
                child = "no";
            }

            if(TableDashboard(child, date))
            {
                bl = true;
            }


            return bl;
        }

        protected Boolean TableDashboard(string child, DateTime date)
        {
            Boolean bl = false; 

            string Dates = date.ToString("yyyy-MM-dd");

            DateTime TimeNow = DateTime.Now.AddMinutes(5); // Hide slot before 5min

            string html = "";

            sql = "select rhd.*, rhs.*, emp.emp_fname_th, concat(emp.emp_pname_th,' ',emp.emp_fname_th,' ',emp.emp_lname_th) as emp_name " +
                "\nfrom rehab_taskdates as rhd " +
                "\nleft join rehab_taskschedule as rhs on rhs.rhs_rhdid = rhd.rhd_id " +
                "\nleft join employee as emp on emp.emp_id = rhs.rhs_empid " +
                "\nwhere rhd.rhd_active = 'yes' and rhs.rhs_active = 'yes' " +
                "\nand rhs_child='" + child + "' and rhd.rhd_date = convert('" + Dates + "', date) " +
                "\norder by rhd_date,rhs.rhs_id";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                string dateHead = date.ToString("dd") + " " + MonthThai(int.Parse(date.ToString("MM"))) + " " + (date.Year + 543).ToString();
                lbl_dateHead.Text = dateHead;

                string rhd = dt.Rows[0]["rhd_id"].ToString();

                int timeSplit = int.Parse(dt.Rows[0]["rhd_timesplit"].ToString());
                string DateTimeST = DateTime.Parse(dt.Rows[0]["rhd_date"].ToString()).ToString("yyyy-MM-dd") + " " + DateTime.Parse(dt.Rows[0]["rhd_timestart"].ToString()).ToString("HH:mm:ss");
                DateTime timeSt = DateTime.Parse(DateTimeST);
                string DateTimeEN = DateTime.Parse(dt.Rows[0]["rhd_date"].ToString()).ToString("yyyy-MM-dd") + " " + DateTime.Parse(dt.Rows[0]["rhd_timeend"].ToString()).ToString("HH:mm:ss");
                DateTime timeEn = DateTime.Parse(DateTimeEN);

                html = "<table style=\"width: 100%; font-size: x-large;\">";
                //html = html + "<td class=\"text-center\" style=\"width: 10%;\">เวลา</td>";
                int i = 0;
                foreach (DataRow dr in dt.Rows)
                {
                    html = html + "<td class=\"text-center\" style=\"width: @W%;\">" + dr["emp_fname_th"].ToString() + "</td>";
                    i++;
                }
                int w = 100 / i;
                html = html.Replace("@W", w.ToString());

                while (timeSt <= timeEn)
                {
                    DateTime D1 = timeSt;
                    DateTime D2 = D1.AddMinutes(timeSplit);

                    html = html + "<tr>";
                    //html = html + "<td>" + timeSt.ToString("HH:mm") + "</td>";
                    foreach (DataRow dr in dt.Rows)
                    {
                        string rhs = dr["rhs_id"].ToString();
                        string empname = dr["emp_name"].ToString();

                        string rhdDate = DateTime.Parse(dr["rhd_date"].ToString()).ToString("yyyy-MM-dd");

                        string StTime = rhdDate + " " + DateTime.Parse(dr["rhs_timeSt"].ToString()).ToString("HH:mm:ss");
                        DateTime StartTime = DateTime.Parse(StTime);

                        string EnTime = rhdDate + " " + DateTime.Parse(dr["rhs_timeEn"].ToString()).ToString("HH:mm:ss");
                        DateTime EndTime = DateTime.Parse(EnTime);

                        DateTime breakSt = DateTime.Parse(dr["rhs_breakSt"].ToString());
                        breakSt = DateTime.Parse(Dates + " " + breakSt.ToString("HH:mm:ss"));
                        DateTime breakEn = DateTime.Parse(dr["rhs_breakEn"].ToString());
                        breakEn = DateTime.Parse(Dates + " " + breakEn.ToString("HH:mm:ss"));

                        html = html + "<td><div class=\"col-12 mx-auto my-1\">";
                        if (breakSt <= timeSt && timeSt < breakEn)
                        {
                            html = html + "<span class=\"col-12 mx-auto btn bg-secondary\" style=\"color: white; font-size: x-large;\">" + timeSt.ToString("HH:mm") + "</span>";
                        }
                        else
                        {
                            if (LockSlot(dr["rhd_id"].ToString(), dr["rhs_id"].ToString(), D1, D2))
                            {
                                html = html + "<span class=\"col-12 mx-auto btn bg-primary\" style=\"color: white; font-size: x-large;\">" + timeSt.ToString("HH:mm") + "</span>";
                            }
                            else
                            {
                                if (TimeNow > timeSt)
                                {
                                    html = html + "<span class=\"col-12 mx-auto btn btn-outline-danger\" style=\"color: white; font-size: x-large;\">" + timeSt.ToString("HH:mm") + "</span>";
                                }
                                else
                                {
                                    if (timeSt >= StartTime && EndTime >= timeSt)
                                    {
                                        html = html + "<a class=\"col-12 mx-auto btn btn-success\" data-toggle=\"modal\" data-target=\"#modalBooking\" style=\"color: white; font-size: x-large; cursor: pointer;\" onclick=\"fn_selecttime('" + dateHead + "','" + timeSt.ToString("HH:mm") + "','" + rhd + "','" + rhs + "','" + empname + "')\">" + timeSt.ToString("HH:mm") + "</a>";
                                    }
                                    else
                                    {
                                        html = html + "<span class=\"col-12 mx-auto btn btn-outline-danger\" style=\"color: white; font-size: x-large;\">" + timeSt.ToString("HH:mm") + "</span>";
                                    }
                                }
                            }
                        }
                        html = html + "</div></td>";
                    }
                    html = html + "</tr>";
                    timeSt = timeSt.AddMinutes(timeSplit);
                }
                html = html + "</table>";

                bl = true;
            }
            else
            {
                lbl_dateHead.Text = Dates;
                html = "<div class\"col-12 mx-auto text-center\">ไม่พบข้อมูล</div>";
            }

            lbl_slot.Text = html;

            if (child == "yes")
            {
                cb_child.Checked = true;
                cb_adult.Checked = false;
            }
            else
            {
                cb_adult.Checked = true;
                cb_child.Checked = false;
            }

            return bl;
        }

        protected void cb_child_CheckedChanged(object sender, EventArgs e)
        {
            DateTime date = DateTime.Parse(CLD_book.SelectedDate.ToString());
            TableDashboard("yes", date);
        }

        protected void cb_adult_CheckedChanged(object sender, EventArgs e)
        {
            DateTime date = DateTime.Parse(CLD_book.SelectedDate.ToString());
            TableDashboard("no", date);
        }

        public Boolean LockSlot(string rhd, string rhs, DateTime Sttime, DateTime Entime)
        {
            Boolean bl = false;

            sql = "select * from rehab_book " +
                "\nwhere rhb_active='yes' and rhb_rhdid='" + rhd + "' and rhb_rhsid='" + rhs + "' " +
                "\nand rhb_timest <= '" + Sttime.ToString("yyyy-MM-dd HH:mm:ss") + "' and rhb_timeen >= '" + Entime.ToString("yyyy-MM-dd HH:mm:ss") + "' ";
            DataTable dt2 = new DataTable();
            dt2 = cl_Sql.select(sql);
            if (dt2.Rows.Count > 0)
            {
                bl = true;
            }

            return bl;
        }

        protected void ToolList()
        {
            sql = "select * from rehab_tool where rht_active='yes' ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {

            }

            dd_tool.DataSource = dt;
            dd_tool.DataTextField = "rht_name";
            dd_tool.DataValueField = "rht_id";
            dd_tool.DataBind();

            dd_tool.Items.Insert(0, new ListItem("ไม่ใช้", "0"));
        }

        protected void dd_tool_SelectedIndexChanged(object sender, EventArgs e)
        {
            string alert = "";

            DateTime date = DateTime.Parse(CLD_book.SelectedDate.ToString());
            string datetimes = date.ToString("yyyy-MM-dd") + " " + txtH_time.Value.ToString();
            string timeEnd = DateTime.Parse(DD_BookTimeEn.SelectedValue.ToString()).ToString("HH:mm:ss");
            string datetimesEnd = date.ToString("yyyy-MM-dd") + " " + timeEnd;
            string toolid = dd_tool.SelectedValue.ToString();

            int cnt_onjob = 0;

            sql = "select * from rehab_book where rhb_active='yes' " +
                "\nand (rhb_timest<='" + datetimes + "' and rhb_timeen >= '" + datetimesEnd + "') " +
                "\nand concat('|',rhb_rhtid,'|') like '%|" + toolid + "|%'; ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {

                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    string[] ArId = dt.Rows[i]["rhb_rhtid"].ToString().Split('|');
                    string[] ArQty = dt.Rows[i]["rhb_toolqty"].ToString().Split('|');

                    for (int j = 0; j < ArId.Length; j++)
                    {
                        if (toolid == ArId[j])
                        {
                            cnt_onjob = cnt_onjob + int.Parse(ArQty[j]);
                            break;
                        }
                    }
                }

                alert = "";
                lbl_tool.ForeColor = System.Drawing.Color.Green;
                if (cnt_onjob > 0)
                {
                    sql = "select * from rehab_tool where rht_active='yes' and rht_id='" + toolid + "'; ";
                    dt = new DataTable();
                    dt = cl_Sql.select(sql);
                    if (dt.Rows.Count > 0)
                    {
                        int qty = int.Parse(dt.Rows[0]["rht_qty"].ToString());
                        if (cnt_onjob >= qty)
                        {
                            alert = "ถูกจองใช้งานในวันเวลานี้เต็มจำนวนแล้ว !!";
                            lbl_tool.ForeColor = System.Drawing.Color.Red;
                        }
                    }
                }
            }

            txtH_toolid.Value = toolid;
            txtH_toolname.Value = dd_tool.SelectedItem.Text;

            lbl_tool.Text = alert;
        }

        protected void btn_BookTimeEn_ServerClick(object sender, EventArgs e)
        {
            string rhsID = txtH_rhs.Value.ToString();
            string rhdID = txtH_rhd.Value.ToString();
            string Date = "";
            string BookTime = DateTime.Parse(txtH_time.Value.ToString()).ToString("HH:mm:ss");
            int SplitTime = 30;
            string EndTime = "";

            sql = "select * from rehab_taskschedule as rhs" +
                "\nleft join rehab_taskdates as rhd on rhd.rhd_id=rhs.rhs_rhdid " +
                "\nwhere rhs_id='" + rhsID + "'; ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                Date = DateTime.Parse(dt.Rows[0]["rhd_date"].ToString()).ToString("yyyy-MM-dd");
                SplitTime = int.Parse(dt.Rows[0]["rhd_timesplit"].ToString());
                EndTime = dt.Rows[0]["rhs_timeEn"].ToString();
            }

            sql = "select min(rhb_timest) as 'rhb_timest' from rehab_book " +
                "\nwhere rhb_active='yes' and rhb_rhdid='" + rhdID + "' and rhb_rhsid='" + rhsID + "' " +
                "\nand rhb_timest >= '" + Date + " " + BookTime + "'; ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                string rhb_timest = dt.Rows[0]["rhb_timest"].ToString();
                if (rhb_timest != "")
                {
                    EndTime = DateTime.Parse(rhb_timest).AddMinutes(-SplitTime).ToString("HH:mm:ss");
                }
            }

            DateTime StTime = DateTime.Parse(Date + " " + BookTime);
            DateTime EnTime = DateTime.Parse(Date + " " + EndTime);

            lbl_booktime.Text = StTime.ToString("HH:mm");


            DataTable dtDD = new DataTable();

            DataColumn dcDD = new DataColumn("DD_Text", typeof(string));
            dtDD.Columns.Add(dcDD);
            dcDD = new DataColumn("DD_Value", typeof(string));
            dtDD.Columns.Add(dcDD);

            int i = 0;
            while (StTime <= EnTime)
            {
                DataRow drDD = dtDD.NewRow();

                StTime = StTime.AddMinutes(SplitTime);

                string St = StTime.ToString("HH:mm");

                drDD[0] = St;
                drDD[1] = St;
                dtDD.Rows.InsertAt(drDD, i);

                i++;
            }
            DD_BookTimeEn.DataSource = dtDD;
            DD_BookTimeEn.DataValueField = "DD_Value";
            DD_BookTimeEn.DataTextField = "DD_Text";
            DD_BookTimeEn.DataBind();
        }

        protected void btn_book_ServerClick(object sender, EventArgs e)
        {
            string scModal = "";

            if (Session["userid"] != null)
            {
                if (lbl_tool.Text == "")
                {
                    string empid = Session["userid"].ToString();

                    string rhdid = txtH_rhd.Value.ToString();
                    string rhsid = txtH_rhs.Value.ToString();
                    string timeSelect = DateTime.Parse(txtH_time.Value.ToString()).ToString("HH:mm:ss");

                    string gender = txtH_gender.Value.ToString();
                    string fname = txt_fname.Value.ToString().Trim();
                    string lname = txt_lname.Value.ToString().Trim();
                    string HN = txt_hn.Value.ToString().Trim();
                    string toolid = dd_tool.SelectedValue.ToString();
                    string toolqty = num_toolqty.Value.ToString();
                    string IPD = rd_ipd.ToString();
                    string OPD = rd_opd.ToString();
                    string OI = "";
                    if (rd_ipd.Checked)
                    {
                        OI = rd_ipd.Value.ToString();
                    }
                    else
                    {
                        OI = rd_opd.Value.ToString();
                    }
                    string remark = txt_remark.Value.ToString().Trim();

                    sql = "select * from rehab_taskdates where rhd_active='yes' and rhd_id='" + rhdid + "'; ";
                    dt = new DataTable();
                    dt = cl_Sql.select(sql);
                    if (dt.Rows.Count > 0)
                    {
                        string dateSelect = DateTime.Parse(dt.Rows[0]["rhd_date"].ToString()).ToString("yyyy-MM-dd");
                        int timesplit = int.Parse(dt.Rows[0]["rhd_timesplit"].ToString());

                        string timeSt = dateSelect + " " + timeSelect;
                        string timeEn = dateSelect + " " + DateTime.Parse(DD_BookTimeEn.SelectedValue.ToString()).ToString("HH:mm:ss");

                        toolid = "0";
                        toolqty = "0";
                        if (txtH_ARtool.Value.ToString() != "")
                        {
                            string[] ArTool = txtH_ARtool.Value.ToString().Trim().Split(','); // ---------------------------------------------
                            for (int i = 0; i < ArTool.Length; i++)
                            {
                                string[] ArIdQty = ArTool[i].Split('|');
                                if (i > 0)
                                {
                                    toolid = toolid + "|";
                                    toolqty = toolqty + "|";
                                }
                                toolid = toolid + ArIdQty[0];
                                toolqty = toolqty + ArIdQty[1];
                            }
                        }
                        

                        sql = "insert into rehab_book(rhb_cuser,rhb_timest,rhb_timeen,rhb_rhdid,rhb_rhsid,rhb_rhtid,rhb_toolqty,rhb_gender,rhb_fname,rhb_lname,rhb_hn,rhb_oi,rhb_remark) " +
                        "\nvalues('" + empid + "','" + timeSt + "','" + timeEn + "','" + rhdid + "','" + rhsid + "','" + toolid + "','" + toolqty + "','" + gender + "','" + fname + "','" + lname + "','" + HN + "','" + OI + "','" + remark + "'); ";
                        if (cl_Sql.Modify(sql))
                        {
                            if (SelectDate())
                            {
                                scModal = "fn_AlertModal('Success','Success !!','',0);";
                            }
                            else
                            {
                                scModal = "fn_AlertModal('Info','บันทึกเรียบร้อยแล้ว ถ้าหาก slot ไม่เปลี่ยนสี กรุณาออกแล้วเข้าระบบใหม่อีกครั้ง !!','',0);";
                            }
                        }
                        else
                        {
                            scModal = "fn_AlertModal('Warning','ไม่สามารถบันทึกได้ กรุณาติดต่อผู้ดูแลระบบ !!','',0);";
                        }
                    }
                    else
                    {
                        scModal = "fn_AlertModal('Warning','ไม่พบข้อมูลวันที่ กรุณาติดต่อผู้ดูแลระบบ !!','',0);";
                    }
                }
                else
                {
                    scModal = "fn_AlertModal('Warning','เครื่องมือที่ต้องการใช้งาน ถูกจองใช้งานในวันเวลาที่เลือกเต็มแล้ว !!','',0);";
                }
            }
            else
            {
                scModal = "fn_AlertModal('Info','บันทึกข้อมูลได้เฉพาะเจ้าหน้าที่ เท่านั้น !!','',0);";
            }
            Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
        }
    }
    

}