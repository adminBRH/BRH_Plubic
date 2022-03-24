<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" Debug="true" AutoEventWireup="true" CodeBehind="Booking.aspx.cs" Inherits="BRH_Plubic.CHK.Booking" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentDesktop" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<style>
    .RadioSize{
        width: 2em; height: 2em;
    }
    .BorderRadius{
        border-radius: 20px;
    }
    .ShowClick{
        cursor: pointer;
    }
</style>
    <asp:ScriptManager ID="ScriptManager_Master" runat="server">
        <Scripts>
            <asp:ScriptReference Path="~/js/Safari3AjaxHack.js" />
        </Scripts>  
    </asp:ScriptManager>

    <asp:UpdateProgress ID="prgLoadingStatus" runat="server" DynamicLayout="true">
        <ProgressTemplate>
            <div id="overlay" class="col-12 mx-auto my-auto text-center">
                <asp:Image ID="imgWaitIcon" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/images/BRHrayongLoading.gif" />
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>

    <div class="row col-12 mx-auto">
        <div class="col-lg-10 col-sm-12 mx-auto">
            <div class="col-10 card boxShadow mx-auto my-3 text-center bg-gradient" style="text-shadow: 1px 1px 1px #4800ff">
                <asp:Label ID="lbl_Title" Font-Size="XX-Large" ForeColor="White" Text="" CssClass="col-12 mx-auto my-auto" runat="server"></asp:Label>
                <br />
                <asp:Label ID="lbl_Detail" Font-Size="Large" ForeColor="White" Text="" CssClass="col-12 mx-auto my-auto" runat="server"></asp:Label>
            </div>
            <asp:UpdatePanel ID="UpdatePanel_calendar" runat="server">
                <ContentTemplate>
                    <asp:Calendar ID="cld_booking" CssClass="col-10 mx-auto mb-5" OnDayRender="cld_booking_DayRender" Height="500" NextPrevFormat="ShortMonth" runat="server">
                        <TitleStyle CssClass="bg-gradient-blue" Font-Size="XX-Large" ForeColor="White" />
                        <DayHeaderStyle BackColor="#c1c1c1" />
                        <SelectedDayStyle BackColor="#ba75b4" />
                        <DayStyle BorderWidth="1" HorizontalAlign="Right" VerticalAlign="Top" Font-Size="XX-Large" />
                        <NextPrevStyle Font-Bold="True" Font-Size="X-Large" ForeColor="White"></NextPrevStyle>
                        <OtherMonthDayStyle ForeColor="#999999" />
                    </asp:Calendar>
                    <div class="col-6 mx-auto" hidden="hidden">
                        <input id="txtH_bookdate" value="" runat="server" />
                        <input id="txtH_bookTimeStart" value="" runat="server" />
                        <input id="txtH_bookTimeEnd" value="" runat="server" />
                        <input id="txtH_TimeSlot" value="" runat="server" />
                        <input id="txtH_booktime" value="" runat="server" />
                        <input id="txtH_booktimeID" value="" runat="server" />
                    </div>
                    <div class="row col-11 mx-auto">
                        <!-- ================================= TimeSlot ==================================== -->
                        <asp:Label ID="lbl_TimeSlot" CssClass="row col-12 mx-auto" Text="" runat="server"></asp:Label>
                        <!-- =============================================================================== -->
                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="cld_booking" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
        <div class="col-lg-8 col-sm-10 mx-auto my-3 bg-gradient-blue BorderRadius" style="color:white;">
            <div class="col-12 mx-auto"><hr /></div>
            
            <asp:UpdatePanel ID="UpdatePanel_Sync" runat="server">
                <ContentTemplate>
                    <div id="div_CheckSync" class="row col-12" runat="server" visible="false">
                        <div class="col-4 mx-auto my-auto text-right h5">
                            <asp:Label ID="lbl_syncName" Text="" runat="server"></asp:Label> : 
                        </div>
                        <div class="col-4 mx-auto my-auto text-left">
                            <input type="text" id="txtSync_empid" class="form-control mx-auto my-auto" value="" placeholder="" runat="server" />
                        </div>
                        <div class="col-4 mx-auto my-auto text-center">
                            <asp:Button ID="btn_Sync" Text="Sync" CssClass="btn btn-info ShowClick" OnClick="btn_Sync_Click" runat="server" />
                        </div>
                    </div>

                    <div class="col-12 mx-auto text-center">
                        <asp:Label ID="lblSync_alert" Text="" ForeColor="Red" Font-Size="X-Large" runat="server"></asp:Label>
                    </div>
                    <div id="div_Sync" class="row col-12" runat="server" visible="false">
                        <div class="col-4 mx-auto my-2 text-right h5">
                            ชื่อ-นามสกุล : 
                        </div>
                        <div class="col-8 mx-auto my-2 text-left">
                            <input type="text" id="txtSync_fullname" class="form-control mx-auto my-auto" value="" disabled="disabled" runat="server" />
                        </div>
                        <div id="div_DOB_title" class="col-4 mx-auto my-2 text-right h5" runat="server" visible="false">
                            วันเกิด : 
                        </div>
                        <div id="div_DOB_detail" class="col-8 mx-auto my-2 text-left" runat="server" visible="false">
                            <input type="date" id="dateSync_DOB" value="" disabled="disabled" runat="server" />
                            <input type="number" id="ageSync" value="" runat="server" hidden="hidden" />
                            <asp:Label ID="lbl_age" Text="" Font-Size="Large" runat="server"></asp:Label>
                        </div>
                        <div id="div_vaccine" class="col-12 mx-auto text-center" runat="server" visible="false" style="font-size: x-large;">
                                จองไว้ <asp:Label ID="lbl_vaccine" Text="" runat="server"></asp:Label> เข็ม
                        </div>
                        <div id="div_program" class="row col-12 mx-auto my-2" runat="server" visible="false">
                            <div class="col-4 mx-auto my-2 text-right h5">
                                โปรแกรมที่ตรวจ : 
                            </div>
                            <div class="col-8 mx-auto my-2 text-left">
                                <asp:Label ID="lblSync_program" Text="" runat="server"></asp:Label>
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btn_Sync" />
                </Triggers>
            </asp:UpdatePanel>
            <!-- ================================= Controler ==================================== -->
            <asp:Label ID="lbl_controler" Text="" runat="server"></asp:Label>
            <asp:Label ID="lbl_scCTRL" Text="" runat="server"></asp:Label>
            <!-- ================================================================================ -->
            <div hidden="hidden">
                <input id="txtH_CreateConT" value="" runat="server" />
                <input id="txtH_splittime" value="" runat="server" />
                <input id="txtH_splittimeQty" value="" runat="server" />
            </div>
        </div>
        <div class="col-lg-10 col-sm-12 mx-auto my-3 text-center">
            <asp:UpdatePanel ID="UpdatePanel_submit" runat="server">
                <ContentTemplate>
                    <div class="col-12 mx-auto text-xl-center bg-dark" style="border-radius: 20px;">
                        <asp:Label ID="lbl_alert" Text="" Font-Size="X-Large" ForeColor="Red" runat="server"></asp:Label>
                    </div>
                    <div id="div_submit" class="col-12 mx-auto text-xl-center" runat="server">
                        <a class="btn btn-outline-primary my-3" onclick="fn_recheck()" data-toggle="modal" data-target="#modalRecheck" style="cursor: pointer; font-size: x-large;">Submit</a>
                        <button id="btnSubmit" runat="server" onserverclick="btn_submit_Click" hidden="hidden"></button>
                        <asp:Button Text="Submit" ID="btn_submit" CssClass="btn btn-outline-primary mx-auto text-center" Font-Size="XX-Large" OnClick="btn_submit_Click" OnClientClick="alertModal('#Modal_Loading');" runat="server" Visible="false" />
                    </div>
                    <!-- Modal Recheck -->
                    <div class="modal fade" id="modalRecheck" tabindex="-1" role="dialog" aria-labelledby="modalRecheckTitle" aria-hidden="true">
                      <div class="modal-dialog modal-dialog-centered" role="document" style="padding-top: 20%;">
                        <div class="modal-content">
                          <div class="modal-header">
                            <h5 class="modal-title" id="modalRecheckTitle"><label id="lbl_recheckhead"></label></h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                              <span aria-hidden="true">&times;</span>
                            </button>
                          </div>
                          <div class="modal-body">
                              <div class="col-12 mx-auto text-center">
                                  <label id="lbl_recheck"></label>
                              </div>
                          </div>
                          <div class="modal-footer">
                              <div id="div_recheck_button" class="row col-12 mx-auto">
                                  <div class="col-6 mx-auto text-center">
                                      <button type="button" class="btn btn-outline-danger" data-dismiss="modal">ไม่ยืนยัน</button>
                                  </div>
                                  <div class="col-6 mx-auto text-center">
                                      <button type="button" class="btn btn-outline-primary" onclick="fn_submit()" data-dismiss="modal">ยืนยัน</button>
                                  </div>
                              </div>
                              <div id="div_recheck_alert" class="col-12 mx-auto" hidden="hidden">
                                  <button type="button" class="btn btn-outline-danger" data-dismiss="modal">ตกลง</button>
                              </div>
                          </div>
                        </div>
                      </div>
                    </div>

                    <script>
                        var txtH_ID = document.getElementById('<%= txtH_booktimeID.ClientID %>');
                        if (txtH_ID.value != '' && txtH_ID.value != id) {
                            document.getElementById('btn_slot_' + txtH_ID.value).setAttribute("class", "col-lg-2 col-sm-3 btn btn-outline-success mx-auto my-auto");
                        }

                        function fn_recheck() {
                            var lblhead = document.getElementById('lbl_recheckhead');
                            var lblbody = document.getElementById('lbl_recheck');
                            var bookdate = document.getElementById('<%= txtH_bookdate.ClientID %>');
                            var booktime = document.getElementById('<%= txtH_booktime.ClientID %>');
                            var divButton = document.getElementById('div_recheck_button');
                            var divAlert = document.getElementById('div_recheck_alert');
                            divButton.setAttribute('hidden', 'hidden');
                            divAlert.removeAttribute('hidden');
                            var head = '';
                            var body = '';
                            if (bookdate.value == '') {
                                head = 'Alert !!';
                                body = 'กรุณาเลือกวันที่';
                            } else if (booktime.value == '') {
                                head = 'Alert !!';
                                body = 'กรุณาเลือกเวลา';
                            } else {
                                head = 'วันเวลาที่คุณต้องการจอง';
                                var DateAR = bookdate.value.split('-');
                                var month = parseInt(DateAR[1]) - 1;
                                var yearTH = parseInt(DateAR[0]) + 543;
                                var DateTH = DateAR[2] + ' ' + monthTH(month) + ' ' + yearTH;
                                body = DateTH + ' เวลา ' + booktime.value + ' น.';
                                divAlert.setAttribute('hidden', 'hidden');
                                divButton.removeAttribute('hidden');
                            }
                            lblhead.innerHTML = head;
                            lblbody.innerHTML = body;
                        }
                    </script>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btn_submit" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </div>

