<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Devolucionfacturas.aspx.cs"
    Inherits="Devolucionfacturas" MasterPageFile="~/Masters/SintesisMaster.Master" %>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPage" runat="server">
    <script type="text/javascript">
        window.appPath = "<%=Request.ApplicationPath%>";
    </script>
    <link href="../Package/Vendor/css/plugins/Autocomplete/autocomplet.css" rel="stylesheet" />
    <style>
        #tblpagoscre-header {
            display: none !important;
        }

        .inputlote {
            width: 100px;
            padding: 0;
            height: 25px !important;
            font-size: 12px !important;
        }

        .select-css {
            font-weight: 700;
            color: #444;
            padding: .3em 1em .3em .8em;
            width: 100%;
            max-width: 100%;
            border-radius: .5em;
            -moz-appearance: none;
            -webkit-appearance: none;
            appearance: none;
            background-image: url(data:image/svg+xml;charset=US-ASCII,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20width%3D%22292.4%22%20height%3D%22292.4%22%3E%3Cpath%20fill%3D%22%23007CB2%22%20d%3D%22M287%2069.4a17.6%2017.6%200%200%200-13-5.4H18.4c-5%200-9.3%201.8-12.9%205.4A17.6%2017.6%200%200%200%200%2082.2c0%205%201.8%209.3%205.4%2012.9l128%20127.9c3.6%203.6%207.8%205.4%2012.8%205.4s9.2-1.8%2012.8-5.4L287%2095c3.5-3.5%205.4-7.8%205.4-12.8%200-5-1.9-9.2-5.5-12.8z%22%2F%3E%3C%2Fsvg%3E), linear-gradient(to bottom, #ffffff 0%,#e5e5e5 100%);
            background-repeat: no-repeat, repeat;
            background-position: right .7em top 50%, 0 0;
            background-size: .65em auto, 100%;
        }

        .rowedit {
            width: 100px;
        }

        .tdedit {
            cursor: pointer;
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
            margin-bottom: 2px;
            border-style: none;
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
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: #1c84c6;
            color: #fff;
            text-align: center;
        }

        .row {
            background-color: #fff !important;
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

        #ModalFormas .btn-primary:hover, #ModalFormas .btn-primary:focus {
            background-color: #0074bcf0;
            border-color: #0074bcf0;
            color: #FFFFFF;
        }

        #divfact .icheckbox_square-green {
            height: 38px;
        }

        #tblcommodity-footer .row {
            margin-left: 0 !important;
        }
    </style>

    <input type="hidden" id="id_devfactura" value="0" />
    <input type="hidden" id="idToken" value="0" />
    <input type="hidden" id="financiera" value="0" />
    <input type="hidden" id="opTipoFactura" value="T" />
    <div class="row" style="margin-left: 0;">
        <div class="x_panel">
            <div class="x_title col-lg-6 col-md-6 col-sm-7 col-xs-12">
                <h1 class="title-master" style="margin-top: 0;"><span class="fa fa-bullhorn fa-fw"></span>Nota Crédito Factura</h1>
                <div class="clearfix"></div>
            </div>
            <div class="col-lg-6 col-md-6 col-sm-5 col-xs-12 Botns">
                <button title="Guardar" id="btnSave" data-option="I" class="btn btn-outline btn-primary dim  pull-right" type="button"><i class="fa fa-paste"></i></button>
                <button title="Imprimir" id="btnPrint" data-option="I" class="btn btn-outline btn-print dim  pull-right" type="button"><i class="fa fa-print"></i></button>
                <button title="Nueva" id="btnnew" data-option="R" class="btn btn-outline btn-default  dim  pull-right" type="button"><i class="fa-file-o fa"></i></button>
                <button title="Listar" id="btnList" data-option="L" class="btn btn-outline btn-info  dim  pull-right" type="button"><i class="fa-list fa"></i></button>

                <span class="pull-right quoteNumber"><span style="font-size: 14px; font-weight: normal;">Consecutivo</span><span class="entradanumber">0</span></span>
            </div>
        </div>
    </div>


    <div class="card" id="diventrada" style="padding-bottom: 30px;">
        <div class="row" style="margin: 0px 10px;">
            <div id="idvdevent">
                <div class="col-lg-2 col-md-3 col-sm-4 col-xs-6  sn-padding">
                    <div class="form-group">
                        <label for="Text_Fecha" class="active">Fecha:</label>
                        <input id="Text_Fecha" type="text" placeholder=" " class="form-control" current="true" date="true" format="YYYY-MM-DD" />
                    </div>
                </div>
                <div class="col-lg-2 col-md-3 col-sm-4 col-xs-6  sn-padding">
                    <div class="form-group">
                        <label for="Text_Nombre" class="active">N° Factura</label>
                        <input type="hidden" id="cd_factura" value="0" />
                        <input type="hidden" id="option" value="FA" />
                        <input type="text" class="form-control actionautocomple inputsearch" id="ds_factura" aria-describedby="sizing-addon1" style="height: 29.77px !important" data-search="Bodegas" data-method="BodegasBuscador" data-params="op:W;o:#" data-result="value:name;data:id" data-idvalue="cd_factura" />

                    </div>
                </div>
                <div id="divfact">
                    <div class="col-lg-2 col-md-2 col-sm-4 col-xs-12 sn-padding">
                        <div class="form-group">
                            <label for="esFE" class="active">Electronica?</label>
                            <div class="check-mail" style="margin-top: 2px">
                                <input type="checkbox" class="i-checks pull-right" id="esFE" value="P" disabled="disabled" />
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-4 col-sm-4 col-xs-12 sn-padding">
                        <div class="form-group">
                            <label for="Text_FechaFAC" class="active">Fecha Factura:</label>
                            <input id="Text_FechaFAC" type="text" placeholder=" " class="form-control" current="true" date="true" format="YYYY-MM-DD" data-op="C" disabled="disabled" />
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-3 col-sm-4 col-xs-12 sn-padding">
                        <div class="form-group">
                            <label for="cd_tipodoc" class="active">Tipo de Documento:</label>
                            <select runat="server" clientidmode="static" id="cd_tipodoc" class="form-control selectpicker" data-size="8" disabled="disabled">
                            </select>
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-4 col-xs-12 sn-padding">
                        <div class="form-group">
                            <label for="Text_Nombre" class="active">Centro Costo</label>
                            <input type="text" class="form-control inputsearch" placeholder=" " readonly="readonly" id="codigoccostos" aria-describedby="sizing-addon1" disabled="disabled" />
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-4 col-sm-4 col-xs-12 sn-padding">
                        <div class="form-group">
                            <label for="Text_Nombre" class="active">Vendedor</label>
                            <input type="text" class="form-control inputsearch" placeholder=" " readonly="readonly" id="ds_vendedor" aria-describedby="sizing-addon1" disabled="disabled" />
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-4 col-sm-4 col-xs-12 sn-padding">
                        <div class="form-group">
                            <label for="Text_Nombre" class="active">Cliente</label>
                            <input type="text" class="form-control inputsearch" placeholder=" " readonly="readonly" id="ds_cliente" aria-describedby="sizing-addon1" disabled="disabled" />
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-3 col-sm-4 col-xs-12 sn-padding">
                        <div class="form-group">
                            <label for="Text_Nombre" class="active">Cuenta de Anticipo:</label>
                            <input type="text" class="form-control inputsearch" placeholder=" " readonly="readonly" id="ds_ctaant" aria-describedby="sizing-addon1" />
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-3 col-sm-4 col-xs-12 sn-padding">
                        <div class="form-group">
                            <label for="m_anticipo" class="active">Anticipo:</label>
                            <input type="text" class="form-control recalculo" id="m_anticipo" placeholder=" " data-op="A" value="0.00" money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="0" data-a-sign="$ " disabled="disabled" />
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-4 col-sm-4 col-xs-12 sn-padding">
                        <div class="form-group">
                            <label for="Text_Nombre" class="active">Cuenta de Descuento Financiero:</label>
                            <input type="hidden" id="id_ctadscto" value="0" />
                            <input type="text" class="form-control actionautocomple inputsearch" id="ds_ctadscto" aria-describedby="sizing-addon1" data-search="Bodegas" data-method="BodegasBuscador" data-params="op:B;o:#;tipo:#" data-result="value:name;data:id" data-idvalue="id_ctadscto" />
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-3 col-sm-4 col-xs-12 sn-padding">
                        <div class="form-group">
                            <label for="m_discountfin" class="active">Descuento Financiero:</label>
                            <input type="text" class="form-control recalculo" id="m_discountfin" placeholder=" " value="0.00" money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="0" data-a-sign="$ " />
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row" style="margin: 0 10px;" id="divaddart" data-serie="false" data-inventario="false">
            <div class="col-lg-10 col-md-10 col-sm-12 col-xs-12" style="padding: 0;">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding: 0">
                    <div class="table-responsive" style="max-height: 600px; min-height: 250px">
                        <table class="table table-striped jambo_table" id="tblcommodity">
                            <thead>
                                <tr>
                                    <th data-formatter="select" data-column-id="id" data-columntext="html" data-sortable="false">

                                        <input type="checkbox" class="i-checks pull-right" id="allcheck" />
                                    </th>
                                    <th data-column-id="codigo">Código</th>
                                    <th data-column-id="nombre">Nombre</th>
                                    <th data-column-id="bodega">Bodega</th>
                                    <th data-column-id="lote" data-formatter="lote">Lote</th>
                                    <th data-column-id="serie" data-formatter="serie">Serie</th>
                                    <th data-column-id="cantidad" data-formatter="valor">Cant</th>
                                    <th data-column-id="cantidaddev" data-formatter="cantidad">Cant Dev</th>
                                    <th data-column-id="precio" data-formatter="valor">precio</th>
                                    <th data-column-id="descuento" data-formatter="valor">Desc</th>
                                    <th data-column-id="iva" data-formatter="valor">Iva</th>
                                    <th data-column-id="inc" data-formatter="valor">Inc</th>
                                    <th data-column-id="total" data-formatter="valor" data-sortable="false">Total</th>
                                </tr>
                            </thead>
                        </table>
                    </div>
                </div>
            </div>

            <div class="col-lg-2 col-md-2 col-sm-12 col-xs-12" style="margin-top: 10px;">
                <div class="row">
                    <div class="table-responsive" style="border: none;">

                        <div class="col-lg-12 col-md-12 col-xs-12 col-sm-12 sn_padding" style="border-bottom: 1px solid #e7eaec">
                            <div class="ibox-content codvalue text-right">
                                <h1 id="Ttventa" class="no-margins">$ 0.00</h1>
                                <span class="font-bold text-navy">Total Venta</span>
                            </div>
                        </div>
                        <div class="col-lg-12 col-md-12 col-xs-12 col-sm-12 sn_padding" style="border-bottom: 1px solid #e7eaec">
                            <div class="ibox-content codvalue text-right">
                                <h1 id="TdescArt" class="no-margins">$ 0.00</h1>
                                <span class="font-bold text-navy">Descuento</span>
                            </div>
                        </div>
                        <div class="col-lg-12 col-md-12 col-xs-12 col-sm-12 sn_padding" style="border-bottom: 1px solid #e7eaec">
                            <div class="ibox-content codvalue text-right">
                                <h1 id="Tiva" class="no-margins">$ 0.00</h1>
                                <span class="font-bold text-navy">Iva</span>
                            </div>
                        </div>
                        <div class="col-lg-12 col-md-12 col-xs-12 col-sm-12 sn_padding" style="border-bottom: 1px solid #e7eaec">
                            <div class="ibox-content codvalue text-right">
                                <h1 id="Tinc" class="no-margins">$ 0.00</h1>
                                <span class="font-bold text-navy">INC</span>
                            </div>
                        </div>
                        <div class="col-lg-12 col-md-12 col-xs-12 col-sm-12 sn_padding" style="border-bottom: 1px solid #e7eaec">
                            <div class="ibox-content codvalue text-right">
                                <h1 id="Ttotal" data-total="0.00" class="no-margins" style="font-weight: bold">$ 0.00</h1>
                                <span class="font-bold text-navy">Total Factura</span>
                            </div>
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
                                <div class="list-group" id="listtreeccostos">
                                </div>
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

    <div class="modal fade" id="ModalLotes">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h2 class="modal-title">Cantidas por Lotes</h2>
                </div>
                <div class="modal-body clearfix" style="margin-bottom: 0; padding-top: 0 !important">
                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-xs-12 col-sm-12" style="padding-top: 10px">
                            <div class="table-responsive" style="max-height: 350px;">
                                <table class="table table-striped jambo_table" style="font-size: 12px !important">
                                    <thead>
                                        <tr>
                                            <td>Lote</td>
                                            <td style="width: 120px;">Cant</td>
                                            <td style="width: 100px">Cant Dev</td>
                                        </tr>
                                    </thead>
                                    <tbody id="listlotes">
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-5 col-sm-6 col-xs-12 pull-right">
                            <div class="form-group">
                                <label for="lotetotal" class="active">Total:</label>
                                <input type="text" class="form-control" disabled="disabled" id="lotetotal" placeholder=" " value="0.00" />
                            </div>
                        </div>
                    </div>
                    <div class="row buttonaction pull-right">
                        <button title="Guardar" id="btnSaveLotes" data-option="I" class="btn btn-outline btn-primary dim waves-effect waves-light" type="button"><i class="fa fa-paste"></i></button>
                        <button title="Cancelar" id="btnCanceLotes" class="btn btn-outline btn-danger  dim waves-effect waves-light" data-dismiss="modal" aria-label="Close" type="button"><i class="fa-file-o fa"></i></button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="ModalFacturas">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h2 class="modal-title">Lista de Devoluciones</h2>
                </div>
                <div class="modal-body clearfix" style="margin-bottom: 0; padding-top: 0 !important">
                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding: 5px;">
                            <div class="table-responsive" style="max-height: 300px">
                                <table class="table table-striped jambo_table" id="tblfacturas">
                                    <thead>
                                        <tr>
                                            <th data-column-id="id" data-formatter="edit" data-sortable="false" style="max-width: 30px !important;">Ver</th>
                                            <th data-column-id="estado">Estado</th>
                                            <th data-column-id="id">Consecutivo</th>
                                            <th data-column-id="fecha">Fecha</th>
                                            <th data-column-id="consecutivo">N° Factura</th>
                                            <th data-column-id="total" data-formatter="valor" data-sortable="false" data-class="text-right">Valor</th>
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

    <script src="../Pages/ScriptsPage/Inventario/Devfactura.js?2"></script>
    <script>
        $(document).ready(function () {
            $('.i-checks').iCheck({
                checkboxClass: 'icheckbox_square-green',
                radioClass: 'iradio_square-green',
            });
            datepicker();
            $("[money]").each(function (i, control) {
                $(control).autoNumeric('init');
            });
            $('select').selectpicker();
        })
    </script>
</asp:Content>
