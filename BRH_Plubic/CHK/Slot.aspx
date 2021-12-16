<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Slot.aspx.cs" Inherits="BRH_Plubic.CHK.Slot" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentDesktop" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<!-- Stlye Customs -->
<link href="css/StyleSheet1.css" rel="stylesheet">
<style>
    .RadioSize {
        width: 2em; height: 2em;
    }
    .CheckboxSize {
        width: 1em; height: 1em;
    }
    .CardBGMenu {
        border-radius: 50px;
        border-top-left-radius: 300px;
        border-bottom-right-radius: 300px;
    }
    .textMenu {
        color: white;
        border-radius: 50px;
    }
</style>
<script>
    function TextForSpliteTime(number, unit) {
        var text = '';
        if (number != '') {
            if (number == '0') {
                text = 'ในแต่ละวัน';
            } else {
                text = 'ทุกๆ ' + number + ' ' + unit;
            }
        }
        else {
            text = 'แบบไม่จำกัดเวลา';
        }
        document.write(text);
    }

    function IconActive(active) {
        html = "";
        if (active == 'yes') {
            html = "<span class='ti-3x ti-check rounded-circle' style='background-color:lightgreen;'></span>";
        }
        else if (active == 'no') {
            html = "<span class='ti-3x ti-close rounded-circle' style='background-color:red;'></span>"
        }
        else {

        }
        document.write(html);
    }
</script>

