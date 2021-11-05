<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Asset.aspx.cs" Inherits="BRH_Plubic.AssetControl.Asset" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentDesktop" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<style>
    .topicColor{
        color: brown;
    }
</style>

<asp:ScriptManager ID="ScriptManager_Master" runat="server"></asp:ScriptManager>
     <link rel="stylesheet" href="css/PostCard.css">

    <div class="col-12 mx-auto">
        <div class="row col-12 mx-auto my-2">
            <div class="row col-6 mx-auto">
                <div class="col-8 mx-auto">
                    <input type="text" id="txt_search_location" value="" class="form-control" placeholder="Search by Location" data-toggle="tooltip" data-placement="top" title="Location or Department" runat="server" />
                </div>
                <div class="col-4 mx-auto text-left">
                    <a id="btn_search_location" class="btn btn-outline-info" style="cursor: pointer;" onserverclick="btn_search_location_ServerClick" runat="server"><i class="ti-search"></i></a>
                </div>
            </div>
            <div class="row col-6 mx-auto">
                <div class="col-8 mx-auto">
                    <input type="text" id="txt_search_code" value="" class="form-control" placeholder="Search by Code" data-toggle="tooltip" data-placement="top" title="SN or GLS barcode" runat="server" />
                </div>
                <div class="col-4 mx-auto text-left">
                    <a id="btn_search_code" class="btn btn-outline-info" style="cursor: pointer;" onserverclick="btn_search_code_ServerClick" runat="server"><i class="ti-search"></i></a>
                </div>
            </div>
        </div>
        <!-- ======================================================= Add ======================================================= -->
        <asp:UpdatePanel ID="UpdatePanel_Add" runat="server">
            <ContentTemplate>
                <div class="col-12 mx-auto text-right">
                    <button id="btn_div_add" class="btn btn-outline-warning" onserverclick="btn_div_add_ServerClick" runat="server"><i id="ti_div_add" class="ti-plus" runat="server"></i> New</button>
                </div>
                <div id="div_add" class="row col-12 mx-auto my-2" runat="server" visible="false">
                    <div id="Accessories" class="col-12 mx-auto text-center" style="font-size: xx-large;">
                        เพิ่มทรัพย์สินเข้าสู่ระบบ
                    </div>
                    <div class="col-lg-3 col-sm-6 my-2 mx-auto">
                        <asp:DropDownList ID="DD_branch" CssClass="form-control" OnSelectedIndexChanged="DD_branch_SelectedIndexChanged" AutoPostBack="true" runat="server">
                            <asp:ListItem Text="" Value=""></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-lg-3 col-sm-6 my-2 mx-auto">
                        <asp:DropDownList ID="DD_department" CssClass="form-control" OnSelectedIndexChanged="DD_department_SelectedIndexChanged" AutoPostBack="true" runat="server">
                            <asp:ListItem Text="" Value=""></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-lg-3 col-sm-6 my-2 mx-auto">
                        <asp:DropDownList ID="DD_cate" CssClass="form-control" OnSelectedIndexChanged="DD_cate_SelectedIndexChanged" AutoPostBack="true" runat="server">
                            <asp:ListItem Text="" Value=""></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-lg-3 col-sm-6 my-2 mx-auto">
                        <asp:DropDownList ID="DD_typeAsset" CssClass="form-control" OnSelectedIndexChanged="DD_typeAsset_SelectedIndexChanged" AutoPostBack="true" runat="server">
                            <asp:ListItem Text="" Value=""></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div id="div_add_Code" class="row col-12 mx-auto" runat="server" visible="false">
                        <div class="col-lg-3 col-sm-6 mx-auto my-2">
                            <input type="text" id="txt_add_name" value="" class="form-control" placeholder="Display Name" runat="server" />
                        </div>
                        <div class="col-lg-3 col-sm-6 mx-auto my-2">
                            <input type="text" id="txt_add_SN" value="" class="form-control" placeholder="S/N" runat="server" />
                        </div>
                        <div class="col-lg-3 col-sm-6 mx-auto my-2">
                            <input type="text" id="txt_add_GLS" value="" class="form-control" placeholder="GLS barcode" runat="server" />
                        </div>
                        <div class="col-lg-3 col-sm-6 mx-auto my-2">
                            <input type="text" id="txt_add_NHealth" value="" class="form-control" placeholder="NHealth barcode" runat="server" />
                        </div>
                        <div class="col-lg-3 col-sm-6 mx-auto my-2">
                            <input type="text" id="txt_add_comname" value="" class="form-control" placeholder="Computer Name" runat="server" />
                        </div>
                        <div class="col-lg-3 col-sm-6 mx-auto my-2">
                            <input type="text" id="txt_asr" value="" class="form-control" placeholder="Accessories of Asset(S/N)" onblur="fn_Accessories()" runat="server" />
                            <asp:Label ID="lbl_asr_alert" Text="" runat="server"></asp:Label>
                            <input id="txt_asr_clone" value="" runat="server" hidden="hidden" />
                            <a id="btn_asr" onserverclick="btn_asr_ServerClick" runat="server" hidden="hidden"></a>
                        </div>
                        <div class="col-lg-3 col-sm-6 mx-auto my-2">
                            <input type="text" id="txt_add_mac" value="" class="form-control" placeholder="MAC Address" runat="server" />
                        </div>
                        <div class="col-lg-3 col-sm-6 mx-auto my-2">
                            <input type="text" id="txt_add_ip" value="" class="form-control" placeholder="IP Address" runat="server" />
                        </div>
                        <div class="row col-lg-3 col-sm-3 mx-auto my-2">
                            <div class="col-lg-6 col-sm-12 mx-auto my-auto text-right">
                                Camera : 
                            </div>
                            <div class="col-lg-6 col-sm-12 mx-auto my-auto">
                                <asp:DropDownList ID="DD_camera" CssClass="form-control" runat="server">
                                    <asp:ListItem Text="ไม่มี" Value="no" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="มี" Value="yes"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="row col-lg-3 col-sm-3 mx-auto my-2">
                            <div class="col-lg-6 col-sm-12 mx-auto my-auto text-right">
                                Card reader : 
                            </div>
                            <div class="col-lg-6 col-sm-12 mx-auto my-auto">
                                <asp:DropDownList ID="DD_cardreader" CssClass="form-control" runat="server">
                                    <asp:ListItem Text="ไม่มี" Value="no" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="มี" Value="yes"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <%--<div class="row col-lg-6 col-sm-6 mx-auto my-2">
                            <textarea id="txt_program" rows="5" class="form-control" placeholder="Program Office." runat="server"></textarea>
                        </div>--%>
                        <div class="col-lg-6 col-sm-12 mx-auto my-2">
                            <textarea id="txt_desc" rows="5" class="form-control" placeholder="Other Description." runat="server"></textarea>
                        </div>
                        <div class="col-12 mx-auto text-center">
                            <div class="col-12 mx-auto text-center">
                                <asp:Label ID="lbl_add_alert" Text="" runat="server"></asp:Label>
                            </div>
                            <a class="btn" style="cursor:pointer; background-color:Highlight; border-radius: 10px; color: white;" onclick="fn_add()"><i class="ti-save-alt"></i> Save</a>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>

        <div hidden="hidden">
            <button id="btn_add" class="btn btn-outline-primary" onserverclick="btn_add_ServerClick" runat="server"></button>
        </div>

