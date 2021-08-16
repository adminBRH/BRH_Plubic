<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SelfScreeningDashBoard.aspx.cs" Inherits="BRH_Plubic.SelfScreeningDashBoard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">

<div class="col-12 mx-auto my-auto text-center">
    
    <div class="row col-12 mx-auto">

        <div class="col-12 mx-auto my-3">
            <div class="card card-header bg-info h3">
                BRH Self Screening Dash Board
            </div>
            <div class="card card-body bg-transparent">
                <div class="row col-12">
                    <div class="col-4">
                        Staff:
                        <asp:DropDownList ID="DD_staff" CssClass="btn btn-outline-primary" runat="server">
                            <asp:ListItem Value="" Text="ALL"></asp:ListItem>
                            <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                            <asp:ListItem Value="No" Text="No"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-6">
                        Date:<input type="date" id="date_search1" class="btn btn-outline-primary" value="" onchange="CheckSearch()" runat="server" /> 
                        to <input type="date" id="date_search2" class="btn btn-outline-primary" value="" onchange="CheckSearch()" runat="server" />
                    </div>
                    <div class="col-2 text-center">
                        <button id="btn_search" class="btn btn-outline-primary" value="Search" onserverclick="btn_search_ServerClick" runat="server">Search</button>
                    </div>
                </div>
            </div>
        </div>

        <script>
            var Date1 = document.getElementById('<%= date_search1.ClientID %>');
            var Date2 = document.getElementById('<%= date_search2.ClientID %>');

            function CheckSearch() {
                if (Date1.value != '') {
                    Date2.removeAttribute('disabled');
                    if (Date2.value == "") {
                        Date2.value = Date1.value;
                    } else {
                        if (Date2.value < Date1.value) {
                            Date2.value = Date1.value;
                            alert('ไม่สามารถเลือกวันที่ น้อยกว่าวันที่เริ่มต้นได้ !!');
                        }
                    }
                }
            }
        </script>

        <div id="printableArea" class="row col-12 mx-auto">

            <div class="col-12 mx-auto text-center bg-info h3">
                Data <asp:Label ID="lbl_Date1" ForeColor="White" Text="" runat="server"></asp:Label> to <asp:Label ID="lbl_Date2" ForeColor="White" Text="" runat="server"></asp:Label>
            </div>

        <!-- Gender -->
        <div class="col col-lg-5 col-sm-12 mx-auto my-3">
            <div class="card card-title bg-info text-center h3">
                Gender
            </div>
            <div class="card card-body bg-transparent">
                <div class="row col-12">
                    <div class="col-4 text-right">
                        <img src="images/Male.png" />Men
                    </div>
                    <div class="col-8 text-right">
                        <div style="font-size:40px"><asp:Label ID="lbl_Male" Text="" ForeColor="SkyBlue" runat="server"></asp:Label></div>คน
                    </div>
                </div>
                <hr />
                <div class="row col-12">
                    <div class="col-4 text-right">
                        <img src="images/Female.png" />Women
                    </div>
                    <div class="col-8 text-right">
                        <div style="font-size:40px"><asp:Label ID="lbl_Female" Text="" ForeColor="Red" runat="server"></asp:Label></div>คน
                    </div>
                </div>
            </div>
        </div>

        <!-- Criteria -->
        <div class="col col-lg-7 col-sm-12 mx-auto my-3">
            <div class="card card-title bg-info text-center h3">
                Criteria
            </div>
            <div class="card card-body bg-transparent">
                <canvas id="cv_CTR" height="335"></canvas>
                <div hidden="hidden">
                    <input type="text" id="txt_CTR" value="" runat="server" />
                    <input type="text" id="txt_CTR_value" value="" runat="server" />
                </div>
            </div>
        </div>

        <!-- Employee -->
        <div class="col col-lg-4 col-sm-12 mx-auto my-3">
            <div class="card card-title bg-info text-center h3">
                Employee
            </div>
            <div class="card card-body bg-transparent">
                <canvas id="cv_emp" height="300"></canvas>
                <div hidden="hidden">
                    <input type="text" id="txt_emp" value="" runat="server" />
                    <input type="text" id="txt_emp_value" value="" runat="server" />
                </div>
            </div>
        </div>

        <!-- Age rank -->
        <div class="col col-lg-8 col-sm-12 mx-auto my-3">
            <div class="card card-title bg-info text-center h3">
                Age rank
            </div>
            <div class="card card-body bg-transparent">
                <canvas id="cv_Age" height="300"></canvas>
                <div hidden="hidden">
                    <input type="text" id="txt_Age" value="" runat="server" />
                    <input type="text" id="txt_Age_value" value="" runat="server" />
                </div>
            </div>
        </div>

        <!-- Self Symptoms -->
        <div class="col col-lg-4 col-sm-12 mx-auto my-3">
            <div class="card card-title bg-info text-center h3">
                Self Symptoms
            </div>
            <div class="card card-body bg-transparent">
                <canvas id="cv_Symptoms" class="col-12" height="300"></canvas>
                <div hidden="hidden">
                    <input type="text" id="txt_Symptoms" value="" runat="server" />
                    <input type="text" id="txt_Symptoms_value" value="" runat="server" />
                </div>
            </div>
        </div>

        <!-- Transaction by date -->
        <div class="col col-lg-8 col-sm-12 mx-auto my-3">
            <div class="card card-title bg-info text-center h3">
                Transaction last 15 days
            </div>
            <div class="card card-body bg-transparent">
                <canvas id="cv_QtyByDate" height="300"></canvas>
                <div hidden="hidden">
                    <input type="text" id="txt_QBD" value="" runat="server" />
                    <input type="text" id="txt_QBDvalue" value="" runat="server" />
                    <input type="text" id="txt_QVD" value="" runat="server" />
                    <input type="text" id="txt_QVN" value="" runat="server" />
                    <input type="text" id="txt_QVQ" value="" runat="server" />
                </div>
            </div>
        </div>

        <script>
            function ChartColor(x) { // x = Intensity
                var Red = 'rgba(255, 99, 132, ' + x + ')';
                var Green = 'rgba(75, 192, 192, ' + x + ')';
                var Yellow = 'rgba(255, 206, 86, ' + x + ')';
                var Blue = 'rgba(54, 162, 235, ' + x + ')';
                var Purple = 'rgba(153, 102, 255, ' + x + '';
                var Orange = 'rgba(255, 159, 64, ' + x + ')';

                var rs = [Red, Green, Yellow, Blue, Purple, Orange];
                return rs;
            }
            function ChartPoint(Qtydate, Colorindex) {
                var rs = [];
                for (i = 1; i <= Qtydate; i++) {
                    rs.push(ChartColor(2)[Colorindex]);
                }
                return rs;
            }

            GenerateChart();

            //------------------------------------------------------------------------- 
            function Criteria() {
                var ctxCTR = document.getElementById('cv_CTR').getContext('2d');
                var CTRLabel = document.getElementById('<%= txt_CTR.ClientID %>').value.split(',');
                var CTRData = document.getElementById('<%= txt_CTR_value.ClientID %>').value.split(',');
                var cv_CTR = new Chart(ctxCTR, {
                    type: 'polarArea',
                    data: {
                        labels: CTRLabel,
                        datasets: [{
                            data: CTRData,
                            backgroundColor: ChartColor(2),
                            borderWidth: 3
                        }]
                    },
                    options: {
                        tooltips: {
                            enabled: false
                        },
                        legend: {
                            position: 'left',
                            align: 'start',
                            labels: {
                                fontSize: 25
                            }
                        },
                        plugins: {
                            datalabels: {
                                formatter: function (value, context) {
                                    return context.chart.data.labels[context.dataIndex];
                                }
                            }
                        }
                    }
                });
            }

            //-------------------------------------------------------------------------  
            function Employee() {
                var ctx_emp = document.getElementById('cv_emp').getContext('2d');
                var empLabel = document.getElementById('<%= txt_emp.ClientID %>').value.split(',');
                var empData = document.getElementById('<%= txt_emp_value.ClientID %>').value.split(',');
                var cv_emp = new Chart(ctx_emp, {
                    type: 'doughnut',
                    data: {
                        labels: empLabel,
                        datasets: [{
                            data: empData,
                            backgroundColor: ChartColor(3),
                            borderColor: ChartColor(1),
                            borderWidth: 3
                        }]
                    },
                    options: {
                        legend: {
                            position: 'left',
                            align: 'start'
                        }
                    }
                });
            }

            //------------------------------------------------------------------------- 
            function AgeRank() {
                var ctxAge = document.getElementById('cv_Age').getContext('2d');
                var ageLabel = document.getElementById('<%= txt_Age.ClientID %>').value.split(',');
                var ageData = document.getElementById('<%= txt_Age_value.ClientID %>').value.split(',');
                var cv_Age = new Chart(ctxAge, {
                    type: 'bar',
                    data: {
                        labels: ageLabel,
                        datasets: [{
                            label: '# of Votes',
                            data: ageData,
                            backgroundColor: ChartColor(0.5),
                            borderColor: ChartColor(1),
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
                        },
                        legend: {
                            display: false
                        }
                    }
                });
            }

            //------------------------------------------------------------------------- 
            function Symptoms() {
                var ctxSymptoms = document.getElementById('cv_Symptoms').getContext('2d');
                var SymptomsLabel = document.getElementById('<%= txt_Symptoms.ClientID %>').value.split(',');
                var SymptomsData = document.getElementById('<%= txt_Symptoms_value.ClientID %>').value.split(',');
                var cv_Symptoms = new Chart(ctxSymptoms, {
                    type: "radar",
                    data: {
                        labels: SymptomsLabel,
                        datasets: [{
                            label: "QTY",
                            data: SymptomsData,
                            backgroundColor: ChartColor(0.5)[4],
                            borderColor: ChartColor(0.5)[4],
                            pointBackgroundColor: ChartColor(0.5)[4],
                            pointBorderColor: ChartColor(0.5)[5],
                            pointHoverBackgroundColor: ChartColor(0.5)[5],
                            pointHoverBorderColor: ChartColor(0.5)[4]
                        }]
                    },
                    options: {
                        elements: {
                            line: {
                                tension: 0, borderWidth: 1
                            }
                        },
                        legend: {
                            position: 'left',
                            align: 'start'
                        },
                        plugins: {
                            datalabels: {
                                formatter: function (value, context) {
                                    return '';
                                }
                            }
                        }
                    }
                });
            }

            //-------------------------------------------------------------------------  
            function QtyByDate() {
                var ctx_QtyByDate = document.getElementById('cv_QtyByDate').getContext('2d');
                var QtyByDateLabel = document.getElementById('<%= txt_QBD.ClientID %>').value.split(',');
                var QtyByDateData = document.getElementById('<%= txt_QBDvalue.ClientID %>').value.split(',');
                var QtyD_Data = document.getElementById('<%= txt_QVD.ClientID %>').value.split(',');
                var QtyN_Data = document.getElementById('<%= txt_QVN.ClientID %>').value.split(',');
                var QtyQ_Data = document.getElementById('<%= txt_QVQ.ClientID %>').value.split(',');
                var cv_QtyByDate = new Chart(ctx_QtyByDate, {
                    type: 'bar',
                    data: {
                        labels: QtyByDateLabel,
                        datasets: [{
                                label: 'Dangers',
                                data: QtyD_Data,
                                backgroundColor: ChartColor(1)[0],
                                type: 'line',
                                pointRadius: 5,
                                pointHoverRadius: 10,
                                order: 1
                            }, {
                                label: 'Quarantine',
                                data: QtyQ_Data,
                                backgroundColor: ChartColor(1)[2],
                                type: 'line',
                                pointRadius: 10,
                                pointHoverRadius: 15,
                                order: 2
                            }, {
                                label: 'Normal',
                                data: QtyN_Data,
                                backgroundColor: ChartColor(1)[1],
                                type: 'line',
                                pointRadius: 5,
                                pointHoverRadius: 10,
                                order: 3
                            }, {
                                label: 'QTY',
                                data: QtyByDateData,
                                backgroundColor: ChartColor(1)[4],
                                borderColor: ChartColor(0.2)[4],
                                borderWidth: 3,
                                order: 4
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
            }


            function GenerateChart() {
                Criteria();
                Employee();
                AgeRank();
                Symptoms();
                QtyByDate();
            }

            function GotoReport() {
                window.location.href = 'SelfScreeningReport.aspx';
            }

            </script>

        </div>

        <div class="col-12 mx-auto">
            <input type="button" class="btn btn-outline-info mx-5" onclick="GotoReport()" value="REPORT" />
        </div>

    </div>

</div>

</asp:Content>
