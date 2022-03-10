<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Manage.aspx.cs" Inherits="BRH_Plubic.GoodDoctor.Manage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentDesktop" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<asp:ScriptManager ID="ScriptManager_Master" runat="server"></asp:ScriptManager>
<style>
input[type=radio] {
    border: 0px;
    width: 2em;
    height: 2em;
}

.OnDashboard{
    border:groove; 
    border-left: 0px;
    border-top: 0px;
    border-right: 0px;
    border-bottom-color: greenyellow;
    border-left-width: 5px;
}
</style>
<script>

    function SetBtnActive(id, active) {
        var btn = document.getElementById('CB_Active_' + id);
        alert(active);
        if (active == 'yes') {
            btn.checked = true;
        } else {
            btn.checked = false;
        }
    }
</script>

    <div class="col-12 mx-auto">
        <div class="row col-12 mx-auto">
            <div class="col-4 mx-auto text-left">
                <asp:DropDownList ID="DD_Department" CssClass="card btnShadow" Font-Size="X-Large" OnSelectedIndexChanged="DD_Department_SelectedIndexChanged" AutoPostBack="true" runat="server">
                    <asp:ListItem Text="" Value=""></asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="col-4 mx-auto text-center">
                <div id="div_cbActive" runat="server" visible="false">
                <label class="switch">
                    <input type="checkbox" name="CB_Active" id="CB_Active" checked="checked" onclick="fn_active()" runat="server"  />
                    <span class="slider round"></span>
                </label> Active
                </div>
            </div>
            <div class="col-4 mx-auto" style="font-size: large;">
                <div class="col-12 mx-auto text-right">
                    <asp:UpdatePanel ID="UpdatePanel_AddDoctor" runat="server">
                        <ContentTemplate>
                            <a id="a_addDoctor" data-toggle="modal" data-target="#modalAddDoctor" style="cursor: pointer;" runat="server" visible="false">Add <i class="ti-2x ti-user"></i></a>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
        <div class="card col-12 mx-auto">
            <asp:UpdatePanel ID="UpdatePanel_DoctorList" runat="server">
                <ContentTemplate>
                    
                    <div class="row col-12 mx-auto">
                        <asp:ListView ID="LV_doctor" runat="server">
                            <LayoutTemplate>
                                <div class="col-12 mx-auto text-center h3">
                                    รายชื่อแพทย์ทั้งหมดภายในแผนก
                                </div>
                                <div id="itemPlaceholder" class="col-12 mx-auto" runat="server">
                                </div>
                            </LayoutTemplate>
                            <ItemTemplate>
                                <div class="card col-lg-4 col-sm-12">
                                    <div class="row col-12 mx-auto my-auto">
                                        <div class="col-4 mx-auto my-auto text-center" onmouseover="EnFocus()">
                                            <img src='<%# Eval("dr_img") %>' class="rounded-circle" style='width: 80%' data-toggle="modal" data-target="#modalImage" onclick="ImageGetScID('<%# Eval("ds_id") %>')" />
                                            <br />
                                            <div class="col-12 mx-auto text-center">
                                                <%# Eval("dr_doctorid") %>
                                            </div>
                                        </div>
                                        <div class="row col-8 mx-auto my-2">
                                            <div class="col-10 mx-auto">
                                                <span class="blink" style="font-size: x-large; color: <%# Eval("ds_onBoard") %>;">&#9673;</span>
                                                <%# Eval("dr_forename") %> <%# Eval("dr_surname") %>
                                            </div>
                                            <div class="col-2 mx-auto" onclick="EnGetScID('<%# Eval("ds_id") %>')">
                                                <span class="ti-medall ti-3x" style="color: gold; text-shadow: 4px 4px 4px #808080"></span>
                                            </div>
                                            <%--<div class="col-2 mx-auto" onclick="EnGetScIDAuto('<%# Eval("ds_id") %>')">
                                                <span class="ti-medall ti-3x" style="color: green; text-shadow: 4px 4px 4px #808080"></span>
                                            </div>--%>
                                            <div class="col-12 mx-auto" onmouseover="GetScID('<%# Eval("ds_id") %>')" data-toggle="modal" data-target="#modalSchedule">
                                                <table style="width: 100%" border="1">
                                                    <tr class="text-center">
                                                        <td style="width: 14.28%">อา.</td>
                                                        <td style="width: 14.28%">จ.</td>
                                                        <td style="width: 14.28%">อ.</td>
                                                        <td style="width: 14.28%">พ.</td>
                                                        <td style="width: 14.28%">พฤ.</td>
                                                        <td style="width: 14.28%">ศ.</td>
                                                        <td style="width: 14.28%">ส.</td>
                                                    </tr>
                                                    <tr class="text-center">
                                                        <td><%# Eval("ds_sunday") %></td>
                                                        <td><%# Eval("ds_monday") %></td>
                                                        <td><%# Eval("ds_tuesday") %></td>
                                                        <td><%# Eval("ds_wednesday") %></td>
                                                        <td><%# Eval("ds_thursday") %></td>
                                                        <td><%# Eval("ds_friday") %></td>
                                                        <td><%# Eval("ds_saturday") %></td>
                                                    </tr>
                                                </table>
                                            </div>  
                                            <div class="row col-12 mx-auto mt-2">
                                                <div class="col-6 mx-auto text-left">
                                                    <button id="btn_manual_<%# Eval("ds_id") %>" class="btn btn-outline-primary" onclick="UpdateManual('<%# Eval("ds_id") %>','<%# Eval("ds_status") %>')" data-toggle="modal" data-target="#modalManual">
                                                        <%# Eval("ds_status") %>
                                                    </button>
                                                </div>
                                                <div class="col-6 mx-auto my-auto text-right">
                                                    <label class="switch">
                                                        <input type="checkbox" name="CB_ActiveN_<%# Eval("ds_id") %>" id="CB_Active_<%# Eval("ds_id") %>" <%# Eval("ds_script") %> onclick="UpdateActive('<%# Eval("ds_id") %>', '<%# Eval("ds_active") %>')" data-toggle="modal" data-target="#modalActive" />
                                                        <span class="slider round"></span>
                                                    </label> Active
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:ListView>
                    </div>

                    <div hidden="hidden">
                        <input type="text" id="txtH_scid" value="" runat="server" />
                        <input type="text" id="txt_active" value="yes" runat="server" />
                        <button id="btn_active" onserverclick="btn_active_ServerClick" runat="server"></button>
                    </div>

                </ContentTemplate>
                <%--<Triggers>
                    <asp:AsyncPostBackTrigger ControlID="DD_Department" />
                </Triggers>--%>
            </asp:UpdatePanel>
        </div>
    </div>

