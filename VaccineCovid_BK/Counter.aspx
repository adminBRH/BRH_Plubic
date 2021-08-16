<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Counter.aspx.cs" Inherits="BRH_Plubic.VaccineCovid.Counter" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>VaccineCovid Counter</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <!-- 'Prompt', sans-serif -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Prompt:wght@200&display=swap" rel="stylesheet">

<style>
    .fontInvent {
        color: blue;
        font-size: 25px;
        font-family: 'Prompt', sans-serif;
        text-shadow: 2px 2px 2px #ffffff;
    }
    .syringe {
        width: 40px; 
        height: 40px;
    }

    .blink {
      animation: blink-animation 1s steps(5, start) infinite;
      -webkit-animation: blink-animation 1s steps(5, start) infinite;
    }
    .blink-one {
       animation: blink-animation 0.8s steps(5, start) infinite;
      -webkit-animation: blink-animation 0.8s steps(5, start) infinite;
    }
    .blink-two {
       animation: blink-animation 0.5s steps(5, start) infinite;
      -webkit-animation: blink-animation 0.5s steps(5, start) infinite;
    }
    @keyframes blink-animation {
      to {
        visibility: hidden;
      }
    }
    @-webkit-keyframes blink-animation {
      to {
        visibility: hidden;
      }
    }
</style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager_Master" runat="server"></asp:ScriptManager>
        <!-- ------------ Dose Counter ------------- -->
        <div class="col-12 mx-auto">
            <asp:UpdatePanel ID="UpdatePanel_invent" runat="server">
                <ContentTemplate>
                    <div class="row alert alert-dark col-12 mx-auto text-center fontInvent">
                        <div class="col-4 mx-auto">
                            ทั้งหมด <asp:Label ID="lbl_doseTotal" Text="0" runat="server"></asp:Label><img src="image/syringe_vaccine.png" class="syringe blink" />
                        </div>
                        <div class="col-4 mx-auto">
                            จองแล้ว <asp:Label ID="lbl_book" Text="0" runat="server"></asp:Label><img src="image/syringe_vaccine_book.png" class="syringe blink-one" />
                        </div>
                        <div class="col-4 mx-auto">
                            เหลือ <asp:Label ID="lbl_invent" Text="0" runat="server"></asp:Label><img src="image/syringe_vaccine.png" class="syringe blink-two" />
                        </div>
                    </div>
                </ContentTemplate>
                <Triggers>
                </Triggers>
            </asp:UpdatePanel>
        </div>
        <!-- ------------ Dose Counter ------------- -->
    </form>
</body>
</html>
