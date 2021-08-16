<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Basket.aspx.cs" Inherits="BRH_Plubic.Marketing.Basket" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">
    
        <div class="col-lg-8 col-sm-12 mx-auto text-center mb-5">
            <div class="card card-head bg-info" style="color:white"><font size="6">สรุปยอดการสั่งซื้อสินค้าทั้งหมด</font></div>
            <div class="card card-body">
                <div class="col-11 text-right"><asp:Button ID="btn_del" Text="ยกเลิกการสั่งซื้อ" Font-Size="Large" CssClass="btn btn-outline-danger mb-3" OnClientClick="ConfirmDel()" OnClick="btn_del_Click" runat="server" /></div>

                <table  id="printableArea" style="width: 100%; margin-left: auto; margin-right: auto;" border="1">
                    <tr style="background-color:burlywood; color:white;">
                        <td width="40%">
                            <font size="5">รายการ</font>
                        </td>
                        <td width="10%">
                            <font size="5">จำนวน</font>
                        </td>
                        <td width="10%">
                            <font size="5">ราคา/หน่วย</font>
                        </td>
                        <td width="10%">
                            <font size="5">รวม</font>
                        </td>
                        <td width="10%">
                            <font size="5">ส่วนลด</font>
                        </td>
                        <td width="10%">
                            <font size="5">สุทธิ</font>
                        </td>
                    </tr>
                        <asp:Label ID="lbl_Detail" Text="" runat="server"></asp:Label>
                    <div hidden="hidden">
                        <input type="text" id="txtH_del" value="" runat="server" />
                    </div>
                </table>
                <br />
                <table  id="printableArea1" style="width: 100%; margin-left: auto; margin-right: auto;" border="0">
                    <tr>
                        <td width="60%">
                            <asp:Label Font-Size="X-Large" ForeColor="Blue" Text="ราคารวมทั้งหมด" runat="server"></asp:Label>
                            </td>
                        <td width="20%">
                            </td>
                        <td width="20%">
                            <asp:Label ID="lbl_total" Font-Size="X-Large" ForeColor="Blue" Text="0" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <%--<span style="color:red">*** ค่าจัดส่งชิ้นแรก 60 บาท ชิ้นต่อไปชิ้นละ 10 บาท ***</span>--%> 
                            <asp:Label ID="lbl_delivary" Text="" Font-Size="Larger" ForeColor="Red" runat="server"></asp:Label>
                        </td>
                    </tr>
                    </table>
                </div>          
            </div>
        <div class="row col-lg-8 col-sm-12 mx-auto text-center">
            <div class="col-6 mx-auto text-left">
                <a href="Default.aspx" class="btn btn-outline-primary mr-5"><font size="6">กลับไปยังหน้าสินค้า</font></a>
            </div>
            <div class="col-6 mx-auto text-right">
                <button type="button" class="btn btn-outline-primary" id="btn_confirm" onserverclick="btn_confirm_ServerClick" runat="server"><font size="6">ชำระสินค้า</font></button>
            </div>
        </div>

   <script>
        <%--function Del(index) {
            var id = document.getElementById('<%= txtH_id.ClientID %>');
            var qty = document.getElementById('<%= txtH_qty.ClientID %>');
            var del = document.getElementById('<%= txtH_del.ClientID %>');
            del.value = index;

            var id_ar = id.value.split(',');
            var qty_ar = qty.value.split(',');
            
            var id_new = '';
            var qty_new = '';
            for (var i = 1; i < (id_ar.length - 1); i++) {
                
                if (del.value != id_ar[i]) {
                    id_new = id_new + id_ar[i] + ',';
                }
                alert(id_ar[i]);
                if (del.value != qty_ar[i]) {
                    qty_new = qty_new + qty_ar[i] + ',';
                }
            }

            id.value = id_new;
            qty.value = qty_new;
        }--%>

       function ConfirmDel() {
           var del = document.getElementById('<%= txtH_del.ClientID %>');
           if (confirm('คุณต้องการยกเลิกการสั่งซื้อใช่หรือไม่ ?')) {
               del.value = 'Yes';
           }
       }
    </script>
        
</asp:Content>
