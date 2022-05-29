<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Transfer.aspx.cs" Inherits="BRH_Plubic.AssetControl.Transfer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentDesktop" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<style>
	/*#div1 {
	  width: 350px;
	  height: 350px;
	  padding: 10px;
	  border: 1px solid #aaaaaa;
	}
	#div2 {
	  width: 350px;
	  height: 350px;
	  padding: 10px;
	  border: 1px solid #aaaaaa;
	}*/
	.comFrom {
		background-color: beige; 
		cursor: move; 
		height: 68px;
		border: solid;
		border-radius: 20px;
	}
	.comTo {
		height: 68px;
	}
	.sizeImg {
		width: 49px;
		height: 39px;
	}
	.dropdownStyle {
		border: solid;
		border-color: blueviolet;
		border-radius: 20px;
	}
</style>
<script>
	function allowDrop(ev) {
		ev.preventDefault();
	}

	function drag(ev) {
		var txt = document.getElementById("txt_img").value;
		ev.dataTransfer.setData(txt, ev.target.id);
	}

	function txtImg(txt){
		document.getElementById("txt_img").value = txt;
	}

	function divName(id) {
        document.getElementById("txt_div").value = id;
    }

	function drop1(ev) {
        var divID = document.getElementById("txt_div").value;
        document.getElementById(divID).setAttribute('ondragover', 'allowDrop(event)');

        var txt = document.getElementById("txt_img").value;
        ev.preventDefault();
        var data = ev.dataTransfer.getData(txt);
        ev.target.appendChild(document.getElementById(data));
        fnDel("<%= lbl_box1.ClientID %>", txt);
        fnAdd("<%= lbl_box1.ClientID %>", txt);
		fnDel("<%= lbl_box2.ClientID %>", txt);

        ev.target.removeAttribute('ondragover');
	}

	function drop2(ev) { 
		var divID = document.getElementById("txt_div").value;
        document.getElementById(divID).setAttribute('ondragover', 'allowDrop(event)');

        var txt = document.getElementById("txt_img").value;
		ev.preventDefault();
        var data = ev.dataTransfer.getData(txt);
        ev.target.appendChild(document.getElementById(data));
        fnDel("<%= lbl_box2.ClientID %>", txt);
        fnAdd("<%= lbl_box2.ClientID %>", txt);
		fnDel("<%= lbl_box1.ClientID %>", txt);

		ev.target.removeAttribute('ondragover');
	}

	function fnAdd(lbl, txt){
		//alert("Add: " + txt + " to: " + lbl);
		var lbl = document.getElementById(lbl);
		if(lbl.innerHTML != ""){ lbl.innerHTML += ","; }
		lbl.innerHTML += txt;
	}

	function fnDel(lbl, txt){
		//alert("Delete: " + txt + " from: " + lbl);
		var lbldel = document.getElementById(lbl);
		lbldel.innerHTML = lbldel.innerHTML.replaceAll(","+txt, "");
		lbldel.innerHTML = lbldel.innerHTML.replaceAll(txt, "");
		if(lbldel.innerHTML.substring(0,1)==","){  
  			lbldel.innerHTML = lbldel.innerHTML.replaceAll(",", "");
		}
	}
</script>

