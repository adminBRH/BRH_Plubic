<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ARIclinic.aspx.cs" Inherits="BRH_Plubic.ARIclinic" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">

<style>
    .RadioWH {
        width: 40px;
        height: 40px;
    }
</style>

    <div class="row mx-auto">
        
        <div class="card card-header col-12 text-center h1 bg-gradient" style="color:white">
            แบบคัดกรองตนเอง<br />
            ก่อนเข้ารับบริการโรงพยาบาลกรุงเทพระยอง
        </div>

        <div class="row col-12 mt-3 mb-2 h2">
            <div class="col-4 mr-2 text-right align-self-center">
                เพศ
            </div>
            <div class="col-7 mb-2">
                <asp:DropDownList ID="DD_sex" CssClass="btn btn-light text-left" runat="server">
                    <asp:ListItem Value="Men" Text="ชาย Men" Selected="True"></asp:ListItem>
                    <asp:ListItem Value="Women" Text="หญิง Women"></asp:ListItem>
                </asp:DropDownList>
                <span style="font-size:medium; color:gray">Sex</span>
            </div>
            <div class="col-4 mr-2 text-right align-self-center mb-2">
                คำนำหน้า
            </div>
            <div class="col-7 mb-2">
                <input type="text" id="txt_pname" class="col-4 form-control text-left" placeholder="Name prefix" value="" required="required" runat="server" />
            </div>
            <div class="col-4 mr-2 text-right align-self-center mb-2">
                ชื่อ
            </div>
            <div class="col-7 mb-2">
                <input type="text" id="txt_fname" class="col-6 form-control text-left" placeholder="First name" value="" required="required" runat="server" />
            </div>
            <div class="col-4 mr-2 text-right align-self-center mb-2">
                นามสกุล
            </div>
            <div class="col-7 mb-2">
                <input type="text" id="txt_lname" class="col-6 form-control text-left" placeholder="Surname" value="" required="required" runat="server" />
            </div>
            <div class="col-4 mr-2 text-right align-self-center mb-2">
                วันเดือนปีเกิด
            </div>
            <div class="col-7 mb-2">
                <input type="date" id="date_dob" class="btn btn-light" value="" required="required" runat="server" /><span style="font-size:medium; color:gray">Date of birth</span>
            </div>
            <div class="col-4 mr-2 text-right align-self-center mb-2">
                เลขบัตรประชาชน
            </div>
            <div class="col-7 mb-2">
                <input type="text" id="txt_cardnum" class="col-6 form-control text-left"  placeholder="ID card number" value="" required="required" runat="server" />
            </div>
            <div class="col-4 mr-2 text-right align-self-center mb-2">
                เบอร์โทรศัพท์
            </div>
            <div class="col-7 mb-2">
                <input type="text" id="txt_phone" class="col-4 form-control text-left"  placeholder="Telephone Number." value="" required="required" runat="server" />
            </div>
            <div class="col-10 mx-auto mt-5 badge-light">
                <div id="div_symptoms" class="card card-header bg-gradient" style="color:white" runat="server">
                    ท่านต้องการพบแพทย์ด้วยอาการดังต่อไปนี้
                </div>
                <div class="card card-body bg-transparent">
                    <div class="row col-12">

                        <div class="col-2 my-3">
                            <label class="switch"><input  type="checkbox" id="CB_Fever" value="Yes" onclick="CheckAnswer()" runat="server" /><span class="slider round"></span></label>
                        </div>
                        <div class="col-10 my-3"> มีไข้ <br />Do you have fever<hr /></div>

                        <div class="col-2 my-3">
                            <label class="switch"><input  type="checkbox" id="CB_C" value="Yes" onclick="CheckAnswer()" runat="server" /><span class="slider round"></span></label>
                        </div>
                        <div class="col-10 my-3"> ไอ <br />Cough<hr /></div>

                        <div class="col-2 my-3">
                            <label class="switch"><input  type="checkbox" id="CB_ST" value="Yes" onclick="CheckAnswer()" runat="server" /><span class="slider round"></span></label>
                        </div>
                        <div class="col-10 my-3"> เจ็บคอ <br />Sore throats<hr /></div>

                        <div class="col-2 my-3">
                            <label class="switch"><input  type="checkbox" id="CB_RN" value="Yes" onclick="CheckAnswer()" runat="server" /><span class="slider round"></span></label>
                        </div>
                        <div class="col-10 my-3"> น้ำมูกไหล <br />Runny nose<hr /></div>

                        <div class="col-2 my-3">
                            <label class="switch"><input  type="checkbox" id="CB_SB" value="Yes" onclick="CheckAnswer()" runat="server" /><span class="slider round"></span></label>
                        </div>
                        <div class="col-10 my-3"> เหนื่อยหอบ <br />Shortness of breath<hr /></div>

                        <div class="col-2 my-3">
                            <label class="switch"><input  type="checkbox" id="CB_Province" value="No" onclick="CheckAnswer()" runat="server" /><span class="slider round"></span></label>
                        </div>
                        <div class="col-10 my-3"> ในช่วง 14วันที่ผ่านมา ท่านได้เดินทางมาจากต่างจังหวัดหรือไม่ <br />In the last 14 days Have you traveled from another province?<hr /></div>
                        
                        <div class="col-2 my-3">
                            <label class="switch"><input  type="checkbox" id="CB_Suspect" value="No" onclick="CheckAnswer()" runat="server" /><span class="slider round"></span></label>
                        </div>
                        <div class="col-10 my-3"> ท่านมีประวัติสัมผัสใกล้ชิดกับผู้ป่วยที่ต้องสงสัยการติดเชื้อโรคไวรัสโคโรนาสายพันธุ์ใหม่ 2019 หรือมีอาชีพที่มีโอกาสสัมผัสนักท่องเที่ยวต่างชาติ <br />Do you have contacted with suspected or have career opportunities with foreign tourists?<hr /></div>

                        <div class="col-2 my-3">
                            <label class="switch"><input type="checkbox" id="CB_NS" value="Yes" checked onclick="CheckNotAll()" runat="server" /><span class="slider round"></span></label>
                        </div>
                        <div class="col-10 my-3"> ไม่มีอาการเหล่านี้ 14วันที่ผ่านมาไม่ได้ไปต่างจังหวัด และไม่เคยสัมผัสใกล้ชิดผู้ป่วย Without these symptoms 14 days ago, didn't go to another province And never touching close patients.</div>

                        <!-- Script Check Answer -->
                        <script>
                            var FE = document.getElementById('<%= CB_Fever.ClientID %>');
                            var CO = document.getElementById('<%= CB_C.ClientID %>');
                            var ST = document.getElementById('<%= CB_ST.ClientID %>');
                            var RN = document.getElementById('<%= CB_RN.ClientID %>');
                            var SB = document.getElementById('<%= CB_SB.ClientID %>');
                            var PR = document.getElementById('<%= CB_Province.ClientID %>');
                            var SU = document.getElementById('<%= CB_Suspect.ClientID %>');

                            var NotAll = document.getElementById('<%= CB_NS.ClientID %>');
                            var DivNotAll = document.getElementById('div_NotAll');

                            function CheckAnswer() {
                                if (FE.checked || CO.checked || ST.checked || RN.checked || SB.checked || PR.checked || SU.checked) {
                                    NotAll.checked = false;
                                }
                            }

                            function CheckNotAll() {
                                if (NotAll.checked) {
                                    FE.checked = false;
                                    CO.checked = false;
                                    ST.checked = false;
                                    RN.checked = false;
                                    SB.checked = false;
                                    PR.checked = false;
                                    SU.checked = false;
                                }
                                else {
                                    if (FE.checked || CO.checked || ST.checked || RN.checked || SB.checked || PR.checked || SU.checked) {
                                    } else {
                                        NotAll.checked = true;
                                    }
                                }
                            }
                        </script>

                    </div>
                </div>
            </div>
        </div>

        <div class="col-11 mx-auto mt-5 text-center">
            <asp:Button ID="btn_submit" Text="SUBMIT" CssClass="btn btn-primary" OnClick="btn_submit_Click" Font-Size="X-Large" runat="server" />
        </div>

    </div>

</asp:Content>
