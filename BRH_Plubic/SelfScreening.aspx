<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SelfScreening.aspx.cs" Inherits="BRH_Plubic.SelfScreening" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">

    <asp:ScriptManager ID="ScriptManager_Master" runat="server"></asp:ScriptManager>

<style type="text/css">
    .rdb button
    {
        width: 100px;
        height: 100px;
    }
</style>

    <div class="col-11 mx-auto mb-5">

        <div class="text-center">
            <img src="images/AllianceLogo2.png" class="img-fluid" style="height:100px"/>
        </div>

        <!-- ======================================================================================================= -->

            <div class="section-title my-3">
                <h2>แบบคัดกรองตนเอง สำหรับผู้สงสัย</h2>
                <h2>โรคไวรัสโคโรนา​ 19</h2>
                <h3>(COVID-19) (Self-Screening)</h3>
                <h4>
                <p>อ้างอิงจากแนวทางการเฝ้าระวังและสอบสวนโรคติดเชื้อไวรัสโคโรนาสายพันธุ์ใหม่ 2019
                            ของกระทรวงสาธารณสุข</p>
                        <p> ขอความร่วมมือท่านให้ข้อมูลที่ถูกต้องเป็นความจริง
                            เพื่อประโยชน์ในการรักษาและป้องกันการแพร่กระจายเชื้อ</p>
                </h4>
                <h4>
                <p> We need your help in providing the most accurate and truthful medical statement in order for
                            us to treat and prevent spreading of the disease effectively</p>
                        <p>为了有效预防疾病的传播, 请您如实提供信息切勿隐瞒</p>
                </h4>
            </div>

            <div class="row">

                <div class="col-12 col-lg-4">
                    <div class="card features">
                        <div class="card-body">
                            <div class="media">
                                <span class="ti-anchor gradient-fill ti-3x mr-3"></span>
                                <div class="media-body h2">
                                    <h2 class="card-title">เพศ (Sex) 性别</h2>
                                    <input type="radio" name="RD_sex" id="RD_SexM" value="Men" style="width:30px; height:30px;" class="ml-3" runat="server" /> ชาย (Male) 男<br />
                                    <input type="radio" name="RD_sex" id="RD_SexF" value="Women" style="width:30px; height:30px;" checked class="ml-3" runat="server" /> หญิง (Female) 女
                                </div>
                            </div>
                        </div>
                    </div>
                </div> <!-- เพศ -->

                <div class="col-12 col-lg-4">
                    <div class="card features">
                        <div class="card-body">
                            <div class="media">
                                <span class="ti-help-alt gradient-fill ti-3x mr-3"></span>
                                <div class="media-body h2">
                                    <h2 class="card-title">อายุ (Age) 年龄</h2>
                                    <div>&nbsp;</div>
                                    <!-- DropDownList Age -->
                                    <div> 
                                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                        <ContentTemplate>
                                            <asp:DropDownList ID="DD_Age" Font-Size="30px" CssClass="btn btn-light" OnSelectedIndexChanged="DD_Age_SelectedIndexChanged" AutoPostBack="true" runat="server">
                                                <asp:ListItem Text="1" Value="1">1</asp:ListItem>
                                                <asp:ListItem Text="2" Value="2">2</asp:ListItem>
                                                <asp:ListItem Text="3" Value="3">3</asp:ListItem>
                                                <asp:ListItem Text="4" Value="4">4</asp:ListItem>
                                                <asp:ListItem Text="5" Value="5">5</asp:ListItem>
                                                <asp:ListItem Text="6" Value="6">6</asp:ListItem>
                                                <asp:ListItem Text="7" Value="7">7</asp:ListItem>
                                                <asp:ListItem Text="8" Value="8">8</asp:ListItem>
                                                <asp:ListItem Text="9" Value="9">9</asp:ListItem>
                                                <asp:ListItem Text="10" Value="10">10</asp:ListItem>
                                                <asp:ListItem Text="11" Value="11">11</asp:ListItem>
                                                <asp:ListItem Text="12" Value="12">12</asp:ListItem>
                                                <asp:ListItem Text="13" Value="13">13</asp:ListItem>
                                                <asp:ListItem Text="14" Value="14">14</asp:ListItem>
                                                <asp:ListItem Text="15" Value="15">15</asp:ListItem>
                                                <asp:ListItem Text="16" Value="16">16</asp:ListItem>
                                                <asp:ListItem Text="17" Value="17">17</asp:ListItem>
                                                <asp:ListItem Text="18" Value="18">18</asp:ListItem>
                                                <asp:ListItem Text="19" Value="19">19</asp:ListItem>
                                                <asp:ListItem Text="20" Value="20">20</asp:ListItem>
                                                <asp:ListItem Text="21" Value="21">21</asp:ListItem>
                                                <asp:ListItem Text="22" Value="22">22</asp:ListItem>
                                                <asp:ListItem Text="23" Value="23">23</asp:ListItem>
                                                <asp:ListItem Text="24" Value="24">24</asp:ListItem>
                                                <asp:ListItem Text="25" Value="25">25</asp:ListItem>
                                                <asp:ListItem Text="26" Value="26">26</asp:ListItem>
                                                <asp:ListItem Text="27" Value="27">27</asp:ListItem>
                                                <asp:ListItem Text="28" Value="28">28</asp:ListItem>
                                                <asp:ListItem Text="29" Value="29">29</asp:ListItem>
                                                <asp:ListItem Text="30" Value="30">30</asp:ListItem>
                                                <asp:ListItem Text="31" Value="31">31</asp:ListItem>
                                                <asp:ListItem Text="32" Value="32">32</asp:ListItem>
                                                <asp:ListItem Text="33" Value="33">33</asp:ListItem>
                                                <asp:ListItem Text="34" Value="34">34</asp:ListItem>
                                                <asp:ListItem Text="35" Value="35">35</asp:ListItem>
                                                <asp:ListItem Text="36" Value="36">36</asp:ListItem>
                                                <asp:ListItem Text="37" Value="37">37</asp:ListItem>
                                                <asp:ListItem Text="38" Value="38">38</asp:ListItem>
                                                <asp:ListItem Text="39" Value="39">39</asp:ListItem>
                                                <asp:ListItem Text="40" Value="40">40</asp:ListItem>
                                                <asp:ListItem Text="41" Value="41">41</asp:ListItem>
                                                <asp:ListItem Text="42" Value="42">42</asp:ListItem>
                                                <asp:ListItem Text="43" Value="43">43</asp:ListItem>
                                                <asp:ListItem Text="44" Value="44">44</asp:ListItem>
                                                <asp:ListItem Text="45" Value="45">45</asp:ListItem>
                                                <asp:ListItem Text="46" Value="46">46</asp:ListItem>
                                                <asp:ListItem Text="47" Value="47">47</asp:ListItem>
                                                <asp:ListItem Text="48" Value="48">48</asp:ListItem>
                                                <asp:ListItem Text="49" Value="49">49</asp:ListItem>
                                                <asp:ListItem Text="50" Value="50">50</asp:ListItem>
                                                <asp:ListItem Text="51" Value="51">51</asp:ListItem>
                                                <asp:ListItem Text="52" Value="52">52</asp:ListItem>
                                                <asp:ListItem Text="53" Value="53">53</asp:ListItem>
                                                <asp:ListItem Text="54" Value="54">54</asp:ListItem>
                                                <asp:ListItem Text="55" Value="55">55</asp:ListItem>
                                                <asp:ListItem Text="56" Value="56">56</asp:ListItem>
                                                <asp:ListItem Text="57" Value="57">57</asp:ListItem>
                                                <asp:ListItem Text="58" Value="58">58</asp:ListItem>
                                                <asp:ListItem Text="59" Value="59">59</asp:ListItem>
                                                <asp:ListItem Text="60" Value="60">60</asp:ListItem>
                                                <asp:ListItem Text="61" Value="61">61</asp:ListItem>
                                                <asp:ListItem Text="62" Value="62">62</asp:ListItem>
                                                <asp:ListItem Text="63" Value="63">63</asp:ListItem>
                                                <asp:ListItem Text="64" Value="64">64</asp:ListItem>
                                                <asp:ListItem Text="65" Value="65">65</asp:ListItem>
                                                <asp:ListItem Text="66" Value="66">66</asp:ListItem>
                                                <asp:ListItem Text="67" Value="67">67</asp:ListItem>
                                                <asp:ListItem Text="68" Value="68">68</asp:ListItem>
                                                <asp:ListItem Text="69" Value="69">69</asp:ListItem>
                                                <asp:ListItem Text="70" Value="70">70</asp:ListItem>
                                                <asp:ListItem Text="71" Value="71">71</asp:ListItem>
                                                <asp:ListItem Text="72" Value="72">72</asp:ListItem>
                                                <asp:ListItem Text="73" Value="73">73</asp:ListItem>
                                                <asp:ListItem Text="74" Value="74">74</asp:ListItem>
                                                <asp:ListItem Text="75" Value="75">75</asp:ListItem>
                                                <asp:ListItem Text="76" Value="76">76</asp:ListItem>
                                                <asp:ListItem Text="77" Value="77">77</asp:ListItem>
                                                <asp:ListItem Text="78" Value="78">78</asp:ListItem>
                                                <asp:ListItem Text="79" Value="79">79</asp:ListItem>
                                                <asp:ListItem Text="80" Value="80">80</asp:ListItem>
                                                <asp:ListItem Text="81" Value="81">81</asp:ListItem>
                                                <asp:ListItem Text="82" Value="82">82</asp:ListItem>
                                                <asp:ListItem Text="83" Value="83">83</asp:ListItem>
                                                <asp:ListItem Text="84" Value="84">84</asp:ListItem>
                                                <asp:ListItem Text="85" Value="85">85</asp:ListItem>
                                                <asp:ListItem Text="86" Value="86">86</asp:ListItem>
                                                <asp:ListItem Text="87" Value="87">87</asp:ListItem>
                                                <asp:ListItem Text="88" Value="88">88</asp:ListItem>
                                                <asp:ListItem Text="89" Value="89">89</asp:ListItem>
                                                <asp:ListItem Text="90" Value="90">90</asp:ListItem>
                                                <asp:ListItem Text="91" Value="91">91</asp:ListItem>
                                                <asp:ListItem Text="92" Value="92">92</asp:ListItem>
                                                <asp:ListItem Text="93" Value="93">93</asp:ListItem>
                                                <asp:ListItem Text="94" Value="94">94</asp:ListItem>
                                                <asp:ListItem Text="95" Value="95">95</asp:ListItem>
                                                <asp:ListItem Text="96" Value="96">96</asp:ListItem>
                                                <asp:ListItem Text="97" Value="97">97</asp:ListItem>
                                                <asp:ListItem Text="98" Value="98">98</asp:ListItem>
                                                <asp:ListItem Text="99" Value="99">99</asp:ListItem>
                                                <asp:ListItem Text="100" Value="100">100</asp:ListItem>
                                                <asp:ListItem Text="101" Value="101">101</asp:ListItem>
                                                <asp:ListItem Text="102" Value="102">102</asp:ListItem>
                                                <asp:ListItem Text="103" Value="103">103</asp:ListItem>
                                                <asp:ListItem Text="104" Value="104">104</asp:ListItem>
                                                <asp:ListItem Text="105" Value="105">105</asp:ListItem>
                                                <asp:ListItem Text="106" Value="106">106</asp:ListItem>
                                                <asp:ListItem Text="107" Value="107">107</asp:ListItem>
                                                <asp:ListItem Text="108" Value="108">108</asp:ListItem>
                                                <asp:ListItem Text="109" Value="109">109</asp:ListItem>
                                                <asp:ListItem Text="110" Value="110">110</asp:ListItem>
                                                <asp:ListItem Text="111" Value="111">111</asp:ListItem>
                                                <asp:ListItem Text="112" Value="112">112</asp:ListItem>
                                                <asp:ListItem Text="113" Value="113">113</asp:ListItem>
                                                <asp:ListItem Text="114" Value="114">114</asp:ListItem>
                                                <asp:ListItem Text="115" Value="115">115</asp:ListItem>
                                                <asp:ListItem Text="116" Value="116">116</asp:ListItem>
                                                <asp:ListItem Text="117" Value="117">117</asp:ListItem>
                                                <asp:ListItem Text="118" Value="118">118</asp:ListItem>
                                                <asp:ListItem Text="119" Value="119">119</asp:ListItem>
                                                <asp:ListItem Text="120" Value="120">120</asp:ListItem>
                                            </asp:DropDownList>
                                            <div hidden="hidden">
                                                <input type="text" id="txtH_age" value="1" runat="server" />
                                            </div>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="DD_Age" EventName="selectedindexchanged" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                    </div>
                                    <!-- DropDownList Age -->
                                </div>
                            </div>
                        </div>
                    </div>
                </div> <!-- อายุ -->

                <div class="col-12 col-lg-4">
                    <div class="card features">
                        <div class="card-body">
                            <div class="media">
                                <span class="ti-world gradient-fill ti-3x mr-3"></span>
                                <div class="media-body h2">
                                    <h2 class="card-title">ภาษาที่ท่านใช้ในการตอบแบบคัดกรอง (Lanquage) 语言</h2>
                                    <div>&nbsp;</div>
                                    <asp:DropDownList ID="DD_Lanquage" Font-Size="30px" CssClass="btn btn-light" runat="server">
                                        <asp:ListItem Text="ไทย" Value="Thai"></asp:ListItem>
                                        <asp:ListItem Text="中文" Value="Chaina"></asp:ListItem>
                                        <asp:ListItem Text="English" Value="English"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>
                    </div>
                </div> <!-- ภาษา -->

                <div class="col-12 col-lg-6 my-lg-3">
                    <div class="card features">
                        <div class="card-body">
                            <div class="media">
                                <span class="ti-support gradient-fill ti-3x mr-3"></span>
                                <div class="media-body h2">
                                    <h2 class="card-title">พนักงานโรงพยาบาลกรุงเทพระยอง (The staff here) 这里的员工</h2>
                                    <div class="form-check container">
                                        <input class="form-check-input" type="radio" id="RD_emp1" name="RDemp" value="Yes" style="width:30px; height:30px;" onclick="ShowHideEmp()" runat="server">
                                        <label class="form-check-label" for="RD_emp1">
                                            ใช่ Yes 是
                                        </label>
                                    </div>
                                    <div id="emp" hidden="hidden">
                                        <%--<input type="text" id="txt_emp" class="col-7 btn btn-outline-dark form-control" value="" placeholder="รหัสพนักงาน" runat="server" />--%>
                                        <input type="text" id="txt_emp" value="" class="form-control" style="font-size:30px" placeholder="รหัสพนักงาน" runat="server">
                                        <asp:UpdatePanel ID="UpdatePanelDepartment" runat="server">
                                            <ContentTemplate>
                                                <button id="btn_department" class="btn btn-outline-warning mb-3" style="font-size:30px" onserverclick="btn_department_ServerClick" runat="server">Check</button>
                                                <asp:Label ID="lbl_department" Text="" CssClass="mb-3" ForeColor="Blue" runat="server"></asp:Label>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </div>
                                    <div class="form-check container">
                                        <input class="form-check-input" type="radio" id="RD_emp0" name="RDemp" value="No" style="width:30px; height:30px;" onclick="ShowHideEmp()" runat="server">
                                        <label class="form-check-label" for="RD_emp0">
                                            ไม่ใช่ No. 否
                                        </label>
                                    </div>

                                    <script>
                                        function ShowHideEmp() {
                                            var d = document.getElementById("emp");
                                            var x = document.getElementById("<%= RD_emp1.ClientID %>");
                                            var t = document.getElementById("<%= txt_emp.ClientID %>");
                                            if (x.checked == true) {
                                                d.hidden = "";
                                                t.setAttribute("required", "required");
                                            } else {
                                                d.hidden = "hidden";
                                                t.removeAttribute("required");
                                            }
                                        }

                                        var d = document.getElementById("emp");
                                        var emp1 = document.getElementById("<%= RD_emp1.ClientID %>");
                                        var emp0 = document.getElementById("<%= RD_emp0.ClientID %>");
                                        if (emp1.checked || emp0.checked) {
                                            if (emp1.checked) {
                                                d.hidden = "";
                                            }
                                        } else {
                                            emp0.setAttribute("checked", "checked");
                                        }
                                    </script>

                                </div>
                            </div>
                        </div>
                    </div>
                </div> <!-- พนักงานโรงพยาบาล -->

                <div class="col-12 col-lg-6 my-lg-3">
                    <div class="card features">
                        <div class="card-body">
                            <div class="media">
                                <span class="ti-user gradient-fill ti-3x mr-3"></span>
                                <div class="media-body h2">
                                    <h2 class="card-title">บุคลากรทางการแพทย์ (Medical staff) 医护人员</h2>
                                    <div class="form-check container">
                                        <input class="form-check-input" type="radio" id="RD_med1" name="RDmedstaff" style="width: 30px; height: 30px;" value="Yes" runat="server">
                                        <label class="form-check-label" for="RD_med1">
                                            ใช่ Yes 是
                                        </label>
                                    </div>
                                    <div id="med" hidden="hidden">
                                        <%--<input type="text" id="txt_emp" class="col-7 btn btn-outline-dark form-control" value="" placeholder="รหัสพนักงาน" runat="server" />--%>
                                        <input type="text" id="txt_doctor" value="" class="form-control" style="font-size:30px" placeholder="Doctor ID" runat="server">
                                        <asp:UpdatePanel ID="UpdatePanel_med" runat="server">
                                            <ContentTemplate>
                                                <button id="btn_doctor" class="btn btn-outline-warning mb-3" style="font-size:30px" onserverclick="btn_doctor_ServerClick" runat="server">Check</button>
                                                <asp:Label ID="lbl_doctor" Text="" CssClass="mb-3" ForeColor="Blue" runat="server"></asp:Label>
                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="btn_doctor" />
                                            </Triggers>
                                        </asp:UpdatePanel>
                                    </div>
                                    <div class="form-check container">
                                        <input class="form-check-input" type="radio" id="RD_med0" name="RDmedstaff" style="width: 30px; height: 30px;" value="No" onclick="fn_Med()" runat="server">
                                        <label class="form-check-label" for="RD_med0">
                                            ไม่ใช่ No. 否
                                        </label>
                                    </div>

                                    <script>
                                        var med1 = document.getElementById("<%= RD_med1.ClientID %>");
                                        var med0 = document.getElementById("<%= RD_med0.ClientID %>");
                                        var divMed = document.getElementById('med');
                                        if (med1.checked || med0.checked) {
                                        } else {
                                            med0.setAttribute("checked", "checked");
                                        }
                                        //function fn_Med() {
                                        //    if (med1.checked) {
                                        //        divMed.removeAttribute('hidden');
                                        //    } else {
                                        //        divMed.setAttribute('hidden','hidden');
                                        //    }
                                        //}
                                        //fn_Med();
                                    </script>

                                </div>
                            </div>
                        </div>
                    </div>
                </div> <!-- บุคลากรทางการแพทย์ -->

            </div>

    </div>

    <!-- ======================================================================================================= -->

    <div class="col-11 mx-auto md-5">

        <div class="row">

            <div class="col-md-12 d-flex align-items-center">
                <ul class="list-unstyled ui-steps">
                    <li class="media">
                        <div class="circle-icon mr-4">1</div>
                        <div class="media-body h2">
                            <h2>ท่านมีไข้หรือไม่ Do you have Fever? 您有发烧的症状吗</h2>
                            <div class="container">
                                <div class="col-12 text-left">
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" id="self_fever_no" name="n_self_fever" style="width:30px; height:30px;" required="required" onchange="HideFevers()" value="No" runat="server">
                                        <label for="self_fever_no" class="ml-3"> ไม่มี NO 沒有 </label>
                                            <br />
                                        <input class="form-check-input" type="radio" id="self_fever" name="n_self_fever" style="width:30px; height:30px;" required="required" onchange="ShowFevers()" value="Yes" runat="server">
                                        <label for="self_fever" class="ml-3"> มี YES 是的 </label>
                                    </div>
                                </div>
                            </div>
