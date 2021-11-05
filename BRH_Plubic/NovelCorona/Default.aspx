<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="BRH_Plubic.NovelCorona.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentDesktop" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .boxInput{
            position: fixed; 
            top: 30%;
        }
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
        .requiredInput{
            border: groove;
            /*border-color: red;*/
        }
    </style>
    

    <div class="col-12 mx-auto mt-5">
        <div class="col-12 mx-auto text-center h3">
            แบบรายงานผู้ป่วยโรคปอดอักเสบจากเชื้อไวรัสโคโรนาสายพันธุ์ใหม่ 2019
        </div>
        <div class="card col-lg-10 col-sm-12 mx-auto bg-gradient-blue" style="border-radius: 20px; font-size: large;">

            <!-- DIV 1 ---------------------------------------------- -->
            <div id="div_1" class="row col-12 mx-auto my-5" runat="server" visible="true">
                <div class="col-12 mx-auto text-left my-2">
                    1. ข้อมูลทั่วไป
                </div>
                <div class="col-6 mx-auto text-center my-2">
                    <input type="text" id="txt_fname" class="form-control" value="" placeholder="ชื่อ" runat="server" />
                </div>
                <div class="col-6 mx-auto text-center my-2">
                    <input type="text" id="txt_lname" class="form-control" value="" placeholder="นามสกุล" runat="server" />
                </div>

                <div class="col-6 mx-auto text-left my-2">
                    <div id="div_rd_sex" class="row col-12 mx-auto" runat="server">
                        <div class="col-4 mx-auto my-auto text-center">เพศ</div>
                        <div class="col-4 mx-auto my-auto text-center">
                            <input type="radio" id="rd_sex_M" name="rd_sex" checked value="male" runat="server" onclick="fn_female('male')" />ชาย
                        </div>
                        <div class="col-4 mx-auto my-auto text-center">
                            <input type="radio" id="rd_sex_F" name="rd_sex" value="female" runat="server" onclick="fn_female('female')" />หญิง
                        </div>
                    </div>
                </div>
                <div class="col-6 mx-auto my-2 text-center">
                    <div class="row col-12 mx-auto">
                        <div class="col-6 mx-auto my-auto text-center" hidden="hidden">
                            วันเดือนปีเกิด
                        </div>
                        <div class="col-6 mx-auto text-center" hidden="hidden">
                            <input type="date" id="date_DOB" class="form-control" value="" runat="server"/>
                        </div>
                        <div class="row col-4 mx-auto text-center">
                            <span class="col-12 mx-auto my-auto">วัน</span> <input type="number" id="txt_D" value="" min="1" max="31" class="col-12 mx-auto" runat="server" />
                        </div>
                        <div class="row col-4 mx-auto text-center">
                            <span class="col-12 mx-auto my-auto">เดือน</span> <input type="number" id="txt_O" value="" min="1" max="12" class="col-12 mx-auto" runat="server" />
                        </div>
                        <div class="row col-4 mx-auto text-center">
                            <span class="col-12 mx-auto my-auto">ปีเกิด</span> <input type="number" id="txt_B" value="" class="col-12 mx-auto" runat="server" />
                        </div>
                    </div>
                </div>
                <div id="div_female" class="row col-12 mx-auto my-2" hidden="hidden">
                    <div class="col-3 mx-auto">
                        <input type="radio" id="rd_nopregnant" name="rd_pregnant" value="no" checked onclick="fn_pregnant('no')" runat="server" />ไม่ได้ตั้งครรภ์
                    </div>
                    <div class="col-3 mx-auto">
                        <input type="radio" id="rd_yespregnant" name="rd_pregnant" value="yes" onclick="fn_pregnant('yes')" runat="server" />ตั้งครรภ์ 
                    </div>
                    <div class="col-6 mx-auto">
                        <div id="div_pregnant" class="row col-12 text-left" hidden="hidden">
                            ครรภ์ที่ <input type="number" id="num_pregnan" class="col-2 form-control my-auto" value="" runat="server" /> &nbsp;
                            อายุครรภ์ <input type="number" id="num_pregnanweek" class="col-2 form-control my-auto" value="" runat="server" /> สัปดาห์
                        </div>
                    </div>
                </div>
                <script>
                    var divFemale = document.getElementById('div_female');
                    var divpregnant = document.getElementById('div_pregnant');
                    var sexF = document.getElementById('<%= rd_sex_F.ClientID %>');
                    if (sexF.checked) {
                        divFemale.removeAttribute('hidden');
                        divpregnant.removeAttribute('hidden');
                    }

                    function fn_female(sex) {
                        if (sex == 'female') {
                            divFemale.removeAttribute('hidden');
                        } else {
                            divFemale.setAttribute('hidden', 'hidden');
                            fn_pregnant('no');
                        }
                    }

                    function fn_pregnant(val) {
                        if (val == 'yes') {
                            divpregnant.removeAttribute('hidden');
                        } else {
                            divpregnant.setAttribute('hidden', 'hidden');
                            document.getElementById('<%= num_pregnan.ClientID %>').value = '';
                                document.getElementById('<%= num_pregnanweek.ClientID %>').value = '';
                        }
                    }
                </script>

                <div class="col-12 mx-auto my-auto text-center">
                    <textarea id="txt_career" rows="3" class="form-control" placeholder="อาชีพ (ระบุลักษณะงานที่ทำอย่างละเอียด เช่น บุคลากรทางการแพทย์ เจ้าหน้าที่ที่สัมผัสกับนักท่องเที่ยว)" runat="server"></textarea>
                </div>

                <div class="col-6 mx-auto my-2 text-center">
                    <input type="text" id="txt_nationality" value="" class="form-control" placeholder="สัญชาติ" runat="server" />
                </div>
                <div class="col-6 mx-auto my-2 text-center">
                    <input type="text" id="txt_race" value="" class="form-control" placeholder="เชื้อชาติ" runat="server" />
                </div>
                
                <div class="row col-12 mx-auto my-2">
                    <input type="text" id="txt_workplace" class="col-12 form-control mb-2" value="" placeholder="สถานที่ทำงาน/ สถานศึกษา" runat="server" /> 
                    <input type="text" id="txt_adr_mobile" class="col-5 form-control mx-auto" value="" placeholder="เบอร์โทรศัพท์ที่ติดต่อได้" runat="server" />
                    <input type="text" id="txt_morchana_mobile" class="col-5 form-control mx-auto" value="" placeholder="เบอร์โทรศัพท์ที่ใช้ลงแอปพลิเคชัน “หมอชนะ”" runat="server" />
                </div>
                <div class="row col-12 mx-auto">
                    <div class="col-lg-4 col-sm-6 mx-auto my-auto text-center">
                        ที่อยู่ที่ติดตามได้ในประเทศไทย
                    </div>
                    <div class="row col-lg-8 col-sm-6 text-left">
                        <div id="div_rd_baan" class="col-12 mx-auto" runat="server">
                            <input type="radio" id="rd_baan_1" name="rd_baan" checked value="บ้าน" onclick="fn_baanOther('baan')" runat="server" /> บ้าน
                            <input type="radio" id="rd_baan_2" name="rd_baan" value="อื่นๆ" onclick="fn_baanOther('other')" runat="server" /> อื่นๆ
                        </div>
                        <div id="div_baanOther" class="col-12 mx-auto" hidden="hidden">
                            <input type="text" id="txt_baan_2" class="form-control" value="" placeholder="โปรดระบุ" runat="server" />
                        </div>
                        <script>
                            var divBaan = document.getElementById('div_baanOther');

                            var rd_baanOther = document.getElementById('<%= rd_baan_2.ClientID %>');
                            if (rd_baanOther.checked) {
                                divBaan.removeAttribute('hidden');
                            }
                            else {
                                var txtOther = document.getElementById('<%= txt_baan_2.ClientID %>').value = "";
                                divBaan.setAttribute('hidden', 'hidden');
                            }

                            function fn_baanOther(val) {
                                if (val == 'other') {
                                    divBaan.removeAttribute('hidden');
                                }
                                else {
                                    var txtOther = document.getElementById('<%= txt_baan_2.ClientID %>').value = "";
                                    divBaan.setAttribute('hidden','hidden');
                                }
                            }
                        </script>
                    </div>
                    <div class="col-lg-2 col-sm-3 mx-auto navbar-text"><input type="text" id="txt_adr_number" class="form-control" value="" placeholder="เลขที่" runat="server" /></div>
                    <div class="col-lg-2 col-sm-3 mx-auto navbar-text"><input type="text" id="txt_adr_moo" class="form-control" value="" placeholder="หมู่ที่" runat="server" /></div>
                    <div class="col-lg-4 col-sm-6 mx-auto navbar-text"><input type="text" id="txt_adr_baan" class="form-control" value="" placeholder="หมู่บ้าน" runat="server" /></div>
                    <div class="col-lg-2 col-sm-3 mx-auto navbar-text"><input type="text" id="txt_adr_alley" class="form-control" value="" placeholder="ซอย" runat="server" /></div>
                    <div class="col-lg-2 col-sm-3 mx-auto navbar-text"><input type="text" id="txt_adr_road" class="form-control" value="" placeholder="ถนน" runat="server" /></div>
                    <div class="col-lg-4 col-sm-6 mx-auto navbar-text"><input type="text" id="txt_adr_subdistrict" class="form-control" value="" placeholder="ตำบล" runat="server" /></div>
                    <div class="col-lg-4 col-sm-6 mx-auto navbar-text"><input type="text" id="txt_adr_district" class="form-control" value="" placeholder="อำเภอ" runat="server" /></div>
                    <div class="col-lg-4 col-sm-6 mx-auto navbar-text"><input type="text" id="txt_adr_province" class="form-control" value="" placeholder="จังหวัด" runat="server" /></div>
                   <%-- <div class="col-lg-4 col-sm-4 mx-auto navbar-text"><input type="text" id="txt_adr_phone" class="form-control" value="" placeholder="โทรศัพท์บ้าน" runat="server" /></div>
                    <div class="col-lg-4 col-sm-4 mx-auto navbar-text"><input type="text" id="txt_adr_tel" class="form-control" value="" placeholder="ที่ทำงาน" runat="server" /></div>
                    <div class="col-lg-4 col-sm-4 mx-auto navbar-text"><input type="text" id="txt_adr_mobile" class="form-control" value="" placeholder="มือถือ" runat="server" /></div>--%>
                    <div class="row col-12 mx-auto my-2">
                        <input type="text" id="txt_congenitalDisease" class="col-12 form-control mb-2" value="" placeholder="โรคประจำตัว" runat="server" />
                        <div class="col-12 mx-auto">
                            การสูบบุหรี่ 
                            <input type="radio" id="rd_no_smoking" name="rd_smoking" value="ไม่เคยสูบ" checked onclick="fn_smoking('ไม่เคยสูบ')" /> ไม่เคยสูบ 
                            <input type="radio" id="rd_yes_smoking" name="rd_smoking" value="ยังคงสูบ" onclick="fn_smoking('ยังคงสูบ')" /> ยังคงสูบ 
                            <input type="radio" id="rd_shrimp_smoking" name="rd_smoking" value="เคยสูบแต่เลิกแล้ว" onclick="fn_smoking('เคยสูบแต่เลิกแล้ว')" /> เคยสูบแต่เลิกแล้ว
                            <input type="text" id="txtH_smoking" value="ไม่เคยสูบ" runat="server" hidden="hidden"/>
                            <script>
                                var txtHsmoking = document.getElementById('<%= txtH_smoking.ClientID %>');
                                var rdsmoking = document.getElementById('rd_smoking');
                                if (txtHsmoking.value == 'เคยสูบแต่เลิกแล้ว') {
                                    document.getElementById('rd_shrimp_smoking').checked = true;
                                    rdsmoking.checked = false;
                                }
                                if (txtHsmoking.value == 'ยังคงสูบ') {
                                    document.getElementById('rd_yes_smoking').checked = true;
                                    rdsmoking.checked = false;
                                }

                                function fn_smoking(val) {
                                    txtHsmoking.value = val;
                                }
                            </script>
                        </div>
                    </div>
                </div>
                
                <hr class="col-10 mx-auto my-2 bg-gradient-mix" />

            </div>

            <!-- DIV 2 ---------------------------------------------- -->
            <div id="div_2" class="row col-12 mx-auto my-5" runat="server" visible="false">
                <div class="col-12 mx-auto text-left my-2">
                    2. ข้อมูลทางคลินิก
                </div>
                <div class="row col-12 mx-auto my-2">
                    <div class="col-2 mx-auto my-auto text-right">วันที่เริ่มป่วย</div>
                    <div class="col-3 mx-auto my-auto text-left"><input type="date" id="date_whenSick" class="form-control" value="" runat="server" /></div>
                    <div class="col-4 mx-auto my-auto text-right">วันที่เข้ารับการรักษาครั้งแรก</div>
                    <div class="col-3 mx-auto my-auto text-left"><input type="date" id="date_firstVisit" class="form-control" value="" runat="server" /></div>
                </div>
                <div class="row col-12 mx-auto my-2">
                    <div class="col-8 mx-auto"><input type="text" id="txt_firstHospital" class="form-control" value="" placeholder="ชื่อสถานพยาบาลที่เข้ารับการรักษาครั้งแรก" runat="server" /></div>
                    <div class="col-4 mx-auto"><input type="text" id="txt_firstHospital_province" class="form-control" value="" placeholder="จังหวัด" runat="server" /></div>
                </div>
                <div class="row col-12 mx-auto my-2">
                    <div class="col-8 mx-auto"><input type="text" id="txt_currenHospital" class="form-control" value="" placeholder="ชื่อสถานพยาบาลที่เข้ารับการรักษาในปัจจุบัน" runat="server" /></div>
                    <div class="col-4 mx-auto"><input type="text" id="txt_currenHospital_province" class="form-control" value="" placeholder="จังหวัด" runat="server" /></div>
                </div>
                <div class="row col-12 mx-auto my-2">
                    <div class="col-12 mx-auto my-2">
                        <div class="row col-12 mx-auto">
                            <div class="col-12">อาการและอาการแสดงในวันพบผู้ป่วย : <input type="checkbox" name="cb_sick" id="cb_sickyes" class="col-6 mx-auto" value="yes" runat="server" />ไข้</div>
                            <div class="row col-12">
                                <span class="my-auto">อุณหภูมิร่างกายแรกรับ</span>
                                <input type="text" id="txt_temperature" class="col-2 form-control ml-2" value="" placeholder="องศาเซลเซียส" runat="server" />
                                <input type="text" id="txt_O2sat" class="col-2 form-control ml-2" value="" placeholder="O2 Sat" runat="server" /><span class="my-auto">%</span>
                                <input type="checkbox" id="cb_respirator" class="my-auto ml-5" value="yes" runat="server" /><span class="my-auto">ใส่เครื่องช่วยหายใจ</span>
                            </div>
                            <div class="row col-12 mx-auto">
                                <div class="col-3 mx-auto text-left">
                                    <input type="checkbox" id="cb_symptom_1" value="ไอ" runat="server" />ไอ
                                </div>
                                <div class="col-3 mx-auto text-left">
                                    <input type="checkbox" id="cb_symptom_2" value="เจ็บคอ" runat="server" />เจ็บคอ
                                </div>
                                <div class="col-3 mx-auto text-left">
                                    <input type="checkbox" id="cb_symptom_3" value="ปวดกล้ามเนื้อ" runat="server" />ปวดกล้ามเนื้อ
                                </div>
                                <div class="col-3 mx-auto text-left">
                                    <input type="checkbox" id="cb_symptom_4" value="มีน้ำมูก" runat="server" />มีน้ำมูก
                                </div>

                                <div class="col-3 mx-auto text-left">
                                    <input type="checkbox" id="cb_symptom_5" value="หายใจลำบาก" runat="server" />หายใจลำบาก
                                </div>
                                <div class="col-3 mx-auto text-left">
                                    <input type="checkbox" id="cb_symptom_6" value="ปวดศีรษะ" runat="server" />ปวดศีรษะ
                                </div>
                                <div class="col-3 mx-auto text-left">
                                    <input type="checkbox" id="cb_symptom_7" value="ถ่ายเหลว" runat="server" />ถ่ายเหลว
                                </div>
                                <div class="col-3 mx-auto text-left">
                                    <input type="checkbox" id="cb_symptom_8" value="จมูกไม่ได้กลิ่น" runat="server" />จมูกไม่ได้กลิ่น
                                </div>

                                <div class="col-3 mx-auto text-left">
                                    <input type="checkbox" id="cb_symptom_9" value="ลิ้นไม่รับรส" runat="server" />ลิ้นไม่รับรส
                                </div>
                                <div class="col-3 mx-auto text-left">
                                    <input type="checkbox" id="cb_symptom_10" value="ตาแดง" runat="server" />ตาแดง
                                </div>
                                <div class="row col-6 mx-auto text-left">
                                    <input type="checkbox" id="cb_symptom_11" value="ผื่น" runat="server" onclick="fn_symptom11()" />ผื่น
                                    <input type="text" id="txt_symptom_11" value="" class="col-10 form-control" placeholder="ตำแหน่ง" runat="server" hidden="hidden" />
                                </div>
                                <script>
                                    function fn_symptom11() {
                                        var txtsymptom11 = document.getElementById('<%= txt_symptom_11.ClientID %>');
                                        var cbsymptom11 = document.getElementById('<%= cb_symptom_11.ClientID %>');
                                        if (cbsymptom11.checked) {
                                            txtsymptom11.removeAttribute('hidden');
                                        }
                                        else {
                                            txtsymptom11.value = "";
                                            txtsymptom11.setAttribute('hidden', 'hidden');
                                        }
                                    }
                                </script>

                                <div class="col-2">
                                    <input type="checkbox" id="cb_symptom_other" value="อื่นๆ" runat="server" onclick="fn_symptomOther()" /><span class="my-auto">อื่นๆ</span>
                                </div>
                                <div class="col-10">
                                    <input type="text" id="txt_symptomOther" class="form-control" value="" placeholder="ระบุ" runat="server" hidden="hidden" />
                                </div>
                                <script>
                                    function fn_symptomOther() {
                                        var txtsymptomOther = document.getElementById('<%= txt_symptomOther.ClientID %>');
                                        var cbsymptom_other = document.getElementById('<%= cb_symptom_other.ClientID %>');
                                        if (cbsymptom_other.checked) {
                                            txtsymptomOther.removeAttribute('hidden');
                                        }
                                        else {
                                            txtsymptomOther.value = "";
                                            txtsymptomOther.setAttribute('hidden', 'hidden');
                                        }
                                    }
                                </script>
                            </div>
                        </div>
                    </div>
                    <div class="row col-12 mx-auto my-2">
                        <div class="row col-lg-4 col-sm-6 mx-auto text-left">
                            <div class="col-auto">เอ็กซเรย์ปอด (ครั้งแรก)</div>
                            <div class="col-auto"><input type="radio" id="rd_xray_no" value="ไม่ได้ทำ" runat="server" onclick="fn_xray()" />ไม่ได้ทำ</div>
                            <div class="col-auto"><input type="radio" id="rd_xray_yes" value="ทำ" runat="server" onclick="fn_xray()" />ทำ</div>
                        </div>
                        <div class="row col-lg-8 col-sm-6 mx-auto">
                            <div class="col-6"><input type="date" id="date_xray" value="" class="form-control my-auto" runat="server" hidden="hidden" /></div>
                            <div class="col-6"><input type="text" id="txt_xray_result" class="form-control my-auto" value="" placeholder="ระบุผล" runat="server" hidden="hidden" /></div>
                        </div>
                        <script>
                            function fn_xray() {
                                var rdXray = document.getElementById('<%= rd_xray_yes.ClientID %>');
                                var dateXray = document.getElementById('<%= date_xray.ClientID %>');
                                var resultXray = document.getElementById('<%= txt_xray_result.ClientID %>');
                                if (rdXray.checked) {
                                    dateXray.removeAttribute('hidden');
                                    resultXray.removeAttribute('hidden');
                                }
                                else {
                                    dateXray.setAttribute('hidden', 'hidden');
                                    dateXray.value = "";
                                    resultXray.setAttribute('hidden', 'hidden');
                                    resultXray.value = "";
                                }
                            }
                        </script>
                    </div>
                    <div class="col-12 mx-auto my-2">
                        <div class="row col-12 mx-auto">
                            <div class="col-lg-2 col-sm-3 mx-auto my-auto text-left">
                                CBC (ครั้งแรก) 
                            </div>
                            <div class="col-lg-4 col-sm-3 mx-auto text-left">
                                <input type="date" id="date_cbc" class="form-control" value="" runat="server" />
                            </div>
                            <div class="col-2 mx-auto text-left">
                                <input type="text" id="txt_cbc_hb" class="form-control" value="" placeholder="ผล Hb" runat="server" />
                            </div>
                            <div class="col-2 mx-auto text-left">
                                <input type="text" id="txt_cbc_hct" class="form-control" value="" placeholder="mg% Hct" runat="server" />
                            </div>
                            <div class="col-2 mx-auto text-left">
                                <input type="text" id="txt_cbc_wbc" class="form-control" value="" placeholder="% WBC" runat="server" />
                            </div>
                        </div>
                    </div>
                    <div class="col-12 mx-auto my-2">
                        <div class="row col-12 mx-auto">
                            <div class="col-3 mx-auto my-auto">
                                Platelet count
                            </div>
                            <div class="row col-3 mx-auto my-auto">
                                <div class="col-6 mx-auto my-auto">
                                    <input type="text" id="txt_pc_x" class="form-control" value="" runat="server" />
                                </div>
                                <div class="col-6 mx-auto my-auto text-left">
                                    x10<sup>3</sup>
                                </div>
                            </div>
                            <div class="row col-3 mx-auto my-auto">
                                <div class="col-3 mx-auto my-auto text-right">N</div>
                                <div class="col-6 mx-auto">
                                    <input type="text" id="txt_pc_n" class="form-control" value="" runat="server" />
                                </div>
                                <div class="col-3 mx-auto my-auto text-left">%</div>
                            </div>
                            <div class="row col-3 mx-auto my-auto">
                                <div class="col-3 mx-auto my-auto text-right">L</div>
                                <div class="col-6 mx-auto">
                                    <input type="text" id="txt_pc_l" class="form-control" value="" runat="server" />
                                </div>
                                <div class="col-3 mx-auto my-auto text-left">%</div>
                            </div>
                            <div class="row col-6 mx-auto my-1">
                                <div class="col-6 mx-auto my-auto text-right">Atyp lymph</div>
                                <div class="col-3 mx-auto">
                                    <input type="text" id="txt_pc_al" class="form-control" value="" runat="server" />
                                </div>
                                <div class="col-3 mx-auto my-auto text-left">%</div>
                            </div>
                            <div class="row col-6 mx-auto my-1">
                                <div class="col-6 mx-auto my-auto text-right">Mono</div>
                                <div class="col-3 mx-auto">
                                    <input type="text" id="txt_pc_mn" class="form-control" value="" runat="server" />
                                </div>
                                <div class="col-3 mx-auto my-auto text-left">%</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 mx-auto my-2">
                        <div class="row col-12 mx-auto">
                            <div class="col-12 mx-auto">
                                ผลการตรวจ Influenza test (ถ้ามี)
                            </div>
                            <div class="row col-lg-4 col-sm-12 mx-auto mb-sm-2">
                                <input type="text" id="txt_influenza" class="form-control" value="" placeholder="วิธีการตรวจ" runat="server" />
                            </div>
                            <div class="col-lg-4 col-sm-6 mx-auto my-auto text-center">
                                <input type="radio" id="rd_Influenza_N" name="rd_Influenza" value="Negative" runat="server" /> Negative / <input type="radio" id="rd_Influenza_P" name="rd_Influenza" value="Positive" runat="server" /> Positive
                            </div>
                            <div class="col-lg-2 col-sm-3 mx-auto my-auto text-center">
                                <input type="checkbox" id="cb_flu_A" value="Flu A" runat="server" /> Flu A
                            </div>
                            <div class="col-lg-2 col-sm-3 mx-auto my-auto text-center">
                                <input type="checkbox" id="cb_flu_B" value="Flu A" runat="server" /> Flu B
                            </div>
                        </div>
                    </div>
                    <div class="row col-12 mx-auto my-2">
                        <div class="col-lg-4 col-sm-6 mx-auto">
                            ผลการตรวจ SARS-CoV-2 PCR
                        </div>
                        <div class="col-lg-8 col-sm-6 mx-auto text-left">
                            <input type="checkbox" id="cb_pcr_no" value="no" onclick="fn_pcr_no()" runat="server" /> ไม่เคยรับการตรวจ
                        </div>
                        <table id="table_pcr" style="width: 100%" border="1">
                            <tr>
                                <td style="width: 10%" class="text-center">ครั้งที่</td>
                                <td style="width: 20%" class="text-center">วันที่เก็บ</td>
                                <td style="width: 20%" class="text-center">ชนิดตัวอย่าง</td>
                                <td style="width: 20%" class="text-center">สถานที่ส่งตรวจ</td>
                                <td style="width: 30%" class="text-center">ผลตรวจ</td>
                            </tr>
                            <tr id="tr_pcr">
                                <td colspan="5">
                                    <table style="width: 100%">
                                        <asp:Label ID="lbl_PCR_table" Text="" runat="server"></asp:Label>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <a id="btn_pcr_add" class="col-12 btn btn-outline-info" onclick="fn_pcr_add()">+</a>
                                </td>
                                <td>
                                    <input type="date" id="date_pcr" value="" class="form-control" />
                                </td>
                                <td>
                                    <input type="text" id="txt_pcr_ex" value="" class="form-control" />
                                </td>
                                <td>
                                    <input type="text" id="txt_pcr_location" value="" class="form-control" />
                                </td>
                                <td>
                                    <div class="row col-12 mx-auto">
                                        <div class="col-lg-6 col-sm-12 mx-auto">
                                            <input type="radio" id="rd_pcr_y" name="rd_pcr" value="Detected" /> Detected
                                        </div>
                                        <div class="col-lg-6 col-sm-12 mx-auto">
                                            <input type="radio" id="rd_pcr_n" name="rd_pcr" value="Not detected" /> Not detected
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <div hidden="hidden">
                            <input type="text" id="txtH_pcr" value="" runat="server" />
                        </div>
                        <script>
                            var pcr_txt = document.getElementById('<%= txtH_pcr.ClientID %>');
                            var lblPcr = document.getElementById('<%= lbl_PCR_table.ClientID %>');

                            function fn_pcr_add() {
                                var pcr_date = document.getElementById('date_pcr');
                                var pcr_ex = document.getElementById('txt_pcr_ex');
                                var pcr_location = document.getElementById('txt_pcr_location');
                                var pcr_yn = '';
                                var pcr_y = document.getElementById('rd_pcr_y');
                                var pcr_n = document.getElementById('rd_pcr_n');
                                if (pcr_y.checked) {
                                    pcr_yn = pcr_y.value;
                                } else {
                                    pcr_yn = pcr_n.value;
                                }
                                var pcr_ar = pcr_txt.value;
                                if (pcr_ar != '') { pcr_ar = pcr_ar + '|'; }
                                pcr_ar = pcr_ar + pcr_date.value + ',' + pcr_ex.value + ',' + pcr_location.value + ',' + pcr_yn;
                                pcr_txt.value = pcr_ar;

                                lblPcr.innerHTML = fn_table_show('pcr',pcr_txt.value);
                            }

                            function fn_pcr_no() {
                                var cb_no = document.getElementById('<%= cb_pcr_no.ClientID %>');
                                var table = document.getElementById('table_pcr');
                                if (cb_no.checked) {
                                    table.setAttribute('hidden', 'hidden');
                                } else {
                                    table.removeAttribute('hidden');
                                }
                            }
                        </script>
                    </div>

                    <div class="row col-12 mx-auto my-2">
                        <div class="col-lg-4 col-sm-6 mx-auto">
                            ผลการตรวจ SARS-CoV-2 Antibody
                        </div>
                        <div class="col-lg-8 col-sm-6 mx-auto text-left">
                            <input type="checkbox" id="cb_antibody_no" value="no" onclick="fn_antibody_no()" runat="server" /> ไม่เคยรับการตรวจ
                        </div>
                        <table id="table_antibody" style="width: 100%" border="1">
                            <tr>
                                <td style="width: 10%" class="text-center">ครั้งที่</td>
                                <td style="width: 20%" class="text-center">วันที่เก็บ</td>
                                <td style="width: 20%" class="text-center">ชนิดตัวอย่าง</td>
                                <td style="width: 20%" class="text-center">สถานที่ส่งตรวจ</td>
                                <td style="width: 30%" class="text-center">ผลตรวจ</td>
                            </tr>
                            <tr id="tr_anti">
                                <td colspan="5">
                                    <table style="width: 100%">
                                        <asp:Label ID="lbl_antibody_table" Text="" runat="server"></asp:Label>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <a id="btn_Antibody_add" class="col-12 btn btn-outline-info" onclick="fn_anti_add()">+</a>
                                </td>
                                <td>
                                    <input type="date" id="date_antibody" value="" class="form-control" />
                                </td>
                                <td>
                                    <input type="text" id="txt_antibody_ex" value="" class="form-control" />
                                </td>
                                <td>
                                    <input type="text" id="txt_antibody_location" value="" class="form-control" />
                                </td>
                                <td>
                                    <%--<input type="text" id="txt_antibody_result" value="" class="form-control" />--%>
                                    <div class="row col-12 mx-auto">
                                        <div class="col-lg-6 col-sm-12 mx-auto">
                                            <input type="radio" id="rd_antibody_y" name="rd_antibody" value="Positive" /> Positive
                                        </div>
                                        <div class="col-lg-6 col-sm-12 mx-auto">
                                            <input type="radio" id="rd_antibody_n" name="rd_antibody" value="Negative" /> Negative
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div hidden="hidden">
                        <input type="text" id="txtH_antibody" value="" runat="server" />
                    </div>
                    <script>
                        var antibody_txt = document.getElementById('<%= txtH_antibody.ClientID %>');
                        var lblAnti = document.getElementById('<%= lbl_antibody_table.ClientID %>');

                        function fn_anti_add() {
                            var antibody_date = document.getElementById('date_antibody');
                            var antibody_ex = document.getElementById('txt_antibody_ex');
                            var antibody_location = document.getElementById('txt_antibody_location');
                            var antibody_result = '';
                            //var antibody_result = document.getElementById('txt_antibody_result').value;
                            var antibody_y = document.getElementById('rd_antibody_y');
                            var antibody_n = document.getElementById('rd_antibody_n');
                            if (antibody_y.checked) {
                                antibody_result = antibody_y.value;
                            } else {
                                antibody_result = antibody_n.value;
                            }
                            var antibody_ar = antibody_txt.value;
                            if (antibody_ar != '') { antibody_ar = antibody_ar + '|'; }
                            antibody_ar = antibody_ar + antibody_date.value + ',' + antibody_ex.value + ',' + antibody_location.value + ',' + antibody_result;
                            antibody_txt.value = antibody_ar;

                            lblAnti.innerHTML = fn_table_show('antibody',antibody_txt.value);
                        }

                        function fn_antibody_no() {
                            var cb_no = document.getElementById('<%= cb_antibody_no.ClientID %>');
                            var table = document.getElementById('table_antibody');
                            if (cb_no.checked) {
                                table.setAttribute('hidden','hidden');
                            } else {
                                table.removeAttribute('hidden');
                            }
                        }

                        
                        function fn_table_show(name,ar) {
                            if (ar != '') {
                                var table_ar = ar.split('|');
                                var html = '';
                                html = html + '<table style="width: 100%">';
                                html = html + '<tr>';
                                html = html + '<td style="width: 10%"></td>';
                                html = html + '<td style="width: 20%"></td>';
                                html = html + '<td style="width: 20%"></td>';
                                html = html + '<td style="width: 20%"></td>';
                                html = html + '<td style="width: 30%"></td>';
                                html = html + '</tr>';
                                for (var i = 0; i < table_ar.length; i++) {
                                    html = html + '<tr>';
                                    var no = i + 1;
                                    html = html + '<td><a class="col-12 btn btn-outline-info" onclick="fn_del_ar(\'' + name + '\',' + i + ')">' + no + '</a></td>';
                                    var table_val = table_ar[i].split(',');
                                    for (var j = 0; j < table_val.length; j++) {
                                        html = html + '<td>' + table_val[j] + '</td>';
                                    }
                                    html = html + '</tr>';
                                }
                                html = html + '</table>';
                                //alert(html);
                                return html;
                            }
                        }

                        function fn_del_ar(name, n) {
                            var ar = '';
                            if (name == 'pcr') {
                                ar = pcr_txt.value;
                            }
                            else {
                                ar = antibody_txt.value;
                            }
                            var val = ar.split('|');//.splice(n, 1);
                            var NewVal = '';
                            for (var i = 0; i < val.length; i++) {
                                if (i != n) {
                                    if (NewVal != '') { NewVal = NewVal + '|'; }
                                    NewVal = NewVal + val[i];
                                }
                            }
                            //alert(NewVal);
                            if (name == 'pcr') {
                                pcr_txt.value = NewVal;
                                lblPcr.innerHTML = fn_table_show('pcr', NewVal);
                            } else {
                                antibody_txt.value = NewVal;
                                lblAnti.innerHTML = fn_table_show('antibody', NewVal);
                            }
                        }

                        if (antibody_txt.value != '') {
                            lblAnti.innerHTML = fn_table_show('antibody',antibody_txt.value);
                        }
                        if (pcr_txt.value != '') {
                            lblPcr.innerHTML = fn_table_show('pcr',pcr_txt.value);
                        }
                    </script>

                    <%--<div class="col-12 mx-auto my-2">
                        <div class="row col-12 mx-auto">
                            <div class="col-6 mx-auto my-auto">
                                ชนิดของตัวอย่างที่ส่งตรวจ
                                <input type="text" id="txt_influenza_type" class="form-control" value="" placeholder="ชนิดของตัวอย่างที่ส่งตรวจ" runat="server" />
                            </div>
                            <div class="row col-6 mx-auto my-auto">
                                <div class="col-4 mx-auto my-auto text-right">วันที่</div>
                                <div class="col-8 mx-auto my-auto"><input type="date" id="date_influenza" class="form-control" value="" runat="server" /></div>
                            </div>
                        </div>
                    </div>--%>
                    <div class="col-12 mx-auto my-2">
                        <div class="row col-12 mx-auto">
                            <div class="col-lg-3 col-sm-4 mx-auto my-auto">
                                ประเภทผู้ป่วย<br />
                                <input type="checkbox" id="cb_opd" value="opd" runat="server" onclick="fn_OI('opd')" /> ผู้ป่วยนอก
                                <input type="checkbox" id="cb_admit" value="admit" runat="server" onclick="fn_OI('ipd')" /> ผู้ป่วยใน
                                <script>
                                    function fn_OI(val) {
                                        if (val == 'opd') {
                                            document.getElementById('<%= cb_admit.ClientID %>').checked = false;
                                        } else {
                                            document.getElementById('<%= cb_opd.ClientID %>').checked = false;
                                        }
                                    }
                                </script>
                            </div>
                            <div class="row col-4 mx-auto">
                                Admit วันที่
                                <input type="date" id="date_admit" class="form-control" value="" runat="server" />
                            </div>
                            <div class="col-lg-5 col-sm-4 mx-auto my-auto">
                                <input type="text" id="txt_diagnosis" class="form-control" value="" placeholder="การวินิจฉัยเบื้องต้น" runat="server" />
                            </div>
                        </div>
                    </div>
                    <div class="col-12 mx-auto my-2">
                        <div class="row col-12 mx-auto">
                            <div class="col-3 mx-auto">
                                การให้ยาต้านไวรัส
                            </div>
                            <div class="row col-4 mx-auto">
                                <div class="col-6 mx-auto text-center">
                                    <input type="radio" id="rd_antiviral_no" name="rd_antiviral" value="no" runat="server" onclick="fn_antiviral()" /> ไม่ให้
                                </div>
                                <div class="col-6 mx-auto text-center">
                                    <input type="radio" id="rd_antiviral_yes" name="rd_antiviral" value="yes" runat="server" onclick="fn_antiviral()" /> ให้
                                </div>
                            </div>
                            <div class="row col-5 mx-auto">
                                <div id="div_antiviral" class="row col-12 mx-auto" hidden="hidden">
                                    วันที่ได้รับยา Dose แรก
                                    <input type="date" id="date_antiviral" class="form-control" value="" runat="server" />
                                </div>
                            </div>
                            <script>
                                function fn_antiviral() {
                                    var rdAntiviral = document.getElementById('<%= rd_antiviral_yes.ClientID %>');
                                    var divAntiviral = document.getElementById('div_antiviral');
                                    if (rdAntiviral.checked) {
                                        divAntiviral.removeAttribute('hidden');
                                    }
                                    else {
                                        document.getElementById('<%= date_antiviral.ClientID %>').value = "";
                                        divAntiviral.setAttribute('hidden','hidden');
                                    }
                                }
                            </script>
                        </div>
                    </div>
                    <div class="row col-12 mx-auto my-2">
                        <div class="col-3 mx-auto text-left">
                            <input type="checkbox" id="cb_re" value="Remdesivir" runat="server" />Remdesivir
                        </div>
                        <div class="col-3 mx-auto text-left">
                            <input type="checkbox" id="cb_fa" value="Favipiravir" runat="server" />Favipiravir 
                        </div>
                        <div class="col-6 mx-auto text-left">
                            <input type="checkbox" id="cb_lori" value="Lopinavir/ritonavir" runat="server" />Lopinavir/ritonavir 
                        </div>
                        <div class="col-3 mx-auto text-left">
                            <input type="checkbox" id="cb_da" value="Darunavir" runat="server" />Darunavir  
                        </div>
                        <div class="col-3 mx-auto text-left">
                            <input type="checkbox" id="cb_ri" value="Ritonavir" runat="server" />Ritonavir   
                        </div>
                        <div class="col-6 mx-auto text-left">
                            <input type="checkbox" id="cb_chhy" value="Chloroquine/Hydroxychloroquine" runat="server" />Chloroquine/Hydroxychloroquine   
                        </div>
                        <div class="row col-12 mx-auto text-left">
                            <input type="checkbox" id="cb_other" value="Other" runat="server" />อื่น ๆ  
                            <input type="text" id="txt_cb_other" class="col-8 form-control" value="" placeholder="ระบุ" runat="server" />
                        </div>
                    </div>
                    <div class="col-12 mx-auto my-2">
                        <div class="row col-12 mx-auto">
                            <div class="col-12 mx-auto">
                                สถานะผู้ป่วย : 
                                <input type="radio" id="rd_pt_status_1" name="rd_pt_status" value="หาย" runat="server" onclick="fn_PTstatus()" /> หาย 
                                <input type="radio" id="rd_pt_status_2" name="rd_pt_status" value="ยังรักษาอยู่" runat="server" onclick="fn_PTstatus()" /> ยังรักษาอยู่ 
                                <input type="radio" id="rd_pt_status_3" name="rd_pt_status" value="เสียชีวิต" runat="server" onclick="fn_PTstatus()" /> เสียชีวิต 
                                <input type="radio" id="rd_pt_status_4" name="rd_pt_status" value="ส่งตัว" runat="server" onclick="fn_PTstatus()" /> ส่งตัวไป รพ. 
                                <input type="radio" id="rd_pt_status_5" name="rd_pt_status" value="อื่นๆ" runat="server" onclick="fn_PTstatus()" /> อื่นๆ 
                            </div>
                            <div class="col-12 mx-auto my-auto">
                                <input type="text" id="txt_pt_status_4" value="" class="form-control" placeholder="ชื่อโรงพยาบาล" runat="server" hidden="hidden" />
                                <input type="text" id="txt_pt_status_5" value="" class="form-control" placeholder="ระบุ" runat="server" hidden="hidden" />
                            </div>
                            <script>
                                function fn_PTstatus() {
                                    var rdptStstaus4 = document.getElementById('<%= rd_pt_status_4.ClientID %>');
                                    var rdptStstaus5 = document.getElementById('<%= rd_pt_status_5.ClientID %>');
                                    var txtptStstaus4 = document.getElementById('<%= txt_pt_status_4.ClientID %>');
                                    var txtptStstaus5 = document.getElementById('<%= txt_pt_status_5.ClientID %>');

                                    if (rdptStstaus4.checked) {
                                        txtptStstaus4.removeAttribute('hidden');
                                    }
                                    else {
                                        txtptStstaus4.setAttribute('hidden', 'hidden');
                                        txtptStstaus4.value = "";
                                    }
                                    if (rdptStstaus5.checked) {
                                        txtptStstaus5.removeAttribute('hidden');
                                    }
                                    else {
                                        txtptStstaus5.setAttribute('hidden', 'hidden');
                                        txtptStstaus5.value = "";
                                    }
                                }
                            </script>
                        </div>
                    </div>
                </div>

                <hr class="col-10 mx-auto my-2 bg-gradient-mix" />

            </div>

            <!-- DIV 3 ---------------------------------------------- -->
            <div id="div_3" class="row col-12 mx-auto my-5" runat="server" visible="false">
                <div class="col-12 mx-auto">
                    3. ประวัติการได้รับวัคซีนป้องกันโรคติดเชื้อไวรัสโคโรนา 2019
                </div>
                <hr class="col-9 bg-info mx-auto" />
                <div class="row col-12 mx-auto">
                    <input type="radio" id="rd_neverVac" name="rd_Vac" value="ไม่เคยได้รับ" runat="server" /> <span class="my-auto">ไม่เคยได้รับ&nbsp;</span> 
                    <input type="radio" id="rd_havebeenVac" name="rd_Vac" value="เคยได้รับ" runat="server" /> <span class="my-auto">เคยได้รับ</span> 
                    <input type="text" id="txtH_VacCovid" value="ไม่เคยได้รับ" runat="server" hidden="hidden" />
                    <span class="my-auto">&nbsp;&nbsp;สมุดบันทึกหรือหลักฐานการได้รับวัคซีนหรือไม่</span> 
                    <span class="my-auto">&nbsp;&nbsp;(</span><input type="radio" id="rd_bookVac_yes" name="rd_bookVac" value="yes" runat="server" /><span class="my-auto">) มี</span> 
                    <span class="my-auto">&nbsp;&nbsp;(</span><input type="radio" id="rd_bookVac_no" name="rd_bookVac" value="no" runat="server" /><span class="my-auto">) ไม่มี</span> 
                    <input type="text" id="txtH_VacCovidBook" value="no" runat="server" hidden="hidden" />
                </div>
                <script>
                    var txthVacCovid = document.getElementById('<%= txtH_VacCovid.ClientID %>');
                    var rdneverVac = document.getElementById('<%= rd_neverVac.ClientID %>');
                    var rdhavebeenVac = document.getElementById('<%= rd_havebeenVac.ClientID %>');

                    var txthVacCovidBook = document.getElementById('<%= txtH_VacCovidBook.ClientID %>');
                    var rdbookVacyes = document.getElementById('<%= rd_bookVac_yes.ClientID %>');
                    var rdbookVacno = document.getElementById('<%= rd_bookVac_no.ClientID %>');

                    if (txthVacCovid.value == 'ไม่เคยได้รับ') {
                        rdneverVac.checked = true;
                        rdhavebeenVac.checked = false;
                        rdbookVacyes.checked = false;
                        rdbookVacno.checked = true;
                    } else {
                        rdneverVac.checked = false;
                        rdhavebeenVac.checked = true;

                        if (txthVacCovidBook.value == 'no') {
                            rdbookVacno.checked = true;
                            rdbookVacyes.checked = false;
                        } else {
                            rdbookVacno.checked = false;
                            rdbookVacyes.checked = true;
                        }
                    }
                </script>
                <div class="row col-12 mx-auto">
                    ครั้งที่ 1 วันที่ได้รับ <input type="date" id="date_Vac1" class="col-3 form-control" value="" runat="server" /> <input type="text" id="txt_nameVac1" class="col-3 form-control" placeholder="ชื่อวัคซีน" value="" runat="server" /> <input type="text" id="txt_locationVac1" class="col-3 form-control" placeholder="สถานที่ได้รับ" value="" runat="server" />
                </div>
                <div class="row col-12 mx-auto">
                    ครั้งที่ 2 วันที่ได้รับ <input type="date" id="date_Vac_2" class="col-3 form-control" value="" runat="server" /> <input type="text" id="txt_nameVac_2" class="col-3 form-control" placeholder="ชื่อวัคซีน" value="" runat="server" /> <input type="text" id="txt_locationVac_2" class="col-3 form-control" placeholder="สถานที่ได้รับ" value="" runat="server" />
                </div>
                <hr class="col-10 mx-auto mb-5 bg-gradient-mix" />
                <div class="col-12 mx-auto">
                    4. ประวัติเสี่ยง
                </div>
                <hr class="col-9 bg-info mx-auto" />
                <div class="row col-12 mx-auto">
                    <div class="col-8 mx-auto my-auto">
                        <i class="ti-control-record"></i> ช่วง 14 วันก่อนป่วยได้อาศัยอยู่หรือเดินทางมาจากพื้นที่ที่มีการระบาด
                        <input type="text" id="txt_yes_4" class="form-control" value="" placeholder="ระบุ" runat="server" hidden="hidden" />
                    </div>
                    <div id="div_rd_4" class="row col-4 mx-auto my-auto" runat="server">
                        <div class="col-6 mx-auto text-center">
                            <input type="radio" id="rd_no_4" name="rd_4" value="no" runat="server" onclick="fn_radio4()" /> ไม่ใช่
                        </div>
                        <div class="col-6 mx-auto text-center">
                            <input type="radio" id="rd_yes_4" name="rd_4" value="yes" runat="server" onclick="fn_radio4()" /> ใช่
                        </div>
                    </div>
                    <script>
                        function fn_radio4() {
                            var txt4 = document.getElementById('<%= txt_yes_4.ClientID %>');
                            var rd4 = document.getElementById('<%= rd_yes_4.ClientID %>');
                            if (rd4.checked) {
                                txt4.removeAttribute('hidden');
                            } else {
                                txt4.setAttribute('hidden', 'hidden');
                                txt4.value = '';
                            }
                        }
                        fn_radio4();
                    </script>
                </div>
                <hr class="col-9 bg-info mx-auto" />
                <div class="row col-12 mx-auto">
                    <div class="col-12 mx-auto my-auto">
                        เดินทางเข้าประเทศเมื่อวันที่ 
                    </div>
                    <div class="col-4 mx-auto">
                        <input type="date" id="date_travel" class="form-control" value="" runat="server" onkeyup="fn_travel()" onchange="fn_travel()" />
                    </div>
                    <div class="col-8 mx-auto">
                        <div id="div_travel" class="row col-12 mx-auto" runat="server" hidden="hidden">
                            <div class="col-6 mx-auto">
                                <input type="text" id="txt_travel_airline" class="form-control" value="" placeholder="โดยสายการบิน" runat="server" />
                            </div>
                            <div class="col-3 mx-auto">
                                <input type="text" id="txt_travel_flight" class="form-control" value="" placeholder="เที่ยวบินที่" runat="server" />
                            </div>
                            <div class="col-3 mx-auto">
                                <input type="text" id="txt_travel_seatnumber" class="form-control" value="" placeholder="เลขที่นั่ง" runat="server" />
                            </div>
                        </div>
                    </div>
                    <script>
                        function fn_travel() {
                            var datetravel = document.getElementById('<%= date_travel.ClientID %>');
                            var divtravel = document.getElementById('<%= div_travel.ClientID %>');
                            if (datetravel.value != '') {
                                divtravel.removeAttribute('hidden');
                            }
                            else {
                                document.getElementById('<%= txt_travel_airline.ClientID %>').value = '';
                                document.getElementById('<%= txt_travel_flight.ClientID %>').value = '';
                                document.getElementById('<%= txt_travel_seatnumber.ClientID %>').value = '';
                                divtravel.setAttribute('hidden', 'hidden');
                            }
                        }
                        fn_travel();
                    </script>
                </div>
                <hr class="col-9 bg-info mx-auto" />
                <div class="row col-12 mx-auto">
                    <div class="col-8 mx-auto my-auto">
                        <i class="ti-control-record"></i> ช่วง 14 วันก่อนป่วยได้เข้ารับการรักษาหรือเยี่ยมผู้ป่วยในโรงพยาบาลของพื้นที่ที่มีการระบาด
                    </div>
                    <div id="div_rd_6" class="row col-4 mx-auto my-auto" runat="server">
                        <div class="col-6 mx-auto text-center">
                            <input type="radio" id="rd_no_6" name="rd_6" value="no" runat="server" /> ไม่ใช่
                        </div>
                        <div class="col-6 mx-auto text-center">
                            <input type="radio" id="rd_yes_6" name="rd_6" value="yes" runat="server" /> ใช่
                        </div>
                    </div>
                </div>
                <hr class="col-9 bg-info mx-auto" />
                <div class="row col-12 mx-auto">
                    <div class="col-8 mx-auto my-auto">
                        <i class="ti-control-record"></i> ช่วง 14 วันก่อนป่วยได้ดูแลหรือสัมผัสใกล้ชิดกับผู้ป่วยอาการคล้ายไข้หวัดใหญ่หรือปอดอักเสบ
                    </div>
                    <div id="div_rd_5" class="row col-4 mx-auto my-auto" runat="server">
                        <div class="col-6 mx-auto text-center">
                            <input type="radio" id="rd_no_5" name="rd_5" value="no" runat="server" /> ไม่ใช่
                        </div>
                        <div class="col-6 mx-auto text-center">
                            <input type="radio" id="rd_yes_5" name="rd_5" value="yes" runat="server" /> ใช่
                        </div>
                    </div>
                </div>
                <hr class="col-9 bg-info mx-auto" />
                <div class="row col-12 mx-auto">
                    <div class="col-8 mx-auto my-auto">
                        <i class="ti-control-record"></i> ช่วง 14 วันก่อนป่วยมีประวัติสัมผัสกับผู้ป่วยยืนยันโรคติดเชื้อไวรัสโคโรนา 2019
                        <input type="text" id="txt_yes_10" class="form-control" value="" placeholder="ระบุ" runat="server" hidden="hidden" />
                    </div>
                    <div id="div_rd_10" class="row col-4 mx-auto my-auto" runat="server">
                        <div class="col-6 mx-auto text-center">
                            <input type="radio" id="rd_no_10" name="rd_10" value="no" runat="server" onclick="fn_radio10()" /> ไม่ใช่
                        </div>
                        <div class="col-6 mx-auto text-center">
                            <input type="radio" id="rd_yes_10" name="rd_10" value="yes" runat="server" onclick="fn_radio10()" /> ใช่
                        </div>
                    </div>
                    <script>
                        function fn_radio10() {
                            var txt10 = document.getElementById('<%= txt_yes_10.ClientID %>');
                            var rd10 = document.getElementById('<%= rd_yes_10.ClientID %>');
                            if (rd10.checked) {
                                txt10.removeAttribute('hidden');
                            } else {
                                txt10.setAttribute('hidden', 'hidden');
                                txt10.value = '';
                            }
                        }
                        fn_radio10();
                    </script>
                </div>
                <hr class="col-9 bg-info mx-auto" />
                <div class="row col-12 mx-auto">
                    <div class="col-8 mx-auto my-auto">
                        <i class="ti-control-record"></i> ช่วง 14 วันก่อนป่วยประกอบอาชีพที่สัมผัสใกล้ชิดกับนักท่องเที่ยวต่างชาติหรือแรงงานต่างชาติ 
                    </div>
                    <div id="div_rd_11" class="row col-4 mx-auto my-auto" runat="server">
                        <div class="col-6 mx-auto text-center">
                            <input type="radio" id="rd_no_11" name="rd_11" value="no" runat="server" /> ไม่ใช่
                        </div>
                        <div class="col-6 mx-auto text-center">
                            <input type="radio" id="rd_yes_11" name="rd_11" value="yes" runat="server" /> ใช่
                        </div>
                    </div>
                </div>
                <hr class="col-9 bg-info mx-auto" />
                <div class="row col-12 mx-auto">
                    <div class="col-8 mx-auto my-auto">
                        <i class="ti-control-record"></i> ช่วง 14 วันก่อนป่วยมีประวัติเดินทางไปในสถานที่ที่มีคนหนาแน่น เช่น ผับ สนามมวย ระบุ
                        <input type="text" id="txt_yes_12" class="form-control" value="" placeholder="ระบุ" runat="server" hidden="hidden" />
                    </div>
                    <div id="div_rd_12" class="row col-4 mx-auto my-auto" runat="server">
                        <div class="col-6 mx-auto text-center">
                            <input type="radio" id="rd_no_12" name="rd_12" value="no" runat="server" onclick="fn_radio12()" /> ไม่ใช่
                        </div>
                        <div class="col-6 mx-auto text-center">
                            <input type="radio" id="rd_yes_12" name="rd_12" value="yes" runat="server" onclick="fn_radio12()" /> ใช่
                        </div>
                    </div>
                    <script>
                        function fn_radio12() {
                            var txt12 = document.getElementById('<%= txt_yes_12.ClientID %>');
                            var rd12 = document.getElementById('<%= rd_yes_12.ClientID %>');
                            if (rd12.checked) {
                                txt12.removeAttribute('hidden');
                            } else {
                                txt12.setAttribute('hidden', 'hidden');
                                txt12.value = '';
                            }
                        }
                        fn_radio12();
                    </script>
                </div>
                <hr class="col-9 bg-info mx-auto" />
                <div class="row col-12 mx-auto">
                    <div class="col-8 mx-auto my-auto">
                        <i class="ti-control-record"></i> เป็นผู้ป่วยอาการทางเดินหายใจหรือปอดอักเสบเป็นกลุ่มก้อน
                    </div>
                    <div id="div_rd_9" class="row col-4 mx-auto my-auto" runat="server">
                        <div class="col-6 mx-auto text-center">
                            <input type="radio" id="rd_no_9" name="rd_9" value="no" runat="server" /> ไม่ใช่
                        </div>
                        <div class="col-6 mx-auto text-center">
                            <input type="radio" id="rd_yes_9" name="rd_9" value="yes" runat="server" /> ใช่
                        </div>
                    </div>
                </div>
                <hr class="col-9 bg-info mx-auto" />
                <div class="row col-12 mx-auto">
                    <div class="col-8 mx-auto my-auto">
                        <i class="ti-control-record"></i> เป็นผู้ป่วยปอดอักเสบรุนแรงหรือเสียชีวิตที่หาสาเหตุไม่ได้ 
                    </div>
                    <div id="div_rd_13" class="row col-4 mx-auto my-auto" runat="server">
                        <div class="col-6 mx-auto text-center">
                            <input type="radio" id="rd_no_13" name="rd_13" value="no" runat="server" /> ไม่ใช่
                        </div>
                        <div class="col-6 mx-auto text-center">
                            <input type="radio" id="rd_yes_13" name="rd_13" value="yes" runat="server" /> ใช่
                        </div>
                    </div>
                </div>
                <hr class="col-9 bg-info mx-auto" />
                <div class="row col-12 mx-auto">
                    <div class="col-8 mx-auto my-auto">
                        <i class="ti-control-record"></i> เป็นบุคลากรทางการแพทย์และสาธารณสุขหรือเจ้าหน้าที่ห้องปฏิบัติการ
                    </div>
                    <div id="div_rd_8" class="row col-4 mx-auto my-auto" runat="server">
                        <div class="col-6 mx-auto text-center">
                            <input type="radio" id="rd_no_8" name="rd_8" value="no" runat="server" /> ไม่ใช่
                        </div>
                        <div class="col-6 mx-auto text-center">
                            <input type="radio" id="rd_yes_8" name="rd_8" value="yes" runat="server" /> ใช่
                        </div>
                    </div>
                </div>
                <hr class="col-9 bg-info mx-auto" />
                <div class="row col-12 mx-auto">
                    <div class="col-2 mx-auto my-auto">
                        <i class="ti-control-record"></i> อื่นๆ
                    </div>
                    <div class="col-10 mx-auto my-auto">
                        <input type="text" id="txt_other" class="form-control" value="" placeholder="ระบุ" runat="server" />
                    </div>
                </div>
                <!-- ---------------------------------------------------------------------------------------------------------------- -->
                <%--<hr class="col-9 bg-info mx-auto" />
                <div class="row col-12 mx-auto">
                    <div class="col-8 mx-auto my-auto">
                        <i class="ti-control-record"></i> ช่วง 14 วันก่อนป่วยได้มีการสัมผัสกับสัตว์ปีก
                    </div>
                    <div id="div_rd_1" class="row col-4 mx-auto my-auto" runat="server">
                        <div class="col-6 mx-auto text-center">
                            <input type="radio" id="rd_no_1" name="rd_1" value="no" runat="server" /> ไม่ใช่
                        </div>
                        <div class="col-6 mx-auto text-center">
                            <input type="radio" id="rd_yes_1" name="rd_1" value="yes" runat="server" /> ใช่
                        </div>
                    </div>
                </div>
                <hr class="col-9 bg-info mx-auto" />
                <div class="row col-12 mx-auto">
                    <div class="col-8 mx-auto my-auto">
                        <i class="ti-control-record"></i> ช่วง 14 วันก่อนป่วยได้มีการสัมผัสโดยตรงกับสัตว์เลี้ยงลูกด้วยนมอื่นๆ หรือไม่
                        <input type="text" id="txt_yes_2" class="form-control" value="" placeholder="ระบุชนิดสัตว์" runat="server" hidden="hidden" />
                    </div>
                    <div id="div_rd_2" class="row col-4 mx-auto my-auto" runat="server">
                        <div class="col-6 mx-auto text-center">
                            <input type="radio" id="rd_no_2" name="rd_2" value="no" runat="server" onclick="fn_radio2()" /> ไม่ใช่
                        </div>
                        <div class="col-6 mx-auto text-center">
                            <input type="radio" id="rd_yes_2" name="rd_2" value="yes" runat="server" onclick="fn_radio2()" /> ใช่
                        </div>
                    </div>
                    <script>
                        function fn_radio2() {
                            var txt2 = document.getElementById('<%= txt_yes_2.ClientID %>');
                            var rd2 = document.getElementById('<%= rd_yes_2.ClientID %>');
                            if (rd2.checked) {
                                txt2.removeAttribute('hidden');
                            } else {
                                txt2.setAttribute('hidden','hidden');
                            }
                        }
                        fn_radio2();
                    </script>
                </div>
                <hr class="col-9 bg-info mx-auto" />
                <div class="row col-12 mx-auto">
                    <div class="col-8 mx-auto my-auto">
                        <i class="ti-control-record"></i> ช่วง 14 วันก่อนป่วยไปตลาดค้าสัตว์ปีก/สัตว์ป่า/สัตว์เลี้ยงลูกด้วยนม/อาหารทะเล หรือไม่
                        <input type="text" id="txt_yes_3" class="form-control" value="" placeholder="ระบุ" runat="server" hidden="hidden" />
                    </div>
                    <div id="div_rd_3" class="row col-4 mx-auto my-auto" runat="server">
                        <div class="col-6 mx-auto text-center">
                            <input type="radio" id="rd_no_3" name="rd_3" value="no" runat="server" onclick="fn_radio3()" /> ไม่ใช่
                        </div>
                        <div class="col-6 mx-auto text-center">
                            <input type="radio" id="rd_yes_3" name="rd_3" value="yes" runat="server" onclick="fn_radio3()" /> ใช่
                        </div>
                    </div>
                    <script>
                        function fn_radio3() {
                            var txt3 = document.getElementById('<%= txt_yes_3.ClientID %>');
                            var rd3 = document.getElementById('<%= rd_yes_3.ClientID %>');
                            if (rd3.checked) {
                                txt3.removeAttribute('hidden');
                            } else {
                                txt3.setAttribute('hidden','hidden');
                            }
                        }
                        fn_radio3();
                    </script>
                </div>
                <hr class="col-9 bg-info mx-auto" />
                <div class="row col-12 mx-auto">
                    <div class="col-8 mx-auto my-auto">
                        <i class="ti-control-record"></i> เป็นผู้ป่วยปอดอักเสบรุนแรงหรือเสียชีวิตที่หาสาเหตุไม่ได้
                    </div>
                    <div id="div_rd_7" class="row col-4 mx-auto my-auto" runat="server">
                        <div class="col-6 mx-auto text-center">
                            <input type="radio" id="rd_no_7" name="rd_7" value="no" runat="server" /> ไม่ใช่
                        </div>
                        <div class="col-6 mx-auto text-center">
                            <input type="radio" id="rd_yes_7" name="rd_7" value="yes" runat="server" /> ใช่
                        </div>
                    </div>
                </div>--%>
                <!-- ---------------------------------------------------------------------------------------------------------------- -->
                
                <hr class="col-10 mx-auto mb-5 bg-gradient-mix" />

                <div class="col-12 mx-auto">
                    5. รายละเอียดเหตุการณ์ ประวัติเสี่ยงต่อการติดเชื้อ ก่อนเริ่มป่วย
                    <textarea id="txt_History" runat="server" class="form-control" rows="5"></textarea>
                </div>

                <hr class="col-10 mx-auto my-2 bg-gradient-mix" />

            </div>

            <div class="col-12 mx-auto mb-5 text-center">
                <button id="btn_submit_1" class="btn btn-outline-light" onserverclick="btn_submit_1_ServerClick" runat="server" visible="true">บันทึก <i class="ti-save ti-2x"></i></button>
                <button id="btn_submit_2" class="btn btn-outline-light" onserverclick="btn_submit_2_ServerClick" runat="server" visible="false">บันทึก <i class="ti-save ti-2x"></i></button>
                <button id="btn_submit_3" class="btn btn-outline-light" onserverclick="btn_submit_3_ServerClick" runat="server" visible="false">บันทึก <i class="ti-save ti-2x"></i></button>
                <button id="btn_submit_4" class="btn btn-outline-light" onserverclick="btn_submit_4_ServerClick" runat="server" visible="false">บันทึก <i class="ti-save ti-2x"></i></button>
            </div>

            <!-- DIV result ---------------------------------------------- -->
            <div id="div_result" class="row col-12 mx-auto my-5" runat="server" visible="false">
                <div class="col-12 mx-auto text-center h1">
                    หมายเลขเอกสารของท่านคือ
                </div>
                <div class="col-12 mx-auto text-center h1" style="text-shadow: 2px 2px 2px #000000;">
                    <asp:Label ID="lbl_docno" Text="" ForeColor="Yellow" runat="server"></asp:Label>
                </div>
                <div class="col-12 mx-auto text-center h3">
                    กรุณาเก็บหมายเลขนี้ไว้
                </div>
                <div class="col-12 mx-auto text-center h3">
                    เพื่อนำแจ้งแก่เจ้าหน้าที่โรงพยาบาลกรุงเทพระยอง
                </div>
                <div class="col-12 mx-auto text-right">
                    วันเวลาที่ลงทะเบียน : <asp:Label ID="lbl_dateadd" Text="" runat="server"></asp:Label>
                </div>
            </div>

        </div>
    </div>
    
    <div hidden="hidden">
        <input type="text" id="txt_key" value="" runat="server" />
        <input type="text" id="txt_step" value="" runat="server" />
    </div>
    <asp:Label ID="lbl_modal" Text="" runat="server"></asp:Label>

</asp:Content>
