<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DashBoard.aspx.cs" Inherits="BRH_Plubic.GoodDoctor.DashBoard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>BRH Good doctor</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <!-- Themify Icons -->
    <link rel="stylesheet" href="../css/themify-icons.css">
    <!-- Main css -->
    <link href="../css/style.css" rel="stylesheet">

<style>
* {box-sizing: border-box;}
body {font-family: Verdana, sans-serif;}
.mySlides {display: none;}
img {vertical-align: middle;}

.full-screen {
    position: fixed;
    width: 100%;
    height: 100%;
    left: 0;
    top: 0;
}
.half-top-screen {
    position: fixed;
    width: 100%;
    height: 50%;
    left: 0;
    top: 5%;
}
.half-bottom-screen {
    position: fixed;
    width: 100%;
    height: 45%;
    left: 0;
    top: 55%;
}
.full-box {
    background-size: contain;
    background-repeat: no-repeat;
    background-position: center;
    width: 70%;
    height: 100%;
    border:groove;
    border-radius: 20px;
}
.text-box {
    position: absolute;
    bottom: 0;
    left: 0;
    text-shadow: 2px 2px 2px gray;
    font-size:x-large;
}
.star-box {
    position: absolute;
    bottom: 0;
    right: 10px;
    background-color: white;
    border-top-left-radius: 20px;
}

/* Slideshow container */
.slideshow-container {
  /*max-width: 1000px;*/
  /*position: relative;*/
  /*margin: auto;*/
}

/* Caption text */
.text {
  color: #f2f2f2;
  font-size: 15px;
  padding: 8px 12px;
  position: absolute;
  bottom: 8px;
  width: 100%;
  text-align: center;
}

/* Number text (1/3 etc) */
.numbertext {
  color: #f2f2f2;
  font-size: 12px;
  padding: 8px 12px;
  position: absolute;
  top: 0;
}

/* The dots/bullets/indicators */
.dot {
  height: 15px;
  width: 15px;
  margin: 0 2px;
  background-color: #bbb;
  border-radius: 50%;
  display: inline-block;
  transition: background-color 0.6s ease;
}

.active {
  background-color: #717171;
}

/* Fading animation */
.fade {
  -webkit-animation-name: fade;
  -webkit-animation-duration: 1.5s;
  animation-name: fade;
  animation-duration: 20s;
}

@-webkit-keyframes fade {
  from {opacity: 1} 
  to {opacity: .8}
}

@keyframes fade {
  from {opacity: 1} 
  to {opacity: .8}
}

/* On smaller screens, decrease text size */
@media only screen and (max-width: 300px) {
  .text {font-size: 11px}
}

/*------------------------ Star ------------------------------*/
.star {
    font-size: 50px;
    width: 50px;
    display: inline-block;
    color: gray;
}
.star:last-child {
    margin-right: 0;
}
.star:before {
    content:'\2605';
}
.star.on {
    color: gold;
}
.star.half:after {
    content:'\2605';
    color: gold;
    position: absolute;
    margin-left: -43px;
    width: 22px;
    overflow: hidden;
}
/*------------------------ Star ------------------------------*/

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

</style>

<script>
    function LoopStar(max, score, size) {
        var html = '';
        if (parseFloat(score) <= max) {
            var half = 'no';
            if ((score % 1) > 0) {
                half = 'yes';
            }
            size = "ti-" + size + "x";
            for (var i = 0; i < parseInt(max); i++) {
                if (i < parseInt(score)) {
                    html = html + '<span class="ti-star  star on ' + size + '"></span> ';
                }
                else {
                    if (half == 'yes') {
                        html = html + '<span class="ti-star star half ' + size + '"></span> ';
                        half = 'no';
                    }
                    else {
                        html = html + '<span class="ti-star star ' + size + '"></span> ';
                    }
                }
            }
        }
        //html = html + "<br />" + score;
        document.write(html);
    }
</script>

</head>
<body>
    <form id="form1" runat="server">

    <div class="col-12 mx-auto text-center h1">
        คะแนนความนิยมแพทย์ จากการประเมินของผู้ใช้บริการ <i id="i_net" class="ti-rss-alt blink" style="color: green"></i>
    </div>

    <asp:Label ID="lbl_HTML" Text="" runat="server"></asp:Label>

    <div style="text-align:center" hidden="hidden">
        <asp:Label ID="lbl_dot" Text="" runat="server"></asp:Label>
    </div>

    <script>
        var slideIndex = 0;
        showSlides();

        function showSlides() {
            var i;
            var slides = document.getElementsByClassName("mySlides");
            var dots = document.getElementsByClassName("dot");
            for (i = 0; i < slides.length; i++) {
                slides[i].style.display = "none";
            }
            slideIndex++;
            if (slideIndex > slides.length) { slideIndex = 1 }
            for (i = 0; i < dots.length; i++) {
                dots[i].className = dots[i].className.replace(" active", "");
            }
            slides[slideIndex - 1].style.display = "block";
            dots[slideIndex - 1].className += " active";
            setTimeout(showSlides, 20000); // Change image every xx time
        }

        function fn_Refresh(ms) {
            var Inet = document.getElementById('i_net')
            setTimeout(function () {
                if (window.navigator.onLine) {
                    Inet.setAttribute('style','color: green');
                    window.location.reload(1);
                } else {
                    Inet.setAttribute('style', 'color: red');
                    fn_Refresh(ms);
                }
            }, ms);
        }
    </script>

    <asp:Label ID="lbl_refresh" Text="" runat="server"></asp:Label>

    </form>
</body>
</html>
