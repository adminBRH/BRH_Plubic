<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AnnualCheckup.aspx.cs" Inherits="BRH_Plubic.AnnualCheckup" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">

    <div class="row col-12 container d-flex justify-content-center my-3">

        <div class="col-12 text-center mb-3">
            <h2>ตรวจสุขภาพประจำปี</h2>
            <h3>Annual check up</h3>
        </div>

        <div class="row col-8 container">

            <div class="col-12 mb-3">
                <div class="card features">
                    <div class="card-body">
                        <div class="media">
                            <span class="ti-user gradient-fill ti-2x mr-3"></span>
                            <div class="media-body">
                                <h4 class="card-title">รหัสพนักงาน</h4>
                                <div class="row col-12 input-group">
                                    <input type="text" id="txt_empid" class="col-8 form-control" value="" required="required" runat="server" />
                                    <asp:Button ID="btn_emp" CssClass="col-4 btn btn-outline-warning" Text="ตรวจสอบ" OnClick="btn_emp_ServerClick" runat="server" />
                                    <div id="divAlert" class="col-12 text-center my-3" runat="server" visible="false">
                                        <asp:Label ID="lbl_alert" CssClass="text-danger" Text="" runat="server"></asp:Label>
                                    </div>
                                    <div id="divCancel" class="col-12 text-center my-3" runat="server" visible="false">
                                        <asp:Button ID="btn_cancel" CssClass="btn btn-outline-danger" Text="ยกเลิกการจองนี้" OnClientClick="ConfirmCancel()" OnClick="btn_cancel_Click" runat="server" />
                                        <div hidden="hidden">
                                            <input type="text" id="txt_cancel" value="" runat="server" />
                                            <input type="text" id="txt_bookid" value="" runat="server" />
                                        </div>
                                        <script>
                                            function ConfirmCancel() {
                                                var cf = confirm("คุณต้องการยกเลิกการจอง ในวันดังกล่าวใช่หรือไม่ ?");
                                                if (cf) {
                                                    var t = document.getElementById("<%= txt_cancel.ClientID %>");
                                                    t.setAttribute("value", "true")

                                                    var pm = prompt("กรอกเลขที่การจองของท่าน ?");
                                                    if (pm != null) {
                                                        var p = document.getElementById("<%= txt_bookid.ClientID %>");
                                                        p.setAttribute("value", pm)
                                                    }
                                                }
                                            }
                                        </script>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


            <div id="divhide" class="col-12" runat="server" visible="false">

                <div class="col-12 mb-3">
                    <div class="card features">
                        <div class="card-body">
                            <div class="media">
                                <span class="ti-anchor gradient-fill ti-3x mr-3"></span>
                                <div class="media-body">
                                    <h4 class="card-title">เพศ</h4>
                                    <div class="form-check container">
                                        <input class="form-check-input" type="radio" id="RD_SexM" name="RDsex" value="ชาย" disabled="disabled" onclick="" runat="server">
                                        <label class="form-check-label" for="RD_SexM">
                                            ชาย
                                        </label>
                                    </div>
                                    <div class="form-check container">
                                        <input class="form-check-input" type="radio" id="RD_SexF" name="RDsex" value="หญิง" disabled="disabled" onclick="" runat="server">
                                        <label class="form-check-label" for="RD_SexF">
                                            หญิง
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-12 mb-3">
                    <div class="card features">
                        <div class="card-body">
                            <div class="media">
                                <span class="ti-id-badge gradient-fill ti-3x mr-3"></span>
                                <div class="media-body">
                                    <h4 class="card-title">ชื่อ - นามสกุล</h4>
                                    <div class="row col-12">
                                        <div class="col-3 text-right">
                                            <label for="txt_empid">คำนำหน้า</label>
                                        </div>
                                        <div class="col-8">
                                            <input type="text" id="txt_pname" class="form-control col-6" value="" disabled="disabled" required="required" runat="server" />
                                        </div>
                                        <div class="col-3 text-right">
                                            <label for="txt_fname">ชื่อ</label>
                                        </div>
                                        <div class="col-8">
                                            <input type="text" id="txt_fname" class="form-control" value="" disabled="disabled" required="required" runat="server" />
                                        </div>
                                        <div class="col-3 text-right">
                                            <label for="txt_lname">นามสกุล</label>
                                        </div>
                                        <div class="col-8">
                                            <input type="text" id="txt_lname" class="form-control" value="" disabled="disabled" required="required" runat="server" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-12 mb-3">
                    <div class="card features">
                        <div class="card-body">
                            <div class="media">
                                <span class="ti-direction-alt gradient-fill ti-2x mr-3"></span>
                                <div class="media-body">
                                    <h4 class="card-title">แผนก</h4>
                                    <input type="text" id="txt_deptdesc" class="form-control col-8" value="" disabled="disabled" required="required" runat="server" />
                                    <input type="text" id="txt_dept" value="" runat="server" visible="false" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>


            <div class="col-12 mb-3 my-3">
                <div class="card features">
                    <div class="card-body">
                        <div class="media">
                            <span class="ti-calendar gradient-fill ti-3x mr-3"></span>
                            <div class="media-body">
                                <h4 class="card-title">เลือกวันที่ เข้ารับการตรวจสุขภาพประจำปี</h4>
                                <div class="col-12 text-center">
                                    <asp:DropDownList ID="DD_Quota" CssClass="btn btn-primary col-6 mx-auto" runat="server">
                                        <asp:ListItem Text="" Value=""></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="container text-center">
                <asp:Button ID="btn_submit" cssclass="btn btn-primary" Text="SUBMIT" runat="server" OnClick="btn_submit_Click" Visible="false" />
            </div>

        </div>

    </div>

</asp:Content>
