<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PaySlip.aspx.cs" Inherits="BRH_Plubic.Marketing.PaySlip" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">

    <div class="col-lg-8 col-sm-12 mx-auto mb-5">
        <div id="div_docno" class="col-12" runat="server" visible="false">
            <div class="card card-head bg-info text-center h2" style="color:white">ข้อมูลสำหรับชำระค่าสินค้าและบริการ</div>
            <div class="card card-body mb-5" id="div3" runat="server"> 
                <asp:Label ID="lbl_name" Text="" Font-Size="X-Large" runat="server"></asp:Label><br />
                <asp:Label ID="lbl_docno" Text="" ForeColor="Blue" Font-Size="X-Large" runat="server"></asp:Label><br />
                <asp:Label ID="lbl_phone" Text="" ForeColor="Blue" Font-Size="X-Large" runat="server"></asp:Label><br />
                <span style="color:red; font-size:x-large">หากท่านยังไม่สะดวกในการชำระ ณ เวลานี้ กรุณาบันทึกเลขที่การสั่งซื้อนี้ไว้ เพื่อใช้สำหรับเข้ามาชำระในภายหลัง</span><br />
                <asp:Label ID="lbl_qty" Text="" Font-Size="X-Large" runat="server"></asp:Label><br />
                <asp:Label ID="lbl_discount" Text="" runat="server"></asp:Label><br />
                <asp:Label ID="lbl_ship" Text="" runat="server"></asp:Label><br />
                <asp:Label ID="lbl_total" Text="" ForeColor="Blue" Font-Size="X-Large" runat="server"></asp:Label><br />
            </div>
        </div>
        <div class="card card-head bg-info text-center h2" style="color:white">ช่องทางการโอนเงิน</div>
        <div class="card card-body mb-5" id="div_checknumber" runat="server">  
            <div class="row col-12 mx-auto">
                <div class="col-8 mx-auto text-center">
                    <label>เลขที่การสั่งซื้อของท่านคือ</label>
                    <br />
                    <input type="text" class="col-8 mb-3 form-control" id="txt_docno" autofocus value="" runat="server" />
                    <br />
                    <label>หมายเลขโทรศัพท์ของท่านคือ</label>
                    <br />
                    <input type="text" class="col-8 mb-3 form-control" id="txt_phone" autofocus value="" runat="server" />
                    <br />
                    <asp:Label ID="lbl_nodata" ForeColor="Red" runat="server" Text=""></asp:Label>
                    <br />
                    <button class="btn btn-success col-6" id="btn_check" onserverclick="btn_check_ServerClick" runat="server">ตรวจสอบ</button>
                </div>
            </div>
        </div>
        <div id="div_account" class="card card-body text-center mb-5" runat="server">
            <img src="image/Payment-V2.png" />
        </div>
        <div id="div_PaySlip" class="col-12" runat="server" visible="false">
            <div class="card card-head text-center bg-info h3" style="color:white">แจ้งข้อมูลการโอนเงิน</div>
            <div class="card card-body mb-5" id="div2" runat="server">
                    <div class="row col-12 mx-auto">
                        <div class="col-12 mx-auto mb-3">
                            <asp:FileUpload id="uploadimg" runat="server" />
                            <p>Upload Slip</p>
                        </div>
                        <div class="col-12 input-group mx-auto mb-3">
                            วันที่<input type="date" id="date_slip" class="col-4 form-control" value="" runat="server" />
                        </div>
                        <script>
                            var date = document.getElementById('<%= date_slip.ClientID %>');
                            date.valueAsDate = new Date();
                        </script>
                        <div class="row col-12 input-group mx-auto mb-3">
                            เวลา
                                <input type="number" id="txt_hour" class="col-2 form-control" placeholder="ชั่วโมง ที่โอน" value="" runat="server" />
                            &nbsp;:&nbsp;
                                <input type="number" id="txt_minute" class="col-2 form-control" placeholder="นาที ที่โอน" value="" runat="server" />
                        </div>
                        <div class="col-12 mx-auto mb-3">
                            <input type="text" id="txt_money" class="col-5 form-control" placeholder="จำนวนเงินที่โอน" value="" runat="server" />
                        </div>
                        <div class="col-12 text-center">
                            <asp:Label ID="lbl_alert" Text="" ForeColor="Red" runat="server"></asp:Label>
                        </div>
                    </div>
            </div>
            <div class="col-12 mx-auto text-center">
                <button class="btn btn-outline-primary mx-auto text-center" value="" id="btn_success" runat="server" onserverclick="btn_success_ServerClick">SUBMIT</button>
            </div>
        </div>
    </div>

</asp:Content>
