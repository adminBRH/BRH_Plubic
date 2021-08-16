<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Doctor.aspx.cs" Inherits="BRH_Plubic.ARIQ.Doctor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">

    <div class="row col-12 mx-auto">
        <div class="col-4 text-right mb-3 h3">ชื่อ - นามสกุล หมอ :</div>
        <div class="col-6 mb-3"><input type="text" id="txt_doctor" class="form-control" placeholder="กรุณากรอกข้อมูล" runat="server" style="font-size:x-large" /></div>
        <div class="col-4 text-right h3">หมายเหตุ</div>
        <div class="col-6"><input type="text" id="txt_status" class="form-control" placeholder="เช่น ออกตรวจ" runat="server" style="font-size:x-large" /></div>
        <div class="col-2 text-right">&nbsp;</div>
        <div class="col-8 mx-auto text-center my-5">
            <asp:RadioButtonList ID="rdl_room" RepeatDirection="Horizontal" Font-Size="X-Large" CssClass="col-12" runat="server">
                <asp:ListItem Value="1" Text="ห้อง 1 " Selected="True"></asp:ListItem>
                <asp:ListItem Value="2" Text="ห้อง 2 "></asp:ListItem>
                <asp:ListItem Value="3" Text="ห้อง 3 "></asp:ListItem>
                <asp:ListItem Value="4" Text="ห้อง 4 "></asp:ListItem>
                <asp:ListItem Value="5" Text="ห้อง 5 "></asp:ListItem>
                <asp:ListItem Value="6" Text="ห้อง 6 "></asp:ListItem>
                <asp:ListItem Value="7" Text="ห้อง 7 "></asp:ListItem>
            </asp:RadioButtonList>
            <asp:Button ID="btn_submit" CssClass="btn btn-light mt-5" Text="Submit" OnClick="btn_submit_Click" runat="server" />
        </div>
    </div>

</asp:Content>
