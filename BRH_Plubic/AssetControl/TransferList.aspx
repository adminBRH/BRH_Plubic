<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TransferList.aspx.cs" Inherits="BRH_Plubic.AssetControl.TransferList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentDesktop" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<asp:ScriptManager ID="ScriptManagerTransferList" runat="server"></asp:ScriptManager>

    <script>    
        function fn_status(id, status, ft) {
            var html = '';
            if (status == 'transfer') {
                html = '<a class="btn btn-outline-primary" onclick="fn_action(\'' + ft + '\',\'' + id + '\')" style="cursor: pointer;"> Action </a>';
            } else {
                if (status == 'approve') {
                    html = '<a class="btn btn-success" style="color: #FFFFFF;"> ' + status + ' </a>';
                } else if (status == 'reject') {
                    html = '<a class="btn btn-danger" style="color: #FFFFFF;"> ' + status + ' </a>';
                } else {
                    html = '<a class="btn btn-outline-warning"> ' + status + ' </a>';
                }
            }
            document.write(html);
        }
    </script>

    <asp:UpdateProgress ID="prgLoadingStatus" runat="server" DynamicLayout="true">
        <ProgressTemplate>
            <div id="overlay" class="col-12 mx-auto my-auto text-center">
                <asp:Image ID="imgWaitIcon" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/images/BRHrayongLoading.gif" />
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>

    <div class="row col-12 mx-auto">
        <div class="col-6 mx-auto text-center">
            <asp:DropDownList ID="DD_date" CssClass="btn btn-outline-info" OnSelectedIndexChanged="DD_date_SelectedIndexChanged" AutoPostBack="true" runat="server">
                <asp:ListItem Text="" Value=""></asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="col-6 mx-auto text-center">

        </div>
        <asp:ListView ID="LV_Transfer" runat="server">
            <LayoutTemplate>
                <div class="col-12 mx-auto alert-primary text-center h3">
                    รายการโอนย้ายทรัพย์สิน
                </div>
                <div id="itemPlaceholder" runat="server"></div>
            </LayoutTemplate>
            <ItemTemplate>
                <div class="card col-12 mx-auto my-2">
                    <div class="row col-12 mx-auto">
                        <div class="col-1 mx-auto my-auto text-center">
                            <a class="btn btn-secondary" style="color: white;"><%# Eval("ast_id") %></a>
                        </div>
                        <div class="row col-3 mx-auto">
                            <div class="col-12 mx-auto alert-dark">
                                <%# Eval("ast_from_date") %>
                            </div>
                            <div class="col-12 mx-auto alert-info">
                                ผู้ร้องขอ : 
                                <%# Eval("emp_pname_th") %> <%# Eval("emp_fname_th") %> <%# Eval("emp_lname_th") %> 
                            </div>
                            <div class="col-12 mx-auto">
                                <%# Eval("ast_from_user_remark") %>
                            </div>
                        </div>
                        <div class="col-1 mx-auto my-auto text-center">
                            <a class="btn btn-outline-secondary" onclick="fn_details('<%# Eval("ast_id") %>','<%# Eval("ast_asdid_array") %>')" style="cursor: pointer;"> Details </a>
                        </div>
                        <div class="row col-7 mx-auto">
                            <div class="col-5 mx-auto alert-dark">
                                From : <%# Eval("deptFrom") %>
                            </div>
                            <div class="col-5 mx-auto alert-dark">
                                To : <%# Eval("deptTo") %>
                            </div>
                            <div class="row col-5 mx-auto alert-info">
                                <div class="col-10 mx-auto">
                                    <div class="col-12 mx-auto">
                                        ผู้อนุมัติ : 
                                        <%# Eval("from_hod_name_th") %> 
                                    </div>
                                    <div class="col-12 mx-auto">
                                        <%# Eval("ast_from_hod_remark") %>
                                    </div>
                                </div>
                                <div class="col-2 mx-auto my-auto">
                                    <script>fn_status('<%# Eval("ast_id") %>','<%# Eval("ast_from_action") %>', 'from');</script>
                                </div>
                            </div>
                            <div class="row col-5 mx-auto alert-info">
                                <div class="col-10 mx-auto">
                                    <div class="col-12 mx-auto">
                                        ผู้อนุมัติ : 
                                        <%# Eval("to_hod_name_th") %>
                                    </div>
                                    <div class="col-12 mx-auto">
                                        <%# Eval("ast_to_hod_remark") %>
                                    </div>
                                </div>
                                <div class="col-2 mx-auto my-auto">
                                    <script>fn_status('<%# Eval("ast_id") %>','<%# Eval("ast_to_action") %>', 'to');</script>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:ListView>

