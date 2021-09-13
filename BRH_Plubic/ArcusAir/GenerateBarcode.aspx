<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GenerateBarcode.aspx.cs" Inherits="BRH_Plubic.ArcusAir.GenerateBarcode" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentDesktop" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="row col-12 mx-auto my-5">
        <div class="col-10 mx-auto my-2 text-center">
            <input type="text" id="txt_user" class="col-lg-4 col-sm-8 mx-auto form-control" placeholder="Show Text" runat="server" />
        </div>
        <div class="col-10 mx-auto my-2 text-center">
            <input type="password" id="txt_pass" class="col-lg-4 col-sm-8 mx-auto form-control" placeholder="Password Arcusair" runat="server" />
        </div>
        <div class="col-lg-4 col-sm-8 mx-auto my-3 text-center">
            <table id="tablePrint" style="width: 100%;">
                <tr>
                    <td style="width: 100%;">
                        <div class="row col-12 mx-auto text-center">
                            <div class="col-12 mx-auto">
                                <img id="img_barcode" src="..." style="width: 100%; margin-top: 5px;" runat="server" />
                            </div>
                            <div class="col-12 mx-auto" style="font-size: xx-large">
                                <asp:Label ID="lbl_barcode" Text="" runat="server"></asp:Label>
                            </div>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div id="div_btnGen" class="col-12 mx-auto my-5 text-center" runat="server">
        <button id="btn_GenerateBarcode" class="btn btn-outline-primary" onserverclick="btn_GenerateBarcode_ServerClick" runat="server"> Generate Barcode </button>
    </div>
    <div id="div_btnPrint" class="row col-12 mx-auto my-5 text-center" runat="server" visible="false">
        <div class="col-6 mx-auto my-auto text-right">
            <button id="btn_newGen" class="btn btn-outline-success" onserverclick="btn_newGen_ServerClick" runat="server"><i class="fa fa-plus-circle"></i>New Generate</button>
        </div>
        <div class="col-6 mx-auto my-auto text-left">
            <button id="btn_print" class="btn btn-outline-primary" onclick="printContent('tablePrint')" data-toggle="tooltip" data-placement="top" title="แนะนำให้ปริ้นออก เครื่องสติ๊กเกอร์ยา">
                <i class="fa fa-print"></i>Print Barcode
            </button>
        </div>
        
    </div>
    <div class="col-12 mx-auto text-center" style="font-size: large; color: red;">
        ขอรับรองว่าระบบไม่ได้จัดเก็บ Password ของคุณเอาไว้ และผู้ดูแลก็ไม่สามารถรับรู้ Password ของท่านได้เช่นเดียวกัน
    </div>
    <div class="col-12 mx-auto text-center" style="color: blue;">
        ถ้าหากคุณทำการเปลี่ยน Password บนระบบ Arcus Air อย่าลืมกลับมา Generate Barcode ใหม่อีกครั้ง
    </div>

<script>
    function printContent(PrintAreaName) {
        var printContents = document.getElementById(PrintAreaName).innerHTML;
        var originalContents = document.body.innerHTML;
        document.body.innerHTML = printContents;
        window.print();
        document.body.innerHTML = originalContents;
    }
</script>

</asp:Content>
