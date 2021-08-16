using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;
using BRH_Plubic.Service;

namespace BRH_Plubic.CHK
{
    public partial class Form : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();
        MakeControler MConT = new MakeControler();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Login"] == null)
            {
                Response.Redirect("../Default.aspx?back=CHK&login=require");
            }
            else
            {
                string status = Session["status"].ToString();
                if (status == "admin" || status == "hr" || status == "checkup" || status == "xray" || status == "mao")
                {
                    if (!IsPostBack)
                    {
                        ListForm();
                    }
                }
                else
                {
                    Response.Write("<script>alert('คุณไม่มีสิทธิ์ ใช้งานระบบนี้ !!'); window.location.href='../Default.aspx';</script>");
                }
            }
        }

        private void ListForm()
        {
            sql = "select * from bookingform where bf_id > 1 and bf_active = 'yes' order by bf_id ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            { }
            LV_Form.DataSource = dt;
            LV_Form.DataBind();
        }

        protected string Controler(string FormID)
        {
            string HTML = "";

            sql = "select * from bookingforminput where bfi_required='yes' and bfi_bfid='" + FormID + "' order by bfi_index ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    string inputID = dt.Rows[i]["bfi_id"].ToString();
                    string type = dt.Rows[i]["bfi_type"].ToString();
                    string inputIndex = dt.Rows[i]["bfi_id"].ToString();
                    string title = dt.Rows[i]["bfi_title"].ToString();
                    string PH = dt.Rows[i]["bfi_placeholder"].ToString();

                    if (HTML == "") { HTML = HTML + "<div class=\"col-12 mx-auto\"><hr></div>"; }
                    HTML = HTML + MConT.Controler(inputID, type, inputIndex, title, PH);
                    HTML = HTML + "<div class=\"col-12 mx-auto\"><hr></div>";
                }
            }
            return HTML;
        }

        protected void btn_List_previewForm_Click(object sender, EventArgs e)
        {
            string formID = txtH_List_formID.Value.ToString().Trim();
            lbl_ListPreview.Text = Controler(formID);
            txtH_List_formID.Value = "";
        }



        protected void DD_Type_SelectedIndexChanged(object sender, EventArgs e)
        {
            string type = DD_Type.SelectedValue.ToString();
            if (type == "")
            {
                div_editControler.Visible = false;
                if (txtH_index_Form.Value.ToString().Trim() == "")
                {
                    div_submit.Visible = false;
                }
                else
                {
                    div_submit.Visible = true;
                }
            }
            else
            {
                div_submit.Visible = false;

                lbl_alert.Text = "";

                div_editControler.Visible = true;
                txtH_DropDownRadio_index.Value = "0";
                txtH_DropDownRadio_list.Value = "";
                txtH_DropDownRadio_listTextValue.Value = "";
                txtH_DropDownRadio_hidden.Value = "";
                lbl_List_DropDownRadio.Text = "";

                MakeControler(type,"");
            }
        }

        protected string MakeControler(string conT, string add)
        {
            string result = "";

            FormHTML();

            string title = txt_title.Value.ToString().Trim();

            div_for_text.Visible = false;
            div_for_DropDownRadio.Visible = false;

            if (title != "")
            {
                if (conT == "text")
                {
                    div_for_text.Visible = true;

                    txtH_DropDownRadio_list.Value = "1";
                    txtH_DropDownRadio_index.Value = "1";

                    string placeholder = txt_placeholder.Value.ToString().Trim();
                    result = Textbox(title, placeholder);
                }
                else if (conT == "dropdownlist")
                {
                    div_for_DropDownRadio.Visible = true;
                    result = DropDown(title);
                }
                else if (conT == "radio" || conT == "checkbox")
                {
                    div_for_DropDownRadio.Visible = true;
                    result = RadioOrCheckbox(title, conT);
                }
                else
                { }

                ShowBtnAddControler();
            }

            lbl_sample.Text = result;

            return result;
        }

        protected string Textbox(string title, string plh)
        {
            string result = "";

            string nameText = IndexConTtext();
            string nameValue = IndexConTvalue();

            result = result + "\n<div id=\"conT_\" class=\"row col-12\">";
            result = result + "\n<div class=\"col-4 mx-auto text-right my-auto h5\">" + title + " : </div>";
            result = result + "\n<div class=\"col-7 mx-auto text-left my-auto\">";
            result = result + "\n<input type=\"text\" id=\"" + nameText + "\" name=\"" + nameValue + "\" class=\"form-control mx-auto  my-auto\" placeholder=\"" + plh + "\" runat=\"server\" />";
            result = result + "\n</div>";
            result = result + "\n<div hidden=\"hidden\"></div>"; // << ---------- for Replace to button Close on ADD
            result = result + "\n</div> ";

            txtH_DropDownRadio_listTextValue.Value = title + "}" + title + ":" + plh;

            return result;
        }

        protected string DropDown(string title)
        {
            string result = "";

            string text = "";
            string value = "";

            string nameText = IndexConTtext();
            string nameValue = IndexConTvalue();

            result = result + "\n<div id=\"conT_\" class=\"row col-12\">";
            result = result + "\n<div class=\"col-4 mx-auto text-right my-auto h5\">" + title + " : </div>";
            result = result + "\n<div class=\"col-7 mx-auto text-left my-auto\">";
            result = result + "\n<select id=\"" + nameText + "\" name=\"" + nameValue + "\" class=\"card\">" +
                              "\n  <option value=\"\" selected=\"selected\">Please select item</option>";
            string List = txtH_DropDownRadio_list.Value.ToString();
            if (List != "")
            {
                string ListValue = "";
                string[] ArList = List.Split(',');
                for (int i = 0; i < ArList.Length; i++)
                {
                    string idText = nameText + ArList[i].ToString();
                    string idValue = nameValue + ArList[i].ToString();
                    text = String.Format("{0}", Request.Form[idText]);
                    value = String.Format("{0}", Request.Form[idValue]);

                    result = result + "\n  <option value=\"" + value + "\">" + text + "</option>";

                    if (ListValue != "") { ListValue = ListValue + ";"; }
                    ListValue = ListValue + text + ":" + value;
                }
                txtH_DropDownRadio_listTextValue.Value = title + "}" + ListValue;
            }
            result = result + "\n</select>";
            result = result + "\n</div> ";
            result = result + "\n<div hidden=\"hidden\"></div>"; // << ---------- for Replace to button Close on ADD
            result = result + "\n</div> ";

            return result;
        }

        protected string RadioOrCheckbox(string title, string type)
        {
            string result = "";

            string text = "";
            string value = "";

            string nameText = IndexConTtext();
            string nameValue = IndexConTvalue();

            result = result + "\n<div id=\"conT_\" class=\"row col-12\">";
            result = result + "\n<div class=\"col-4 mx-auto text-right h5\">" + title + " : </div>";
            result = result + "\n<div class=\"col-7 mx-auto text-left my-auto\">";
            result = result + "\n<div class=\"row col-12 mx-auto\">";
            string indexMake = txtH_DropDownRadio_index.Value.ToString();
            if (indexMake == "0")
            {
                lbl_List_DropDownRadio.Text = AddList("yes");
            }
            string List = txtH_DropDownRadio_list.Value.ToString();
            if (List != "")
            {
                string ListValue = "";
                string[] ArList = List.Split(',');
                for (int i = 0; i < ArList.Length; i++)
                {
                    string idText = nameText + ArList[i].ToString();
                    string idName = nameValue;

                    string Checked = "";
                    if (i == 0)
                    {
                        Checked = "checked=\"checked\"";
                    }

                    if (indexMake == "0")
                    {
                        text = "Name";
                        value = "Value";
                    }
                    else
                    {
                        text = String.Format("{0}", Request.Form[idText]);
                        value = String.Format("{0}", Request.Form[idName + ArList[i].ToString()]);
                    }

                    idText = type + "_" + idText;
                    idName = type + "_" + idName;

                    if (type == "checkbox")
                    {
                        idName = idName + ArList[i].ToString();
                    }

                    string inputConT = "<input type=\"" + type + "\" id=\"" + idText + "\" name=\"" + idName + "\" value=\"" + value + "\" class=\"RadioSize\" " + Checked + " />";

                    result = result +
                        "<div class=\"row col-12 mx-auto\">" +
                        "    <div class=\"col-2 mx-auto text-right\">" + inputConT + "</div>" +
                        "    <div class=\"col-10 mx-auto my-auto text-left h5\">" + text + "</div>" +
                        "</div>";

                    if (ListValue != "") { ListValue = ListValue + ";"; }
                    ListValue = ListValue + text + ":" + value;
                }
                txtH_DropDownRadio_listTextValue.Value = title + "}" + ListValue;
            }
            result = result + "\n</div>";
            result = result + "\n</div> ";
            result = result + "\n<div hidden=\"hidden\"></div>"; // << ---------- for Replace to button Close on ADD
            result = result + "\n</div> ";

            return result;
        }

        protected string IndexConTtext()
        {
            string result = "";

            string index = txtH_index.Value.ToString();
            index = (int.Parse(index) + 1).ToString();
            result = "txt_" + index + "_text_";

            return result;
        }
        
        protected string IndexConTvalue()
        {
            string result = "";

            string index = txtH_index.Value.ToString();
            index = (int.Parse(index) + 1).ToString();
            result = "txt_" + index + "_value_";

            return result;
        }

        protected string AddList(string add)
        {
            string result = "";

            FormHTML();

            string List_old = "";
            string List_new = "";

            string nameText = IndexConTtext();
            string nameValue = IndexConTvalue();

            string j = "0";
            string ArList = txtH_DropDownRadio_list.Value.ToString();
            if (ArList != "")
            {
                if (add == "del") { txtH_DropDownRadio_list.Value = ""; }
                string[] ArListSplit = ArList.Split(',');
                for (int i = 0; i < ArListSplit.Length; i++)
                {
                    string idText = nameText + ArListSplit[i].ToString();
                    string idValue = nameValue + ArListSplit[i].ToString();
                    string text = String.Format("{0}", Request.Form[idText]);
                    string value = String.Format("{0}", Request.Form[idValue]);
                    j = (i + 1).ToString();
                    string OnEvent = "onkeypress=\"blockKeyCode(event)\"";
                    List_old = List_old +
                             "\n<div id=\"divList_" + j + "\" class=\"row col-12 mx-auto\">" +
                             "\n   <div class=\"col-lg-5 col-sm-12 mx-auto\">" +
                             "\n       <div class=\"row col-12 mx-auto\"> " +
                             "\n            <div class=\"col-lg-4 col-sm-2 mx-auto my-auto text-right\">" +
                             "\n                ชื่อรายการ : " +
                             "\n            </div> " +
                             "\n            <div class=\"col-lg-8 col-sm-10 mx-auto my-auto\">" +
                             "\n                <input type=\"text\" id=\"" + nameText + "" + j + "\" name=\"" + nameText + "" + j + "\" value=\"" + text + "\" " + OnEvent + " runat=\"server\" />" +
                             "\n            </div>" +
                             "\n       </div>" +
                             "\n   </div>" +
                             "\n   <div class=\"col-lg-5 col-sm-12 mx-auto\">" +
                             "\n       <div class=\"row col-12 mx-auto\"> " +
                             "\n            <div class=\"col-lg-4 col-sm-2 mx-auto my-auto text-right\">" +
                             "\n                ค่าที่บันทึก : " +
                             "\n            </div> " +
                             "\n            <div class=\"col-lg-8 col-sm-10 mx-auto my-auto\">" +
                             "\n                <input type=\"text\" id=\"" + nameValue + "" + j + "\" name=\"" + nameValue + "" + j + "\" value=\"" + value + "\" " + OnEvent + " runat=\"server\" />" +
                             "\n            </div>" +
                             "\n       </div>" +
                             "\n   </div>" +
                             "\n   <div class=\"col-lg-2 col-sm-12 mx-auto text-right\">" +
                             "\n       <a class=\"btn btn-light\" onclick=\"delList('" + j + "')\"><i class=\"ti-trash\"></i></a>" +
                             "\n   </div>" +
                             "\n</div>"+
                             "\n<div class=\"col-12 mx-auto\"><hr class=\"col-10\"></div>";
                    if (add == "del")
                    {
                        if (txtH_DropDownRadio_list.Value != "") { txtH_DropDownRadio_list.Value = txtH_DropDownRadio_list.Value + ","; }
                        txtH_DropDownRadio_list.Value = txtH_DropDownRadio_list.Value + j;
                    }
                }
            }

            j = (int.Parse(j) + 1).ToString();
            List_new = "\n<div id=\"divList_" + j + "\" class=\"row col-12 mx-auto\">" +
                        "\n   <div class=\"col-lg-5 col-sm-12 mx-auto\">" +
                        "\n       <div class=\"row col-12 mx-auto\"> " +
                        "\n             <div class=\"col-lg-4 col-sm-2 mx-auto my-auto text-right\">" +
                        "\n                 ชื่อรายการ : " +
                        "\n             </div> " +
                        "\n             <div class=\"col-lg-8 col-sm-10 mx-auto my-auto\">" +
                        "\n                 <input type=\"text\" id=\"" + nameText + "\" name=\"" + nameText + "\" value=\"Name\" runat=\"server\" />" +
                        "\n             </div>" +
                        "\n       </div>" +
                        "\n   </div>" +
                        "\n   <div class=\"col-lg-5 col-sm-12 mx-auto\">" +
                        "\n       <div class=\"row col-12 mx-auto\"> " +
                        "\n             <div class=\"col-lg-4 col-sm-2 mx-auto my-auto text-right\">" +
                        "\n                 ค่าที่บันทึก : " +
                        "\n             </div> " +
                        "\n             <div class=\"col-lg-8 col-sm-10 mx-auto my-auto\">" +
                        "\n                 <input type=\"text\" id=\"" + nameValue + "\" name=\"" + nameValue + "\" value=\"Value\" runat=\"server\" />" +
                        "\n             </div>" +
                        "\n       </div>" +
                        "\n   </div>" +
                        "\n   <div class=\"col-lg-2 col-sm-12 mx-auto text-right\">" +
                        "\n       <a class=\"btn btn-light\" onclick=\"delList('" + j + "')\"><i class=\"ti-trash\"></i></a>" +
                        "\n   </div>" +
                        "\n</div>";

            if (add == "yes")
            {
                string index = txtH_DropDownRadio_index.Value.ToString();
                index = (int.Parse(index) + 1).ToString();
                List_new = List_new.Replace(nameText, nameText + index);
                List_new = List_new.Replace(nameValue, nameValue + index);
                txtH_DropDownRadio_index.Value = index;

                List_old = List_old + List_new;

                if (ArList != "") { ArList = ArList + ","; }
                ArList = ArList + index;
                txtH_DropDownRadio_list.Value = ArList;
            }

            ShowBtnAddControler();

            result = List_old;

            return result;
        }

        protected void btn_addList_DropDownRadio_ServerClick(object sender, EventArgs e)
        {
            string conT = DD_Type.SelectedValue.ToString();
            lbl_List_DropDownRadio.Text = AddList("yes");
        }

        protected void btn_PreControler_ServerClick(object sender, EventArgs e)
        {
            string type = DD_Type.SelectedValue.ToString();
            lbl_List_DropDownRadio.Text = AddList("no");
            MakeControler(type, "");
        }

        protected void ShowBtnAddControler()
        {
            string index = txtH_DropDownRadio_index.Value;
            string list = txtH_DropDownRadio_list.Value;
            
            if (index != "0" && list != "")
            {
                div_AddControler.Visible = true;
            }
            else
            {
                div_AddControler.Visible = false;
            }
        }

        protected void btn_addControler_ServerClick(object sender, EventArgs e)
        {
            string type = DD_Type.SelectedValue.ToString();

            string HTML_new = MakeControler(type, "");
            string HTML_old = lbl_controler.Text;

            string index = txtH_index.Value.ToString();
            index = (int.Parse(index) + 1).ToString();
            HTML_new = HTML_new.Replace("conT_","conT_" + index);
            string ButtonDelete = "\n<div class=\"col-1 mx-auto text-right my-auto\" onclick=\"delControler('" + index + "')\" style=\"color:red;\"><i class=\"ti-trash btn btn-light\"></i></div>";
            HTML_new = HTML_new.Replace("\n<div hidden=\"hidden\"></div>", ButtonDelete);

            HTML_old = HTML_old + "<hr id=\"hr_" + index + "\" />" + HTML_new;

            lbl_controler.Text = HTML_old;

            txtH_index.Value = index;

            string ArForm = txtH_index_Form.Value.ToString().Trim();
            if (ArForm != "") { ArForm = ArForm + "|"; }

            string ArList = txtH_DropDownRadio_listTextValue.Value;
            //if (ArList == "") { ArList = "1"; }

            txtH_index_Form.Value = ArForm + index + "," + type + "," + ArList;
            // Format Value in Array "{ indexForm,Type,indexList }"
            //  indexList can split by ":"

            ClearTemp();
            ButtonSubmit();
        }

        protected void FormHTML()
        {
            string Form = lbl_controler.Text.ToString();
            string index_hide = txtH_index_hidden.Value.ToString();
            if (index_hide != "")
            {
                string[] ArIndex = index_hide.Split(',');
                for (int i = 0; i < ArIndex.Length; i++)
                {
                    string index = ArIndex[i].ToString();
                    Form = Form.Replace("conT_" + index + "\"", "conT_" + index + "\" hidden=\"hidden\" ");
                    Form = Form.Replace("hr_" + index + "\"", "hr_" + index + "\" hidden=\"hidden\" ");
                }
            }
            lbl_controler.Text = Form;
        }

        protected void ClearTemp()
        {
            txtH_DropDownRadio_index.Value = "0";
            txtH_DropDownRadio_list.Value = "";
            txtH_DropDownRadio_listTextValue.Value = "";
            lbl_sample.Text = "";
            lbl_List_DropDownRadio.Text = "";
            DD_Type.SelectedValue = "";

            div_for_text.Visible = false;
            div_for_DropDownRadio.Visible = false;

            div_editControler.Visible = false;
        }

        protected void btn_UpdateBeforDel_Click(object sender, EventArgs e)
        {
            string indexDel = txtH_DropDownRadio_hidden.Value.ToString().Trim();
            string indexForm = txtH_DropDownRadio_list.Value.ToString().Trim();
            indexForm = "^," + indexForm + ",^";
            string TextOld = "," + indexDel + ",";
            string TextNew = ",";
            indexForm = indexForm.Replace(TextOld, TextNew);
            indexForm = indexForm.Replace("^,", "");
            indexForm = indexForm.Replace(",^", "");
            txtH_DropDownRadio_list.Value = indexForm;

            lbl_List_DropDownRadio.Text = AddList("del");
        }

        protected void ButtonSubmit()
        {
            if (txtH_index_Form.Value.ToString().Trim() == "")
            {
                div_submit.Visible = false;
            }
            else
            {
                div_submit.Visible = true;
            }
        }

        protected void btn_Submit_ServerClick(object sender, EventArgs e)
        {
            string alert = "";
            string FormName = txt_FormName.Value.ToString().Trim();
            if (FormName == "")
            {
                alert = "กรุณาตั้งชื่อแบบฟอร์ม !!";
            }
            else
            {
                sql = "select * from bookingform where bf_active='yes' and bf_formname='" + FormName + "' ";
                dt = new DataTable();
                dt = cl_Sql.select(sql);
                if (dt.Rows.Count > 0)
                {
                    alert = "ชื่อแบบฟอร์มนี้มีอยู่แล้ว !!";
                }
                else
                {
                    if (Session["userid"] != null)
                    {
                        string result = Insert(Session["userid"].ToString(), FormName);
                        if (result == "success")
                        {
                            alert = "success";
                            lbl_alert.ForeColor = System.Drawing.Color.Blue;
                            ListForm();
                        }
                        else
                        {
                            alert = "ไม่สามารถบันทึกได้ กรุณาแจ้งผู้ดูแลระบบ (Booking Form : " + result + ") !!";
                            lbl_alert.ForeColor = System.Drawing.Color.Red;
                        }
                    }
                }
            }
            if (alert == "success")
            {
                Response.Write("<script>alertModal('#Modal_Success');</script>");
            }
            else
            {
                lbl_alert.Text = alert;
            }
        }

        private string Insert(string LoginID, string FormName)
        {
            string result = "";

            string FormID = "";

            LoginID = Session["userid"].ToString();
            sql = "INSERT INTO bookingform(bf_editby, bf_formname) VALUES('" + LoginID + "', '" + FormName + "') ";
            if (cl_Sql.Modify(sql))
            {
                FormID = cl_Sql.LastID("bf_id", "bookingform");

                // txtH_index_Form ใช้เก็บ Array ของแบบฟอร์มที่ Preview
                // Split โดย | เพื่อแยก Controler
                string[] ArForm = txtH_index_Form.Value.ToString().Trim().Split('|');
                //txtH_index_hidden ใช้เก็บ Array ของ Controler ที่ถูก delete
                string[] ArFormCacel = txtH_index_hidden.Value.ToString().Trim().Split(',');
                for (int i = 0; i < ArForm.Length; i++)
                {
                    // Split โดย , จะได้ค่า [0]=index [1]=type [2]=New Array
                    string[] ArControler = ArForm[i].ToString().Split(',');
                    string index = ArControler[0].ToString();
                    if (Array.IndexOf(ArFormCacel, index) < 0)
                    {
                        string type = ArControler[1].ToString();
                        // Split โดย } จะได้ค่า [0]=Title [1]=New Array
                        string[] ArValue = ArControler[2].ToString().Split('}');
                        string title = ArValue[0].ToString();

                        string placeholderField = "";
                        string placeholderValue = "";
                        if (type == "text")
                        {
                            placeholderField = "bfi_placeholder, ";
                            placeholderValue = "'" + ArValue[1].ToString().Split(':')[1].ToString() + "', ";
                        }


                        sql = "INSERT INTO bookingforminput " +
                            "\n(bfi_bfid, bfi_type, bfi_title, bfi_index, " + placeholderField + " bfi_required) " +
                            "\nVALUES('" + FormID + "', '" + type + "', '" + title + "', '" + index + "'," + placeholderValue + "'yes');";
                        if (cl_Sql.Modify(sql))
                        {
                            string inputID = cl_Sql.LastID("bfi_id", "bookingforminput");

                            if (type != "text")
                            {
                                sql = ""; // Clear SQL

                                string[] ArAtb = ArValue[1].ToString().Split(';');
                                for (int j = 0; j < ArAtb.Length; j++)
                                {
                                    string[] Atb = ArAtb[j].ToString().Split(':');
                                    string name = Atb[0].ToString();
                                    string value = Atb[1].ToString();
                                    string indexList = (j + 1).ToString();

                                    sql = sql + "INSERT INTO bookingforminputlist " +
                                                "\n(bfil_bfiid, bfil_index, bfil_text, bfil_value) " +
                                                "\nVALUES('" + inputID + "', '" + indexList + "', '" + name + "', '" + value + "');\n";
                                }

                                if (sql != "")
                                {
                                    if (cl_Sql.Modify(sql))
                                    {
                                        result = "success";
                                    }
                                    else
                                    {
                                        sql = "update bookingform set bf_active='no' where bf_id='" + FormID + "'; ";
                                        sql = sql + "update bookingforminput set bfi_required='no' where bfi_id='" + inputID + "'; ";
                                        cl_Sql.Modify(sql);

                                        result = "List error";
                                    }
                                }
                            }
                            else
                            {
                                result = "success";
                            }
                        }
                        else
                        {
                            sql = "update bookingform set bf_active='no' where bf_id='" + FormID + "' ";
                            cl_Sql.Modify(sql);

                            result = "Input error";
                        }
                    }
                }
            }
            else
            {
                result = "Form error";
            }

            return result;
        }
    }
}