<asp:ScriptManager ID="ScriptManager_Master" runat="server"></asp:ScriptManager>

    <div class="row col-12 mx-auto mt-sm-5">
        <div class="col-6 mx-auto my-3 card btnShadow bg-gradient CardBGMenu" onclick="ShowHide('div_add')">
            <div id="div_Menu_Add" class="row col-12 mx-auto">
                <div class="col-4 mx-auto">
                    <img src="image/icon/CreateSlot.png" class="iconSize100" />
                </div>
                <div class="col-8 mx-auto my-auto h1 bg-primary text-right textMenu">
                    Create<br />Slot.
                </div>
            </div>
        </div>
        <div class="col-6 mx-auto my-3 card btnShadow bg-gradient CardBGMenu" onclick="ShowHide('div_list')">
            <div id="div_Menu_List" class="row col-12 mx-auto">
                <div class="col-4 mx-auto">
                    <img src="image/icon/ListSlot.png" class="iconSize100" />
                </div>
                <div class="col-8 mx-auto my-auto h1 bg-primary text-right textMenu">
                    List<br />Slot.
                </div>
            </div>
        </div>
    </div>

    <div id="div_add" class="section my-3" hidden="hidden">
        <div class="card col-11 mx-auto mb-3" style="color:blue;">
            <div class="row col-12 mx-auto">
                <div class="col-4 mx-auto my-auto text-right h3">
                    Select Contacts : 
                </div>
                <div class="col-8 mx-auto my-auto text-left">
                    <asp:UpdatePanel ID="UpdatePanel_Contacts" runat="server">
                        <ContentTemplate>
                            <asp:DropDownList ID="DD_company" CssClass="col-12 btn btn-light mx-auto my-auto" Font-Size="X-Large" Font-Italic="true" OnSelectedIndexChanged="DD_company_SelectedIndexChanged" AutoPostBack="true" runat="server">
                                <asp:ListItem Text="Select Company" Value=""></asp:ListItem>
                            </asp:DropDownList>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="DD_company" EventName="selectedindexchanged" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
        <div class="card col-11 boxShadow mx-auto">

            <div class="col-12 mx-auto mt-3">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <div id="div_Sync" class="col-12 mx-auto text-center h3" style="color:blue;" runat="server" visible="false">
                            <label class="switch">
                                <input type="checkbox" name="CB_SyncEmp[1][]" id="CB_SyncEmployee" value="sync" onclick="getValueSync('sync')" runat="server" />
                                <span class="slider round"></span>
                            </label>
                            ผูกกับฐานข้อมูลพนักงานของ <asp:Label ID="lbl_contactsName" Text="" runat="server"></asp:Label>
                        </div>
                        <div hidden="hidden">
                            <input type="text" id="txtH_Sync" value="" runat="server" />
                        </div>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="DD_company" EventName="selectedindexchanged" />
                    </Triggers>
                </asp:UpdatePanel>
            </div>
            <div class="col-12"><hr /></div>

            <div class="row col-12 mx-auto">
                <div class="row col-6 mx-auto text-center h3">
                    <div class="col-lg-4 col-sm-12 mx-auto my-auto text-lg-right my-3" style="color:blue;">Start date : </div>
                    <div class="col-8 mx-auto text-lg-left my-3"><input type="date" id="date_start" value="" onchange="CheckDate()" runat="server" /></div>
                    <div class="col-lg-4 col-sm-12 mx-auto my-auto text-lg-right my-3" style="color:blue;">Start Time : </div>
                    <div class="col-8 mx-auto text-lg-left my-3"><input type="time" id="time_start" value="" runat="server" /></div>
                </div>
                <div class="row col-6 mx-auto text-center h3">
                    <div class="col-lg-4 col-sm-12 mx-auto my-auto text-lg-right my-3" style="color:blue;">End date : </div>
                    <div class="col-8 mx-auto text-lg-left my-3"><input type="date" id="date_end" value="" onchange="CheckDate()" runat="server" /></div>
                    <div class="col-lg-4 col-sm-12 mx-auto my-auto text-lg-right my-3" style="color:blue;">End Time : </div>
                    <div class="col-8 mx-auto text-lg-left my-3"><input type="time" id="time_end" value="" runat="server" /></div>
                </div>
                <div class="row col-12 mx-auto text-center h3">
                    <div class="col-4 mx-auto text-right" style="color:blue;">Hidden date :</div>
                    <div class="row col-8 mx-auto my-auto">
                        <input type="checkbox" id="cb_date1" value="1" class="col-1 my-auto CheckboxSize" onclick="fn_hiddendate()" />จ.&nbsp;&nbsp;
                        <input type="checkbox" id="cb_date2" value="2" class="col-1 my-auto CheckboxSize" onclick="fn_hiddendate()" />อ.&nbsp;&nbsp;
                        <input type="checkbox" id="cb_date3" value="3" class="col-1 my-auto CheckboxSize" onclick="fn_hiddendate()" />พ.&nbsp;&nbsp;
                        <input type="checkbox" id="cb_date4" value="4" class="col-1 my-auto CheckboxSize" onclick="fn_hiddendate()" />พฤ.&nbsp;&nbsp;
                        <input type="checkbox" id="cb_date5" value="5" class="col-1 my-auto CheckboxSize" onclick="fn_hiddendate()" />ศ.&nbsp;&nbsp;
                        <input type="checkbox" id="cb_date6" value="6" class="col-1 my-auto CheckboxSize" onclick="fn_hiddendate()" />ส.&nbsp;&nbsp;
                        <input type="checkbox" id="cb_date7" value="7" class="col-1 my-auto CheckboxSize" onclick="fn_hiddendate()" />อ.&nbsp;&nbsp;
                    </div>
                    <div hidden="hidden">
                        <input type="text" id="txt_hiddendate" value="" runat="server" />
                    </div>
                </div>
<script>
    function fn_hiddendate() {
        var val = '';
        for (i = 1; i < 8; i++) {
            var HDD = document.getElementById('cb_date' + i);
            if (HDD.checked) {
                if (val != '') { val = val + '|'; }
                val = val + HDD.value;
            }
        }
        document.getElementById('<%= txt_hiddendate.ClientID %>').value = val;
    }

    function CheckDate() {
        var StartDate = document.getElementById('<%= date_start.ClientID %>');
        var EndDate = document.getElementById('<%= date_end.ClientID %>');
        if (StartDate.value != '') {
            if (EndDate.value == '') {
                EndDate.value = StartDate.value;
            } else {
                if (EndDate.value < StartDate.value) {
                    EndDate.value = StartDate.value;
                }
            }
        }
    }
