<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EmailAuto.aspx.cs" Inherits="BRH_Plubic.EmailAuto" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">
    <div class="mx-auto text-center">
        <asp:Button ID="btn_sendmail" CssClass="col-2 btn btn-light" OnClick="btn_sendmail_Click" Text="TEST" runat="server" />
    </div>
</asp:Content>
