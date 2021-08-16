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
    public partial class SettingProduct : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass CL_Sql = new SQLclass();

        ClassMarketing cl_mr = new ClassMarketing();

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
                    if (Request.QueryString["cate"] != null)
                    {
                        string cateID = Request.QueryString["cate"].ToString();
                        if (!IsPostBack)
                        {
                            ImgCategory(cateID);
                        }

                        if (Request.QueryString["show"] != null)
                        {
                            string show = Request.QueryString["show"].ToString();
                            if (show == "yes")
                            {
                                lbl_script.Text = "<script>ShowProductAuto();</script>";
                            }
                        }
                    }
                    else
                    {
                        Response.Redirect("ManageProduct.aspx");
                    }
                }
                else
                {
                    string scModal = "fn_AlertModal('Info','คุณไม่มีสิทธิ์ใช้งานหน้านี้ !!','Default.aspx',2000);";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
                }
            }
        }

        protected void ImgCategory(string id)
        {
            string version = cl_mr.versionNumber("marketingcategory", "mc_id", id, "mc_version");
            if (version != "")
            {
                lbl_version.Text = "<b>Image version :</b> " + version;
                version = "_v" + version;
            }
            string src = "image/main/id" + id + "_Home-Category" + ".jpg";
            img_category.Src = src;

            DetailCategory(id);
        }

        protected void DetailCategory(string id)
        {
            sql = "select * ,DATE_FORMAT(mc_startdate,\"%d %b %Y\") as 'StartDate',DATE_FORMAT(mc_enddate,\"%d %b %Y\") as 'EndDate' " +
                "from marketingcategory where mc_id = '" + id + "' ";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                txt_category_name.Value = dt.Rows[0]["mc_name"].ToString();
                date_start.Value = DateTime.Parse(dt.Rows[0]["mc_startdate"].ToString()).ToString("yyyy-MM-dd");
                date_end.Value = DateTime.Parse(dt.Rows[0]["mc_enddate"].ToString()).ToString("yyyy-MM-dd");

                if (dt.Rows[0]["mc_active"].ToString() == "yes")
                {
                    CB_category_active.Checked = true;
                }
                else
                {
                    CB_category_active.Checked = false;
                }

                DetailProduct(id);
            }
        }

        protected void btn_category_Click(object sender, EventArgs e)
        {
            string scModal = "";

            string id = Request.QueryString["cate"].ToString();
            string CateName = txt_category_name.Value.ToString().Trim();
            string startDate = date_start.Value.ToString();
            string endDate = date_end.Value.ToString();
            string active = "no";
            if (CB_category_active.Checked)
            {
                active = "yes";
            }

            sql = "update marketingcategory " +
                "set mc_name = '" + CateName + "', mc_active = '" + active + "', mc_startdate = '" + startDate + "', mc_enddate = '" + endDate + "' " +
                "where mc_id = '" + id + "' ";
            if (CL_Sql.Modify(sql))
            {
                string Next = "Yes";
                if (UploadImg_category.HasFile)
                {
                    Next = "No";

                    sql = "update marketingcategory set mc_version = (if(mc_version is null,0,mc_version) + 1) where mc_id = '" + id + "' ";
                    if (CL_Sql.Modify(sql))
                    {
                        string version = cl_mr.versionNumber("marketingcategory", "mc_id", id, "mc_version");
                        if (version != "")
                        {
                            version = "_v" + version;
                            lbl_version.Text = "";
                        }

                        string resultUpload = UploadImgCategory(id);
                        if (resultUpload == "success")
                        {
                            Next = "Yes";
                        }
                        else
                        {
                            scModal = "fn_AlertModal('Info','" + resultUpload + "','',0);";
                        }
                    }
                    else
                    {
                        scModal = "fn_AlertModal('Info','ไม่สามารถอัพเดท Version รูปภาพได้ กรุณาติดต่อผู้ดูแลระบบ !!','',0);";
                    }
                }

                if (Next == "Yes")
                {
                    scModal = "fn_AlertModal('Success','บันทึกข้อมูล Category เรียบร้อยแล้ว','ManageProduct.aspx',2000);";
                }
            }
            else
            {
                scModal = "fn_AlertModal('Warning','ไม่สามารถบันทึกข้อมูลได้ กรุณาติดต่อผู้ดูแลระบบ !!','',0);";
            }

            Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
        }

        protected void DetailProduct(string cateID)
        {
            sql = "select *,CONCAT('color:',if(mk_active='yes','green','red'),';') as 'mk_color' " +
                ", if(mk_version is null,'',CONCAT('_v',mk_version)) as mkVersion " +
                "from marketingproduct where mk_mcid = '" + cateID + "' order by mk_index ";
            dt = new DataTable();
            dt = CL_Sql.select(sql);
            if (dt.Rows.Count > 0)
            { }
            lv_product.DataSource = dt;
            lv_product.DataBind();
        }

        protected void btn_product_ServerClick(object sender, EventArgs e)
        {
            string scModal = "";
            string cateid = Request.QueryString["cate"].ToString();
            string id = txt_id.Value.ToString();
            string name = txt_name.Value.ToString().Trim();
            string price = txt_price.Value.ToString().Trim();
            string discount = txt_discount.Value.ToString().Trim();
            if (discount == "") { discount = "0"; }
            string active = "no";
            if (cb_active.Checked)
            {
                active = "yes";
            }
            string delivery = "no";
            if (cb_delivery.Checked)
            {
                delivery = "yes";
            }
            string condition = txt_condition.Value.ToString().Trim();

            sql = "update marketingproduct set mk_productname='" + name + "', mk_price=" + price + ", mk_discount=" + discount + ", " +
                "mk_active='" + active + "', mk_delivery='" + delivery + "', mk_condition='" + condition + "' " +
                "where mk_id = '" + id + "' ";
            if (CL_Sql.Modify(sql))
            {
                if (UploadImg_product.HasFile)
                {
                    sql = "update marketingproduct set mk_version=(if(mk_version is null,0,mk_version)+1) where mk_id='" + id + "' ";
                    if (CL_Sql.Modify(sql))
                    {
                        string version = cl_mr.versionNumber("marketingproduct", "mk_id", id, "mk_version");
                        if (version != "")
                        {
                            version = "_v" + version;
                            //lbl_version.Text = "";
                        }

                        string index = txt_index.Value.ToString();

                        string filename = "imageProduct" + index; // + version;
                        HttpPostedFile HPF = UploadImg_product.PostedFile;
                        string resultUpload = UploadImgProduct(cateid, filename, HPF);
                        if (resultUpload == "success")
                        {
                            scModal = "fn_AlertModal('Success','Success !!','SettingProduct.aspx?cate=" + cateid + "&show=yes#divProd_" + index + "',1000);";
                        }
                        else
                        {
                            scModal = "fn_AlertModal('Info','" + resultUpload + "','SettingProduct.aspx?cate=" + cateid + "&show=yes#divProd_" + index + "',2000);";
                        }
                    }
                    else
                    {
                        scModal = "fn_AlertModal('Info','บันทึกข้อมูลเรียบร้อยแล้ว แต่ไม่สามารถอัพเดทเวอร์ชั่นได้ กรุณาติดต่อผู้ดูแลระบบ !!','',0);";
                    }
                }
                else
                {
                    scModal = "fn_AlertModal('Info','กรุณาแนบภาพสินค้า !!','',0);";
                }
            }
            else
            {
                scModal = "fn_AlertModal('Warning','ไม่สามารถบันทึกข้อมูลได้ กรุณาติดต่อผู้ดูแลระบบ !!','',0);";
            }

            Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
        }

        protected void btn_addProd_ServerClick(object sender, EventArgs e)
        {
            string scModal = "";


            if (Upload_newProduct.HasFile)
            {
                string cateid = Request.QueryString["cate"].ToString();
                int index = 1;

                sql = "select ifnull(max(mk_index),0) as 'mk_index' from marketingproduct where mk_mcid='" + cateid + "' ";
                dt = new DataTable();
                dt = CL_Sql.select(sql);
                if (dt.Rows.Count > 0)
                {
                    index = index + int.Parse(dt.Rows[0]["mk_index"].ToString());
                }

                string prName = txt_prodName.Value.ToString().Trim();
                string prPrice = txt_prodPrice.Value.ToString().Trim();
                if (prPrice == "")
                {
                    prPrice = "0";
                }
                string prDiscount = txt_prodDiscount.Value.ToString().Trim();
                if (prDiscount == "")
                {
                    prDiscount = "NULL";
                }
                string prDelivery = "no";
                if (cb_prodDelivery.Checked)
                {
                    prDelivery = "yes";
                }
                string prCondition = txt_prodCondition.Value.ToString().Trim();

                sql = "INSERT INTO marketingproduct " +
                    "\n(mk_productname, mk_price, mk_discount, mk_index, mk_mcid, mk_delivery, mk_condition) " +
                    "\nVALUES('" + prName + "', " + prPrice + ", " + prDiscount + ", " + index + ", " + cateid + ", '" + prDelivery + "', '" + prCondition + "');";
                if (CL_Sql.Modify(sql))
                {

                    string path = "image/product/";
                    string filename = "imageProduct" + index;
                    HttpPostedFile HPF = Upload_newProduct.PostedFile;
                    string resultUpload = UploadImgProduct(cateid, filename, HPF);
                    if (resultUpload == "success")
                    {
                        scModal = "fn_AlertModal('Success','Success !!','SettingProduct?cate=" + cateid + "&show=yes#divProd_" + index + "',2000);";
                    }
                    else
                    {
                        scModal = "fn_AlertModal('Info','" + resultUpload + "','',0);";
                    }
                }
                else
                {
                    scModal = "fn_AlertModal('Info','ไม่สามารถบันทึกได้ กรุณาติดต่อผู้ดูแลระบบ !!','',0);";
                }
            }
            else
            {
                scModal = "fn_AlertModal('Info','กรุณาแนบภาพสินค้า !!','',0);";
            }

            Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
        }



        public string UploadImgCategory(string id)
        {
            string result = "";

            string Path = "../Marketing/image/main/";
            string path = "image/main/";
            string Name = "Home-Category"; // + version;

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

        public string UploadImgProduct(string id, string Name, HttpPostedFile uploadFile)
        {

            string result = "";

            string Path = "../Marketing/image/product/";
            string path = "image/product/";

            string FileName = uploadFile.FileName;
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

            return result;
        }

        
    }
}