<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GAD7toPHQ9pos.aspx.cs" Inherits="BRH_Plubic.MentalHealthClinic.GAD7toPHQ9pos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">
    <div class="col-8 mx-auto">
            <div class="card">
                <div class="card-body" style="background-color:lightpink" id="div_green">
                    <div class="card-header text-center" style="background-color:lightgoldenrodyellow"><h5>จากผลของแบบประเมินสุขภาพจิต พบว่า</h5></div>
                    <div class="text-center"><img src="img/sad.png" width="120px"/></div>
                    <div class="container text-center">
                        <h5>คุณเข้าข่าย "โรควิตกกังวล" และขออนุญาตแนะนำให้ทำนัดพบกับจิตแพทย์ เป็นกรณีเร่งด่วน </h5>
                        <h5>ทางโรงพยาบาลได้รับข้อมูลของคุณแล้ว  จะมีเจ้าหน้าที่ติดต่อกลับไป เพื่อทำนัดหมายกับจิตแพทย์ ตามช่องทางที่คุณให้ไว้โดยเร็วที่สุดค่ะ</h5>
                        <h5>แนะนำให้ทำแบบประเมินโรคซึมเศร้าต่อ โดยกด "Next"</h5>
                        
                        
                    </div>

                    <div class="col-12 mx-auto text-center">
                            <button type="button" class="btn btn-primary" id="btn_submit_gad7_to_phq9" onserverclick="btn_submit_gad7_to_phq9_ServerClick"  runat="server">Next</button>
                        </div>
                </div>
            </div>
        </div>
</asp:Content>
