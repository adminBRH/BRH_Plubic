<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="BRH_Plubic.CHK.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentDesktop" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<!-- Stlye Customs -->
    <link href="css/StyleSheet1.css" rel="stylesheet" />
<style>
.CardBGMenu {
    border-radius: 50px;
    border-top-left-radius: 300px;
}

.textMenu {
    color: white;
    border-top-left-radius: 50px;
    border-bottom-left-radius: 50px;
}
</style>
    <div class="row col-12 mx-auto my-auto">

        <div class="col-lg-5 col-sm-12 mx-auto my-lg-5 my-sm-3">
            <div class="bg-gradient btnShadow CardBGMenu">
                <a href="Company.aspx">
                    <div class="row col-12 mx-auto my-auto">
                        <div class="col-3 my-auto text-right">
                            <img src="image/icon/Contacts.png" class="iconSize100" />
                        </div>
                        <div class="col-9 my-auto h1 bg-primary text-right textMenu">
                            Manage<br />Contacts
                        </div>
                    </div>
                </a>
            </div>
        </div>

        <div class="col-lg-5 col-sm-12 mx-auto my-lg-5 my-sm-3">
            <div class="bg-gradient btnShadow CardBGMenu">
                <a href="Form.aspx#div_list">
                    <div class="row col-12">
                        <div class="col-3 my-auto text-right">
                            <img src="image/icon/Report.png" class="iconSize100" />
                        </div>
                        <div class="col-9 my-auto h1 bg-primary text-right textMenu">
                            Manage<br />Form
                        </div>
                    </div>
                </a>
            </div>
        </div>

        <div class="col-lg-5 col-sm-12 mx-auto my-lg-5 my-sm-3">
            <div class="bg-gradient btnShadow CardBGMenu">
                <a href="Slot.aspx">
                    <div class="row col-12">
                        <div class="col-3 my-auto text-right">
                            <img src="image/icon/CalendarForm.png" class="iconSize100" />
                        </div>
                        <div class="col-9 my-auto h1 bg-primary text-right textMenu">
                            Manage<br />Booking Slot
                        </div>
                    </div>
                </a>
            </div>
        </div>

        <div class="col-lg-5 col-sm-12 mx-auto my-lg-5 my-sm-3">
            <div class="bg-gradient btnShadow CardBGMenu">
                <a href="Report.aspx#div_list">
                <div class="row col-12">
                    <div class="col-3 my-auto text-right">
                        <img src="image/icon/Dashboard.png" class="iconSize100" />

                    </div>
                    <div class="col-9 my-auto h1 bg-primary text-right textMenu">
                        Report<br />Dashboard
                    </div>
                </div>
                </a>
            </div>
        </div>

    </div>

</asp:Content>
