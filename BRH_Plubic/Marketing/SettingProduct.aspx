<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SettingProduct.aspx.cs" Inherits="BRH_Plubic.Marketing.SettingProduct" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentDesktop" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


<script>
    function ActiveIcon(status) {
        var span = ' <span class="ti-close rounded-circle"></span>';
        if (status == 'yes') {
            span = '<span class="ti-check rounded-circle"></span>';
        }
        document.write(status + ' ' + span);
    }
</script>

<style>
    .btnAddNew {
        height: 100px;
        top: 60%; left: auto; right: 0;  
        border-top-left-radius:10px; 
        border-bottom-left-radius:10px;
        font-size: x-large;
    }
</style>

    <div class="alert-primary boxShadow mx-auto text-center mb-3 h1">Setting Category and Products</div>
    <div class="col-12 mx-auto">
        <div class="col-12 card boxShadow mx-auto">
            <div class="row col-12">
                <div class="col-3 mx-auto">
                    <img id="img_category" src="..." runat="server" style="width:100%" />
                    <asp:FileUpload ID="UploadImg_category" AllowMultiple="false" runat="server" />
                </div>
                <div class="row col-9 mx-auto">
                    <div class="col-12 mx-auto text-left h3"><b>Category name</b> <br />
                        <input type="text" id="txt_category_name" class="form-control" value="" runat="server" />
                    </div>
                    <div class="col-6 mx-auto text-left h5"><b>Start date</b> <br />
                        <input type="date" id="date_start" value="" runat="server" />
                    </div>
                    <div class="col-6 mx-auto text-left h5"><b>End Date</b> <br />
                        <input type="date" id="date_end" value="" runat="server" />
                    </div>
                    <div class="col-12 mx-auto text-left h5">
                        <asp:Label ID="lbl_version" Text="" runat="server"></asp:Label>
                    </div>
                    <div class="col-6 mx-auto text-left h3">
                        <label class="switch">
                            <input type="checkbox" id="CB_category_active" value="" runat="server" />
                            <span class="slider round"></span>
                        </label> Active
                    </div>
                    <div class="col-6 mx-auto text-center">
                        <asp:Button ID="btn_category" CssClass="btn btn-outline-success" Font-Size="Large" Text="Confirm" OnClick="btn_category_Click" runat="server" />
                    </div>
                </div>
            </div>
        </div>
        <div class="col-12 mx-auto my-3">
            <div class="row col-12">
                <asp:ListView ID="lv_product" DataKeyNames="mk_id" runat="server">
                    <LayoutTemplate>
                        <table width="100%">
                            <div class="col-12 mx-auto text-center alert-primary h3">
                                Product details in category.
                                <label class="switch">
                                    <input type="checkbox" id="cb_ShowProduct" onclick="ShowProduct()" />
                                    <span class="slider round"></span>
                                </label>
                            </div>
                            <div id="div_details" class="row col-12 mx-auto" hidden="hidden">
                                <div id="itemPlaceholder" class="row col-12 mx-auto" runat="server">
                                </div>
                            </div>
                        </table>
                    </LayoutTemplate>
                    <ItemTemplate>
                        <div id="divProd_<%# Eval("mk_index") %>" class="row col-lg-4 col-sm-6 mx-auto my-1 boxShadow section">
                            <div class="col-6">
                                <img src="image/product/id<%# Eval("mk_mcid") %>_imageProduct<%# Eval("mk_index") %>.jpg" style="width:100%;"/>
                                <input type="text" hidden="hidden" id="txtH_img_<%# Eval("mk_id") %>" value="image/product/id<%# Eval("mk_mcid") %>_imageProduct<%# Eval("mk_index") %>.jpg" />
                            </div>
                            <div class="col-6">
                                <strong>Name : <%# Eval("mk_productname") %></strong>
                                <input type="text" hidden="hidden" id="txtH_name_<%# Eval("mk_id") %>" value="<%# Eval("mk_productname") %>" />
                                <br /><br />
                                <strong style="color:blue;">Price : <%# Eval("mk_price") %></strong>
                                <input type="text" hidden="hidden" id="txtH_price_<%# Eval("mk_id") %>" value="<%# Eval("mk_price") %>" />
                                <br />
                                <strong style="color:red;">Discount : <%# Eval("mk_discount") %></strong>
                                <input type="text" hidden="hidden" id="txtH_discount_<%# Eval("mk_id") %>" value="<%# Eval("mk_discount") %>" />
                                <br />
                                <strong>Delivery : <%# Eval("mk_delivery") %></strong>
                                <input type="text" hidden="hidden" id="txtH_delivery_<%# Eval("mk_id") %>" value="<%# Eval("mk_delivery") %>" />
                                <br />
                                <strong>Condition : <%# Eval("mk_condition") %></strong>
                                <input type="text" hidden="hidden" id="txtH_condition_<%# Eval("mk_id") %>" value="<%# Eval("mk_condition") %>" />
                                <br />
                                <strong style="<%# Eval("mk_color") %>">Active : <script> ActiveIcon('<%# Eval("mk_active") %>'); </script></strong>
                                
                                <input type="text" hidden="hidden" id="txtH_active_<%# Eval("mk_id") %>" value="<%# Eval("mk_active") %>" />
                                <br /><br />
                                <a href="#" class="btn btn-outline-primary" data-toggle="modal" data-target="#ModalProduct" onclick="ShowDatatoModal('<%# Eval("mk_id") %>','<%# Eval("mk_index") %>')">
                                    Edit <span class="ti-pencil-alt"></span>
                                </a>
                                <br /><br />
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:ListView>
            </div>
        </div>
    </div>

