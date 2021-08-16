<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="BRH_Plubic.Appointment.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">

    <div class="col-lg-8 col-sm-11 mx-auto">
        <div class="card card-header border-0 bg-transparent" style="background-image: url(images/Search_bot.png); background-size:cover; background-repeat:no-repeat">
            <h2 class="">Diagnose BOT วินิจฉัยโรคเบื้องต้นด้วยหุ่นยนต์</h2><br />
            <h3>เพื่อค้นหาว่าท่านควรจะเข้ารับบริการที่แผนกใด</h3>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p class="text-right" style="color:red; font-size:large">&nbsp; <i>หากท่านมีหลายอาการ แนะนำให้กรอกเว้นวรรคแต่ละอาการนะครับ</i></p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <%--<img src="images/Search_bot.png" />--%>
             <div class="card card-body border-0 bg-transparent">
                <div class="row col-12">
                    <div class="col-10 nx-auto text-center">
                        <input type="text" id="txt_diag" class="form-control" placeholder="กรอกอาการของท่าน เช่น ไข้ ปวดหัว  ไอ  เจ็บคอ" value="" runat="server" />
                    </div>
                    <div class="col-2 mx-auto text-left">
                        <asp:Button ID="btn_search" Font-Size="Larger" Text="วินิจฉัย" CssClass="btn btn-outline-primary" OnClick="btn_search_Click" runat="server" />
                    </div>
                </div>
            </div>
        </div>
       
    </div>

</asp:Content>
