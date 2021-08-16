<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="BRH_Plubic.Rehab.Dashboard" %>

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
    <form id="form1" runat="server">

        <table id="table_dashboard" class="fullscreen" style="font-family: 'Prompt', sans-serif;" border="0">
            <thead>
                <tr>
                    <th colspan="1" class="HeadOne">เจ้าหน้าที่</th>
                    <th colspan="24" class="HeadTwo text-center">
                        วันที่ <script>fn_dateNowThai();</script>
                        <span class="BoxBook blink">&nbsp;จองได้&nbsp;</span>
                        <span class="BoxBreak">&nbsp;พักเบรค&nbsp;</span>
                        <span class="BoxBooked">&nbsp;จองแล้ว&nbsp;</span>
                        <span class="BoxOvertime">&nbsp;เลยเวลา&nbsp;</span>
                        <label style='margin-right: 100px;' id='time'></label>
                    </th>
                    <%--<asp:Label ID="lbl_header" Text="" runat="server"></asp:Label>--%>
                </tr>
            </thead>
            <!-- body dynamic rows -->
            <tbody></tbody>
        </table>

        <script>
            function fn_AddMinute(time,min) {
                return new Date(time.getTime() + (min * 60000));
            }
            function fn_timeFull(t) {
                if (t < 10) { t = '0' + t; }
                return t;
            }
            function fn_datetimeFull(dt) {
                return dt.getFullYear() + "-" + fn_timeFull((dt.getMonth() + 1)) + "-" + dt.getDate() + " " + fn_timeFull(dt.getHours()) + ":" + fn_timeFull(dt.getMinutes()) + ":00";
            }
        </script>

        <script src="../Scripts/jquery-3.4.1.min.js" "></script>
        <script src="../Scripts/jquery.signalR-2.4.1.js"></script>
        <script src="/signalr/hubs"></script>
        <script type="text/javascript">

            $(function () {

                var Rehab = $.connection.rehabHUB;

                Rehab.client.displayData = function (jsonData) {
                    $('#table_dashboard > tbody:last').empty();
                    var toDay = new Date();
                    var DateNow = fn_datetimeFull(toDay);
                    var tr = "";
                    var colspan = 0;
                    var trH1 = "";
                    var tr1 = "";
                    var trH2 = "";
                    var tr2 = "";
                    var booked = "";
                    var obj = jQuery.parseJSON(jsonData);
                    $.each(obj, function (key, val) {
                        var dateID = val["DateID"];
                        var scheduleID = val["ScheduleID"];

                        var child = val["Child"];
                        var name = val["Name"];
                        var dates = val["Dates"].substring(0, 10);
                        var dateSt = val["DateSt"];
                        var dateEn = val["DateEn"];
                        var timeStart = val["TimeStart"];
                        var timeEnd = val["TimeEnd"];
                        var timesplit = val["Timesplit"];
                        var breakSt = val["BreakSt"];
                        var breakEn = val["BreakEn"];

                        var bookTime = val["Booktime"];
                        
                        var timeSt = new Date(dates + ' ' + dateSt);
                        var timeEn = new Date(dates + ' ' + dateEn);

                        breakSt = new Date(dates + ' ' + breakSt);
                        breakEn = new Date(dates + ' ' + breakEn);
                        
                        var workSt = new Date(dates + ' ' + timeStart);
                        var workEn = new Date(dates + ' ' + timeEnd);
                        
                        if (child == "yes") {
                            trH1 = "<tr><td colspan='^' style='background-color:bisque'><span style='margin-left: 100px;' class='BoxName'>เด็ก</span></td></tr>";
                            tr1 = tr1 + "<tr>";
                            tr1 = tr1 + "<td class='BoxName text-right'>" + name + "&nbsp;</td>";
                            var td = "";
                            // ------ Create Box ------
                            colspan = 2;
                            while (timeSt.getTime() <= timeEn.getTime()) {
                                var HH = fn_timeFull(timeSt.getHours()); 
                                var mm = fn_timeFull(timeSt.getMinutes()); 
                                
                                // ---- Find Status ----
                                var cl = "BoxNull";
                                if (workSt.getTime() <= timeSt.getTime() && timeSt.getTime() <= workEn.getTime()) {
                                    if (breakSt.getTime() <= timeSt.getTime() && timeSt.getTime() <= breakEn.getTime()) {
                                        cl = "BoxBreak";
                                    } else {
                                        //alert(bookTime.includes(fn_datetimeFull(timeSt)) + " : " + fn_datetimeFull(timeSt) + " --- " + bookTime);
                                        if (bookTime.includes(fn_datetimeFull(timeSt))) {
                                            cl = "BoxBooked";
                                        } else {
                                            if (timeSt.getTime() >= toDay.getTime()) {
                                                cl = "BoxBook";
                                            } else {
                                                cl = "BoxOvertime";
                                            }
                                        }
                                    }
                                }
                                // ---- Find Status ----
                                td = td + "<td class='" + cl + "'>" + HH + ":" + mm + "</td>";
                                timeSt = fn_AddMinute(timeSt, timesplit);
                                colspan++;
                            }
                            // ------ Create Box ------
                            tr1 = tr1 + td;
                            tr1 = tr1 + "</tr>";
                        } else {
                            trH2 = "<tr><td colspan='^' style='background-color:bisque'><span style='margin-left: 100px;' class='BoxName'>ผู้ใหญ่</span></td></tr>";
                            tr2 = tr2 + "<tr>";
                            tr2 = tr2 + "<td class='BoxName text-right'>" + name + "&nbsp;</td>";
                            var td = "";
                            // ------ Create Box ------
                            colspan = 2;
                            while (timeSt.getTime() <= timeEn.getTime()) {
                                var HH = fn_timeFull(timeSt.getHours());
                                var mm = fn_timeFull(timeSt.getMinutes());

                                // ---- Find Status ----
                                var cl = "BoxNull";
                                if (workSt.getTime() <= timeSt.getTime() && timeSt.getTime() <= workEn.getTime()) {
                                    if (breakSt.getTime() <= timeSt.getTime() && timeSt.getTime() <= breakEn.getTime()) {
                                        cl = "BoxBreak";
                                    } else {
                                        //alert(bookTime.includes(fn_datetimeFull(timeSt)) + " : " + fn_datetimeFull(timeSt) + " --- " + bookTime);
                                        if (bookTime.includes(fn_datetimeFull(timeSt))) {
                                            cl = "BoxBooked";
                                        } else {
                                            if (timeSt.getTime() >= toDay.getTime()) {
                                                cl = "BoxBook";
                                            } else {
                                                cl = "BoxOvertime";
                                            }
                                        }
                                    }
                                }
                                // ---- Find Status ----
                                td = td + "<td class='" + cl + "'>" + HH + ":" + mm + "</td>";
                                timeSt = fn_AddMinute(timeSt, timesplit);
                                colspan++;
                            }
                            // ------ Create Box ------
                            tr2 = tr2 + td;
                            tr2 = tr2 + "</tr>";
                        }
                    });

                    tr = tr + trH2 + tr2 + trH1 + tr1;
                    tr = tr.replaceAll('^', colspan);

                    $('#table_dashboard > tbody:last').append(tr);
                };

                $.connection.hub.start().done(function () {
                    Rehab.server.data();
                });

            });


            function checkTime(i) {
                if (i < 10) {
                    i = "0" + i;
                }
                return i;
            }
            function startTime() {
                var today = new Date();
                var h = today.getHours();
                var m = today.getMinutes();
                var s = today.getSeconds();
                // add a zero in front of numbers<10
                m = checkTime(m);
                s = checkTime(s);
                document.getElementById('time').innerHTML = h + ":" + m + ":" + s;
                t = setTimeout(function () {
                    startTime()
                }, 500);
            }
            startTime();

            function LoadTimer() {
                var now = new Date()
                var timeOfRefresh = new Date();
                var HH = now.getHours();
                var mm = 30;
                var ss = 0;
                if (now.getTime() >= timeOfRefresh.setMinutes(mm)) {
                    HH = HH + 1;
                    mm = 0;
                }
                timeOfRefresh.setHours(HH);
                timeOfRefresh.setMinutes(mm);
                timeOfRefresh.setSeconds(ss);
                var diff = timeOfRefresh.getTime() - now.getTime();
                var alertDiff = diff;
                //alert("wait reload : " + (alertDiff / 60000) + " min");
                setTimeout(function () {
                    window.location.reload(1);
                }, diff);
            }
            LoadTimer();
        </script>
    </form>
</body>
</html>
