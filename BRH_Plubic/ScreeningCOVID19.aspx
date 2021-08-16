<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ScreeningCOVID19.aspx.cs" Inherits="BRH_Plubic.ScreeningCOVID19" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">
    
    <asp:ScriptManager ID="ScriptManager_Master" runat="server"></asp:ScriptManager>

    <div class="col-7 mx-auto text-right">
        Language : <a href="#document" onclick="fn_translate('TH')">ไทย</a> | <a href="#document" onclick="fn_translate('EN')">English</a>
    </div>
    <div id="document" class="col-11 mx-auto section">

    <table width="100%" id="printableArea" runat="server" data-toggle="modal" data-target="#exampleModal" data-whatever="@mdo" style="width: 21cm; height: 29.7cm; margin-left: auto; margin-right: auto;" border="0">
      <tr>
           <td>
               <div class="text-center">
                   <b>
                       <label ID="lbl_subject_th">แบบคัดกรองความเสี่ยงต่อโรคโควิด -19 ก่อนเข้ารับการเก็บสิ่งส่งตรวจ</label>
                       <label ID="lbl_subject_en" hidden="hidden">Risk of COVID-19 infection before swap collecting screen form</label>
                   </b>
               </div>
           </td>       
      </tr>
      <tr>
          <td>
              <div class="text-right">
                  <label ID="lbl_date_th">วันที่</label><label ID="lbl_date_en" hidden="hidden">Date</label><asp:Label id="lbl_Date" ForeColor="Blue" Text="........" runat="server"></asp:Label>
                  <!-- Company ID  --> 
                  <input type="text" id="txt_cpid" value="BRH" runat="server" hidden="hidden" />
              </div>
          </td>
      </tr>
      <tr>
          <td>
              <div>
                <label ID="lbl_name_th">ข้าพเจ้า นาย/นาง/นางสาว</label><label ID="lbl_name_en" hidden="hidden">I Mr./Mrs./Miss</label><asp:Label id="lbl_name" ForeColor="Blue" Text="....................................................." runat="server"></asp:Label><br />
                <label ID="lbl_DOB_th">วัน เดือน ปี เกิด</label><label ID="lbl_DOB_en" hidden="hidden">Date of Birth</label><asp:Label id="lbl_DOB" ForeColor="Blue" Text="..........................................." runat="server"></asp:Label>
              </div>
          </td>
      </tr>
      <tr>
          <td>
            <label ID="lbl_caution_th">เพื่อเป็นการเฝ้าระวังการแพร่ระบาดของโรคโควิด-19 ซึ่งจะส่งผลกระทบต่อสุขภาพของผู้รับบริการ และบุคลากรทางการแพทย์ ข้าพเจ้าขอให้ข้อมูลดังนี้</label>
            <label ID="lbl_caution_en" hidden="hidden">In caution of COVID-19 spreading, which could affect the health of the patient and the medical personnel, I provide the information as follows;</label>
            <!-- -------------------------------- ตารางด้านใน -------------------------------- -->
            <table width="100%" border="1">
                <tr>
                    <td class="text-center" width="90%">
                        <label ID="lbl_infor_th">รายละเอียดข้อมูล</label><label ID="lbl_infor_en" hidden="hidden">Information</label>
                    </td>
                    <td width="5%">
                        <label ID="lbl_yes_th">ใช่</label>
                        <label ID="lbl_yes_en" hidden="hidden" hidden="hidden" >Yes</label>
                    </td>
                    <td width="5%">
                        <label ID="lbl_no_th">ไม่ใช่</label>
                        <label ID="lbl_no_en" hidden="hidden" hidden="hidden" >No</label>
                    </td>
                </tr> 
                <tr>
                    <td>
                        <label ID="lbl_1_th">1. ในช่วง 14 วันที่ผ่านมาข้าพเจ้าพักอยู่บ้าน โดยมิได้มีการเดินทางข้ามจังหวัด</label>
                        <label ID="lbl_1_en" hidden="hidden">1.	In the past 14 days, I have quarantined at my resident and have not traveled across the province.</label>>
                    </td>
                    <td>
                        <img src="~/images/check.png" style="width:38px; height:38px;" id="img_1y" runat="server" hidden="hidden" />
                        <asp:Image ID="img_0y" ImageUrl="~/images/check.png" runat="server" Visible="false" />
                    </td>
                    <td>
                        <img src="~/images/check.png" style="width:38px; height:38px;" id="img_1n" runat="server" hidden="hidden" />
                        <asp:Image ID="img_0n" ImageUrl="~/images/check.png" runat="server" Visible="false" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label ID="lbl_2_th">2. ในช่วง 14 วันที่ผ่านมา ข้าพเจ้ามิได้มีการใกล้ชิดหรือสัมผัสกับผู้ป่วยเข้าข่ายหรือยืนยันโรคติดเชื้อโควิด-19</label>
                        <label ID="lbl_2_en" hidden="hidden">2.	In the past 14 days, I have not been in close contact nor directly contacted anyone that is suspected or confirmed as COVID-19 infected patient.</label>
                    </td>
                    <td>
                        <img src="~/images/check.png" style="width:38px; height:38px;" id="img_2y" runat="server" hidden="hidden" />
                    </td>
                    <td>
                        <img src="~/images/check.png" style="width:38px; height:38px;" id="img_2n" runat="server" hidden="hidden" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label ID="lbl_3_th">3. ในช่วง 14 วันที่ผ่านมา ข้าพเจ้ามิได้มีกิจกรรม หรือ เดินทางไปในสถานที่เสี่ยงต่อการติดโรคโควิด-19 เช่น ตลาดนัด สนามชนไก่ โรงพยาบาล พบปะญาติ เพื่อนที่มาจากต่างประเทศ จัดเลี้ยงสังสรรค์กับเพื่อน หรือญาติ ร่วมกิจกรรมทางศาสนา หรือร่วมพิธีศพ</label>
                        <label ID="lbl_3_en" hidden="hidden">3.	In the past 14 days, I have not had any activities or traveled to the area that has the risk of COVID-19 spreading, such as market, cockfighting field, hospital, meeting friend or family who traveled from another country, gathering party, religious activity or funeral.</label>
                    </td>
                    <td>
                        <img src="~/images/check.png" style="width:38px; height:38px;" id="img_3y" runat="server" hidden="hidden" />
                    </td>
                    <td>
                        <img src="~/images/check.png" style="width:38px; height:38px;" id="img_3n" runat="server" hidden="hidden" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label ID="lbl_4_th">4. ในช่วง 14 วันที่ผ่านมาจนถึงปัจจุบัน ข้าพเจ้าไม่มีอาการผิดปกติ เช่น ไข้ ไอ เจ็บคอ มีน้ำมูก หายใจหอบเหนื่อย<br />
                        ถ้าตอบว่า “ไม่ใช่” โปรดระบุอาการ</label>
                        <label ID="lbl_4_en" hidden="hidden">4.	In the past 14 days until now, I don't have any illnesses such as fever, cough, sore throat, runny nose, nor difficulty breathing.<br />
                        If the answer is no, please specify symptom</label>
                            <asp:Label id="lbl_no4" ForeColor="Blue" Text="_____________________________________________________" runat="server"></asp:Label>
                    </td>
                    <td>
                        <img src="~/images/check.png" style="width:38px; height:38px;" id="img_4y" runat="server" hidden="hidden" />
                    </td>
                    <td>
                        <img src="~/images/check.png" style="width:38px; height:38px;" id="img_4n" runat="server" hidden="hidden" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label ID="lbl_5_th">5. ในช่วง 14 วันที่ผ่านมา หากข้าพเจ้ามีความจำเป็นต้องออกจากที่พักอาศัย ข้าพเจ้ามีการสวมหน้ากากอนามัยทุกครั้ง และหมั่นล้างมือทำความสะอาดด้วยสบู่ หรือ แอลกอฮอล์</label>
                        <label ID="lbl_5_en" hidden="hidden">5.	In the past 14 days, in case I have to leave the residence, I have always worn a mask and washed my hands with either soap or hand sanitizer.</label>
                    </td>
                    <td>
                        <img src="~/images/check.png" style="width:38px; height:38px;" id="img_5y" runat="server" hidden="hidden" />
                    </td>
                    <td>
                        <img src="~/images/check.png" style="width:38px; height:38px;" id="img_5n" runat="server" hidden="hidden" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label ID="lbl_6_th">6. ข้าพเจ้าคิดว่าตนเองมีความเสี่ยงต่อการติดโรคโควิด-19 หรือไม่<br />
                        ถ้าตอบว่า “ใช่” โปรดระบุเหตุผล</label>
                        <label ID="lbl_6_en" hidden="hidden">I am suspected to have the COVID-19 infection.<br />
                        If the answer is yes, please specify the reason</label>
                        <asp:Label id="lbl_no6" ForeColor="Blue" Text="________________________________________________________________" runat="server"></asp:Label>
                    </td>
                    <td>
                        <img src="~/images/check.png" style="width:38px; height:38px;" id="img_6y" runat="server" hidden="hidden" />
                    </td>
                    <td>
                        <img src="~/images/check.png" style="width:38px; height:38px;" id="img_6n" runat="server" hidden="hidden" />
                    </td>
                </tr>
            </table>
            <!-- -------------------------------- ตารางด้านใน -------------------------------- -->
          </td>
      </tr>     
      <tr>
          <td>
              <!-- -------------------------------- Footer -------------------------------- -->
              <Table width="100%" border="0">
                  <tr>
                      <td>
                          <label ID="lbl_certify_th">ข้าพเจ้าขอรับรองว่า ข้อมูลที่แจ้งแก่โรงพยาบาลกรุงเทพระยองเป็นความจริงทุกประการ ทั้งนี้เพื่อสนับสนุนนโยบายการป้องกันความเสี่ยงและการแพร่ระบาดของโรคโควิด-19 หากข้าพเจ้าจงใจปิดบัง หรือให้ข้อมูลอันเป็นเท็จ อันนำมาซึ่งความเสียหายแก่บุคลากรทางการแพทย์ ข้าพเจ้ายินดีให้โรงพยาบาลดำเนินการตามกฎหมาย</label>
                          <label ID="lbl_certify_en" hidden="hidden">I certify that the information that is given to Bangkok Hospital Rayong is true in every aspect. I support the policy of reducing the risk of COVID-19 spreading. If I intended to hide or give false information, that could lead harm to our medical personnel, I consent to the hospital to prosecute in the term of law.</label>
                      </td>
                  </tr> 
                  <tr>
                      <td class="text-right">
                          <label ID="lbl_sign_th">ลงชื่อ</label><label ID="lbl_sign_en" hidden="hidden">Signature</label><asp:Label id="lbl_signed"  ForeColor="Blue" Text="........................................................................" runat="server"></asp:Label>
                      </td>
                  </tr>
                  <tr>
                      <td>&nbsp;</td>
                  </tr>
                  <tr>
                      <td>&nbsp;</td>
                  </tr>
                  <tr>
                      <td>
                          <!-- หมายเหตุ -->
                          <Table width="100%" border="1">
                              <tr>
                                  <td>    
                                      <br><u><label ID="lbl_remark_th">หมายเหตุ</label><label ID="lbl_remark_en" hidden="hidden">Remark:</label></u><br>
                                      <label ID="lbl_remarkdetail_th">กรณีที่ท่านคิดว่าตนเองมีความเสี่ยงการติดโรคโควิด-19 (ตามคำตอบข้อ6) หรือ มีคำตอบข้อใดข้อหนึ่งในคำถามข้อ1-4 “ไม่ใช่” ให้เจ้าหน้าที่ก่อนการเก็บสิ่งส่งตรวจ เพื่อดำเนินการซักประวัติโดยละเอียดอีกครั้ง</label>
                                      <label ID="lbl_remarkdetail_en" hidden="hidden">In the case of suspected COVID-19 infection (related to answer number 6) or has "No" answered in question 1-4, the patient should be further investigated by the staff again.</label>
                                  </td>
                              </tr>  
                          </Table>
                          <!-- หมายเหตุ -->
                      </td>
                  </tr>
               </Table>
              <!-- -------------------------------- Footer -------------------------------- -->
          </td>
      </tr>
    </table>

