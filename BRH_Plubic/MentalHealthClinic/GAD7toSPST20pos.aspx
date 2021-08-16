<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GAD7toSPST20pos.aspx.cs" Inherits="BRH_Plubic.MentalHealthClinic.GAD7toSPST20pos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">
    <div class="col-8 mx-auto">
            <div class="card">
                <div class="card-body" style="background-color:lightpink" id="div_green">
                    <div class="card-header text-center" style="background-color:lightgoldenrodyellow"><h5>จากผลของแบบประเมินความวิตกกังวล พบว่า</h5></div>
                    <div class="text-center"><img src="img/sad.png" width="120px"/></div>
                    <div class="container ">
                        <h4>คุณเข้าข่าย "โรควิตกกังวล" <br />และขออนุญาตแนะนำให้ทำนัดพบกับจิตแพทย์ เป็นกรณีเร่งด่วน
                               <br />ทางโรงพยาบาลได้รับข้อมูลของคุณแล้ว จะมีเจ้าหน้าที่ติดต่อกลับไป เพื่อทำนัดหมายกับจิตแพทย์ ตามช่องทางที่คุณให้ไว้โดยเร็วที่สุด<br />
                        กรุณากด "NEXT" เพื่อทำแบบประเมินความเครียดต่อ </h4>
                        
                        
                    </div>

                    <div class="col-12 mx-auto text-center">
                            <button type="button" class="btn btn-primary" id="btn_submit_GAD7_to_spst" onserverclick="btn_submit_GAD7_to_spst_ServerClick"  runat="server">Next</button>
                        </div>
                </div>
            </div>
        </div>
</asp:Content>
