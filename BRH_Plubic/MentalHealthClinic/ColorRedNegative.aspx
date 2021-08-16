<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ColorRedNegative.aspx.cs" Inherits="BRH_Plubic.MentalHealthClinic.ColorRedNegative" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">
     <div class="col-lg-8 col-sm-11 mx-auto">
            <div class="card">
                <div class="card-body" style="background-color:navajowhite" id="div_green">
                    <div class="card-header text-center h3" style="background-color:lemonchiffon">จากผลของแบบประเมินสุขภาพจิต<br /> ในด้านภาวะซึมเศร้า/ภาวะวิตกกังวล/ภาวะเครียด พบว่า</div>
                    <div class="text-center"><img src="img/smile2.png" width="120px"/></div>
                    <div class="container  h4" style="color:darkslategray;">
                        คุณอยู่ในภาวะ "ปกติ" <br /> 
                        แต่ด้วยสถานการณ์ความตึงเครียดต่างๆในปัจจุบัน อาจส่งผลให้เกิด ภาวะความทุกข์ ไม่สบายใจสูงได้<br />                       
                        • ทางโรงพยาบาล ได้รับข้อมูลของคุณแล้ว และมีผู้เชี่ยวชาญที่ยินดีจะให้คำปรึกษาคุณในด้านสุขภาพจิต <br />
                        • กรุณารอซักครู่ จะมีเจ้าหน้าที่ติดต่อกลับ ตามช่องทางที่คุณให้ไว้โดยเร็วที่สุด     
                        

                    </div>
                    <div hidden="hidden">
                    <div class="card-body col-5 mx-auto" style="background-color:azure" id="div_yellow" >
                         <input type="text" class="form-control mt-1" placeholder="ชื่อ" id="yelneg_fname" runat="server"/>
                         <input type="text" class="form-control mt-1" placeholder="นามสกุล" id="yelneg_lname" runat="server"/>
                         <input type="text" class="form-control mt-1" placeholder="เบอร์โทร" id="yelneg_pnumber" runat="server"/>
                         <input type="text" class="form-control mt-1" placeholder="LineID" id="yelneg_line" runat="server"/>
                    </div>  
                    <div class="col-12 mt-3 mx-auto text-center">
                            <button type="button" class="btn btn-primary" id="btn_submit_ylneg" onserverclick="btn_submit_ylneg_ServerClick"  runat="server">Submit</button>
                    </div>
                   </div>
                </div>
            </div>
        </div>
</asp:Content>
