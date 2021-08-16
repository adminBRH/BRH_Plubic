<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Company.aspx.cs" Inherits="BRH_Plubic.CHK.Company" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentDesktop" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>

<!-- Stlye Customs -->
<link href="css/StyleSheet1.css" rel="stylesheet">
<style>
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
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <asp:UpdateProgress ID="prgLoadingStatus" runat="server" DynamicLayout="true">
        <ProgressTemplate>
            <div id="overlay" class="col-12 mx-auto my-auto text-center">
                <asp:Image ID="imgWaitIcon" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/images/BRHrayongLoading.gif" />
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>

    <div class="row col-12 mx-auto mt-sm-5">
        <div class="col-6 mx-auto my-3 card btnShadow bg-gradient CardBGMenu" onclick="ShowHideDiv('add')">
            <div id="div_Menu_Add" class="row col-12 mx-auto">
                <div class="col-4 mx-auto">
                    <img src="image/icon/add-address.png" class="iconSize100" />
                </div>
                <div class="col-8 mx-auto my-auto h1 bg-primary text-right textMenu">
                    Create<br />Contacts.
                </div>
            </div>
        </div>
        <div class="col-6 mx-auto my-3 card btnShadow bg-gradient CardBGMenu" onclick="ShowHideDiv('list')">
            <div id="div_Menu_List" class="row col-12 mx-auto">
                <div class="col-4 mx-auto">
                    <img src="image/icon/Company.png" class="iconSize100" />
                </div>
                <div class="col-8 mx-auto my-auto h1 bg-primary text-right textMenu">
                    List<br />Contacts.
                </div>
            </div>
        </div>
    </div>

    <section id="sec_add" data-spy="sec_add" data-target="#sec_add"></section> 
    <div id="div_company" class="section row col-lg-6 col-sm-8 mx-auto my-3" hidden="hidden">
        <div class="col-12 mx-auto inputWithIcon">
            <input id="txt_name_th" value="" style="width:100%;" placeholder="Name Contacts (Thai)" runat="server" />
            <i class="fa fa-pencil fa-lg fa-fw" aria-hidden="true"></i>
        </div>
        <div class="col-12 mx-auto inputWithIcon">
            <input id="txt_name_en" value="" style="width:100%;" placeholder="Name Contacts (English)" runat="server" />
            <i class="fa fa-pencil fa-lg fa-fw" aria-hidden="true"></i>
        </div>
        <div class="col-12 mx-auto inputWithIcon">
            <input id="txt_address" value="" style="width:100%;" placeholder="Address" runat="server" />
            <i class="fa fa-address-book fa-lg fa-fw" aria-hidden="true"></i>
        </div>
        <div class="col-6 mx-auto inputWithIcon">
            <input id="txt_phone" value="" style="width:100%;" placeholder="Phone number" runat="server" />
            <i class="fa fa-phone fa-lg fa-fw" aria-hidden="true"></i>
        </div>
        <div class="col-6 mx-auto inputWithIcon">
            <input id="txt_email" value="" style="width:100%;" placeholder="Email" runat="server" />
            <i class="fa fa-envelope-o fa-lg fa-fw" aria-hidden="true"></i>
        </div>
        <div class="col-12 mx-auto my-5">
            <a href="#" id="btn_add" class="cta mx-auto" onserverclick="btn_add_ServerClick" runat="server">
              <span>Submit</span>
              <svg width="13px" height="10px" viewBox="0 0 13 10">
                <path d="M1,5 L11,5"></path>
                <polyline points="8 1 12 5 8 9"></polyline>
              </svg>
            </a>
        </div>
    </div>

    
    <section id="sec_list" data-spy="sec_list" data-target="#sec_list"></section>
    <div id="div_list" class="section row col-lg-11 col-sm-12 mx-auto my-5">
        <div class="col-12 mx-auto text-center h1">
            รายชื่อบริษัทคู่สัญญา
        </div>
        <div class="row col-12 mx-auto">
            <div id="div_field" class="row col-12 mx-auto mt-3" hidden="hidden">
                <label class="switch">
                    <input type="checkbox" name="CB_search[1][]" id="CB_name" value="name" checked="checked" />
                    <span class="slider round"></span>
                </label> Name
                <label class="switch">
                    <input type="checkbox" name="CB_search[1][]" id="CB_address" value="address" />
                    <span class="slider round"></span>
                </label> Address
                <label class="switch">
                    <input type="checkbox" name="CB_search[1][]" id="CB_phone" value="phone" />
                    <span class="slider round"></span>
                </label> Phone
                <label class="switch">
                    <input type="checkbox" name="CB_search[1][]" id="CB_email" value="email"/>
                    <span class="slider round"></span>
                </label> Email
            </div>
            <div class="row col-6">
                <button id="btn_Search" class="my-auto border-0" onmouseover="getTextSearch()" onserverclick="btn_search_ServerClick" runat="server">
                    <span class="fa fa-2x fa-search"></span>
                </button>
                <input type="text" id="txt_SearchText" class="search mr-2" placeholder="Search" onfocus="ShowFieldSearch()">
            </div>
            <div class="col-6 mx-auto text-right my-auto">
                <label class="switch">
                    <input type="checkbox" id="CB_active" checked="checked" value="active"/>
                    <span class="slider round"></span>
                </label> Active
            </div>
        </div>
        
        <div class="col-12 mx-auto">
        <asp:UpdatePanel ID="UpdatePanel_List" runat="server">
            <ContentTemplate> 
        <asp:ListView ID="listview_contacts" runat="server">
            <LayoutTemplate>
                <div id="itemPlaceholder" runat="server">
                </div>
            </LayoutTemplate>
            <ItemTemplate>
                <div class="card col-12 boxShadow mx-auto my-2">
                    <div class="row col-12 mx-auto" data-toggle="modal" data-target="#ModalList" onclick="txtID('<%# Eval("cp_id") %>')">
                        <div class="col-6 my-auto h3">
                            <%# Eval("cp_name_en") %>
                            <hr />
                            <%# Eval("cp_name_th") %>
                        </div>
                        <div class="col-5">
                            <div class="row col-12">
                                <div class="col-12 my-3">
                                    <i class="fa fa-address-book"></i> <%# Eval("cp_address") %>
                                </div>
                                <div class="col-lg-6 col-sm-12 my-3">
                                    <i class="fa fa-phone"></i> <%# Eval("cp_phone") %>
                                </div>
                                <div class="col-lg-6 col-sm-12 my-3">
                                    <i class="fa fa-envelope-o"></i> <%# Eval("cp_email") %>
                                </div>
                            </div>
                        </div>
                        <div class="col-1 mx-auto my-auto">
                            <%# Eval("cp_active") %>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:ListView>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btn_Search" EventName="serverclick" />
            </Triggers>
        </asp:UpdatePanel>
        </div>
    </div>

    <!-- Modal -->