<script>
    function fn_Accessories() {
        var sn = document.getElementById('<%= txt_asr.ClientID %>');
        document.getElementById('<%= lbl_asr_alert.ClientID %>').innerHTML = '';
        if (sn.value != '') {
            window.location.href = '#Accessories';
            __doPostBack('<%= btn_asr.UniqueID %>', '');
        }
    }

    function fn_ti(n,c) {
        c = c + 1;
        for (i = 1; i <= c; i++) {
            var ti = document.getElementById('ti_' + i);
            if (n == i) {
                ti.setAttribute('class','ti-check');
            } else {
                ti.setAttribute('class', 'ti-control-stop');
            }
        }
    }

    function fn_fn_select_asr(n) {
        document.getElementById('<%= txt_asr.ClientID %>').value = document.getElementById('ti_' + n);
        document.getElementById('<%= lbl_asr_alert.ClientID %>').innerHTML = '';
    }

    function fn_add() {
        __doPostBack('<%= btn_add.UniqueID %>', '');
    }

    function fn_ShowAccess(index, asr) {
        if (asr == '') {
            document.getElementById('div_accessories_' + index).removeAttribute('hidden');
        }
    }
</script>
        <!-- ======================================================= Detail ======================================================= -->
        <div id="div_detail" class="row col-12 mx-auto my-5" runat="server" >
            <div class="row col-5 mx-auto text-left">
                <div class="col-6 mx-auto">
                    <asp:DropDownList ID="dd_limit" CssClass="btn btn-dark" OnSelectedIndexChanged="dd_limit_SelectedIndexChanged" AutoPostBack="true" runat="server">
                        <asp:ListItem Text="10 item" Value="10"></asp:ListItem>
                        <asp:ListItem Text="20 item" Value="20"></asp:ListItem>
                        <asp:ListItem Text="50 item" Value="50" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="100 item" Value="100"></asp:ListItem>
                        <asp:ListItem Text="500 item" Value="500"></asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            <div class="col-7 mx-auto my-auto text-left" style="color: coral">
                <asp:Label ID="lbl_search_alert" Text="" runat="server"></asp:Label>
            </div>
            <div class="col-12 mx-auto">
                <asp:ListView ID="LV_Asset" runat="server">
                    <LayoutTemplate>
                        <div class="col-12 mx-auto text-center h3">
                            รายการทรัพย์สิน 
                        </div>
                        <div class="row col-12 mx-auto">
                            <div id="itemPlaceholder" runat="server"></div>
                        </div>
                    </LayoutTemplate>
                    <ItemTemplate>

                        <div class="col-lg-4 col-sm-6 mx-auto my-2">
                            <div class="PostCard">
                                <div class="PostCard-time">
                                    Update: <%# Eval("asd_timeago") %>
                                </div>
                                <div class="PostCard-logo text-center">
                                    <img src="images/<%# Eval("ast_logo") %>" class="PostCard-logo-img" data-toggle="tooltip" data-placement="top" title="<%# Eval("ast_name") %>" />
                                </div>
                                <div class="PostCard-name">
                                    <%# Eval("asd_displayname") %>
                                </div>
                                <div class="PostCard-body">
                                    <p><i class="fa fa-map-marker" data-toggle="tooltip" data-placement="top" title="Location" style="color: lightseagreen;"></i> <%# Eval("ds_desc") %></p>
                                    <p>Come name: <span class="badge badge-dark" style="font-size: large"><%# Eval("asd_comname") %></span></p>
                                    <p onclick="fn_getSN('<%# Eval("asd_sn") %>')">
                                        SN: <span class="badge badge-dark" style="font-size: large"><%# Eval("asd_sn") %></span>
                                        <span class="badge badge-primary" data-toggle="tooltip" data-placement="top" title="Click for link Accessories" style="cursor: pointer;">
                                            <i class="fa fa-link"></i>
                                        </span>
                                    </p>
                                    <p>GLS barcode: <span class="badge badge-dark" style="font-size: large"><%# Eval("asd_gls_barcode") %></span></p>
                                </div>
                                <div class="col-10 mx-auto PostCard-desc">
                                    <textarea id="txt_desc_<%# Container.DataItemIndex %>" disabled="disabled" class="form-control"><%# Eval("asd_desc") %></textarea>
                                </div>
                                <div class="PostCard-button text-left">
                                    <span data-toggle="tooltip" data-placement="top" title="IP Config">
                                        <i class="fa fa-wifi my-3" data-toggle="popover" data-html="true" title="IP Config." data-content="<b>MAC:</b> <%# Eval("asd_mac") %><br /><b>IP:</b> <%# Eval("asd_ip") %>" style="cursor: pointer;"></i>
                                    </span>
                                    <script>
                                        function fn_RepairIcon(status, asid) {
                                            var cl = 'fa fa-spin fa-spinner my-3';
                                            var i_ar = document.getElementById('i_ar_' + asid);
                                            if (status == 'Finish' || status == '') {
                                                cl = 'fa fa-wrench my-3';
                                                i_ar.setAttribute('data-toggle','modal');
                                                i_ar.setAttribute('data-target','#modal_repair');
                                            } else {
                                                i_ar.removeAttribute('data-toggle');
                                                i_ar.removeAttribute('data-target');
                                                i_ar.setAttribute('onclick', 'fn_repairlist(\'<%# Eval("asr_id") %>\')');
                                            }
                                            i_ar.setAttribute('class',cl);
                                        }

                                        function fn_repairlist(id) {
                                            location.href = 'RepairList?id=' + id;
                                        }
                                    </script>
                                    <i id="i_ar_<%# Eval("asd_id") %>" data-toggle="modal" data-target="#modal_repair" title="แจ้งซ่อม" style="cursor: pointer;" onclick="fn_repair('<%# Eval("asd_displayname") %>','<%# Eval("ast_name") %>','<%# Eval("ds_desc") %>','<%# Eval("asd_sn") %>','<%# Eval("asr_status") %>','<%# Eval("asr_id") %>')"></i>
                                </div>
                                <script>
                                    fn_RepairIcon('<%# Eval("asr_status") %>', '<%# Eval("asd_id") %>');
                                </script>
                                <div class="PostCard-footer">
                                    <a data-toggle="modal" data-target="#modalPerformance" onclick="fn_adjPerformance('<%# Eval("asd_id") %>','<%# Eval("asd_branch") %>&<%# Eval("asd_cate") %>&<%# Eval("asd_type") %>')"><img src="images/Performance/add_icon.png" data-toggle="tooltip" data-placement="top" title="Adjust performance" style="cursor: pointer;" /></a>
                                    <%# Eval("asd_performance") %>
                                </div>
                                <div id="div_accessories_<%# Container.DataItemIndex %>" class="PostCard-Accessories" hidden="hidden">
                                    <i class="fa fa-object-ungroup" onclick="fn_setSearch('code','<%# Eval("asd_sn") %>')" data-toggle="tooltip" data-placement="top" title="View Accessories"></i>
                                </div>
                                <script>
                                    fn_ShowAccess('<%# Container.DataItemIndex %>','<%# Eval("asd_asr_id") %>');
                                </script>
                                <div class="PostCard-edit" data-toggle="tooltip" data-placement="top" title="Edit asset">
                                    <i class="fa fa-gears" 
                                        onclick="fn_setDataEdit(
                                        '<%# Container.DataItemIndex %>',
                                        '<%# Eval("asd_id") %>',
                                        '<%# Eval("ds_desc") %>',
                                        '<%# Eval("ds_id") %>',
                                        '<%# Eval("ast_name") %>',
                                        '<%# Eval("asd_displayname") %>',
                                        '<%# Eval("asd_comname") %>',
                                        '<%# Eval("asd_sn") %>',
                                        '<%# Eval("asd_asr_id") %>',
                                        '<%# Eval("asd_gls_barcode") %>',
                                        '<%# Eval("asd_nhealth_barcode") %>',
                                        '<%# Eval("asd_mac") %>',
                                        '<%# Eval("asd_ip") %>'
                                        )"
                                        data-toggle="modal" data-target="#modalEdit"
                                        style="cursor: pointer;">
                                    </i>
                                </div>
                            </div>
                        </div>

                    </ItemTemplate>
                </asp:ListView>
            </div>
        </div>
    </div>

