<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ScreenCovidBeforToWorkReport.aspx.cs" Inherits="BRH_Plubic.ScreenCovidBeforToWorkReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">

    <div class="col-11 container mx-auto">
        <div class="card card-header text-center bg-info h1">
            Screen Covid-19 Befor return to work
        </div>
        <div class="card card-body">
            <asp:GridView ID="GridView1" CssClass="mx-auto" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3">
                <Columns>
                    <asp:TemplateField HeaderText="No.">
                        <ItemTemplate>
                            <%# Container.DataItemIndex + 1 %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField HeaderText="วันเวลา" DataField="sc_datetime" DataFormatString="{0: dd/MM/yyyy HH:mm:ss}"></asp:BoundField>
                    <asp:BoundField HeaderText="บริษัท" DataField="cp_name_th"></asp:BoundField>
                    <asp:BoundField HeaderText="ชื่อ - นามสกุล" DataField="sc_fullname"></asp:BoundField>
                    <asp:BoundField HeaderText="รหัสพนักงาน" DataField="sc_empid"></asp:BoundField>
                    <asp:BoundField HeaderText="มีความเสี่ยง" DataField="sc_risk"></asp:BoundField>
                    <asp:TemplateField HeaderText="PRINT" HeaderStyle-CssClass="title_bg" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <a class="btn btn-outline-primary" href="ScreenCovidBeforToWork.aspx?id=<%# Eval("sc_id") %>">
                                <img src="images/SaveDoc.png" alt="Edit" border="0" width="25" >
                            </a>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <FooterStyle BackColor="White" ForeColor="#000066"></FooterStyle>

                <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White"></HeaderStyle>

                <PagerStyle HorizontalAlign="Left" BackColor="White" ForeColor="#000066"></PagerStyle>

                <RowStyle ForeColor="#000066"></RowStyle>

                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White"></SelectedRowStyle>

                <SortedAscendingCellStyle BackColor="#F1F1F1"></SortedAscendingCellStyle>

                <SortedAscendingHeaderStyle BackColor="#007DBB"></SortedAscendingHeaderStyle>

                <SortedDescendingCellStyle BackColor="#CAC9C9"></SortedDescendingCellStyle>

                <SortedDescendingHeaderStyle BackColor="#00547E"></SortedDescendingHeaderStyle>
            </asp:GridView>
        </div>
        <div class="card card-footer bg-info">

        </div>
    </div>

</asp:Content>
