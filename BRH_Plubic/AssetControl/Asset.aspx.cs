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
using System.Net;
using System.IO;

namespace BRH_Plubic.AssetControl
{
    public partial class Asset : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        SQLclass cl_Sql = new SQLclass();

        string clearSearch = "<i class=\"fa fa-stop-circle-o fa-2x\" onclick=\"window.location.href='Asset'\" data-toggle=\"tooltip\" data-placement=\"top\" title=\"Clear Search !\" style=\"cursor: pointer;\"></i>";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userid"] != null)
            {
                if (!IsPostBack)
                {
                    Branch();
                    DD_branch.SelectedValue = "1";
                    Department("BRH");
                    Category("", "");
                    AeetType("", "", "");

                    lbl_repair_user.Text = "แจ้งซ่อมโดย : " + Session["name"].ToString() + " (" + Session["userid"].ToString() + ")";

                    CheckSelect();

                    status();

                    string SearchType = "";
                    string SearchValue = "";
                    string SearchStatus = "";
                    string SearchLimit = "10";
                    if (Request.QueryString["st"] != null && Request.QueryString["sv"] != null)
                    {
                        SearchType = Request.QueryString["st"].ToString();
                        SearchValue = Request.QueryString["sv"].ToString();
                        SearchLimit = Request.QueryString["lm"].ToString();
                        Search(SearchType, SearchValue, SearchLimit);
                    }
                    else
                    {
                        ListAsset(SearchValue, SearchType, SearchStatus, SearchLimit);
                    }
                }
            }
            else
            {
                Response.Redirect("../Default.aspx?back=AssetControl/Asset&login=require");
            }
        }

        public Boolean CheckStatus()
        {
            Boolean bl = false;

            string userStatus = Session["status"].ToString();
            if (userStatus == "admin")
            {
                bl = true;
            }

            return bl;
        }

        protected void status()
        {
            sql = "select * from asset_status where ass_active = 'yes'; ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {

            }
            DD_status.DataSource = dt;
            DD_status.DataTextField = "ass_name";
            DD_status.DataValueField = "ass_id";
            DD_status.DataBind();
        }

        protected void ListAsset(string search, string searchby, string status, string limit)
        {
            status = DD_status.SelectedValue.ToString();

            sql = "select ad.*,ds.*,ac.*,at.*,st.* " +
                "\n,null as 'asd_timeago', null as 'asd_performance', null as 'asd_performance_ar' " +
                "\n,if(ar.asr_status is null,'Finish',ar.asr_status) as 'asr_status', ar.asr_id " +
                "\nfrom asset_details as ad  " +
                "\nleft join department_service as ds on ds.ds_id = ad.asd_dept " +
                "\nleft join asset_cate as ac on ac.asc_id = ad.asd_cate " +
                "\nleft join asset_type as at on at.ast_id = ad.asd_type " +
                "\nleft join asset_status as st on st.ass_id = ad.asd_status " +
                "\nleft join (select * from asset_repair where asr_status != 'Finish') as ar on ar.asr_asdid = ad.asd_id " +
                "\nwhere asd_status like '%" + status + "%' ";
            if (searchby == "code")
            {
                sql = sql + "\nand (";
                sql = sql + "asd_sn like '%" + search + "%' ";
                sql = sql + "or asd_gls_barcode like '%" + search + "%' ";
                sql = sql + "or asd_nhealth_barcode like '%" + search + "%' ";
                sql = sql + "or asd_asr_id like '%" + search + "%' ";
                sql = sql + ") ";
            }
            else if (searchby == "location")
            {
                sql = sql + "\nand (" +
                    "\nds_desc like '%" + search + "%' " +
                    "\nor ds_id like '%" + search + "%' " +
                    ") ";
            }
            else
            {

            }
            sql = sql + "limit " + limit + "; ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                foreach (DataRow dr in dt.Rows)
                {
                    string timeAgo = dr["asd_mdate"].ToString();
                    if (timeAgo == "") { timeAgo = dr["asd_cdate"].ToString(); }
                    dr["asd_timeago"] = cl_Sql.TimeAgo(DateTime.Parse(timeAgo));
                    string[] PerformanceAr = Performance(dr["asd_id"].ToString()).Split('@');
                    dr["asd_performance"] = PerformanceAr[0];
                    dr["asd_performance_ar"] = PerformanceAr[1]; // How to use >> Split by '|'
                }
            }

            LV_Asset.DataSource = dt;
            LV_Asset.DataBind();
        }

        public string Performance(string asd_id)
        {
            string result = "";
            string asdpDetail = "";

            sql = "select * from asset_details_performance as adp " +
                "left join asset_performance as asp on asp.asp_id = adp.asdp_aspid " +
                "\nwhere asdp_active='yes' and asdp_asdid='" + asd_id +"'; ";
            DataTable dtP = new DataTable();
            dtP = cl_Sql.select(sql);
            if (dtP.Rows.Count > 0)
            {
                foreach (DataRow drP in dtP.Rows)
                {
                    string name = drP["asp_name"].ToString() + " " + drP["asdp_details"].ToString();
                    string img = drP["asp_image"].ToString();
                    result = result + "<img src='images/" + img + "' data-toggle='tooltip' data-placement='top' title='" + name + "' />";

                    if (asdpDetail != "") { asdpDetail = asdpDetail + "|"; }
                    asdpDetail = asdpDetail + drP["asdp_id"].ToString() + "," + drP["asdp_aspid"].ToString() + ",images/" + img + "," + name;
                }
            }

            return result + "@" + asdpDetail;
        }

        protected void btn_div_add_ServerClick(object sender, EventArgs e)
        {
            ti_div_add.Attributes.Remove("class");
            if (div_add.Visible == false)
            {
                div_add.Visible = true;
                ti_div_add.Attributes.Add("class", "ti-angle-double-up");
            } 
            else
            {
                div_add.Visible = false;
                ti_div_add.Attributes.Add("class", "ti-plus");
            }
        }

        private void Branch()
        {
            sql = "select * from branch where br_active='yes' order by br_id; ";
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {

            }
            DD_branch.DataSource = dt;
            DD_branch.DataValueField = "br_id";
            DD_branch.DataTextField = "br_name";
            DD_branch.DataBind();
            //DD_branch.Items.Insert(0, new ListItem("รพ.กรุงเทพระยอง", "1"));
        }

        private void Department(string br)
        {
            sql = "select * from department_service where ds_active='yes' and ds_branch = '" + br + "' " +
                "\norder by ds_branch,ds_desc";
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                
            }
            DD_department.DataSource = dt;
            DD_department.DataValueField = "ds_id";
            DD_department.DataTextField = "ds_desc";
            DD_department.DataBind();
            DD_department.Items.Insert(0, new ListItem("เลือก แผนก", ""));
        }

        private void Category(string br, string dept)
        {
            sql = "select * from asset_cate where asc_active='yes' and asc_branch='" + br + "' and asc_dept='" + dept + "' order by asc_id; ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            { }
            else
            {
                if (dept != "")
                {
                    sql = "select * from asset_cate where asc_active='yes' and asc_branch='" + br + "' and asc_dept='ALL' order by asc_id; ";
                    dt = new DataTable();
                    dt = cl_Sql.select(sql);
                    if (dt.Rows.Count > 0)
                    { }
                }
            }
            DD_cate.DataSource = dt;
            DD_cate.DataValueField = "asc_id";
            DD_cate.DataTextField = "asc_name";
            DD_cate.DataBind();
            DD_cate.Items.Insert(0, new ListItem("เลือก หมวดหมู่", ""));
        }

        private void AeetType(string br, string dept, string cate)
        {
            sql = "Select * from asset_type where ast_active='yes' and ast_ds_branch='" + br + "' and ast_dept='" +dept + "' and ast_cate='" + cate + "' ";
            sql = sql + "\norder by ast_name; ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            { }
            else
            {
                if (dept != "")
                {
                    sql = "Select * from asset_type where ast_active='yes' and ast_ds_branch='" + br + "' and ast_dept='ALL' and ast_cate='" + cate + "' ";
                    sql = sql + "\norder by ast_name; ";
                    dt = new DataTable();
                    dt = cl_Sql.select(sql);
                    if (dt.Rows.Count > 0)
                    { }
                    else
                    {
                        if (cate != "")
                        {
                            sql = "Select * from asset_type where ast_active='yes' and ast_ds_branch='" + br + "' and ast_dept='ALL' and ast_cate='ALL' ";
                            sql = sql + "\norder by ast_name; ";
                            dt = new DataTable();
                            dt = cl_Sql.select(sql);
                            if (dt.Rows.Count > 0)
                            { }
                        }
                    }
                }
            }

            DD_typeAsset.DataSource = dt;
            DD_typeAsset.DataTextField = "ast_name";
            DD_typeAsset.DataValueField = "ast_id";
            DD_typeAsset.DataBind();
            DD_typeAsset.Items.Insert(0, new ListItem("เลือก ประเภท", ""));
        }

        public Boolean CheckSelect()
        {
            Boolean bl = true;

            if (DD_branch.SelectedValue == "")
            {
                DD_branch.ForeColor = Color.Red;
                bl = false;
            }
            else
            {
                DD_branch.ForeColor = Color.Green;
            }

            if (DD_department.SelectedValue == "")
            {
                DD_department.ForeColor = Color.Red;
                bl = false;
            }
            else
            {
                DD_department.ForeColor = Color.Green;
            }
            
            if (DD_cate.SelectedValue == "")
            {
                DD_cate.ForeColor = Color.Red;
                bl = false;
            }
            else
            {
                DD_cate.ForeColor = Color.Green;
            }
            
            if (DD_typeAsset.SelectedValue == "")
            {
                DD_typeAsset.ForeColor = Color.Red;
                bl = false;
            }
            else
            {
                DD_typeAsset.ForeColor = Color.Green;
            }

            if (bl == true)
            {
                div_add_Code.Visible = true;
            }
            else
            {
                div_add_Code.Visible = false;
            }

            return bl;
        }

        protected void DD_branch_SelectedIndexChanged(object sender, EventArgs e)
        {
            string br = DD_branch.SelectedValue.ToString();
            Department(br);
            string dept = DD_department.SelectedValue.ToString();
            Category(br, dept);
            string cate = DD_cate.SelectedValue.ToString();
            AeetType(br, dept, cate);

            CheckSelect();
        }

        protected void DD_department_SelectedIndexChanged(object sender, EventArgs e)
        {
            string br = DD_branch.SelectedValue.ToString();
            string dept = DD_department.SelectedValue.ToString();
            Category(br, dept);
            string cate = DD_cate.SelectedValue.ToString();
            AeetType(br, dept, cate);

            CheckSelect();
        }

        protected void DD_cate_SelectedIndexChanged(object sender, EventArgs e)
        {
            string br = DD_branch.SelectedValue.ToString();
            string dept = DD_department.SelectedValue.ToString();
            string cate = DD_cate.SelectedValue.ToString();
            AeetType(br, dept, cate);

            CheckSelect();
        }

        protected void DD_typeAsset_SelectedIndexChanged(object sender, EventArgs e)
        {
            CheckSelect();
        }

        protected void btn_asr_ServerClick(object sender, EventArgs e)
        {
            string html = "";

            string br = DD_branch.SelectedValue.ToString();
            string dept = DD_department.SelectedValue.ToString();
            string cate = DD_cate.SelectedValue.ToString();
            string type = DD_typeAsset.SelectedValue.ToString();
            string sn = txt_asr.Value.ToString().Trim();

            sql = "select * from asset_details " +
                "\nwhere asd_branch='" + br + "' and asd_dept='"+ dept + "' " +
                "\nand asd_sn = '" + sn + "' " +
                "\norder by asd_sn; ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                lbl_asr_alert.ForeColor = Color.Blue;
                txt_asr_clone.Value = txt_asr.Value.ToString();

                int rc = dt.Rows.Count;
                if (rc <= 10)
                {
                    int i = 1;
                    foreach (DataRow dr in dt.Rows)
                    {
                        if (html != "")
                        {
                            html = html + "<br />";
                        }
                        html = html + "<span class=\"badge badge-primary\"><i class=\"fa fa-link\"></i></span> " + dr["asd_displayname"].ToString();
                        html = html + " <a class=\"btn btn-outline-info\" onmouseover=\"fn_ti('" +i.ToString()+ "'," + rc.ToString() + ")\" onclick=\"fn_select_asr('" + i.ToString() + "')\"><i id=\"ti_" + i.ToString() + "\" calss=\"ti-control-stop\"></i></a>";
                        i++;
                    }
                }
            }
            if (html == "")
            {
                txt_asr_clone.Value = "";
                html = "ไม่พบ S/N นี้ในแผนก " + DD_department.SelectedItem.Text + " !!";
                lbl_asr_alert.ForeColor = Color.Red;
            }
            lbl_asr_alert.Text = html;
        }

        protected void btn_add_ServerClick(object sender, EventArgs e)
        {
            string scModal = "";

            string br = DD_branch.SelectedValue.ToString();
            string dept = DD_department.SelectedValue.ToString();
            string cate = DD_cate.SelectedValue.ToString();
            string type = DD_typeAsset.SelectedValue.ToString();

            string name = txt_add_name.Value.ToString().Trim();
            string sn = txt_add_SN.Value.ToString().Trim();
            string gls_bar = txt_add_GLS.Value.ToString().Trim();
            string nhealth_bar = txt_add_NHealth.Value.ToString().Trim();

            string mac = txt_add_mac.Value.ToString().Trim();
            string ip = txt_add_ip.Value.ToString().Trim();
            string comname = txt_add_comname.Value.ToString().Trim();
            string camera = DD_camera.SelectedValue.ToString();
            string cardreader = DD_cardreader.SelectedValue.ToString();

            string asc = txt_asr_clone.Value.ToString().Trim();

            //string program = txt_program.Value.ToString().Trim();
            string desc = txt_desc.Value.ToString().Trim();

            if (sn == "" || name == "")
            {
                if (sn == "") { txt_add_SN.Attributes.Add("style", "border-color: red;"); }
                if (name == "") { txt_add_name.Attributes.Add("style", "border-color: red;"); }
            }
            else
            {
                txt_add_SN.Attributes.Remove("style");
                txt_add_name.Attributes.Remove("style");

                string cuser = Session["userid"].ToString();

                sql = "select * from asset_details where asd_sn='" + sn + "' ";
                dt = new DataTable();
                dt = cl_Sql.select(sql);
                if (dt.Rows.Count > 0)
                {
                    scModal = "fn_AlertModal('Info','Duplicate S/N !!','',0);";
                }
                else
                {
                    lbl_add_alert.Text = ""; 

                    sql = "INSERT INTO asset_details " +
                        "\n(asd_branch, asd_dept, asd_cate, asd_type, asd_cuser, asd_displayname, asd_sn, asd_gls_barcode, asd_nhealth_barcode, asd_mac, asd_ip, asd_comname, asd_camera, asd_cardreader, asd_asr_id, asd_desc) " +
                        "\nVALUES('" + br + "', '" + dept + "', '" + cate + "', '" + type + "'" +
                        ", '" + cuser + "', '" + name + "', '" + sn + "', '" + gls_bar + "', '" + nhealth_bar + "'" +
                        ", '" + mac + "', '" + ip + "', '" + comname + "', '" + camera + "', '" + cardreader + "'" +
                        ", '" + asc + "', '" + desc + "'); ";
                    if (cl_Sql.Modify(sql))
                    {
                        string SearchType = "";
                        string SearchValue = "";
                        string limit = dd_limit.SelectedValue.ToString();
                        if (txt_search_location.Value.ToString() != "")
                        {
                            SearchType = "location";
                            SearchValue = txt_search_location.Value.ToString().Trim();
                        }
                        if (txt_search_code.Value.ToString() != "")
                        {
                            SearchType = "code";
                            SearchValue = txt_search_code.Value.ToString().Trim();
                        }
                        scModal = "fn_AlertModal('Success','Success !!','Asset?st=" + SearchType + "&sv=" + SearchValue + "&lm=" + limit + "',1000);";
                    }
                    else
                    {
                        scModal = "fn_AlertModal('Warning','ไม่สามารถบันทึกได้ กรุณาติดต่อผู้ดูแลระบบ !!','',0);";
                    }
                }
            }

            Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
        }

        protected void btn_search_code_ServerClick(object sender, EventArgs e)
        {
            string search = txt_search_code.Value.ToString().Trim();
            string limit = dd_limit.SelectedValue.ToString();
            Search("code" ,search, limit);
        }

        protected void btn_search_location_ServerClick(object sender, EventArgs e)
        {
            string search = txt_search_location.Value.ToString().Trim();
            string limit = dd_limit.SelectedValue.ToString();
            Search("location", search, limit);
        }

        protected void btn_accessories_ServerClick(object sender, EventArgs e)
        {
            string limit = dd_limit.SelectedValue.ToString();
            string type = "location";
            string search = txt_search_location.Value.ToString();
            if (search == "")
            {
                type = "code";
                search = txt_search_code.Value.ToString();
            }
            
            Search(type, search, limit);
        }

        protected void Search(string type,string search, string limit)
        {
            if (type == "location")
            {
                ListAsset(search, "location", "", limit);
                lbl_search_alert.Text = "Search by location >> " + search + " " + clearSearch;
                txt_search_location.Value = search;
                txt_search_code.Value = "";
            }

            if (type == "code")
            {
                ListAsset(search, "code", "", limit);
                lbl_search_alert.Text = "Search by Code >> " + search + " " + clearSearch;
                txt_search_code.Value = search;
                txt_search_location.Value = "";
            }

            dd_limit.SelectedValue = limit;
        }

        protected void dd_limit_SelectedIndexChanged(object sender, EventArgs e)
        {
            string searchLo = txt_search_location.Value.ToString().Trim();
            string searchCo = txt_search_code.Value.ToString().Trim();
            string search = "";
            string by = "";
            lbl_search_alert.Text = "";
            if (searchLo != "")
            {
                search = searchLo;
                by = "location";
                lbl_search_alert.Text = "Search by Location >> " + search + " " + clearSearch;
            }
            if (searchCo != "")
            {
                search = searchCo;
                by = "code";
                lbl_search_alert.Text = "Search by Code >> " + search + " " + clearSearch;
            }
            string limit = dd_limit.SelectedValue.ToString();
            ListAsset(search, by, "", limit);
        }

        protected void DD_status_SelectedIndexChanged(object sender, EventArgs e)
        {
            string searchLo = txt_search_location.Value.ToString().Trim();
            string searchCo = txt_search_code.Value.ToString().Trim();
            string search = "";
            string by = "";
            lbl_search_alert.Text = "";
            if (searchLo != "")
            {
                search = searchLo;
                by = "location";
                lbl_search_alert.Text = "Search by Location >> " + search + " " + clearSearch;
            }
            if (searchCo != "")
            {
                search = searchCo;
                by = "code";
                lbl_search_alert.Text = "Search by Code >> " + search + " " + clearSearch;
            }
            string limit = dd_limit.SelectedValue.ToString();
            ListAsset(search, by, "", limit);
        }

        protected void btn_edit_ServerClick(object sender, EventArgs e)
        {
            string scModal = "";

            if (CheckStatus() == false)
            {
                scModal = "fn_AlertModal('Warning','คุณไม่มีสิทธิ์แก้ไขข้อมูลสินทรัพย์ !!','',0);";
            }
            else
            {
                string muser = Session["userid"].ToString();

                string asdID = txtH_asdID.Value.ToString().Trim();

                string comname = txt_edit_comname.Value.ToString();
                string displayname = txt_edit_displayname.Value.ToString();
                string sn = txt_edit_sn.Value.ToString();
                string asr = txt_edit_asr.Value.ToString();
                string gls = txt_edit_gls.Value.ToString();
                string nhealth = txt_edit_nhealth.Value.ToString();
                string mac = txt_edit_mac.Value.ToString();
                string ip = txt_edit_ip.Value.ToString();
                string desc = txt_edit_desc.Value.ToString();
                string status = dd_edit_status.SelectedValue.ToString();

                sql = "INSERT INTO asset_details_log(asd_id,asd_status,asd_branch,asd_dept,asd_cate,asd_type,asd_cuser,asd_cdate,asd_muser,asd_mdate,asd_displayname ,asd_sn,asd_gls_barcode,asd_nhealth_barcode,asd_mac,asd_ip,asd_comname,asd_camera,asd_cardreader,asd_pgo,asd_asr_id,asd_desc,asd_warrant_end,asd_transfer_dept) " +
                    "\nSELECT * FROM asset_details where asd_id = '" + asdID + "' ";
                if (cl_Sql.Modify(sql))
                {
                    sql = "update asset_details set asd_comname='" + comname + "', asd_displayname='" + displayname + "', " +
                        "\nasd_sn='" + sn + "', asd_asr_id='" + asr + "', " +
                        "\nasd_gls_barcode='" + gls + "', asd_nhealth_barcode='" + nhealth + "', asd_mac='" + mac + "', asd_ip='" + ip + "', asd_desc='" + desc + "', " +
                        "\nasd_status = '" + status + "', asd_muser='" + muser + "', asd_mdate=CURRENT_TIMESTAMP " +
                        "\nwhere asd_id='" + asdID + "'; ";
                    if (cl_Sql.Modify(sql))
                    {
                        string SearchType = "";
                        string SearchValue = "";
                        string limit = dd_limit.SelectedValue.ToString();
                        if (txt_search_location.Value.ToString() != "")
                        {
                            SearchType = "location";
                            SearchValue = txt_search_location.Value.ToString().Trim();
                        }
                        if (txt_search_code.Value.ToString() != "")
                        {
                            SearchType = "code";
                            SearchValue = txt_search_code.Value.ToString().Trim();
                        }
                        scModal = "fn_AlertModal('Success','Success !!','Asset?st=" + SearchType + "&sv=" + SearchValue + "&lm=" + limit + "',1000);";
                    }
                    else
                    {
                        scModal = "fn_AlertModal('Warning','ไม่สามารถบันทึกได้กรุณาติดต่อผู้ดูแลระบบ [error code: ed001]','',0);";
                    }
                }
                else
                {
                    scModal = "fn_AlertModal('Warning','ไม่สามารถบันทึกได้กรุณาติดต่อผู้ดูแลระบบ [error code: ed002]','',0);";
                }
            }

            Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
        }

        public void ddProformance(string bran, string cate, string type)
        {
            sql = "select * from asset_performance " +
                "\nwhere (asp_branchid='" + bran + "' or asp_branchid='ALL') " +
                "\nand (asp_cateid='" + cate + "' or asp_cateid='ALL') " +
                "\nand (asp_typeid='" + type + "' or asp_typeid='ALL') " +
                "\norder by asp_name; ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            { }

            dd_adjPerformance.DataSource = dt;
            dd_adjPerformance.DataTextField = "asp_name";
            dd_adjPerformance.DataValueField = "asp_id";
            dd_adjPerformance.DataBind();
        }

        public void ListProformance(string asdID)
        {
            sql = "select * from asset_details_performance as adp " +
                "\nleft join asset_performance as ap on ap.asp_id=adp.asdp_aspid " +
                "\nwhere asdp_active='yes' and asdp_asdid='" + asdID + "' ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            { }
            LV_adj_perf.DataSource = dt;
            LV_adj_perf.DataBind();

            txt_adjPerf_details.Value = "";
        }

        protected void btn_adjPerf_ServerClick(object sender, EventArgs e)
        {
            string scModal = "";
            if (CheckStatus() == false)
            {
                scModal = "fn_AlertModal('Warning','คุณไม่มีสิทธิ์แก้ไขข้อมูลสินทรัพย์ !!','',0);";
            }
            else
            {
                string asdID = txtH_adjPerf_id.Value.ToString().Trim();

                ListProformance(asdID);

                string BCT = txtH_adjPerf_BCT.Value.ToString().Trim();
                string[] arBCT = BCT.Split('&');
                string bran = arBCT[0];
                string cate = arBCT[1];
                string type = arBCT[2];

                ddProformance(bran, cate, type);
            }

            Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", scModal, true);
        }

        protected void btn_adjPerf_add_ServerClick(object sender, EventArgs e)
        {
            string cuser = Session["userid"].ToString();
            string asdID = txtH_adjPerf_id.Value.ToString().Trim();
            string aspID = dd_adjPerformance.SelectedValue.ToString();
            string details = txt_adjPerf_details.Value.ToString().Trim();
            sql = "insert into asset_details_performance(asdp_cuser,asdp_asdid,asdp_aspid,asdp_details) values " +
                "\n('" + cuser + "','" + asdID + "','" + aspID + "','" + details + "'); ";
            if (cl_Sql.Modify(sql))
            {
                div_adjPerf_alert.Visible = false;
                lbl_adjPerf_alert.Text = "";

                ListProformance(asdID);
            }
            else
            {
                div_adjPerf_alert.Visible = true;
                lbl_adjPerf_alert.Text = "Can't add performance please contact admin.";
            }
        }

        protected void btn_adjPerf_del_ServerClick(object sender, EventArgs e)
        {
            string muser = Session["userid"].ToString();
            string asdID = txtH_adjPerf_id.Value.ToString().Trim();
            string asdpID = txtH_adjPerf_pid.Value.ToString().Trim();
            sql = "update asset_details_performance set asdp_active='no', asdp_muser='" + muser + "', asdp_mdate=CURRENT_TIMESTAMP " +
                "\nwhere asdp_id='" + asdpID + "' ";
            if (cl_Sql.Modify(sql))
            {
                div_adjPerf_alert.Visible = false;
                lbl_adjPerf_alert.Text = "";

                ListProformance(asdID);
            }
            else
            {
                div_adjPerf_alert.Visible = true;
                lbl_adjPerf_alert.Text = "Can't delete performance please contact admin.";
            }
        }

        public void ReloadDATA()
        {
            string search = txt_search_location.Value.ToString().Trim();
            string searchBy = "location";
            if (txt_search_code.Value.ToString().Trim() != "")
            {
                search = txt_search_code.Value.ToString().Trim();
                searchBy = "code";
            }
            string limit = dd_limit.SelectedValue.ToString();
            ListAsset(search, searchBy, "", limit);
        }

        protected void btn_reload_ServerClick(object sender, EventArgs e)
        {
            ReloadDATA();
        }

        public Boolean Linenotify(string txt, string sendTo)
        {
            Boolean bl = false;

            string token = "zAnirYUlJsqdbI9ISjXe7wPP0xbje3pAufQKXjs4UQ0";
            if (sendTo == "Clinic")
            {
                token = "KvQLv7ml6usGawbF7ljp5GxZDyxo2LbGzdaVL09E8h6";
            }
            string msg = txt.Replace("&","%26");

            try
            {
                var request = (HttpWebRequest)WebRequest.Create("https://notify-api.line.me/api/notify");
                var postData = string.Format("message={0}", msg);
                var data = Encoding.UTF8.GetBytes(postData);
                request.Method = "POST";
                request.ContentType = "application/x-www-form-urlencoded";
                request.ContentLength = data.Length;
                request.Headers.Add("Authorization", "Bearer " + token);

                using (var stream = request.GetRequestStream())
                {
                    stream.Write(data, 0, data.Length);
                }

                var response = (HttpWebResponse)request.GetResponse();
                var responseString = new StreamReader(response.GetResponseStream()).ReadToEnd();

                bl = true;
            }
            catch (Exception ex)
            {
                bl = false;
            }

            return bl;
        }

        protected void btn_repair_submit_ServerClick(object sender, EventArgs e)
        {
            string username = Session["name"].ToString() + "(" + Session["userid"].ToString() + ")";
            string Display = txtH_display.Value.ToString();
            string Location = txtH_location.Value.ToString();
            string Type = txtH_machine.Value.ToString();
            string DESC = txt_repair_detail.Value.ToString().Trim();
            string SN = txtH_SN.Value.ToString();

            sql = "select * from asset_details where asd_sn='" + SN + "'; ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                string asdID = dt.Rows[0]["asd_id"].ToString();
                string typeID = dt.Rows[0]["asd_type"].ToString();
                string cateID = dt.Rows[0]["asd_cate"].ToString();
                string deptID = dt.Rows[0]["asd_dept"].ToString();

                string RepairID = "";

                // Check Duplicate Insert
                sql = "select * from asset_repair where asr_sn='" + SN + "' and asr_status='Notify' ";
                dt = new DataTable();
                dt = cl_Sql.select(sql);
                if (dt.Rows.Count > 0)
                { }
                else
                {
                    sql = "INSERT INTO asset_repair " +
                        "\n(asr_asdid, asr_sn, asr_cuser, asr_dsid, asr_ascid, asr_astid, asr_desc) " +
                        "\nVALUES('" + asdID + "', '" + SN + "', '" + Session["userid"].ToString() + "','" + deptID + "', '" + cateID + "', '" + typeID + "', '" + DESC + "'); ";
                    if (cl_Sql.Modify(sql))
                    {
                        // status 5 = Repair
                        sql = "update asset_details set asd_status='5' where asd_id = '" + asdID + "'; ";
                        if (cl_Sql.Modify(sql))
                        {
                            sql = "select max(asr_id) as 'asr_id' from asset_repair " +
                                "\nwhere asr_asdid='" + asdID + "' and convert(asr_cdate, date)=current_date ";
                            dt = new DataTable();
                            dt = cl_Sql.select(sql);
                            if (dt.Rows.Count > 0)
                            {
                                RepairID = dt.Rows[0]["asr_id"].ToString();

                                string domain = cl_Sql.host();
                                string Link = "http://" + domain + "/AssetControl/RepairList?id=" + RepairID;

                                string txt = "\nแจ้งซ่อมอุปกรณ์ !!\nRepair ID: " + RepairID + "\nLocation: " + Location + "\nAsset Type: " + Type + "" +
                                    "\nDisplay Name: " + Display + "\nSN: " + SN + "\nBy: " + username + "\nLink: " + Link;
                                Linenotify(txt, "IT");

                                txt = "\nหมายเลขการแจ้ง: " + RepairID + "\n" + Location + "\nแจ้งซ่อม " + Type + "(" + Display + ")" +
                                    "\nSN: " + SN + "\nแจ้งโดย: " + username + "\nLink: " + Link;
                                Linenotify(txt, "Clinic");

                                string searchLo = txt_search_location.Value.ToString().Trim();
                                string searchCo = txt_search_code.Value.ToString().Trim();
                                string limit = dd_limit.SelectedValue.ToString();

                                string searchType = "";
                                string search = "";
                                if (searchLo != "")
                                {
                                    searchType = "location";
                                    search = searchLo;
                                }
                                if (searchCo != "")
                                {
                                    searchType = "code";
                                    search = searchCo;
                                }

                                if (searchType == "")
                                {
                                    Response.Redirect(Page.Request.Url.ToString(), true);
                                }
                                else
                                {
                                    Search(searchType, search, limit);
                                }
                            }
                            else
                            {

                            }
                        }
                        else
                        {

                        }
                    }
                    else
                    {

                    }
                }
            }
            else
            {

            }
        }

        protected void btn_generate_log_ServerClick(object sender, EventArgs e)
        {
            string asdid = txtH_log_asdid.Value.ToString();
            sql = "SELECT * FROM asset_transfer_log where concat(',',ast_asdid_array,',') like '%," + asdid + ",%' ";
            dt = new DataTable();
            dt = cl_Sql.select(sql);
            if (dt.Rows.Count > 0)
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "cllAlertModal", "$('#modal_Log_Transfer').modal('show');", true);
            }
            LV_log_transfer.DataSource = dt;
            LV_log_transfer.DataBind();
        }
    }
}