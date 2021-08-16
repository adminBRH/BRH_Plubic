<%@ Page Async="true" Language="C#" AutoEventWireup="true" CodeBehind="Speech.aspx.cs" Inherits="BRH_Plubic.Speech" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="https://texttospeech.googleapis.com/v1beta1/text:synthesize" rel="stylesheet" />
</head>
<body bgcolor="navy">    
    <form id="form2" runat="server">    
    <div style="color: White;">    
        <h4>    
            Article for C#Corner    
        </h4>    
        <br />    
        <table width="100%">    
            <tr>    
                <td>    
                    <asp:TextBox ID="txtMsg" TextMode="MultiLine" runat="server" Height="142px" Width="380px"></asp:TextBox><br />    
                </td>    
            </tr>    
        </table>    
        <br />    
            <table>    
            <tr>    
                <td>    
                        <asp:Button ID="btVoice" runat="server"   
                        Text="convert to speech" onclick="btVoice_Click" />    
                </td>    
            </tr>    
        </table>    
              
    </div>    
    </form>    
</body>
</html>
