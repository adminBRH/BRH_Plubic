<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="BRH_Plubic.MorChana.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentDesktop" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<asp:ScriptManager ID="ScriptManager_Master" runat="server"></asp:ScriptManager>

<style type="text/css">
    input[type=radio] {
        border: 0px;
        width: 2em;
        height: 2em;
    }
    .btnColor {
        height: 80px;
        border-radius: 10px;
        opacity: 0.3;
    }
    .btnColorSelect {
        height: 80px;
        border-radius: 10px;
        box-shadow: 5px 5px 5px #808080;
        opacity: 1;
    }
    .btnGender {
        opacity: 0.3;
    }
    .btnGenderSelect {
        opacity: 1;
    }
</style>
    <div class="col-12 mx-auto" style="position: absolute; top: 30%">
        <asp:UpdatePanel ID="UpdatePanel_Color" runat="server">
            <ContentTemplate>
                <div class="row col-lg-8 col-sm-12 mx-auto">
                    <div class="col-12 mx-auto">
                        <div class="row col-12 mx-auto">
                            <div class="col-12 mx-auto text-center">
                                <asp:Label ID="lbl_name" Text="" runat="server" Font-Size="XX-Large"></asp:Label>
                                <asp:Label ID="lbl_ip" Text="" runat="server"></asp:Label>
                            </div>
                            <div class="col-12 mx-auto">
                                <span style="font-size: xx-large;">เลือกสี</span> <span style="font-size: large;"> (ตามที่ใน App หมอชนะแจ้งเตือน)</span>
                            </div>
                            <a id="btn_green" onclick="fn_btncolor('green')" class="col-3 mx-auto text-center btnColor" style="background-color: green;"></a>
                            <a id="btn_yellow" onclick="fn_btncolor('yellow')" class="col-3 mx-auto text-center btnColor" style="background-color: yellow;"></a>
                            <a id="btn_orange" onclick="fn_btncolor('orange')" class="col-3 mx-auto text-center btnColor" style="background-color: orange;"></a>
                            <a id="btn_red" onclick="fn_btncolor('red')" class="col-3 mx-auto text-center btnColor" style="background-color: red;"></a>
                            <div class="col-12 mx-auto" hidden="hidden">
                                <input type="text" id="txtH_color" value="" runat="server" />
                            </div>
                        </div>
                    </div>
                    <div class="col-12 mx-auto my-3 text-center">
                        <span class="col-12" style="font-size: xx-large;">แนบรูปภาพ</span>
                        <asp:FileUpload ID="FileUpload1" CssClass="btn btn-outline-info" AllowMultiple="false" runat="server" />
                        (ภาพ Capture หน้าจอ App หมอชนะ)
                    </div>
                    <div class="row col-12 mx-auto my-3 text-center">
                        <div class="col-4 mx-auto text-right" onclick="fn_btngender('male')"><img src="image/male.png" id="btn_male" class="btnGender" style="width: 55px;" /><br /><span style="font-size:x-large;">ชาย</span></div>
                        <div class="col-4 mx-auto my-auto text-center">
                            <span class="col-12" style="font-size: xx-large;">เลือกเพศ</span>
                        </div>
                        <div class="col-4 mx-auto text-left" onclick="fn_btngender('female')"><img src="image/female.png" id="btn_female" class="btnGender" style="width: 80px;" /><br /><span style="font-size:x-large;">หญิง</span></div>
                        <div class="col-12 mx-auto" hidden="hidden">
                            <input type="text" id="txtH_gender" value="" runat="server" />
                        </div>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>

        <div class="col-12 mx-auto my-5 text-center">
            <button id="btn_submit" class="col-3 btn btn-outline-primary mx-auto text-center" onmouseup="fn_WaitLoadModal()" onserverclick="btn_submit_ServerClick" runat="server" style="font-size:xx-large">SAVE <i class="ti-save"></i></button>
        </div>
        <p>&nbsp;</p>
        <p>&nbsp;</p>
    </div>
    

<script>
    function fn_btncolor(color) {
        var txtColor = document.getElementById('<%= txtH_color.ClientID %>');
        if (txtColor.value != '') {
            document.getElementById('btn_' + txtColor.value).setAttribute('class','col-3 mx-auto text-center btnColor');
        }
        document.getElementById('btn_' + color).setAttribute('class', 'col-3 mx-auto text-center btnColorSelect');
        txtColor.value = color;
    }
    

    function fn_btngender(sex) {
        var txtGendar = document.getElementById('<%= txtH_gender.ClientID %>');
        if (txtGendar.value != '') {
            document.getElementById('btn_' + txtGendar.value).setAttribute('class', 'btnGender');
        }
        document.getElementById('btn_' + sex).setAttribute('class', 'btnGenderSelect');
        txtGendar.value = sex;
    }
    

    function fn_preview() {
        var txtColor = document.getElementById('<%= txtH_color.ClientID %>');
        if (txtColor.value != '') {
            document.getElementById('btn_' + txtColor.value).setAttribute('class', 'col-3 mx-auto text-center btnColorSelect');
        }
        var txtGendar = document.getElementById('<%= txtH_gender.ClientID %>');
        if (txtGendar.value != '') {
            document.getElementById('btn_' + txtGendar.value).setAttribute('class', 'btnGenderSelect');
        }
    }
</script>

</asp:Content>
