﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Result_dass21.aspx.cs" Inherits="BRH_Plubic.MentalHealthClinic.Result_dass21" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">
    <div class="col-8 mx-auto">
            <div class="card">
                <div class="card-body" style="background-color:lemonchiffon" id="div_dass_result">
                    <div class="card-header text-center" style="background-color:navajowhite"><h5>ตามการประเมินอุณหภูมิใจ<br /> คุณอยู่ในภาวะ "ความไม่สบายใจค่อนสูง"</h5></div>
                    <div class="text-center"><img src="img/smile2.png" width="120px"/></div>
                    <div class="container text-center">
                        <h5>ทางโรงพยาบาลมีความเป็นห่วง อยากช่วยหาปัจจัยที่ก่อให้เกิดความเครียด</h5>                       
                        <h5>กรุณา กด "Next" เพื่อทำแบบประเมินเพิ่มเติม</h5>
                       
                        
                    </div>
                    <div class="card-body col-5 mx-auto" style="background-color:azure" id="div_yellow" >
                         <input type="text" class="form-control mt-1" placeholder="ชื่อ" id="txt_fname" onkeyup="checkData()" runat="server"/>
                         <input type="text" class="form-control mt-1" placeholder="นามสกุล" id="txt_lname" onkeyup="checkData()" runat="server"/>
                         <input type="text" class="form-control mt-1" placeholder="รหัสพนักงาน" id="txt_empid" onkeyup="checkData()" runat="server"/>
                         <input type="text" class="form-control mt-1" placeholder="เบอร์โทร" id="txt_phone" onkeyup="checkData()" runat="server"/>
                         <input type="text" class="form-control mt-1" placeholder="LineID" id="txt_line" onkeyup="checkData()" runat="server"/>
                    </div>  
                    <div class="col-12 mt-3 mx-auto text-center">
                            <button type="button" class="btn btn-primary" id="btn_submit_result_dass" onserverclick="btn_submit_result_dass_ServerClick" disabled="disabled" runat="server">Next</button>
                        </div>
                </div>
            </div>
        </div>
    <script>
        function checkData() {
            var fname = document.getElementById('<%= txt_fname.ClientID %>');
            var lname = document.getElementById('<%= txt_lname.ClientID %>');
            var phone = document.getElementById('<%= txt_phone.ClientID %>');

            var key = '';
            var btn = document.getElementById('<%= btn_submit_result_dass.ClientID %>');

            if (fname.value == '') {
                fname.setAttribute('class', 'form-control mt-1 border-danger');
            }
            else {
                fname.setAttribute('class', 'form-control mt-1');
                key = key + 'f';
            }

            if (lname.value == '') {
                lname.setAttribute('class', 'form-control mt-1 border-danger');
            }
            else {
                lname.setAttribute('class', 'form-control mt-1');
                key = key + 'l';
            }

            if (phone.value == '') {
                phone.setAttribute('class', 'form-control mt-1 border-danger');
            }
            else {
                phone.setAttribute('class', 'form-control mt-1');
                key = key + 'p';
            }

            if (key == 'flp') {
                btn.removeAttribute('disabled');
            }
            else {
                btn.setAttribute('disabled', 'disabled');
            }
        }
    </script>
</asp:Content>