<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BookVaccinateReport.aspx.cs" Inherits="BRH_Plubic.BookVaccinateReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">

    <asp:ScriptManager ID="ScriptManager_Master" runat="server"></asp:ScriptManager>

    <asp:UpdatePanel ID="UpdatePanel_Calendar" runat="server">
       <ContentTemplate>

    <div class="col-8 mx-auto text-center">
        <div class="text-right">
            <asp:DropDownList ID="DD_location" CssClass="btn btn-light text-left" OnSelectedIndexChanged="DD_location_SelectedIndexChanged" AutoPostBack="true" runat="server">
                <asp:ListItem Text="All Location" Value="" Selected="True"></asp:ListItem>
                <asp:ListItem Text="รพ.กรุงเทพระยอง" Value="รพ.กรุงเทพระยอง"></asp:ListItem>
                <asp:ListItem Text="รพ.ศรีระยอง" Value="รพ.ศรีระยอง"></asp:ListItem>
                <asp:ListItem Text="คลินิก บ้านฉาง" Value="คลินิก บ้านฉาง"></asp:ListItem>
                <asp:ListItem Text="คลินิก บ่อวิน" Value="คลินิก บ่อวิน"></asp:ListItem>
            </asp:DropDownList>
        </div>
        <asp:Calendar ID="CLD_book" CssClass="col-12 mx-auto" Height="500" OnSelectionChanged="CLD_book_SelectionChanged" OnDayRender="CLD_book_DayRender" runat="server">
            <TitleStyle Font-Size="X-Large" ForeColor="White" BackColor="#9e1782" CssClass="bg-gradient" />
            <DayHeaderStyle BackColor="#c1c1c1" />
            <SelectedDayStyle BackColor="#ba75b4" />
            <DayStyle BorderWidth="1" HorizontalAlign="Right" VerticalAlign="Top" Font-Size="XX-Large" />
        </asp:Calendar>
        <div hidden="hidden">
            <input type="text" id="txtH_bookdate" value="" runat="server" />
        </div>
    </div>
        
        </ContentTemplate>
    </asp:UpdatePanel>

    <div class="col-8 mx-auto text-right mt-5 mb-2">
        <asp:Button ID="btnExport" CssClass="btn btn-outline-primary" runat="server" Text="Export To Excel" OnClick="btnExport_Click" />
    </div>

    <asp:UpdatePanel ID="UpdatePanel_Grid1" runat="server">
       <ContentTemplate>

    <div class="col-12 mx-auto text-center">
        <asp:GridView ID="GridView1" CssClass="mx-auto" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None">
            <AlternatingRowStyle BackColor="White"></AlternatingRowStyle>
            <Columns>
                <asp:BoundField DataField="vb_adddate" HeaderText="TIMESTAMP" DataFormatString="{0: dd/MM/yyyy HH:mm}"></asp:BoundField>
                <asp:BoundField DataField="vb_bookdate" HeaderText="วันที่นัดหมาย" DataFormatString="{0: dd/MM/yyyy HH:mm}"></asp:BoundField>
                <asp:BoundField DataField="FullName" HeaderText="ชื่อ - นามสกุล"></asp:BoundField>
                <asp:BoundField DataField="vb_status" HeaderText="สถานะ"></asp:BoundField>
                <asp:BoundField DataField="vb_empid" HeaderText="รหัสพนักงาน"></asp:BoundField>
                <asp:BoundField DataField="vb_dob" HeaderText="วัน/เดือน/ปีเกิด" DataFormatString="{0: dd/MM/yyyy}"></asp:BoundField>
                <asp:BoundField DataField="vb_age" HeaderText="อายุ/ปี"></asp:BoundField>
                <asp:BoundField DataField="vb_payer" HeaderText="การชำระเงิน"></asp:BoundField>
                <asp:BoundField DataField="vb_location" HeaderText="รับบริการที่"></asp:BoundField>
                <asp:BoundField DataField="vb_ComeHow" HeaderText="มารับบริการโดย"></asp:BoundField>
                <asp:BoundField DataField="vb_phone" HeaderText="เบอร์โทรศัพท์"></asp:BoundField>
                <asp:BoundField DataField="vb_havebeen" HeaderText="เคยมาที่นี่แล้ว"></asp:BoundField>
                <asp:BoundField DataField="vb_congenitaldisease" HeaderText="โรคประจำตัว"></asp:BoundField>
                <asp:BoundField DataField="vb_drugallergy" HeaderText="แพ้ยา"></asp:BoundField>
                <asp:BoundField DataField="vb_allergiceggs" HeaderText="แพ้ไข่"></asp:BoundField>
                <asp:BoundField DataField="vb_allergicvaccines" HeaderText="แพ้วัคซีน"></asp:BoundField>
                <asp:BoundField DataField="vb_allergicvaccinesdesc" HeaderText="ข้อมูลแพ้วัคซีน"></asp:BoundField>
                <asp:BoundField DataField="vb_fever" HeaderText="เป็นไข้"></asp:BoundField>
                <asp:BoundField DataField="vb_pregnant" HeaderText="ตั้งครรภ์"></asp:BoundField>
                <asp:BoundField DataField="vb_gillenbarre" HeaderText="GBS"></asp:BoundField>
            </Columns>
            <EditRowStyle BackColor="#7C6F57"></EditRowStyle>
            <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White"></FooterStyle>
            <HeaderStyle BackColor="#9b1181" Font-Bold="True" ForeColor="White"></HeaderStyle>
            <PagerStyle HorizontalAlign="Center" BackColor="#666666" ForeColor="White"></PagerStyle>
            <RowStyle BackColor="#E3EAEB"></RowStyle>
            <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333"></SelectedRowStyle>
            <SortedAscendingCellStyle BackColor="#F8FAFA"></SortedAscendingCellStyle>
            <SortedAscendingHeaderStyle BackColor="#246B61"></SortedAscendingHeaderStyle>
            <SortedDescendingCellStyle BackColor="#D4DFE1"></SortedDescendingCellStyle>
            <SortedDescendingHeaderStyle BackColor="#15524A"></SortedDescendingHeaderStyle>
        </asp:GridView>
    </div>

        </ContentTemplate>
        <Triggers>
               <asp:AsyncPostBackTrigger ControlID="CLD_book" EventName="selectionchanged" />
        </Triggers>
    </asp:UpdatePanel>

</asp:Content>
