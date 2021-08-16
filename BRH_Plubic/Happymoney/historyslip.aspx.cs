using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;
using System.IO;

namespace BRH_Plubic.Happymoney
{
    public partial class historyslip : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Login"] == null)
            {
                Response.Write("<script>alert('กรุณา Login ก่อนเข้าใช้งาน');window.location.href='../Default.aspx';</script>");
                //Response.Write("<script>alert('กรุณา Login ก่อนเข้าใช้งาน !!'); window.location.href='../Default.aspx';</script>");
            }
            else
            {
                data_list();
            }
        }
        protected void data_list()
        {

            string empid = "";
            if (Session["userid"] != null)
            {
                empid = Session["userid"].ToString();
            }
            sql = "select ms.*,emp.emp_pname_th, emp.emp_pnamefull_th " +
                "from mon_savemoney as ms " +
                "left join employee as emp on ms.mo_empid = emp.emp_id collate utf8_general_ci where ms.mo_empid = '"+ empid +"';";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if(dt.Rows.Count > 0)
            {
                list_money.DataSource = dt;
                list_money.DataBind();
            }
        }
        public string imageslip(string id)
        {
            string path = "~/Happymoney/image/slip/";

            string imageslip = "";
            DirectoryInfo myDirinfo;
            myDirinfo = new DirectoryInfo(HttpContext.Current.Server.MapPath(path));
            FileInfo[] arrFileInfo = myDirinfo.GetFiles("id" + id + ",*");
            if (arrFileInfo.Length > 0)
            {
                foreach(FileInfo myFileInto in arrFileInfo)
                {
                    imageslip = path + myFileInto.Name.ToString();
                }
            }


            return imageslip;
        }

        protected void btn_imgslip_Click(object sender, EventArgs e)
        {
            string id = txtH_id.Value.ToString();
            string img = imageslip(id);
            img_id.Src = img;
            img_id.Attributes.Remove("hidden");
        }
    }
}