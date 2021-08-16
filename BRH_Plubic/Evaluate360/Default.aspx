<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="BRH_Plubic.Evaluate360.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">

    <asp:ScriptManager ID="ScriptManager_Master" runat="server"></asp:ScriptManager>

<style>
    input[type=radio] {
        border: 0px;
        width: 2em;
        height: 2em;
    }
    .bootRBL input {display:inline;margin-right:0.25em;}
    .bootRBL label {display:inline;margin-right:3em;}
</style>

    <div class="col-11 mx-auto card card-header bg-info h1" style="color:white">
        <div class="row col-12 mx-auto">
            ประเมิน 360 องศา (ปี<asp:Label ID="lbl_year" Text="" runat="server"></asp:Label>)
        </div>
    </div>
    <div id="div_evaluate" class="col-11 mx-auto card card-body" runat="server" visible="false">
        <div class="col-11 mx-auto">
            <div class="card card-header bg-info h3" style="color:white">
                เลือกการประเมิน
            </div>
            <div class="card card-body mb-3">
                <asp:DropDownList ID="DD_mode" CssClass="btn btn-light text-left" OnSelectedIndexChanged="DD_mode_SelectedIndexChanged" AutoPostBack="true" runat="server">
                    <asp:ListItem Text="กรุณาเลือกการประเมิน" Value="" Selected="False"></asp:ListItem>
                    <asp:ListItem Text="สำหรับระดับบริหาร ประเมินระดับบริหาร (ระดับเดียวกัน)" Value="EXECUTIVE LEVEL (same level)"></asp:ListItem>
                    <asp:ListItem Text="สำหรับพนักงาน/ระดับบริหาร ประเมินผู้บังคับบัญชา" Value="EMPLOYEE LEVEL (for chief assessment)"></asp:ListItem>
                    <asp:ListItem Text="สำหรับพนักงาน ประเมินพนักงาน" Value="EMPLOYEE LEVEL"></asp:ListItem>
                </asp:DropDownList>
            </div>
            <asp:UpdatePanel ID="UpdatePanel_dept" runat="server">
                <ContentTemplate>
                    <div id="div_dept" runat="server" visible="false">
                        <div class="card card-header bg-info h3" style="color:white">
                            เลือกแผนก และรายชื่อพนักงาน ที่จะทำการประเมิน
                        </div>
                        <div class="card card-body mb-3">
                            <div class="row col-12 mx-auto">
                                <div class="col-lg-6 col-sm-12 mx-auto mb-sm-3">
                                    เลือกแผนก
                                    <asp:DropDownList ID="DD_Department" CssClass="btn btn-light text-left" OnSelectedIndexChanged="DD_Department_SelectedIndexChanged" AutoPostBack="true" runat="server">
                                        <asp:ListItem Text="" Value=""></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-lg-6 col-sm-12 mx-auto">
                                    <asp:UpdatePanel ID="UpdatePanel_name" runat="server">
                                        <ContentTemplate>
                                            ชื่อผู้ถูกประเมิน
                                            <asp:DropDownList ID="DD_name" CssClass="btn btn-light text-left" OnSelectedIndexChanged="DD_name_SelectedIndexChanged" AutoPostBack="true" runat="server">
                                                <asp:ListItem Text="" Value=""></asp:ListItem>
                                            </asp:DropDownList>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="DD_Department" EventName="selectedindexchanged" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div hidden="hidden">
                        <input type="text" id="txtH_status" value="" runat="server" />
                        <input type="text" id="txtH_mode" value="" runat="server" />
                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="DD_mode" EventName="selectedindexchanged" />
                </Triggers>
            </asp:UpdatePanel>

            <asp:UpdatePanel ID="UpdatePanel_topic" runat="server">
                <ContentTemplate>
                    <%-- ======================================== ข้อ 1 ============================================ --%>
                    <div id="div_1" runat="server" visible="false">
                        <div class="card card-header h5">
                            <asp:Label ID="lbl_1_1" Text="1. เพื่อนร่วมงานของท่านเป็นผู้มีความรับผิดชอบในหน้าที่ เป็นตัวอย่างที่ดี" runat="server" Visible="false"></asp:Label>
                            <asp:Label ID="lbl_2_1" Text="1. หัวหน้างานของท่านเป็นผู้มีความรับผิดชอบในหน้าที่ เป็นตัวอย่างที่ดี" runat="server" Visible="false"></asp:Label>
                        </div>
                        <div class="card card-body mb-3">
                            <div class="row col-12 mx-auto">
                                <asp:RadioButtonList ID="RDB_1" CssClass="form-inline bootRBL" RepeatLayout="Flow" runat="server">
                                    <asp:ListItem Value="1" Text="น้อยที่สุด"></asp:ListItem>
                                    <asp:ListItem Value="2" Text="น้อย"></asp:ListItem>
                                    <asp:ListItem Value="3" Text="ปานกลาง"></asp:ListItem>
                                    <asp:ListItem Value="4" Text="มาก"></asp:ListItem>
                                    <asp:ListItem Value="5" Text="มากที่สุด"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                        </div>
                    </div>
                    <%-- ======================================== ข้อ 2 ============================================ --%>
                    <div id="div_2" runat="server" visible="false">
                        <div class="card card-header h5">
                            <asp:Label ID="lbl_1_2" Text="2 เพื่อนร่วมงานของท่านรับฟังพนักงานในหน่วยงาน เพื่อนำมาพัฒนาและปรับปรุงงาน" runat="server" Visible="false"></asp:Label>
                            <asp:Label ID="lbl_2_2" Text="2 หัวหน้างานของท่านรับฟังพนักงานในหน่วยงาน เพื่อนำมาพัฒนาและปรับปรุงงาน" runat="server" Visible="false"></asp:Label>
                        </div>
                        <div class="card card-body mb-3">
                            <div class="row col-12 mx-auto">
                                <asp:RadioButtonList ID="RDB_2" CssClass="form-inline bootRBL" RepeatLayout="Flow" runat="server">
                                    <asp:ListItem Value="1" Text="น้อยที่สุด"></asp:ListItem>
                                    <asp:ListItem Value="2" Text="น้อย"></asp:ListItem>
                                    <asp:ListItem Value="3" Text="ปานกลาง"></asp:ListItem>
                                    <asp:ListItem Value="4" Text="มาก"></asp:ListItem>
                                    <asp:ListItem Value="5" Text="มากที่สุด"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                        </div>
                    </div>
                    <%-- ======================================== ข้อ 3 ============================================ --%>
                    <div id="div_3" runat="server" visible="false">
                        <div class="card card-header h5">
                            <asp:Label ID="lbl_1_3" Text="3. เพื่อนร่วมงานของท่านช่วยท่านแก้ไขปัญหาหน้างาน ตอบสนองเมื่อท่านมีปัญหา" runat="server" Visible="false"></asp:Label>
                            <asp:Label ID="lbl_2_3" Text="3. หัวหน้างานของท่านช่วยท่านแก้ไขปัญหาหน้างาน ตอบสนองเมื่อท่านมีปัญหา" runat="server" Visible="false"></asp:Label>
                        </div>
                        <div class="card card-body mb-3">
                            <div class="row col-12 mx-auto">
                                <asp:RadioButtonList ID="RDB_3" CssClass="form-inline bootRBL" RepeatLayout="Flow" runat="server">
                                    <asp:ListItem Value="1" Text="น้อยที่สุด"></asp:ListItem>
                                    <asp:ListItem Value="2" Text="น้อย"></asp:ListItem>
                                    <asp:ListItem Value="3" Text="ปานกลาง"></asp:ListItem>
                                    <asp:ListItem Value="4" Text="มาก"></asp:ListItem>
                                    <asp:ListItem Value="5" Text="มากที่สุด"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                        </div>
                    </div>
                    <%-- ======================================== ข้อ 4 ============================================ --%>
                    <div id="div_4" runat="server" visible="false">
                        <div class="card card-header h5">
                            <asp:Label ID="lbl_1_4" Text="4. เพื่อนร่วมงานของท่านให้คำแนะนำที่ดีแก่ท่าน" runat="server" Visible="false"></asp:Label>
                            <asp:Label ID="lbl_2_4" Text="4. หัวหน้างานของท่านให้คำแนะนำที่ดีแก่ท่าน" runat="server" Visible="false"></asp:Label>
                        </div>
                        <div class="card card-body mb-3">
                            <div class="row col-12 mx-auto">
                                <asp:RadioButtonList ID="RDB_4" CssClass="form-inline bootRBL" RepeatLayout="Flow" runat="server">
                                    <asp:ListItem Value="1" Text="น้อยที่สุด"></asp:ListItem>
                                    <asp:ListItem Value="2" Text="น้อย"></asp:ListItem>
                                    <asp:ListItem Value="3" Text="ปานกลาง"></asp:ListItem>
                                    <asp:ListItem Value="4" Text="มาก"></asp:ListItem>
                                    <asp:ListItem Value="5" Text="มากที่สุด"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                        </div>
                    </div>
                    <%-- ======================================== ข้อ 5 ============================================ --%>
                    <div id="div_5" runat="server" visible="false">
                        <div class="card card-header h5">
                            <asp:Label ID="lbl_1_5" Text="5. เพื่อนร่วมงานของท่านเปิดโอกาสให้ท่านได้แสดงความรู้ความสามารถ" runat="server" Visible="false"></asp:Label>
                            <asp:Label ID="lbl_2_5" Text="5. หัวหน้างานของท่านเปิดโอกาสให้ท่านได้แสดงความรู้ความสามารถ" runat="server" Visible="false"></asp:Label>
                        </div>
                        <div class="card card-body mb-3">
                            <div class="row col-12 mx-auto">
                                <asp:RadioButtonList ID="RDB_5" CssClass="form-inline bootRBL" RepeatLayout="Flow" runat="server">
                                    <asp:ListItem Value="1" Text="น้อยที่สุด"></asp:ListItem>
                                    <asp:ListItem Value="2" Text="น้อย"></asp:ListItem>
                                    <asp:ListItem Value="3" Text="ปานกลาง"></asp:ListItem>
                                    <asp:ListItem Value="4" Text="มาก"></asp:ListItem>
                                    <asp:ListItem Value="5" Text="มากที่สุด"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                        </div>
                    </div>
                    <%-- ======================================== ข้อ 6 ============================================ --%>
                    <div id="div_6" runat="server" visible="false">
                        <div class="card card-header h5">
                            <asp:Label ID="lbl_1_6" Text="6. เพื่อนร่วมงานของท่านรับฟังท่านอย่างตั้งใจและเข้าใจในความกังวลของท่าน" runat="server" Visible="false"></asp:Label>
                            <asp:Label ID="lbl_2_6" Text="6. หัวหน้างานของท่านส่งเสริมให้ท่านมีส่วนร่วมกับการพัฒนางานคุณภาพของโรงพยาบาล" runat="server" Visible="false"></asp:Label>
                        </div>
                        <div class="card card-body mb-3">
                            <div class="row col-12 mx-auto">
                                <asp:RadioButtonList ID="RDB_6" CssClass="form-inline bootRBL" RepeatLayout="Flow" runat="server">
                                    <asp:ListItem Value="1" Text="น้อยที่สุด"></asp:ListItem>
                                    <asp:ListItem Value="2" Text="น้อย"></asp:ListItem>
                                    <asp:ListItem Value="3" Text="ปานกลาง"></asp:ListItem>
                                    <asp:ListItem Value="4" Text="มาก"></asp:ListItem>
                                    <asp:ListItem Value="5" Text="มากที่สุด"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                        </div>
                    </div>
                    <%-- ======================================== ข้อ 7 ============================================ --%>
                    <div id="div_7" runat="server" visible="false">
                        <div class="card card-header h5">
                            <asp:Label ID="lbl_1_7" Text="7. เพื่อนร่วมงานของท่านสร้างบรรยากาศในการทำงานเป็นทีม" runat="server" Visible="false"></asp:Label>
                            <asp:Label ID="lbl_2_7" Text="7. หัวหน้างานของท่านสื่อสารในเรื่องต่างๆภายในองค์กร หน่วยงาน เพื่อให้ท่านรับทราบข้อมูลได้อย่างมีประสิทธิภาพ" runat="server" Visible="false"></asp:Label>
                        </div>
                        <div class="card card-body mb-3">
                            <div class="row col-12 mx-auto">
                                <asp:RadioButtonList ID="RDB_7" CssClass="form-inline bootRBL" RepeatLayout="Flow" runat="server">
                                    <asp:ListItem Value="1" Text="น้อยที่สุด"></asp:ListItem>
                                    <asp:ListItem Value="2" Text="น้อย"></asp:ListItem>
                                    <asp:ListItem Value="3" Text="ปานกลาง"></asp:ListItem>
                                    <asp:ListItem Value="4" Text="มาก"></asp:ListItem>
                                    <asp:ListItem Value="5" Text="มากที่สุด"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                        </div>
                    </div>
                    <%-- ======================================== ข้อ 8 ============================================ --%>
                    <div id="div_8" runat="server" visible="false">
                        <div class="card card-header h5">
                            8. หัวหน้างานของท่านรับฟังท่านอย่างตั้งใจและเข้าใจในความกังวลของท่าน
                        </div>
                        <div class="card card-body mb-3">
                            <div class="row col-12 mx-auto">
                                <asp:RadioButtonList ID="RDB_8" CssClass="form-inline bootRBL" RepeatLayout="Flow" runat="server">
                                    <asp:ListItem Value="1" Text="น้อยที่สุด"></asp:ListItem>
                                    <asp:ListItem Value="2" Text="น้อย"></asp:ListItem>
                                    <asp:ListItem Value="3" Text="ปานกลาง"></asp:ListItem>
                                    <asp:ListItem Value="4" Text="มาก"></asp:ListItem>
                                    <asp:ListItem Value="5" Text="มากที่สุด"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                        </div>
                    </div>
                    <%-- ======================================== ข้อ 9 ============================================ --%>
                    <div id="div_9" runat="server" visible="false">
                        <div class="card card-header h5">
                            9. หัวหน้างานของท่านสร้างบรรยากาศ/ส่งเสริมท่าน ในการทำงานเป็นทีม
                        </div>
                        <div class="card card-body mb-3">
                            <div class="row col-12 mx-auto">
                                <asp:RadioButtonList ID="RDB_9" CssClass="form-inline bootRBL" RepeatLayout="Flow" runat="server">
                                    <asp:ListItem Value="1" Text="น้อยที่สุด"></asp:ListItem>
                                    <asp:ListItem Value="2" Text="น้อย"></asp:ListItem>
                                    <asp:ListItem Value="3" Text="ปานกลาง"></asp:ListItem>
                                    <asp:ListItem Value="4" Text="มาก"></asp:ListItem>
                                    <asp:ListItem Value="5" Text="มากที่สุด"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                        </div>
                    </div>
                    <%-- ======================================== ข้อเสนอแนะ ============================================ --%>
                    <div id="div_remark" runat="server" visible="false">
                        <div class="card card-header h5">
                            <asp:Label ID="lbl_1_rm" Text="8. ข้อเสนอแนะ" runat="server" Visible="false"></asp:Label>
                            <asp:Label ID="lbl_2_rm" Text="10. ข้อเสนอแนะ" runat="server" Visible="false"></asp:Label>
                        </div>
                        <div class="card card-body mb-3">
                            <div class="col-10 mx-auto">
                                <textarea id="txt_remark" class="form-control" runat="server"></textarea>
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="DD_name" EventName="selectedindexchanged" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
        <div id="div_submit" class="col-12 mx-auto text-center" runat="server">
            <button id="btn_submit" class="btn btn-outline-primary mx-auto text-center" onserverclick="btn_submit_ServerClick" runat="server">SUBMIT</button>
        </div>
    </div>

    <asp:Label ID="lbl_CallModal" Text="" runat="server"></asp:Label>

</asp:Content>
