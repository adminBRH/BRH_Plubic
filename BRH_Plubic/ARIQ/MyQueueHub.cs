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

namespace BRH_Plubic.ARIQ
{
    public class MyQueueHub : Hub
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        public class tableQueue
        {
            public string status { get; set; }
            public string room { get; set; }
            public string number { get; set; }
        }

        public void SaveData(string status, string room, string number)
        {
            if (number != string.Empty)
            {
                //sql = "insert into mytable(name, email) values('" + name + "','" + email + "') ";
                //if (cl_Sql.Modify(sql))
                //{

                //}
            }
            //SelectData();
        }
    }
}