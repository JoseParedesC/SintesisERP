<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Refinanciacion.aspx.cs"
    Inherits="Refinanciacion" MasterPageFile="~/Masters/SintesisMaster.Master" %>

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
    <input type="hidden" id="id_refinan" value="0" />
    <input type="hidden" id="opTipoFactura" value="T" />
    <div class="row" style="margin-left: 0;">
        <div class="x_panel">
            <div class="x_title col-lg-6 col-md-6 col-sm-7 col-xs-12">
                <h1 class="title-master" style="margin-top: 0;"><span class="fa fa-line-chart"></span>Refinanciacion Financiera</h1>
                <div class="clearfix"></div>
            </div>
            <div class="col-lg-6 col-md-6 col-sm-5 col-xs-12 Botns">
                <button title="Revertir" id="btnRev" class="btn btn-outline btn-danger  dim  pull-right" type="button"><i class="fa-file-o fa"></i></button>
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

            <div id="divfact">
                <div class="col-lg-2 col-md-3 col-sm-6 col-xs-12 sn-padding">
                    <div class="form-group">
                        <label for="cd_tipodoc" class="active">Tipo de Documento:</label>
                        <select runat="server" clientidmode="static" id="cd_tipodoc" class="form-control selectpicker" data-size="8" disabled="disabled">
                        </select>
                    </div>
                </div>

                <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12 sn-padding">
                    <div class="form-group">
                        <label for="Text_Nombre" class="active">Centro Costo</label>
                        <input type="hidden" id="id_ccostos" />
                        <input type="hidden" id="Idcurrent" value="0" />
                        <input type="hidden" id="isofDetalle" value='true' />
                        <input type="text" class="form-control actionautocomple inputsearch" id="codigoccostos" aria-describedby="sizing-addon1" data-search="Bodegas" data-method="BodegasBuscador" data-params="op:F;o:#" data-result="value:name;data:id" data-idvalue="id_ccostos" />
                    </div>
                </div>


                <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12  sn-padding">
                    <div class="form-group">
                        <label for="Text_Fecha" class="active">Fecha:</label>
                        <input id="Text_Fecha" type="text" placeholder=" " class="form-control" current="true" date="true" format="YYYY-MM-DD" />
                    </div>
                </div>

                <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12 sn-padding">
                    <div class="form-group">
                        <label for="Text_Nombre" class="active">Cliente</label>
                        <input type="hidden" id="cd_cliente" value="0" data-op="C" class="recalculo" />
                        <input type="hidden" id="tipotercero1" value="FA" />

                        <input type="text" class="form-control actionautocomple inputsearch" id="id_cliente" aria-describedby="sizing-addon1" data-search="Bodegas" data-method="BodegasBuscador" data-params="op:T;o:CL" data-result="value:name;data:id" data-idvalue="cd_cliente" />
                    </div>
                </div>

                <div class="col-lg-3 col-md-2 col-sm-6 col-xs-12 sn-padding">
                    <div class="form-group">
                        <label for="Text_Nombre" class="active">N° Factura</label>
                        <input type="hidden" id="cd_factu" value="0" data-valor="0" data-credito="0"/>
                        <input type="hidden" id="tipotercero2" value="F" />
                        <input type="text" class="form-control actionautocomple inputsearch" id="fact" aria-describedby="sizing-addon1" data-search="Bodegas" data-method="BodegasBuscador" data-params="op:I;o:U;tipo:#" data-endcallback="SelecFactura" data-result="value:name;data:id;cuotas:cuotas;saldoactual:saldoActual;interesmora:interesmora" data-idvalue="cd_factu" />
                    </div>
                </div>
            </div>
        </div>

        <%-----------------------------------------------------REFINEANCIAR -----------------------------------------------------------------------------------%>

        <div class="row" style="margin: 0px 10px;">
            <div id="pagoCredito">

                <hr class="hrseparator" style="margin-top: 0px; margin-bottom: 10px" />


                <div id="generarcuotas">
                    <div class="col-lg-2 col-md-3 col-sm-6 col-xs-12 sn-padding" id="PagoAcreditos">
                        <div class="form-group">
                            <label for="tipo_cartera" class="active">Forma Pago:</label>
                            <select runat="server" clientidmode="static" id="tipo_cartera" data-size="8" class="form-control selectpicker" title="Seleccione" data-live-search="true">
                            </select>
                        </div>
                    </div>

                    <div class="col-lg-1 col-md-2 col-sm-6 col-xs-12 sn-padding">
                        <div class="form-group">
                            <label for="valorforma" class="active">N° Cuotas:</label>
                            <input type="text" class="form-control" id="nrocuotas2" money="true" data-a-dec="." data-a-sep="," data-m-dec="0" data-v-min="1" data-v-max="36" value="1" data-a-sign="" />
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12 sn-padding">
                        <div class="form-group">
                            <label for="Text_FechaVenIni2" class="active">Venc. Inicial:</label>
                            <input id="Text_FechaVenIni2" type="text" placeholder=" " class="form-control" current="true" date="true" format="YYYY-MM-DD" />
                        </div>
                    </div>

                    <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12 sn-padding">
                        <div class="form-group">
                            <label for="valorforma" class="active">Valor Cuota</label>
                            <input type="text" class="form-control" id="valorCuotacre" money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="0" data-v-max="999999999999.99" value="0" data-a-sign="$ " />
                        </div>
                    </div>

                    <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12 sn-padding" id="ValorCuotaFinanza">
                        <div class="form-group">
                            <label for="valorfianza" class="active">Valor Cuota Fianza</label>
                            <input type="text" class="form-control" id="valorFianza" money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="0" data-v-max="999999999999.99" data-a-sign="$ " />
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12 sn-padding">
                        <div class="form-group">
                            <label for="id_ctamorads" class="active">Cuenta Intereses Mora:</label>
                            <input type="hidden" id="id_ctamora" value="TER" />
                            <input type="text" class="form-control actionautocomple inputsearch" id="id_ctamorads" aria-describedby="sizing-addon1" data-search="Bodegas" data-method="BodegasBuscador" data-params="op:B;o:#;tipo:ANT" data-result="value:name;data:id" data-idvalue="id_ctamora" />
                        </div>
                    </div>

                    <div class="col-lg-1 col-md-1 col-sm-1 col-xs-12 sn-padding">
                        <button id="actCuotas" type="button" data-option="F" class="btn btn-sin btn-circle addarticle" title="Agregar"><i class="fa fa-money"></i></button>
                    </div>

                </div>
                <div id="ContenedorCuota" class="col-lg-9 col-md-9 col-sm-12 col-xs-12 sn-padding center">
                    <h3 style="text-align: center">Detalle de Cuotas</h3>
                    <div class="table-responsive" style="max-height: 260px;">
                        <table class="table table-striped jambo_table" id="tblpagoscre" data-cuotas="0" data-inicial="" data-tipoven="0" data-dias="0">
                            <thead>
                                <tr>
                                    <th data-column-id="id">N° Cuota</th>
                                    <th data-column-id="vencimiento">Fecha</th>
                                    <th data-column-id="cuota" data-formatter="valor" data-sortable="false" data-class="text-right">Valor</th>
                                    <th data-column-id="saldo" data-formatter="saldo" data-sortable="false" data-class="text-right">Saldo</th>
                                </tr>
                            </thead>
                            <tbody id="tbdcuotas">
                            </tbody>
                        </table>
                    </div>

                </div>



                <div class="col-lg-9 col-md-9 col-sm-12 col-xs-12" style="padding: 0; display: none" id="TableCuotas">
                    <div class="table-responsive" style="max-height: 600px; min-height: 55px">
                        <table class="table table-striped jambo_table" id="tblcommodity" style="font-size: 12px;">
                            <thead>
                                <tr>
                                    <th data-column-id="cuota" data-formatter="cuota">Cuota No.</th>
                                    <th data-column-id="numfactura" data-formatter="numfactura">Factura</th>
                                    <th data-column-id="valorCuota" data-formatter="valorCuota">Valor de cuota</th>
                                    <th data-column-id="saldo" data-formatter="saldo">Saldo</th>
                                    <th data-column-id="interes" data-formatter="interes">Ineteres</th>
                                    <th data-column-id="capital" data-formatter="capital">Capital</th>
                                    <th data-column-id="vencimiento" data-formatter="vencimiento">Vencimiento</th>
                                </tr>
                            </thead>
                        </table>
                    </div>
                </div>
                <div class="col-lg-3 col-md-3 col-sm-12 col-xs-12" style="margin-top: 10px;">
                    <div class="row">
                        <div class="table-responsive" style="border: none;">

                            <div class="col-lg-12 col-md-12 col-xs-12 col-sm-12 sn_padding" style="border-bottom: 1px solid #e7eaec">
                                <div class="ibox-content codvalue text-right">
                                    <h1 id="TFactura" class="no-margins" style="font-weight: bold;">$ 0.00</h1>
                                    <span class="font-bold text-navy">Total Saldo</span>
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-12 col-xs-12 col-sm-12 sn_padding" style="border-bottom: 1px solid #e7eaec">
                                <div class="ibox-content codvalue text-right">
                                    <h1 id="TMora" class="no-margins" style="font-weight: bold;">$ 0.00</h1>
                                    <span class="font-bold text-navy">Total Mora</span>
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-12 col-xs-12 col-sm-12 sn_padding" style="border-bottom: 1px solid #e7eaec">
                                <div class="ibox-content codvalue text-right">
                                    <h1 id="VCuota" class="no-margins">$ 0.00</h1>
                                    <span class="font-bold text-navy">Valor Cuota</span>
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-12 col-xs-12 col-sm-12 sn_padding" style="border-bottom: 1px solid #e7eaec">
                                <div class="ibox-content codvalue text-right">
                                    <h1 id="Tcredito" class="no-margins">$ 0.00</h1>
                                    <span class="font-bold text-navy">A Credito</span>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>


    <%--   listar lo guardado--%>
    <div class="modal fade" id="ModalFacturas">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h2 class="modal-title">Lista de refinanciacion</h2>
                </div>
                <div class="modal-body clearfix" style="margin-bottom: 0; padding-top: 0 !important">
                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding: 5px;">
                            <div class="table-responsive" style="max-height: 300px">
                                <table class="table table-striped jambo_table" id="tblfacturas">
                                    <thead>
                                        <tr>
                                            <th data-column-id="id" data-formatter="edit" data-sortable="false" style="max-width: 30px !important;">Ver</th>
                                            <th data-column-id="estado" data-formatter="estado">Estado</th>
                                            <th data-column-id="Consecutivo" data-formatter="Consecutivo">Consecutivo</th>
                                            <th data-column-id="fecha" data-formatter="fecha">Fecha</th>
                                            <th data-column-id="numfactura" data-formatter="numfactura">N° Factura</th>
                                            <th data-column-id="total" data-formatter="total" data-sortable="false" data-class="text-right">Total Acreditar</th>
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


    <script src="../Package/Vendor/js/plugins/Autocomplete/jquery.autocomplete.js"></script>
    <script src="../Pages/ScriptsPage/Financiero/Refinanciacion.js"></script>

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
