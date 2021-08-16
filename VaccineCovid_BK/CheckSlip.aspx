<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CheckSlip.aspx.cs" Inherits="BRH_Plubic.VaccineCovid.CheckSlip" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentDesktop" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<asp:ScriptManager ID="ScriptManager_Master" runat="server"></asp:ScriptManager>

    <div class="row col-12 mx-auto">
        <div class="col-9 mx-auto my-3">
            <div id="div_alert"  >
                <asp:Label ID="lbl_alert" Text="" runat="server"></asp:Label>
            </div>
            <script>
                function fn_InOutAlert(status, text) {
                    var div = document.getElementById('div_alert');
                    var lbl = document.getElementById('<%= lbl_alert.ClientID %>');
                    lbl.innerHTML = text;
                    if (status == 'Success') {
                        div.setAttribute('class', 'alert alert-success');
                    } else if (status == 'Warnning') {
                        div.setAttribute('class', 'alert alert-danger');
                    }
                    $("#div_alert").fadeIn();
                    $("#div_alert").fadeOut(5000);
                }
            </script>
        </div>
        <div class="col-3 mx-auto my-3">
            <span style="font-size: large; text-shadow: 2px 2px 2px chocolate;">Status</span>
            <asp:DropDownList ID="dd_status" CssClass="mx-auto my-auto form-control" OnSelectedIndexChanged="dd_status_SelectedIndexChanged" AutoPostBack="true" runat="server">
                <asp:ListItem Text="" Value=""></asp:ListItem>
            </asp:DropDownList>
        </div>
        <asp:ListView ID="LV_table" runat="server">
            <LayoutTemplate>
                <table class="table">
                    <thead class="thead-dark">
                        <tr>
                            <th class="mx-auto" scope="col">#</th>
                            <th class="mx-auto text-center" scope="col">Date Time</th>
                            <th class="mx-auto text-center" scope="col">Bank</th>
                            <th class="mx-auto text-center" scope="col">Amount</th>
                            <th class="mx-auto text-center" scope="col">Details</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr id="itemPlaceholder" runat="server"></tr>
                    </tbody>
                </table>
            </LayoutTemplate>
            <ItemTemplate>
                <tr>
                    <th scope="row"><%# Container.DataItemIndex + 1 %></th>
                    <td class="mx-auto my-auto text-center"><%# String.Format("{0:yyyy-MM-dd HH:mm}", Eval("pv_slip_time")) %></td>
                    <td class="mx-auto my-auto text-center"><%# Eval("pv_bank") %><br /><%# Eval("pv_account") %></td>
                    <td class="mx-auto my-auto text-right"><%# String.Format("{0:#,##0.##}", Eval("pv_slip_pay")) %></td>
                    <td class="mx-auto my-auto text-center">
                        <i class=" ti-2x ti-receipt" onclick="fn_details('<%# Eval("pv_id") %>')" data-toggle="modal" data-target="#ModalDetail" style="cursor: pointer; color: chocolate"></i>
                    </td>
                </tr>
            </ItemTemplate>
        </asp:ListView>
        <div hidden="hidden">
            <input type="text" id="txtH_id" value="" runat="server" />
            <button id="btn_details" runat="server" onserverclick="btn_details_ServerClick"></button>
        </div>
    </div>

