<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SelfScreeningReport.aspx.cs" Inherits="BRH_Plubic.SelfScreeningReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">

    <asp:ScriptManager ID="ScriptManager_Master" runat="server"></asp:ScriptManager>

    <div class="col-10 mx-auto">
        <div class="h3 card card-header col-12 bg-info">
            Self Screening Report
        </div>
        <div class="card card-body col-12">
            <div class="row col-12 my-3">
                <div class="input-group col-12">
                    <div class="col-6 input-group">
                        <asp:UpdatePanel ID="UpdatePanel_DD_Field" runat="server">
                        <ContentTemplate>

                            <div class="col-4">
                                <asp:DropDownList ID="DD_Field" CssClass="btn btn-outline-info" OnSelectedIndexChanged="DD_Field_SelectedIndexChanged" AutoPostBack="true" runat="server">
                                    <asp:ListItem Value="" Text="ทั้งหมด"></asp:ListItem>
                                    <asp:ListItem Value="ss_id" Text="ID"></asp:ListItem>
                                    <asp:ListItem Value="ss_datetime" Text="DateTime"></asp:ListItem>
                                    <asp:ListItem Value="ss_staff" Text="พนักงาน"></asp:ListItem>
                                    <asp:ListItem Value="ss_staffid" Text="รหัสพนักงาน"></asp:ListItem>
                                    <asp:ListItem Value="emp_deptid" Text="รหัสแผนก"></asp:ListItem>
                                    <asp:ListItem Value="ss_sex" Text="เพศ"></asp:ListItem>
                                    <asp:ListItem Value="ss_age" Text="อายุ"></asp:ListItem>
                                    <asp:ListItem Value="ss_selffever" Text="มีไข้"></asp:ListItem>
                                    <asp:ListItem Value="ss_selfsymptoms" Text="มีอาการ"></asp:ListItem>
                                    <asp:ListItem Value="ss_country" Text="มาจากประเทศเสี่ยง"></asp:ListItem>
                                    <asp:ListItem Value="ss_countryother" Text="มาจากประเทศอื่น"></asp:ListItem>
                                    <asp:ListItem Value="ss_city" Text="มาจากจังหวัดเสี่ยง"></asp:ListItem>
                                    <asp:ListItem Value="ss_cityrisk" Text="ไปในพื้นที่เสี่ยง"></asp:ListItem>
                                    <asp:ListItem Value="ss_touchdetail" Text="สัมผัส ใกล้ชิด"></asp:ListItem>
                                    <%--<asp:ListItem Value="ss_score" Text="Score"></asp:ListItem>--%>
                                    <asp:ListItem Value="ss_ctr" Text="Criteria"></asp:ListItem>
                                </asp:DropDownList>
                            </div>

                            <div id="div_txt_search" class="col-6 mt-3" runat="server" visible="false">
                                <input type="text" id="txt_search" value="" placeholder="กรอกข้อความ" runat="server" />
                            </div>
                            <div id="div_dt_search" class="col-6 mt-3" runat="server" visible="false">
                                <input type="date" id="dt_search" value="" runat="server" />
                            </div>
                            <div id="div_rd_search" class="col-6 mt-3" runat="server" visible="false">
                                <div> <input type="radio" id="rd_search_1" name="rd_search" value="Yes" runat="server" />Yes </div>
                                <div> <input type="radio" id="rd_search_2" name="rd_search" value="No" runat="server" />No </div>
                            </div>

                            <div hidden="hidden">
                                <input type="text" id="txtH_field" value="" runat="server" />
                            </div>

                        </ContentTemplate>
                        </asp:UpdatePanel>

                        <div class="col-2 text-center">
                            <asp:Button ID="btn_search" CssClass="btn btn-outline-info mx-3" Text="Search" OnClick="btn_search_Click" runat="server" />
                        </div>
                    </div>

                    <div class="col-3 text-right mr-3">
                        <asp:Button ID="btnExport" CssClass="btn btn-outline-primary" runat="server" Text="Export To Excel" OnClick="btnExport_Click" />
                    </div>

                </div>
            </div>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                OnPageIndexChanging="GridView1_PageIndexChanging" PageSize="100" AllowPaging="true">

                <Columns>
                    <asp:TemplateField HeaderText="No.">
                        <ItemTemplate>
                            <%# Container.DataItemIndex + 1 %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <%--<asp:BoundField DataField="ss_id" HeaderText="ID"></asp:BoundField>--%>
                    <asp:BoundField DataField="ss_datetime" HeaderText="DateTime" DataFormatString="{0:dd/MM/yyyy HH:mm:ss}"></asp:BoundField>
                    <asp:BoundField DataField="ss_staffid" HeaderText="รหัสพนักงาน"></asp:BoundField>
                    <asp:BoundField DataField="emp_deptid" HeaderText="รหัสแผนก"></asp:BoundField>
                    <asp:BoundField DataField="ss_sex" HeaderText="เพศ"></asp:BoundField>
                    <asp:BoundField DataField="ss_age" HeaderText="อายุ"></asp:BoundField>
                    <asp:BoundField DataField="ss_selffever" HeaderText="มีไข้"></asp:BoundField>
                    <asp:BoundField DataField="ss_selffeverscore" HeaderText="อุณหภูมิ"></asp:BoundField>
                    <asp:BoundField DataField="ss_selfsymptoms" HeaderText="มีอาการ"></asp:BoundField>
                    <asp:BoundField DataField="ss_country" HeaderText="มาจากประเทศเสี่ยง"></asp:BoundField>
                    <asp:BoundField DataField="ss_countryother" HeaderText="มาจากประเทศอื่น"></asp:BoundField>
                    <asp:BoundField DataField="ss_city" HeaderText="มาจากจังหวัดเสี่ยง"></asp:BoundField>
                    <asp:BoundField DataField="ss_cityrisk" HeaderText="ไปในพื้นที่เสี่ยง"></asp:BoundField>
                    <asp:BoundField DataField="ss_touchdetail" HeaderText="สัมผัส ใกล้ชิด"></asp:BoundField>
                    <%--<asp:BoundField DataField="ss_score" HeaderText="Score"></asp:BoundField>--%>
                    <asp:BoundField DataField="ss_ctr" HeaderText="Criteria"></asp:BoundField>
                </Columns>
                <HeaderStyle BackColor="#009999" HorizontalAlign="Center" Font-Bold="True" ForeColor="White"></HeaderStyle>
                <PagerSettings Mode="NumericFirstLast" PageButtonCount="10" FirstPageText="<< " LastPageText=" >>" NextPageText=">" PreviousPageText="<" Position="TopAndBottom" />
                <PagerStyle HorizontalAlign="Right" />
            </asp:GridView>
        </div>
        <div class="card card-footer col-12 bg-info">

        </div>
    </div>

</asp:Content>
