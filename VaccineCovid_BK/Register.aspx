<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="BRH_Plubic.VaccineCovid.Register" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentDesktop" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<style>
    input[type=text] {
        border: none;
        border-bottom: 2px solid #808080;
    }
    input:required {
        border: none;
        border-bottom: 2px solid red;
    }
    input:required:valid {
        border: none;
        border-bottom: 2px solid #067423;
    }
    #fdate_dob:valid + .labelDOB { visibility: visible!important; } 
    
    .BKForm {
        background-image: url(image/BK_coronavirus_blue.jpg);
        background-repeat: no-repeat;
        background-size: cover;

        border-radius: 20px;
    }
    .BKForm:before {
        opacity: 0.5;
    }
    .BorderInput{
        border: groove; 
        border-color: deepskyblue; 
        border-radius: 10px;
        background-color: white;
    }
    .FontTopic{
        font-size: x-large;
        text-shadow: 1px 1px 1px #0094ff;
    }
    .CheckboxSize {
        width: 1.5em; height: 1.5em;
    }
</style>

<asp:ScriptManager ID="ScriptManager_Master" runat="server"></asp:ScriptManager>
    
    <!-- ------------ Dose Counter ------------- -->
    <div class="col-12 mx-auto">
        <iframe id="iframe_Counter" src="Counter.aspx" class="row col-12 mx-auto" style="height: 100%; overflow-y: auto;" runat="server"></iframe>
    </div>
    <!-- ------------ Dose Counter ------------- -->

    <div id="top" class="col-12 mx-auto text-center FontTopic">
        ลงทะเบียนจองฉีดวัคซีน Moderna
    </div>

    <div class="row col-12 mx-auto">
        <div class="alert alert-warning alert-dismissible fade show mt-2" role="alert" style="font-size:x-large">
            <strong>คำแนะนำ!</strong> เมื่อทำการลงทะเบียนเสร็จแล้วท่านจะต้องชำระเงินภายใน 1ชั่วโมง ไม่เช่นนั้นจะถูกตัดสิทธิ์ กรุณาเตรียมเงินของท่านสำหรับการโอนชำระออนไลน์ผ่านหมายเลขบัญชีธนาคาร
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <div id="data_top"></div>
        <div class="col-10 mx-auto mt-2 text-left FontTopic">
            ที่อยู่ปัจจุบัน
        </div>
        <div class="row col-11 mx-auto BorderInput">
            <div class="col-3 mx-auto my-2">
                <asp:UpdatePanel ID="UpdatePanel_zip" runat="server">
                    <ContentTemplate>
                        <input id="txt_adr_zip" value="" class="form-control" placeholder="รหัสไปรษณีย์" onkeyup="fn_checkZip()" required runat="server" />
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btn_Auto_ADR" />
                    </Triggers>
                </asp:UpdatePanel>
            </div>
            <div class="col-3 mx-auto my-2">
                <input id="txt_adr_no" value="" class="form-control" placeholder="บ้านเลขที่" required runat="server" />
            </div>
            <div class="col-2 mo-auto my-2">
                <input id="txt_adr_moo" value="" class="form-control" placeholder="หมู่ที่" required runat="server" />
            </div>
            <div class="col-4 mx-auto my-2">
                <input id="txt_adr_bann" value="" class="form-control" placeholder="ชื่ออาคาร หรือหมู่บ้าน" required runat="server" />
            </div>
            <div class="col-12 mx-auto my-2">
                <asp:UpdatePanel ID="UpdatePanel_ADR" runat="server">
                  <ContentTemplate>
                      <div id="div_adr_search" class="col-12 mx-auto my-2" runat="server" visible="false">
                          <asp:ListView ID="LV_ADR" runat="server">
                              <LayoutTemplate>
                                  <div class="col-12 mx-auto text-left">
                                      ตัวเลือกกรอกข้อมูลอัตโนมัติ
                                  </div>
                                  <div id="itemPlaceholder" runat="server"></div>
                              </LayoutTemplate>
                              <ItemTemplate>
                                  <div class="col-12 mx-auto btn btn-outline-info" onclick="fn_Auto_ADR(<%# Eval("lo_id") %>)" style="cursor: pointer;">
                                      <div class="row col-12 mx-auto">
                                          <div class="col-12 mx-auto text-left">
                                              ตำบล:<%# Eval("lo_tambon_th") %> อำเภอ:<%# Eval("lo_district_th") %> จังหวัด:<%# Eval("lo_province_th") %> <%# Eval("lo_postcode") %>
                                          </div>
                                      </div>
                                  </div>
                              </ItemTemplate>
                          </asp:ListView>
                      </div>
                  </ContentTemplate>
                  <Triggers>
                      <asp:AsyncPostBackTrigger ControlID="btn_search_adr" />
                  </Triggers>
              </asp:UpdatePanel>
            </div>
            <asp:UpdatePanel ID="UpdatePanel_btn_adr" runat="server">
                <ContentTemplate>
                    <div class="row col-12 mx-auto my-2">
                        <div class="col-4 mx-auto my-2">
                            <input type="text" id="txt_adr_rode" value="" class="form-control" placeholder="ถนน" runat="server" />
                        </div>
                        <div class="col-4 mx-auto my-2">
                            <input type="text" id="txt_adr_subrode" value="" class="form-control" placeholder="ซอย" runat="server" />
                        </div>
                        <div class="col-4 mx-auto my-2">
                            <input id="txt_adr_tambon" value="" class="form-control" placeholder="ตำบล" required runat="server" />
                        </div>
                        <div class="col-4 mx-auto my-2">
                            <input id="txt_adr_district" value="" class="form-control" placeholder="อำเภอ" required runat="server" />
                        </div>
                        <div class="col-4 mx-auto my-2">
                            <input id="txt_adr_province" value="" class="form-control" placeholder="จังหวัด" required runat="server" />
                        </div>
                        <div class="col-4 mx-auto my-2">
                            <input id="txt_adr_country" value="ประเทศไทย" class="form-control" placeholder="ประเทศ" runat="server" />
                        </div>
                    </div>
                    <div hidden="hidden">
                        <button id="btn_search_adr" runat="server" onserverclick="btn_search_adr_ServerClick"></button>
                        <input type="text" id="txt_auto_id" value="" runat="server" />
                        <button id="btn_Auto_ADR" runat="server" onserverclick="btn_Auto_ADR_ServerClick"></button>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>

        <div id="person_top" class="col-10 mx-auto mt-5 text-left FontTopic">
            ข้อมูลส่วนบุคคล
        </div>
        <div class="col-12 mx-auto">
            <!-- ---------------------- New Person ------------------------ -->
            <asp:Label ID="lbl_newform_person" Text="" runat="server"></asp:Label>
            <!-- ---------------------- New Person ------------------------ -->
        </div>
        <div id="div_person" class="row col-11 mx-auto BorderInput">
            <div class="col-12 mx-auto my-auto my-sm-2" style="font-size: large">
                <span class="my-auto mr-5">ต้องการฉีด : </span>
                <input type="checkbox" class="CheckboxSize" id="cb_dose_1" onclick="fn_dose(1)" checked />
                <span class="my-auto mr-3"> 1 เข็ม</span>
                <input type="checkbox" class="CheckboxSize" id="cb_dose_2" onclick="fn_dose(2)" />
                <span class="my-auto"> 2 เข็ม</span>
            </div>
            <div class="row col-4 mx-auto my-auto my-sm-2" style="font-size: large">
                <div class="col-6 mx-auto text-center">
                    <input type="radio" name="rd_card" id="rd_cardID" onclick="fn_card(1)" checked style="width: 1em; height: 1em;" />
                    <span class="my-auto mr-2">บัตรประชาชน</span>
                </div>
                <div class="col-6 mx-auto text-center">
                    <input type="radio" name="rd_card" onclick="fn_card(2)" id="rd_passport" style="width: 1em; height: 1em;" />
                    <span class="my-auto mr-2">Passport</span>
                </div>
            </div>
            <div class="col-3 mx-auto my-auto my-sm-2">
                <input type="number" id="txt_card_1" value="" class="form-control" placeholder="เลขบัตรประจำตัวประชาชน" required onkeypress="if(this.value.length==13) return false;" onblur="checkForm()" data-toggle="tooltip" data-placement="top" title="หากเจ้าหน้าที่ตรวจสอบภายหลังพบว่าหมายเลขบัตรไม่ตรงกับในภาพถ่าย จะถูกยกเลิกสิทธิ์โดยทันที" />
            </div>
            <div class="row col-5 mx-auto my-auto text-right">
                <span class="col-4 mx-auto my-auto">วันเกิด</span>
                <div class="col-8 mx-auto">
                    <input type="date" id="date_dob" value="" required class="form-control" onchange="fn_change()" runat="server" />
                    <label id="lbl_dob"></label>
                    <script>
                        function fn_change() {
                            var DOB = document.getElementById('<%= date_dob.ClientID %>');
                            var minDOB = DOB.min;
                            var maxDOB = DOB.max;
                            var ar = DOB.value.split('-');
                            var dd = ar[2];
                            var MM = ar[1];
                            var yyyy = ar[0];
                            var newDOB_eg = '';
                            var newDOB_th = '';
                            newDOB_eg = 'ค.ศ.' + yyyy;
                            yyyy = parseInt(yyyy) + 543;
                            newDOB_th = 'พ.ศ.' + yyyy;
                            var ms = '';
                            if (DOB.value < minDOB || DOB.value > maxDOB) {
                                ms = 'วันเกิดไม่ถูกต้อง !!';
                            } else {
                                ms = newDOB_eg + ' = ' + newDOB_th;
                            }
                            document.getElementById('lbl_dob').innerHTML = ms;
                        }
                        fn_change();
                    </script>
                </div>
            </div>
            <div class="row col-8 mx-auto my-auto my-sm-2" hidden="hidden">
                <div class="col-3 mx-auto my-auto">
                    <input type="number" id="txt_dd_1" value="30" onblur="check_dd('1')" class="form-control" />
                </div>
                <div class="col-3 mx-auto my-auto">
                    <input type="number" id="txt_MM_1" value="12" onblur="check_MM('1')" class="form-control" />
                </div>
                <div class="col-3 mx-auto my-auto">
                    <input type="number" id="txt_yyyy_1" value="2534" onblur="check_yyyy('1')" class="form-control" />
                </div>
            </div>
            <div class="col-2 mx-auto my-auto my-sm-2">
                <select id="op_pname_1" class="form-control" required style="border: none; border-bottom: 2px solid #808080;">
                    <option value="นาย" selected="selected">นาย</option>
                    <option value="นาง">นาง</option>
                    <option value="นส.">นส.</option>
                </select>
            </div>
            <div class="col-3 mx-auto my-auto my-sm-2">
                <input id="txt_fname_1" value="" class="form-control" placeholder="ชื่อ" required onkeypress="blockKeyCode(event)"/>
            </div>
            <div class="col-3 mx-auto my-auto my-sm-2">
                <input id="txt_lname_1" value="" class="form-control" placeholder="นามสกุล" required onkeypress="blockKeyCode(event)" />
            </div>
            <div class="col-4 mx-auto my-auto my-sm-2 text-center">
                <span class="mx-auto my-auto">เคยมาใช้บริการ </span>
                <label class="switch my-auto">
                    <input type="checkbox" id="btn_havebeen_1" />
                    <span class="slider round"></span>
                </label>
            </div>
            <div class="col-4 mx-auto my-auto my-sm-2 text-center">
                <input type="text" id="txt_career_1" value="" class="form-control" placeholder="อาชีพ" onkeypress="blockKeyCode(event)" />
            </div>
            <div class="col-4 mx-auto my-auto my-sm-2 text-center">
                <input type="text" id="txt_workplace_1" value="" class="form-control" placeholder="สถานที่ทำงาน" onkeypress="blockKeyCode(event)" />
            </div>
            <div class="col-4 mx-auto my-auto my-sm-2 text-center">
                <input type="number" id="txt_phone_1" value="" class="form-control" placeholder="เบอร์โทรศัพท์" data-toggle="tooltip" data-placement="top" title="กรอกได้เฉพาะตัวเลขไม่เกิน10ตัวอักษร" required onkeypress="if(this.value.length>=10) { return false; } else { fn_phone(); }" />
            </div>
            <script>
                function fn_phone() {
                    blockKeyCode(event);
                }
            </script>
            <div class="row col-12 mx-auto my-3">
                        <div class="col-12 mx-auto">
                            <span style="font-size: large"><label id="lbl_upimg">ภาพถ่ายบัตรประชาชน</label> </span>
                            <input type="file" ID="uploadSlip" name="uploadSlip" onchange="previewFile()" required runat="server" />
                        </div>
                        <div class="col-lg-3 col-sm-5 mx-auto">
                            <asp:Image ID="previewSlip" runat="server" ImageUrl="~/VaccineCovid/image/CardID_EX.jpg" Width="100%" />
                            <label id="lbl_card_ex" style="color: red;">ตัวอย่าง ภาพถ่ายบัตรประชาชน</label>
                        </div>
                        <div hidden="hidden">
                            <input type="text" id="txtH_slip_pt" value="" runat="server" />
                            <input type="text" id="txtH_slip_pv" value="" runat="server" />
                            <button id="btn_resize" onserverclick="btn_resize_ServerClick" runat="server"></button>    
                        </div>
                    </div>
            
            <script>
                function previewFile() {
                    var preview = document.querySelector('#<%=previewSlip.ClientID %>');
                    var file = document.querySelector('#<%=uploadSlip.ClientID %>');
                    var reader = new FileReader();

                    var pt = document.getElementById('<%= txtH_slip_pt.ClientID %>');
                    var pv = document.getElementById('<%= txtH_slip_pv.ClientID %>');

                    reader.onloadend = function () {
                        pt.value = fileName(file.value);
                        var Artype = pt.value.split('.');
                        var type = Artype[1].toLowerCase();
                        if (type == 'jpg' || type == 'png') {
                            preview.src = reader.result;
                            pv.value = reader.result;
                            if (pv.value != '') {
                                document.getElementById('lbl_card_ex').hidden = true;;
                            }
                        } else {
                            pt.value = '';
                            file.value = '';
                            alert('อัพโหลดได้เฉพาะไฟล์ .jpg หรือ .png เท่านั้น !!');
                        }
                    }

                    if (file.files[0]) {
                        reader.readAsDataURL(file.files[0]);
                    } else {
                        preview.src = '';
                    }
                }

                function fileName(fakepath) {
                    var name = fakepath.split('\\');
                    var last = name.length - 1;
                    return name[last];
                }
            </script>
        </div>
        <div id="div_person_btn" class="col-12 mx-auto my-auto my-sm-2">
            <asp:UpdatePanel ID="UpdatePanel_person" runat="server">
                <ContentTemplate>
                    <div id="div_alert_person" class="alert alert-danger fade show mt-2" role="alert" style="font-size:large" runat="server" hidden="hidden">
                        <asp:Label ID="lbl_alert_person" Text="" runat="server"></asp:Label>
                    </div>
                    <div class="col-12 mx-auto" hidden="hidden">
                        <input id="txt_cardID" value="" runat="server" />
                        <input id="txt_DOB" value="" runat="server" />

                        <input id="txtH_ArPerson" value="" runat="server" />
                        <input id="txtH_ADDnew" value="" runat="server" />

                        <input id="txt_qty" value="1" runat="server" />
                        <button id="btn_checkIDcard" runat="server" onserverclick="btn_checkIDcard_ServerClick"></button>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
            <div class="col-10 mx-auto mt-1 text-left FontTopic">
                <a id="btn_add_person" class="btn btn-outline-warning" runat="server" onclick="fn_addPerson()" style="cursor: pointer;">
                    +<i class="ti-user"></i> 
                    <asp:Label id="btn_addPerson" Text="บันทึก" runat="server"></asp:Label>
                </a>
            </div>
        </div>
        <a id="btn_show_person" class="btn btn-outline-warning FontTopic" style="cursor: pointer;" onclick="fn_Show_Person()" hidden="hidden">+<i class="ti-user"></i> เพิ่มสมาชิกในครัวเรือน</a>

        <div id="div_sum" class="row col-12 mx-auto" hidden="hidden">
            <div class="col-10 mx-auto mt-5 text-left FontTopic">
                ข้อมูลการจองวัคซีน
            </div>
            <div class="row col-11 mx-auto mb-5 BorderInput" style="font-size: x-large;">
                <div class="col-6 mx-auto my-auto my-sm-2">
                    จองทั้งหมด <asp:Label ID="lbl_qty" Text="" runat="server"></asp:Label> เข็ม
                </div>
                <div class="col-6 mx-auto my-auto my-sm-2">
                    ราคา เข็มละ <asp:Label ID="lbl_price" Text="" runat="server"></asp:Label> บาท
                </div>
                <div class="col-12 mx-auto my-auto my-sm-2">
                    รวมเป็นเงินทั้งหมด <asp:Label ID="lbl_net" Text="" runat="server"></asp:Label> บาท
                </div>
            </div>

            <div class="col-10 mx-auto mt-5 text-left FontTopic">
                ท่านทราบข่าวสารจากช่องทางใด
            </div>
            <div class="row col-11 mx-auto mb-5 BorderInput" style="font-size: x-large;">
                <textarea id="txt_getnewsfrom" class="form-control" rows="3" placeholder="facebook line ป้ายประชาสัมพันธ์ เพื่อน หรือบุคคลในโรงพยาบาลกรุงเทพระยองแนะนำ ?" onkeypress="blockKeyCode(event)" runat="server"></textarea>
            </div>

            <div class="col-12 mx-auto text-center">
                <a class="btn btn-outline-primary FontTopic" onclick="fn_checkData()" style="cursor: pointer;">บันทึก</a>
                <button id="btn_submit" onserverclick="btn_submit_ServerClick" runat="server" hidden="hidden"></button>
            </div>
        </div>

    </div>

