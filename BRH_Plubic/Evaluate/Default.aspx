<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="BRH_Plubic.Evaluate.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentDesktop" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<style>
    input[type=radio]{
        border: 0px;
        width: 2em;
        height: 2em;
    }
    input[type=checkbox]{
        border: 0px;
        width: 1em;
        height: 1em;
    }
    .nameSystem {
        border: solid; 
        border-color: darkturquoise;
        border-radius: 20px;
        background-color: antiquewhite;
        border-top-right-radius: 50px;
    }
</style>

<asp:ScriptManager ID="ScriptManager_asm" runat="server"></asp:ScriptManager>

    <!-- Modal -->
<div class="modal fade" id="Modal_alert" tabindex="-1" role="dialog" aria-labelledby="Modal_alert_title" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header bg-danger">
        <%--<h5 class="modal-title" id="Modal_alert_title">Alert</h5>--%>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
          <asp:Label ID="lbl_modal_alert" Text="" Font-Size="X-Large" runat="server"></asp:Label>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<script>
    function fn_modal() {
        $(document).ready(function () {
            $("#Modal_alert").modal();
        });
    }
</script>

    <div class="col-11 mx-auto">
        <span class="nameSystem h3">
            &nbsp;&nbsp;BRH Assessment Form&nbsp;&nbsp;
        </span>
    </div>
    <div class="card col-11 mx-auto">
        <div class="alert alert-primary mt-3 text-center h3">
            แบบประเมิน : 
            <asp:Label ID="lbl_subject" Text="Subject" runat="server"></asp:Label> 
        </div>
        <asp:UpdatePanel ID="UpdatePanel_asm" runat="server">
            <ContentTemplate>
                <div class="row col-12 mx-auto">
                    <!-- Header -->
                    <div class="col-12 mx-auto h3">
                        <asp:Label ID="lbl_head" Text="" runat="server"></asp:Label>
                    </div>
                    <asp:ListView ID="lv_question" runat="server">
                        <LayoutTemplate>
                            <div id="itemPlaceholder" runat="server"></div>
                        </LayoutTemplate>
                        <ItemTemplate>
                            <div class="row col-12 mx-auto my-2">
                                <!-- Body -->
                                <div class="row col-12 mx-auto h3">
                                    <input type="radio" name="rd_name_<%# Eval("ash_id") %>" id="rd_id_<%# Eval("asd_id") %>" class="my-auto" value="<%# Eval("asd_score") %>" onclick="fn_rdvalue('<%# Eval("asd_id") %>')" />
                                    <span class="my-auto">&nbsp;&nbsp;&nbsp;<%# Eval("asd_title") %></span>
                                    <input type="text" id="txt_input_<%# Eval("asd_id") %>" value="<%# Eval("asd_text") %>" hidden="hidden" />
                                    <input type="text" id="txt_id_<%# Eval("asd_id") %>" class="mx-3 my-auto col-5 form-control" value="" style="border: solid;" hidden="hidden" />
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:ListView>
                    <div hidden="hidden">
                        <input type="text" id="txt_oldid" value="" runat="server" />
                        <input type="text" id="txtH_required" value="no" runat="server" />
                        <input type="text" id="txtH_rd_value" value="" runat="server" />
                        <input type="number" id="txtH_question" value="1" runat="server" />
                        <input type="number" id="txtH_maxIndex" value="1" runat="server" />
                    </div>
                </div>
                <script>
                    function fn_rdvalue(id) {
                        document.getElementById('<%= txtH_rd_value.ClientID %>').value = id;
                        var oid = document.getElementById('<%= txt_oldid.ClientID %>');
                        if (oid.value == '') {
                            oid.value = id;
                        }
                        fn_showtext(id);
                        fn_hidetext(id);
                    }

                    function fn_showtext(id) {
                        if (document.getElementById('txt_input_' + id).value == 'yes') {
                            var txt = document.getElementById('txt_id_' + id);
                            txt.removeAttribute('hidden');
                        }
                    }

                    function fn_hidetext(id) {
                        var oid = document.getElementById('<%= txt_oldid.ClientID %>');
                        if (oid.value != '' && id != oid.value) {
                            document.getElementById('txt_id_' + oid.value).setAttribute('hidden', 'hidden');
                            oid.value = id;
                        }
                    }
                </script>
                <asp:Label ID="lbl_script" Text="" runat="server"></asp:Label>
            </ContentTemplate>
        </asp:UpdatePanel>
        <div class="col-12 mx-auto my-5 text-center">
                        <a id="btn_previous" class="btn btn-outline-primary mx-5" style="cursor: pointer;" onserverclick="btn_previous_ServerClick" runat="server"><< previous</a>
                        <a id="btn_next" class="btn btn-outline-primary mx-5" style="cursor: pointer;" onserverclick="btn_next_ServerClick" runat="server">NEXT >></a>
                        <a id="btn_submit" class="btn btn-success mx-auto" style="cursor: pointer;" onserverclick="btn_submit_ServerClick" runat="server" visible="false">SUBMIT</a>
                    </div>
        <div class="row col-12 mx-auto alert alert-info h3">
            <div class="col-6 mx-auto">
                Create by: <asp:Label ID="lbl_createby" Text=".........." runat="server"></asp:Label> 
            </div>
            <div class="col-6 mx-auto text-right">
                <asp:Label ID="lbl_createtime" Text="00:00:00 น." runat="server"></asp:Label> 
            </div>
        </div>
    </div>

</asp:Content>
