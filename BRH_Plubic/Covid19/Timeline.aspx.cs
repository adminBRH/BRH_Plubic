using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;

namespace BRH_Plubic.Covid19
{
    public partial class Timeline : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            string scModal = "";

            if (!IsPostBack)
            {
                circle1.Attributes.Remove("class");
                circle1.Attributes.Add("class", circle("process"));

                circle2.Attributes.Remove("class");
                circle2.Attributes.Add("class", circle("waiting"));

                circle3.Attributes.Remove("class");
                circle3.Attributes.Add("class", circle("waiting"));

                if (Request.QueryString["id"] != null)
                {
                    string ctid = Request.QueryString["id"].ToString();
                    if (Session["status"] != null)
                    {
                        string status = Session["status"].ToString();
                        if (status == "admin" || status == "novelcovid")
                        {
                            div_1.Visible = true;
                            div_2.Visible = true;
                            circle2.Attributes.Remove("class");
                            circle2.Attributes.Add("class", circle("process"));

                            btn_submit_1.Visible = false;

                            ListViewDate(ctid);
                        }
                        else
                        {
                            scModal = "fn_AlertModal('Warning','คุณไม่มีสิทธิ์ใช้งานในหน้านี้ !!','Covid19/Timeline',1500);";
                        }
                    }
                    else
                    {
                        Response.Redirect("../Default.aspx?back=Covid19/Timeline?id=" + ctid + "&login=require");
                    }
                }
            }
            Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
        }

        public string circle(string status)
        {
            string result = "";

            string succecc = "circle-icon mr-4 mx-auto bg-gradient-blue";
            string process = "circle-icon mr-4 mx-auto bg-gradient";
            string waiting = "circle-icon mr-4 mx-auto bg-secondary";

            if (status == "success")
            {
                result = succecc;
            }
            else if (status == "process")
            {
                result = process;
            }
            else
            {
                result = waiting;
            }

            return result;
        }

        private Boolean TimelineDate(string ctid, DateTime curDate)
        {
            Boolean bl = false;

            DateTime startDate = curDate.AddDays(-13);

            sql = "insert into covid_timelinedate(ctd_ctid,ctd_date,ctd_index) values ";
            int i = 1;
            while (startDate.Date <= curDate.Date)
            {
                sql = sql + "\n('" + ctid + "','" + startDate.ToString("yyyy-MM-dd") + "','" + i.ToString() + "')";
                if (startDate.Date == curDate.Date)
                {
                    sql = sql + ";";
                }
                else
                {
                    sql = sql + ", ";
                }
                startDate = startDate.AddDays(1);
                i++;
            }
            if (cl_Sql.Modify(sql))
            {
                bl = true;
            }

            return bl;
        }

        private string Step1(string id)
        {
            string result = "";

            string fname = txt_fname.Value.ToString().Trim();
            string lname = txt_lname.Value.ToString().Trim();
            string phone = txt_phone.Value.ToString().Trim();
            if (fname == "")
            {
                result = "กรุณากรอกชื่อ";
            }
            else
            {
                if (lname == "")
                {
                    result = "กรุณากรอกนามสกุล";
                }
                else
                {
                    if (phone == "")
                    {
                        result = "กรุณากรอกเบอร์โทรศัพท์";
                    }
                    else
                    {
                        string sick = "";
                        if (rd_sick_yes.Checked)
                        {
                            sick = rd_sick_yes.Value.ToString();
                        }
                        else
                        {
                            sick = rd_sick_no.Value.ToString();
                        }
                        string sickDate = date_sick.Value.ToString();
                        if (sickDate == "")
                        {
                            sickDate = "null";
                        }
                        else
                        {
                            sickDate = "'" + DateTime.Parse(sickDate).ToString("yyyy-MM-dd") + "'";
                        }
                        string pcrDate = date_RT.Value.ToString();
                        if (pcrDate == "")
                        {
                            pcrDate = "null";
                        }
                        else
                        {
                            pcrDate = "'" + DateTime.Parse(pcrDate).ToString("yyyy-MM-dd") + "'";
                        }

                        string curDate = "";
                        if (sickDate == "null")
                        {
                            curDate = pcrDate;
                        }
                        else
                        {
                            curDate = sickDate;
                        }

                        if (curDate == "null")
                        {
                            if (rd_sick_yes.Checked)
                            {
                                result = "กรุณากรอกวันที่เริ่มมีอาการ";
                            }
                            else
                            {
                                result = "กรุณากรอกวันที่เก็บสิ่งส่งตรวจ";
                            }
                        }
                        else
                        {
                            if (id != "")
                            {
                                string userid = Session["userid"].ToString();

                                sql = "update covid_timeline set " +
                                    "ct_fname='" + fname + "'," +
                                    "ct_lname='"+ lname + "'," +
                                    "ct_phone='"+ phone + "'," +
                                    "ct_symptom='"+ sick + "'," +
                                    "ct_symptomdate="+ sickDate + "," +
                                    "ct_pcrdate="+ pcrDate + ", " +
                                    "ct_editby='" + userid + "', ct_editdate=current_timestamp() " +
                                    "\nwhere ct_id='" + id + "'; ";
                                if (cl_Sql.Modify(sql))
                                {
                                    result = "success";
                                }
                                else
                                {
                                    result = "ไม่สามารถอัพเดทข้อมูลได้ กรุณาติดต่อผู้ดูแลระบบ !!";
                                }
                            }
                            else
                            {
                                string key = cl_Sql.GenerateKey(11);

                                sql = "insert into covid_timeline(ct_fname,ct_lname,ct_phone,ct_symptom,ct_symptomdate,ct_pcrdate,ct_key) " +
                                    "\nvalue('" + fname + "','" + lname + "','" + phone + "','" + sick + "'," + sickDate + "," + pcrDate + ",'" + key + "'); ";
                                if (cl_Sql.Modify(sql))
                                {
                                    sql = "select * from covid_timeline where ct_key = '" + key + "' ";
                                    dt = new DataTable();
                                    dt = cl_Sql.select(sql);
                                    if (dt.Rows.Count > 0)
                                    {
                                        string ctid = dt.Rows[0]["ct_id"].ToString();
                                        if (TimelineDate(ctid, DateTime.Parse(curDate.Replace("'", ""))))
                                        {
                                            txtH_id.Value = ctid;
                                            ListViewDate(ctid);
                                            result = "success";
                                        }
                                        else
                                        {
                                            result = "ไม่สามารถสร้างตาราง Timeline ได้ กรุณากรอกใหม่อีกครั้ง";
                                        }
                                    }
                                    else
                                    {
                                        result = "ไม่สามารถสืบค้นข้อมูลได้ กรุณากรอกใหม่อีกครั้ง";
                                    }
                                }
                                else
                                {
                                    result = "ไม่สามารถบันทึกข้อมูลได้กรุณาติดต่อเจ้าหน้าที่";
                                }
                            }
                        }
                    }
                }
            }

            return result;
        }

        protected void btn_submit_1_ServerClick(object sender, EventArgs e)
        {
            string scModal = "";

            string step1 = Step1("");
            if (step1 == "success")
            {
                circle1.Attributes.Remove("class");
                circle1.Attributes.Add("class", circle("success"));
                div_1.Visible = false;

                circle2.Attributes.Remove("class");
                circle2.Attributes.Add("class", circle("process"));
                div_2.Visible = true;

                scModal = "fn_AlertModal('Success','Step 1 Success !!','',0);";
            }
            else
            {
                scModal = "fn_AlertModal('Warning','" + step1 + " !!','',0);";
            }
            Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
        }

        protected void ListViewDate(string ctid)
        {
            if (Request.QueryString["id"] != null)
            {
                sql = "select * from covid_timeline where ct_id = '" + ctid + "'; ";
                dt = new DataTable();
                dt = cl_Sql.select(sql);
                if (dt.Rows.Count > 0)
                {
                    if (dt.Rows[0]["ct_editdate"].ToString() != "")
                    {
                        Response.Redirect("TimelineReport?id=" + ctid);
                    }
                    else
                    {
                        txt_fname.Value = dt.Rows[0]["ct_fname"].ToString();
                        txt_lname.Value = dt.Rows[0]["ct_lname"].ToString();
                        txt_phone.Value = dt.Rows[0]["ct_phone"].ToString();
                        string symptom = dt.Rows[0]["ct_symptom"].ToString();
                        if (symptom == "yes")
                        {
                            rd_sick_yes.Checked = true;
                            rd_sick_no.Checked = false;
                            date_sick.Value = DateTime.Parse(dt.Rows[0]["ct_symptomdate"].ToString()).ToString("yyyy-MM-dd");
                        }
                        else
                        {
                            rd_sick_yes.Checked = false;
                            rd_sick_no.Checked = true;
                        }
                        date_RT.Value = DateTime.Parse(dt.Rows[0]["ct_pcrdate"].ToString()).ToString("yyyy-MM-dd");
                    }
                }
            }

            //sql = "select *, ROW_NUMBER() OVER (ORDER BY ctd_date) AS row_num " +
            //    "\nfrom covid_timelinedate where ctd_ctid='" + ctid + "'; ";
            sql = "select *, concat(day(ctd_date),'/',month(ctd_date),'/',year(ctd_date)) as ctd_dateTH, '' as ctd_txt " +
                "\nfrom covid_timelinedate " +
                "\nwhere ctd_ctid='" + ctid + "'; ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                foreach (DataRow dr in dt.Rows)
                {
                    dr["ctd_txt"] = "<input id=\"txt_detail_" + dr["ctd_index"] + "\" value=\"" + dr["ctd_details"] + "\" hidden=\"hidden\" />";
                }
            }
            LV_timeline.DataSource = dt;
            LV_timeline.DataBind();
        }

        protected void btn_submit_2_ServerClick(object sender, EventArgs e)
        {
            string scModal = "";

            string txtALL = txtH_ALL.Value.ToString().Trim();
            if (txtALL == "")
            {
                scModal = "fn_AlertModal('Info','กรุณากรอกรายละเอียดให้ครบทุกวัน !!','',0);";
            }
            else
            {
                string ctid = "";
                if (Request.QueryString["id"] != null)
                {
                    ctid = Request.QueryString["id"].ToString();
                }
                else
                {
                    ctid = txtH_id.Value.ToString().Trim();
                }

                string[] Detail = txtALL.Split('!');
                sql = "";
                int j = 1;
                for (int i=0; i<14; i++)
                {
                    sql = sql + "update covid_timelinedate set ctd_details='" + Detail[i] + "' " +
                        "where ctd_ctid='" + ctid + "' and ctd_index='" + j.ToString() + "';\n";
                    j++;
                }
                if (cl_Sql.Modify(sql))
                {
                    if (Request.QueryString["id"] != null)
                    {
                        string step1 = Step1(ctid);
                        if (step1 == "success")
                        {
                            Response.Redirect("TimelineReport?id=" + ctid);
                            scModal = "fn_AlertModal('Success','อัพเดทข้อมูลเรียบร้อยแล้ว !!','..Covid19/TimelineReport?id=" + ctid + "',1500);";
                        }
                        else
                        {
                            scModal = "fn_AlertModal('Warning','" + step1 + "','',0);";
                        }
                    }
                    else
                    {
                        scModal = "fn_AlertModal('Success','Step 2 Success !!','',0);";
                        circle2.Attributes.Remove("class");
                        circle2.Attributes.Add("class", circle("success"));
                        div_2.Visible = false;

                        circle3.Attributes.Remove("class");
                        circle3.Attributes.Add("class", circle("process"));
                        div_3.Visible = true;
                    }
                }
                else
                {
                    scModal = "fn_AlertModal('Warning','ไม่สามารถบันทึกกิจกรรมและการเดินทางได้กรุณาติดต่อเจ้าหน้าที่ !!','',0);";
                }
            }
            Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
        }
    }
}