<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ColorRedPHQ9Positive.aspx.cs" Inherits="BRH_Plubic.MentalHealthClinic.ColorRedPHQ9Positive" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">
    <div class="col-8 mx-auto">
            <div class="card">
                <div class="card-body" style="background-color:lightpink" id="div_green">
                    <div class="card-header text-center" style="background-color:lightgoldenrodyellow"><h5>จากผลของแบบประเมินสุขภาพจิต พบว่า</h5></div>
                    <div class="text-center"><img src="img/sad.png" width="120px"/></div>
                    <div class="container text-center">
                        <h5>คุณมีความเสี่ยงต่อ "ภาวะซึมเศร้า"</h5>
                        <h5>แนะนำให้แบบประเมินของกรมสุขภาพจิตต่อ โดยกด "Next"</h5>
                        
                        
                    </div>

                    <div class="col-12 mx-auto text-center">
                            <button type="button" class="btn btn-primary" id="btn_submit_PHQ9" onserverclick="btn_submit_PHQ9_ServerClick"  runat="server">Next</button>
                        </div>
                </div>
            </div>
        </div>
</asp:Content>
