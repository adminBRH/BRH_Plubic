<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Schedule.aspx.cs" Inherits="BRH_Plubic.Rehab.Schedule" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentDesktop" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<style>
    .tdTime {
        width: 3.125%; /* (3.125 x 24) = 75% */
    }
    .colorTime {

    }
    input[type=radio] {
        border: 0px;
        width: 1em;
        height: 1em;
    }
</style>
<script>
    function fn_colorTime(val) {
        var color = '';
        if (val == 'on') {
            color = 'greenyellow';
        } else if (val == 'break') {
            color = 'gray';
        } else {
            color = 'white';
        }
        document.write('<td style="background-color: ' + color + ';"></td>');
    }

    function fn_Child(val) {
        if (val == 'yes') {
            val = 'เด็ก';
        } else {
            val = 'ผู้ใหญ่';
        }
        document.write(val);
    }
</script>


<asp:ScriptManager ID="ScriptManager_Master" runat="server"></asp:ScriptManager>

    <div class="card col-12 mx-auto">
        <div class="row col-12 mx-auto">
            <div class="col-12 mx-auto my-2 text-center">
                <asp:Calendar CssClass="mx-auto" ID="CLD_Task" runat="server" OnDayRender="CLD_Task_DayRender" OnSelectionChanged="CLD_Task_SelectionChanged" BackColor="White" BorderColor="White" BorderWidth="1px" Font-Names="Verdana" Font-Size="9pt" ForeColor="Black" Height="250px" NextPrevFormat="ShortMonth" Width="350px">
                    <DayHeaderStyle Font-Bold="True" Font-Size="8pt"></DayHeaderStyle>
                    <NextPrevStyle VerticalAlign="Bottom" Font-Bold="True" Font-Size="8pt" ForeColor="#333333"></NextPrevStyle>
                    <OtherMonthDayStyle ForeColor="#999999"></OtherMonthDayStyle>
                    <SelectedDayStyle BackColor="#333399" ForeColor="White"></SelectedDayStyle>
                    <TitleStyle BackColor="White" BorderColor="Black" BorderWidth="4px" Font-Bold="True" Font-Size="12pt" ForeColor="#333399"></TitleStyle>
                    <TodayDayStyle BackColor="#CCCCCC"></TodayDayStyle>
                </asp:Calendar>
            </div>
            <div id="div_AddDate" class="col-6 mx-auto text-left" runat="server">
                <a id="btn_AddDate" data-toggle="modal" data-target="#modalAddDate" style="font-size: x-large; cursor: pointer;">+ <i class="ti-calendar"></i></a>
            </div>
            <div id="div_EditDate" class="col-6 mx-auto text-left" runat="server" visible="false">
                <a id="btn_EditDate" data-toggle="modal" data-target="#modalEditDate" style="font-size: x-large; cursor: pointer;"><i class="ti-alarm-clock"></i></a>
            </div>
            <div id="div_AddTask" class="col-6 mx-auto text-right" runat="server">
                <a id="btn_AddTask" data-toggle="modal" data-target="#modalAddTask" style="font-size: x-large; cursor: pointer;">+ <i class="ti-user"></i></a>
            </div>
            <div class="col-12 mx-auto text-center" style="font-size: x-large;">
                ตารางเวร <asp:Label ID="lbl_date" Text="" runat="server"></asp:Label>
                <br />
                <i class="ti-arrow-circle-right" style="background-color: greenyellow; border-radius: 20px;"></i> เด็ก
                &nbsp;&nbsp;&nbsp;&nbsp;
                <i class="ti-arrow-circle-right" style="background-color: darkgoldenrod; border-radius: 20px;"></i> ผู้ใหญ่
                &nbsp;&nbsp;&nbsp;&nbsp;
                <i class="ti-arrow-circle-right" style="background-color: lightgrey; border-radius: 20px;"></i> พักเบรค
                &nbsp;&nbsp;&nbsp;&nbsp;
                <i class="ti-arrow-circle-right" style="background-color: Highlight; border-radius: 20px;"></i> จองแล้ว
                &nbsp;&nbsp;&nbsp;&nbsp;
                <i class="ti-arrow-circle-right" style="background-color: cornflowerblue; border-radius: 20px;"></i> ดำเนินการ
                &nbsp;&nbsp;&nbsp;&nbsp;
                <i class="ti-arrow-circle-right" style="background-color: forestgreen; border-radius: 20px;"></i> เสร็จสิ้น
            </div>
            <table border="1" style="width: 100%; font-family: Calibri;">
                <thead>
                    <tr class="text-center bg-info" style="color: white;">
                        <td style="width: 5%;"><b>ลำดับ</b></td>
                        <td style="width: 15%;"><b>ชื่อ - นามสกุล</b></td>
                        <td style="width: 5%;"><b>ดูแล</b></td>
                        <asp:Label ID="lbl_tdHead" Text="" runat="server"></asp:Label>
                    </tr>
                </thead>
                <asp:ListView ID="LV_time" runat="server">
                    <LayoutTemplate>
                        <tr id="itemPlaceholder" runat="server"></tr>
                    </LayoutTemplate>
                    <ItemTemplate>
                        <tr>
                            <td class="text-center"><%# Eval("Num") %></td>
                            <td data-toggle="modal" data-target="#modalEditTask" style="cursor: pointer;" onclick="fn_editTask('<%# Eval("rhs_id") %>','<%# Eval("Num") %>','<%# Eval("rhs_empid") %>','<%# Eval("Name") %>','<%# Eval("rhs_timeSt") %>','<%# Eval("rhs_timeEn") %>','<%# Eval("rhs_breakSt") %>','<%# Eval("rhs_breakEn") %>','<%# Eval("rhs_child") %>')">
                                <%# Eval("Name") %>
                            </td>
                            <td><script>fn_Child('<%# Eval("rhs_child") %>');</script></td>
                            <%# Eval("TableTimes") %>
                        </tr>
                    </ItemTemplate>
                </asp:ListView>
            </table>
        </div>
    </div>

