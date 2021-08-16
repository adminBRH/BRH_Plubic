using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;

namespace BRH_Plubic.Service
{
    public class MakeControler
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        public string Controler(string inputID, string type, string inputIndex, string title, string ph)
        {
            string result = "";

            if (type == "text")
            {
                result = Textbox(title, ph, inputIndex);
            }
            else if (type == "dropdownlist")
            {
                result = DropDown(inputID, title, inputIndex);
            }
            else if (type == "radio" || type == "checkbox")
            {
                result = RadioOrCheckbox(inputID, title, inputIndex, type);
            }
            else
            { }

            return result;
        }

        public string Textbox(string title, string ph, string inputIndex)
        {
            string result = "";
            string id = "conT_" + inputIndex;
            string name = "conT_" + inputIndex;

            result = result + "\n<div class=\"row col-12\">";
            result = result + "\n<div class=\"col-4 mx-auto text-right my-auto h5\">" + title + " : </div>";
            result = result + "\n<div class=\"col-8 mx-auto text-left my-auto\">";
            result = result + "\n<input type=\"text\" id=\"" + id + "\" name=\"" + name + "\" class=\"form-control mx-auto  my-auto\" placeholder=\"" + ph + "\" runat=\"server\" />";
            result = result + "\n</div>";
            result = result + "\n</div> ";

            return result;
        }

        private string ArList(string inputID)
        {
            string result = "";

            sql = "select * from bookingforminputlist where bfil_bfiid='" + inputID + "' order by bfil_index ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                for (int i=0; i<dt.Rows.Count; i++)
                {
                    if (result != "") { result = result + "|"; }
                    string index = dt.Rows[i]["bfil_index"].ToString();
                    string text = dt.Rows[i]["bfil_text"].ToString();
                    string value = dt.Rows[i]["bfil_value"].ToString();
                    result = result + index + "," + text + "," + value;
                }
            }

            return result;
        }

        public string DropDown(string inputID, string title, string inputIndex)
        {
            string result = "";

            string text = "";
            string value = "";

            string nameText = "conT_" + inputIndex;
            string nameValue = "conT_" + inputIndex;

            result = result + "\n<div class=\"row col-12\">";
            result = result + "\n<div class=\"col-4 mx-auto text-right my-auto h5\">" + title + " : </div>";
            result = result + "\n<div class=\"col-8 mx-auto text-left my-auto\">";
            result = result + "\n<select id=\"" + nameText + "\" name=\"" + nameValue + "\" class=\"card\">" +
                              "\n  <option value=\"\" selected=\"selected\">Please select item</option>";
            string[] ListAr = ArList(inputID).Split('|');
            for (int i=0; i< ListAr.Length; i++)
            {
                string[] List = ListAr[i].ToString().Split(',');
                text = List[1].ToString();
                value = List[2].ToString();
                result = result + "\n  <option value=\"" + value + "\">" + text + "</option>";
            }
            result = result + "\n</select>";
            result = result + "\n</div> ";
            result = result + "\n<div hidden=\"hidden\"></div>"; // << ---------- for Replace to button Close on ADD
            result = result + "\n</div> ";

            return result;
        }

        protected string RadioOrCheckbox(string inputID, string title, string inputIndex, string type)
        {
            string result = "";

            string index = "";
            string text = "";
            string value = "";

            string nameText = "conT_" + inputIndex;
            string nameValue = "conT_" + inputIndex;

            result = result + "\n<div class=\"row col-12\">";
            result = result + "\n<div class=\"col-4 mx-auto text-right h5\">" + title + " : </div>";
            result = result + "\n<div class=\"col-8 mx-auto text-left my-auto\">";
            result = result + "\n<div class=\"row col-12 mx-auto\">";

            string[] ListAr = ArList(inputID).Split('|');
            for (int i = 0; i < ListAr.Length; i++)
            {
                string[] List = ListAr[i].ToString().Split(',');
                index = List[0].ToString();
                text = List[1].ToString();
                value = List[2].ToString();
                string idText = nameText + "_" + index;
                string idName = nameValue;

                if (type == "checkbox")
                {
                    idName = idName + "_" + index;
                }

                string Checked = "";
                if (i == 0)
                {
                    Checked = "checked=\"checked\"";
                }

                string inputConT = "";
                if (type == "radio")
                {
                    inputConT = "<input type=\"radio\" id=\"" + idText + "\" name=\"" + idName + "\" value=\"" + value + "\" class=\"RadioSize\" " + Checked + " />";
                }
                else
                {
                    inputConT = "<input type=\"checkbox\" id=\"" + idText + "\" name=\"" + idName + "\" class=\"RadioSize\" value=\"" + value + "\" " + Checked + " />";
                }

                result = result +
                        "<div class=\"row col-12 mx-auto\">" +
                        "    <div class=\"col-2 mx-auto text-right\">" + inputConT + "</div>" +
                        "    <div class=\"col-10 mx-auto my-auto text-left h5\">" + text + "</div>" +
                        "</div>";
            }

            result = result + "\n</div>";
            result = result + "\n</div> ";
            result = result + "\n</div> ";

            return result;
        }
    }
}