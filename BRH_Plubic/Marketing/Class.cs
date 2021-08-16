using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;

namespace BRH_Plubic.Marketing
{
    public class ClassMarketing
    {
        string sql = "";
        DataTable dt;
        SQLclass CL_Sql = new SQLclass();

        public string versionNumber(string tablename, string fieldID, string id, string fieldVersion)
        {
            string result = "";

            sql = "select " + fieldVersion + " from " + tablename + " where " + fieldID + " = '" + id + "' ";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                result = dt.Rows[0][fieldVersion].ToString();
            }

            return result;
        }
    }
}