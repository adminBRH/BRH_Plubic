<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Test.aspx.cs" Inherits="BRH_Plubic.Test" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">

    <div class="row col-12 mx-auto my-5">

        <div class="col-6 mx-auto text-center">
            <input id="txt_salt" value="" class="form-control" placeholder="สร้างกุญแจ" runat="server" />
        </div>
        <div class="col-6 mx-auto text-left">
            <a id="btn_salt" class="btn btn-info" style="cursor: pointer;" onserverclick="btn_salt_ServerClick" runat="server">Salt</a>
        </div>

        <div class="col-6 mx-auto text-center">
            <input id="txt_pass" value="" class="form-control" placeholder="สร้างรหัสผ่าน" runat="server" />
        </div>
        <div class="col-6 mx-auto text-left">
            <a id="btn_pass" class="btn btn-outline-primary" style="cursor: pointer;" onserverclick="btn_pass_ServerClick" runat="server">Pass</a>
        </div>

        <div class="col-6 mx-auto mt-3 text-center">
            <input id="txt_hash" value="" class="form-control" placeholder="สร้างรหัสผ่านจากการเข้ารหัส" runat="server" />
        </div>
        <div class="col-6 mx-auto mt-3 text-left">
            <a id="btn_hash" class="btn btn-info" style="cursor: pointer;" onserverclick="btn_hash_ServerClick" runat="server">Hash</a>
        </div>
        
        <div class="col-6 mx-auto mt-5 text-center">
            <asp:Label ID="lbl_test" Text="" runat="server"></asp:Label>
        </div>
        <div class="col-6 mx-auto mt-5 text-left">
            <a id="btn_check" class="btn btn-primary" style="cursor: pointer;" onserverclick="btn_check_ServerClick" runat="server">Check</a>
        </div>
    </div>


</asp:Content>