<!-- Modal Add Date -->
<div class="modal fade" id="modalAddDate" tabindex="-1" role="dialog" aria-labelledby="modalAddDateTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalAddDateTitle">Add time to day.</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
          <div class="row col-12 mx-auto my-3">
              <div class="col-3 mx-auto my-auto text-right">
                  วันที่
              </div>
              <div class="col-9 mx-auto">
                  <asp:Label ID="lbl_Adddatetask" Text="" runat="server"></asp:Label>
                  <input type="date" id="date_Task" class="form-control" value="" runat="server" hidden="hidden" />
              </div>
          </div>
          <div class="row col-12 mx-auto my-3">
              <div class="col-3 mx-auto my-auto text-right">
                  เวลา
              </div>
              <div class="col-4 mx-auto text-center">
                  <input type="time" id="time_St" class="form-control" value="08:00" runat="server" />
              </div>
              <div class="col-1 mx-auto my-auto text-center">
                  ถึง
              </div>
              <div class="col-4 mx-auto text-center">
                  <input type="time" id="time_En" class="form-control" value="19:30" runat="server" />
              </div>
          </div>
          <div class="row col-12 mx-auto my-3">
              <div class="col-3 mx-auto my-auto text-right">
                  ช่วงละ
              </div>
              <div class="col-3 mx-auto my-auto text-center">
                  <input type="number" id="number_split" class="form-control" value="30" runat="server" />
              </div>
              <div class="col-6 mx-auto my-auto text-left">
                  นาที
              </div>
          </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" id="btn_addDate" class="btn btn-outline-primary" runat="server" onserverclick="btn_addDate_ServerClick">Save</button>
      </div>
    </div>
  </div>
