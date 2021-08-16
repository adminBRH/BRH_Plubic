<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Report.aspx.cs" Inherits="BRH_Plubic.Evaluate360.Report" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">

    <div class="col-11 mx-auto">
        <div class="card card-header bg-info mx-auto text-center h1" style="color:white">
            Report การประเมิน 360 องศา
        </div>
        <div class="card card-body mx-auto">
            <div class="col-10 mx-auto mb-3">
                <div class="row col-12 mx-auto">
                    <div class="row col-4 mx-auto text-right">
                        <asp:DropDownList ID="DD_date" CssClass="btn btn-light form-control" OnSelectedIndexChanged="DD_date_SelectedIndexChanged" AutoPostBack="true" runat="server">
                            <asp:ListItem Text="" Value=""></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-4 mx-auto text-left">
                        &nbsp;
                    </div>
                    <div class="col-4 mx-auto text-right">
                        <asp:Button ID="btnExport" CssClass="btn btn-primary" runat="server" Text="Export To Excel" OnClick="btnExport_Click" />
                    </div>
                </div>
            </div>
            <asp:GridView ID="GridView1" runat="server" CssClass="mx-auto" AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3">
                <Columns>
                    <asp:TemplateField>
                        <HeaderTemplate>ลำดับ</HeaderTemplate>
                        <ItemTemplate><%# Container.DataItemIndex + 1 %></ItemTemplate>
                    </asp:TemplateField>
                    <%--<asp:BoundField DataField="ev_id" HeaderText="ลำดับ"></asp:BoundField>--%>
                    <asp:BoundField DataField="ev_adddate" HeaderText="วันที่"></asp:BoundField>
                    <asp:BoundField DataField="ev_deptname" HeaderText="แผนก"></asp:BoundField>
                    <asp:BoundField DataField="ev_empid" HeaderText="รหัสพนักงาน"></asp:BoundField>
                    <asp:BoundField DataField="ev_name" HeaderText="ชื่อ-นามสกุล"></asp:BoundField>
                    <asp:BoundField DataField="ev_mode" HeaderText="การประเมิน"></asp:BoundField>
                    <asp:BoundField DataField="ev_topic1" HeaderText="ข้อที่ 1"></asp:BoundField>
                    <asp:BoundField DataField="ev_topic2" HeaderText="ข้อที่ 2"></asp:BoundField>
                    <asp:BoundField DataField="ev_topic3" HeaderText="ข้อที่ 3"></asp:BoundField>
                    <asp:BoundField DataField="ev_topic4" HeaderText="ข้อที่ 4"></asp:BoundField>
                    <asp:BoundField DataField="ev_topic5" HeaderText="ข้อที่ 5"></asp:BoundField>
                    <asp:BoundField DataField="ev_topic6" HeaderText="ข้อที่ 6"></asp:BoundField>
                    <asp:BoundField DataField="ev_topic7" HeaderText="ข้อที่ 7"></asp:BoundField>
                    <asp:BoundField DataField="ev_topic8" HeaderText="ข้อที่ 8"></asp:BoundField>
                    <asp:BoundField DataField="ev_topic9" HeaderText="ข้อที่ 9"></asp:BoundField>
                    <asp:BoundField DataField="ev_remark" HeaderText="ข้อเสนอแนะ"></asp:BoundField>
                </Columns>
                <FooterStyle BackColor="White" ForeColor="#000066"></FooterStyle>

                <HeaderStyle BackColor="#006699" HorizontalAlign="Center" Font-Bold="True" ForeColor="White"></HeaderStyle>

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

</asp:Content>
