<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="BRH_Plubic.QER.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">

<style>
.Mycircle {
  height: 40px;
  width: 60px;
  background-color: #0094ff;
  border-radius: 20%;
  display: inline-block;
  box-shadow: rgb(128, 128, 128) 2px 2px;
  color:white;
  text-shadow: 1px 1px 1px #000000;
}
.iconSize{
    width: 30px;
    height: 30px;
}
.iconSizeSelected{
    width: 40px;
    height: 40px;
    background-color: #0094ff;
    border-radius: 50%;
    display: inline-block;
}
</style>

<script>
    function ImgIcon(id, title) {
        var name = 'img/' + id + '.png';
        var img = '<a href="#" id="a_icon_' + id + '" onclick="getStatusID(' + id + ')"><img src="' + name + '" class="iconSize" data-toggle="tooltip" data-placement="right" title="' + title + '"/></a>';
        document.write(img);
    }
</script>

    <asp:ScriptManager ID="script_manager1" runat="server"></asp:ScriptManager>
     <div class="row mx-auto my-auto bg">
          <div class="col-2 card bg">
              <div class="card mt-2">                     
                      <div class="card-body col-12 my-auto">
                          <asp:UpdatePanel ID="UpdatePanel_ListQ" runat="server">
                              <ContentTemplate>
                             <asp:ListView ID="List_Q" runat="server">
                                      <LayoutTemplate>
                                         <div class="row col-12 mx-auto" id="itemPlaceholder" runat="server"></div>
                                      </LayoutTemplate>
                                      <ItemTemplate>
                                          <div class="mx-auto my-auto text-center Mycircle" style="background-color:<%# Eval("qer_triage_color") %>;"><%# Eval("qer_qnumber") %></div>                              
                                      </ItemTemplate>
                            </asp:ListView>     
                          <asp:Timer ID="TimerQ" OnTick="TimerQ_Tick" Interval="10000" runat="server"></asp:Timer>
                             </ContentTemplate>
                              <Triggers>
                                  <asp:AsyncPostBackTrigger ControlID="TimerQ" />
                              </Triggers>
                          </asp:UpdatePanel>
                      </div>
              </div>          
          </div>
         

          <!-- เตียงแถวหนึ่ง -->
          <div class="col-10 card bg">
              <div class="row mt-2 bg">

                  <div class="col-3  ">
                    <div class="card">
                        <div class="row col-12 mx-auto my-auto">
                            <div class="col-3 mx-auto my-auto text-left">                               
                                <a href="#" id="status_success1" onserverclick="status_success_ServerClick" onmouseover="getStatusSuccess('Bed 1','1')" data-toggle="modal" data-target="#modalMove" runat="server">
                                    <label id="lbl_bed1" class="mx-auto my-auto text-center Mycircle" runat="server" style="font-size:x-large">
                                        <asp:Label ID="lbl_queue_1" Text="" runat="server"></asp:Label>
                                    </label>
                                </a>
                            </div>
                            <div class="col-9 text-right my-auto" style="font-size:large">
                                <asp:Label ID="lbl_iconstatus_1" Text="" runat="server"></asp:Label>
                            </div>
                            <div class="col-12 mx-auto my-auto">
                                <hr />
                                <button class="border-0 bg-transparent" id="add_bed1" onserverclick="add_bed_ServerClick" onmouseover="getBedID('1')" runat="server">
                                    <img src="../QER/img/bed.png" style="width:40px;height:40px;"/>
                                    <span class="badge-primary rounded h5">&nbsp;Bed 1&nbsp;</span>
                                </button>
                            </div>
                        </div>  
                    </div>
                  </div>

                  <div class="col-3 ">
                    <div class="card">
                        <div class="row col-12 mx-auto my-auto">
                            <div class="col-3 mx-auto my-auto text-left"> 
                                <a href="#" id="status_success2" onserverclick="status_success_ServerClick" onmouseover="getStatusSuccess('Bed 2','2')" data-toggle="modal" data-target="#modalMove" runat="server">
                                <label id="lbl_bed2" class="mx-auto my-auto text-center Mycircle" runat="server" style="font-size:x-large">
                                    <asp:Label ID="lbl_queue_2" Text="" runat="server"></asp:Label>
                                </label>
                                </a>
                            </div>
                            <div class="col-9 text-right my-auto" style="font-size:large">
                                <asp:Label ID="lbl_iconstatus_2" Text="" runat="server"></asp:Label>
                            </div>
                            <div class="col-12 mx-auto my-auto">
                                <hr />
                                <button class="border-0 bg-transparent" id="add_bed2" value="2" onserverclick="add_bed_ServerClick" onmouseover="getBedID('2')" runat="server">
                                    <img src="../QER/img/bed.png" style="width:40px;height:40px;"/>
                                    <span class="badge-primary rounded h5">&nbsp;Bed 2&nbsp;</span>
                                </button>
                            </div>
                        </div> 
                    </div>
                  </div>

                   <div class="col-3 ">
                    <div class="card">
                        <div class="row col-12 mx-auto my-auto">
                            <div class="col-3 mx-auto my-auto text-left"> 
                                <a href="#" id="status_success3" onserverclick="status_success_ServerClick" onmouseover="getStatusSuccess('Bed 3','3')" data-toggle="modal" data-target="#modalMove" runat="server">
                                <label id="lbl_bed3" class="mx-auto my-auto text-center Mycircle" runat="server" style="font-size:x-large">
                                    <asp:Label ID="lbl_queue_3" Text="" runat="server"></asp:Label>
                                </label>
                                </a>
                            </div>
                            <div class="col-9 text-right my-auto" style="font-size:large">
                                <asp:Label ID="lbl_iconstatus_3" Text="" runat="server"></asp:Label>
                            </div>
                            <div class="col-12 mx-auto my-auto">
                                <hr />
                                <button class="border-0 bg-transparent" id="add_bed3" value="3" onserverclick="add_bed_ServerClick" onmouseover="getBedID('3')" runat="server">
                                    <img src="../QER/img/bed.png" style="width:40px;height:40px;"/>
                                    <span class="badge-primary rounded h5">&nbsp;Bed 3&nbsp;</span>
                                </button>
                            </div>
                        </div> 
                    </div>
                  </div>

                   <div class="col-3">
                    <div class="card">
                         <div class="row col-12 mx-auto my-auto">
                            <div class="col-3 mx-auto my-auto text-left"> 
                                <a href="#" id="status_success4" onserverclick="status_success_ServerClick" onmouseover="getStatusSuccess('Bed 4','4')" data-toggle="modal" data-target="#modalMove" runat="server">
                                <label id="lbl_bed4" class="mx-auto my-auto text-center Mycircle" runat="server" style="font-size:x-large">
                                    <asp:Label ID="lbl_queue_4" Text="" runat="server"></asp:Label>
                                </label>
                                </a>
                            </div>
                            <div class="col-9 text-right my-auto" style="font-size:large">
                                <asp:Label ID="lbl_iconstatus_4" Text="" runat="server"></asp:Label>
                            </div>
                            <div class="col-12 mx-auto my-auto">
                                <hr />
                                <button class="border-0 bg-transparent" id="add_bed4" value="4" onserverclick="add_bed_ServerClick" onmouseover="getBedID('4')" runat="server">
                                    <img src="../QER/img/bed.png" style="width:40px;height:40px;"/>
                                    <span class="badge-primary rounded h5">&nbsp;Bed 4&nbsp;</span>
                                </button>
                            </div>
                        </div> 
                    </div>
                  </div>
                  
                </div>
                <!-- End เตียงแถวหนึ่ง -->

                <!-- เตียงแถวสอง -->
               <div class="row mt-3 bg">
                   <div class="col-3">&nbsp;</div> 

                   <div class="col-6">  
                       <div class="card">
                          <div class="row col-12 mx-auto mt-2 mb-2">
                              <div class="col-6 mx-auto my-auto">
                                  <h3 class="card-title text-center"><img src="../QER/img/medical.png" style="width:40px;height:40px;"/>&nbsp; Manage Q</h3>
                                    <div class="text-center mx-auto"><input id="ip_q" class="form-control col-12" runat="server"/></div>    
                              </div>
                              <div class="col-6 mx-auto">   
                                  <asp:ListView ID="LV_btnStatus" runat="server">
                                      <LayoutTemplate>
                                          <a id="itemPlaceholder" runat="server"></a>
                                      </LayoutTemplate>
                                      <ItemTemplate>
                                          <!-- ================================================= Change Status ========================================================== -->
                                          <script> ImgIcon('<%# Eval("qer_list_id") %>','<%# Eval("qer_listname") %>'); </script>

                                      </ItemTemplate>
                                  </asp:ListView>
                                    
                                   <div class="dropdown text-center mx-auto mt-3">                         
                                   <asp:UpdatePanel ID="UpdatePanel_color" runat="server">

                                       <ContentTemplate>
                                           เลือกสีสำหรับ Update : 
                                           <asp:DropDownList ID="dd_color" AutoPostBack="true" runat="server">
                                               <asp:ListItem Text="" Value=""></asp:ListItem>  
                                           </asp:DropDownList>                     
                                        </ContentTemplate>
                                                                         
                                   </asp:UpdatePanel>      
             
                                   </div>   
                              </div>
                          </div>
                       </div>
                   </div> 
                     
                  
                  <div class="col-3 ">
                    <div class="card">
                        <div class="row col-12 mx-auto my-auto">
                            <div class="col-3 mx-auto my-auto text-left"> 
                                <a href="#" id="status_success5" onserverclick="status_success_ServerClick" onmouseover="getStatusSuccess('Bed 5','5')" data-toggle="modal" data-target="#modalMove" runat="server">
                                <label id="lbl_bed5" class="mx-auto my-auto text-center Mycircle" runat="server" style="font-size:x-large">
                                    <asp:Label ID="lbl_queue_5" Text="" runat="server"></asp:Label>
                                </label>
                                </a>
                            </div>
                            <div class="col-9 text-right my-auto" style="font-size:large">
                                <asp:Label ID="lbl_iconstatus_5" Text="" runat="server"></asp:Label>
                            </div>
                            <div class="col-12 mx-auto my-auto">
                                <hr />
                                <button class="border-0 bg-transparent" id="add_bed5" value="5" onserverclick="add_bed_ServerClick" onmouseover="getBedID('5')" runat="server">
                                    <img src="../QER/img/bed.png" style="width:40px;height:40px;"/>
                                    <span class="badge-primary rounded h5">&nbsp;Bed 5&nbsp;</span>
                                </button>
                            </div>
                        </div> 
                    </div>
                  </div> 

                </div>
              <!-- End เตียงแถวสอง -->
              
              <!-- เตียงแถวสาม -->
              <div class="row mt-3 bg">
                   <div class="col-3 ">   
                       <div class="card">
                                <div class="row col-12 mx-auto my-auto">
                            <div class="col-3 mx-auto my-auto text-left"> 
                                <a href="#" id="status_success13" onserverclick="status_success_ServerClick" onmouseover="getStatusSuccess('ห้องหัตถการ','13')" data-toggle="modal" data-target="#modalMove" runat="server">
                                <label id="lbl_bed_13" class="mx-auto my-auto text-center Mycircle" runat="server" style="font-size:x-large">
                                    <asp:Label ID="lbl_queue_13" Text="" runat="server"></asp:Label>
                                </label>
                                </a>
                            </div>
                            <div class="col-9 text-right my-auto" style="font-size:large">
                                <asp:Label ID="lbl_iconstatus_13" Text="" runat="server"></asp:Label>
                            </div>
                            <div class="col-12 mx-auto my-auto">
                                <hr />
                                <button class="border-0 bg-transparent" id="add_bed_13" value="13" onserverclick="add_bed_ServerClick" onmouseover="getBedID('13')" runat="server">
                                    <img src="../QER/img/bed.png" style="width:40px;height:40px;"/>
                                    <span class="badge-primary rounded h5">&nbsp;ห้องฟื้นคืนชีพ&nbsp;</span>
                                </button>
                            </div>
                        </div>    
                    </div>
                   </div> 
                   <div class="col-3">                 
                   </div> 
                   <div class="col-3">                   
                   </div>   
                  
                  <div class="col-3 ">
                    <div class="card">
                        <div class="row col-12 mx-auto my-auto">
                            <div class="col-3 mx-auto my-auto text-left"> 
                                <a href="#" id="status_success6" onserverclick="status_success_ServerClick" onmouseover="getStatusSuccess('Bed 6','6')" data-toggle="modal" data-target="#modalMove" runat="server">
                                <label id="lbl_bed6" class="mx-auto my-auto text-center Mycircle" runat="server" style="font-size:x-large">
                                    <asp:Label ID="lbl_queue_6" Text="" runat="server"></asp:Label>
                                </label>
                                </a>
                            </div>
                            <div class="col-9 text-right my-auto" style="font-size:large">
                                <asp:Label ID="lbl_iconstatus_6" Text="" runat="server"></asp:Label>
                            </div>
                            <div class="col-12 mx-auto my-auto">
                                <hr />
                                <button class="border-0 bg-transparent" id="add_bed6" value="6" onserverclick="add_bed_ServerClick" onmouseover="getBedID('6')" runat="server">
                                    <img src="../QER/img/bed.png" style="width:40px;height:40px;"/>
                                    <span class="badge-primary rounded h5">&nbsp;Bed 6&nbsp;</span>
                                </button>
                            </div>
                        </div> 
                    </div>
                  </div> 

                </div>
               <!-- End เตียงแถวสาม -->

              <!-- เตียงแถวสี่ -->
              
                  <div class="row mt-3 bg">
                      <div class="col-3 ">
                        <div class="card">
                            <div class="row col-12 mx-auto my-auto">
                                <div class="col-3 mx-auto my-auto text-left"> 
                                    <a href="#" id="status_success12" onserverclick="status_success_ServerClick" onmouseover="getStatusSuccess('Bed 12','12')" data-toggle="modal" data-target="#modalMove" runat="server">
                                    <label id="lbl_bed_12" class="mx-auto my-auto text-center Mycircle" runat="server" style="font-size:x-large">
                                        <asp:Label ID="lbl_queue_12" Text="" runat="server"></asp:Label>
                                    </label>
                                    </a>
                                </div>
                                <div class="col-9 text-right my-auto" style="font-size:large">
                                    <asp:Label ID="lbl_iconstatus_12" Text="" runat="server"></asp:Label>
                                </div>
                                <div class="col-12 mx-auto my-auto">
                                    <hr />
                                    <button class="border-0 bg-transparent" id="add_bed12" value="12" onserverclick="add_bed_ServerClick" onmouseover="getBedID('12')" runat="server">
                                        <img src="../QER/img/bed.png" style="width:40px;height:40px;"/>
                                        <span class="badge-primary rounded h5">&nbsp;ห้องหัตถการ&nbsp;</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                      </div>

                      <div class="col-3 ">
                       
                      </div>

                       <div class="col-3 ">
                     
                      </div>

                       <div class="col-3">
                        <div class="card">
                            <div class="row col-12 mx-auto my-auto">
                                <div class="col-3 mx-auto my-auto text-left"> 
                                    <a href="#" id="status_success7" onserverclick="status_success_ServerClick" onmouseover="getStatusSuccess('Bed 7','7')" data-toggle="modal" data-target="#modalMove" runat="server">
                                    <label id="lbl_bed7" class="mx-auto my-auto text-center Mycircle" runat="server" style="font-size:x-large">
                                        <asp:Label ID="lbl_queue_7" Text="" runat="server"></asp:Label>
                                    </label>
                                    </a>
                                </div>
                                <div class="col-9 text-right my-auto" style="font-size:large">
                                    <asp:Label ID="lbl_iconstatus_7" Text="" runat="server"></asp:Label>
                                </div>
                                <div class="col-12 mx-auto my-auto">
                                    <hr />
                                    <button class="border-0 bg-transparent" id="add_bed7" value="7" onserverclick="add_bed_ServerClick" onmouseover="getBedID('7')" runat="server">
                                        <img src="../QER/img/bed.png" style="width:40px;height:40px;"/>
                                        <span class="badge-primary rounded h5">&nbsp;Bed 7&nbsp;</span>
                                    </button>
                                </div>
                            </div> 
                        </div>
                      </div>
                  
                    </div>
                    <!-- End เตียงแถวสี่ -->

              <!-- เตียงแถวห้า -->
              
                  <div class="row mt-3 bg">
                      <div class="col-3 ">
                        <div class="card">
                             <div class="row col-12 mx-auto my-auto">
                                <div class="col-3 mx-auto my-auto text-left"> 
                                    <a href="#" id="status_success11" onserverclick="status_success_ServerClick" onmouseover="getStatusSuccess('Bed 11','11')" data-toggle="modal" data-target="#modalMove" runat="server">
                                    <label id="lbl_bed_11" class="mx-auto my-auto text-center Mycircle" runat="server" style="font-size:x-large">
                                        <asp:Label ID="lbl_queue_11" Text="" runat="server"></asp:Label>
                                    </label>
                                        </a>
                                </div>
                                <div class="col-9 text-right my-auto" style="font-size:large">
                                    <asp:Label ID="lbl_iconstatus_11" Text="" runat="server"></asp:Label>
                                </div>
                                <div class="col-12 mx-auto my-auto">
                                    <hr />
                                    <button class="border-0 bg-transparent" id="add_bed11" value="11" onserverclick="add_bed_ServerClick" onmouseover="getBedID('11')" runat="server">
                                        <img src="../QER/img/bed.png" style="width:40px;height:40px;"/>
                                        <span class="badge-primary rounded h5">&nbsp;Bed 11&nbsp;</span>
                                    </button>
                                </div>
                            </div>  
                        </div>
                      </div>

                      <div class="col-3 ">
                        <div class="card">
                            <div class="row col-12 mx-auto my-auto">
                                <div class="col-3 mx-auto my-auto text-left"> 
                                    <a href="#" id="status_success10" onserverclick="status_success_ServerClick" onmouseover="getStatusSuccess('Bed 10','10')" data-toggle="modal" data-target="#modalMove" runat="server">
                                    <label id="lbl_bed10" class="mx-auto my-auto text-center Mycircle" runat="server" style="font-size:x-large">
                                        <asp:Label ID="lbl_queue_10" Text="" runat="server"></asp:Label>
                                    </label>
                                    </a>
                                </div>
                                <div class="col-9 text-right my-auto" style="font-size:large">
                                    <asp:Label ID="lbl_iconstatus_10" Text="" runat="server"></asp:Label>
                                </div>
                                <div class="col-12 mx-auto my-auto">
                                    <hr />
                                    <button class="border-0 bg-transparent" id="add_bed10" value="10" onserverclick="add_bed_ServerClick" onmouseover="getBedID('10')" runat="server">
                                        <img src="../QER/img/bed.png" style="width:40px;height:40px;"/>
                                        <span class="badge-primary rounded h5">&nbsp;Bed 10&nbsp;</span>
                                    </button>
                                </div>
                            </div>  
                        </div>
                      </div>

                       <div class="col-3 ">
                        <div class="card">
                            <div class="row col-12 mx-auto my-auto">
                                <div class="col-3 mx-auto my-auto text-left"> 
                                    <a href="#" id="status_success9" onserverclick="status_success_ServerClick" onmouseover="getStatusSuccess('Bed 9','9')" data-toggle="modal" data-target="#modalMove" runat="server">
                                    <label id="lbl_bed9" class="mx-auto my-auto text-center Mycircle" runat="server" style="font-size:x-large">
                                        <asp:Label ID="lbl_queue_9" Text="" runat="server"></asp:Label>
                                    </label>
                                    </a>
                                </div>
                                <div class="col-9 text-right my-auto" style="font-size:large">
                                    <asp:Label ID="lbl_iconstatus_9" Text="" runat="server"></asp:Label>
                                </div>
                                <div class="col-12 mx-auto my-auto">
                                    <hr />
                                    <button class="border-0 bg-transparent" id="add_bed9" value="9" onserverclick="add_bed_ServerClick" onmouseover="getBedID('9')" runat="server">
                                        <img src="../QER/img/bed.png" style="width:40px;height:40px;"/>
                                        <span class="badge-primary rounded h5">&nbsp;Bed 9&nbsp;</span>
                                    </button>
                                </div>
                            </div> 
                        </div>
                      </div>

                       <div class="col-3">
                        <div class="card">
                            <div class="row col-12 mx-auto my-auto">
                                <div class="col-3 mx-auto my-auto text-left"> 
                                    <a href="#" id="status_success8" onserverclick="status_success_ServerClick" onmouseover="getStatusSuccess('Bed 8','8')" data-toggle="modal" data-target="#modalMove" runat="server">
                                    <label id="lbl_bed8" class="mx-auto my-auto text-center Mycircle" runat="server" style="font-size:x-large">
                                        <asp:Label ID="lbl_queue_8" Text="" runat="server"></asp:Label>
                                    </label>
                                    </a>
                                </div>
                                <div class="col-9 text-right my-auto" style="font-size:large">
                                    <asp:Label ID="lbl_iconstatus_8" Text="" runat="server"></asp:Label>
                                </div>
                                <div class="col-12 mx-auto my-auto">
                                    <hr />
                                    <button class="border-0 bg-transparent" id="add_bed8" value="8" onserverclick="add_bed_ServerClick" onmouseover="getBedID('8')" runat="server">
                                        <img src="../QER/img/bed.png" style="width:40px;height:40px;"/>
                                        <span class="badge-primary rounded h5">&nbsp;Bed 8&nbsp;</span>
                                    </button>
                                </div>
                            </div> 
                        </div>
                      </div>
                  
                    </div>
                    <!-- End เตียงแถวห้า -->
                    
              <br />
          </div>
        </div>
    <!-- Modal -->
