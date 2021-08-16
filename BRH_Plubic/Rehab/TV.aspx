<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TV.aspx.cs" Inherits="BRH_Plubic.Rehab.TV" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>BRH Rehab Dashboard</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <!-- Themify Icons -->
    <link rel="stylesheet" href="../css/themify-icons.css">
    <!-- 'Prompt', sans-serif -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Prompt:wght@200&display=swap" rel="stylesheet">
    <style>
        @-webkit-keyframes blinker {
          from {opacity: 1.0;}
          to {opacity: 0.0;}
        }
        .blink{
	        text-decoration: blink;
	        -webkit-animation-name: blinker;
	        -webkit-animation-duration: 0.6s;
	        -webkit-animation-iteration-count:infinite;
	        -webkit-animation-timing-function:ease-in-out;
	        -webkit-animation-direction: alternate;
        }

        .HeadOne {
            width: 10%;
            text-shadow: 2px 2px 2px #808080; 
            font-size: x-large; 
        }
        .HeadTwo {
            width: 90%; 
            text-shadow: 2px 2px 2px #808080; 
            font-size: xx-large; 
        }

        .BoxName {
            text-shadow: 2px 2px 2px #808080;
            font-size: x-large;
            font-weight: bold;
        }

        .BoxBook {
            color: white;
            background-color: green;
            border: none;
            border-bottom-color: white;
            border-bottom: solid;
        }
        .BoxBooked {
            color: white;
            background-color: blue;
            border: none;
            border-bottom-color: white;
            border-bottom: solid;
        }
        .BoxBreak {
            color: white;
            background-color: gray;
            border: none;
            border-bottom-color: white;
            border-bottom: solid;
        }
        .BoxOvertime {
            color: white;
            background-color: indianred;
            border: none;
            border-bottom-color: white;
            border-bottom: solid;
        }
        .BoxNull {
            background-color: white;
            border: none;
            border-bottom-color: white;
            border-bottom: solid;
        }
    </style>
    <script>
        function JavaStyle() {
            var st = "<style> .fullscreen{ width: " + screen.width + "px; height: " + screen.height + "px; } .scroll{ overflow-y: scroll; height: " + (parseInt(screen.height) - 20).toString() + "px; } </style>";
            document.write(st);
            //alert(screen.width + " " + screen.height)
        }
        JavaStyle();
    </script>
    <script>
        function fn_dateNowThai() {
            var today = new Date();
            var dd = today.getDate();
            var mm = today.getMonth();
            var yyyy = today.getFullYear() + 543;
            today = dd + ' ' + fn_MonthThai(mm) + ' ' + yyyy;
            document.write(today);
        }
        function fn_MonthThai(mm) {
            var mTh = ['มกราคม', 'กุมภาพันธ์', 'มีนาคม', 'เมษายน', 'พฤษภาคม', 'มิถุนายน', 'กรกฎาคม', 'สิงหาคม', 'กันยายน', 'ตุลาคม', 'พฤศจิกายน', 'ธันวาคม'];
            return mTh[mm];
        }
    </script>
</head>
<body>
    <form id="form_rehabTV" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:Label ID="lbl_Box" Text="" runat="server"></asp:Label>
        <asp:Timer ID="timee1" OnTick="timee1_Tick" Interval="180000" runat="server"></asp:Timer>
    </form>
</body>
</html>
