<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="BRH_Plubic.Queue.Default" %>
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
    <asp:Label ID="lbl_IP" Text="" runat="server" Visible="false"></asp:Label>

    <div id="div_input" class="col-12 mx-auto" style="position: absolute; top: 35%;" runat="server">
        <div class="col-12 mx-auto text-center" style="font-size: xx-large">
            กรอกข้อมูลเพื่อรับคิว Input your information to get the queue.
        </div>
        <div class="row col-12 mx-auto">
            <div class="col-lg-5 col-sm-10 mx-auto my-3">
                <input type="text" id="txt_fname" class="form-control boxShadow" value="" placeholder="ชื่อ First name" runat="server" style="font-size: xx-large" />
            </div>
            <div class="col-lg-5 col-sm-10 mx-auto my-3">
                <input type="text" id="txt_lname" class="form-control boxShadow" value="" placeholder="นามสกุล Last name" runat="server" style="font-size: xx-large" />
            </div>
            <div class="row col-lg-12 col-sm-10 mx-auto">
                <div class="row col-7 mx-auto my-3 text-center">
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
                <div class="col-3 mx-auto my-auto">
                    <input type="number" id="txt_age" min="0" max="120" class="form-control boxShadow" value="" placeholder="อายุ Age" runat="server" style="font-size: xx-large" />
                </div>
                <div class="col-1 mx-auto my-auto" style="font-size: xx-large">
                    ปี<br /><span style="font-size: large;">Year</span>
                </div>
            </div>
        </div>
        <div class="col-12 mx-auto my-5 text-center">
            <button id="btn_submit" class="btn btn-outline-primary" runat="server" onserverclick="btn_submit_ServerClick" style="font-size: xx-large">Receive Queue <i class="ti-hand-open"></i></button>
        </div>
        <p>&nbsp;</p>
        <p>&nbsp;</p>
        <p>&nbsp;</p>
    </div>

<style>
    .TextQueue {
        font-size: 80px;
    }
</style>

    <div id="div_queue" class="col-12 mx-auto text-center" style="position: absolute; top: 35%;" runat="server" visible="false">
        <span style="font-size: 60px;">Queue คิวที่</span><br />
        <a data-toggle="modal" data-target="#Modal_cancelQueue" style="cursor: pointer;">
            <asp:Label ID="lbl_queue" Text="" CssClass="TextQueue textShadow" runat="server" ForeColor="Blue"></asp:Label>
        </a>
        <div class="col-12 mx-auto mt-5 text-center">
            <button id="btn_cancelQueue" class="btn btn-outline-danger" onserverclick="btn_cancel_ServerClick" runat="server" visible="false">ยกเลิกคิว</button>
            <button id="btn_doctorRating" class="btn btn-outline-primary" runat="server" onserverclick="btn_doctorRating_ServerClick" style="font-size: 30px;">ประเมินแพทย์ <i class="ti-star" style="color:gold"></i></button>
        </div>
    </div>

<!-- Modal Cancel Queue ----------------------------------------------------------------------------- -->
<div class="modal fade" id="Modal_cancelQueue" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-xl" role="document">
    <div class="modal-content">
        <div class="modal-header" style="background: rgba(0,212,255,1); color:white; border-top-right-radius: 80px;">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="position: absolute; top: 0; right: 10px;">
              <span aria-hidden="true" style="color:red">&times;</span>
            </button>
            <div class="row col-12 mx-auto">
                <div class="col-12 mx-auto my-auto text-center">
                    <div class="icon-box">
                        <i class="ti-5x ti-info"></i>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-body">
          <div class="row col-12 mx-auto">
              <div class="col-12 mx-auto my-auto text-center h1" style="padding-top: 1em; padding-bottom: 1em;">
                  <asp:Label ID="lbl_Modal_cancelQueue" Text="คุณต้องการยกเลิกคิวใช่หรือไม่ (Would do you want cancel queue ?)" runat="server"></asp:Label>
              </div>
          </div>
        </div>
        <div class="modal-footer">
          <div class="row col-12 mx-auto">
              <div class="col-6 mx-auto text-center">
                  <button id="btn_close" class="btn btn-outline-danger">No</button>
              </div>
              <div class="col-6 mx-auto text-center">
                  <button id="btn_cancel" class="btn btn-outline-primary" runat="server" onserverclick="btn_cancel_ServerClick">Yes</button>
              </div>
          </div>
         </div>
    </div>
  </div>
</div>

<iframe id="iframe_autoQueue" src="Generate.aspx" runat="server" hidden="hidden"></iframe>

</asp:Content>
