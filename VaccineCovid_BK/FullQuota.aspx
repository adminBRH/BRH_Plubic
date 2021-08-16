<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FullQuota.aspx.cs" Inherits="BRH_Plubic.VaccineCovid.FullQuota" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentDesktop" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<style>
    .fontTopic {
        color: black;
        font-size: xx-large;
        text-shadow: 2px 2px 2px #808080;
    }
    .fontDetail {
        font-size: x-large;
    }
    .fontlink {
        font-size: large;
        color: blue;
        text-shadow: 2px 2px 2px #ffd800;
    }
    .cardTopic {
        /*border: double;
        border-color: gold;
        border-radius: 20px;*/
    }
    .bkTopic {
        background-image: url(image/BK_coronavirus_blue.jpg);
        background-repeat: no-repeat;
        background-size: cover;
        border-radius: 20px;
    }
</style>

    <div class="col-11 mx-auto my-5 bkTopic fontTopic">
        <p>&nbsp;</p>
        <p>&nbsp;</p>
        <p>&nbsp;</p>
        <div class="row col-lg-8 col-sm-12 mx-auto my-5 cardTopic">
            <div class="col-12 mx-auto text-center">
                โรงพยาบาลกรุงเทพระยอง ต้องขออภัยอย่างสูง
            </div>
            <div class="col-12 mx-auto text-center">
                ขณะนี้ยอดการจองวัคซีน Moderna เต็มหมดแล้ว
            </div>
            <div class="col-12 mx-auto text-center">
                หากมีวัคซีนเข้ามาเพิ่มจะรีบแจ้งให้ท่านทราบโดยเร็วที่สุด
            </div>
        </div>
        <p>&nbsp;</p>
        <p>&nbsp;</p>
        <p>&nbsp;</p>
        <div class="row col-12 mx-auto fontDetail">
            <div class="col-2 mx-auto">&nbsp;</div>
            <div class="col-10 mx-auto">
                ขอให้ติดตามข่าวสารของทางโรงพยาบาลกรุงเทพระยอง ผ่านช่องทางดังนี้ 
            </div>
            <div class="col-2 mx-auto">&nbsp;</div>
            <div class="col-10 mx-auto">
                Website : <a target="_blank" class="fontlink" href="https://bangkokhospitalrayong.com">https://bangkokhospitalrayong.com</a>
            </div>
            <div class="col-2 mx-auto">&nbsp;</div>
            <div class="col-10 mx-auto">
                Facebook : <a target="_blank" class="fontlink" href="https://www.facebook.com/BangkokRayong">โรงพยาบาลกรุงเทพระยอง</a>
            </div>
            <div class="col-2 mx-auto">&nbsp;</div>
            <div class="col-10 mx-auto">
                LINE Official : <a class="fontlink" href="https://page.line.me/bangkokrayong">@bangkokrayong</a>
            </div>
            <div class="col-2 mx-auto">&nbsp;</div>
            <div class="col-10 mx-auto">
                Instagram : <a class="fontlink" href="https://www.instagram.com/bangkokhospitalrayong">bangkokhospitalrayong</a> 
            </div>
        </div>
        <p>&nbsp;</p>
        <p>&nbsp;</p>
        <p>&nbsp;</p>
    </div>

</asp:Content>
