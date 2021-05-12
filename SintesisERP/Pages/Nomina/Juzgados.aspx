<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Juzgados.aspx.cs"
    Inherits="Juzgados" MasterPageFile="~/Masters/SintesisMaster.Master" %>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPage" runat="server">
    <script type="text/javascript">
        window.appPath = "<%=Request.ApplicationPath%>";
    </script>
    <link href="../Package/Vendor/css/plugins/Autocomplete/autocomplet.css" rel="stylesheet" />

    <style>
        .input-group-addon .btn-primary {
            height: 29.77px !important;
        }

        .col-sm-12 .actions.btn-group {
            display: none;
        }
    </style>

    <div>

        <div class="row" style="margin: 0px 10px;">
            <div class="x_panel">
                <div class="x_title">
                    <h1 class="title-master" style="margin-top: 0;"><span class="fa fa-file-archive-o fa-fw"></span>Maestro de Juzgados</h1>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>


        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
            <div class="table-responsive ">
                <table class="table table-striped jambo_table" id="tbljuzgados">
                    <thead>
                        <tr>
                            <th data-column-id="edit" data-formatter="edit" data-sortable="false" style="max-width: 30px !important;">Editar</th>
                            <th data-column-id="code">Codigo</th>
                            <th data-column-id="code_ext">Codigo Externo</th>
                            <th data-column-id="state" data-formatter="state">Estado</th>
                            <th data-column-id="delete" data-formatter="delete" data-sortable="false" style="max-width: 30px">Eliminar</th>
                        </tr>
                    </thead>
                </table>
            </div>
        </div>
    </div>

    <span class="fa-stack fa-lg pull-right goTop iconnew">
        <i class="fa fa-circle fa-stack-2x"></i>
        <i class="fa fa-plus fa-stack-1x fa-inverse"></i>
    </span>

    <div class="modal fade" id="ModalAddJuzgado">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h2 class="modal-title">Detalles de Juzgados</h2>
                </div>
                <div class="modal-body clearfix">
                    <div class="col-lg-6 col-md-6 col-sm-12 col-md-12 sn-padding">
                        <div class="form-group">
                            <label for="code">Codigo: </label>
                            <input type="text" id="code" placeholder=" " value="0" class="form-control" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-6 col-sm-12 col-md-12 sn-padding">
                        <div class="form-group">
                            <label for="code_ext">Codigo Externo: </label>
                            <input type="text" id="code_ext" placeholder=" " value="0" class="form-control" />
                        </div>
                    </div>
                    <div class="col-lg-12 col-md-21 col-sm-12 col-md-12 sn-padding">
                        <div class="form-group">
                            <label for="detalle">Detalles: </label>
                            <textarea id="detalle" rows="3" placeholder=" " class="form-control" style="max-width: 100%; min-width: 100%; min-height: 100px !important; max-height: 200px !important"></textarea>
                        </div>
                    </div>

                    <div class="col-lg-12 col-md-12" style="margin: 5px">
                        <button id="btnBack" class="btn btn-danger dim btn-outline pull-right" data-dismiss="modal" aria-label="Close"><i class="fa fa-file-o icon"></i></button>
                        <button id="btnSave" class="btn btn-success dim btn-outline pull-right"><i class="fa fa-paste icon"></i></button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="../Package/Vendor/js/plugins/Autocomplete/jquery.autocomplete.js"></script>
    <script src="../Pages/ScriptsPage/Nomina/Juzgados.js"></script>

    <script>
        $(document).ready(function () {

            $('.i-checks').iCheck({
                checkboxClass: 'icheckbox_square-green',
                radioClass: 'iradio_square-green',
            });

        });
    </script>

</asp:Content>
