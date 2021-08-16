<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SelfScreeningResult.aspx.cs" Inherits="BRH_Plubic.SelfScreeningResult" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">
    
    <div class="row col-12">

        <div id="DivModal1" class="col-12 container text-center my-10" visible="false" runat="server">
            <div class="card col-10 mx-auto" style="background-color:lawngreen">
                <div class="text-center col-12 mb-3">
                    <img id="img_green" src="images/face-smile.png" style="width:100px; height:100px;" runat="server" visible="false" />
                    <img id="img_green_emp" src="images/humangreen1.png" style="width:100px; height:100px;" runat="server" visible="false" />
                    <br />
                    <h2><b><asp:Label ID="lbl_date_1" CssClass="col-12 mx-auto" Text="" runat="server"></asp:Label></b></h2>
                </div>
                <div id="div_1" class="col-12 text-center" runat="server" visible="true">
                    <h3>ไม่เข้าเกณฑ์การติดเชื้อไวรัสโคโรนาสายพันธุ์ใหม่ 2019</h3>
                    <h5>No indication for Novel Coronavirus 2019 infection.</h5>
                    <h5>非感染者。</h5>
                </div>
                <div id="divEmp_1" class="col-12 text-center" runat="server" visible="false">
                    <h3>ปฏิบัติงานได้ตามปกติ</h3>
                </div>
            </div>
        </div>

        <div id="DivModal2" class="col-12 container text-center my-10" visible="false" runat="server">
            <div class="card col-10 mx-auto" style="background-color:yellow">
                <div class="text-center col-12 mb-3">
                    <img id="img_yellow" src="images/face-sad.png" style="width:100px; height:100px;" runat="server" visible="false" />
                    <img id="img_yellow_emp" src="~/images/humanyellow.png" style="width:100px; height:100px;" runat="server" visible="false" />
                    <br />
                    <h2><b><asp:Label ID="lbl_date_2" CssClass="col-12 mx-auto" Text="" runat="server"></asp:Label></b></h2>
                </div>
                <div id="div_2" class="col-12 text-center" runat="server" visible="true">
                    <h3>แยกตัวเอง สังเกตอาการ หากไม่สบายหรืออาการไม่ดีขึ้น ให้พบแพทย์</h3>
                    <h5>Isolate yourself, if you have any symptoms, please see a doctor.</h5>
                    <h5>请自行隔离观察症状，若没好转，请立即去看医生。</h5>
                    <br />
                    <br />
                    <a href="https://forms.gle/mxht61rz58684RxQ7" target="_blank">
                        <h5 style="color:blue;">แบบคัดกรองข้อมูลผู้เดินทางเข้าจังหวัดระยอง</h5>
                        <h5 style="color:blue;">(Rayong Entry Screening Form)</h5>
                    </a>
                </div>
                <div id="divEmp_2" class="col-12 text-center" runat="server" visible="false">
                    <h3>ปฏิบัติงานได้ตามปกติ</h3>
                    <h5>ให้สังเกตุอาการตนเอง หากมีอาการไม่สบายให้มาพบแพทย์ทันที</h5>
                </div>
            </div>
        </div>

        <div id="DivModal3" class="col-12 container text-center my-10" visible="false" runat="server">
            <div class="card col-10 mx-auto" style="background-color:red;">
                <div class="text-center col-12 mb-3">
                    <img id="img_red" src="images/face-dizzy.png" style="width:100px; height:100px;" runat="server" visible="false" />
                    <img id="img_red_emp" src="images/humanred.png" style="width:100px; height:100px;" runat="server" visible="false" />
                    <br />
                    <h2><b><asp:Label ID="lbl_date_3" CssClass="col-12 mx-auto" Text="" runat="server"></asp:Label></b></h2>
                </div>
                <div id="div_3" class="col-12 text-center" runat="server" visible="true">
                    <h3 style="color:white;">รีบพบแพทย์ ณ โรงพยาบาลที่ใกล้ที่สุดของท่าน</h3>
                    <h5 style="color:white;">Medical evaluation is immediately needed</h5>
                    <h5 style="color:white;">请立即到最近的医院看医生。</h5>
                    <br />
                    <br />
                    <a href="https://forms.gle/mxht61rz58684RxQ7" target="_blank">
                        <h5 style="color:blue;">แบบคัดกรองข้อมูลผู้เดินทางเข้าจังหวัดระยอง</h5>
                        <h5 style="color:blue;">(Rayong Entry Screening Form)</h5>
                    </a>
                </div>
                <div id="divEmp_3" class="col-12 text-center" runat="server" visible="false">
                    <h3>แจ้งผลให้ฝ่ายบริหารทรัพยากรบุคคลทราบและผู้บังคับบัญชาทราบ</h3>
                    <h5>และไปที่จุดคัดกรอง เพื่อทำการคัดกรองโดยละเอียดอีกครั้ง</h5>
                </div>
            </div>
        </div>

    </div>

</asp:Content>