<script>
    function ShowProduct() {
        var cbProduct = document.getElementById('cb_ShowProduct');
        var divDetails = document.getElementById('div_details');
        if (cbProduct.checked) {
            divDetails.removeAttribute('hidden');
        }
        else {
            divDetails.setAttribute('hidden','hidden');
        }
    }

    function ShowProductAuto() {
        var cbProduct = document.getElementById('cb_ShowProduct');
        var divDetails = document.getElementById('div_details');
        cbProduct.checked = true;
        divDetails.removeAttribute('hidden');
    }
</script>

    <asp:Label ID="lbl_script" Text="" runat="server"></asp:Label>

    <!-- ------------------------------------ Modal Product ------------------------------------ -->
    <div class="modal fade" id="ModalProduct" aria-labelledby="ModalProductTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="ModalProductTitle">Edit Product detail</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                      <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row col-12 mx-auto">
                        <div class="col-lg-4 col-sm-8 mx-auto">
                            <img id="img_product" src="..." style="width:100%;" />
                            <asp:FileUpload ID="UploadImg_product" AllowMultiple="false" runat="server" />
                        </div>
                        <div class="row col-lg-8 col-sm-12 mx-auto mt-2">
                            <input type="text" id="txt_id" value="" runat="server" hidden="hidden" />
                            <input type="text" id="txt_index" value="" runat="server" hidden="hidden" />
                            <div class="col-3 my-2 text-right">Name : </div>
                            <div class="col-9 my-2"><input type="text" id="txt_name" class="form-control" value="" runat="server" /></div>
                            <div class="col-3 my-2 text-right">Price : </div>
                            <div class="col-9 my-2"><input type="text" id="txt_price" class="form-control col-4" value="" runat="server" /></div>
                            <div class="col-3 my-2 text-right">Discount : </div>
                            <div class="col-9 my-2"><input type="text" id="txt_discount" class="form-control col-4" value="" runat="server" /></div>
                            <div class="col-3 my-2 text-right">Active : </div>
                            <div class="col-3 my-2 text-left"><label class="switch">
                                <input type="checkbox" id="cb_active" value="" checked="checked" runat="server" />
                                    <span class="slider round"></span>
                                </label>
                            </div>
                            <div class="col-3 my-2 text-right">Delivery : </div>
                            <div class="col-3 my-2 text-left"><label class="switch">
                                <input type="checkbox" id="cb_delivery" value="" checked="checked" runat="server" />
                                    <span class="slider round"></span>
                                </label>
                            </div>
                            <div class="col-3 my-2 text-right">Condition : </div>
                            <div class="col-9 my-2"><input type="text" id="txt_condition" class="form-control" value="" runat="server" /></div>
                            <div class="col-12 mx-auto my-3 text-center">
                                <a href="#" data-toggle="modal" data-dismiss="modal" data-target="#ModalConfirm" class="btn btn-outline-primary"><span class="ti-save-alt"></span> Save</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- ------------------------------------ Modal Product ------------------------------------ -->
    <!-- ------------------------------------ Modal Confirm ------------------------------------ -->
    <div class="modal fade" id="ModalConfirm" aria-labelledby="ModalConfirmTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="ModalConfirmTitle">Are you sure ?</h5>
                </div>
                <div class="modal-body">
                    <div class="row col-12 mx-auto text-center">
                        <div class="col-6 mx-auto text-center">
                            <button id="btn_close" class="btn btn-outline-danger" data-dismiss="modal">Close</button>
                        </div>
                        <div class="col-6 mx-auto text-center">
                            <button id="btn_product" class="btn btn-outline-success" runat="server" onserverclick="btn_product_ServerClick">Confirm</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- ------------------------------------ Modal Confirm ------------------------------------ -->

