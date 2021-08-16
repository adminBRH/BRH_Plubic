<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ScreenCovidBeforToWork.aspx.cs" Inherits="BRH_Plubic.ScreenCovidBeforToWork" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">

    <asp:ScriptManager ID="ScriptManager_Master" runat="server"></asp:ScriptManager>

    <div class="col-11 mx-auto my-5">

    <table width="100%" id="printableArea" runat="server" data-toggle="modal" data-target="#exampleModal" data-whatever="@mdo" style="width: 21cm; height: 29.7cm; margin-left: auto; margin-right: auto;" border="0">
      <tr>
           <td>
               <div class="text-center">
                   <b>หนังสือแสดงข้อมูลความเสี่ยงต่อโรคโควิด-19 ก่อนกลับเข้าปฏิบัติงาน</b>
               </div>
           </td>       
      </tr>
      <tr>
          <td>
              <div class="text-center">
                  Declaring Document to Covid-19 risk before Return to work
              </div>
          </td>     
      </tr>
      <tr>
          <td>
              <div class="text-right mb-2">
                  วันที่/ Date<asp:Label id="lbl_Date" ForeColor="Blue" Text="........" runat="server"></asp:Label>
              </div>
          </td>
      </tr>
      <tr>
          <td><div>เรียน <asp:Label id="lbl_company_TH" ForeColor="Blue" Text="" runat="server"></asp:Label></div></td>      
      </tr>
      <tr>
          <td><div>To: <asp:Label id="lbl_company_EN" ForeColor="Blue" Text="" runat="server"></asp:Label></div></td>
      </tr>
       <tr>
          <td>
              <div hidden="hidden">
                  <input type="text" id="txt_cpid" value="" runat="server" />
              </div>
          </td>
      </tr>
      <tr>
          <td>
              <div class="mt-2">
                ข้าพเจ้า นาย/นาง/นางสาว/ I Mr./Mrs./Miss<asp:Label id="lbl_name" ForeColor="Blue" Text="....................................................." runat="server"></asp:Label>รหัสประจำตัวพนักงาน/ Employee ID<asp:Label id="lbl_emp" ForeColor="Blue" Text="......................" runat="server"></asp:Label>
              </div>
          </td>
      </tr>
      <tr>
          <td>
              <div>
              ตำแหน่ง/ Position<asp:Label id="lbl_posi" ForeColor="Blue" Text="..........................................." runat="server"></asp:Label>
              แผนก/ Department<asp:Label id="lbl_dept" ForeColor="Blue" Text="..........................................." runat="server"></asp:Label>
              ฝ่าย/ Division<asp:Label id="lbl_div" ForeColor="Blue" Text=".............................." runat="server"></asp:Label>
              </div>
          </td>
      </tr>
      <tr>
          <td>
              <div>
              เพื่อเป็นการเฝ้าระวังการแพร่ระบาดของโรคโควิด-19 ซึ่งจะส่งผลกระทบต่อสุขภาพของพนักงานและบริษัทฯ ข้าพเจ้าขอให้ข้อมูลเพื่อรับรองต่อบริษัทฯ ดังนี้<br />
              To be monitoring the epidemic of Covid-19 that effect to employees’ health and business. I, hereby certify to the company as follows:
              </div>
          </td>
      </tr>
      <tr>
          <td>
            <!-- -------------------------------- ตารางด้านใน -------------------------------- -->
            <table width="100%" border="1">
                <tr>
                    <td class="text-center" width="90%">
                        รายละเอียดข้อมูล / Information
                    </td>
                    <td width="5%">
                        ใช่<br />
                        Yes
                    </td>
                    <td width="5%">
                        ไม่ใช่<br />
                        No
                    </td>
                </tr> 
                <tr>
                    <td>
                        1. ในระหว่างวันหยุดที่ผ่านมา ข้าพเจ้าพักอยู่บ้าน โดยมิได้มีการเดินทางข้ามจังหวัด / During passed holidays I stayed at home and did not travel between provinces.
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
                        2. ในระหว่างวันหยุดที่ผ่านมา ข้าพเจ้ามิได้มีการใกล้ชิดหรือสัมผัสกับผู้ป่วยเข้าข่ายหรือยืนยันโรคติดเชื้อโควิด-19/ During passed holidays, I did not close or contact to the suspect or patient of Covid-19
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
                        3. ในระหว่างวันหยุดที่ผ่านมา ข้าพเจ้ามิได้มีกิจกรรม หรือ เดินทางไปในสถานที่เสี่ยงต่อการติดโรคโควิด-19 เช่นตลาดนัด สนามชนไก่ โรงพยาบาล พบปะญาติ เพื่อนที่มาจากต่างประเทศ 
                        จัดเลี้ยงสังสรรค์กับเพื่อน หรือญาติ ร่วมงานเทศกาลสงกรานต์ ร่วมกิจกรรมทางศาสนา หรือร่วมพิธีศพ เป็นต้น/ During passed holidays I did not have activities or travelled to the place that are the risk of Covid-19 e.g. Market fair,
                        Cockpit, Hospital, Meet the relatives or friends from aboard, Party with friends or relatives, join Songkran festival, join the ritualistic ceremony or funeral ceremony etc.
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
                        4. ในระหว่างวันหยุดที่ผ่านมา จน ถึงปัจจุบัน ข้าพเจ้าไม่มีอาการผิดปกติ เช่น ไข้ ไอ เจ็บคอ มีน้ำมูก หายใจหอบเหนื่อย/ From the passed holidays until now I have never had symptoms e.g. fever, cough, runny nose, dyspnea etc.
                        ถ้าตอบว่า “ไม่ใช่” โปรดระบุอาการ / If “No”, please specify<asp:Label id="lbl_no4" ForeColor="Blue" Text="_____________________________________________________" runat="server"></asp:Label>
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
                        5. ในระหว่างวันหยุดที่ผ่านมา หากข้าพเจ้ามีความจำเป็นต้องออกจากที่พักอาศัย ข้าพเจ้ามีการสวมหน้ากากอนามัยทุกครั้ง และหมั่นล้างมือทาความสะอาดด้วยสบู่ หรือ แอลกอฮอล์/ During passed holidays when I had necessary to go outside, I wore mask every time and washed hand with soap or cleaned with alcohol.
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
                        6. ข้าพเจ้าคิดว่าตนเองมีความเสี่ยงต่อการติดโรคโควิด-19 หรือไม่ / I think that I have the risk to infect Covid-19
                        ถ้าตอบว่า “ใช่” โปรดระบุเหตุผล / If “Yes”, please specify the reason<asp:Label id="lbl_no6" ForeColor="Blue" Text="________________________________________________________________" runat="server"></asp:Label>
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
                          ข้าพเจ้าขอรับรองว่า ข้อมูลที่แจ้งแก่บริษัทฯ เป็นความจริงทุกประการ ทั้งนี้เพื่อสนับสนุนนโยบายการป้องกันความเสี่ยงและการแพร่ระบาดของโรคโควิด-19 หากข้าพเจ้าจงใจปิดบัง หรือให้ข้อมูลอันเป็นเท็จ อันนำมาซึ่งความเสียหายแก่ พนักงาน และบริษัทฯ ข้าพเจ้ายินดีให้บริษัทฯ พิจารณาโทษทางวินัยตามระเบียบบริษัทฯ<br />
                          I hereby confirm that information given is correct in order that to support the risk and the spread prevention of Covid-19. If I intend to hide or give the false information that brings the damage to employees and company, I consent to receive the disciplinary action according to company rules and regulation.
                      </td>
                  </tr> 
                  <tr>
                      <td class="text-right">
                          ลงชื่อพนักงาน/ signed<asp:Label id="lbl_signed"  ForeColor="Blue" Text="........................................................................" runat="server"></asp:Label>
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
                                      <br><u>หมายเหตุ/ Remark:</u><br>
                                      กรณีที่พนักงานคิดว่าตนเองมีความเสี่ยงการติดโรคโควิด-19 (ตามคำตอบข้อ6) หรือ มีคำตอบข้อใดข้อหนึ่งในคำถามข้อ1-4 “ไม่ใช่” <u>ให้พบพยาบาลที่จุดคัดกรองนอกรั้วแต่ละอาคารทันที ห้ามผ่าน Turnstiles</u> จนกว่าจะได้รับการยืนยันจากแพทย์หรือฝ่ายทรัพยากรบุคคลว่าสามารถปฏิบัติงานได้<br>
                                      In case of employee think that he/she has the risk to infect The Covid-19 ( from question number 6) or has the answer “No” in of one of question from number 1-4, the employee <u>Please go to screening point outside the fence of each building immediately., Do not pass turnstiles!</u> until the employee is confirmed by doctor or HR that can return to work.
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
    <button type="button" class="btn btn-primary" style="font-size:50px" data-toggle="modal" data-target="#exampleModal" data-whatever="@mdo">กรอกข้อมูล</button>
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
        <h1 class="modal-title" id="exampleModalLabel">กรอกข้อมูล</h1>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
           
          <asp:UpdatePanel ID="UpdatePanel_Emp" runat="server">
              <ContentTemplate>

                  <div class="form-group text-left">
                    <label for="message-text" class="col-form-label" style="font-size: 25px;">รหัสประจำตัวพนักงาน / Employee ID</label>
                    <input type="text" class="form-control" id="employeeid" required="required" runat="server" />
                    <asp:Button ID="btn_emp" CssClass="btn btn-light ml-5" Text="Check" OnClick="btn_emp_Click" runat="server" />
                    <asp:Label ID ="lbl_alert" CssClass="my-3" ForeColor="Red" Text="" runat="server" Visible="false"></asp:Label>
                  </div>
                  <div class="form-group text-left" >
                    <label for="recipient-name" class="col-form-label" style="font-size: 25px;">ชื่อ - นามสกุล</label>
                    <input type="text" class="form-control" id="fullname" runat="server" disabled="disabled" />
                  </div>
                  <div class="form-group text-left" hidden="hidden">
                    <label for="recipient-name" class="col-form-label" style="font-size: 25px;">ชื่อ</label>
                    <input type="text" class="form-control" id="firstname" required="required" runat="server" disabled="disabled" />
                  </div>
                  <div class="form-group text-left" hidden="hidden">
                    <label for="message-text" class="col-form-label" style="font-size: 25px;">นามสกุล</label>
                    <input type="text" class="form-control" id="lastname" required="required" runat="server" disabled="disabled" />
                  </div>
                  <div class="form-group text-left">
                    <label for="message-text" class="col-form-label" style="font-size: 25px;">ตำแหน่ง / Post</label>
                    <input type="text" class="form-control" id="position" runat="server" disabled="disabled" />
                  </div>
                  <div class="form-group text-left">
                    <label for="message-text" class="col-form-label" style="font-size: 25px;">แผนก / Department</label>
                    <input type="text" class="form-control" id="department" required="required" runat="server" disabled="disabled" />
                  </div>
                  <div class="form-group text-left">
                    <label for="message-text" class="col-form-label" style="font-size: 25px;">ฝ่าย / Division</label>
                    <input type="text" class="form-control" id="division" runat="server" disabled="disabled" />
                  </div>

              </ContentTemplate>
          </asp:UpdatePanel>

          <div class="form-group">
            <label for="message-text" class="col-form-label" style="font-size: 20px;">1. ในระหว่างวันหยุดที่ผ่านมา ข้าพเจ้าพักอยู่บ้าน โดยมิได้มีการเดินทางข้ามจังหวัด / During passed holidays I stayed at home and did not travel between provinces.</label>
            <div class="row col-12 text-center">
                <div class="col-6 h3">
                    <input type="radio" style="width: 30px; height: 30px;" name="no1" value="0" id="no1y" runat="server"/>ใช่
                </div>
                <div class="col-6 h3">
                    <input type="radio" style="width: 30px; height: 30px;" name="no1" value="1" id="no1n" runat="server"/>ไม่ใช่
                </div>
                </div>
            </div>
          </div>
          <div class="form-group">
            <label for="message-text" class="col-form-label" style="font-size: 20px;">2. ในระหว่างวันหยุดที่ผ่านมา ข้าพเจ้ามิได้มีการใกล้ชิดหรือสัมผัสกับผู้ป่วยเข้าข่ายหรือยืนยันโรคติดเชื้อโควิด-19/ During passed holidays, I did not close or contact to the suspect or patient of Covid-19</label>
            <div class="row col-12 text-center">
                <div class="col-6 h3">
                    <input type="radio" style="width: 30px; height: 30px;" name="no2" value="0" id="no2y" runat="server"/>ใช่
                </div>
                <div class="col-6 h3">
                    <input type="radio" style="width: 30px; height: 30px;" name="no2" value="1" id="no2n"  runat="server"/>ไม่ใช่
                </div>
                </div>
          </div>
          <div class="form-group">
            <label for="message-text" class="col-form-label" style="font-size: 20px;">3. ในระหว่างวันหยุดที่ผ่านมา ข้าพเจ้ามิได้มีกิจกรรม หรือ เดินทางไปในสถานที่เสี่ยงต่อการติดโรคโควิด-19 เช่น
                ตลาดนัด สนามชนไก่ โรงพยาบาล พบปะญาติ เพื่อนที่มาจากต่างประเทศ จัดเลี้ยงสังสรรค์กับเพื่อน หรือญาติ ร่วมงานเทศกาลสงกรานต์ ร่วมกิจกรรมทางศาสนา หรือร่วมพิธีศพ เป็นต้น/ During passed holidays I did not have activities or travelled to the place that are the risk of Covid-19 e.g. Market fair, Cockpit, Hospital, Meet the relatives or friends from aboard, Party with friends or relatives, join Songkran festival, join the ritualistic ceremony or funeral ceremony etc.</label>
            <div class="row col-12 text-center">
                <div class="col-6 h3">
                    <input type="radio" style="width: 30px; height: 30px;" name="no3" value="0" id="no3y"  runat="server"/>ใช่
                </div>
                <div class="col-6 h3">
                    <input type="radio" style="width: 30px; height: 30px;" name="no3" value="1" id="no3n" runat="server"/>ไม่ใช่
                </div>
                </div>
          </div>
          <div class="form-group">
            <label for="message-text" class="col-form-label" style="font-size: 20px;">4. ในระหว่างวันหยุดที่ผ่านมา จน ถึงปัจจุบัน ข้าพเจ้าไม่มีอาการผิดปกติ เช่น ไข้ ไอ เจ็บคอ มีน้ามูก หายใจหอบเหนื่อย/ From the passed holidays until now I have never had symptoms e.g. fever, cough, runny nose, dyspnea etc.
                ถ้าตอบว่า “ไม่ใช่” โปรดระบุอาการ / If “No”, please specify</label>
            <div class="row col-12 text-center">
                <div class="col-6 h3">
                    <input type="radio" style="width: 30px; height: 30px;" name="no4" value="0" id="no4y" onclick="myFunction()"  runat="server"/>ใช่
                </div>

                <div class="col-6 h3">                                  
                    <input type="radio" style="width: 30px; height: 30px;" name="no4" value="1" id="no4n" onclick="myFunction()" runat="server"/>ไม่ใช่
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
            <label for="message-text" class="col-form-label" style="font-size: 20px;">5. ในระหว่างวันหยุดที่ผ่านมา หากข้าพเจ้ามีความจำเป็นต้องออกจากที่พักอาศัย ข้าพเจ้ามีการสวมหน้ากากอนามัยทุกครั้ง และหมั่นล้างมือทาความสะอาดด้วยสบู่ หรือ แอลกอฮอล์/ During passed holidays when I had necessary to go outside, I wore mask every time and washed hand with soap or cleaned with alcohol.</label>
            <div class="row col-12 text-center">
                <div class="col-6 h3">
                    <input type="radio" style="width: 30px; height: 30px;" name="no5" value="yes" id="no5y"  runat="server"/>ใช่
                </div>
                <div class="col-6 h3">
                    <input type="radio" style="width: 30px; height: 30px;" name="no5" value="no" id="no5n" runat="server"/>ไม่ใช่
                </div>
                </div>
          </div>
          <div class="form-group">
            <label for="message-text" class="col-form-label" style="font-size: 20px;">6. ข้าพเจ้าคิดว่าตนเองมีความเสี่ยงต่อการติดโรคโควิด-19 หรือไม่ / I think that I have the risk to infect Covid-19 ถ้าตอบว่า “ใช่” โปรดระบุเหตุผล / If “Yes”, please specify the reason</label>
            <div class="row col-12 text-center">
                <div class="col-6 h3">
                    <input type="radio" style="width: 30px; height: 30px;" name="no6" value="yes"  id="no6y" onclick="myFunction1()" runat="server"/>ใช่
                </div>
                <div class="col-6 h3">
                    <input type="radio" style="width: 30px; height: 30px;" name="no6" value="no" id="no6n" onclick="myFunction1()"  runat="server"/>ไม่ใช่
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
                    var emp = document.getElementById("<%= employeeid.ClientID %>");
                    var posi = document.getElementById("<%= position.ClientID %>");       
                    var dept = document.getElementById("<%= department.ClientID %>");
                    var div = document.getElementById("<%= division.ClientID %>");
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


                    if (fname.value == "" || lname.value == "" || emp.value == "" || dept.value == "") { 
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
                            var empname = document.getElementById("<%= lbl_emp.ClientID %>");
                            var posiname = document.getElementById("<%= lbl_posi.ClientID %>");
                            var deptname = document.getElementById("<%= lbl_dept.ClientID %>");
                            var divname = document.getElementById("<%= lbl_div.ClientID %>");
                            var lblno4 = document.getElementById("<%= lbl_no4.ClientID %>");
                            var lblno6 = document.getElementById("<%= lbl_no6.ClientID %>");
                            var lblsign = document.getElementById("<%= lbl_signed.ClientID %>");
                            lblname.innerText = " " + fname.value + " " + lname.value + " " ;
                            empname.innerText = " " + emp.value + " " ;
                            posiname.innerText = " " + posi.value + " " ;
                            deptname.innerText = " " + dept.value + " " ;
                            divname.innerText = " " + div.value + " " ;
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

</div>

</asp:Content>
