<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Conversionarticulos.aspx.cs"
    Inherits="Conversionarticulos" MasterPageFile="~/Masters/SintesisMaster.Master" %>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPage" runat="server">
    <script type="text/javascript">
        window.appPath = "<%=Request.ApplicationPath%>";
    </script>
    <link href="../Package/Vendor/css/plugins/Autocomplete/autocomplet.css" rel="stylesheet" />
    <style>
        #ModalConfigSerieLote select {
            display: block !important;
        }

        #configuration td {
            max-width: 20px;
        }

        #configuration .table-responsive {
            overflow-x: unset;
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
            margin-bottom: 10px;
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

        .desactivelote, .desactiveserie, .desactiveservice {
            display: none;
        }

        .activelote, .activeserie, .activeservice {
            display: block;
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
            height: 38px;
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
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #1ab394;
            color: #fff;
            text-align: center;
        }

        #containerTable {
            margin-top: 12px !important;
        }

        .row {
            background-color: #fff !important;
        }

        #addarticle {
            margin-top: 13px;
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

        .errorselect {
            border-bottom: 2px solid #f00 !important;
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
    </style>
    <input type="hidden" id="id_entrada" value="0" />
    <input type="hidden" id="id_entradatemp" value="0" />
    <input type="hidden" id="facturatemp" value="" />
    <input type="hidden" id="opTipoEntrada" value="T" />
    <div class="row" style="margin-left: 0;">
        <div class="x_panel">
            <div class="x_title col-lg-5 col-md-5 col-sm-7 col-xs-12">
                <h1 class="title-master" style="margin-top: 0;"><span class="fa fa-bullhorn fa-fw"></span>Conversión de Articulos</h1>
                <div class="clearfix"></div>
            </div>
            <div class="col-lg-7 col-md-7 col-sm-5 col-xs-12 Botns">
                <button title="Revertir" id="btnRev" class="btn btn-outline btn-danger  dim  pull-right" type="button" disabled="disabled"><i class="fa-file-o fa"></i></button>
                <button title="Guardar" id="btnSave" data-option="I" class="btn btn-outline btn-primary dim  pull-right" type="button"><i class="fa fa-paste"></i></button>
                <button title="Imprimir" id="btnPrint" data-option="I" class="btn btn-outline btn-print dim  pull-right" type="button" style="display: none"><i class="fa fa-print"></i></button>
                <button title="Nueva" id="btnnew" data-option="R" class="btn btn-outline btn-default  dim  pull-right" type="button"><i class="fa-file-o fa"></i></button>
                <button title="Listar" id="btnList" data-option="L" class="btn btn-outline btn-info  dim  pull-right" type="button"><i class="fa-list fa"></i></button>
                <span class="pull-right quoteNumber"><span style="font-size: 14px; font-weight: normal;">Consecutivo</span><span class="entradanumber">0</span></span>
            </div>
        </div>
    </div>
    <div class="card" id="diventrada" style="padding-bottom: 30px;">
        <div class="row" style="margin: 0px 10px;">
            <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12 sn-padding">
                <div class="form-group">
                    <label for="Text_Fecha" class="active">Fecha:</label>
                    <input id="Text_Fecha" type="text" placeholder=" " class="form-control" current="true" date="true" format="YYYY-MM-DD" />
                </div>
            </div>
            <div class="col-lg-2 col-md-3 col-sm-6 col-xs-12 sn-padding">
                <div class="form-group">
                    <label for="cd_tipodoc" class="active">Tipo de Documento:</label>
                    <select runat="server" clientidmode="static" id="cd_tipodoc" class="form-control selectpicker" data-size="8">
                    </select>
                </div>
            </div>
            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12 sn-padding">
                <div class="form-group">
                    <label for="Text_Nombre" class="active">Centro Costo</label>
                    <input type="hidden" id="id_ccostos" />
                    <input type="hidden" id="Idcurrent" value="0" />
                    <input type="hidden" id="isofDetalle" value='true' />
                    <input type="text" class="form-control actionautocomple inputsearch" id="codigoccostos" aria-describedby="sizing-addon1" data-search="Bodegas" data-method="BodegasBuscador" data-params="op:F;o:#" data-result="value:name;data:id" data-idvalue="id_ccostos" />

                </div>
            </div>
            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12  sn-padding">
                <div class="form-group">
                    <label for="cd_wineridef" class="active">Bodega:</label>
                    <input type="hidden" id="cd_wineridef" />
                    <input type="text" class="form-control actionautocomple inputsearch" id="ds_bod" aria-describedby="sizing-addon1" data-search="Bodegas" data-method="BodegasBuscador" data-params="op:Z;o:#" data-result="value:name;data:id" data-idvalue="cd_wineridef" />
                </div>
            </div>
        </div>
        <div class="row" style="margin: 0 10px;">
            <hr class="hrseparator" style="margin-top: 0px; margin-bottom: 10px">
        </div>
        <div class="row" style="margin: 0 10px;">
            <div class="col-lg-10 col-md-10 col-sm-12 col-xs-12" style="padding: 0;">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding: 0;">
                    <div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
                        <div class="form-group">
                            <label for="v_code" class="active">Código:</label>
                            <input type="hidden" id="v_produ" value="0" />
                            <input type="text" name="country" id="v_code" class="form-control actionautocomple inputsearch" data-search="Productos" data-endcallback="SelecProducto" data-method="ArticulosBuscador" data-params="op:E;o:#;formula:true;id_prod:0;" data-result="value:name;data:id;inventarial:inventarial" data-idvalue="v_produ" />
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-2 col-xs-12">
                        <div class="form-group">
                            <label for="m_quantity" class="active">Cantidad:</label>
                            <input id="m_quantity" type="text" class="form-control" placeholder=" " money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="0" data-v-max="999999999.99" value="1.00" />
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12 desactivelote">
                        <div class="form-group">
                            <label for="v_lote" class="active">Lote:</label>
                            <input type="text" name="country" id="v_lote" class="form-control" placeholder=" " />
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12 desactivelote">
                        <div class="form-group">
                            <label for="Text_FechaV2" class="active">Vencimiento:</label>
                            <input id="Text_FechaV2" type="text" placeholder=" " class="form-control" current="true" date="true" format="YYYY-MM-DD" />
                        </div>
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-1 col-xs-12">
                        <button id="addarticle" type="button" class="btn btn-outline btn-primary dim  pull-right" title="Agregar" data-serie=""><i class="fa fa-plus"></i></button>
                    </div>
                </div>
                <div id="containerTable" class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding-bottom: 15px; padding-left: 2px;">
                    <div class="table-responsive" style="max-height: 300px">
                        <table class="table table-striped jambo_table" id="tblcommodity">
                            <thead>
                                <tr>
                                    <th data-column-id="delete" data-formatter="delete" data-sortable="false">Eliminar</th>
                                    <th data-column-id="codigo">Código</th>
                                    <th data-column-id="nombre">Nombre</th>
                                    <th data-column-id="serie" data-formatter="serie">Serie</th>
                                    <th data-column-id="config" data-formatter="configuracion">Config</th>
                                    <th data-column-id="bodega">Bodega</th>
                                    <th data-column-id="cantidad" data-formatter="cantidad">Cantidad</th>
                                    <th data-column-id="costo" data-formatter="costo">Costo</th>
                                    <th data-column-id="costototal" data-formatter="costototal">Costo Total</th>
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
                                <h1 id="Tcosto" class="no-margins">$ 0.00</h1>
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
                    <h2 class="modal-title">Lista de Entradas</h2>
                </div>
                <div class="modal-body clearfix" style="margin-bottom: 0; padding-top: 0 !important">
                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding: 5px;">
                            <div class="table-responsive" style="max-height: 300px">
                                <table class="table table-striped jambo_table" id="tblentradas">
                                    <thead>
                                        <tr>
                                            <th data-column-id="id" data-formatter="edit" data-sortable="false" style="max-width: 30px !important;">Ver</th>
                                            <th data-column-id="estado">Estado</th>
                                            <th data-column-id="id">Consecutivo</th>
                                            <th data-column-id="fechadocumen">Fecha</th>
                                            <th data-column-id="concepto">Concepto</th>
                                            <th data-column-id="costo" data-formatter="costo" data-sortable="false" data-class="text-right">Costo</th>
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
    <div class="modal fade" id="ModalConfig">
        <div class="modal-dialog modal-sm" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h2 class="modal-title">Configuración</h2>
                </div>
                <div class="modal-body clearfix" style="margin-bottom: 0; padding-top: 0 !important">
                    <div class="row">
                        <div class="col-md-4 col-lg-4 col-sm-4 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="prorratear" class="active">Prorratear? </label>
                                <div class="check-mail">
                                    <input type="checkbox" class="i-checks pull-right" id="prorratear" checked="checked" />
                                </div>
                            </div>
                        </div>
                        <div class="col-md-8 col-lg-8 col-sm-8 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="typeprorrateo" class="active">Tipo</label>
                                <select id="typeprorrateo" class="form-control selectpicker" runat="server" clientidmode="static">
                                    <option value="V">Valor</option>
                                    <option value="C">Cantidad</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12  sn-padding">
                            <div class="form-group">
                                <label for="Text_Nombre" class="active">Proveedor</label>
                                <div class="input-group ">
                                    <input type="hidden" id="cd_provconf" value="0" />
                                    <input type="text" class="form-control inputsearch" placeholder=" " readonly="readonly" id="ds_provconf" aria-describedby="sizing-addon1" />
                                    <span class="input-group-addon ">
                                        <button id="btnproviderconf" type="button" class="btn btn-primary btnsearch" data-search="Provedores" data-method="ProveedoresList" data-title="Proveedores"
                                            data-select="1,3" data-column="id,nit,razonsocial" data-fields="cd_provconf,ds_provconf" disabled="disabled">
                                            <i class="fa fa-fw fa-search"></i>
                                        </button>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-12 col-xs-12">
                            <button id="btnCance" type="button" data-id="0" class="pull-right btn btn-danger" data-dismiss="modal" aria-label="Close">Cerrar</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="ModalLoad">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-body clearfix" style="margin-bottom: 0; padding-top: 0 !important">
                    <div class="row">
                        <h4 class="text-center">Procesando...</h4>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="ModalLog">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h2 class="modal-title">Lista de Log</h2>
                </div>
                <div class="modal-body clearfix" style="margin-bottom: 0; padding-top: 0 !important">
                    <div class="row">
                        <input type="hidden" id="id_proce" value="0" />
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding: 5px;">
                            <div class="table-responsive" style="max-height: 300px">
                                <table class="table table-striped jambo_table" id="tbllog">
                                    <thead>
                                        <tr>
                                            <th data-column-id="fecha">Fecha</th>
                                            <th data-column-id="mensaje">Mensaje</th>
                                        </tr>
                                    </thead>
                                </table>
                            </div>
                        </div>
                        <div class="col-sm-12 col-xs-12">
                            <button type="button" data-id="0" class="pull-right btn btn-danger waves-effect waves-light" data-dismiss="modal" aria-label="Close">Cerrar</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="ModalSeries">
        <div class="modal-dialog modal-sm" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h2 class="modal-title">Registrar Series</h2>
                </div>
                <div class="modal-body clearfix" style="margin-bottom: 0; padding-top: 0 !important">
                    <div class="row">
                        <div class="table-responsive" style="max-height: 400px; padding-right: 8px;">
                            <div class="col-lg-12 col-md-12 col-xs-12 col-sm-12" style="padding: 0; padding-top: 10px !important;" id="listseries">
                            </div>
                        </div>
                    </div>
                    <div class="row buttonaction pull-right">
                        <button title="Guardar" id="btnSaveSeries" data-option="I" class="btn btn-outline btn-primary dim waves-effect waves-light" type="button"><i class="fa fa-paste"></i></button>
                        <button title="Cancelar" id="btnCanceSeries" class="btn btn-outline btn-danger  dim waves-effect waves-light" data-dismiss="modal" aria-label="Close" type="button"><i class="fa-file-o fa"></i></button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="ModalConfigSerieLote">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content" id="configuration">
                <div class="modal-header">
                    <input type="hidden" id="id_artconf" value="0" />
                    <input type="hidden" id="cantconf" value="0" />
                    <input type="hidden" id="id_bodegaconf" value="0" />
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h2 class="modal-title">Configuracion Series y Lotes</h2>
                </div>

                <div class="row" style="margin: 0px 10px;">
                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding: 5px;">
                        <div class="table-responsive">
                            <table class="table table-striped jambo_table" id="tbconfig">
                                <thead>
                                    <tr>
                                        <th data-column-id="nombre">Nombre</th>
                                        <th data-column-id="cantidad">Cantidad</th>
                                        <th data-column-id="serie" data-formatter="series">Series</th>
                                    </tr>
                                </thead>
                                <tbody></tbody>
                            </table>
                        </div>
                    </div>
                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 text-right" style="margin: 10px 10px 10px">
                        <button title="Guardar" id="btnSaveConfig" data-option="I" class="btn btn-outline btn-primary dim waves-effect waves-light" type="button"><i class="fa fa-paste"></i></button>
                        <button title="Cancelar" id="btnCanceConfig" class="btn btn-outline btn-danger  dim waves-effect waves-light" data-dismiss="modal" aria-label="Close" type="button"><i class="fa-file-o fa"></i></button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    </div>
    <input type="hidden" id="newId" value="0" />
    <input type="hidden" value="" id="htmlestado" />
    <script src="../Pages/ScriptsPage/Inventario/ConversionArticulos.js"></script>
    <script src="../Package/Vendor/js/plugins/Autocomplete/jquery.autocomplete.js"></script>
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
