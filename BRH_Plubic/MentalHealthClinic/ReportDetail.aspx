<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ReportDetail.aspx.cs" Inherits="BRH_Plubic.MentalHealthClinic.ReportDetail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">
     <div class="card ">
        <div class="card-body text-center">
            <h3>MentalHealthClinic Report</h3>
            <br />
            <asp:GridView ID="Report_user" class="col-10 mx-auto bg-light" runat="server" AutoGenerateColumns="False" CellPadding="3" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px">
                <Columns>
                    <asp:BoundField DataField="m_id" HeaderText="ID"></asp:BoundField>
                    <asp:BoundField DataField="fname" HeaderText="Firstname"></asp:BoundField>
                    <asp:BoundField DataField="lname" HeaderText="Lastname"></asp:BoundField>
                    <asp:BoundField DataField="color_temp" HeaderText="TempColor"></asp:BoundField>
                    <asp:BoundField DataField="color_id" HeaderText="TempNumber"></asp:BoundField>
                    <asp:BoundField DataField="p_number" HeaderText="Phone"></asp:BoundField>
                    <asp:BoundField DataField="line_id" HeaderText="LineID"></asp:BoundField>

                    <asp:TemplateField HeaderText="Report">
                        <ItemTemplate>
                           <a href="Default.aspx?id=<%# Eval("m_id") %>"><img src="img/Report.png" width="30px"/></a> 
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
         </div>
</asp:Content>
