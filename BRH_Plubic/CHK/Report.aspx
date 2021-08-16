<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Report.aspx.cs" Inherits="BRH_Plubic.CHK.Report" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentDesktop" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<!-- Stlye Customs -->
<link href="css/StyleSheet1.css" rel="stylesheet">
<style>
    .CardBGMenu {
        border-radius: 50px;
        border-top-left-radius: 300px;
        border-bottom-right-radius: 300px;
    }
    .textMenu {
        color: white;
        border-radius: 50px;
    }
    .textDeatil{
        color: blue;
        text-shadow: 1px 1px 1px #808080;
    }
</style>

    <asp:ScriptManager ID="ScriptManager_Master" runat="server"></asp:ScriptManager>

    <asp:UpdateProgress ID="prgLoadingStatus" runat="server" DynamicLayout="true">
        <ProgressTemplate>
            <div id="overlay" class="col-12 mx-auto my-auto text-center">
                <asp:Image ID="imgWaitIcon" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/images/BRHrayongLoading.gif" />
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>

    <div class="row col-12 mx-auto mt-sm-5">
        <div class="col-6 mx-auto my-3 card btnShadow bg-gradient CardBGMenu" onclick="ShowHide('div_dashboard')">
            <div id="div_Menu_Dashboard" class="row col-12 mx-auto">
                <div class="col-4 mx-auto">
                    <img src="image/icon/Board1.png" class="iconSize100" style="transform: rotate(20deg);" />
                </div>
                <div class="col-8 mx-auto my-auto h1 bg-primary text-center textMenu">
                    Dashboard.
                </div>
            </div>
        </div>
        <div class="col-6 mx-auto my-3 card btnShadow bg-gradient CardBGMenu" onclick="ShowHide('div_list')">
            <div id="div_Menu_List" class="row col-12 mx-auto">
                <div class="col-4 mx-auto">
                    <img src="image/icon/ReportExcel.png" class="iconSize100" />
                </div>
                <div class="col-8 mx-auto my-auto h1 bg-primary text-center textMenu">
                    Reports.
                </div>
            </div>
        </div>
    </div>

    <section id="sec_dashboard" data-spy="sec_dashboard" data-target="#sec_dashboard"></section> 
    <div id="div_dashboard" class="card boxShadow col-lg-11 col-sm-12 mx-auto my-3" hidden="hidden">
        &nbsp;
    </div>

    <section id="sec_list" data-spy="sec_list" data-target="#sec_list"></section> 
    <div id="div_list" class="card boxShadow col-lg-11 col-sm-12 mx-auto mt-5">
        <asp:UpdatePanel ID="UpdatePanel_list" runat="server">
            <ContentTemplate>
                <div class="col-12 mx-auto text-right">
                    <asp:DropDownList ID="DD_Slot" CssClass="col-lg-8 col-sm-10 btn btn-light" Font-Size="XX-Large" OnSelectedIndexChanged="DD_Slot_SelectedIndexChanged" AutoPostBack="true" runat="server">
                        <asp:ListItem Text="" Value=""></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div id="div_detail" class="row col-12 mx-auto" runat="server" visible="false">
                    <div class="row col-12 mx-auto mb-5 h3">
                        <div class="col-6 mx-auto my-3">
                            <b>ตั้งแต่วันที่ :</b>
                            <br />&nbsp;&nbsp;&nbsp;<asp:Label ID="lbl_slotDate" Text="" runat="server"></asp:Label>
                            <div class="card boxShadow col-10 mx-auto my-3"></div>
                            <b>เวลา :</b>
                            <br />&nbsp;&nbsp;&nbsp;<asp:Label ID="lbl_slotTime" Text="" runat="server"></asp:Label>
                        </div>
                        <div class="col-6 mx-auto my-3">
                            <b>แบบฟอร์มที่ใช้ :</b>
                            <br />&nbsp;&nbsp;&nbsp;<asp:Label ID="lbl_form" Text="" runat="server"></asp:Label>
                            <div class="card boxShadow col-10 mx-auto my-3"></div>
                            <b>เงื่อนไขการจอง :</b>
                            <br />&nbsp;&nbsp;&nbsp;<asp:Label ID="lbl_SplitText" Text="" runat="server"></asp:Label>
                        </div>
                        <div class="card boxShadow col-10 mx-auto"></div>
                    </div>
                    <div id="div_search_sync" class="row col-12 mx-auto my-5 h3" runat="server" visible="false">
                        <div class="col-2 mx-auto my-auto">ค้นหาจาก</div>
                        <div class="row col-8 mx-auto my-auto">
                            <div class="col-3 mx-auto my-auto">
                                เลขที่จอง
                                <input type="text" id="txt_search_num" class="form-control" value="" runat="server" />
                            </div>
                            <div class="col-6 mx-auto my-auto">
                                ชื่อ-นามสกุล
                                <input type="text" id="txt_search_name" class="form-control" value="" runat="server" />
                            </div>
                            <div class="col-3 mx-auto my-auto">
                                วันที่จอง
                                <input type="date" id="txt_search_date" class="form-control" value="" runat="server" />
                            </div>
                        </div>
                        <div class="col-2 mx-auto my-auto">
                            <button id="btn_search" class="btn btn-outline-primary" onserverclick="btn_search_ServerClick" runat="server">Search<i class="ti-search"></i></button>
                        </div>
                        <div class="card boxShadow col-10 mx-auto"></div>
                    </div>
                    <div class="col-12 mx-auto text-right">
                        <button id="btnExport" class="btn btn-outline-success" onclick="ExportFiles()">Export <i class="ti-files"></i></button>
                    </div>
                    <asp:ListView ID="LV_Report" runat="server">
                        <LayoutTemplate>
                            <div id="itemPlaceholder" runat="server">
                            </div>
                        </LayoutTemplate>
                        <ItemTemplate>
                            <div class="card boxShadow col-12 mx-auto my-1 textDeatil">
                                <div class="row col-12 mx-auto">
                                    <div class="col-2 mx-auto my-auto text-center" data-toggle="modal" data-target="#modalCancel" onclick="fn_bookid('<%# Eval("br_id") %>')" style="font-size:x-large; cursor: pointer;">
                                        <%# Eval("RowIndex") %>
                                    </div>
                                    <div class="row col-10 mx-auto my-auto">
                                        <div class="col-12 mx-auto" style="font-size:x-large;">
                                            เลขที่การจอง [ <%# Eval("br_id") %> ] 
                                            จองวันที่ <%# Eval("BookDate") %> เวลา <%# Eval("BookTime") %>
                                        </div>
                                        <div class="col-12 mx-auto">
                                            <%# Eval("RowHTML") %>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:ListView>
                    <div hidden="hidden">
                        <asp:GridView ID="GridView1" runat="server"></asp:GridView>
                    </div>
                </div>
                <asp:Label ID="lbl_Modal" Text="" runat="server"></asp:Label>
            </ContentTemplate>
        </asp:UpdatePanel>
        <div hidden="hidden">
            <asp:Button ID="btn_Export" CssClass="btn btn-outline-primary" runat="server" Text="Export To Excel" OnClick="btn_Export_Click" />
        </div>
    </div>

<!-- Modal Cancel -->
<div class="modal fade" id="modalCancel" tabindex="-1" role="dialog" aria-labelledby="modalCancelLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalCancelLabel">Cancel Booking.</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" style="font-size: x-large;">
          ต้องการยกเลิกการจองหมายเลข <asp:Label ID="lbl_bookid" Text="" runat="server"></asp:Label> ใช่หรือไม่ ?
          <div hidden="hidden">
              <input type="text" id="txtH_bookid" value="" runat="server" />
          </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
        <button type="button" id="btn_cancel" class="btn btn-primary" onserverclick="btn_cancel_ServerClick" runat="server">Yes</button>
      </div>
    </div>
  </div>
</div>

<script>
    function ExportFiles() {
        __doPostBack('<%= btn_Export.UniqueID %>', '');
    }

    function fn_bookid(id) {
        var lblid = document.getElementById('<%= lbl_bookid.ClientID %>');
        lblid.innerText = '[ ' + id + ' ]';
        var txtH = document.getElementById('<%= txtH_bookid.ClientID %>');
        txtH.value = id;
    }

    function ShowHide(name) {
        document.getElementById('div_dashboard').hidden = true;
        document.getElementById('div_list').hidden = true;

        var div = document.getElementById(name);
        if (div.hidden) {
            div.hidden = false;
            window.location.href = '#' + name;
        }
        else {
            div.hidden = true;
        }

        var MenuAdd = document.getElementById('div_Menu_Dashboard');
        var MenuList = document.getElementById('div_Menu_List');
        MenuAdd.removeAttribute('style');
        MenuList.removeAttribute('style');
        if (name == 'div_dashboard') {
            MenuAdd.setAttribute('style', 'color:cornflowerblue');
        }
        if (name == 'div_list') {
            MenuList.setAttribute('style', 'color:cornflowerblue');
        }
    }
</script>

</asp:Content>
