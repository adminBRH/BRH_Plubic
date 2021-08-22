<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MeetingRoom.aspx.cs" Inherits="BRH_Plubic.MeetingRoom" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">

    <div class="row col-10 mx-auto my-5" style="background-color: lightblue;">
        <div class="col-6 mx-auto text-left">
            <a href="CheckinMeetingReport.aspx" style="cursor: pointer; font-size: x-large; font-weight: bold; text-shadow: 2px 2px 2px #808080;">
                <i class="fa fa-dashboard fa-2x" style="color: mediumpurple;"></i> Dashboard
            </a>
        </div>
        <div class="col-6 mx-auto my-auto text-right">
            <a href="#" id="a_book" onclick="ShowBook()">
                <asp:Label ID="lbl_book" Text="จองห้องประชุม +" Font-Size="X-Large" runat="server"></asp:Label>
            </a>
        </div>
    </div>
    <div id="div_add" class="col-lg-8 col-sm-12 mx-auto h3" hidden="hidden">
        <div class="row col-12 mx-auto mb-5">
            <div class="col-12 mx-auto">
                <input name="txth_header" type="text" id="txt_sj" placeholder="หัวข้อการประชุม" required="required" value="" class="form-control mb-5" runat="server" />
            </div>
            <div class="col-lg-5 col-sm-12 mx-auto">
                <input type="date" id="date_start" required="required" onchange="SetYearFormat('start')" runat="server" />
                <input type="time" min="06:00" max="18:00" id="time_start" value="" onchange="SetYearFormat('start')" onmouseout="SecondZero('start')" onclick="" runat="server" />
            </div>
            <div class="col-2 mx-auto text-center">
                To
            </div>
            <div class="col-lg-5 col-sm-12 mx-auto">
                <input type="date" id="date_end" required="required" onchange="SetYearFormat('end')" runat="server" />
                <input type="time"  min="06:00" max="18:00" id="time_end" value="" onchange="SetYearFormat('end')" onmouseout="SecondZero('end')" runat="server" />
            </div>
        </div>

        <script>
            function SetYearFormat(evn) {
                var Startdate = document.getElementById('<%= date_start.ClientID %>');
                var Starttime = document.getElementById('<%= time_start.ClientID %>');
                var Enddate = document.getElementById('<%= date_end.ClientID %>');
                var Endtime = document.getElementById('<%= time_end.ClientID %>');
                var D = new Date();
                var year = D.getFullYear();
                var SetYear = '';

                if (Startdate.value > Enddate.value ) {
                    Enddate.value = Startdate.value;
                    Endtime.value = Starttime.value;
                }
                else {
                    
                    if (Starttime.value > Endtime.value) {
                        Endtime.value = Starttime.value;
                    }
                }

                if (evn == 'start') {
                    if (Startdate.value != '') {
                        var stDate = Startdate.value.split('-');
                        if (parseInt(stDate[0]) > parseInt(year)) {
                            var YearSet = parseInt(stDate[0]) - 543;
                            SetYear = YearSet + '-' + stDate[1] + '-' + stDate[2];
                            Startdate.value = SetYear;
                        }
                    }
                }
                if (evn == 'end') {
                    if (Enddate.value != '') {
                        var enDate = Enddate.value.split('-');
                        if (parseInt(enDate[0]) > parseInt(year)) {
                            var YearSet = parseInt(enDate[0]) - 543;
                            SetYear = YearSet + '-' + enDate[1] + '-' + enDate[2];
                            Enddate.value = SetYear;
                        }
                    }
                }
            }

            function SecondZero(time_event) {
                var time;
                if (time_event == 'start') {
                    time = document.getElementById('<%= time_start.ClientID %>');
                } else {
                    time = document.getElementById('<%= time_end.ClientID %>');
                }
                var timeAR = time.value.split(':');
                time.value = timeAR[0] + ':' + timeAR[1] + ':00';
            }
        </script>

        <div class="row col-12 mx-auto mb-3">
            <div class="row col-lg-4 col-sm-12 my-3">
                <div class="col-auto my-auto">
                    <label class="switch">
                        <input type="checkbox" name="cbroom" id="CB_room1" class="my-auto" value="1" onclick="CheckRoom('1')" runat="server" />
                        <span class="slider round my-auto"></span>
                    </label>
                </div>
                <div class="col-auto my-auto">ห้องประชุม 1</div>
            </div>
            <div class="row col-lg-4 col-sm-12 my-3">
                <div class="col-auto my-auto">
                    <label class="switch">
                        <input type="checkbox" name="cbroom" id="CB_room2" value="2" onclick="CheckRoom('2')" runat="server" />
                        <span class="slider round"></span>
                    </label>
                </div>
                <div class="col-auto my-auto">ห้องประชุม 2</div>
            </div>
            <div class="row col-lg-4 col-sm-12 my-3">
                <div class="col-auto my-auto">
                    <label class="switch">
                        <input type="checkbox" name="cbroom" id="CB_room3" value="3" onclick="CheckRoom('3')" runat="server" />
                        <span class="slider round"></span>
                    </label>
                </div>
                <div class="col-auto my-auto">ห้องประชุม 3</div>
            </div>
            <div class="row col-lg-4 col-sm-12 my-3">
                <div class="col-auto my-auto">
                    <label class="switch">
                        <input type="checkbox" name="cbroom" id="CB_room4" value="4" onclick="CheckRoom('4')" runat="server" />
                        <span class="slider round"></span>
                    </label>
                </div>
                <div class="col-auto my-auto">ห้องประชุม 4</div>
            </div>
            <div class="row col-lg-4 col-sm-12 my-3">
                <div class="col-auto my-auto">
                    <label class="switch">
                        <input type="checkbox" name="cbroom" id="CB_room5" value="5" onclick="CheckRoom('5')" runat="server" />
                        <span class="slider round"></span>
                    </label>
                </div>
                <div class="col-auto my-auto">ห้องประชุม 5</div>
            </div>
        </div>
        <div hidden="hidden" >
            <input type="text" id="txth_room" value="1" runat="server" />
        </div>
        <div class="mx-auto text-center">
            <asp:Button ID="btn_submit" CssClass="btn btn-light mx-auto text-center mt-5" Text="SUBMIT" runat="server" OnClick="btn_submit_Click"/>
        </div>
    </div>

    <div id="div_list" class="col-lg-11 col-sm-12 mx-auto">
        <div class="col-12 mx-auto text-center mt-5" style="font-size:x-large;">
            <div class="row col-12">
                <div class="col-5 mx-auto my-auto text-center">
                    วันเวลา <i class="ti ti-filter" data-toggle="modal" data-target="#modalDateTime" style="cursor: pointer;"></i>
                    <hr style="border-width:5px; background-color:gold;"/>
                </div>
                <div class="col-5 mx-auto my-auto text-center">
                    หัวข้อการประชุม <i class="ti ti-filter" data-toggle="modal" data-target="#modalTopic" style="cursor: pointer;"></i>
                    <hr style="border-width:5px; background-color:gold;"/>
                </div>
                <div class="col-2 mx-auto my-auto text-center">
                    ห้องประชุม
                    <hr style="border-width:5px; background-color:gold;"/>
                </div>
            </div>
        </div>

        <asp:ListView ID="LV_book" DataKeyNames="cms_id" runat="server">
            <LayoutTemplate>
                <div id="itemPlaceholder" runat="server"></div>
            </LayoutTemplate>
            <ItemTemplate>
                <div class="col-12 card boxShadow rounded mx-auto my-2" style="font-size:x-large;">
                    <div class="row col-12" onclick="goto('<%# Eval("cms_id") %>','<%# Eval("cms_room") %>')">
                        <div class="col-5 mx-auto my-auto">
                            <div id="div_time_<%# Eval("cms_id") %>" class="row col-12 bg-<%# Eval("dateCoclor") %> rounded text-center" style="color:white; cursor: pointer;">
                                <div class="col-12"><%# Eval("dateStart") %> - <%# Eval("dateEnd") %></div>
                                <div class="col-12"><%# Eval("timeStart") %> - <%# Eval("timeEnd") %></div>
                            </div>
                        </div>
                        <div class="col-5 mx-auto my-auto text-center">
                            <%# Eval("cms_sj") %>
                        </div>
                        <div class="col-2 mx-auto my-auto text-center">
                            <div class="circle-icon my-auto"><%# Eval("cms_room") %></div>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:ListView>
        <script>
            function goto(slot, room) {
                window.location.href = 'CheckinMeeting?slot=' + slot + '&room=' + room;
            }
        </script>
    </div>

