<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="BRH_Plubic.Employee._default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentDesktop" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <button id="btn_Export" class="btn btn-primary" onserverclick="btn_Export_ServerClick" runat="server" visible="false">Export Excel</button>

    <div class="col-12 mx-auto text-center">
        <asp:GridView ID="GridView1" runat="server"></asp:GridView>
    </div>

</asp:Content>
