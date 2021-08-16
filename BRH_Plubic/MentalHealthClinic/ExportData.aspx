<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ExportData.aspx.cs" Inherits="BRH_Plubic.MentalHealthClinic.ExportData" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentDesktop" runat="server">
    <div class="col-12">
        <div class="card">

            <br />
            <div class="mx-auto text-center">
            เลือกแบบฟอร์มที่ต้องการ Export: 
                         <asp:DropDownList ID="ddl_table" AutoPostBack="true" OnSelectedIndexChanged="select_table_SelectedIndexChanged" runat="server">
                             <asp:ListItem Text="Record" Value="" Selected="True"></asp:ListItem>  
                             <asp:ListItem Text="DASS21" Value="dass21"></asp:ListItem>  
                             <asp:ListItem Text="Yellow" Value="yellow"></asp:ListItem>  
                             <asp:ListItem Text="PHQ9" Value="phq9"></asp:ListItem>  
                             <asp:ListItem Text="PHQ8" Value="phq8"></asp:ListItem>                          
                             <asp:ListItem Text="GAD7" Value="gad7"></asp:ListItem>                          
                             <asp:ListItem Text="Spst20" Value="SPST20"></asp:ListItem>                          
                         </asp:DropDownList>
            </div>
            <br />
            <asp:GridView ID="GridView1" CssClass="mx-auto text-center" runat="server">

            </asp:GridView>
            <br />
       </div>
    </div>
</asp:Content>
