<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="SintesisERP.Systems.Default" MasterPageFile="~/Masters/SintesisMaster.Master" %>

<asp:Content ID="content1" ContentPlaceHolderID="ContentPage" runat="server">

    <script src="../Package/Vendor/js/plugins/Chart-js/Chart.min.js"></script>
    <script src="../Package/Vendor/js/plugins/Chart-js/utils.js"></script>
    <script src="../Package/Vendor/js/numeral.min.js"></script>

    <script type="text/javascript">
        window.appPath = "<%=Request.ApplicationPath%>";
    </script>
    <style>
        canvas {
            -moz-user-select: none;
            -webkit-user-select: none;
            -ms-user-select: none;
        }
    </style>
    
    <literal id="tblhtml" runat="server"></literal>
    
    <script>
        $(document).ready(function () {
            setTimeout(function () {
                toastr.options = {
                    closeButton: true,
                    progressBar: true,
                    showMethod: 'slideDown',
                    timeOut: 5000
                };
                toastr.success('Bienvenido ' + ((window.NameUser !== undefined) ? window.NameUser : ""), 'Sintesis ERP');

            }, 1300);
        });
    </script>
</asp:Content>
