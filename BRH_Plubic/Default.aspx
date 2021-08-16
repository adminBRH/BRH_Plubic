<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="BRH_Plubic._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentDesktop" runat="server">

<style>

	.sliderCube {
		position: absolute;
		top: 0;
		bottom: 0;
		right: 0;
		left: 0;
		width: 200px;
		height: 200px;
 		margin: auto;
		-webkit-perspective: 300px;
				perspective: 300px;
	}

	.sliderCube * {
		-webkit-transition: all 1s cubic-bezier(0.5, -0.75, 0.2, 1.5);
		        transition: all 1s cubic-bezier(0.5, -0.75, 0.2, 1.5);
	}

	.containerCube {
		width: inherit;
		height: inherit;
		-webkit-transform-style: preserve-3d;
		        transform-style: preserve-3d;
		-webkit-transform: rotateY(0deg) rotateX(0deg);
		        transform: rotateY(0deg) rotateX(0deg);
	}

		.slideCube, .slideCube:after, .slideCube:before {
			display: block;
			width: inherit;
			height: inherit;
			position: absolute;
			-webkit-transform-style: preserve-3d;
			        transform-style: preserve-3d;
			background-position: center;
		}

		.slideCube.x {
		  -webkit-transform: rotateY(90deg);
		          transform: rotateY(90deg);
		} 

			.slideCube.x:after {
				content: '';
				background-image: url('../images/Cube/Wellness.png');
				background-size: contain;
				background-repeat: no-repeat;
				-webkit-transform: translateZ(200px) rotateZ(-90deg);
				        transform: translateZ(200px) rotateZ(-90deg);
			}

			.slideCube.x:before {
				content: '';
				background-image: url('../images/Cube/BNH.png');
				background-size: contain;
				background-repeat: no-repeat;
				-webkit-transform: translateZ(-200px) rotateZ(-90deg);
				        transform: translateZ(-200px) rotateZ(-90deg);
			}

		.slideCube.y {
		  -webkit-transform: rotateX(90deg);
		          transform: rotateX(90deg);
		} 

			.slideCube.y:after {
				content: '';
				background-image: url('../images/Cube/ROYAL.png');
				background-size: contain;
				background-repeat: no-repeat;
				-webkit-transform: translateZ(200px) scale(-1);
				        transform: translateZ(200px) scale(-1);
			}

			.slideCube.y:before {
				content: '';
				background-image: url('../images/Cube/Paolo.png');
				background-size: contain;
				background-repeat: no-repeat;
				-webkit-transform: translateZ(-200px);
				        transform: translateZ(-200px);
			}

		.slideCube.z {
		  -webkit-transform: rotateX(0);
		          transform: rotateX(0);
		} 

			.slideCube.z:after {
				content: '';
				background-image: url('../images/Cube/PHY.png');
				background-size: contain;
				background-repeat: no-repeat;
				-webkit-transform: translateZ(200px);
				        transform: translateZ(200px);
			}

			.slideCube.z:before {
				content: '';
				background-image: url('../images/Cube/SAMIT.png');
				background-size: contain;
				background-repeat: no-repeat;
				-webkit-transform: translateZ(-200px);
				transform: translateZ(-200px);
			}


		.containerCube {
			-webkit-animation: rotate 30s infinite cubic-bezier(1, -0.75, 0.5, 1.2);
			animation: rotate 30s infinite cubic-bezier(1, -0.75, 0.5, 1.2);
		}

		@-webkit-keyframes rotate {
			0%, 10% {-webkit-transform: rotateY(0deg) rotateX(0deg);transform: rotateY(0deg) rotateX(0deg);}
			15%, 20% {-webkit-transform: rotateY(180deg) rotateX(0deg);transform: rotateY(180deg) rotateX(0deg);}
			25%, 35% {-webkit-transform: rotateY(180deg) rotateX(270deg);transform: rotateY(180deg) rotateX(270deg);}
			40%, 50% {-webkit-transform: rotateY(180deg) rotateX(90deg);transform: rotateY(180deg) rotateX(90deg);}
			55%, 65% {-webkit-transform: rotateY(-90deg) rotateX(90deg);transform: rotateY(-90deg) rotateX(90deg);}
			70%, 80% {-webkit-transform: rotateY(90deg) rotateX(90deg);transform: rotateY(90deg) rotateX(90deg);}
			90%, 95% {-webkit-transform: rotateY(0deg) rotateX(90deg);transform: rotateY(0deg) rotateX(90deg);}
		}

		@keyframes rotate {
			0%, 10% {-webkit-transform: rotateY(0deg) rotateX(0deg);transform: rotateY(0deg) rotateX(0deg);}
			15%, 20% {-webkit-transform: rotateY(180deg) rotateX(0deg);transform: rotateY(180deg) rotateX(0deg);}
			25%, 35% {-webkit-transform: rotateY(180deg) rotateX(270deg);transform: rotateY(180deg) rotateX(270deg);}
			40%, 50% {-webkit-transform: rotateY(180deg) rotateX(90deg);transform: rotateY(180deg) rotateX(90deg);}
			55%, 65% {-webkit-transform: rotateY(-90deg) rotateX(90deg);transform: rotateY(-90deg) rotateX(90deg);}
			70%, 80% {-webkit-transform: rotateY(90deg) rotateX(90deg);transform: rotateY(90deg) rotateX(90deg);}
			90%, 95% {-webkit-transform: rotateY(0deg) rotateX(90deg);transform: rotateY(0deg) rotateX(90deg);}
		}
</style>

<div class="sliderCube" runat="server" visible="false">
  <div class="containerCube">
    <div class="slideCube x"></div>
    <div class="slideCube y"></div>
    <div class="slideCube z"></div>
  </div>
</div>

<div class="col-lg-11 col-sm-12 mx-auto text-center">
	<img src="images/PR/COVID.jpg" style="width: 100%; border-radius: 20px;" />
</div>
	
</asp:Content>
