<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GAD7.aspx.cs" Inherits="BRH_Plubic.MentalHealthClinic.GAD7" %>
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
            <h2>แบบวัดความวิตกกังวล (GAD-7)</h2>
        </div>
    </div>
        <div class="card col-10 mx-auto">        
             <div class="card-body">
                 <div class="text-left"><h4>ในช่วง 2 อาทิตย์ที่ผ่านมา ท่านถูกรบกวนด้วยปัญหาต่อไปนี้บ่อยเพียงใด</h4>
                    <h6>0 หมายถึง ไม่เลย</h6>
                    <h6>1 หมายถึง หลายวัน</h6>
                    <h6>2 หมายถึง เกินกว่าครึ่งนึง</h6>
                    <h6>3 หมายถึง เกือบทุกวัน</h6>
                 </div>
                  <!-- หัว Colum 1  -->
                      <div class="row" >
                            <div class="card-header col-8 mx-auto text-center " style="background-color:paleturquoise">                                
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:ivory">       
                                ไม่เลย
                            </div> 
                            <div class="card-header col-1 mx-auto text-center" style="background-color:lemonchiffon">  
                                หลายวัน
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:lightsalmon">  
                                เกินกว่าครึ่งนึง
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:darkorange">  
                                เกือบทุกวัน
                            </div>
                                <div class="w-100"></div>
                            <!-- หัวข้อถัดไป -->
                            <!-- หัวข้อถัดไป -->
                            <div class="card-header col-8 mx-auto text-left" style="background-color:honeydew">
                                <h4>1. รู้สึกตึงเครียด วิตกกังวล หรือกระวนกระวาย</h4>
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:ivory">                              
                                <input type="radio" id="GAD7_1_0"  name="GAD7_1" value="0"  />&nbsp;0                                                        
                            </div> 
                            <div class="card-header col-1 mx-auto text-center" style="background-color:lemonchiffon">
                                <input type="radio" id="GAD7_1_01" name="GAD7_1" value="1"  />&nbsp;1 
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:lightsalmon">
                                <input type="radio" id="GAD7_1_02" name="GAD7_1" value="2"  />&nbsp;2  
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:darkorange">
                                <input type="radio" id="GAD7_1_03" name="GAD7_1" value="3"  />&nbsp;3  
                            </div>
                            <!-- หัวข้อถัดไป -->
                            <!-- หัวข้อถัดไป -->
                            <div class="card-header col-8 mx-auto text-left" style="background-color:honeydew">
                                <h4>2. ไม่สามารถหยุดหรือควบคุมความกังวลได้</h4>
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:ivory">                              
                                <input type="radio" id="GAD7_2_0"  name="GAD7_2" value="0"  />&nbsp;0                                                        
                            </div> 
                            <div class="card-header col-1 mx-auto text-center" style="background-color:lemonchiffon">
                                <input type="radio" id="GAD7_2_01" name="GAD7_2" value="1"  />&nbsp;1 
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:lightsalmon">
                                <input type="radio" id="GAD7_2_02" name="GAD7_2" value="2"  />&nbsp;2  
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:darkorange">
                                <input type="radio" id="GAD7_2_03" name="GAD7_2" value="3"  />&nbsp;3  
                            </div>
                            <!-- หัวข้อถัดไป -->
                            <!-- หัวข้อถัดไป -->
                            <div class="card-header col-8 mx-auto text-left" style="background-color:honeydew">
                                <h4>3. กังวลมากเกินไปในเรื่องต่างๆ</h4>
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:ivory">                              
                                <input type="radio" id="GAD7_3_0"  name="GAD7_3" value="0"  />&nbsp;0                                                        
                            </div> 
                            <div class="card-header col-1 mx-auto text-center" style="background-color:lemonchiffon">
                                <input type="radio" id="GAD7_3_01" name="GAD7_3" value="1"  />&nbsp;1 
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:lightsalmon">
                                <input type="radio" id="GAD7_3_02" name="GAD7_3" value="2"  />&nbsp;2  
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:darkorange">
                                <input type="radio" id="GAD7_3_03" name="GAD7_3" value="3"  />&nbsp;3  
                            </div>
                            <!-- หัวข้อถัดไป -->
                            <!-- หัวข้อถัดไป -->
                            <div class="card-header col-8 mx-auto text-left" style="background-color:honeydew">
                                <h4>4. ทำตัวให้ผ่อนคลายได้ยาก</h4>
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:ivory">                              
                                <input type="radio" id="GAD7_4_0"  name="GAD7_4" value="0"  />&nbsp;0                                                        
                            </div> 
                            <div class="card-header col-1 mx-auto text-center" style="background-color:lemonchiffon">
                                <input type="radio" id="GAD7_4_01" name="GAD7_4" value="1"  />&nbsp;1 
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:lightsalmon">
                                <input type="radio" id="GAD7_4_02" name="GAD7_4" value="2"  />&nbsp;2  
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:darkorange">
                                <input type="radio" id="GAD7_4_03" name="GAD7_4" value="3"  />&nbsp;3  
                            </div>
                            <!-- หัวข้อถัดไป -->
                            <!-- หัวข้อถัดไป -->
                            <div class="card-header col-8 mx-auto text-left" style="background-color:honeydew">
                                <h4>5. รู้สึกกระสับกระส่ายจนไม่สามารถนั่งนิ่งๆได้</h4>
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:ivory">                              
                                <input type="radio" id="GAD7_5_0"  name="GAD7_5" value="0"  />&nbsp;0                                                        
                            </div> 
                            <div class="card-header col-1 mx-auto text-center" style="background-color:lemonchiffon">
                                <input type="radio" id="GAD7_5_01" name="GAD7_5" value="1"  />&nbsp;1 
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:lightsalmon">
                                <input type="radio" id="GAD7_5_02" name="GAD7_5" value="2"  />&nbsp;2  
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:darkorange">
                                <input type="radio" id="GAD7_5_03" name="GAD7_5" value="3"  />&nbsp;3  
                            </div>
                            <!-- หัวข้อถัดไป -->
                            <!-- หัวข้อถัดไป -->
                            <div class="card-header col-8 mx-auto text-left" style="background-color:honeydew">
                                <h4>6. กลายเป็นคนขี้รำคาญ หรือหงุดหงิดง่าย</h4>
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:ivory">                              
                                <input type="radio" id="GAD7_6_0" name="GAD7_6" value="0"  />&nbsp;0                                                        
                            </div> 
                            <div class="card-header col-1 mx-auto text-center" style="background-color:lemonchiffon">
                                <input type="radio" id="GAD7_6_01" name="GAD7_6" value="1"  />&nbsp;1 
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:lightsalmon">
                                <input type="radio" id="GAD7_6_02" name="GAD7_6" value="2" />&nbsp;2  
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:darkorange">
                                <input type="radio" id="GAD7_6_03" name="GAD7_6" value="3"  />&nbsp;3  
                            </div>
                            <!-- หัวข้อถัดไป -->
                            <!-- หัวข้อถัดไป -->
                            <div class="card-header col-8 mx-auto text-left" style="background-color:honeydew">
                                <h4>7. รู้สึกกลัวเหมือนว่าจะมีอะไรร้ายๆเกิดขึ้น</h4>
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:ivory">                              
                                <input type="radio" id="GAD7_7_0"  name="GAD7_7" value="0"  />&nbsp;0                                                        
                            </div> 
                            <div class="card-header col-1 mx-auto text-center" style="background-color:lemonchiffon">
                                <input type="radio" id="GAD7_7_01" name="GAD7_7" value="1"  />&nbsp;1 
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:lightsalmon">
                                <input type="radio" id="GAD7_7_02" name="GAD7_7" value="2"  />&nbsp;2  
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:darkorange">
                                <input type="radio" id="GAD7_7_03" name="GAD7_7" value="3"  />&nbsp;3  
                            </div>
                            <!-- หัวข้อถัดไป -->
                          <div hidden="hidden">
                              <input type="text" id="txtH_GAD71" value="0" runat="server"/>                             
                              <input type="text" id="txtH_GAD72" value="0" runat="server"/>                             
                              <input type="text" id="txtH_GAD73" value="0" runat="server"/>                             
                              <input type="text" id="txtH_GAD74" value="0" runat="server"/>                             
                              <input type="text" id="txtH_GAD75" value="0" runat="server"/>                             
                              <input type="text" id="txtH_GAD76" value="0" runat="server"/>                             
                              <input type="text" id="txtH_GAD77" value="0" runat="server"/>                             
                                                                                                               
                          </div>

                    </div>
                 </div>
            </div>
        </div>

                    <div class="card-footer col-10 mx-auto text-center" onmouseover="GetScore()" style="background-color:lightcoral">
                            <%--<button type="button" class="btn btn-light " id="btn_submit1" onmouseover="GetScore()" onserverclick="btn_submit1_ServerClick" runat="server">Submit</button>--%>
                    <button id="btn_submit_gad7" onserverclick="btn_submit_gad7_ServerClick" class="btn btn-light" runat="server">SUBMIT</button>
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

                    var score1 = LoopVal('GAD7_1');
                    var score2 = LoopVal('GAD7_2');
                    var score3 = LoopVal('GAD7_3');
                    var score4 = LoopVal('GAD7_4');
                    var score5 = LoopVal('GAD7_5');
                    var score6 = LoopVal('GAD7_6');
                    var score7 = LoopVal('GAD7_7');

                    var txt_1 = document.getElementById('<%= txtH_GAD71.ClientID %>');
                    var txt_2 = document.getElementById('<%= txtH_GAD72.ClientID %>');
                    var txt_3 = document.getElementById('<%= txtH_GAD73.ClientID %>');
                    var txt_4 = document.getElementById('<%= txtH_GAD74.ClientID %>');
                    var txt_5 = document.getElementById('<%= txtH_GAD75.ClientID %>');
                    var txt_6 = document.getElementById('<%= txtH_GAD76.ClientID %>');
                    var txt_7 = document.getElementById('<%= txtH_GAD77.ClientID %>');

                    txt_1.value = score1;
                    txt_2.value = score2;
                    txt_3.value = score3;
                    txt_4.value = score4;
                    txt_5.value = score5;
                    txt_6.value = score6;
                    txt_7.value = score7;

                    var sumscore = parseInt(score1) + parseInt(score2) + parseInt(score3) + parseInt(score4) + parseInt(score5) + parseInt(score6) + parseInt(score7);

                    var txtlink = document.getElementById('<%= txtH_link.ClientID %>');

                    if (parseInt(sumscore) >= 10) {
                        //window.location.href = "GAD7Postive.aspx";
                        txtlink.value = "GAD7Postive";
                    } else {
                        //window.location.href = "GAD7Negative.aspx";
                        txtlink.value = "GAD7Negative";
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