<script>
    function fn_active() {
        __doPostBack('<%= btn_active.UniqueID %>', '');
    }
</script>

<!-- Modal Manual -->
<div class="modal fade" id="modalManual" tabindex="-1" role="dialog" aria-labelledby="modalManualTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header bg-warning">
        <h5 class="modal-title" id="modalManualTitle">Confirm</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        คุณต้องการปิดสถานะ <asp:Label ID="lbl_manual" Text="" Font-Size="X-Large" ForeColor="Blue" runat="server"></asp:Label> ใช่หรือไม่ ?
          <div hidden="hidden">
              <input type="text" id="txtH_manualId" value="" runat="server" />
              <input type="text" id="txtH_manualstatus" value="" runat="server" />
          </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-outline-secondary" data-dismiss="modal">ไม่</button>
        <button type="button" id="btn_updateManual" class="btn btn-outline-primary" onserverclick="btn_updateManual_ServerClick" runat="server">ใช่</button>
      </div>
    </div>
  </div>
</div>
<!-- Modal Active -->
<div class="modal fade" id="modalActive" tabindex="-1" role="dialog" aria-labelledby="modalActiveTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header bg-warning">
        <h5 class="modal-title" id="modalActiveTitle">Confirm</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        คุณต้องการเปลี่ยนสถานะ active เป็น <asp:Label ID="lbl_active" Text="" Font-Size="X-Large" ForeColor="Blue" runat="server"></asp:Label> ใช่หรือไม่ ?
          <div hidden="hidden">
              <input type="text" id="txtH_activeId" value="" runat="server" />
              <input type="text" id="txtH_activestatus" value="" runat="server" />
          </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-outline-secondary" data-dismiss="modal">ไม่</button>
        <button type="button" id="btn_updateActive" class="btn btn-outline-primary" onserverclick="btn_updateActive_ServerClick" runat="server">ใช่</button>
      </div>
    </div>
  </div>
</div>
    <!-- Modal Image -->
