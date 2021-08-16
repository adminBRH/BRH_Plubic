using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;

namespace BRH_Plubic
{
    public partial class MsTeamAgreeDetail : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["MsTeamAgree"] != null)
            {
                if (Request.QueryString["id"] != null)
                {
                    string msid = Request.QueryString["id"].ToString();
                    Detail(msid);
                    Session.Remove("MsTeamAgree");
                }
            }
            else
            {
                Response.Redirect("MsTeamAgreeReport.aspx");
            }
        }

        public Boolean Detail(string id)
        {
            Boolean bl = false;

            sql = "select *,concat(ms_fnameth,' ',ms_lnameth) as 'fullnameTH' ,concat(ms_fname,' ',ms_lname) as 'fullnameEN' " +
                "from msteamagree where ms_id = '" + id + "' ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                lbl_msid.Text = dt.Rows[0]["ms_id"].ToString();
                lbl_date.Text = dt.Rows[0]["ms_adddatetime"].ToString();
                lbl_nameTH.Text = dt.Rows[0]["fullnameTH"].ToString();
                lbl_nameEN.Text = dt.Rows[0]["fullnameEN"].ToString();
                lbl_gender.Text = dt.Rows[0]["ms_gender"].ToString();
                string[] dob = dt.Rows[0]["ms_dob"].ToString().Split(' ');
                lbl_dob.Text = dob[0].ToString();
                lbl_cardtype.Text = dt.Rows[0]["ms_cardtype"].ToString();
                lbl_cardnum.Text = dt.Rows[0]["ms_cardnum"].ToString();
                lbl_phone.Text = dt.Rows[0]["ms_phone"].ToString();
                lbl_email.Text = dt.Rows[0]["ms_email"].ToString();
                lbl_idline.Text = dt.Rows[0]["ms_line"].ToString();
                lbl_reason.Text = dt.Rows[0]["ms_reason"].ToString();
            }
            else
            {
                Response.Write("<script>alert('ไม่มี ID นี้ในระบ !!');</script>");
            }

            return bl;
        }
    }
}