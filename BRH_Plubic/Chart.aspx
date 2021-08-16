<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Chart.aspx.cs" Inherits="BRH_Plubic.Chart" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">

<div class="col-10 mx-auto my-auto text-center">
    
    <div class="row col-12 mx-auto">
        <canvas id="myRadar" class="col col-lg-4 col-sm-12 mx-auto my-3" width="100%" height="60"></canvas>
        <canvas id="myDoughnut" class="col col-lg-4 col-sm-12 mx-auto my-3" width="100%" height="50"></canvas>
        <canvas id="myPolarArea" class="col col-lg-4 col-sm-12 mx-auto my-3" width="100%" height="60"></canvas>
        <canvas id="myline" class="col col-lg-5 col-sm-12 mx-auto my-3" width="100%" height="50"></canvas>
        <canvas id="myBar" class="col col-lg-5 col-sm-12 mx-auto my-3" width="100%" height="50"></canvas>
    </div>

    <script>
        //------------------------------------------------------------------------- doughnut
        var ctxDoughnut = document.getElementById('myDoughnut').getContext('2d');
        var myDoughnut = new Chart(ctxDoughnut, {
            type: 'doughnut',
            data: {
                labels: ['Red', 'Blue', 'Yellow'],
                datasets: [{
                    label: '# of Votes',
                    data: [10, 20, 30],
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.5)',
                        'rgba(54, 162, 235, 0.5)',
                        'rgba(255, 206, 86, 0.5)'
                    ],
                    borderColor: [
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)'
                    ],
                    borderWidth: 3
                }]
            }
        });

        //------------------------------------------------------------------------- polarArea
        var ctxPolarArea = document.getElementById('myPolarArea').getContext('2d');
        var myPolarArea = new Chart(ctxPolarArea, {
            type: 'polarArea',
            data: {
                labels: ['Red', 'Blue' ,'Purple', 'Yellow'],
                datasets: [{
                    label: '# of Votes',
                    data: [18, 43, 25, 30],
                    backgroundColor: [
                        'rgba(255, 99, 132, 2)',
                        'rgba(54, 162, 235, 2',
                        'rgba(153, 102, 255, 2',
                        'rgba(255, 206, 86, 2)'
                    ],
                    borderWidth: 3
                }]
            }
        });

        //------------------------------------------------------------------------- radar
        var ctxRadar = document.getElementById('myRadar').getContext('2d');
        var myRadar = new Chart(ctxRadar, {
            type: "radar",
            data: {
                labels: ["Eating", "Drinking", "Sleeping", "Designing", "Coding", "Cycling", "Running"],
                datasets: [{
                    label: "My First Dataset",
                    data: [65, 59, 90, 81, 56, 55, 40],
                    fill: true,
                    backgroundColor: [
                        "rgba(255, 99, 132, 0.2)"
                    ],
                    borderColor: [
                        "rgb(255, 99, 132)"
                    ],
                    pointBackgroundColor: [
                        "rgb(255, 99, 132)"
                    ],
                    pointBorderColor: [
                        "#fff"
                    ],
                    pointHoverBackgroundColor: [
                        "#fff"
                    ],
                    pointHoverBorderColor: [
                        "rgb(255, 99, 132)"
                    ]
                },
                {
                    label: "My Second Dataset",
                    data: [28, 48, 40, 19, 96, 27, 100],
                    fill: true,
                    backgroundColor: [
                        "rgba(54, 162, 235, 0.2)"
                    ],
                    borderColor: [
                        "rgb(54, 162, 235)"
                    ],
                    pointBackgroundColor: [
                        "rgb(54, 162, 235)"
                    ],
                    pointBorderColor: [
                        "#fff"
                    ],
                    pointHoverBackgroundColor: [
                        "#fff"
                    ],
                    pointHoverBorderColor: [
                        "rgb(54, 162, 235)"
                    ]
                }]
            },
            options: {
                elements: {
                    line: {
                        tension: 0, borderWidth: 3
                    }
                }
            }
        });

        //------------------------------------------------------------------------- line
        var ctxline = document.getElementById('myline').getContext('2d');
        var myline = new Chart(ctxline, {
            type: 'line',
            data: {
                labels: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'],
                datasets: [{
                    label: '# of Votes',
                    data: [12, 19, 3, 5, 8, 3],
                    backgroundColor: [
                        'rgba(10, 60, 64, 0.5)'
                    ],
                    borderColor: [
                        'rgba(255, 99, 132, 2)'
                    ],
                    pointBackgroundColor: [
                        "rgb(54, 162, 235, 0.2)"
                    ],
                    pointBorderColor: [
                        'rgba(255, 206, 86, 2)',
                        'rgba(255, 206, 86, 2)',
                        'rgba(255, 206, 86, 2)',
                        'rgba(255, 206, 86, 2)',
                        'rgba(255, 206, 86, 2)',
                        'rgba(255, 206, 86, 2)'
                    ],
                    borderWidth: 3
                }]
            },
            options: {
                scales: {
                    yAxes: [{
                        ticks: {
                            beginAtZero: true
                        }
                    }]
                }
            }
        });

        //------------------------------------------------------------------------- bar
        var ctxBar = document.getElementById('myBar').getContext('2d');
        var myBar = new Chart(ctxBar, {
            type: 'bar',
            data: {
                labels: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'],
                datasets: [{
                    label: '# of Votes',
                    data: [12, 19, 3, 5, 8, 3],
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.5)',
                        'rgba(54, 162, 235, 0.5)',
                        'rgba(255, 206, 86, 0.5)',
                        'rgba(75, 192, 192, 0.5)',
                        'rgba(153, 102, 255, 0.5)',
                        'rgba(255, 159, 64, 0.5)'
                    ],
                    borderColor: [
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(75, 192, 192, 1)',
                        'rgba(153, 102, 255, 1)',
                        'rgba(255, 159, 64, 1)'
                    ],
                    borderWidth: 3
                }]
            },
            options: {
                scales: {
                    yAxes: [{
                        ticks: {
                            beginAtZero: true
                        }
                    }]
                }
            }
        });

    </script>

</div>

</asp:Content>
