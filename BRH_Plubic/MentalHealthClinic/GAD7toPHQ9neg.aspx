<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GAD7toPHQ9neg.aspx.cs" Inherits="BRH_Plubic.MentalHealthClinic.GAD7toPHQ9neg" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">
    <div class="col-8 mx-auto">
            <div class="card">
                <div class="card-body" style="background-color:lightpink" id="div_green">
                    <div class="card-header text-center" style="background-color:lightgoldenrodyellow"><h5>จากผลของแบบประเมินความวิตกกังวล พบว่า</h5></div>
                    <div class="text-center"><img src="img/sad.png" width="120px"/></div>
                    <div class="container text-center">
                        <h5>คุณเข้าข่าย ภาวะวิตกกังวล ค่ะ และด้วยสถานการณ์ความตึงเครียดต่างๆในปัจจุบัน อาจส่งผลให้เกิด ภาวะความทุกข์ ไม่สบายใจสูงได้</h5>
                        <h5>ทางโรงพยาบาล ได้รับข้อมูลของคุณแล้ว และนักจิตวิทยายินดีจะให้คำปรึกษาคุณในด้านสุขภาพจิต  </h5>
                        <h5>กรุณารอซักครู่ จะมีเจ้าหน้าที่ติดต่อกลับ ตามช่องทางที่คุณให้ไว้โดยเร็วที่สุดค่ะ</h5>
                        <h5>แนะนำให้ทำแบบประเมินโรคซึมเศร้าต่อ โดยกด "Next"</h5>
                        
                        
                    </div>

                    <div class="col-12 mx-auto text-center">
                            <button type="button" class="btn btn-primary" id="btn_submit_gad7_to_phq9" onserverclick="btn_submit_gad7_to_phq9_ServerClick"  runat="server">Next</button>
                        </div>
                </div>
            </div>
        </div>
</asp:Content>
