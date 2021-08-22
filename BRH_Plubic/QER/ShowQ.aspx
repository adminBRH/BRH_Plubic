<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShowQ.aspx.cs" Inherits="BRH_Plubic.QER.ShowQ" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <title>
        BRH ER Queue
    </title>
    
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <!-- Themify Icons -->
    <link rel="stylesheet" href="../css/themify-icons.css">
    <!-- Owl carousel -->
    <link rel="stylesheet" href="../css/owl.carousel.min.css">
    <!-- Main css -->
    <link href="../css/style.css" rel="stylesheet">
    

    <script src="../js/ajax/jquery-2.1.3.min.js"></script>

    <script>
        function JavaStyle() {
            var st = "<style> .fullscreen{ width: " + screen.width + "px; height: " + screen.height + "px; } .scroll{ overflow-y: scroll; height: " + (parseInt(screen.height)-20).toString() + "px; } </style>";
            document.write(st);
            //alert(screen.width + " " + screen.height)
        }
    </script>

    <style>
        body, html {
            height: 100%;
            margin: 0;
        }

        .bg {
            /* The image used */
            background-image: url("../QER/img/white.jpeg");

            /* Full height */
            height: 100%; 

            /* Center and scale the image nicely */
            background-position: center;
            background-repeat: no-repeat;
            background-size: cover;
        }
         .MycircleQ {
          height: 45px;
          width: 90px;
          background-color: #0094ff;
          border-radius: 20%;
          display: inline-block;
          vertical-align: central;
          font-size: 30px;
          color: white;
          text-shadow: 2px 2px 2px #000;
          box-shadow: rgb(128, 128, 128) 2px 2px;
        }
         .Mycircle {
          height: 60px;
          width: 60px;
          background-color: #0094ff;
          border-radius: 50%;
          display: inline-block;
          box-shadow: rgb(128, 128, 128) 2px 2px;
        }
         .bedSize {
            width: 35px;
            height: 35px;
         }
        .iconSize{
            width: 50px;
            height: 50px;
        }
        .iconDetailSize{
            width: 95px;
            height: 95px;
        }
        .textSize{
            font-size: 30px;
            text-shadow: 1px 1px 1px #0094ff;
        }
        .textBed{
            font-size: 30px;
            text-shadow: 1px 1px 1px #0094ff;
        }
        .textQueue{
            font-size: 70px;
            color:aliceblue;
            text-shadow:2px 2px 2px #000;
        }
        .texticonDetail {
            font-size: 55px;
            color:aliceblue;
            text-shadow:2px 2px 2px #000;
        }
        .iconSizeSelected{
            width: 30px;
            height: 30px;
            background-color: #0094ff;
            border-radius: 50%;
            display: inline-block;
        }
        .CardBed{
            border-color:#0094ff;
        }
    </style>

    <script> JavaStyle(); </script>

</head>
    
