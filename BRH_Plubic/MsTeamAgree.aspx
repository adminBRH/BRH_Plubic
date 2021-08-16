<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MsTeamAgree.aspx.cs" Inherits="BRH_Plubic.MsTeamAgree" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">

    <asp:ScriptManager ID="ScriptManager_Master" runat="server"></asp:ScriptManager>

        <div class="section col-11 mx-auto" id="document">
            
            <div class="col-6 mx-auto text-right mb-3">
                <a href="#document" onclick="language('TH')">ไทย </a> | <a href="#document" onclick="language('EN')"> English</a>
            </div>
            <p>&nbsp;</p>

            <!-- ====================================== DocCument HTML ====================================== -->
            <table width="100%" id="printableArea" runat="server" data-toggle="modal" data-target="#InputModal" style="width: 21cm; margin-left: auto; margin-right: auto;" border="0">
                <tr>
                    <td colspan="2">
                        <table width="100%" border="0">
                            <tr>
                                <td width="40%">
                                    <table width="100%" border="1" style="border:outset;">
                                        <tr>
                                            <td width="70%" style="border:hidden;">
                                                <img src="images/LOGO-BRH-Horizontal-ENG.jpg" class="img-fluid" />
                                            </td>
                                            <td width="30%" style="border:1px;" class="text-center">
                                                Picture
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" style="border:outset;"></td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" style="border:1px;" class="text-center">
                                                <b id="titleDoc_th">
                                                    <asp:Label ID="lbl_titleDoc_th" Text="" runat="server"></asp:Label>
                                                </b>
                                                <b id="titleDoc_en" hidden="hidden">
                                                    <asp:Label ID="lbl_titleDoc_en" Text="" runat="server"></asp:Label>
                                                </b>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="60%" class="align-text-bottom">
                                    Name :<asp:Label ID="lbl_name" ForeColor="Blue" Text="………………………………….………………………………" runat="server"></asp:Label>Room :……………<br />
                                    Date of Birth : <asp:Label ID="lbl_dob" ForeColor="Blue" Text="……………………………………" runat="server"></asp:Label>Age<asp:Label ID="lbl_age" ForeColor="Blue" Text="…………………." runat="server"></asp:Label>Gender<asp:Label ID="lbl_gender" ForeColor="Blue" Text="…………" runat="server"></asp:Label><br />
                                    HN : ……………………………………… EN / AN :……..………………………………<br />
                                    Visit Date : <asp:Label ID="lbl_visitdate" ForeColor="Blue" Text="…………………………..." runat="server"></asp:Label>OPD / Ward…………………………………<br />
                                    Physician : ………………………………..………………………………………………..<br />
                                    Allergies :……………………………….………………………………………………….
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                </tr>
                    <td colspan="2">&nbsp;</td>
                <tr>
                    <td colspan="2">
                        <label id="lb_pnameTH">ข้าพเจ้า นาย / นาง/ นางสาว</label>
                        <label id="lb_pnameEN" hidden="hidden">I,  Mr, Mrs, Ms, </label>
                        <asp:Label ID="lbl_nameTH" ForeColor="Blue" Text="………………………………………………………………………………………………." runat="server">
                        </asp:Label><label id="lb_ageTH">อายุ</label><label id="lb_ageEN" hidden="hidden">age</label><asp:Label ID="lbl_ageTH" ForeColor="Blue" Text="……………………" runat="server"></asp:Label><label id="lb_yearoldTH">ปี</label><label id="lb_yearoldEN" hidden="hidden">year old</label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <label id="lb_cardTH">บัตรประจำตัวประชาชน / ใบขับขี่ / บัตรอื่น ๆ คือ </label>
                        <label id="lb_cardEN" hidden="hidden">Identity card/Driving license/other </label>
                        <asp:Label ID="lbl_card" ForeColor="Blue" Text="……………………………………………….." runat="server"></asp:Label>
                        <label id="lb_cardnumTH">เลขที่</label>
                        <label id="lb_cardnumEN" hidden="hidden">number of identity</label>
                        <asp:Label ID="lbl_cardNum" ForeColor="Blue" Text="………………………………………………." runat="server"></asp:Label>
                    </td>
                </tr>
                <tr id="tr1_reason" runat="server">
                    <td colspan="2">
                        <label id="lb_reasonTH">เหตุผลที่ผู้รับบริการไม่สามารถเดินทางมารับการรักษาในโรงพยาบาล</label>
                        <label id="lb_reasonEN" hidden="hidden">Reason of incapable for incapable for coming to received the treatment at the hospital</label>
                        <asp:Label ID="lbl_reason" ForeColor="Blue" Text="……………………………………………………………………………" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr id="tr1_accept" runat="server">
                    <td colspan="2">
                        <label id="lb_covidTH">ขอแสดงความยินยอมโดยสมัครใจ ขอคำปรึกษา ตรวจรักษากับแพทย์ และทันตแพทย์ ผ่านระบบอินเตอร์เน็ต ในสถานการณ์ COVID-19</label>
                        <label id="lb_covidEN" hidden="hidden">I voluntarily accept to received consultation and treatment by the doctor and dentist via internet, during the coronavirus (COVID-19) outbreak.</label>
                    </td>
                </tr>
                <tr id="tr2_accept" runat="server" hidden="hidden">
                    <td colspan="2">
                        <label id="lb_covidTH2">ขอแสดงความยินยอมโดยสมัครใจกักตัวที่บ้านนาน 10 วัน ภายใต้การดูแลของทีมโรงพยาบาลกรุงเทพระยอง และสมัครใจขอคำปรึกษา ตรวจรักษากับแพทย์ และทันตแพทย์ของโรงพยาบาลกรุงเทพระยอง ผ่านระบบอินเตอร์เน็ต เนื่องจากสถานการณ์การระบาดของโรคโควิด-19 และภาวะขีดจำกัดด้านความสามารถเตียงผู้ป่วยในที่รองรับกลุ่ม COVID-19 ที่มีจำกัด</label>
                        <label id="lb_covidEN2" hidden="hidden">I voluntarily consent to accept for 10-day home quarantine under the care of Bangkok Hospital Rayong team, including voluntarily consent for medical consultation and treatment with physician/dentist of Bangkok Hospital Rayong via telemedicine due to Covid-19 pandemic situation and in-patient accommodation capacity for Covid-19 cases is limited. Thus, I was well informed by the treating physician/dentist and/or his/her assistants.</label>
                    </td>
                </tr>
                <tr>
                    <td width="5%" class="text-right align-text-top">1. </td>
                    <td width="95%">
                        <label id="lb_1TH">ข้าพเจ้าได้รับการชี้แจงจากคณะแพทย์ ทันตแพทย์ พยาบาลของโรงพยาบาลโดยชัดแจ้งถึงข้อดีและข้อจำกัดต่างๆ  อันอาจจะเกิดจากการตรวจรักษาพยาบาลผ่านระบบอินเตอร์เน็ต และยินยอมขอคำปรึกษาตรวจรักษากับแพทย์ และทันตแพทย์ ตลอดจนปฏิบัติตามคำแนะนำและข้อจำกัดของแพทย์ และทันตแพทย์ ทุกประการ</label>
                        <label id="lb_1EN" hidden="hidden">I was clearly clarified from the treating physician and/or his/her assistants about the pros and cons which might happen from the treatment via the internet and consent to accept the treatment including following all the advice suggested by the treating physician and/or his/her assistants.</label>
                    </td>
                </tr>
                <tr>
                    <td class="text-right align-text-top">2. </td>
                    <td>
                        <label id="lb_2TH">ข้าพเจ้ายินยอมโดยสมัครใจให้คณะแพทย์ ทันตแพทย์-พยาบาล และ/หรือ บุคลากรอื่น ๆ ในทีมสุขภาพของโรงพยาบาลกรุงเทพระยอง ทำการตรวจรักษา การบันทึกข้อมูลสุขภาพ รวมถึงการถ่ายนิ่งและบันทึกภาพเคลื่อนไหว ที่เกี่ยวข้องกับการรักษาและ/หรือ กระทำการใดๆ ตามหลักวิชาชีพทางการแพทย์ได้ตลอดระยะเวลาที่ข้าพเจ้า ให้คำปรึกษา ตรวจรักษากับแพทย์ผ่านระบบอินเตอร์เน็ต โดยจะต้องอธิบายข้อมูล รายละเอียดให้แก่ข้าพเจ้าได้เข้าใจและยินยอมก่อนที่จะดำเนินการอีกทั้งเปิดโอกาสให้ข้าพเจ้าซักถามจนเป็นที่พอใจ เพื่อการปรับปรุงการบริการ</label>
                        <label id="lb_2EN" hidden="hidden">I voluntarily consent to the treatment, record health information including take photos and video that is related to the treatment and/or appropriate medical procedures provided by the treating physician and/or his/her assistants and/or other personnel from Bangkok Hospital Rayong throughout the period that I am to be treated via the internet. Prior to any procedure, the details must be explained to me to my comprehension and agreement as well as giving me the opportunity to inquire further should I feel inadequately informed.</label>
                    </td>
                </tr>
                <tr>
                    <td class="text-right align-text-top">3. </td>
                    <td>
                        <label id="lb_3TH">ข้าพเจ้าเข้าใจดีว่าข้อมูลในการตรวจรักษาของข้าพเจ้าใช้เพื่อการตรวจวินิจฉัยและการรักษาของข้าพเจ้า ดังนั้น คณะแพทย์/พยาบาล/เจ้าหน้าที่และ/หรือบุคลากรอื่น ๆ ในทีมสุขภาพของโรงพยาบาล ผู้ซึ่งเกี่ยวข้องในการตรวจวินิจฉัย และการรักษาข้าพเจ้า มีความจำเป็นในการเข้าถึง  ข้อมูลของข้าพเจ้า</label>
                        <label id="lb_3EN" hidden="hidden">I understand that the information about my treatment is needed for my diagnosis and treatment. Therefore, all the treating physician and/or his/her assistants, staffs and/or other personnel in Health Department of the hospital including other people who get involved in diagnosing and treating me can access to the information.</label>
                    </td>
                </tr>
                <tr>
                    <td class="text-right align-text-top">4. </td>
                    <td>
                        <label id="lb_4TH">ในกรณีซึ่งค่าใช้จ่ายในการตรวจวินิจฉัย และการรักษาของข้าพเจ้า รับผิดชอบโดยบุคคลอื่น เช่น บริษัทต้นสังกัด และ/หรือบริษัทประกันเป็นต้น อาจมีการร้องขอให้โรงพยาบาลเปิดเผยข้อมูลของข้าพเจ้าแก่บริษัทดังกล่าว ข้าพเจ้าเข้าใจและยินยอมให้โรงพยาบาลเปิดเผยข้อมูลทั้งหมดที่ขอของข้าพเจ้าให้ บริษัทดังกล่าวได้</label>
                        <label id="lb_4EN" hidden="hidden">If the expenses of my diagnosis and treatment are responsible by other persons such as the company and/or insurance company, my information might be asked to disclose to those companies. I understand and agree with the hospital to disclose all the required information to those companies.</label>
                    </td>
                </tr>
                <tr id="tr2_5" runat="server" hidden="hidden">
                    <td class="text-right align-text-top">5. </td>
                    <td>
                        <label id="lb_5TH">ข้าพเจ้ายินยอมที่จะปฏิบัติตามคำแนะนำที่คณะแพทย์ ทันตแพทย์ -พยาบาล และ/หรือ บุคลากรอื่น ๆ ในทีมสุขภาพของโรงพยาบาลกรุงเทพระยองอย่างเคร่งครัด และยินยอมที่จะได้รับการดูแลเพิ่มเติมจากทีมงานด้านสาธารณสุขจากภาครัฐที่ทางโรงพยาบาลกรุงเทพระยองประสานงานให้</label>
                        <label id="lb_5EN" hidden="hidden">I consent to strictly follow all the advice suggested by treating physician/dentist and/or his/her assistants, staffs and/or other personnel in Bangkok Hospital Rayong including consent to accept further care from government public health professionals those who cooperated with the hospital.</label>
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>
                        <br /><br />
                        <p id="lb_respectTH">
                            <asp:Label ID="lbl_respect_th" Text="" runat="server"></asp:Label>
                        </p>
                        <p id="lb_respectEN" hidden="hidden">
                            <asp:Label ID="lbl_respect_en" Text="" runat="server"></asp:Label>
                        </p>
                    </td>
                </tr>
            </table>

            <div class="col-12 mx-auto my-3 text-center">
                <a href="#" id="btn_input" class="btn btn-outline-primary" data-toggle="modal" data-target="#InputModal" runat="server">กรอกข้อมูล</a>
                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                    <ContentTemplate>
                        <div id="div_submit" runat="server" hidden="hidden">
                            <a href="#" id="btn_edit" class="btn btn-outline-primary mx-5" data-toggle="modal" data-target="#InputModal" runat="server">แก้ไข</a>
                            <asp:Button ID="btn_submit" CssClass="btn btn-primary mx-5" Text="ยอมรับ Agree" OnClick="btn_submit_Click" runat="server" />
                        </div>
                        <asp:Label ID="lbl_alert" CssClass="col-12 mx-auto text-center" Font-Size="X-Large" Text="" runat="server"></asp:Label>
                        <div id="div_print" runat="server" visible="false">
                            <input type="button" class="btn btn-outline-info mx-5" onclick="printDiv()" value="PRINT" />
                        </div>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btn_submit" EventName="click" />
                    </Triggers>
                </asp:UpdatePanel>
            </div>
            <!-- ====================================== DocCument HTML ====================================== -->

        </div>