<div class="modal fade" id="ModalList" tabindex="-1" role="dialog" aria-labelledby="ModalListTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="ModalListTitle">Details</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
          <div class="row col-12 mx-auto">
              <div class="col-12">
                  <input type="text" id="txtM_name_th" class="form-control" placeholder="Name Thai" runat="server">
              </div>
              <div class="col-12">
                  <input type="text" id="txtM_name_en" class="form-control" placeholder="Name English" runat="server">
              </div>
              <div class="col-12">
                  <input type="text" id="txtM_address" class="form-control" placeholder="Address" runat="server">
              </div>
              <div class="col-6">
                  <input type="text" id="txtM_phone" class="form-control" placeholder="Phone" runat="server">
              </div>
              <div class="col-6">
                  <input type="text" id="txtM_email" class="form-control" placeholder="Email" runat="server">
              </div>
          </div>
      </div>
      <div class="modal-footer">
        <div hidden="hidden">
            <input type="text" id="txtH_ID" value="" runat="server" />
        </div>
        <div class="col-12 mx-auto text-right">
            <a href="#" id="btn_update" class="cta mx-auto" onserverclick="btn_update_ServerClick" runat="server">
              <span>Submit</span>
              <svg width="13px" height="10px" viewBox="0 0 13 10">
                <path d="M1,5 L11,5"></path>
                <polyline points="8 1 12 5 8 9"></polyline>
              </svg>
            </a>
        </div>
      </div>
    </div>
  </div>
</div>

    <div hidden="hidden">
        <input type="text" id="txtH_fieldSearch" value="name" runat="server" />
        <input type="text" id="txtH_SearchText" value="" runat="server" />
        <input type="text" id="txtH_active" value="" runat="server" />
    </div>

<script>
    function GetListID(id) {
        var txtID = document.getElementById('<%= txtH_ID.ClientID %>');
        txtID.value = id;
    }

    function ShowHideDiv(name) {

        var divAdd = document.getElementById('div_company');
        var divList = document.getElementById('div_list');

        divAdd.setAttribute('hidden','hidden');
        divList.setAttribute('hidden','hidden');

        if (name == 'add') {
            if (divAdd.hidden) {
                divAdd.removeAttribute('hidden');
            }
            window.location.href = '#sec_add';
        }
        if (name == 'list') {
            if (divList.hidden) {
                divList.removeAttribute('hidden');
            }
            window.location.href = '#sec_list';
        }

    }

    function ShowFieldSearch() {
        var divF = document.getElementById('div_field');
        divF.hidden = false;
    }

    function getTextSearch() {
        var txtSearch = document.getElementById('txt_SearchText');
        var txtHSearch = document.getElementById('<%= txtH_SearchText.ClientID %>');
        txtHSearch.value = txtSearch.value;

        var cbActive = document.getElementById('CB_active');
        var txtActive = document.getElementById('<%= txtH_active.ClientID %>');
        if (cbActive.checked) {
            txtActive.value = "Yes";
        }
        else {
            txtActive.value = "No";
        }
    }


    $("input:checkbox").on('click', function () {
        var $box = $(this);
        if ($box.is(":checked")) {
            var group = "input:checkbox[name='" + $box.attr("name") + "']";
            var id = $box.attr("id");
            $(group).prop("checked", false);
            $box.prop("checked", true);

            var fieldSearch = document.getElementById(id);
            var txtFieldSearch = document.getElementById('<%= txtH_fieldSearch.ClientID %>');
            if (fieldSearch.value != 'active') {
                txtFieldSearch.value = fieldSearch.value;
            }
        } else {
            $box.prop("checked", false);
        }
    });
</script>

</asp:Content>