</div>
<!-- Modal Edit Date -->
<div class="modal fade" id="modalEditDate" tabindex="-1" role="dialog" aria-labelledby="modalEditDateTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalEditDateTitle">Edit time on day.</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
          <div class="row col-12 mx-auto my-3">
              <div class="col-3 mx-auto my-auto text-right">
                  วันที่
              </div>
              <div class="col-9 mx-auto text-left">
                  <asp:Label ID="lbl_editdate" Text="" runat="server"></asp:Label>
              </div>
          </div>
          <div class="row col-12 mx-auto my-3">
              <div class="col-3 mx-auto my-auto text-right">
                  เวลา
              </div>
              <div class="col-4 mx-auto text-center">
                  <input type="time" id="time_editSt" class="form-control" value="" runat="server" />
              </div>
              <div class="col-1 mx-auto my-auto text-center">
                  ถึง
              </div>
              <div class="col-4 mx-auto text-center">
                  <input type="time" id="time_editEn" class="form-control" value="" runat="server" />
              </div>
          </div>
          <div class="row col-12 mx-auto my-3">
              <div class="col-3 mx-auto my-auto text-right">
                  ช่วงละ
              </div>
              <div class="col-3 mx-auto my-auto text-center">
                  <input type="number" id="number_editSplit" class="form-control" value="" runat="server" />
              </div>
              <div class="col-6 mx-auto my-auto text-left">
                  นาที
              </div>
          </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" id="btn_editTime" class="btn btn-outline-primary" runat="server" onserverclick="btn_editTime_ServerClick">Save</button>
      </div>
    </div>
  </div>
</div>

<!-- Modal Add Task -->
<div class="modal left fade" id="modalAddTask" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document" style="max-width: 100%; top: 0; left: auto; right: 0;">
        <div class="modal-content" style="background-color:white;">
            <div class="modal-body">
                <div class="row col-12 mx-auto text-center" style="font-size: x-large;">
                    เพิ่มตารางการทำงานในวันที่ &nbsp;<asp:Label ID="lbl_dateTask" Text="" runat="server"></asp:Label>
                </div>
                <div class="row col-12 mx-auto" style="position: absolute; top: 10%">
                    <div class="col-12 mx-auto">
                        <asp:UpdatePanel ID="UpdatePanel_AddTask" runat="server">
                            <ContentTemplate>
                                <div class="row col-12 mx-auto">
                                    <div class="col-2 mx-auto my-auto text-right">
                                        เพิ่ม 
                                    </div>
                                    <div class="col-2 mx-auto my-auto">
                                        <input type="number" id="txt_qtyslot" class="form-control" value="5" max="20" runat="server" />
                                    </div>
                                    <div class="col-8 mx-auto my-auto text-left"> Slot</div>
                                </div>
                                <div class="row col-12 mx-auto my-3">
                                    <div class="col-5 mx-auto my-auto text-right">
                                        เวลาทำงาน
                                    </div>
                                    <div class="col-3 mx-auto">
                                        <input type="time" id="time_taskSt" value="" required="required" class="form-control" runat="server" />
                                    </div>
                                    <div class="col-1 mx-auto my-auto text-center">ถึง</div>
                                    <div class="col-3 mx-auto">
                                        <input type="time" id="time_taskEn" value="" required="required" class="form-control" runat="server" />
                                    </div>
                                </div>
                                <div class="row col-12 mx-auto my-3">
                                    <div class="col-5 mx-auto my-auto text-right">
                                        เวลาพักเบรค
                                    </div>
                                    <div class="col-3 mx-auto">
                                        <input type="time" id="time_breakSt" value="12:00" required="required" class="form-control" runat="server" />
                                    </div>
                                    <div class="col-1 mx-auto my-auto text-center">ถึง</div>
                                    <div class="col-3 mx-auto">
                                        <input type="time" id="time_breakEn" value="13:00" required="required" class="form-control" runat="server" />
                                    </div>
                                </div>
                                <div class="col-12 mx-auto my-3">
                                    ตรวจ 
                                    <label class="switch my-auto">
                                        <input type="checkbox" name="cb_child" id="cb_child_y" checked="checked" value="yes" onclick="fn_child('yes')" runat="server" />
                                        <span class="slider round"></span>
                                    </label> เด็ก 
                                    <label class="switch my-auto">
                                        <input type="checkbox" name="cb_child" id="cb_child_n" value="no" onclick="fn_child('no')" runat="server" />
                                        <span class="slider round"></span>
                                    </label> ผู้ใหญ่
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                    <div class="col-12 mx-auto my-3 text-center">
                        <button id="btn_submitTask" class="btn btn-outline-primary" onserverclick="btn_submitTask_ServerClick" runat="server">save <i class="ti-save"></i></button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div hidden="hidden">
    <input type="text" id="txt_dateid" value="" runat="server" />
    <input type="text" id="txt_taskid" value="" runat="server" />
    <input type="text" id="txt_child" value="yes" runat="server" />

    <input type="text" id="txt_bookid" value="" runat="server" />
