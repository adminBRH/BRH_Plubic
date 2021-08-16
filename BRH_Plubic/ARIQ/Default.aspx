<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="BRH_Plubic.ARIQ.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">

    <asp:ScriptManager ID="ScriptManager_Master" runat="server"></asp:ScriptManager>

    <asp:UpdatePanel ID="UpdatePanel_ShowQ" runat="server">
        <ContentTemplate>
            <br />
        <div id="ShowQ" class="section row col-12 mx-auto">
            

        <div class="col-2 btn btn-light"><asp:Label ID="timeShow" Font-Size="X-Large" Text="" runat="server"></asp:Label></div>
        <div class="row col-9 btn btn-light">
            <div class="row col-12">
                <div class="col-lg-2 col-sm-2 h1">เข้าพบแพทย์</div>
                <div class="col-lg-2 col-sm-2 h1">รอผลตรวจ</div>
                <div class="col-lg-8 col-sm-8 h1">รอพบแพทย์</div>
            </div>
            <%--<table width="100%">
                <tr>
                    <td width="20%"><h3>เข้าพบแพทย์</h3></td>
                    <td width="20%"><h3>รอผลตรวจ</h3></td>
                    <td width="60%" colspan="4"><h3>รอพบแพทย์</h3></td>
                </tr>
            </table>--%>
        </div>
        <div class="col-2 btn btn-light"><h1>ห้อง 1</h1><h3><asp:Label ID="lbl_doctor1" Text="" runat="server"></asp:Label></h3></div>
        <div class="col-9 btn btn-light">
            <div class="row col-12">
                <div class="col-2" style="background-color:greenyellow; font-size:75px;"><asp:Label ID="lbl_R1" Text="" runat="server"></asp:Label></div>
                <div class="col-2" style="background-color:aqua; font-size:75px;"><asp:Label ID="lbl_RH1" Text="" runat="server"></asp:Label></div>
                <div class="col-8 text-left" style="background-color:antiquewhite; font-size:75px;"><asp:Label ID="lbl_RN1" Text="" runat="server"></asp:Label></div>
            </div>
        </div>
        <div class="col-2 btn btn-light"><h1>ห้อง 2</h1><h3><asp:Label ID="lbl_doctor2" Text="" runat="server"></asp:Label></h3></div>
        <div class="col-9 btn btn-light">
            <div class="row col-12">
                <div class="col-2" style="background-color:greenyellow; font-size:75px;"><asp:Label ID="lbl_R2" Text="" runat="server"></asp:Label></div>
                <div class="col-2" style="background-color:aqua; font-size:75px;"><asp:Label ID="lbl_RH2" Text="" runat="server"></asp:Label></div>
                <div class="col-8 text-left" style="background-color:antiquewhite; font-size:75px;"><asp:Label ID="lbl_RN2" Text="" runat="server"></asp:Label></div>
            </div>
        </div>
        <div class="col-2 btn btn-light"><h1>ห้อง 3</h1><h3><asp:Label ID="lbl_doctor3" Text="" runat="server"></asp:Label></h3></div>
        <div class="col-9 btn btn-light">
            <div class="row col-12">
                <div class="col-2" style="background-color:greenyellow; font-size:75px;"><asp:Label ID="lbl_R3" Text="" runat="server"></asp:Label></div>
                <div class="col-2" style="background-color:aqua; font-size:75px;"><asp:Label ID="lbl_RH3" Text="" runat="server"></asp:Label></div>
                <div class="col-8 text-left" style="background-color:antiquewhite; font-size:75px;"><asp:Label ID="lbl_RN3" Text="" runat="server"></asp:Label></div>
            </div>
        </div>
        <div class="col-2 btn btn-light"><h1>ห้อง 4</h1><h3><asp:Label ID="lbl_doctor4" Text="" runat="server"></asp:Label></h3></div>
        <div class="col-9 btn btn-light">
            <div class="row col-12">
                <div class="col-2" style="background-color:greenyellow; font-size:75px;"><asp:Label ID="lbl_R4" Text="" runat="server"></asp:Label></div>
                <div class="col-2" style="background-color:aqua; font-size:75px;"><asp:Label ID="lbl_RH4" Text="" runat="server"></asp:Label></div>
                <div class="col-8 text-left" style="background-color:antiquewhite; font-size:75px;"><asp:Label ID="lbl_RN4" Text="" runat="server"></asp:Label></div>
            </div>
        </div>
        <div class="col-2 btn btn-light"><h1>ห้อง 5</h1><h3><asp:Label ID="lbl_doctor5" Text="" runat="server"></asp:Label></h3></div>
        <div class="col-9 btn btn-light">
            <div class="row col-12">
                <div class="col-2" style="background-color:greenyellow; font-size:75px;"><asp:Label ID="lbl_R5" Text="" runat="server"></asp:Label></div>
                <div class="col-2" style="background-color:aqua; font-size:75px;"><asp:Label ID="lbl_RH5" Text="" runat="server"></asp:Label></div>
                <div class="col-8 text-left" style="background-color:antiquewhite; font-size:75px;"><asp:Label ID="lbl_RN5" Text="" runat="server"></asp:Label></div>
            </div>
        </div>
        <div class="col-2 btn btn-light"><h1>ห้อง 6</h1><h3><asp:Label ID="lbl_doctor6" Text="" runat="server"></asp:Label></h3></div>
        <div class="col-9 btn btn-light">
            <div class="row col-12">
                <div class="col-2" style="background-color:greenyellow; font-size:75px;"><asp:Label ID="lbl_R6" Text="" runat="server"></asp:Label></div>
                <div class="col-2" style="background-color:aqua; font-size:75px;"><asp:Label ID="lbl_RH6" Text="" runat="server"></asp:Label></div>
                <div class="col-8 text-left" style="background-color:antiquewhite; font-size:75px;"><asp:Label ID="lbl_RN6" Text="" runat="server"></asp:Label></div>
            </div>
        </div>
        <div class="col-2 btn btn-light"><h1>ห้อง 7</h1><h3><asp:Label ID="lbl_doctor7" Text="" runat="server"></asp:Label></h3></div>
        <div class="col-9 btn btn-light">
            <div class="row col-12">
                <div class="col-2" style="background-color:greenyellow; font-size:75px;"><asp:Label ID="lbl_R7" Text="" runat="server"></asp:Label></div>
                <div class="col-2" style="background-color:aqua; font-size:75px;"><asp:Label ID="lbl_RH7" Text="" runat="server"></asp:Label></div>
                <div class="col-8 text-left" style="background-color:antiquewhite; font-size:75px;"><asp:Label ID="lbl_RN7" Text="" runat="server"></asp:Label></div>
            </div>
        </div>
    </div>

            <asp:Timer ID="Timer1" runat="server" Interval="3000" OnTick="Timer1_Tick" ></asp:Timer>
        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>