<div class="modal fade" id="modalImage" tabindex="-1" role="dialog" aria-labelledby="modalImageTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header bg-primary">
        <h5 class="modal-title" id="modalImageTitle">Edit Image</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
          <asp:FileUpload ID="FileUpload1" AllowMultiple="false"  runat="server" />
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-outline-secondary" data-dismiss="modal">Close</button>
        <button type="button" id="btn_uploadImage" class="btn btn-outline-primary" onserverclick="btn_uploadImage_ServerClick" runat="server">Save</button>
      </div>
    </div>
  </div>
</div>
<!-- Modal Schedule -->
<div class="modal fade" id="modalSchedule" tabindex="-1" role="dialog" aria-labelledby="modalScheduleTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header bg-warning">
        <h5 class="modal-title" id="modalScheduleTitle">คุณต้องการ Update Schedule ใช่หรือไม่ ?</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-outline-secondary" data-dismiss="modal">ไม่</button>
        <button type="button" id="btn_Schedule" class="btn btn-outline-primary" onserverclick="btn_Schedule_ServerClick" data-toggle="modal" data-target="#modalUpdateSchedule" data-dismiss="modal" runat="server">ใช่</button>
      </div>
    </div>
  </div>
</div>
<!-- Modal Update Schedule -->
<div class="modal fade" id="modalUpdateSchedule" tabindex="-1" role="dialog" aria-labelledby="modalUpdateScheduleTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header bg-primary">
        <h5 class="modal-title" id="modalUpdateScheduleTitle" style="color:white;">Update Schedule</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
          <asp:UpdatePanel ID="UpdatePanel_Schedule" runat="server">
              <ContentTemplate>
                  <div class="row col-12 mx-auto">
                      <div class="col-2 mx-auto my-auto">
                          อา.
                      </div>
                      <div class="col-4 mx-auto">
                          <input type="time" id="time_sun_start" value="" class="form-control" runat="server" />
                      </div>
                      <div class="col-4 mx-auto">
                          <input type="time" id="time_sun_finish" value="" class="form-control" runat="server" />
                      </div>
                  </div>
                  <div class="row col-12 mx-auto">
                      <div class="col-2 mx-auto my-auto">
                          จ.
                      </div>
                      <div class="col-4 mx-auto">
                          <input type="time" id="time_mon_start" value="" class="form-control" runat="server" />
                      </div>
                      <div class="col-4 mx-auto">
                          <input type="time" id="time_mon_finish" value="" class="form-control" runat="server" />
                      </div>
                  </div>
                  <div class="row col-12 mx-auto">
                      <div class="col-2 mx-auto my-auto">
                          อ.
                      </div>
                      <div class="col-4 mx-auto">
                          <input type="time" id="time_tue_start" value="" class="form-control" runat="server" />
                      </div>
                      <div class="col-4 mx-auto">
                          <input type="time" id="time_tue_finish" value="" class="form-control" runat="server" />
                      </div>
                  </div>
                  <div class="row col-12 mx-auto">
                      <div class="col-2 mx-auto my-auto">
                          พ.
                      </div>
                      <div class="col-4 mx-auto">
                          <input type="time" id="time_wen_start" value="" class="form-control" runat="server" />
                      </div>
                      <div class="col-4 mx-auto">
                          <input type="time" id="time_wen_finish" value="" class="form-control" runat="server" />
                      </div>
                  </div>
                  <div class="row col-12 mx-auto">
                      <div class="col-2 mx-auto my-auto">
                          พฤ.
                      </div>
                      <div class="col-4 mx-auto">
                          <input type="time" id="time_thu_start" value="" class="form-control" runat="server" />
                      </div>
                      <div class="col-4 mx-auto">
                          <input type="time" id="time_thu_finish" value="" class="form-control" runat="server" />
                      </div>
                  </div>
                  <div class="row col-12 mx-auto">
                      <div class="col-2 mx-auto my-auto">
                          ศ.
                      </div>
                      <div class="col-4 mx-auto">
                          <input type="time" id="time_fri_start" value="" class="form-control" runat="server" />
                      </div>
                      <div class="col-4 mx-auto">
                          <input type="time" id="time_fri_finish" value="" class="form-control" runat="server" />
                      </div>
                  </div>
                  <div class="row col-12 mx-auto">
                      <div class="col-2 mx-auto my-auto">
                          ส.
                      </div>
                      <div class="col-4 mx-auto">
                          <input type="time" id="time_sat_start" value="" class="form-control" runat="server" />
                      </div>
                      <div class="col-4 mx-auto">
                          <input type="time" id="time_sat_finish" value="" class="form-control" runat="server" />
                      </div>
                  </div>
              </ContentTemplate>
              <Triggers>
                  <asp:AsyncPostBackTrigger ControlID="btn_Schedule" />
              </Triggers>
          </asp:UpdatePanel>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-outline-secondary" data-dismiss="modal">Close</button>
        <button type="button" id="btn_updateSchedule" class="btn btn-outline-primary" onserverclick="btn_updateSchedule_ServerClick" runat="server">Save</button>
      </div>
    </div>
  </div>
