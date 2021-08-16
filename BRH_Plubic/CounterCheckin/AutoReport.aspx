<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AutoReport.aspx.cs" Inherits="BRH_Plubic.CounterCheckin.AutoReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">

    <div class="col-12 mx-ato">
        <asp:GridView ID="GridView1" CssClass="mx-auto" runat="server" AutoGenerateColumns="False">
            <Columns>
                <asp:BoundField DataField="cc_id" HeaderText="ID"></asp:BoundField>
                <asp:BoundField DataField="cc_datein" HeaderText="Datein" DataFormatString="{0: dd/MM/yyyy}"></asp:BoundField>
                <asp:BoundField DataField="cc_timein" HeaderText="Checkin"></asp:BoundField>
                <asp:BoundField DataField="cc_dateout" HeaderText="Dateout" DataFormatString="{0: dd/MM/yyyy}"></asp:BoundField>
                <asp:BoundField DataField="cc_timeout" HeaderText="Checkout"></asp:BoundField>
                <asp:BoundField DataField="cc_empid" HeaderText="EmpID"></asp:BoundField>
                <asp:BoundField DataField="cc_deptid" HeaderText="DeptID"></asp:BoundField>
            </Columns>
        </asp:GridView>
    </div>

</asp:Content>
