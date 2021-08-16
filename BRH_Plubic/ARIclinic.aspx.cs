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
    public partial class ARIclinic : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            string Result = Insert();

            if (Result == "Error")
            {
                Response.Write("<script>alert('ระบบขัดข้องไม่สามารถบันทึกข้อมูลได้ กรุณาติดต่อผู้ดูแลระบบ !!');</script>");
            }
            else if (Result == "BookARI")
            {
                Response.Redirect("ARIResult.aspx");
            }
            else
            {
                Response.Redirect("ARIguide.aspx");
            }
        }

        public string Insert()
        {
            string bl = "";

            string Sex = DD_sex.SelectedValue.ToString();

            string PName = txt_pname.Value.ToString().Trim();
            string FName = txt_fname.Value.ToString().Trim();
            string LName = txt_lname.Value.ToString().Trim();
            string[] DOB_Ar = date_dob.Value.ToString().Split(' ');
            string DOB = DOB_Ar[0];
            string Cardname = "Identity card";
            string CardNum = txt_cardnum.Value.ToString().Trim();
            string Phone = txt_phone.Value.ToString().Trim();

            string Fever = "No"; if (CB_Fever.Checked) { Fever = CB_Fever.Value.ToString(); }
            string Ch = "No"; if (CB_C.Checked) { Ch = CB_C.Value.ToString(); }
            string St = "No"; if (CB_ST.Checked) { St = CB_ST.Value.ToString(); }
            string Rn = "No"; if (CB_RN.Checked) { Rn = CB_RN.Value.ToString(); }
            string Sb = "No"; if (CB_SB.Checked) { Sb = CB_SB.Value.ToString(); }

            string province = "No"; if (CB_Province.Checked) { province = CB_Province.Value.ToString(); }
            string Suspect = "No"; if (CB_Suspect.Checked) { Suspect = CB_Suspect.Value.ToString(); }

            string NotAll = "No"; if (CB_NS.Checked) { NotAll = CB_NS.Value.ToString(); }

            int age = DateTime.Now.Year - DateTime.Parse(DOB).Year;
            if((DateTime.Parse(DOB).Month- DateTime.Now.Month) > 1)
            {
                age = age - 1;
            }

            string type = "";
            if (age < 15)
            {
                type = "Child";
            }
            else
            {
                type = "Adult";
            }

            sql = "INSERT INTO ari_book" +
                "(ab_adddate, ab_sex, ab_pname, ab_fname, ab_lname, ab_dob, ab_type, ab_cardname, ab_cardnum, ab_phone, ab_fever, ab_cough, ab_sore_throats, ab_runny_nose, ab_shortness_of_breath, ab_province, ab_suspect) " +
                "VALUES(" +
                "current_timestamp(), " +
                "'" + Sex + "', " +
                "'" + PName + "', " +
                "'" + FName + "', " +
                "'" + LName + "', " +
                "'" + DOB + "', " +
                "'" + type + "', " +
                "'" + Cardname + "', " +
                "'" + CardNum + "', " +
                "'" + Phone + "', " +
                "'" + Fever + "', " +
                "'" + Ch + "', " +
                "'" + St + "', " +
                "'" + Rn + "', " +
                "'" + Sb + "', " +
                "'" + province + "', " +
                "'" + Suspect + "') ";
            if (cl_Sql.Modify(sql))
            {
                if (NotAll == "Yes")
                {
                    bl = "Normal";
                }
                else
                {
                    Session["ARIKEy"] = CardNum;
                    Session["ARIType"] = type;
                    bl = "BookARI";
                }
            }
            else
            {
                bl = "Error";
            }

            return bl;
        }
    }
}