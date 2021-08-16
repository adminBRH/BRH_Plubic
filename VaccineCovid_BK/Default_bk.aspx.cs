using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Text;
using MySql.Data.MySqlClient;

namespace BRH_Plubic.VaccineCovid
{
    public partial class Default : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        VaccineClass cl_Invent = new VaccineClass();

        protected void Page_Load(object sender, EventArgs e)
        {
            StartBooking();
            if (!IsPostBack)
            {
                cl_Invent.ClearBooking();
            }
        }

        private void StartBooking()
        {
            string scModal = "";
            DateTime DateNow = DateTime.Now;
            if (DateNow <= cl_Invent.LockPage())
            {
                //scModal = "fn_AlertModal('Info','ระบบจะเปิดให้ทำการจอง วันที่ 13 กรกฎาคม 2564 เวลา 08:00 น. !!','',);";
                scModal = "fn_AlertModal('Info','ขออภัยในความไม่สะดวก ขณะนี้กำลังทำการปรับปรุงระบบ เพื่อรองรับการเข้าใช้งานพร้อมกันในจำนวนมาก !!','',);";
            }
            Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
        }

        public void Delay(int ms)
        {
            System.Threading.Thread.Sleep(ms);
        }

        protected void btn_acknowledge_ServerClick(object sender, EventArgs e)
        {
            Delay(500);
            Response.Redirect("Register?acknowledge=yes");
        }
    }
}