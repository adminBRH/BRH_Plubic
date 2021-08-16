<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PreRegister.aspx.cs" Inherits="BRH_Plubic.PreRegister" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">

    <asp:ScriptManager ID="ScriptManager_Master" runat="server"></asp:ScriptManager>

    <div class="col-12 card card-header text-center bg-gradient h3" style="color:white">
        Pre Register นัดจองวันเวลาพบแพทย์
    </div>

    <div class="col-11 mx-auto my-3">
        <div class="card card-header bg-gradient h4" style="color:white">
            ข้อมูลส่วนบุคคล
        </div>
        <div class="card card-body">
            <div class="row col-12">

                <asp:Table Width="100%" runat="server">
                    <asp:TableRow>
                        <asp:TableCell Width="25%">
                            <div class="btn-light bg-info text-right" style="font-size:large; color:white">Gender</div>
                        </asp:TableCell>
                        <asp:TableCell Width="75%">
                            <asp:DropDownList ID="DD_gender" CssClass="col-4 btn btn-light text-left" runat="server">
                                <asp:ListItem Value="Men" Text="Men ชาย"></asp:ListItem>
                                <asp:ListItem Value="Women" Text="Women หญิง"></asp:ListItem>
                            </asp:DropDownList> 
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>
                            <div class="btn-light bg-info text-right" style="font-size:large; color:white">Name prefix</div>
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:DropDownList ID="DD_pname" CssClass="col-4 btn btn-light text-left" runat="server">
                                <asp:ListItem Value="" Text=""></asp:ListItem>
                            </asp:DropDownList> 
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>
                            <div class="btn-light bg-info text-right" style="font-size:large; color:white">First name</div>
                        </asp:TableCell>
                        <asp:TableCell>
                            <input type="text" id="txt_fname" value="" placeholder="ชื่อ" class="form-control col-10 text-left" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>
                            <div class="btn-light bg-info text-right" style="font-size:large; color:white">Last name</div>
                        </asp:TableCell>
                        <asp:TableCell>
                            <input type="text" id="txt_lname" value="" placeholder="นามสกุล" class="form-control col-10 text-left" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>
                            <div class="btn-light bg-info text-right" style="font-size:large; color:white">Tel number</div>
                        </asp:TableCell>
                        <asp:TableCell>
                            <input type="tel" id="txt_tel" value="" placeholder="เบอร์โทรศัพท์" class="form-control col-10 text-left" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>
                            <div class="btn-light bg-info text-right" style="font-size:large; color:white">Email</div>
                        </asp:TableCell>
                        <asp:TableCell>
                            <input type="tel" id="txt_email" value="" placeholder="อีเมล" class="form-control col-10 text-left" />
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
                
            </div>
        </div>
    </div>

    <div class="col-11 mx-auto my-3">
        <div class="card card-header bg-gradient h4" style="color:white">
            อาการของท่าน
        </div>
        <div class="card card-body">
            <div class="row col-12 mt-3">
                <div class="btn-light bg-info" style="font-size:large; color:white">อาการ</div>
                <asp:DropDownList ID="DD_Illness" CssClass="col-5 btn btn-light text-left" runat="server">
                    <asp:ListItem Text="อาการ 1" Value="1"></asp:ListItem>
                    <asp:ListItem Text="อาการ 2" Value="2"></asp:ListItem>
                    <asp:ListItem Text="อาการ 3" Value="3"></asp:ListItem>
                    <asp:ListItem Text="อาการ 4" Value="4"></asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>
    </div>

    <div class="col-11 mx-auto my-3">
        <div class="card card-header bg-gradient h4" style="color:white">
            วันเวลา นัดหมาย
        </div>
        <div class="card card-body">
            <asp:UpdatePanel ID="UpdatePanel_CLD" runat="server">
                <ContentTemplate>
                    <asp:Calendar ID="CLD_book" CssClass="col-12 mx-auto" Height="500" OnDayRender="CLD_book_DayRender" OnSelectionChanged="CLD_book_SelectionChanged" runat="server">
                        <TitleStyle CssClass="bg-info" Font-Size="X-Large" ForeColor="White" />
                        <NextPrevStyle ForeColor="White" />
                        <DayHeaderStyle CssClass="bg-info" ForeColor="White" />
                        <SelectedDayStyle CssClass="bg-info" />
                        <DayStyle BorderWidth="1" HorizontalAlign="Right" VerticalAlign="Top" Font-Size="XX-Large" />
                    </asp:Calendar>
                    <div>
                        <input type="text" id="txt_date" value="" runat="server" />
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
            <div class="row col-12 mt-3">
                <div class="btn-light bg-info" style="font-size:large; color:white">Choose Time</div>
                <input type="time" id="time_book" class="btn btn-light col-2 text-left" value="" runat="server" />
            </div>
        </div>
    </div>

</asp:Content>
