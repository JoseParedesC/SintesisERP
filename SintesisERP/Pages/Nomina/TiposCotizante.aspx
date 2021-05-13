<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TiposCotizante.aspx.cs"
    Inherits="TiposCotizante" MasterPageFile="~/Masters/SintesisMaster.Master" %>

<asp:Content ID="Content" ContentPlaceHolderID="ContentPage" runat="server">

    <script type="text/javascript">
        window.appPath = "<%=Request.ApplicationPath%>";
    </script>

    <link href="../Package/Vendor/css/plugins/Autocomplete/autocomplet.css" rel="stylesheet" />

    <style>
        
    </style>

    <div>
        <div class="row" style="margin: 0px 10px;">
            <div class="x_panel">
                <div class="x_title">
                    <h1 class="title-master" style="margin-top: 0;"><span class="fa fa-1x fa-user fa-fw"></span>Maestro Tipos de Cotizante</h1>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>

        <div class="card" style="margin-top: 5px;">
            <div class="col-lg-12 sn-padding">
                <div role="alert" aria-live="polite" aria-atomic="true" class="alert alert-dismissible alert-alert alert-card alert-info" style="margin-bottom: 0px">
                    <strong class="text-capitalize">Información!</strong>
                    <br />
                    1. Solo se editarán los Tipos
                    <br />
                    2. Para editar un Tipo de cotizante debe presionar doble click sobre el.
                    <br />
                    3. Los Subtipos se añadiran selecionandolos en los select
                </div>
            </div>
            <div class="card-body">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 sn-padding">
                    <div class="form-group">
                        <label for="ds_buscadorTipoCotizante" class="active">Código o Nombre</label>
                        <div class="input-group ">
                            <input type="text" class="form-control inputsearch" placeholder=" " id="ds_buscadorTipoCotizante" aria-describedby="sizing-addon1" />
                            <span class="input-group-addon ">
                                <button id="BtnTipoCotizante" type="button" class="btn btn-primary waves-effect waves-light">
                                    <i class="fa fa-fw fa-search"></i>
                                </button>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 sn-padding">
                    <hr class="hrseparator" />
                    <div class="table-responsive" style="max-height: 500px">
                        <div role="tree" class="tree tree-default tree-checkbox-selection">
                            <ul role="group" class="tree-container-ul tree-children tree-wholerow-ul" id="ultipostree">
                                <asp:Literal ID="treeCotizante" runat="server" Text=""></asp:Literal>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <span class="fa-stack fa-lg pull-right goTop iconnew">
        <i class="fa fa-circle fa-stack-2x"></i>
        <i class="fa fa-plus fa-stack-1x fa-inverse"></i>
    </span>

    <div class="modal fade" id="ModalAddTipo">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h2 class="modal-title"><i class="fa fa-2x fa-fighter-jet"></i>&nbsp;&nbsp;Detalles de Cotizante</h2>
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
                    <div class="col-lg-12 col-md-12 col-sm-12 col-md-12 sn-padding">
                        <div class="form-group">
                            <label for="tipocot">Sub tipo: </label>
                            <select id="tipocot" class="form-control selectpicker" runat="server" clientidmode="static" multiple="true"></select>
                        </div>
                    </div>
                    <div class="col-lg-12 col-md-12 col-sm-12 col-md-12 sn-padding">
                        <div class="form-group">
                            <label for="detalle">Descripcion: </label>
                            <textarea id="detalle" rows="3" placeholder=" " class="form-control" style="max-width: 100%; min-width: 100%; min-height: 100px !important; max-height: 200px !important"></textarea>
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
    <script src="../Pages/ScriptsPage/Nomina/TiposCotizante.js?9"></script>

    <script>
        $(document).ready(function () {
            $('.i-checks').iCheck({
                checkboxClass: 'icheckbox_square-green',
                radioClass: 'iradio_square-green',
            });

        });
    </script>

</asp:Content>
