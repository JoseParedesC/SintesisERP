<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SaldosIniciales.aspx.cs"
    Inherits="SaldosIniciales" MasterPageFile="~/Masters/SintesisMaster.Master" %>


<asp:Content ID="Content3" ContentPlaceHolderID="ContentPage" runat="server">
    <script type="text/javascript">
        window.appPath = "<%=Request.ApplicationPath%>";
    </script>
    <style>
        .check-mail .icheckbox_square-green {
            top: -8px !important;
            left: -18px !important;
        }
    </style>

    <div class="row" style="margin-left: 0; margin-bottom: 10px;">
        <div class="x_panel">
            <div class="x_title">
                <h1 class="title-master" style="margin-top: 0;"><span class="fa fa-dollar fa-fw"></span>Saldos Iniciales</h1>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>

    <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
        <div class="card" id="diventrada" style="padding-bottom: 30px;">
            <div class="row" style="margin: 0px 10px;">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 sn-padding">
                    <h2>Inventario Inicial</h2>
                    <hr class="hrseparator" style="margin-top: 0px; margin-bottom: 15px" />
                    <div class="form-group">
                        <label for="excel" class="active">Archivo plano :</label>
                        <input type="file" runat="server" clientidmode="Static" id="inviniicial" class="dropify" data-height="120" data-max-file-size="3M"
                            data-allowed-file-extensions="xls xlsx"
                            data-max-file-size-preview="10M" />
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12 sn-padding">
                    <div class="form-group">
                        <label for="Text_exist" class="active">incluir existencia?</label>
                        <div class="check-mail">
                            <input type="checkbox" class="i-checks pull-right" id="Text_exist" />
                        </div>
                    </div>
                </div>
                <div class="col-sm-12 col-xs-12 col-lg-6 col-md-6 sn-padding ">
                    <button title="Guardar" id="btnSave" data-option="I" class="pull-right btn btn-outline btn-primary dim waves-effect waves-light" type="button"><i class="fa fa-paste"></i></button>
                </div>
            </div>
        </div>
    </div>

    <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
        <div class="card" style="padding-bottom: 30px;">
            <div class="row" style="margin: 0px 10px;">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 sn-padding">
                    <h2>Saldo Cuentas</h2>
                    <hr class="hrseparator" style="margin-top: 0px; margin-bottom: 15px" />
                    <div class="form-group">
                        <label for="excel" class="active">Archivo plano :</label>
                        <input type="file" runat="server" clientidmode="Static" id="salcuenta" class="dropify" data-height="120" data-max-file-size="3M"
                            data-allowed-file-extensions="xls xlsx"
                            data-max-file-size-preview="10M" />
                    </div>
                </div>
                <div class="col-sm-12 col-xs-12 col-lg-12 col-md-12 sn-padding">
                    <button title="Guardar" id="btnSaveCuenta" data-option="I" class="pull-right btn btn-outline btn-primary dim waves-effect waves-light" type="button"><i class="fa fa-paste"></i></button>
                </div>
            </div>
        </div>
    </div>

    <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
        <div class="card" style="padding-bottom: 30px;">
            <div class="row" style="margin: 0px 10px;">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 sn-padding">
                    <h2>Saldo Cartera</h2>
                    <hr class="hrseparator" style="margin-top: 0px; margin-bottom: 15px" />
                    <div class="form-group">
                        <label for="excel" class="active">Archivo plano :</label>
                        <input type="file" runat="server" clientidmode="Static" id="File1" class="dropify" data-height="120" data-max-file-size="3M"
                            data-allowed-file-extensions="xls xlsx"
                            data-max-file-size-preview="10M" />
                    </div>
                </div>
                <div class="col-sm-12 col-xs-12 col-lg-12 col-md-12 sn-padding">
                    <button title="Guardar" id="btnSaveCartera" data-option="I" class="pull-right btn btn-outline btn-primary dim waves-effect waves-light" type="button"><i class="fa fa-paste"></i></button>
                </div>
            </div>
        </div>
    </div>

   <%-- <span class="fa-stack fa-lg pull-right goTop iconnew">
        <i class="fa fa-circle fa-stack-2x"></i>
        <i class="fa fa-plus fa-stack-1x fa-inverse"></i>
    </span>--%>
    <div class="modal fade" id="ModalArticle">
        <div class="modal-dialog modal-sm" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h2 class="modal-title">Detalle Inventario</h2>
                </div>
                <div class="modal-body clearfix" style="margin-bottom: 0;">
                </div>

            </div>
        </div>
    </div>
    <script>
        $(function () {
            datepicker();
            $('.i-checks').iCheck({
                checkboxClass: 'icheckbox_square-green',
                radioClass: 'iradio_square-green',
            });

            $('.dropify').dropify({
                messages: {
                    default: 'Arrastre un archivo o haga clic aquí',
                    replace: 'Arrastre un archivo o haga clic para reemplazar',
                    remove: 'Quitar',
                    error: 'Archivo demasiado grande o extensión incorrecta'
                },
                error: {
                    fileSize: 'El tamaño del archivo es muy grande ({{ value }} max).',
                    minWidth: 'El ancho de la imagen es muy pequeño ({{ value }}}px min).',
                    maxWidth: 'El ancho de la imagen es muy grande ({{ value }}}px max).',
                    minHeight: 'La altura de la imagen es muy pequeña ({{ value }}}px min).',
                    maxHeight: 'La altura de la imagen es muy grande ({{ value }}px max).',
                    imageFormat: 'El formato de la imagen no esta permitido ({{ value }} solamente).',
                    fileExtension: 'El archivo no es permitido ({{ value }} solamente).'
                }
            });

        })
    </script>
    <script src="../Pages/ScriptsPage/Seguridad/SaldosIniciales.js"></script>
</asp:Content>
