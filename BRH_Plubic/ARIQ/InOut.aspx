<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="InOut.aspx.cs" Inherits="BRH_Plubic.ARIQ.InOut" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">
    <div class="row col-12 mx-auto">
        <div class="col-lg-4 col-sm-2 mx-auto text-right">
            <div class="row col-12 mx-auto">
                <asp:RadioButtonList ID="rdl_status" CssClass="col-12" OnSelectedIndexChanged="rdl_status_SelectedIndexChanged" Font-Size="X-Large" AutoPostBack="true" runat="server">
                    <asp:ListItem Value="next" Text="Next" Selected="True"></asp:ListItem>
                    <asp:ListItem Value="hold" Text="Hold"></asp:ListItem>
                    <asp:ListItem Value="unhold" Text="Unhold"></asp:ListItem>
                    <asp:ListItem Value="cancel" Text="Cancel"></asp:ListItem>
                </asp:RadioButtonList>
            </div>
        </div>
        <div class="col-lg-8 col-sm-10 mx-auto text-left">
            <div class="row col-12 mx-auto">
                <div id="div_number" class="col-2" runat="server" visible="false">
                    <input type="text" id="txt_number" class="form-control" placeholder="คิวที่" runat="server" />
                </div>
                <div class="col-10">
                    <div class="row col-12">
                        <asp:Button ID="btn_room1" CssClass="btn btn-light" Text="1" OnClick="btn_room_Click" OnClientClick="fn_room('1')" runat="server" />
                        <asp:Button ID="btn_room2" CssClass="btn btn-light" Text="2" OnClick="btn_room_Click" OnClientClick="fn_room('2')" runat="server" />
                        <asp:Button ID="btn_room3" CssClass="btn btn-light" Text="3" OnClick="btn_room_Click" OnClientClick="fn_room('3')" runat="server" />
                        <asp:Button ID="btn_room4" CssClass="btn btn-light" Text="4" OnClick="btn_room_Click" OnClientClick="fn_room('4')" runat="server" />
                        <asp:Button ID="btn_room5" CssClass="btn btn-light" Text="5" OnClick="btn_room_Click" OnClientClick="fn_room('5')" runat="server" />
                        <asp:Button ID="btn_room6" CssClass="btn btn-light" Text="6" OnClick="btn_room_Click" OnClientClick="fn_room('6')" runat="server" />
                        <asp:Button ID="btn_room7" CssClass="btn btn-light" Text="7" OnClick="btn_room_Click" OnClientClick="fn_room('7')" runat="server" />
                    </div>
                </div>
            </div>
        </div>
        <div hidden="hidden">
            <input type="text" id="txt_room" value="" runat="server" />
        </div>

        <script>
            function fn_room(r) {
                var room = document.getElementById('<%= txt_room.ClientID %>');
                room.value = r;
            }
        </script>
    </div>
</asp:Content>
