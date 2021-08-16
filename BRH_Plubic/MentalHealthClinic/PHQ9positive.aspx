<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PHQ9positive.aspx.cs" Inherits="BRH_Plubic.MentalHealthClinic.PHQ9positive" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">
    <!-- Yellow -->
    <div class="col-lg-8 col-sm-11 mx-auto" id="div_phq9_pos" runat="server">
       <div class="card">
        <div class="card-body" style="background-color:lightpink" runat="server">
                <div class="card-header text-center" style="background-color:lightgoldenrodyellow"><h5>จากผลของแบบประเมินโรคซึมเศร้า พบว่า</h5></div>
                        <div class="text-center"><img src="img/smile2.png" width="120px"/></div>
                            <div class="container text-center">
                            <h3>คุณเข้าข่าย โรคซึมเศร้าและเสี่ยงต่อการทำร้ายตัวเอง </h3>
                                <h3>ทำแบบประเมินแนวโน้มการฆ่าตัวตายต่อ โดยกด "Next" ค่ะ</h3>
                            <h5>ทางโรงพยาบาลได้รับข้อมูลของคุณแล้ว  และขออนุญาตแนะนำให้ทำนัดพบกับจิตแพทย์ เป็นกรณีเร่งด่วน
                                โดยจะมีเจ้าหน้าที่ติดต่อกลับไป เพื่อทำนัดหมายกับจิตแพทย์ ตามช่องทางที่คุณให้ไว้โดยเร็วที่สุดค่ะ</h5>
                   
                      </div> 
             <!-- Button -->            
                    <div class="col-12 mt-3 mx-auto text-center">
                            <button type="button" class="btn btn-primary" id="btn_submit_phq9pos" onserverclick="btn_submit_phq9pos_ServerClick"  runat="server">Next</button>
                    </div>
     <!-- Button -->
                 </div>  
                
            </div>
      </div>
</asp:Content>