<div hidden="hidden">
    <input id="txtH_id" value="" runat="server" />
    <input id="txtH_details" value="" runat="server" />
    <input id="txtH_action" value="" runat="server" />
</div>

<div class="modal fade" id="modalAction" tabindex="-1" role="dialog" aria-labelledby="modalActionTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header bg-warning">
        <h5 class="modal-title" id="modalActionTitle">Action for <label id="lbl_action_name"></label> no<label class="btn btn-secondary" id="lbl_action_id" style="color: white; font-size: x-large;"></label></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
          <textarea id="txt_remark" class="form-control" rows="3" placeholder="หมายเหตุ" runat="server"></textarea>
      </div>
      <div class="modal-footer">
        <button type="button" id="btn_reject" class="btn btn-danger" onserverclick="btn_reject_ServerClick" runat="server" data-dismiss="modal" data-toggle="modal" data-target="#Modal_WaitLoad"> Reject </button>
        <button type="button" id="btn_approve" class="btn btn-success" onserverclick="btn_approve_ServerClick" runat="server" data-dismiss="modal" data-toggle="modal" data-target="#Modal_WaitLoad"> Approve </button>
      </div>
    </div>
  </div>
</div>
        
<div class="modal fade" id="modalDetails" tabindex="-1" role="dialog" aria-labelledby="modalDetailsTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <asp:UpdatePanel ID="UpdatePanelModalDetailss" runat="server">
          <ContentTemplate>
          <div class="modal-header bg-primary">
            <h5 class="modal-title" id="modalDetailsTitle">Details</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
              <div id="div_detais_id" runat="server">
                  คุณต้องการดูรายละเอียดการโอนย้าย หมายเลข <label class="btn btn-secondary" id="lbl_details_id" style="color: white; font-size: x-large;"></label> ใช่หรือไม่ ?
              </div>
              <div id="div_details_list" runat="server" hidden="hidden">
                  <asp:Label ID="lbl_details_list" Text="" runat="server"></asp:Label>
              </div>
          </div>
          <div class="modal-footer">
              <div id="div_details_btn" runat="server">
                  <button type="button" class="btn btn-outline-danger" data-dismiss="modal"> No </button>
                  <button type="button" id="btn_details" class="btn btn-outline-success" onserverclick="btn_details_ServerClick" runat="server"> Yes </button>
              </div>
          </div>
          </ContentTemplate>
      </asp:UpdatePanel>
    </div>
  </div>
</div>

        <script>
            function fn_setID(id) {
                var txtHid = document.getElementById('<%= txtH_id.ClientID %>');
                txtHid.value = id;
                document.getElementById('lbl_action_id').innerHTML = id;
                document.getElementById('lbl_details_id').innerHTML = id;
            }

            function fn_action(modal, id) {
                document.getElementById('<%= txtH_action.ClientID %>').value = modal;
                var lblActionName = document.getElementById('lbl_action_name');
                if (modal == 'from') {
                    lblActionName.innerHTML = 'Transfer';
                } else if (modal == 'to') {
                    lblActionName.innerHTML = 'Receive';
                } else {
                    lblActionName.innerHTML = '???';
                }
                fn_setID(id);
                $('#modalAction').modal('show');
            }

            function fn_details(id, detail) {
                var divID = document.getElementById('<%= div_detais_id.ClientID %>');
                divID.removeAttribute('hidden');
                var divList = document.getElementById('<%= div_details_list.ClientID %>');
                divList.setAttribute('hidden', 'hidden');
                var divDetailBtn = document.getElementById('<%= div_details_btn.ClientID %>');
                divDetailBtn.removeAttribute('hidden');
                var lbl = document.getElementById('<%= lbl_details_list.ClientID %>');
                lbl.innerHTML = '';

                fn_setID(id);

                var txtH = document.getElementById('<%= txtH_details.ClientID %>');
                txtH.value = detail;

                $('#modalDetails').modal('show');
            }
        </script>


    </div>

</asp:Content>
