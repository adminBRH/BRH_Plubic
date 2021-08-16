﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="myWebForm.aspx.cs" Inherits="BRH_Plubic.Queue.myWebForm" %>


<!DOCTYPE html>
<html>
<head>
    <title>SignalR Simple Chat</title>
    <style type="text/css">
        .container {
            background-color: #99CCFF;
            border: thick solid #808080;
            padding: 20px;
            margin: 20px;
        }

        .textQueue {
            text-shadow: 2px 2px 2px #808080;
            font-size: x-large;
        }
    </style>
</head>
<body>
    <div class="col-12 mx-auto" hidden="hidden">
        <asp:Label ID="lbl_IPAddress" Text="" runat="server"></asp:Label>
    </div>
    <div hidden="hidden">
        <input id="txt_dept" value="" runat="server" />
    </div>
    <div class="container" hidden="hidden">
        FirstName <input type="text" id="txtfName" /> LastName <input type="text" id="txtlName" />
        <input type="button" id="btnSave" value="Save" />
    </div>
    <div class="col-12 mx-auto text-center" style="font-size: x-large;">
        Queue of <asp:Label ID="lbl_DeptName" Text="" runat="server"></asp:Label>
    </div>

        <table width="100%" border="1" id="myTable">
        <!-- head table -->
        <thead>
          <tr style="background-color:burlywood">
            <td style="width: 10%;"> <div align="center">คิว</div></td>
            <td style="width: 15%;"> <div align="center">เพศ</div></td>
            <td style="width: 20%;"> <div align="center">ชื่อ</div></td>
            <td style="width: 20%;"> <div align="center">นามสกุล</div></td>
            <td style="width: 15%;"> <div align="center">อายุ</div></td>
            <td style="width: 20%;"> <div align="center">วันเวลา</div></td>
          </tr>
        </thead>
        <!-- body dynamic rows -->
        <tbody></tbody>
        </table>

    <!--Add script to update the page and send messages.-->
    <!--Reference the jQuery library. -->
    <script src="../Scripts/jquery-3.4.1.min.js" "></script>
    <!--Reference the SignalR library. -->
    <script src="../Scripts/jquery.signalR-2.4.1.js"></script>
    <!--Reference the autogenerated SignalR hub script. -->
    <script src="/signalr/hubs"></script>

    <script type="text/javascript">
        $(function () {

            // Declare a proxy to reference the hub.
            var chat = $.connection.centerHub;

            // Create a function that the hub can call to broadcast messages.
            chat.client.displayData = function (jsonData) {

                var deptid = document.getElementById("<%= txt_dept.ClientID %>");

                $('#myTable > tbody:last').empty();

                var obj = jQuery.parseJSON(jsonData);
                $.each(obj, function (key, val) {
                    var queue = val["queue"];
                    var datetimes = val["datetimes"];
                    var dept = val["dept"];
                    var age = val["age"];
                    var gender = val["gender"];
                    var fname = val["fname"];
                    var lname = val["lname"];
                    var active = val["active"];
                    var status = val["status"];
                    if (dept == deptid.value && active == "yes" && status == "wait") {
                        var tr = "<tr>";
                        tr = tr + "<td align='center'><div class='textQueue'>" + queue + "</div></td>";
                        tr = tr + "<td align='center'>" + gender + "</td>";
                        tr = tr + "<td>" + fname + "</td>";
                        tr = tr + "<td>" + lname + "</td>";
                        tr = tr + "<td align='center'>" + age + "</td>";
                        tr = tr + "<td>" + datetimes + "</td>";
                        tr = tr + "</tr>";
                    }
                    $('#myTable > tbody:last').append(tr);
                });

            };


            // Start the connection.
            $.connection.hub.start().done(function () {
                $("#btnSave").click(function () {
                    // Call the Send method on the hub.
                    chat.server.callFunction("insert into mytable(IP, dept, fname, lname) values('" + $('<%= lbl_IPAddress.ClientID %>').val() + "','" + dept + "','" + $('#txtfName').val() + "','" + $('#txtlName').val() + "');", "select * from mytable where convert(datetimes,date)=current_date order by id desc;");
                    // Clear text box and reset focus for next comment.
                    $("#txtName").val("").focus();
                    $("#txtEmail").val("").focus();
                });

                //First load
                chat.server.callFunction("", "select * from mytable where convert(datetimes,date)=current_date order by id desc;");

            });

        });
    </script>
</body>
</html>