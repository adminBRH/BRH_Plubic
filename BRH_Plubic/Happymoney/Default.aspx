<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="BRH_Plubic.Happymoney.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentDesktop" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

   <div class ="row mx-auto col-12">
       <div class ="container col-12 text-right" value="false" id="div_showmoney" runat="server" visible="false">
           <h1><strong>ยอดการซื้อฉลากทั้งโครงการ : <asp:Label ID="lb_summoney" runat="server" Text=""></asp:Label> บาท</strong></h1>
       </div>
     <div class="container col-12 mx-auto text-center mt-5 mb-5">
          <img src="image/icon/B_Banner.png" width="90%"/>  
     </div>
      
      <div class="row col-12" id="div_menu" value="false" runat="server" visible="false" >
         <div class="row col-12">
          <div class="card boxShadow col-5 my-3 mx-auto">
            <label><strong style="font-size:xx-large;">ยอดเงิน : <asp:Label ID="lbl_sumusermoney" Text="" Font-Size ="XX-Large" Font-Bold="true" runat="server"> </asp:Label> บาท</strong></label>
          </div>
       </div>
          <div class="col-sm-6 col-lg-4 mt-5">
           <div class="card boxShadow">
               <div class="card-body">
                   <div class="row col-lg-12">
                       <h5 class="card-title col-8"><strong>ทำการส่งสลิปฝากเงิน</strong></h5>
                         <div class="container col-4">
                           <img src="image/icon/happymoney.png" width="100" height="100" />
                        </div>
                     </div>
                   <a href="uploadslip.aspx" class="btn btn-primary">Go To Page</a>
               </div>
           </div>
       </div>
       <div class="col-sm-6 col-lg-4 mt-5">
           <div class="card boxShadow">
               <div class="card-body">
                   <div class="row col-lg-12">
                       <h5 class="card-title col-8"><strong>ประวัติการฝาก</strong></h5>
                         <div class="container col-4">
                           <img src="image/icon/history.png" width="100" height="100" />
                        </div>
                     </div>
                   <a href="historyslip.aspx" class="btn btn-primary">Go To Page</a>
               </div>
           </div>
       </div>   
       <div class="col-sm-6 col-lg-4 mt-5">
           <div class="card boxShadow">
               <div class="card-body">
                   <div class="row col-lg-12">
                       <h5 class="card-title col-8"><strong>รายการรออนุมัติ</strong></h5>
                         <div class="container col-4">
                           <img src="image/icon/report.png" width="100" height="100" />
                        </div>
                     </div>
                   <a href="approveslip.aspx" class="btn btn-primary">Go To Page</a>
               </div>
           </div>
       </div>
      </div>           
   </div>
    <div class="col-sm-12 text-center col-auto" id="btn_summit" runat="server" visible="true">
        <div class="boxShadow">
            <div class="card-body">
                <div class="row col-lg-12">
                    <h3 class="card-title col-12"><strong>คุณต้องการเข้าร่วมโครงการ B+Happy Money ใช่หรือไม่</strong>&nbsp&nbsp&nbsp&nbsp<button type="button" class="btn btn-outline-success" id="btn_adduser" onserverclick="btn_adduser_ServerClick" runat="server" style="font-size:30px"><strong>เข้าร่วมโครงการ</strong></button></h3>
                  
                </div>
            </div>
          </div>
    </div>
</asp:Content>
