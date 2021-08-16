<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PHQ8Negative.aspx.cs" Inherits="BRH_Plubic.MentalHealthClinic.PHQ8Negative" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">
    <div class="col-lg-8 col-sm-11 mx-auto">
            <div class="card">
                <div class="card-body" style="background-color:navajowhite" id="div_green">
                    <div class="card-header text-center h3" style="background-color:lemonchiffon">จากผลของแบบประเมินการฆ่าตัวตาย พบว่า</div>
                    <div class="text-center"><img src="img/smile2.png" width="120px"/></div>
                    <div class="container text-center h4" style="color:darkslategray;">
                        คุณไม่มีความเสี่ยงต่อ การฆ่าตัวตายในปัจจุบัน ค่ะ <br />
                        แต่จากแบบประเมินโรคซึมเศร้า คุณเข้าข่าย โรคซึมเศร้า และยังมีความเสี่ยงต่อการทำร้ายตัวเองอยู่<br />
                        - ทางโรงพยาบาลได้รับข้อมูลของคุณแล้ว  และขออนุญาตแนะนำให้ทำนัดพบกับจิตแพทย์ เป็นกรณีเร่งด่วน <br />
                        - โดยจะมีเจ้าหน้าที่ติดต่อกลับไป เพื่อทำนัดหมายกับจิตแพทย์ ตามช่องทางที่คุณให้ไว้โดยเร็วที่สุดค่ะ
                        
                    </div>
                    <div hidden="hidden">
                    <div class="card-body col-5 mx-auto" style="background-color:azure" id="div_yellow" >
                         <input type="text" class="form-control mt-1" placeholder="ชื่อ" id="phq8neg_fname" runat="server"/>
                         <input type="text" class="form-control mt-1" placeholder="นามสกุล" id="phq8neg_lname" runat="server"/>
                         <input type="text" class="form-control mt-1" placeholder="เบอร์โทร" id="phq8neg_pnumber" runat="server"/>
                         <input type="text" class="form-control mt-1" placeholder="LineID" id="phq8neg_line" runat="server"/>
                    </div>
                        <div class="col-12 mt-3 mx-auto text-center">
                                <button type="button" class="btn btn-primary" id="btn_submit_phq8neg" onserverclick="btn_submit_phq8neg_ServerClick"  runat="server">Submit</button>
                        </div>
                    </div>
                   </div>                  
                </div>
            </div>
        
    
</asp:Content>
