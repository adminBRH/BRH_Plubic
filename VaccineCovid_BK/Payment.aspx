<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Payment.aspx.cs" Inherits="BRH_Plubic.VaccineCovid.Payment" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentDesktop" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<style>
    .imgCircle {
        width: 92px;
        border-radius: 50%;
    }
    .fontTopic {
        font-size: xx-large;
        text-shadow: 2px 2px 2px #0094ff;
    }
    .fontDetail {
        font-size: x-large;
    }
    .dotted {
      border-bottom: 1px dashed #999;
      text-decoration: none; 
    }

    .important {
        color: red;
    }
</style>

    <!-- ------------ Dose Counter ------------- -->
    <div class="col-12 mx-auto">
        <iframe id="iframe_Counter" src="Counter.aspx" class="row col-12 mx-auto" style="height: 100%; overflow-y: auto;" runat="server"></iframe>
    </div>
    <!-- ------------ Dose Counter ------------- -->

    <div class="col-12 mx-auto mt-5 alert alert-warning fontTopic">
        จำนวนเงินที่ท่านต้องทำการโอนชำระทั้งหมด
        <asp:Label ID="lbl_net" Text="" runat="server"></asp:Label> บาท 
        <span class="btn btn-outline-warning" data-toggle="modal" data-target="#ModalDetail" style="cursor: pointer; text-shadow: 1px 1px 1px #000000;">
            <i class="ti-2x ti-receipt"></i>รายละเอียด
            <label id="lbl_details"></label>
        </span>
    </div>
    <div class="col-12 mx-auto mb-3 alert alert-danger fontDetail text-center">
        กรุณาโอนชำระก่อนเวลา <i class="ti-alarm-clock"></i>
        <asp:Label ID="lbl_endtime" Text="" runat="server"></asp:Label> น.
    </div>

    <div class="row col-12 mx-auto">
        <div class="col-11 mx-auto fontTopic">
            บัญชีธนาคารสำหรับการโอนชำระ
        </div>
        <div class="row col-12 mx-auto">
            <div class="col-2 mx-auto my-auto text-right">
                <label class="switch my-3" hidden="hidden">
                    <input type="checkbox" name="btn_bank" id="btn_bank_kplus" checked />
                    <span class="slider round"></span>
                </label>
            </div>
            <div class="col-2 mx-auto my-auto text-center">
                <img src="../images/logo/KPLUS.png" class="imgCircle" />
            </div>
            <div class="col-8 mx-auto my-auto fontDetail">
                ธนาคารกสิกรไทย 140-2-83629-2 <br />โรงพยาบาลกรุงเทพระยอง
            </div>
        </div>
        <div hidden="hidden">
            <input id="txt_bank" value="kplus" runat="server" />
        </div>
    </div>

    <div class="row col-12 mx-auto my-3 fontTopic">
        แนบสลิปการโอน<span class="important">*</span>
        <div class="row col-12 mx-auto my-3">
            <div id="div_upload" class="row col-12 mx-auto" runat="server">  
                <div class="col-12" style="font-size: large;">
                    <input type="file" ID="uploadSlip" name="uploadSlip" onchange="previewFile()" runat="server" />
                </div>
                <div class="col-lg-3 col-sm-5 mx-auto">
                    <asp:Image ID="previewSlip" runat="server" ImageUrl="..." Width="100%" />
                </div>
                <div hidden="hidden">
                    <input type="text" id="txtH_slip_pt" value="" runat="server" />
                    <input type="text" id="txtH_slip_pv" value="" runat="server" />
                </div>
            </div>
            <script>
                function previewFile() {
                    var preview = document.querySelector('#<%=previewSlip.ClientID %>');
                    var file = document.querySelector('#<%=uploadSlip.ClientID %>');
                    var reader = new FileReader();

                    var pt = document.getElementById('<%= txtH_slip_pt.ClientID %>');
                    var pv = document.getElementById('<%= txtH_slip_pv.ClientID %>');
                    
                    reader.onloadend = function () {
                        preview.src = reader.result;
                        pt.value = fileName(file.value);
                        pv.value = reader.result;
                    }

                    if (file.files[0]) {
                        reader.readAsDataURL(file.files[0]);
                    } else {
                        preview.src = '';
                    }
                }

                function fileName(fakepath) {
                    var name = fakepath.split('\\');
                    var last = name.length - 1;
                    return name[last];
                }
            </script>
        </div>
        <div class="col-4 mx-auto my-3">
            จำนวนเงินที่โอน<span class="important">*</span>
            <input type="number" id="txt_money" value="" data-number-format="{0:#,##0,##}" class="form-control" runat="server" />
        </div>
        <div class="col-3 mx-auto my-3">
            เวลาที่โอน<span class="important">*</span>
            <input type="time" id="txt_time" value="" class="form-control" runat="server" />
        </div>
        <div class="col-5 mx-auto my-3">
            เบอร์โทรศัพท์<span class="important">*</span>
            <input type="number" id="txt_phone" value="" required="required" class="form-control" onkeypress="if(this.value.length>=10) return false;" placeholder="เบอร์โทรศัพท์ ที่สามารถติดต่อได้" data-toggle="tooltip" data-placement="top" title="กรอกได้เฉพาะตัวเลข ไม่เกิน10ตัวอักษร" runat="server" />
        </div>
    </div>

    <div class="col-12 mx-auto my-5 text-center">
        <button id="btn_submit" class="btn btn-outline-primary fontTopic" runat="server" onserverclick="btn_submit_ServerClick">ส่งสลิป <i class="ti-cloud-up"></i></button>
    </div>


