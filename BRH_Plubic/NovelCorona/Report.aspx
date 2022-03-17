<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Report.aspx.cs" Inherits="BRH_Plubic.NovelCorona.Report" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>BRH Novel Corona Report</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <!-- Themify Icons -->
    <link rel="stylesheet" href="../css/themify-icons.css">
    <style>
        .TablePrint {
            width: 21cm; 
            /*height: 29.7cm;*/
            margin-top: 0;
            margin-left: auto; 
            margin-right: auto;
        }
        .textDetail {
            font-size: 12px;
        }
        .textTopic {
            font-size: 14px;
        }
        .DotUnder {
            border-bottom:black 1px dotted;
        }
    </style>
    <script>
        function fn_THdate(txt) {
            // txt = yyyy-MM-dd
            var THdate = '';
            if (txt != '') {
                var ar = txt.split('-');
                var year = parseInt(ar[0]) + parseInt(543);
                THdate = ar[2] + '/' + ar[1] + '/' + year;
            }
            document.write(THdate);
        }

        function fn_CByn(str, val) {
            var html = '';
            if (str == val) {
                html = '<i class="ti-check-box"></i>';
            } else {
                html = '<i class="ti-control-stop"></i>';
            }
            document.write(html);
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div id="div_reporter" class="row col-12 mx-auto" runat="server" style="position: absolute; top: 20%;">
            <div class="col-12 mx-auto my-5 text-center h3">
                กรุณากรอกข้อมูลผู้รายงาน (สำหรับเจ้าหน้าที่)
            </div>
            <div class="col-lg-4 col-sm-12 mx-auto my-2">
                <input type="text" id="txt_reporter" class="form-control" value="" placeholder="ชื่อผู้รายงาน" runat="server" />
            </div>
            <div class="col-lg-4 col-sm-12 mx-auto my-2">
                <input type="text" id="txt_reporterdept" class="form-control" value="" placeholder="หน่วยงาน" runat="server" />
            </div>
            <div class="col-lg-4 col-sm-12 mx-auto my-2">
                <input type="text" id="txt_reportertel" class="form-control" value="" placeholder="โทรศัพท์" runat="server" />
            </div>
            <div class="col-12 mx-auto my-5 text-center">
                <button id="btn_reporter" class="btn btn-outline-primary" runat="server" onserverclick="btn_reporter_ServerClick">Submit <i class="ti-save"></i></button>
            </div>
        </div>
        <div id="div_report" class="col-12 mx-auto mx-auto" runat="server" visible="false">
            <asp:ListView ID="LV_novelcorona" runat="server">
                <LayoutTemplate>
                    <div class="col-12 mx-auto text-center h3">
                        Novel Corona Report
                    </div>
                    <div id="itemPlaceholder" runat="server">
                    </div>
                </LayoutTemplate>
                <ItemTemplate>
                    <div class="col-12 mx-auto mt-3">
                        <table id="printableArea" width="100%" class="TablePrint">
                            <tr>
                                <td colspan="2" class="text-center textTopic">
                                    <center><b>แบบรายงานผู้ป่วยโรคปอดอักเสบจากเชื้อไวรัสโคโรนาสายพันธุ์ใหม่ 2019</b></center>
                                    <hr style="background-color:black" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" class="textTopic"><b>1. ข้อมูลทั่วไป</b></td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                                <td>
                                    <!-- ------------------------ 1 ------------------------ -->
                                    <table width="100%" class="textDetail">
                                        <tr>
                                            <td>
                                                <script>
                                                    function fn_sex(val) {
                                                        html = '<i class="ti-control-stop"></i>';
                                                        if (val == 'male') {
                                                            html = '<i class="ti-check-box"></i> ชาย <i class="ti-control-stop"></i> หญิง';
                                                        }
                                                        else if (val == 'female'){
                                                            html = '<i class="ti-control-stop"></i> ชาย <i class="ti-check-box"></i> หญิง';
                                                        }
                                                        else {
                                                            html = '<i class="ti-control-stop"></i> ชาย <i class="ti-control-stop"></i> หญิง';
                                                        }
                                                        document.write(html);
                                                    }
                                                </script>
                                                ชื่อ - นามสกุล <span class="DotUnder"> <%# Eval("nc_fname") %> <%# Eval("nc_lname") %> </span>
                                                เพศ <script> fn_sex('<%# Eval("nc_sex") %>'); </script>
                                                อายุ <span class="DotUnder"> <%# Eval("nc_ageYear") %> </span> ปี <span class="DotUnder"> <%# Eval("nc_ageMonth") %> </span> เดือน
                                                </span> สัญชาติ <span class="DotUnder"> <%# Eval("nc_nationality") %> </span> เชื้อชาติ <span class="DotUnder"> <%# Eval("nc_race") %> </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                กรณีเพศหญิง 
                                                <script> fn_CByn('no','<%# Eval("nc_pregnant") %>'); </script>ไม่ได้ตั้งครรภ์ 
                                                <script> fn_CByn('yes','<%# Eval("nc_pregnant") %>'); </script>ตั้งครรภ์ 
                                                ครรภ์ที่ &nbsp;&nbsp;&nbsp;<%# Eval("nc_pregnant_num") %>&nbsp;&nbsp;&nbsp;</span> 
                                                อายุครรภ์ &nbsp;&nbsp;&nbsp;<%# Eval("nc_pregnant_week") %>&nbsp;&nbsp;&nbsp;</span>  สัปดาห์
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                อาชีพ (ระบุลักษณะงานที่ทำอย่างละเอียด เช่น บุคลากรทางการแพทย์ เจ้าหน้าที่ที่สัมผัสกับนักท่องเที่ยว) <span class="DotUnder"> <%# Eval("nc_career") %>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                สถานที่ทำงาน/ สถานศึกษา <span class="DotUnder"> <%# Eval("nc_workplace") %> </span> 
                                                เบอร์โทรศัพท์ที่ติดต่อได้ <span class="DotUnder"> <%# Eval("nc_adr_mobile") %> </span>
                                                เบอร์โทรศัพท์ที่ใช้ลงแอปพลิเคชัน “หมอชนะ” <span class="DotUnder"> <%# Eval("nc_telmorchana") %> </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                ที่อยู่ที่ติดตามได้ในประเทศไทย <i class="ti-check-box"></i> บ้าน <i class="ti-control-stop"></i> อื่นๆ ระบุ <span class="DotUnder"> <%# Eval("nc_baan") %> </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                เลขที่ <span class="DotUnder"> <%# Eval("nc_adr_number") %> </span> หมู่ที่ <span class="DotUnder"> <%# Eval("nc_adr_moo") %> </span> หมู่บ้าน <span class="DotUnder"> <%# Eval("nc_adr_baan") %> </span> ซอย <span class="DotUnder"> <%# Eval("nc_adr_alley") %> </span> ถนน <span class="DotUnder"> <%# Eval("nc_adr_road") %> </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                ตำบล <span class="DotUnder"> <%# Eval("nc_adr_subdistrict") %> </span> อำเภอ <span class="DotUnder"> <%# Eval("nc_adr_district") %> </span> จังหวัด <span class="DotUnder"> <%# Eval("nc_adr_province") %> </span>
                                            </td>
                                        </tr>
                                        <%--<tr>
                                            <td>
                                                โทรศัพท์บ้าน <span class="DotUnder"> <%# Eval("nc_adr_phone") %> </span> ที่ทำงาน <span class="DotUnder"> <%# Eval("nc_adr_tel") %> </span> มือถือ <span class="DotUnder"> <%# Eval("nc_adr_mobile") %> </span>
                                            </td>
                                        </tr>--%>
                                        <tr>
                                            <td>
                                                โรคประจำตัว <span class="DotUnder"> <%# Eval("nc_congenitaldisease") %> </span>
                                                การสูบบุหรี่ 
                                                <script> fn_CByn('ไม่เคยสูบ','<%# Eval("nc_smoking") %>'); </script>ไม่เคยสูบ 
                                                <script> fn_CByn('ยังคงสูบ','<%# Eval("nc_smoking") %>'); </script>ยังคงสูบ 
                                                <script> fn_CByn('เคยสูบแต่เลิกแล้ว','<%# Eval("nc_smoking") %>'); </script>เคยสูบแต่เลิกแล้ว
                                            </td>
                                        </tr>
                                    </table>
                                    <!-- ------------------------ 1 ------------------------ -->
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" class="textTopic"><br /><b>2. ข้อมูลทางคลินิก</b></td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                                <td>
                                    <table width="100%" class="textDetail">
                                        <tr>
                                            <td>
                                                วันที่เริ่มป่วย (วัน/เดือน/ปี) <span class="DotUnder">&nbsp;&nbsp;&nbsp;<script>fn_THdate('<%# Eval("ncc_whensick", "{0:yyyy-MM-dd}") %>');</script>&nbsp;&nbsp;&nbsp;</span>
                                                วันที่เข้ารับการรักษาครั้งแรก (วัน/เดือน/ปี) <span class="DotUnder">&nbsp;&nbsp;&nbsp;<script> fn_THdate('<%# Eval("ncc_firstvisit", "{0:yyyy-MM-dd}") %>'); </script>&nbsp;&nbsp;&nbsp;</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                ชื่อสถานพยาบาลที่เข้ารับการรักษาครั้งแรก <span class="DotUnder">&nbsp;&nbsp;&nbsp;<%# Eval("ncc_firsthospital") %>&nbsp;&nbsp;&nbsp;</span> 
                                                จังหวัด <span class="DotUnder">&nbsp;&nbsp;&nbsp;<%# Eval("ncc_firsthospital_province") %>&nbsp;&nbsp;&nbsp;</span> 
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                ชื่อสถานพยาบาลที่เข้ารับการรักษาในปัจจุบัน <span class="DotUnder">&nbsp;&nbsp;&nbsp;<%# Eval("ncc_currenhospital") %>&nbsp;&nbsp;&nbsp;</span> 
                                                จังหวัด <span class="DotUnder">&nbsp;&nbsp;&nbsp;<%# Eval("ncc_currenhospital_province") %>&nbsp;&nbsp;&nbsp;</span> 
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                อาการและอาการแสดงในวันพบผู้ป่วย : 
                                                <script> fn_CByn('yes','<%# Eval("ncc_sick") %>'); </script>ไข้ 
                                                อุณหภูมิร่างกายแรกรับ <span class="DotUnder">&nbsp;&nbsp;&nbsp;<%# Eval("ncc_temperature") %>&nbsp;&nbsp;&nbsp;</span> <sup>o</sup>C
                                                O<sub>2</sub> Sat <span class="DotUnder">&nbsp;&nbsp;&nbsp;<%# Eval("ncc_o2sat") %>&nbsp;&nbsp;&nbsp;</span> %
                                                <script> fn_CByn('yes','<%# Eval("ncc_respirator") %>'); </script>ใส่เครื่องช่วยหายใจ
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <script>
                                                    function fn_CheckBox(val) {
                                                        html = '<i class="ti-control-stop"></i>';
                                                        if (val != '') {
                                                            html = '<i class="ti-check-box"></i>';
                                                        }
                                                        document.write(html);
                                                    }
                                                </script>
                                                <script>fn_CheckBox('<%# Eval("ncc_symptom_1") %>');</script> ไอ&nbsp;&nbsp;&nbsp;
                                                <script>fn_CheckBox('<%# Eval("ncc_symptom_2") %>');</script> เจ็บคอ&nbsp;&nbsp;&nbsp;
                                                <script>fn_CheckBox('<%# Eval("ncc_symptom_3") %>');</script> ปวดกล้ามเนื้อ&nbsp;&nbsp;&nbsp;
                                                <script>fn_CheckBox('<%# Eval("ncc_symptom_4") %>');</script> มีน้ำมูก&nbsp;&nbsp;&nbsp;
                                                <script>fn_CheckBox('<%# Eval("ncc_symptom_5") %>');</script> หายใจลำบาก&nbsp;&nbsp;&nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <script>fn_CheckBox('<%# Eval("ncc_symptom_6") %>');</script> ปวดศีรษะ&nbsp;&nbsp;&nbsp;
                                                <script>fn_CheckBox('<%# Eval("ncc_symptom_7") %>');</script> ถ่ายเหลว&nbsp;&nbsp;&nbsp;
                                                <script>fn_CheckBox('<%# Eval("ncc_symptom_8") %>');</script> จมูกไม่ได้กลิ่น&nbsp;&nbsp;&nbsp;
                                                <script>fn_CheckBox('<%# Eval("ncc_symptom_9") %>');</script> ลิ้นไม่รับรส&nbsp;&nbsp;&nbsp;
                                                <script>fn_CheckBox('<%# Eval("ncc_symptom_10") %>');</script> ตาแดง&nbsp;&nbsp;&nbsp;
                                                <script>fn_CheckBox('<%# Eval("ncc_symptom_11") %>');</script> ผื่น&nbsp;&nbsp;&nbsp;
                                                ตำแหน่ง <span class="DotUnder">&nbsp;&nbsp;&nbsp;<%# Eval("ncc_symptom_11_location") %>&nbsp;&nbsp;&nbsp;</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <script>fn_CheckBox('<%# Eval("ncc_symptomother") %>');</script> อื่นๆ 
                                                ระบุ <span class="DotUnder">&nbsp;&nbsp;&nbsp;<%# Eval("ncc_symptomother") %>&nbsp;&nbsp;&nbsp;</span>  &nbsp;&nbsp;&nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <script>
                                                    function fn_Xray(val) {
                                                        html = '';
                                                        if (val == 'ทำ') {
                                                            html = '<i class="ti-control-stop"></i> ไมได้ทำ <i class="ti-check-box"></i> ทำ';
                                                        }
                                                        else if (val == 'ไม่ทำ') {
                                                            html = '<i class="ti-check-box"></i> ไมได้ทำ <i class="ti-control-stop"></i> ทำ';
                                                        }
                                                        else {
                                                            html = '<i class="ti-control-stop"></i> ไมได้ทำ <i class="ti-control-stop"></i> ทำ';
                                                        }
                                                        document.write(html);
                                                    }
                                                </script>
                                                เอ็กซเรย์ปอด (ครั้งแรก) <span>&nbsp;&nbsp;&nbsp;<script> fn_Xray('<%# Eval("ncc_xray") %>'); </script>&nbsp;&nbsp;&nbsp;</span> 
                                                เมื่อวันที่ <span class="DotUnder">&nbsp;&nbsp;&nbsp;<script> fn_THdate('<%# Eval("ncc_xraydate", "{0:yyyy-MM-dd}") %>'); </script>&nbsp;&nbsp;&nbsp;</span> 
                                                ระบุผล <span class="DotUnder">&nbsp;&nbsp;&nbsp;<%# Eval("ncc_xrayresult") %>&nbsp;&nbsp;&nbsp;</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                CBC (ครั้งแรก) : วันที่ <span class="DotUnder">&nbsp;&nbsp;&nbsp;<script> fn_THdate('<%# Eval("ncc_cbc_date", "{0:yyyy-MM-dd}") %>'); </script>&nbsp;&nbsp;&nbsp;</span> 
                                                ผล Hb <span class="DotUnder">&nbsp;&nbsp;&nbsp;<%# Eval("ncc_cbc_hb") %>&nbsp;&nbsp;&nbsp;</span>
                                                mg% Hct <span class="DotUnder">&nbsp;&nbsp;&nbsp;<%# Eval("ncc_cbc_hct") %>&nbsp;&nbsp;&nbsp;</span> 
                                                % WBC <span class="DotUnder">&nbsp;&nbsp;&nbsp;<%# Eval("ncc_cbc_wbc") %>&nbsp;&nbsp;&nbsp;</span> 
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Platelet count <span class="DotUnder">&nbsp;&nbsp;&nbsp;<%# Eval("ncc_pc_x") %>&nbsp;&nbsp;&nbsp;</span> x10<sup>3</sup>
                                                N <span class="DotUnder">&nbsp;&nbsp;&nbsp;<%# Eval("ncc_pc_n") %>&nbsp;&nbsp;&nbsp;</span> % 
                                                L <span class="DotUnder">&nbsp;&nbsp;&nbsp;<%# Eval("ncc_pc_l") %>&nbsp;&nbsp;&nbsp;</span> % 
                                                Atyp lymph <span class="DotUnder">&nbsp;&nbsp;&nbsp;<%# Eval("ncc_pc_al") %>&nbsp;&nbsp;&nbsp;</span> % 
                                                Mono <span class="DotUnder">&nbsp;&nbsp;&nbsp;<%# Eval("ncc_pc_mn") %>&nbsp;&nbsp;&nbsp;</span> %
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                ผลการตรวจ Influenza test (ถ้ามี) วิธีการตรวจ <span class="DotUnder">&nbsp;&nbsp;&nbsp;<%# Eval("ncc_influenza_test") %>&nbsp;&nbsp;&nbsp;</span>
                                                <span class="DotUnder">&nbsp;&nbsp;&nbsp;<%# Eval("ncc_influenza") %>&nbsp;&nbsp;&nbsp;</span> 
                                                <script> fn_CheckBox('<%# Eval("ncc_flu_a") %>'); </script> Flu A 
                                                <script> fn_CheckBox('<%# Eval("ncc_flu_b") %>'); </script> Flu B
                                            </td>
                                        </tr>
                                        <%--<tr>
                                            <td>
                                                ชนิดของตัวอย่างที่ส่งตรวจ <span class="DotUnder">&nbsp;&nbsp;&nbsp;<%# Eval("ncc_influenza_type") %>&nbsp;&nbsp;&nbsp;</span> 
                                                วันที่ <span class="DotUnder">&nbsp;&nbsp;&nbsp;<script> fn_THdate('<%# Eval("ncc_influenza_date", "{0:yyyy-MM-dd}") %>'); </script>&nbsp;&nbsp;&nbsp;</span> 
                                            </td>
                                        </tr>--%>
                                        <script>
                                            function fn_table_show(ar) {
                                                if (ar != '') {
                                                    var html = '';
                                                    if (ar == 'no') {
                                                        html = '<span class="DotUnder">&nbsp;&nbsp;&nbsp;' + 'ไม่เคยรับการตรวจ' + '&nbsp;&nbsp;&nbsp;</span>';
                                                    } else {
                                                        var table_ar = ar.split('|');
                                                        
                                                        html = html + '<table style="width: 100%" border="1">';
                                                        html = html + '<tr>';
                                                        html = html + '<td style="width: 10%" class="text-center">ครั้งที่</td>';
                                                        html = html + '<td style="width: 20%" class="text-center">วันที่เก็บ</td>';
                                                        html = html + '<td style="width: 20%" class="text-center">ชนิดตัวอย่าง</td>';
                                                        html = html + '<td style="width: 20%" class="text-center">สถานที่ส่งตรวจ</td>';
                                                        html = html + '<td style="width: 30%" class="text-center">ผลตรวจ</td>';
                                                        html = html + '</tr>';
                                                        for (var i = 0; i < table_ar.length; i++) {
                                                            html = html + '<tr>';
                                                            var no = i + 1;
                                                            html = html + '<td>' + no + '</td>';
                                                            var table_val = table_ar[i].split(',');
                                                            for (var j = 0; j < table_val.length; j++) {
                                                                html = html + '<td>' + table_val[j] + '</td>';
                                                            }
                                                            html = html + '</tr>';
                                                        }
                                                        html = html + '</table>';
                                                        //alert(html);
                                                    }
                                                    document.write(html);
                                                }
                                            }
                                        </script>
                                        <tr>
                                            <td>
                                                ผลการตรวจ SARS-CoV-2 PCR
                                                <script> fn_table_show('<%# Eval("ncc_pcr_array") %>'); </script>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                ผลการตรวจ ATK <!--SARS-CoV-2 Antibody-->
                                                <script> fn_table_show('<%# Eval("ncc_antibody_array") %>'); </script>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                ประเภทผู้ป่วย 
                                                <script> fn_CheckBox('<%# Eval("ncc_opd") %>'); </script>ผู้ป่วยนอก 
                                                <script> fn_CheckBox('<%# Eval("ncc_admit") %>'); </script>ผู้ป่วยใน  
                                                Admit วันที่ <span class="DotUnder">&nbsp;&nbsp;&nbsp;<script> fn_THdate('<%# Eval("ncc_admit_date", "{0:yyyy-MM-dd}") %>'); </script>&nbsp;&nbsp;&nbsp;</span>
                                                การวินิจฉัยเบื้องต้น <span class="DotUnder">&nbsp;&nbsp;&nbsp;<%# Eval("ncc_diagnosis") %>&nbsp;&nbsp;&nbsp;</span> 
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <script>
                                                    function fn_antiviral(val) {
                                                        html = '';
                                                        if (val == 'yes') {
                                                            html = '<i class="ti-control-stop"></i> ไมให้ <i class="ti-check-box"></i> ให้';
                                                        }
                                                        else if (val == 'no') {
                                                            html = '<i class="ti-check-box"></i> ไม่ให้ <i class="ti-control-stop"></i> ให้';
                                                        }
                                                        else {
                                                            html = '<i class="ti-control-stop"></i> ไม่ให้ <i class="ti-control-stop"></i> ให้';
                                                        }
                                                        document.write(html);
                                                    }
                                                </script>
                                                การให้ยาต้านไวรัส <span>&nbsp;&nbsp;&nbsp;<script> fn_antiviral('<%# Eval("ncc_antiviral") %>'); </script>&nbsp;&nbsp;&nbsp;</span>
                                                วันที่ได้รับยา Dose แรก <span class="DotUnder">&nbsp;&nbsp;&nbsp;<script> fn_THdate('<%# Eval("ncc_antiviral_date", "{0:yyyy-MM-dd}") %>'); </script>&nbsp;&nbsp;&nbsp;</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <script> fn_CheckBox('<%# Eval("ncc_re") %>'); </script>Remdesivir&nbsp;&nbsp;&nbsp;
                                                <script> fn_CheckBox('<%# Eval("ncc_fa") %>'); </script>Favipiravir&nbsp;&nbsp;&nbsp;
                                                <script> fn_CheckBox('<%# Eval("ncc_lori") %>'); </script>Lopinavir/ritonavir&nbsp;&nbsp;&nbsp;
                                                <script> fn_CheckBox('<%# Eval("ncc_da") %>'); </script>Darunavir&nbsp;&nbsp;&nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <script> fn_CheckBox('<%# Eval("ncc_ri") %>'); </script>Ritonavir&nbsp;&nbsp;&nbsp;
                                                <script> fn_CheckBox('<%# Eval("ncc_chhy") %>'); </script>Chloroquine/Hydroxychloroquine&nbsp;&nbsp;&nbsp;
                                                <script> fn_CheckBox('<%# Eval("ncc_anti_other") %>'); </script>อื่น ๆ ระบุ <span class="DotUnder">&nbsp;&nbsp;&nbsp;<%# Eval("ncc_anti_other") %>&nbsp;&nbsp;&nbsp;</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <script>
                                                    function fn_PTstatus(val, fix) {
                                                        html = '<i class="ti-control-stop"></i>';
                                                        if (val == fix) {
                                                            html = '<i class="ti-check-box"></i>';
                                                        }
                                                        document.write(html);
                                                    }
                                                </script>
                                                สถานะผู้ป่วย 
                                                <script> fn_PTstatus('<%# Eval("ncc_pt_status") %>', 'หาย'); </script> หาย 
                                                <script> fn_PTstatus('<%# Eval("ncc_pt_status") %>', 'ยังรักษาอยู่'); </script> ยังรักษาอยู่ 
                                                <script> fn_PTstatus('<%# Eval("ncc_pt_status") %>', 'เสียชีวิต'); </script> เสียชีวิต 
                                                <script> fn_PTstatus('<%# Eval("ncc_pt_status") %>', 'ส่งตัว'); </script> ส่งตัวไป รพ. <span class="DotUnder">&nbsp;&nbsp;&nbsp;<%# Eval("ncc_pt_status_4") %>&nbsp;&nbsp;&nbsp;</span> 
                                                <script> fn_PTstatus('<%# Eval("ncc_pt_status") %>', 'อื่นๆ'); </script> อื่นๆ ระบุ <span class="DotUnder">&nbsp;&nbsp;&nbsp;<%# Eval("ncc_pt_status_5") %>&nbsp;&nbsp;&nbsp;</span> 
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" class="textTopic"><br /><b>3. ประวัติการได้รับวัคซีนป้องกันโรคติดเชื้อไวรัสโคโรนา 2019</b></td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                                <td>
                                    <table width="100%" class="textDetail">
                                        <tr>
                                            <td>
                                                <script> fn_CByn('ไม่เคยได้รับ','<%# Eval("nc_covidvaccine") %>'); </script> ไม่เคยได้รับ 
                                                <script> fn_CByn('เคยได้รับ','<%# Eval("nc_covidvaccine") %>'); </script> เคยได้รับ
                                                สมุดบันทึกหรือหลักฐานการได้รับวัคซีนหรือไม่ (<script> fn_CByn('yes','<%# Eval("nc_covidvaccine_book") %>'); </script>) มี (<script> fn_CByn('no','<%# Eval("nc_covidvaccine_book") %>'); </script>) ไม่มี 
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                ครั้งที่ 1 วันที่ได้รับ <span class="DotUnder">&nbsp;&nbsp;&nbsp;<script> fn_THdate('<%# Eval("nc_covidvaccine1_date", "{0:yyyy-MM-dd}") %>'); </script>&nbsp;&nbsp;&nbsp;</span> 
                                                ชื่อวัคซีน <span class="DotUnder">&nbsp;&nbsp;&nbsp;<%# Eval("nc_covidvaccine1_name") %>&nbsp;&nbsp;&nbsp;</span> 
                                                สถานที่ได้รับ <span class="DotUnder">&nbsp;&nbsp;&nbsp;<%# Eval("nc_covidvaccine1_location") %>&nbsp;&nbsp;&nbsp;</span> 
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                ครั้งที่ 2 วันที่ได้รับ <span class="DotUnder">&nbsp;&nbsp;&nbsp;<script> fn_THdate('<%# Eval("nc_covidvaccine2_date", "{0:yyyy-MM-dd}") %>'); </script>&nbsp;&nbsp;&nbsp;</span> 
                                                ชื่อวัคซีน <span class="DotUnder">&nbsp;&nbsp;&nbsp;<%# Eval("nc_covidvaccine2_name") %>&nbsp;&nbsp;&nbsp;</span> 
                                                สถานที่ได้รับ <span class="DotUnder">&nbsp;&nbsp;&nbsp;<%# Eval("nc_covidvaccine2_location") %>&nbsp;&nbsp;&nbsp;</span> 
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" class="textTopic"><br /><b>4. ประวัติเสี่ยง</b></td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                                <td>
                                    <script>
                                        function fn_CheckBox(val) {
                                            var html = '';
                                            if (val == 'no') {
                                                html = '<i class="ti-check-box"></i> ไม่ใช่ <i class="ti-control-stop"></i> ใช่';
                                            } else {
                                                html = '<i class="ti-control-stop"></i> ไม่ใช่ <i class="ti-check-box"></i> ใช่';
                                            }
                                            document.write(html);
                                        }
                                        function fn_RHval(val) {
                                            html = '';
                                            if (val != "no") {
                                                html = val;
                                            }
                                            document.write(html);
                                        }
                                    </script>
                                    <table width="100%" class="textDetail">
                                        <!-- ------------------------------------------------------------------------------------------- -->
                                        <tr>
                                            <td width="87%">
                                                <ul>
                                                  <li>ช่วง 14 วันก่อนป่วยได้อาศัยอยู่หรือเดินทางมาจากพื้นที่ที่มีการระบาด ระบุ
                                                      <span class="DotUnder"> <script> fn_RHval('<%# Eval("nc_rh_4") %>'); </script> </span>
                                                  </li>
                                                </ul>
                                            </td>
                                            <td  width="13%">
                                                <script> fn_CheckBox('<%# Eval("nc_rh_4") %>'); </script>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <div class="row col-12 mx-auto">
                                                    <div class="col-auto">
                                                        เดินทางเข้าประเทศเมื่อวันที่ <span class="DotUnder"> <script> fn_THdate('<%# Eval("nc_rh_travel_date", "{0:yyyy-MM-dd}") %>'); </script> </span> 
                                                    </div>
                                                    <div id="div_travle" class="col-auto" hidden="hidden">
                                                        โดยสายการบิน <span class="DotUnder"> <%# Eval("nc_rh_travel_airline") %> </span> 
                                                        เที่ยวบินที่ <span class="DotUnder"> <%# Eval("nc_rh_travel_flight") %> </span> 
                                                        เลขที่นั่ง <span class="DotUnder"> <%# Eval("nc_rh_travel_seatnumber") %> </span>
                                                    </div>
                                                </div>
                                                <br />
                                                <script>
                                                    var travelDate = '<%# Eval("nc_rh_travel_date") %>';
                                                    if (travelDate != '') {
                                                        document.getElementById('div_travle').removeAttribute('hidden');
                                                    }
                                                    else {
                                                        document.getElementById('div_travle').setAttribute('hidden', 'hidden');
                                                    }
                                                </script>
                                            </td>
                                        </tr>
                                        <!-- ------------------------------------------------------------------------------------------- -->
                                        <tr>
                                            <td>
                                                <ul>
                                                  <li>ช่วง 14 วันก่อนป่วยได้เข้ารับการรักษาหรือเยี่ยมผู้ป่วยในโรงพยาบาลของพื้นที่ที่มีการระบาด</li>
                                                </ul>
                                            </td>
                                            <td>
                                                <script> fn_CheckBox('<%# Eval("nc_rh_6") %>'); </script>
                                            </td>
                                        </tr>
                                        <!-- ------------------------------------------------------------------------------------------- -->
                                        <tr>
                                            <td>
                                                <ul>
                                                  <li>ช่วง 14 วันก่อนป่วยได้ดูแลหรือสัมผัสใกล้ชิดกับผู้ป่วยอาการคล้ายไข้หวัดใหญ่หรือปอดอักเสบ</li>
                                                </ul>
                                            </td>
                                            <td>
                                                <script> fn_CheckBox('<%# Eval("nc_rh_5") %>'); </script>
                                            </td>
                                        </tr>
                                        <!-- ------------------------------------------------------------------------------------------- -->
                                        <tr>
                                            <td>
                                                <ul>
                                                  <li>ช่วง 14 วันก่อนป่วยมีประวัติสัมผัสกับผู้ป่วยยืนยันโรคติดเชื้อไวรัสโคโรนา 2019
                                                      <span class="DotUnder"> <script> fn_RHval('<%# Eval("nc_rh_10") %>'); </script> </span>
                                                  </li>
                                                </ul>
                                            </td>
                                            <td>
                                                <script> fn_CheckBox('<%# Eval("nc_rh_10") %>'); </script>
                                            </td>
                                        </tr>
                                        <!-- ------------------------------------------------------------------------------------------- -->
                                        <tr>
                                            <td>
                                                <ul>
                                                  <li>ช่วง 14 วันก่อนป่วยประกอบอาชีพที่สัมผัสใกล้ชิดกับนักท่องเที่ยวต่างชาติหรือแรงงานต่างชาติ</li>
                                                </ul>
                                            </td>
                                            <td>
                                                <script> fn_CheckBox('<%# Eval("nc_rh_11") %>'); </script>
                                            </td>
                                        </tr>
                                        <!-- ------------------------------------------------------------------------------------------- -->
                                        <tr>
                                            <td>
                                                <ul>
                                                  <li>ช่วง 14 วันก่อนป่วยมีประวัติเดินทางไปในสถานที่ที่มีคนหนาแน่น เช่น ผับ สนามมวย ระบุ
                                                      <span class="DotUnder"> <script> fn_RHval('<%# Eval("nc_rh_12") %>'); </script> </span>
                                                  </li>
                                                </ul>
                                            </td>
                                            <td>
                                                <script> fn_CheckBox('<%# Eval("nc_rh_12") %>'); </script>
                                            </td>
                                        </tr>
                                        <!-- ------------------------------------------------------------------------------------------- -->
                                        <tr>
                                            <td>
                                                <ul>
                                                  <li>เป็นผู้ป่วยอาการทางเดินหายใจหรือปอดอักเสบเป็นกลุ่มก้อน</li>
                                                </ul>
                                            </td>
                                            <td>
                                                <script> fn_CheckBox('<%# Eval("nc_rh_9") %>'); </script>
                                            </td>
                                        </tr>
                                        <!-- ------------------------------------------------------------------------------------------- -->
                                        <tr>
                                            <td>
                                                <ul>
                                                  <li>เป็นผู้ป่วยปอดอักเสบรุนแรงหรือเสียชีวิตที่หาสาเหตุไม่ได้</li>
                                                </ul>
                                            </td>
                                            <td>
                                                <script> fn_CheckBox('<%# Eval("nc_rh_13") %>'); </script>
                                            </td>
                                        </tr>
                                        <!-- ------------------------------------------------------------------------------------------- -->
                                        <tr>
                                            <td>
                                                <ul>
                                                  <li>เป็นบุคลากรทางการแพทย์และสาธารณสุขหรือเจ้าหน้าที่ห้องปฏิบัติการ</li>
                                                </ul>
                                            </td>
                                            <td>
                                                <script> fn_CheckBox('<%# Eval("nc_rh_8") %>'); </script>
                                            </td>
                                        </tr>
                                        <!-- ------------------------------------------------------------------------------------------- -->
                                        <tr>
                                            <td colspan="2">
                                                <ul>
                                                  <li>อื่นๆ ระบุ
                                                      <span class="DotUnder"> <%# Eval("nc_rh_other") %> </span>
                                                  </li>
                                                </ul>
                                            </td>
                                        </tr>
                                        <!-- ------------------------------------------------------------------------------------------- -->
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" class="textTopic"><br /><b>5. รายละเอียดเหตุการณ์ ประวัติเสี่ยงต่อการติดเชื้อ ก่อนเริ่มป่วย</b></td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                                <td>
                                    <table width="100%" class="textDetail">
                                        <tr>
                                            <td>
                                                <span class="DotUnder">&nbsp;&nbsp;&nbsp;<%# Eval("nc_history") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> 
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div class="row col-12 mx-auto mt-5">
                                                    <div class="col-4 mx-auto">
                                                        <b>ผู้รายงาน</b> <span class="DotUnder">&nbsp;&nbsp;&nbsp; <%# Eval("ncc_reporter") %> &nbsp;&nbsp;&nbsp;</span>
                                                    </div>
                                                    <div class="col-4 mx-auto">
                                                        <b>หน่วยงาน</b> <span class="DotUnder">&nbsp;&nbsp;&nbsp; <%# Eval("ncc_reporterdept") %> &nbsp;&nbsp;&nbsp;</span>
                                                    </div>
                                                    <div class="col-4 mx-auto">
                                                        <b>โทรศัพท์</b> <span class="DotUnder">&nbsp;&nbsp;&nbsp; <%# Eval("ncc_reportertel") %> &nbsp;&nbsp;&nbsp;</span>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </div>
                </ItemTemplate>
            </asp:ListView>
            <div class="col-12 mx-auto my-5 text-center">
                <button id="btn_print" class="btn btn-outline-primary" onclick="printDiv()">PRINT <i class="ti-printer"></i></button>
            </div>
        </div>
        <asp:Label id="lbl_test" Text="" runat="server"></asp:Label>
        <script>
            var D = new Date();
            var Y = d.getFullYear();
            alert(Y);

            function AgeYear(DOB) {
               
            }
            function AgeMonth(DOB) {

            }

            function printDiv() {
                var printContents = document.getElementById("printableArea").innerHTML;
                var originalContents = document.body.innerHTML;
                document.body.innerHTML = printContents;
                window.print();
                document.body.innerHTML = originalContents;
            }
        </script>
    </form>
</body>
</html>
