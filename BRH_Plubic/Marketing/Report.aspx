<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Report.aspx.cs" Inherits="BRH_Plubic.Marketing.Report" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">

    <asp:ScriptManager ID="ScriptManager_Master" runat="server"></asp:ScriptManager>

    <div class="col-11 mx-auto">

        <div class="col-9 mx-auto text-right">
            <a href="ForBill.aspx"><img src="image/invoice_bill.png" onclick="Search()" /></a> 
        </div>
        <div id="div_btn_search_1" class="col-9 mx-auto">
            <img src="image/search.png" width="44" onclick="Search()" />
        </div>

        <div id="div_search" hidden="hidden" class="col-8 border border-primary mx-auto mb-2">
            <div class="row col-11 mx-auto my-2">
                <div class="col-3 text-right">เลขที่สั่งซื้อ</div> 
                <div class="col-9 text-left"><input type="text" id="txt_id" class="col-6 form-control" value="" runat="server" /></div>
            </div>
            <div class="row col-11 mx-auto my-2">
                <div class="col-3 text-right">วันที่สั่งซื้อ</div> 
                <div class="col-9 text-left"><input type="date" id="date_order" class="col-6 form-control" value="" runat="server" /></div>
            </div>
            <div class="row col-11 mx-auto my-2">
                <div class="col-3 text-right">ชื่อ นามสกุล</div> 
                <div class="col-9 text-left"><input type="text" id="txt_name" class="col-6 form-control" value="" runat="server" /></div>
            </div>
            <div class="row col-11 mx-auto my-2">
                <div class="col-3 text-right">เบอร์โทรศัพท์</div> 
                <div class="col-9 text-left"><input type="text" id="txt_phone" class="col-6 form-control" value="" runat="server" /></div>
            </div>
            <div class="row col-11 mx-auto my-2">
                <div class="col-3 text-right">สถานะชำระ</div> 
                <div class="col-9 text-left">
                    <asp:DropDownList ID="DD_PayStatus" CssClass="col-6 form-control" runat="server">
                        <asp:ListItem Value="" Text="ทั้งหมด" Selected="True"></asp:ListItem>
                        <asp:ListItem Value="confirm" Text="บัญชียืนยันการชำระแล้ว"></asp:ListItem>
                        <asp:ListItem Value="yes" Text="แจ้งชำระแต่บัญชียังไม่ตรวจสอบ"></asp:ListItem>
                        <asp:ListItem Value="no" Text="ยังไม่ชำระเข้ามา"></asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            <div class="row col-11 mx-auto my-2">
                <div class="col-3 text-right">ช่องทางการรับสินค้า</div> 
                <div class="col-9 text-left">
                    <asp:DropDownList ID="DD_Send" CssClass="col-6 form-control" runat="server">
                        <asp:ListItem Value="" Text="ทั้งหมด" Selected="True"></asp:ListItem>
                         <asp:ListItem Value="รับสินค้า ณ จุดจำหน่าย" Text="รับสินค้า ณ จุดจำหน่าย"></asp:ListItem>
                        <asp:ListItem Value="จัดส่งสินค้าตามที่อยู่" Text="จัดส่งสินค้าตามที่อยู่"></asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            <div class="row col-11 mx-auto my-2">
                <div class="col-3 text-right">รับ/จัดส่ง</div> 
                <div class="col-9 text-left">
                    <asp:DropDownList ID="DD_Receive" CssClass="col-6 form-control" runat="server">
                        <asp:ListItem Value="" Text="ทั้งหมด" Selected="True"></asp:ListItem>
                         <asp:ListItem Value="no" Text="ยังไม่ได้รับ/ยังไม่ได้จัดส่ง"></asp:ListItem>
                        <asp:ListItem Value="yes" Text="รับสินค้าแล้ว/จัดส่งสินค้าแล้ว"></asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            <div class="col-8 mx-auto text-center my-3">
                <a href="#" id="btn_clear" class="mr-5" onclick="Clear()"><img src="image/clear.png" width="44" /></a>
                <a href="#" id="btn_search" runat="server" onserverclick="btn_search_ServerClick"><img src="image/search.png" width="44" /></a>
            </div>
        </div>

        <script>
            var div_search = document.getElementById('div_search');
            var btn_search_1 = document.getElementById('div_btn_search_1');

            function Search() {
                div_search.hidden = false;
                btn_search_1.hidden = true;
            }
            function Clear() {
                window.location.href = 'Report.aspx';
            }
        </script>

        <asp:UpdatePanel ID="UpdatePanel_Grid1" runat="server">
            <ContentTemplate>
                <asp:GridView ID="GridView1" CssClass="mx-auto" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3">
                    <Columns>
                        <asp:BoundField DataField="hd_id" HeaderText="เลขที่สั่งซื้อ">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="hd_date" HeaderText="วันเวลาที่สั่งซื้อ" DataFormatString="{0: dd/MM/yyyy HH:mm:ss}"></asp:BoundField>
                        <asp:BoundField DataField="name" HeaderText="ชื่อ - นามสกุล"></asp:BoundField>
                        <asp:BoundField DataField="hd_pnumber" HeaderText="เบอร์โทรศัพท์"></asp:BoundField>
                        <asp:BoundField DataField="hd_totalqty" HeaderText="จำนวน">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="hd_total" HeaderText="ราคารวม" DataFormatString="{0: #,##0.00}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="hd_shippingcost" HeaderText="ค่าจัดส่ง" DataFormatString="{0: #,##0.00}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="hd_priceslip" DataFormatString="{0: #,##0.00}" HeaderText="ยอดที่ชำระ">
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </asp:BoundField>
                        <%--<asp:BoundField DataField="PayDatetime" HeaderText="วันเวลาที่ชำระ" DataFormatString="{0: dd/MM/yyyy HH:mm}"></asp:BoundField>--%>
                        <asp:BoundField DataField="hd_paystatus" HeaderText="สถานะชำระ">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="hd_shippingstatus" HeaderText="ช่องทางการรับสินค้า"></asp:BoundField>
                        <asp:BoundField DataField="hd_receive" HeaderText="รับ/จัดส่ง">
                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Detail" HeaderStyle-CssClass="title_bg" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <a class="btn btn-light" href="Detail.aspx?id=<%# Eval("hd_id") %>">
                                    <img src="../images/More.png" class="mx-auto" alt="More" border="0" width="18" >
                                </a>
                            </ItemTemplate>
                        </asp:TemplateField>
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
                <asp:AsyncPostBackTrigger ControlID="btn_search" EventName="serverclick" />
            </Triggers>
        </asp:UpdatePanel>
    </div>

</asp:Content>
