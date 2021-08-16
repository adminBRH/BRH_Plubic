<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Self.aspx.cs" Inherits="BRH_Plubic.CounterCheckin.Self" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentDesktop" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<script>
    function IconStatus(status, id, deptid) {
        var icon = "";
        id = "'" + id + "'";
        deptid = "'" + deptid + "'";

        if (status == "confirm") {
            icon = "<span class='ti-3x ti-check rounded-circle' style='background-color:lightgreen;'></span>";
        }
        else if (status == "waiting" || status == "forgot checkout") {
            icon = "<span class='ti-3x ti-timer rounded-circle'></span>";
        }
        else if (status == "cancel") {
            icon = "<span class='ti-3x ti-close rounded-circle' style='background-color:red;'></span>";
        }
        else if (status == "working") {
            icon = '<a href="#" data-toggle="modal" data-target="#ModalManage" onclick="getID(' + id + ',' + deptid + ')"><span class="ti-3x ti-settings rounded-circle"></span></a>';
        }
        else { }
        document.write(icon);
    }
</script>

    <div class="row col-12 mx-auto">
        <div class="card border-warning border-top-0 border-left-0 border-right-0 col-12">
            <div class="row col-12 mx-auto">
                <div class="row col-6 mx-auto text-center">
                    <div class="col-6 mx-auto text-center">
                        จากวันที่<br />
                        <input type="date" id="date_Start" class="border-0" value="" runat="server" />
                    </div>
                    <div class="col-6 mx-auto text-center">
                        ถึงวันที่<br />
                        <input type="date" id="date_end" class="border-0" value="" runat="server" />
                    </div>
                </div>
                <div class="col-4 mx-auto text-center">
                    สถานะ<br />
                    <asp:DropDownList ID="ddl_status" class="border-0 mx-auto" runat="server">
                        <asp:ListItem Value="" Text=""></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-2 mx-auto my-auto text-center">
                    <button id="btnSearch" class="btn btn-outline-primary border-0" onserverclick="btnSearch_ServerClick" runat="server">Search<i class="ti-search"></i></button>
                </div>
            </div>
        </div>
        <asp:ListView ID="lv_list" runat="server" DataKeyNames="cc_id">
            <LayoutTemplate>
                <div class="col-12 mx-auto text-center mt-3 h3">
                    รายการประวัติการช่วยงานหรือฝึกงานของตนเอง
                </div>
                <div id="itemPlaceholder" runat="server">
                </div>
            </LayoutTemplate>
            <ItemTemplate>
                <div class="col-12 mx-auto my-2">
                    <div class="card boxShadow">
                        <div class="row col-12 mx-auto">
                            <div class="col-lg-2 col-sm-3 mx-auto my-auto">
                                <script> LoopStar(5,<%# Eval("cc_score") %>,2); </script>
                            </div>
                            <div class="row col-8 mx-auto" style="font-size:x-large;">
                                <div class="col-12 my-auto" style="color:blue;">
                                    <%# Eval("cc_typename") %> : <%# Eval("ds_desc") %>
                                </div>
                                <div class="col-lg-6 col-sm-12 my-auto" style="color:mediumseagreen;">
                                    In <%# Eval("datein") %>
                                </div>
                                <div class="col-lg-6 col-sm-12 my-auto" style="color:red;">
                                    Out <%# Eval("dateout") %>
                                </div>
                                <div class="col-12">
                                    <%# Eval("suggestion") %>
                                </div>
                            </div>
                            <div class="col-lg-2 col-sm-1 mx-auto my-auto">
                                <script> IconStatus('<%# Eval("cc_status") %>', '<%# Eval("cc_id") %>', '<%# Eval("cc_deptid") %>'); </script>
                            </div>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:ListView>
    </div>
   
    <!-- ------------------------------------ Modal Cancel or Checkout ------------------------------------ -->
    <div class="modal fade" id="ModalManage" aria-labelledby="ModalManageTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="ModalManageTitle">คุณต้องการทำอะไรกับรายการนี้</h5>
                </div>
                <div class="modal-body">
                    <div class="row col-12 mx-auto text-center">
                        <div class="col-12 mx-auto mb-3 h3">
                            What do you want to do ?
                        </div>
                        <div class="col-6 mx-auto text-center">
                            <button id="btn_cancel" class="btn btn-outline-danger" runat="server" data-dismiss="modal" onserverclick="btn_cancel_ServerClick">Cancel ยกเลิกรายการ</button>
                        </div>
                        <div class="col-6 mx-auto text-center">
                            <button id="btn_CheckOut" class="btn btn-outline-warning" runat="server" data-dismiss="modal" onserverclick="btn_CheckOut_ServerClick">CheckOut เช็คเอ้าท์</button>
                        </div>
                        <div hidden="hidden">
                            <input type="text" id="txtH_ID" value="" runat="server" />
                            <input type="text" id="txtH_deptID" value="" runat="server" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- ------------------------------------ Modal Cancel or Checkout ------------------------------------ -->

<script>
    function getID(id, deptid) {
        var txtID = document.getElementById('<%= txtH_ID.ClientID %>');
        var txtdeptID = document.getElementById('<%= txtH_deptID.ClientID %>');
        txtID.value = id;
        txtdeptID.value = deptid;
    }
</script>

</asp:Content>
