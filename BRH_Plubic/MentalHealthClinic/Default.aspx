

<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="BRH_Plubic.MentalHealthClinic.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">
<style>
input[type=radio] {
    border: 0px;
    width: 2em;
    height: 2em;
}
</style>

    <div class="col-11 mx-auto" id="printableArea" runat="server">
        <div class="text-center"> 
            <h1>วัดอุณหภูมิใจ</h1>
            <h3>ขอนุญาตสอบถามถึงความรู้สึกในช่วงนี้ จาก 0-10 คะแนน</h3><br />
            
        </div> 
        <div class="text-center"><h4>ทุกข์ทรมานอย่างแสนสาหัส </h4></div>
        <div class="col-12 mx-auto">
            <div class="alert alert-danger col-lg-5 col-sm-10 mx-auto my-2 text-center h4">
                ระดับที่ 10 &nbsp;<input type="radio" id="SCT_10" value="10" onclick="CheckIDno('10')" runat="server" />
            </div>  
            <div class="alert alert-danger col-lg-5 col-sm-10 mx-auto my-2 text-center h4">
                ระดับที่ 9 &nbsp;<input type="radio" id="SCT_9" value="9" onclick="CheckIDno('9')" runat="server"/>
            </div>
            <div class="alert alert-danger col-lg-5 col-sm-10 mx-auto my-2 text-center h4">
                ระดับที่ 8 &nbsp;<input type="radio" id="SCT_8" value="8" onclick="CheckIDno('8')" runat="server"/>
            </div>
            <div class="alert alert-warning col-lg-5 col-sm-10 mx-auto my-2 text-center h4">
                ระดับที่ 7 &nbsp;<input type="radio" id="SCT_7" value="7" onclick="CheckIDno('7')" runat="server"/>
            </div>
            <div class="alert alert-warning col-lg-5 col-sm-10 mx-auto my-2 text-center h4">
                ระดับที่ 6 &nbsp;<input type="radio" id="SCT_6" value="6" onclick="CheckIDno('6')" runat="server"/>
            </div>
            <div class="alert alert-warning col-lg-5 col-sm-10 mx-auto my-2 text-center h4">
                ระดับที่ 5 &nbsp;<input type="radio" id="SCT_5" value="5" onclick="CheckIDno('5')" runat="server"/>
            </div>
            <div class="alert alert-success col-lg-5 col-sm-10 mx-auto my-2 text-center h4">
                ระดับที่ 4 &nbsp;<input type="radio" id="SCT_4" value="4" onclick="CheckIDno('4')" runat="server"/>
            </div>
            <div class="alert alert-success col-lg-5 col-sm-10 mx-auto my-2 text-center h4">
                ระดับที่ 3 &nbsp;<input type="radio" id="SCT_3" value="3" onclick="CheckIDno('3')" runat="server"/> 
            </div>
            <div class="alert alert-success col-lg-5 col-sm-10 mx-auto my-2 text-center h4">
                ระดับที่ 2 &nbsp;<input type="radio" id="SCT_2" value="2" onclick="CheckIDno('2')" runat="server"/> 
            </div>
            <div class="alert alert-success col-lg-5 col-sm-10 mx-auto my-2 text-center h4">
                ระดับที่ 1 &nbsp;<input type="radio" id="SCT_1" value="1" onclick="CheckIDno('1')" runat="server"/> 
            </div>       
            <div class="alert alert-success col-lg-5 col-sm-10 mx-auto my-2 text-center h4">
                ระดับที่ 0 &nbsp;<input type="radio" id="SCT_0" value="0" onclick="CheckIDno('0')" runat="server" />
            </div>
        </div>
        <div class="text-center mt-2"><h4>ไม่ทุกข์เลย </h4></div>
    </div>

    <div hidden="hidden">
        <input type="text" id="txtH_Score" value="0" runat="server" />
        <script>
            function CheckIDno(x) {
                var TxtHscore = document.getElementById('<%= txtH_Score.ClientID %>')
                TxtHscore.value = x;
            }
        </script>
    </div>

    <div class="col-11 mx-auto text-center mt-5">
        <asp:Button ID="btn_next" Text="Next" CssClass="col-lg-3 col-sm-8 btn btn-light" Font-Size="X-Large" OnClick="btn_next_Click" runat="server" />
    </div>
    
    <div class="col-11 mx-auto text-center mt-5" visible="true" runat="server">
        <asp:Button ID="btn_next1" Text="ถัดไป" CssClass="btn btn-light" OnClick="btn_next1_Click" runat="server" />
    </div>

    <div class="col-11 mx-auto text-center mt-5" visible="true" runat="server">
        <asp:Button ID="printdiv"  Text="Print" CssClass="btn btn-info" OnClientClick="printDiv()" runat="server" />
    </div>

    <script>
        function printDiv() {
            var printContents = document.getElementById("<%= printableArea.ClientID %>").innerHTML;
            var originalContents = document.body.innerHTML;
            document.body.innerHTML = printContents;
            window.print();
            document.body.innerHTML = originalContents;
        }
    </script>

</asp:Content>
