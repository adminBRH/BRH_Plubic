<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PHQ9.aspx.cs" Inherits="BRH_Plubic.MentalHealthClinic.PHQ9" %>
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
    <div class="card-header col-10 mx-auto" style="background-color:lightblue">
        <div class="container d-flex align-items-center flex-column mb-1">
            <h2>แบบประเมินโรคซึมเศร้า 9 คำถาม (PHQ-9)</h2>
        </div>
    </div>
        <div class="card col-10 mx-auto">        
             <div class="card-body"> 
                 <div class="tex-left"><h4>ในช่วง 2 สัปดาห์ที่ผ่านมารวมทั้งวันนี้ ท่านมีอาการเหล่านี้ บ่อยแค่ไหน</h4></div>
                 <!-- หัว Colum 1  -->
                      <div class="row" >
                            <div class="card-header col-8 mx-auto text-center " style="background-color:lightblue">                                
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:ivory">       
                                ไม่มีเลย
                            </div> 
                            <div class="card-header col-1 mx-auto text-center" style="background-color:lemonchiffon">  
                                เป็นบางวัน 1-7 วัน
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:lightsalmon">  
                                เป็นบ่อย > 7 วัน
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:darkorange">  
                                เป็นทุกวัน
                            </div>
                                <div class="w-100"></div>
                            <!-- หัวข้อถัดไป -->
                            <div class="card-header col-8 mx-auto text-left" style="background-color:honeydew">
                                <h4>1. เบื่อ ไม่สนใจอยากทำอะไร</h4>
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:ivory">                              
                                <input type="radio" id="PHQ9_1_0"  name="PHQ9_1" value="0"  />&nbsp;0                                                        
                            </div> 
                            <div class="card-header col-1 mx-auto text-center" style="background-color:lemonchiffon">
                                <input type="radio" id="PHQ9_1_01" name="PHQ9_1" value="1"  />&nbsp;1 
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:lightsalmon">
                                <input type="radio" id="PHQ9_1_02" name="PHQ9_1" value="2"  />&nbsp;2  
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:darkorange">
                                <input type="radio" id="PHQ9_1_03" name="PHQ9_1" value="3"  />&nbsp;3  
                            </div>
                            <!-- หัวข้อถัดไป -->
                            <!-- หัวข้อถัดไป -->
                            <div class="card-header col-8 mx-auto text-left" style="background-color:honeydew">
                                <h4>2. ไม่สบายใจ ซึมเศร้า ท้อแท้</h4>
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:ivory">                              
                                <input type="radio" id="PHQ9_2_0"  name="PHQ9_2" value="0"  />&nbsp;0                                                        
                            </div> 
                            <div class="card-header col-1 mx-auto text-center" style="background-color:lemonchiffon">
                                <input type="radio" id="PHQ9_2_01" name="PHQ9_2" value="1"  />&nbsp;1 
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:lightsalmon">
                                <input type="radio" id="PHQ9_2_02" name="PHQ9_2" value="2"  />&nbsp;2  
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:darkorange">
                                <input type="radio" id="PHQ9_2_03" name="PHQ9_2" value="3"  />&nbsp;3  
                            </div>
                            <!-- หัวข้อถัดไป -->
                            <!-- หัวข้อถัดไป -->
                            <div class="card-header col-8 mx-auto text-left" style="background-color:honeydew">
                                <h4>3. หลับยากหรือหลับๆตื่นๆหรือหลับมากไป</h4>
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:ivory">                              
                                <input type="radio" id="PHQ9_3_0"  name="PHQ9_3" value="0"  />&nbsp;0                                                        
                            </div> 
                            <div class="card-header col-1 mx-auto text-center" style="background-color:lemonchiffon">
                                <input type="radio" id="PHQ9_3_01" name="PHQ9_3" value="1" />&nbsp;1 
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:lightsalmon">
                                <input type="radio" id="PHQ9_3_02" name="PHQ9_3" value="2"  />&nbsp;2  
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:darkorange">
                                <input type="radio" id="PHQ9_3_03" name="PHQ9_3" value="3"  />&nbsp;3  
                            </div>
                            <!-- หัวข้อถัดไป -->
                            <!-- หัวข้อถัดไป -->
                            <div class="card-header col-8 mx-auto text-left" style="background-color:honeydew">
                                <h4>4. เหนื่อยง่ายหรือไม่ค่อยมีแรง</h4>
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:ivory">                              
                                <input type="radio" id="PHQ9_4_0"  name="PHQ9_4" value="0"  />&nbsp;0                                                        
                            </div> 
                            <div class="card-header col-1 mx-auto text-center" style="background-color:lemonchiffon">
                                <input type="radio" id="PHQ9_4_01" name="PHQ9_4" value="1"  />&nbsp;1 
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:lightsalmon">
                                <input type="radio" id="PHQ9_4_02" name="PHQ9_4" value="2"  />&nbsp;2  
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:darkorange">
                                <input type="radio" id="PHQ9_4_03" name="PHQ9_4" value="3"  />&nbsp;3  
                            </div>
                            <!-- หัวข้อถัดไป -->
                            <!-- หัวข้อถัดไป -->
                            <div class="card-header col-8 mx-auto text-left" style="background-color:honeydew">
                                <h4>5. เบื่ออาหารหรือกินมากเกินไป</h4>
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:ivory">                              
                                <input type="radio" id="PHQ9_5_0"  name="PHQ9_5" value="0"  />&nbsp;0                                                        
                            </div> 
                            <div class="card-header col-1 mx-auto text-center" style="background-color:lemonchiffon">
                                <input type="radio" id="PHQ9_5_01" name="PHQ9_5" value="1"  />&nbsp;1 
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:lightsalmon">
                                <input type="radio" id="PHQ9_5_02" name="PHQ9_5" value="2"  />&nbsp;2  
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:darkorange">
                                <input type="radio" id="PHQ9_5_03" name="PHQ9_5" value="3"  />&nbsp;3  
                            </div>
                            <!-- หัวข้อถัดไป -->
                            <!-- หัวข้อถัดไป -->
                            <div class="card-header col-8 mx-auto text-left" style="background-color:honeydew">
                                <h4>6. รู้สึกไม่ดีกับตัวเอง คิดว่าตัวเองล้มเหลวหรือครอบครัวผิดหวัง</h4>
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:ivory">                              
                                <input type="radio" id="PHQ9_6_0"  name="PHQ9_6" value="0"  />&nbsp;0                                                        
                            </div> 
                            <div class="card-header col-1 mx-auto text-center" style="background-color:lemonchiffon">
                                <input type="radio" id="PHQ9_6_01" name="PHQ9_6" value="1"  />&nbsp;1 
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:lightsalmon">
                                <input type="radio" id="PHQ9_6_02" name="PHQ9_6" value="2"  />&nbsp;2  
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:darkorange">
                                <input type="radio" id="PHQ9_6_03" name="PHQ9_6" value="3"  />&nbsp;3  
                            </div>
                            <!-- หัวข้อถัดไป -->
                            <!-- หัวข้อถัดไป -->
                            <div class="card-header col-8 mx-auto text-left" style="background-color:honeydew">
                                <h4>7. สมาธิไม่ดี เวลาทำอะไร เช่น ดูโทรทัศน์  ฟังวิทยุ หรือทำงานที่ต้องใช้ความตั้งใจ</h4>
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:ivory">                              
                                <input type="radio" id="PHQ9_7_0"  name="PHQ9_7" value="0"  />&nbsp;0                                                        
                            </div> 
                            <div class="card-header col-1 mx-auto text-center" style="background-color:lemonchiffon">
                                <input type="radio" id="PHQ9_7_01" name="PHQ9_7" value="1"  />&nbsp;1 
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:lightsalmon">
                                <input type="radio" id="PHQ9_7_02" name="PHQ9_7" value="2"  />&nbsp;2  
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:darkorange">
                                <input type="radio" id="PHQ9_7_03" name="PHQ9_7" value="3"  />&nbsp;3  
                            </div>
                            <!-- หัวข้อถัดไป -->
                            <!-- หัวข้อถัดไป -->
                            <div class="card-header col-8 mx-auto text-left" style="background-color:honeydew">
                                <h4>8. พูดช้า ทำอะไรช้าลงจนคนอื่นสังเกตเห็นได้ หรือกระสับกระส่ายไม่สามารถอยู่นิ่งได้เหมือนที่เคยเป็น</h4>
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:ivory">                              
                                <input type="radio" id="PHQ9_8_0"  name="PHQ9_8" value="0"  />&nbsp;0                                                        
                            </div> 
                            <div class="card-header col-1 mx-auto text-center" style="background-color:lemonchiffon">
                                <input type="radio" id="PHQ9_8_01" name="PHQ9_8" value="1"  />&nbsp;1 
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:lightsalmon">
                                <input type="radio" id="PHQ9_8_02" name="PHQ9_8" value="2"  />&nbsp;2  
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:darkorange">
                                <input type="radio" id="PHQ9_8_03" name="PHQ9_8" value="3"  />&nbsp;3  
                            </div>
                            <!-- หัวข้อถัดไป -->
                            <!-- หัวข้อถัดไป -->
                            <div class="card-header col-8 mx-auto text-left" style="background-color:honeydew">
                                <h4>9. คิดทำร้ายตนเองหรือคิดว่าถ้าตายไปคงจะดี</h4>
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:ivory">                              
                                <input type="radio" id="PHQ9_9_0"  name="PHQ9_9" value="0"  />&nbsp;0                                                        
                            </div> 
                            <div class="card-header col-1 mx-auto text-center" style="background-color:lemonchiffon">
                                <input type="radio" id="PHQ9_9_01" name="PHQ9_9" value="1"  />&nbsp;1 
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:lightsalmon">
                                <input type="radio" id="PHQ9_9_02" name="PHQ9_9" value="2"  />&nbsp;2  
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:darkorange">
                                <input type="radio" id="PHQ9_9_03" name="PHQ9_9" value="3"  />&nbsp;3  
                            </div>
                            <!-- หัวข้อถัดไป -->
                          <!-- หัวข้อถัดไป -->
                            <div class="card-header col-8 mx-auto text-left" style="background-color:honeydew">
                                <h4>ถ้าตอบว่ามีอาการไม่ว่าในข้อใดก็ตาม อาการนั้นๆ ทำให้ผู้ป่วยมีปัญหาในการทำงาน การดูแลสิ่งต่างๆ ในบ้านหรือการเข้ากับผู้คนหรือไม่</h4>
                            </div>                           
                            <div class="card-header col-1 mx-auto text-center" style="background-color:ivory">                              
                                <input type="radio" id="PHQ9_10_0"  name="PHQ9_10" value="0"  />&nbsp;<br />ไม่มีปัญหาเลย                                                        
                            </div> 
                            <div class="card-header col-1 mx-auto text-center" style="background-color:lemonchiffon">
                                <input type="radio" id="PHQ9_10_01" name="PHQ9_10" value="1"  />&nbsp;<br />มีปัญหาบ้าง 
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:lightsalmon">
                                <input type="radio" id="PHQ9_10_02" name="PHQ9_10" value="2"  />&nbsp;<br />มีปัญหามาก  
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:darkorange">
                                <input type="radio" id="PHQ9_10_03" name="PHQ9_10" value="3"  />&nbsp;<br />มีปัญหามากที่สุด  
                            </div>
                            <!-- หัวข้อถัดไป -->
                          <div hidden="hidden">
                              <input type="text" id="txtH_PHQ1" value="0" runat="server"/>                             
                              <input type="text" id="txtH_PHQ2" value="0" runat="server"/>                             
                              <input type="text" id="txtH_PHQ3" value="0" runat="server"/>                             
                              <input type="text" id="txtH_PHQ4" value="0" runat="server"/>                             
                              <input type="text" id="txtH_PHQ5" value="0" runat="server"/>                             
                              <input type="text" id="txtH_PHQ6" value="0" runat="server"/>                             
                              <input type="text" id="txtH_PHQ7" value="0" runat="server"/>                             
                              <input type="text" id="txtH_PHQ8" value="0" runat="server"/>                             
                              <input type="text" id="txtH_PHQ9" value="0" runat="server"/>
                              <input type="text" id="txtH_PHQ10" value="0" runat="server"/>
                          </div>

                    </div>
                 </div>
             </div>
        </div>
                 <div class="card-footer col-10 mx-auto text-center" onmouseover="GetScore()" style="background-color:lightcoral">
                            <%--<button type="button" class="btn btn-light " id="btn_submit1" onserverclick="btn_submit1_ServerClick" runat="server">Submit</button>--%>
                    <button id="btn_submit" onserverclick="btn_submit_ServerClick" class="btn btn-light" runat="server">SUBMIT</button>
                </div>
            <div hidden="hidden">
                <input type="text" id="txtH_link" value="" runat="server" />
            </div>
            <div hidden="hidden" >
                        <input type="text" id="Text1" value="" runat="server" />
                        <asp:Label ID="lb_script" Text="" runat="server"></asp:Label>
            </div>
             <div class="col-11 mx-auto text-center mt-5" visible="true" runat="server">
                    <asp:Button ID="btn_next11" Text="ถัดไป" CssClass="btn btn-light" OnClick="btn_next11_Click" runat="server" />
             </div>
             <div class="col-11 mx-auto text-center mt-5" visible="true" runat="server">
                            <asp:Button ID="printdiv"  Text="Print" CssClass="btn btn-info" OnClientClick="printDiv()" runat="server" />
             </div>

            <script>
                function GetScore() {

                    var score1 = LoopVal('PHQ9_1');
                    var score2 = LoopVal('PHQ9_2');
                    var score3 = LoopVal('PHQ9_3');
                    var score4 = LoopVal('PHQ9_4');
                    var score5 = LoopVal('PHQ9_5');
                    var score6 = LoopVal('PHQ9_6');
                    var score7 = LoopVal('PHQ9_7');
                    var score8 = LoopVal('PHQ9_8');
                    var score9 = LoopVal('PHQ9_9');
                    var score10 = LoopVal('PHQ9_10');

                    var txt_1 = document.getElementById('<%= txtH_PHQ1.ClientID %>');
                    var txt_2 = document.getElementById('<%= txtH_PHQ2.ClientID %>');
                    var txt_3 = document.getElementById('<%= txtH_PHQ3.ClientID %>');
                    var txt_4 = document.getElementById('<%= txtH_PHQ4.ClientID %>');
                    var txt_5 = document.getElementById('<%= txtH_PHQ5.ClientID %>');
                    var txt_6 = document.getElementById('<%= txtH_PHQ6.ClientID %>');
                    var txt_7 = document.getElementById('<%= txtH_PHQ7.ClientID %>');
                    var txt_8 = document.getElementById('<%= txtH_PHQ8.ClientID %>');
                    var txt_9 = document.getElementById('<%= txtH_PHQ9.ClientID %>');
                    var txt_10 = document.getElementById('<%= txtH_PHQ10.ClientID %>');

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

                    var sumscore = parseInt(score1) + parseInt(score2) + parseInt(score3) + parseInt(score4) + parseInt(score5) + parseInt(score6) + parseInt(score7) + parseInt(score8) + parseInt(score9);

                    var txtlink = document.getElementById('<%= txtH_link.ClientID %>');

                    if (parseInt(sumscore) >= 7) {
                        //window.location.href = "PHQ8.aspx";
                        txtlink.value = "PHQ8";
                    }
                    else {
                        // window.location.href = "PHQ9Negative.aspx";
                        txtlink.value = "PHQ9Negative";
                    }
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