</div>
<!-- Modal Add Doctor -->
<div class="modal fade" id="modalAddDoctor" tabindex="-1" role="dialog" aria-labelledby="modalAddDoctorTitle" aria-hidden="true">
  <div class="modal-dialog modal-xl" role="document">
    <div class="modal-content">
      <div class="modal-header bg-warning">
        <h5 class="modal-title" id="modalAddDoctorTitle">Add New Doctor</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
          <div class="row col-12 mx-auto">
              <div class="col-6 mx-auto my-2">
                  <input type="number" id="txt_doctorid" class="form-control" value="" placeholder="หมายเลข ว." onkeyup="fn_username()" runat="server" />
              </div>
              <div class="col-6 mx-auto my-2">
                  <input type="text" id="txt_doctoruser" class="form-control" value="" placeholder="Username" runat="server" disabled="disabled" />
              </div>
              <div class="col-6 mx-auto my-2">
                  <input type="text" id="txt_fname" class="form-control" value="" placeholder="ชื่อ" runat="server" />
              </div>
              <div class="col-6 mx-auto my-2">
                  <input type="text" id="txt_lname" class="form-control" value="" placeholder="นามสกุล" runat="server" />
              </div>
              <div class="col-6 mx-auto my-2">
                  <input type="text" id="txt_fname_eg" class="form-control" value="" placeholder="Name" runat="server" />
              </div>
              <div class="col-6 mx-auto my-2">
                  <input type="text" id="txt_lname_eg" class="form-control" value="" placeholder="Last name" runat="server" />
              </div>
          </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-outline-secondary" data-dismiss="modal">Cancel</button>
        <button type="button" id="btn_adddoctor" class="btn btn-outline-primary" onserverclick="btn_adddoctor_ServerClick" runat="server">Save</button>
      </div>
    </div>
  </div>
</div>
<script>
    function fn_username() {
        var drid = document.getElementById('<%= txt_doctorid.ClientID %>');
        var user = document.getElementById('<%= txt_doctoruser.ClientID %>');
        user.value = drid.value;
    }
</script>

<style>
    .btnShowQueue {
        cursor: pointer;
        height: 60px;
        top: 40%; left: auto; right: 0;  
        border-top-left-radius:10px; 
        border-bottom-left-radius:10px;
    }
    .btnAddQueue {
        cursor: pointer;
        height: 60px;
        top: 50%; left: auto; right: 0;  
        border-top-left-radius:10px; 
        border-bottom-left-radius:10px;
    }
    .btnLinkScore {
        cursor: pointer;
        height: 60px;
        top: 60%; left: auto; right: 0;  
        border-top-left-radius:10px; 
        border-bottom-left-radius:10px;
    }
</style>
<a class="btn btn-warning fixed-bottom btnShowQueue" data-toggle="modal" data-target="#Modal_ShowQueue"><i class="ti-2x ti-agenda"></i></a>
<a class="btn btn-info fixed-bottom btnAddQueue" data-toggle="modal" data-target="#Modal_AddQueue"><i class="ti-2x ti-pencil"></i></a>
<a class="btn btn-outline-primary fixed-bottom btnLinkScore" id="a_linkscore" target="_blank" runat="server"><i class="ti-2x ti-link"></i></a>

<!-- Modal Show Queue -->
<div class="modal right fade" id="Modal_ShowQueue" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document" style="max-width: 100%; top: 0; left: auto; right: 0;">
        <div class="modal-content" style="background-color:white;">
            <div class="modal-body">
                <asp:UpdatePanel ID="UpdatePanel_Queue" runat="server">
                    <ContentTemplate>
                        <div class="col-12 mx-auto my-2 text-right">
                            <a id="btn_loadQueue" style="cursor: pointer;" onserverclick="btn_loadQueue_ServerClick" runat="server"><i class="fa fa-refresh"></i> Refresh</a>
                        </div>
                        <iframe id="iframe_queue" src="../Queue/myWebForm.aspx" class="row col-12 mx-auto" style="position: fixed; height: 100%; overflow-y: auto;" runat="server"></iframe>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>