</div>

<!-- Modal Details -->
<div class="modal fade" id="modalDetails" tabindex="-1" role="dialog" aria-labelledby="modalDetailsTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header bg-primary" style="color: white;">
        <h5 class="modal-title" id="modalDetailsTitle">รายละเอียดการจอง</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
          <asp:UpdatePanel ID="UpdatePanel_Details" runat="server">
              <ContentTemplate>
                  <div class="row col-12- mx-auto">
                      <div class="col-12 mx-auto">
                          <b>จองวันที่ :</b> <asp:Label ID="lbl_dateTH" Text="" runat="server"></asp:Label>&nbsp;&nbsp;&nbsp;
                          <b>เวลา :</b> <asp:Label ID="lbl_time" Text="" runat="server"></asp:Label>&nbsp;&nbsp;&nbsp;
                          <b>สำหรับ :</b> <asp:Label ID="lbl_child" Text="" runat="server"></asp:Label>
                      </div>
                      <div class="col-12 mx-auto">
                          <b>เจ้าหน้าที่ที่รับผิดชอบ :</b> <asp:Label ID="lbl_staff" Text="" runat="server"></asp:Label>
                      </div>
                      <div class="col-11 mx-auto my-2 boxShadow"></div>
                      <div class="col-12 mx-auto">
                          <b>ข้อมูลผู้รับบริการ</b>
                      </div>
                      <div class="col-12 mx-auto">
                          <b>HN :</b> <asp:Label ID="lbl_hn" Text="" runat="server"></asp:Label>&nbsp;&nbsp;&nbsp
                          <b> จาก :</b> <asp:Label ID="lbl_oi" Text="" runat="server"></asp:Label>
                      </div>
                      <div class="col-12 mx-auto">
                          <b>ชื่อ - นามสกุล :</b> <asp:Label ID="lbl_customer" Text="" runat="server"></asp:Label>&nbsp;&nbsp;&nbsp
                      </div>
                      <div class="col-12 mx-auto">
                          <b>เพศ :</b> <asp:Label ID="lbl_gender" Text="" runat="server"></asp:Label>
                      </div>
                      <div class="col-11 mx-auto my-2 boxShadow"></div>
                      <div class="col-12 mx-auto">
                          <b>เครื่องมือที่ต้องการใช้งาน :</b> <br /><asp:Label ID="lbl_tool" Text="" runat="server"></asp:Label>
                      </div>
                      <div class="col-11 mx-auto my-2 boxShadow"></div>
                      <div class="col-12 mx-auto">
                          <b>หมายเหตุ :</b> 
                          <textarea id="txt_remark" rows="5" class="form-control" runat="server" disabled="disabled"></textarea>
                      </div>
                  </div>
                  <div class="col-12 mx-auto mt-3 text-left">
                      <button id="btnonjob" class="btn btn-outline-primary" onserverclick="btnonjob_ServerClick" runat="server">เข้ารับการรักษา</button>
                  </div>
                  <a id="btn_details" runat="server" onserverclick="btn_details_ServerClick" hidden="hidden"></a>
              </ContentTemplate>
              <Triggers>
                  <asp:AsyncPostBackTrigger ControlID="btn_details" />
              </Triggers>
          </asp:UpdatePanel>
      </div>
      <div class="modal-footer">
        <a class="btn btn-outline-danger" data-toggle="modal" data-target="#modalConfirm">ยกเลิกการจอง</a>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<!-- Modal Cancel -->