<a id="btn_accessories" onserverclick="btn_accessories_ServerClick" runat="server" hidden="hidden"> </a>
<script>
    function fn_setSearch(type, search) {
        var code = document.getElementById('<%= txt_search_code.ClientID %>');
        var location = document.getElementById('<%= txt_search_location.ClientID %>');
        var next = 'n';
        if (type == 'code') {
            code.value = search;
            location.value = '';
            next = 'y';
        } else if (type == 'location') {
            code.value = '';
            location.value = search;
            next = 'y';
        } else { }
        if (next == 'y') {
            __doPostBack('<%= btn_accessories.UniqueID %>', '');
        }
    }

    function fn_getSN(sn) {
        document.getElementById('<%= txt_asr.ClientID %>').value = sn;
        fn_Accessories();
    }
</script>

<!-- Modal repair -->
<div class="modal fade" id="modal_repair" tabindex="-1" role="dialog" aria-labelledby="modal_repairTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modal_repairTitle">แจ้งซ่อม</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
          <div class="row col-12 mx-auto">
              <div class="col-12 mx-auto">
                  <asp:Label id="lbl_repair_display" Text="" runat="server"></asp:Label>
              </div>
              <div class="col-12 mx-auto">
                  <asp:Label id="lbl_repair_machine" Text="" runat="server"></asp:Label>
              </div>
              <div class="col-12 mx-auto">
                  <asp:Label id="lbl_repair_location" Text="" runat="server"></asp:Label>
              </div>
              <div class="col-12 mx-auto">
                  <asp:Label id="lbl_repair_SN" Text="" runat="server"></asp:Label>
              </div>
              <textarea id="txt_repair_detail" class="form-control" rows="3" placeholder="รายละเอียด" runat="server"></textarea>
              <div class="col-12 mx-auto">
                  <asp:Label ID="lbl_repair_user" Text="" runat="server"></asp:Label>
              </div>
          </div>
          <div hidden="hidden">
              <input type="text" id="txtH_display" value="" runat="server" />
              <input type="text" id="txtH_machine" value="" runat="server" />
              <input type="text" id="txtH_location" value="" runat="server" />
              <input type="text" id="txtH_SN" value="" runat="server" />
          </div>
      </div>
      <div class="modal-footer">
        <button type="button" id="btn_repair_submit" class="btn btn-outline-primary" onserverclick="btn_repair_submit_ServerClick" runat="server">ส่งซ่อม</button>
      </div>
    </div>
  </div>
