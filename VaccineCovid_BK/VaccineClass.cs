using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;

namespace BRH_Plubic.VaccineCovid
{
    public class VaccineClass
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        public DateTime LockPage()
        {
            return DateTime.Parse("2021-07-30 12:00:00");
        }

        public int[] CountDose()
        {
            int[] result = { 0, 0, 0 };

            string id = "2"; // Moderna = 2

            int stock = 0;
            sql = "select * from vaccine where vc_id='" + id + "' ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                string qty = dt.Rows[0]["vc_stock"].ToString();
                if (qty != "")
                {
                    stock = int.Parse(qty);
                }
            }

            int book = 0;
            sql = "select sum(bv_qty) as 'bv_qty' from book_vaccine where bv_vcid='" + id + "' and bv_active='yes' ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                string qty = dt.Rows[0]["bv_qty"].ToString();
                if (qty != "")
                {
                    book = int.Parse(qty);
                }
            }

            int invent = stock - book;

            result[0] = stock;
            result[1] = book;
            result[2] = invent;

            return result;
        }

        public Boolean ClearBooking()
        {
            Boolean bl = false;

            string endTime = (10000).ToString(); // 1hour for SQL

            sql = "update book_vaccine set bv_active='no' " +
                    "\nwhere bv_active='yes' and bv_status='book' and addtime(bv_cdate, '" + endTime + "') < current_timestamp ";
            if (cl_Sql.Modify(sql))
            {
                bl = true;
            }

            return bl;
        }
    }
}