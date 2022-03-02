<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RepairList.aspx.cs" Inherits="BRH_Plubic.AssetControl.RepairList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentDesktop" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="row col-12 mx-auto">
        <div class="row col-8 mx-auto">
            <div class="row col-12 mx-auto">
                <div class="col-8 mx-auto">
                    <input type="text" id="txt_id" value="" class="form-control" placeholder="Repair ID" runat="server" />
                </div>
                <div class="col-4 mx-auto">
                    <button id="btn_search" class="btn btn-outline-primary" onserverclick="btn_search_ServerClick" runat="server">Search</button>
                </div>
            </div>
        </div>
        <div class="col-4 mx-auto">
            <asp:DropDownList ID="dd_status" CssClass="col-12 mx-auto btn btn-outline-info" AutoPostBack="true" OnSelectedIndexChanged="dd_status_SelectedIndexChanged" runat="server">
                <asp:ListItem Text="" Value=""></asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="col-12 mx-auto mt-5">
            <asp:ListView ID="LV_Repair" runat="server">
                <LayoutTemplate>
                    <div class="col-12 mx-auto text-center h3">
                        Asset repair list.
                    </div>
                    <div id="itemPlaceholder" runat="server"></div>
                </LayoutTemplate>
                <ItemTemplate>
                    <div class="row col-12 mx-auto my-3" style="border: solid; border-color: blueviolet; border-radius: 20px;">
                        <div class="row col-2 mx-auto my-auto">
                            <div class="col-12 mx-auto text-center">Repair ID</div>
                            <div class="col-12 mx-auto text-center"><%# Eval("asr_id") %></div>
                            <div class="col-12 mx-auto text-center">Status</div>
                            <div class="col-12 mx-auto text-center"><%# Eval("asr_status") %></div>
                        </div>
                        <div class="row col-8 mx-auto my-auto">
                            <div class="col-5 mx-auto">Date: <%# Eval("asr_cdate") %></div>
                            <div class="col-7 mx-auto">Location: <%# Eval("ds_desc") %></div>
                            <div class="col-5 mx-auto">Asset Type: <%# Eval("ast_name") %></div>
                            <div class="col-7 mx-auto">Display name: <%# Eval("asr_displayname") %></div>
                            <div class="col-5 mx-auto">SN: <%# Eval("asr_sn") %></div>
                            <div class="col-7 mx-auto">Caetegory: <%# Eval("asc_name") %></div>
                            <div class="col-12 mx-auto">Create by: <%# Eval("emp_pname_th") %> <%# Eval("emp_pnamefull_th") %></div>
                        </div>
                        <div class="col-2 mx-auto my-auto text-center">
                            <div class="col-12 mx-auto my-2">
                                <input id="txtH_details_<%# Eval("asr_id") %>" value="<%# Eval("asr_desc") %>" hidden="hidden" />
                                <a class="btn btn-outline-info" onclick="fn_details('<%# Eval("asr_id") %>')" style="cursor: pointer;">
                                    Details <i class="fa fa-book"></i>
                                </a>
                            </div>
                            <div class="col-12 mx-auto my-2">
                                <a class="btn btn-warning" onclick="fn_action('<%# Eval("asr_id") %>','<%# Eval("asr_status") %>')" style="cursor: pointer;">
                                    <%# Eval("asr_action") %> <i class="fa fa-pencil"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:ListView>
        </div>
    </div>

    <div hidden="hidden">
        <input type="text" id="txtH_ID" value="" runat="server" />
        <a id="btn_action" onserverclick="btn_action_ServerClick" runat="server"></a>
    </div>

    <!-- Modal -->
<div class="modal fade" id="modalDetails" tabindex="-1" role="dialog" aria-labelledby="modalDetailsTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalDetailsTitle">Repair details.</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
          <textarea id="txt_details" class="form-control" disabled="disabled" rows="5"></textarea>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<script>
    function fn_details(id) {
        var desc = document.getElementById('txtH_details_' + id);
        var txtDetails = document.getElementById('txt_details');
        txtDetails.innerText = desc.value;
        $('#modalDetails').modal('show');
    }

    function fn_action(id, status) {
        var txtHID = document.getElementById('<%= txtH_ID.ClientID %>');
        txtHID.value = id;
        if (status != 'Finish') {
            __doPostBack('<%= btn_action.UniqueID %>', '');
        }
    }
</script>

</asp:Content>