<body>

   <form class="bg" id="form1" runat="server">

       <asp:ScriptManager ID="script_manager1" runat="server"></asp:ScriptManager>

       <table class="fullscreen" border="0">
           <tr>
               <td style="width:100%; height:10%; vertical-align:top;">

                   <div class="row col-12 mx-auto">
                        <div class="col-2 mx-auto">
                            <div class="card col-12" style="background-color:#0094ff; font-size: 30px; text-shadow:2px 2px 2px #000; color:white; vertical-align:top;">
                                <asp:UpdatePanel ID="UpdatePanel_summary" runat="server">
                                    <ContentTemplate>
                                        <asp:Label ID="lbl_cnt_wait" Text="" runat="server"></asp:Label>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="Timer1"/>
                                    </Triggers>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                        <div class="col-5 mx-auto">
                            <div id="div_TypeIcon" class="card col-12 textSize" style="background-color:#0094ff; text-shadow:2px 2px 2px #000; color:white;">
                                <asp:Label ID="lbl_typeIcon" CssClass="row col-12 mx-auto" Text="" runat="server"></asp:Label>
                            </div>
                        </div>
                        <div class="col-5 mx-auto">
                            <div class="card col-12 textSize" style="background-color:#0094ff; text-shadow:2px 2px 2px #000; color:white;">
                                <asp:Label CssClass="row col-12 mx-auto" ID="lbl_typeColor" Text="" runat="server"></asp:Label>
                            </div>
                        </div>
                    </div>

               </td>
           </tr>
           <tr>
               <td style="width:100%; height:90%; vertical-align:top;">
    <asp:UpdatePanel ID="UpdatePanel_ShowQ" runat="server">
    <ContentTemplate>
        <script>
            function ImgIcon(id) {
                var name = 'img/' + id + '.png';
                var img = '<a href="#" id="a_icon_' + id + '" onclick="getStatusID(' + id + ')"><img src="' + name + '" class="iconSize"/></a>';
                document.write(img);
            }
        </script>
            <table  style="width:100%; height:100%;">
                <tr>

               <td style="width:15%; vertical-align:top;">
                   <div class="col-12 mx-auto scroll" style="background-color:#0094ff; border-radius: 10px;">
                       <asp:Label ID="lbl_QueueTriage" CssClass="row col-12 text-center" Text="" runat="server"></asp:Label>
                   </div>
               </td>
               <td style="width:85%; vertical-align:top;">

                   <table style="width:100%; vertical-align:top;">
                       <!-- Row 1 -->
                       <tr>
                           <td style="width:25%; vertical-align:top;">
                               <div class="card col-12 CardBed">
                                   <div class="row col-12 mx-auto">
                                       <div id="div_bed_1" class="col-4 mx-auto my-auto textSize" runat="server">
                                           <img src="../QER/img/bed.png" class="bedSize"/>
                                           <br /><span class="textBed">Bed 1</span>
                                       </div>
                                       <div class="col-8 mx-auto my-auto">
                                           <div class="col-12 mx-auto my-auto">
                                               <label id="lbl_bed1" class="col-12 mx-auto my-auto text-right" runat="server">
                                                    <asp:Label ID="lbl_queue_1" Text="" CssClass="textQueue" runat="server"></asp:Label>
                                               </label>
                                           </div>
                                           <div class="col-12 mx-auto my-auto textSize">
                                               <asp:Label ID="lbl_iconstatus_1" Text="" runat="server"></asp:Label> 
                                           </div>
                                       </div>
                                   </div>
                               </div>
                           </td>


                           <td style="width:25%; vertical-align:top;">
                               <div class="card col-12 CardBed">
                                   <div class="row col-12 mx-auto">
                                       <div id="div_bed_2" class="col-4 mx-auto my-auto textSize" runat="server">
                                           <img src="../QER/img/bed.png" class="bedSize"/>
                                           <br /><span class="textBed">Bed 2</span>
                                       </div>
                                       <div class="col-8 mx-auto my-auto">
                                           <div class="col-12 mx-auto my-auto">
                                               <label id="lbl_bed2" class="col-12 mx-auto my-auto text-right textSize" runat="server">
                                                    <asp:Label ID="lbl_queue_2" CssClass="textQueue" Text="" runat="server"></asp:Label>
                                               </label>
                                           </div>
                                           <div class="col-12 mx-auto my-auto textSize">
                                               <asp:Label ID="lbl_iconstatus_2" Text="" runat="server"></asp:Label> 
                                           </div>
                                       </div> 
                                   </div>
                               </div>
                           </td>

                           <td style="width:25%; vertical-align:top;">
                               <div class="card col-12 CardBed">
                                   <div class="row col-12 mx-auto">
                                       <div id="div_bed_3" class="col-4 mx-auto my-auto textSize" runat="server">
                                           <img src="../QER/img/bed.png" class="bedSize"/>
                                           <br /><span class="textBed">Bed 3</span>
                                       </div>
                                       <div class="col-8 mx-auto my-auto">
                                           <div class="col-12 mx-auto my-auto">
                                               <label id="lbl_bed3" class="col-12 mx-auto my-auto text-right textSize" runat="server">
                                                    <asp:Label ID="lbl_queue_3" CssClass="textQueue" Text="" runat="server"></asp:Label>
                                               </label>
                                           </div>
                                           <div class="col-12 mx-auto my-auto textSize">
                                               <asp:Label ID="lbl_iconstatus_3" Text="" runat="server"></asp:Label> 
                                           </div>
                                       </div>
                                   </div>
                               </div>
                           </td>

                           <td style="width:25%; vertical-align:top;">
                                <div class="card col-12 CardBed">
                                   <div class="row col-12 mx-auto">
                                       <div id="div_bed_4" class="col-4 mx-auto my-auto textSize" runat="server">
                                           <img src="../QER/img/bed.png" class="bedSize"/>
                                           <br /><span class="textBed">Bed 4</span>
                                       </div>
                                       <div class="col-8 mx-auto my-auto">
                                           <div class="col-12 mx-auto my-auto">
                                               <label id="lbl_bed4" class="col-12 mx-auto my-auto text-right textSize" runat="server">
                                                    <asp:Label ID="lbl_queue_4" CssClass="textQueue" Text="" runat="server"></asp:Label>
                                               </label>
                                           </div>
                                           <div class="col-12 mx-auto my-auto textSize">
                                               <asp:Label ID="lbl_iconstatus_4" Text="" runat="server"></asp:Label> 
                                           </div>
                                       </div> 
                                   </div>
                               </div>
                           </td>
                       </tr> 
                       <!-- Row 2 -->
                       <tr>
                           <td>
                               &nbsp;
                           </td>
                           <td colspan="2" rowspan="3">
                               <div class="col-10 mx-auto text-center textSize center" >
                                  <img src="img/Line_icon.png" style="width: 38px; height: 38px;" /> Emergency BRH<br /><img src="img/QRcode-Line-ER.jpg" class="text-center mx-auto textSize" style="width:55%" />
                               </div>
                           </td>

                           <td>
                               <div class="card col-12 CardBed">
                                   <div class="row col-12 mx-auto">
                                       <div id="div_bed_5" class="col-4 mx-auto my-auto textSize" runat="server">
                                           <img src="../QER/img/bed.png" class="bedSize"/>
                                           <br /><span class="textBed">Bed 5</span>
                                       </div>
                                       <div class="col-8 mx-auto my-auto">
                                           <div class="col-12 mx-auto my-auto">
                                               <label id="lbl_bed5" class="col-12 mx-auto my-auto text-right textSize" runat="server">
                                                    <asp:Label ID="lbl_queue_5" CssClass="textQueue" Text="" runat="server"></asp:Label>
                                               </label>
                                           </div>
                                           <div class="col-12 mx-auto my-auto textSize">
                                               <asp:Label ID="lbl_iconstatus_5" Text="" runat="server"></asp:Label> 
                                           </div>
                                       </div>
                                   </div>
                               </div>
                           </td>

                       </tr>
                       <!-- Row 3 -->
                       <tr>
                           <td>
                               <div class="card col-12 CardBed">
                                   <div class="row col-12 mx-auto">
                                       <div id="div_bed_13" class="col-5 mx-auto my-auto textSize" runat="server">
                                           <img src="../QER/img/bed.png" class="bedSize"/>
                                           <span class="textBed">ฟื้นคืนชีพ</span>
                                       </div>
                                       <div class="col-7 mx-auto my-auto">
                                           <div class="col-12 mx-auto my-auto">
                                               <label id="lbl_bed13" class="col-12 mx-auto my-auto text-right textSize" runat="server">
                                                    <asp:Label ID="lbl_queue_13" CssClass="textQueue" Text="" runat="server"></asp:Label>
                                               </label>
                                           </div>
                                           <div class="col-12 mx-auto my-auto textSize">
                                               <asp:Label ID="lbl_iconstatus_13" Text="" runat="server"></asp:Label> 
                                           </div>
                                        </div>
                                   </div>
                               </div>
                           </td>
                           <%--<td colspan="2">
                               &nbsp;
                           </td>--%>
                           <td>
                               <div class="card col-12 CardBed">
                                   <div class="row col-12 mx-auto">
                                       <div id="div_bed_6" class="col-4 mx-auto my-auto textSize" runat="server">
                                           <img src="../QER/img/bed.png" class="bedSize"/>
                                           <br /><span class="textBed">Bed 6</span>
                                       </div>
                                       <div class="col-8 mx-auto my-auto">
                                           <div class="col-12 mx-auto my-auto">
                                               <label id="lbl_bed6" class="col-12 mx-auto my-auto text-right textSize" runat="server">
                                                    <asp:Label ID="lbl_queue_6" CssClass="textQueue" Text="" runat="server"></asp:Label>
                                               </label>
                                           </div>
                                           <div class="col-12 mx-auto my-auto textSize">
                                               <asp:Label ID="lbl_iconstatus_6" Text="" runat="server"></asp:Label> 
                                           </div>
                                        </div>
                                   </div>
                               </div>
                           </td>
                       </tr>
                       <!-- Row 4 -->
                       <tr>
                           <td>
                               <div class="card col-12 CardBed">
                                   <div class="row col-12 mx-auto">
                                       <div id="div_bed_12" class="col-5 mx-auto my-auto textSize" runat="server">
                                           <img src="../QER/img/bed.png" class="bedSize"/>
                                           <span class="textBed">หัตถการ</span>
                                       </div>
                                       <div class="col-7 mx-auto my-auto">
                                           <div class="col-12 mx-auto my-auto">
                                               <label id="lbl_bed12" class="col-12 mx-auto my-auto text-right textSize" runat="server">
                                                    <asp:Label ID="lbl_queue_12" CssClass="textQueue" Text="" runat="server"></asp:Label>
                                               </label>
                                           </div>
                                           <div class="col-12 mx-auto my-auto textSize">
                                               <asp:Label ID="lbl_iconstatus_12" Text="" runat="server"></asp:Label> 
                                           </div>
                                       </div>
                                   </div>
                               </div>
                           </td>
                           <%--<td colspan="2">
                               &nbsp;
                           </td>--%>
                           <td>
                               <div class="card col-12 CardBed">
                                   <div class="row col-12 mx-auto">
                                       <div  id="div_bed_7" class="col-4 mx-auto my-auto textSize" runat="server">
                                           <img src="../QER/img/bed.png" class="bedSize"/>
                                           <br /><span class="textBed">Bed 7</span>
                                       </div>
                                       <div class="col-8 mx-auto my-auto">
                                           <div class="col-12 mx-auto my-auto">
                                               <label id="lbl_bed7" class="col-12 mx-auto my-auto text-right textSize" runat="server">
                                                    <asp:Label ID="lbl_queue_7" CssClass="textQueue" Text="" runat="server"></asp:Label>
                                               </label>
                                           </div>
                                           <div class="col-12 mx-auto my-auto textSize">
                                               <asp:Label ID="lbl_iconstatus_7" Text="" runat="server"></asp:Label> 
                                           </div>
                                        </div>
                                   </div>
                               </div>
                           </td>
                       </tr>
                       <!-- Row 5 -->
                       <tr>
                           <td>
                               <div class="card col-12 CardBed">
                                   <div class="row col-12 mx-auto">
                                       <div id="div_bed_11" class="col-5 mx-auto my-auto textSize" runat="server">
                                           <img src="../QER/img/bed.png" class="bedSize"/>
                                           <br /><span class="textBed">Bed 11</span>
                                       </div>
                                       <div class="col-7 mx-auto my-auto">
                                           <div class="col-12 mx-auto my-auto">
                                               <label id="lbl_bed11" class="col-12 mx-auto my-auto text-right textSize" runat="server">
                                                    <asp:Label ID="lbl_queue_11" CssClass="textQueue" Text="" runat="server"></asp:Label>
                                               </label>
                                           </div>
                                           <div class="col-12 mx-auto my-auto textSize">
                                               <asp:Label ID="lbl_iconstatus_11" Text="" runat="server"></asp:Label> 
                                           </div>
                                        </div>
                                   </div>
                               </div>
                           </td>
                           <td>
                               <div class="card col-12 CardBed">
                                   <div class="row col-12 mx-auto">
                                       <div id="div_bed_10" class="col-5 mx-auto my-auto textSize" runat="server">
                                           <img src="../QER/img/bed.png" class="bedSize"/>
                                           <br /><span class="textBed">Bed 10</span>
                                       </div>
                                       <div class="col-7 mx-auto my-auto">
                                           <div class="col-12 mx-auto my-auto">
                                               <label id="lbl_bed10" class="col-12 mx-auto my-auto text-right textSize" runat="server">
                                                    <asp:Label ID="lbl_queue_10" CssClass="textQueue" Text="" runat="server"></asp:Label>
                                               </label>
                                           </div>
                                           <div class="col-12 mx-auto my-auto textSize">
                                               <asp:Label ID="lbl_iconstatus_10" Text="" runat="server"></asp:Label> 
                                           </div>
                                        </div>
                                   </div>
                               </div>
                           </td>
                           <td>
                               <div class="card col-12 CardBed">
                                   <div class="row col-12 mx-auto">
                                       <div id="div_bed_9" class="col-4 mx-auto my-auto textSize" runat="server">
                                           <img src="../QER/img/bed.png" class="bedSize"/>
                                           <br /><span class="textBed">Bed 9</span>
                                       </div>
                                       <div class="col-8 mx-auto my-auto">
                                           <div class="col-12 mx-auto my-auto">
                                               <label id="lbl_bed9" class="col-12 mx-auto my-auto text-right textSize" runat="server">
                                                    <asp:Label ID="lbl_queue_9" CssClass="textQueue" Text="" runat="server"></asp:Label>
                                               </label>
                                           </div>
                                           <div class="col-12 mx-auto my-auto textSize">
                                               <asp:Label ID="lbl_iconstatus_9" Text="" runat="server"></asp:Label> 
                                           </div>
                                        </div>
                                   </div>
                               </div>
                           </td>
                           <td>
                               <div class="card col-12 CardBed">
                                   <div class="row col-12 mx-auto">
                                       <div id="div_bed_8" class="col-4 mx-auto my-auto textSize" runat="server">
                                           <img src="../QER/img/bed.png" class="bedSize"/>
                                           <br /><span class="textBed">Bed 8</span>
                                       </div>
                                       <div class="col-8 mx-auto my-auto">
                                       <div class="col-12 mx-auto my-auto">
                                           <label id="lbl_bed8" class="col-12 mx-auto my-auto text-right textSize" runat="server">
                                                <asp:Label ID="lbl_queue_8" CssClass="textQueue" Text="" runat="server"></asp:Label>
                                           </label>
                                       </div>
                                       <div class="col-12 mx-auto my-auto textSize">
                                           <asp:Label ID="lbl_iconstatus_8" Text="" runat="server"></asp:Label> 
                                       </div>
                                        </div>
                                   </div>
                               </div>
                           </td>
                       </tr> 
                   </table>
         
               </td>

            </tr>
            </table>

        <asp:Timer ID="Timer1" runat="server" Interval="3000" OnTick="Timer1_Tick" ></asp:Timer>
        </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="Timer1"/>
            </Triggers>
    </asp:UpdatePanel> 
                </td>
           </tr>
       </table>
   
       
 </form>
            
   
<script>
    $("#lbl_typeIcon > div:gt(0)").hide();
    setInterval(function () {
        $('#lbl_typeIcon > div:first')
            .fadeIn(1000)
            .attr('style', 'display: none;')
            .next()
            .fadeOut(1000)
            .attr('style', 'displaynoneck;')
            .end()
            .appendTo('#lbl_typeIcon');
    }, 4000);

    $("#lbl_typeColor > div:gt(0)").hide();
    setInterval(function () {
        $('#lbl_typeColor > div:first')
            .fadeIn(2000).attr('style', 'display: none;')
            .next()
            .fadeOut(2000).attr('style', 'displaynoneck;')
            .end()
            .appendTo('#lbl_typeColor');
    }, 5000);

    setTimeout(function () {
        window.location.reload(1);
    }, ((1000 * 60) * 10));
</script> 
    
   
</body>
</html>