<script>
    function language(lg) {
        var titleDocTH = document.getElementById("titleDoc_th");
        var titleDocEN = document.getElementById("titleDoc_en");
        var pnameTH = document.getElementById("lb_pnameTH");
        var pnameEN = document.getElementById("lb_pnameEN");
        var ageTH = document.getElementById("lb_ageTH");
        var ageEN = document.getElementById("lb_ageEN");
        var yearoldTH = document.getElementById("lb_yearoldTH");
        var yearoldEN = document.getElementById("lb_yearoldEN");
        var cardTH = document.getElementById("lb_cardTH");
        var cardEN = document.getElementById("lb_cardEN");
        var cardnumTH = document.getElementById("lb_cardnumTH");
        var cardnumEN = document.getElementById("lb_cardnumEN");
        var reasonTH = document.getElementById("lb_reasonTH");
        var reasonEN = document.getElementById("lb_reasonEN");
        var covidTH = document.getElementById("lb_covidTH");
        var covidEN = document.getElementById("lb_covidEN");
        var covidTH2 = document.getElementById("lb_covidTH2");
        var covidEN2 = document.getElementById("lb_covidEN2");
        var oneTH = document.getElementById("lb_1TH");
        var oneEN = document.getElementById("lb_1EN");
        var twoTH = document.getElementById("lb_2TH");
        var twoEN = document.getElementById("lb_2EN");
        var threeTH = document.getElementById("lb_3TH");
        var threeEN = document.getElementById("lb_3EN");
        var fourTH = document.getElementById("lb_4TH");
        var fourEN = document.getElementById("lb_4EN");
        var fiveTH = document.getElementById("lb_5TH");
        var fiveEN = document.getElementById("lb_5EN");
        var respectTH = document.getElementById("lb_respectTH");
        var respectEN = document.getElementById("lb_respectEN");

        if (lg == "TH") {
            titleDocTH.hidden = "";
            titleDocEN.hidden = "hidden";
            pnameTH.hidden = "";
            pnameEN.hidden = "hidden";
            ageTH.hidden = "";
            ageEN.hidden = "hidden";
            yearoldTH.hidden = "";
            yearoldEN.hidden = "hidden";
            cardTH.hidden = "";
            cardEN.hidden = "hidden";
            cardnumTH.hidden = "";
            cardnumEN.hidden = "hidden";
            reasonTH.hidden = "";
            reasonEN.hidden = "hidden";
            covidTH.hidden = "";
            covidEN.hidden = "hidden";
            covidTH2.hidden = "";
            covidEN2.hidden = "hidden";
            oneTH.hidden = "";
            oneEN.hidden = "hidden";
            twoTH.hidden = "";
            twoEN.hidden = "hidden";
            threeTH.hidden = "";
            threeEN.hidden = "hidden";
            fourTH.hidden = "";
            fourEN.hidden = "hidden";
            fiveTH.hidden = "";
            fiveEN.hidden = "hidden";
            respectTH.hidden = "";
            respectEN.hidden = "hidden";
        } else if (lg == "EN") {
            titleDocTH.hidden = "hidden";
            titleDocEN.hidden = "";
            pnameTH.hidden = "hidden";
            pnameEN.hidden = "";
            ageTH.hidden = "hidden";
            ageEN.hidden = "";
            yearoldTH.hidden = "hidden";
            yearoldEN.hidden = "";
            cardTH.hidden = "hidden";
            cardEN.hidden = "";
            cardnumTH.hidden = "hidden";
            cardnumEN.hidden = "";
            reasonTH.hidden = "hidden";
            reasonEN.hidden = "";
            covidTH.hidden = "hidden";
            covidEN.hidden = "";
            covidTH2.hidden = "hidden";
            covidEN2.hidden = "";
            oneTH.hidden = "hidden";
            oneEN.hidden = "";
            twoTH.hidden = "hidden";
            twoEN.hidden = "";
            threeTH.hidden = "hidden";
            threeEN.hidden = "";
            fourTH.hidden = "hidden";
            fourEN.hidden = "";
            fiveTH.hidden = "hidden";
            fiveEN.hidden = "";
            respectTH.hidden = "hidden";
            respectEN.hidden = "";
        } else { }
    }
