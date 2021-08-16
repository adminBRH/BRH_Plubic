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
    public partial class approveslip : System.Web.UI.Page
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
                data_users();
                data_summoney();
                data_list();
            }
        }
        protected void data_users()
        {
            string empid = "";
            if (Session["userid"] != null)
            {
                empid = Session["userid"].ToString();
            }
            sql = "select * from employee where emp_id = '" + empid + "'";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if(dt.Rows.Count > 0)
            {
                lal_name.Text = dt.Rows[0]["emp_pnamefull_th"].ToString();
                lal_depart.Text = dt.Rows[0]["emp_deptdesc"].ToString();
                lal_depid.Text = dt.Rows[0]["emp_deptid"].ToString();
            }
        }
        protected void data_summoney()
        {
            string empid = "";
            if (Session["userid"] != null)
            {
                empid = Session["userid"].ToString();
            }
            sql = "select sum(mo_money) as money from mon_savemoney  where mo_empid = '" + empid + "' and mo_money_active='Approve'";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                lbl_summoney.Text = dt.Rows[0]["money"].ToString();
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
                "left join employee as emp on ms.mo_empid = emp.emp_id collate utf8_general_ci where ms.mo_empid = '" + empid + "' and ms.mo_money_active='Waiting';";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
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
                foreach (FileInfo myFileInto in arrFileInfo)
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