<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Report.aspx.cs" Inherits="BRH_Plubic.ControlAsset.Report" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentDesktop" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="row col-12 mx-auto">
        <div class="row col-6 mx-auto">
            <div class="col-12 mx-auto my-auto">
                <asp:DropDownList ID="DD_Dept" CssClass="btn btn-outline-info" runat="server" OnSelectedIndexChanged="DD_Dept_SelectedIndexChanged" AutoPostBack="true">
                    <asp:ListItem Text="" Value=""></asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>
        <div class="card col-6 mx-auto my-3" style="border-radius: 20px; right:0;">
            <div class="col-12 mx-auto text-center h5">
                ความหมายของช่อง ดำเนินการ
            </div>
            <div class="row col-12 mx-auto">
                <div class="col-12 mx-auto">
                    <span style="color: green;">checked</span> = มีทรัพย์สินในแผนกผู้ดำเนินการ และพบในฐานข้อมูล
                </div>
                <div class="col-12 mx-auto">
                    <span style="color: blue;">add</span> = มีทรัพย์สินในแผนกผู้ดำเนินการ แต่ไม่พบในฐานข้อมูล
                </div>
                <div class="col-12 mx-auto">
                    <span style="color: red;">return</span> = ต้องการทำคืนทรัพย์สิน
                </div>
            </div>
        </div>
        <div class="col-8 mx-auto my-auto h3">
            รายงานการตรวจสอบข้อมูล Desktop & Laptop
        </div>
        <div class="col-4 mx-auto my-2 text-right" style="font-size: x-large;">
            <button id="btn_Export" class="btn btn-outline-success" onserverclick="btn_Export_ServerClick" runat="server">Export <img src="../images/excel_icon.png" style="width: 32px;"></button>
        </div>
        <div class="col-12 mx-auto">
        <asp:GridView ID="GridView1" CssClass="col-12 mx-auto" runat="server" AutoGenerateColumns="False">
            <Columns>
                <asp:BoundField DataField="asr_datetime" HeaderText="วันที่"></asp:BoundField>
                <asp:BoundField DataField="asr_user" HeaderText="รหัสพนักงาน"></asp:BoundField>
                <asp:BoundField DataField="emp_name" HeaderText="ชื่อ-นามสกุล"></asp:BoundField>
                <asp:BoundField DataField="asr_deptid" HeaderText="แผนก"></asp:BoundField>
                <asp:BoundField DataField="emp_deptdesc" HeaderText="ชื่อแผนก"></asp:BoundField>
                <asp:BoundField DataField="asr_action" HeaderText="ดำเนินการ"></asp:BoundField>
                <asp:BoundField DataField="asr_sn" HeaderText="Service Tag"></asp:BoundField>
                <asp:BoundField DataField="asset_cate" HeaderText="ประเภท"></asp:BoundField>
                <asp:BoundField DataField="asset_department" HeaderText="อยู่ที่แผนก"></asp:BoundField>
            </Columns>
        </asp:GridView>
        </div>
    </div>

</asp:Content>