<div class="modal fade" id="modalConfirm" tabindex="-1" role="dialog" aria-labelledby="modalConfirmTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header bg-danger" style="color: white;">
        <h5 class="modal-title" id="modalConfirmTitle">คุณต้องการยกเลิกการจองนี้ ใช่หรือไม่ ?</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
          <div class="row col-12 mx-auto">
              <div class="col-6 mx-auto text-center">
                  <button type="button" id="btn_cancel" class="btn btn-outline-danger" onserverclick="btn_cancel_ServerClick" runat="server">ใช่</button>
              </div>
              <div class="col-6 mx-auto text-center">
                  <a data-dismiss="modal" class="btn btn-outline-info">ไมใช่</a>
              </div>
          </div>
      </div>
    </div>
  </div>
</div>

<!-- Modal Edit Task -->
<div class="modal left fade" id="modalEditTask" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document" style="max-width: 100%; top: 0; left: auto; right: 0;">
        <div class="modal-content" style="background-color:white;">
            <div class="modal-body">
                <div class="row col-12 mx-auto text-center" style="font-size: x-large;">
                    แก้ไขตารางการทำงานวันที่ &nbsp;&nbsp;<asp:Label ID="lbl_EditdateTask" Text="" runat="server"></asp:Label>
                </div>
                <div class="row col-12 mx-auto" style="position: absolute; top: 10%">
                    <div class="col-12 mx-auto">
                        <div class="row col-12 mx-auto">
                            <div class="col-4 mx-auto" runat="server">
                                <input type="text" id="txt_emp" value="" class="form-control" placeholder="รหัสพนักงาน" runat="server" />
                            </div>
                            <div class="col-8 mx-auto" runat="server">
                                <asp:Label ID="lbl_EditName" Font-Size="X-Large" ForeColor="Blue" Text="" runat="server"></asp:Label>
                            </div>
                        </div>
                        <div class="row col-12 mx-auto my-3">
                            <div class="col-5 mx-auto my-auto text-right">
                                เวลาทำงาน
                            </div>
                            <div class="col-3 mx-auto">
                                <input type="time" id="time_EdittaskSt" value="" required="required" class="form-control" runat="server" />
                            </div>
                            <div class="col-1 mx-auto my-auto text-center">ถึง</div>
                            <div class="col-3 mx-auto">
                                <input type="time" id="time_EdittaskEn" value="" required="required" class="form-control" runat="server" />
                            </div>
                        </div>
                        <div class="row col-12 mx-auto my-3">
                            <div class="col-5 mx-auto my-auto text-right">
                                เวลาพักเบรค
                            </div>
                            <div class="col-3 mx-auto">
                                <input type="time" id="time_EditbreakSt" value="12:00" required="required" class="form-control" runat="server" />
                            </div>
                            <div class="col-1 mx-auto my-auto text-center">ถึง</div>
                            <div class="col-3 mx-auto">
                                <input type="time" id="time_EditbreakEn" value="13:00" required="required" class="form-control" runat="server" />
                            </div>
                        </div>
                        <div class="col-12 mx-auto my-3">
                            ตรวจ 
                            <label class="switch my-auto">
                                <input type="checkbox" name="cb_Editchild" id="cb_Editchild_y" value="yes" onclick="fn_EditChild('yes')" runat="server" />
                                <span class="slider round"></span>
                            </label> เด็ก 
                            <label class="switch my-auto">
                                <input type="checkbox" name="cb_Editchild" id="cb_Editchild_n" value="no" onclick="fn_EditChild('no')" runat="server" />
                                <span class="slider round"></span>
                            </label> ผู้ใหญ่
                        </div>
                    </div>
                    <div class="row col-12 mx-auto my-3 text-center">
                        <div class="col-6 mx-auto text-right">
                            <a class="btn btn-outline-danger" data-toggle="modal" data-target="#modalCancelTask">Delete <i class="ti-trash"></i></a>
                        </div>
                        <div class="col-6 mx-auto text-left">
                            <button id="btn_submitEditTask" class="btn btn-outline-primary" onserverclick="btn_submitEditTask_ServerClick" runat="server">save <i class="ti-save"></i></button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Modal Cancel Task -->
