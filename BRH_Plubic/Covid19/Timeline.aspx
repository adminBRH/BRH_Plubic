<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Timeline.aspx.cs" Inherits="BRH_Plubic.Covid19.Timeline" %>
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

    .buttonNext{
        border-radius: 50%;
    }

    .fontMobile{
        font-size: x-large;
    }
</style>

<script>
    function fn_dateThai(D) {
        var result = '';
        if (D != '') {
            var dateObj = new Date(D);
            var month = dateObj.getUTCMonth();
            var day = dateObj.getUTCDate();
            var year = dateObj.getUTCFullYear() + 543;
            var result = day + '/' + month + '/' + year;
        }
        document.write(result);
    }
</script>

    <!-- Div 1 -->
    <div id="div_1" class="col-12 mx-auto" runat="server" visible="true">
        <div class="row col-12 mx-auto my-3">
            <div class="col-12 mx-auto text-center h3">
                Timeline 14 วัน เพื่อส่งสำนักงานสาธารณสุขจังหวัด
            </div>
            <div class="col-12 mx-auto mb-3 text-center h5">
                (กรุณาให้ข้อมูลที่เป็นจริง เพื่อประโยชน์ต่อการควบคุมโรค)
            </div>
            <div class="col-4 mx-auto">
                <input type="text" id="txt_fname" class="form-control" value="" placeholder="ชื่อ" runat="server" />
            </div>
            <div class="col-4 mx-auto">
                <input type="text" id="txt_lname" class="form-control" value="" placeholder="นามสกุล" runat="server" />
            </div>
            <div class="col-4 mx-auto">
                <input type="text" id="txt_phone" class="form-control" value="" placeholder="เบอร์โทรศัพท์" runat="server" />
            </div>
        </div>
        <div class="col-12 mx-auto my-3">
            <div class="row col-12 mx-auto my-3">
                <span class="my-auto">อาการเจ็บป่วย</span>
                &nbsp;&nbsp;&nbsp;<input type="radio" id="rd_sick_no" name="rd_sick" value="no" class="my-auto" checked runat="server" onclick="fn_sick()" /> <span class="my-auto">ไม่มี</span>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" id="rd_sick_yes" name="rd_sick" value="yes" class="my-auto" runat="server" onclick="fn_sick()" /> <span class="my-auto">มี</span>
                &nbsp;&nbsp;<span id="sp_sick" class="my-auto" hidden="hidden">วันที่เริ่มมีอาการ</span> &nbsp;&nbsp;<input type="date" id="date_sick" value="" class="col-3 form-control" runat="server" hidden="hidden" />
            </div>
        </div>
        <script>
            function fn_sick() {
                var sp = document.getElementById('sp_sick');
                var ds = document.getElementById('<%= date_sick.ClientID %>');
                var rd = document.getElementById('<%= rd_sick_yes.ClientID %>');
                if (rd.checked) {
                    sp.removeAttribute('hidden');
                    ds.removeAttribute('hidden');
                } else {
                    sp.setAttribute('hidden','hidden');
                    ds.setAttribute('hidden', 'hidden');
                    ds.value = '';
                }
            }
            fn_sick();
        </script>
        <div class="col-12 mx-auto">
            <div class="row col-12 mx-auto">
                <span class="my-auto">วันที่เก็บสิ่งส่งตรวจ (ป้ายจมูกเพื่อตรวจ RT-PCR)</span>&nbsp;&nbsp;
                <input type="date" id="date_RT" value="" class="col-3 form-control" runat="server" />
            </div>
        </div>
        <div class="col-12 mx-auto my-5 text-center">
            <input type="text" id="txtH_id" value="" runat="server" hidden="hidden" />
            <button id="btn_submit_1" runat="server" class="btn btn-outline-primary" onserverclick="btn_submit_1_ServerClick">Submit</button>
        </div>
    </div>

    <!-- Div 2 -->
    <div id="div_2" class="col-12 mx-auto fontMobile" runat="server" visible="false">
        <asp:ListView ID="LV_timeline" runat="server">
            <LayoutTemplate>
                <div class="col-12 mx-auto">
                    ตารางกิจกรรม และการเดินทาง 14 วันหลังป่วย
                </div>
                <div class="col-12 mx-auto">
                    <table style="width: 100%" border="1">
                        <tr>
                            <td style="width: 15%" class="text-center">No. / ลำดับ</td>
                            <td style="width: 50%" class="text-center">
                                Date / วันที่
                            </td>
                            <td style="width: 35%" class="text-center">
                                Detail / รายละเอียด
                            </td>
                        </tr>
                        <tr id="itemPlaceholder" runat="server">
                        </tr>
                    </table>
                </div>
            </LayoutTemplate>
            <ItemTemplate>
                <tr id="tr_<%# Eval("ctd_index") %>">
                    <td class="text-center">
                        <%# Eval("ctd_index") %>
                    </td>
                    <td class="text-center">
                        <%# Eval("ctd_dateTH") %>
                        <%--<input id="txt_detail_<%# Eval("ctd_index") %>" value="" hidden="hidden" />--%>
                        <%# Eval("ctd_txt") %>
                    </td>
                    <td>
                        <div class="col-12 mx-auto text-center">
                            <a class="col-6 mx-auto my-2 btn btn-outline-info" data-toggle="modal" data-target="#modal_detail" onclick="fn_details('<%# Eval("ctd_index") %>','<%# Eval("ctd_dateTH") %>')">กรอกข้อมูล</a>
                        </div>
                    </td>
                </tr>
            </ItemTemplate>
        </asp:ListView>
        <div class="col-12 mx-auto my-5 text-center">
            <input type="text" id="txtH_ALL" value="" runat="server" hidden="hidden" />
            <a class="btn btn-outline-primary" onclick="fn_checkData()">Submit</a>
            <button id="btn_submit_2" runat="server" onserverclick="btn_submit_2_ServerClick" hidden="hidden"></button>
        </div>
    </div>

