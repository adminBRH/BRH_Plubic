<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Transfer.aspx.cs" Inherits="BRH_Plubic.AssetControl.Transfer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentDesktop" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<style>
	#div1 {
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
	}
	.com {
		background-color: beige; 
		cursor: move; 
		height: 43px;
		border: solid;
		border-radius: 20px;
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
        Transfer
    </div>
    <div class="row col-6 mx-auto">
        <div class="alert alert-warning col-12 mx-auto h3">
            Form: 
			<asp:DropDownList ID="dd_department" CssClass="dropdownStyle" OnSelectedIndexChanged="dd_department_SelectedIndexChanged" AutoPostBack="true" runat="server">
				<asp:ListItem Text="" Value=""></asp:ListItem>
			</asp:DropDownList>
        </div>
        <div id="div1" class="row col-12 mx-auto bg-dark">
			<div id="divFrom_1" class="col-5 mx-auto my-1 bg-secondary" ondrop="drop1(event)" onmouseover="divName('divFrom_1')">&nbsp;
				<div id="com1" class="col-12 mx-auto my-1 com" draggable="true" ondragstart="drag(event)" ondragend="dragEnd(event)" onmouseover="txtImg('คอมห้องหมอ 1')">
					<img src="../AssetControl/images/logo/PC.png" class="sizeImg" style="cursor: pointer">
					คอมห้องหมอ 1
				</div>
			</div>
			<div id="divFrom_2" class="col-5 mx-auto my-1 bg-secondary" ondrop="drop1(event)" onmouseover="divName('divFrom_2')">&nbsp;
				<div id="com2" class="col-12 mx-auto my-1 com" draggable="true" ondragstart="drag(event)" onmouseover="txtImg('คอมห้องยา')">
					<img src="../AssetControl/images/logo/PC.png" class="sizeImg" style="cursor: pointer">
					คอมห้องยา
				</div>
			</div>
			<div id="divFrom_3" class="col-5 mx-auto my-1 bg-secondary" ondrop="drop1(event)" onmouseover="divName('divFrom_3')">&nbsp;
				<div id="com3" class="col-12 mx-auto my-1 com" draggable="true" ondragstart="drag(event)" onmouseover="txtImg('คอมลงทะเบียน 1')">
					<img src="../AssetControl/images/logo/PC.png" class="sizeImg" style="cursor: pointer">
					คอมลงทะเบียน 1
				</div>
			</div>
			<div id="divFrom_4" class="col-5 mx-auto my-1 bg-secondary" ondrop="drop1(event)" onmouseover="divName('divFrom_4')">&nbsp;
				<div id="com4" class="col-12 mx-auto my-1 com" draggable="true" ondragstart="drag(event)" onmouseover="txtImg('คอมลงทะเบียน 2')">
					<img src="../AssetControl/images/logo/PC.png" class="sizeImg" style="cursor: pointer">
					คอมลงทะเบียน 2
				</div>
			</div>
        </div>
    </div>
    <div class="row col-6 mx-auto">
        <div class="alert alert-danger col-12 mx-auto h3">
            To: 
			<asp:DropDownList ID="dd_departmentTo" CssClass="dropdownStyle" runat="server">
			</asp:DropDownList>
        </div>
        <div id="div2" class="row col-12 mx-auto bg-dark">
			<div id="divTo_1" class="col-5 mx-auto my-1 bg-secondary" ondrop="drop2(event)" onmouseover="divName('divTo_1')" ondragover="allowDrop(event)">&nbsp;</div>
			<div id="divTo_2" class="col-5 mx-auto my-1 bg-secondary" ondrop="drop2(event)" onmouseover="divName('divTo_2')" ondragover="allowDrop(event)">&nbsp;</div>
			<div id="divTo_3" class="col-5 mx-auto my-1 bg-secondary" ondrop="drop2(event)" onmouseover="divName('divTo_3')" ondragover="allowDrop(event)">&nbsp;</div>
			<div id="divTo_4" class="col-5 mx-auto my-1 bg-secondary" ondrop="drop2(event)" onmouseover="divName('divTo_4')" ondragover="allowDrop(event)">&nbsp;</div>
        </div>
    </div>
	<div hidden="hidden">
		<input type="text" id="txt_img" value="" disabled><br />
		from: <asp:Label ID="lbl_box1" Text="คอมห้องหมอ 1,คอมห้องยา,คอมลงทะเบียน 1,คอมลงทะเบียน 2" runat="server"></asp:Label><br />
		to: <asp:Label ID="lbl_box2" Text="" runat="server"></asp:Label><br />
		<input type="text" id="txt_div" value="" disabled>
	</div>
</div>

</asp:Content>