</script>

<!-- ====================================== Input MODAL ====================================== -->
          <div class="modal fade" id="InputModal" tabindex="-1" role="dialog" aria-labelledby="lblInputModal" aria-hidden="true" style="font-size: x-large;">
            <div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 80%;">
              <div class="modal-content">
                <div class="modal-header">
                  <%--<h5 class="modal-title" style="color:red" id="lblInputModal">โปรดกรอกข้อมูลลงแบบฟอร์ม<br />ในการขอรับคำปรึกษาตรวจรักษากับแพทย์ผ่านระบบอินเตอร์เน็ต</h5>--%>
                  <h5 class="modal-title" style="color:red" id="lblInputModal"><asp:Label ID="lbl_titleModal" Text="" runat="server"></asp:Label></h5>
                  <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                  </button>
                </div>
                <div class="modal-body">
                    <div class="row col-12">
                        <div class="col-4 text-right my-3">
                            ชื่อ <span style="color:red">*</span> :
                        </div>
                        <div class="col-8 my-3">
                            <input type="text" id="txt_fnameTH" value="" class="form-control" placeholder="ชื่อ ภาษาไทย" runat="server" required="required" />
                        </div>
                        <div class="col-4 text-right my-3">
                            นามสกุล <span style="color:red">*</span> :
                        </div>
                        <div class="col-8 my-3">
                            <input type="text" id="txt_lnameTH" value="" class="form-control" placeholder="นามสกุล ภาษาไทย" runat="server" required="required" />
                        </div>
                        <div class="col-4 text-right my-3">
                            First Name :
                        </div>
                        <div class="col-8 my-3">
                            <input type="text" id="txt_fname" value="" class="form-control" placeholder="ชื่อ ภาษาอังกฤษ" runat="server" />
                        </div>
                        <div class="col-4 text-right my-3">
                            Last Name :
                        </div>
                        <div class="col-8 my-3">
                            <input type="text" id="txt_lname" value="" class="form-control" placeholder="นามสกุล ภาษาอังกฤษ" runat="server" />
                        </div>
                        <div class="col-4 text-right my-3">
                            Gender <span style="color:red">*</span> :
                            <br />เพศ
                        </div>
                        <div class="col-8 my-3">
                            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                <ContentTemplate>
                                    <asp:RadioButtonList ID="RD_gender" OnSelectedIndexChanged="RD_gender_SelectedIndexChanged" AutoPostBack="true" runat="server">
                                        <asp:ListItem Text="ชาย Male" Value="Male" selected="True"></asp:ListItem>
                                        <asp:ListItem Text="หญิง Female" Value="Female"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <div hidden="hidden">
                                        <input type="text" id="txt_gender" value="Male" runat="server" />
                                    </div>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="RD_gender" EventName="selectedindexchanged" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </div>
                        <div class="col-4 text-right my-3">
                            Date of Birth <span style="color:red">*</span> :
                            <br />วันเดือนปีเกิด
                        </div>
                        <div class="col-8 my-3">
                            <input type="date" id="date_DOB" value="" class="form-control" required="required" runat="server">
                        </div>
                        <div class="col-4 text-right my-3">
                            Card type <span style="color:red">*</span> :
                        </div>
                        <div class="col-8 my-3">
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                                    <asp:RadioButtonList ID="RD_Card" OnSelectedIndexChanged="RD_Card_SelectedIndexChanged" AutoPostBack="true" runat="server">
                                        <asp:ListItem Text="บัตรประจำตัวประชาชน (Identity card)" Value="Identity card" selected="True"></asp:ListItem>
                                        <asp:ListItem Text="ใบขับขี่ (Driver license)" Value="Driver license"></asp:ListItem>
                                        <asp:ListItem Text="บัตรอื่นๆ (Other cards)" Value="Other cards"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <div id="div_cardOther" class="input-group" runat="server" visible="false">
                                        <span style="color:red">*</span><input type="text" id="txt_CardOther" class="form-control" value="" placeholder="Card type name ?" runat="server" />
                                    </div>
                                    <div hidden="hidden">
                                        <input type="text" id="txtH_card" value="Identity card" runat="server" />
                                    </div>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="RD_Card" EventName="selectedindexchanged" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </div>
                        <div class="col-4 text-right my-3">
                            Card Number <span style="color:red">*</span> :
                        </div>
                        <div class="col-8 my-3">
                            <input type="text" id="txt_CardNumber" value="" class="form-control" placeholder="เลขที่บัตร" required="required" runat="server" />
                        </div>
                        <div class="col-4 text-right my-3">
                            Reson <span style="color:red">*</span> :
                        </div>
                        <div class="col-8 my-3">
                            <textarea id="txt_reson" aria-valuemax="500" class="form-control" placeholder="เหตุผลที่ผู้รับบริการไม่สามารถเดินทางมารับการรักษาในโรงพยาบาล" required="required" runat="server"></textarea>
                        </div>
                        <div class="col-4 text-right my-3">
                            Phone <span style="color:red">*</span> :
                        </div>
                        <div class="col-8 my-3">
                            <input type="text" id="txt_phone" value="" class="form-control" placeholder="เบอร์โทรศัพท์" runat="server" required="required" />
                        </div>
                        <div class="col-4 text-right my-3">
                            Email :
                        </div>
                        <div class="col-8 my-3">
                            <input type="text" id="txt_email" value="" class="form-control" placeholder="อีเมล" runat="server" />
                        </div>
                        <div class="col-4 text-right my-3">
                            Line ID :
                        </div>
                        <div class="col-8 my-3">
                            <input type="text" id="txt_line" value="" class="form-control" placeholder="ไอดีไลน์" runat="server" />
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                  <div class="input-group">
                      <div class="col-12 mx-auto text-center">
                          <button type="button" id="btn_InputOK" data-dismiss="modal" class="btn btn-primary" onmouseover="CheckInput()" value="" runat="server">Save</button>
                      </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