</script>
                <div class="col-12"><hr /></div>
                <div class="row col-lg-6 col-sm-12 mx-auto">
                <asp:UpdatePanel ID="UpdatePanel_ageCondition" runat="server">
                    <ContentTemplate>
                        <div id="div_AgeCondition" class="col-12 mx-auto h3" hidden="hidden" style="color:blue;" runat="server">
                            <div class="col-12 mx-auto">
                                สร้างเงื่อนไขจากอายุ
                                <label class="switch">
                                    <input type="checkbox" name="CB_ageCondition[1][]" id="CB_ageCondition" value="yes" onclick="fn_CheckAgeCondition()" runat="server" />
                                    <span class="slider round"></span>
                                </label>
                            </div>
                        </div>
                        <div class="row col-12 mx-auto h3">
                            <div id="div_QtyCondition" class="row col-12 mx-auto my-auto" hidden="hidden" runat="server">
                                <div class="col-12 mx-auto text-center">
                                    อายุ <= <input type="number" id="txt_age_lessthan" value="34" class="col-2 border rounded text-center my-auto" runat="server" /> ปี 
                                    จองได้ <input type="number" id="num_age_lessthan" value="1" class="col-2 border rounded text-center my-auto" runat="server" /> คน
                                </div>
                                <%--<div class="col-12 mx-auto text-center">
                                    อายุเท่ากับ <input type="number" id="txt_age_equal" value="35" class="col-2 border rounded text-center my-auto" runat="server" /> ปี 
                                    จองได้ <input type="number" id="num_age_equal" value="1" class="col-2 border rounded text-center my-auto" runat="server" /> คน
                                </div>--%>
                                <div class="col-12 mx-auto text-center">
                                    อายุ >= <input type="number" id="txt_age_morethan" value="35" class="col-2 border rounded text-center my-auto" runat="server" /> ปี 
                                    จองได้ <input type="number" id="num_age_morethan" value="1" class="col-2 border rounded text-center my-auto" runat="server" /> คน
                                </div>
                            </div>
                            <div id="div_Qty" class="row col-12 mx-auto my-auto" style="color:blue;" runat="server">
                                <div class="col-12 mx-auto my-2 text-center">
                                    สามารถจองได้ <input type="number" id="num_qty" value="3" class="col-2 border rounded text-center my-auto" runat="server" /> คน
                                </div>
                                <div class="col-12 mx-auto my-2 text-center">
                                    <label class="switch">
                                        <input type="checkbox" name="CB_DuplicateNextDay" id="CB_DuplicateNextDay" value="yes" runat="server" />
                                        <span class="slider round"></span>
                                    </label> สามารถจองซ้ำในวันอื่นๆที่ไม่ใช่วันเดียวกันได้
                                </div>
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
                </div>
<script>
    function fn_CheckAgeCondition() {
        var CBageCondition = document.getElementById('<%= CB_ageCondition.ClientID %>');
        var divQtyCondition = document.getElementById('<%= div_QtyCondition.ClientID %>');
        var divQty = document.getElementById('<%= div_Qty.ClientID %>');

        if (CBageCondition.checked) {
            divQtyCondition.removeAttribute('hidden');
            divQty.setAttribute('hidden','hidden');
        }
        else {
            divQty.removeAttribute('hidden');
            divQtyCondition.setAttribute('hidden', 'hidden');
        }
    }