<div class="modal fade" id="modalCancelTask" tabindex="-1" role="dialog" aria-labelledby="modalCancelTaskTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header bg-danger" style="color: white;">
        <h5 class="modal-title" id="modalCancelTaskTitle">Cancel Task.</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body text-center" style="font-size: x-large;">
          คุณต้องการลบตารางการทำงานลำดับที่ <asp:Label ID="lbl_delnum" Text="" runat="server"></asp:Label> ออกใช่หรือไม่ <i class="ti-help"></i>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
        <button type="button" id="btn_cancelTask" class="btn btn-outline-primary" runat="server" onserverclick="btn_cancelTask_ServerClick">Yes</button>
      </div>
    </div>
  </div>
</div>

<script>
    function fn_child(yn) {
        var child = document.getElementById('<%= txt_child.ClientID %>');
        var childY = document.getElementById('<%= cb_child_y.ClientID %>');
        var childN = document.getElementById('<%= cb_child_n.ClientID %>');
        if (yn == 'yes') {
            childY.checked = true;
            childN.checked = false;
        }
        else {
            childY.checked = false;
            childN.checked = true;
        }
        child.value = yn;
    }

    function fn_EditChild(yn) {
        var child = document.getElementById('<%= txt_child.ClientID %>');
        var childY = document.getElementById('<%= cb_Editchild_y.ClientID %>');
        var childN = document.getElementById('<%= cb_Editchild_n.ClientID %>');
        if (yn == 'yes') {
            childY.checked = true;
            childN.checked = false;
        }
        else {
            childY.checked = false;
            childN.checked = true;
        }
        child.value = yn;
    }

    function fn_editTask(id, num, emp, name, timeSt, timeEn, breakSt, breakEn, yn) {
        document.getElementById('<%= txt_taskid.ClientID %>').value = id;
        document.getElementById('<%= txt_emp.ClientID %>').value = emp;
        document.getElementById('<%= lbl_EditdateTask.ClientID %>').innerText = document.getElementById('<%= lbl_date.ClientID %>').innerText + ' ลำดับที่ ' + num;
        document.getElementById('<%= lbl_EditName.ClientID %>').innerText = name;

        document.getElementById('<%= time_EdittaskSt.ClientID %>').value = timeSt;
        document.getElementById('<%= time_EdittaskEn.ClientID %>').value = timeEn;

        document.getElementById('<%= time_EditbreakSt.ClientID %>').value = breakSt;
        document.getElementById('<%= time_EditbreakEn.ClientID %>').value = breakEn;

        document.getElementById('<%= lbl_delnum.ClientID %>').innerText = num;

        fn_EditChild(yn);
    }

    function fn_details(rhbid) {
        document.getElementById('<%= txt_bookid.ClientID %>').value = rhbid;
        __doPostBack('<%= btn_details.UniqueID %>', '');
    }
</script>

</asp:Content>
