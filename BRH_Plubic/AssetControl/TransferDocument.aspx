<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TransferDocument.aspx.cs" Inherits="BRH_Plubic.AssetControl.TransferDocument" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentDesktop" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .bgHeader {
            background-color: gainsboro; font-weight: bold;
        }
    </style>

    <div class="col-11 mx-auto">
        <table id="printableArea" style="width: 100%;" border="1">
            <tr>
                <td style="width: 100%">
                    <table style="width: 100%" border="1">
                        <tr>
                            <td colspan="2">
                                <img src="../images/LOGO-BRH-Horizontal-ENG-Transparent.png" style="width: 100%;" />
                            </td>
                            <td colspan="7" style="font-size: large; text-align: center;">
                                <b>แบบบันทึกการโอนย้ายทรัพย์สินระหว่างหน่วยงาน</b>
                            </td>
                        </tr>
                        <tr style="background-color: gainsboro; font-weight: bold; text-align: center;">
                            <td style="width: 5%">ลำดับ</td>
                            <td style="width: 18%">รายการทรัพย์สิน</td>
                            <td style="width: 5%">ประเภท</td>
                            <td style="width: 12%">หมายเลข<br />ทรัพย์สินบัญชี</td>
                            <td style="width: 12%">Code<br />เครื่องมือแพทย์</td>
                            <td style="width: 12%">วันที่<br />ซื้อทรัพย์สิน</td>
                            <td style="width: 12%">วันที่<br />ครบอายุใช้งาน</td>
                            <td style="width: 12%">ราคาทุน</td>
                            <td style="width: 12%">มูลค่าคงเหลือ<br />ณ ปัจจุบัน</td>
                        </tr>
                        <tr>
                            <td class="text-center" style="width: 5%">&nbsp;</td>
                            <td class="text-center" style="width: 18%">&nbsp;</td>
                            <td class="text-center" style="width: 5%">&nbsp;</td>
                            <td class="text-center" style="width: 12%">&nbsp;</td>
                            <td class="text-center" style="width: 12%">&nbsp;</td>
                            <td class="text-center" style="width: 12%">&nbsp;</td>
                            <td class="text-center" style="width: 12%">&nbsp;</td>
                            <td class="text-center" style="width: 12%">&nbsp;</td>
                            <td class="text-center" style="width: 12%">&nbsp;</td>
                        </tr>
                        <tr>
                            <td colspan="9" style="width: 100%">
                                เหตุผลการโอนย้าย ..................................................................................................................................................................................................
                                <br />.................................................................................................................................................................................................................................................
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="width: 100%">
                    <table style="width: 100%; text-align: center;" border="1">
                        <tr style="background-color: gainsboro; font-weight: bold;">
                            <td colspan="2" style="width: 50%">
                                แผนกผู้โอนทรัพย์สิน ................................................. รหัสแผนก....................
                            </td>
                            <td style="width: 25%">
                                กรณีโอนย้ายทรัพย์สิน<br />ประเภทเครื่องมือแพทย์
                            </td>
                            <td style="width: 25%">
                                ผู้อนุมัติ
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 25%;">
                                ลงชื่อ.....................................ผู้โอนทรัพย์สิน
                                <br />(……………………………………….)
                                <br />วันที่ ...............................................
                                <br />หัวหน้าแผนก
                            </td>
                            <td style="width: 25%;">
                                ลงชื่อ.........................................ผู้อนุมัติโอน
                                <br />(……………………………………….)
                                <br />วันที่ ...............................................
                                <br />
                            </td>
                            <td rowspan="3" style="width: 25%;" class="my-auto">
                                ลงชื่อ.........................................รับทราบ
                                <br />(……………………………………….)
                                <br />วันที่ ...............................................
                                <br />
                            </td>
                            <td rowspan="3" style="width: 25%;" class="my-auto">
                                ลงชื่อ.........................................อนุมัติ
                                <br />(……………………………………….)
                                <br />วันที่ ...............................................
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="width: 50%; background-color: gainsboro; font-weight: bold; text-align: center;">
                                แผนกผู้รับโอนทรัพย์สิน ................................................. รหัสแผนก....................
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 25%;">
                                ลงชื่อ.....................................ผู้รับโอนทรัพย์สิน
                                <br />(……………………………………….)
                                <br />วันที่ ...............................................
                                <br />
                            </td>
                            <td style="width: 25%;">
                                ลงชื่อ..................................... ผู้อนุมัติรับโอน
                                <br />(……………………………………….)
                                <br />วันที่ ...............................................
                                <br />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div class="col-12 mx-auto my-5 text-center">
        <button class="btn btn-outline-primary" onclick="printA4('printableArea')"> PRINT </button>
    </div>

</asp:Content>
