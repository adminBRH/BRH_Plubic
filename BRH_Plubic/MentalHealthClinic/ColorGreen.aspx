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
                    <div class="card-body col-lg-5 col-sm-9 mx-auto" style="background-color:azure" id="div_yellow" >
                        <input type="text" class="form-control mt-1" placeholder="รหัสพนักงาน" id="txt_empid" runat="server" />
                        <input type="text" class="form-control mt-1" placeholder="ชื่อ" id="txt_fname" runat="server"/>
                        <input type="text" class="form-control mt-1" placeholder="นามสกุล" id="txt_lname" runat="server"/>
                        <input type="text" class="form-control mt-1" placeholder="เบอร์โทร" id="txt_phone" runat="server"/>
                        <input type="text" class="form-control mt-1" placeholder="LineID" id="txt_line" runat="server"/>
                        <asp:DropDownList ID="dd_accommodation" CssClass="form-control mt1" runat="server" Visible="false">
                            <asp:ListItem Text="โปรดเลือก สถานที่พักรักษา" Value=""></asp:ListItem>
                            <asp:ListItem Text="โรงพยาบาลกรุงเทพระยอง" Value="โรงพยาบาลกรุงเทพระยอง"></asp:ListItem>
                            <asp:ListItem Text="Hospitel ในโรงพยาบาลกรุงเทพระยอง" Value="Hospitel ในโรงพยาบาลกรุงเทพระยอง"></asp:ListItem>
                            <asp:ListItem Text="โรงแรมตำนานป่า" Value="โรงแรมตำนานป่า"></asp:ListItem>
                            <asp:ListItem Text="โรงแรม Fuse" Value="โรงแรม Fuse"></asp:ListItem>
                            <asp:ListItem Text="โรงแรม Cruise" Value="โรงแรม Cruise"></asp:ListItem>
                            <asp:ListItem Text="โรงแรมอักษร" Value="โรงแรมอักษร"></asp:ListItem>
                        </asp:DropDownList>
                        <input type="text" class="form-control mt-1" placeholder="หมายเลขห้อง" id="txt_roomnumber" runat="server" visible="false"/>
                    </div>  
                    <div class="col-12 mt-3 mx-auto text-center">
                        <a id="btnSubmit" class="col-lg-3 col-sm-8 btn btn-outline-primary" onclick="checkData()" style="font-size: x-large; cursor:pointer;">Next</a>
                        <button id="btn_submit" onserverclick="btn_submit_ServerClick" runat="server" hidden="hidden"></button>
                    </div>
                </div>
            </div>
        </div>

    <script>
        function checkData() {
            var empid = document.getElementById('<%= txt_empid.ClientID %>');
            var fname = document.getElementById('<%= txt_fname.ClientID %>');
            var lname = document.getElementById('<%= txt_lname.ClientID %>');
            var phone = document.getElementById('<%= txt_phone.ClientID %>');

            var key = '';
            var btn = document.getElementById('<%= btn_submit.ClientID %>');

            if (empid.value == '') {
                empid.setAttribute('class', 'form-control mt-1 border-danger');
            }
            else {
                empid.setAttribute('class', 'form-control mt-1');
                key = key + 'e';
            }

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

            if (key == 'eflp') {
                btn.click();
            }
            else {
                btn.setAttribute('disabled', 'disabled');
            }
        }
    </script>

</asp:Content>
