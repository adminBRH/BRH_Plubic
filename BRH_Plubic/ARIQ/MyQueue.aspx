<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MyQueue.aspx.cs" Inherits="BRH_Plubic.ARIQ.MyQueue" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">

    <asp:ScriptManager ID="ScriptManager_Master" runat="server"></asp:ScriptManager>

    <div id="div_check" class="row col-lg-6 col-sm-8 mx-auto" runat="server">
        <div class="col-12 text-center">
            <input type="text" id="txt_number" class="col-4 form-control mx-auto" placeholder="หมายเลขคิว" runat="server" style="font-size:xx-large" />
            <h3><asp:Label ID="lbl_alert" Text="" runat="server"></asp:Label></h3>
        </div>
        <div class="col-12 mx-auto text-center">
            <asp:Button ID="btn_submit" CssClass="btn btn-light" Text="Submit" OnClick="btn_submit_Click" runat="server" />
        </div>
    </div>

    <asp:UpdatePanel ID="UpdatePanel_Detail" runat="server">
        <ContentTemplate>

        <div id="div_ShowQ" class="row col-lg-6 col-sm-8 mx-auto" runat="server">
            <div class="col-12 mx-auto text-center">
                <asp:Label ID="lbl_room" Text="" Font-Size="XX-Large" ForeColor="White" runat="server" style="background-color:cornflowerblue;"></asp:Label>
            </div>
            <div class="col-12 mx-auto text-center">
                <asp:Label ID="lbl_html" Text="" runat="server"></asp:Label>
            </div>
            <div class="col-12 mx-auto text-center">
                <asp:Label ID="lbl_detail" Text="" Font-Size="XX-Large" ForeColor="White" runat="server"></asp:Label>
            </div>
        </div>

            <asp:Timer ID="Timer1" runat="server" Interval="3000" OnTick="Timer1_Tick" ></asp:Timer>
        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>
