<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="BRH_Plubic.Rehab.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentDesktop" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<style>
    input[type=radio] {
        border: 0px;
        width: 2em;
        height: 2em;
    }
</style>
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <div class="col-12 mx-auto text-center" style="font-size: xx-large;">
        ตารางนัดกายภาพบำบัด
    </div>
    <div class="col-12 mx-auto text-center my-2" style="font-size: x-large; cursor: pointer;">
        <u><asp:Label ID="lbl_dateHead" Text="" runat="server" data-toggle="modal" data-target="#modalCalendar"></asp:Label></u>
    </div>
    <div class="col-12 mx-auto text-center" style="font-size: x-large;">
        <label class="switch my-auto">
            <asp:CheckBox ID="cb_child" Checked="true" OnCheckedChanged="cb_child_CheckedChanged" AutoPostBack="true" runat="server" />
            <span class="slider round"></span>
        </label><span>เด็ก</span>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <label class="switch my-auto">
            <asp:CheckBox ID="cb_adult" OnCheckedChanged="cb_adult_CheckedChanged" AutoPostBack="true" runat="server" />
            <span class="slider round"></span>
        </label><span class="my-auto">ผู้ใหญ่</span>
    </div>
    <!-- ================================================== Slot ================================================== -->
    <div class="col-12 mx-auto my-5">
        <asp:Label ID="lbl_slot" CssClass="col-12 mx-auto text-center" Text="" runat="server"></asp:Label>
    </div>
    <!-- ================================================== Slot ================================================== -->

<!-- Modal Calendar -->
<div class="modal fade" id="modalCalendar" tabindex="-1" role="dialog" aria-labelledby="modalCalendarTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalCalendarTitle">Calendar <asp:Label ID="Label1" Text="" runat="server"></asp:Label></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
          <asp:Calendar CssClass="mx-auto" ID="CLD_book" runat="server" OnDayRender="CLD_book_DayRender" OnSelectionChanged="CLD_book_SelectionChanged" BackColor="White" BorderColor="White" BorderWidth="1px" Font-Names="Verdana" Font-Size="9pt" ForeColor="Black" Height="250px" NextPrevFormat="ShortMonth" Width="350px">
                <DayHeaderStyle Font-Bold="True" Font-Size="8pt"></DayHeaderStyle>
                <NextPrevStyle VerticalAlign="Bottom" Font-Bold="True" Font-Size="8pt" ForeColor="#333333"></NextPrevStyle>
                <OtherMonthDayStyle ForeColor="#999999"></OtherMonthDayStyle>
                <SelectedDayStyle BackColor="#333399" ForeColor="Red"></SelectedDayStyle>
                <TitleStyle BackColor="White" BorderColor="Black" BorderWidth="4px" Font-Bold="True" Font-Size="12pt" ForeColor="#333399"></TitleStyle>
                <TodayDayStyle BackColor="#CCCCCC"></TodayDayStyle>
            </asp:Calendar>
      </div>
      <div class="modal-footer">
      </div>
    </div>
  </div>
</div>

