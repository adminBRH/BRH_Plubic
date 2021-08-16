using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;

using System.Security.Cryptography;
using System.Text;

namespace BRH_Plubic
{
    public partial class Test : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass CL_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void btn_salt_ServerClick(object sender, EventArgs e)
        {
            txt_salt.Value = Salt();
        }

        protected void btn_pass_ServerClick(object sender, EventArgs e)
        {
            txt_pass.Value = Password();
        }

        protected void btn_hash_ServerClick(object sender, EventArgs e)
        {
            string password = txt_pass.Value.ToString().Trim();
            string salt = txt_salt.Value.ToString().Trim();

            txt_hash.Value = Hash(password, salt);
        }

        private string Salt()
        {
            string salt = "";

            RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider();
            byte[] saltByte = new byte[36];
            rng.GetBytes(saltByte);
            salt = Convert.ToBase64String(saltByte);

            return salt;
        }

        private string Password()
        {
            string pass = "";

            pass = CL_Sql.GenerateKey(8);

            return pass;
        }

        private string Hash(string password, string salt)
        {
            string hash = "";

            byte[] passwordAndSaltBytes = System.Text.Encoding.UTF8.GetBytes(password + salt);
            byte[] hashBytes = new System.Security.Cryptography.SHA256Managed().ComputeHash(passwordAndSaltBytes);
            hash = Convert.ToBase64String(hashBytes);

            return hash;
        }

        protected void btn_check_ServerClick(object sender, EventArgs e)
        {
            string password = txt_pass.Value.ToString().Trim();
            string salt = txt_salt.Value.ToString().Trim();
            string hash = txt_hash.Value.ToString().Trim();
            string check = Hash(password, salt);
            string alert = "";
            if (hash == check)
            {
                alert = "Success";
            }
            else
            {
                alert = "Fail";
            }
            lbl_test.Text = alert;
        }

    }
}