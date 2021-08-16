<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GAD7Negative.aspx.cs" Inherits="BRH_Plubic.MentalHealthClinic.GAD7Negative" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">
    <div class="col-lg-8 col-sm-11 mx-auto">
            <div class="card">
                <div class="card-body" style="background-color:navajowhite" id="div_green">
                    <div class="card-header text-center h3" style="background-color:lemonchiffon">จากผลของแบบประเมินความวิตกกังวล พบว่า</div>
                    <div class="text-center"><img src="img/smile2.png" width="120px"/></div>
                    <div class="container text-center h4" style="color:darkslategray;">
                        คุณเข้าข่าย ภาวะวิตกกังวล ค่ะ<br />
                        และด้วยสถานการณ์ความตึงเครียดต่างๆในปัจจุบัน อาจส่งผลให้เกิด ภาวะความทุกข์ ไม่สบายใจสูงได้ <br />                       
                        - ทางโรงพยาบาล ได้รับข้อมูลของคุณแล้ว และนักจิตวิทยายินดีจะให้คำปรึกษาคุณในด้านสุขภาพจิต  <br />
                        - กรุณารอซักครู่ จะมีเจ้าหน้าที่ติดต่อกลับ ตามช่องทางที่คุณให้ไว้โดยเร็วที่สุดค่ะ
                        
                    </div>
                    <div class="card-body col-5 mx-auto" style="background-color:azure" id="div_yellow" >
                         <input type="text" class="form-control mt-1" placeholder="ชื่อ" id="gad7neg_fname" runat="server"/>
                         <input type="text" class="form-control mt-1" placeholder="นามสกุล" id="gad7neg_lname" runat="server"/>
                         <input type="text" class="form-control mt-1" placeholder="เบอร์โทร" id="gad7neg_pnumber" runat="server"/>
                         <input type="text" class="form-control mt-1" placeholder="LineID" id="gad7neg_line" runat="server"/>
                    </div>  
                    <div class="col-12 mt-3 mx-auto text-center">
                            <button type="button" class="btn btn-primary" id="btn_submit_gad7neg" onserverclick="btn_submit_gad7neg_ServerClick"  runat="server">Submit</button>
                    </div>
                </div>
            </div>
        </div>
</asp:Content>
