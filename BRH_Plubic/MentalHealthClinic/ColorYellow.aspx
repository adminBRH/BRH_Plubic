<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ColorYellow.aspx.cs" Inherits="BRH_Plubic.MentalHealthClinic.ColorYellow" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">
<style>
input[type=radio] {
    border: 0px;
    width: 2em;
    height: 2em;
}
</style>
    <div class="col-12" id="printableArea" runat="server">
    <div class="card-header col-8 mx-auto h5" style="background-color:lemonchiffon">
        <div class="container d-flex align-items-center flex-column mb-1">
            <h2>แบบประเมินปัจจัยก่อความเครียด</h2>
        </div>
    </div>
        <div class="card col-8 mx-auto h5" >        
             <div class="card-body"> 
                 <div class="text-center"><h4>กรุณากดเลือกที่ช่อง <input type="radio" id="testest" /> หน้าหัวข้อต่อไปนี้ ที่เป็นปัญหาสำหรับคุณในช่วง 1 สัปดาห์ที่ผ่านมารวมถึงวันนี้</h4> </div>
                 <!-- หัว Colum 1  -->
                      <div class="row" >
                            <div class="card-header col-2 mx-auto text-center" style="background-color:lemonchiffon">
                                <h4>ไม่มี</h4>
                            </div>
                            <div class="card-header col-2 mx-auto text-center" style="background-color:lemonchiffon">
                                <h4>มี</h4>
                            </div> 
                            <div class="card-header col-8 mx-auto h5" style="background-color:lemonchiffon">
                                <h4>ปัญหาทางกาย</h4>
                            </div>
                        <div class="w-100"></div>
                          <!-- คำตอบ  -->
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_1_1" name="Yel_1" value="0" />          
                            </div>
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_1_2" name="Yel_1" value="1" />
                            </div> 
                            <div class="card-header col-8 mx-auto h5" style="background-color:azure">
                                1. ระบบหายใจ เช่น หายใจไม่อิ่ม                       
                            </div>
                           <!--  คำตอบ -->
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_2_1" name="Yel_2" value="0"/>          
                            </div>
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_2_2" name="Yel_2" value="1"/>
                            </div>     
                            <div class="card-header col-8 mx-auto h5" style="background-color:azure">
                                2. ระบบทางเดินอาหาร เช่น ทานอาหารมากขึ้น , ทานอาหารน้อยลง                      
                            </div> 
                          <!--  คำตอบ -->
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_3_1" name="Yel_3" value="0"/>          
                            </div>
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_3_2" name="Yel_3" value="1"/>
                            </div>     
                            <div class="card-header checked col-8 mx-auto h5" style="background-color:azure">
                               3. ระบบกล้ามเนื้อ เช่น ปวดตามร่างกาย (ศีรษะ/แขน/ขา) , ชาตามร่างกาย                    
                            </div> 
                          <!--  คำตอบ -->
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_4_1" name="Yel_4" value="0"/>          
                            </div>
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_4_2" name="Yel_4" value="1"/>
                            </div>     
                            <div class="card-header checked col-8 mx-auto h5" style="background-color:azure">
                               4. การนอน                     
                            </div> 
                          <!--  คำตอบ -->
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_5_1" name="Yel_5" value="0"/>          
                            </div>
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_5_2" name="Yel_5" value="1"/>
                            </div>     
                            <div class="card-header checked col-8 mx-auto h5" style="background-color:azure">
                              5. สมาธิ/ความจำ                       
                            </div> 
                          <!--  คำตอบ -->
                          <!-- หัวข้อที่สอง -->
                          <div class="card-header col-2 mx-auto text-center" style="background-color:lemonchiffon">        
                              <h4>ไม่มี</h4>
                            </div>
                            <div class="card-header col-2 mx-auto text-center" style="background-color:lemonchiffon">
                              <h4>มี</h4>
                            </div> 
                            <div class="card-header col-8 mx-auto h5" style="background-color:lemonchiffon">
                                <h4>ปัญหาทางอารมณ์</h4>
                            </div>
                            <!--  คำตอบ -->
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_6_1" name="Yel_6" value="0"/>          
                            </div>
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_6_2" name="Yel_6" value="1"/>
                            </div>     
                            <div class="card-header col-8 mx-auto h5" style="background-color:azure">
                              6. ความรู้สึกเศร้า/เสียใจ                       
                            </div> 
                          <!--  คำตอบ -->
                          <!--  คำตอบ -->
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_7_1" name="Yel_7" value="0"/>          
                            </div>
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_7_2" name="Yel_7" value="1"  />
                            </div>     
                            <div class="card-header col-8 mx-auto h5" style="background-color:azure">
                               7. ความหดหู่/สะเทือนใจ                      
                            </div> 
                          <!--  คำตอบ -->
                          <!--  คำตอบ -->
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_8_1" name="Yel_8" value="0"/>          
                            </div>
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_8_2" name="Yel_8" value="1" />
                            </div>     
                            <div class="card-header col-8 mx-auto h5" style="background-color:azure">
                               8. ความสนใจในกิจวัตรประจำวันลดลง : อารมณ์เบื่อ/เซ็ง                     
                            </div> 
                            <!--  คำตอบ -->
                            <!--  คำตอบ -->
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_9_1" name="Yel_9" value="0" />          
                            </div>
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_9_2" name="Yel_9" value="1"  />
                            </div>     
                            <div class="card-header col-8 mx-auto h5" style="background-color:azure">
                               9. กังวลใจ , กระวนกระวาย                     
                            </div> 
                          <!--  คำตอบ -->
                          <!--  คำตอบ -->
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_10_1" name="Yel_10" value="0"  />          
                            </div>
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_10_2" name="Yel_10" value="1" />
                            </div>     
                            <div class="card-header col-8 mx-auto h5" style="background-color:azure">
                               10. หวาดกลัว                      
                            </div> 


                          <!--  คำตอบ -->
                           <div class="card-header col-2 mx-auto text-center" style="background-color:lemonchiffon">        
                              <h4>ไม่มี</h4>
                            </div>
                            <div class="card-header col-2 mx-auto text-center" style="background-color:lemonchiffon">
                              <h4>มี</h4>
                            </div> 
                            <div class="card-header col-8 mx-auto h5" style="background-color:lemonchiffon">
                                <h4>ปัญหาทางสังคม & สิ่งแวดล้อม</h4>
                            </div>
                            <!--  คำตอบ -->
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_11_1" name="Yel_11" value="0" />          
                            </div>
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_11_2" name="Yel_11"  value="1"  />
                            </div>     
                            <div class="card-header col-8 mx-auto h5" style="background-color:azure">
                               11. การเงิน/ค่าใช้จ่าย                      
                            </div> 
                          <!--  คำตอบ -->
                          <!--  คำตอบ -->
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_12_1" name="Yel_12" value="0"  />          
                            </div>
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_12_2" name="Yel_12" value="1"  />
                            </div>     
                            <div class="card-header col-8 mx-auto h5" style="background-color:azure">
                               12. การทำงาน / การเรียน                       
                            </div> 
                          <!--  คำตอบ -->
                          <!--  คำตอบ -->
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_13_1" name="Yel_13" value="0"  />          
                            </div>
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_13_2" name="Yel_13" value="1"  />
                            </div>     
                            <div class="card-header col-8 mx-auto h5" style="background-color:azure">
                               13. ที่อยู่อาศัย                    
                            </div> 
                          <!--  คำตอบ -->
                          <!--  คำตอบ -->
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_14_1" name="Yel_14" value="0"  />          
                            </div>
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_14_2" name="Yel_14" value="1"  />
                            </div>     
                            <div class="card-header col-8 mx-auto h5" style="background-color:azure">
                               14. ปฏิสัมพันธ์กับคนรอบข้าง                     
                            </div> 
                          <!--  คำตอบ -->  
                          <!--  คำตอบ -->
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_15_1" name="Yel_15" value="0"  />          
                            </div>
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_15_2" name="Yel_15" value="1"  />
                            </div>     
                            <div class="card-header col-8 mx-auto h5" style="background-color:azure">
                               15. การจัดการในครอบครัว                   
                            </div> 
                          <!--  คำตอบ -->
                          <!-- หัวข้อที่สาม -->
                         <%-- <div class="card-header col-2 mx-auto text-center" style="background-color:lemonchiffon">
                              <h4>มี</h4>
                            </div>
                            <div class="card-header col-2 mx-auto text-center" style="background-color:lemonchiffon"> 
                              <h4>ไม่มี</h4>  
                            </div> 
                            <div class="card-header col-8 mx-auto h5" style="background-color:lemonchiffon">
                                <h4>ปัญหาทางร่างกาย</h4>
                            </div>
                            <!--  คำตอบ -->
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_16_1" name="Yel_16" value="0"  />          
                            </div>
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_16_2" name="Yel_16" value="1"  />
                            </div>     
                            <div class="card-header col-8 mx-auto h5" style="background-color:azure">
                                รูปลักษณ์ภายนอกมีการเปลี่ยนแปลง เช่น ผมร่วง,มีการเปลี่ยนแปลงสีผิว                       
                            </div> 
                          <!--  คำตอบ -->
                          <!--  คำตอบ -->
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_17_1" name="Yel_17" value="0" />          
                            </div>
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_17_2" name="Yel_17" value="1"  />
                            </div>     
                            <div class="card-header col-8 mx-auto h5" style="background-color:azure">
                                การอาบน้ำ / การแต่งตัว                      
                            </div> 
                          <!--  คำตอบ -->
                          <!--  คำตอบ -->
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_18_1" name="Yel_18" value="0" />          
                            </div>
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_18_2" name="Yel_18" value="1" />
                            </div>     
                            <div class="card-header col-8 mx-auto h5" style="background-color:azure">
                                การหายใจ                     
                            </div> 
                          <!--  คำตอบ -->
                          <!--  คำตอบ -->
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_19_1" name="Yel_19" value="0"  />          
                            </div>
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_19_2" name="Yel_19" value="1"  />
                            </div>     
                            <div class="card-header col-8 mx-auto h5" style="background-color:azure">
                                มีการเปลี่ยนแปลงการถ่ายปัสสาวะ                       
                            </div> 
                          <!--  คำตอบ -->
                          <!--  คำตอบ -->
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_20_1" name="Yel_20" value="0"  />          
                            </div>
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_20_2" name="Yel_20" value="1"  />
                            </div>     
                            <div class="card-header col-8 mx-auto h5" style="background-color:azure">
                                ท้องผูก                       
                            </div> 
                          <!--  คำตอบ -->
                          <!--  คำตอบ -->
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_21_1" name="Yel_21" value="0"  />          
                            </div>
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_21_2" name="Yel_21" value="1"  />
                            </div>     
                            <div class="card-header col-8 mx-auto h5" style="background-color:azure">
                                ท้องเสีย                       
                            </div> 
                          <!--  คำตอบ -->
                          <!--  คำตอบ -->
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_22_1" name="Yel_22" value="0"  />          
                            </div>
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_22_2" name="Yel_22" value="1"  />
                            </div>     
                            <div class="card-header col-8 mx-auto h5" style="background-color:azure">
                                การรับประทานอาหาร                       
                            </div> 
                          <!--  คำตอบ -->
                          <!--  คำตอบ -->
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_23_1" name="Yel_23" value="0" />          
                            </div>
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_23_2" name="Yel_23" value="1"  />
                            </div>     
                            <div class="card-header col-8 mx-auto h5" style="background-color:azure">
                                ความรู้สึกเพลีย / อ่อนล้า                       
                            </div> 
                          <!--  คำตอบ -->
                          <!--  คำตอบ -->
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_24_1" name="Yel_24" value="0"  />          
                            </div>
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_24_2" name="Yel_24" value="1"  />
                            </div>     
                            <div class="card-header col-8 mx-auto h5" style="background-color:azure">
                                บวม                       
                            </div> 
                          <!--  คำตอบ -->
                          <!--  คำตอบ -->
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_25_1" name="Yel_25" value="0"  />          
                            </div>
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_25_2" name="Yel_25" value="1"  />
                            </div>     
                            <div class="card-header col-8 mx-auto h5" style="background-color:azure">
                                มีไข้                       
                            </div> 
                          <!--  คำตอบ -->
                          <!--  คำตอบ -->
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_26_1" name="Yel_26" value="0" />          
                            </div>
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_26_2" name="Yel_26" value="1" />
                            </div>     
                            <div class="card-header col-8 mx-auto h5" style="background-color:azure">
                                การเคลื่อนย้ายตัวเอง เช่น การเดิน,นั่ง,นอน, การเคลื่อนไหวร่างกายเป็นต้น                     
                            </div> 
                          <!--  คำตอบ -->
                          <!--  คำตอบ -->
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_27_1" name="Yel_27" value="0" />          
                            </div>
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_27_2" name="Yel_27" value="1" />
                            </div>     
                            <div class="card-header col-8 mx-auto h5" style="background-color:azure">
                                อาหารไม่ย่อย / ท้องอืด                     
                            </div> 
                          <!--  คำตอบ -->
                          <!--  คำตอบ -->
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_28_1" name="Yel_28" value="0" />          
                            </div>
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_28_2" name="Yel_28" value="1"  />
                            </div>     
                            <div class="card-header col-8 mx-auto h5" style="background-color:azure">
                                ความจำ / สมาธิ                       
                            </div> 
                          <!--  คำตอบ -->
                          <!--  คำตอบ -->
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_29_1" name="Yel_29" value="0" />          
                            </div>
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_29_2" name="Yel_29" value="1" />
                            </div>     
                            <div class="card-header col-8 mx-auto h5" style="background-color:azure">
                                แผลในปาก / ร้อนใน                       
                            </div> 
                          <!--  คำตอบ -->
                          <!--  คำตอบ -->
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_30_1" name="Yel_30" value="0"  />          
                            </div>
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_30_2" name="Yel_30" value="1" />
                            </div>     
                            <div class="card-header col-8 mx-auto h5" style="background-color:azure">
                                คลื่นใส้                       
                            </div> 
                          <!--  คำตอบ -->
                          <!--  คำตอบ -->
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_31_1" name="Yel_31" value="0"  />          
                            </div>
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_31_2" name="Yel_31" value="1"  />
                            </div>     
                            <div class="card-header col-8 mx-auto h5" style="background-color:azure">
                                คัดแน่นจมูก                       
                            </div> 
                          <!--  คำตอบ -->
                          <!--  คำตอบ -->
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_32_1" name="Yel_32" value="0"  />          
                            </div>
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_32_2" name="Yel_32" value="1"  />
                            </div>     
                            <div class="card-header col-8 mx-auto h5" style="background-color:azure">
                                ปวด                      
                            </div> 
                          <!--  คำตอบ -->
                          <!--  คำตอบ -->
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_33_1" name="Yel_33" value="0" />          
                            </div>
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_33_2" name="Yel_33" value="1" />
                            </div>     
                            <div class="card-header col-8 mx-auto h5" style="background-color:azure">
                                ปัญหาเรื่องเพศสัมพันธ์                      
                            </div> 
                          <!--  คำตอบ -->
                          <!--  คำตอบ -->
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_34_1" name="Yel_34" value="0" />          
                            </div>
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_34_2" name="Yel_34" value="1" />
                            </div>     
                            <div class="card-header col-8 mx-auto h5" style="background-color:azure">
                                ผัวหนังแห้ง / คัน                      
                            </div> 
                          <!--  คำตอบ -->
                          <!--  คำตอบ -->
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_35_1" name="Yel_35" value="0" />          
                            </div>
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_35_2" name="Yel_35" value="1" />
                            </div>     
                            <div class="card-header col-8 mx-auto h5" style="background-color:azure">
                                การนอนหลับ                       
                            </div> 
                          <!--  คำตอบ -->
                          <!--  คำตอบ -->
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_36_1" name="Yel_36" value="0"  />          
                            </div>
                            <div class="card-header col-2 mx-auto text-center" style="background-color:azure">
                                <input type="radio"  id="Yel_36_2" name="Yel_36" value="1"  />
                            </div>     
                            <div class="card-header col-8 mx-auto h5" style="background-color:azure">
                                อาการชาตามมือ / เท้า หรืออวัยวะอื่นๆ                       
                            </div> 
                          <!--  คำตอบ -->--%>
                           <!--  คำตอบ -->      
                          <div hidden="hidden">
                              <input type="text" id="txtH_Yel_1" value="0" runat="server"/>                             
                              <input type="text" id="txtH_Yel_2" value="0" runat="server"/>                             
                              <input type="text" id="txtH_Yel_3" value="0" runat="server"/>                             
                              <input type="text" id="txtH_Yel_4" value="0" runat="server"/>                             
                              <input type="text" id="txtH_Yel_5" value="0" runat="server"/>                             
                              <input type="text" id="txtH_Yel_6" value="0" runat="server"/>                             
                              <input type="text" id="txtH_Yel_7" value="0" runat="server"/>                             
                              <input type="text" id="txtH_Yel_8" value="0" runat="server"/>                             
                              <input type="text" id="txtH_Yel_9" value="0" runat="server"/>
                              <input type="text" id="txtH_Yel_10" value="0" runat="server"/>
                              <input type="text" id="txtH_Yel_11" value="0" runat="server"/>
                              <input type="text" id="txtH_Yel_12" value="0" runat="server"/>
                              <input type="text" id="txtH_Yel_13" value="0" runat="server"/>
                              <input type="text" id="txtH_Yel_14" value="0" runat="server"/>
                              <input type="text" id="txtH_Yel_15" value="0" runat="server"/>
                              <%--<input type="text" id="txtH_Yel_16" value="0" runat="server"/>
                              <input type="text" id="txtH_Yel_17" value="0" runat="server"/>
                              <input type="text" id="txtH_Yel_18" value="0" runat="server"/>
                              <input type="text" id="txtH_Yel_19" value="0" runat="server"/>
                              <input type="text" id="txtH_Yel_20" value="0" runat="server"/>
                              <input type="text" id="txtH_Yel_21" value="0" runat="server"/>
                              <input type="text" id="txtH_Yel_22" value="0" runat="server"/>
                              <input type="text" id="txtH_Yel_23" value="0" runat="server"/>
                              <input type="text" id="txtH_Yel_24" value="0" runat="server"/>
                              <input type="text" id="txtH_Yel_25" value="0" runat="server"/>
                              <input type="text" id="txtH_Yel_26" value="0" runat="server"/>
                              <input type="text" id="txtH_Yel_27" value="0" runat="server"/>
                              <input type="text" id="txtH_Yel_28" value="0" runat="server"/>
                              <input type="text" id="txtH_Yel_29" value="0" runat="server"/>
                              <input type="text" id="txtH_Yel_30" value="0" runat="server"/>
                              <input type="text" id="txtH_Yel_31" value="0" runat="server"/>
                              <input type="text" id="txtH_Yel_32" value="0" runat="server"/>
                              <input type="text" id="txtH_Yel_33" value="0" runat="server"/>
                              <input type="text" id="txtH_Yel_34" value="0" runat="server"/>
                              <input type="text" id="txtH_Yel_35" value="0" runat="server"/>
                              <input type="text" id="txtH_Yel_36" value="0" runat="server"/>--%>                              
                          </div>
                     </div>  
                 <div hidden="hidden">
                    <div class="row col-6 mt-3">
                        <div class="col-12 mb-2" style="font-size:x-large">คุณมีปัจจัยก่อความเครียดโดยรวมดังนี้</div>
                        <div class="col-8"><p>ปัญหาทางกาย</p></div>
                        <div class="col-4 text-left"> <asp:Label ID="lbl_summary_1" Text="0" runat="server"></asp:Label> ข้อ</div>
                        <input type="text" id="no1" text="0" runat="server" />
                        <div class="col-8"><p>ปัญหาทางอารมณ์</p></div>
                        <div class="col-4 text-left"> <asp:Label ID="lbl_summary_2" Text="0" runat="server"></asp:Label> ข้อ</div>
                        <input type="text" id="no2" text="0" runat="server" />
                        <div class="col-8"><p>ปัญหาทางสังคม และ สิ่งแวดล้อม</p></div>
                        <div class="col-4 text-left"> <asp:Label ID="lbl_summary_3" Text="0" runat="server"></asp:Label> ข้อ</div>
                        <input type="text" id="no3" text="0" runat="server" />
                    </div>
                    <div class="row col-6">
                        &nbsp;
                    </div>
                </div>
              </div>                   
            </div>
    </div>
     <div class="card-footer col-8 mx-auto text-center bg-warning" onmouseover="GetScore()">
                            <%--<button type="button" class="btn btn-light " id="btn_submit1" onmouseover="GetScore()" onserverclick="btn_submit1_ServerClick" runat="server">Submit</button>--%>
                            <button id="btn_submit_yellow" onserverclick="btn_submit_yellow_ServerClick" class="col-lg-3 col-sm-8 btn btn-light" runat="server">SUBMIT</button>
                    </div>
                    <div hidden="hidden" >
                        <input type="text" id="txtH_link" value="" runat="server" />
                        <asp:Label ID="lb_script" Text="" runat="server"></asp:Label>
                    </div>
                     <div hidden="hidden" >
                                <input type="text" id="Text1" value="" runat="server" />
                                <asp:Label ID="Label1" Text="" runat="server"></asp:Label>
                    </div>
                     <div class="col-11 mx-auto text-center mt-5" visible="true" runat="server">
                            <asp:Button ID="btn_next11" Text="ถัดไป" CssClass="btn btn-light" OnClick="btn_next11_Click" runat="server" />
                     </div>
                        <div class="col-11 mx-auto text-center mt-5" visible="true" runat="server">
                            <asp:Button ID="printdiv"  Text="Print" CssClass="btn btn-info" OnClientClick="printDiv()" runat="server" />
                        </div>
            <script>
                function GetScore() {

                    var score1 = LoopVal('Yel_1');
                    var score2 = LoopVal('Yel_2');
                    var score3 = LoopVal('Yel_3');
                    var score4 = LoopVal('Yel_4');
                    var score5 = LoopVal('Yel_5');
                    var score6 = LoopVal('Yel_6');
                    var score7 = LoopVal('Yel_7');
                    var score8 = LoopVal('Yel_8');
                    var score9 = LoopVal('Yel_9');
                    var score10 = LoopVal('Yel_10');
                    var score11 = LoopVal('Yel_11');
                    var score12 = LoopVal('Yel_12');
                    var score13 = LoopVal('Yel_13');
                    var score14 = LoopVal('Yel_14');
                    var score15 = LoopVal('Yel_15');
                    //var score16 = LoopVal('Yel_16');
                    //var score17 = LoopVal('Yel_17');
                    //var score18 = LoopVal('Yel_18');
                    //var score19 = LoopVal('Yel_19');
                    //var score20 = LoopVal('Yel_20');
                    //var score21 = LoopVal('Yel_21');
                    //var score22 = LoopVal('Yel_22');
                    //var score23 = LoopVal('Yel_23');
                    //var score24 = LoopVal('Yel_24');
                    //var score25 = LoopVal('Yel_25');
                    //var score26 = LoopVal('Yel_26');
                    //var score27 = LoopVal('Yel_27');
                    //var score28 = LoopVal('Yel_28');
                    //var score29 = LoopVal('Yel_29');
                    //var score30 = LoopVal('Yel_30');
                    //var score31 = LoopVal('Yel_31');
                    //var score32 = LoopVal('Yel_32');
                    //var score33 = LoopVal('Yel_33');
                    //var score34 = LoopVal('Yel_34');
                    //var score35 = LoopVal('Yel_35');
                    //var score36 = LoopVal('Yel_36');

                    var txt_1 = document.getElementById('<%= txtH_Yel_1.ClientID %>');
                    var txt_2 = document.getElementById('<%= txtH_Yel_2.ClientID %>');
                    var txt_3 = document.getElementById('<%= txtH_Yel_3.ClientID %>');
                    var txt_4 = document.getElementById('<%= txtH_Yel_4.ClientID %>');
                    var txt_5 = document.getElementById('<%= txtH_Yel_5.ClientID %>');
                    var txt_6 = document.getElementById('<%= txtH_Yel_6.ClientID %>');
                    var txt_7 = document.getElementById('<%= txtH_Yel_7.ClientID %>');
                    var txt_8 = document.getElementById('<%= txtH_Yel_8.ClientID %>');
                    var txt_9 = document.getElementById('<%= txtH_Yel_9.ClientID %>');
                    var txt_10 = document.getElementById('<%= txtH_Yel_10.ClientID %>');
                    var txt_11 = document.getElementById('<%= txtH_Yel_11.ClientID %>');
                    var txt_12 = document.getElementById('<%= txtH_Yel_12.ClientID %>');
                    var txt_13 = document.getElementById('<%= txtH_Yel_13.ClientID %>');
                    var txt_14 = document.getElementById('<%= txtH_Yel_14.ClientID %>');
                    var txt_15 = document.getElementById('<%= txtH_Yel_15.ClientID %>');
                   <%-- var txt_16 = document.getElementById('<%= txtH_Yel_16.ClientID %>');
                    var txt_17 = document.getElementById('<%= txtH_Yel_17.ClientID %>');
                    var txt_18 = document.getElementById('<%= txtH_Yel_18.ClientID %>');
                    var txt_19 = document.getElementById('<%= txtH_Yel_19.ClientID %>');
                    var txt_20 = document.getElementById('<%= txtH_Yel_20.ClientID %>');
                    var txt_21 = document.getElementById('<%= txtH_Yel_21.ClientID %>');
                    var txt_22 = document.getElementById('<%= txtH_Yel_22.ClientID %>');
                    var txt_23 = document.getElementById('<%= txtH_Yel_23.ClientID %>');
                    var txt_24 = document.getElementById('<%= txtH_Yel_24.ClientID %>');
                    var txt_25 = document.getElementById('<%= txtH_Yel_25.ClientID %>');
                    var txt_26 = document.getElementById('<%= txtH_Yel_26.ClientID %>');
                    var txt_27 = document.getElementById('<%= txtH_Yel_27.ClientID %>');
                    var txt_28 = document.getElementById('<%= txtH_Yel_28.ClientID %>');
                    var txt_29 = document.getElementById('<%= txtH_Yel_29.ClientID %>');
                    var txt_30 = document.getElementById('<%= txtH_Yel_30.ClientID %>');
                    var txt_31 = document.getElementById('<%= txtH_Yel_31.ClientID %>');
                    var txt_32 = document.getElementById('<%= txtH_Yel_32.ClientID %>');
                    var txt_33 = document.getElementById('<%= txtH_Yel_33.ClientID %>');
                    var txt_34 = document.getElementById('<%= txtH_Yel_34.ClientID %>');
                    var txt_35 = document.getElementById('<%= txtH_Yel_35.ClientID %>');
                    var txt_36 = document.getElementById('<%= txtH_Yel_36.ClientID %>');--%>
                    
                    txt_1.value = score1;
                    txt_2.value = score2;
                    txt_3.value = score3;
                    txt_4.value = score4;
                    txt_5.value = score5;
                    txt_6.value = score6;
                    txt_7.value = score7;
                    txt_8.value = score8;
                    txt_9.value = score9;
                    txt_10.value = score10;
                    txt_11.value = score11;
                    txt_12.value = score12;
                    txt_13.value = score13;
                    txt_14.value = score14;
                    txt_15.value = score15;
                    //txt_16.value = score16;
                    //txt_17.value = score17;
                    //txt_18.value = score18;
                    //txt_19.value = score19;
                    //txt_20.value = score20;
                    //txt_21.value = score21;
                    //txt_22.value = score22;
                    //txt_23.value = score23;
                    //txt_24.value = score24;
                    //txt_25.value = score25;
                    //txt_26.value = score26;
                    //txt_27.value = score27;
                    //txt_28.value = score28;
                    //txt_29.value = score29;
                    //txt_30.value = score30;
                    //txt_31.value = score31;
                    //txt_32.value = score32;
                    //txt_33.value = score33;
                    //txt_34.value = score34;
                    //txt_35.value = score35;
                    //txt_36.value = score36;

                    var score_1 = parseInt(score1) + parseInt(score2) + parseInt(score3) + parseInt(score4) + parseInt(score5);
                    var score_2 = parseInt(score6) + parseInt(score7) + parseInt(score8) + parseInt(score9) + parseInt(score10);
                    var score_3 = parseInt(score11) + parseInt(score12) + parseInt(score13) + parseInt(score14) + parseInt(score15);
                    
                    var sumscore = parseInt(score_1) + parseInt(score_2) + parseInt(score_3);
                    //+ parseInt(score16) + parseInt(score17) + parseInt(score18) + parseInt(score19) + parseInt(score20) + parseInt(score21) + parseInt(score22) + parseInt(score23) + parseInt(score24) + parseInt(score25) + parseInt(score26) + parseInt(score27) + parseInt(score28) + parseInt(score29) + parseInt(score30) + parseInt(score31) + parseInt(score32) + parseInt(score33) + parseInt(score34) + parseInt(score35) + parseInt(score36)
                    
                    var sum_1 = document.getElementById('<%= lbl_summary_1.ClientID %>');
                    var sum_2 = document.getElementById('<%= lbl_summary_2.ClientID %>');
                    var sum_3 = document.getElementById('<%= lbl_summary_3.ClientID %>');
                    var sum_txtbox1 = document.getElementById('<%= no1.ClientID %>');
                    var sum_txtbox2 = document.getElementById('<%= no2.ClientID %>');
                    var sum_txtbox3 = document.getElementById('<%= no3.ClientID %>');

                    sum_1.innerText = score_1;
                    sum_2.innerText = score_2;
                    sum_3.innerText = score_3;
                    sum_txtbox1.value = score_1;
                    sum_txtbox2.value = score_2;
                    sum_txtbox3.value = score_3;

                    var txtlink = document.getElementById('<%= txtH_link.ClientID %>');

                    if (parseInt(sumscore) >= 0) {
                        //window.location.href = "Yellow.aspx";
                        txtlink.value = "Yellow";
                    }  else {
                        //window.location.href = "GAD7Negative.aspx";
                        txtlink.value = "Negative";
                    }
                }

                function LoopVal(id) {
                    var result = 0;
                    for (var i = 0; i < 2; i++) {
                        if (document.getElementsByName(id)[i].checked) {
                            result = document.getElementsByName(id)[i].value;
                            break;
                        }
                    }
                    return result;
                }
                
            </script>
          

    <script>
        function printDiv() {
            var printContents = document.getElementById("<%= printableArea.ClientID %>").innerHTML;
            var originalContents = document.body.innerHTML;
            document.body.innerHTML = printContents;
            PrintReport();
            window.print();
            document.body.innerHTML = originalContents;
            PrintReport();
        }
    </script>
        
</asp:Content>
