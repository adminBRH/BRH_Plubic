<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ARIReport.aspx.cs" Inherits="BRH_Plubic.ARIReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">

	<asp:ScriptManager ID="ScriptManager_Master" runat="server"></asp:ScriptManager>

	<asp:UpdatePanel ID="UpdatePanel_calendar" runat="server">
		<ContentTemplate>

			<div class="col-8 mx-auto text-right mb-3">
				<asp:DropDownList ID="DD_type" CssClass="btn btn-primary" OnSelectedIndexChanged="DD_type_SelectedIndexChanged" AutoPostBack="true" runat="server">
					<asp:ListItem Value="" Text="ALL" Selected="True"></asp:ListItem>
					<asp:ListItem Value="Adult" Text="Adult"></asp:ListItem>
					<asp:ListItem Value="Child" Text="Child"></asp:ListItem>
				</asp:DropDownList>
				<div hidden="hidden">
					<input type="text" id="txtH_type" value="" runat="server" />
				</div>
			</div>
			<div class="col-8 mx-auto text-center">
				<asp:Calendar ID="CLD_book" CssClass="col-12 mx-auto" Height="500" BackColor="#e7eaed"
				OnSelectionChanged="CLD_book_SelectionChanged" 
				OnDayRender="CLD_book_DayRender" 
				runat="server">
					<TitleStyle BackColor="#9f2684" CssClass="bg-gradient" ForeColor="White" Font-Size="X-Large"/>
					<DayHeaderStyle BackColor="#3590fc" Font-Size="Large" HorizontalAlign="Center" />
					<DayStyle Font-Bold="true" ForeColor="Blue" HorizontalAlign="Center" VerticalAlign="Top" BackColor="#c0c0c0" BorderWidth="1" BorderColor="#333333" />
					<TodayDayStyle BackColor="#99ccff" />
					<SelectedDayStyle CssClass="rounded-circle" BackColor="#c40779" ForeColor="White" Font-Bold="true" />
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
                <asp:GridView ID="GridView1" CssClass="col-10 mx-auto" runat="server" AutoGenerateColumns="False">
                    <Columns>
                        <asp:BoundField DataField="ab_bookdate" HeaderText="วันที่จอง" DataFormatString="{0: dd/MM/yyyy}"></asp:BoundField>
                        <asp:BoundField DataField="ab_times" HeaderText="เวลาที่จอง"></asp:BoundField>
						<asp:BoundField DataField="ab_name" HeaderText="ชื่อ นามสกุล"></asp:BoundField>
						<asp:BoundField DataField="ab_dob" HeaderText="วันเดือนปีเกิด" DataFormatString="{0: dd/MM/yyyy}"></asp:BoundField>
						<asp:BoundField DataField="ab_cardnum" HeaderText="เลขบัตรประชาชน"></asp:BoundField>
						<asp:BoundField DataField="ab_phone" HeaderText="เบอร์โทรศัพท์"></asp:BoundField>
						<asp:BoundField DataField="ab_fever" HeaderText="มีไข้"></asp:BoundField>
						<asp:BoundField DataField="ab_cough" HeaderText="ไอ"></asp:BoundField>
						<asp:BoundField DataField="ab_sore_throats" HeaderText="เจ็บคอ"></asp:BoundField>
						<asp:BoundField DataField="ab_runny_nose" HeaderText="น้ำมูกไหล"></asp:BoundField>
						<asp:BoundField DataField="ab_shortness_of_breath" HeaderText="เหนื่อยหอบ"></asp:BoundField>
						<asp:BoundField DataField="ab_province" HeaderText="มาจาก ตจว."></asp:BoundField>
						<asp:BoundField DataField="ab_suspect" HeaderText="สัมผัสใกล้ชิด"></asp:BoundField>
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
