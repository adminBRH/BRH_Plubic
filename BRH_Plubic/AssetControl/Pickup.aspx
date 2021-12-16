<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Pickup.aspx.cs" Inherits="BRH_Plubic.AssetControl.Pickup" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentDesktop" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="row col-12 mx-auto my-auto" style="font-size: x-large;">
        <div class="col-6 mx-auto my-auto text-right">
            ต้องการเบิก :
        </div>
        <div class="col-6 mx-auto my-auto">
            <asp:DropDownList ID="dd_pickup" runat="server">
                <asp:ListItem Text="" Value=""></asp:ListItem>
            </asp:DropDownList>
        </div>
    </div>

</asp:Content>
