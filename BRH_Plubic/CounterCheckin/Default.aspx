<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="BRH_Plubic.CounterCheckin.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">

    <asp:ScriptManager ID="ScriptManager_Master" runat="server"></asp:ScriptManager>

<style>
input[type=radio] {
    border: 0px;
    width: 2em;
    height: 2em;
}
</style>

<asp:UpdateProgress ID="prgLoadingStatus" runat="server" DynamicLayout="true">
<ProgressTemplate>
    <div id="overlay">
        <asp:Image ID="imgWaitIcon" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/images/BRHrayongLoading.gif" />
    </div>
</ProgressTemplate>
</asp:UpdateProgress>

    <!-- ---------------------------------------------- LOGO Hospital ---------------------------------------------- -->
    <div id="div_branch" class="row col-lg-8 col-sm-11 mx-auto h1" runat="server" style="color:darkgoldenrod; font-family:'Segoe MDL2 Assets';">
        <div class="col-8 btn btn-light mx-auto text-center mb-5">
            <!-------------------*** ??? ***------------------->
            <a href="Default.aspx?br=BRH"><img src="images/LOGO-BRH_Rayong.png"/></a>
        </div>
        <div class="col-8 btn btn-light mx-auto text-center mb-5">
            <!-------------------*** ??? ***------------------->
            <a href="Default.aspx?br=SRH"><img src="images/LOGO-SRI_Rayong.png"/></a>
        </div>
    </div>
    <!-- ---------------------------------------------- LOGO Hospital ---------------------------------------------- -->


    <div id="div_department" class="col-lg-8 col-sm-11 mx-auto" runat="server" visible="false">
        <div class="col-12" style="background-image: url(images/BRHCounterCheckin.png); background-position-x:center; background-size:200px; background-repeat:no-repeat">
            <div class="col-12 my-5">&nbsp;</div>
            <div class="col-12 my-5">&nbsp;</div>
            <br />
            <div class="col-12 mx-auto text-center">
                <img id="img_logo" src="images/LOGO-BRH_Rayong.png" class="boxShadow border border-warning border-right-0 border-bottom-0 rounded" height="100" runat="server" />
            </div>
        </div>
        <div id="div_back" class="col-12 text-left" runat="server">
            <a href="Default.aspx"><img src="../images/go-back.png" width="50" /></a>
        </div>
        <!-- ---------------------------------------------- Select Department ---------------------------------------------- -->
        <div id="div_dept" class="row col-12 my-5" runat="server">
            <div class="col-8 mx-auto text-right">
                <asp:DropDownList ID="DD_department" CssClass="col-12 btn btn-light" Font-Size="X-Large" runat="server">
                    <asp:ListItem Text="" Value=""></asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="col-4 mx-auto text-left">
                <button id="btn_dept" value="" class="col-12 btn btn-light text-center" style="color:darkgoldenrod; font-size:large; font-family:'Segoe MDL2 Assets';" onserverclick="btn_dept_ServerClick" runat="server">เข้าสู่หน้า Check In</button>
            </div>
        </div>
        <!-- ---------------------------------------------- Select Department ---------------------------------------------- -->

    <!-- ---------------------------------------------- Check-in Check-out ---------------------------------------------- -->
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
        <div id="div_CheckIn" class="row col-12" runat="server">
            <div class="col-12 mx-auto text-left mb-5" style="font-family:'Segoe MDL2 Assets';">
                <asp:Label ID="lb_department" Text="" Font-Size="XX-Large" ForeColor="#b8860b" runat="server"></asp:Label>
            </div>
            <div class="row col-12">
                <div class="col-6 mx-auto text-left mb-5">
                    <asp:RadioButtonList ID="rd_type" CssClass="col-12" Font-Size="X-Large" RepeatDirection="Horizontal" runat="server">
                        <asp:ListItem Text=" ช่วยงาน" Value="Help" Selected="True"></asp:ListItem>
                        <asp:ListItem Text=" ฝึกงาน" Value="Training"></asp:ListItem>
                    </asp:RadioButtonList>
                </div>
                <div class="col-6 mx-auto">&nbsp;</div>
            </div>
            <div class="col-6 mx-auto text-right">
                <input type="text" id="txt_empid" class="form-control" style="font-size:x-large" value="" placeholder="รหัสพนักงาน" runat="server" />
            </div>
            <div class="col-6 mx-auto text-left">
                <span class="ti-2x ti-location-pin"></span><asp:Button ID="btn_submit" Text="Submit" Font-Size="X-Large" OnClick="btn_submit_Click" runat="server" />
            </div>
            <div class="col-12 mx-auto text-center">
                <asp:Label ID="lb_alert" Text="" Font-Size="X-Large" ForeColor="Red" runat="server"></asp:Label>
            </div>
            <div class="col-12 mx-auto text-left mt-3">
                <asp:GridView ID="GridView1" runat="server" Font-Size="Larger" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" AutoGenerateColumns="False">
                    <Columns>
                        <asp:BoundField DataField="cc_empid" HeaderText="รหัสพนักงาน"></asp:BoundField>
                        <asp:BoundField DataField="emp_Name" HeaderText="ชื่อ-นามสกุล"></asp:BoundField>
                        <asp:BoundField DataField="cc_datein" HeaderText="Date In" DataFormatString="{0: dd/MM/yyyy}"></asp:BoundField>
                        <asp:BoundField DataField="cc_timein" HeaderText="Time In"></asp:BoundField>
                        <asp:BoundField DataField="cc_dateout" HeaderText="Date Out" DataFormatString="{0: dd/MM/yyyy}"></asp:BoundField>
                        <asp:BoundField DataField="cc_timeout" HeaderText="Time Out"></asp:BoundField>
                    </Columns>

                    <FooterStyle BackColor="White" ForeColor="#000066"></FooterStyle>

                    <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" HorizontalAlign="Center"></HeaderStyle>

                    <PagerStyle HorizontalAlign="Left" BackColor="White" ForeColor="#000066"></PagerStyle>

                    <RowStyle ForeColor="#000066"></RowStyle>

                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White"></SelectedRowStyle>

                    <SortedAscendingCellStyle BackColor="#F1F1F1"></SortedAscendingCellStyle>

                    <SortedAscendingHeaderStyle BackColor="#007DBB"></SortedAscendingHeaderStyle>

                    <SortedDescendingCellStyle BackColor="#CAC9C9"></SortedDescendingCellStyle>

                    <SortedDescendingHeaderStyle BackColor="#00547E"></SortedDescendingHeaderStyle>
                </asp:GridView>
            </div>
        </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <!-- ---------------------------------------------- Check-in Check-out ---------------------------------------------- -->

    </div>

    <!-- ---------------------------------------------- Suggesion ---------------------------------------------- -->
    <div id="div_alert" class="row col-lg-6 col-sm-8 mx-auto text-center my-5" runat="server" visible="false">
        <asp:Label ID="lbl_eval" CssClass="mx-auto text-center mb-5" Text="" Font-Size="X-Large" runat="server"></asp:Label>
        <textarea id="txt_sugges" placeholder="ข้อเสนอแนะ" class="form-control" runat="server"></textarea>
        <asp:Button ID="btn_sugges" Text="ส่ง" CssClass="col-2 btn btn-outline-success mx-auto text-center mt-3" OnClick="btn_sugges_Click" runat="server" /> 
    </div>
    <!-- ---------------------------------------------- Suggesion ---------------------------------------------- -->

</asp:Content>
