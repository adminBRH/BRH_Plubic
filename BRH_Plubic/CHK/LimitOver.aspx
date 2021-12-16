<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LimitOver.aspx.cs" Inherits="BRH_Plubic.CHK.LimitOver" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>BRH Queue Limit</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="../css/bootstrap.min.css">
</head>
<body>
    <form id="form1" runat="server">
        <div class="row col-12 mx-auto">
            <div class="col-10 mx-auto my-5 text-center h1" style="color: red;">
                <%--ขณะนี้มีจำนวนคนเข้าใช้งานระบบมากเกินไป<br />
                ทางเรากำลังพยายามเร่งแก้ไข<br />
                กรุณากลับเข้ามาใหม่ในภายหลัง--%>
           <%--     ขออภัยในความไม่สะดวก<br />
                เนื่องจากระบบมีการจำกัดจำนวนผู้เข้าใช้งาน 50คน/15นาที<br />
                กรุณากลับเข้ามาใหม่ในภายหลัง--%>
                <br />
                ขณะนี้คิวการฉีดวัคซีนรอบที่ 1 เต็มแล้ว
            </div>
            <div class="col-12 mx-auto text-center">
                <a href="../VaccineCovid/Lot1Confirm" class="btn btn-outline-primary">กลับสู่หน้าตรวจสอบสิทธิ์</a>
            </div>
        </div>
    </form>
</body>
</html>
