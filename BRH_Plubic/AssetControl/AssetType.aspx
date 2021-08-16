<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AssetType.aspx.cs" Inherits="BRH_Plubic.AssetControl.AssetType" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentDesktop" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<asp:ScriptManager ID="ScriptManager_Master" runat="server"></asp:ScriptManager>
    <div class="col-11 mx-auto">
        <div class="row col-12 mx-auto">
            <div class="row col-8 mx-auto">
                <div class="col-10 mx-auto">
                    <input id="txt_search" value="" placeholder="Search" class="form-control my-auto" runat="server" />
                </div>
                <div class="col-2 mx-auto">
                    <a class="btn btn-outline-info"><i class="ti-search"></i></a>
                </div>
            </div>
            <div class="col-4 mx-auto text-right">
                <a class="btn btn-outline-primary" data-toggle="modal" data-target="#modalAdd"><i class="ti-plus"></i>New</a>
            </div>
        </div>

        <div class="col-12 mx-auto text-center h3 mt-5">
            List Asset Type
        </div>
        <div class="row col-12 mx-auto">
            <asp:ListView ID="LV_AssetTyep" runat="server">
                <LayoutTemplate>
                    <div class="row col-12 mx-auto bg-dark" style="color: white;">
                        <div class="col-2 mx-auto">No.</div>
                        <div class="col-8 mx-auto">Type Name</div>
                        <div class="col-2 mx-auto">Edit</div>
                    </div>
                    <div id="itemPlaceholder" class="col-12 mx-auto" runat="server"></div>
                </LayoutTemplate>
                <ItemTemplate>
                    <div class="row col-12 mx-auto my-2" style="background-color:antiquewhite;">
                        <div class="col-2 mx-auto my-auto"><%# Eval("ast_index") %></div>
                        <div class="col-8 mx-auto my-auto"><%# Eval("ast_name") %></div>
                        <div class="col-2 mx-auto my-auto"><a class="btn btn-outline-warning"><i class="ti-settings"></i></a></div>
                    </div>
                </ItemTemplate>
            </asp:ListView>
        </div>
    </div>

<!-- Modal -->
<div class="modal fade" id="modalAdd" tabindex="-1" role="dialog" aria-labelledby="modalAddTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalAddTitle">Add new Type</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
            <asp:UpdatePanel ID="UpdatePanel_dept" runat="server">
                <ContentTemplate>
                    <div class="row col-12 mx-auto">
                    <div class="col-12 mx-auto">
                        <input id="txt_typename" value="" class="form-control" placeholder="ชื่อทรัพย์สิน" runat="server" />
                    </div>
                    <div class="col-6 mx-auto my-2">
                        <asp:DropDownList ID="DD_branch" CssClass="form-control" OnSelectedIndexChanged="DD_branch_SelectedIndexChanged" AutoPostBack="true" runat="server">
                            <asp:ListItem Text="" Value=""></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-6 mx-auto my-2">
                        <asp:DropDownList ID="DD_department" CssClass="form-control" runat="server">
                            <asp:ListItem Text="" Value=""></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-12 mx-auto">
                        <asp:Label ID="lbl_alertnewtype" Text="" runat="server"></asp:Label>
                    </div>
                    </div>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="DD_branch" />
                <asp:AsyncPostBackTrigger ControlID="btn_addtype" />
            </Triggers>
        </asp:UpdatePanel>
      </div>
      <div class="modal-footer">
        <button id="btn_addtype" type="button" class="btn btn-outline-primary" onserverclick="btn_addtype_ServerClick" runat="server">Save</button>
      </div>
    </div>
  </div>
</div>

<asp:Label ID="lbl_script" Text="" runat="server"></asp:Label>

</asp:Content>