<div class="modal fade" id="modalConfirm" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Remove Queue</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        คุณต้องการนำคิว ออกจากเตียง 
          <span class="badge-primary rounded h5">&nbsp;<asp:Label ID="lblM_Bed" Text="" runat="server"></asp:Label>&nbsp;</span>
          ใช่ หรือ ไม่
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" onserverclick="btn_move_ServerClick" runat="server" >ย้ายเตียง</button>
        <button type="button" class="btn btn-primary" onserverclick="status_success_ServerClick" runat="server">จบกระบวนการ</button>
      </div>
    </div>
  </div>
</div>

    <!-- Modal Qnull -->
<div class="modal fade" id="modalMove" tabindex="-1" role="dialog" aria-labelledby="modalMoveLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalMoveLabel">Move Queue</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        คุณต้องการย้าย Queue เข้าที่เตียงนี้ ใช่ หรือ ไม่
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">ยกเลิก</button>
        <button type="button" id="btn_submit_move" class="btn btn-primary" onserverclick="btn_submit_move_ServerClick" runat="server">ยืนยัน</button>
      </div>
    </div>
  </div>
</div>

<div hidden="hidden">
    <input type="text" id="txtH_StatusID" value="" runat="server" />
    <input type="text" id="txtH_StatusID_selected" value="" />

    <input type="text" id="txtH_BedID" value="" runat="server" />
    <input type="text" id="txtH_ID" value="" runat="server" />

    <input type="text" id="txtH_Status_success" value="" runat="server" />
