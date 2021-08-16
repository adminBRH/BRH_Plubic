<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Detail.aspx.cs" Inherits="BRH_Plubic.Marketing.Detail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">

    <div id="printableArea" class="col-11 mx-auto" runat="server">
        <div class="card card-header bg-primary h3" style="color:white">
            <div class="row">
                <div class="col-6 text-left">รายละเอียดการสั่งซื้อสินค้า</div>
                <div class="col-6 text-right">
                    <button id="btn_send" class="btn btn-light" onserverclick="btn_send_ServerClick" runat="server" visible="false">รับแล้ว / จัดส่งแล้ว</button>
                </div>
            </div>
        </div>
        <div class="card card-body">
            <div class="col-12 mx-auto">
                <div class="row mx-auto">
                    <div class="col-4 text-right">
                        เลขที่การสั่งซื้อ : 
                    </div>
                    <div class="col-8 text-left">
                        <asp:Label ID="lbl_docno" Text="" runat="server"></asp:Label>
                    </div>
                    <div class="col-4 text-right">
                        วันเวลาที่สั่งซื้อ : 
                    </div>
                    <div class="col-8 text-left">
                        <asp:Label ID="lbl_date" Text="" runat="server"></asp:Label>
                    </div>
                    <div class="col-4 text-right">
                        ชื่อ : 
                    </div>
                    <div class="col-8 text-left">
                        <asp:Label ID="lbl_name" Text="" runat="server"></asp:Label>
                    </div>
                    <div class="col-4 text-right">
                        ช่องทางการจัดส่ง : 
                    </div>
                    <div class="col-8 text-left">
                        <asp:Label ID="lbl_shipping" Text="" runat="server"></asp:Label>
                    </div>
                    <div class="col-4 text-right">
                        เบอร์โทรศัพท์ : 
                    </div>
                    <div class="col-8 text-left">
                        <asp:Label ID="lbl_phone" Text="" runat="server"></asp:Label>
                    </div>
                    <div class="col-4 text-right">
                        ที่อยู่จัดส่ง : 
                    </div>
                    <div class="col-8 text-left">
                        <asp:Label ID="lbl_address" Text="" runat="server"></asp:Label>
                    </div>
                    <div class="col-12 mx-auto my-3">
                        <table id="table_detail" width="100%" border="1">
                            <tr>
                                <td width="40%" style="text-align: center; background-color:lightskyblue">รายการ</td>
                                <td width="10%" style="text-align: center; background-color:lightskyblue">จำนวน</td>
                                <td width="10%" style="text-align: center; background-color:lightskyblue">ราคา/หน่วย</td>
                                <td width="10%" style="text-align: center; background-color:lightskyblue">รวม</td>
                                <td width="10%" style="text-align: center; background-color:lightskyblue">ส่วนลด</td>
                                <td width="10%" style="text-align: center; background-color:lightskyblue">สุทธิ</td>
                            </tr>
                            <asp:Label ID="lbl_detail" Text="" runat="server"></asp:Label>
                        </table>
                        <table width="100%" border="0">
                            <tr>
                                <td width="70%" style="text-align: right">รวมทั้งหมด</td>
                                <td width="10%"></td>
                                <td width="20%" style="text-align: left"><asp:Label ID="lbl_total" Text="" runat="server"></asp:Label></td>
                            </tr>
                            <tr>
                                <td style="text-align: right">หักค่าส่วนลด</td>
                                <td></td>
                                <td style="text-align: left"><asp:Label ID="lbl_discont" Text="" runat="server"></asp:Label></td>
                            </tr>
                            <tr>
                                <td style="text-align: right">ค่าจัดส่ง</td>
                                <td></td>
                                <td style="text-align: left"><asp:Label ID="lbl_send" Text="" runat="server"></asp:Label></td>
                            </tr>
                            <tr>
                                <td style="text-align: right">ยอดที่ต้องชำระ</td>
                                <td></td>
                                <td style="text-align: left"><b><asp:Label ID="lbl_pay" Text="" runat="server"></asp:Label></b></td>
                            </tr>
                        </table>
                    </div>
                    <div class="col-4 text-right">
                        สถานะชำระ : 
                    </div>
                    <div class="col-8 text-left">
                        <asp:Label ID="lbl_paystatus" Text="" runat="server"></asp:Label>
                    </div>
                    <div hidden="hidden">
                        <input type="text" id="txtH_confirm" value="" runat="server" />
                    </div>
                    <div class="col-4 text-right">
                        ยอดที่โอน : 
                    </div>
                    <div class="col-8 text-left">
                        <asp:Label ID="lbl_payslip" Text="" runat="server"></asp:Label>
                    </div>
                    <div class="col-4 text-right">
                        วันเวลาที่โอน : 
                    </div>
                    <div class="col-8 text-left">
                        <asp:Label ID="lbl_timeslip" Text="" runat="server"></asp:Label>
                    </div>
                    <div class="col-4 text-right">&nbsp;</div>
                    <div class="col-8 text-left">
                        <asp:Image ID="imgSlip" ImageUrl="..." Width="30%" runat="server" />
                        <div id="div_confirm" class="col-12" runat="server" visible="false">
                            <asp:Button ID="btn_confirmSlip" CssClass="btn btn-outline-primary" OnClick="btn_confirmSlip_Click" Text="confirm" OnClientClick="confirmPay('confirm')" runat="server" />
                            <asp:Button ID="btn_cancelSlip" CssClass="btn btn-outline-danger" OnClick="btn_cancelSlip_Click" Text="cancel" OnClientClick="confirmPay('cancel')" runat="server" />
                        </div>
                    </div>
                    <script>
                        function confirmPay(status) {
                            var txtConFirm = document.getElementById('<%= txtH_confirm.ClientID %>');
                            if (status == 'confirm') {
                                if (confirm('คุณต้องการ confirm ยอดชำระการสั่งซื้อใช่หรือไม่ ?')) {
                                    txtConFirm.value = status;
                                }
                            }
                            if (status == 'cancel') {
                                if (confirm('คุณต้องการยกเลิกยอดชำระการสั่งซื้อนี้ใช่หรือไม่ ?')) {
                                    txtConFirm.value = status;
                                }
                            }
                        }
                    </script>
                    <div class="col-4 text-right">
                        รับ/จัดส่ง : 
                    </div>
                    <div class="col-8 text-left">
                        <asp:Label ID="lbl_receive" Text="" runat="server"></asp:Label>
                    </div>
                    <div class="col-4 text-right">
                        วันเวลา รับ/จัดส่ง : 
                    </div>
                    <div class="col-8 text-left">
                        <asp:Label ID="lbl_receivedate" Text="" runat="server"></asp:Label>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="mx-auto text-center mt-3">
        <input id="btn_print" type="button" class="btn btn-outline-info mx-5" onclick="printDiv()" value="PRINT" runat="server" />
    </div>

    <script>
        function printDiv() {
            var printContents = document.getElementById("<%= printableArea.ClientID %>").innerHTML;
            var originalContents = document.body.innerHTML;
            document.body.innerHTML = printContents;
            window.print();
            document.body.innerHTML = originalContents;
        }
    </script>

</asp:Content>
