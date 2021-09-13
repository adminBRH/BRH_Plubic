using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.IO;
using System.Drawing;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;
using System.Drawing.Text;
using System.Net.Sockets;

using ZXing.Common;
using ZXing;
using ZXing.QrCode;

namespace BRH_Plubic.ArcusAir
{
    public partial class GenerateBarcode : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {

            }
        }

        protected Boolean GenBarcode(string user, string pass)
        {
            Boolean bl = false;

            img_barcode.Src = "...";
            lbl_barcode.Text = "";

            string path = "images/barcode/";
            DateTime DateNow = DateTime.Now;
            string SaveDate = DateNow.ToString("yyyyMMdd");
            string key = cl_Sql.GenerateKey(20);
            string filename = SaveDate + "_" + key + ".jpg";

            string[] ArFile = Directory.GetFiles(Server.MapPath(path), "*.jpg").Where(x => !x.Contains(SaveDate + "_")).ToArray();
            if (ArFile.Length > 0)
            {
                foreach (string f in ArFile)
                {
                    File.Delete(f);
                }
            }

            ZXing.BarcodeWriter BC = new ZXing.BarcodeWriter() { 
                Format = BarcodeFormat.CODE_128,
                Options = new EncodingOptions
                {
                    Width = 400,
                    Height = 100,
                    PureBarcode = true,
                    Margin = 10,
                }
            };

            var bitmap = BC.Write(pass);
            bitmap.Save(System.IO.Path.Combine(Server.MapPath(path), filename));

            img_barcode.Src = path + filename;
            lbl_barcode.Text = user;

            if (File.Exists(Path.Combine(Server.MapPath(path), filename)))
            {
                bl = true;
            }

            return bl;
        }

        protected void btn_GenerateBarcode_ServerClick(object sender, EventArgs e)
        {
            div_btnGen.Visible = true;
            div_btnPrint.Visible = false;

            string user = txt_user.Value.ToString().Trim();
            string pass = txt_pass.Value.ToString().Trim();
            if (user != "" && pass != "")
            {
                if (GenBarcode(user, pass))
                {
                    div_btnGen.Visible = false;
                    div_btnPrint.Visible = true;
                }
            }
        }

        protected void btn_newGen_ServerClick(object sender, EventArgs e)
        {
            txt_user.Value = "";
            txt_pass.Value = "";
            img_barcode.Src = "...";
            lbl_barcode.Text = "";
            div_btnGen.Visible = true;
            div_btnPrint.Visible = false;
        }
    }
}