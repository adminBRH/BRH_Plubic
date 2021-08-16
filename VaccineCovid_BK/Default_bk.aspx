<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default_bk.aspx.cs" Inherits="BRH_Plubic.VaccineCovid.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentDesktop" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
  
<style>
    .backgroundModal{
        background-image: url(image/BK_coronavirus_blue.jpg); 
        background-size: 100% 100%;
        background-repeat: no-repeat;
        color: white;
    }

    .borderModal{
        border-bottom-left-radius: 5%; 
        border-bottom-right-radius: 5%;
    }
    .fontInvent {
        color: blue;
        font-size: 40px;
        font-family: JasmineUPC;
        text-shadow: 2px 2px 2px #ffffff;
    }
    .syringe {
        width: 60px; 
        height: 60px;
    }
</style>

<asp:ScriptManager ID="ScriptManager_Master" runat="server"></asp:ScriptManager>

    <!-- ------------ Dose Counter ------------- -->
    <div class="col-12 mx-auto">
        <iframe id="iframe_Counter" src="Counter.aspx" class="row col-12 mx-auto" style="height: 100%; overflow-y: auto;" runat="server"></iframe>
    </div>
    <!-- ------------ Dose Counter ------------- -->

    <div class="col-12 mx-auto" style="margin-top: auto;">
        <img src="image/ModernaVaccine.jpg" data-toggle="modal" data-target="#modalDetail" style="width: 100%; cursor: pointer;" />
    </div>

<!-- Modal Detail -->
<div class="modal fade" id="modalDetail" tabindex="-1" role="dialog" aria-labelledby="modalDetailTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
    <div class="modal-content backgroundModal" style="font-size: x-large; border: 0px;">
      <div class="modal-body borderModal">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
          </button>
          <div class="row col-12 mx-auto">
              <div id="Div_Agree" class="col-12 mx-auto">
                  <div id="Informatics_1">
                      <img src="image/ModernaAppropriate1.jpg" style="width: 100%" />
                  </div>
                  <div id="Informatics_2">
                      <img src="image/VaccineEfficacy1.jpg" style="width: 100%" />
                  </div>
                  <div id="Informatics_3">
                      <img src="image/VaccineEfficacy2.jpg" style="width: 100%" />
                  </div>
              </div>
          </div>
          <div class="row col-12 mx-auto mt-5 text-center">
              <div class="col-4 mx-auto">&nbsp;</div>
              <div class="col-4 mx-auto bg-gradient-blue" style="border-radius: 10px;">
                  <label class="switch my-3">
                      <input type="checkbox" name="btn_agree" id="btn_agree" onclick="fn_agree()" />
                      <span class="slider round"></span>
                  </label> <span class="my-3" style="font-size: xx-large; text-shadow: 2px 2px 2px #ff6a00;">รับทราบ</span>
              </div>
              <div class="col-4 mx-auto">&nbsp;</div>
          </div>
          <div hidden="hidden">
              <asp:Label ID="lbl_acknowledge" Text="" runat="server"></asp:Label>
              <button id="btn_acknowledge" onserverclick="btn_acknowledge_ServerClick" runat="server"></button>
          </div>
      </div>
      <div class="modal-footer" style="border: 0px; color: blue;">
          <img src="image/ModernaAppropriate2.jpg" style="width: 100%" />
      </div>
    </div>
  </div>
</div>

<script>
    $("#Informatics_2").fadeOut();
    $("#Informatics_3").fadeOut();

    function fn_agree() {
        var Informatics1 = document.getElementById('Informatics_1');
        var Informatics2 = document.getElementById('Informatics_2');
        var Informatics3 = document.getElementById('Informatics_3');
        var agree = document.getElementById('btn_agree');
        var acknowledge = document.getElementById('<%= lbl_acknowledge.ClientID %>');

        if (agree.checked) {
            if (acknowledge.innerText == 'Caution') {
                acknowledge.innerText = '';
                $("#Informatics_3").fadeOut("slow");
                __doPostBack('<%= btn_acknowledge.UniqueID %>', '');
            } else if (acknowledge.innerText == 'Efficacy') {
                acknowledge.innerText = 'Caution';
                $("#Informatics_2").fadeOut("slow");
                $("#Informatics_3").fadeIn("slow");
                setTimeout(agree.checked = false, 1000);
            } else {
                acknowledge.innerText = 'Efficacy';
                $("#Informatics_1").fadeOut("slow");
                $("#Informatics_2").fadeIn("slow");
                setTimeout(agree.checked = false, 1000);
            }
        }

        location.href = '#Div_Agree';
    }
</script>

</asp:Content>
