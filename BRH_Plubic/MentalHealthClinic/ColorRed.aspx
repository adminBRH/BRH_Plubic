<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ColorRed.aspx.cs" Inherits="BRH_Plubic.MentalHealthClinic.ColorRed" %>
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
    <div class="card-header col-10 mx-auto" style="background-color:lightcoral">
        <div class="container d-flex align-items-center flex-column mb-1">
            <h2><font color="white">แบบประเมินสุขภาพจิต DASS-21</font></h2>
        </div>
    </div>
        <div class="card col-10 mx-auto">        
             <div class="card-body"> 
                 <div class="text-left"><h4>โปรดอ่านข้อความแต่ละข้อและเลือกเครื่องหมาย <input type="radio" id="heading_1" /> หมายเลข 0, 1, 2, หรือ 3 ที่ระบุข้อความได้ตรงกับความรู้สึกของท่านมากที่สุด <u>ในช่วง 2 สัปดาห์ที่ผ่านมา</u></h4><br />
                     <h4>ทั้งนี้ ไม่มีคำตอบที่ถูก หรือคำตอบที่ผิด ท่านไม่ควรใช้เวลานานมากนักในแต่ละข้อความ</h4><br />
                     <h4>0   ไม่ตรงกับฉันเลย</h4><br />
                     <h4>1   ตรงกับฉันบ้าง หรือเกิดขึ้นเป็นบางครั้ง</h4><br />
                     <h4>2   ตรงกับฉัน หรือเกิดขึ้นบ่อย</h4><br />
                     <h4>3   ตรงกับฉันมาก หรือเกิดขึ้นบ่อยมากที่สุด</h4><br />
                 </div>
                  <!-- หัว Colum 1  -->
                      <div class="row" >
                            <div class="card-header col-lg-8 col-sm-4 mx-auto text-center " style="background-color:lightcoral">                               
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:lightcoral">                               
                            </div> 
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:lightcoral">                               
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:lightcoral">                                
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:lightcoral">                               
                            </div>
                                <div class="w-100"></div>
                            <div class="card-header col-lg-8 col-sm-4 mx-auto text-left" style="background-color:lavenderblush">
                                <h4>1. ฉันรู้สึกยากที่จะสงบจิตใจลง</h4>
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:ivory">                              
                                <input type="radio" id="DASS_1_0"  name="DASS_1" value="0" />&nbsp;0                                                        
                            </div> 
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:lemonchiffon">
                                <input type="radio" id="DASS_1_01" name="DASS_1" value="1"  />&nbsp;1 
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:lightsalmon">
                                <input type="radio" id="DASS_1_02" name="DASS_1" value="2"  />&nbsp;2  
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:darkorange">
                                <input type="radio" id="DASS_1_03" name="DASS_1" value="3"  />&nbsp;3  
                            </div>
                            <!-- หัวข้อถัดไป -->
                            <div class="card-header col-lg-8 col-sm-4 mx-auto text-left" style="background-color:lavenderblush">
                                <h4>2. ฉันรู้สึกปากคอแห้ง</h4>
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:ivory">                              
                                <input type="radio" id="DASS_2_0"  name="DASS_2" value="0" />&nbsp;0                                                        
                            </div> 
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:lemonchiffon">
                                <input type="radio" id="DASS_2_01" name="DASS_2"  value="1" />&nbsp;1  
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:lightsalmon">
                                <input type="radio" id="DASS_2_02" name="DASS_2" value="2" />&nbsp;2  
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:darkorange">
                                <input type="radio" id="DASS_2_03" name="DASS_2" value="3" />&nbsp;3  
                            </div>
                            <!-- หัวข้อถัดไป -->
                            <div class="card-header col-lg-8 col-sm-4 mx-auto text-left" style="background-color:lavenderblush">
                                <h4>3. ฉันแทบไม่รู้สึกอะไร ดีๆเลย</h4>
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:ivory">                              
                                <input type="radio" id="DASS_3_0"  name="DASS_3" value="0" />&nbsp;0                                                        
                            </div> 
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:lemonchiffon">
                                <input type="radio" id="DASS_3_01" name="DASS_3" value="1" />&nbsp;1  
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:lightsalmon">
                                <input type="radio" id="DASS_3_02" name="DASS_3" value="2" />&nbsp;2  
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:darkorange">
                                <input type="radio" id="DASS_3_03" name="DASS_3" value="3" />&nbsp;3  
                            </div>
                            <!-- หัวข้อถัดไป -->
                            <div class="card-header col-lg-8 col-sm-4 mx-auto text-left" style="background-color:lavenderblush">
                                <h4>4. ฉันมีอาการหายใจผิดปกติ (เช่น หายใจเร็วเกินเหตุ หายใจไม่ทันแม้ว่าจะไม่ได้ออกแรง)</h4>
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:ivory">                              
                                <input type="radio" id="DASS_4_0"  name="DASS_4" value="0" />&nbsp;0                                                        
                            </div> 
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:lemonchiffon">
                                <input type="radio" id="DASS_4_01" name="DASS_4" value="1" />&nbsp;1  
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:lightsalmon">
                                <input type="radio" id="DASS_4_02" name="DASS_4" value="2" />&nbsp;2  
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:darkorange">
                                <input type="radio" id="DASS_4_03" name="DASS_4" value="3" />&nbsp;3  
                            </div>
                            <!-- หัวข้อถัดไป -->
                            <div class="card-header col-lg-8 col-sm-4 mx-auto text-left" style="background-color:lavenderblush">
                                <h4>5. ฉันพบว่ามันยากที่จะคิดริเริ่มทำสิ่งใดสิ่งหนึ่ง</h4>
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:ivory">                              
                                <input type="radio" id="DASS_5_0"  name="DASS_5" value="0" />&nbsp;0                                                        
                            </div> 
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:lemonchiffon">
                                <input type="radio" id="DASS_5_01" name="DASS_5" value="1" />&nbsp;1  
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:lightsalmon">
                                <input type="radio" id="DASS_5_02" name="DASS_5" value="2" />&nbsp;2  
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:darkorange">
                                <input type="radio" id="DASS_5_03" name="DASS_5" value="3" />&nbsp;3  
                            </div>
                            <!-- หัวข้อถัดไป -->
                            <div class="card-header col-lg-8 col-sm-4 mx-auto text-left" style="background-color:lavenderblush">
                                <h4>6. ฉันมีแนวโน้มที่จะตอบสนองเกินเหตุต่อสถานการณ์</h4>
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:ivory">                              
                                <input type="radio" id="DASS_6_0"  name="DASS_6" value="0" />&nbsp;0                                                        
                            </div> 
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:lemonchiffon">
                                <input type="radio" id="DASS_6_01" name="DASS_6" value="1" />&nbsp;1  
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:lightsalmon">
                                <input type="radio" id="DASS_6_02" name="DASS_6" value="2" />&nbsp;2  
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:darkorange">
                                <input type="radio" id="DASS_6_03" name="DASS_6" value="3" />&nbsp;3  
                            </div>
                            <!-- หัวข้อถัดไป -->
                            <div class="card-header col-lg-8 col-sm-4 mx-auto text-left" style="background-color:lavenderblush">
                                <h4>7. ฉันรู้สึกว่าร่างกายบางส่วนสั่นผิดปกติ (เช่น มือสั่น)</h4>
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:ivory">                              
                                <input type="radio" id="DASS_7_0"  name="DASS_7" value="0" />&nbsp;0                                                        
                            </div> 
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:lemonchiffon">
                                <input type="radio" id="DASS_7_01" name="DASS_7" value="1" />&nbsp;1  
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:lightsalmon">
                                <input type="radio" id="DASS_7_02" name="DASS_7" value="2" />&nbsp;2  
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:darkorange">
                                <input type="radio" id="DASS_7_03" name="DASS_7" value="3" />&nbsp;3  
                            </div>
                            <!-- หัวข้อถัดไป -->
                            <div class="card-header col-lg-8 col-sm-4 mx-auto text-left" style="background-color:lavenderblush">
                                <h4>8. ฉันรู้สึกเสียพลังงานไปมากกับการคิดกังวล</h4>
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:ivory">                              
                                <input type="radio" id="DASS_8_0"  name="DASS_8" value="0" />&nbsp;0                                                        
                            </div> 
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:lemonchiffon">
                                <input type="radio" id="DASS_8_01" name="DASS_8" value="1" />&nbsp;1  
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:lightsalmon">
                                <input type="radio" id="DASS_8_02" name="DASS_8" value="2" />&nbsp;2  
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:darkorange">
                                <input type="radio" id="DASS_8_03" name="DASS_8" value="3" />&nbsp;3  
                            </div>
                            <!-- หัวข้อถัดไป -->
                            <div class="card-header col-lg-8 col-sm-4 mx-auto text-left" style="background-color:lavenderblush">
                                <h4>9. ฉันรู้กังวลกับเหตุการณ์ที่อาจทำให้ฉันรู้สึกตื่นกลัวและกระทำบางสิ่งน่าอับอาย</h4>
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:ivory">                              
                                <input type="radio" id="DASS_9_0"  name="DASS_9" value="0" />&nbsp;0                                                        
                            </div> 
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:lemonchiffon">
                                <input type="radio" id="DASS_9_01" name="DASS_9" value="1" />&nbsp;1  
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:lightsalmon">
                                <input type="radio" id="DASS_9_02" name="DASS_9" value="2" />&nbsp;2  
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:darkorange">
                                <input type="radio" id="DASS_9_03" name="DASS_9" value="3" />&nbsp;3  
                            </div>
                            <!-- หัวข้อถัดไป -->
                            <div class="card-header col-lg-8 col-sm-4 mx-auto text-left" style="background-color:lavenderblush">
                                <h4>10. ฉันรู้สึกไม่มีเป้าหมายในชีวิต</h4>
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:ivory">                              
                                <input type="radio" id="DASS_10_0"  name="DASS_10" value="0" />&nbsp;0                                                        
                            </div> 
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:lemonchiffon">
                                <input type="radio" id="DASS_10_01" name="DASS_10" value="1" />&nbsp;1  
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:lightsalmon">
                                <input type="radio" id="DASS_10_02" name="DASS_10" value="2" />&nbsp;2  
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:darkorange">
                                <input type="radio" id="DASS_10_03" name="DASS_10" value="3" />&nbsp;3  
                            </div>
                            <!-- หัวข้อถัดไป -->
                            <div class="card-header col-lg-8 col-sm-4 mx-auto text-left" style="background-color:lavenderblush">
                                <h4>11. ฉันรู้สึกกระวนกระวายใจ</h4>
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:ivory">                              
                                <input type="radio" id="DASS_11_0"  name="DASS_11" value="0" />&nbsp;0                                                        
                            </div> 
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:lemonchiffon">
                                <input type="radio" id="DASS_11_01" name="DASS_11" value="1" />&nbsp;1  
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:lightsalmon">
                                <input type="radio" id="DASS_11_02" name="DASS_11" value="2" />&nbsp;2  
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:darkorange">
                                <input type="radio" id="DASS_11_03" name="DASS_11" value="3" />&nbsp;3  
                            </div>
                            <!-- หัวข้อถัดไป -->
                            <div class="card-header col-lg-8 col-sm-4 mx-auto text-left" style="background-color:lavenderblush">
                                <h4>12. ฉันรู้สึกยากที่จะผ่อนคลายตัวเอง</h4>
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:ivory">                              
                                <input type="radio" id="DASS_12_0"  name="DASS_12" value="0" />&nbsp;0                                                        
                            </div> 
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:lemonchiffon">
                                <input type="radio" id="DASS_12_01" name="DASS_12" value="1" />&nbsp;1  
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:lightsalmon">
                                <input type="radio" id="DASS_12_02" name="DASS_12" value="2" />&nbsp;2  
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:darkorange">
                                <input type="radio" id="DASS_12_03" name="DASS_12" value="3" />&nbsp;3  
                            </div>
                            <!-- หัวข้อถัดไป -->
                            <div class="card-header col-lg-8 col-sm-4 mx-auto text-left" style="background-color:lavenderblush">
                                <h4>13. ฉันรู้สึกจิตใจเหงาหงอยเศร้าซึม</h4>
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:ivory">                              
                                <input type="radio" id="DASS_13_0"  name="DASS_13" value="0" />&nbsp;0                                                        
                            </div> 
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:lemonchiffon">
                                <input type="radio" id="DASS_13_01" name="DASS_13" value="1" />&nbsp;1  
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:lightsalmon">
                                <input type="radio" id="DASS_13_02" name="DASS_13" value="2" />&nbsp;2  
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:darkorange">
                                <input type="radio" id="DASS_13_03" name="DASS_13" value="3" />&nbsp;3  
                            </div>
                            <!-- หัวข้อถัดไป -->
                            <div class="card-header col-lg-8 col-sm-4 mx-auto text-left" style="background-color:lavenderblush">
                                <h4>14. ฉันรู้สึกทนไม่ได้เวลามีอะไรมาขัดขวางสิ่งที่ฉันกำลังทำอยู่</h4>
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:ivory">                              
                                <input type="radio" id="DASS_14_0"  name="DASS_14" value="0" />&nbsp;0                                                        
                            </div> 
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:lemonchiffon">
                                <input type="radio" id="DASS_14_01" name="DASS_14" value="1" />&nbsp;1  
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:lightsalmon">
                                <input type="radio" id="DASS_14_02" name="DASS_14" value="2" />&nbsp;2  
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:darkorange">
                                <input type="radio" id="DASS_14_03" name="DASS_14" value="3" />&nbsp;3  
                            </div>
                            <!-- หัวข้อถัดไป -->
                            <div class="card-header col-lg-8 col-sm-4 mx-auto text-left" style="background-color:lavenderblush">
                                <h4>15. ฉันรู้สึกคล้ายจะมีอาการตื่นตระหนก</h4>
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:ivory">                              
                                <input type="radio" id="DASS_15_0"  name="DASS_15" value="0" />&nbsp;0                                                        
                            </div> 
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:lemonchiffon">
                                <input type="radio" id="DASS_15_01" name="DASS_15" value="1" />&nbsp;1  
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:lightsalmon">
                                <input type="radio" id="DASS_15_02" name="DASS_15" value="2" />&nbsp;2  
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:darkorange">
                                <input type="radio" id="DASS_15_03" name="DASS_15" value="3" />&nbsp;3  
                            </div>
                            <!-- หัวข้อถัดไป -->
                            <div class="card-header col-lg-8 col-sm-4 mx-auto text-left" style="background-color:lavenderblush">
                                <h4>16. ฉันรู้สึกไม่มีความกระตือรือร้นต่อสิ่งใด</h4>
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:ivory">                              
                                <input type="radio" id="DASS_16_0"  name="DASS_16" value="0" />&nbsp;0                                                        
                            </div> 
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:lemonchiffon">
                                <input type="radio" id="DASS_16_01" name="DASS_16" value="1" />&nbsp;1  
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:lightsalmon">
                                <input type="radio" id="DASS_16_02" name="DASS_16" value="2" />&nbsp;2  
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:darkorange">
                                <input type="radio" id="DASS_16_03" name="DASS_16" value="3" />&nbsp;3  
                            </div>
                            <!-- หัวข้อถัดไป -->
                            <div class="card-header col-lg-8 col-sm-4 mx-auto text-left" style="background-color:lavenderblush">
                                <h4>17. ฉันรู้สึกเป็นคนไม่มีคุณค่า</h4>
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:ivory">                              
                                <input type="radio" id="DASS_17_0"  name="DASS_17" value="0" />&nbsp;0                                                        
                            </div> 
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:lemonchiffon">
                                <input type="radio" id="DASS_17_01" name="DASS_17" value="1" />&nbsp;1  
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:lightsalmon">
                                <input type="radio" id="DASS_17_02" name="DASS_17" value="2" />&nbsp;2  
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:darkorange">
                                <input type="radio" id="DASS_17_03" name="DASS_17" value="3" />&nbsp;3  
                            </div>
                            <!-- หัวข้อถัดไป -->
                            <div class="card-header col-lg-8 col-sm-4 mx-auto text-left" style="background-color:lavenderblush">
                                <h4>18. ฉันรู้สึกค่อนข้างฉุนเฉียวง่าย</h4>
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:ivory">                              
                                <input type="radio" id="DASS_18_0"  name="DASS_18" value="0" />&nbsp;0                                                        
                            </div> 
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:lemonchiffon">
                                <input type="radio" id="DASS_18_01" name="DASS_18" value="1" />&nbsp;1  
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:lightsalmon">
                                <input type="radio" id="DASS_18_02" name="DASS_18" value="2" />&nbsp;2  
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:darkorange">
                                <input type="radio" id="DASS_18_03" name="DASS_18" value="3" />&nbsp;3  
                            </div>
                            <!-- หัวข้อถัดไป -->
                            <div class="card-header col-lg-8 col-sm-4 mx-auto text-left" style="background-color:lavenderblush">
                                <h4>19. ฉันรับรู้ถึงการทำงานของหัวใจแม้ในตอนที่ฉันไม่ได้ออกแรง (เช่นรู้สึกว่าหัวใจเต้นเร็วขึ้นหรือเต้นไม่เป็นจังหวะ)</h4>
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:ivory">                              
                                <input type="radio" id="DASS_19_0"  name="DASS_19" value="0" />&nbsp;0                                                        
                            </div> 
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:lemonchiffon">
                                <input type="radio" id="DASS_19_01" name="DASS_19" value="1" />&nbsp;1  
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:lightsalmon">
                                <input type="radio" id="DASS_19_02" name="DASS_19" value="2" />&nbsp;2  
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:darkorange">
                                <input type="radio" id="DASS_19_03" name="DASS_19" value="3" />&nbsp;3  
                            </div>
                            <!-- หัวข้อถัดไป -->
                            <div class="card-header col-lg-8 col-sm-4 mx-auto text-left" style="background-color:lavenderblush">
                                <h4>20. ฉันรู้สึกกลัวโดยไม่มีเหตุผล</h4>
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:ivory">                              
                                <input type="radio" id="DASS_20_0"  name="DASS_20" value="0" />&nbsp;0                                                        
                            </div> 
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:lemonchiffon">
                                <input type="radio" id="DASS_20_01" name="DASS_20" value="1" />&nbsp;1  
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:lightsalmon">
                                <input type="radio" id="DASS_20_02" name="DASS_20" value="2" />&nbsp;2  
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:darkorange">
                                <input type="radio" id="DASS_20_03" name="DASS_20" value="3" />&nbsp;3  
                            </div>
                            <!-- หัวข้อถัดไป -->
                            <div class="card-header col-lg-8 col-sm-4 mx-auto text-left" style="background-color:lavenderblush">
                                <h4>21. ฉันรู้สึกว่าชีวิตไม่มีความหมาย</h4>
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:ivory">                              
                                <input type="radio" id="DASS_21_0"  name="DASS_21" value="0" />&nbsp;0                                                        
                            </div> 
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:lemonchiffon">
                                <input type="radio" id="DASS_21_01" name="DASS_21" value="1" />&nbsp;1  
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:lightsalmon">
                                <input type="radio" id="DASS_21_02" name="DASS_21" value="2" />&nbsp;2  
                            </div>
                            <div class="card-header col-lg-1 col-sm-2 h5 mx-auto text-center" style="background-color:darkorange">
                                <input type="radio" id="DASS_21_03" name="DASS_21" value="3" />&nbsp;3  
                            </div>
                            <!-- หัวข้อถัดไป -->
                          <div hidden="hidden">
                              <input type="text" id="txtH_DASS1" value="0" runat="server"/>                             
                              <input type="text" id="txtH_DASS2" value="0" runat="server"/>                             
                              <input type="text" id="txtH_DASS3" value="0" runat="server"/>                             
                              <input type="text" id="txtH_DASS4" value="0" runat="server"/>                             
                              <input type="text" id="txtH_DASS5" value="0" runat="server"/>                             
                              <input type="text" id="txtH_DASS6" value="0" runat="server"/>                             
                              <input type="text" id="txtH_DASS7" value="0" runat="server"/>                             
                              <input type="text" id="txtH_DASS8" value="0" runat="server"/>                             
                              <input type="text" id="txtH_DASS9" value="0" runat="server"/>                             
                              <input type="text" id="txtH_DASS10" value="0" runat="server"/>                             
                              <input type="text" id="txtH_DASS11" value="0" runat="server"/>                             
                              <input type="text" id="txtH_DASS12" value="0" runat="server"/>                             
                              <input type="text" id="txtH_DASS13" value="0" runat="server"/>                             
                              <input type="text" id="txtH_DASS14" value="0" runat="server"/>                             
                              <input type="text" id="txtH_DASS15" value="0" runat="server"/>                             
                              <input type="text" id="txtH_DASS16" value="0" runat="server"/>                             
                              <input type="text" id="txtH_DASS17" value="0" runat="server"/>                             
                              <input type="text" id="txtH_DASS18" value="0" runat="server"/>                             
                              <input type="text" id="txtH_DASS19" value="0" runat="server"/>                             
                              <input type="text" id="txtH_DASS20" value="0" runat="server"/>                             
                              <input type="text" id="txtH_DASS21" value="0" runat="server"/>                             
                          </div>
                 </div>
            </div>
            </div>
        </div>
                <div class="card-footer col-10 mx-auto text-center" onmouseover="GetScore()" style="background-color:lightcoral">
                            <%--<button type="button" class="btn btn-light " id="btn_submit1" onmouseover="GetScore()" onserverclick="btn_submit1_ServerClick" runat="server">Submit</button>--%>
                    <button id="btn_submit" onserverclick="btn_submit_ServerClick" class="btn btn-light" runat="server">SUBMIT</button>
                </div>
            <div hidden="hidden">
                <input type="text" id="txtH_link" value="" runat="server" />
            </div>
            <div hidden="hidden">
                <input type="text" id="txtH_link_phq9" value="" runat="server" />
            </div>
            <div hidden="hidden">
                <input type="text" id="txtH_link_gad7" value="" runat="server" />
            </div>
            <div hidden="hidden">
                <input type="text" id="txtH_link_spst20" value="" runat="server" />
            </div>
            <div hidden="hidden" >
                        <input type="text" id="Text1" value="" runat="server" />
                        <asp:Label ID="lb_script" Text="" runat="server"></asp:Label>
             </div>
             <div class="col-11 mx-auto text-center mt-5" visible="true" runat="server">
                    <asp:Button ID="btn_next11" Text="ถัดไป" CssClass="btn btn-light" OnClick="btn_next11_Click" runat="server" />
             </div>
             <div class="col-11 mx-auto text-center mt-5" visible="true" runat="server">
                 <button id="btn_print" class="btn btn-info" onclick="printDiv()" runat="server">PRINT</button>
             </div>

            <script>
                function GetScore() {
                    var score1 = LoopVal('DASS_1');  // S
                    var score2 = LoopVal('DASS_2');  // A
                    var score3 = LoopVal('DASS_3');  // D
                    var score4 = LoopVal('DASS_4');  // A
                    var score5 = LoopVal('DASS_5');  // D
                    var score6 = LoopVal('DASS_6');  // S
                    var score7 = LoopVal('DASS_7');  // A
                    var score8 = LoopVal('DASS_8');  // S
                    var score9 = LoopVal('DASS_9');  // A
                    var score10 = LoopVal('DASS_10'); // D
                    var score11 = LoopVal('DASS_11'); // S
                    var score12 = LoopVal('DASS_12'); // S
                    var score13 = LoopVal('DASS_13'); // D
                    var score14 = LoopVal('DASS_14'); // S
                    var score15 = LoopVal('DASS_15'); // A
                    var score16 = LoopVal('DASS_16'); // D
                    var score17 = LoopVal('DASS_17'); // D
                    var score18 = LoopVal('DASS_18'); // S
                    var score19 = LoopVal('DASS_19'); // A
                    var score20 = LoopVal('DASS_20'); // A
                    var score21 = LoopVal('DASS_21'); // D
                    
                    var txt_1 = document.getElementById('<%= txtH_DASS1.ClientID %>');
                    var txt_2 = document.getElementById('<%= txtH_DASS2.ClientID %>');
                    var txt_3 = document.getElementById('<%= txtH_DASS3.ClientID %>');
                    var txt_4 = document.getElementById('<%= txtH_DASS4.ClientID %>');
                    var txt_5 = document.getElementById('<%= txtH_DASS5.ClientID %>');
                    var txt_6 = document.getElementById('<%= txtH_DASS6.ClientID %>');
                    var txt_7 = document.getElementById('<%= txtH_DASS7.ClientID %>');
                    var txt_8 = document.getElementById('<%= txtH_DASS8.ClientID %>');
                    var txt_9 = document.getElementById('<%= txtH_DASS9.ClientID %>');
                    var txt_10 = document.getElementById('<%= txtH_DASS10.ClientID %>');
                    var txt_11 = document.getElementById('<%= txtH_DASS11.ClientID %>');
                    var txt_12 = document.getElementById('<%= txtH_DASS12.ClientID %>');
                    var txt_13 = document.getElementById('<%= txtH_DASS13.ClientID %>');
                    var txt_14 = document.getElementById('<%= txtH_DASS14.ClientID %>');
                    var txt_15 = document.getElementById('<%= txtH_DASS15.ClientID %>');
                    var txt_16 = document.getElementById('<%= txtH_DASS16.ClientID %>');
                    var txt_17 = document.getElementById('<%= txtH_DASS17.ClientID %>');
                    var txt_18 = document.getElementById('<%= txtH_DASS18.ClientID %>');
                    var txt_19 = document.getElementById('<%= txtH_DASS19.ClientID %>');
                    var txt_20 = document.getElementById('<%= txtH_DASS20.ClientID %>');
                    var txt_21 = document.getElementById('<%= txtH_DASS21.ClientID %>');
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
                    txt_21.value = score21;

                    var D = parseInt(score3) + parseInt(score5) + parseInt(score10) + parseInt(score13) + parseInt(score16) + parseInt(score17) + parseInt(score21);
                    var A = parseInt(score2) + parseInt(score4) + parseInt(score7) + parseInt(score9) + parseInt(score15) + parseInt(score19) + parseInt(score20);
                    var S = parseInt(score1) + parseInt(score6) + parseInt(score8) + parseInt(score11) + parseInt(score12) + parseInt(score14) + parseInt(score18);

                    var txtlink = document.getElementById('<%= txtH_link.ClientID %>');
                    var txtlink_phq9 = document.getElementById('<%= txtH_link_phq9.ClientID %>');
                    var txtlink_gad7 = document.getElementById('<%= txtH_link_gad7.ClientID %>');
                    var txtlink_spst = document.getElementById('<%= txtH_link_spst20.ClientID %>');

                    var link = "";

                    if (parseInt(A) >= 6) {
                        txtlink_gad7.value = "yes";
                    }
                    if (parseInt(S) >= 10) {
                        txtlink_spst.value = "yes";
                    } 
                    if (parseInt(D) >= 7) {
                        txtlink_phq9.value = "yes";
                    }

                    
                    if (parseInt(A) >= 6) {
                        if (link == "") {
                            link = "GAD7";
                        }
                    }
                    else if (parseInt(S) >= 10) {
                        if (link == "") {
                            link = "SPST20";
                        }
                    }  
                    else if (parseInt(D) >= 7) {
                        link = "PHQ9";
                    }
                    else {
                        //window.location.href = "ColorRedNegative.aspx";
                        txtlink.value = "Negative";
                    }
                    txtlink.value = link;
                }

                function LoopVal(id) {
                    var result = 0;
                    for (var i = 0; i < 4; i++) {
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
