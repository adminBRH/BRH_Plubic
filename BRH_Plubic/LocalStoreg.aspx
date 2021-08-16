<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LocalStoreg.aspx.cs" Inherits="BRH_Plubic.LocalStoreg" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">

<div>    
   <table>    
      <tr>    
         <td>Customer Name </td>    
         <td><input type="text" name="txtCustomer" id="txtCustomer"/></td>    
      </tr>    
      <tr>    
         <td>Customer Address </td>    
         <td><input type="text" name="txtCustAddr" id="txtCustAddr"/></td>    
      </tr>    
      <tr>    
         <td><input type="button" id="btnSave"  value="Save to Local Storage" onClick="fnSaveData()" /> </td>    
         <td><input type="button" id="btnFind" value="Get Data From Local Storage" onclick="fnGetData()" /> </td>    
         <td><input type="button" id="btnClear" value="Clear Data From Local Storage" onclick="fnDeleteData()" /> </td>    
      </tr>    
       <tr>
           <td>Find Customer </td>    
           <td><input type="text" name="txtCustAddr" id="txtFindCust"/></td> 
           <td><input type="button" id="btnSearch" value="Search Data From Local Storage" onclick="fnSearch()" /> </td>  
       </tr>
   </table>    
</div> 

<script>
    function fnSaveData() {
        var CustName = window.localStorage.getItem("CustName");
        var txtCustomer = document.getElementById("txtCustomer").value;
        if (txtCustomer != "") {
            if (CustName == null) {
                window.localStorage.setItem("CustName", txtCustomer);
            }
            else {
                window.localStorage.setItem("CustName", txtCustomer + ',' + CustName);
            }
            
        }

        var CustAddr = window.localStorage.getItem("CustAddr");
        var txtCustAddr = document.getElementById("txtCustAddr").value;
        if (txtCustAddr != "") {
            if (CustAddr == null) {
                window.localStorage.setItem("CustAddr", txtCustAddr);
            }
            else {
                window.localStorage.setItem("CustAddr", txtCustAddr + ',' + CustAddr);
            }
        }
    } 

    function fnGetData() {
        if (window.localStorage.getItem("CustName") != null) {
            alert(window.localStorage.getItem("CustName"));
            alert(window.localStorage.getItem("CustAddr"));
        }
    }  

    function fnSearch() {
        var txtFindCust = document.getElementById("txtFindCust").value;
        var data = window.localStorage.getItem("CustName");
        if (data.search(txtFindCust) < 0) {
            alert('ไม่พบ !!');
        }
        else {
            alert('Yes');
        }
    }

    function fnDeleteData() {
        window.localStorage.clear();
    }

    //alert(JSON.parse(window.localStorage.getItem("CustName"))); 
</script>


</asp:Content>
