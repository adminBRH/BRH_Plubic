<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="report.aspx.cs" Inherits="BRH_Plubic.Happymoney.getUsers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentDesktop" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
   <div class="mx-auto text-center">
       <div>
           <asp:Button CssClass="btn btn-info mb-5" ID="btnExport" runat="server" OnClick="btnExport_Click" Text="Export to Excel" />
           
       </div>
       <asp:GridView CssClass="mx-auto text-center" ID="GridView1" runat="server"></asp:GridView>
   </div>
</asp:Content>
