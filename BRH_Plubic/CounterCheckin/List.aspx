<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="List.aspx.cs" Inherits="BRH_Plubic.CounterCheckin.List" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentDesktop" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<script>
    function fn_status(status, timeout, score, id) {
        var html = '';
        if (status == 'cancel') {
            html = "<span class='ti-3x ti-close rounded-circle' style='background-color:red;'></span>";
        }
        else {
            if (timeout == '') {
                html = "<span class='ti-3x ti-timer rounded-circle'></span>";
            }
            else {
                if (score == '') {
                    html = "<a href='#' data-toggle='modal' data-target='#ModalEvaluate' onclick='fn_getID(\"" + id + "\")'>";
                    html = html + "<span class='ti-3x ti-pencil rounded-circle' style='background-color:darkgoldenrod;'></span> <span class='ti-star' style='color:darkorange;'></span>";
                    html = html + '</a>';
                }
                else {
                    html = "<span class='ti-3x ti-check rounded-circle' style='background-color:lightgreen;'></span>";
                }
            }
        }
        document.write(html);
    }
</script>

    <div class="row col-12 mx-auto">
        <div class="card border-warning border-top-0 border-left-0 border-right-0 col-12">
            <div class="row col-12 mx-auto">
                <div class="row col-6 mx-auto text-center">
                    <div class="col-6 mx-auto text-center">
                        จากวันที่<br />
                        <input type="date" id="StartDate" class="border-0" value="" runat="server" />
                    </div>
                    <div class="col-6 mx-auto text-center">
                        ถึงวันที่<br />
                        <input type="date" id="EndDate" class="border-0" value="" runat="server" />
                    </div>
                </div>
                <div class="col-4 mx-auto text-center">
                    สถานะ<br />
                    <asp:DropDownList ID="ddl_status" class="border-0 mx-auto" runat="server">
                        <asp:ListItem Value="" Text=""></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-2 mx-auto my-auto text-center">
                    <button id="btnSearch" class="btn btn-outline-primary border-0" onserverclick="btnSearch_ServerClick" runat="server">Search<span class="ti-2x ti-search"></span></button>
                </div>
            </div>
        </div>
        <asp:ListView ID="lv_list" runat="server">
            <LayoutTemplate>
                <div class="col-12 mx-auto text-center mt-3 h1">
                    พนักงานที่มาช่วยงานหรือฝึกงานในแผนกของท่าน
                </div>
                <div id="itemPlaceholder" runat="server">
                </div>
            </LayoutTemplate>
            <ItemTemplate>
                <div class="col-lg-8 col-sm-12 card boxShadow rounded mx-auto my-2">
                    <div class="row col-12">
                        <div class="col-2 mx-auto my-auto">
                            <img src="../images/users/UserNull.png" style="width:100%;" />
                        </div>
                        <div class="row col-9 mx-auto" style="font-size:x-large;">
                            <div class="col-12" style="color:darkblue;">
                                <%# Eval("cc_typename") %> : <%# Eval("ds_desc") %>
                            </div>
                            <div class="col-12 my-auto">
                                ชื่อ : <%# Eval("empname") %>
                            </div>
                            <div class="col-6 my-auto">
                                รหัสพนักงาน : <%# Eval("cc_empid") %>
                            </div>
                            <div class="col-6 my-auto">
                                คะแนน : <script> LoopStar(5,<%# Eval("cc_score") %>,1); </script>
                            </div>
                            <div class="col-12 my-auto" style="color:mediumseagreen;">
                                Check-In : <%# Eval("datein") %>
                            </div>
                            <div class="col-12 my-auto" style="color:red;">
                                Check-Out : <%# Eval("dateout") %>
                            </div>
                            <div class="col-12">
                                 <%# Eval("suggestion") %>
                            </div>
                        </div>
                        <div class="col-1 mx-auto my-auto">
                            <script> fn_status('<%# Eval("cc_status") %>', '<%# Eval("cc_timeout") %>', '<%# Eval("cc_evaluate") %>', '<%# Eval("cc_id") %>'); </script>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:ListView>
    </div>

    <!-- ------------------------------------ Modal Evaluate ------------------------------------ -->
    <div class="modal fade" id="ModalEvaluate" aria-labelledby="ModalEvaluateTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="ModalEvaluateTitle">Evaluate ประเมิน</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                      <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row col-12 mx-auto">
                        <div class="col-2 mx-auto my-auto text-center">
                            <a href="#" data-toggle="modal" data-target="#ModalConfirm" data-dismiss="modal" onclick="fn_getScore(1)">
                                <img src="images/eval_1.png" style="width:100%;" />แย่มาก
                            </a>
                        </div>
                        <div class="col-2 mx-auto my-auto text-center">
                            <a href="#" data-toggle="modal" data-target="#ModalConfirm" data-dismiss="modal" onclick="fn_getScore(2)">
                                <img src="images/eval_2.png" style="width:100%;" />แย่
                            </a>
                        </div>
                        <div class="col-2 mx-auto my-auto text-center">
                            <a href="#" data-toggle="modal" data-target="#ModalConfirm" data-dismiss="modal" onclick="fn_getScore(3)">
                                <img src="images/eval_3.png" style="width:100%;" />ปานกลาง
                            </a>
                        </div>
                        <div class="col-2 mx-auto my-auto text-center">
                            <a href="#" data-toggle="modal" data-target="#ModalConfirm" data-dismiss="modal" onclick="fn_getScore(4)">
                                <img src="images/eval_4.png" style="width:100%;" />ดี
                            </a>
                        </div>
                        <div class="col-2 mx-auto my-auto text-center">
                            <a href="#" data-toggle="modal" data-target="#ModalConfirm" data-dismiss="modal" onclick="fn_getScore(5)">
                                <img src="images/eval_5.png" style="width:100%;" />ดีมาก
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- ------------------------------------ Modal Evaluate ------------------------------------ -->
    <div hidden="hidden">
        <input type="text" id="txtH_id" value="" runat="server" />
        <input type="text" id="txtH_score" value="0" runat="server" />
    </div>
    <!-- ------------------------------------ Modal Confirm ------------------------------------ -->
    <div class="modal fade" id="ModalConfirm" aria-labelledby="ModalConfirmTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="ModalConfirmTitle">Are you sure ?</h5>
                </div>
                <div class="modal-body">
                    <div class="row col-12 mx-auto text-center">
                        <div class="col-12 mx-auto mb-3">
                            <textarea id="txt_remark" class="form-control" placeholder="คำแนะนำ ติชม" runat="server"></textarea>
                        </div>
                        <div class="col-6 mx-auto text-center">
                            <button id="btn_confirm_close" class="btn btn-outline-danger" data-dismiss="modal">Close</button>
                        </div>
                        <div class="col-6 mx-auto text-center">
                            <button id="btn_submit" class="btn btn-outline-success" runat="server" onserverclick="btn_submit_ServerClick">Confirm</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- ------------------------------------ Modal Confirm ------------------------------------ -->

<script>
    function fn_getID(id) {
        var txtid = document.getElementById('<%= txtH_id.ClientID %>');
        txtid.value = id;
    }
    function fn_getScore(sc) {
        var txtscore = document.getElementById('<%= txtH_score.ClientID %>');
        txtscore.value = sc;
    }
</script>

</asp:Content>
