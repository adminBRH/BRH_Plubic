<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GAD7Postive.aspx.cs" Inherits="BRH_Plubic.MentalHealthClinic.GAD7Postive" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">
     <div class="col-lg-8 col-sm-11 mx-auto">
            <div class="card">
                <div class="card-body" style="background-color:lightpink" id="div_green">
                    <div class="card-header text-center h3" style="background-color:mistyrose">จากผลของแบบประเมินความวิตกกังวล พบว่า</div>
                    <div class="text-center"><img src="img/danger.png" width="120px"/></div>
                    <div class="container text-center h4" style="color:darkslategrey;">
                        คุณเข้าข่าย โรควิตกกังวล <br /> และขออนุญาตแนะนำให้ทำนัดพบกับจิตแพทย์ เป็นกรณีเร่งด่วน 
                       <br /> ทางโรงพยาบาลได้รับข้อมูลของคุณแล้ว <br />จะมีเจ้าหน้าที่ติดต่อกลับไป เพื่อทำนัดหมายกับจิตแพทย์ ตามช่องทางที่คุณให้ไว้โดยเร็วที่สุด
                                                
                    </div>
                    <div class="card-body col-5 mx-auto" style="background-color:azure" id="div_yellow" >
                         <input type="text" class="form-control mt-1" placeholder="ชื่อ" id="gad7post_fname" runat="server"/>
                         <input type="text" class="form-control mt-1" placeholder="นามสกุล" id="gad7post_lname" runat="server"/>
                         <input type="text" class="form-control mt-1" placeholder="เบอร์โทร" id="gad7post_pnumber" runat="server"/>
                         <input type="text" class="form-control mt-1" placeholder="LineID" id="gad7post_line" runat="server"/>
                    </div>  
                    <div class="col-12 mt-3 mx-auto text-center">
                            <button type="button" class="btn btn-primary" id="btn_submit_gad7post" onserverclick="btn_submit_gad7post_ServerClick"  runat="server">Submit</button>
                    </div>
                </div>
            </div>
        </div>
</asp:Content>
