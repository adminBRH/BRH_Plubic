<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="BRH_Plubic.ChangePassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">

    <div class="col-8 mx-auto">
        <div class="card card-header bg-primary h1" style="color:white">
            Change your Password
        </div>
        <div class="card card-body">
            <div class="row col-12 mx-auto">
                <div class="col-4 text-right mb-3">
                    New Password : 
                </div>
                <div class="col-8 mb-3">
                    <input type="password" id="txt_newpass" value="" class="form-control col-6" required="required" runat="server" />
                </div>
                <div class="col-4 text-right mb-3">
                    Confirm Password : 
                </div>
                <div class="col-8 mb-3">
                    <input type="password" id="txt_confpass" value="" class="form-control col-6" required="required" runat="server" />
                </div>
                <div class="col-4 text-right mb-5">
                    Old Password : 
                </div>
                <div class="col-8 mb-5">
                    <input type="password" id="txt_oldpass" value="" class="form-control col-6" required="required" runat="server" />
                </div>
                <div class="col-12 mx-auto text-center">
                    <asp:Label ID="lbl_alert" Text="" ForeColor="Red" runat="server"></asp:Label><br />
                    <button id="btn_submit" class="btn btn-primary" onserverclick="btn_submit_ServerClick" runat="server">SUBMIT</button>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