<!-- Modal -->
<div class="modal fade" id="ModalAlertSubmit" tabindex="-1" role="dialog" aria-labelledby="ModalAlertSubmitLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <div class="modal-title row col-12 mx-auto" id="ModalAlertSubmitLabel">
            <div class="col-6 mx-auto text-left">
                <%--<img src="../images/BGH_Rayong-Logo.jpg" style="width: 30%;" />--%>
                <img src="../images/logo-BRH_200x80px.png" style="width: 30%;" />
            </div>
            <div class="col-6 mx-auto my-auto text-right" style="margin-right: 25px;">
                <asp:Label ID="lbl_docno" Text="" runat="server"></asp:Label>
            </div>
        </div>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
          <div class="row col-12 mx-auto">
              <div class="col-6 mx-auto my-auto text-center" style="color:white;">
                  <i class="ti-5x ti-check bg-success text-center" style="border-radius: 100%"></i>
              </div>
              <div class="col-12 mx-auto text-center h3">
                  บันทึกข้อมูลเรียบร้อยแล้ว
              </div>
              <div class="col-12 mx-auto text-center mt-2 h4">
                  <asp:Label ID="lbl_syncData" Text="" runat="server"></asp:Label>
              </div>
              <div class="col-12 mx-auto text-center mt-2 h4">
                  <asp:Label ID="lbl_KeyRecord" Text="" runat="server"></asp:Label>
              </div>
              <div class="col-12 mx-auto"><div class="col-8 card boxShadow mx-auto text-center"></div></div>
              <div class="col-12 mx-auto mt-5 h5">
                  <asp:Label ID="lbl_alertSubmimt" Text="" runat="server"></asp:Label>
              </div>
          </div>
      </div>
    </div>
  </div>
