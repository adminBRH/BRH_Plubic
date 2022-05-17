<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="BRH_Plubic.AssetControl.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentDesktop" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<style>
    .boxMain {
        /*position: absolute;*/
        padding: 25px;
        margin: auto;
    }
    .buttonMain {
        cursor: pointer;
        background-color: Highlight;
        height: 150px;
        border-radius: 50px;
        border-top-right-radius: unset;
        color: white;
        text-shadow: 2px 2px 2px #000000;
        box-shadow: 4px 4px 2px #808080;
    }
    .buttonIcon {
        position: absolute;
        top: -5px;
        right: 30px;
        width: 80px;
        height: 100px;
        border-bottom-left-radius: 110px;
        border-bottom-right-radius: 110px;
        background-color: white;
    }
    .icon {
        margin-top: 10px;
        color: Highlight;
        font-size: 60px;
        text-shadow: 4px 4px 2px #808080;
    }
</style>

    <link rel="stylesheet" href="css/PostCard.css">
    
    <div class="row col-12 mx-auto boxMain">
        <div class="card col-sm-10 col-lg-5 mx-auto my-3 buttonMain" onclick="alert('ยังไม่เปิดให้ใช้งาน !!');">
            <div class="text-center my-auto my-auto buttonIcon">
                <i class="fa fa-hospital-o icon"></i>
            </div>
            <p class="h3">Manage Department.</p>
            <p class="h5">หน้าจัดการรายชื่อแผนกที่จัดเก็บ</p>
        </div>
        <div class="card col-sm-10 col-lg-5 mx-auto my-3 buttonMain" onclick="fn_link('AssetCate')">
            <div class="text-center my-auto my-auto buttonIcon">
                <i class="fa fa-cubes icon"></i>
            </div>
            <p class="h3">Manage Category.</p>
            <p class="h5">หน้าจัดการหมวดหมู่ของทรัพย์สิน</p>
        </div>
        <div class="card col-sm-10 col-lg-5 mx-auto my-3 buttonMain" onclick="fn_link('AssetType')">
            <div class="text-center my-auto my-auto buttonIcon">
                <i class="fa fa-sliders icon"></i>
            </div>
            <p class="h3">Manage Type.</p>
            <p class="h5">หน้าจัดการประเภทของทรัพย์สิน</p>
        </div>
        <div class="card col-sm-10 col-lg-5 mx-auto my-3 buttonMain" onclick="fn_link('Asset')">
            <div class="text-center my-auto my-auto buttonIcon">
                <i class="fa fa-archive icon"></i>
            </div>
            <p class="h3">Asset details.</p>
            <p class="h5">รายละเอียดทรัพย์สิน</p>
        </div>
        <div class="card col-sm-10 col-lg-5 mx-auto my-3 buttonMain" onclick="fn_link('Transfer')">
            <div class="text-center my-auto my-auto buttonIcon">
                <i class="fa fa-braille icon"></i>
            </div>
            <p class="h3">Transfer.</p>
            <p class="h5">โอนย้ายทรัพย์สิน</p>
        </div>
        <div class="card col-sm-10 col-lg-5 mx-auto my-3 buttonMain" onclick="fn_link('TransferList')">
            <div class="text-center my-auto my-auto buttonIcon">
                <i class="fa fa-list-ol icon"></i>
            </div>
            <p class="h3">Transfer list.</p>
            <p class="h5">รายการโอนย้ายทรัพย์สิน</p>
        </div>
    </div>

<script>
    function fn_link(page) {
        window.location.href = page;
    }
</script>

</asp:Content>
