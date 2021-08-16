using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;

namespace BRH_Plubic.Marketing
{
    public partial class ManageProduct : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass CL_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Login"] == null)
            {
                Response.Redirect("../Default.aspx?back=Marketing/ManageProduct&login=require");
            }
            else
            {
                string status = Session["status"].ToString();
                if (status == "admin" || status == "marketing")
                {
                    if (!IsPostBack)
                    {
                        BindData();
                    }
                }
                else
                {
                    string scModal = "fn_AlertModal('Info','คุณไม่มีสิทธิ์ใช้งานหน้านี้ !!','Default.aspx',2000);";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
                }
            }
        }

        private void BindData()
        {
            sql = "select *,DATE_FORMAT(mc_startdate,\"%d %b %Y\") as 'StartDate',DATE_FORMAT(mc_enddate,\"%d %b %Y\") as 'EndDate' " +
                "from marketingcategory order by mc_active desc, mc_id desc ";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                lv_category.DataSource = dt;
                lv_category.DataBind();
            }
        }

        public string UploadImgCategory(string id)
        {
            string result = "";

            string Path = "../Marketing/image/main/";
            string path = "image/main/";
            string Name = "Home-Category";

            if (UploadImg_category.HasFile)
            {
                string FileName = "";
                foreach (HttpPostedFile uploadFile in UploadImg_category.PostedFiles)
                {
                    FileName = uploadFile.FileName;
                    string[] exts = FileName.ToString().Split('.');
                    string file_lname = exts[1].ToString().ToLower();
                    if (file_lname == "jpg")
                    {
                        FileName = "id" + id + "_" + Name + "." + exts[1].ToString();
                        string MapPath = path + FileName;
                        if (System.IO.File.Exists(Server.MapPath(MapPath)))
                        {
                            System.IO.File.Delete(Server.MapPath(MapPath));
                        }

                        uploadFile.SaveAs(System.IO.Path.Combine(Server.MapPath(Path), FileName));
                        result = "success";
                    }
                    else
                    {
                        result = "Not JPG file.";
                    }
                }
            }
            return result;
        }

        protected void btn_addcate_ServerClick(object sender, EventArgs e)
        {
            string scModal = "";

            string id = "";

            string cateName = txt_cateName.Value.ToString().Trim();
            string startDate = DateTime.Parse(txt_dateStart.Value.ToString()).ToString("yyyy-MM-dd");
            string endDate = DateTime.Parse(txt_dateEnd.Value.ToString()).ToString("yyyy-MM-dd");

            if (cateName == "")
            {
                scModal = "fn_AlertModal('Info','Please fill Category Name !!','',0);";
            }
            else
            {
                if (startDate == "")
                {
                    scModal = "fn_AlertModal('Info','Please fill Start Date !!','',0);";
                }
                else
                {
                    sql = "insert into marketingcategory(mc_name,mc_startdate,mc_enddate,mc_active) values('" + cateName + "','" + startDate + "','" + endDate + "','no'); ";
                    if (CL_Sql.Modify(sql))
                    {
                        sql = "select max(mc_id) as 'mc_id' from marketingcategory where mc_name='" + cateName + "'; ";
                        dt = new DataTable();
                        dt = CL_Sql.select(sql);
                        if (dt.Rows.Count > 0)
                        {
                            id = dt.Rows[0]["mc_id"].ToString();
                            string resultUpload = UploadImgCategory(id);
                            if (resultUpload == "success")
                            {
                                scModal = "fn_AlertModal('Success','บันทึกข้อมูล Category เรียบร้อยแล้ว','SettingProduct?cate=" + id + "',2000);";
                            }
                            else
                            {
                                scModal = "fn_AlertModal('Info','" + resultUpload + "','SettingProduct?cate=" + id + "',2000);";
                            }
                        }
                        else
                        {
                            scModal = "fn_AlertModal('Info','บันทึกข้อมูลแล้ว แต่ค้นหา Category ไม่พบ กรุณาติดต่อผู้ดูแลระบบ !!','',0);";
                        }
                    }
                    else
                    {
                        scModal = "fn_AlertModal('Warning','ไม่สามารถบันทึกได้ กรุณาติดต่อผู้ดูแลระบบ !!','',0);";
                    }
                }
            }

            Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
        }
    }
}