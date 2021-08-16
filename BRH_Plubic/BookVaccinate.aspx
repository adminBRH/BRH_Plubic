<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BookVaccinate.aspx.cs" Inherits="BRH_Plubic.BookVaccinate" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">

    <asp:ScriptManager ID="ScriptManager_Master" runat="server"></asp:ScriptManager>

    <div class="col-12 container">
        
        <div class="col-12 col-lg-8 mx-auto my-2">
            <div class="card features">
                <div class="card-body">
                    <div class="media">
                        <span class="ti-id-badge gradient-fill ti-3x mr-3"></span>
                        <div class="media-body h4">
                            <h2 id="name_title" class="card-title" runat="server">ข้อมูลส่วนบุคคล</h2>
                            <asp:DropDownList ID="DD_pname" CssClass="btn btn-light text-left mb-3" runat="server">
                                <asp:ListItem Text="" Value=""></asp:ListItem>
                            </asp:DropDownList>
                            <input type="text" id="txt_fname" class="col-5 form-control text-left mb-3" value="" placeholder="ชื่อ" required="required" runat="server" />
                            <input type="text" id="txt_lname" class="col-5 form-control text-left mb-3" value="" placeholder="นามสกุล" required="required" runat="server" />
                            <input type="number" id="txt_cardnum" class="col-5 form-control text-left mb-3" value="" placeholder="เลขที่บัตรประจำตัวประชาชน" required="required" runat="server" />
                            <input type="tel" id="tel_phone" class="col-3 form-control text-left mb-3" value="" placeholder="เบอร์โทรศัพท์" required="required" runat="server" />
                            เพศ <label class="switch">
                                <input  type="checkbox" id="CB_Men" value="Men" checked onclick="CheckSex('M')" runat="server" />
                                <span class="slider round"></span>
                            </label> ชาย
                            <label class="switch">
                                <input  type="checkbox" id="CB_Women" value="Women" onclick="CheckSex('F')" runat="server" />
                                <span class="slider round"></span>
                            </label> หญิง
                            <script>
                                function CheckSex(S) {
                                    var M = document.getElementById('<%= CB_Men.ClientID %>');
                                    var F = document.getElementById('<%= CB_Women.ClientID %>');
                                    if (S == 'M') {
                                        M.checked = true;
                                        F.checked = false;
                                    }
                                    else {
                                        M.checked = false;
                                        F.checked = true;
                                    }
                                }
                            </script>
                        </div>
                    </div>
                </div>
            </div>
        </div> <!-- ข้อมูลส่วนบุคคล -->

        <div class="col-12 col-lg-8 mx-auto my-2">
            <div class="card features">
                <div class="card-body">
                    <div class="media">
                        <span class="ti-location-arrow gradient-fill ti-3x mr-3"></span>
                        <div class="media-body h2">
                            <h2 id="H1" class="card-title" runat="server">ท่านเคยรับบริการโรงพยาบาลกรุงเทพระยอง หรือไม่</h2>
                            <label class="switch">
                                <input  type="checkbox" id="CB_service_Y" value="Yes" checked onclick="CheckService('Y')" runat="server" />
                                <span class="slider round"></span>
                            </label> เคย
                            <label class="switch">
                                <input  type="checkbox" id="CB_service_N" value="No" onclick="CheckService('N')" runat="server" />
                                <span class="slider round"></span>
                            </label> ไม่เคย
                            <script>
                                function CheckService(S) {
                                    var Y = document.getElementById('<%= CB_service_Y.ClientID %>');
                                    var N = document.getElementById('<%= CB_service_N.ClientID %>');
                                    if (S == 'Y') {
                                        Y.checked = true;
                                        N.checked = false;
                                    }
                                    else {
                                        Y.checked = false;
                                        N.checked = true;
                                    }
                                }
                            </script>
                        </div>
                    </div>
                </div>
            </div>
        </div> <!-- เคยรับบริการ -->

        <div class="col-12 col-lg-8 mx-auto my-2">
            <div class="card features">
                <div class="card-body">
                    <div class="media">
                        <span class="ti-location-pin gradient-fill ti-3x mr-3"></span>
                        <div class="media-body h2">
                            <h2 id="H2" class="card-title" runat="server">ท่านมีความประสงค์จะรับบริการฉีดวัคซีนที่ไหน</h2>
                            <asp:UpdatePanel ID="UpdatePanel_location" runat="server">
                                <ContentTemplate>
                                    <asp:DropDownList ID="DD_Location" CssClass="btn btn-light text-left" OnSelectedIndexChanged="DD_Location_SelectedIndexChanged" AutoPostBack="true" runat="server" >
                                        <asp:ListItem Text="รพ.กรุงเทพระยอง" Value="รพ.กรุงเทพระยอง"></asp:ListItem>
                                        <asp:ListItem Text="รพ.ศรีระยอง" Value="รพ.ศรีระยอง"></asp:ListItem>
                                        <asp:ListItem Text="คลินิก บ้านฉาง" Value="คลินิก บ้านฉาง"></asp:ListItem>
                                        <asp:ListItem Text="คลินิก บ่อวิน" Value="คลินิก บ่อวิน"></asp:ListItem>
                                    </asp:DropDownList>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                    </div>
                </div>
            </div>
        </div> <!-- สถานที่ฉีดวัคซีน -->

        <div class="col-12 col-lg-8 mx-auto my-2">
            <div class="card features">
                <div class="card-body">
                    <div class="media">
                        <span class="ti-user gradient-fill ti-3x mr-3"></span>
                        <div class="media-body h2">
                            <h2 class="card-title">สถานะ ของคุณคือ</h2>
                            <div class="row col-12">
                                <div class="col-6 text-left mb-3">
                                    <label class="switch">
                                        <input  type="checkbox" id="CB_emp" value="Employee" checked onclick="CheckStatus('emp')" runat="server" />
                                        <span class="slider round"></span>
                                    </label> พนักงาน
                                </div>
                                <div class="col-6 text-left">
                                    <label class="switch mb-3">
                                        <input  type="checkbox" id="CB_spo" value="Spouse" onclick="CheckStatus('spo')" runat="server" />
                                        <span class="slider round"></span>
                                    </label> คู่สมรส
                                </div>
                                <div class="col-6 text-left">
                                    <label class="switch">
                                        <input  type="checkbox" id="CB_chi" value="Children" onclick="CheckStatus('chi')" runat="server" />
                                        <span class="slider round"></span>
                                    </label> บุตร
                                </div>
                                <div class="col-6 text-left">
                                    <label class="switch">
                                        <input  type="checkbox" id="CB_par" value="Parents" onclick="CheckStatus('par')" runat="server" />
                                        <span class="slider round"></span>
                                    </label> บิดา/มารดา
                                </div>
                            </div>
                            <div hidden="hidden">
                                <input type="text" id="txtH_status" value="Employee" runat="server" />
                            </div>
                            <script>
                                function CheckStatus(id) {
                                    var emp = document.getElementById('<%= CB_emp.ClientID %>');
                                    var spo = document.getElementById('<%= CB_spo.ClientID %>');
                                    var chi = document.getElementById('<%= CB_chi.ClientID %>');
                                    var par = document.getElementById('<%= CB_par.ClientID %>');

                                    var status = document.getElementById('<%= txtH_status.ClientID %>');

                                    emp.checked = true; spo.checked = false; chi.checked = false; par.checked = false;
                                    status.value = emp.value;

                                    if (id == 'spo') {
                                        spo.checked = true;
                                        emp.checked = false;
                                        status.value = spo.value;
                                    }
                                    if (id == 'chi') {
                                        chi.checked = true;
                                        emp.checked = false;
                                        status.value = chi.value;
                                    }
                                    if (id == 'par') {
                                        par.checked = true;
                                        emp.checked = false;
                                        status.value = par.value;
                                    }
                                }
                            </script>

                        </div>
                    </div>
                </div>
            </div>
        </div> <!-- สถานะ -->

        <div class="col-12 col-lg-8 mx-auto my-2">
            <div class="card features">
                <div class="card-body">
                    <div class="media">
                        <span class="ti-stamp gradient-fill ti-3x mr-3"></span>
                        <div class="media-body h2">
                            <h2 id="emp_tilte" class="card-title" runat="server">รหัสพนักงาน</h2>
                            <input type="text" id="txt_empid" class="col-5 form-control text-left" placeholder="รหัสพนักงาน" required="required" runat="server" />
                        </div>
                    </div>
                </div>
            </div>
        </div> <!-- รหัสพนักงาน -->

        <div class="col-12 col-lg-8 mx-auto my-2">
            <div class="card features">
                <div class="card-body">
                    <div class="media">
                        <span class="ti-calendar gradient-fill ti-3x mr-3"></span>
                        <div class="media-body h2">
                            <h2 id="dob_title" class="card-title" runat="server">วัน/เดือน/ปีเกิด</h2> 
                            <input type="date" id="date_dob" class="btn btn-light text-left" value="" required="required" onchange="ShowDOB()" runat="server" />
                            <asp:Label ID="lbl_dob" style="font-size:x-large;" ForeColor="Red" Text="" runat="server"></asp:Label>
                        </div>
                        <script>
                            function ShowDOB() {
                                var dob = document.getElementById('<%= date_dob.ClientID %>').value;
                                var text = document.getElementById('<%= lbl_dob.ClientID %>');
                                var D1 = new Date(dob);
                                var D2 = new Date();
                                var Year = parseInt(D2.getFullYear()) - parseInt(D1.getFullYear());
                                var Month = parseInt(D1.getMonth());
                                var MonthDiff = (parseInt(D1.getMonth()) - parseInt(D2.getMonth()));
                                if (MonthDiff > 0) {
                                    Year = Year - 1;
                                    Month = 12 - parseInt(MonthDiff);
                                }
                                else {
                                    if (parseInt(MonthDiff) == 0) {
                                        Month = 0;
                                    } else {
                                        Month = parseInt(MonthDiff) * (-1);
                                    }
                                }
                                if (dob != '') {
                                    var YearChlid = '';
                                    if (Year < 5) {
                                        YearChlid = ' ต้องเข้ารับบริการที่ศูนย์กุมารเวชและชำระค่าแพทย์เพิ่ม 500บาท'; 
                                    }
                                    else {
                                        YearChlid = ''
                                    }
                                    text.innerText = ' อายุ ' + Year + ' ปี ' + Month + ' เดือน ' + YearChlid;
                                }
                            }
                        </script>
                    </div>
                </div>
            </div>
        </div> <!-- วัน/เดือน/ปีเกิด -->

        <div class="col-12 col-lg-8 mx-auto my-2">
            <div class="card features">
                <div class="card-body">
                    <div class="media">
                        <span class="ti-credit-card gradient-fill ti-3x mr-3"></span>
                        <div class="media-body h2">
                            <h2 class="card-title">เงื่อนไขการชำระเงิน</h2> 
                            <asp:DropDownList ID="DD_payer" CssClass="btn btn-light text-left" runat="server">
                                <asp:ListItem Value="วางบิลบริษัท" Text="Option 0 วางบิลบริษัท"></asp:ListItem>
                                <asp:ListItem Value="วางบิล AIA" Text="Option 1,2 วางบิล AIA"></asp:ListItem>
                                <asp:ListItem Value="วางบิล AIA 400 บาท พนักงานชำระเงินสด 100 บาท" Text="option 3 AIA+Co pay>>> วางบิล AIA 400 บาท พนักงานชำระเงินสด 100 บาท"></asp:ListItem>
                                <asp:ListItem Value="เงินสด" Text="เงินสด (สำหรับครอบครัวที่อยู่นอกสิทธิ์)" Selected="True"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                </div>
            </div>
        </div> <!-- เงื่อนไขการชำระเงิน -->

        <div class="col-12 col-lg-8 mx-auto my-2">
            <div class="card features">
                <div class="card-body">
                    <div class="media">
                        <span class="ti-car gradient-fill ti-3x mr-3"></span>
                        <div class="media-body h2">
                            <h2 id="goto_tilte" class="card-title" runat="server">รูปแบบการให้บริการ</h2> 
                            <asp:UpdatePanel ID="UpdatePanel_goto" runat="server">
                                <ContentTemplate>
                                    <asp:DropDownList ID="DD_goto" CssClass="btn btn-light text-left mb-3" AutoPostBack="true" OnSelectedIndexChanged="DD_goto_SelectedIndexChanged" runat="server">
                                        <asp:ListItem Value="Drive thru" Text="Drive thru"></asp:ListItem>
                                        <asp:ListItem Value="Walk in" Text="Walk in"></asp:ListItem>
                                    </asp:DropDownList>
                                    <input id="txt_brand" class="col-5 form-control text-left mb-3" runat="server" placeholder="ระบุยี่ห้อรถ" required="required" />
                                    <input id="txt_vehicle" class="col-5 form-control text-left" runat="server" placeholder="ระบุทะเบียนรถ" required="required" />
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                    </div>
                </div>
            </div>
        </div> <!-- รูปแบบการให้บริการ -->

        <div class="col-12 col-lg-8 mx-auto my-2">
            <div class="card features">
                <div class="card-body">
                    <div class="media">
                        <span class="ti-heart gradient-fill ti-3x mr-3"></span>
                        <div class="media-body h4">
                            <h2 class="card-title">ประวัติการแพ้ยาและอื่นๆ</h2>
                            <input id="txt_CongenitalDisease" class="col-8 form-control text-left mb-3" value="" runat="server" placeholder="โรคประจำตัว" />
                            <input id="txt_DrugAllergy" class="col-8 form-control text-left mb-2" value="" runat="server" placeholder="ประวัติการแพ้ยา" />
                            <div class="col-12">
                            <asp:DropDownList ID="DD_AllergicEggs" CssClass="btn btn-light text-left" runat="server">
                                <asp:ListItem Value="Yes" Text="มี"></asp:ListItem>
                                <asp:ListItem Value="No" Text="ไม่มี" Selected="True"></asp:ListItem>
                            </asp:DropDownList> ประวัติการแพ้ไข่
                            </div>
                            <div class="col-12">
                            <asp:UpdatePanel ID="UpdatePanel_AllergicVaccines" runat="server">
                                <ContentTemplate>
                                    <asp:DropDownList ID="DD_AllergicVaccines" CssClass="btn btn-light text-left" AutoPostBack="true" OnSelectedIndexChanged="DD_AllergicVaccines_SelectedIndexChanged" runat="server">
                                        <asp:ListItem Value="Yes" Text="มี"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="ไม่มี" Selected="True"></asp:ListItem>
                                    </asp:DropDownList> ประวัติการแพ้วัคซีน
                                    <input id="txt_AllergicVaccines" class="col-8 form-control text-left mb-2" placeholder="โปรดระบุ" runat="server" visible="false" />
                                </ContentTemplate>
                            </asp:UpdatePanel>
                            </div>
                            <div class="col-12">
                            <asp:DropDownList ID="DD_Fever" CssClass="btn btn-light text-left" runat="server">
                                <asp:ListItem Value="Yes" Text="มี"></asp:ListItem>
                                <asp:ListItem Value="No" Text="ไม่มี" Selected="True"></asp:ListItem>
                            </asp:DropDownList> ประวัติไข้ในปัจจุบัน
                            </div>
                            <div class="col-12">
                             <asp:DropDownList ID="DD_Pregnant" CssClass="btn btn-light text-left" runat="server">
                                <asp:ListItem Value="Yes" Text="มี"></asp:ListItem>
                                <asp:ListItem Value="No" Text="ไม่มี" Selected="True"></asp:ListItem>
                            </asp:DropDownList> ประวัติการตั้งครรภ์ในปัจจุบัน
                            </div>
                            <div class="col-12">
                            <asp:DropDownList ID="DD_GillenBarre" CssClass="btn btn-light text-left" runat="server">
                                <asp:ListItem Value="Yes" Text="มี"></asp:ListItem>
                                <asp:ListItem Value="No" Text="ไม่มี" Selected="True"></asp:ListItem>
                            </asp:DropDownList> ประวัติเกี่ยวกับโรคกิลเลน-บาร์เร่ ซินโดรม (เป็นอัมพาตชนิดหนึ่ง เรียกอีกอย่างหนึ่งว่า GBS)
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div> <!-- ประวัติการแพ้ยาและอื่นๆ -->

        <div class="col-12 col-lg-8 mx-auto my-2">
            <div class="card features">
                <div class="card-body">
                    <div class="media">
                        <span class="ti-help-alt gradient-fill ti-3x mr-3"></span>
                        <div class="media-body h2">
                            <h2 id="cld_title" class="card-title" runat="server">วันเวลาที่นัดหมาย</h2>
                            <p>สามารถเลือกตั้งแต่ 11/5/2020 - 15/7/2020</p>
                            <asp:UpdatePanel ID="UpdatePanel_CLD" runat="server">
                                <ContentTemplate>
                                    <asp:Calendar ID="CLD_book" CssClass="col-12 mx-auto" Height="500" OnSelectionChanged="CLD_book_SelectionChanged" OnDayRender="CLD_book_DayRender" runat="server">
                                        <TitleStyle BackColor="#9e1782" CssClass="bg-gradient" />
                                        <DayHeaderStyle BackColor="#c1c1c1" />
                                        <SelectedDayStyle BackColor="#ba75b4" />
                                        <DayStyle BorderWidth="1" HorizontalAlign="Right" VerticalAlign="Top" Font-Size="XX-Large" />
                                    </asp:Calendar>
                                    <span style="color:red; font-size:medium">หมายเหตุ : จำกัดวันละ 60คนเท่านั้น</span>
                                    <div hidden="hidden">
                                        <input type="text" id="txtH_bookdate" value="" runat="server" />
                                    </div>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="DD_Location" EventName="selectedindexchanged" />
                                </Triggers>
                            </asp:UpdatePanel>
                            <div class="row col-12 mt-3">
                                เวลา : &nbsp;<input type="time" id="txt_time" class="col-2 form-control text-left" value="" runat="server" required="required" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div> <!-- วันที่นัดหมาย -->

        <div class="col-12 col-lg-8 mx-auto my-5 text-center">
            <button type="submit" id="btn_Submit" class="btn btn-primary" value="Submit" onserverclick="btn_Submit_ServerClick" runat="server">
                <span class="ti-save ti-2x"> SAVE</span>
            </button>
            <script>
                // Check submit double click
                Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(BeginRequestHandler);
                function BeginRequestHandler(sender, args) { var oControl = args.get_postBackElement(); oControl.disabled = true; }
            </script>
        </div>

    </div>

</asp:Content>