</div>
<!-- Modal Add Queue -->
<div class="modal right fade" id="Modal_AddQueue" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document" style="max-width: 100%; top: 0; left: auto; right: 0;">
        <div class="modal-content" style="background-color:white;">
            <div class="modal-body">
                <%--<asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>--%>
                        <div class="card mx-auto" style="position: absolute; top: 30%;">
                            <div class="col-12 mx-auto mb-5 h1">
                                เพิ่ม Queue ใหม่
                            </div>
                            <div class="row col-12 mx-auto" style="font-size: large;">
                                <div class="col-6 mx-auto my-2">
                                    <input id="txtAdd_fname" class="form-control" placeholder="ชื่อ First Name" value="" runat="server" />
                                </div>
                                <div class="col-6 mx-auto my-2">
                                    <input id="txtAdd_lname" class="form-control" placeholder="นามสกุล Last Name" value="" runat="server" />
                                </div>
                                <div class="row col-lg-6 col-sm-12 mx-auto my-2">
                                    <div class="col-4 mx-auto my-auto" style="font-size: xx-large">
                                        เพศ<br /><span style="font-size: large;">Gender</span>
                                    </div>
                                    <div class="col-4 mx-auto" style="font-size: xx-large">
                                        <input type="radio" name="rd_gender" id="rd_male" value="male" runat="server" /> ชาย<br /><span style="font-size: large;">male</span>
                                    </div>
                                    <div class="col-4 mx-auto" style="font-size: xx-large">
                                        <input type="radio" name="rd_gender" id="rd_female" value="female" runat="server" /> หญิง<br /><span style="font-size: large;">female</span>
                                    </div>
                                </div>
                                <div class="row col-lg-6 col-sm-12 mx-auto my-2">
                                    <div class="col-9 mx-auto">
                                        <input type="number" id="txtAdd_age" class="form-control" placeholder="อายุ Age" value="" runat="server" />
                                    </div>
                                    <div class="col-3 mx-auto">ปี<br />Year</div>
                                </div>
                            </div>
                            <div class="col-12 mx-auto mt-3 text-center">
                                <button id="btn_addQueue" class="btn btn-outline-primary" runat="server" data-dismiss="modal" onserverclick="btn_addQueue_ServerClick">Add Queue</button>
                            </div>
                        </div>
                    <%--</ContentTemplate>
                </asp:UpdatePanel>--%>
            </div>
        </div>
    </div>
</div>

<script>
    function UpdateManual(id,status) {
        var txtID = document.getElementById('<%= txtH_manualId.ClientID %>');
        txtID.value = id;
        var txtStatus = document.getElementById('<%= txtH_manualstatus.ClientID %>');
        txtStatus.value = status;
        var lbl = document.getElementById('<%= lbl_manual.ClientID %>');
        lbl.innerText = status;
    }

    function UpdateActive(id, status) {

        var oldBtn = document.getElementById('CB_Active_' + id);
        
        if (status == 'yes') {
            oldBtn.checked = true;
            status = 'no'
        }
        else {
            oldBtn.checked = false;
            status = 'yes'
        }
        var txtID = document.getElementById('<%= txtH_activeId.ClientID %>');
        txtID.value = id;
        var txtStatus = document.getElementById('<%= txtH_activestatus.ClientID %>');
        txtStatus.value = status;
        var lbl = document.getElementById('<%= lbl_active.ClientID %>');
        lbl.innerText = status;
    }

    function GetScID(scid) {
        var txt = document.getElementById('<%= txtH_scid.ClientID %>');
        txt.value = scid;
    }
    function ImageGetScID(scid) {
        var txt = document.getElementById('<%= txtH_scid.ClientID %>');
        txt.value = scid;
    }
    function EnGetScID(scid) {
        var txt = document.getElementById('<%= txtH_scid.ClientID %>');
        txt.value = scid;
        windowPopup("/GoodDoctor/InputENRating.aspx?sc=" + scid, "Register En for Rating", 250, 200);
    }
    function EnGetScIDAuto(scid) {
        var txt = document.getElementById('<%= txtH_scid.ClientID %>');
        txt.value = scid;
        windowPopup("/GoodDoctor/InputENRating.aspx?sc=" + scid, "Register En for Rating", 250, 200);
    }
</script>

<asp:Label ID="lbl_Modal" Text="" runat="server"></asp:Label>

</asp:Content>