</div>

<script>
    function fn_repair(displayname, Name, location, sn, RepairStatus, RepairID) {
        if (RepairStatus == '' || RepairStatus == 'Finish') {
            var lblDisplay = document.getElementById('<%= lbl_repair_display.ClientID %>');
            var lblMachine = document.getElementById('<%= lbl_repair_machine.ClientID %>');
            var lblLocation = document.getElementById('<%= lbl_repair_location.ClientID %>');
            var lblSN = document.getElementById('<%= lbl_repair_SN.ClientID %>');

            var txtHDisplay = document.getElementById('<%= txtH_display.ClientID %>');
            var txtHMachine = document.getElementById('<%= txtH_machine.ClientID %>');
            var txtHLocation = document.getElementById('<%= txtH_location.ClientID %>');
            var txtHSN = document.getElementById('<%= txtH_SN.ClientID %>');

            txtHDisplay.value = displayname;
            txtHMachine.value = Name;
            txtHLocation.value = location;
            txtHSN.value = sn;

            lblDisplay.innerHTML = displayname;
            lblMachine.innerHTML = 'ประเภท : ' + Name;
            lblLocation.innerHTML = 'แผนก : ' + location;
            lblSN.innerHTML = 'SN : ' + sn;
        } else {
            var http = window.location.protocol;
            var domain = window.location.host;
            var pathname = '/AssetControl'; //window.location.pathname;
            window.location.href = http + '//' + domain + pathname + '/RepairList?id=' + RepairID;
        }
    }
