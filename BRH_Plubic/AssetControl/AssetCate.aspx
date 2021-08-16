<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AssetCate.aspx.cs" Inherits="BRH_Plubic.AssetControl.AssetCate" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentDesktop" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<asp:ScriptManager ID="ScriptManager_Master" runat="server"></asp:ScriptManager>

    <div class="row col-12 mx-auto mb-3">
        <div class="row col-8 mx-auto">
            <div class="col-10 mx-auto">
                <input id="txt_search" value="" class="form-control" placeholder="Search" runat="server" />
            </div>
            <div class="col-2 mx-auto text-left">
                <a id="btn_search" class="btn btn-outline-info" style="cursor: pointer;"><i class="ti-search"></i></a>
            </div>
        </div>
        <div class="col-4 mx-auto text-right">
            <a id="btn_add" class="btn btn-outline-primary" data-toggle="modal" data-target="#modalAdd"><i class="ti-plus"></i> New</a>
        </div>
    </div>

<!-- Modal -->
<div class="modal fade" id="modalAdd" tabindex="-1" role="dialog" aria-labelledby="modalAddTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalAddTitle">Add new Category.</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
          <div class="row col-12 mx-auto">
              <div class="col-6 mx-auto text-center">
                  <asp:DropDownList ID="DD_branch" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="DD_branch_SelectedIndexChanged" runat="server">
                      <asp:ListItem Text="" Value=""></asp:ListItem>
                  </asp:DropDownList>
              </div>
              <div class="col-6 mx-auto text-center">
                  <asp:UpdatePanel ID="UpdatePanel_dept" runat="server">
                      <ContentTemplate>
                          <asp:DropDownList ID="DD_department" CssClass="form-control" runat="server">
                              <asp:ListItem Text="" Value=""></asp:ListItem>
                          </asp:DropDownList>
                      </ContentTemplate>
                      <Triggers>
                          <asp:AsyncPostBackTrigger ControlID="DD_branch" />
                         
                      </Triggers>
                  </asp:UpdatePanel>
              </div>
              <div class="col-12 mx-auto my-3">
                  <input id="txt_catename" value="" class="form-control" placeholder="Category Name" runat="server" />
              </div>
          </div>
      </div>
      <div class="modal-footer">
          <asp:UpdatePanel ID="UpdatePanel_alertAdd" runat="server">
              <ContentTemplate>
                  <div class="row col-12 mx-auto">
                      <div class="col-10 mx-auto">
                          <asp:Label ID="lbl_alertAdd" Text="" runat="server"></asp:Label>
                      </div>
                      <div class="col-2 mx-auto">
                          <button id="btn_addcate" type="button" class="btn btn-outline-primary" onserverclick="btn_addcate_ServerClick" runat="server">Save</button>
                      </div>
                  </div>
              </ContentTemplate>
              <Triggers>
                  <asp:AsyncPostBackTrigger ControlID="btn_addcate" />
              </Triggers>
          </asp:UpdatePanel>
      </div>
    </div>
  </div>
</div>

    <div class="col-12 mx-auto">
        <asp:ListView ID="LV_Cate" runat="server">
            <LayoutTemplate>
                <div class="card col-12 mx-auto">
                    <div class="row col-12 mx-auto bg-dark" style="color:white;">
                        <div class="col-1 mx-auto text-center">No.</div>
                        <div class="col-4 mx-auto text-center">Category</div>
                        <div class="col-3 mx-auto text-center">Branch</div>
                        <div class="col-3 mx-auto text-center">Department</div>
                        <div class="col-1 mx-auto text-center">Edit</div>
                    </div>
                    <div id="itemPlaceholder" class="col-12 mx-auto" runat="server">
                    </div>
                </div>
            </LayoutTemplate>
            <ItemTemplate>
                <div class="row col-12 mx-auto my-1" style="background-color: darkkhaki;">
                    <div class="col-1 mx-auto my-auto"><%# Container.DataItemIndex + 1 %></div>
                    <div class="col-4 mx-auto my-auto"><%# Eval("asc_name") %></div>
                    <div class="col-3 mx-auto my-auto"><%# Eval("asc_branch") %></div>
                    <div class="col-3 mx-auto my-auto"><%# Eval("asc_dept") %></div>
                    <div class="col-1 mx-auto my-auto text-center"><a class="btn btn-outline-warning" style="cursor: pointer;"><i class="ti-settings my-auto"></i></a></div>
                </div>
            </ItemTemplate>
        </asp:ListView>
    </div>

</asp:Content>
