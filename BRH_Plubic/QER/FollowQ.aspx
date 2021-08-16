<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FollowQ.aspx.cs" Inherits="BRH_Plubic.QER.FollowQ" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">

<style>
    .iconSize{
        width: 65px;
        height: 65px;
    }
    .cardStyle{
        border-radius: 5%;
    }
</style>

<asp:ScriptManager ID="script_manager1" runat="server"></asp:ScriptManager>

    <div id="div_CheckQ" class="col-12 mx-auto text-center mt-5" runat="server">
        <a class="btn btn-outline-primary" data-toggle="modal" data-target="#ModalFollowQ" onclick="ClearData()">ติดตาม Queue</a>
    </div>
    <div id="div_Details" class="card col-10 mx-auto bg-gradient-mix cardStyle" runat="server" visible="false">
        <asp:UpdatePanel ID="UpdatePanel_Detail" runat="server">
            <ContentTemplate>
                <div class="col-12 mx-auto text-center" style="font-size: 90px;">
                    <asp:Label ID="lbl_Queue" Text="" runat="server"></asp:Label>
                </div>
                <div class="col-12 mx-auto text-center" style="font-size: 40px;">
                    <asp:Label ID="lbl_triage" Text="" runat="server"></asp:Label>
                </div>
                <div class="col-8 mx-auto boxShadow"></div>
                <div class="col-12 mx-auto text-center" style="font-size: 40px;">
                    <asp:Label ID="lbl_bed" Text="" runat="server"></asp:Label>
                </div>
                <div class="col-auto mx-auto text-center mt-5" style="font-size:30px">
                    <asp:Label ID="lbl_process" Text="" runat="server"></asp:Label>
                </div>
                <asp:Timer ID="Timer1" runat="server" Interval="5000" OnTick="Timer1_Tick" ></asp:Timer>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="Timer1"/>
            </Triggers>
        </asp:UpdatePanel>
        <asp:Button ID="btn_CearQueue" Text="ยกเลิกการติดตาม" CssClass="btn btn-outline-primary mx-auto text-center mt-5" Font-Size="X-Large" OnClick="btn_CearQueue_Click" runat="server" />
    </div>

<!-- Modal ----------------------------------------------------------------------------- -->
<div class="modal fade modal-center" id="ModalFollowQ" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-xl" role="document">
    <div class="modal-content">
        <div class="modal-header" style="background: #0d0158; color:white;">
            <div class="row col-12 mx-auto">
                <div class="col-12 mx-auto my-auto text-center">
                    <span class="h3">ติดตามสถานการณ์ผู้ป่วย</span>
                    <div class="icon-box">
                        <i class="ti-5x ti-pin-alt"></i>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-body">
            <div class="row col-12 mx-auto">
                <div class="col-12 mx-auto my-auto text-center h1" style="padding-top: 1em; padding-bottom: 1em;">
                    <div class="row col-12 mx-auto">
                        <div class="col-12 mx-auto text-center" style="font-size:xx-large;">
                            กรอกหมายเลขคิว
                        </div>
                        <div class="col-8 mx-auto text-right">
                            <input type="number" id="txt_Queue" value="" class="form-control" runat="server" style="font-size:xx-large;" />
                        </div>
                        <div class="col-2 mx-auto text-left">
                            <button id="btn_submit" class="btn btn-outline-primary text-center" onserverclick="btn_submit_ServerClick" runat="server" style="font-size:xx-large;">ติดตาม</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
  </div>
</div>

<asp:Label ID="lbl_CallModal" Text="" runat="server"></asp:Label>


<script>
    function ClearData() {
        var txtQ = document.getElementById('<%= txt_Queue.ClientID %>');
        txtQ.value = "";
    }

    setTimeout(function () {
        window.location.reload(1);
    }, ((1000 * 60) * 10));
</script>

</asp:Content>
