<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="BRH_Plubic.ARIQ.Register" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">

    <asp:ScriptManager ID="ScriptManager_Master" runat="server"></asp:ScriptManager>

    <div class="row col-10 mx-auto">
        <div class="col-lg-4 col-sm-6 mx-auto text-center mb-3">
            <input type="text" id="txt_number" class="form-control" placeholder="หมายเลขคิว" value="" runat="server" style="font-size:x-large" />
            <asp:Label ID="lbl_alert" Text="" Font-Size="X-Large" runat="server"></asp:Label>
        </div>
        <div class="row col-lg-8 col-sm-12 mx-auto">
            <div class="col-lg-1 col-sm-1 mx-auto text-right">
                <h3>ห้อง </h3>
            </div>
            <div class="col-3 mx-auto text-center">
                <asp:Button ID="btn_room1" CssClass="btn btn-light" Text="1" Font-Size="XX-Large" OnClick="btn_room_Click" OnClientClick="fn_room('1')" runat="server" />
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:Label ID="lbl_doctor1" CssClass="badge-primary" Text="" Font-Size="X-Large" runat="server"></asp:Label>
                        <h3>
                            <asp:Label ID="lbl_f1" class="badge-success" Text="" runat="server"></asp:Label>
                            <asp:Label ID="lbl_h1" class="badge-warning" Text="" runat="server"></asp:Label>
                            <asp:Label ID="lbl_n1" class="badge-danger" Text="" runat="server"></asp:Label>
                        </h3>
                        <asp:Timer ID="Timer1" Interval="5000" OnTick="Timer1_Tick" runat="server"></asp:Timer>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
            <div class="col-3 mx-auto text-center">
                <asp:Button ID="btn_room2" CssClass="btn btn-light" Text="2" Font-Size="XX-Large" OnClick="btn_room_Click" OnClientClick="fn_room('2')" runat="server" />
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <asp:Label ID="lbl_doctor2" CssClass="badge-primary" Text="" Font-Size="X-Large" runat="server"></asp:Label>
                        <h3>
                            <asp:Label ID="lbl_f2" class="badge-success" Text="" runat="server"></asp:Label>
                            <asp:Label ID="lbl_h2" class="badge-warning" Text="" runat="server"></asp:Label>
                            <asp:Label ID="lbl_n2" class="badge-danger" Text="" runat="server"></asp:Label>
                        </h3>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="Timer1" EventName="tick" />
                    </Triggers>
                </asp:UpdatePanel>
            </div>
            <div class="col-3 mx-auto text-center">
                <asp:Button ID="btn_room3" CssClass="btn btn-light" Text="3" Font-Size="XX-Large" OnClick="btn_room_Click" OnClientClick="fn_room('3')" runat="server" />
                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                    <ContentTemplate>
                        <asp:Label ID="lbl_doctor3" CssClass="badge-primary" Text="" Font-Size="X-Large" runat="server"></asp:Label>
                        <h3>
                            <asp:Label ID="lbl_f3" class="badge-success" Text="" runat="server"></asp:Label>
                            <asp:Label ID="lbl_h3" class="badge-warning" Text="" runat="server"></asp:Label>
                            <asp:Label ID="lbl_n3" class="badge-danger" Text="" runat="server"></asp:Label>
                        </h3>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="Timer1" EventName="tick" />
                    </Triggers>
                </asp:UpdatePanel>
            </div>
            <div class="col-3 mx-auto text-center">
                <asp:Button ID="btn_room4" CssClass="btn btn-light" Text="4" Font-Size="XX-Large" OnClick="btn_room_Click" OnClientClick="fn_room('4')" runat="server" />
                <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                    <ContentTemplate>
                        <asp:Label ID="lbl_doctor4" CssClass="badge-primary" Text="" Font-Size="X-Large" runat="server"></asp:Label>
                        <h3>
                            <asp:Label ID="lbl_f4" class="badge-success" Text="" runat="server"></asp:Label>
                            <asp:Label ID="lbl_h4" class="badge-warning" Text="" runat="server"></asp:Label>
                            <asp:Label ID="lbl_n4" class="badge-danger" Text="" runat="server"></asp:Label>
                        </h3>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="Timer1" EventName="tick" />
                    </Triggers>
                </asp:UpdatePanel>
            </div>
            <div class="col-3 mx-auto text-center">
                <asp:Button ID="btn_room5" CssClass="btn btn-light" Text="5" Font-Size="XX-Large" OnClick="btn_room_Click" OnClientClick="fn_room('5')" runat="server" />
                <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                    <ContentTemplate>
                        <asp:Label ID="lbl_doctor5" CssClass="badge-primary" Text="" Font-Size="X-Large" runat="server"></asp:Label>
                        <h3>
                            <asp:Label ID="lbl_f5" class="badge-success" Text="" runat="server"></asp:Label>
                            <asp:Label ID="lbl_h5" class="badge-warning" Text="" runat="server"></asp:Label>
                            <asp:Label ID="lbl_n5" class="badge-danger" Text="" runat="server"></asp:Label>
                        </h3>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="Timer1" EventName="tick" />
                    </Triggers>
                </asp:UpdatePanel>
            </div>
            <div class="col-3 mx-auto text-center">
                <asp:Button ID="btn_room6" CssClass="btn btn-light" Text="6" Font-Size="XX-Large" OnClick="btn_room_Click" OnClientClick="fn_room('6')" runat="server" />
                <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                    <ContentTemplate>
                        <asp:Label ID="lbl_doctor6" CssClass="badge-primary" Text="" Font-Size="X-Large" runat="server"></asp:Label>
                        <h3>
                            <asp:Label ID="lbl_f6" class="badge-success" Text="" runat="server"></asp:Label>
                            <asp:Label ID="lbl_h6" class="badge-warning" Text="" runat="server"></asp:Label>
                            <asp:Label ID="lbl_n6" class="badge-danger" Text="" runat="server"></asp:Label>
                        </h3>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="Timer1" EventName="tick" />
                    </Triggers>
                </asp:UpdatePanel>
            </div>
            <div class="col-3 mx-auto text-center">
                <asp:Button ID="btn_room7" CssClass="btn btn-light" Text="7" Font-Size="XX-Large" OnClick="btn_room_Click" OnClientClick="fn_room('7')" runat="server" />
                <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                    <ContentTemplate>
                        <asp:Label ID="lbl_doctor7" CssClass="badge-primary" Text="" Font-Size="X-Large" runat="server"></asp:Label>
                        <h3>
                            <asp:Label ID="lbl_f7" class="badge-success" Text="" runat="server"></asp:Label>
                            <asp:Label ID="lbl_h7" class="badge-warning" Text="" runat="server"></asp:Label>
                            <asp:Label ID="lbl_n7" class="badge-danger" Text="" runat="server"></asp:Label>
                        </h3>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="Timer1" EventName="tick" />
                    </Triggers>
                </asp:UpdatePanel>
            </div>
        </div>
        <div class="col-12 text-left mt-5">
            <h3><label id="lbl_f" class="badge-success" runat="server">F = Finish</label>
                <label id="lbl_h" class="badge-warning" runat="server">H = hold</label>
                <label id="lbl_n" class="badge-danger" runat="server">W = waiting</label>
            </h3>
        </div>
        <div hidden="hidden">
            <input type="text" id="txt_room" value="" runat="server" />
        </div>
    </div>

    <script>
        function fn_room(r) {
            var room = document.getElementById('<%= txt_room.ClientID %>');
            room.value = r;
        }
    </script>

</asp:Content>
