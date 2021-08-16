<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Tool.aspx.cs" Inherits="BRH_Plubic.Rehab.Tool" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentDesktop" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <div class="row col-12 mx-auto">
        <div class="col-2 mx-auto text-center">
            <a style="font-size: x-large;" data-toggle="modal" data-target="#modalAddNewItem">+ <i class="ti-hummer"></i></a>
        </div>
        <div class="col-8 mx-auto text-center" style="font-size: xx-large;">
            รายการเครื่องมือที่ใช้ทำหัตถการทั้งหมด
        </div>
        <div class="col-2 mx-auto my-auto text-center" style="font-size: x-large">
            <label class="switch">
                <asp:CheckBox ID="cbs_active" OnCheckedChanged="cbs_active_CheckedChanged" Checked="true" AutoPostBack="true" runat="server" />
                <span class="slider round"></span>
            </label>
            Active
        </div>
        <asp:ListView ID="LV_list" runat="server">
            <LayoutTemplate>
                <div class="row col-12 mx-auto" style="font-size: x-large; color: white; background-color:cornflowerblue;">
                    <div class="col-1 mx-auto text-center">
                        No
                    </div>
                    <div class="col-6 mx-auto text-center">
                        Name
                    </div>
                    <div class="col-2 mx-auto text-center">
                        Qty
                    </div>
                    <div class="col-2 mx-auto text-center">
                        OnJob
                    </div>
                    <div class="col-1 mx-auto text-center">
                        Edit
                    </div>
                </div>
                <div id="itemPlaceholder" runat="server"></div>
            </LayoutTemplate>
            <ItemTemplate>
                <hr class="col-11 mx-auto" />
                <div class="row col-12 mx-auto">
                    <div class="col-1 mx-auto my-auto text-center">
                        <%# Eval("rht_id") %>
                    </div>
                    <div class="col-6 mx-auto my-auto">
                        <%# Eval("rht_name") %>
                    </div>
                    <div class="col-2 mx-auto my-auto text-center">
                        <%# Eval("rht_qty") %>
                    </div>
                    <div class="col-2 mx-auto my-auto text-center">
                        <%# Eval("QtyOnJob") %>
                    </div>
                    <div class="col-1 mx-auto my-auto text-center">
                        <a data-toggle="modal" data-target="#modalEditItem" onclick="fn_getid('<%# Eval("rht_id") %>')" style="font-size: x-large; cursor: pointer;"><i class="ti-settings"></i></a>
                    </div>
                </div>
            </ItemTemplate>
        </asp:ListView>
    </div>

<div hidden="hidden">
    <input id="txt_id" value="" runat="server" />
</div>

<!-- Modal Add Item -->
<div class="modal fade" id="modalAddNewItem" tabindex="-1" role="dialog" aria-labelledby="modalAddNewItemTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header bg-primary" style="color: white;">
        <h5 class="modal-title" id="modalAddNewItemTitle">Add new item.</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
          <div class="row col-12 m-auto">
              <div class="col-8 mx-auto">
                  <input type="text" id="txt_toolname" value="" class="form-control" placeholder="ชื่อเครื่องมือ" runat="server" />
              </div>
              <div class="col-4 mx-auto">
                  <input type="number" id="num_toolqty" value="" class="form-control" placeholder="จำนวนเครื่อง" runat="server" />
              </div>
          </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <a class="btn btn-outline-primary" onclick="fn_checkAdd()">Save</a>
        <button type="button" id="btn_add" onserverclick="btn_add_ServerClick" runat="server" hidden="hidden"></button>
      </div>
    </div>
  </div>
</div>

<!-- Modal Edit Item -->
<div class="modal fade" id="modalEditItem" tabindex="-1" role="dialog" aria-labelledby="modalEditItemTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header bg-warning" style="color: white;">
        <h5 class="modal-title" id="modalEditItemTitle">Edit item.</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
          <asp:UpdatePanel ID="UpdatePanel_edittool" runat="server">
              <ContentTemplate>
                  <div class="row col-12 mx-auto">
                      <div class="col-8 mx-auto">
                          <input type="text" id="txt_edit_toolname" value="" class="form-control" placeholder="ชื่อเครื่องมือ" runat="server" />
                      </div>
                      <div class="col-4 mx-auto">
                          <input type="number" id="num_edit_toolqty" value="" class="form-control" placeholder="จำนวนเครื่อง" runat="server" />
                      </div>
                      <div class="col-12 mx-auto my-2">
                          <label class="switch">
                              <asp:CheckBox ID="cb_active" runat="server" />
                              <span class="slider round"></span>
                          </label> Active
                      </div>
                  </div>
                  <button id="btn_SelectEdit" runat="server" onserverclick="btn_SelectEdit_ServerClick" hidden="hidden"></button> 
              </ContentTemplate>
              <Triggers>
                  <asp:AsyncPostBackTrigger ControlID="btn_SelectEdit" />
              </Triggers>
          </asp:UpdatePanel>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <a class="btn btn-outline-primary" onclick="fn_checkEdit()">Save</a>
        <button type="button" id="btn_edit" onserverclick="btn_edit_ServerClick" runat="server" hidden="hidden"></button>
      </div>
    </div>
  </div>
</div>

<script>
    function fn_checkAdd() {
        var toolname = document.getElementById('<%= txt_toolname.ClientID %>');
        var qty = document.getElementById('<%= num_toolqty.ClientID %>');
        toolname.removeAttribute('style');
        qty.removeAttribute('style');
        var wrong = 0;
        var style = 'border:groove; border-color: red;';
        if (toolname.value == '') {
            toolname.setAttribute('style', style);
            wrong++;
        }
        if (qty.value == '') {
            qty.setAttribute('style', style);
            wrong++;
        }
        if (wrong == 0) {
            __doPostBack('<%= btn_add.UniqueID %>', '');
        }
    }
    function fn_checkEdit() {
        var toolname = document.getElementById('<%= txt_edit_toolname.ClientID %>');
        var qty = document.getElementById('<%= num_edit_toolqty.ClientID %>');
        toolname.removeAttribute('style');
        qty.removeAttribute('style');
        var wrong = 0;
        var style = 'border:groove; border-color: red;';
        if (toolname.value == '') {
            toolname.setAttribute('style', style);
            wrong++;
        }
        if (qty.value == '') {
            qty.setAttribute('style', style);
            wrong++;
        }
        if (wrong == 0) {
            __doPostBack('<%= btn_edit.UniqueID %>', '');
        }
    }

    function fn_getid(id) {
        var txtid = document.getElementById('<%= txt_id.ClientID %>');
        txtid.value = id;
        __doPostBack('<%= btn_SelectEdit.UniqueID %>', '');
    }
</script>

</asp:Content>