<!-- Modal DateTime -->
<div class="modal fade" id="modalDateTime" tabindex="-1" role="dialog" aria-labelledby="modalDateTimeTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
    <div class="modal-content border-0">
      <div class="modal-header bg-primary" style="color:white">
        <h3 class="modal-title" id="modalDateTimeTitle">ค้นหาจาก วัน</h3>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body bg-light">
          <div class="row col-12 mx-auto h3">
              <div class="col-12 mx-auto my-auto text-right">
                  <div class="btn btn-outline-danger col-2 mx-auto text-center" onclick="ClearDateSearch()">Clear <i class="ti-filter"></i></div>
              </div>
              <div class="col-6 mx-auto my-auto text-center">
                  วันที่เริ่มต้น<br /><input type="date" id="txt_dateStart" value ="" onchange="CheckDateSearch()" class="bg-info rounded" runat="server" />
              </div>
              <div class="col-6 mx-auto my-auto text-center">
                 วันที่สิ้นสุด<br /><input type="date" id="txt_dateEnd" value ="" onchange="CheckDateSearch()" class="bg-info rounded" runat="server" />
              </div>
              <script>
                  function CheckDateSearch() {
                      var dateStart = document.getElementById('<%= txt_dateStart.ClientID %>');
                      var dateEnd = document.getElementById('<%= txt_dateEnd.ClientID %>');
                      if (dateStart.value != '') {
                          if (dateEnd.value == '') {
                              dateEnd.value = dateStart.value;
                          }
                          else {
                              if (dateEnd.value < dateStart.value) {
                                  dateEnd.value = dateStart.value;
                              }
                          }
                      }
                  }
                  function ClearDateSearch() {
                      var dateStart = document.getElementById('<%= txt_dateStart.ClientID %>');
                      var dateEnd = document.getElementById('<%= txt_dateEnd.ClientID %>');
                      dateStart.value = "";
                      dateEnd.value = "";
                  }
              </script>
          </div>
      </div>
      <div class="modal-footer">
        <button type="button" id="btn_Search" class="btn btn-outline-primary" onserverclick="btn_Search_ServerClick" runat="server"><i class="ti-2x ti-search"></i></button>
      </div>
    </div>
  </div>
