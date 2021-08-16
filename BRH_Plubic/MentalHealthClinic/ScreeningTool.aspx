<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ScreeningTool.aspx.cs" Inherits="BRH_Plubic.MentalHealthClinic.ScreeningTool" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">

    <div class="card-header col-10 mx-auto" style="background-color:deepskyblue">
        <div class="container d-flex align-items-center flex-column mb-1">
            <h2>Screening Tool</h2>
        </div>
    </div>
        <div class="card col-10 mx-auto">        
             <div class="card-body">
                            <div class="text-center">
                               <h3>วัดอุณหภูมิใจ</h3>
                                <h4>“ 0-10 คะแนน วันนี้ระดับความทุกข์ของคุณอยู่ที่เท่าไหร่คะ”</h4><br />
                            </div>                                                     
                             <div class="card-header col-2 mx-auto text-center" style="background-color:lightcoral">
                                 ระดับที่ 10 &nbsp;<input type="radio" id="SCT_10" onclick="CheckIDno('10')" value="10" runat="server"/>
                             </div>
                             <div class="card-header col-2 mx-auto text-center" style="background-color:lightcoral">
                                ระดับที่ 9 &nbsp;<input type="radio" id="SCT_9" value="9" onclick="CheckIDno('9')" runat="server"/>
                             </div>
                             <div class="card-header col-2 mx-auto text-center" style="background-color:lightcoral">
                                ระดับที่ 8 &nbsp;<input type="radio" id="SCT_8" value="8" onclick="CheckIDno('8')" runat="server"/>
                             </div>
                             <div class="card-header col-2 mx-auto text-center" style="background-color:lightgoldenrodyellow">
                                ระดับที่ 7 &nbsp;<input type="radio" id="SCT_7" value="7" onclick="CheckIDno('7')" runat="server"/>
                             </div>
                             <div class="card-header col-2 mx-auto text-center" style="background-color:lightgoldenrodyellow">
                                ระดับที่ 6 &nbsp;<input type="radio" id="SCT_6" value="6" onclick="CheckIDno('6')" runat="server"/>
                             </div>
                             <div class="card-header col-2 mx-auto text-center" style="background-color:lightgoldenrodyellow">
                                ระดับที่ 5 &nbsp;<input type="radio" id="SCT_5" value="5" onclick="CheckIDno('5')" runat="server"/>
                             </div>
                             <div class="card-header col-2 mx-auto text-center" style="background-color:lightgreen">
                                ระดับที่ 4 &nbsp;<input type="radio" id="SCT_4" value="4" onclick="CheckIDno('4')" runat="server"/>
                             </div>
                             <div class="card-header col-2 mx-auto text-center" style="background-color:lightgreen">
                                ระดับที่ 3 &nbsp;<input type="radio" id="SCT_3" value="3" onclick="CheckIDno('3')" runat="server"/> 
                             </div>
                             <div class="card-header col-2 mx-auto text-center" style="background-color:lightgreen">
                                ระดับที่ 2 &nbsp;<input type="radio" id="SCT_2" value="2" onclick="CheckIDno('2')" runat="server"/> 
                             </div>
                             <div class="card-header col-2 mx-auto text-center" style="background-color:lightgreen">
                                ระดับที่ 1 &nbsp;<input type="radio" id="SCT_1" value="1" onclick="CheckIDno('1')" runat="server"/> 
                             </div>
                             <div class="card-header col-2 mx-auto text-center" style="background-color:lightgreen">
                                ระดับที่ 0 &nbsp;<input type="radio" id="SCT_0" value="0" onclick="CheckIDno('0')" runat="server"/> 
                             </div>
                               

             </div>           
        </div>
    <div class="card-footer col-10 mx-auto text-center" style="background-color:deepskyblue">
        <button type="button" class="btn btn-primary" id="btn_submit" onserverclick="btn_submit_ServerClick" runat="server">Submit</button>
    </div>
    
    <%--<script>
        var sct_no_10 = document.getElementById('<%= SCT_10.ClientID %>');
        var sct_no_9 = document.getElementById('<%= SCT_9.ClientID %>');
        var sct_no_8 = document.getElementById('<%= SCT_8.ClientID %>');
        var sct_no_7 = document.getElementById('<%= SCT_7.ClientID %>');
        var sct_no_6 = document.getElementById('<%= SCT_6.ClientID %>');
        var sct_no_5 = document.getElementById('<%= SCT_5.ClientID %>');
        var sct_no_4 = document.getElementById('<%= SCT_4.ClientID %>');
        var sct_no_3 = document.getElementById('<%= SCT_3.ClientID %>');
        var sct_no_2 = document.getElementById('<%= SCT_2.ClientID %>');
        var sct_no_1 = document.getElementById('<%= SCT_1.ClientID %>');
        var sct_no_0 = document.getElementById('<%= SCT_0.ClientID %>');

        function CheckIDno(sctno) {
            var sct = document.getElementById('<%= sct_id %>');
            sct.value = sctno;

            sct_no_10.checked = false;
            sct_no_9.checked = false;
            sct_no_8.checked = false;
            sct_no_7.checked = false;
            sct_no_6.checked = false;
            sct_no_5.checked = false;
            sct_no_4.checked = false;
            sct_no_3.checked = false;
            sct_no_2.checked = false;
            sct_no_1.checked = false;
            sct_no_0.checked = false;

            if (sctno == '10') {
                sct_no_10.checked = true;
            }
            if (sctno == '9') {
                sct_no_9.checked = true;
            }
            if (sctno == '8') {
                sct_no_8.checked = true;
            }
            if (sctno == '7') {
                sct_no_7.checked = true;
            }
            if (sctno == '6') {
                sct_no_6.checked = true;
            }
            if (sctno == '5') {
                sct_no_5.checked = true;
            }
            if (sctno == '4') {
                sct_no_4.checked = true;
            }
            if (sctno == '3') {
                sct_no_3.checked = true;
            }
            if (sctno == '2') {
                sct_no_2.checked = true;
            }
            if (sctno == '1') {
                sct_no_1.checked = true;
            }
            if (sctno == '0') {
                sct_no_0.checked = true;
            }

        }>

    </script>--%>


</asp:Content>
