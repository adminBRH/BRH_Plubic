<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PHQ8.aspx.cs" Inherits="BRH_Plubic.MentalHealthClinic.PHQ8" %>
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
            <h2>แบบประเมินการฆ่าตัวตาย 8 คำถาม (PHQ-8)</h2>
        </div>
    </div>
        <div class="card col-10 mx-auto">        
             <div class="card-body"> 
                 <!-- หัว Colum 1  -->
                      <div class="row" >
                            <div class="card-header col-1 mx-auto text-center" style="background-color:lightcyan">
                                <h4>ไม่มี</h4>
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:lightcyan">
                                <h4>มี</h4>
                            </div> 
                            <div class="card-header col-10 mx-auto" style="background-color:lightpink">
                                <h4>ปัญหาในชีวิตประจำวันทั่วไป</h4>
                            </div>
                          
                        <div class="w-100"></div>
                          <!-- คำตอบ  -->
                            <div class="card-header col-1 mx-auto text-center" style="background-color:azure">
                                <input type="radio" id="PHQ8_1_0"  name="PHQ8_1" value="0"  />          
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:azure">
                                <input type="radio" id="PHQ8_1_01" name="PHQ8_1" value="1"  />
                            </div>     
                            <div class="card-header col-10 mx-auto" style="background-color:azure">
                               1. คิดอยากตาย หรือ คิดว่าตายไปจะดีกว่า                       
                            </div>
                           <!--  คำตอบ -->
                           <!-- คำตอบ  -->
                            <div class="card-header col-1 mx-auto text-center" style="background-color:azure">
                                <input type="radio" id="PHQ8_2_0"  name="PHQ8_2" value="0"  />          
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:azure">
                                <input type="radio" id="PHQ8_2_01" name="PHQ8_2" value="2"  />
                            </div>     
                            <div class="card-header col-10 mx-auto" style="background-color:azure">
                               2. อยากทำร้ายตัวเอง หรือ ทำให้ตัวเองบาดเจ็บ                       
                            </div>
                           <!--  คำตอบ -->
                           <!-- คำตอบ  -->
                            <div class="card-header col-1 mx-auto text-center" style="background-color:azure">
                                <input type="radio" id="PHQ8_3_0"  name="PHQ8_3" value="0" onclick="ShowHide()" />          
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:azure">
                                <input type="radio" id="PHQ8_3_01" name="PHQ8_3" value="6" onclick="ShowHide()" />
                            </div>     
                            <div class="card-header col-10 mx-auto" style="background-color:azure">
                               3. คิดเกี่ยวกับการฆ่าตัวตาย                       
                            </div>
                   <!--  คำตอบ -->   
                       <div class="row col-12"  id="hidden_phq8" hidden="hidden">
                          <!-- คำตอบ  -->
                            <div class="card-header col-1 mx-auto text-center" style="background-color:azure">
                                <input type="radio" id="PHQ8_4_0"  name="PHQ8_4" value="0"  /> ได้         
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:azure">
                                <input type="radio" id="PHQ8_4_01" name="PHQ8_4" value="8"  /> ไม่ได้
                            </div>     
                            <div class="card-header col-10 mx-auto" style="background-color:lightpink">
                                <u>(ถ้าตอบว่าคิดเกี่ยวกับฆ่าตัวตายให้ตอบคำถามข้อนี้ต่อ)</u>..ในช่วง 1 เดือนที่ผ่านมารวมวันนี้  ท่านสามารถควบคุมความอยากฆ่าตัวตายที่ท่านคิดอยู่นั้นได้หรือไม่ หรือ บอกได้ไหมว่าคงจะไม่ทำตามความคิดนั้นในขณะนี้                      
                            </div>
                           </div>
                           <!--  คำตอบ -->
                           <!-- คำตอบ  -->
                            <div class="card-header col-1 mx-auto text-center" style="background-color:azure">
                                <input type="radio" id="PHQ8_5_0"  name="PHQ8_5" value="0"  />          
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:azure">
                                <input type="radio" id="PHQ8_5_01" name="PHQ8_5" value="8"  />
                            </div>     
                            <div class="card-header col-10 mx-auto" style="background-color:azure">
                               4. ในช่วง 1 เดือนที่ผ่านมารวมวันนื้ มีแผนการที่จะฆ่าตัวตาย                       
                            </div>
                           <!--  คำตอบ -->
                           <!-- คำตอบ  -->
                            <div class="card-header col-1 mx-auto text-center" style="background-color:azure">
                                <input type="radio" id="PHQ8_6_0"  name="PHQ8_6" value="0"  />          
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:azure">
                                <input type="radio" id="PHQ8_6_01" name="PHQ8_6" value="9"  />
                            </div>     
                            <div class="card-header col-10 mx-auto" style="background-color:azure">
                               5. ในช่วง 1 เดือนที่ผ่านมารวมวันนี้ ได้เตรียมการที่จะทำร้ายตนเองหรือเตรียมการจะฆ่าตัวตายโดยตั้งใจว่าจะให้ตายจริง ๆ                       
                            </div>
                           <!--  คำตอบ -->
                           <!-- คำตอบ  -->
                            <div class="card-header col-1 mx-auto text-center" style="background-color:azure">
                                <input type="radio" id="PHQ8_7_0"  name="PHQ8_7" value="0"  />          
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:azure">
                                <input type="radio" id="PHQ8_7_01" name="PHQ8_7" value="4"  />
                            </div>     
                            <div class="card-header col-10 mx-auto" style="background-color:azure">
                               6. ได้ทำให้ตนเองบาดเจ็บแต่ไม่ตั้งใจที่จะทำให้เสียชีวิต                       
                            </div>
                           <!--  คำตอบ -->
                           <!-- คำตอบ  -->
                            <div class="card-header col-1 mx-auto text-center" style="background-color:azure">
                                <input type="radio" id="PHQ8_8_0"  name="PHQ8_8" value="0" />          
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:azure">
                                <input type="radio" id="PHQ8_8_01"  name="PHQ8_8" value="10"  />
                            </div>     
                            <div class="card-header col-10 mx-auto" style="background-color:azure">
                               7. ได้พยายามฆ่าตัวตายโดยคาดหวัง/ตั้งใจที่จะให้ตาย                       
                            </div>
                           <!--  คำตอบ -->
                           <!-- คำตอบ  -->
                            <div class="card-header col-1 mx-auto text-center" style="background-color:azure">
                                <input type="radio" id="PHQ8_9_0"  name="PHQ8_9" value="0"  />          
                            </div>
                            <div class="card-header col-1 mx-auto text-center" style="background-color:azure">
                                <input type="radio" id="PHQ8_9_01" name="PHQ8_9" value="4"  />
                            </div>     
                            <div class="card-header col-10 mx-auto" style="background-color:azure">
                               8. ตลอดชีวิตที่ผ่านมาท่านเคยพยายามฆ่าตัวตาย                       
                            </div>
                              
                          
                           <!--  คำตอบ -->      
                          <div hidden="hidden">
                              <input type="text" id="txtH_PHQ81" value="0" runat="server"/>                             
                              <input type="text" id="txtH_PHQ82" value="0" runat="server"/>                             
                              <input type="text" id="txtH_PHQ83" value="0" runat="server"/>                             
                              <input type="text" id="txtH_PHQ84" value="0" runat="server"/>                             
                              <input type="text" id="txtH_PHQ85" value="0" runat="server"/>                             
                              <input type="text" id="txtH_PHQ86" value="0" runat="server"/>                             
                              <input type="text" id="txtH_PHQ87" value="0" runat="server"/>                             
                              <input type="text" id="txtH_PHQ88" value="0" runat="server"/>                             
                              <input type="text" id="txtH_PHQ89" value="0" runat="server"/>                                                                                     
                          </div>
                       </div>
                 </div>
            </div>
            </div>
                    <div class="card-footer col-10 mx-auto text-center" onmouseover="GetScore()" style="background-color:lightcoral">
                            <%--<button type="button" class="btn btn-light " id="btn_submit1" onmouseover="GetScore()" onserverclick="btn_submit1_ServerClick" runat="server">Submit</button>--%>
                    <button id="btn_submit_phq8" onserverclick="btn_submit_phq8_ServerClick" class="btn btn-light" runat="server">SUBMIT</button>
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
            <!-- script hide -->
                <script>
                    var phq8show = document.getElementById("PHQ8_3_01");
                    var divhide = document.getElementById("hidden_phq8");
                    if (phq8show.checked) {
                        divhide.hidden = "";
                    }

                    function ShowHide() {
                        if (phq8show.checked) {
                            divhide.hidden = "";
                        } else {
                            divhide.hidden = "hidden";
                        }
                    }
                </script>
                    <!-- -->
            <script>
                function GetScore() {

                    var score1 = LoopVal('PHQ8_1');
                    var score2 = LoopVal('PHQ8_2');
                    var score3 = LoopVal('PHQ8_3');
                    var score4 = LoopVal('PHQ8_4');
                    var score5 = LoopVal('PHQ8_5');
                    var score6 = LoopVal('PHQ8_6');
                    var score7 = LoopVal('PHQ8_7');
                    var score8 = LoopVal('PHQ8_8');
                    var score9 = LoopVal('PHQ8_9');

                    var txt_1 = document.getElementById('<%= txtH_PHQ81.ClientID %>');
                    var txt_2 = document.getElementById('<%= txtH_PHQ82.ClientID %>');
                    var txt_3 = document.getElementById('<%= txtH_PHQ83.ClientID %>');
                    var txt_4 = document.getElementById('<%= txtH_PHQ84.ClientID %>');
                    var txt_5 = document.getElementById('<%= txtH_PHQ85.ClientID %>');
                    var txt_6 = document.getElementById('<%= txtH_PHQ86.ClientID %>');
                    var txt_7 = document.getElementById('<%= txtH_PHQ87.ClientID %>');
                    var txt_8 = document.getElementById('<%= txtH_PHQ88.ClientID %>');
                    var txt_9 = document.getElementById('<%= txtH_PHQ89.ClientID %>');

                    txt_1.value = score1;
                    txt_2.value = score2;
                    txt_3.value = score3;
                    txt_4.value = score4;
                    txt_5.value = score5;
                    txt_6.value = score6;
                    txt_7.value = score7;
                    txt_8.value = score8;
                    txt_9.value = score9;

                    var sumscore = parseInt(score1) + parseInt(score2) + parseInt(score3) + parseInt(score4) + parseInt(score5) + parseInt(score6) + parseInt(score7) + parseInt(score8) + parseInt(score9);

                    var txtlink = document.getElementById('<%= txtH_link.ClientID %>');

                    if (parseInt(sumscore) >= 17) {
                        //window.location.href = "PHQ8Positive.aspx";
                        txtlink.value = "PHQ8Positive";
                    } else {
                        //window.location.href = "PHQ8Negative.aspx";
                        txtlink.value = "PHQ8Negative";
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
