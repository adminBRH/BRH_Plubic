<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="BRH_Plubic.DentalBook.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">

    <asp:ScriptManager ID="ScriptManager_Master" runat="server"></asp:ScriptManager>

    <div class="col-lg-8 col-sm-11 mx-auto">
        <asp:UpdatePanel ID="UpdatePanel_input" runat="server">
            <ContentTemplate>
                <div class="row col-12" style="background-image: url(images/DentalBooking.png); background-position-x:center; background-size:contain; background-repeat:no-repeat">
                    <div class="col-12 my-5">&nbsp;</div>
                    <div class="col-lg-6 col-sm-12 mx-auto text-center mt-3">
                        <div class="col-12 mt-5">&nbsp;</div>
                        <asp:Calendar ID="Calendar1" CssClass="col-12 mx-auto text-center" OnSelectionChanged="Calendar1_SelectionChanged" OnDayRender="Calendar1_DayRender" runat="server" BackColor="White" BorderColor="White" BorderWidth="1px" Font-Names="Verdana" Font-Size="14pt" ForeColor="Black" NextPrevFormat="FullMonth" Width="80%">
                            <DayHeaderStyle Font-Bold="True" Font-Size="8pt"></DayHeaderStyle>
                            <NextPrevStyle VerticalAlign="Bottom" Font-Bold="True" Font-Size="10pt" ForeColor="#333333"></NextPrevStyle>
                            <OtherMonthDayStyle ForeColor="#999999"></OtherMonthDayStyle>
                            <SelectedDayStyle BackColor="#333399" ForeColor="White"></SelectedDayStyle>
                            <TitleStyle BackColor="White" BorderColor="Black" BorderWidth="1px" Font-Bold="True" Font-Size="12pt" ForeColor="#333399"></TitleStyle>
                            <TodayDayStyle BackColor="#CCCCCC"></TodayDayStyle>
                        </asp:Calendar>
                    </div>
                    <div class="col-lg-6 col-sm-12 mx-auto text-center mt-5">
                        <div class="col-lg-12 col-sm-8 mx-auto text-center">
                            <div class="row col-12 text-left">
                                <div class="col-6">
                                    <img id="Dentist1_3" src="images/Dentist.png" width="60" runat="server" />
                                    <img id="Dentist1_2" src="images/Dentist.png" width="60"  runat="server"  />
                                    <img id="Dentist1_1" src="images/Dentist.png" width="60"  runat="server"  />
                                </div>
                                <div class="col-2">&nbsp;</div>
                                <div class="col-2">&nbsp;</div>
                                <div class="col-2">&nbsp;</div>
                            </div>
                            <div hidden="hidden">
                                <input type="text" id="txtH_time1" value="" runat="server" />
                            </div>
                            <div class="row col-12 btn btn-light text-left" style="font-size:x-large">
                                <label class="switch">
                                    <input type="checkbox" id="CB_Time1" value="14:00:00" onclick="CheckTime('1')" runat="server" />
                                    <span class="slider round"></span>
                                </label> 14:00 น. - 15:00 น.
                            </div>
                            <div class="row col-12 text-right">
                                <div class="col-2">&nbsp;</div>
                                <div class="col-2">&nbsp;</div>
                                <div class="col-2">&nbsp;</div>
                                <div class="col-6 text-right">
                                    <img id="Dentist2_1" src="images/Dentist.png" width="60" runat="server" />
                                    <img id="Dentist2_2" src="images/Dentist.png" width="60" runat="server"  />
                                    <img id="Dentist2_3" src="images/Dentist.png" width="60" runat="server"  />
                                </div>
                            </div>
                            <div hidden="hidden">
                                <input type="text" id="txtH_time2" value="" runat="server" />
                                <input type="text" id="txtH_selectTime" value="" runat="server" />
                            </div>
                            <div class="row col-12 btn btn-light text-right" style="font-size:x-large">
                                <label class="switch">
                                    <input type="checkbox" id="CB_Time2" value="15:00:00" onclick="CheckTime('2')" runat="server" />
                                    <span class="slider round"></span>
                                </label> 15:00 น. - 16:00 น.
                            </div>
                            <script>
                                function CheckTime(S) {
                                    var T1 = document.getElementById('<%= CB_Time1.ClientID %>');
                                    var T2 = document.getElementById('<%= CB_Time2.ClientID %>');
                                    var SelectTime = document.getElementById('<%= txtH_selectTime.ClientID %>');

                                    if (S == '1') {
                                        T1.checked = true;
                                        T2.checked = false;
                                        SelectTime.value = T1.value;
                                    } else {
                                        T1.checked = false;
                                        T2.checked = true;
                                        SelectTime.value = T2.value;
                                    }
                                }
                            </script>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-sm-6 mx-auto mb-5" style="background-image:url(images/seeker_employee.png); background-position-x:center; background-size:contain; background-repeat:no-repeat">
                    <div class="my-5">&nbsp;</div>
                    <div class="col-12 btn btn-light">
                        <input type="text" id="txt_empid" class="form-control" placeholder="รหัสพนักงาน" value="" runat="server" />
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <div class="mx-auto text-center">
            <div class="col-2 btn btn-light">
            <asp:Button ID="btn_submit" CssClass="col-12 btn btn-outline-primary" Font-Size="X-Large" Text="จอง" OnClick="btn_submit_Click" runat="server" />
            </div>
        </div>
    </div>

</asp:Content>