</script>
                <div class="row col-lg-6 col-sm-12 mx-auto my-auto text-center h3">
                    <div class="row col-12 mx-auto my-auto text-center" style="color:blue;">
                        <div class="col-12 mx-auto my-auto">
                            <label class="switch">
                                <input type="checkbox" name="CB_SFTime[1][]" id="CB_fulltime" value="full" checked="checked" onclick="getValueSFTime('full')" />
                                <span class="slider round"></span>
                            </label> แบบไม่จำกัดเวลา
                        </div>
                        <div class="col-12 mx-auto my-auto">
                            <label class="switch">
                                <input type="checkbox" name="CB_SFTime[1][]" id="CB_splittime" value="split" onclick="fn_SelectSplit()" />
                                <span class="slider round"></span>
                            </label> แบบแบ่งช่วงเวลา
                        </div>
                        <div id="div_splitSelect" class="row col-12 mx-auto my-auto" hidden="hidden">
                            <div class="col-6 mx-auto my-auto">
                                <label class="switch">
                                    <input type="checkbox" name="CB_SpSe[1][]" id="CB_SpSeAuto" value="auto" onclick="getValueSFTime('split')" />
                                    <span class="slider round"></span>
                                </label> Auto
                            </div>
                            <div class="col-6 mx-auto my-auto">
                                <label class="switch">
                                    <input type="checkbox" name="CB_SpSe[1][]" id="CB_SpSeManual" value="manual" onclick="getValueSFTime('manual')" />
                                    <span class="slider round"></span>
                                </label> Manual
                            </div>
                        </div>
                        <div id="div_splittime" class="row col-12 mx-auto my-auto" hidden="hidden">
                            <div class="row col-6 mx-auto my-auto">
                                <div class="col-5 mx-auto my-auto text-right">
                                    ทุกๆ
                                </div>
                                <div class="col-6 mx-auto my-auto text-left">
                                    <input type="text" id="txt_time" class="form-control" runat="server" /> 
                                </div>
                            </div>
                            <div class="col-6 mx-auto my-auto text-left">
                                <asp:DropDownList ID="DD_timeunit" CssClass="rounded my-auto" runat="server">
                                    <asp:ListItem Value="minute" Text="นาที" Selected="True"></asp:ListItem>
                                    <asp:ListItem Value="hour" Text="ชั่วโมง"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="row col-12 mx-auto my-auto">
                                <div class="col-4 mx-auto text-right">
                                    พักเบรค
                                </div>
                                <div class="col-3 mx-auto">
                                    <input type="time" id="txt_breakSt" class="form-control" value="12:00" runat="server" />
                                </div>
                                <div class="col-2 mx-auto my-auto text-center">
                                    ถึง
                                </div>
                                <div class="col-3 mx-auto">
                                    <input type="time" id="txt_breakEn" class="form-control" value="13:00" runat="server" />
                                </div>
                                <div class="col-12 mx-auto my-2 text-right">
                                    <input type="checkbox" id="cb_StartSlotEndBreak" class="CheckboxSize" value="yes" runat="server" /> เริ่ม Slot ถัดไปต่อจากพักเบรค
                                </div>
                            </div>
                            <div class="row col-12 mx-auto my-2">
                                <div class="col-3 mx-auto my-auto text-right">
                                    เต็มที่
                                </div>
                                <div class="col-3 mx-auto my-auto text-center">
                                    <input type="number" id="txt_maxqty" value="100" class="form-control" runat="server" />
                                </div>
                                <div class="col-6 mx-auto my-auto text-left">
                                    คน
                                </div>
                            </div>
                        </div>
                        <div id="div_splitMe" class="row col-12 mx-auto my-auto" hidden="hidden">
                            <div class="col-12 mx-auto my-auto">
                                <label class="col-12 mx-auto" id="lbl_splitMe"></label>
                            </div>
                            <div hidden="hidden">
                                <input type="text" id="txtH_splitMe" value="" runat="server" />
                            </div>
                            <div class="col-3 mx-auto my-auto">
                                <input type="time" id="time_manual_ST" value="" class="form-control" />
                            </div>
                            <div class="col-1 mx-auto my-auto">-</div>
                            <div class="col-3 mx-auto my-auto">
                                <input type="time" id="time_manual_EN" value="" class="form-control" />
                            </div>
                            <div class="col-3 mx-auto my-auto">
                                <input type="text" id="txt_manual_QTY" value="" placeholder="จำนวนคน" class="form-control" />
                            </div>
                            <div class="col-2 mx-auto my-auto">
                                <i class="fa fa-plus-square-o mx-auto" style="cursor:pointer;" onclick="fn_SplitMe('add','')"></i>
                            </div>
                        </div>
                        <script>
                            function fn_SelectSplit() {
                                var CB = document.getElementById('CB_splittime');
                                var DIV = document.getElementById('div_splitSelect');
                                if (CB.checked) {
                                    DIV.removeAttribute('hidden');
                                } else {
                                    DIV.setAttribute('hidden','hidden');
                                }
                            }

                            function fn_SplitMe(act,ar) {
                                var txtH = document.getElementById('<%= txtH_splitMe.ClientID %>');
                                var timeST = document.getElementById('time_manual_ST');
                                var timeEN = document.getElementById('time_manual_EN');
                                var txtQTY = document.getElementById('txt_manual_QTY');
                                var txtAR = txtH.value;
                                if (act == 'add') {
                                    if (txtAR != '') { txtAR = txtAR + '|'; }
                                    txtAR = txtAR + timeST.value + ',' + timeEN.value + ',' + txtQTY.value;
                                } else {
                                    const splitAR = txtAR.split('|');
                                    splitAR.splice(ar, 1);
                                    txtAR = splitAR.join('|');
                                }
                                txtH.value = txtAR;

                                timeST.value = '';
                                timeEN.value = '';
                                txtQTY.value = '';

                                fn_SplitMe_show();
                            }

                            function fn_SplitMe_show() {
                                var txtH = document.getElementById('<%= txtH_splitMe.ClientID %>');
                                var label = document.getElementById('lbl_splitMe');
                                var html = '';
                                if (txtH.value != '') {
                                    const dt = txtH.value.split('|');
                                    html = '<table style="width: 100%;" border="1">';
                                    for (var i = 0; i < dt.length; i++) {
                                        const dr = dt[i].split(',');
                                        html += '<tr>';
                                        html += '<td style="width: 70%;">' + dr[0] + ' - ' + dr[1] + '</td>';
                                        html += '<td style="width: 25%;">' + dr[2] + '</td>';
                                        html += '<td style="width: 5%;"><i class="fa fa-trash-o" style="cursor: pointer;" onclick="fn_SplitMe(\'del\',\'' + i + '\')"></i></td>';
                                        html += '</tr>';
                                    }
                                    html += '</table>';
                                }
                                label.innerHTML = html;
                            }

                            fn_SplitMe_show();

                        </script>
                    </div>
                </div>
                <div class="col-12"><hr /></div>
                <div class="col-12 mx-auto text-center h3" style="color:blue;">
                    แบบฟอร์ม
                    <asp:DropDownList ID="DD_Form" CssClass="card mx-auto" OnSelectedIndexChanged="DD_Form_SelectedIndexChanged" AutoPostBack="true" runat="server">
                        <asp:ListItem Text="" Value=""></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-lg-8 col-sm-10 mx-auto my-3 badge-secondary rounded">
                    <asp:UpdatePanel ID="UpdatePanel_Form" runat="server">
                        <ContentTemplate>
                            <asp:Label id="lbl_controler" Text="" runat="server"></asp:Label>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="DD_Form" EventName="selectedindexchanged" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
                <div class="col-12"><hr /></div>
                <div class="col-12 mx-auto text-center">
                    <asp:UpdatePanel ID="UpdatePanel_submit" runat="server">
                        <ContentTemplate>
                            <div id="div_submit" class="col-12 mx-auto my-auto text-center h3" runat="server" visible="false">
                                <a href="#" class="btn btn-outline-primary mx-auto text-center my-3" data-toggle="modal" data-target="#ModalConfirmSubmit">Submit</a>
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="DD_Form" EventName="selectedindexchanged" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal -->
    <div class="modal fade" id="ModalConfirmSubmit" tabindex="-1" role="dialog" aria-labelledby="ModalConfirmSubmitTitle" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="ModalConfirmSubmitTitle">Create topic for this booking slot.</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
              <div class="row col-lg-6 col-sm-12 mx-auto">
                  <div class="col-12 mx-auto">
                      <input type="text" id="txt_name" value="" class="form-control" placeholder="กรุณาตั้งชื่อให้ Slot นี้" onkeyup="CheckInput()" runat="server" />
                  </div>
                  <div class="col-12 mx-auto">
                      <textarea rows="2" id="txt_alertonform" class="form-control" placeholder="เพิ่มคำอธิบาย" onkeyup="CheckInput()" runat="server"></textarea>
                  </div>
                  <div class="col-12 mx-auto">
                      <textarea rows="5" id="txt_NotifySubmit" class="form-control" placeholder="กรุณาระบุข้อความที่จะแสดงเมื่อ User ทำการจองเสร็จสิ้น" onkeyup="CheckInput()" runat="server"></textarea>
                  </div>
              </div>
          </div>
          <div class="modal-footer">
              <button type="button" id="btn_submit" class="btn btn-outline-light" onserverclick="btn_submit_ServerClick" disabled="disabled" runat="server">Save</button>
          </div>
        </div>
      </div>
    </div>