<!-- ------------------------------------------------- -->
<div class="col-1"></div>
<div id="ShowFever" class="col-11 container" hidden="hidden">

                    <div class="col-12 text-left">
                        <b>ท่านได้ทำการวัดไข้หรือไม่ ? Do you measure your body temperature 您是否量过体温</b>
                    </div>
                    
                    <div class="col-12">
                            <input type="radio" onclick="HideScoreFever()" name="ScoreFever" id="ScoreFever0" value="No" style="width:30px; height:30px;" runat="server">
                            <label for="CheckFever0"> ไม่ได้วัดไข้ No. 没有 </label>
                    </div>
                    <div class="col-12">
                        <input type="radio" onclick="ShowScoreFever()" name="ScoreFever" id="ScoreFever1" value="Yes" style="width:30px; height:30px;" runat="server">
                        <label for="CheckFever1"> วัดไข้ Yes. 有</label>
                    </div>


                    <div class="input-group col-12 mb-3" id="ScoreFevers" hidden="hidden">
                        <table>
                            <tr>
                                <!-- DropDownList ScoreFever -->
                                <td>
                            <asp:DropDownList ID="DD_ScoreFever" Font-Size="30px" CssClass="btn btn-outline-danger" runat="server">
                                <asp:ListItem Text="37.5" Value="37.5" Selected="True"></asp:ListItem>
                                <asp:ListItem Text="38" Value="38"></asp:ListItem>
                                <asp:ListItem Text="38.5" Value="38.5"></asp:ListItem>
                                <asp:ListItem Text="39" Value="39"></asp:ListItem>
                                <asp:ListItem Text="39.5" Value="39.5"></asp:ListItem>
                                <asp:ListItem Text="40" Value="40"></asp:ListItem>
                                <asp:ListItem Text="40.5" Value="40.5"></asp:ListItem>
                                <asp:ListItem Text="41" Value="41"></asp:ListItem>
                            </asp:DropDownList>
                                </td>
                                <!-- DropDownList ScoreFever -->
                                <td>
                            <label for="DD_ScoreFever">°C</label>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <script>
                        function ShowScoreFever() {
                            var d = document.getElementById("ScoreFevers");
                            var x = document.getElementById("<%= ScoreFever1.ClientID %>");
                            if (x.checked == true) {
                                d.hidden = "";
                            } else {
                                d.hidden = "hidden";
                            }
                        }
                        function HideScoreFever() {
                            var d = document.getElementById("ScoreFevers");
                            var x = document.getElementById("<%= ScoreFever0.ClientID %>");
                            if (x.checked == true) {
                                d.hidden = "hidden";
                            } else {
                                d.hidden = "";
                            }
                        }

                        var d = document.getElementById("ScoreFevers");
                        var x = document.getElementById("<%= ScoreFever1.ClientID %>");
                        if (x.checked) {
                            d.hidden = "";
                        }
                    </script>

                    <div class="col-12 mt-3">
                        <b>ท่านได้รับประทานยาลดไข้หรือไม่ ? Do you have taken antipyretics drugs ?</b>
                    </div>
                    <div class="col-12">
                        <input type="radio" onclick="HideTakeMedications()" name="TakeMedication" id="TakeMedication0" value="No" style="width:30px; height:30px;" runat="server">
                        <label for="TakeMedication0"> ไม่ได้รับประทานยา No 沒有 </label>
                    </div>
                    <div class="col-12">
                        <input type="radio" onclick="ShowTakeMedications()" name="TakeMedication" id="TakeMedication1" value="Yes" style="width:30px; height:30px;" runat="server">
                        <label for="TakeMedication1"> รับประทานยา YES 是的 </label>
                    </div>

                    <div id="TakeMedications" hidden="hidden">
                        <div class="col-12 text-left mt-3">
                            <b>ระบุวัน/เวลาที่รับประทานยาลดไข้ When was the last time you took antipyretics drugs
                            告知小时内服用退烧药的时间</b>
                        </div>

                        <div class="col-12 ">
                            <table>
                                <tr>
                                    <td>
                                        <label> วันที่ (Date) 日期 </label>
                                        <input type="date" id="self_drugs_date" name="n_self_drugs_date" class="" runat="server">
                                    </td>
                                    <td>&nbsp;</td>
                                    <td>
                                        <label> เวลา (Time) 時間</label>
                                        <input type="time" id="self_drugs_time" name="n_self_drugs_time" class="" runat="server">
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="col-12 mt-3">
                            <b>วันที่เริ่มรู้สึกป่วย When did you start feeling sick? 你从什么时候开始发病</b>
                        </div>
                        <div class="col-12">
                            <label> วันที่ (Date) 日期 </label>
                            <input type="date" id="self_sick_date" name="n_self_sick_date" class="" runat="server">
                        </div>
                    </div>
                    <script>
                        function ShowTakeMedications() {
                            var d = document.getElementById("TakeMedications");
                            var x = document.getElementById("<%= TakeMedication1.ClientID %>");
                            if (x.checked == true) {
                                d.hidden = "";
                            } else {
                                d.hidden = "hidden";
                            }
                        }
                        function HideTakeMedications() {
                            var d = document.getElementById("TakeMedications");
                            var x = document.getElementById("<%= TakeMedication0.ClientID %>");
                            if (x.checked == true) {
                                d.hidden = "hidden";
                            } else {
                                d.hidden = "";
                            }
                        }

                        var d = document.getElementById("TakeMedications");
                        var x = document.getElementById("<%= TakeMedication1.ClientID %>");
                        if (x.checked) {
                            d.hidden = "";
                        }
                    </script>