<script>
    for (var i = 1; i <= 14; i++) {
        var trGreen = document.getElementById('txt_detail_' + i);
        if (trGreen.value != "") {
            document.getElementById('tr_' + i).setAttribute('style', 'background-color: greenyellow;');
        }
    }
</script>

    <div class="row col-12 mx-auto">

    <!-- Modal Add Details -->
    <div class="modal right fade" id="modal_detail" tabindex="-1" role="dialog" aria-hidden="false">
        <div class="modal-dialog" role="document" style="max-width: 100%; top: 0; left: auto; right: 0;">
            <div class="modal-content bg-secondary" style="background-color:white;">
                <div class="modal-body fontMobile">
                    <div class="row col-12 mx-auto">
                        <div class="col-12 mx-xl mt-3 text-center" style="font-size: xx-large;">
                            กรอกกิจกรรมและการเดินทาง
                            <input type="text" id="txtH_n" value="" hidden="hidden" />
                            <input type="text" id="txtH_detail" value="" hidden="hidden" />
                        </div>
                        <div class="col-12 mx-xl mb-2 text-center" style="font-size: xx-large;">
                            ของวันที่ <asp:Label ID="lbl_date" Text="" runat="server"></asp:Label>
                        </div>
                        <div class="col-12 mx-auto my-5">
                            <input type="checkbox" id="cb_forgot" value="yes" onclick="fn_forgot()" /> จำไม่ได้
                        </div>
                        <div id="div_forgot" class="row col-12 mx-auto">
                            <div class="col-12 mx-auto">
                                ตั้งแต่เวลา
                            </div>
                            <div class="row col-12 mx-auto my-2">
                                <div class="col-5 mx-auto">
                                    <input type="time" id="time_start" value="" class="form-control" />
                                </div>
                                <div class="col-2 mx-auto text-center">
                                    ถึง
                                </div>
                                <div class="col-5 mx-auto text-right">
                                    <input type="time" id="time_end" value="" class="form-control" />
                                </div>
                            </div>
                            <div class="col-12 mx-auto my-2">
                                <textarea id="txt_eventlocation" class="form-control" rows="6" placeholder="กิจกรรม/สถานที่"></textarea>
                            </div>
                            <div class="row col-12 mx-auto my-2">
                                <div class="col-5 mx-auto" style="font-size: medium">
                                    จำนวนผู้เข้าร่วมกิจกรรม
                                    <input type="number" id="num_person" value="" class="form-control" />
                                </div>
                                <div class="col-7 mx-auto">
                                    <textarea id="txt_person" class="form-control" rows="3" placeholder="(ระบุบุคคล หากทำได้)"></textarea>
                                </div>
                            </div>
                            <div class="col-12 mx-auto my-3 text-center">
                                <a id="btn_addtime" class="btn btn-info" onclick="fn_addDetail('')" style="cursor: pointer;">บันทึก</a>
                                <a id="btn_edittime" class="btn btn-info" onclick="fn_addDetail()" style="cursor: pointer;" hidden="hidden">บันทึก</a>
                            </div>
                            <div class="row col-12 mx-auto my-2" style="font-size: medium;">
                                <asp:Label ID="lbl_tableDetail" CssClass="col-12 mx-auto" Text="" runat="server"></asp:Label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal -->
    <div class="modal fade" id="modal_setting_detail" tabindex="-1" role="dialog" aria-labelledby="modal_setting_detailTitle" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="modal_setting_detailTitle">ยืนยันคำสั่ง</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-footer">
              <div class="row col-12 mx-auto">
                  <input type="text" id="txtH_index" value="" hidden="hidden" />
                  <div class="col-6 mx-auto text-center">
                      <a class="btn btn-outline-danger" onclick="fn_delDetail()" data-dismiss="modal">ลบข้อมูล</a>
                  </div>
                  <div class="col-6 mx-auto text-center">
                      <a class="btn btn-outline-info" onclick="fn_editDetail()" data-dismiss="modal">แก้ไขข้อมูล</a>
                  </div>
              </div>
          </div>
        </div>
      </div>
    </div>

    <script>
        function fn_forgot() {
            var n = document.getElementById('txtH_n');
            var txtH_n = document.getElementById('txt_detail_' + n.value)
            var txtH_d = document.getElementById('txtH_detail');
            var divforgot = document.getElementById('div_forgot');
            if (cb_forgot.checked) {
                var detail = '00:00 - 23:59^จำไม่ได้^0 คน';
                txtH_n.value = detail;

                var success = 'background-color: greenyellow;';
                document.getElementById('tr_' + n.value).setAttribute('style', success);
                divforgot.setAttribute('hidden', 'hidden');
            } else {
                txtH_n.value = '';
                txtH_d.value = '';
                if (txtH_n.value == '') {
                    document.getElementById('tr_' + n.value).removeAttribute('style');
                }
                divforgot.removeAttribute('hidden');
                fn_tabalDetail(txtH_n.value);
            }
        }

        function fn_details(n, d) {
            var btnAdd = document.getElementById('btn_addtime');
            var btnEdit = document.getElementById('btn_edittime');
            btnAdd.removeAttribute('hidden');
            btnEdit.setAttribute('hidden', 'hidden');

            var txt = document.getElementById('txt_detail_' + n);
            var txtH_n = document.getElementById('txtH_n');
            var txtH_d = document.getElementById('txtH_detail');
            var divforgot = document.getElementById('div_forgot');
            txtH_n.value = n;
            txtH_d.value = txt.value;

            var lbldate = document.getElementById('<%= lbl_date.ClientID %>');

            lbldate.innerText = d;

            fn_tabalDetail(txtH_d.value);

            if (txt.value == '00:00 - 23:59^จำไม่ได้^0 คน') {
                cb_forgot.checked = true;
                divforgot.setAttribute('hidden','hidden');
            } else {
                cb_forgot.checked = false;
                divforgot.removeAttribute('hidden');
            }
        }

        function fn_tabalDetail(TextAr) {
            var html = '';
            html = '<table border="1" style="width: 100%; border-color: blue; color: white;">' +
                    '     <tr>' +
                    '        <td class="text-center" style="width: 10%;">เวลา</td>' +
                    '        <td class="text-center" style="width: 50%;">กิจกรรม/สถานที่</td>' +
                    '        <td class="text-center" style="width: 35%;">จำนวนผู้เข้าร่วมกิจกรรม (ระบุบุคคล หากทำได้)</td>' +
                    '        <td style="width: 5%;"></td>' +
                    '     </tr>';

            var trtd = '';
            if (TextAr != '') {
                var tr = TextAr.split('|');
                for (var i = 0; i < tr.length; i++) {
                    trtd = trtd + '<tr>';
                    var td = tr[i].split('^');
                    for (var j = 0; j < td.length; j++) {
                        trtd = trtd + '<td>';
                        trtd = trtd + td[j];
                        trtd = trtd + '</td>';
                    }
                    trtd = trtd + '<td class="text-center"><i class="ti-2x ti-settings" data-toggle="modal" data-target="#modal_setting_detail" onmouseover="fn_getIndex(' + i + ')"></i></td>';
                    trtd = trtd + '</tr>';
                }
            }
            
            html = html + trtd

            html = html + '</table >';

            document.getElementById('<%= lbl_tableDetail.ClientID %>').innerHTML = html;
        }

        function fn_getIndex(val) {
            var index = document.getElementById('txtH_index');
            index.value = val;
        }

        function fn_delDetail() {
            var index = document.getElementById('txtH_index');

            var n = document.getElementById('txtH_n');
            var txt = document.getElementById('txt_detail_' + n.value)
            var txtH_d = document.getElementById('txtH_detail');

            var tr = txtH_d.value.split('|');
            var trnew = '';
            for (var i = 0; i < tr.length; i++) {
                if (i != index.value) {
                    if (trnew != '') { trnew = trnew + "|"; }
                    trnew = trnew + tr[i];
                }
            }

            txtH_d.value = trnew;
            txt.value = trnew;

            if (txt.value == '') {
                document.getElementById('tr_' + n.value).removeAttribute('style');
            }

            fn_tabalDetail(txtH_d.value);
        }

        function fn_addDetail() {
            var index = document.getElementById('txtH_index');

            var timeStart = document.getElementById('time_start');
            var timeEnd = document.getElementById('time_end');
            var eventLocation = document.getElementById('txt_eventlocation');
            var numPerson = document.getElementById('num_person');
            var txtPerson = document.getElementById('txt_person');

            var styleNull = 'border: groove; border-color: red;';

            timeStart.setAttribute('style', styleNull);
            eventLocation.setAttribute('style', styleNull);
            numPerson.setAttribute('style', styleNull);

            var next = 0;
            if (timeStart.value != '') {
                timeStart.removeAttribute('style');
                next++;
            }
            if (eventLocation.value != '') {
                eventLocation.removeAttribute('style');
                next++;
            }
            if (numPerson.value != '') {
                numPerson.removeAttribute('style');
                next++;
            }

            if (next == 3) {
                var AR = document.getElementById('txtH_detail');

                var detail = '';
                detail = detail + timeStart.value;
                if (timeEnd.value != '') {
                    detail = detail + ' - ' + timeEnd.value;
                }
                detail = detail + '^' + eventLocation.value;
                detail = detail + '^' + numPerson.value + ' คน ';
                if (txtPerson.value != '') {
                    detail = detail + '(' + txtPerson.value + ')';
                }

                if (index.value == '') {
                    if (AR.value != '') {
                        AR.value = AR.value + '|';
                    }
                    AR.value = AR.value + detail;
                } else { // ---- edit detail
                    var tr = AR.value.split('|');
                    var trnew = '';
                    for (var i = 0; i < tr.length; i++) {
                        if (trnew != '') { trnew = trnew + '|'; }
                        if (i == index.value) {
                            trnew = trnew + detail;
                        } else {
                            trnew = trnew + tr[i];
                        }
                    }
                    AR.value = trnew;
                    index.value = '';
                }

                var n = document.getElementById('txtH_n');
                var txt = document.getElementById('txt_detail_' + n.value);
                txt.value = AR.value;

                fn_tabalDetail(AR.value);

                var success = 'background-color: greenyellow;';
                document.getElementById('tr_' + n.value).setAttribute('style',success);

                timeStart.value = '';
                timeEnd.value = '';
                eventLocation.value = '';
                numPerson.value = '';
                txtPerson.value = '';
            }
        }

        function fn_editDetail() {
            var index = document.getElementById('txtH_index');

            var n = document.getElementById('txtH_n');
            var txt = document.getElementById('txt_detail_' + n.value);
            var txtH_d = document.getElementById('txtH_detail');
            //alert(txtH_d.value);
            var tr = txtH_d.value.split('|');
            //alert(tr);
            var td = tr[index.value].split('^');
            //alert(td[0]);

            var timeStart = document.getElementById('time_start');
            var timeEnd = document.getElementById('time_end');
            var eventLocation = document.getElementById('txt_eventlocation');
            var numPerson = document.getElementById('num_person');
            var txtPerson = document.getElementById('txt_person');

            var ts = td[0].split('-');
            if (ts.length > 1) {
                timeStart.value = ts[0].trim();
                timeEnd.value = ts[1].trim();
            } else {
                timeStart.value = td[0];
            }

            eventLocation.value = td[1];
            var ArPerson = td[2].split('คน');
            var numPs = ArPerson[0];
            var txtPs = ArPerson[1];
            numPerson.value = numPs.trim();
            if (txtPs != '') {
                txtPs = txtPs.replace('(','');
                txtPs = txtPs.replace(')','');
            }
            txtPerson.value = txtPs.trim();

            var btnAdd = document.getElementById('btn_addtime');
            var btnEdit = document.getElementById('btn_edittime');

            btnAdd.setAttribute('hidden','hidden');
            btnEdit.removeAttribute('hidden');
        }

        function fn_checkData() {
            var txtAll = document.getElementById('<%= txtH_ALL.ClientID %>');
            var j = 0;
            for (var i = 1; i <= 14; i++) {
                var txt = document.getElementById('txt_detail_' + i);
                if (txtAll.value != '') {
                    txtAll.value = txtAll.value + '!';
                }
                txtAll.value = txtAll.value + txt.value;
                if (txt.value == '') {
                    j++;
                }
            }
            if (j > 0) {
                txtAll.value = '';
                fn_AlertModal('Info', 'กรุณากรอกรายละเอียดให้ครบทุกวัน !!', '', 0);
            } else {
                if (txtAll.value != '') {
                    __doPostBack('<%= btn_submit_2.UniqueID %>', '');
                }
            }
        }
    </script>
        
    </div>

    
    <!-- Div 3 -->
    <div id="div_3" class="col-12 mx-auto fontMobile" runat="server" visible="false" style="margin-top:20%;">
        <div class="col-12 mx-auto my-auto text-center" style="font-size: 65px; font-family: Magneto; color:goldenrod">
            Thank you very much
        </div>
    </div>

    <div class="row col-12 mx-auto my-5 text-center" style="font-size: x-large;">
        <div class="col-1 mx-auto">&nbsp;</div>
        <div class="col-3 mx-auto text-center">
            <li class="media my-4 mx-auto">
                <div id="circle1" class="circle-icon mr-4 mx-auto bg-secondary" runat="server">
                    1
                </div>
            </li>
        </div>
        <div class="col-3 mx-auto text-center">
            <li class="media my-4 mx-auto">
                <div id="circle2" class="circle-icon mr-4 mx-auto bg-gradient-blue" runat="server">
                    2
                </div>
            </li>
        </div>
        <div class="col-3 mx-auto text-center">
            <li class="media my-4 mx-auto">
                <div id="circle3" class="circle-icon mr-4 mx-auto bg-gradient-blue" runat="server">
                    3
                </div>
            </li>
        </div>
        <div class="col-1 mx-auto">&nbsp;</div>
    </div>
</asp:Content>
