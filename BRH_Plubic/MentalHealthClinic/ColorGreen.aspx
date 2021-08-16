<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ColorGreen.aspx.cs" Inherits="BRH_Plubic.MentalHealthClinic.ColorGreen" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">
        <div class="col-lg-8 col-sm-11 mx-auto">
            <div class="card">
                <div class="card-body" style="background-color:limegreen" id="div_green">
                    <div class="card-header text-center h3" style="background-color:lightgreen">ตามการประเมินอุณหภูมิใจ<br /> คุณอยู่ในภาวะ "ปกติ"</div>
                    <div class="text-center"><img src="img/smile1.png" width="120px"/></div>
                    <div class="container h3" style="color:white;">
                        • แนะนำให้รักษาสุขภาพด้วยนะคะ<br />
                        • นอนหลับพักผ่อนให้เพียงพอ<br />
                        • ทานอาหารถูกสุขอนามัย ครบ 5 หมู่ และทานให้เป็นเวลา<br />
                        • ดื่มน้ำวันละ 8-10 แก้ว <br />
                        • หลีกเลี่ยงการดื่มสุรา , สูบบุหรี่ , ใช้สารเสพติด  <br />
                        • แบ่งเวลาให้กับคนในครอบครัว เพื่อน<br />
                        • แบ่งเวลาดูแลตนเอง ทำจิตใจให้ร่าเริงแจ่มใส<br />
                        • จัดตารางชีวิตให้สมดุล ทั้งการทำงาน การพักผ่อน และการออกกำลังกาย<br />
                    </div>
                    <div class="card-body col-5 mx-auto" style="background-color:azure" id="div_yellow" >
                         <input type="text" class="form-control mt-1" placeholder="ชื่อ" id="txt_fname" onkeyup="checkData()" runat="server"/>
                         <input type="text" class="form-control mt-1" placeholder="นามสกุล" id="txt_lname" onkeyup="checkData()" runat="server"/>
                         <input type="text" class="form-control mt-1" placeholder="รหัสพนักงาน" id="txt_empid" onkeyup="checkData()" runat="server"/>
                         <input type="text" class="form-control mt-1" placeholder="เบอร์โทร" id="txt_phone" onkeyup="checkData()" runat="server"/>
                         <input type="text" class="form-control mt-1" placeholder="LineID" id="txt_line" onkeyup="checkData()" runat="server"/>
                    </div>  
                    <div class="col-12 mt-3 mx-auto text-center">
                        <button type="button" class="btn btn-primary" id="btn_submit" disabled="disabled" onserverclick="btn_submit_ServerClick" onmouseover="checkData()" runat="server">Next</button>
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
            var btn = document.getElementById('<%= btn_submit.ClientID %>');

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
