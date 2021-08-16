<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MsTeamAgreeReport.aspx.cs" Inherits="BRH_Plubic.MsTeamAgreeReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">

<div class="col-10 mx-auto my-auto text-center">

    <div class="col-10 text-right mb-3">
        <asp:Button ID="btnExport" CssClass="btn btn-outline-primary" runat="server" Text="Export To Excel" OnClick="btnExport_Click" />
    </div>

    <asp:GridView ID="GridView1" CssClass="col-12 mx-auto text-center" runat="server" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical" AutoGenerateColumns="False">
        <AlternatingRowStyle BackColor="#CCCCCC"></AlternatingRowStyle>

        <Columns>
            <asp:BoundField DataField="ms_id" HeaderText="ID"></asp:BoundField>
            <asp:BoundField DataField="ms_adddatetime" HeaderText="วันที่สมัคร" DataFormatString="{0: dd/MM/yyyy}"></asp:BoundField>
            <asp:BoundField DataField="FullNameTH" HeaderText="ชื่อ-นามสกุล"></asp:BoundField>
            <asp:BoundField DataField="FullName" HeaderText="Name"></asp:BoundField>
            <asp:BoundField DataField="ms_gender" HeaderText="เพศ"></asp:BoundField>
            <asp:BoundField DataField="ms_dob" HeaderText="วันเดือนปีเกิด" DataFormatString="{0: dd/MM/yyyy}"></asp:BoundField>
            <asp:BoundField DataField="ms_cardtype" HeaderText="บัตร"></asp:BoundField>
            <asp:BoundField DataField="ms_cardnum" HeaderText="เลขที่บัตร"></asp:BoundField>
            <%--<asp:BoundField DataField="ms_phone" HeaderText="เบอร์โทรศัพท์"></asp:BoundField>
            <asp:BoundField DataField="ms_email" HeaderText="อีเมล"></asp:BoundField>
            <asp:BoundField DataField="ms_line" HeaderText="ไอดีไลน์"></asp:BoundField>
            <asp:BoundField DataField="ms_reason" HeaderText="เหตุผล"></asp:BoundField>--%>
            <asp:TemplateField HeaderText="Detail" HeaderStyle-CssClass="title_bg" ItemStyle-HorizontalAlign="Center">
                <ItemTemplate>
                    <a class="btn btn-light" href="MsTeamAgreeDetail.aspx?id=<%# Eval("ms_id") %>">
                        <img src="images/More.png" class="mx-auto" alt="More" border="0" width="25" >
                    </a>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Print" HeaderStyle-CssClass="title_bg" ItemStyle-HorizontalAlign="Center">
                <ItemTemplate>
                    <a class="btn btn-light" href="MsTeamAgree.aspx?form=<%# Eval("ms_docform") %>&id=<%# Eval("ms_id") %>">
                        <img src="images/SaveDoc.png" alt="Document" border="0" width="25" >
                    </a>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>

        <FooterStyle BackColor="#CCCCCC"></FooterStyle>

        <HeaderStyle BackColor="#0099ff" Font-Bold="True" ForeColor="White"></HeaderStyle>

        <PagerStyle HorizontalAlign="Center" BackColor="#999999" ForeColor="Black"></PagerStyle>

        <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White"></SelectedRowStyle>

        <SortedAscendingCellStyle BackColor="#F1F1F1"></SortedAscendingCellStyle>

        <SortedAscendingHeaderStyle BackColor="#808080"></SortedAscendingHeaderStyle>

        <SortedDescendingCellStyle BackColor="#CAC9C9"></SortedDescendingCellStyle>

        <SortedDescendingHeaderStyle BackColor="#383838"></SortedDescendingHeaderStyle>
    </asp:GridView>
</div>

</asp:Content>
