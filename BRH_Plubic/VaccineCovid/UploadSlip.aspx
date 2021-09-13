<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UploadSlip.aspx.cs" Inherits="BRH_Plubic.VaccineCovid.UploadSlip" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Confirm Slip of booking vaccine Moderna</title>
    <link href="~/images/icon/apple-icon-57x57.png" rel="shortcut icon" type="image/x-icon" />

    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="../fonts/font-awesome-4.7.0/css/font-awesome.min.css">

    <!-- 'Prompt', sans-serif -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Prompt:wght@200&display=swap" rel="stylesheet">

    <style>
        .center-screen {
          display: flex;
          flex-direction: column;
          justify-content: center;
          align-items: center;
          min-height: 100vh;

          background-color: royalblue;
        }
        .BoxSlip {
            width: 90%;
            margin: auto;
            padding: 25px;
            border-radius: 20px;
            border: solid;
            border-color: beige;
            box-shadow: 4px 4px #000000;
            color: white;
            font-family: 'Prompt', sans-serif;
        }
        .Logo {
            position: absolute;
            margin-top: 0px;
            margin-left: -65px;
            width:200px;
            height: 100px;
        }
        .BoxTitle {
            position: absolute;
            margin-top: 0px;
            padding: 25px;
            width: 90%;
            height: 70px;
            font-size: x-large;
            font-weight: bold;
            border-top-right-radius: 20px;
            border-bottom-right-radius: 20px;
            box-shadow: 4px 4px #000000;
        }
        .BoxBody {
            padding: 10px;
            padding-top: 100px;
            border-bottom-left-radius: 20px;
            border-bottom-right-radius: 20px;
            background-color: lightgoldenrodyellow;
        }

        input[type=text] {
          width: 100%;
          font-size: xx-large;
          font-weight: bold;
          color: royalblue;
          text-align: center;
        }
        ::placeholder {
            color: royalblue;
            opacity: 1; /* Firefox */
            font-size: x-large;
            font-weight: bold;
            text-align: end;
        }
        :-ms-input-placeholder { /* Internet Explorer 10-11 */
            color: royalblue;
            font-size: x-large;
            font-weight: bold;
            text-align: end;
        }

        button {
            cursor: pointer;
        }

        .BoxData {
            border-radius: 20px;
            padding: 25px;
            background-color: lightgoldenrodyellow;
            color: black;
            font-size: xx-large;
            font-weight: bold;
            display: none;
        }

        .badgeFont {
            font-size: xx-large;
            font-weight: bold;
        }

        .ringBox {
            position: static;
            margin-top: -36px;
        }
        .half-circle {
            margin: auto;
            width: 30px;
            height: 15px;
            border-top-left-radius: 110px;
            border-top-right-radius: 110px;
            border: 6px solid #969393;
            border-bottom: 0;
            transform: rotate(90deg);
        }

        .btnSend {
            padding: 25px;
            color: white;
            font-weight: bold;
            border-radius: 10px;
            background-color: lightskyblue;
        }
        .btnSend:hover {
            box-shadow: 3px 3px #808080;
        }

        @-webkit-keyframes blinker {
          from {opacity: 1.0;}
          to {opacity: 0.0;}
        }
        .blink{
	        text-decoration: blink;
	        -webkit-animation-name: blinker;
	        -webkit-animation-duration: 0.5s;
	        -webkit-animation-iteration-count:infinite;
	        -webkit-animation-timing-function:ease-in-out;
	        -webkit-animation-direction: alternate;
        }
    </style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
    <form id="form_SlipModerna" runat="server">
        <div class="center-screen">
            <div class="BoxSlip">
                <div class="BoxTitle bg-dark">
                    <span style="margin-left: 130px;">Confirm slip for your booking vaccine `Moderna`</span> 
                </div>
                <div class="Logo">
                    <img src="../images/BGH_Rayong-Logo.jpg" style="width: 100%; border-radius: 20px;" />
                </div>
                <div class="BoxBody">
                    <div class="row col-12 mx-auto">
                        <div id="div_alert" class="col-11 mx-auto" runat="server" visible="false">
                            <div id="alertMsg" class="alert alert-danger" role="alert" runat="server" style="font-size: x-large; font-weight: bold;">
                                <i class="fa fa-info-circle"></i> <asp:Label ID="lbl_alert" Text="" runat="server"></asp:Label>
                            </div>
                        </div>
                        <div class="col-lg-6 col-sm-8 mx-auto my-sm-3">
                            <span class="badge badge-dark col-12 mx-auto">
                                <input type="text" id="txt_cardID" value="" placeholder="Passport number หรือ หมายเลขบัตรประชาชน" required="required" runat="server" />
                            </span>
                        </div>
                        <div class="col-lg-6 col-sm-8 mx-auto my-sm-3">
                            <span class="badge badge-dark col-12 mx-auto">
                                <input type="text" id="txt_phonenumber" value="" placeholder="Phone number เบอร์โทรศัพท์" required="required" onkeypress="if(this.value.length>=10) return false;" runat="server" />
                            </span>
                        </div>
                        <div id="div_search" class="col-12 mx-auto text-center my-3" runat="server">
                            <button id="btn_check" class="btn btn-info" runat="server" onserverclick="btn_check_ServerClick" style="font-weight: bold; font-size: xx-large;">
                                <i class="fa fa-search"></i> Search
                            </button>
                        </div>
                    </div>
                </div>
                <div id="div_data1" class="BoxData col-12 mx-auto mt-2">
                    <div class="ringBox row col-12 mx-auto text-center">
                        <div class="col-1 mx-auto"><div class="half-circle"></div></div>
                        <div class="col-1 mx-auto"><div class="half-circle"></div></div>
                        <div class="col-6 mx-auto">&nbsp;</div>
                        <div class="col-1 mx-auto"><div class="half-circle"></div></div>
                        <div class="col-1 mx-auto"><div class="half-circle"></div></div>
                    </div>
                    <div class="row">
                        <div class="col-7 mx-auto"> <i class="fa fa-user-circle"></i> <asp:Label ID="lbl_name" Text="" runat="server"></asp:Label> </div>
                        <div class="col-5 mx-auto text-right">จองทั้งหมด <span class="badge badge-success badgeFont"><asp:Label ID="book_qtytotal" Text="" runat="server"></asp:Label></span> เข็ม</div>
                        <input type="text" id="txtH_wantMax" value="" runat="server" hidden="hidden" />
                    </div>
                </div>
                <div id="div_data2" class="BoxData col-12 mx-auto mt-2">
                    <div class="ringBox row col-12 mx-auto text-center">
                        <div class="col-1 mx-auto"><div class="half-circle"></div></div>
                        <div class="col-1 mx-auto"><div class="half-circle"></div></div>
                        <div class="col-6 mx-auto">&nbsp;</div>
                        <div class="col-1 mx-auto"><div class="half-circle"></div></div>
                        <div class="col-1 mx-auto"><div class="half-circle"></div></div>
                    </div>
                    <asp:ListView ID="LV_bookdetails" runat="server">
                        <LayoutTemplate>
                            <div id="itemPlaceholder" class="col-12 mx-auto" runat="server"></div>
                        </LayoutTemplate>
                        <ItemTemplate>
                            <div class="row my-1">
                                <div class="col-7 mx-auto">
                                    ลำดับการจองเลขที่ <span class="badge badge-info badgeFont"><%# Eval("cm_payid") %></span>
                                    <span class="badge badge-secondary" style="font-size: medium;"><i class="fa fa-vcard-o"></i> <%# Eval("cm_cardid") %> <%# Eval("cm_name") %></span>
                                </div>
                                <div class="col-5 mx-auto text-right">จำนวน <span class="badge badge-success badgeFont"><%# Eval("cm_qty") %></span> เข็ม</div>
                            </div>
                        </ItemTemplate>
                    </asp:ListView>
                </div>
                <div id="div_data3" class="BoxData col-12 mx-auto mt-2">
                    <div class="ringBox row col-12 mx-auto text-center">
                        <div class="col-1 mx-auto"><div class="half-circle"></div></div>
                        <div class="col-1 mx-auto"><div class="half-circle"></div></div>
                        <div class="col-6 mx-auto">&nbsp;</div>
                        <div class="col-1 mx-auto"><div class="half-circle"></div></div>
                        <div class="col-1 mx-auto"><div class="half-circle"></div></div>
                    </div>
                    <div class="row">
                        <div class="col-6 mx-auto">ราคาเข็มละ <span class="badge badge-primary badgeFont"><asp:Label ID="lbl_price" Text="" runat="server"></asp:Label></span> บาท</div>
                        <div class="col-6 mx-auto text-right">ยอดรวมสุทธิ <span class="badge badge-warning badgeFont"><asp:Label ID="lbl_pricetotal" Text="" runat="server"></asp:Label></span> บาท</div>
                    </div>
                </div>
                <div id="div_data4" class="BoxData col-12 mx-auto mt-2">
                    <div class="ringBox row col-12 mx-auto text-center">
                        <div class="col-1 mx-auto"><div class="half-circle"></div></div>
                        <div class="col-1 mx-auto"><div class="half-circle"></div></div>
                        <div class="col-6 mx-auto">&nbsp;</div>
                        <div class="col-1 mx-auto"><div class="half-circle"></div></div>
                        <div class="col-1 mx-auto"><div class="half-circle"></div></div>
                    </div>
                    <div class="row col-12 mx-auto">
                        <div class="alert alert-danger col-12" style="font-size: large;">
                            หมายเหตุ : บัตรประชาชนหนึ่งใบ จะสามารถขอใช้สิทธิ์ได้ไม่เกิน 2เข็มเท่านั้น ถึงแม้ว่าท่านจะสามารถจองไว้ได้หลายเข็ม
                        </div>
                    </div>
                </div>
                <div id="div_data5" class="BoxData col-12 mx-auto mt-2">
                    <div class="ringBox row col-12 mx-auto text-center">
                        <div class="col-1 mx-auto"><div class="half-circle"></div></div>
                        <div class="col-1 mx-auto"><div class="half-circle"></div></div>
                        <div class="col-6 mx-auto">&nbsp;</div>
                        <div class="col-1 mx-auto"><div class="half-circle"></div></div>
                        <div class="col-1 mx-auto"><div class="half-circle"></div></div>
                    </div>
                    <div class="row">
                        <div class="col-6 mx-auto">
                            คุณต้องการ
                            <span class="col-3 badge badge-success badgeFont">
                                <input type="number" id="txt_want" class="col-12" value="1" onblur="fn_pay()" required="required" runat="server" style="text-align: center;" />
                            </span> 
                            เข็ม
                        </div>
                        <div class="col6 mx-auto my-auto text-right">ยอดที่ชำระ <span class="badge badge-danger badgeFont"><label id="lbl_PaySlip" class="blink"></label></span> บาท</div>
                        <script>
                            function fn_pay() {
                                var qty = document.getElementById('<%= txt_want.ClientID %>');
                                var price = document.getElementById('<%= lbl_price.ClientID %>');
                                var max = document.getElementById('<%= txtH_wantMax.ClientID %>').value;
                                if (parseInt(qty.value) < 0) {
                                    qty.value = '0';
                                }
                                if (parseInt(qty.value) > parseInt(max)) {
                                    qty.value = parseInt(max);
                                }
                                var pay = parseInt(qty.value) * parseInt(price.innerHTML);
                                document.getElementById('lbl_PaySlip').innerHTML = pay;
                            }
                            fn_pay();
                        </script>
                    </div>
                </div>
                <div id="div_data6" class="BoxData col-12 mx-auto mt-2" hidden="hidden">
                    <div class="ringBox row col-12 mx-auto text-center">
                        <div class="col-1 mx-auto"><div class="half-circle"></div></div>
                        <div class="col-1 mx-auto"><div class="half-circle"></div></div>
                        <div class="col-6 mx-auto">&nbsp;</div>
                        <div class="col-1 mx-auto"><div class="half-circle"></div></div>
                        <div class="col-1 mx-auto"><div class="half-circle"></div></div>
                    </div>
                    <div class="row">
                        <div class="col-12 mx-auto">
                            ธนาคาร ไทยพาณิชย์ (BANK: SCB) 
                        </div>
                        <div class="col-12 mx-auto">
                            เลขที่บัญชี <span class="badge badge-secondary badgeFont">523-304467-9</span>
                        </div>
                        <div class="col-12 mx-auto">
                            ชื่อบัญชี บริษัทโรงพยาบาลกรุงเทพระยอง จำกัด
                        </div>
                    </div>
                </div>
                <div id="div_data7" class="BoxData col-12 mx-auto mt-2" hidden="hidden">
                    <div class="ringBox row col-12 mx-auto text-center">
                        <div class="col-1 mx-auto"><div class="half-circle"></div></div>
                        <div class="col-1 mx-auto"><div class="half-circle"></div></div>
                        <div class="col-6 mx-auto">&nbsp;</div>
                        <div class="col-1 mx-auto"><div class="half-circle"></div></div>
                        <div class="col-1 mx-auto"><div class="half-circle"></div></div>
                    </div>
                    <div class="row">
                        <div class="col-12 mx-auto">
                            แนบ <U style="color: red">ใบหลักฐานการโอนเงิน</U>
                            <span class="badge badge-dark">
                                <input type="file" id="uploadSlip" name="uploadSlip" onchange="previewFile()" required="required" runat="server" />
                            </span>
                        </div>
                        <div class="row col-12 mx-auto">
                            <div class="col-lg-4 col-sm-10 mx-auto text-center">
                                <asp:Image ID="previewSlip" runat="server" ImageUrl="..." Width="100%" />
                            </div>
                        </div>
                        <div hidden="hidden">
                            <input type="text" id="txtH_num" value="" runat="server" />
                            <input type="text" id="txtH_slip_pt" value="" runat="server" />
                            <input type="text" id="txtH_slip_pv" value="" runat="server" />
                        </div>
                    </div>
                </div>
                <script>
                    function previewFile() {
                        var preview = document.querySelector('#<%=previewSlip.ClientID %>');
                        var file = document.querySelector('#<%=uploadSlip.ClientID %>');
                    var reader = new FileReader();

                    var pt = document.getElementById('<%= txtH_slip_pt.ClientID %>');
                        var pv = document.getElementById('<%= txtH_slip_pv.ClientID %>');

                        reader.onloadend = function () {
                            preview.src = reader.result;
                            pt.value = fileName(file.value);
                            pv.value = reader.result;
                        }

                        if (file.files[0]) {
                            reader.readAsDataURL(file.files[0]);
                        } else {
                            preview.src = '';
                        }
                    }

                    function fileName(fakepath) {
                        var name = fakepath.split('\\');
                        var last = name.length - 1;
                        return name[last];
                    }
                </script>
                <div id="div_data8" class="BoxData col-12 mx-auto mt-2" hidden="hidden">
                    <div class="ringBox row col-12 mx-auto text-center">
                        <div class="col-1 mx-auto"><div class="half-circle"></div></div>
                        <div class="col-1 mx-auto"><div class="half-circle"></div></div>
                        <div class="col-6 mx-auto">&nbsp;</div>
                        <div class="col-1 mx-auto"><div class="half-circle"></div></div>
                        <div class="col-1 mx-auto"><div class="half-circle"></div></div>
                    </div>
                    <div class="row text-center">
                        <div class="col-6 mx-auto">
                            วันที่ <U style="color: red">ในหลักฐานการโอนเงิน</U>
                            <span class="badge badge-dark">
                                <input type="date" id="txt_date" value="" runat="server" />
                            </span>
                        </div>
                        <div class="col-6 mx-auto">
                            เวลา <U style="color: red">ในหลักฐานการโอนเงิน</U>
                            <span class="badge badge-dark">
                                <input type="time" id="txt_time" value="" runat="server" />
                            </span>
                        </div>
                    </div>
                </div>
                <div id="div_data9" class="BoxData col-10 mx-auto mt-2">
                    <div class="ringBox row col-12 mx-auto text-center">
                        <div class="col-6 mx-auto"><div class="half-circle"></div></div>
                        <div class="col-6 mx-auto"><div class="half-circle"></div></div>
                    </div>
                    <div class="col-12 mx-auto text-center mt-3">
                        <span class="badge badge-danger">
                            ขออภัย !! หมดเวลารับชำระและยืนยันสลิปแล้ว
                        </span>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <script>
        function fn_fadeDataIn() {
            var div = 9;
            $(document).ready(function () {
                var sc = 1000;
                for (var i = 1; i <= div; i++) {
                    $("#div_data" + i).fadeIn(sc);
                    sc = sc + 300;
                }
            });
        }
        function fn_fadeDataOut() {
            $(document).ready(function () {
                var sc = 1000;
                for (var i = 8; i > 0; i--) {
                    $("#div_data" + i).fadeOut(sc);
                    sc = sc + 100;
                }
            });
        }
    </script>
    <asp:Label ID="lbl_script" Text="" runat="server"></asp:Label>
</body>
</html>
