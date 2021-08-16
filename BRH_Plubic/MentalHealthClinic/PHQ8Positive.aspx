<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PHQ8Positive.aspx.cs" Inherits="BRH_Plubic.MentalHealthClinic.PHQ8Positive" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">
    <div class="col-lg-8 col-sm-11 mx-auto">
            <div class="card">
                <div class="card-body" style="background-color:lightpink" id="div_green">
                    <div class="card-header text-center h3" style="background-color:mistyrose">จากผลของแบบประเมินการฆ่าตัวตาย พบว่า</div>
                    <div class="text-center"><img src="img/danger.png" width="120px"/></div>
                    <div class="container text-center h4" style="color:darkslategrey;">
                        คุณมีความเสี่ยงต่อ การฆ่าตัวตาย กรุณา "อย่าอยู่คนเดียว และติดต่อโรงพยาบาลใกล้บ้าน โดยด่วน"<br />
                        หรือติดต่อที่แผนกฉุกเฉิน โรงพยาบาลกรุงเทพระยอง สายด่วน 1719 
                                                
                    </div>
                    <div hidden="hidden">
                    <div class="card-body col-5 mx-auto" style="background-color:azure" id="div_yellow" >
                         <input type="text" class="form-control mt-1" placeholder="ชื่อ" id="phq8post_fname" runat="server"/>
                         <input type="text" class="form-control mt-1" placeholder="นามสกุล" id="phq8post_lname" runat="server"/>
                         <input type="text" class="form-control mt-1" placeholder="เบอร์โทร" id="phq8post_pnumber" runat="server"/>
                         <input type="text" class="form-control mt-1" placeholder="LineID" id="phq8post_line" runat="server"/>
                    </div>  
                    <div class="col-12 mt-3 mx-auto text-center">
                            <button type="button" class="btn btn-primary" id="btn_submit_phq8post" onserverclick="btn_submit_phq8post_ServerClick"  runat="server">Submit</button>
                    </div>
                    </div>
                </div>
            </div>
        </div>
</asp:Content>