<div class="row col-12 mx-auto">
    <div class="alert alert-primary col-12 mx-auto text-center h3">
        Transfer by <asp:Label ID="lbl_transferby" Text="" runat="server"></asp:Label>
    </div>
    <div class="row col-6 mx-auto">
        <div class="alert alert-warning col-12 mx-auto h3">
            Form: 
			<asp:DropDownList ID="dd_department" CssClass="dropdownStyle" OnSelectedIndexChanged="dd_department_SelectedIndexChanged" AutoPostBack="true" runat="server">
				<asp:ListItem Text="" Value=""></asp:ListItem>
			</asp:DropDownList>
        </div>
    </div>
    <div class="row col-6 mx-auto">
        <div class="alert alert-danger col-12 mx-auto h3">
            To: 
			<asp:DropDownList ID="dd_departmentTo" CssClass="dropdownStyle" OnSelectedIndexChanged="dd_departmentTo_SelectedIndexChanged" AutoPostBack="true" runat="server">
			</asp:DropDownList>
        </div>
    </div>
	<div class="row col-6 mx-auto">
		<div id="div1" class="row col-12 mx-auto my-2 bg-dark">
			<asp:ListView ID="LV_from" runat="server">
				<LayoutTemplate>
					<div id="itemPlaceholder" runat="server"></div>
				</LayoutTemplate>
				<ItemTemplate>
					<div id="divFrom_<%# Eval("asd_id") %>" class="col-5 mx-auto my-1 bg-secondary" ondrop="drop1(event)" onmouseover="divName('divFrom_<%# Eval("asd_id") %>')">
						<div id="com_<%# Eval("asd_id") %>" class="col-12 mx-auto my-1 comFrom" draggable="true" ondragstart="drag(event)" ondragend="dragEnd(event)" onmouseover="txtImg('<%# Eval("asd_id") %>')">
							<img src="images/<%# Eval("ast_logo") %>" class="sizeImg" style="cursor: pointer">
							<%# Eval("asd_displayname") %><br />
							SN: <%# Eval("asd_sn") %>
						</div>
					</div>
				</ItemTemplate>
			</asp:ListView>
        </div>
	</div>
	<div class="row col-6 mx-auto">
		<div id="div2" class="row col-12 mx-auto  my-2 bg-dark">
			<asp:Label ID="lbl_to" Text="" runat="server" Visible="false"></asp:Label>
        </div>
	</div>
	<div hidden="hidden">
		<input type="text" id="txt_img" value="" disabled><br />
		from: <asp:Label ID="lbl_box1" Text="" runat="server"></asp:Label><br />
		to: <asp:Label ID="lbl_box2" Text="" runat="server"></asp:Label><br />
		get: <input id="txtH_id" value="" runat="server" /><br />
		<input type="text" id="txt_div" value="" disabled>
	</div>

	<script>
		function fn_getid() {
			var to = document.getElementById('<%= lbl_box2.ClientID %>');
			var get = document.getElementById('<%= txtH_id.ClientID %>');
			get.value = to.innerHTML;
        }
    </script>
	
<!-- Modal -->
<div class="modal fade" id="modalConfirm" tabindex="-1" role="dialog" aria-labelledby="modalConfirmTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header bg-warning">
        <h5 class="modal-title" id="modalConfirmTitle">Confirm</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
		  คุณต้องการเคลื่อนย้ายอุปกรณ์ดังรายการที่กำหนด ใช่หรือไม่ ?
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal"> No </button>
        <button id="btn_submit" class="btn btn-warning" onserverclick="btn_submit_ServerClick" runat="server"> Yes </button>
      </div>
    </div>
  </div>
</div>

<!-- Modal -->
<div class="modal fade" id="modalEmail" tabindex="-1" role="dialog" aria-labelledby="modalEmailTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header bg-warning">
        <h5 class="modal-title" id="modalEmailTitle"> Your Email ?</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
		  <div class="alert-primary">
			เนื่องจากคุณยังไม่มีข้อมูล Email ภายในระบบ กรุณาระบุ email ของคุณ ก่อนทำการบันทึก !!
		  </div>
		  <div class="col-10 mx-auto">
			  <input id="txt_email" class="form-control" value="" placeholder="กรุณาระบุ email ของคุณ" runat="server" />
		  </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal"> Cancel </button>
        <button id="Button1" class="btn btn-warning" onserverclick="btn_submit_ServerClick" runat="server"> Save and Submit </button>
      </div>
    </div>
  </div>
</div>

	<div id="div_submit" class="row col-12 mx-auto text-center alert-primary" runat="server" visible="false">
		<div class="col-12 mx-auto my-2">
			<div class="col-6 mx-auto">
				<textarea id="txt_remark" class="form-control" rows="5" placeholder="หมายเหตุ" runat="server"></textarea>
			</div>
		</div>
		<div class="col-12 mx-auto my-3">
			<a id="btn_confirm" class="btn btn-warning" style="cursor: pointer; font-size: x-large;" data-toggle="modal" data-target="#modalConfirm" onclick="fn_getid()"> SUBMIT </a>
		</div>
	</div>
</div>

<asp:Label ID="lbl_script" Text="" runat="server"></asp:Label>

</asp:Content>
