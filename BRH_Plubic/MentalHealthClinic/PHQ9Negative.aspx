<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PHQ9Negative.aspx.cs" Inherits="BRH_Plubic.MentalHealthClinic.PHQ9Negative" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">
    <div class="col-lg-8 col-sm-11 mx-auto">
            <div class="card">
                <div class="card-body" style="background-color:navajowhite" id="div_green">
                    <div class="card-header text-center h3" style="background-color:lemonchiffon">จากผลของแบบประเมินโรคซึมเศร้า พบว่า</div>
                    <div class="text-center"><img src="img/smile2.png" width="120px"/></div>
                    <div class="container h3" style="color:darkslategray;">
                        คุณเข้าข่าย ภาวะซึมเศร้า ค่ะ และด้วยสถานการณ์ความตึงเครียดต่างๆในปัจจุบัน อาจส่งผลให้เกิด ภาวะความทุกข์ ไม่สบายใจสูงได้<br />
                        - ทางโรงพยาบาล ได้รับข้อมูลของคุณแล้ว และนักจิตวิทยายินดีจะให้คำปรึกษาคุณในด้านสุขภาพจิต
                         กรุณารอซักครู่ จะมีเจ้าหน้าที่ติดต่อกลับ ตามช่องทางที่คุณให้ไว้โดยเร็วที่สุดค่ะ
                        
                    </div>
                    <div hidden="hidden">
                    <div class="card-body col-5 mx-auto" style="background-color:azure" id="div_yellow" >
                         <input type="text" class="form-control mt-1" placeholder="ชื่อ" id="phqneg_fname" runat="server"/>
                         <input type="text" class="form-control mt-1" placeholder="นามสกุล" id="phqneg_lname" runat="server"/>
                         <input type="text" class="form-control mt-1" placeholder="เบอร์โทร" id="phqneg_pnumber" runat="server"/>
                         <input type="text" class="form-control mt-1" placeholder="LineID" id="phqneg_line" runat="server"/>
                    </div>  
                    <div class="col-12 mt-3 mx-auto text-center">
                            <button type="button" class="btn btn-primary" id="btn_submit_phqneg" onserverclick="btn_submit_phqneg_ServerClick"  runat="server">Submit</button>
                    </div>
                  </div>
                </div>
            </div>
        </div>
</asp:Content>
