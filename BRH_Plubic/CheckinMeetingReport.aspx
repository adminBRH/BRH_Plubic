<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CheckinMeetingReport.aspx.cs" Inherits="BRH_Plubic.CheckinMeetingReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentDesktop" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<style>
    .title {
        position: absolute;
        margin: auto;
        margin-top: -50px;
        padding: 10px;
        font-size: xx-large;
        font-weight: bold;
        text-shadow: 2px 2px 2px #808080;
    }
    .ddTopic {
        position: absolute;
        margin-left: 50px;
        margin-bottom: -10px;
        padding: 10px;
    }
    .titleChart {
        position: absolute;
        margin-top: -10px;
        padding: 25px;
        padding-left: 100px;
        font-size: x-large;
        font-weight: bold;
        text-shadow: 2px 2px 2px #808080;
    }
    .backHome {
        position: absolute;
        margin-top: -30px;
        margin-left: 85%;
        text-shadow: 2px 2px 2px #808080;
    }
</style>

    <div class="alert alert-dark mb-5">
        <div class="title">
            Meeting room Dashboard
        </div>
        <div class="ddTopic">
            <asp:DropDownList ID="dd_topic" CssClass="btn btn-info" OnSelectedIndexChanged="dd_topic_SelectedIndexChanged" AutoPostBack="true" runat="server">
                <asp:ListItem Text="" Value=""></asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="backHome">
            <a href="MeetingRoom.aspx" style="font-size: x-large; font-weight: bold;">Room <i class="fa fa-backward"></i></a>
        </div>
    </div>

    <div class="row col-12 mx-auto" style="margin: auto;">
        <div class="col-lg-4 col-sm-12 mx-auto" style="margin: auto; margin-top: 0px;">
            <div class="titleChart">
                <span class="badge badge-info">Person by Date <i class="fa fa-calendar"></i></span>
            </div>
            <canvas id="chart_bar" style="width: 100%"></canvas>
        </div>
        <div class="col-lg-4 col-sm-12 mx-auto" style="margin: auto; margin-bottom: 0px;">
            <div class="titleChart">
                <span class="badge badge-info">Person by Time <i class="fa fa-clock-o"></i></span>
            </div>
            <canvas id="chart_line" style="width: 100%"></canvas>
        </div>
        <div class="col-lg-4 col-sm-12 mx-auto" style="margin: auto;">
            <div class="titleChart">
                <span class="badge badge-info">HOD & STAFF <i class="fa fa-user-md"></i></span>
            </div>
            <canvas id="chart_doughnut" style="width: 100%"></canvas>
        </div>
    </div>

    <div hidden="hidden">
        <input type="text" id="txtH_bar" value="" runat="server" disabled="disabled" />
        <input type="text" id="txtH_line" value="" runat="server" disabled="disabled" />
        <input type="text" id="txtH_doughnut" value="" runat="server" disabled="disabled" />
    </div>
    

<script>

    function fn_color(name,tran) {
        var color = '';
        switch (name) {
            case 'blue': color = 'rgba(54, 162, 235, ' + tran + ')'; break;
            case 'red': color = 'rgba(255, 99, 132, ' + tran + ')'; break;
            case 'green': color = 'rgba(75, 192, 192, ' + tran + ')'; break;
            case 'yellow': color = 'rgba(255, 206, 86, ' + tran + ')'; break;
            case 'purple': color = 'rgba(153, 102, 255, ' + tran + ''; break;
            case 'orange': color = 'rgba(255, 159, 64, ' + tran + ')'; break;
            default: color = 'rgba(54, 162, 235, 0.5)'; break;
        }
        return color;
    }

    function fn_LabelData(ar, type) {
        var result = [];
        if (ar != '') {
            var sp = ar.split('@');
            if (type == 'data') {
                result = sp[1].split(',');
            } else {
                result = sp[0].split(',');
            }
        }
        return result;
    }

    var arBar = document.getElementById('<%= txtH_bar.ClientID %>').value;
    var ctx = document.getElementById('chart_bar').getContext('2d');
    var chart_bar = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: fn_LabelData(arBar, 'label'),
            datasets: [{
                label: 'QTY',
                data: fn_LabelData(arBar, 'data'),
                backgroundColor: 'rgba(54, 162, 235, 0.2)',
                borderColor: 'rgba(54, 162, 235, 1)',
                borderWidth: 2
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });

    var arLine = document.getElementById('<%= txtH_line.ClientID %>').value;
    var ctx = document.getElementById('chart_line').getContext('2d');
    var chart_bar = new Chart(ctx, {
        type: 'line',
        data: {
            labels: fn_LabelData(arLine, 'label'),
            datasets: [{
                label: 'QTY',
                backgroundColor: 'rgb(61, 10, 100, 0.2)',
                borderColor: 'rgb(255, 99, 132)',
                data: fn_LabelData(arLine, 'data'),
            }]
        },
        options: {}
    });

    var arDoughnut = document.getElementById('<%= txtH_doughnut.ClientID %>').value;
    var ctx = document.getElementById('chart_doughnut').getContext('2d');
    var chart_doughnut = new Chart(ctx, {
        type: 'doughnut',
        data: {
            labels: fn_LabelData(arDoughnut, 'label'),
            datasets: [{
                label: 'QTY',
                backgroundColor: [
                    fn_color('yellow',0.5),
                    fn_color('blue',0.5),
                ],
                data: fn_LabelData(arDoughnut, 'data'),
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    position: 'top',
                },
                title: {
                    display: true,
                    text: 'Doughnut Chart'
                }
            }
        },
    });

</script>

</asp:Content>