</div>

<script>
    function ShowFevers() {
        var d = document.getElementById("ShowFever");
        var x = document.getElementById("<%= self_fever.ClientID %>");
        if (x.checked == true) {
            d.hidden = "";
        } else {
            d.hidden = "hidden";
        }
    }
    function HideFevers() {
        var d = document.getElementById("ShowFever");
        var x = document.getElementById("<%= self_fever_no.ClientID %>");
        if (x.checked == true) {
            d.hidden = "hidden";
        } else {
            d.hidden = "";
        }
    }

    var d = document.getElementById("ShowFever");
    var x = document.getElementById("<%= self_fever_no.ClientID %>");
    if (x.checked) {
        d.hidden = "";
    }
</script>

<!-- ---------------------------------------------------------- -->
                        </div>
                    </li>


                    <li class="media my-4">
                        <div class="circle-icon mr-4">2</div>
                        <div class="media-body h2">
                            <h2>ท่านมีอาการดังต่อไปนี้ หรือไม่ Do you have any of these Symptoms? 您有以下一个或多个症状</h2>
                            <!-- ----------------------------------------- -->
                            <div class="col-lg-12 ml-5">
                                <div class="form-check">
                                    <div class="checkbox-group">
                                        <div class="col-12 mb-3">
                                            <input class="form-check-input" type="checkbox" name="self_symptoms[]" required="required" style="width:30px; height:30px;" onclick="ckChange(this)" id="inlineCheckbox1" value="Cough" runat="server">
                                            <label class="form-check-label" for="inlineCheckbox1">ไอ Cough 咳嗽</label>
                                        </div>
                                        <div class="col-12 mb-3">
                                            <input class="form-check-input" type="checkbox" name="self_symptoms[]" required="required" style="width:30px; height:30px;" onclick="ckChange(this)" id="inlineCheckbox2" value="Sore throats" runat="server">
                                            <label class="form-check-label" for="inlineCheckbox2">เจ็บคอ Sore throats 咽喉痛</label>
                                        </div>
                                        <div class="col-12 mb-3">
                                            <input class="form-check-input" type="checkbox" name="self_symptoms[]" required="required" style="width:30px; height:30px;" onclick="ckChange(this)" id="inlineCheckbox3" value="Runny nose" runat="server">
                                            <label class="form-check-label" for="inlineCheckbox3">น้ํามูกไหล Runny nose 流鼻涕</label>
                                        </div>
                                        <div class="col-12 mb-3">
                                            <input class="form-check-input" type="checkbox" name="self_symptoms[]" required="required" style="width:30px; height:30px;" onclick="ckChange(this)" id="inlineCheckbox4" value="Shortness of breath" runat="server">
                                            <label class="form-check-label" for="inlineCheckbox4">เหนื่อยหอบ Shortness of breath 胸闷气短</label>
                                        </div>
                                        <div class="col-12 mb-3">
                                            <input class="form-check-input" type="checkbox" name="self_symptoms[]" required="required" style="width:30px; height:30px;" onclick="ckChange(this)" id="inlineCheckbox6" value="Do not know smell" runat="server">
                                            <label class="form-check-label" for="inlineCheckbox4">ไม่ได้กลิ่น Don't know smell 不知道气味</label>
                                        </div>
                                        <div class="col-12 mb-3">
                                            <input class="form-check-input" type="checkbox" name="self_symptoms[]" required="required" style="width:30px; height:30px;" onclick="ckChange(this)" id="inlineCheckbox5" value="No" runat="server">
                                            <label class="form-check-label" for="inlineCheckbox5">ไม่มีอาการเหล่านี้ None of these symtoms. 沒有</label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <script>
                                function ckChange(ckType) {
                                    var ckName = document.getElementsByName(ckType.name);
                                    var c1 = document.getElementById("<%= inlineCheckbox1.ClientID %>");
                                    var c2 = document.getElementById("<%= inlineCheckbox2.ClientID %>");
                                    var c3 = document.getElementById("<%= inlineCheckbox3.ClientID %>");
                                    var c4 = document.getElementById("<%= inlineCheckbox4.ClientID %>");
                                    var c6 = document.getElementById("<%= inlineCheckbox6.ClientID %>");

                                    var c5 = document.getElementById("<%= inlineCheckbox5.ClientID %>");

                                    if (c1.checked || c2.checked || c3.checked || c4.checked || c6.checked || c5.checked) {
                                        c1.removeAttribute("required");
                                        c2.removeAttribute("required");
                                        c3.removeAttribute("required");
                                        c4.removeAttribute("required");
                                        c6.removeAttribute("required");
                                        c5.removeAttribute("required");
                                    } else {
                                        c1.setAttribute("required", "required");
                                        c2.setAttribute("required", "required");
                                        c3.setAttribute("required", "required");
                                        c4.setAttribute("required", "required");
                                        c6.setAttribute("required", "required");
                                        c5.setAttribute("required", "required");
                                    }

                                    if (c5.checked) {
                                        c5.disabled = false;
                                        c1.disabled = true; c2.disabled = true; c3.disabled = true; c4.disabled = true; c6.disabled = true;
                                        c1.checked = false; c2.checked = false; c3.checked = false; c4.checked = false; c6.checked = false;
                                    } else {
                                        c1.disabled = false; c2.disabled = false; c3.disabled = false; c4.disabled = false; c6.disabled = false;
                                        if (c1.checked || c2.checked || c3.checked || c4.checked || c6.checked) {
                                            c5.disabled = true;
                                            c5.checked = false;
                                        } else {
                                            c5.disabled = false;
                                        }
                                    }
                                }

                                var c1 = document.getElementById("<%= inlineCheckbox1.ClientID %>");
                                var c2 = document.getElementById("<%= inlineCheckbox2.ClientID %>");
                                var c3 = document.getElementById("<%= inlineCheckbox3.ClientID %>");
                                var c4 = document.getElementById("<%= inlineCheckbox4.ClientID %>");
                                var c6 = document.getElementById("<%= inlineCheckbox6.ClientID %>");
                                var c5 = document.getElementById("<%= inlineCheckbox5.ClientID %>");

                                if (c5.checked) {
                                    c1.disabled = true; c2.disabled = true; c3.disabled = true; c4.disabled = true; c6.disabled = true;
                                    c5.disabled = false;
                                } else {
                                    if (c1.checked || c2.checked || c3.checked || c4.checked || c6.checked) {
                                        c1.disabled = false; c2.disabled = false; c3.disabled = false; c4.disabled = false; c6.disabled = false;
                                        c5.disabled = true;
                                    }
                                }

                                if (c1.checked || c2.checked || c3.checked || c4.checked || c6.checked || c5.checked) {
                                    c1.removeAttribute("required");
                                    c2.removeAttribute("required");
                                    c3.removeAttribute("required");
                                    c4.removeAttribute("required");
                                    c6.removeAttribute("required");
                                    c5.removeAttribute("required");
                                }

                            </script>
                            <!-- ----------------------------------------- -->
                        </div>
                    </li>
                    

                    <li class="media" hidden="hidden">
                        <div class="circle-icon mr-4">3</div>
                        <div class="media-body col-12">
                            <h2>ท่านมีประวัติเดินทางมาจากประเทศ</h2>
                            <p>จีน ฮ่องกง มาเก๊า เกาหลีใต้ อิตาลี อิหร่าน ออสเตรีย เบลเยียม มาเลเซีย แคนาดา โปรตุเกส บราซิล เช็คเกีย อิสราเอล ออสเตรเลีย อังกฤษ เกาะไอร์แลนด์ ปากีสถาน ฟินแลนด์ ตุรกี กรีซ ชิลี ลักเซมเบิร์ก โปแลนด์ เอกวาดอร์ สวิสเซอร์แลนด์  ฝรั่งเศส สเปน อเมริกา นอร์เวย์ เดนมาร์ก เนเธอร์แลนด์ สวีเดน เยอรมนี ญี่ปุ่น หรือในพื้นที่ที่มีการระบาดของไวรัสโคโรน่า สายพันธุ์ใหม่ 2019ในช่วงเวลา 14 วัน ก่อนเริ่มป่วย ใช่หรือไม่ ?</p>
                            <p>Have you traveled to China, Hongkong, Macao, Republic of Korea, Italy, Iran, Austria, Belgium, Malaysia, Canada, Portugal, Brazil, Czech Republic, Israel, Australia, England, Ireland, Pakistan, Finland, Turkey, Greece, Chile, Luxembourg, Poland, Ecuador, Switzerland, France, Spain, United States of America, Norway, Denmark, The Netherlands, Sweden, Germany, Japan, or to an area that has the corona-virus (COVID-19) outbreak in the past 14 days before starting to have the symptoms?</p>
                            <p>发病前14天如果您从中国、香港、澳门、韩国、意大利、伊朗、奥地利、比利时、马来西亚、加拿大、葡萄牙、巴西、捷克共和国、以色列、澳大利亚、英国、爱尔兰、巴基斯坦、芬兰、土耳其、希腊、智利、卢森堡、波兰、厄瓜多尔、瑞士、法国、西班牙、利坚合众国、挪威、丹麦、荷兰、瑞典、德国、日本回来，或有关冠状病毒持续传染地区？</p>
                            <!-- ----------------------------------------- -->
                            <div class="col-12 ml-5">
                                <div class="form-check mb-3">
                                    <input class="form-check-input" type="radio" name="RCountry" id="Country1" value="Yes" style="width:30px; height:30px;" onclick="ShowCountry()" runat="server">
                                    <label class="form-check-label h2" for="City1">
                                        ใช่ Yes 是
                                    </label>
                                </div>
                                <div class="form-group container mb-3 h2" id="Country" hidden="hidden">
                                    จากประเทศ (From Country) 你来自这个地方
                                    <br />
                                    <div class="col-8">
                                        <!-- DropDownList Country -->
                                        <asp:DropDownList ID="DD_Country" CssClass="btn btn-outline-danger" Font-Size="25px" runat="server">
                                            <asp:ListItem Text="" Value=""></asp:ListItem>
                                        </asp:DropDownList>
                                        <!-- DropDownList Country -->
                                    </div>
                                    <div class="container mt-3">
                                        <input type="text" id="txt_country_other" value="" class="form-control" style="font-size:25px" placeholder="อื่นๆ (Other) 其他" runat="server">
                                    </div>
                                </div>

                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="RCountry" id="Country0" onclick="HideCountry()" value="No" style="width:30px; height:30px;" runat="server">
                                    <label class="form-check-label h2" for="City0">
                                        ไม่ใช่ No. 否
                                    </label>
                                </div>
                                <script>
                                    function ShowCountry() {
                                        var d = document.getElementById("Country");
                                        var x = document.getElementById("<%= Country1.ClientID %>");
                                        if (x.checked == true) {
                                            d.hidden = "";
                                        } else {
                                            d.hidden = "hidden";
                                        }
                                    }
                                    function HideCountry() {
                                        var d = document.getElementById("Country");
                                        var x = document.getElementById("<%= Country0.ClientID %>");
                                        if (x.checked == true) {
                                            d.hidden = "hidden";
                                        } else {
                                            d.hidden = "";
                                        }
                                    }

                                    var d = document.getElementById("Country");
                                    var x = document.getElementById("<%= Country1.ClientID %>");
                                    if (x.checked) {
                                        d.hidden = "";
                                    }
                                </script>
                            </div>
                            <!-- ----------------------------------------- -->
                        </div>
                    </li>


                    <li class="media">
                        <%--<div class="circle-icon mr-4">4</div>--%>
                        <div class="circle-icon mr-4">3</div>
                        <div class="media-body col-12 h2">
                            <%--<h2>ในช่วง 14วันที่ผ่านมา ท่านได้เดินทางมาจากต่างจังหวัดหรือไม่</h2>--%>
                            <h2>ในช่วง 14วันที่ผ่านมา ท่านได้เดินทางไปพื้นที่เสี่ยง ตามประกาศจากหน่วยงานราชการ หรือกระทรวงสาธรณสุขหรือไม่</h2>
                            <%--<h5>ท่านมีประวัติเดินทางมาจากจังหวัดเหล่านี้หรือไม่</h5>--%>
                            <%--<p>กรุงเทพมหานคร, อุบลราชธานี, ขอนแก่น, นนทบุรี, สงขลา, นครราชสีมา, สุรินทร์, ระยอง, แพร่, เชียงราย, ประจวบคีรีขันธ์, บุรีรัมย์, พิษณุโลก, ราชบุรี, ลพบุรี, นครสวรรค์, นครปฐม, มุกดาหาร, เพชรบูรณ์, ตาก, ชลบุรี, เชียงใหม่, อุตรดิตถ์</p>--%>
                            <%--<p>Do you have a history of traveling from these provinces</p>--%>
                            <%--<p>In the last 14 days Have you traveled from another province?</p>--%>
                            <p>In the past 14 days, have you been in Covid-19 risk areas as the announcement of government/Ministry of Public Health?</p>
                            <%--<p>您有从这些省旅行的历史吗</p>--%>
                            <p>发病前14天您是否来自或有关冠状病毒持续传播地区？</p>
                            <%--<p>กรุงเทพฯ และปริมณฑล (นครปฐม, นนทบุรี, ปทุมธานี, สมุทรปราการ สมุทรสาคร) หรือในพื้นที่ที่มีการระบาดของไวรัสโคโรน่า สายพันธุ์ใหม่ 2019ในช่วงเวลา 14 วัน ก่อนเริ่มป่วย ใช่หรือไม่ ?</p>
                            <p>Have you traveled to Bangkok, Nakhonpathom, Nonthaburi, Pathum-Thani, Samut Prakan or Samut Sakhon or to an area that has the corona virus (COVID-19) outbreak in the past 14 days before starting to have the symptoms?</p>
                            <p>发病前14天您是否从曼谷与四郊（包括 佛统府、暖武里府、巴吞他尼府、北揽府、龙仔厝府）(伦披尼、叻喃隆拳场) (通洛酒吧街道) 回来？</p>--%>
                            <!-- ----------------------------------------- -->
                            <div class="col-12 ml-5">
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="RCity" required="" id="City1" value="1" style="width:30px; height:30px;" onclick="ShowCity()" runat="server">
                                    <%--<input class="form-check-input" type="radio" name="RCity" required="" id="City1" value="1" style="width:30px; height:30px;" runat="server">--%>
                                    <label class="form-check-label" for="City1">
                                        ใช่ Yes 是
                                    </label>
                                </div>
                                <div class="form-group" id="City" hidden="hidden">
                                    จากจังหวัด (From Province) 你来自这个地方
                                    <br />
                                    <div class="container">
                                        
                                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                            <ContentTemplate>

                                                <div class="row col-12 mx-auto">
                                                    <div class="col-12 mx-auto">
                                                        <!-- DropDownList AutoPostBack Province -->
                                                        <asp:DropDownList ID="DD_Province" CssClass="btn btn-outline-secondary" Font-Size="20px" OnSelectedIndexChanged="DD_Province_SelectedIndexChanged" AutoPostBack="true" runat="server">
                                                            <asp:ListItem Text="" Value=""></asp:ListItem>
                                                        </asp:DropDownList>
                                                        <!-- DropDownList AutoPostBack Province -->
                                                    </div>
                                                    <div class="col-12 mx-auto">
                                                        <!-- Risk Area -->
                                                        <asp:DropDownList ID="DD_RiskArea" CssClass="btn btn-outline-danger" Font-Size="20px" runat="server"></asp:DropDownList>
                                                        <!-- Risk Area -->
                                                    </div>
                                                </div>
                                                
                                                <div id="divLoRisk" class="col-12 mb-2 my-2" runat="server" visible="false">
                                                    <h4>ท่านได้ไปพื้นที่เสี่ยงที่แสดงด้านล่างหรือไม่</h4>
                                                    <p>Have you gone to the risk area shown below?</p>
                                                    <p>您是否已前往以下所示的危险区域？</p>
                                                    <div class="form-check">
                                                        <input class="form-check-input" type="radio" name="LoRisk" id="RDLoRisk1" value="Yes" runat="server">
                                                        <label class="form-check-label" for="RDLoRisk1">
                                                            เคยไป (Been to) 去过
                                                        </label>
                                                    </div>
                                                    <div class="form-check">
                                                        <input class="form-check-input" type="radio" name="LoRisk" id="RDLoRisk0" value="No" runat="server">
                                                        <label class="form-check-label" for="RDLoRisk0">
                                                            ไม่เคยไป (Never been) 没去过
                                                        </label>
                                                    </div>
                                                    <script>
                                                        var Lo1 = document.getElementById("<%= RDLoRisk0.ClientID %>");
                                                        var Lo0 = document.getElementById("<%= RDLoRisk0.ClientID %>");
                                                        if (Lo1.checked || Lo0.checked) {
                                                        } else {
                                                            Lo0.setAttribute("checked", "checked");
                                                        }
                                                    </script>
                                                </div>

                                                <div class="col-12">
                                                    <img id="imglo1" src="images/location/location_01.JPG" runat="server" visible="false" />
                                                    <img id="imglo2" src="images/location/location_02.JPG" runat="server" visible="false" />
                                                    <img id="imglo3" src="images/location/location_03.PNG" runat="server" visible="false" />
                                                    <img id="imglo4" src="images/location/location_04.PNG" runat="server" visible="false" />
                                                    <img id="imglo5" src="images/location/location_05.PNG" runat="server" visible="false" />
                                                    <img id="imglo6" src="images/location/location_06.PNG" runat="server" visible="false" />
                                                    <img id="imglo7" src="images/location/location_07.PNG" runat="server" visible="false" />
                                                    <img id="imglo8" src="images/location/location_08.PNG" runat="server" visible="false" />
                                                    <img id="imglo9" src="images/location/location_09.PNG" runat="server" visible="false" />
                                                    <img id="imglo10" src="images/location/location_10.PNG" runat="server" visible="false" />
                                                    <img id="imglo11" src="images/location/location_11.PNG" runat="server" visible="false" />
                                                    <img id="imglo12" src="images/location/location_12.PNG" runat="server" visible="false" />
                                                    <img id="imglo13" src="images/location/location_13.PNG" runat="server" visible="false" />
                                                    <img id="imglo14" src="images/location/location_14.PNG" runat="server" visible="false" />
                                                    <img id="imglo15" src="images/location/location_15.PNG" runat="server" visible="false" />
                                                    <img id="imglo16" src="images/location/location_16.PNG" runat="server" visible="false" />
                                                    <img id="imglo17" src="images/location/location_17.PNG" runat="server" visible="false" />
                                                    <img id="imglo18" src="images/location/location_18.PNG" runat="server" visible="false" />
                                                    <img id="imglo19" src="images/location/location_19.PNG" runat="server" visible="false" />
                                                    <img id="imglo20" src="images/location/location_20.PNG" runat="server" visible="false" />
                                                    <img id="imglo21" src="images/location/location_21.PNG" runat="server" visible="false" />
                                                    <img id="imglo22" src="images/location/location_22.PNG" runat="server" visible="false" />
                                                    <img id="imglo23" src="images/location/location_23.PNG" runat="server" visible="false" />
                                                </div>

                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="DD_Province" EventName="selectedindexchanged" />
                                            </Triggers>
                                        </asp:UpdatePanel>
                                        
                                    </div>
                                    <br />
                                    <div class="container" hidden="hidden">
                                        <input type="text" id="txt_province_other" value="" placeholder="อื่นๆ (Other) 其他" class="form-control" runat="server">
                                    </div>
                                </div>

                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="RCity" id="City0" onclick="HideCity()" value="0" style="width:30px; height:30px;" runat="server">
                                    <label class="form-check-label" for="City0">
                                        ไม่ใช่ No. 否
                                    </label>
                                </div>
                                <script>
                                    function ShowCity() {
                                        var d = document.getElementById("City");
                                        var x = document.getElementById("<%= City1.ClientID %>");
                                        if (x.checked == true) {
                                            d.hidden = "";
                                        } else {
                                            d.hidden = "hidden";
                                        }
                                    }
                                    function HideCity() {
                                        var d = document.getElementById("City");
                                        var x = document.getElementById("<%= City0.ClientID %>");
                                        if (x.checked == true) {
                                            d.hidden = "hidden";
                                        } else {
                                            d.hidden = "";
                                        }
                                    }

                                    var d = document.getElementById("City");
                                    var x = document.getElementById("<%= City1.ClientID %>");
                                    if (x.checked) {
                                        d.hidden = "";
                                    }

                                </script>
                            </div>
                            <!-- ----------------------------------------- -->
                        </div>
                    </li>


                    <li class="media">
                        <%--<div class="circle-icon mr-4">5</div>--%>
                        <div class="circle-icon mr-4">4</div>
                        <div class="media-body h2">
                            <%--<h2>ท่านมีประวัติสัมผัสใกล้ชิดกับผู้ป่วยที่ต้องสงสัยการติดเชื้อโรคไวรัสโคโรนาสายพันธุ์ใหม่
                            2019 หรือมีอาชีพที่มีโอกาสสัมผัสนักท่องเที่ยวต่างชาติ หรือไม่?</h2>--%>
                            <h2>ท่านมีประวัติสัมผัสผู้ป่วยที่ยืนยันการติดเชื้อโรคไวรัสโคโรนาสายพันธุ์ใหม่ 2019  หรือไม่</h2>
                            <%--<p>Do you have contacted with suspected or have career opportunities with foreign tourists?</p>--%>
                            <p>Have you had contacted with any confirmed cases of Coronavirus (Covid-19)?</p>
                            <p>您是否亲密接触过疑似新型冠状病毒的患者或者您的职业有机会接触到外国游客？</p>
                            <!-- ----------------------------------------- -->
                            <div class="col-12 ml-5 mt-2">
                                <div class="form-check">
                                    <%--<input class="form-check-input" type="radio" name="self_contacted_virus" id="Touch1" value="Yes" style="width:30px; height:30px;" onclick="ShowTouch()" runat="server">--%>
                                    <input class="form-check-input" type="radio" name="self_contacted_virus" id="Touch1" value="Yes" style="width:30px; height:30px;" runat="server">
                                    <label class="form-check-label" for="Touch1">
                                        ใช่ Yes. 是
                                    </label>
                                </div>
                            </div>
                            <div class="col-8 text-right" id="Touch" hidden="hidden">
                                <select class="form-control text-right" style="font-size:20px" id="self_TouchDetail" name="self_contacted_virus_detail" runat="server">
                                    <option value="contacted with suspected">สัมผัสผู้ป่วย (contacted with suspected) 接触病人</option>
                                    <option value="career opportunities with foreign tourists">ประกอบอาชีพ (career opportunities with foreign tourists) 外国游客的职业机会</option>
                                </select>
                            </div>
                            <div class="col-12 ml-5 mt-2 ">
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="self_contacted_virus" id="Touch0" value="No" style="width:30px; height:30px;" onclick="HideTouch()" runat="server">
                                    <label class="form-check-label" for="Touch0">
                                        ไม่ใช่ No. 否
                                    </label>
                                </div>
                            </div>
                            <script>
                                function ShowTouch() {
                                    var d = document.getElementById("Touch");
                                    var x = document.getElementById("<%= Touch1.ClientID %>");
                                    if (x.checked == true) {
                                        d.hidden = "";
                                    } else {
                                        d.hidden = "hidden";
                                    }
                                }
                                function HideTouch() {
                                    var d = document.getElementById("Touch");
                                    var x = document.getElementById("<%= Touch0.ClientID %>");
                                    if (x.checked == true) {
                                        d.hidden = "hidden";
                                    } else {
                                        d.hidden = "";
                                    }
                                }

                                var x = document.getElementById("<%= Touch1.ClientID %>");
                                var d = document.getElementById("Touch");
                                if (x.checked) {
                                    d.hidden = "";
                                }

                            </script>
                            <!-- ----------------------------------------- -->
                        </div>
                    </li>

                </ul>

            </div>

        </div>

    </div>

    <div class="container text-center" onmouseover="CheckAge()">
        <asp:Button ID="btn_submit" cssclass="btn btn-primary" Text="SUBMIT" Font-Size="30px" runat="server" OnClick="btn_submit_Click" />
        <%--<a href="#" id="a_modal" data-toggle="modal" data-target="" class="btn btn-primary" onclick="CheckResult()" onserverclick="btn_submit_Click" runat="server">SUBMIT</a>--%>
    </div>


    <script>
        function CheckAge() {
            var age = document.getElementById("<%= txtH_age.ClientID %>");
            if (age.value == '1') {
                alert('คุณแน่ใจว่าอายุ 1 ขวบ ?');
                age.value = 'yes';
            }
        }
    </script>

    <asp:Label ID="lbl_modal" Text="" runat="server"></asp:Label>

<!-- ======================================================================================================= -->

</asp:Content>
