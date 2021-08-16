<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CheckDocument.aspx.cs" Inherits="BRH_Plubic.NovelCorona.CheckDocument" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentDesktop" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<style>
    .SelectDetail {
        font-size: large; 
        cursor: pointer;
    }
    .SelectDetail:hover{
        background-color: burlywood;
    }
</style>
<script>
    function fn_status(val) {
        var txt = '';
        if (val == '') {
            txt = 'ตรวจสอบ';
        }
        else {
            txt = 'Print';
        }
        document.write(txt);
    }
    function fn_link(val, id, key) {
        if (val == 'yes') {
            window.location.href = 'Report.aspx?nc=' + id + '&key=' + key;
        }
        else {
            window.location.href = 'Default.aspx?nc=' + id;
        }
    }
</script>

    <div class="col-12 mx-auto my-3">
        <div class="col-lg-8 col-sm-12 mx-auto text-center bg-gradient-blue" style="border-radius: 20px;">
            <div class="row col-12 mx-auto">
                <div class="col-12 mx-auto mt-2 text-center h1">
                    ค้นหารายงานผู้ป่วยโรคปอดอักเสบ<br />จากเชื้อไวรัสโคโรนาสายพันธุ์ใหม่ 2019
                </div>
                <div class="col-8 mx-auto my-auto text-center">
                    <input type="text" id="txt_docno" class="form-control" value="" placeholder="กรอกหมายเลข" runat="server" />
                </div>
                <div class="col-4 mx-auto my-auto text-left">
                    <button id="btn_submit" class="btn btn-outline-light" onserverclick="btn_submit_ServerClick" runat="server">Search <i class="ti-search ti-2x"></i></button>
                </div>
                <div class="col-12 mx-auto mb-2 text-right">
                    <a href="Default?nc=staff" style="font-size: large;">กรอกข้อมูลใหม่ <i class="ti-pencil ti-2x"></i></a>
                </div>
            </div>
        </div>
    </div>

    <div class="col-10 mx-auto mt-5 text-right">
        <button id="btn_Export" class="btnShadow btn-outline-primary" runat="server" onserverclick="btn_Export_ServerClick" style="font-size: xx-large; border-radius: 10px;">Export <i class="ti-export"></i></button>
    </div>

    <div class="col-lg-10 col-sm-12 mx-auto my-3">
        <div class="col-12 mx-auto">
            <asp:ListView ID="LV_Report" runat="server">
                <LayoutTemplate>
                    <div class="col-12 mx-auto text-center h1">
                        รายชื่อผู้ทำแบบสอบถามทั้งหมด
                    </div>
                    <div class="row col-12 mx-auto bg-info" style="border-top-left-radius: 20px; border-top-right-radius: 20px; color:white;">
                        <div class="col-2 mx-auto my-auto text-center h3">เลขที่เอกสาร</div>
                        <div class="col-10 mx-auto my-auto text-center h3">Details</div>
                    </div>
                    <div id="itemPlaceholder" runat="server"></div>
                    <div class="col-12 mx-auto  bg-info" style="border-bottom-left-radius: 20px; border-bottom-right-radius: 20px;">&nbsp;</div>
                </LayoutTemplate>
                <ItemTemplate>
                    <div class="card col-12 mx-auto my-1 SelectDetail">
                        <div class="row col-12 mx-auto my-2" onclick="fn_link('<%# Eval("nc_staffcheck") %>','<%# Eval("nc_id") %>','<%# Eval("nc_key") %>')">
                            <div class="col-2 mx-auto my-auto text-center"><%# Eval("nc_id") %></div>
                            <div class="col-10 mx-auto">
                                <div class="row col-12 mx-auto">
                                    <div class="col-4 mx-auto">
                                        <%# Eval("nc_datetime") %>
                                    </div>
                                    <div class="col-3 mx-auto">
                                        <%# Eval("nc_fname") %> <%# Eval("nc_lname") %>
                                    </div>
                                    <div class="col-3 mx-auto">
                                        Tel: <%# Eval("nc_adr_mobile") %>
                                    </div>
                                    <div class="col-2 mx-auto">
                                         <script> fn_status('<%# Eval("ncc_reporter") %>'); </script> : <%# Eval("nc_staffcheck") %>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:ListView>
        </div>
    </div>
    
    <div class="col-12 mx-auto" hidden="hidden">
        <asp:GridView ID="GridView1" runat="server"></asp:GridView>
    </div>

</asp:Content>