<!-- Modal Booking -->
<div class="modal fade" id="modalBooking" tabindex="-1" role="dialog" aria-labelledby="modalBookingTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalBookingTitle">
            <b>ต้องการจองวันที่ :</b> <asp:Label ID="lbl_bookdate" Text="" runat="server"></asp:Label>
            <asp:UpdatePanel ID="UpdatePanel_BookTimeEn" runat="server">
                <ContentTemplate>
                    <b>เวลา :</b> <asp:Label ID="lbl_booktime" Text="" runat="server"></asp:Label>
                    <b>ถึง </b><asp:DropDownList ID="DD_BookTimeEn" runat="server">
                        <asp:ListItem Text="" Value=""></asp:ListItem>
                    </asp:DropDownList> น.
                    <a id="btn_BookTimeEn" runat="server" onserverclick="btn_BookTimeEn_ServerClick" hidden="hidden"></a>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btn_BookTimeEn" />
                </Triggers>
            </asp:UpdatePanel>
            <b>สำหรับ :</b> <asp:Label ID="lbl_child" Text="" runat="server"></asp:Label>
            <br />
            <b>เจ้าหน้าที่ที่รับผิดชอบ :</b> <asp:Label ID="lbl_empname" Text="" runat="server"></asp:Label>
        </h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
          <div hidden="hidden">
              <input id="txtH_dateid" value="" runat="server" />
              <input id="txtH_rhd" value="" runat="server" />
              <input id="txtH_rhs" value="" runat="server" />
              <input id="txtH_time" value="" runat="server" />
              <input id="txtH_gender" value="" runat="server" />
          </div>
          <div class="row col-12 mx-auto">
              <div class="col-12 mx-auto" style="font-size: x-large;">
                  ข้อมูลผู้รับบริการ
              </div>
              <div class="row col-4 mx-auto my-auto">
                  <div class="col-2 mx-auto my-auto">
                      เพศ
                  </div>
                  <div id="div_male" class="col-5 mx-auto my-auto text-center" onclick="fn_gender('male')">
                      <img src="image/male.png" style="width: 40px; height: 100px; cursor: pointer;" /><br />
                      <span id="span_man" style="border-radius: 20px;">&nbsp;&nbsp;ชาย&nbsp;&nbsp;</span>
                  </div>
                  <div id="div_female" class="col-5 mx-auto my-auto text-center" onclick="fn_gender('female')">
                      <img src="image/female.png" style="width: 50px; height: 100px; cursor: pointer;" /><br />
                      <span id="span_feman" style="border-radius: 20px;">&nbsp;&nbsp;หญิง&nbsp;&nbsp;</span>
                  </div>
                  <script>
                      function fn_gender(val) {
                          var man = document.getElementById('span_man');
                          var feman = document.getElementById('span_feman');
                          if (val == 'male') {
                              man.setAttribute('class', 'bg-gradient-blue');
                              feman.removeAttribute('class');
                          }
                          else {
                              feman.setAttribute('class', 'bg-gradient-blue');
                              man.removeAttribute('class');
                          }

                          var gender = document.getElementById('<%= txtH_gender.ClientID %>');
                          gender.value = val;
                      }
                  </script>
              </div>
              <div class="row col-8 mx-auto">
                  <div class="col-6 mx-auto">
                      <input id="txt_fname" value="" class="form-control" placeholder="ชื่อ" runat="server" />
                  </div>
                  <div class="col-6 mx-auto">
                      <input id="txt_lname" value="" class="form-control" placeholder="นามสกุล" runat="server" />
                  </div>
                  <%--<div class="col-4 mx-auto my-auto">
                      วัน
                      <asp:DropDownList ID="dd_DOB_date" CssClass="form-control" runat="server" >
                          <asp:ListItem Text="" Value=""></asp:ListItem>
                      </asp:DropDownList>
                  </div>
                  <div class="col-4 mx-auto my-auto">
                      เดือน
                      <asp:DropDownList ID="dd_DOB_month" CssClass="form-control" runat="server" >
                          <asp:ListItem Text="" Value=""></asp:ListItem>
                      </asp:DropDownList>
                  </div>
                  <div class="col-4 mx-auto my-auto">
                      ปี เกิด
                      <asp:DropDownList ID="dd_DOB_year" CssClass="form-control" runat="server" >
                          <asp:ListItem Text="" Value=""></asp:ListItem>
                      </asp:DropDownList>
                  </div>--%>
                  <div class="col-6 mx-auto">
                      <input type="text" id="txt_hn" value="" class="form-control" placeholder="HN" runat="server" />
                  </div>
                  <div class="row col-6 mx-auto">
                      <div class="col-6 mx-auto my-auto">
                          IPD <input type="radio" name="rd_OI" id="rd_ipd" value="IPD" runat="server" style="siz" />
                      </div>
                      <div class="col-6 mx-auto my-auto">
                          OPD <input type="radio" name="rd_OI" id="rd_opd" checked value="OPD" runat="server" />
                      </div>
                  </div>
              </div>
          </div>
          <div class="row col-12 mx-auto my-3">
              <div class="col-12 mx-auto" style="font-size: x-large;">
                  เครื่องมือที่ต้องการใช้งาน
              </div>
              <div class="col-12 mx-auto">
                  <asp:Label ID="lbl_toolalert" Text="" runat="server"></asp:Label>
                  <asp:UpdatePanel ID="UpdatePanel_tool" runat="server">
                      <ContentTemplate>
                          <div class="row col-12 mx-auto my-2">
                              <div id="div_tool" class="col-6 mx-auto">
                                  <asp:DropDownList ID="dd_tool" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="dd_tool_SelectedIndexChanged" runat="server" >
                                      <asp:ListItem Text="" Value=""></asp:ListItem>
                                  </asp:DropDownList>
                                  <div hidden="hidden">
                                      <input type="text" id="txtH_toolid" value="0" runat="server" />
                                      <input type="text" id="txtH_toolname" value="" runat="server" />
                                  </div>
                                  <asp:Label ID="lbl_tool" Text="" runat="server"></asp:Label>
                              </div>
                              <div class="row col-4 mx-auto">
                                  <div class="col-3 mx-auto text-right">จำนวน </div>
                                  <div class="col-6 mx-auto text-right">
                                      <input type="number" id="num_toolqty" max="3" class="form-control" value="1" runat="server" />
                                  </div>
                                  <div class="col-3 mx-auto text-left"> ครั้ง</div>
                              </div>
                              <div class="col-2 mx-auto">
                                  <a class="btn btn-outline-info" onclick="fn_addtool()" style="cursor: pointer;">+Add</a>
                              </div>
                          </div>
                      </ContentTemplate>
                  </asp:UpdatePanel>
                  <div hidden="hidden">
                      <input type="text" id="txtH_ARtool" value="" runat="server" />
                      <input type="text" id="txtH_ARtoolname" value="" runat="server" />
                  </div>
              </div>
          </div>
          <div class="row col-12 mx-auto my-3">
              <textarea id="txt_remark" rows="5" class="form-control" placeholder="หมายเหตุ หรือ ความคิดเห็นเพิ่มเติม" runat="server"></textarea>
          </div>
      </div>
      <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
          <a class="btn btn-outline-primary" onclick="fn_book()">Save</a>
          <a id="btn_book" hidden="hidden" onserverclick="btn_book_ServerClick" runat="server"></a>
      </div>
    </div>
  </div>
