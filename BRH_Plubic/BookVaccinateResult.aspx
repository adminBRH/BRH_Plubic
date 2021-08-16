<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BookVaccinateResult.aspx.cs" Inherits="BRH_Plubic.BookVaccinateResult" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">

    <div id="Result" class="section col-11 mx-auto text-center">
        <div class="card bg-info text-center">
            <h2 style="color:white">
                <asp:Label ID="lbl_name" Text="" runat="server"></asp:Label>
            </h2>
            <h3 style="color:white">
                ได้นัดหมายฉีดวัคซีนแบบ <asp:Label ID="lbl_comby" Text="" runat="server"></asp:Label> ที่ <asp:Label ID="lbl_location" Text="" runat="server"></asp:Label>
            </h3>
            <h3 style="color:white">
                วันที่ ...<asp:Label ID="lbl_bookdate" Text="" runat="server"></asp:Label>...
            </h3>
            <h3 style="color:white">
                โดยใช้สิทธิ์ ...<asp:Label ID="lbl_payer" Text="" runat="server"></asp:Label>...
            </h3>
            <h3 style="color:white">
                เป็นที่เรียบร้อย
            </h3>
        </div>
        <span style="color:red">***** หมายเหตุ หากต้องการยกเลิกหรือเปลี่ยนแปลงกรุณาติดต่อเบอร์ 038-921820 ******</span>

        <div class="col-12 text-center my-5">
            <a id="btn_reinput" class="btn bg-gradient" href="BookVaccinate.aspx" style="font-size:x-large; color:white;">ลงทะเบียนเพิ่มเติม</a>
        </div>
    </div>

</asp:Content>