</div>

<!-- Modal Topic -->
<div class="modal fade" id="modalTopic" tabindex="-1" role="dialog" aria-labelledby="modalTopicTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
    <div class="modal-content border-0">
      <div class="modal-header bg-primary" style="color:white">
        <h3 class="modal-title" id="modalTopicTitle">ค้นหาจาก หัวข้อการประชุม</h3>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body bg-light">
          <div class="row col-12 mx-auto h3">
              <div class="col-12 mx-auto mb-3 text-right">
                  <div class="btn btn-outline-danger col-2 mx-auto text-center" onclick="ClearTopicSearch()">Clear <i class="ti-filter"></i></div>
              </div>
              <div class="col-lg-3 col-sm-5 mx-auto my-auto text-right">
                  คำที่ต้องการค้นหา
              </div>
              <div class="col-lg-9 col-sm-7 mx-auto my-auto text-left">
                 <input type="text" id="txt_topic" value ="" class="form-control col-10" runat="server" />
              </div>
          </div>
          <script>
              function ClearTopicSearch() {
                  var txtTopic = document.getElementById('<%= txt_topic.ClientID %>');
                  txtTopic.value = "";
              }
          </script>
      </div>
      <div class="modal-footer">
        <button type="button" id="btn_SearchTopic" class="btn btn-outline-primary" onserverclick="btn_Search_ServerClick" runat="server"><i class="ti-2x ti-search"></i></button>
      </div>
    </div>
  </div>
</div>

<script>
    var cb_r1 = document.getElementById('<%= CB_room1.ClientID %>');
    var cb_r2 = document.getElementById('<%= CB_room2.ClientID %>');
    var cb_r3 = document.getElementById('<%= CB_room3.ClientID %>');
    var cb_r4 = document.getElementById('<%= CB_room4.ClientID %>');
    var cb_r5 = document.getElementById('<%= CB_room5.ClientID %>');       

    function CheckRoom(room) {
        var r = document.getElementById('<%= txth_room.ClientID %>'); 
        r.value = room;

        cb_r1.checked = false;
        cb_r2.checked = false;
        cb_r3.checked = false;
        cb_r4.checked = false;
        cb_r5.checked = false;
           
        if (room == '1') {
            cb_r1.checked = true;
        }
        if (room == '2') {
            cb_r2.checked = true;
        }
        if (room == '3') {
            cb_r3.checked = true;
        }
        if (room == '4') {
            cb_r4.checked = true;
        }
        if (room == '5') {
            cb_r5.checked = true;
        }

    }

</script>

<script>
    var divAdd = document.getElementById('div_add');
    var divList = document.getElementById('div_list');
    var linkBook = document.getElementById('<%= lbl_book.ClientID %>');
    function ShowBook() {
        if (divAdd.hidden == true) {
            divAdd.hidden = false;
            divList.hidden = true;
            linkBook.innerText = "รายการที่มีการจองเข้ามา";
        }
        else {
            divAdd.hidden = true;
            divList.hidden = false;
            linkBook.innerText = "จองห้องประชุม +";
        }
            
    }
</script>

</asp:Content>
