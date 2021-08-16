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
    public partial class TV : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            Data();
        }

        public Boolean Book(string rhdID, string rhsID, string timeBox)
        {
            Boolean bl = false;
            sql = "select * from rehab_book where rhb_active='yes' and rhb_rhdid='" + rhdID + "' and rhb_rhsid='" + rhsID + "' " +
                "and(rhb_timest <= convert('" + timeBox + "', datetime) and rhb_timeen >= convert('" + timeBox + "', datetime)); ";
            DataTable dtb = new DataTable();
            dtb = cl_Sql.select(sql);
            if (dtb.Rows.Count > 0)
            {
                bl = true;
            }
            return bl;
        }

        public string createBox(string rhdID, string rhsID, DateTime workSt, DateTime workEn, DateTime timeSt, DateTime timeEn, DateTime breakSt, DateTime breakEn, int timeSplit)
        {
            string result = "";

            DateTime dateNow = DateTime.Parse(DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));

            while (workSt <= workEn)
            {
                string classBox = "BoxNull";
                if (workSt >= timeSt && timeEn >= workSt) // Work Slot
                {
                    if (workSt >= breakSt && breakEn >= workSt)
                    {
                        classBox = "BoxBreak";
                    }
                    else
                    {
                        if (Book(rhdID, rhsID, workSt.ToString("yyyy-MM-dd HH:mm:ss")))
                        {
                            classBox = "BoxBooked";
                        }
                        else
                        {
                            if (workSt > dateNow)
                            {
                                classBox = "BoxBook";
                            }
                            else
                            {
                                classBox = "BoxOvertime";
                            }
                        }
                    }
                }

                result = result + "<td class=\"" + classBox + "\">" + workSt.ToString("HH:mm") + "</td>";

                workSt = workSt.AddMinutes(timeSplit);
            }

            return result;
        }

        private void Data()
        {
            string HTML = "";

            string aduleBox = "";
            string childBox = "";

            sql = "select rhd_id as 'DateID', rhs_id as 'ScheduleID', rhs_child as 'Child', " +
                "\nrhd_date as 'Dates', rhd_timestart as 'DateSt', rhd_timeend as 'DateEn', " +
                "\nrhs_timeSt as 'TimeStart', rhs_timeEn as 'TimeEnd', rhd_timesplit as 'Timesplit', " +
                "\nrhs_breakSt as 'BreakSt', rhs_breakEn as 'BreakEn', " +
                "\nemp_fname_th as 'Name' " +
                "\nfrom rehab_taskschedule as rhs " +
                "\nleft join rehab_taskdates as rhd on rhd.rhd_id=rhs.rhs_rhdid " +
                "\nleft join employee as emp on emp.emp_id=rhs.rhs_empid " +
                "\nwhere rhs_active='yes' and rhd_active='yes' " +
                "\nand rhd_date=current_date " +
                "\norder by rhs_child desc, rhs_id; ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                DateTime workSt = DateTime.Parse(dt.Rows[0]["DateSt"].ToString());
                DateTime workEn = DateTime.Parse(dt.Rows[0]["DateEn"].ToString());
                int timeSplit = int.Parse(dt.Rows[0]["Timesplit"].ToString());

                int colspan = 1;
                while (workSt <= workEn) 
                {
                    colspan++;
                    workSt = workSt.AddMinutes(timeSplit);
                }

                string aduleBoxHead = "";
                string childBoxHead = "";

                foreach (DataRow dr in dt.Rows)
                {
                    string rhdID = dr["DateID"].ToString();
                    string rhsID = dr["ScheduleID"].ToString();
                    workSt = DateTime.Parse(dr["DateSt"].ToString());
                    workEn = DateTime.Parse(dr["DateEn"].ToString());
                    DateTime timeSt = DateTime.Parse(dr["TimeStart"].ToString());
                    DateTime timeEn = DateTime.Parse(dr["TimeEnd"].ToString());
                    DateTime breakSt = DateTime.Parse(dr["BreakSt"].ToString());
                    DateTime breakEn = DateTime.Parse(dr["BreakEn"].ToString());
                    timeSplit = int.Parse(dr["Timesplit"].ToString());
                    string Child = dr["Child"].ToString();
                    string Name = dr["Name"].ToString();

                    if (Child == "yes")  
                    {
                        childBoxHead = "<tr><td class=\"BoxName\" colspan=\"" + colspan + "\" style=\"background-color:bisque; width: 100%;\"><span style=\"margin-left: 100px;\">สำหรับเด็ก</span></td></tr>";
                        childBox = childBox + "<tr>";
                        childBox = childBox + "<td class=\"BoxName text-right\">" + Name + "</td>";
                        childBox = childBox + createBox(rhdID, rhsID, workSt, workEn, timeSt, timeEn, breakSt, breakEn, timeSplit);
                        childBox = childBox + "</tr>";
                    }
                    else
                    {
                        aduleBoxHead = "<tr><td class=\"BoxName\" colspan=\"" + colspan + "\" style=\"background-color:bisque; width: 100%;\"><span style=\"margin-left: 100px;\">สำหรับผู้ใหญ่</span></td></tr>";
                        aduleBox = aduleBox + "<tr>";
                        aduleBox = aduleBox + "<td class=\"BoxName text-right\">" + Name + " </td>";
                        aduleBox = aduleBox + createBox(rhdID, rhsID, workSt, workEn, timeSt, timeEn, breakSt, breakEn, timeSplit);
                        aduleBox = aduleBox + "</tr>";
                    }
                }
                childBox = childBoxHead + childBox;
                aduleBox = aduleBoxHead + aduleBox;
                string head = "<table class=\"fullscreen\" style=\"font-family: 'Prompt', sans - serif;\" border=\"0\">" +
                          "<tr>" +
                          "  <td colspan=\"1\" class=\"HeadOne\">เจ้าหน้าที่</td>" +
                          "  <td colspan=\"" + (colspan - 1) + "\" class=\"HeadTwo text-center\">" +
                          "      วันที่ <script> fn_dateNowThai();</script>" +
                          "      <span class=\"BoxBook blink\">&nbsp;จองได้&nbsp;</span>" +
                          "      <span class=\"BoxBreak\">&nbsp;พักเบรค&nbsp;</span>" +
                          "      <span class=\"BoxBooked\">&nbsp;จองแล้ว&nbsp;</span>" +
                          "      <span class=\"BoxOvertime\">&nbsp;เลยเวลา&nbsp;</span>" +
                          "  </td>" +
                          "</tr>";
                HTML = HTML + head + aduleBox + childBox + "</table>";
            }

            lbl_Box.Text = HTML;
        }

        protected void timee1_Tick(object sender, EventArgs e)
        {
            Data();
        }
    }
}