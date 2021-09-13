<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CheckinMeeting.aspx.cs" Inherits="BRH_Plubic.CheckinMeeting" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>BRH Check In Meeting</title>
    <script src="js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="css/bootstrap.min.css" />
</head>
<body>
    <div class="col-11 mx-auto mt-5">
        <img src="images/LOGO-BRH-Horizontal-ENG-Transparent.png" width="200" />
    </div>
    <div class="text-right mb-5" style="margin-right:200px">
        <a href="MeetingRoom.aspx">เลือกห้องประชุม</a>
    </div>
   
    <form id="form1" runat="server">
        <div class="col-lg-8 col-sm-10 mx-auto mb-5">
            <div class="card card-header bg-primary" style="color:white">
                <div class="row col-12">
                    <div class="col-4 h3">
                        (<asp:Label ID="lbl_room" Text="" runat="server"></asp:Label>)
                    </div>
                    <div class="col-8 bg-dark rounded mx-auto text-right h5">
                        <asp:Label ID="lbl_dateslot" Text="" runat="server"></asp:Label>
                    </div>
                    <div class="col-12 h3">
                        <asp:Label ID="lbl_topic" Text="" runat="server"></asp:Label>
                    </div>
                </div>
            </div>
            <div class="card card-body">
                <div class="row col-12 input-group">
                    <input type="text" id="txt_empid" autofocus="autofocus" onblur="fn_tabSubmit()" class="col-9 form-control" placeholder="รหัสพนักงาน" runat="server" />
                    <asp:Button ID="btn_submit" CssClass="col-3 btn btn-light" Text="Check In" runat="server" />
                    <asp:Label ID="lbl_alert" CssClass="col-12" Font-Size="Larger" Text="" runat="server"></asp:Label>
                    <button id="btnH_submit" hidden="hidden" runat="server" onserverclick="btn_submit_Click"></button> 
                    <script>
                        function fn_tabSubmit() {
                            var txt = document.getElementById('<%= txt_empid.ClientID %>');
                            if (txt.value != '') {
                                __doPostBack('<%= btnH_submit.UniqueID %>', '');
                            }
                        }
                    </script>
                </div>
            </div>
        </div>
        <div class="col-9 mx-auto">
            <a href="#" id="a_add" onclick="ShowAdd()">ADD+</a>
            <div id="div_add" class="row col-12" hidden="hidden">
                <div class="col-2"><input type="text" id="txtH_empid" class="form-control" placeholder="รหัสพนักงาน" value="" runat="server" /></div>
                <div class="col-3"><input type="text" id="txtH_fname" class="form-control" placeholder="ชื่อ" value="" runat="server" /></div>
                <div class="col-3"><input type="text" id="txtH_lname" class="form-control" placeholder="นามสกุล" value="" runat="server" /></div>
                <div class="col-3"><input type="text" id="txtH_post" class="form-control" placeholder="ตำแหน่ง" value="" runat="server" /></div>
                <div class="col-1"><button id="btn_add" class="btn btn-light" onserverclick="btn_add_ServerClick" runat="server">submit</button></div>
            </div>
            <script>
                function ShowAdd() {
                    var box = document.getElementById('div_add');
                    box.hidden = false;
                }
            </script>
        </div>
        <asp:GridView ID="GridView1" runat="server" CssClass="col-lg-10 col-sm-12 mx-auto" AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3">
            <Columns>
                <asp:TemplateField HeaderText="ลำดับ">
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="cm_indate" HeaderText="ประทับเวลา" DataFormatString="{0: dd/MM/yyyy HH:mm:ss}"></asp:BoundField>
                <asp:BoundField DataField="empid" HeaderText="รหัสพนัก"></asp:BoundField>
                <asp:BoundField DataField="emp_name" HeaderText="ชื่อ นามสกุล"></asp:BoundField>
                <asp:BoundField DataField="emp_posdesc" HeaderText="ตำแหน่ง"></asp:BoundField>
                <asp:BoundField DataField="emp_deptdesc" HeaderText="ฝ่าย/แผนก"></asp:BoundField>
            </Columns>
            <FooterStyle BackColor="White" ForeColor="#000066"></FooterStyle>
             
            <HeaderStyle CssClass="bg-primary" HorizontalAlign="Center" Font-Bold="True" ForeColor="White"></HeaderStyle>

            <PagerStyle HorizontalAlign="Left" BackColor="White" ForeColor="#000066"></PagerStyle>

            <RowStyle ForeColor="#000066"></RowStyle>

            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White"></SelectedRowStyle>

            <SortedAscendingCellStyle BackColor="#F1F1F1"></SortedAscendingCellStyle>

            <SortedAscendingHeaderStyle BackColor="#007DBB"></SortedAscendingHeaderStyle>

            <SortedDescendingCellStyle BackColor="#CAC9C9"></SortedDescendingCellStyle>

            <SortedDescendingHeaderStyle BackColor="#00547E"></SortedDescendingHeaderStyle>
        </asp:GridView>
        <div class="col-8 mx-auto text-right mt-5 mb-2">
            <asp:Button ID="btnExport" CssClass="btn btn-outline-primary" runat="server" Text="Export To Excel" OnClick="btnExport_Click" Visible="false" />
        </div>
    </form>
</body>
</html>