<!-- Modal Detail -->
<div class="modal fade" id="ModalDetail" tabindex="-1" role="dialog" aria-labelledby="ModalDetailTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
    <div class="modal-content">
      <div class="modal-header bg-info">
        <h5 class="modal-title fontTopic" id="ModalDetailTitle">รายละเอียดการจอง</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
          <div class="col-12 mx-auto">
              <asp:ListView ID="LV_details" runat="server">
                  <LayoutTemplate>
                      <div class="row col-12 mx-auto bg-dark" style="color: yellow;">
                          <div class="col-1 mx-auto text-center">ลำดับ</div>
                          <div class="col-3 mx-auto text-center">ชื่อ-นามสกุล</div>
                          <div class="col-2 mx-auto text-center">จำนวน</div>
                          <div class="col-3 mx-auto text-center">ราคา</div>
                          <div class="col-3 mx-auto text-center">รวม</div>
                      </div>
                      <div id="itemPlaceholder" class="col-12 mx-auto" runat="server"></div>
                  </LayoutTemplate>
                  <ItemTemplate>
                      <div class="row col-12 mx-auto">
                          <hr class="bg-gradient-RedBlue text-center" style="width: 100%;" />
                          <div class="col-1 mx-auto text-center"><%# Container.DataItemIndex + 1 %></div>
                          <div class="col-3 mx-auto text-center"><%# Eval("cm_pname") %> <%# Eval("cm_fname") %> <%# Eval("cm_lname") %></div>
                          <div class="col-2 mx-auto text-center"><%# Eval("bv_qty") %> เข็ม</div>
                          <div class="col-3 mx-auto text-center"><%# Eval("bv_price") %></div>
                          <div class="col-3 mx-auto text-center"><%# Eval("bv_net") %></div>
                      </div>
                  </ItemTemplate>
              </asp:ListView>
          </div>
      </div>
      <div class="modal-footer">

      </div>
    </div>
  </div>
</div>

