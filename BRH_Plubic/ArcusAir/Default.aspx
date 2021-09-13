<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="BRH_Plubic.ArcusAir.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentDesktop" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<style>
    .boxMain {
        padding: 10px;
        background-color: #0d7fa3;
        color: white;
        font-size: xx-large;
        text-shadow: 2px 2px 2px #808080;
        border: solid;
        border-radius: 20px;
        font-weight: bold;
    }
    .boxMain:hover {
        cursor:pointer;
        border-bottom-color: gray;
        color: chartreuse;
    }
    .iconMain {
        width: 45px; 
        height: 45px;
    }
</style>

    <div class="row col-12 mx-auto my-5 fontGoogle">
        <div class="col-lg-4 col-sm-10 mx-auto my-3 boxMain" onclick="window.location.href='https://ArcusAir.bdms.co.th'">
            <img src="images/icon/arcus-white-ico.ico" class="iconMain" /> Arcus Air.
        </div>
        <div class="col-lg-4 col-sm-10 mx-auto my-3 boxMain" onclick="window.location.href='GenerateBarcode'">
            <img src="images/icon/barcode_icon.png" class="iconMain" /> Create Barcode.
        </div>
    </div>
</asp:Content>