<script>
    function CheckInput() {
        var txtName = document.getElementById('<%= txt_name.ClientID %>');
        var notify = document.getElementById('<%= txt_NotifySubmit.ClientID %>');
        var date = document.getElementById('<%= date_start.ClientID %>');
        var qty = document.getElementById('<%= num_qty.ClientID %>');

        var submit = document.getElementById('<%= btn_submit.ClientID %>');

        if (txtName.value == '' || notify.value == '' || date.value == '' || qty == '') {
            submit.setAttribute('disabled', 'disabled');
            submit.setAttribute('class', 'btn btn-outline-light');
        } else {
            submit.removeAttribute('disabled');
            submit.setAttribute('class','btn btn-outline-primary');
        }
    }
</script>

    <div id="div_list" class="section row col-12 mx-auto my-3">
        <div class="row col-12 mx-auto">
            <div class="col-6 mx-auto my-auto">
                
            </div>
            <div class="col-6 mx-auto my-auto">
                <button id="btn_search" class="btn btn-outline-primary" runat="server"><i class="fa fa-2x fa-search"></i></button>
                <input type="text" id="txt_search" class="search" placeholder="Search" runat="server" />
            </div>
        </div>
        <asp:ListView ID="Listview_slot" runat="server">
            <LayoutTemplate>
                <div id="itemPlaceholder" runat="server">
                </div>
            </LayoutTemplate>
            <ItemTemplate>
                <div class="card col-12 boxShadow mx-auto my-2">
                    <div class="row col-12 mx-auto">
                        <div class="row col-1 mx-auto my-auto">
                            <div class="col-12 mx-auto my-auto text-center">
                                <a href="Booking.aspx?key=<%# Eval("bs_key") %>&slot=<%# Eval("bs_id") %>">
                                    <i class="ti-2x ti-eye"></i>
                                </a>
                            </div>
                            <div class="col-12 mx-auto my-auto text-center">
                                <hr />
                            </div>
                            <div class="col-12 mx-auto my-auto text-center">
                                <i class="ti-2x ti-link" onclick="CopyLink('<%# Eval("bs_id") %>')" style="cursor: pointer;"></i>
                            </div>
                            <input type="text" id="txtH_link_<%# Eval("bs_id") %>" hidden="hidden" value="brh.apply-apps.com/CHK/Booking.aspx?key=<%# Eval("bs_key") %>&slot=<%# Eval("bs_id") %>" />
                        </div>
                        <div class="col-3 mx-auto my-auto">
                            <div class="row col-12 mx-auto h5">
                                <div class="col-12 mx-auto my-auto text-center">
                                    เริ่ม <%# Eval("bs_startdate") %>
                                </div>
                                <div class="col-12 mx-auto text-center">
                                    <hr />
                                </div>
                                <div class="col-12 mx-auto my-auto text-center">
                                    ถึง <%# Eval("bs_enddate") %>
                                </div>
                            </div>
                        </div>
                        <div class="col-5 mx-auto my-auto">
                            <div class="row col-12 mx-auto">
                                <div class="col-12 mx-auto alert-info rounded h3">
                                    <%# Eval("bs_name") %>
                                </div>
                                <div class="row col-12 mx-auto">
                                    <div class="col-6 mx-auto text-right h5">
                                        สามารถจองได้ <%# Eval("bs_splittimeqty") %> คน
                                    </div>
                                    <div class="col-6 mx-auto text-left h5">
                                        <script> TextForSpliteTime('<%# Eval("bs_splittime") %>', '<%# Eval("bs_splittimeunit") %>'); </script>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-1 mx-auto my-auto">
                            <a onclick="fn_direction(<%# Eval("bs_id") %>)">
                                <i class="ti-2x ti-direction" style="cursor: pointer;"></i>
                            </a>
                        </div>
                        <div class="row col-2 mx-auto my-auto">
                            <div class="col-12 mx-auto text-center h5">Active</div>
                            <div class="col-12 mx-auto text-center h5">
                                <script> IconActive('<%# Eval("bs_active") %>'); </script>
                            </div>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:ListView>
    </div>

