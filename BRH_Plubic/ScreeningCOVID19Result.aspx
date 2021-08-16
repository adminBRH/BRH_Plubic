﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ScreeningCOVID19Result.aspx.cs" Inherits="BRH_Plubic.ScreeningCOVID19Result" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Screening COVID-19</title>
    <script src="js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="css/bootstrap.min.css" />

</head>
<body>
    <form id="form1" runat="server">
        <div class="col-12" id="divgreen" runat="server" visible="false">
            <div class="col-11 badge-success mx-auto mt-5 text-center card card-header" style="font-size:80px">
                ผ่านเกณฑ์ : Pass
            </div>
           
            <div class="col-11 badge-success mx-auto  text-center card card-body" style="font-size:50px">
                <div class="12 mx-auto"><img src="images/humangreen1.png" style="height:120px; width:120px;" /></div>
                No indication for COVID-19 infection
            </div>
        </div>   
        
        <div class="col-12" id="divred" runat="server" visible="false">
            <div class="col-11 bg-danger mx-auto mt-5 text-center card card-header h1" style="color:white; font-size:80px;">    
                ไม่ผ่านเกณฑ์ : Failed screening
            </div> 

            <div class="col-11 bg-danger mx-auto  text-center card card-body" style="font-size:50px; color:white;">
                <div class="12 mx-auto"><img src="images/humanred.png" style="height:120px; width:120px;" /></div>
                กรุณาติดต่อเจ้าหน้าที่ก่อนเข้ารับการตรวจ เพื่อขอข้อมูลเพิ่มเติม<br />
                Please contact staff before further investigation.
            </div>
        </div>
           

    </form>
</body>
</html>
