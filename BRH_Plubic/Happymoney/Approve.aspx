<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Approve.aspx.cs" Inherits="BRH_Plubic.Happymoney.Approve" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentDesktop" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="row col-12 mx-auto">
        <div class="row col-8 mx-auto">
            <div class="col-10 mx-auto">
                <input id="txt_search" value="" class="form-control" placeholder="Search" runat="server" />
            </div>
            <div class="col-2 mx-auto">
                <button id="btn_search" class="btn btn-outline-info" onserverclick="btn_search_ServerClick" runat="server"><i class="ti-search"></i></button>
            </div>
        </div>
        <div class="row col-4 mx-auto text-right">
            <asp:DropDownList ID="DD_status" CssClass="form-control" OnSelectedIndexChanged="DD_status_SelectedIndexChanged" AutoPostBack="true" runat="server">
                <asp:ListItem Text="" Value=""></asp:ListItem>
            </asp:DropDownList>
        </div>
    </div>

    <div class="col-12 mx-auto">
        <asp:ListView ID="LV_data" runat="server">
            <LayoutTemplate>
                <div class="card col-12 mx-auto bg-gradient-mix">
                    <div class="row col-12 mx-auto" style="font-size: x-large;">
                        <div class="col-1 mx-auto text-center">No.</div>
                        <div class="col-4 mx-auto text-center">Date</div>
                        <div class="col-4 mx-auto text-center">Name</div>
                        <div class="col-2 mx-auto text-center">Amount</div>
                        <div class="col-1 mx-auto text-center">Event</div>
                    </div>
                </div>
                <div id="itemPlaceholder" class="col-12 mx-auto" runat="server"></div>
            </LayoutTemplate>
            <ItemTemplate>
                <div class="row col-12 mx-auto my-1 bg-gradient-blue">
                    <div class="col-1 mx-auto my-auto text-center"><%# Container.DataItemIndex + 1 %></div>
                    <div class="row col-4 mx-auto my-auto">
                        <div class="col-12 mx-auto my-auto">วันที่ซื้อสลาก : <%# Eval("mo_date_th") %></div>
                        <div class="col-12 mx-auto my-auto">วันที่อัพโหลด : <%# Eval("mo_craetedate_th") %></div>
                    </div>
                    <div class="row col-4 mx-auto my-auto">
                        <div class="col-12 mx-auto my-auto">รหัสพนักงาน : <%# Eval("mo_empid") %></div>
                        <div class="col-12 mx-auto my-auto">ชื่อ : <%# Eval("emp_pnamefull_th") %></div>
                    </div>
                    <div class="col-2 mx-auto my-auto text-right"><%# Eval("mo_money") %> ฿</div>
                    <div class="col-1 mx-auto my-auto text-center">
                        <a <%# Eval("mo_hidden") %> class="btn btn-outline-info" onclick="fn_slip('<%# Eval("mo_id") %>','<%# Eval("mo_imageSlip") %>')" data-toggle="modal" data-target="#modalSlip" style="cursor: pointer;"><i class="ti-settings"></i></a>
                    </div>
                </div>
            </ItemTemplate>
        </asp:ListView>
    </div>

<!-- Modal -->
<div class="modal fade" id="modalSlip" tabindex="-1" role="dialog" aria-labelledby="modalSlipTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalSlipTitle">Event</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
          <div hidden="hidden">
              <input type="text" id="txtH_id" value="" runat="server" />
          </div>
          <div class="row col-12 mx-auto">
              <div class="col-12 mx-auto text-center">
                  <img src="image/icon/alllist.png" id="img_slip" class="img-fluid" />
              </div>
              <div class="col-12 mx-auto">
                  <textarea id="txt_comment" rows="3" class="form-control" placeholder="Comment" runat="server"></textarea>
              </div>
          </div>
      </div>
      <div class="modal-footer">
        <button id="btn_reject" type="button" class="btn btn-outline-danger" onserverclick="btn_reject_ServerClick" runat="server">Reject</button>
        <button id="btn_approve" type="button" class="btn btn-outline-primary" onserverclick="btn_approve_ServerClick" runat="server">Approve</button>
      </div>
    </div>
  </div>
</div>

<script>
    function fn_slip(id, type) {
        document.getElementById('<%= txtH_id.ClientID %>').value = id;
        document.getElementById('img_slip').setAttribute('src', '../Happymoney/image/slip/id' + id + ',savemoney.' + type);
    }
</script>

</asp:Content>