<div hidden="hidden">
    <input type="text" id="txtH_FullSplit" value="full" runat="server" />

    <button id="btn_direction" onserverclick="btn_direction_ServerClick" runat="server"></button>
    <input type="text" id="txtH_direction" value="" runat="server" />
</div>


<!-- Modal add Direction -->
<div class="modal right fade" id="modalDirection" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document" style="max-width: 100%; top: 0; left: auto; right: 0;">
        <div class="modal-content" style="background-color:white;">
            <div class="modal-header h3">
                Connect to my other slot.
            </div>
            <div class="modal-body">
                <div class="row col-12 mx-auto" style="font-size: x-large;">
                    <div class="col-12 mx-auto my-3">
                        <span style="color:blue;">Slot main : </span>
                        <asp:Label ID="lbl_slotmain" Text="" runat="server"></asp:Label>
                    </div>
                    <div class="col-12 mx-auto">
                        เมื่อทำการจองใน <span style="color:blue;">Slot main</span> เสร็จสิ้น ให้เชื่อมต่อไปยัง
                    </div>
                    <div class="col-12 mx-auto my-3">
                        <span style="color:darkgoldenrod;">Slot child : </span>
                        <asp:DropDownList ID="DD_direction" CssClass="btn btn-outline-primary" runat="server">
                            <asp:ListItem Text="" Value=""></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="row col-12 mx-auto my-3">
                        <div class="col-12 mx-auto">
                            กำหนดเงื่อนไขวันจอง
                            <label class="switch">
                                <input type="checkbox" name="CB_direction" id="CB_direction" value="less" onclick="fn_CB_DirectionDay('yes')" runat="server" />
                                <span class="slider round"></span>
                            </label>
                        </div>
                        <div id="div_direction_day" class="card" hidden="hidden">
                            <div class="row col-12 mx-auto">
                                <div class="row col-12 mx-auto my-2">
                                    <div class="col-2 mx-auto my-auto">
                                        <label class="switch">
                                            <input type="checkbox" name="CB_direction_day[1][]" id="CB_direction_dayless" value="less" onclick="fn_CB_DirectionDay('less')" runat="server" />
                                            <span class="slider round"></span>
                                        </label>
                                    </div>
                                    <div class="col-10 mx-auto">
                                        ห้ามเลือกวันที่ใน <span style="color:darkgoldenrod;">Slot child</span>
                                        <br />ก่อนหน้าวันที่จองใน <span style="color:blue;">Slot main</span>
                                        <br /><input type="number" id="txt_direction_day_less" class="col-2" value="0" runat="server" /> วัน
                                    </div>
                                </div>
                                <div class="col-12 boxShadow"></div>
                                <div class="row col-12 mx-auto my-2">
                                    <div class="col-2 mx-auto my-auto">
                                        <label class="switch">
                                            <input type="checkbox" name="CB_direction_day[1][]" id="CB_direction_daymore" value="more" onclick="fn_CB_DirectionDay('more')" runat="server" />
                                            <span class="slider round"></span>
                                        </label>
                                    </div>
                                    <div class="col-10 mx-auto">
                                        ห้ามเลือกวันที่ใน <span style="color:darkgoldenrod;">Slot child</span>
                                        <br />หลังวันที่จองใน <span style="color:blue;">Slot main</span>
                                        <br /><input type="number" id="txt_direction_day_more" class="col-2" value="0" runat="server" /> วัน
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <div class="col-12 mx-auto text-center">
                    <button id="btn_direction_save" class="btn btn-outline-primary" onserverclick="btn_direction_save_ServerClick" runat="server">SAVE <i class="ti-save"></i></button>
                </div>
            </div>
        </div>
    </div>
