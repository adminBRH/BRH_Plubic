<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="BRH_Plubic.MorChana.Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentDesktop" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<style>
    .boxColor {
        height: 100px;
        border-radius: 10px;
        text-align: center;
        font-size: xx-large;
        color: white;
        text-shadow: 2px 2px 2px #808080;
    }
    .HumanColor {
        height: 100px;
    }
    .HumanText {
        font-size: xx-large;
        text-shadow: 2px 2px 2px #808080;
    }
</style>

    <div class="col-lg-10 col-sm-12 mx-auto">

        <div class="row col-12 mx-auto">
            <div class="col-7">
                <asp:DropDownList ID="DD_dept" CssClass="col-12 btn btn-outline-primary mb-3" Font-Size="X-Large" runat="server">
                    <asp:ListItem Text="" Value=""></asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="col-3">
                <input type="date" id="date_search" value="" class="form-control" runat="server" style="font-size: x-large" />
                <script>
                    function fn_dateSearch() {
                        var datetime = document.getElementById('<%= date_search.ClientID %>');
                        if (datetime.value == '') {
                            var curDate = Today(0);
                            //alert(curDate);
                            datetime.value = curDate;
                        }
                    }
                    fn_dateSearch();
                </script>
            </div>
            <div class="col-2 text-right">
                <button id="btn_search" class="btn btn-outline-info" runat="server" onserverclick="btn_search_ServerClick" style="font-size: x-large"><i class="ti-search"></i></button>
            </div>
        </div>
        <div class="card col-12 mx-auto my-3 boxShadow">
            <div class="col-12 mx-auto text-center" style="font-size: xx-large;">
                <asp:Label ID="lbl_datetime" Text="" runat="server"></asp:Label>
            </div>
            <div class="col-12 mx-auto">
                <span style="font-size:xx-large">Total:</span> <asp:Label ID="lbl_total" Text="" Font-Size="XX-Large" ForeColor="Blue" runat="server"></asp:Label> <i class="ti-3x ti-user" style="color:darkgoldenrod"></i>
            </div>
            <div class="row col-12 mx-auto my-3">
                <div class="col-3 my-1 boxColor" style="background-color: green;">
                    <asp:Label ID="lbl_QtyGreen" Text="" runat="server"></asp:Label>
                </div>
                <div class="col-3 my-1 boxColor" style="background-color: yellow;">
                    <asp:Label ID="lbl_QtyYellow" Text="" runat="server"></asp:Label>
                </div>
                <div class="col-3 my-1 boxColor" style="background-color: orange;">
                    <asp:Label ID="lbl_QtyOrange" Text="" runat="server"></asp:Label>
                </div>
                <div class="col-3 my-1 boxColor" style="background-color: red;">
                    <asp:Label ID="lbl_QtyRed" Text="" runat="server"></asp:Label>
                </div>
            </div>
        </div>
        <div class="card col-12 mx-auto my-3 boxShadow">
            <div class="row col-12 mx-auto mb-3">
                <div class="col-3 mx-auto text-left HumanText">
                    <img id="img_woman_green" src="image/woman_green.png" class="HumanColor" runat="server" visible="false" />
                    <asp:Label ID="lbl_woman_green" Text="" runat="server"></asp:Label>
                </div>
                <div class="col-3 mx-auto text-left HumanText">
                    <img id="img_woman_yellow" src="image/woman_yellow.png" class="HumanColor" runat="server" visible="false" />
                    <asp:Label ID="lbl_woman_yellow" Text="" runat="server"></asp:Label>
                </div>
                <div class="col-3 mx-auto text-left HumanText">
                    <img id="img_woman_orangew" src="image/woman_orange.png" class="HumanColor" runat="server" visible="false" />
                    <asp:Label ID="lbl_woman_orange" Text="" runat="server"></asp:Label>
                </div>
                <div class="col-3 mx-auto text-left HumanText">
                    <img id="img_woman_red" src="image/woman_red.png" class="HumanColor" runat="server" visible="false" />
                    <asp:Label ID="lbl_woman_red" Text="" runat="server"></asp:Label>
                </div>
            </div>
            <div class="row col-12 mx-auto">
                <div class="col-3 mx-auto text-right HumanText">
                    <asp:Label ID="lbl_man_green" Text="" runat="server"></asp:Label>
                    <img id="img_man_green" src="image/man_green.png" class="HumanColor" runat="server" visible="false" />
                </div>
                <div class="col-3 mx-auto text-right HumanText">
                    <asp:Label ID="lbl_man_yellow" Text="" runat="server"></asp:Label>
                    <img id="img_man_yellow" src="image/man_yellow.png" class="HumanColor" runat="server" visible="false" />
                </div>
                <div class="col-3 mx-auto text-right HumanText">
                    <asp:Label ID="lbl_man_orange" Text="" runat="server"></asp:Label>
                    <img id="img_man_orange" src="image/man_orange.png" class="HumanColor" runat="server" visible="false" />
                </div>
                <div class="col-3 mx-auto text-right HumanText">
                    <asp:Label ID="lbl_man_red" Text="" runat="server"></asp:Label>
                    <img id="img_man_red" src="image/man_red.png" class="HumanColor" runat="server" visible="false" />
                </div>
            </div>
        </div>

        <div class="col-12 mx-auto my-3">
            <asp:ListView ID="LV_Details" runat="server">
                <LayoutTemplate>
                    <div id="itemPlaceholder" class="col-12 mx-auto" runat="server"></div>
                </LayoutTemplate>
                <ItemTemplate>
                    <div class="card col-12 mx-auto my-1">
                        <div class="row col-12 mx-auto" style="font-size: xx-large;">
                            <div class="col-2 mx-auto my-auto text-center">
                                <%# Eval("mc_index") %>
                            </div>
                            <div class="col-6 mx-auto my-auto text-center">
                                <%# Eval("emp_name") %><br />
                                <%# Eval("mc_datetime") %>
                            </div>
                            <div class="col-4 mx-auto my-auto text-center" style="background-color: <%# Eval("mc_color") %>; border-radius: 10px;">
                                <img src="<%# Eval("mc_img") %>" style="width: 100px;" />
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:ListView>
        </div>

        <div id="div_grid" runat="server" visible="false">
            <asp:GridView ID="GridView1" runat="server"></asp:GridView>
        </div>

        <div class="col-12 mx-auto my-3 text-right">
            <button id="btn_export" class="btn btn-outline-success" onserverclick="btn_export_ServerClick" runat="server">Export <img src="../images/excel_icon.png" style="width: 32px;" /></button>
        </div>

    </div>

</asp:Content>
