using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;

namespace BRH_Plubic.Evaluate
{
    public partial class Default : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        DataTable dtQs;
        SQLclass cl_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["asm"] == null)
                {
                    Response.Redirect("../Default");
                }
                else
                {
                    string asm = Request.QueryString["asm"].ToString();
                    dtQs = new DataTable();
                    dtQs = dtQuestion(asm);
                    if (dtQs.Rows.Count > 0)
                    {
                        Question(dtQs);
                    }
                }
            }
        }

        private DataTable dtQuestion(string mID)
        {
            sql = "select * from assessment as asm " +
                "\nleft join assessment_header as ash on ash.ash_asmid = asm.asm_id " +
                "\nleft join assessment_details as asd on asd.asd_ashid = ash.ash_id " +
                "\nwhere ash.ash_asmid = '1' " +
                "\nand asm_active = 'yes' and ash_active = 'yes' and asd_active = 'yes' " +
                "\norder by ash.ash_index, asd.asd_index ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                int lastRow = dt.Rows.Count - 1;
                txtH_maxIndex.Value = dt.Rows[lastRow]["ash_index"].ToString();
            }
            return dt;
        }

        protected void Question(DataTable dtQ)
        {
            string script = "";
            string alert = "";

            string subject = "";
            string head = "";
            string next = "yes";
            string required = txtH_required.Value.ToString();
            if (required == "yes")
            {
                string RDvalue = txtH_rd_value.Value.ToString().Trim();
                if (RDvalue == "")
                {
                    next = "no";
                    alert = "กรุณาเลือกคำตอบของท่าน !!";
                    script = "<script> fn_modal(); </script>";
                }
            }
            lbl_modal_alert.Text = alert;
            lbl_script.Text = script;

            if (next == "yes")
            {
                int qs = int.Parse(txtH_question.Value.ToString().Trim());
                int maxIndex = int.Parse(txtH_maxIndex.Value.ToString().Trim());

                dt = new DataTable();
                dt = dtQ;
                dt = dt.Select("asd_ashid = '" + qs.ToString() + "'").CopyToDataTable();
                if (dt.Rows.Count > 0)
                {
                    subject = dt.Rows[0]["asm_subject"].ToString();
                    head = dt.Rows[0]["ash_title"].ToString();

                    txtH_required.Value = dt.Rows[0]["ash_need"].ToString();

                    qs++;
                }

                if (qs > 2)
                {
                    btn_previous.Visible = true;
                }
                else
                {
                    btn_previous.Visible = false;
                }

                if (qs < maxIndex)
                {
                    btn_next.Visible = true;
                    btn_submit.Visible = false;
                }
                else
                {
                    btn_next.Visible = false;
                    btn_submit.Visible = true;
                }

                lbl_subject.Text = subject;
                lbl_head.Text = head;

                lv_question.DataSource = dt;
                lv_question.DataBind();

                txtH_question.Value = qs.ToString();
                txtH_rd_value.Value = "";
                txt_oldid.Value = "";
            }
        }

        protected void btn_previous_ServerClick(object sender, EventArgs e)
        {
            int qs = int.Parse(txtH_question.Value.ToString().Trim());
            txtH_question.Value = (qs - 2).ToString();

            string asm = Request.QueryString["asm"].ToString();
            dtQs = new DataTable();
            dtQs = dtQuestion(asm);
            if (dtQs.Rows.Count > 0)
            {
                txtH_rd_value.Value = "-";
                Question(dtQs);
            }
        }

        protected void btn_next_ServerClick(object sender, EventArgs e)
        {
            string asm = Request.QueryString["asm"].ToString();
            dtQs = new DataTable();
            dtQs = dtQuestion(asm);
            if (dtQs.Rows.Count > 0)
            {
                Question(dtQs);
            }
        }

        protected void btn_submit_ServerClick(object sender, EventArgs e)
        {

        }
    }
}