</div>


<script src="../Scripts/custom/CheckboxGroup.js"></script>

<script>

    var today = Today('1');
    var timeStart = '07:00';
    var timeEnd = '15:00';

    var Startdate = document.getElementById('<%= date_start.ClientID %>');
    var Starttime = document.getElementById('<%= time_start.ClientID %>');
    var Enddate = document.getElementById('<%= date_end.ClientID %>');
    var Endtime = document.getElementById('<%= time_end.ClientID %>');
    Startdate.value = today;
    Starttime.value = timeStart;
    Enddate.value = today;
    Endtime.value = timeEnd;

    function ShowHide(name) {
        document.getElementById('div_add').hidden = true;
        document.getElementById('div_list').hidden = true;

        var div = document.getElementById(name);
        if (div.hidden) {
            div.hidden = false;
            window.location.href = '#' + name;
        }
        else {
            div.hidden = true;
        }

        var MenuAdd = document.getElementById('div_Menu_Add');
        var MenuList = document.getElementById('div_Menu_List');
        MenuAdd.removeAttribute('style');
        MenuList.removeAttribute('style');
        if (name == 'div_add') {
            MenuAdd.setAttribute('style', 'color:cornflowerblue');
        }
        if (name == 'div_list') {
            MenuList.setAttribute('style', 'color:cornflowerblue');
        }
    }

    function getValueSFTime(val) {
        var txtH = document.getElementById('<%= txtH_FullSplit.ClientID %>');
        var divSelect = document.getElementById('div_splitSelect');
        var divAuto = document.getElementById('div_splittime');
        var divManual = document.getElementById('div_splitMe');
        divSelect.removeAttribute('hidden');
        divAuto.setAttribute('hidden', 'hidden');
        divManual.setAttribute('hidden', 'hidden');
        txtH.value = val;
        if (val == 'split') {
            divAuto.removeAttribute('hidden');
        } else if(val == 'manual') {
            divManual.removeAttribute('hidden');
        } else {
            divSelect.setAttribute('hidden','hidden');
            var splitTime = document.getElementById('<%= txt_time.ClientID %>');
            var splitUnit = document.getElementById('<%=  DD_timeunit.ClientID %>');
            splitTime.value = "";
            splitUnit.value = "minute";
        }
    }

    function getValueSync(val) {
        var CBSync = document.getElementById('<%= CB_SyncEmployee.ClientID %>');
        var div_AgeCon = document.getElementById('<%= div_AgeCondition.ClientID %>');
        var txtHSync = document.getElementById('<%= txtH_Sync.ClientID %>');

        if (CBSync.checked) {
            txtHSync.value = val;
            div_AgeCon.removeAttribute('hidden');
        } else {
            txtHSync.value = "";
            var CBageCondition = document.getElementById('<%= CB_ageCondition.ClientID %>');
            CBageCondition.checked = false;
            div_AgeCon.setAttribute('hidden', 'hidden');
        }

        fn_CheckAgeCondition();
    }

    function CopyLink(id) {
        if (confirm("You want copy link ?") == true) {
            var copyText = document.getElementById("txtH_link_" + id);
            copyText.removeAttribute("hidden");
            copyText.select();
            copyText.setSelectionRange(0, 99999)
            document.execCommand("copy");
            copyText.setAttribute("hidden", "hidden");
        }
    }

    function fn_direction(id) {
        var direction = document.getElementById('<%= txtH_direction.ClientID %>');
        direction.value = id;

        var CBdirection = document.getElementById('<%= CB_direction.ClientID %>');
        CBdirection.checked = false;
        fn_CB_DirectionDay();

        __doPostBack('<%= btn_direction.UniqueID %>', '');
    }

    function fn_CB_DirectionDay(val) {
        var CBdirection = document.getElementById('<%= CB_direction.ClientID %>');
        var CBdayLess = document.getElementById('<%= CB_direction_dayless.ClientID %>');
        var CBdayMore = document.getElementById('<%= CB_direction_daymore.ClientID %>');
        var div_direction = document.getElementById('div_direction_day');

        if (CBdirection.checked) {
            div_direction.removeAttribute('hidden');
            if (val == 'less') {
                CBdayLess.checked = true;
                CBdayMore.checked = false;
            } else if (val == 'more') {
                CBdayLess.checked = false;
                CBdayMore.checked = true;
            } else {
                val = "less";
                CBdayLess.checked = true;
                CBdayMore.checked = false;
            }
        }
        else {
            div_direction.setAttribute('hidden', 'hidden');
            CBdayLess.checked = false;
            CBdayMore.checked = false;
        }
    }
</script>

    <asp:Label ID="lbl_Modal" Text="" runat="server"></asp:Label>


<asp:UpdatePanel ID="UpdatePanel_script" runat="server">
    <ContentTemplate>
        <asp:Label ID="lbl_script" Text="" runat="server"></asp:Label>
    </ContentTemplate>
</asp:UpdatePanel>
    

</asp:Content>
