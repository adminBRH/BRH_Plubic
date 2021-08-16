<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SPST20.aspx.cs" Inherits="BRH_Plubic.MentalHealthClinic.SPST20" %>
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
    <div class="card-header col-10 mx-auto" style="background-color:paleturquoise">
        <div class="container d-flex align-items-center flex-column mb-1">
            <h2>แบบประเมินความเครียด (SPST20)</h2>

        </div>
    </div>
        <div class="card col-10 mx-auto">        
             <div class="card-body">
                 <div class="text-left"><h4>ในระยะเวลา 6 เดือนที่ผ่านมามีเหตุการณ์ข้อใดเกิดขึ้นกับคุณบ้าง และคุณรู้สึกอย่างไรต่อเหตุการณ์นั้น ให้เลือกตัวเลือกลงในช่องระดับความเครียด "ถ้าข้อไหนไม่ได้เกิดขึ้นให้ข้ามไปไม่ต้องตอบ"</h4>
                     <h6>ระดับความเครียด</h6>
                     <h6>1 หมายถึง ไม่รู้สึกเครียด</h6>
                     <h6>2 หมายถึง รู้สึกเครียดเล็กน้อย</h6>
                     <h6>3 หมายถึง รู้สึกเครียดปานกลาง</h6>
                     <h6>4 หมายถึง รู้สึกเครียดมาก </h6>
                     <h6>5 หมายถึง รู้สึกเครียดมากที่สุด</h6>
                 </div>
                 <div class="row" >
                            <div class="card-header col-7 mx-auto text-center " style="background-color:paleturquoise">                                
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:ivory">       
                                ไม่รู้สึกเครียด
                            </div> 
                            <div class="card-header col-1 mx-auto text-center" style="background-color:lemonchiffon">  
                                รู้สึกเครียดเล็กน้อย
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:lightsalmon">  
                                รู้สึกเครียดปานกลาง
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:darkorange">  
                                รู้สึกเครียดมาก
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:orangered">  
                                รู้สึกเครียดมากที่สุด
                            </div>
                                <div class="w-100"></div>
                                  <!-- หัวข้อถัดไป -->
                                        <div class="card-header col-7 mx-auto text-left" style="background-color:honeydew">
                                            <h4>1. กลัวทำงานผิดพลาด</h4>
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:ivory">                              
                                            <input type="radio" id="SPST20_1_1"  name="SPST20_1" value="1"  />&nbsp;1                                                        
                                        </div> 
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:lemonchiffon">
                                            <input type="radio" id="SPST20_1_02" name="SPST20_1" value="2"  />&nbsp;2 
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:lightsalmon">
                                            <input type="radio" id="SPST20_1_03" name="SPST20_1" value="3"  />&nbsp;3  
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:darkorange">
                                            <input type="radio" id="SPST20_1_04" name="SPST20_1" value="4"  />&nbsp;4  
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:orangered">
                                            <input type="radio" id="SPST20_1_05" name="SPST20_1" value="5"  />&nbsp;5  
                                        </div>
                                        <!-- หัวข้อถัดไป -->
                                        <!-- หัวข้อถัดไป -->
                                        <div class="card-header col-7 mx-auto text-left" style="background-color:honeydew">
                                            <h4>2. ไปไม่ถึงเป้าหมายที่วางไว้</h4>
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:ivory">                              
                                            <input type="radio" id="SPST20_2_1"  name="SPST20_2" value="1" />&nbsp;1                                                        
                                        </div> 
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:lemonchiffon">
                                            <input type="radio" id="SPST20_2_02" name="SPST20_2" value="2"  />&nbsp;2 
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:lightsalmon">
                                            <input type="radio" id="SPST20_2_03" name="SPST20_2" value="3" />&nbsp;3  
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:darkorange">
                                            <input type="radio" id="SPST20_2_04" name="SPST20_2" value="4"  />&nbsp;4  
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:orangered">
                                            <input type="radio" id="SPST20_2_05" name="SPST20_2" value="5"  />&nbsp;5  
                                        </div>
                                        <!-- หัวข้อถัดไป -->
                                        <!-- หัวข้อถัดไป -->
                                        <div class="card-header col-7 mx-auto text-left" style="background-color:honeydew">
                                            <h4>3. ครอบครัวมีความขัดแย้งกันในเรื่องเงินหรือเรื่องงานในบ้าน</h4>
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:ivory">                              
                                            <input type="radio" id="SPST20_3_1"  name="SPST20_3" value="1"  />&nbsp;1                                                        
                                        </div> 
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:lemonchiffon">
                                            <input type="radio" id="SPST20_3_02" name="SPST20_3" value="2"  />&nbsp;2 
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:lightsalmon">
                                            <input type="radio" id="SPST20_3_03" name="SPST20_3" value="3"  />&nbsp;3  
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:darkorange">
                                            <input type="radio" id="SPST20_3_04" name="SPST20_3" value="4"  />&nbsp;4  
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:orangered">
                                            <input type="radio" id="SPST20_3_05" name="SPST20_3" value="5"  />&nbsp;5  
                                        </div>
                                        <!-- หัวข้อถัดไป -->
                                        <!-- หัวข้อถัดไป -->
                                        <div class="card-header col-7 mx-auto text-left" style="background-color:honeydew">
                                            <h4>4. เป็นกังวลกับเรื่องสารพิษหรือมลภาวะในอากาศ น้ำ เสียง และดิน</h4>
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:ivory">                              
                                            <input type="radio" id="SPST20_4_1"  name="SPST20_4" value="1"  />&nbsp;1                                                        
                                        </div> 
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:lemonchiffon">
                                            <input type="radio" id="SPST20_4_02" name="SPST20_4" value="2"  />&nbsp;2 
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:lightsalmon">
                                            <input type="radio" id="SPST20_4_03" name="SPST20_4" value="3"  />&nbsp;3  
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:darkorange">
                                            <input type="radio" id="SPST20_4_04" name="SPST20_4" value="4"  />&nbsp;4  
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:orangered">
                                            <input type="radio" id="SPST20_4_05" name="SPST20_4" value="5"  />&nbsp;5  
                                        </div>
                                        <!-- หัวข้อถัดไป -->
                                        <!-- หัวข้อถัดไป -->
                                        <div class="card-header col-7 mx-auto text-left" style="background-color:honeydew">
                                            <h4>5. รู้สึกว่าต้องแข่งขันหรือเปรียบเทียบ</h4>
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:ivory">                              
                                            <input type="radio" id="SPST20_5_1"  name="SPST20_5" value="1"  />&nbsp;1                                                        
                                        </div> 
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:lemonchiffon">
                                            <input type="radio" id="SPST20_5_02" name="SPST20_5" value="2"  />&nbsp;2 
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:lightsalmon">
                                            <input type="radio" id="SPST20_5_03" name="SPST20_5" value="3"  />&nbsp;3  
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:darkorange">
                                            <input type="radio" id="SPST20_5_04" name="SPST20_5" value="4"  />&nbsp;4  
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:orangered">
                                            <input type="radio" id="SPST20_5_05" name="SPST20_5" value="5"  />&nbsp;5  
                                        </div>
                                        <!-- หัวข้อถัดไป -->
                                        <!-- หัวข้อถัดไป -->
                                        <div class="card-header col-7 mx-auto text-left" style="background-color:honeydew">
                                            <h4>6. เงินไม่พอใช้จ่าย</h4>
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:ivory">                              
                                            <input type="radio" id="SPST20_6_1"  name="SPST20_6" value="1"  />&nbsp;1                                                        
                                        </div> 
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:lemonchiffon">
                                            <input type="radio" id="SPST20_6_02" name="SPST20_6" value="2"  />&nbsp;2 
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:lightsalmon">
                                            <input type="radio" id="SPST20_6_03" name="SPST20_6" value="3"  />&nbsp;3  
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:darkorange">
                                            <input type="radio" id="SPST20_6_04" name="SPST20_6" value="4"  />&nbsp;4  
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:orangered">
                                            <input type="radio" id="SPST20_6_05" name="SPST20_6" value="5"  />&nbsp;5  
                                        </div>
                                        <!-- หัวข้อถัดไป -->
                                        <!-- หัวข้อถัดไป -->
                                        <div class="card-header col-7 mx-auto text-left" style="background-color:honeydew">
                                            <h4>7. กล้ามเนื้อตึงหรือปวด</h4>
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:ivory">                              
                                            <input type="radio" id="SPST20_7_1"  name="SPST20_7" value="1"  />&nbsp;1                                                        
                                        </div> 
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:lemonchiffon">
                                            <input type="radio" id="SPST20_7_02" name="SPST20_7" value="2"  />&nbsp;2 
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:lightsalmon">
                                            <input type="radio" id="SPST20_7_03" name="SPST20_7" value="3"  />&nbsp;3  
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:darkorange">
                                            <input type="radio" id="SPST20_7_04" name="SPST20_7" value="4"  />&nbsp;4  
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:orangered">
                                            <input type="radio" id="SPST20_7_05" name="SPST20_7" value="5"  />&nbsp;5  
                                        </div>
                                        <!-- หัวข้อถัดไป -->
                                        <!-- หัวข้อถัดไป -->
                                        <div class="card-header col-7 mx-auto text-left" style="background-color:honeydew">
                                            <h4>8. ปวดหัวจากความตึงเครียด</h4>
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:ivory">                              
                                            <input type="radio" id="SPST20_8_1"  name="SPST20_8" value="1"  />&nbsp;1                                                        
                                        </div> 
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:lemonchiffon">
                                            <input type="radio" id="SPST20_8_02" name="SPST20_8" value="2"  />&nbsp;2 
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:lightsalmon">
                                            <input type="radio" id="SPST20_8_03" name="SPST20_8" value="3"  />&nbsp;3  
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:darkorange">
                                            <input type="radio" id="SPST20_8_04" name="SPST20_8" value="4"  />&nbsp;4  
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:orangered">
                                            <input type="radio" id="SPST20_8_05" name="SPST20_8" value="5"  />&nbsp;5  
                                        </div>
                                        <!-- หัวข้อถัดไป -->
                                        <!-- หัวข้อถัดไป -->
                                        <div class="card-header col-7 mx-auto text-left" style="background-color:honeydew">
                                            <h4>9. ปวดหลัง</h4>
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:ivory">                              
                                            <input type="radio" id="SPST20_9_1"  name="SPST20_9" value="1"  />&nbsp;1                                                        
                                        </div> 
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:lemonchiffon">
                                            <input type="radio" id="SPST20_9_02" name="SPST20_9" value="2"  />&nbsp;2 
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:lightsalmon">
                                            <input type="radio" id="SPST20_9_03" name="SPST20_9" value="3"  />&nbsp;3  
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:darkorange">
                                            <input type="radio" id="SPST20_9_04" name="SPST20_9" value="4"  />&nbsp;4  
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:orangered">
                                            <input type="radio" id="SPST20_9_05" name="SPST20_9" value="5"  />&nbsp;5  
                                        </div>
                                        <!-- หัวข้อถัดไป -->
                                        <!-- หัวข้อถัดไป -->
                                        <div class="card-header col-7 mx-auto text-left" style="background-color:honeydew">
                                            <h4>10. ความอยากอาหารเปลี่ยนแปลง</h4>
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:ivory">                              
                                            <input type="radio" id="SPST20_10_1"  name="SPST20_10" value="1"  />&nbsp;1                                                        
                                        </div> 
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:lemonchiffon">
                                            <input type="radio" id="SPST20_10_02" name="SPST20_10" value="2"  />&nbsp;2 
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:lightsalmon">
                                            <input type="radio" id="SPST20_10_03" name="SPST20_10" value="3"  />&nbsp;3  
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:darkorange">
                                            <input type="radio" id="SPST20_10_04" name="SPST20_10" value="4"  />&nbsp;4  
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:orangered">
                                            <input type="radio" id="SPST20_10_05" name="SPST20_10" value="5"  />&nbsp;5  
                                        </div>
                                        <!-- หัวข้อถัดไป -->
                                        <!-- หัวข้อถัดไป -->
                                        <div class="card-header col-7 mx-auto text-left" style="background-color:honeydew">
                                            <h4>11. ปวดศีรษะข้างเดียว</h4>
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:ivory">                              
                                            <input type="radio" id="SPST20_11_1"  name="SPST20_11" value="1"  />&nbsp;1                                                        
                                        </div> 
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:lemonchiffon">
                                            <input type="radio" id="SPST20_11_02" name="SPST20_11" value="2"  />&nbsp;2 
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:lightsalmon">
                                            <input type="radio" id="SPST20_11_03" name="SPST20_11" value="3"  />&nbsp;3  
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:darkorange">
                                            <input type="radio" id="SPST20_11_04" name="SPST20_11" value="4"  />&nbsp;4  
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:orangered">
                                            <input type="radio" id="SPST20_11_05" name="SPST20_11" value="5"  />&nbsp;5  
                                        </div>
                                        <!-- หัวข้อถัดไป -->
                                        <!-- หัวข้อถัดไป -->
                                        <div class="card-header col-7 mx-auto text-left" style="background-color:honeydew">
                                            <h4>12. รู้สึกวิตกกังวล</h4>
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:ivory">                              
                                            <input type="radio" id="SPST20_12_1"  name="SPST20_12" value="1"  />&nbsp;1                                                        
                                        </div> 
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:lemonchiffon">
                                            <input type="radio" id="SPST20_12_02" name="SPST20_12" value="2"  />&nbsp;2 
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:lightsalmon">
                                            <input type="radio" id="SPST20_12_03" name="SPST20_12" value="3"  />&nbsp;3  
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:darkorange">
                                            <input type="radio" id="SPST20_12_04" name="SPST20_12" value="4"  />&nbsp;4  
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:orangered">
                                            <input type="radio" id="SPST20_12_05" name="SPST20_12" value="5"  />&nbsp;5  
                                        </div>
                                        <!-- หัวข้อถัดไป -->
                                        <!-- หัวข้อถัดไป -->
                                        <div class="card-header col-7 mx-auto text-left" style="background-color:honeydew">
                                            <h4>13. รู้สึกคับข้องใจ</h4>
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:ivory">                              
                                            <input type="radio" id="SPST20_13_1"  name="SPST20_13" value="1"  />&nbsp;1                                                        
                                        </div> 
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:lemonchiffon">
                                            <input type="radio" id="SPST20_13_02" name="SPST20_13" value="2"  />&nbsp;2 
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:lightsalmon">
                                            <input type="radio" id="SPST20_13_03" name="SPST20_13" value="3"  />&nbsp;3  
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:darkorange">
                                            <input type="radio" id="SPST20_13_04" name="SPST20_13" value="4"  />&nbsp;4  
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:orangered">
                                            <input type="radio" id="SPST20_13_05" name="SPST20_13" value="5"  />&nbsp;5  
                                        </div>
                                        <!-- หัวข้อถัดไป -->
                                        <!-- หัวข้อถัดไป -->
                                        <div class="card-header col-7 mx-auto text-left" style="background-color:honeydew">
                                            <h4>14. รู้สึกโกรธ หรือหงุดหงิด</h4>
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:ivory">                              
                                            <input type="radio" id="SPST20_14_1"  name="SPST20_14" value="1"  />&nbsp;1                                                        
                                        </div> 
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:lemonchiffon">
                                            <input type="radio" id="SPST20_14_02" name="SPST20_14" value="2" />&nbsp;2 
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:lightsalmon">
                                            <input type="radio" id="SPST20_14_03" name="SPST20_14" value="3"  />&nbsp;3  
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:darkorange">
                                            <input type="radio" id="SPST20_14_04" name="SPST20_14" value="4"  />&nbsp;4  
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:orangered">
                                            <input type="radio" id="SPST20_14_05" name="SPST20_14" value="5"  />&nbsp;5  
                                        </div>
                                        <!-- หัวข้อถัดไป -->
                                        <!-- หัวข้อถัดไป -->
                                        <div class="card-header col-7 mx-auto text-left" style="background-color:honeydew">
                                            <h4>15. รู้สึกเศร้า</h4>
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:ivory">                              
                                            <input type="radio" id="SPST20_15_1"  name="SPST20_15" value="1"  />&nbsp;1                                                        
                                        </div> 
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:lemonchiffon">
                                            <input type="radio" id="SPST20_15_02" name="SPST20_15" value="2"  />&nbsp;2 
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:lightsalmon">
                                            <input type="radio" id="SPST20_15_03" name="SPST20_15" value="3"  />&nbsp;3  
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:darkorange">
                                            <input type="radio" id="SPST20_15_04" name="SPST20_15" value="4"  />&nbsp;4  
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:orangered">
                                            <input type="radio" id="SPST20_15_05" name="SPST20_15" value="5"  />&nbsp;5  
                                        </div>
                                        <!-- หัวข้อถัดไป -->
                                        <!-- หัวข้อถัดไป -->
                                        <div class="card-header col-7 mx-auto text-left" style="background-color:honeydew">
                                            <h4>16. ความจำไม่ดี</h4>
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:ivory">                              
                                            <input type="radio" id="SPST20_16_1"  name="SPST20_16" value="1"  />&nbsp;1                                                        
                                        </div> 
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:lemonchiffon">
                                            <input type="radio" id="SPST20_16_02" name="SPST20_16" value="2"  />&nbsp;2 
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:lightsalmon">
                                            <input type="radio" id="SPST20_16_03" name="SPST20_16" value="3"  />&nbsp;3  
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:darkorange">
                                            <input type="radio" id="SPST20_16_04" name="SPST20_16" value="4"  />&nbsp;4  
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:orangered">
                                            <input type="radio" id="SPST20_16_05" name="SPST20_16" value="5"  />&nbsp;5  
                                        </div>
                                        <!-- หัวข้อถัดไป -->
                                        <!-- หัวข้อถัดไป -->
                                        <div class="card-header col-7 mx-auto text-left" style="background-color:honeydew">
                                            <h4>17. รู้สึกสับสน</h4>
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:ivory">                              
                                            <input type="radio" id="SPST20_17_1"  name="SPST20_17" value="1"  />&nbsp;1                                                        
                                        </div> 
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:lemonchiffon">
                                            <input type="radio" id="SPST20_17_02" name="SPST20_17" value="2"  />&nbsp;2 
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:lightsalmon">
                                            <input type="radio" id="SPST20_17_03" name="SPST20_17" value="3"  />&nbsp;3  
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:darkorange">
                                            <input type="radio" id="SPST20_17_04" name="SPST20_17" value="4"  />&nbsp;4  
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:orangered">
                                            <input type="radio" id="SPST20_17_05" name="SPST20_17" value="5"  />&nbsp;5  
                                        </div>
                                        <!-- หัวข้อถัดไป -->
                                        <!-- หัวข้อถัดไป -->
                                        <div class="card-header col-7 mx-auto text-left" style="background-color:honeydew">
                                            <h4>18. ตั้งสมาธิลำบาก</h4>
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:ivory">                              
                                            <input type="radio" id="SPST20_18_1"  name="SPST20_18" value="1"  />&nbsp;1                                                        
                                        </div> 
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:lemonchiffon">
                                            <input type="radio" id="SPST20_18_02" name="SPST20_18" value="2"  />&nbsp;2 
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:lightsalmon">
                                            <input type="radio" id="SPST20_18_03" name="SPST20_18" value="3"  />&nbsp;3  
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:darkorange">
                                            <input type="radio" id="SPST20_18_04" name="SPST20_18" value="4"  />&nbsp;4  
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:orangered">
                                            <input type="radio" id="SPST20_18_05" name="SPST20_18" value="5"  />&nbsp;5  
                                        </div>
                                        <!-- หัวข้อถัดไป -->
                                        <!-- หัวข้อถัดไป -->
                                        <div class="card-header col-7 mx-auto text-left" style="background-color:honeydew">
                                            <h4>19. รู้สึกเหนื่อยง่าย</h4>
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:ivory">                              
                                            <input type="radio" id="SPST20_19_1"  name="SPST20_19" value="1"  />&nbsp;1                                                        
                                        </div> 
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:lemonchiffon">
                                            <input type="radio" id="SPST20_19_02" name="SPST20_19" value="2"  />&nbsp;2 
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:lightsalmon">
                                            <input type="radio" id="SPST20_19_03" name="SPST20_19" value="3"  />&nbsp;3  
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:darkorange">
                                            <input type="radio" id="SPST20_19_04" name="SPST20_19" value="4"  />&nbsp;4  
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:orangered">
                                            <input type="radio" id="SPST20_19_05" name="SPST20_19" value="5"  />&nbsp;5  
                                        </div>
                                        <!-- หัวข้อถัดไป -->
                                        <!-- หัวข้อถัดไป -->
                                        <div class="card-header col-7 mx-auto text-left" style="background-color:honeydew">
                                            <h4>20. เป็นหวัดบ่อยๆ</h4>
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:ivory">                              
                                            <input type="radio" id="SPST20_20_1"  name="SPST20_20" value="1"  />&nbsp;1                                                        
                                        </div> 
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:lemonchiffon">
                                            <input type="radio" id="SPST20_20_02" name="SPST20_20" value="2"  />&nbsp;2 
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:lightsalmon">
                                            <input type="radio" id="SPST20_20_03" name="SPST20_20" value="3"  />&nbsp;3  
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:darkorange">
                                            <input type="radio" id="SPST20_20_04" name="SPST20_20" value="4"  />&nbsp;4  
                                        </div>
                                        <div class="card-header col-1 mx-auto text-center" style="background-color:orangered">
                                            <input type="radio" id="SPST20_20_05" name="SPST20_20" value="5"  />&nbsp;5  
                                        </div>
                                        <!-- คำตอบ -->
                             <div hidden="hidden">
                              <input type="text" id="txtH_SPST20_1" value="0" runat="server"/>                             
                              <input type="text" id="txtH_SPST20_2" value="0" runat="server"/>                             
                              <input type="text" id="txtH_SPST20_3" value="0" runat="server"/>                             
                              <input type="text" id="txtH_SPST20_4" value="0" runat="server"/>                             
                              <input type="text" id="txtH_SPST20_5" value="0" runat="server"/>                             
                              <input type="text" id="txtH_SPST20_6" value="0" runat="server"/>                             
                              <input type="text" id="txtH_SPST20_7" value="0" runat="server"/>                             
                              <input type="text" id="txtH_SPST20_8" value="0" runat="server"/>                             
                              <input type="text" id="txtH_SPST20_9" value="0" runat="server"/>                                                                                     
                              <input type="text" id="txtH_SPST20_10" value="0" runat="server"/>                                                                                     
                              <input type="text" id="txtH_SPST20_11" value="0" runat="server"/>                                                                                     
                              <input type="text" id="txtH_SPST20_12" value="0" runat="server"/>                                                                                     
                              <input type="text" id="txtH_SPST20_13" value="0" runat="server"/>                                                                                     
                              <input type="text" id="txtH_SPST20_14" value="0" runat="server"/>                                                                                     
                              <input type="text" id="txtH_SPST20_15" value="0" runat="server"/>                                                                                     
                              <input type="text" id="txtH_SPST20_16" value="0" runat="server"/>                                                                                     
                              <input type="text" id="txtH_SPST20_17" value="0" runat="server"/>                                                                                     
                              <input type="text" id="txtH_SPST20_18" value="0" runat="server"/>                                                                                     
                              <input type="text" id="txtH_SPST20_19" value="0" runat="server"/>                                                                                     
                              <input type="text" id="txtH_SPST20_20" value="0" runat="server"/>                                                                                     
                          </div>           

                    </div>
                 </div>
             </div>
        </div>
                            <div class="card-footer col-10 mx-auto text-center" onmouseover="GetScore()" style="background-color:lightcoral">
                            <%--<button type="button" class="btn btn-light " id="btn_submit1" onmouseover="GetScore()" onserverclick="btn_submit1_ServerClick" runat="server">Submit</button>--%>
                    <button id="btn_submit_spst20" onserverclick="btn_submit_spst20_ServerClick" class="btn btn-light" runat="server">SUBMIT</button>
                    </div>
                    <div hidden="hidden">
                        <input type="text" id="txtH_link" value="" runat="server" />
                    </div>
                    <div hidden="hidden" >
                                <input type="text" id="Text1" value="" runat="server" />
                                <asp:Label ID="lb_script" Text="" runat="server"></asp:Label>
                    </div>
                    <div class="col-11 mx-auto text-center mt-5" visible="true" runat="server">
                        <asp:Button ID="btn_next11" Text="ถัดไป" CssClass="btn btn-light" OnClick="btn_next11_Click1" runat="server" />
                    </div>
                    <div class="col-11 mx-auto text-center mt-5" visible="true" runat="server">
                             <asp:Button ID="printdiv"  Text="Print" CssClass="btn btn-info" OnClientClick="printDiv()" runat="server" />
                    </div>
                     <%--<div class="col-11 mx-auto text-center mt-5" visible="true" runat="server">
                            <asp:button id="btn_next11" text="ถัดไป" cssclass="btn btn-light" onclick="btn_next11_click" runat="server" />
                     </div>--%>

                  <script>
                      function GetScore() {
                          var score1 = LoopVal('SPST20_1');  // 
                          var score2 = LoopVal('SPST20_2');  // 
                          var score3 = LoopVal('SPST20_3');  // 
                          var score4 = LoopVal('SPST20_4');  // 
                          var score5 = LoopVal('SPST20_5');  // 
                          var score6 = LoopVal('SPST20_6');  // 
                          var score7 = LoopVal('SPST20_7');  // 
                          var score8 = LoopVal('SPST20_8');  // 
                          var score9 = LoopVal('SPST20_9');  // 
                          var score10 = LoopVal('SPST20_10'); // 
                          var score11 = LoopVal('SPST20_11'); // 
                          var score12 = LoopVal('SPST20_12'); // 
                          var score13 = LoopVal('SPST20_13'); // 
                          var score14 = LoopVal('SPST20_14'); // 
                          var score15 = LoopVal('SPST20_15'); // 
                          var score16 = LoopVal('SPST20_16'); // 
                          var score17 = LoopVal('SPST20_17'); // 
                          var score18 = LoopVal('SPST20_18'); // 
                          var score19 = LoopVal('SPST20_19'); //
                          var score20 = LoopVal('SPST20_20'); // 

                          var txt_1 = document.getElementById('<%= txtH_SPST20_1.ClientID %>');
                          var txt_2 = document.getElementById('<%= txtH_SPST20_2.ClientID %>');
                          var txt_3 = document.getElementById('<%= txtH_SPST20_3.ClientID %>');
                          var txt_4 = document.getElementById('<%= txtH_SPST20_4.ClientID %>');
                          var txt_5 = document.getElementById('<%= txtH_SPST20_5.ClientID %>');
                          var txt_6 = document.getElementById('<%= txtH_SPST20_6.ClientID %>');
                          var txt_7 = document.getElementById('<%= txtH_SPST20_7.ClientID %>');
                          var txt_8 = document.getElementById('<%= txtH_SPST20_8.ClientID %>');
                          var txt_9 = document.getElementById('<%= txtH_SPST20_9.ClientID %>');
                          var txt_10 = document.getElementById('<%= txtH_SPST20_10.ClientID %>');
                          var txt_11 = document.getElementById('<%= txtH_SPST20_11.ClientID %>');
                          var txt_12 = document.getElementById('<%= txtH_SPST20_12.ClientID %>');
                          var txt_13 = document.getElementById('<%= txtH_SPST20_13.ClientID %>');
                          var txt_14 = document.getElementById('<%= txtH_SPST20_14.ClientID %>');
                          var txt_15 = document.getElementById('<%= txtH_SPST20_15.ClientID %>');
                          var txt_16 = document.getElementById('<%= txtH_SPST20_16.ClientID %>');
                          var txt_17 = document.getElementById('<%= txtH_SPST20_17.ClientID %>');
                          var txt_18 = document.getElementById('<%= txtH_SPST20_18.ClientID %>');
                          var txt_19 = document.getElementById('<%= txtH_SPST20_19.ClientID %>');
                          var txt_20 = document.getElementById('<%= txtH_SPST20_20.ClientID %>');

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
                          txt_16.value = score16;
                          txt_17.value = score17;
                          txt_18.value = score18;
                          txt_19.value = score19;
                          txt_20.value = score20;
                          

                          var sumscore = parseInt(score1) + parseInt(score2) + parseInt(score3) + parseInt(score4) + parseInt(score5) + parseInt(score6) + parseInt(score7) + parseInt(score8) + parseInt(score9) + parseInt(score10)
                              + parseInt(score11) + parseInt(score12) + parseInt(score13) + parseInt(score14) + parseInt(score15) + parseInt(score16) + parseInt(score17) + parseInt(score18) + parseInt(score19) + parseInt(score20);

                          var txtlink = document.getElementById('<%= txtH_link.ClientID %>');

                          if (parseInt(sumscore) >= 42) {
                              //window.location.href = "SPST20Positive.aspx";
                              txtlink.value = "SPST20Positive";
                          } else {
                              //window.location.href = "SPST20Negative.aspx";
                              txtlink.value = "SPST20Negative";
                          }

                      }

                      function LoopVal(id) {
                          var result = 0;
                          for (var i = 0; i < 5; i++) {
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
