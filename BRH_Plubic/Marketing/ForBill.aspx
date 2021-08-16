<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ForBill.aspx.cs" Inherits="BRH_Plubic.Marketing.ForBill" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">

    <asp:ScriptManager ID="ScriptManager_Master" runat="server"></asp:ScriptManager>

    <div class="col-8 card card-header bg-info mx-auto text-center mb-2 h1" style="color:white">
        รายละเอียดการสั่งซื้อสินค้า
    </div>
    <div class="col-8 mx-auto text-right mb-3">
        <asp:Button ID="btnExport" CssClass="btn btn-outline-primary" runat="server" Text="Export To Excel" OnClick="btnExport_Click" />
    </div>
    <div class="col-11 mx-auto">
        <div class="row col-12 mx-auto">
            <div class="col-4 text-right">วันที่สั่งซื้อ <input type="date" id="date_start" value="" runat="server" /></div>
            <div class="col-4">ถึง <input type="date" id="date_end" value="" runat="server" /></div>
            <div class="col-4"><a href="#" id="a_search" onserverclick="a_search_ServerClick" runat="server"><img src="image/search.png" width="44" /></a></div>
        </div>
        <asp:UpdatePanel ID="UpdatePanel_Grid1" runat="server">
            <ContentTemplate>
                <div class="row col-12 mx-auto text-center">
                    <asp:Label ID="lbl_alert" CssClass="mx-auto text-center" Text="" ForeColor="Red" runat="server"></asp:Label>
                </div>
                <asp:GridView ID="GridView1" CssClass="mx-auto" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3">
                    <Columns>
                        <asp:BoundField DataField="hd_id" HeaderText="เลขที่สั่งซื้อ"></asp:BoundField>
                        <asp:BoundField DataField="hd_date" HeaderText="วันที่สั่งซื้อ" DataFormatString="{0: dd/MM/yyyy}"></asp:BoundField>
                        <asp:BoundField DataField="dt_mk_productname" HeaderText="รายการ"></asp:BoundField>
                        <asp:BoundField DataField="dt_qty" HeaderText="จำนวน"></asp:BoundField>
                        <asp:BoundField DataField="dt_price" HeaderText="ราคา"></asp:BoundField>
                        <asp:BoundField DataField="dt_total" HeaderText="รวม"></asp:BoundField>
                        <asp:BoundField DataField="dt_disc" HeaderText="ส่วนลด"></asp:BoundField>
                        <asp:BoundField DataField="dt_net" HeaderText="สุทธิ"></asp:BoundField>
                        <asp:BoundField DataField="hd_paystatus" HeaderText="สถานะชำระ"></asp:BoundField>
                        <asp:BoundField DataField="hd_dateslip" HeaderText="วันที่ชำระ" DataFormatString="{0: dd/MM/yyyy}"></asp:BoundField>
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
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="a_search" EventName="serverclick" />
            </Triggers>
        </asp:UpdatePanel>
    </div>

</asp:Content>
