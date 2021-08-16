<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShowQ.aspx.cs" Inherits="BRH_Plubic.ARIQ.ShowQ" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>ARI Queue</title>
    <script src="../js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="../css/bootstrap.min.css" />
</head>
<body style="background-color:darkblue">
    <form id="form1" runat="server">
        <div>
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

            <asp:UpdatePanel ID="UpdatePanel_ShowQ" runat="server">
                <ContentTemplate>

            <div id="ShowQ" class="section row col-12 mx-auto">

            <div class="row col-12 mx-auto text-center">
                <!-- ============================================== Header ============================================== -->
                <table width="100%" border="0">
                    <tr>
                        <td width="14%" style="color:white;">
                            <h1><asp:Label ID="lbl_doctor1" Text="" runat="server"></asp:Label></h1>
                            <h2><asp:Label ID="lbl_status1" CssClass="bg-secondary" Text="" runat="server"></asp:Label></h2>
                        </td>
                        <td width="14%" style="color:white;">
                            <h1><asp:Label ID="lbl_doctor2" Text="" runat="server"></asp:Label></h1>
                            <h2><asp:Label ID="lbl_status2" CssClass="bg-secondary" Text="" runat="server"></asp:Label></h2>
                        </td>
                        <td width="14%" style="color:white;">
                            <h1><asp:Label ID="lbl_doctor3" Text="" runat="server"></asp:Label></h1>
                            <h2><asp:Label ID="lbl_status3" CssClass="bg-secondary" Text="" runat="server"></asp:Label></h2>
                        </td>
                        <td width="14%" style="color:white;">
                            <h1><asp:Label ID="lbl_doctor4" Text="" runat="server"></asp:Label></h1>
                            <h2><asp:Label ID="lbl_status4" CssClass="bg-secondary" Text="" runat="server"></asp:Label></h2>
                        </td>
                        <td width="14%" style="color:white;">
                            <h1><asp:Label ID="lbl_doctor5" Text="" runat="server"></asp:Label></h1>
                            <h2><asp:Label ID="lbl_status5" CssClass="bg-secondary" Text="" runat="server"></asp:Label></h2>
                        </td>
                        <td width="14%" style="color:white;">
                            <h1><asp:Label ID="lbl_doctor6" Text="" runat="server"></asp:Label></h1>
                            <h2><asp:Label ID="lbl_status6" CssClass="bg-secondary" Text="" runat="server"></asp:Label></h2>
                        </td>
                        <td width="14%" style="color:white;">
                            <h1><asp:Label ID="lbl_doctor7" Text="" runat="server"></asp:Label></h1>
                            <h2><asp:Label ID="lbl_status7" CssClass="bg-secondary" Text="" runat="server"></asp:Label></h2>
                        </td>
                    </tr>
                    <tr>
                        <td style="background-color:cornflowerblue; font-size:60px; color:white;">ห้อง 1</td>
                        <td style="background-color:cornflowerblue; font-size:60px; color:white;">ห้อง 2</td>
                        <td style="background-color:cornflowerblue; font-size:60px; color:white;">ห้อง 3</td>                        
                        <td style="background-color:cornflowerblue; font-size:60px; color:white;">ห้อง 4</td>
                        <td style="background-color:cornflowerblue; font-size:60px; color:white;">ห้อง 5</td>
                        <td style="background-color:cornflowerblue; font-size:60px; color:white;">ห้อง 6</td>
                        <td style="background-color:cornflowerblue; font-size:60px; color:white;">ห้อง 7</td>
                    </tr>
                    <asp:Label ID="lbl_html" Text="" runat="server"></asp:Label>
                </table>
                <!-- ============================================== Header ============================================== -->

                <!-- ============================================== Body ============================================== -->

                <!-- ============================================== Body ============================================== -->
            </div>

            </div>

                    <asp:Timer ID="Timer1" runat="server" Interval="3000" OnTick="Timer1_Tick" ></asp:Timer>
                </ContentTemplate>
            </asp:UpdatePanel>

        </div>
        <div class="fixed-bottom">
            <div class="row col-12 mx-auto text-right">
                <div class="col-5">&nbsp;</div>
                <div class="col-auto btn btn-outline-success border-0" style="font-size:xx-large;">เขียว=เข้าพบแพทย์</div>
                <div class="col-auto btn btn-outline-warning border-0" style="font-size:xx-large;">เหลือง=รอฟังผลตรวจ</div>
                <div class="col-auto btn btn-outline-danger border-0" style="font-size:xx-large;">แดง=รอคิว</div>
            </div>
        </div>
    </form>
    <script>
        setTimeout(function () {
            window.location.reload(1);
        }, ((1000*60)*5));
    </script>
</body>
</html>
