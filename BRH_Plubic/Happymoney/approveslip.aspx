<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="approveslip.aspx.cs" Inherits="BRH_Plubic.Happymoney.approveslip" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentDesktop" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="text-center">
        <label><strong style="font-size:xx-large">ข้อมูลส่วนตัว</strong></label>
    </div>
    <div class="row col-12">
        <div class="card boxShadow col-11 my-3 mx-auto">
            <label><strong style="font-size:xx-large;">ชื่อ : <asp:Label ID="lal_name" Text="" Font-Size ="XX-Large" Font-Bold="true" runat="server"></asp:Label></strong></label>
        </div>
    </div>
    <div class="row col-12">
        <div class="card boxShadow col-11 my-3 mx-auto">
            <label><strong style="font-size:xx-large;">รหัสแผนก : <asp:Label ID="lal_depid" Text="" Font-Size ="XX-Large" Font-Bold="true" runat="server"></asp:Label></strong></label>
        </div>
    </div>
    <div class="row col-12">
        <div class="card boxShadow col-11 my-3 mx-auto">
            <label><strong style="font-size:xx-large;">แผนก : <asp:Label ID="lal_depart" Text="" Font-Size ="XX-Large" Font-Bold="true" runat="server"></asp:Label></strong></label>
        </div>
    </div>
    <div class="row col-12">
        <div class="card boxShadow col-5 my-3 mx-auto">
            <label><strong style="font-size:xx-large;">ยอดเงิน : <asp:Label ID="lbl_summoney" Text="" Font-Size ="XX-Large" Font-Bold="true" runat="server"></asp:Label></strong></label>
        </div>  
        <div class="card boxShadow col-5 my-3 mx-auto"> 
            <label><strong style="font-size:xx-large;">คะแนน : <asp:Label ID="Label1" Text="" Font-Size ="XX-Large" Font-Bold="true" runat="server"></asp:Label></strong></label>
        </div> 
    </div>
    
    <asp:ListView ID="list_money" runat="server">
        <LayoutTemplate>
            <div class="col-12 mx-auto text-center mt-3 h2">
                <strong>รอการอนุมัติ</strong>
            </div>
           <div class=""></div>
            <div id="itemPlaceholder" runat="server"></div>
        </LayoutTemplate>
        <ItemTemplate>
           <div class="card boxShadow my-3 col-11 mx-auto">
                <a href ="#" data-toggle="modal" data-target="#modal_id" onclick="get_id('<%# Eval("mo_id") %>','<%# Eval("mo_money") %>')">
                <div class="row col-12 mx-auto">
                    <div class="col-1">
                        <div class="my-3">
                            <h5><strong><%# Eval("mo_empid") %></strong></h5>
                        </div>
                    </div> 
                    <div class="col-3">
                           <div class="my-3">
                               <h5><strong><%# Eval("emp_pname_th") %> <%# Eval("emp_pnamefull_th") %></strong></h5>
                           </div>
                    </div> 
                    <div class="col-2">
                           <div class="my-3">
                                <h5><strong><%# Eval("mo_date") %></strong></h5>
                           </div>   
                    </div>
                    <div class="col-1">
                        <div class="my-3">
                            <h5><strong><%# Eval("mo_money") %> บาท</strong></h5>
                        </div>
                    </div>
                    <div class="col-2">
                        <div class="my-3">
                            <h5><strong><%# Eval("mo_craetedate") %></strong></h5>
                        </div>
                    </div>
                    <div class="col-1">
                        <div class="my-3">
                            <h5><strong><%# Eval("mo_money_active") %></strong></h5>
                        </div>
                    </div>                    
                </div>
               </a>
            </div>
        </ItemTemplate>
    </asp:ListView>
        <!-- Button trigger modal -->
    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalCenter" hidden="hidden">
          Launch demo modal
    </button>
    <div class="modal fade" id="modal_id" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
       <div class="modal-dialog modal-dialog-centered" role="document">
          <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle">Modal title</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                 <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                 <div hidden="hidden">
                <input type="text" id="txtH_id" value="" runat="server" />
                 </div>
                <label id="lbl_money"></label>
                <asp:UpdatePanel ID="UpdatePanel_slip" runat="server">
                <ContentTemplate>
                    <img src="..." id="img_id" runat="server" hidden="hidden" />
                        <asp:Button ID="btn_imgslip" Text="Show Slip" CssClass="btn btn-outline-info" OnClick="btn_imgslip_Click" runat="server" />
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btn_imgslip" EventName="click" />
                </Triggers>
                </asp:UpdatePanel>
             </div>
            <div class="modal-footer">
             <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
         
      </div>
    </div>
  </div>
</div>
    <script>
        function get_id(id, money) {
            var imgslip = document.getElementById('<%= img_id.ClientID %>');
            imgslip.setAttribute("hidden","hidden");
            var txtid = document.getElementById('<%= txtH_id.ClientID %>');
            txtid.value = id
            var lblMoney = document.getElementById('lbl_money');
            lblMoney.innerText = money + ' บาท';
        }
    </script>
</asp:Content>
