<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TimelineReport.aspx.cs" Inherits="BRH_Plubic.Covid19.TimelineReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentDesktop" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<style>
    .TablePrint {
        width: 21cm; 
        /*height: 29.7cm;*/
        margin-top: 0;
        margin-left: auto; 
        margin-right: auto;
    }
    .DotUnder {
        border-bottom:black 1px dotted;
    }
</style>

<table id="printableArea" width="100%" class="TablePrint" border="1">
    <tr>
        <td style="width: 100%;">

            <div class="row col-12 mx-auto my-3">
                <div class="col-12 mx-auto text-center">
                    <b>Timelime 14 วัน เพื่อส่งสำนักงานสาธารณสุขจังหวัด</b>
                    <br />(กรุณาให้ข้อมูลที่เป็นจริง เพื่อประโยชน์ต่อการควบคุมโรค)
                </div>
                <div class="col-8 mx-auto">
                    <b>ชื่อ-สกุล</b> <span class="DotUnder">&nbsp;&nbsp;&nbsp;<asp:Label ID="lbl_name" Text="" runat="server"></asp:Label>&nbsp;&nbsp;&nbsp;</span>
                </div>
                <div class="col-4 mx-auto">
                    <b>โทร</b> <span class="DotUnder">&nbsp;&nbsp;&nbsp;<asp:Label ID="lbl_phone" Text="" runat="server"></asp:Label>&nbsp;&nbsp;&nbsp;</span>
                </div>
                <div class="col-12 mx-auto">
                    <b>อาการเจ็บป่วย</b> 
                    (<asp:Label ID="lbl_symptomNo" Text="  " runat="server"></asp:Label>) ไม่มี 
                    (<asp:Label ID="lbl_symptomYes" Text="  " runat="server"></asp:Label>) มี 
                    วันที่เริ่มมีอาการ <span class="DotUnder">&nbsp;&nbsp;&nbsp;<asp:Label ID="lbl_symptomDate" Text="" runat="server"></asp:Label>&nbsp;&nbsp;&nbsp;</span>
                </div>
                <div class="col-12 mx-auto">
                    <b>วันที่เก็บสิ่งส่งตรวจ (ป้ายจมูกเพื่อตรวจ RT-PCR)</b> <span class="DotUnder">&nbsp;&nbsp;&nbsp;<asp:Label ID="lbl_pcrdate" Text="" runat="server"></asp:Label>&nbsp;&nbsp;&nbsp;</span>
                </div>
            </div>

        <script>
            function fn_details(txt) {
                var html = '';
                var tr = txt.split('|');
                for (var i = 0; i < tr.length; i++) {
                    html = html + '&nbsp;&nbsp;';
                    var td = tr[i].split('^');
                    for (var j = 0; j < td.length; j++) {
                        html = html + td[j];
                        html = html + '&nbsp;&nbsp;&nbsp;';
                    }
                    html = html + '<br />';
                }

                document.write(html);
            }
        </script>

            <div class="col-12 mx-auto">
                <b>ตารางกิจกรรม และการเดินทาง 14 วันหลังป่วย</b>
                <asp:ListView ID="LV_Details" runat="server">
                    <LayoutTemplate>
                        <table style="width: 100%; border-radius: 20px;" border="1">
                            <tr>
                                <td class="text-center" style="width: 5%"><b>ลำดับ</b></td>
                                <td class="text-center" style="width: 10%"><b>วันที่</b></td>
                                <td class="text-center" style="width: 75%"><b>เวลา &nbsp;&nbsp;&nbsp; กิจกรรม/สถานที่ &nbsp;&nbsp;&nbsp; จำนวนผู้เข้าร่วมกิจกรรม (ระบุบุคคล หากทำได้)</b></td>
                            </tr>
                            <tr id="itemPlaceholder" runat="server"></tr>
                        </table>
                    </LayoutTemplate>
                    <ItemTemplate>
                        <tr>
                            <td class="text-center"><%# Eval("ctd_index") %></td>
                            <td class="text-center"><%# Eval("ctd_dateTH") %></td>
                            <td>
                                <script>fn_details('<%# Eval("ctd_details") %>');</script>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:ListView>
            </div>

        </td>
    </tr>
</table>
<div class="col-12 mx-auto my-5 text-center">
    <button id="btn_print" class="btn btn-outline-primary" onclick="printDiv()">PRINT <i class="ti-printer"></i></button>
</div>
<script>
    function printDiv() {
        var printContents = document.getElementById("printableArea").innerHTML;
        var originalContents = document.body.innerHTML;
        document.body.innerHTML = printContents;
        window.print();
        document.body.innerHTML = originalContents;
    }
</script>
</asp:Content>
