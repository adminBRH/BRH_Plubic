<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Yellow.aspx.cs" Inherits="BRH_Plubic.MentalHealthClinic.Yellow" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">
    <div class="col-8 mx-auto">
            <div class="card">
                <div class="card-body" style="background-color:yellow" id="div_green">
                    
                    
                    <div class="card-header text-center" style="background-color:lightgoldenrodyellow"><h5>ทางโรงพยาบาลได้รับข้อมูลของคุณแล้ว และจะมีเจ้าหน้าที่ติดต่อกลับตามช่องทางที่คุณให้ไว้โดยเร็วที่สุด</h5></div>
                    <div class="text-center"><img src="img/smile2.png" width="120px"/></div>
                    <div class="container text-center">   
                        
                    </div>
                        <div class="card col-6 mx-auto">
                            <div class="row col-12 mt-3">
                                <div class="col-12 mb-2 text-center" style="font-size:x-large">คุณมีปัจจัยก่อความเครียดโดยรวมดังนี้</div>
                                <div class="col-8"><p>ปัญหาทางกาย</p></div>
                                <div class="col-4 text-left"> <asp:Label ID="lbl_summary_1" Text="0" runat="server"></asp:Label> ข้อ</div>
                                <div class="col-8"><p>ปัญหาทางอารมณ์</p></div>
                                <div class="col-4 text-left"> <asp:Label ID="lbl_summary_2" Text="0" runat="server"></asp:Label> ข้อ</div>
                                <div class="col-8"><p>ปัญหาทางสังคม และ สิ่งแวดล้อม</p></div>
                                <div class="col-4 text-left"> <asp:Label ID="lbl_summary_3" Text="0" runat="server"></asp:Label> ข้อ</div>
                            </div>
                            <div class="row col-12">
                        &nbsp;
                    </div>
                        </div>
                    <div hidden="hidden">
                    <div class="card-body col-5 mx-auto" style="background-color:azure" id="div_yellow" >
                         <input type="text" class="form-control mt-1" placeholder="ชื่อ" id="yelpost_fname" runat="server"/>
                         <input type="text" class="form-control mt-1" placeholder="นามสกุล" id="yelpost_lname" runat="server"/>
                         <input type="text" class="form-control mt-1" placeholder="เบอร์โทร" id="yelpost_pnumber" runat="server"/>
                         <input type="text" class="form-control mt-1" placeholder="LineID" id="yelpost_line" runat="server"/>
                    </div>  
                        </div>
                    <div hidden="hidden">
                        <div class="col-12 mt-3 mx-auto text-center">
                                <button type="button" class="btn btn-primary" id="btn_submit_ylpost" onserverclick="btn_submit_ylpost_ServerClick"  runat="server">Submit</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
</asp:Content>
