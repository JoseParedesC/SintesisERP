<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/SintesisMaster.Master"
    AutoEventWireup="true" Inherits="Reporteador" CodeBehind="Reporteador.aspx.cs" ValidateRequest="false" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPage" runat="Server">
    <script type="text/javascript">
        window.appPath = "<%=Request.ApplicationPath%>";
    </script>
    <style>
        .form-group {
            margin-bottom: 0 !important;
        }

        .loader,
        .loader:before,
        .loader:after {
            border-radius: 50%;
            width: 2.5em;
            height: 2.5em;
            -webkit-animation-fill-mode: both;
            animation-fill-mode: both;
            -webkit-animation: load7 1.8s infinite ease-in-out;
            animation: load7 1.8s infinite ease-in-out;
        }

        .loader {
            color: #0074bcf0;
            font-size: 10px;
            margin: 80px auto;
            position: relative;
            top: 200px;
            text-indent: -9999em;
            -webkit-transform: translateZ(0);
            -ms-transform: translateZ(0);
            transform: translateZ(0);
            -webkit-animation-delay: -0.16s;
            animation-delay: -0.16s;
        }

            .loader:before,
            .loader:after {
                content: '';
                position: absolute;
                top: 0;
            }

            .loader:before {
                left: -3.5em;
                -webkit-animation-delay: -0.32s;
                animation-delay: -0.32s;
            }

            .loader:after {
                left: 3.5em;
            }

        @-webkit-keyframes load7 {
            0%, 80%, 100% {
                box-shadow: 0 2.5em 0 -1.3em;
            }

            40% {
                box-shadow: 0 2.5em 0 0;
            }
        }

        @keyframes load7 {
            0%, 80%, 100% {
                box-shadow: 0 2.5em 0 -1.3em;
            }

            40% {
                box-shadow: 0 2.5em 0 0;
            }
        }

        #loadingDiv {
            position: absolute;
            top: 0;
            left: 0%;
            width: 100%;
            height: 100%;
            background-color: #333;
            opacity: 0.6;
        }

        .h3 {
            color: black;
        }
    </style>
    <div class="wrapper wrapper-content" style="padding-top: 5px; background: #fff !important;">
        <div class="row" style="margin-left: 0;">
            <div class="x_panel">
                <div class="x_title">
                    <h1 class="title-master" style="margin-top: 0;"><span class="fa fa-bullhorn fa-fw"></span>Reporteador</h1>
                    <div class="clearfix"></div>
                </div>
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 diventrada" style="padding-top: 5px; padding-left: 2px;">
                    <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
                        <div class="form-group">
                            <label for="id_report">Reportes</label>
                            <select class="selectpicker form-control" id="id_report" name="id_report" runat="server" clientidmode="static" data-live-search="true" data-size="8"></select>
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-2 col-xs-4 col-sm-2">
                        <button type="button" id="btnReport" class="btn-info btn" title="Generar" style="margin-top: 22px !important"><i class="fa fa-file-pdf-o"></i></button>
                        <button type="button" id="btnExport" class="btn-default btn" title="Exportar" style="margin-top: 22px !important"><i class="fa fa-file-excel-o"></i></button>
                    </div>
                </div>
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 diventrada" style="padding-top: 5px; padding-left: 2px;">
                    <h3 style="margin-left: 15px; border-bottom: 2px solid #ccc; padding-bottom: 5px;">Filtros</h3>
                </div>
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" id="filterreport" style="padding-top: 5px; padding-left: 2px; margin-bottom: 20px;">
                </div>
                <br />
                <div class="col-lg-12 col-sm-12 col-md-12 col-xs-12">
                    <div id="pdf">
                        <div style="display: none;" id="loadingDiv">
                            <div class="loader">Loading...</div>
                        </div>
                        <iframe id="pdf_content" src="../Informes/Generados/pdfblank.pdf" style="width: 100%; height: 600px;" frameborder="0"></iframe>
                    </div>
                </div>
                <iframe id="downexcel" src="" style="display: none; visibility: hidden;"></iframe>
            </div>
        </div>
    </div>
    <script src="../Pages/ScriptsPage/Parametrizacion/Reporteador.js?2"></script>
</asp:Content>
