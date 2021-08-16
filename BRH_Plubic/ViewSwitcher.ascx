<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ViewSwitcher.ascx.cs" Inherits="BRH_Plubic.ViewSwitcher" %>
<div id="viewSwitcher">
    <%: CurrentView %> view | <a href="<%: SwitchUrl %>" data-ajax="true">Switch to <%: AlternateView %></a>
    <script>
        alert('<%: SwitchUrl %>');
        window.location.href = '<%: SwitchUrl %>';
    </script>
</div>