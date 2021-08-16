using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using Microsoft.AspNet.SignalR;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;

using System.Threading.Tasks;
using System.Diagnostics;

namespace BRH_Plubic.Rehab.Hubs
{
    public class RehabHUB : Hub
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        public string Book(string rhdID, string rhsID, int splitTime)
        {
            string result = "";
            sql = "select * from rehab_book where rhb_active='yes' " +
                "\nand rhb_rhdid = '" + rhdID + "' and rhb_rhsid = '" + rhsID + "' " +
                "\norder by rhb_timest ";
            DataTable dtb = new DataTable();
            dtb = cl_Sql.select(sql);
            if (dtb.Rows.Count > 0)
            {
                foreach (DataRow drd in dtb.Rows)
                {
                    string timeSt = drd["rhb_timest"].ToString();
                    string timeEn = drd["rhb_timeen"].ToString();
                    DateTime bookSt = DateTime.Parse(timeSt);
                    DateTime bookEn = DateTime.Parse(timeEn);
                    while (bookSt <= bookEn)
                    {
                        if (result != "") { result = result + ","; }
                        result = result + bookSt.ToString("yyyy-MM-dd HH:mm:00");
                        bookSt = bookSt.AddMinutes(splitTime);
                    }
                }
                result = "'" + result + "'";
            }
            return result;
        }

        public void Data()
        {
            sql = "select rhd_id as 'DateID', rhs_id as 'ScheduleID', rhs_child as 'Child', " +
                "\nrhd_date as 'Dates', rhd_timestart as 'DateSt', rhd_timeend as 'DateEn', " +
                "\nrhs_timeSt as 'TimeStart', rhs_timeEn as 'TimeEnd', rhd_timesplit as 'Timesplit', " +
                "\nrhs_breakSt as 'BreakSt', rhs_breakEn as 'BreakEn', " +
                "\nemp_fname_th as 'Name', " +
                "\nnull as Booktime " +
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
                foreach (DataRow dr in dt.Rows)
                {
                    string DateID = dr["DateID"].ToString();
                    string ScheduleID = dr["ScheduleID"].ToString();
                    int Timesplit = int.Parse(dr["Timesplit"].ToString());

                    dr["Booktime"] = Book(DateID, ScheduleID, Timesplit);
                }
            }

            string json = "[";
            if (dt.Rows.Count > 0)
            {
                foreach (DataRow dr in dt.Rows)
                {
                    if (dt.Rows.IndexOf(dr) > 0) { json = json + ","; }
                    json = json + "{";
                    string comma = "";
                    foreach (DataColumn dc in dr.Table.Columns)
                    {
                        json = json + comma;
                        comma = ",";
                        json = json + "\"" + dc.ColumnName + "\"";
                        json = json + ":";
                        json = json + "\"" + dr[dc.ColumnName].ToString() + "\"";
                    }
                    json = json + "}";
                }
            }
            json = json + "]";

            Clients.All.displayData(json);
        }
    }
}