</script>

<!-- Modal Performance -->
<div class="modal fade" id="modalPerformance" tabindex="-1" role="dialog" aria-labelledby="modalPerformanceTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header" style="background-color: mediumpurple;">
                <h3 class="modal-title" id="modalPerformanceTitle" style="font-weight: bold; color: white; text-shadow: 2px 2px 2px #000000;">Adjust Performance</h3>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="col-12 mx-auto">
                    <asp:UpdatePanel ID="UpdatePanel_adjPerformance" runat="server">
                        <ContentTemplate>
                            <asp:ListView ID="LV_adj_perf" runat="server">
                                <LayoutTemplate>
                                    <div id="itemPlaceholder" runat="server"></div>
                                </LayoutTemplate>
                                <ItemTemplate>
                                    <div class="row col-12 mx-auto">
                                        <div class="col-1 mx-auto my-auto text-center">
                                            <a onclick="fn_adjPerf_del('<%# Eval("asdp_id") %>')" style="cursor: pointer;">
                                                <i class="fa fa-times-circle-o iButton" data-toggle="tooltip" data-placement="top" title="Delete" style="color: red;"></i>
                                            </a>
                                        </div>
                                        <div class="col-11 mx-auto">
                                            <img src="images/<%# Eval("asp_image") %>" style="width: 60px; height: 60px;" /> 
                                            <span class="badge badge-dark" style="font-size: x-large;"><%# Eval("asp_name") %></span> <span class="badge badge-secondary" style="font-size: large;"><%# Eval("asdp_details") %></span>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:ListView>
                            <div hidden="hidden">
                                <input type="text" id="txtH_adjPerf_id" value="" runat="server" />
                                <input type="text" id="txtH_adjPerf_BCT" value="" runat="server" />
                                <a id="btn_adjPerf" runat="server" onserverclick="btn_adjPerf_ServerClick"></a>
                                <input type="text" id="txtH_adjPerf_pid" value="" runat="server" />
                                <a id="btn_adjPerf_del" runat="server" onserverclick="btn_adjPerf_del_ServerClick"></a>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
            <div class="modal-footer">
                <div class="col-12 mx-auto">
                    <asp:UpdatePanel ID="UpdatePanel_adjPerformance_footer" runat="server">
                        <ContentTemplate>
                            <div class="row col-12 mx-auto">
                                <div id="div_adjPerf_alert" class="alert alert-danger" runat="server" visible="false">
                                    <asp:Label ID="lbl_adjPerf_alert" Text="" runat="server"></asp:Label>
                                </div>
                                <div class="col-5 mx-auto">
                                    Select Performance
                                    <asp:DropDownList ID="dd_adjPerformance" CssClass="btn btn-dark form-control" runat="server">
                                        <asp:ListItem Text="" Value=""></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-5 mx-auto">
                                    <input type="text" id="txt_adjPerf_details" value="" class="form-control" placeholder="Details" runat="server" style="position: absolute; bottom: 0; right: 2px;" />
                                </div>
                                <div class="col-2 mx-auto">
                                    <a id="btn_adjPerf_add" class="btn btn-warning" onserverclick="btn_adjPerf_add_ServerClick" runat="server" style="cursor: pointer; position: absolute; bottom: 0;">
                                        <i class="fa fa-plus-circle fa-spin"></i> Add
                                    </a>
                                </div>
                            </div>
                            <div class="col-12 mx-auto mt-5 text-right">
                                <a id="btn_reload" class="badge badge-info my-auto" onclick="location.reload();" style="cursor: pointer; font-size: large;">
                                    Update data <i class="fa fa-refresh fa-2x fa-spin my-auto" style="color:deepskyblue; text-shadow: 2px 2px 2px #000000;"></i> click
                                </a>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function fn_adjPerformance(id,bct) {
        document.getElementById('<%= txtH_adjPerf_id.ClientID %>').value = id;
        document.getElementById('<%= txtH_adjPerf_BCT.ClientID %>').value = bct;
        __doPostBack('<%= btn_adjPerf.UniqueID %>', '');
    }

    function fn_adjPerf_del(id) {
        document.getElementById('<%= txtH_adjPerf_pid.ClientID %>').value = id;
        __doPostBack('<%= btn_adjPerf_del.UniqueID %>', '');
    }
    