<!-- Modal Confirm -->
<div class="modal fade" id="modalconfirm" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
        <div class="modal-content">
            <div class="modal-header bg-gradient-RedBlue">
                <h5>Confirm</h5>
            </div>
            <div class="modal-body FontTopic">
                คุณต้องการบันทึกข้อมูลการจองใช่หรือไม่ ?
            </div>
            <div class="modal-footer">
                <div class="col-12 mx-auto text-right">
                    <a class="btn btn-outline-danger" data-dismiss="modal" style="cursor: pointer;">ไม่</a>
                    <a class="btn btn-outline-primary" data-dismiss="modal" onclick="fn_checkData()" style="cursor: pointer;">ใช่</a>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function fn_dose(i) {
        var dose1 = document.getElementById('cb_dose_1');
        var dose2 = document.getElementById('cb_dose_2');
        var txtQty = document.getElementById('<%= txt_qty.ClientID %>');
        if (i == 2) {
            dose1.checked = false;
            dose2.checked = true;
        } else {
            dose1.checked = true;
            dose2.checked = false;
        }
        txtQty.value = i;
        var passport = document.getElementById('rd_passport');
        if (passport.checked) {
            fn_CheckPassport(2);
        } else {
            checkForm();
        }
    }

    function fn_card(i) {
        var card = document.getElementById('txt_card_1');
        var lblimgUp = document.getElementById('lbl_upimg');
        var lblimgEx = document.getElementById('lbl_card_ex');
        var preSlip = document.getElementById('<%= previewSlip.ClientID %>');
        if (i == 2) {
            card.setAttribute('type', 'text');
            card.setAttribute('onkeypress', 'fn_CheckPassport(1);');
            card.setAttribute('onblur', 'fn_CheckPassport(2)');
            card.setAttribute('placeholder', 'Passport number');
            lblimgUp.textContent = 'Passport photo';
            lblimgEx.textContent = 'Passport photo';
            preSlip.src = 'image/Passport_EX.jpg';
        } else {
            card.setAttribute('type', 'number');
            card.setAttribute('onkeypress', 'if(this.value.length==13) return false;');
            card.setAttribute('onblur', 'checkForm()');
            card.setAttribute('placeholder', 'เลขบัตรประจำตัวประชาชน');
            lblimgUp.textContent = 'ภาพถ่ายบัตรประชาชน';
            lblimgEx.textContent = 'ภาพถ่ายบัตรประชาชน';
            preSlip.src = 'image/CardID_EX.jpg';
        }
        card.value = '';
    }

    function fn_CheckPassport(s) {
        if (s == 2) {
            IDcard = document.getElementById('txt_card_1');
            document.getElementById('<%= txt_cardID.ClientID %>').value = IDcard.value;
            if (IDcard.value != '') {
                __doPostBack('<%= btn_checkIDcard.UniqueID %>', '');
            } else {
                document.getElementById('<%= lbl_alert_person.ClientID %>').innerHTML = '';
                document.getElementById('<%= div_alert_person.ClientID %>').setAttribute('hidden','hidden');
            }
        } else {
            if (blockKeyCode(event)) {
                return false;
            } else {
                return true;
            }
        }
    }

    function checkID(id) {
        if (id.length != 13) return false;
        for (i = 0, sum = 0; i < 12; i++)
            sum += parseFloat(id.charAt(i)) * (13 - i); if ((11 - sum % 11) % 10 != parseFloat(id.charAt(12)))
            return false; return true;
    }

    function checkForm() {
        var IDcard = document.getElementById('txt_card_1');
        IDcard.removeAttribute('style');
        if (IDcard.value != '') {
            if (!checkID(IDcard.value)) {
                IDcard.setAttribute('style', 'border: none; border-bottom: 2px solid red;');
                location.href = '#div_person';
                fn_AlertModal('Warning', 'เลขบัตรประชาชนไม่ถูกต้อง !!', '', 0);
            } else {
                document.getElementById('<%= txt_cardID.ClientID %>').value = IDcard.value;
                __doPostBack('<%= btn_checkIDcard.UniqueID %>', '');
            }
        }
    }

    function check_dd(id) {
        var dd = document.getElementById('txt_dd_' + id);
        if (dd.value > 31) {
            fn_AlertModal('Warning', 'วัน ไม่ถูกต้อง !!', '', 0);
            dd.value = 30;
        }
    }

    function check_MM(id) {
        var MM = document.getElementById('txt_MM_' + id);
        if (MM.value > 12) {
            fn_AlertModal('Warning', 'เดือน ไม่ถูกต้อง !!', '', 0);
            MM.value = 12;
        }
    }

    function check_yyyy(id) {
        var today = new Date();
        var now_d = today.getDate();
        var now_m = today.getMonth() + 1; //January is 0!
        var now_y = today.getFullYear() + 543; // พศ.
        var dd = document.getElementById('txt_dd_' + id);
        var MM = document.getElementById('txt_MM_' + id);
        var yyyy = document.getElementById('txt_yyyy_' + id);
        if (yyyy.value > now_y) {
            yyyy.value = yyyy.value - 543;
        }
        if (yyyy.value > now_y) {
            fn_AlertModal('Warning', 'ปี ไม่ถูกต้อง !!', '', 0);
            yyyy.value = 2534;
        } else {
            if (yyyy.value == now_y) {
                if (MM.value > now_m) {
                    if (dd.value > now_d) {
                        fn_AlertModal('Warning', 'วันเดือนปี ไม่ถูกต้อง !!', '', 0);
                        dd.value = 30;
                        MM.value = 12;
                        yyyy.value = 2534;
                    } else {
                        document.getElementById('<%= txt_DOB.ClientID %>').value = yyyy.value + '-' + MM.value + '-' + dd.value;
                    }
                }
            }
        }
    }

    function fn_checkZip() {
        var zip = document.getElementById('<%= txt_adr_zip.ClientID %>');
        if (zip.value != '') {
            if (zip.value.length > 3) {
                __doPostBack('<%= btn_search_adr.UniqueID %>', '');
            }
        } else {
            __doPostBack('<%= btn_search_adr.UniqueID %>', '');
        }
    }

    function fn_Auto_ADR(id) {
        document.getElementById('<%= txt_auto_id.ClientID %>').value = id;
        __doPostBack('<%= btn_Auto_ADR.UniqueID %>', '');
    }

    function fn_checkADR() {
        var bool = true;

        var zip = document.getElementById('<%= txt_adr_zip.ClientID %>');
        var no = document.getElementById('<%= txt_adr_no.ClientID %>');
        var moo = document.getElementById('<%= txt_adr_moo.ClientID %>');
        var baan = document.getElementById('<%= txt_adr_bann.ClientID %>');
        var tambon = document.getElementById('<%= txt_adr_tambon.ClientID %>');
        var district = document.getElementById('<%= txt_adr_district.ClientID %>');
        var provice = document.getElementById('<%= txt_adr_province.ClientID %>');

        zip.removeAttribute('style');
        no.removeAttribute('style');
        moo.removeAttribute('style');
        baan.removeAttribute('style');
        tambon.removeAttribute('style');
        district.removeAttribute('style');
        provice.removeAttribute('style');

        var style = 'border: none; border-bottom: 2px solid red;';

        if (zip.value == '' || zip.value < 5) {
            bool = false;
            zip.setAttribute('style', style);
        }
        if (no.value == '') {
            bool = false;
            no.setAttribute('style', style);
        }
        if (moo.value == '') {
            bool = false;
            moo.setAttribute('style', style);
        }
        if (baan.value == '') {
            bool = false;
            baan.setAttribute('style', style);
        }
        if (tambon.value == '') {
            bool = false;
            tambon.setAttribute('style', style);
        }
        if (district.value == '') {
            bool = false;
            district.setAttribute('style', style);
        }
        if (provice.value == '') {
            bool = false;
            provice.setAttribute('style', style);
        }

        return bool;
    }

    function fn_vaccine(arPerson) {
        var lblqty = document.getElementById('<%= lbl_qty.ClientID %>');
        var lblprice = document.getElementById('<%= lbl_price.ClientID %>');
        var lblnet = document.getElementById('<%= lbl_net.ClientID %>');
        var qty = 0;
        var price = lblprice.innerHTML.replace(',','');
        var net = price;
        if (arPerson != '') {
            var ar = arPerson.split('|');
            for (var i = 0; i < ar.length; i++) {
                if (ar[i] != '') {
                    var arCol = ar[i].split('+');
                    qty = qty + parseInt(arCol[9]); // 9 = dose qty
                }
            }
        }
        net = price * qty;
        lblqty.innerHTML = qty;
        lblprice.innerHTML = parseInt(price).toLocaleString("th-TH");
        lblnet.innerHTML = parseInt(net).toLocaleString("th-TH");

        var divPerson = document.getElementById('div_person');
        var divPersonBtn = document.getElementById('div_person_btn');
        var btnShowPerson = document.getElementById('btn_show_person');

        var divSum = document.getElementById('div_sum');
        if (qty > 0) {
            divSum.removeAttribute('hidden');

            btnShowPerson.removeAttribute('hidden');
            divPerson.setAttribute('hidden', 'hidden');
            divPersonBtn.setAttribute('hidden', 'hidden');
        } else {
            divSum.setAttribute('hidden', 'hidden');

            btnShowPerson.setAttribute('hidden', 'hidden');
            divPerson.removeAttribute('hidden');
            divPersonBtn.removeAttribute('hidden');
        }
    }

    function fn_Show_Person() {
        var divPerson = document.getElementById('div_person');
        var divPersonBtn = document.getElementById('div_person_btn');
        var btnShowPerson = document.getElementById('btn_show_person');
        if (divPerson.hidden == true) {
            btnShowPerson.setAttribute('hidden', 'hidden');
            divPerson.removeAttribute('hidden');
            divPersonBtn.removeAttribute('hidden');
        } else {
            btnShowPerson.removeAttribute('hidden');
            divPerson.setAttribute('hidden', 'hidden');
            divPersonBtn.setAttribute('hidden', 'hidden');
        }
    }

    function fn_addPerson() {
        var bool = false;
        var mss = '';

        if (fn_checkADR()) {
            var listPerson = document.getElementById('<%= lbl_newform_person.ClientID %>').innerHTML;
            var alertPerson = document.getElementById('<%= lbl_alert_person.ClientID %>').innerHTML;

            var arPerson = document.getElementById('<%= txtH_ArPerson.ClientID %>');

            var file = document.querySelector('#<%= uploadSlip.ClientID %>');
            var previewFile = document.querySelector('#<%= previewSlip.ClientID %>');
            var pathFile = document.querySelector('#<%= txtH_slip_pt.ClientID %>');
            var dataFile = document.querySelector('#<%= txtH_slip_pv.ClientID %>');
            if (dataFile.value != '') {
                var cardID = document.getElementById('txt_card_1');
                var rdPassport = document.getElementById('rd_passport');
                if (rdPassport.checked) {
                    fn_CheckPassport(2);
                } else {
                    checkForm();
                }
                var DOB = document.getElementById('<%= date_dob.ClientID %>');
                var pname = document.getElementById('op_pname_1');
                var fname = document.getElementById('txt_fname_1');
                var lname = document.getElementById('txt_lname_1');
                var havebeen = document.getElementById('btn_havebeen_1');
                if (havebeen.checked) {
                    havebeen.value = 'yes';
                } else {
                    havebeen.value = 'no';
                }
                var dose = 1;
                var dose1 = document.getElementById('cb_dose_1');
                var dose2 = document.getElementById('cb_dose_2');
                if (dose2.checked) {
                    dose = 2
                }
                var career = document.getElementById('txt_career_1');
                var work = document.getElementById('txt_workplace_1');
                var phone = document.getElementById('txt_phone_1');

                var search = cardID.value;
                if (search == '') { search = 'xxxxxxxxxxxxx'; }
                var duplicate = arPerson.value.includes(search);
                if (duplicate == true) {
                    fn_AlertModal('Warning', alertPerson, '', 0);
                } else {
                    var next = 'yes';
                    cardID.removeAttribute('style');
                    DOB.removeAttribute('style');
                    fname.removeAttribute('style');
                    lname.removeAttribute('style');
                    phone.removeAttribute('style');

                    mss = 'กรุณากรอก ข้อมูลส่วนบุคคล ที่จำเป็นให้ครบถ้วน !!';
                    var style = 'border: none; border-bottom: 2px solid red;';

                    if (DOB.value == '') { next = 'no'; DOB.setAttribute('style', style); }
                    if (fname.value == '') { next = 'no'; fname.setAttribute('style', style); }
                    if (lname.value == '') { next = 'no'; lname.setAttribute('style', style); }
                    if (phone.value == '') {
                        next = 'no'; phone.setAttribute('style', style);
                    } else {
                        if (phone.value.length < 9 || phone.value.length > 10) {
                            next = 'no'; phone.setAttribute('style', style);
                            mss = 'เบอร์โทรศัพท์ไม่ถูกต้อง !!';
                        }
                    }
                    if (cardID.value == '') {
                        next = 'no'; cardID.setAttribute('style', style);
                    } else {
                        if (!rdPassport.checked) {
                            if (checkID(cardID.value) == false) {
                                next = 'no'; cardID.setAttribute('style', style);
                                mss = 'เลขบัตรประจำตัวประชาชน ไม่ถูกต้อง !!';
                            }
                        }
                    }

                    if (next == 'yes') {
                        bool = true;

                        alertPerson = document.getElementById('<%= lbl_alert_person.ClientID %>').innerHTML;
                        mss = '';

                        if (alertPerson == '') {
                            var ar = document.getElementById('<%= txtH_ADDnew.ClientID %>');
                            ar.value = cardID.value + '+' + DOB.value + '+' + pname.value + '+' + fname.value + '+' + lname.value + '+' + havebeen.value + '+' + career.value + '+' + work.value + '+' + phone.value + '+' + dose;

                            if (arPerson.value != '') {
                                arPerson.value = arPerson.value + '|';
                            }
                            arPerson.value = arPerson.value + ar.value;

                            __doPostBack('<%= btn_resize.UniqueID %>', '');

                            //file.value = '';
                            previewFile.src = '';
                            pathFile.value = '';
                            //dataFile.value = '';
                            cardID.value = '';
                            pname.value = 'นาย';
                            fname.value = '';
                            lname.value = '';
                            havebeen.checked = false;
                            career.value = '';
                            work.value = '';
                            phone.value = '';
                            dose1.checked = true;
                            dose2.checked = false;
                        } else {
                            if (cardID.value != '') {
                                mss = alertPerson;
                            }
                        }

                        fn_showPerson();
                    }

                    if (bool == false) {
                        if (listPerson != '' && cardID.value == '') {
                            cardID.removeAttribute('style');
                            DOB.removeAttribute('style');
                            fname.removeAttribute('style');
                            lname.removeAttribute('style');
                            phone.removeAttribute('style');
                            bool = true;
                        }
                    }
                    fn_vaccine(arPerson.value);
                }
            } else {
                mss = 'กรุณาอัพโหลด ภาพถ่ายบัตรประชาชน !!';
            }
        } else {
            mss = 'กรุณากรอกที่อยู่ปัจุบันให้เรียบร้อย !!';
        }

        if (mss != '') {
            location.href = '#top';
            fn_AlertModal('Warning', mss, '', 0);
        }


        return bool;
    }

    function dobTH(dob) {
        var dob_ar = dob.split('-');
        dob = dob_ar[2] +'/'+ dob_ar[1] +'/'+ dob_ar[0];
        return dob;
    }

    function fn_showPerson() {
        var ListPerson = '';
        var arPerson = document.getElementById('<%= txtH_ArPerson.ClientID %>');
        if (arPerson.value != '') {
            var dt = arPerson.value.split('|');
            for (var i = 0; i < dt.length; i++) {
                if (dt[i] != '') {
                    var dr = dt[i].split('+');
                    var index = i + 1;
                    ListPerson = ListPerson + '<div class="row col-12 mx-auto alert alert-info fade show" role="alert">';
                    ListPerson = ListPerson + '<div class="col-2 mx-auto"><img src="../images/CardID/' + dr[0] +'.jpg" style="width: 100%"></div>';
                    ListPerson = ListPerson + '<div class="col-7 mx-auto">';
                    ListPerson = ListPerson + index + '. ';
                    ListPerson = ListPerson + dr[2] + ' ' + dr[3] + ' ' + dr[4];
                    ListPerson = ListPerson + ' เลขบัตรประชาชน: ' + dr[0];
                    ListPerson = ListPerson + ' วันเกิด: ' + dobTH(dr[1]);
                    ListPerson = ListPerson + '<br />' + ' อาชีพ: ' + dr[6];
                    ListPerson = ListPerson + ' สถานที่ทำงาน: ' + dr[7];
                    ListPerson = ListPerson + ' เบอร์โทรศัพท์: ' + dr[8];
                    var havebeen = 'ไม่เคย';
                    if (dr[5] == 'yes') { havebeen = 'เคย'; }
                    ListPerson = ListPerson + ' เคยมาใช้บริการ: ' + havebeen;
                    ListPerson = ListPerson + '</div><div class="col-2 mx-auto text-center">' + dr[9] + '<br />เข็ม</div>';
                    ListPerson = ListPerson + '<a class="col-1 mx-auto my-auto text-center" onclick="fn_delPerson(' + i + ')" style="cursor: pointer; color: red; font-size: x-large;" > <i class="ti-trash"></i></a>  ';
                    ListPerson = ListPerson + '</div>';
                }
            }
        }
        if (ListPerson != '') {
            ListPerson = '<div class="row col-12 mx-auto" style="font-size: large;">' + ListPerson + '</div>';
        }

        var btnAdd = document.getElementById('<%= btn_addPerson.ClientID %>');
        if (ListPerson == '') {
            btnAdd.innerHTML = "บันทึก";
        } else {
            btnAdd.innerHTML = 'บันทึก';
        }

        fn_vaccine(arPerson.value);

        document.getElementById('<%= lbl_newform_person.ClientID %>').innerHTML = ListPerson;
    }

    function fn_delPerson(index) {
        var arPerson = document.getElementById('<%= txtH_ArPerson.ClientID %>');
        if (arPerson.value != '') {
            var newAr = '';
            var dt = arPerson.value.split('|');
            for (var i = 0; i < dt.length; i++) {
                if (i != index) {
                    if (i > 0) { newAr = newAr + '|'; }
                    newAr = newAr + dt[i];
                }
            }
            arPerson.value = newAr;
            fn_showPerson();
            fn_vaccine(arPerson.value);
        }
    }

    function fn_checkData() {
        var bool = true;
        if (!fn_addPerson()) {
            bool = false;
        }
        if (!fn_checkADR()) {
            bool = false;
        }
        if (bool == true) {
            __doPostBack('<%= btn_submit.UniqueID %>', '');
        } else {
            location.href = '#top';
            fn_AlertModal('Warning', 'กรุณากรอกข้อมูลในส่วนที่จำเป็นให้ครบถ้วน !!', '#data_top', 2000);
        }
    }

    function fn_warning() {
        location.href = '#top';
        fn_AlertModal('Warning', 'ไม่อนุญาตให้มีการดัดแปลงหรือแต่งเติมข้อมูลระหว่างทาง !!', '', 0);
    }
</script>

<asp:UpdatePanel ID="UpdatePanel_script" runat="server" >
    <ContentTemplate>
        <asp:Label ID="lbl_script" Text="" runat="server"></asp:Label>
    </ContentTemplate>
</asp:UpdatePanel>

</asp:Content>