<!-- ------------------------------------------- Button ------------------------------------------------------------ -->
<div id="div_input" class="col-12 mt-5 text-center" runat="server">
    <button type="button" class="btn btn-primary" style="font-size:50px" data-toggle="modal" data-target="#exampleModal" data-whatever="@mdo">INPUT</button>
</div>
<div id="div_submit" class="col-12 mt-5 text-center" runat="server" hidden="hidden">
    <button type="button" class="btn btn-primary" id="btnsubmit" style="font-size:50px" runat="server" onserverclick="btnsubmit_ServerClick">submit</button>
    <input type="text" id="txtH_risk" value="" runat="server" hidden="hidden" />
</div>
<div id="div_print" class="col-12 mt-5 text-center" runat="server" visible="false">
    <button id="btn_print" class="btn btn-primary" value="" style="font-size:50px" onclick="printDiv()" >PRINT</button>
</div>
<script>
    function printDiv() {
        var printContents = document.getElementById("<%= printableArea.ClientID %>").innerHTML;
        var originalContents = document.body.innerHTML;
        document.body.innerHTML = printContents;
        window.print();
        document.body.innerHTML = originalContents;
    }
</script>
<!-- ------------------------------------------- Button ------------------------------------------------------------ -->

<!-- ------------------------------------------- Modal ------------------------------------------------------------ -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title" id="exampleModalLabel"><label id="lbl_inputhead_th">กรอกข้อมูล</label><label id="lbl_inputhead_en" hidden="hidden">INPUT DATA</label></h1>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
           
          <asp:UpdatePanel ID="UpdatePanel_Emp" runat="server">
              <ContentTemplate>

                  <div class="form-group text-left">
                    <label id="lbl_fname_th" style="font-size: 25px;">ชื่อ</label><label id="lbl_fname_en" style="font-size: 25px;" hidden="hidden">First name</label>
                    <input type="text" class="form-control" id="firstname" required="required" runat="server" />
                  </div>
                  <div class="form-group text-left">
                    <label id="lbl_lname_th" style="font-size: 25px;">นามสกุล</label><label id="lbl_lname_en" style="font-size: 25px;" hidden="hidden">Last name</label>
                    <input type="text" class="form-control" id="lastname" required="required" runat="server" />
                  </div>
                  <div class="form-group text-left">
                    <label id="lbl_dob_th" style="font-size: 25px;">วัน เดือน ปี เกิด</label><label id="lbl_dob_en" style="font-size: 25px;" hidden="hidden">Date of Birth</label>
                    <input type="date" class="form-control" id="dob" runat="server" />
                  </div>

              </ContentTemplate>
          </asp:UpdatePanel>

          <div class="form-group">
            <label id="lbl_in1_th" style="font-size: 20px;">1. ในช่วง 14 วันที่ผ่านมาข้าพเจ้าพักอยู่บ้าน โดยมิได้มีการเดินทางข้ามจังหวัด</label>
            <label id="lbl_in1_en" style="font-size: 20px;" hidden="hidden">1.	In the past 14 days, I have quarantined at my resident and have not traveled across the province.</label>
            <div class="row col-12 text-center">
                <div class="col-6 h3">
                    <input type="radio" style="width: 30px; height: 30px;" name="no1" value="0" id="no1y" runat="server"/><label id="lbl_yes1_th">ใช่</label><label id="lbl_yes1_en" hidden="hidden" >Yes</label>
                </div>
                <div class="col-6 h3">
                    <input type="radio" style="width: 30px; height: 30px;" name="no1" value="1" id="no1n" runat="server"/><label id="lbl_no1_th">ไม่ใช่</label><label id="lbl_no1_en" hidden="hidden" >No</label>
                </div>
                </div>
            </div>
          </div>
          <div class="form-group">
            <label id="lbl_in2_th" style="font-size: 20px;">2. ในช่วง 14 วันที่ผ่านมา ข้าพเจ้ามิได้มีการใกล้ชิดหรือสัมผัสกับผู้ป่วยเข้าข่ายหรือยืนยันโรคติดเชื้อโควิด-19</label>
            <label id="lbl_in2_en" style="font-size: 20px;" hidden="hidden">2.	In the past 14 days, I have not been in close contact nor directly contacted anyone that is suspected or confirmed as COVID-19 infected patient.</label>
            <div class="row col-12 text-center">
                <div class="col-6 h3">
                    <input type="radio" style="width: 30px; height: 30px;" name="no2" value="0" id="no2y" runat="server"/><label id="lbl_yes2_th">ใช่</label><label id="lbl_yes2_en" hidden="hidden" >Yes</label>
                </div>
                <div class="col-6 h3">
                    <input type="radio" style="width: 30px; height: 30px;" name="no2" value="1" id="no2n"  runat="server"/><label id="lbl_no2_th">ไม่ใช่</label><label id="lbl_no2_en" hidden="hidden" >No</label>
                </div>
                </div>
          </div>
          <div class="form-group">
            <label id="lbl_in3_th" style="font-size: 20px;">3. ในช่วง 14 วันที่ผ่านมา ข้าพเจ้ามิได้มีกิจกรรม หรือ เดินทางไปในสถานที่เสี่ยงต่อการติดโรคโควิด-19 เช่น ตลาดนัด สนามชนไก่ โรงพยาบาล พบปะญาติ เพื่อนที่มาจากต่างประเทศ จัดเลี้ยงสังสรรค์กับเพื่อน หรือญาติ ร่วมกิจกรรมทางศาสนา หรือร่วมพิธีศพ</label>
            <label id="lbl_in3_en" style="font-size: 20px;" hidden="hidden">3.	In the past 14 days, I have not had any activities or traveled to the area that has the risk of COVID-19 spreading, such as market, cockfighting field, hospital, meeting friend or family who traveled from another country, gathering party, religious activity or funeral.</label>
            <div class="row col-12 text-center">
                <div class="col-6 h3">
                    <input type="radio" style="width: 30px; height: 30px;" name="no3" value="0" id="no3y"  runat="server"/><label id="lbl_yes3_th">ใช่</label><label id="lbl_yes3_en" hidden="hidden" >Yes</label>
                </div>
                <div class="col-6 h3">
                    <input type="radio" style="width: 30px; height: 30px;" name="no3" value="1" id="no3n" runat="server"/><label id="lbl_no3_th">ไม่ใช่</label><label id="lbl_no3_en" hidden="hidden" >No</label>
                </div>
                </div>
          </div>
          <div class="form-group">
            <label id="lbl_in4_th" style="font-size: 20px;">4. ในช่วง 14 วันที่ผ่านมาจนถึงปัจจุบัน ข้าพเจ้าไม่มีอาการผิดปกติ เช่น ไข้ ไอ เจ็บคอ มีน้ำมูก หายใจหอบเหนื่อย<br />
            ถ้าตอบว่า “ไม่ใช่” โปรดระบุอาการ</label>
            <label id="lbl_in4_en" style="font-size: 20px;" hidden="hidden">4.	In the past 14 days until now, I don't have any illnesses such as fever, cough, sore throat, runny nose, nor difficulty breathing.<br />
            If the answer is no, please specify symptom</label>
            <div class="row col-12 text-center">
                <div class="col-6 h3">
                    <input type="radio" style="width: 30px; height: 30px;" name="no4" value="0" id="no4y" onclick="myFunction()"  runat="server"/><label id="lbl_yes4_th">ใช่</label><label id="lbl_yes4_en" hidden="hidden" >Yes</label>
                </div>

                <div class="col-6 h3">                                  
                    <input type="radio" style="width: 30px; height: 30px;" name="no4" value="1" id="no4n" onclick="myFunction()" runat="server"/><label id="lbl_no4_th">ไม่ใช่</label><label id="lbl_no4_en" hidden="hidden" >No</label>
                </div>

                 
                 <div class="row col-12 text-center" id="myDIV" hidden="hidden">
                    <input type="text" class="form-control" id="no4d" placeholder="ระบุอาการ" value="" runat="server"/>

                    <script>
                        var myDIV = document.getElementById("myDIV");
                        myDIV.hidden = "hidden";
                        function myFunction() {
                            var ry = document.getElementById("<%= no4y.ClientID %>");
                            var rn = document.getElementById("<%= no4n.ClientID %>");

                            if (rn.checked) {
                                myDIV.hidden = "";

                            }
                            if (ry.checked) {
                                myDIV.hidden = "hidden";

                            }

                        }
                    </script>
                    </div>
                  
              
                </div>
            
          </div>
          <div class="form-group">
            <label id="lbl_in5_th"  style="font-size: 20px;">5. ในช่วง 14 วันที่ผ่านมา หากข้าพเจ้ามีความจำเป็นต้องออกจากที่พักอาศัย ข้าพเจ้ามีการสวมหน้ากากอนามัยทุกครั้ง และหมั่นล้างมือทำความสะอาดด้วยสบู่ หรือ แอลกอฮอล์</label>
            <label id="lbl_in5_en" style="font-size: 20px;" hidden="hidden">5.	In the past 14 days, in case I have to leave the residence, I have always worn a mask and washed my hands with either soap or hand sanitizer.</label>
            <div class="row col-12 text-center">
                <div class="col-6 h3">
                    <input type="radio" style="width: 30px; height: 30px;" name="no5" value="yes" id="no5y"  runat="server"/><label id="lbl_yes5_th">ใช่</label><label id="lbl_yes5_en" hidden="hidden" >Yes</label>
                </div>
                <div class="col-6 h3">
                    <input type="radio" style="width: 30px; height: 30px;" name="no5" value="no" id="no5n" runat="server"/><label id="lbl_no5_th">ไม่ใช่</label><label id="lbl_no5_en" hidden="hidden" >No</label>
                </div>
                </div>
          </div>
          <div class="form-group">
            <label id="lbl_in6_th" style="font-size: 20px;">6. ข้าพเจ้าคิดว่าตนเองมีความเสี่ยงต่อการติดโรคโควิด-19 หรือไม่<br />
            ถ้าตอบว่า “ใช่” โปรดระบุเหตุผล</label>
            <label id="lbl_in6_en" style="font-size: 20px;" hidden="hidden">I am suspected to have the COVID-19 infection.<br />
            If the answer is yes, please specify the reason</label>
            <div class="row col-12 text-center">
                <div class="col-6 h3">
                    <input type="radio" style="width: 30px; height: 30px;" name="no6" value="yes"  id="no6y" onclick="myFunction1()" runat="server"/><label id="lbl_yes6_th">ใช่</label><label id="lbl_yes6_en" hidden="hidden" >Yes</label>
                </div>
                <div class="col-6 h3">
                    <input type="radio" style="width: 30px; height: 30px;" name="no6" value="no" id="no6n" onclick="myFunction1()"  runat="server"/><label id="lbl_no6_th">ไม่ใช่</label><label id="lbl_no6_en" hidden="hidden" >No</label>
                </div>

                <div class="row col-12 text-center" id="myHIDE" hidden="hidden">
                <input type="text" class="form-control" id="no6d" runat="server" placeholder="โปรดระบุเหตุผล" />

                    <script>
                        var x = document.getElementById("myHIDE");
                        x.hidden = "hidden";
                        function myFunction1() {
                            var ry = document.getElementById("<%= no6y.ClientID %>");
                            var rn = document.getElementById("<%= no6n.ClientID %>");

                            if (rn.checked) {
                                x.hidden = "hidden";
                                
                            }
                            if (ry.checked) {
                                x.hidden = "";

                            }
                           
                        }
                    </script>
                    </div>
                </div>
          </div>
        

        <div class="modal-footer col-12 mx-auto text-center">

            <button type="button" class="btn btn-primary text-center" style="font-size:40px" data-dismiss="modal" onmouseover="btnok()">Ok</button>

            <script>
                function btnok() {
                    
                    var fname = document.getElementById("<%= firstname.ClientID %>");
                    var lname = document.getElementById("<%= lastname.ClientID %>");
                    var DOB = document.getElementById("<%= dob.ClientID %>");
                    var no1y = document.getElementById("<%= no1y.ClientID %>");
                    var no1n = document.getElementById("<%= no1n.ClientID %>");
                    var no2y = document.getElementById("<%= no2y.ClientID %>");
                    var no2n = document.getElementById("<%= no2n.ClientID %>");
                    var no3y = document.getElementById("<%= no3y.ClientID %>");
                    var no3n = document.getElementById("<%= no3n.ClientID %>");
                    var no4y = document.getElementById("<%= no4y.ClientID %>");
                    var no4n = document.getElementById("<%= no4n.ClientID %>");
                    var no4d = document.getElementById("<%= no4d.ClientID %>");
                    var no5y = document.getElementById("<%= no5y.ClientID %>");
                    var no5n = document.getElementById("<%= no5n.ClientID %>");
                    var no6y = document.getElementById("<%= no6y.ClientID %>");
                    var no6n = document.getElementById("<%= no6n.ClientID %>");
                    var no6d = document.getElementById("<%= no6d.ClientID %>");


                    if (fname.value == "" || lname.value == "" || DOB.value == "") { 
                        alert("กรุุณากรอกข้อมูลให้ครบถ้วน");

                    } else {

                        var ch = "no";
                        if (no1y.checked || no1n.checked) {
                            if (no1y.checked) {
                                document.getElementById("<%= img_1y.ClientID %>").hidden = "";
                                document.getElementById("<%= img_1y.ClientID %>").style = "width: 38px; height: 38px;";
                            } else {
                                document.getElementById("<%= img_1n.ClientID %>").hidden = "";
                            }
                            if (no2y.checked || no2n.checked) {
                                if (no2y.checked) {
                                    document.getElementById("<%= img_2y.ClientID %>").hidden = "";
                                } else {
                                    document.getElementById("<%= img_2n.ClientID %>").hidden = "";
                                }
                                if (no3y.checked || no3n.checked) {
                                    if (no3y.checked) {
                                        document.getElementById("<%= img_3y.ClientID %>").hidden = "";
                                    } else {
                                        document.getElementById("<%= img_3n.ClientID %>").hidden = "";
                                    }

                                    if (no4y.checked || no4n.checked) {
                                        if (no4y.checked) {
                                            document.getElementById("<%= img_4y.ClientID %>").hidden = "";
                                        } else {
                                            document.getElementById("<%= img_4n.ClientID %>").hidden = "";
                                        }
                                        if (no5y.checked || no5n.checked) {
                                            if (no5y.checked) {
                                                document.getElementById("<%= img_5y.ClientID %>").hidden = "";
                                            } else {
                                                document.getElementById("<%= img_5n.ClientID %>").hidden = "";
                                            }

                                            if (no6y.checked || no6n.checked) {
                                                if (no6y.checked) {
                                                    document.getElementById("<%= img_6y.ClientID %>").hidden = "";
                                                } else {
                                                    document.getElementById("<%= img_6n.ClientID %>").hidden = "";
                                                }
                                                ch = "yes";
                                            }

                                        }
                                    }
                                }
                            }
                        }

                        if (ch == "yes") {

                            var lblname = document.getElementById("<%= lbl_name.ClientID %>");
                            var lbldob = document.getElementById("<%= lbl_DOB.ClientID %>");
                            var lblno4 = document.getElementById("<%= lbl_no4.ClientID %>");
                            var lblno6 = document.getElementById("<%= lbl_no6.ClientID %>");
                            var lblsign = document.getElementById("<%= lbl_signed.ClientID %>");

                            lblname.innerText = " " + fname.value + " " + lname.value + " ";
                            var DOB_d = DOB.value.split('-');
                            var DOBth = DOB_d[2] + "/" + DOB_d[1] + "/" + DOB_d[0];
                            lbldob.innerText = " " + DOBth + " ";
                            lblno4.innerText = " " + no4d.value + " " ;
                            lblno6.innerText = " " + no6d.value + " " ;
                            lblsign.innerText = " " + fname.value + " " + lname.value + " " ;

                            document.getElementById("<%= div_input.ClientID %>").hidden = "hidden";
                            document.getElementById("<%= div_submit.ClientID %>").hidden = "";
                            
                        } else {
                            alert("กรุณาตอบคำถามให้ครบ");
                        }

                    }
                                     
                }

                

            </script>

        </div>
        </div>
      </div>
    </div>