</script>

<!-- Modal Edit asset -->
<div class="modal fade" id="modalEdit" tabindex="-1" role="dialog" aria-labelledby="modalEditTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
        <div class="modal-content">
            <div class="modal-header" style="background-color: mediumpurple;">
                <h3 class="modal-title" id="modalEditTitle" style="font-weight: bold; color: white; text-shadow: 2px 2px 2px #000000;">Edit Asset</h3>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="row col-12 mx-auto">
                    <div hidden="hidden">
                        <input type="text" id="txtH_asdID" value="" runat="server" />
                    </div>
                    <div class="col-lg-6 col-sm-12 mx-auto my-2">
                        <span class="badge badge-secondary fontBadge">Location</span>
                        <input type="text" id="txt_edit_location_name" value="" runat="server" disabled="disabled" />
                        <input type="text" id="txt_edit_location" value="" runat="server" hidden="hidden" />
                    </div>
                    <div class="col-lg-6 col-sm-12 mx-auto my-2">
                        <span class="badge badge-secondary fontBadge">Asset type</span>
                        <input type="text" id="txt_edit_type" value="" runat="server" disabled="disabled" />
                    </div><div class="col-lg-6 col-sm-12 mx-auto my-2">
                        <span class="badge badge-info fontBadge">Come name</span>
                        <input type="text" id="txt_edit_comname" value="" class="input-edit" runat="server" />
                    </div>
                    <div class="col-lg-6 col-sm-12 mx-auto my-2">
                        <span class="badge badge-info fontBadge">Display name</span>
                        <input type="text" id="txt_edit_displayname" value="" class="input-edit" runat="server" />
                    </div>
                    <div class="col-lg-6 col-sm-12 mx-auto my-2">
                        <span class="badge badge-info fontBadge">SN</span>
                        <input type="text" id="txt_edit_sn" value="" class="input-edit" runat="server" />
                    </div>
                    <div class="col-lg-6 col-sm-12 mx-auto my-2">
                        <span class="badge badge-info fontBadge">Accessories of(SN)</span>
                        <input type="text" id="txt_edit_asr" value="" class="input-edit" runat="server" />
                    </div>
                    <div class="col-lg-6 col-sm-12 mx-auto my-2">
                        <span class="badge badge-info fontBadge">GLS barcode</span>
                        <input type="text" id="txt_edit_gls" value="" class="input-edit" runat="server" />
                    </div>
                    <div class="col-lg-6 col-sm-12 mx-auto my-2">
                        <span class="badge badge-info fontBadge">NHealth barcode</span>
                        <input type="text" id="txt_edit_nhealth" value="" class="input-edit" runat="server" />
                    </div>
                    <div class="col-lg-6 col-sm-12 mx-auto my-2">
                        <span class="badge badge-info fontBadge">MAC address</span>
                        <input type="text" id="txt_edit_mac" value="" class="input-edit" runat="server" />
                    </div>
                    <div class="col-lg-6 col-sm-12 mx-auto my-2">
                        <span class="badge badge-info fontBadge">IP address</span>
                        <input type="text" id="txt_edit_ip" value="" class="input-edit" runat="server" />
                    </div>
                    <div class="col-12 mx-auto my-2">
                        <span class="badge badge-info fontBadge" style="margin-top: 0;">Other Description</span>
                        <textarea id="txt_edit_desc" rows="3" class="form-control" runat="server" />
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" id="btn_edit" class="btn btn-warning" onserverclick="btn_edit_ServerClick" runat="server" style="color: white; font-size: large; font-weight: bold; text-shadow: 2px 2px 2px #808080">
                    Save <i class="fa fa-save"></i>
                </button>
            </div>
        </div>
    </div>
