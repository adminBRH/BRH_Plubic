using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;

using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.Runtime.InteropServices;

namespace BRH_Plubic.MorChana
{
    public partial class Default : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DeleteImage();
            }

            if (Session["userid"] == null)
            {
                Response.Redirect("../Default.aspx?back=MorChana&login=require");
            }
            else
            {
                string empid = Session["userid"].ToString();
                lbl_name.Text = Session["name"].ToString();
                lbl_ip.Text = " IP[" + GetUserIP() + "]";
            }
        }

        private string GetUserIP()
        {
            //Gets a comma-delimited list of IP Addresses
            string ipList = Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

            //If any are available - use the first one
            if (!string.IsNullOrEmpty(ipList))
            {
                return ipList.Split(',')[0];
            }

            //Otherwise return the Remote Address
            return Request.ServerVariables["REMOTE_ADDR"];
        }

        public string checkdata()
        {
            string result = "";

            string alert = "";

            string color = txtH_color.Value.ToString().Trim();
            string gender = txtH_gender.Value.ToString().Trim();
            if (color == "")
            {
                if (alert != "")
                {
                    alert = alert + ", ";
                }
                alert = alert + "เลือกสี";
            }
            if (!FileUpload1.HasFile)
            {
                if (alert != "")
                {
                    alert = alert + ", ";
                }
                alert = alert + "แนบรูปภาพ";
            }
            else
            {
                string file_name = FileUpload1.FileName;
                string[] list_file = file_name.ToString().Split('.');
                int maxindex = list_file.Length - 1;
                string typefile = list_file[maxindex].ToString().ToLower();
                if (typefile == "jpg" || typefile == "jpeg" || typefile == "png")
                {

                }
                else
                {
                    alert = alert + "แนบรูปภาพใหม่(ระบบไม่รองรับไฟล์ ." + typefile + ")";
                }
            }
            if (gender == "")
            {
                if (alert != "")
                {
                    alert = alert + ", ";
                }
                alert = alert + "เลือกเพศ";
            }

            if (alert == "")
            {
                result = "";
            }
            else
            {
                alert = "กรุณา " + alert;
                result = alert;
            }

            

            return result;
        }

        protected void btn_submit_ServerClick(object sender, EventArgs e)
        {
            System.Threading.Thread.Sleep(2000);

            string scModal = "";

            string result = checkdata();
            if (result == "")
            {
                string color = txtH_color.Value.ToString().Trim();
                string gender = txtH_gender.Value.ToString().Trim();
                string empid = Session["userid"].ToString();
                string empstatus = Session["status"].ToString();

                sql = "select * from morchana where mc_empstatus='" + empstatus + "' and mc_empid='" + empid + "'" +
                    "and convert(mc_datetime,date)=current_date ";
                dt = new DataTable();
                dt = cl_Sql.select(sql);
                if (dt.Rows.Count > 0)
                {
                    scModal = "fn_AlertModal('Info','วันนี้คุณอัพโหลดไปแล้ว ไม่สามารถทำซ้ำได้ !!','',0);";
                }
                else
                {
                    string id = SaveData(empid, empstatus, gender, color);
                    if (id == "")
                    {
                        scModal = "fn_AlertModal('Warning','ไม่สามารถบันทึกข้อมูลได้ กรุณาติดต่อผู้ดูแลระบบ !!','',0); fn_preview();";
                    }
                    else
                    {
                        if (upload_file(id))
                        {
                            string ResultDate = DateTime.Now.ToString("dd/MM/") + (DateTime.Now.Year + 543).ToString();
                            scModal = "fn_AlertModal('Success','บันทึกสำเร็จ วันที่ " + ResultDate + "','',0); fn_preview();";
                        }
                        else
                        {
                            scModal = "fn_AlertModal('Info','ไม่สามารถบันทึกรูปภาพได้ กรุณาติดต่อผู้ดูแลระบบ !!','',0); fn_preview();";
                        }
                    }
                }
            }
            else
            {
                scModal = "fn_AlertModal('Warning','" + result + "','',0); fn_preview();";
            }

            Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
        }

        public string SaveData(string empid, string empstatus, string gender, string color)
        {
            string result = "";

            string key = cl_Sql.GenerateKey(6);

            sql = "INSERT INTO morchana " +
                "(mc_empid, mc_empstatus, mc_gender, mc_color,mc_active,mc_ip) " +
                "VALUES('" + empid + "', '" + empstatus + "', '" + gender + "', '" + color + "','" + key + "','" + GetUserIP() + "'); ";
            if (cl_Sql.Modify(sql))
            {
                sql = "select * from morchana where mc_active = '" + key + "' ";
                dt = new DataTable();
                dt = cl_Sql.select(sql);
                if (dt.Rows.Count > 0)
                {
                    result = dt.Rows[0]["mc_id"].ToString();

                    sql = "update morchana set mc_active='yes' where mc_id = '" + result + "' ";
                    cl_Sql.Modify(sql);
                }
            }
            return result;
        }

        public void ResizeImage(string thumb, string path, string type)
        {
            foreach(HttpPostedFile get_file in FileUpload1.PostedFiles)
            {
                get_file.SaveAs(System.IO.Path.Combine(Server.MapPath(thumb), path));
            }
            
            System.Drawing.Image img = System.Drawing.Image.FromFile(Server.MapPath(thumb + path));

            //ImageResizer.ScaleMode.DownscaleOnly = 0;
        }

        public Boolean upload_file(string id)
        {
            Boolean bl = false;
            if (FileUpload1.HasFile)
            {
                string file_name = "";
                foreach (HttpPostedFile get_file in FileUpload1.PostedFiles)
                {
                    file_name = FileUpload1.FileName;
                    string[] list_file = file_name.ToString().Split('.');
                    int maxindex = list_file.Length - 1;
                    string typefile = list_file[maxindex].ToString();
                    //if (typefile == "jpg" || typefile == "jpeg" || typefile == "png")
                    //{

                        
                    //}
                    file_name = id + "_capture." + typefile;

                    try
                    {
                        get_file.SaveAs(System.IO.Path.Combine(Server.MapPath("image/capture/"), file_name));

                        sql = "update morchana set mc_img='image/capture/" + file_name + "' where mc_id = '" + id + "'; ";
                        cl_Sql.Modify(sql);

                        bl = true;
                    }
                    catch
                    {
                        bl = false;
                    }

                    //ResizeImage("image/resize/", file_name, typefile);
                }
            }

            return bl;
        }

        public Boolean DeleteImage()
        {
            Boolean bl = false;

            if (Session["userid"] != null)
            {
                string empid = Session["userid"].ToString();

                sql = "Select * from morchana where mc_empid='" + empid + "' and convert(mc_datetime,date) <= current_date - INTERVAL 4 day; ";
                dt = new DataTable();
                dt = cl_Sql.select(sql);
                if (dt.Rows.Count > 0)
                {
                    foreach (DataRow dr in dt.Rows)
                    {
                        string filename = dr["mc_img"].ToString();
                        if (System.IO.File.Exists(Server.MapPath(filename)))
                        {
                            System.IO.File.Delete(Server.MapPath(filename));
                            bl = true;
                        }
                    }
                }
            }

            return bl;
        }
    }
}