<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AnnualCheckupReport.aspx.cs" Inherits="BRH_Plubic.AnnualCheckupReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">

    <div class="col-10 mx-auto text-center">
        <div class="col-12 my-5">
            <div class="h3 card card-header bg-info">
                Report BRH Annual Checkup
            </div>
            <div class="card card-body bg-transparent">
                <div class="row col-12">
                    <div class="col-8">
                        <div class="input-group">
                            <asp:DropDownList ID="DD_field" CssClass="btn btn-outline-info" runat="server">
                                <asp:ListItem Value="ALL" Text="ทั้งหมด" Selected="True"></asp:ListItem>
                                <asp:ListItem Value="book_id" Text="เลขที่การจอง"></asp:ListItem>
                                <asp:ListItem Value="quota_date" Text="วันที่จอง"></asp:ListItem>
                                <asp:ListItem Value="book_empid" Text="รหัสพนักงาน"></asp:ListItem>
                                <asp:ListItem Value="FullName" Text="ชื่อ - นามสกุล"></asp:ListItem>
                                <asp:ListItem Value="book_dept" Text="รหัสแผนก"></asp:ListItem>
                                <asp:ListItem Value="book_status" Text="สถานะ"></asp:ListItem>
                                <%--<asp:ListItem Value="emp_register" Text="ลงทะเบียนแล้ว"></asp:ListItem>--%>
                                <asp:ListItem Value="book_adddate" Text="วันเวลาที่ Submit"></asp:ListItem>
                            </asp:DropDownList>
                            <input type="text" id="txt_search" runat="server" />
                            <button id="btn_search" class="btn btn-outline-primary rounded-circle" value="" onserverclick="btn_search_ServerClick" runat="server">SEARCH</button>
                        </div>
                        <div hidden="hidden">
                            <input type="text" id="txtH_field" value="ALL" runat="server" />
                            <input type="text" id="txtH_search" value="" runat="server" />
                        </div>
                    </div>
                    <div class="col-4">
                        <asp:Button ID="btnExport" CssClass="btn btn-outline-primary" runat="server" Text="Export To Excel" OnClick="btnExport_Click" />
                    </div>
                </div>
                <asp:GridView ID="GridView1" CssClass="col-12 my-3" runat="server" AutoGenerateColumns="False" AllowCustomPaging="false" AllowPaging="True" PageSize="50" OnPageIndexChanging="GridView1_PageIndexChanging">
                    <Columns>
                        <asp:BoundField DataField="book_id" HeaderText="เลขที่การจอง"></asp:BoundField>
                        <asp:BoundField DataField="quota_date" HeaderText="วันที่จอง" DataFormatString="{0:yyyy-MM-dd}"></asp:BoundField>
                        <asp:BoundField DataField="book_empid" HeaderText="รหัสพนักงาน"></asp:BoundField>
                        <asp:BoundField DataField="FullName" HeaderText="ชื่อ - นามสกุล"></asp:BoundField>
                        <asp:BoundField DataField="book_dept" HeaderText="รหัสแผนก"></asp:BoundField>
                        <asp:BoundField DataField="book_status" HeaderText="สถานะ"></asp:BoundField>
                        <%--<asp:BoundField DataField="emp_register" HeaderText="ลงทะเบียนแล้ว"></asp:BoundField>--%>
                        <asp:BoundField DataField="book_adddate" HeaderText="วันเวลาที่ Submit" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"></asp:BoundField>
                    </Columns>
                    <HeaderStyle BackColor="#009999" Font-Bold="True" ForeColor="White"></HeaderStyle>
                    <PagerSettings PageButtonCount="20" FirstPageText="First" LastPageText="Last" />
                </asp:GridView>
            </div>
            <div class="h3 card card-footer bg-info">
            </div>
        </div>
    </div>

</asp:Content>