</div>

<script>
    function fn_setDataEdit(index ,id, loname, lo, type, display, comname, sn, asr, gls, nhealth, mac, ip) {
        var asdID = document.getElementById('<%= txtH_asdID.ClientID %>');
        var txtLocationName = document.getElementById('<%= txt_edit_location_name.ClientID %>');
        var txtLocation = document.getElementById('<%= txt_edit_location.ClientID %>');
        var txtType = document.getElementById('<%= txt_edit_type.ClientID %>');
        var txtDisplayname = document.getElementById('<%= txt_edit_displayname.ClientID %>');
        var txtComname = document.getElementById('<%= txt_edit_comname.ClientID %>');
        var txtSN = document.getElementById('<%= txt_edit_sn.ClientID %>');
        var txtASR = document.getElementById('<%= txt_edit_asr.ClientID %>');
        var txtGLS = document.getElementById('<%= txt_edit_gls.ClientID %>');
        var txtNHealth = document.getElementById('<%= txt_edit_nhealth.ClientID %>');
        var txtMac = document.getElementById('<%= txt_edit_mac.ClientID %>');
        var txtIP = document.getElementById('<%= txt_edit_ip.ClientID %>');
        var txtDesc = document.getElementById('<%= txt_edit_desc.ClientID %>');
        asdID.value = id;
        txtLocationName.value = loname;
        txtLocation.value = lo;
        txtType.value = type;
        txtDisplayname.value = display;
        txtComname.value = comname;
        txtSN.value = sn;
        txtASR.value = asr;
        txtGLS.value = gls;
        txtNHealth.value = nhealth;
        txtMac.value = mac;
        txtIP.value = ip;
        txtDesc.value = document.getElementById('txt_desc_' + index).value;
    }
</script>

</asp:Content>
