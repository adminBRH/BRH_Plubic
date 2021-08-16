using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.AspNet.SignalR;

using System.Data;
using System.Data.SqlClient;
using System.Text;
using MySql.Data.MySqlClient;
using Newtonsoft.Json;

namespace BRH_Plubic
{
    public class MyChatHub : Hub
    {
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        public void MyChatSend(string name, string to, string message)
        {
            // Call the broadcastMessage method to update clients.
            Clients.All.broadcastMessage(name, to, message);
        }

        public void CallFunction(string sql_action, string sql_select)
        {
            actionData(sql_action);

            SelectData(sql_select);
        }

        public void actionData(string sql)
        {
            cl_Sql.Modify(sql);
        }

        public void SelectData(string sql)
        {
            string json = string.Empty;

            dt = new DataTable();
            dt = cl_Sql.select(sql);

            //var ls = new List<mytable>();
            json = "[";
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