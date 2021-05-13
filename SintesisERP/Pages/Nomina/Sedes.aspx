<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sedes.aspx.cs"
    Inherits="Sede" MasterPageFile="~/Masters/SintesisMaster.Master" %>

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

        .open > .dropdown-menu{
            max-height: 170px !important;
            cursor: wait;
        }

    </style>

    <div>

        <div class="row" style="margin: 0px 10px;">
            <div class="x_panel">
                <div class="x_title">
                    <h1 class="title-master" style="margin-top: 0;"><span class="fa fa-file-archive-o fa-fw"></span>Maestro de Sedes</h1>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>


        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
            <div class="table-responsive ">
                <table class="table table-striped jambo_table" id="tblcommodity">
                    <thead>
                        <tr>
                            <th data-column-id="edit" data-formatter="edit" data-sortable="false" style="max-width: 30px !important;">Editar</th>
                            <th data-column-id="sede">Nombre</th>
                            <th data-column-id="ciudad">Ciudad</th>
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

    <div class="modal fade" id="ModalAddSede">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h2 class="modal-title">Detalles de Sedes</h2>
                </div>
                <div class="modal-body clearfix">
                    <div class="col-lg-6 col-md-12 col-sm-12 col-md-12 sn-padding">
                        <div class="form-group">
                            <label for="nombre">Nombre: </label>
                            <input type="text" id="nombre" placeholder=" " class="form-control" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-12 col-sm-12 col-md-12 sn-padding">
                        <div class="form-group">
                            <label for="ds_ciudad">Ciudad: </label>
                            <select id="ds_ciudad" runat="server" clientidmode="static" class="form-control selectpicker" data-live-search="true"></select>
                        </div>
                    </div>
                    <div class="row buttonaction pull-right" style="margin: 5px">
                        <button id="btnSave" class="btn btn-success dim btn-outline"><i class="fa fa-paste icon"></i></button>
                        <button id="btnBack" class="btn btn-danger dim btn-outline" data-dismiss="modal" aria-label="Close"><i class="fa fa-file-o icon"></i></button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="../Package/Vendor/js/plugins/Autocomplete/jquery.autocomplete.js"></script>
    <script src="../pages/scriptspage/nomina/Sedes.js?9"></script>

    <script>
        $(document).ready(function () {

            $('.i-checks').iCheck({
                checkboxClass: 'icheckbox_square-green',
                radioClass: 'iradio_square-green',
            });

        });
    </script>

</asp:Content>
