<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RegisterQ.aspx.cs" Inherits="BRH_Plubic.QER.RegisterQ" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">
    <div class="card-header col-8 mx-auto text-center" style="background-color:#1E90FF"><div style="font-size:x-large">Register Q-ER</div></div>
    <div class="card col-8 mx-auto">       
        <div class="col-12">  
            <div class="card-body mx-auto">
                <div class="col-4 mx-auto ">
                <div class="text-center my-1">กรุณากรอก Q</div><input type="number" id="txtq_input" class="form-control" runat="server"/>
                </div>
               <div class="text-center mt-2">เลือก Triage Level</div>
                <div class="col-8 mx-auto mt-2 text-center">           
                <button ID="triage_lv1" Class="btn" style="background-color:firebrick" value="lv1" onmouseover="CheckIDno('1')" onserverclick="triage_lv_ServerClick" runat="server">Triage Lv.1</button>&nbsp;
                <button ID="triage_lv2" Class="btn" style="background-color:red" value="lv2" onmouseover="CheckIDno('2')" onserverclick="triage_lv_ServerClick" runat="server">Triage Lv.2</button>&nbsp;
                <button ID="triage_lv3" Class="btn" style="background-color:yellow" value="lv3" onmouseover="CheckIDno('3')" onserverclick="triage_lv_ServerClick" runat="server">Triage Lv.3</button>&nbsp;
                <button ID="triage_lv4" Class="btn" style="background-color:limegreen" value="lv4" onmouseover="CheckIDno('4')" onserverclick="triage_lv_ServerClick" runat="server">Triage Lv.4</button>&nbsp;
                <button ID="triage_lv5" Class="btn" style="background-color:azure" value="lv5" onmouseover="CheckIDno('5')" onserverclick="triage_lv_ServerClick" runat="server">Triage Lv.5</button>&nbsp;
                </div>
                <br />
                
                <div hidden="hidden">
                    <input type="text" id="txtH_id_triage" value="0" runat="server" />
                    <script>
                        function CheckIDno(x) {
                            var TxtH_triage = document.getElementById('<%= txtH_id_triage.ClientID  %>')
                            TxtH_triage.value = x;
                        }
                    </script>
                </div>
            </div>
       </div>       
    </div>
</asp:Content>
