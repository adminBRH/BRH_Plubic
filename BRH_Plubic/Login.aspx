<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="BRH_Plubic.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">

    <div class="col-lg-5 col-sm-8 m-lg-auto m-sm-auto mt-5">
        <div class="card card-header bg-gradient">
            <h3 style="color:white">Admin Authentication</h3>
        </div>
        <div class="card card-body bg-light h4">
            <div class="row col-12">
                <div class="col-2 text-right my-3"><img src="images/User.png" width="28" /></div>
                <div class="col-10 my-3"><input type="text" id="txt_user" placeholder="User" class="form-control" style="font-size:xx-large" runat="server" /></div>
                <div class="col-2 text-right my-3"><img src="images/Lock.png" width="32" /></div>
                <div class="col-10 my-3"><input type="password" id="txt_pass" placeholder="Password" class="form-control" style="font-size:xx-large" runat="server" /></div>
                <div class="col-12 text-center my-3">
                    <asp:Label ID="lbl_alert" Text="" ForeColor="Red" Font-Size="XX-Large" runat="server"></asp:Label>
                </div>
                <div class="col-12 text-center mt-3">
                    <asp:Button ID="btn_login" Font-Size="Large" Text="Login" CssClass="btn btn-primary" OnClick="btn_login_Click" runat="server" />
                </div>
            </div>
        </div>
        <div class="card card-footer bg-gradient">

        </div>
    </div>


</asp:Content>
