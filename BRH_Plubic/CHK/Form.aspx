<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Form.aspx.cs" Inherits="BRH_Plubic.CHK.Form" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentDesktop" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<!-- Stlye Customs -->
<link href="css/StyleSheet1.css" rel="stylesheet">
<style>
    .RadioSize{
        width: 2em; height: 2em;
    }
    .textList{
        text-shadow: 1px 1px 1px blue;
    }
    .valueList{
        color: brown;
        text-shadow: 2px 2px 2px #808080;
    }
    .CardBGMenu {
        border-radius: 50px;
        border-top-left-radius: 300px;
        border-bottom-right-radius: 300px;
    }
    .textMenu {
        color: white;
        border-radius: 50px;
    }
</style>
<script>
    function colorStatus(status) {
        if (status == 'yes') {
            document.write('<span style="text-shadow: 2px 2px 2px #4cff00;">Yes</span> ');
        }
        else {
            document.write('<span style="text-shadow: 2px 2px 2px #ff0000;">No</span> ');
        }
    }
</script>

<asp:ScriptManager ID="ScriptManager_Master" runat="server"></asp:ScriptManager>

    <asp:UpdateProgress ID="prgLoadingStatus" runat="server" DynamicLayout="true">
        <ProgressTemplate>
            <div id="overlay" class="col-12 mx-auto my-auto text-center">
                <asp:Image ID="imgWaitIcon" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/images/BRHrayongLoading.gif" />
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>

    <div class="row col-12 mx-auto mt-sm-5">
        <div class="col-6 mx-auto my-3 card btnShadow bg-gradient CardBGMenu" onclick="ShowHide('div_add')">
            <div id="div_Menu_Add" class="row col-12 mx-auto">
                <div class="col-4 mx-auto">
                    <img src="image/icon/CreateForm.png" class="iconSize100" />
                </div>
                <div class="col-8 mx-auto my-auto h1 bg-primary text-right textMenu">
                    Create<br />Form.
                </div>
            </div>
        </div>
        <div class="col-6 mx-auto my-3 card btnShadow bg-gradient CardBGMenu" onclick="ShowHide('div_list')">
            <div id="div_Menu_List" class="row col-12 mx-auto">
                <div class="col-4 mx-auto">
                    <img src="image/icon/cabinet.png" class="iconSize100" />
                </div>
                <div class="col-8 mx-auto my-auto h1 bg-primary text-right textMenu">
                    List<br />Form.
                </div>
            </div>
        </div>
    </div>

    <section id="sec_add" data-spy="sec_add" data-target="#sec_add"></section> 
    <div id="div_add" class="section col-lg-10 col-sm-12 mx-auto my-3" hidden="hidden">
        <asp:UpdatePanel ID="UpdatePanel_Type" runat="server">
            <ContentTemplate>
                <div class="col-12 mx-auto text-center">
                    <asp:Label ID="lbl_alert" Text="" CssClass="my-5" Font-Size="XX-Large" runat="server"></asp:Label>
                </div>
                <div class="row col-12 mx-auto my-3">
                    <div class="card col-12 mx-auto">
                        <div class="row col-12 mx-auto">
                            <div class="col-4 mx-auto">
                                <asp:DropDownList ID="DD_Type" 
                                CssClass="btn btn-light my-auto" 
                                OnSelectedIndexChanged="DD_Type_SelectedIndexChanged" 
                                AutoPostBack="true" runat="server">
                                    <asp:ListItem Value="" Text="เลือกประเภท Controler" Selected="True"></asp:ListItem>
                                    <asp:ListItem Value="text" Text="Text Box"></asp:ListItem>
                                    <asp:ListItem Value="dropdownlist" Text="Drop Down List"></asp:ListItem>
                                    <asp:ListItem Value="radio" Text="Radio Button"></asp:ListItem>
                                    <asp:ListItem Value="checkbox" Text="Check Box"></asp:ListItem>
                                </asp:DropDownList> 
                            </div>
                            <div class="col-8 mx-auto">
                                <div class="col-12 text-center bg-gradient rounded" style="color:white; font-family:'Californian FB'; font-size:x-large">Exsample</div>
                                <div class="col-12 card mx-auto my-auto bg-secondary">
                                    <asp:Label ID="lbl_sample" CssClass="col-12 my-3" Text="Please select Controler" runat="server"></asp:Label>
                                </div>
                            </div>
                        </div>
                        <div id="div_editControler" class="col-12 mx-auto" runat="server" visible="false">
                            <div class="card col-12 mx-auto mt-5">
                                <div class="row col-12 mx-auto">
                                    <div class="col-12 mx-auto mb-3 text-center" style="">
                                        <span style="font-size:x-large; font-family:'Californian FB'; background-image: url(image/icon/arrow_up_right.png); background-position-x:right; background-size:30px; background-repeat:no-repeat;">
                                            Edit Controler &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        </span>
                                        <div class="col-12 card boxShadow"></div>
                                    </div>
                                    <div class="row col-lg-6 col-sm-12 mx-auto mb-3">
                                        <div class="col-4 mx-auto my-auto text-right">
                                            ชื่อหัวข้อ : 
                                        </div>
                                        <div class="col-8 mx-auto my-auto">
                                            <input type="text" id="txt_title" value="ชื่อหัวข้อ" onkeypress="blockKeyCode(event)" runat="server" />
                                        </div>
                                    </div>
                                    <div id="div_for_text" class="row col-lg-6 col-sm-12 mx-auto mb-3" runat="server" visible="false">
                                        <div class="col-4 mx-auto my-auto text-right">
                                            ข้อความที่ต้องการจะบอก : 
                                        </div> 
                                        <div class="col-8 mx-auto my-auto">
                                            <input type="text" id="txt_placeholder" value="กรุณากรอกข้อมูล" onkeypress="blockKeyCode(event)" runat="server" />
                                        </div>
                                    </div>
                                    <div id="div_for_DropDownRadio" class="row col-12 mx-auto" runat="server" visible="false">
                                        <asp:Label ID="lbl_List_DropDownRadio" CssClass="col-12 mx-auto" Text="" runat="server"></asp:Label>
                                        <div class="col-12">
                                            <a id="btn_addList_DropDownRadio" onserverclick="btn_addList_DropDownRadio_ServerClick" runat="server">เพิ่มรายการ <i class="ti-plus"></i></a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div id="div_AddControler" class="col-12 mx-auto my-3 text-center" runat="server" visible="false">
                                <button id="btn_addControler" class="btn btn-outline-primary mx-5" onserverclick="btn_addControler_ServerClick" runat="server" style="font-size:x-large">Add to form +</button>
                                <button id="btn_PreControler" class="btn btn-outline-primary mx-5" onserverclick="btn_PreControler_ServerClick" runat="server" style="font-size:x-large"><i class="ti-eye"></i></button>
                            </div>
                        </div>
                        <div class="col-12 mx-auto mt-3">
                            <div class="col-12 text-center bg-gradient rounded" style="color:white; font-family:'Californian FB'; font-size:x-large">Form Preview</div>
                            <div class="card col-12 mx-auto">
                                <div class="row col-12 mx-auto">
                                    <div class="col-lg-8 col-sm-10 mx-auto my-3 badge-secondary rounded">
                                        <asp:Label ID="lbl_controler" Text="" runat="server"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div hidden="hidden">
                            <input type="text" id="txtH_DropDownRadio_index" value="0" runat="server" />
                            <input type="text" id="txtH_DropDownRadio_list" value="" runat="server" />
                            <input type="text" id="txtH_DropDownRadio_listTextValue" value="" runat="server" />
                            <input type="text" id="txtH_DropDownRadio_hidden" value="" runat="server" />
                            <asp:Button ID="btn_UpdateBeforDel" OnClick="btn_UpdateBeforDel_Click" runat="server" />
                        </div>
                        <div hidden="hidden">
                            <input type="text" id="txtH_index" value="0" runat="server" />
                            <input type="text" id="txtH_index_Form" value="" runat="server" />
                            <input type="text" id="txtH_index_hidden" value="" runat="server" />
                        </div>
                        <div id="div_submit" class="col-12 mx-auto text-center mt-3" runat="server" visible="false">
                            <button id="btn_confirm" class="btn btn-light" data-toggle="modal" data-target="#ModalFormConfirm" style="font-size:x-large;">Submit</button>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <!-- Modal -->
    <div class="modal fade" id="ModalFormConfirm" tabindex="-1" role="dialog" aria-labelledby="ModalFormConfirmTitle" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="ModalFormConfirmTitle">ตั้งชื่อแบบฟอร์ม</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <input type="text" id="txt_FormName" value="" onkeyup="checkForm()" class="form-control" placeholder="ชื่อแบบฟอร์ม" runat="server" />
          </div>
          <div class="modal-footer">
            <button type="button" id="btn_Submit" class="btn btn-outline-primary" onserverclick="btn_Submit_ServerClick" runat="server" disabled="disabled">Save</button>
          </div>
        </div>
      </div>
    </div>
