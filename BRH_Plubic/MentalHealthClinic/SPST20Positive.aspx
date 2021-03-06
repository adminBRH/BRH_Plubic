<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SPST20Positive.aspx.cs" Inherits="BRH_Plubic.MentalHealthClinic.SPST20Positive" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">
    <div class="col-lg-8 col-sm-11 mx-auto">
            <div class="card">
                <div class="card-body" style="background-color:lightpink" id="div_green">
                    <div class="card-header text-center h3" style="background-color:mistyrose">จากผลของแบบประเมินความเครียด พบว่า</div>
                    <div class="text-center"><img src="img/danger.png" width="120px"/></div>
                    <div class="container text-center h4" style="color:darkslategrey;">
                        คุณเข้าข่าย ภาวะเครียดสูง<br /> ซึ่งนำไปสู่โรคซึมเศร้าหรือวิตกกังวลได้ ขออนุญาตแนะนำให้ทำนัดพบกับจิตแพทย์ เป็นกรณีเร่งด่วน    
                       <br /> ทางโรงพยาบาลได้รับข้อมูลของคุณแล้ว <br /> จะมีเจ้าหน้าที่ติดต่อกลับไป เพื่อทำนัดหมายกับจิตแพทย์ ตามช่องทางที่คุณให้ไว้โดยเร็วที่สุด
                                                
                    </div>
                    <div hidden="hidden">
                    <div class="card-body col-5 mx-auto" style="background-color:azure" id="div_yellow" >
                         <input type="text" class="form-control mt-1" placeholder="ชื่อ" id="spst20post_fname" runat="server"/>
                         <input type="text" class="form-control mt-1" placeholder="นามสกุล" id="spst20post_lname" runat="server"/>
                         <input type="text" class="form-control mt-1" placeholder="เบอร์โทร" id="spst20post_pnumber" runat="server"/>
                         <input type="text" class="form-control mt-1" placeholder="LineID" id="spst20post_line" runat="server"/>
                    </div>  
                    <div class="col-12 mt-3 mx-auto text-center">
                            <button type="button" class="btn btn-primary" id="btn_submit_spst20post" onserverclick="btn_submit_spst20post_ServerClick"  runat="server">Submit</button>
                    </div>
                    </div>
                </div>
                
            </div>
        </div>
</asp:Content>