<a data-toggle="modal" data-target="#ModalAddProduct" class="btn btn-warning fixed-bottom btnAddNew">
    <i class="ti-plus"></i> New<br />Product
</a>

<!-- Modal Add New Product -->
<div class="modal right fade" id="ModalAddProduct" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document" style="max-width: 100%; top: 0; left: auto; right: 0;">
        <div class="modal-content" style="background-color:lightgoldenrodyellow;">
            <div class="modal-header" style="font-size: xx-large; color:cadetblue; text-shadow: 2px 2px 2px #000000;">
                <div class="col-12 mx-auto text-center">
                    Add New Product.
                </div>
            </div>
            <div class="modal-body">
                <div class="row col-12 mx-auto">
                    <div class="col-12 mx-auto my-3">
                        <input type="text" id="txt_prodName" class="form-control" placeholder="Product Name" runat="server" />
                    </div>
                    <div class="col-4 mx-auto my-3">
                        Price : <input type="number" id="txt_prodPrice" class="form-control" value="" runat="server" />
                    </div>
                    <div class="col-4 mx-auto my-3">
                        Discount : <input type="number" id="txt_prodDiscount" class="form-control" value="" runat="server" />
                    </div>
                    <div class="col-4 mx-auto my-3">
                        Delivery : 
                        <label class="switch">
                            <input type="checkbox" id="cb_prodDelivery" runat="server"/>
                            <span class="slider round"></span>
                        </label>
                    </div>
                    <div class="col-12 mx-auto my-3">
                        <input type="text" id="txt_prodCondition" class="form-control" placeholder="Condition" runat="server" />
                    </div>
                    <div class="col-12 mx-auto my-3">
                        Image : 
                        <asp:FileUpload ID="Upload_newProduct" AllowMultiple="false" runat="server" />
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <div class="col-12 mx-auto text-center">
                    <button id="btn_addProd" class="btn btn-outline-primary" onserverclick="btn_addProd_ServerClick" runat="server" style="font-size: large;">
                        <i class="ti-save"></i> save
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function ShowDatatoModal(id,index) {
        document.getElementById('<%= txt_id.ClientID %>').value = id;
        document.getElementById('<%= txt_index.ClientID %>').value = index;
        var img = document.getElementById('txtH_img_' + id);
        var name = document.getElementById('txtH_name_' + id);
        var price = document.getElementById('txtH_price_' + id);
        var discount = document.getElementById('txtH_discount_' + id);
        var delivery = document.getElementById('txtH_delivery_' + id);
        var condition = document.getElementById('txtH_condition_' + id);
        var active = document.getElementById('txtH_active_' + id);

        var Modal_img = document.getElementById('img_product');
        var Modal_name = document.getElementById('<%= txt_name.ClientID %>');
        var Modal_price = document.getElementById('<%= txt_price.ClientID %>');
        var Modal_discount = document.getElementById('<%= txt_discount.ClientID %>');
        var Modal_delivery = document.getElementById('<%= cb_delivery.ClientID %>');
        var Modal_condition = document.getElementById('<%= txt_condition.ClientID %>');
        var Modal_active = document.getElementById('<%= cb_active.ClientID %>');

        Modal_img.src = img.value;
        Modal_name.value = name.value;
        Modal_price.value = price.value;
        Modal_discount.value = discount.value;
        if (delivery.value == 'no') {
            Modal_delivery.removeAttribute('checked');
        }
        if (active.value == 'no') {
            Modal_active.removeAttribute('checked');
        }
        Modal_condition.value = condition.value;
    }
</script>

</asp:Content>