<!-- ====================================== Input MODAL ====================================== -->

    <div hidden="hidden">
        <input type="text" id="txtH_dcr" value="" runat="server" />
        <input type="text" id="txtH_dob" value="" runat="server" />
        <input type="text" id="txtH_dobsave" value="" runat="server" />
    </div>

<script>
    function CheckInput() {
        var fnameTH = document.getElementById("<%= txt_fnameTH.ClientID %>");
        var lnameTH = document.getElementById("<%= txt_lnameTH.ClientID %>");
        var fname = document.getElementById("<%= txt_fname.ClientID %>");
        var lname = document.getElementById("<%= txt_lname.ClientID %>"); 
        var DOB = document.getElementById("<%= date_DOB.ClientID %>"); 
        var gender = document.getElementById("<%= txt_gender.ClientID %>"); 
        var card = document.getElementById("<%= txtH_card.ClientID %>"); 
        var cardother = document.getElementById("<%= txt_CardOther.ClientID %>");
        var cardnum = document.getElementById("<%= txt_CardNumber.ClientID %>"); 
        var reson = document.getElementById("<%= txt_reson.ClientID %>"); 
        var phone = document.getElementById("<%= txt_phone.ClientID %>"); 
        var email = document.getElementById("<%= txt_email.ClientID %>"); 
        
        if (fnameTH.value == "" || lnameTH.value == "" || DOB.value == "" || phone.value == "" || (card.value == "Other" && cardother.value == "") ) {
            alert("กรุณากรอกข้อมูลให้ครบถ้วน Please Input required field !!");
            ShowHideBTN('required');
        } else {
            var lbl_name = document.getElementById("<%= lbl_name.ClientID %>");
            var lbl_dob = document.getElementById("<%= lbl_dob.ClientID %>");
            var lbl_age = document.getElementById("<%= lbl_age.ClientID %>");
            var lbl_gender = document.getElementById("<%= lbl_gender.ClientID %>");
            var lbl_visitdate = document.getElementById("<%= lbl_visitdate.ClientID %>");
            var lbl_nameTH = document.getElementById("<%= lbl_nameTH.ClientID %>");
            var lbl_ageTH = document.getElementById("<%= lbl_ageTH.ClientID %>");
            var lbl_card = document.getElementById("<%= lbl_card.ClientID %>");
            var lbl_cardnum = document.getElementById("<%= lbl_cardNum.ClientID %>");
            var lbl_reason = document.getElementById("<%= lbl_reason.ClientID %>");

            var H_dcr = document.getElementById("<%= txtH_dcr.ClientID %>");
            var dcr_ar = H_dcr.value.split('-');
            var dob_ar = DOB.value.split('-');
            var dobYear = dob_ar[0];

            var today = new Date();

            if (parseInt(dobYear) > today.getFullYear()) {
                dobYear = parseInt(dobYear) - 543;
            }

            var age = parseInt(dcr_ar[0]) - parseInt(dobYear);

            var MM = parseInt(dob_ar[1]) - parseInt(dcr_ar[1]);
            if (parseInt(MM) > 1) {
                age = parseInt(age) - 1;
            }

            var H_dob = document.getElementById("<%= txtH_dob.ClientID %>");
            H_dob.value = age;

            var FullName = fname.value + " " + lname.value;
            var FullNameTH = fnameTH.value + " " + lnameTH.value;

            if (fname.value == "" || lname.value == "") {
            } else {
                lbl_name.innerText = " " + FullName + " ";
            }

            var H_dobsave = document.getElementById("<%= txtH_dobsave.ClientID %>");
            H_dobsave.value = dobYear + "-" + dob_ar[1] + "-" + dob_ar[2];

            lbl_dob.innerText = " " + dob_ar[2] + "/" + dob_ar[1] + "/" + dobYear + " ";
            lbl_age.innerText = " " + age + " ";
            lbl_gender.innerText = " " + gender.value + " ";
            lbl_visitdate.innerText = " " + dcr_ar[2] + "/" + dcr_ar[1] + "/" + dcr_ar[0] + " ";
            lbl_nameTH.innerText = " " + FullNameTH + " ";
            lbl_ageTH.innerText = " " + age + " ";
            lbl_card.innerText = " " + card.value + " ";
            lbl_cardnum.innerText = " " + cardnum.value + " ";
            lbl_reason.innerText = " " + reson.value + " ";

            ShowHideBTN('input');
        }
    }

    function ShowHideBTN(SH) {
        var btn_input = document.getElementById("<%= btn_input.ClientID %>");
        var div_submit = document.getElementById("<%= div_submit.ClientID %>");

        if (SH == "required") {
            btn_input.hidden = "";
            div_submit.hidden = "hidden";
        } else if (SH == "input") {
            btn_input.hidden = "hidden";
            div_submit.hidden = "";
        } else {}
    }

    function printDiv() {
        var printContents = document.getElementById("<%= printableArea.ClientID %>").innerHTML;
        var originalContents = document.body.innerHTML;
        document.body.innerHTML = printContents;
        window.print();
        document.body.innerHTML = originalContents;
    }
</script>

    <asp:Label ID="lbl_modal" Text="" runat="server"></asp:Label>

</asp:Content>
