<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="BRH_Plubic.Marketing.Register" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">

    <div class="col-lg-8 col-sm-12 mx-auto mb-5">
        <div class="card card-head bg-info text-center h1" style="color:white">ช่องทางการรับสินค้า</div>
        <div  class="card card-body mb-5"> 
            <div>
                <span style="color:red; font-size:larger;">หมายเหตุ :<br /> จัดส่งสินค้าเฉพาะชุดหนูน้อยสู้โควิดและหน้ากากผ้าเท่านั้น<br />สำหรับคูปองโปรแกรมตรวจสุขภาพต้องเข้ามารับ ณ โรงพยาบาล</span>
            </div>
            <div class="mt-3">
                <label class="switch">
                    <input  type="checkbox" id="CB_send1" value="1" onclick="showaddress(1)" checked runat="server" />
                    <span class="slider round"></span>
                </label> รับสินค้า ณ จุดจำหน่ายโปรโมชั่น ชั้น 1 หน้า Au Bon Pain โรงพยาบาลกรุงเทพระยอง
            </div>
            <div>
                <label class="switch">
                    <input  type="checkbox" id="CB_send2" value="2" onclick="showaddress(2)" runat="server" />
                    <span class="slider round"></span>
                </label> จัดส่งสินค้าตามที่อยู่(คิดค่าบริการจัดส่งเพิ่ม)
            </div>
            
            <div hidden="hidden">
                <input type="text" id="txt_send" value="1" runat="server" />
            </div>
        </div>
        <div class="card card-head col-12 text-center bg-info h4" style="color:white" >ข้อมูลสำหรับติดต่อรับสินค้าและบริการ</div>
        <div class="card card-body">  
            <div class="row col-10 mx-auto">
                <div class="col-lg-4 col-sm-12 mx-auto mb-3">
                    <input type="text" id="txt_fname" autofocus="autofocus" class="form-control" placeholder="ชื่อ" value="" required="required" runat="server" />
                </div>
                <div class="col-lg-4 col-sm-12 mx-auto mb-3">
                    <input type="text" id="txt_lname" class="form-control" placeholder="นามสกุล" value="" required="required" runat="server" />
                </div>
                <div class="col-lg-4 col-sm-12 mx-auto mb-3">
                    <input type="tel" id="txt_phone" class="form-control" placeholder="เบอร์โทรศัพท์" value="" required="required" runat="server" />
                </div>
            </div>
        </div>
        <div id="div_address" class="card card-body" hidden="hidden">  
            <div class="card card-head col-12 text-center bg-info h4" style="color:white" >ที่อยู่สำหรับจัดส่งสินค้า</div>
            <div class="row col-12">
                <div class="col-10 container mb-3">
                    <input type="text" id="txt_address" class="form-control" placeholder="บ้านเลขที่ " runat="server" />
                </div>
                <div class="col-10 container mb-3">
                    <input type="text" id="txt_moo" class="form-control" value="" placeholder="หมู่ / ซอย" runat="server" />
                </div>
                <div class="col-10 container mb-3">
                    <input type="text" id="txt_subdistric" class="form-control" value="" placeholder="ถนน / ตำบล" runat="server" />
                </div>
                <div class="col-10 container mb-3">
                    <input type="text" id="txt_distric" class="form-control" value="" placeholder="เขต / อำเภอ" runat="server" />
                </div>
                <div class="col-10 container mb-3">
                    <input type="text" id="txt_province" class="form-control" value="" placeholder="จังหวัด" runat="server" />
                </div>
                <div class="col-10 container mb-3">
                    <input type="text" id="txt_zipcode" class="form-control" value="" placeholder="รหัสไปรษณีย์" runat="server" />
                </div>
            </div>
        </div>
        <div id="div_submit" class="text-center mt-5 mx-auto" onmouseover="checkdata()">
            <button class="btn btn-outline-primary col-4 mx-auto text-center" value="" id="btn_submit" runat="server" onserverclick="btn_submit_ServerClick"><font size="6">SUBMIT</font></button>
        </div>
     </div>
    <script>
        function showaddress(X) {
            var CB1 = document.getElementById('<%= CB_send1.ClientID %>');
            var CB2 = document.getElementById('<%= CB_send2.ClientID %>');
            var send = document.getElementById('<%= txt_send.ClientID %>');
            var div = document.getElementById('div_address');
            if (X == 1) {
                div.hidden = true;
                CB1.checked = true;
                CB2.checked = false;
            }
            if (X == 2) {
                div.hidden = false;
                CB1.checked = false;
                CB2.checked = true;
            }
            send.value = X;
        }

        function checkdata() {
            var send = document.getElementById('<%= txt_send.ClientID %>');

            var fname = document.getElementById('<%= txt_fname.ClientID %>');
            var lname = document.getElementById('<%= txt_lname.ClientID %>');
            var phone = document.getElementById('<%= txt_phone.ClientID %>');

            var address = document.getElementById('<%= txt_address.ClientID %>');
            var moo = document.getElementById('<%= txt_moo.ClientID %>');
            var subdistric = document.getElementById('<%= txt_subdistric.ClientID %>');
            var distric = document.getElementById('<%= txt_distric.ClientID %>');
            var province = document.getElementById('<%= txt_province.ClientID %>');
            var zipcode = document.getElementById('<%= txt_zipcode.ClientID %>');

            var div = document.getElementById('div_submit');
            var btn = document.getElementById('<%= btn_submit.ClientID %>');

            var status = '';

            var css1 = 'form-control border-danger';
            var css2 = 'form-control';
            
            if (fname.value == '' || lname.value == '' || phone.value == '') {
                fname.setAttribute('class', css1);
                lname.setAttribute('class', css1);
                phone.setAttribute('class', css1);
                status = 'no'
            }
            else {
                fname.setAttribute('class', css2);
                lname.setAttribute('class', css2);
                phone.setAttribute('class', css2);
                status = 'yes'
            }

            if (send.value == '2') {
                if (address.value == '' || moo.value == '' || subdistric.value == '' || distric.value == '' || province.value == '' || zipcode.value == '') {
                    status = 'no'
                    address.setAttribute('class', css1);
                    moo.setAttribute('class', css1);
                    subdistric.setAttribute('class', css1);
                    distric.setAttribute('class', css1);
                    province.setAttribute('class', css1);
                    zipcode.setAttribute('class', css1);
                } else {
                    status = 'yes'
                    address.setAttribute('class', css2);
                    moo.setAttribute('class', css2);
                    subdistric.setAttribute('class', css2);
                    distric.setAttribute('class', css2);
                    province.setAttribute('class', css2);
                    zipcode.setAttribute('class', css2);
                }
            }

            if (status == 'no') {
                //alert('กรุณากรอกข้อมูลให้ครบถ้วน !!');
                btn.setAttribute('disabled', 'disabled');
                //fn_AlertModal('Info', 'กรุณากรอกข้อมูลให้ครบถ้วน', '', 0);
                fn_AlertModal('Success', 'บันทึกข้อมูลของท่านเรียบร้อยแล้ว', 'PaySlip.aspx?id=18', 2000);
            }
            else {
                btn.removeAttribute('disabled');
            }
            
        }
    </script>

</asp:Content>
