<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TimelineList.aspx.cs" Inherits="BRH_Plubic.Covid19.TimelineList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentDesktop" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<script>
    function fn_checkStatus(val,id) {
        var btnEdit = '<a id="btn_edit" class="col-12 btn btn-outline-info mx-auto" onclick="fn_edit(' + id + ')"><i class="ti-pencil-alt"></i></a>';
        var btnPre = '<a id="btn_pre" class="col-12 btn btn-outline-info mx-auto" onclick="fn_pre(' + id + ')"><i class="ti-printer"></i></a>';
        var btnShow = '';
        if (val == 'Checked') {
            btnShow = btnPre;
        } else {
            btnShow = btnEdit;
        }
        document.write(btnShow);
    }
</script>
    <div class="row col-12 mx-auto">
        <div class="col-12 mx-auto text-left" style="font-size: xx-large;">
            <a href="Timeline.aspx" target="_blank" class="btn btn-outline-primary">กรอกข้อมูล <i class="ti-pencil"></i></a>
        </div>
        <div class="col-12 mx-auto">
            <asp:ListView ID="LV_list" runat="server" OnPagePropertiesChanging="LV_list_PagePropertiesChanging">
                <LayoutTemplate>
                    <table class="table table-success table-striped" style="width: 100%">
                        <tr>
                            <th class="text-center" style="width: 5%">No.</th>
                            <th class="text-center" style="width: 10%">ID</th>
                            <th class="text-center" style="width: 50%">Name</th>
                            <th class="text-center" style="width: 20%">Phone</th>
                            <th class="text-center" style="width: 10%">Status</th>
                            <th class="text-center" style="width: 5%"></th>
                        </tr>
                        <tr id="itemPlaceholder" runat="server"></tr>
                        <tr runat="server">  
                            <td colspan="6" class="text-right" runat="server">  
                                <asp:DataPager runat="server" PageSize="10" ID="DataPager1">  
                                    <Fields>  
                                        <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False"></asp:NextPreviousPagerField>  
                                        <asp:NumericPagerField></asp:NumericPagerField>  
                                        <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False"></asp:NextPreviousPagerField>  
                                    </Fields>  
                                </asp:DataPager>  
                            </td>  
                        </tr>  
                    </table>    
                </LayoutTemplate>
                <ItemTemplate>
                    <tr>
                        <td class="text-center"><%# Eval("ct_index") %></td>
                        <td class="text-center"><%# Eval("ct_id") %></td>
                        <td><%# Eval("ct_fname") %><%# Eval("ct_lname") %></td>
                        <td><%# Eval("ct_phone") %></td>
                        <td class="text-center"><%# Eval("ct_status") %></td>
                        <td class="text-center">
                            <script>fn_checkStatus('<%# Eval("ct_status") %>','<%# Eval("ct_id") %>');</script>
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:ListView>
        </div>
    </div>
<script>
    function fn_edit(id) {
        window.location.href = '/Covid19/Timeline?id=' + id;
    }
    function fn_pre(id) {
        window.location.href = '/Covid19/TimelineReport?id=' + id;
    }
</script>
</asp:Content>
