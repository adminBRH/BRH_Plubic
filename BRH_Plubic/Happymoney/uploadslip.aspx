<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="uploadslip.aspx.cs" Inherits="BRH_Plubic.Happymoney.uploadslip" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentDesktop" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="col">
      <div class="col-12 text-center">
          <h1><strong>อัพโหลดสลิป</strong></h1>
        </div>
        <div class="col-12 text-center mx-auto mt-5 mb-5">
             <img src="image/icon/slipmoney.png" style="width:30%"/> 
        </div>
        <div class="col-12 text-center">
             <asp:FileUpload id="fu_slip" runat="server" AllowMultiple="false" />
        </div>
            &nbsp&nbsp
           <div class="mx-auto col-5 text-center">
                <input type="text" id="txt_money" class="form-control" placeholder="จำนวนเงิน" style="font-size:xx-large" value="" runat="server" />
          </div>
        <div class="col-12 text-center mx-auto mt-5 mb-5">
           <label><strong><h2>วันที่โอนเงิน</h2></strong></label>&nbsp&nbsp&nbsp&nbsp
          <input type="date" id="date_slip" value="" style="font-size:xx-large"/>
        </div>
         <div class="row col-12 mx-auto text-center mt-5 mb-5 ">
          <button type="button" class="btn btn-primary btn-lg col-6 mx-auto text-center" id="btn_uploadslip" style="height: 100px; font-size: xx-large" onmouseover="getdate_slip()" onserverclick="btn_uploadslip_ServerClick" runat="server" ><strong>upload</strong></button>       
        </div>
    </div>
    <div hidden="hidden">
        <input type="text" id="txt_dateslip" class="form-control" value="" runat="server" />
        <input type="text" id="txt_filename" class="form-control" value="" runat="server" />
    </div>

    

 <script>

     var inputSlip = document.getElementById('date_slip');
     var to_day = Today(0);
     inputSlip.value = to_day;

     function getdate_slip() {
         var dateslip = document.getElementById('date_slip');
         var txtslip = document.getElementById('<%= txt_dateslip.ClientID %>');
         txtslip.value = dateslip.value;
     }
 </script>
</asp:Content>