</div>

<script>
    function SelectTime(id, time) {
        // Set focus button
        var btn = document.getElementById('btn_slot_' + id)
        btn.setAttribute("class","col-lg-2 col-sm-3 btn btn-success mx-auto my-auto");

        // Clear focus button
        var txtH_ID = document.getElementById('<%= txtH_booktimeID.ClientID %>');
        if (txtH_ID.value != '' && txtH_ID.value != id) {
            document.getElementById('btn_slot_' + txtH_ID.value).setAttribute("class", "col-lg-2 col-sm-3 btn btn-outline-success mx-auto my-auto");
        }
        txtH_ID.value = id;

        // Get time 
        var txtH_Time = document.getElementById('<%= txtH_booktime.ClientID %>');
        txtH_Time.value = time;
    }

    function fn_submit() {
        var Timeslot = document.getElementById('<%= txtH_TimeSlot.ClientID %>');
        var booktime = document.getElementById('<%= txtH_booktime.ClientID %>');
        var btnNext = "yes";
        if (Timeslot.value == "yes") {
            if (booktime.value == "") {
                btnNext = "no";
            }
        }
        if (btnNext == "yes") {
            __doPostBack('<%= btnSubmit.UniqueID %>', '');
        } else {
            alert('กรุณาเลือกเวลาที่ต้องการจอง !!');
        }
    }
</script>

    <asp:UpdatePanel ID="UpdatePanel_script" runat="server">
        <ContentTemplate>
            <asp:Label ID="lbl_script" Text="" runat="server"></asp:Label>
        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>