<script>
    function checkForm() {
        var FormName = document.getElementById('<%= txt_FormName.ClientID %>');
        var btnSubmit = document.getElementById('<%= btn_Submit.ClientID %>');
        if (FormName.value == '') {
            btnSubmit.setAttribute('disabled', 'disabled');
        }
        else {
            btnSubmit.removeAttribute('disabled');
        }
    }
</script>


    <!-- List -->
    <section id="sec_list" data-spy="sec_list" data-target="#sec_list"></section> 
    <div id="div_list" class="section col-lg-10 col-sm-12 mx-auto my-5">
        <div class="card boxShadow col-12 mx-auto">
            <asp:ListView ID="LV_Form" runat="server">
                <LayoutTemplate>
                    <div class="col-12 mx-auto my-auto text-center h1" style="text-shadow: 1px 1px 1px #ff00dc;">
                        รายการแบบฟอร์มในระบบ
                    </div>
                    <div id="itemPlaceholder" class="mx-auto my-3" runat="server">
                    </div>
                </LayoutTemplate>
                <ItemTemplate>
                    <div class="card my-2 col-12 mx-auto" style="box-shadow: 2px 2px 2px #000000;">
                        <div class="row col-12 mx-auto h3">
                            <div class="col-12 mx-auto valueList"><%# Eval("bf_formname") %><hr /></div>
                            <div class="col-8 mx-auto">
                                <div class="col-1 mx-auto">&nbsp;</div>
                                <div class="col-11 mx-auto valueList"><b class="textList">Create date :</b> <%# Eval("bf_editdate") %></div>
                                <div class="col-10 mx-auto"><hr /></div>
                                <div class="col-1 mx-auto">&nbsp;</div>
                                <div class="col-11 mx-auto valueList"><b class="textList">Create by :</b> <%# Eval("bf_editby") %></div>
                            </div>
                            <div class="col-2 mx-auto text-center">
                                <b class="textList">Active</b><br />
                                <script> colorStatus('<%# Eval("bf_active") %>'); </script>
                            </div>
                            <div class="col-2 mx-auto text-center">
                                <i class="ti-2x ti-eye" onclick="preview('<%# Eval("bf_id") %>')" data-toggle="modal" data-target="#ModalPreview" style="text-shadow: 2px 2px 2px #ffd800;"></i>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:ListView>
        </div>
    </div>
    <!-- Modal -->
    <div class="modal fade" id="ModalPreview" tabindex="-1" role="dialog" aria-labelledby="ModalPreviewTitle" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
        <div class="modal-content">
            <asp:UpdatePanel ID="UpdatePanel_modalList" runat="server">
                <ContentTemplate>
                  <div class="modal-header">
                    <h5 class="modal-title" id="ModalPreviewTitle">Preview Form</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                      <span aria-hidden="true">&times;</span>
                    </button>
                  </div>
                  <div class="modal-body">
                    <div hidden="hidden">
                        <input type="text" id="txtH_List_formID" value="" runat="server" />
                    </div>
                      <div class="col-lg-8 col-sm-12 mx-auto bg-secondary rounded" style="color:white;">
                          <asp:Label ID="lbl_ListPreview" Text="" runat="server"></asp:Label>
                      </div>
                  </div>
                  <div class="modal-footer" hidden="hidden">
                      <asp:Button ID="btn_List_previewForm" Text="preview" OnClick="btn_List_previewForm_Click" runat="server" />
                  </div>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btn_List_previewForm" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
      </div>
    </div>
 <script>
     function ShowHide(name) {
         document.getElementById('div_add').hidden = true;
         document.getElementById('div_list').hidden = true;

         var div = document.getElementById(name);
         if (div.hidden) {
             div.hidden = false;
             window.location.href = '#' + name;
         }
         else {
             div.hidden = true;
         }

         var MenuAdd = document.getElementById('div_Menu_Add');
         var MenuList = document.getElementById('div_Menu_List');
         MenuAdd.removeAttribute('style');
         MenuList.removeAttribute('style');
         if (name == 'div_add') {
             MenuAdd.setAttribute('style', 'color:cornflowerblue');
         }
         if (name == 'div_list') {
             MenuList.setAttribute('style', 'color:cornflowerblue');
         }
     }

     function preview(formID) {
         var txtH = document.getElementById('<%= txtH_List_formID.ClientID %>');
         txtH.value = formID;
         __doPostBack('<%= btn_List_previewForm.UniqueID %>', '');
     }

     function delControler(index) {
         var indexHide = document.getElementById('<%= txtH_index_hidden.ClientID %>');
         if (indexHide.value != '') { indexHide.value = indexHide.value + ','; }
         indexHide.value = indexHide.value + index;
         var conT = document.getElementById('conT_' + index);
         conT.setAttribute("hidden", "hidden");

         var lblConT = document.getElementById('<%= lbl_controler.ClientID %>');
         var TextOld = 'conT_' + index + '"';
         var TextNew = 'conT_' + index + '" hidden="hidden" ';
         lblConT.innerHTML = lblConT.innerHTML.replace(TextOld, TextNew);
         TextOld = 'hr_' + index + '"';
         TextNew = 'hr_' + index + '" hidden="hidden" ';
         lblConT.innerHTML = lblConT.innerHTML.replace(TextOld, TextNew);
         //alert(lblConT.innerHTML);
     }

     function delList(id) {
         var indexDel = document.getElementById('<%= txtH_DropDownRadio_hidden.ClientID %>');
         indexDel.value = id;

         __doPostBack('<%= btn_UpdateBeforDel.UniqueID %>', '');
     }
 </script>

</asp:Content>
