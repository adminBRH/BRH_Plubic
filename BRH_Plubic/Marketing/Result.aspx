<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Result.aspx.cs" Inherits="BRH_Plubic.Marketing.Result" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">

    <div class="col-lg-8 col-sm-12 mx-auto text-center mb-5">
            <div class="col-12 text-right">
                <span style="color:red; font-size:large">ท่านที่ประสงค์เข้ามารับสินค้าเอง ณ จุดจำหน่ายกรุณาบันทึก หรือปริ้นหน้านี้ไว้ เพื่อใช้สำหรับติดต่อรับสินค้า</span>
            </div>
        <div id="printArea" class="col-12 mx-auto">
            <div class="card card-head bg-info" style="color:white"><font size="6">สรุปยอดการสั่งซื้อสินค้าทั้งหมด</font></div>
            <div class="card card-body">

                <div class="text-left mb-3"><asp:Label ID="lbl_name" Font-Size="Larger" ForeColor="Blue" Text="ชื่อ นามสกุล" runat="server"></asp:Label></div>
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
                        <td width="60%" style="font-size:x-large">
                            ราคารวมทั้งหมด
                            </td>
                        <td width="20%">
                            </td>
                        <td width="20%">
                            <asp:Label ID="lbl_total" Font-Size="X-Large" Text="0" runat="server"></asp:Label>&nbsp;บาท
                        </td>
                    </tr>
                    <tr>
                        <td>
                            ค่าส่วนลด
                            </td>
                        <td>
                            </td>
                        <td>
                            <asp:Label ID="lbl_discount" Text="0" runat="server"></asp:Label>&nbsp;บาท
                        </td>
                    </tr>
                    <tr>
                        <td>
                            ค่าจัดส่ง
                            </td>
                        <td>
                            </td>
                        <td>
                            <asp:Label ID="lbl_ship" Text="0" runat="server"></asp:Label>&nbsp;บาท
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label Font-Size="X-Large" ForeColor="Blue" Text="ยอดเงินที่ชำระ" runat="server"></asp:Label>
                            </td>
                        <td>
                            </td>
                        <td>
                            <asp:Label ID="lbl_nettotal" Font-Size="X-Large" ForeColor="Blue" Text="0" runat="server"></asp:Label>
                        </td>
                    </tr>
                    </table>
                </div>   
                <div class="card card-footer text-left bg-transparent h5 mb5" style="color:red; font-size:medium;">
                    หมายเหตุ : <br />
                        - ลูกค้าสามารถมารับคูปองโปรแกรมสุขภาพ ณ ศูนย์จำหน่ายบัตรชีววัฒนะ ชั้น 1 ทุกวัน เวลา 08.00 – 17.00 น.<br />
                        - คูปองสามารถใช้สิทธิ์ได้ภายใน 30 วัน นับตั้งแต่วันที่ซื้อคูปอง<br />
                        - ติดต่อสอบถามเพิ่มเติมโทร 083 921 999 ต่อ 1887<br />
                </div>
                <div class="card card-footer text-center bg-transparent h5 mb5">
                    คำสั่งซื้อของคุณลูกค้า ทางโรงพยาบาลกรุงเทพระยอง จะดำเนินตามขั้นตอนการสั่งซื้อ
                </div>
        </div>
        <div class="row col-10 mx-auto text-center">
            <div class="col-6 mx-auto text-center">
                 <a href="#" id="btn_newOrder" class="btn btn-outline-primary" runat="server" onserverclick="btn_newOrder_ServerClick"><font size="4">เลือกซื้อสินค้าเพิ่ม</font></a>
            </div>
            <div class="col-6 mx-auto text-center">
                 <a class="btn btn-outline-primary" onclick="printDiv()"><font size="4">Print</font><i class="ti-printer"></i></a>
            </div>
        </div>
            </div>

<script>
    function printDiv() {
        var printContents = document.getElementById("printArea");
        var originalContents = document.body.innerHTML;
        printContents.setAttribute('style', 'width: 21cm; margin-left: auto; margin-right: auto;');
        document.body.innerHTML = printContents.innerHTML;
        window.print();
        document.body.innerHTML = originalContents;
    }
</script>

</asp:Content>
