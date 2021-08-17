using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using MySql.Data.MySqlClient;
using System.Text;
using MySqlX.XDevAPI;
using Renci.SshNet;
using Session = MySqlX.XDevAPI.Session;
using System.Web.Services.Description;
using Microsoft.AspNet.SignalR.Infrastructure;

using System.Drawing;
using System.Drawing.Drawing2D;
using System.Net.NetworkInformation;

public class ConnectDB
{
    public SqlConnection SqlStrCon()
    {
        //return new SqlConnection("Data Source=BRH-DBS01.BDMS.CO.TH;Initial Catalog=BRH_IT_REQUEST" +
        //    ";Persist Security Info=True;User ID=sa;Password=P@ssw0rd");
        //return new SqlConnection("Data Source=203.154.41.76;Initial Catalog=RunDB" +
        //    ";Persist Security Info=True;User ID=sa;Password=P@ssw0rd@brh");
        return new SqlConnection("Data Source=10.121.13.41;Initial Catalog=BRH_Bconnect_RPT" +
            ";Persist Security Info=True;User ID=reports;Password=reports");
    }
}

public class SQLclass
{
    // Localhost
    //string connection = "Server=localhost;User Id=root; Password=P@ssw0rd; Database=BRH_Informatics; charset=utf8;Pooling=false; Port=3306;";

    // FTP: 103.245.164.57 Id=brh-admin; Password=P@ssw0rd1168;
    // Database: db1.telecorp.co.th/phpMyAdmin Id=telecorp; Password=@Telecorp$12345;
    string connection = "Server=db1.telecorp.co.th;User Id=telecorp; Password=@Telecorp$12345; Database=brh_hospitaldb; charset=utf8;Pooling=false";

    // Server in BRH
    //string connection = "Server=10.3.10.103;User Id=clusteruser; Password=clusterp@$$; Database=brh_informatics; charset=utf8;Pooling=false";

    // 27.254.59.12/phpMyAdmin/db_structure.php?server=1&db=brh_hospitaldb  
    //string connection = "Server=localhost;User Id=brh_admin; Password=11681168; Database=brh_hospitaldb; charset=utf8;Pooling=false";

    //SQL Server Class
    public DataTable select(string sql)
    {
        //SqlConnection conn = new ConnectDB().SqlStrCon(); 
        //conn.Open();
        //SqlDataAdapter da = new SqlDataAdapter(sql, conn);
        //DataTable dt = new DataTable();
        //da.Fill(dt);
        //conn.Close();
        //return dt;

        DataTable dt = new DataTable();
        //try
        //{

        //}
        //catch (Exception)
        //{
        //    System.Web.HttpContext.Current.Response.Write("<script>alertModalWarning('#Modal_Warning','ไม่สามารถติดต่อฐานข้อมูลได้ !!');<script>");
        //}

        MySqlConnection conn = new MySqlConnection(connection);
        MySqlDataAdapter da = new MySqlDataAdapter(sql, conn);
        conn.Open();
        da.Fill(dt);
        conn.Close();

        return dt;
    }

    public DataTable selectBconnect(string sql)
    {
        SqlConnection conn = new ConnectDB().SqlStrCon();
        conn.Open();
        SqlDataAdapter da = new SqlDataAdapter(sql, conn);
        DataTable dt = new DataTable();
        da.Fill(dt);
        conn.Close();
        return dt;
    }

    public string ToJSON(string sql)
    {
        string json = string.Empty;

        DataTable dt = new DataTable();
        dt = select(sql);

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

        return json;
    }

    public Boolean Modify(string sql)
    {
        MySqlConnection conn = new MySqlConnection(connection);
        MySqlCommand command = conn.CreateCommand();
        command.CommandText = sql;
        try
        {
            conn.Open();
            command.ExecuteNonQuery();
            conn.Close();
            return true;
        }
        catch
        {
            return false;
        }
    }

    public string LastID(string id, string table)
    {
        string StID = "";
        string sql = "SELECT LAST_INSERT_ID(" + id + ") as LastID from " + table + "  order by " + id + " desc";
        DataTable dts = new DataTable();
        dts = select(sql);
        StID = dts.Rows[0]["LastID"].ToString();
        return StID;
    }

