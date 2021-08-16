<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ARIResult.aspx.cs" Inherits="BRH_Plubic.ARIResult" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>ARI Result</title>
    <script src="js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="css/bootstrap.min.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div class="card col-12 alert-heading" style="margin-top:50px; margin-left:50px; background-color:lightsteelblue">
                <a href="Default.aspx">
                    <img src="images/LOGO-BRH-Horizontal-ENG-Transparent.png" width="200" />
                </a>
            </div>

            <div id="div_next" class="col-11 mx-auto text-center my-5" runat="server" visible="false">
                <div class="card row col-12 mx-auto text-center bg-warning h2" style="color:white">
                    <br /><br />
                    <h1>บันทึกข้อมูลเรียบร้อยแล้ว</h1>
                    <div class="col-12 mx-auto text-center">
                    ต่อไปเป็นการเลือก วันและเวลา นัดหมาย
                    </div>
                    <br />
                    <div class="text-right" style="margin-right:20px">
                        <a href="ARIcalendar.aspx">
                        <img src="images/arrow_right.png" width="100" />
                        </a>
                    </div>
                    <br />
                </div>
            </div>

            <div id="div_finish" class="col-11 mx-auto text-center my-5" runat="server" visible="false">
                <div class="card row col-12 mx-auto text-center bg-info h2" style="color:white">
                    <br /><br />
                    <h1>คุณได้รับการนัดหมายที่ ARI Clinic</h1>
                    <div class="col-12 mx-auto text-center">
                    วันที่ <asp:Label ID="lbl_date" Text="" runat="server"></asp:Label> เวลา <asp:Label ID="lbl_time" Text="" runat="server"></asp:Label> เรียบร้อยแล้ว
                    </div>
                    <br /><br />
                </div>
                <span style="color:red; font-size:large" class="text-left">หมายเหตุ : หากต้องการเปลี่ยนแปลงกรุณาติดต่อเบอร์ 033-108999 Ext 2341</span> 
            </div>
            
        </div>
    </form>
</body>
</html>
