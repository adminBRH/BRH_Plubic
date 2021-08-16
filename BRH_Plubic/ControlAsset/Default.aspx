<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="BRH_Plubic.ControlAsset.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentDesktop" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="card col-10 mx-auto" style="position: absolute; top: 40%; left: 0; right: 0; background-color:burlywood; border-radius: 20px;">
        <div class="row col-12 mx-auto my-3">
            <div class="col-12 mx-auto mb-3 h3 text-center">
                ตรวจสอบข้อมูล Desktop & Laptop
            </div>
            <div class="col-12 mx-auto my-auto" style="font-size: x-large;">
                แผนกหรือหน่วยงานของคุณ
                <asp:DropDownList ID="DD_dept" CssClass="btn btn-info" runat="server">
                    <asp:ListItem Text="" Value=""></asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="col-lg-11 col-sm-12 mx-auto my-auto text-right">
                <input type="text" id="txt_SN" value="" class="form-control" placeholder="Service Tag" runat="server" />
            </div>
            <div class="col-lg-1 col-sm-12 mx-auto my-auto text-center">
                <button id="btn_check" class="btn btn-outline-primary" onserverclick="btn_check_ServerClick" runat="server"><i class="ti-2x ti-search"></i></button>
            </div>
        </div>
        <div class="col-12 mx-auto my-auto">
            <a data-toggle="modal" data-target="#modalExsample" style="font-size: large; cursor: pointer; color:blue;">ดูตัวอย่าง Service Tag หรือ SN</a>
        </div>
    </div>

<div class="modal fade" id="modalExsample" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-xl" role="document" style="position: absolute; top: 20%; left:0; right:0;">
        <div class="modal-content" style="background-color:antiquewhite; border-radius: 20px;">
            <div class="modal-body">
                <div class="row col-12 mx-auto" style="font-size: x-large;">
                    <div class="col-lg-6 col-sm-12 mx-auto my-sm-3 text-center">
                        Desktop
                        <br />
                        <img src="image/SN-Desktop.jpg" style="width: 300px; height: 300px;" />
                    </div>
                    <div class="col-lg-6 col-sm-12 mx-auto my-sm-3 text-center">
                        Labtop
                        <br />
                        <img src="image/SN-Labtop.jpg" style="width: 300px; height: 300px;" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modal Asset -->
<div class="modal fade" id="modalAsset" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-xl" role="document" style="position: absolute; top: 30%; left:0; right:0;">
        <div class="modal-content" style="background-color:white;">
            <div class="modal-header h3">
                Control Asset.
            </div>
            <div class="modal-body">
                <asp:Label ID="lbl_asset" Text="" Font-Size="X-Large" runat="server"></asp:Label>
                <div class="row col-12 mx-auto mt-3" style="font-size: x-large">
                    <div class="col-4 mx-auto my-auto text-center">
                        ต้องการที่จะ
                    </div>
                    <div class="row col-8 mx-auto my-auto">
                        <div class="col-12 mx-auto my-auto">
                            <label class="switch">
                                <input type="checkbox" name="CB_ct" id="CB_ct_check" value="checked" checked onclick="fn_action('check')" runat="server" />
                                <span class="slider round"></span>
                            </label>
                            ตรวจสอบทรัพย์สิน
                        </div>
                        <div class="col-12 mx-auto my-auto">
                            <label class="switch">
                                <input type="checkbox" name="CB_ct" id="CB_ct_return" value="return" onclick="fn_action('return')" runat="server" />
                                <span class="slider round"></span>
                            </label>
                            ทำคืนทรัพย์สิน
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <div class="row col-12 mx-auto" style="font-size: x-large;">
                    <div class="col-6 mx-auto text-center">
                        <a class="btn btn-outline-danger" data-dismiss="modal">Close</a>
                    </div>
                    <div class="col-6 mx-auto text-center">
                        <button id="btn_submit" class="btn btn-outline-primary" data-dismiss="modal" runat="server" onserverclick="btn_submit_ServerClick">Confirm <i class="ti-save"></i></button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function fn_action(val) {
        var CBcheck = document.getElementById('<%= CB_ct_check.ClientID %>');
        var CBreturn = document.getElementById('<%= CB_ct_return.ClientID %>');
        if (val == 'check') {
            CBcheck.checked = true;
            CBreturn.checked = false;
        } else if (val == 'return') {
            CBcheck.checked = false
            CBreturn.checked = true;
        } else {
            CBcheck.checked = false
            CBreturn.checked = false;
        }
    }
</script>

<asp:Label ID="lbl_script" Text="" runat="server"></asp:Label>

</asp:Content>
