<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MsTeamAgreeDetail.aspx.cs" Inherits="BRH_Plubic.MsTeamAgreeDetail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">

    <div class="col-11 container mx-auto">
        <div class="card card-header bg-info text-center h1">
            ข้อมูลเพิ่มเติม
        </div>
        <div class="card card-body" style="font-size: 30px">
            <div class="row col-12">
                <div class="col-4 text-right">
                    ID :
                </div>
                <div class="col-7 btn btn-light text-left">
                    <asp:Label ID="lbl_msid" Text="" runat="server"></asp:Label>
                </div>
                <div class="col-4 text-right">
                    วันที่สมัคร :
                </div>
                <div class="col-7 btn btn-light text-left">
                    <asp:Label ID="lbl_date" Text="" runat="server"></asp:Label>
                </div>
                <div class="col-4 text-right">
                    ชื่อ - นามสกุล :
                </div>
                <div class="col-7 btn btn-light text-left">
                    <asp:Label ID="lbl_nameTH" Text="" runat="server"></asp:Label>
                </div>
                <div class="col-4 text-right">
                    Name :
                </div>
                <div class="col-7 btn btn-light text-left">
                    <asp:Label ID="lbl_nameEN" Text="" runat="server"></asp:Label>
                </div>
                <div class="col-4 text-right">
                    เพศ :
                </div>
                <div class="col-7 btn btn-light text-left">
                    <asp:Label ID="lbl_gender" Text="" runat="server"></asp:Label>
                </div>
                <div class="col-4 text-right">
                    วันเดือนปีเกิด :
                </div>
                <div class="col-7 btn btn-light text-left">
                    <asp:Label ID="lbl_dob" Text="" runat="server"></asp:Label>
                </div>
                <div class="col-4 text-right">
                    ประเภทบัตร :
                </div>
                <div class="col-7 btn btn-light text-left">
                    <asp:Label ID="lbl_cardtype" Text="" runat="server"></asp:Label>
                </div>
                <div class="col-4 text-right">
                    เลขที่บัตร :
                </div>
                <div class="col-7 btn btn-light text-left">
                    <asp:Label ID="lbl_cardnum" Text="" runat="server"></asp:Label>
                </div>
                <div class="col-4 text-right">
                    เบอร์โทรศัพท์ :
                </div>
                <div class="col-7 btn btn-light text-left">
                    <asp:Label ID="lbl_phone" Text="" runat="server"></asp:Label>
                </div>
                <div class="col-4 text-right">
                    อีเมล :
                </div>
                <div class="col-7 btn btn-light text-left">
                    <asp:Label ID="lbl_email" Text="" runat="server"></asp:Label>
                </div>
                <div class="col-4 text-right">
                    ไอดีไลน์ :
                </div>
                <div class="col-7 btn btn-light text-left">
                    <asp:Label ID="lbl_idline" Text="" runat="server"></asp:Label>
                </div>
                <div class="col-4 text-right">
                    เหตุผล :
                </div>
                <div class="col-7 btn btn-light text-left">
                    <asp:Label ID="lbl_reason" Text="" runat="server"></asp:Label>
                </div>
            </div>
        </div>
        <div class="card card-footer bg-info">

        </div>
    </div>

</asp:Content>
