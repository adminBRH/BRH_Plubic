<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Report.aspx.cs" Inherits="BRH_Plubic.VaccineCovid.Report" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentDesktop" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<style>
    .ddStatus {
        padding: 10px; 
        margin-right: 100px;
        margin-bottom: -5px;
    }
    .boxStatus {
        position: absolute;
        margin-top: -10px;
        margin-left: -40px;
        padding: 10px;
        color: white;
        text-shadow: 2px 2px 2px #000000;
        background-color: lightblue;
        border-radius: 20px;
        font-size: xx-large;
    }
    .boxCheck {
        position: absolute;
        margin-top: -10px;
        margin-left: 99%;
        margin-right: 0px;
        padding: 10px;
        color: white;
        text-shadow: 2px 2px 2px #000000;
        background-color: lightblue;
        border-radius: 20px;
        font-size: xx-large;
    }
</style>
<script>
    function fn_datetimeSlip(datetimes) {
        var result = '';
        if (datetimes != '') {
            var newDate = new Date(datetimes);
            var monthfull = ['มกราคม', 'กุมภาพันธ์', 'มีนาคม', 'เมษายน', 'พฤษภาคม', 'มิถุนายน', 'กรกฎาคม', 'สิงหาคม', 'กันยายน', 'ตุลาคม', 'พฤศจิกายน', 'ธันวาคม'];
            var month = ['ม.ค.', 'ก.พ.', 'มี.ค.', 'ม.ย.', 'พ.ค.', 'มิ.ย.', 'ก.ค.', 'ส.ค.', 'ก.ย.', 'ต.ค.', 'พ.ย.', 'ธ.ค.'];
            var yearThai = newDate.getFullYear() + 543;
            var yearTh = yearThai - 2500;
            var HH = newDate.getHours();
            if (HH < 10) { HH = '0' + HH; }
            var mm = newDate.getMinutes();
            if (mm < 10) { mm = '0' + mm; }
            result = newDate.getDate() + ' ' + month[newDate.getMonth()] + ' ' + yearTh + ' &nbsp;&nbsp;' + HH + ':' + mm + ' น.';
        }
        document.write(result);
    }
    function fn_paidID(id) {
        if (id != '') {
            id = '<br />' + id;
        }
        document.write(id);
    }
    function fn_check(status, payid) {
        var html = '';
        if (status == 'paid') {
            html = '<a class="btn"><i class="fa fa-times-rectangle" style="color: red;"></i></a> <a class="btn" onclick="fn_confirm(\'' + payid + '\')" > <i class="fa fa-check-square fa-2x" style="color: greenyellow;"></i></a >';
        }
        document.write(html);
    }
</script>

    <div class="col-12 mx-auto" style="margin: auto;">
        <div class="row">
            <div class="col-6 mx-auto text-left">
                <a id="btn_Export" style="cursor: pointer; font-size: large; margin-left: 100px;" onserverclick="btn_Export_ServerClick" runat="server"><i class="fa fa-download" style="color: forestgreen;"></i> Excel</a>
            </div>
            <div class="col-6 mx-auto text-right" style="font-weight: bold; font-size: x-large;">
                STATUS 
                <asp:DropDownList ID="dd_status" CssClass="btn btn-info ddStatus" OnSelectedIndexChanged="dd_status_SelectedIndexChanged" AutoPostBack="true" runat="server">
                    <asp:ListItem Text="" Value=""></asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>
        <asp:ListView ID="LV_data" runat="server">
            <LayoutTemplate>
                <div class="col-12 mx-auto bg-info text-center h2" style="color: white; text-shadow: 2px 2px 2px #808080; border-radius: 20px; padding: 10px;">
                    BRH Report Slip Moderna.
                </div>
                <div id="itemPlaceholder" runat="server"></div>
            </LayoutTemplate>
            <ItemTemplate>
                <div class="card col-11 mx-auto my-2" style="margin: auto; box-shadow: 2px 2px #808080; padding: 5px;">
                    <div class="row" style="font-weight: bold; font-size: large;">
                        <div class="boxStatus">
                            <%# Eval("cm_status") %>
                            <script>fn_paidID('<%# Eval("pm_id") %>');</script>
                        </div>
                        <div class="boxCheck">
                            <script> fn_check('<%# Eval("cm_status") %>','<%# Eval("pm_id") %>'); </script>
                        </div>
                        <div class="col-4 mx-auto text-right" style="margin-top: 0px;">
                            <img src="<%# Eval("pm_slip") %>" style="width: 80%" />
                        </div>
                        <div class="row col-8 mx-auto" style="margin-top: 0px;">
                            <div class="row col-6 mx-auto" style="margin-top: 0px;">
                                <div class="col-12 mx-auto">
                                    วันเวลาที่ทำการโอน<br />
                                    <span class="badge badge-warning" style="font-size: x-large;">
                                        <div class="col-12 mx-auto"><script>fn_datetimeSlip('<%# Eval("pm_slipdatetime") %>');</script></div>
                                    </span>
                                </div>
                                <div class="col-12 mx-auto">
                                    ที่ต้องการจริงๆ <span class="badge badge-success" style="font-size: x-large;"><%# Eval("want_qty") %></span> เข็ม
                                </div>
                                <div class="col-12 mx-auto">
                                    ยอดชำระ <span class="badge badge-success" style="font-size: x-large;"><%# Eval("pay_total") %></span> บาท
                                </div>
                            </div>
                            <div class="row col-6 mx-auto" style="margin-top: 0px;">
                                <div class="col-12 mx-auto" style="font-size: x-large;"><%# Eval("cm_name") %></div>
                                <div class="col-12 mx-auto">
                                    <i class="fa fa-user-circle"></i> <span class="badge badge-dark" style="font-size: x-large;"><%# Eval("cm_cardid") %></span> <%# Eval("cm_cardtype") %>
                                </div>
                                <div class="col-12 mx-auto">
                                    <i class="fa fa-phone"></i> <span class="badge badge-dark" style="font-size: large;"><%# Eval("cm_phone") %></span>
                                </div>
                                <div class="col-12 mx-auto my-1">
                                    โควต้าที่จองไว้ได้ <span class="badge badge-info" style="font-size: x-large;"><%# Eval("book_qty") %></span> เข็ม
                                </div>
                                <div class="col-12 mx-auto my-1">
                                    ราคารวม <span class="badge badge-info" style="font-size: x-large;"><%# Eval("sale_total") %></span> บาท
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:ListView>
    </div>

    <div hidden="hidden">

        <input type="text" id="txtH_payid" value="" runat="server" />
        <button id="btn_confirm" onserverclick="btn_confirm_ServerClick" runat="server"></button>

        <asp:GridView ID="GridView1" runat="server"></asp:GridView>

    </div>

    <script>
        function fn_confirm(payid) {
            if (confirm('ต้องการยืนยันการชำระเงินใช่หรือไม่ ?')) {
                document.getElementById('<%= txtH_payid.ClientID %>').value = payid;
                __doPostBack('<%= btn_confirm.UniqueID %>', '');
            }
        }
    </script>

</asp:Content>
