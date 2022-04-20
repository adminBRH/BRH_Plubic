<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Ranking.aspx.cs" Inherits="BRH_Plubic.GoodDoctor.Ranking" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>BRH Good Doctor Ranking</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <!-- Themify Icons -->
    <link rel="stylesheet" href="../css/themify-icons.css">
    <!-- Main css -->
    <link href="../css/style.css" rel="stylesheet">

</head>
<body>
    <form id="formGDR" runat="server">

        <asp:ScriptManager ID="ScriptManagerGoodDctor" runat="server"></asp:ScriptManager>

        <div class="col-12 mx-auto my-3 text-center">
            ข้อมูล 
            <asp:DropDownList ID="dd_lastDay" CssClass="btn btn-dark" OnSelectedIndexChanged="dd_lastDay_SelectedIndexChanged" AutoPostBack="true" runat="server">
                <asp:ListItem Text="Yesterday" Value="1" Selected="True"></asp:ListItem>
                <asp:ListItem Text="Last 7 Day" Value="7"></asp:ListItem>
                <asp:ListItem Text="Last 15 Day" Value="15"></asp:ListItem>
                <asp:ListItem Text="Last 30 Day" Value="30"></asp:ListItem>
                <asp:ListItem Text="Last 60 Day" Value="60"></asp:ListItem>
                <asp:ListItem Text="Last 180 Day" Value="180"></asp:ListItem>
                <asp:ListItem Text="Last 365 Day" Value="365"></asp:ListItem>
            </asp:DropDownList> 
            จากการประเมินขั้นต่ำ 
            <asp:DropDownList ID="dd_minQTY" CssClass="btn btn-outline-info" OnSelectedIndexChanged="dd_minQTY_SelectedIndexChanged" AutoPostBack="true" runat="server">
                <asp:ListItem Text="1 คน" Value="1" Selected="True"></asp:ListItem>
                <asp:ListItem Text="2 คน" Value="2"></asp:ListItem>
                <asp:ListItem Text="3 คน" Value="3"></asp:ListItem>
                <asp:ListItem Text="4 คน" Value="4"></asp:ListItem>
                <asp:ListItem Text="5 คน" Value="5"></asp:ListItem>
                <asp:ListItem Text="6 คน" Value="6"></asp:ListItem>
                <asp:ListItem Text="7 คน" Value="7"></asp:ListItem>
                <asp:ListItem Text="8 คน" Value="8"></asp:ListItem>
                <asp:ListItem Text="9 คน" Value="9"></asp:ListItem>
                <asp:ListItem Text="10 คน" Value="10"></asp:ListItem>
            </asp:DropDownList> 
            แสดงผลลำดับ 
            <asp:DropDownList ID="dd_rank" CssClass="btn btn-outline-dark" OnSelectedIndexChanged="dd_rank_SelectedIndexChanged" AutoPostBack="true" runat="server">
                <asp:ListItem Text="5 Star" Value="5" Selected="True"></asp:ListItem>
                <asp:ListItem Text="4 Star" Value="4"></asp:ListItem>
                <asp:ListItem Text="3 Star" Value="3"></asp:ListItem>
                <asp:ListItem Text="2 Star" Value="2"></asp:ListItem>
                <asp:ListItem Text="1 Star" Value="1"></asp:ListItem>
            </asp:DropDownList>
        </div>

        <asp:UpdatePanel ID="UpdatePanel_Data" runat="server">
            <ContentTemplate>
                <input type="text" id="txtH_imgTOP" value="" runat="server" hidden="hidden" />
                <div class="row col-12 mx-auto mt-3">
                    <!-- Department -->
                    <div class="col-lg-6 col-sm-12 mx-auto">
                        <div class="card col-12 mx-auto h5">
                            <asp:Label ID="lbl_alert_department" Text="" CssClass="col-12 mx-auto text-center" runat="server"></asp:Label>
                            <asp:ListView ID="listview_department" runat="server">
                                <LayoutTemplate>
                                    <div class="col-12 alert alert-primary mx-auto mb-5 text-center h3">
                                        Amount of <label id="lbl_lastDay_dept">Yesterday</label> by Department.
                                    </div>
                                    <div id="itemPlaceholder" runat="server"></div>
                                </LayoutTemplate>
                                <ItemTemplate>
                                    <div class="row col-12 mx-auto my-2">
                                        <div class="col-6 mx-auto text-right">
                                            <%# Eval("dl_name") %>
                                        </div>
                                        <div class="col-6 mx-auto">
                                            <%# Eval("COUNTrow") %>
                                        </div>
                                        <hr class="col-10 mx-auto" />
                                    </div>
                                </ItemTemplate>
                            </asp:ListView>
                        </div>
                    </div>
                    <!-- Doctor -->
                    <div class="col-lg-6 col-sm-12 mx-auto">
                        <div class="card col-12 mx-auto h5">
                            <asp:Label ID="lbl_alert_doctor" CssClass="col-12 mx-auto text-center" Text="" runat="server"></asp:Label>
                            <asp:ListView ID="listview_doctor" runat="server">
                                <LayoutTemplate>
                                    <div class="col-12 alert alert-primary mx-auto text-center h3">
                                        <label id="lbl_top_doctor">5 Star</label> of <label id="lbl_lastDay_doctor">Yesterday</label>.
                                    </div>
                                    <div class="col-12 mx-auto text-center">
                                        <img id="img_top" src="..." width="100" style="border: 0; border-radius: 20px;" />
                                    </div>
                                    <div id="itemPlaceholder" runat="server"></div>
                                </LayoutTemplate>
                                <ItemTemplate>
                                    <div class="row col-12 mx-auto">
                                        <div class="col-6 mx-auto my-auto">
                                            <%# Container.DataItemIndex + 1 %>. 
                                            <%# Eval("dr_forename") %> <%# Eval("dr_surname") %> [<%# Eval("drr_drid") %>]
                                        </div>
                                        <div class="col-3 mx-auto my-auto text-right">
                                            <%# Eval("COUNTrow") %> คน
                                        </div>
                                        <div class="row col-3 mx-auto my-auto">
                                            <div class="col-8 mx-auto my-auto text-right">
                                                <%# Eval("AVGStar") %>
                                            </div>
                                            <div class="col-4 mx-auto my-auto">
                                                <i class="ti-2x ti-star" style="color: gold;"></i>
                                            </div>
                                        </div>
                                        <hr class="col-10 mx-auto" />
                                    </div>
                                </ItemTemplate>
                            </asp:ListView>
                        </div>
                    </div>
                </div>
                <script>
                    function fn_imgTOP() {
                        var txt = document.getElementById('<%= txtH_imgTOP.ClientID %>');
                        var img = document.getElementById('img_top');
                        if (txt.value != '') {
                            img.setAttribute('src', txt.value);
                        } else {
                            img.setAttribute('src','...');
                        }
                    }

                    function fn_lastDay() {
                        var ddLastDay = document.getElementById('<%= dd_lastDay.ClientID %>');
                        var ddRank = document.getElementById('<%= dd_rank.ClientID %>');
                        document.getElementById('lbl_lastDay_dept').innerText = 'last ' + ddLastDay.value + ' day';
                        document.getElementById('lbl_lastDay_doctor').innerText = 'last ' + ddLastDay.value + ' day';
                        document.getElementById('lbl_top_doctor').innerText = ddRank.value + ' Star';
                    }

                    function pageLoad() {
                        fn_imgTOP();
                        fn_lastDay();
                    }
                </script>
            </ContentTemplate>
        </asp:UpdatePanel>

    </form>
</body>
</html>
