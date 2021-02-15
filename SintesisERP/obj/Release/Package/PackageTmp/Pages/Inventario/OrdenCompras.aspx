<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OrdenCompras.aspx.cs"
    Inherits="OrdenCompras" MasterPageFile="~/Masters/SintesisMaster.Master" %>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPage" runat="server">
    <script type="text/javascript">
        window.appPath = "<%=Request.ApplicationPath%>";
    </script>
    <link href="../Package/Vendor/css/plugins/Autocomplete/autocomplet.css" rel="stylesheet" />
    <style>
        .rowedit {
            width: 100px;
        }

        #divaddart .bootstrap-select span.filter-option, #divaddart input, #divaddart .form-group label {
            font-size: 12px !important;
        }

        #divaddart .form-group label {
            margin-bottom: 5px;
        }

        .desactivelote, .desactiveserie {
            display: none;
        }

        .activelote, .activeserie {
            display: block;
        }

        .inputsearch {
            height: 29.77px !important;
        }

        .input-group-addon .btn-primary {
            height: 29.77px !important;
        }

        .col-sm-12 .actions.btn-group {
            display: none;
        }

        #tblcommodity-footer .row {
            margin-left: 0 !important;
        }

        .btn-outline[disabled] {
            color: #fff !important;
        }

        .dropify-wrapper {
            min-height: 150px;
        }

        .btn-outline {
            margin-bottom: 20px !important;
        }

        .form-group {
            margin-bottom: 10px !important;
        }

        .padsmall {
            padding-right: 5px !important;
            padding-left: 5px !important;
        }

        .autocomplete-suggestions {
            border: medium none;
            border-radius: 3px;
            box-shadow: 0 0 3px rgba(86, 96, 117, 0.7);
            float: left;
            font-size: 12px;
            left: 0;
            list-style: none outside none;
            padding: 0;
            position: absolute;
            text-shadow: none;
            top: 100%;
            z-index: 1000;
            background: #fff;
        }

        .autocomplete-suggestion {
            border-radius: 3px;
            color: inherit;
            line-height: 25px;
            margin: 4px;
            text-align: left;
            font-weight: normal;
            padding: 3px 20px;
        }

        .autocomplete-selected {
            color: #fff;
            text-decoration: none;
            background-color: #337ab7;
            outline: 0;
        }

            .autocomplete-selected strong {
                color: #fff !important;
            }

        .codvalue {
            padding: 0 0 10px 0 !important;
            margin-bottom: 5px;
            border-style: none;
            border-bottom: 1px solid #e7eaec !important;
            min-height: 38px;
        }

            .codvalue h1 {
                font-size: 19px;
                text-align: right;
                padding: 0 !important;
            }

            .codvalue span {
                float: right;
            }

        .icheckbox_square-green {
            margin: 0 !important;
        }

        tr th {
            padding: 2px !important;
        }

        .addarticle {
            font-size: 20px;
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: #1ab394;
            color: #fff;
            text-align: center;
        }

        .row {
            background-color: #fff !important;
        }

        .nav.nav-tabs li {
            background: #1ab394;
            color: #fff !important;
        }

            .nav.nav-tabs li.active {
                background: #fff;
            }

            .nav.nav-tabs li a {
                color: #fff !important;
                outline: none !important;
                border-bottom: 2px #1ab394 solid !important;
            }

            .nav.nav-tabs li.active a {
                color: #1ab394 !important;
            }

        .wrapper {
            padding: 0 10px;
        }

        .Botns button {
            margin-bottom: 20px !important;
        }

        .quoteNumber {
            border-radius: .1em;
            background: #fff;
            font-size: 20px;
            font-weight: bold;
            text-align: center;
            margin-top: -5px;
            margin-right: 5px;
            border: solid 1px;
        }

        .entradanumber {
            width: 100% !important;
            text-align: center;
            position: relative;
            float: right;
            margin-top: -8px;
        }

        .command-edit {
            margin-left: 5px;
        }
    </style>

    <input type="hidden" id="id_entrada" value="0" runat="server" clientidmode="static" />
    <input type="hidden" id="id_entradatemp" value="0" />
    <input type="hidden" id="opcion" value="T" />
    <div class="row" style="margin-left: 0;">
        <div class="x_panel">
            <div class="x_title col-lg-5 col-md-5 col-sm-7 col-xs-12">
                <h1 class="title-master" style="margin-top: 0;"><span class="fa fa-level-down fa-fw"></span>Orden de Compra</h1>
                <div class="clearfix"></div>
            </div>
            <div class="col-lg-7 col-md-7 col-sm-5 col-xs-12 Botns">
                <input type="hidden" id="estadoOrden" value="" />
                <button title="Revertir" id="btnRev" class="mintip btn btn-outline btn-danger  dim  pull-right" type="button" disabled="disabled"><i class="fa-file-o fa"></i></button>
                <button title="Guardar" id="btnSave" data-option="I" class="mintip btn btn-outline btn-primary dim  pull-right" type="button"><i class="fa fa-paste"></i></button>
                <button title="Traslado" id="btntraslate" data-option="D" class="mintip btn btn-outline btn-warning dim  pull-right" type="button"><i class="fa fa-exchange fa"></i></button>
                <button title="Temporal" id="btnTemp" data-option="L" class="mintip btn btn-outline btn-success  dim  pull-right" type="button" style="display: none"><i class="fa fa-upload"></i></button>
                <button title="Imprimir" id="btnPrint" data-option="I" class="mintip btn btn-outline btn-print dim  pull-right" type="button"><i class="fa fa-print"></i></button>
                <button title="Nueva" id="btnnew" data-option="R" class="mintip btn btn-outline btn-default  dim  pull-right" type="button"><i class="fa-file-o fa"></i></button>
                <button title="Listar" id="btnList" data-option="L" class="mintip btn btn-outline btn-info  dim  pull-right" type="button"><i class="fa-list fa"></i></button>
                <span class="pull-right quoteNumber"><span style="font-size: 14px; font-weight: normal;">Consecutivo</span><span class="entradanumber">0</span></span>
            </div>
        </div>
    </div>

    <div class="card" id="diventrada">
        <div class="row" style="margin: 0px 10px;">
            <div class="col-lg-2 col-md-3 col-sm-4 col-xs-12 sn-padding">
                <div class="form-group">
                    <div class="form-group">
                        <label for="cd_tipodoc" class="active">Tipo de Documento:</label>
                        <select runat="server" clientidmode="static" id="cd_tipodoc" class="form-control selectpicker" data-size="8">
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-2 col-md-3 col-sm-4 col-xs-12 sn-padding">
                <!--Campo de busqueda de centro de costo por defecto-->
                <div class="form-group">
                    <label for="Text_Nombre" class="active">Centro Costo</label>
                    <input type="hidden" id="id_ccostos" />
                        <input type="hidden" id="Idcurrent" value="0" />
                        <input type="hidden" id="isofDetalle" value='true' />
                        <input type="text" class="form-control actionautocomple inputsearch" id="codigoccostos" aria-describedby="sizing-addon1"  data-search="Bodegas" data-method="BodegasBuscador" data-params="op:F;o:#" data-result="value:name;data:id" data-idvalue="id_ccostos"/>
							
                </div>
            </div>
            <div class="col-lg-2 col-md-2 col-sm-4 col-xs-12 sn-padding">
                <div class="form-group">
                    <label for="Text_Fecha" class="active">Fecha:</label>
                    <input id="Text_Fecha" type="text" placeholder=" " class="form-control" current="true" date="true" format="YYYY-MM-DD" />
                </div>
            </div>
            <div class="col-lg-3 col-md-2 col-sm-6 col-xs-12 sn-padding">
                <div class="form-group">
                    <label for="Text_Nombre" class="active">Proveedor</label>
                    <input type="hidden" id="cd_provider" value="0" />
                        <input type="hidden" id="tipotercero" value="PR" />
                         <input type="text" class="form-control actionautocomple inputsearch" id="ds_cliente" aria-describedby="sizing-addon1" data-search="Bodegas" data-method="BodegasBuscador" data-params="op:T;o:PR" data-result="value:name;data:id" data-idvalue="cd_provider" />

                </div>
            </div>
            <div class="col-lg-2 col-md-3 col-sm-4 col-xs-12 sn-padding padsmall">
                <div class="form-group">
                    <label for="cd_wineridef" class="active">Bodega:</label>
                    <select runat="server" clientidmode="static" id="cd_wineridef" class="form-control selectpicker" data-size="8">
                    </select>
                </div>
            </div>
        </div>
        <div class="row" style="margin: 0 10px;">
            <hr class="hrseparator" style="margin-top: 0px; margin-bottom: 10px" />
        </div>
        <div class="row" style="margin: 0 10px;" id="divaddart">
            <div class="col-lg-10 col-md-10 col-sm-12 col-xs-12 " style="padding: 0;">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 divarticleadd" style="padding: 0;">
                    <div class="col-lg-2 col-md-3 col-sm-6 col-xs-12">
                        <div class="form-group">
                            <label for="v_code" class="active">Código:</label>
                            <input type="text" name="country" id="v_code" class="form-control" placeholder=" " />
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-4 col-sm-6 col-xs-12">
                        <div class="form-group">
                            <label for="nombre" class="active">Nombre:</label>
                            <input type="text" name="nombre" id="nombre" class="form-control" placeholder=" "  disabled="disabled" data-lote="false" data-serie="false" />
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                        <div class="form-group">
                            <label for="m_quantity" class="active">Cantidad:</label>
                            <input id="m_quantity" type="text" class="form-control" placeholder=" " money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="0.01" data-v-max="999999999.99" value="1.00" />
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                        <button title="Agregar" id="addarticle" data-option="I" class="btn btn-outline btn-primary dim  pull-right" type="button" data-id="0" style="margin-bottom: 0 !important; margin-top: 15px; float: left !important;"><i class="fa fa-plus"></i></button>
                    </div>
                </div>
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding-bottom: 15px; padding-left: 2px; margin-top: -10px;">
                    <div class="table-responsive" style="max-height: 300px">
                        <table class="table table-striped jambo_table" id="tblcommodity">
                            <thead>
                                <tr>
                                    <th data-column-id="codigo" data-formatter="delete" data-sortable="false">#</th>
                                    <th data-column-id="codigo">Código</th>
                                    <th data-column-id="nombre">Nombre</th>
                                    <th data-column-id="cantidad" data-formatter="cantidad">Cantidad</th>
                                    <th data-column-id="costo" data-formatter="costo">Costo</th>
                                    <th data-column-id="costototal" data-formatter="costototal">Total</th>
                                </tr>
                            </thead>
                        </table>
                    </div>
                </div>
            </div>
            <div class="col-lg-2 col-md-2 col-sm-12 col-xs-12" style="margin-top: 10px;">
                <div class="row">
                    <div class="table-responsive" style="border: none;">
                        <div class="col-lg-12 col-md-12 col-xs-12 col-sm-12">
                            <div class="ibox-content codvalue text-right">
                                <h1 id="Tcosto" class="no-margins" style="font-weight:bold">$ 0.00</h1>
                                <span class="font-bold text-navy">Total Costo</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <div class="modal fade" id="ModalEntrada">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h2 class="modal-title">Lista de Ordenes</h2>
                </div>
                <div class="modal-body clearfix" style="margin-bottom: 0; padding-top: 0 !important">
                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding: 5px;">
                            <div class="table-responsive" style="max-height: 300px">
                                <table class="table table-striped jambo_table" id="tblOrdenCompras">
                                    <thead>
                                        <tr>
                                            <th data-column-id="id" data-formatter="edit" data-sortable="false" style="max-width: 30px !important;">Ver</th>
                                            <th data-column-id="estado">Estado</th>
                                            <th data-column-id="tipodocumento">Tipo Documento</th>
                                            <th data-column-id="centrocosto">Centro Costo</th>
                                            <th data-column-id="id">Consecutivo</th>
                                            <th data-column-id="fechadocumen">Fecha</th>
                                            <th data-column-id="proveedor">Proveedor</th>
                                            <th data-column-id="nombrebodega">Bodega</th>
                                            <th data-column-id="costo" data-formatter="costo">Total</th>
                                    </thead>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="ModalOrdenCompraTemp">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h2 class="modal-title">Lista de Entradas</h2>
                </div>
                <div class="modal-body clearfix" style="margin-bottom: 0; padding-top: 0 !important">
                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding: 5px;">
                            <div class="table-responsive" style="max-height: 300px">
                                <table class="table table-striped jambo_table" id="tblOrdenComprasTemp">
                                    <thead>
                                        <tr>
                                            <th data-column-id="id" data-formatter="edit" data-sortable="false" style="max-width: 30px !important;">Ver</th>
                                            <th data-column-id="id">Consecutivo</th>
                                            <th data-column-id="fechadocumen">Fecha</th>
                                            <th data-column-id="proveedor">Proveedor</th>
                                            <th data-column-id="nombrebodega">Bodega</th>

                                        </tr>
                                    </thead>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <input id="estadopedido" type="hidden" value="" />
    <script src="../Pages/ScriptsPage/Inventario/Ordencompra.js?1"></script>
    <script>
        $(document).ready(function () {
            datepicker();
            if ($('#newId').val() == 0) {
                var newid = newID('newId');
            }
            $("[money]").each(function (i, control) {
                $(control).autoNumeric('init');
            });
        })
    </script>
</asp:Content>
