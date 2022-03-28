<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DragDrop.aspx.cs" Inherits="BRH_Plubic.DragDrop" %>

<!DOCTYPE HTML>
<html>
<head>
	<title>Drag & Drop</title>

	<!-- Bootstrap CSS -->
    <link rel="stylesheet" href="../css/bootstrap.min.css">
	<!-- Themify Icons -->
    <link rel="stylesheet" href="../css/themify-icons.css">
    <!-- Main css -->
    <link href="../css/style.css" rel="stylesheet">

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
		background-color: darkturquoise; 
		cursor: move; 
		height: 7.0px;
		border: solid;
		border-radius: 20px;
		font-size: xx-large;
	}
	</style>
	<script>
	function allowDrop(ev) {
	  ev.preventDefault();
	}

	function drag(ev) {
	  var txt =  document.getElementById("txt_img").value;
	  ev.dataTransfer.setData(txt, ev.target.id);
	}

	function txtImg(txt){
		document.getElementById("txt_img").value = txt;
	}

	function drop1(ev) {
	  var txt =  document.getElementById("txt_img").value;
	  ev.preventDefault();
	  var data = ev.dataTransfer.getData(txt);
	  ev.target.appendChild(document.getElementById(data));
  
	  fnDel("lbl_box1",txt);
  
	  fnAdd("lbl_box1",txt);
  
	  fnDel("lbl_box2",txt);
	}

	function drop2(ev) {
	  var txt =  document.getElementById("txt_img").value;
	  ev.preventDefault();
	  var data = ev.dataTransfer.getData(txt);
	  ev.target.appendChild(document.getElementById(data));
  
	  fnDel("lbl_box2",txt);
  
	  fnAdd("lbl_box2",txt);
  
	  fnDel("lbl_box1",txt);
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
</head>
<body>
	<div class="row col-12 mx-auto">
		<div class="col-6 mx-auto mt-5 text-center">
			Department 1
		</div>
		<div class="col-6 mx-auto mt-5 text-center">
			Department 2
		</div>
		<div id="div1" class="row col-5 mx-auto mb-5" ondrop="drop1(event)" ondragover="allowDrop(event)">
			<div id="com1" class="col-6 mx-auto my-1 com" draggable="true" ondragstart="drag(event)" onmouseover="txtImg('com1')">
				1 <img src="../images/LOGO-BRH-Horizontal-ENG-Transparent.png" width="69" height="29" style="cursor: pointer">
			</div>
			<div id="com2" class="col-6 mx-auto my-1 com" draggable="true" ondragstart="drag(event)" onmouseover="txtImg('com2')">
				2 <img src="../images/LOGO-BRH-Horizontal-ENG-Transparent.png" width="69" height="29" style="cursor: pointer">
			</div>
			<div id="com3" class="col-6 mx-auto my-1 com" draggable="true" ondragstart="drag(event)" onmouseover="txtImg('com3')">
				3 <img src="../images/LOGO-BRH-Horizontal-ENG-Transparent.png" width="69" height="29" style="cursor: pointer">
			</div>
			<div id="com4" class="col-6 mx-auto my-1 com" draggable="true" ondragstart="drag(event)" onmouseover="txtImg('com4')">
				4 <img src="../images/LOGO-BRH-Horizontal-ENG-Transparent.png" width="69" height="29" style="cursor: pointer">
			</div>
			<div id="com5" class="col-6 mx-auto my-1 com" draggable="true" ondragstart="drag(event)" onmouseover="txtImg('com5')">
				5 <img src="../images/LOGO-BRH-Horizontal-ENG-Transparent.png" width="69" height="29" style="cursor: pointer">
			</div>
			<div id="com6" class="col-6 mx-auto my-1 com" draggable="true" ondragstart="drag(event)" onmouseover="txtImg('com6')">
				6 <img src="../images/LOGO-BRH-Horizontal-ENG-Transparent.png" width="69" height="29" style="cursor: pointer">
			</div>
		</div>
		<div id="div2" class="row col-5 mx-auto mb-5" ondrop="drop2(event)" ondragover="allowDrop(event)"></div>
		<div class="col-6 mx-auto text-center">
			List: <label id="lbl_box1">com1,com2,com3</label>
		</div>
		<div class="col-6 mx-auto text-center">
			List: <label id="lbl_box2"></label>
		</div>
		<div class="col-12 mx-auto" hidden="hidden">
			Drage: <input type="text" id="txt_img" value="" disabled>
		</div>
	</div>
</body>
</html>