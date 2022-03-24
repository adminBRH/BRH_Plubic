<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CheckDocument.aspx.cs" Inherits="BRH_Plubic.NovelCorona.CheckDocument" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentDesktop" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<style>
    .SelectDetail {
        font-size: large; 
        cursor: pointer;
    }
    .SelectDetail:hover{
        background-color: burlywood;
    }
    .DeleteDetail {
        font-size: large; 
        cursor: pointer;
    }
    .DeleteDetail:hover{
        background-color: mediumvioletred;
    }
    input[type=radio]{
        border: 0px;
        width: 2em;
        height: 2em;
    }
</style>
<script>
    function fn_status(val) {
        var txt = '';
        if (val == '') {
            txt = 'ตรวจสอบ';
        }
        else {
            txt = 'Print';
        }
        document.write(txt);
    }
    function fn_link(val, id, key) {
        if (val == 'yes') {
            window.location.href = 'Report.aspx?nc=' + id + '&key=' + key;
        }
        else {
            window.location.href = 'Default.aspx?nc=' + id;
        }
    }
</script>

    <div class="col-12 mx-auto my-3">
        <div class="col-lg-8 col-sm-12 mx-auto text-center bg-gradient-blue" style="border-radius: 20px;">
            <div class="row col-12 mx-auto">
                <div class="col-12 mx-auto mt-2 text-center h1">
                    ค้นหารายงานผู้ป่วยโรคปอดอักเสบ<br />จากเชื้อไวรัสโคโรนาสายพันธุ์ใหม่ 2019
                </div>
                <div class="col-12 mx-auto my-auto text-left h4">
                    ค้นหาจาก &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="radio" id="rd_docno" name="rd_search" runat="server" onclick="fn_typeSearch()" checked /> เลขที่เอกสาร &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="radio" id="rd_name" name="rd_search" runat="server" onclick="fn_typeSearch()" /> ชื่อ นามสกุล &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <button id="btn_clear" class="btn btn-danger" onserverclick="btn_clear_ServerClick" runat="server" visible="false">ยกเลิกการค้นหา</button>
                </div>
                <div class="col-8 mx-auto my-auto text-center">
                    <input type="text" id="txt_docno" class="form-control" value="" placeholder="กรอกหมายเลขเอกสาร" runat="server" />
                    <input type="text" id="txt_name" class="form-control" value="" placeholder="กรอกชื่อหรือนามสกุล" runat="server" hidden="hidden" />
                </div>
                <div class="col-4 mx-auto my-auto text-left">
                    <button id="btn_submit" class="btn btn-outline-light" onserverclick="btn_submit_ServerClick" runat="server">Search <i class="ti-search ti-2x"></i></button>
                </div>
                <div class="col-12 mx-auto mb-2 text-right">
                    <a href="Default?nc=staff" style="font-size: large;">กรอกข้อมูลใหม่ <i class="ti-pencil ti-2x"></i></a>
                </div>
            </div>
        </div>
    </div>

    <script>
        function fn_typeSearch() {
            var rdname = document.getElementById('<%= rd_name.ClientID %>');
            var txtdocno = document.getElementById('<%= txt_docno.ClientID %>');
            var txtname = document.getElementById('<%= txt_name.ClientID %>');
            if (rdname.checked) {
                txtdocno.setAttribute('hidden', 'hidden');
                txtname.removeAttribute('hidden');
            } else {
                txtdocno.removeAttribute('hidden');
                txtname.setAttribute('hidden', 'hidden'); 
            }
        }
        fn_typeSearch();
    </script>

    <div class="col-10 mx-auto mt-5 text-right">
        <button id="btn_Export" class="btnShadow btn-outline-primary" runat="server" onserverclick="btn_Export_ServerClick" style="font-size: xx-large; border-radius: 10px;">Export <i class="ti-export"></i></button>
    </div>

    <div class="row col-lg-10 col-sm-12 mx-auto my-3">
        <div class="col-4 mx-auto text-right">
            <asp:DropDownList ID="DD_Date" CssClass="btn btn-outline-info" OnSelectedIndexChanged="DD_Date_SelectedIndexChanged" AutoPostBack="true" runat="server">
                <asp:ListItem Text="" Value=""></asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="col-4 mx-auto text-center">
            <a id="btn_refresh" runat="server" onserverclick="btn_refresh_ServerClick" style="cursor:pointer;"><i class="ti ti-2x ti-reload"></i></a>
        </div>
        <div class="col-4 mx-auto">
            <asp:DropDownList ID="dd_status" CssClass="btn btn-outline-info" OnSelectedIndexChanged="dd_status_SelectedIndexChanged" AutoPostBack="true" runat="server">
                <asp:ListItem Text="ทุกสถานะ" Value=""></asp:ListItem>
                <asp:ListItem Text="ตรวจสอบ : no" Value="no"></asp:ListItem>
                <asp:ListItem Text="ตรวจสอบ : yes" Value="yes"></asp:ListItem>
                <asp:ListItem Text="Print" Value="print"></asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="col-12 mx-auto">
            <asp:ListView ID="LV_Report" runat="server">
                <LayoutTemplate>
                    <div class="col-12 mx-auto text-center h1">
                        รายชื่อผู้ทำแบบสอบถามทั้งหมด
                    </div>
                    <div class="row col-12 mx-auto bg-info" style="border-top-left-radius: 20px; border-top-right-radius: 20px; color:white;">
                        <div class="col-2 mx-auto my-auto text-center h3">เลขที่เอกสาร</div>
                        <div class="col-10 mx-auto my-auto text-center h3">Details</div>
                    </div>
                    <div id="itemPlaceholder" runat="server"></div>
                    <div class="col-12 mx-auto  bg-info" style="border-bottom-left-radius: 20px; border-bottom-right-radius: 20px;">&nbsp;</div>
                </LayoutTemplate>
                <ItemTemplate>
                    <div class="row col-12 mx-auto my-auto">
                        <div class="card col-11 mx-auto my-auto SelectDetail">
                            <div class="row col-12 mx-auto my-2" onclick="fn_link('<%# Eval("nc_staffcheck") %>','<%# Eval("nc_id") %>','<%# Eval("nc_key") %>')">
                                <div class="col-2 mx-auto my-auto text-center"><%# Eval("nc_id") %></div>
                                <div class="col-10 mx-auto my-auto">
                                    <div class="row col-12 mx-auto my-auto">
                                        <div class="col-4 mx-auto my-auto">
                                            <%# Eval("nc_datetime", "{0:dd/MMM/yyyy}") %>
                                        </div>
                                        <div class="col-3 mx-auto my-auto">
                                            <%# Eval("nc_fname") %> <%# Eval("nc_lname") %>
                                        </div>
                                        <div class="col-3 mx-auto my-auto">
                                            Tel: <%# Eval("nc_adr_mobile") %>
                                        </div>
                                        <div class="col-2 mx-auto my-auto">
                                                <script> fn_status('<%# Eval("ncc_reporter") %>'); </script> : <%# Eval("nc_staffcheck") %>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card col-1 mx-auto my-1 DeleteDetail text-center" onclick="fn_del('<%# Eval("nc_id") %>')">
                            <a id="btn_del" class="mx-auto my-auto"><i class="ti ti-2x ti-trash"></i></a>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:ListView>
        </div>
    </div>

    <!-- Modal -->
    <div class="modal fade" id="ModalDelete" tabindex="-1" role="dialog" aria-labelledby="ModalDeleteTitle" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="ModalDeleteTitle">ยืนยันการลบข้อมูล</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body h3">
              คุณต้องการลบเอกสารเลขที่ <asp:Label ID="lbl_id" Text="" runat="server"></asp:Label><br />ใช่หรือไม่ ?
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">ไม่</button>
            <button type="button" id="btn_delete" class="btn btn-danger" onserverclick="btn_delete_ServerClick" runat="server">ใช่</button>
          </div>
        </div>
      </div>
    </div>
    
    <div class="col-12 mx-auto" hidden="hidden">
        <asp:GridView ID="GridView1" runat="server"></asp:GridView>
    </div>

    <input id="txtH_id" value="" runat="server" hidden="hidden"/>
    <script>
        function fn_del(id) {
            document.getElementById('<%= lbl_id.ClientID %>').innerHTML = id;
            document.getElementById('<%= txtH_id.ClientID %>').value = id;
            $('#ModalDelete').modal('show');
        }
    </script>

</asp:Content>