<!-- ------------------------------------------- Modal ------------------------------------------------------------ -->

<!-- -------------------------------------- Script translate -------------------------------------------------------- -->
<script>
    function fn_translate(LQ) {
        var sj_th = document.getElementById('lbl_subject_th');
        var sj_en = document.getElementById('lbl_subject_en');
        var date_th = document.getElementById('lbl_date_th');
        var date_en = document.getElementById('lbl_date_en');
        var name_th = document.getElementById('lbl_name_th');
        var name_en = document.getElementById('lbl_name_en');
        var dob_th = document.getElementById('lbl_DOB_th');
        var dob_en = document.getElementById('lbl_DOB_en');
        var cau_th = document.getElementById('lbl_caution_th');
        var cau_en = document.getElementById('lbl_caution_en');
        var inf_th = document.getElementById('lbl_infor_th');
        var inf_en = document.getElementById('lbl_infor_en');
        var yes_th = document.getElementById('lbl_yes_th');
        var yes_en = document.getElementById('lbl_yes_en');
        var no_th = document.getElementById('lbl_no_th');
        var no_en = document.getElementById('lbl_no_en');

        var q1_th = document.getElementById('lbl_1_th');
        var q1_en = document.getElementById('lbl_1_en');
        var q2_th = document.getElementById('lbl_2_th');
        var q2_en = document.getElementById('lbl_2_en');
        var q3_th = document.getElementById('lbl_3_th');
        var q3_en = document.getElementById('lbl_3_en');
        var q4_th = document.getElementById('lbl_4_th');
        var q4_en = document.getElementById('lbl_4_en');
        var q5_th = document.getElementById('lbl_5_th');
        var q5_en = document.getElementById('lbl_5_en');
        var q6_th = document.getElementById('lbl_6_th');
        var q6_en = document.getElementById('lbl_6_en');

        var cer_th = document.getElementById('lbl_certify_th');
        var cer_en = document.getElementById('lbl_certify_en');
        var sign_th = document.getElementById('lbl_sign_th');
        var sign_en = document.getElementById('lbl_sign_en');
        var rem_th = document.getElementById('lbl_remark_th');
        var rem_en = document.getElementById('lbl_remark_en');
        var remd_th = document.getElementById('lbl_remarkdetail_th');
        var remd_en = document.getElementById('lbl_remarkdetail_en');

        // --------------------------------------------------------------------

        var inputHead_th = document.getElementById('lbl_inputhead_th');
        var inputHead_en = document.getElementById('lbl_inputhead_en');
        var fname_th = document.getElementById('lbl_fname_th');
        var fname_en = document.getElementById('lbl_fname_en');
        var lname_th = document.getElementById('lbl_lname_th');
        var lname_en = document.getElementById('lbl_lname_en');

        var DOB_th = document.getElementById('lbl_dob_th');
        var DOB_en = document.getElementById('lbl_dob_en');
        var in1_th = document.getElementById('lbl_in1_th');
        var in1_en = document.getElementById('lbl_in1_en');
        var in2_th = document.getElementById('lbl_in2_th');
        var in2_en = document.getElementById('lbl_in2_en');
        var in3_th = document.getElementById('lbl_in3_th');
        var in3_en = document.getElementById('lbl_in3_en');
        var in4_th = document.getElementById('lbl_in4_th');
        var in4_en = document.getElementById('lbl_in4_en');
        var in5_th = document.getElementById('lbl_in5_th');
        var in5_en = document.getElementById('lbl_in5_en');
        var in6_th = document.getElementById('lbl_in6_th');
        var in6_en = document.getElementById('lbl_in6_en');

        var no4_d = document.getElementById('<%= no4d.ClientID %>');
        var no6_d = document.getElementById('<%= no6d.ClientID %>');

        var y1_th = document.getElementById('lbl_yes1_th'); var y1_en = document.getElementById('lbl_yes1_en');
        var y2_th = document.getElementById('lbl_yes2_th'); var y2_en = document.getElementById('lbl_yes2_en');
        var y3_th = document.getElementById('lbl_yes3_th'); var y3_en = document.getElementById('lbl_yes3_en');
        var y4_th = document.getElementById('lbl_yes4_th'); var y4_en = document.getElementById('lbl_yes4_en');
        var y5_th = document.getElementById('lbl_yes5_th'); var y5_en = document.getElementById('lbl_yes5_en');
        var y6_th = document.getElementById('lbl_yes6_th'); var y6_en = document.getElementById('lbl_yes6_en');
        var n1_th = document.getElementById('lbl_no1_th'); var n1_en = document.getElementById('lbl_no1_en');
        var n2_th = document.getElementById('lbl_no2_th'); var n2_en = document.getElementById('lbl_no2_en');
        var n3_th = document.getElementById('lbl_no3_th'); var n3_en = document.getElementById('lbl_no3_en');
        var n4_th = document.getElementById('lbl_no4_th'); var n4_en = document.getElementById('lbl_no4_en');
        var n5_th = document.getElementById('lbl_no5_th'); var n5_en = document.getElementById('lbl_no5_en');
        var n6_th = document.getElementById('lbl_no6_th'); var n6_en = document.getElementById('lbl_no6_en');

        if (LQ == "EN") {
            sj_en.hidden = ""; date_en.hidden = ""; name_en.hidden = ""; 
            dob_en.hidden = ""; cau_en.hidden = ""; inf_en.hidden = "";     
            yes_en.hidden = ""; no_en.hidden = ""; q1_en.hidden = "";       
            q2_en.hidden = ""; q3_en.hidden = ""; q4_en.hidden = "";        
            q5_en.hidden = ""; q6_en.hidden = ""; cer_en.hidden = "";       
            sign_en.hidden = ""; rem_en.hidden = ""; remd_en.hidden = "";   

            sj_th.hidden = "hidden"; date_th.hidden = "hidden"; name_th.hidden = "hidden";
            dob_th.hidden = "hidden"; cau_th.hidden = "hidden"; inf_th.hidden = "hidden";
            yes_th.hidden = "hidden"; no_th.hidden = "hidden"; q1_th.hidden = "hidden";
            q2_th.hidden = "hidden"; q3_th.hidden = "hidden"; q4_th.hidden = "hidden";
            q5_th.hidden = "hidden"; q6_th.hidden = "hidden"; cer_th.hidden = "hidden";
            sign_th.hidden = "hidden"; rem_th.hidden = "hidden"; remd_th.hidden = "hidden";

            inputHead_en.hidden = ""; fname_en.hidden = ""; lname_en.hidden = ""; DOB_en.hidden = "";
            in1_en.hidden = ""; in2_en.hidden = ""; in3_en.hidden = ""; in4_en.hidden = ""; in5_en.hidden = ""; in6_en.hidden = "";
            y1_en.hidden = ""; y2_en.hidden = ""; y3_en.hidden = ""; y4_en.hidden = ""; y5_en.hidden = ""; y6_en.hidden = "";
            n1_en.hidden = ""; n2_en.hidden = ""; n3_en.hidden = ""; n4_en.hidden = ""; n5_en.hidden = ""; n6_en.hidden = "";

            inputHead_th.hidden = "hidden"; fname_th.hidden = "hidden"; lname_th.hidden = "hidden"; DOB_th.hidden = "hidden";
            in1_th.hidden = "hidden"; in2_th.hidden = "hidden"; in3_th.hidden = "hidden"; in4_th.hidden = "hidden"; in5_th.hidden = "hidden"; in6_th.hidden = "hidden";
            y1_th.hidden = "hidden"; y2_th.hidden = "hidden"; y3_th.hidden = "hidden"; y4_th.hidden = "hidden"; y5_th.hidden = "hidden"; y6_th.hidden = "hidden";
            n1_th.hidden = "hidden"; n2_th.hidden = "hidden"; n3_th.hidden = "hidden"; n4_th.hidden = "hidden"; n5_th.hidden = "hidden"; n6_th.hidden = "hidden";

            no4_d.setAttribute("placeholder", "Please specify symptoms.");
            no6_d.setAttribute("placeholder", "Please specify a reason.");
        } else if (LQ == "TH") {
            sj_en.hidden = "hidden"; date_en.hidden = "hidden"; name_en.hidden = "hidden";
            dob_en.hidden = "hidden"; cau_en.hidden = "hidden"; inf_en.hidden = "hidden";
            yes_en.hidden = "hidden"; no_en.hidden = "hidden"; q1_en.hidden = "hidden";
            q2_en.hidden = "hidden"; q3_en.hidden = "hidden"; q4_en.hidden = "hidden";
            q5_en.hidden = "hidden"; q6_en.hidden = "hidden"; cer_en.hidden = "hidden";
            sign_en.hidden = "hidden"; rem_en.hidden = "hidden"; remd_en.hidden = "hidden";

            sj_th.hidden = ""; date_th.hidden = ""; name_th.hidden = "";
            dob_th.hidden = ""; cau_th.hidden = ""; inf_th.hidden = "";
            yes_th.hidden = ""; no_th.hidden = ""; q1_th.hidden = "";
            q2_th.hidden = ""; q3_th.hidden = ""; q4_th.hidden = "";
            q5_th.hidden = ""; q6_th.hidden = ""; cer_th.hidden = "";
            sign_th.hidden = ""; rem_th.hidden = ""; remd_th.hidden = "";

            inputHead_en.hidden = "hidden"; fname_en.hidden = "hidden"; lname_en.hidden = "hidden"; DOB_en.hidden = "hidden";
            in1_en.hidden = "hidden"; in2_en.hidden = "hidden"; in3_en.hidden = "hidden"; in4_en.hidden = "hidden"; in5_en.hidden = "hidden"; in6_en.hidden = "hidden";
            y1_en.hidden = "hidden"; y2_en.hidden = "hidden"; y3_en.hidden = "hidden"; y4_en.hidden = "hidden"; y5_en.hidden = "hidden"; y6_en.hidden = "hidden";
            n1_en.hidden = "hidden"; n2_en.hidden = "hidden"; n3_en.hidden = "hidden"; n4_en.hidden = "hidden"; n5_en.hidden = "hidden"; n6_en.hidden = "hidden";

            inputHead_th.hidden = ""; fname_th.hidden = ""; lname_th.hidden = ""; DOB_th.hidden = "";
            in1_th.hidden = ""; in2_th.hidden = ""; in3_th.hidden = ""; in4_th.hidden = ""; in5_th.hidden = ""; in6_th.hidden = "";
            y1_th.hidden = ""; y2_th.hidden = ""; y3_th.hidden = ""; y4_th.hidden = ""; y5_th.hidden = ""; y6_th.hidden = "";
            n1_th.hidden = ""; n2_th.hidden = ""; n3_th.hidden = ""; n4_th.hidden = ""; n5_th.hidden = ""; n6_th.hidden = "";

            no4_d.setAttribute("placeholder", "ระบุอาการ");
            no6_d.setAttribute("placeholder", "โปรดระบุเหตุผล");
        } else { }
    }
</script>
<!-- -------------------------------------- Script translate -------------------------------------------------------- -->

</div>

</asp:Content>