    public string MD5Hash(string txtPassword)
    {
        System.Security.Cryptography.MD5 md5 = System.Security.Cryptography.MD5CryptoServiceProvider.Create();
        byte[] dataMd5 = md5.ComputeHash(Encoding.Default.GetBytes(txtPassword));
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < dataMd5.Length; i++)
            sb.AppendFormat("{0:x2}", dataMd5[i]);
        return sb.ToString();
    }

    public string GenerateKey(int Len)
    {
        string Key = "";

        string Letters = "";
        for (int Gi = 1; Gi <= Len; Gi++)
        {
            Letters = Letters + "\n substring('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789', rand() * 36 + 1, 1)";

            if (Gi < Len)
            {
                Letters = Letters + ", ";
            }
            else
            {
                Letters = Letters + " ";
            }
        }

        string sql = "select concat (" + Letters + ") as 'License'; ";
        DataTable dtKey = new DataTable();
        dtKey = select(sql);
        if (dtKey.Rows.Count > 0)
        {
            Key = dtKey.Rows[0]["License"].ToString();
        }

        return Key;
    }

    public string DateTimeTH(string DT)
    {
        string result = "";

        DateTime date = DateTime.Parse(DT);
        result = date.Day.ToString() + "/" + date.Month.ToString() + "/" + date.Year.ToString();
        result = result + " " + date.Hour.ToString() + ":" + date.Minute.ToString() + ":" + date.Second.ToString();

        return result;
    }

    public string DateTH(string DT)
    {
        string result = "";

        DateTime date = DateTime.Parse(DT);
        result = date.Day.ToString() + "/" + date.ToString("MMM") + "/" + date.Year.ToString();

        return result;
    }

    public string WeekDayEng(string num)
    {
        string result = "";

        switch (num)
        {
            case "1": result = "Monday"; break;
            case "2": result = "Tuesday"; break;
            case "3": result = "Wednesday"; break;
            case "4": result = "Thursday"; break;
            case "5": result = "Friday"; break;
            case "6": result = "Saturday"; break;
            case "7": result = "Sunday"; break;
            default:
                break;
        }

        return result;
    }

    public int Date2YearOld(DateTime DOB)
    {
        int sesult = 0;

        int YearNow = DateTime.Now.Year;
        int MonthNow = DateTime.Now.Month;
        int DayNow = DateTime.Now.Day;

        sesult = YearNow - DOB.Year;

        if (MonthNow < DOB.Month)
        {
            sesult = sesult - 1;
        }
        else if (MonthNow == DOB.Month)
        {
            if (DayNow < DOB.Day)
            {
                sesult = sesult - 1;
            }
        }
        else { }

        return sesult;
    }

    public string TimeAgo(DateTime UpdateDate)
    {
        string result = "";

        double ago = 1;
        DateTime nowDate = DateTime.Now;
        if (UpdateDate < (nowDate.AddYears(-1)))
        {
            ago = (nowDate - UpdateDate).TotalDays;
            ago = ago / 365;
            result = " Years ago";
        }
        else if (UpdateDate < (nowDate.AddMonths(-1)))
        {
            ago = (nowDate - UpdateDate).TotalDays;
            ago = ago / 30;
            result = " Months ago";
        }
        else if (UpdateDate < (nowDate.AddHours(-24)))
        {
            ago = (nowDate - UpdateDate).TotalDays;
            result = " Days ago";
        }
        else if (UpdateDate < (nowDate.AddHours(-1)))
        {
            ago = (nowDate - UpdateDate).TotalHours;
            result = " hours ago";
        }
        else if (UpdateDate < (nowDate.AddMinutes(-1)))
        {
            ago = (nowDate - UpdateDate).TotalMinutes;
            result = " minutes ago";
        }
        else
        {
            ago = (nowDate - UpdateDate).Seconds;
            result = " seconds ago";
        }
        int timeAgo = Convert.ToInt32(ago);

        return timeAgo + result;
    }

    public DataTable sp_doctorRating(string EN, string LO)
    {
        DataTable dt_sp = new DataTable();
        string sql = "select ds.ds_id,ds.ds_dlid,dl.dl_name,ds.ds_drid,dr.dr_doctorid,dr.dr_forename,dr.dr_surname,dr.dr_englishname,fn_doctorRating(ds.ds_drid) as 'dr_rating', " +
                "\n    case dayname(current_date()) " +
                "\n        when 'Sunday' then ds.ds_sunday_start " +
                "\n        when 'Monday' then ds.ds_monday_start " +
                "\n        when 'Tuesday' then ds.ds_tuesday_start " +
                "\n        when 'Wednesday' then ds.ds_wednesday_start " +
                "\n        when 'Thursday' then ds.ds_thursday_start " +
                "\n        when 'Friday' then ds.ds_friday_start " +
                "\n        when 'Saturday' then ds.ds_monday_start " +
                "\n        else null " +
                "\n    end as StartDate, " +
                "\n    case dayname(current_date())  " +
                "\n        when 'Sunday' then ds.ds_sunday_finish " +
                "\n        when 'Monday' then ds.ds_monday_finish " +
                "\n        when 'Tuesday' then ds.ds_tuesday_finish " +
                "\n        when 'Wednesday' then ds.ds_wednesday_finish " +
                "\n        when 'Thursday' then ds.ds_thursday_finish " +
                "\n        when 'Friday' then ds.ds_friday_finish " +
                "\n        when 'Saturday' then ds.ds_monday_start " +
                "\n        else null " +
                "\n    end as FinishDate, " +
                "\n    ds.ds_status,ds.ds_active,dr.dr_img " +
                "\nfrom doctor_schedule as ds " +
                "\nleft join doctor as dr on dr.dr_id=ds.ds_drid " +
                "\nleft join doctor_location as dl on dl.dl_id=ds.ds_dlid " +
                "\nleft join doctor_rating as drr on drr.drr_dlid=ds.ds_dlid and drr.drr_drid=ds.ds_drid " +
                "\nwhere dl.dl_id = '" + LO + "' and drr.drr_en = '" + EN + "' and drr.drr_active='no' and CONVERT(drr.drr_datetime,date)=CURRENT_DATE " +
                "\norder by ds.ds_dlid,ds.ds_drid";
        dt_sp = select(sql);
        return dt_sp;
    }

    public System.Drawing.Image resizeImage(System.Drawing.Image imgToResize, Size size)
    {
        //Get the image current width  
        int sourceWidth = imgToResize.Width;
        //Get the image current height  
        int sourceHeight = imgToResize.Height;
        float nPercent = 0;
        float nPercentW = 0;
        float nPercentH = 0;
        //Calulate  width with new desired size  
        nPercentW = ((float)size.Width / (float)sourceWidth);
        //Calculate height with new desired size  
        nPercentH = ((float)size.Height / (float)sourceHeight);
        if (nPercentH < nPercentW)
            nPercent = nPercentH;
        else
            nPercent = nPercentW;
        //New Width  
        int destWidth = (int)(sourceWidth * nPercent);
        //New Height  
        int destHeight = (int)(sourceHeight * nPercent);
        Bitmap b = new Bitmap(destWidth, destHeight);
        Graphics g = Graphics.FromImage((System.Drawing.Image)b);
        g.InterpolationMode = InterpolationMode.HighQualityBicubic;
        // Draw image with new width and height  
        g.DrawImage(imgToResize, 0, 0, destWidth, destHeight);
        g.Dispose();
        return (System.Drawing.Image)b;
    }

    public Boolean InternetConnect()
    {
        Boolean bl = false;

        try
        {
            Ping myPing = new Ping();
            String host = "google.com";
            byte[] buffer = new byte[32];
            int timeout = 1000;
            PingOptions pingOptions = new PingOptions();
            PingReply reply = myPing.Send(host, timeout, buffer, pingOptions);
            //return (reply.Status == IPStatus.Success);
            bl = true;
        }
        catch (Exception)
        {
            //return false;
        }

        return bl;
    }
}