</div>
<script>
    function getBedID(Bed) {
        var txtBedID = document.getElementById('<%= txtH_BedID.ClientID %>');
        
        txtBedID.value = Bed;
    }

    function getStatusID(id) {

        var txtStatusID = document.getElementById('<%= txtH_StatusID.ClientID %>');
        var txtStatusID_selected = document.getElementById('txtH_StatusID_selected');
        var a_icon = document.getElementById('a_icon_' + id);

        var checkID = id;
        if (checkID != "") {
            a_icon.setAttribute("class", "iconSizeSelected");

            if (txtStatusID.value.search(id) >= 0) {

                a_icon.setAttribute("class", "iconSize");

                txtStatusID.value = txtStatusID.value.replace(id+",", "");
                txtStatusID.value = txtStatusID.value.replace(","+id, "");
                txtStatusID.value = txtStatusID.value.replace(id, "");
            } else {

                if (txtStatusID.value != '') { txtStatusID.value = txtStatusID.value + ','; }
                txtStatusID.value = txtStatusID.value + id;

            }
        }
    }

    function getStatusSuccess(Bed,x) {
        var ModalBed = document.getElementById('<%= lblM_Bed.ClientID %>');
        ModalBed.innerText = Bed;
        var txtBed = document.getElementById('<%= txtH_BedID.ClientID %>');
        txtBed.value = x;
    }

    $(function () {
        $('[data-toggle="tooltip"]').tooltip()
    })

</script>
   
</asp:Content>
