<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Result.aspx.cs" Inherits="BRH_Plubic.MentalHealthClinic.Result" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">
   
     <!-- Yellow -->
    <div class="col-lg-8 col-sm-11 mx-auto" id="div_yellow" runat="server" visible="false">
       <div class="card">
        <div class="card-body" style="background-color:yellow" runat="server">
                <div class="card-header text-center" style="background-color:lightgoldenrodyellow"><h5>ทางโรงพยาบาลได้รับข้อมูลของคุณแล้ว<br /> และจะมีเจ้าหน้าที่ติดต่อกลับตามช่องทางที่คุณให้ไว้โดยเร็วที่สุดค่ะ</h5></div>
                        <div class="text-center"><img src="img/smile2.png" width="120px"/></div>
                            <div class="container text-center">
                            
                       
                      </div>  
                 </div>                   
            </div>
      </div>
    <!-- ColorRedNegative (DASS-21) -->
     <div class="col-lg-8 col-sm-11 mx-auto" id="div_dass21_neg" runat="server" visible="false">
            <div class="card">
                <div class="card-body" style="background-color:navajowhite" runat="server" >
                    <div class="card-header text-center h3" style="background-color:lemonchiffon">จากผลของแบบประเมินสุขภาพจิต <br /> ในด้านภาวะซึมเศร้า/ภาวะวิตกกังวล/ภาวะเครียด พบว่า</div>
                    <div class="text-center"><img src="img/smile2.png" width="120px"/></div>
                    <div class="container h4" style="color:darkslategray;">
                        คุณอยู่ในภาวะ "ปกติ"<br /> 
                        แต่ด้วยสถานการณ์ความตึงเครียดต่างๆในปัจจุบัน อาจส่งผลให้เกิด ภาวะความทุกข์ ไม่สบายใจสูงได้<br />                       
                        • ทางโรงพยาบาล ได้รับข้อมูลของคุณแล้ว และมีผู้เชี่ยวชาญที่ยินดีจะให้คำปรึกษาคุณในด้านสุขภาพจิต <br />
                        • กรุณารอซักครู่ จะมีเจ้าหน้าที่ติดต่อกลับ ตามช่องทางที่คุณให้ไว้โดยเร็วที่สุด     
                        

                    </div>                   
                </div>
            </div>
        </div>
    <!-- PHQ9 Negative -->
    <div class="col-lg-8 col-sm-11 mx-auto" id="div_phq9_neg" runat="server" visible="false">
            <div class="card">
                <div class="card-body" style="background-color:navajowhite" runat="server">
                    <div class="card-header text-center h3" style="background-color:lemonchiffon">จากผลของแบบประเมินโรคซึมเศร้า พบว่า</div>
                    <div class="text-center"><img src="img/smile2.png" width="120px"/></div>
                    <div class="container h3" style="color:darkslategray;">
                        คุณเข้าข่าย ภาวะซึมเศร้า และด้วยสถานการณ์ความตึงเครียดต่างๆในปัจจุบัน อาจส่งผลให้เกิด ภาวะความทุกข์ ไม่สบายใจสูงได้<br />
                        • ทางโรงพยาบาล ได้รับข้อมูลของคุณแล้ว และนักจิตวิทยายินดีจะให้คำปรึกษาคุณในด้านสุขภาพจิต
                          กรุณารอซักครู่ จะมีเจ้าหน้าที่ติดต่อกลับ ตามช่องทางที่คุณให้ไว้โดยเร็วที่สุด
                        
                    </div>                    
                </div>
            </div>
        </div>
    <!-- PHQ8 Positive -->
    <div class="col-lg-8 col-sm-11 mx-auto" id="div_phq8_pos" runat="server" visible="false">
            <div class="card">
                <div class="card-body" style="background-color:lightpink" runat="server" >
                    <div class="card-header text-center h3" style="background-color:mistyrose">จากผลของแบบประเมินการฆ่าตัวตาย พบว่า</div>
                    <div class="text-center"><img src="img/sad.png" width="120px"/></div>
                    <div class="container text-center h4" style="color:darkslategrey;">
                        คุณมีความเสี่ยงต่อ การฆ่าตัวตาย กรุณา "อย่าอยู่คนเดียว และติดต่อโรงพยาบาลใกล้บ้าน โดยด่วน"<br />
                        หรือติดต่อที่แผนกฉุกเฉิน โรงพยาบาลกรุงเทพระยอง สายด่วน 1719
                                                
                    </div>                  
                </div>
            </div>
        </div>
    <!-- PHQ8 Negative -->
    <div class="col-lg-8 col-sm-11 mx-auto" id="div_phq8_neg" runat="server" visible="false">
            <div class="card">
                <div class="card-body" style="background-color:navajowhite" runat="server" >
                    <div class="card-header text-center h3" style="background-color:lemonchiffon">จากผลของแบบประเมินการฆ่าตัวตาย พบว่า</div>
                        <div class="text-center"><img src="img/smile2.png" width="120px"/></div>
                            <div class="container  h4" style="color:darkslategray;">
                                คุณไม่มีความเสี่ยงต่อ การฆ่าตัวตายในปัจจุบัน<br />
                                แต่จากแบบประเมินโรคซึมเศร้า คุณเข้าข่าย โรคซึมเศร้า และยังมีความเสี่ยงต่อการทำร้ายตัวเองอยู่<br />
                                • ทางโรงพยาบาลได้รับข้อมูลของคุณแล้ว  และขออนุญาตแนะนำให้ทำนัดพบกับจิตแพทย์ เป็นกรณีเร่งด่วน <br />
                                • โดยจะมีเจ้าหน้าที่ติดต่อกลับไป เพื่อทำนัดหมายกับจิตแพทย์ ตามช่องทางที่คุณให้ไว้โดยเร็วที่สุด
                        
                            </div>
                     </div>                  
                </div>
            </div>
     <!-- GAD7 Positive -->
     <div class="col-lg-8 col-sm-11 mx-auto" id="div_gad7_pos" runat="server" visible="false">
            <div class="card">
                <div class="card-body" style="background-color:lightpink" runat="server" >
                    <div class="card-header text-center h3" style="background-color:mistyrose">จากผลของแบบประเมินความวิตกกังวล พบว่า</div>
                        <div class="text-center"><img src="img/sad.png" width="120px"/></div>
                            <div class="container text-center h4" style="color:darkslategrey;">
                                คุณเข้าข่าย โรควิตกกังวล<br />และขออนุญาตแนะนำให้ทำนัดพบกับจิตแพทย์ เป็นกรณีเร่งด่วน 
                               <br />ทางโรงพยาบาลได้รับข้อมูลของคุณแล้ว<br /> จะมีเจ้าหน้าที่ติดต่อกลับไป เพื่อทำนัดหมายกับจิตแพทย์ ตามช่องทางที่คุณให้ไว้โดยเร็วที่สุด
                                                
                            </div>                   
                    </div>
                </div>
            </div>
    <!-- GAD7 Negative -->
     <div class="col-lg-8 col-sm-11 mx-auto" id="div_gad7_neg" runat="server" visible="false">
            <div class="card">
                <div class="card-body" style="background-color:navajowhite" runat="server" >
                    <div class="card-header text-center h3" style="background-color:lemonchiffon">จากผลของแบบประเมินความวิตกกังวล พบว่า</div>
                    <div class="text-center"><img src="img/smile2.png" width="120px"/></div>
                    <div class="container  h4" style="color:darkslategray;">
                        คุณเข้าข่าย ภาวะวิตกกังวล<br />
                        และด้วยสถานการณ์ความตึงเครียดต่างๆในปัจจุบัน อาจส่งผลให้เกิด ภาวะความทุกข์ ไม่สบายใจสูงได้<br />                       
                        • ทางโรงพยาบาล ได้รับข้อมูลของคุณแล้ว และนักจิตวิทยายินดีจะให้คำปรึกษาคุณในด้านสุขภาพจิต<br />
                        • กรุณารอซักครู่ จะมีเจ้าหน้าที่ติดต่อกลับ ตามช่องทางที่คุณให้ไว้โดยเร็วที่สุด
                        
                    </div>                    
                </div>
            </div>
        </div>
    <!-- SPST20 Positive -->
    <div class="col-lg-8 col-sm-11 mx-auto" id="div_spst_pos" runat="server" visible="false">
            <div class="card">
                <div class="card-body" style="background-color:lightpink" runat="server" >
                    <div class="card-header text-center h3" style="background-color:mistyrose">จากผลของแบบประเมินความเครียด พบว่า</div>
                     <div class="text-center"><img src="img/sad.png" width="120px"/></div>
                        <div class="container text-center h4" style="color:darkslategrey;">
                            คุณเข้าข่าย ภาวะเครียดสูง<br /> ซึ่งนำไปสู่โรคซึมเศร้าหรือวิตกกังวลได้ ขออนุญาตแนะนำให้ทำนัดพบกับจิตแพทย์ เป็นกรณีเร่งด่วน    
                           <br />ทางโรงพยาบาลได้รับข้อมูลของคุณแล้ว <br /> จะมีเจ้าหน้าที่ติดต่อกลับไป เพื่อทำนัดหมายกับจิตแพทย์ ตามช่องทางที่คุณให้ไว้โดยเร็วที่สุดค่ะ
                                                
                        </div>                    
                </div>                
            </div>
        </div>
    <!-- SPST20 Negative -->
    <div class="col-lg-8 col-sm-11 mx-auto" id="div_spst_neg" runat="server" visible="false">
            <div class="card">
                <div class="card-body" style="background-color:navajowhite" runat="server" >
                    <div class="card-header text-center h3" style="background-color:lemonchiffon">จากผลของแบบประเมินความเครียด พบว่า</div>
                    <div class="text-center"><img src="img/smile2.png" width="120px"/></div>
                    <div class="container text-center h4" style="color:darkslategray;">
                       คุณเข้าข่าย ภาวะเครียด <br /> 
                        และด้วยสถานการณ์ความตึงเครียดต่างๆในปัจจุบัน อาจส่งผลให้เกิด ภาวะความทุกข์ ไม่สบายใจสูงได้<br />                      
                        • ทางโรงพยาบาล ได้รับข้อมูลของคุณแล้ว และนักจิตวิทยายินดีจะให้คำปรึกษาคุณในด้านสุขภาพจิต<br />
                        • กรุณารอซักครู่ จะมีเจ้าหน้าที่ติดต่อกลับ ตามช่องทางที่คุณให้ไว้โดยเร็วที่สุด
                        
                    </div>                 
                </div>              
            </div>
        </div>

     <!-- Button -->
    <div hidden="hidden">
                    <div class="card-body col-5 mx-auto" style="background-color:azure" id="register_from" >
                         <input type="text" class="form-control mt-1" placeholder="ชื่อ" id="register_fname" runat="server"/>
                         <input type="text" class="form-control mt-1" placeholder="นามสกุล" id="register_lname" runat="server"/>
                         <input type="text" class="form-control mt-1" placeholder="เบอร์โทร" id="register_pnumber" runat="server"/>
                         <input type="text" class="form-control mt-1" placeholder="LineID" id="register_line" runat="server"/>
                    </div>  
                    <div class="col-12 mt-3 mx-auto text-center">
                            <button type="button" class="btn btn-primary" id="btn_submit_result" onserverclick="btn_submit_result_ServerClick"  runat="server">Submit</button>
                    </div>
        </div>
     <!-- Button -->
   




</asp:Content>
