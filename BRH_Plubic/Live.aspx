<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Live.aspx.cs" Inherits="BRH_Plubic.Live" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">

<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <div class="row col-11 mx-auto text-center">

        <div class="col-8 mx-auto text-center">
            <iframe width="100%" height="415" src="https://mylive.in.th/BRHTableau" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
        </div>

        <div class="col-4 mx-auto" runat="server">
            <iframe src="https://www6.cbox.ws/box/?boxid=843729&boxtag=NA2KBL" 
                width="100%" 
                height="415" 
                allowtransparency="yes" 
                allow="autoplay" 
                frameborder="0" 
                marginheight="0" 
                marginwidth="0" 
                scrolling="auto">
            </iframe>	
        </div>

        <div hidden="hidden">
            <asp:UpdatePanel ID="UpdatePanel_usertime" runat="server">
                <ContentTemplate>
                    <asp:Timer ID="Timer1" runat="server" Interval="5000" OnTick="Timer1_Tick" ></asp:Timer>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>

        <div class="row col-4 mx-auto" runat="server" visible="false">
            <table id="tableChat" style="width: 100%">
                <thead>
                <tr>
                    <td colspan="2" style="font-size: x-large; text-shadow: 2px 2px 2px #808080;">
                        <div class="card col-12 mx-auto text-center" style="border-radius: 20px; background-color: cornflowerblue; color:white;">
                            Chat
                        </div>
                    </td>
                </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>


        <div class="col-12 mx-auto">
            <div class="row">
                <div class="col-4">
                    <div class="card card-header bg-dark h3" style="color:white">
                        ดูย้อนหลัง
                    </div>
                    <div class="card card-body">
                        <div class="text-left mb-4">
                            <p>27/05/2020</p>
                            <a href="#">- Tableau Online Ep1.</a>
                        </div>
                        <div class="text-left mb-4">
                            <p>10/06/2020</p>
                            <a target="_blank" href="https://youtu.be/B_F9HrDLYsA">- Tableau Online Ep2.</a><br />
                            <a target="_blank" href="https://youtu.be/-RYhx-pDU-M">- Tableau Online Ep3.</a>
                        </div>
                        <div class="text-left mb-4">
                            <p>17/06/2020</p>
                            <a target="_blank" href="https://youtu.be/-utVHmu-JLo">- Tableau Online Ep4.</a>
                        </div>
                        <div class="text-left mb-4">
                            <p>24/06/2020</p>
                            <a target="_blank" href="https://youtu.be/PdF-GNPJ-w4">- Tableau Online Ep5.</a>
                            <br />
                            <a target="_blank" href="Document/ประชากรไทย.xlsx"><img src="images/excel_icon.png" width="18" /> ข้อมูล ประชากรไทย</a>
                        </div>
                        <div class="text-left mb-4">
                            <p>01/07/2020</p>
                            <a target="_blank" href="https://youtu.be/LaY2fzskm8I">- Tableau Online Ep6.</a>
                        </div>
                        <div class="text-left mb-4">
                            <p>08/07/2020</p>
                            <a target="_blank" href="https://youtu.be/Yw8mFcvLNwM">- Tableau Online Ep7.</a>
                        </div>
                        <div class="text-left mb-4">
                            <p>22/07/2020</p>
                            <a target="_blank" href="https://youtu.be/a0995ublPtk">- Tableau Online Ep8 - 9.</a>
                        </div>
                        <div class="text-left mb-4">
                            <p>29/07/2020</p>
                            <a target="_blank" href="https://youtu.be/OoPA40UhuHg">- Tableau Online Ep10.</a>
                        </div>
                        <div class="text-left mb-4">
                            <p>05/08/2020</p>
                            <a target="_blank" href="https://youtu.be/lMoE70jWsdY">- Tableau Online Ep11.</a>
                        </div>

                        <img src="images/Artboard.png" width="200" />
                    </div>
                </div>
                <div class="col-8 text-left">
                    <br />
                    <a href="https://www.tableau.com/products/cloud-bi" target="_blank"> Link Dowload Tableau Online </a>
                    <img src="images/TableauLogo.png" />
                    <img src="images/Event_TableauChampion.jpg" width="100%" />
                </div>
            </div>
        </div>

        <div class="col-12 mx-auto text-center">
            <img src="images/Tableau Schedule.jpg" width="100%" />
        </div>

    </div>

</asp:Content>
