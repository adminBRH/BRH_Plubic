<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ARIcalendar.aspx.cs" Inherits="BRH_Plubic.ARIcalendar" %>

<!DOCTYPE html>

<html>
<head>
    <title>FullCalendar TEST</title>

	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

<script src="js/bootstrap.bundle.min.js"></script>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="css/bootstrap.min.css">
<!-- Themify Icons -->
<link rel="stylesheet" href="css/themify-icons.css">
<!-- Owl carousel -->
<link rel="stylesheet" href="css/owl.carousel.min.css">
<!-- Main css -->
<link href="css/style.css" rel="stylesheet">
	
</head>
<body data-spy="scroll" class="bg-secondary">

<form runat="server">

<div class="col-10 mx-auto text-left">
	<img src="images/LOGO-BRH-Horizontal-ENG-Transparent.png" width="250" height="100"/>
</div>

<div class="col-12 mx-auto">
<center>
    <asp:Calendar ID="CLD_book" Width="900" Height="500" BackColor="#e7eaed"
	OnSelectionChanged="CLD_book_SelectionChanged" 
	OnDayRender="CLD_book_DayRender" 
	runat="server">
		<TitleStyle BackColor="#c0c0c0" Font-Size="X-Large"/>
		<DayHeaderStyle BackColor="#3590fc" Font-Size="Large" HorizontalAlign="Center" />
		<DayStyle Font-Bold="true" ForeColor="Blue" HorizontalAlign="Center" VerticalAlign="Top" BackColor="#c0c0c0" BorderWidth="1" BorderColor="#333333" />
		<TodayDayStyle BackColor="#99ccff" />
		<SelectedDayStyle CssClass="rounded-circle" BackColor="#ff9966" ForeColor="Black" Font-Bold="true" />
    </asp:Calendar>
	<div hidden="hidden">
		<input type="text" id="txtH_date" value="" runat="server" />
	</div>
</center>
</div>

<div class="col-12 mx-auto mt-3 mb-5">
	<div class="row col-12 mx-auto">
		<%--<div class="col-4 my-3 text-right h2">
			เลือกวันที่
		</div>
		<div class="col-4">
			<input type="date" id="date_book" class="btn btn-light form-control" value="" runat="server" />
		</div>
		<div class="col-4">&nbsp;</div>--%>
		<div class="col-4 my-3 text-right h2">
			เวลา
		</div>
		<div class="col-4">
			<asp:DropDownList ID="DD_Times" CssClass="btn btn-light form-control" runat="server">
				<asp:ListItem Value="" Text=""></asp:ListItem>
			</asp:DropDownList>
		</div>
		<div class="col-4">&nbsp;</div>
	</div>
	<div class="col-10 mx-auto text-center my-5">
		<asp:Button ID="btn_submit" CssClass="btn btn-light" ForeColor="Red" Text="Submit" Font-Size="X-Large" OnClick="btn_submit_Click" runat="server" />
	</div>
</div>

</form>

</body>
</html>