<!-- Modal Submit -->
<div class="modal fade" id="ModalSubmit" tabindex="-1" role="dialog" aria-labelledby="ModalSubmitTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
    <div class="modal-content">
      <div class="modal-header bg-info">
        <div class="modal-title fontTopic" id="ModalSubmitTitle">
            <img src="../images/logo-BRH_200x80px.png" style="width: 100px;" />
        </div>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" style="font-size: large;">
          <div class="col-12 mx-auto text-right">
              หมายเลขการจอง: <asp:Label ID="lbl_docno" Text="" runat="server"></asp:Label>
          </div>
          <div class="col-12 mx-auto">
              ขอบคุณที่ท่านให้ความไว้วางใจในการบริการของโรงพยาบาลกรุงเทพระยอง
          </div>
          <div class="col-12 mx-auto">
              โรงพยาบาลได้รับยอดชำระค่าวัคซีนจำนวน <asp:Label ID="lbl_net_alert" Text="" CssClass="dotted" runat="server"></asp:Label> บาท 
              จำนวน <asp:Label ID="lbl_dose_alert" Text="" CssClass="dotted" runat="server"></asp:Label> เข็ม
              <asp:ListView ID="LV_alert" runat="server">
                  <LayoutTemplate>
                      <div class="col-12 mx-auto">
                          ของผู้รับบริการ
                      </div>
                      <div id="itemPlaceholder" class="col-12 mx-auto" runat="server"></div>
                  </LayoutTemplate>
                  <ItemTemplate>
                      <div class="col-12 mx-auto">
                          ชื่อ <span class="dotted"><%# Eval("cm_pname") %> <%# Eval("cm_fname") %></span> นามสกุล <span class="dotted"><%# Eval("cm_lname") %></span> เบอร์โทร <span class="dotted"><%# Eval("cm_phone") %></span>
                      </div>
                  </ItemTemplate>
              </asp:ListView>
          </div>
      </div>
      <div class="modal-footer">
          <div class="row col-12 mx-auto">
              <div class="col-12 mx-auto">
                  หมายเหตุ : รพ.จะติดต่อกลับ แจ้งวันรับการฉีดวัคซีน หลังจากได้รับการจัดสรรวัคซีนแล้ว
              </div>
              <div class="col-12 mx-auto">
                  1 . เมื่อทำการจองวัคซีนแล้ว ไม่สามารถคืนเงินได้ ดังนั้นท่านจะต้องพิจารณาให้รอบคอบก่อนตัดสินใจทำการจองวัคซีน
              </div>
              <div class="col-12 mx-auto">
                  2 . หากรพ.ไม่ได้รับการจัดสรรวัคซีนตามระยะเวลาที่กำหนด รพ.ยินดีคืนเงินให้เต็มจำนวน
              </div>
              <div class="col-12 mx-auto">
                  3. ราคานี้รวมประกันสำหรับผู้มีอาการแพ้วัคซีนแล้ว
              </div>
              <div class="col-2 mx-auto">&nbsp;</div>
              <div class="col-10 mx-auto">
                  ขอให้ติดตามข่าวสารของทางโรงพยาบาลกรุงเทพระยอง ผ่านช่องทางดังนี้ 
              </div>
              <div class="col-2 mx-auto">&nbsp;</div>
              <div class="col-10 mx-auto">
                  Website : <a target="_blank" href="https://bangkokhospitalrayong.com">https://bangkokhospitalrayong.com</a>
              </div>
              <div class="col-2 mx-auto">&nbsp;</div>
              <div class="col-10 mx-auto">
                  Facebook : <a target="_blank" href="https://www.facebook.com/BangkokRayong">โรงพยาบาลกรุงเทพระยอง</a>
              </div>
              <div class="col-2 mx-auto">&nbsp;</div>
              <div class="col-10 mx-auto">
                  LINE Official : <a href="https://page.line.me/bangkokrayong">@bangkokrayong</a>
              </div>
              <div class="col-2 mx-auto">&nbsp;</div>
              <div class="col-10 mx-auto">
                  Instagram : <a href="https://www.instagram.com/bangkokhospitalrayong">bangkokhospitalrayong</a> 
              </div>
          </div>
      </div>
    </div>
  </div>
</div>

<script>
    function fn_DetailInOut(show) {
        var lbl = document.getElementById('lbl_details');
        if (show == 'yes') {
            lbl.innerHTML = 'คลิ๊กเพื่อดูรายละเอียด';
        } else {
            lbl.innerHTML = '';
        }
    }
</script>

    <asp:Label ID="lbl_script" Text="" runat="server"></asp:Label>

</asp:Content>
