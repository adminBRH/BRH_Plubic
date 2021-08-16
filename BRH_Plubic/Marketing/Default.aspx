<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="BRH_Plubic.Marketing.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server"> 

<style>
    .btnCart {
        height: 100px;
        top: 200px; left: 0; right: auto;  
    }
</style>

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <div id="Cart" class="section fixed-top btnCart">   
        <asp:UpdatePanel ID="UpdatePanel_cart" runat="server">
            <ContentTemplate>
                <button type="button" class="btn btn-light" id="btn_pay" onserverclick="btn_pay_ServerClick" runat="server"><img src="image/bill_payment.png" width="34" /><br />ชำระค่าสินค้า</button>
                <br />
                <button type="button" class="btn btn-light" id="btn_basket" onserverclick="btn_basket_ServerClick" runat="server"><img src="image/cart.png" width="54" /><asp:Label ID="lbl_amt" Text="" Font-Size="X-Large" runat="server"></asp:Label></button>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btn_submit" EventName="serverclick" />
            </Triggers>
        </asp:UpdatePanel>
    </div>

    <div id="div_category" class="row col-12 mx-auto" runat="server">
        <!--------------------------------- Main Category --------------------------------->
        <asp:Label CssClass="row col-12 mx-auto text-center" ID="lbl_imgMain" Text="" runat="server"></asp:Label>
        <!--------------------------------- -------------------- -------------------------->
    </div>


    <div id="div_product" class="row col-12 mx-auto" runat="server" visible="false">
        
        <!--------------------------------- Products by Category --------------------------------->
        <asp:Label ID="lbl_product" Text="" CssClass="row col-12" runat="server"></asp:Label>
        <!--------------------------------- -------------------- --------------------------------->



           <!-- Button trigger modal -->
           <!--<button type="button" class="btn btn-primary mx-auto text-center" data-toggle="modal" data-target="#exampleModalCenter">
            Launch demo modal
           </button>-->

                    <!-- Modal -->
            <div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
              <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
                <div class="modal-content">
                  <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLongTitle"><asp:Label ID="lbl_title_modal" Text="" runat="server"></asp:Label></h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                      <span aria-hidden="true">&times;</span>
                    </button>
                  </div>
                          <div class="modal-body bg-transparent">   
                              <div class="col-12 mx-auto text-right">
                                  <button type="button" class="col-3 btn btn-outline-success boxShadow" id="btn_submit" onserverclick="btn_submit_ServerClick" data-dismiss="modal" runat="server" style="font-size:x-large;">Add<img src="image/cart.png" width="58" /></button>
                              </div>
                                <%--<div class="card card-head bg-info text-center" style="color:white">&nbsp;</div>--%>
                                <div class="card card-body bg-transparent">
                                    <div class="row col-12 mx-auto">
                                        <div hidden="hidden">
                                            <input type="text" id="txth_item" value="1" runat="server" />
                                        </div>
                                        <div class="col-lg-6 col-sm-12 mx-auto text-center mb-5">
                                            <asp:Label ID="lbl_img" Text="" runat="server"></asp:Label>
                                            <a id="a_Detail" target="_blank" href="image/product/id4_imageProductDetail.jpg" class="col-12 btn mt-2" runat="server" visible="false" style="font-size:x-large; background-color:darkblue; color:white;">ดูรายละเอียด</a>
                                        </div>
                                        <div class="row col-lg-6 col-sm-12">
                                            <div class="row col-lg-12 col-sm-6 mb-5">
                                                <input type="text" id="txt_order" class="col-lg-6 col-sm-12 text-left" onkeyup="Additem('add','input')" value="0" runat="server" style="font-size:50px" />
                                                <span id="spandd" class="col-lg-3 col-sm-6 btn btn-outline-primary" onclick="Additem('add','click')" style="font-size:50px">+</span>
                                                <span id="spandel" class="col-lg-3 col-sm-6 btn btn-outline-danger" onclick="Additem('del','click')" style="font-size:50px">-</span> 
                                            </div>
                                            <div class="row col-12">
                                                <div class="col-6 mb-5" style="font-size:30px; color:blue">
                                                    ราคา : ฿ <asp:Label ID="lbl_price" Text="0" runat="server"></asp:Label>
                                                </div>
                                                <div class="col-6 mb-5" style="font-size:30px; color:orangered">
                                                    ส่วนลด : ฿ <asp:Label ID="lbl_discount" Text="0" runat="server"></asp:Label>
                                                </div>
                                                <div class="col-12 mb-5" style="font-size:30px">
                                                    Total : ฿ <asp:Label ID="lbl_total" Text="0" runat="server"></asp:Label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row col-lg-4 col-sm-12 mx-auto" style="font-size:30px">
                                            <div class="col-12 mb-5">
                                                <b>การจัดส่ง :</b> <asp:Label ID="lbl_delivery" Text="" ForeColor="Blue" runat="server"></asp:Label>
                                            </div>
                                            <div class="col-12 mb-5">
                                                <b>เงื่อนไข :</b> <asp:Label ID="lbl_condition" Text="" ForeColor="Red" runat="server"></asp:Label>
                                            </div>
                                        </div>
                                        <!-- ==================================== Slide Recommended promotions ==================================== -->
                                        <hr style="color:aqua;" />
                                        <div class="row col-lg-4 col-sm-10 boxShadow mx-auto mb-5">
                                            <div class="col-12 alert-dark mx-auto text-center h3">สินค้าอื่นๆ</div>
                                            <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
                                              <ol class="carousel-indicators">
                                                <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active bg-gradient"></li>
                                                <li data-target="#carouselExampleIndicators" data-slide-to="1" class="bg-gradient"></li>
                                                <li data-target="#carouselExampleIndicators" data-slide-to="2" class="bg-gradient"></li>
                                                <!-- Image Promotion -->
                                                  <asp:Label ID="lbl_promotion_indi" Text="" runat="server"></asp:Label>
                                                  <!-- Image Promotion -->
                                              </ol>
                                              <div class="carousel-inner">
                                                  <!-- Image Promotion -->
                                                  <asp:Label ID="lbl_promotion_img" Text="" runat="server"></asp:Label>
                                                  <!-- Image Promotion -->
                                              </div>
                                              <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
                                                <span class="carousel-control-prev-icon bg-danger" aria-hidden="true"></span>
                                                <span class="sr-only">Previous</span>
                                              </a>
                                              <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
                                                <span class="carousel-control-next-icon bg-danger" aria-hidden="true"></span>
                                                <span class="sr-only">Next</span>
                                              </a>
                                            </div>
                                        </div>
                                        <!-- ==================================== Slide Recommended promotions ==================================== -->

                                    </div>
                                </div>
                          </div>
                  <div class="modal-footer">
                    <%--<button type="button" class="btn btn-secondary" data-dismiss="modal"><h5>Close</h5><img src="image/Close.png" width="38" /></button>--%>
                  </div>
                </div>

              </div>
            </div>
            
        <div hidden="hidden">
            <asp:TextBox ID="txt_cate" Text="" runat="server"></asp:TextBox>
        </div>

        
    </div>

        <script>          

            function SetItem(item,cateID,id) {

                var cate = document.getElementById('<%= txt_cate.ClientID%>');

                var i = document.getElementById('<%= txth_item.ClientID%>');
                i.value = id;

                var title = document.getElementById('txth_title_' + id);
                var titleModal = document.getElementById('<%= lbl_title_modal.ClientID%>');
                titleModal.innerText = title.value;

                var price = document.getElementById('txth_price_' + id);
                var lblprice = document.getElementById('<%= lbl_price.ClientID%>');
                lblprice.innerText = price.value;

                var discount = document.getElementById('txth_discount_' + id);
                var lbldiscount = document.getElementById('<%= lbl_discount.ClientID%>');
                lbldiscount.innerText = discount.value;

                var delivery = document.getElementById('txth_delivery_' + id);
                var lbldelivery = document.getElementById('<%= lbl_delivery.ClientID%>');
                lbldelivery.innerText = delivery.value;

                var condition = document.getElementById('txth_condition_' + id);
                var lblcondition = document.getElementById('<%= lbl_condition.ClientID%>');
                lblcondition.innerText = condition.value;

                var img = "image/product/id" + cateID + "_imageProduct" + item + ".jpg";

                var lbl = document.getElementById('<%= lbl_img.ClientID%>');
                lbl.innerHTML = "<img class='boxShadow' src='" + img + "' width='100%' />";

                var qty = document.getElementById('<%= txt_order.ClientID%>');
                qty.value = 0;
                var lbltotal = document.getElementById('<%= lbl_total.ClientID%>');
                lbltotal.innerText = 0;
            }

            function Additem(event,step) {
                var qty = document.getElementById('<%= txt_order.ClientID%>');

                if (step == 'click') {
                    if (event == 'add') {
                        qty.value = parseInt(qty.value) + 1;
                    }
                    if (event == 'del') {
                        qty.value = parseInt(qty.value) - 1;
                    }
                    if (parseInt(qty.value) < 0) {
                        qty.value = 0;
                    }
                }

                var lblid = document.getElementById('<%= txth_item.ClientID%>');
                var lblprice = document.getElementById('txth_price_' + lblid.value);
                var lbldiscount = document.getElementById('txth_discount_' + lblid.value);
                var discount = 0;
                if (lbldiscount.value != '') {
                    discount = parseInt(qty.value) * parseInt(lbldiscount.value);
                }
                var total = parseInt(qty.value) * parseInt(lblprice.value);
                total = parseInt(total) - parseInt(discount);

                var lbltotal = document.getElementById('<%= lbl_total.ClientID%>');
                lbltotal.innerText = total;
            }
                
        </script>

</asp:Content>
