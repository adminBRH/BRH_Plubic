<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageProduct.aspx.cs" Inherits="BRH_Plubic.Marketing.ManageProduct" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentDesktop" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<script>
    function ActiveIcon(status) {
        var span = ' <span class="ti-close rounded-circle" style="color:red;"></span>';
        if (status == 'yes') {
            span = '<span class="ti-check rounded-circle" style="color:green;"></span>';
        }
        document.write(status + ' ' + span);
    }
</script>

<style>
    .btnAddNew {
        height: 100px;
        top: 40%; left: auto; right: 0;  
        border-top-left-radius:10px; 
        border-bottom-left-radius:10px;
        font-size: x-large;
    }
</style>

    <div class="row col-12 mx-auto">
        <asp:ListView ID="lv_category" runat="server" DataKeyNames="mc_id">
            <LayoutTemplate>
                <table width="100%" runat="server">
                    <tr>
                        <th>
                            <div class="col-12 mx-auto text-center h1">
                                Products category Management.
                            </div>
                        </th>
                    </tr>
                    <tr ID="itemPlaceholder" runat="server">
                    </tr>
                </table>
            </LayoutTemplate>
            <ItemTemplate>
                <tr>
                    <td width="100%">
                        <div class="row col-12 mx-auto">
                            <div class="card round col-lg-7 col-sm-12 mx-auto my-2 boxShadow">
                                <div class="row col-12 mx-auto">
                                    <div class="col-4 mx-auto text-center"><img src="image/main/id<%# Eval("mc_id") %>_Home-Category.jpg" width="100%" /></div>
                                    <div class="row col-7 mx-auto">
                                        <div class="col-12 mx-auto text-left h3"><%# Eval("mc_name") %></div>
                                        <div class="col-6 mx-auto text-left h5"><b>Start date</b> <br /><%# Eval("StartDate") %></div>
                                        <div class="col-6 mx-auto text-left h5"><b>End Date</b> <br /><%# Eval("EndDate") %></div>
                                        <div class="row col-6 mx-auto text-left h5">
                                            Active : <script> ActiveIcon('<%# Eval("mc_active") %>'); </script>
                                        </div>
                                        <div class="col-6 mx-auto text-right">
                                            <a href="SettingProduct.aspx?cate=<%# Eval("mc_id") %>"><span class="ti-3x ti-settings"></span></a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </td>
                <tr />
            </ItemTemplate>
        </asp:ListView>

    </div>


<a data-toggle="modal" data-target="#ModalAddCategory" class="btn btn-warning fixed-bottom btnAddNew">
    <i class="ti-plus"></i> New
</a>

<!-- Modal Add New Category -->
<div class="modal right fade" id="ModalAddCategory" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document" style="max-width: 100%; top: 0; left: auto; right: 0;">
        <div class="modal-content" style="background-color:lightgoldenrodyellow;">
            <div class="modal-header" style="font-size: xx-large; color:cadetblue; text-shadow: 2px 2px 2px #000000;">
                <div class="col-12 mx-auto text-center">
                    Add New Category.
                </div>
            </div>
            <div class="modal-body">
                <div class="row col-12 mx-auto" style="position: absolute; top: 30%;">
                    <div class="col-12 mx-auto my-3">
                        <input type="text" id="txt_cateName" class="form-control" placeholder="Category Name" runat="server" />
                    </div>
                    <div class="col-6 mx-auto my-3">
                        Start : <input type="date" id="txt_dateStart" class="form-control" value="" runat="server" />
                    </div>
                    <div class="col-6 mx-auto my-3">
                        End : <input type="date" id="txt_dateEnd" class="form-control" value="" runat="server" />
                    </div>
                    <div class="col-12 mx-auto my-3">
                        Image : 
                        <asp:FileUpload ID="UploadImg_category" AllowMultiple="false" runat="server" />
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <div class="col-12 mx-auto text-center">
                    <button id="btn_addcate" class="btn btn-outline-primary" onserverclick="btn_addcate_ServerClick" runat="server" style="font-size: large;">
                        <i class="ti-save"></i> save
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

</asp:Content>
