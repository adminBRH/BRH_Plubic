<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="BRH_Plubic.VaccineCovid.Default1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>BRH Vaccine Moderna</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" type="text/css" href="../fonts/font-awesome-4.7.0/css/font-awesome.min.css">
    <!-- Google Font 'Prompt', sans-serif -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Prompt:wght@200&display=swap" rel="stylesheet">
    <!-- Bootstrap Modal -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

    <style>
        .centered {
            position: absolute;
            top: 50%;
            left: 50%;
            margin-top: -50px;
            margin-left: -100px;
        }
        .modal-xl {
            max-width: 80%;
            border-radius: 20px;
        }

        .modal-center {
            position: relative;
            margin: auto;
            top: 40%;
        }
    </style>
</head>
<body style="font-family: 'Prompt', sans-serif;">

    <!-- Modal -->
<%--<div class="modal fade" id="modalAlert" tabindex="-1" role="dialog" aria-labelledby="modalAlertTitle" aria-hidden="true">
  <div class="modal-center modal-xl" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <div class="modal-title" id="modalAlertTitle">
            <img src="../images/BGH_Rayong-Logo.jpg" style="width: 200px; height: 100px;" />
        </div>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
          <div class="col-12 mx-auto alert alert-danger text-center" style="color:burlywood; font-size: 40px; text-shadow: 2px 2px 2px #000000;">
              ขออภัย ขณะนี้หมดเขตการรับชำระเงินแล้ว
          </div>
      </div>
    </div>
  </div>
</div>

<script>
    $('#modalAlert').modal('show');

    $('#modalAlert').on('hidden.bs.modal', function (e) {
        window.location.href = '../Marketing';
    });
</script>--%>

</body>
</html>
