using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BRH_Plubic.Function
{
    public class Customize
    {
        public string MonthThai(string monthNumber)
        {
            string result = "";

            switch (monthNumber)
            {
                case "01": result = "มกราคม"; break;
                case "02": result = "กุมภาพันธ์"; break;
                case "03": result = "มีนาคม"; break;
                case "04": result = "เมษายน"; break;
                case "05": result = "พฤษภาคม"; break;
                case "06": result = "มิถุนายน"; break;
                case "07": result = "กรกฎาคม"; break;
                case "08": result = "สิงหาคม"; break;
                case "09": result = "กันยายน"; break;
                case "10": result = "ตุลาคม"; break;
                case "11": result = "พฤศจิกายน"; break;
                case "12": result = "ธันวาคม"; break;
                default: break;
            }

            return result;
        }
    }
}