<!-- Modal Detail -->
<div class="modal fade" id="ModalDetail" tabindex="-1" role="dialog" aria-labelledby="ModalDetailTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
    <div class="modal-content">
      <div class="modal-header bg-info">
        <h5 class="modal-title fontTopic" id="ModalDetailTitle" style="color: white;">Details</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
            <asp:UpdatePanel ID="UpdatePanel_img" runat="server">
                <ContentTemplate>
                    <div class="row col-12 mx-auto">
                        <div id="div_reject" class="col-lg-3 col-sm-2 mx-auto my-auto text-center" runat="server" visible="false">
                            <a class="btn btn-outline-danger" data-toggle="modal" data-target="#modalReject" data-dismiss="modal" style="cursor: pointer;">Reject</a>
                        </div>
                        <div class="col-lg-5 col-sm-8 mx-auto my-auto text-center">
                            <img id="img_slip" src="..." style="width: 100%;" runat="server" />
                        </div>
                        <div id="div_confirm" class="col-lg-3 col-sm-2 mx-auto my-auto text-center" runat="server" visible="false">
                            <button id="btn_confirm" class="btn btn-outline-primary" runat="server" onserverclick="btn_confirm_ServerClick">Confirm</button>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
          <div class="col-12 mx-auto">
              <asp:UpdatePanel ID="UpdatePanel_detail" runat="server">
                  <ContentTemplate>
                        <asp:ListView ID="LV_details" runat="server">
                            <LayoutTemplate>
                                <div class="row col-12 mx-auto bg-dark" style="color: yellow;">
                                    <div class="col-1 mx-auto text-center">ลำดับ</div>
                                    <div class="col-3 mx-auto text-center">ชื่อ-นามสกุล</div>
                                    <div class="col-2 mx-auto text-center">จำนวน</div>
                                    <div class="col-3 mx-auto text-center">ราคา</div>
                                    <div class="col-3 mx-auto text-center">รวม</div>
                                </div>
                                <div id="itemPlaceholder" class="col-12 mx-auto" runat="server"></div>
                            </LayoutTemplate>
                            <ItemTemplate>
                                <div class="row col-12 mx-auto">
                                    <hr class="bg-gradient-RedBlue text-center" style="width: 100%;" />
                                    <div class="col-1 mx-auto text-center"><%# Container.DataItemIndex + 1 %></div>
                                    <div class="row col-3 mx-auto text-center">
                                        <div class="col-12 mx-auto">
                                            <%# Eval("cm_pname") %> <%# Eval("cm_fname") %> <%# Eval("cm_lname") %>
                                        </div>
                                        <div class="col-lg-8 col-sm-12 mx-auto">
                                            <img src="../images/CardID/<%# Eval("bv_cardid") %>.jpg" style="width: 100%" />
                                        </div>
                                    </div>
                                    <div class="col-2 mx-auto text-center"><%# Eval("bv_qty") %> เข็ม</div>
                                    <div class="col-3 mx-auto text-center"><%# String.Format("{0:#,##0.##}", Eval("bv_price")) %></div>
                                    <div class="col-3 mx-auto text-center"><%# String.Format("{0:#,##0.##}", Eval("bv_net")) %></div>
                                </div>
                            </ItemTemplate>
                        </asp:ListView>
                    </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btn_details" />
                </Triggers>
            </asp:UpdatePanel>
          </div>
      </div>
    </div>
  </div>
</div>

<!-- Modal Reject -->
<div class="modal fade" id="modalReject" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
        <div class="modal-content">
            <div class="modal-header bg-danger">
                <h5>เหตุผลที่ reject ?</h5>
            </div>
            <div class="modal-body">
                <textarea id="txt_remark" class="form-control" placeholder="กรุณากรอกเหตุผลที่ Reject" runat="server"></textarea>
            </div>
            <div class="modal-footer">
                <div class="col-12 mx-auto text-right">
                    <button id="btn_reject" class="btn btn-outline-danger" onserverclick="btn_reject_ServerClick" runat="server">บันทึก</button>
                </div>
            </div>
        </div>
    </div>
</div>


<script>
    function fn_details(id) {
        document.getElementById('<%= txtH_id.ClientID %>').value = id;
        __doPostBack('<%= btn_details.UniqueID %>', '');
    }
</script>

<asp:UpdatePanel ID="UpdatePanel_script" runat="server">
    <ContentTemplate>
        <asp:Label ID="lbl_modal" Text="" runat="server"></asp:Label>
    </ContentTemplate>
</asp:UpdatePanel>

</asp:Content>