</div>

<script>
    function fn_selecttime(date,time,rhd,rhs,empname)
    {
        var lblDate = document.getElementById('<%= lbl_bookdate.ClientID %>');
        var lblTime = document.getElementById('<%= lbl_booktime.ClientID %>');
        var txtRhs = document.getElementById('<%= txtH_rhs.ClientID %>');
        var txtRhd = document.getElementById('<%= txtH_rhd.ClientID %>');
        var txtTime = document.getElementById('<%= txtH_time.ClientID %>');
        var EmpName = document.getElementById('<%= lbl_empname.ClientID %>');
        var lblChild = document.getElementById('<%= lbl_child.ClientID %>');

        lblDate.innerHTML = date;
        lblTime.innerHTML = time + ' น.';
        txtRhd.value = rhd;
        txtRhs.value = rhs;
        txtTime.value = time;
        EmpName.innerHTML = empname;

        var CBchild = document.getElementById('<%= cb_child.ClientID %>');
        var CBadult = document.getElementById('<%= cb_adult.ClientID %>');
        if (CBchild.checked) {
            lblChild.innerHTML = "เด็ก";
        }
        else {
            lblChild.innerHTML = "ผู้ใหญ่";
        }

        __doPostBack('<%= btn_BookTimeEn.UniqueID %>', '');
    }

    function fn_addtool() {
        var toolid = document.getElementById('<%= txtH_toolid.ClientID %>');
        var toolmame = document.getElementById('<%= txtH_toolname.ClientID %>');
        var toolqty = document.getElementById('<%= num_toolqty.ClientID %>');

        var Arid = document.getElementById('<%= txtH_ARtool.ClientID %>');
        var Arname = document.getElementById('<%= txtH_ARtoolname.ClientID %>');

        if (toolid.value == '0') {
            alert('กรุณาเลือกเครื่องมือก่อน !!');
        } else {
            lbltool = document.getElementById('<%= lbl_tool.ClientID %>');
            if (lbltool.innerHTML != '') {
                alert('เครื่องมือนี้ถูกจองใช้งานในวันเวลาดังกล่าวเต็มแล้ว !!');
            } else {
                if (Arid.value != '') {
                    Arid.value = Arid.value + ',';
                }
                Arid.value = Arid.value + toolid.value + '|' + toolqty.value;

                if (Arname.value != '') {
                    Arname.value = Arname.value + ',';
                }
                Arname.value = Arname.value + toolmame.value + '|' + toolqty.value;
            }
        }

        fn_ShowTool();
    }

    function fn_deltool(id) {
        var txtid = document.getElementById('<%= txtH_ARtool.ClientID %>');
        var txtname = document.getElementById('<%= txtH_ARtoolname.ClientID %>');
        var idAR = txtid.value.split(',');
        var nameAR = txtname.value.split(',');
        var newID = '';
        var newName = '';
        for (i = 0; i < idAR.length; i++) {
            if (i != id) {
                if (newID != '') {
                    newID = newID + ',';
                    newName = newName + ',';
                }
                newID = newID + idAR[i];
                newName = newName + nameAR[i];
            }
        }
        txtid.value = newID;
        txtname.value = newName;

        fn_ShowTool();
    }

    function fn_ShowTool() {
        var lbl = document.getElementById('<%= lbl_toolalert.ClientID %>');
        var nameTool = document.getElementById('<%= txtH_ARtoolname.ClientID %>');
        var nameAR = nameTool.value.split(',');

        var html = '';
        if (nameTool.value != '') {
            html = '<div class="row col-12 mx-auto">';
            for (i = 0; i < nameAR.length; i++) {
                var NQ = nameAR[i].split('|');
                html = html + '<div class="col-6 mx-auto">' + NQ[0] + '</div>';
                html = html + '<div class="col-4 mx-auto">' + NQ[1] + ' ครั้ง</div>';
                html = html + '<div class="col-2 mx-auto"><a class="btn btn-outline-danger" onclick="fn_deltool(\'' + i + '\')"> X </a></div>';
            }
            html = html + '</div>';
        }

        lbl.innerHTML = html;
    }

    function fn_book() {
        var style = 'border:groove; border-color: red;';

        var gender = document.getElementById('<%= txtH_gender.ClientID %>');
        var fname = document.getElementById('<%= txt_fname.ClientID %>');
        var lname = document.getElementById('<%= txt_lname.ClientID %>');
        var tool = document.getElementById('<%= lbl_tool.ClientID %>');
        var toolAr = document.getElementById('<%= lbl_toolalert.ClientID %>');
        var divMale = document.getElementById('div_male');
        var divFemale = document.getElementById('div_female');
        var divTool = document.getElementById('div_tool');
        
        divMale.removeAttribute('style');
        divFemale.removeAttribute('style');
        fname.removeAttribute('style');
        lname.removeAttribute('style');
        divTool.removeAttribute('style');
        
        var wrong = 0;
        if (gender.value == '') {
            divMale.setAttribute('style', style);
            divFemale.setAttribute('style', style);
            wrong++;
        }
        if (fname.value == '') {
            fname.setAttribute('style', style);
            wrong++;
        }
        if (lname.value == '') {
            lname.setAttribute('style', style);
            wrong++;
        }
        if (tool.innerText != '') {
            divTool.setAttribute('style', style);
            wrong++;
        }
        //if (toolAr.innerText == '') {
        //    divTool.setAttribute('style', style);
        //    wrong++;
        //}

        if (wrong == 0) {
            __doPostBack('<%= btn_book.UniqueID %>', '');
        }
    }
</script>

<script src="../Scripts/jquery-3.4.1.min.js" "></script>
<script src="../Scripts/jquery.signalR-2.4.1.js"></script>
<script src="/signalr/hubs"></script>
<script type="text/javascript">
    var Rehab = $.connection.rehabHUB;
    $.connection.hub.start().done(function () {
        Rehab.server.data();
    });
</script>

</asp:Content>
