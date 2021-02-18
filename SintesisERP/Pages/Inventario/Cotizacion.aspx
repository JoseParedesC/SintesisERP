<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Cotizacion.aspx.cs"
    Inherits="Cotizacion" MasterPageFile="~/Masters/SintesisMaster.Master" %>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPage" runat="server">
    <script type="text/javascript">
        window.appPath = "<%=Request.ApplicationPath%>";
    </script>
    <link href="../Package/Vendor/css/plugins/Autocomplete/autocomplet.css" rel="stylesheet" />
    <%--/*estilos para el switch*/--%>
    <style>
        .switch {
            position: relative;
            display: inline-block;
            width: 60px;
            height: 34px;
            /*margin-top: 16px;
            margin-left: 15px;*/
        }

            .switch input {
                opacity: 0;
                width: 0;
                height: 0;
            }

        .slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: #ccc;
            -webkit-transition: .4s;
            transition: .4s;
        }

            .slider:before {
                position: absolute;
                content: "";
                height: 26px;
                width: 26px;
                left: 4px;
                bottom: 4px;
                background-color: white;
                -webkit-transition: .4s;
                transition: .4s;
            }

        input:checked + .slider {
            background-color: #2196F3;
        }

        input:focus + .slider {
            box-shadow: 0 0 1px #2196F3;
        }

        input:checked + .slider:before {
            -webkit-transform: translateX(26px);
            -ms-transform: translateX(26px);
            transform: translateX(26px);
        }

        /* Rounded sliders */
        .slider.round {
            border-radius: 34px;
        }

            .slider.round:before {
                border-radius: 50%;
            }
    </style>
    <%-- Estilos generales --%>
    <style>
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
            background: #fff;
            color: #1ab394 !important;
        }

            .nav.nav-tabs li.active {
                background: #1ab394;
            }

        .diventrada .nav-tabs > li > a:hover, .nav-tabs > li > a:focus {
            background-color: #1ab394;
            color: #fff !important;
            opacity: 0.8;
            border: none;
        }

        .nav.nav-tabs li a {
            color: #1ab394 !important;
            outline: none !important;
            border: 1px solid #1ab394;
            width: 100%;
            /*border-bottom: 2px #1ab394 solid !important;*/
        }

        .nav.nav-tabs li.active a {
            color: #fff !important;
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

        .active {
            display: block;
        }

        .inactive {
            display: none;
        }
    </style>
    <input type="hidden" id="id_factura" value="0" />
    <input type="hidden" id="opTipoFactura" value="T" />
    <input type="hidden" id="idToken" value="0" />
    <div class="wrapper " style="padding-top: 5px;">
        <div class="row" style="margin-left: 0;">
            <div class="x_panel">
                <div class="x_title col-lg-6 col-md-6 col-sm-7 col-xs-12">
                    <h1 class="title-master" style="margin-top: 0;"><span class="fa fa-bullhorn fa-fw"></span>Cotización</h1>
                    <div class="clearfix"></div>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-5 col-xs-12 Botns">
                    <button title="Guardar" id="btnSave" data-option="I" class="btn btn-outline btn-primary dim  pull-right" type="button"><i class="fa fa-paste"></i></button>
                    <button title="Imprimir" id="btnPrint" data-option="I" class="btn btn-outline btn-print dim  pull-right" type="button"><i class="fa fa-print"></i></button>
                    <button title="Nueva" id="btnnew" data-option="R" class="btn btn-outline btn-default  dim  pull-right" type="button"><i class="fa-file-o fa"></i></button>
                    <button title="Listar" id="btnList" data-option="L" class="btn btn-outline btn-info  dim  pull-right" type="button"><i class="fa-list fa"></i></button>

                    <span class="pull-right quoteNumber"><span style="font-size: 14px; font-weight: normal;">Consecutivo</span><span class="entradanumber">0</span></span>
                </div>
                <div class="card" id="diventrada" style="padding-bottom: 30px;">
                    <div class="row" style="margin: 0px 10px;">
                        <div class="col-lg-3 col-md-4 col-sm-4 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="Text_Fecha" class="active">Fecha:</label>
                                <input id="Text_Fecha" type="text" placeholder=" " class="form-control" current="true" date="true" format="YYYY-MM-DD" data-op="C" />
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-4 col-sm-4 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="Text_Nombre" class="active">Vendedor</label>

                                <input type="hidden" id="cd_vendedor" value="0" />
                                <input type="text" class="form-control actionautocomple inputsearch" id="ds_vendedor" aria-describedby="sizing-addon1" data-search="Bodegas" data-method="BodegasBuscador" data-params="op:V;o:#" data-result="value:name;data:id" data-idvalue="cd_vendedor" />
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-4 col-sm-4 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="Text_Nombre" class="active">Cliente</label>

                                <input type="hidden" id="cd_cliente" value="0" data-op="C" class="recalculo" />
                                <input type="hidden" id="tipotercero1" value="CL" />
                                <input type="text" class="form-control actionautocomple inputsearch" id="ds_cliente" aria-describedby="sizing-addon1" data-search="Bodegas" data-method="BodegasBuscador" data-params="op:T;o:CL" data-result="value:name;data:id" data-idvalue="cd_cliente" />

                            </div>
                        </div>
                        <div class="col-lg-3 col-md-4 col-sm-4 col-xs-12 sn-padding ">
                            <div class="form-group">
                                <label for="cd_wineridef" class="active">Bodega:</label>
                                <input type="hidden" id="cd_wineridef" value="0" />
                                <input type="text" class="form-control actionautocomple inputsearch" id="ds_bod" aria-describedby="sizing-addon1" data-search="Bodegas" data-method="BodegasBuscador" data-params="op:Z;o:#" data-result="value:name;data:id" data-idvalue="cd_wineridef" />
                            </div>
                        </div>

                        <div class="col-lg-2 col-md-2 col-sm-2 col-xs-12 sn-padding" id="div_des">
                            <div class="form-group">
                                <label for="descuento" class="">Descuento:</label>
                                <input id="descuento" type="text" placeholder=" " class="form-control inputsearch" value="0.00" placeholder=" " money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="0" data-a-sign="$ " />
                            </div>
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-2 col-xs-12 sn-padding" id="div_ini">
                            <div class="form-group">
                                <label for="v_inicial" class="">Cuota Inicial:</label>
                                <input id="v_inicial" type="text" placeholder=" " class="form-control inputsearch" value="0.00" placeholder=" " money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="0" data-a-sign="$ " />
                            </div>
                        </div>
                        <div class="col-lg-1 col-md-2 col-sm-2 col-xs-12 sn-padding swtich-container">
                            <label>Financiero?</label>
                            <label class="switch">
                                <input type="checkbox" data-validate="false" id="financiero" onclick="Reset()" />
                                <span class="slider round"></span>

                            </label>
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-2 col-xs-12 sn-padding inactive" id="PagoAcreditos">
                            <div class="form-group">
                                <label for="lineacredit" class="active">Linea de Credito</label>
                                <select runat="server" clientidmode="static" id="lineacredit" data-size="8" class="form-control selectpicker" title="" data-live-search="true"></select>
                            </div>
                        </div>
                        <div class="col-lg-1 col-md-3 col-sm-3 col-xs-12 sn-padding inactive" id="div_cuotas">
                            <div class="form-group">
                                <label for="valorforma" class="active">N° Cuotas:</label>
                                <input type="text" class="form-control" id="nrocuotas2" money="true" data-a-dec="." data-a-sep="," data-m-dec="0" data-v-min="0" data-v-max="60" value="1" data-a-sign="" />
                            </div>
                        </div>
                        <div class="col-lg-1 col-md-2 col-sm-2 col-xs-12 sn-padding inactive" id="div_calcular">
                            <label for="Calcular" class="active">Calcular:</label>
                            <button title="Calcular" id="btnCalcular" class="btn btn-outline btn-primary dim m-l-xs" type="button" style="margin-bottom: 7px !important; margin-top: -3px; margin-left: 7px;"><i class="fa fa-calculator"></i></button>
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-2 col-xs-12 sn-padding inactive" id="div_cal">
                            <div class="form-group">
                                <label for="id_cal" class="active">Valor Cuota</label>
                                <input id="id_cal" type="text" placeholder=" " class="form-control" placeholder=" " money="true" data-a-dec="." data-a-sep="," data-m-dec="2" value="0.00" readonly="readonly" disabled="disabled" />
                            </div>
                        </div>
                    </div>
                    <div class="row" style="margin: 0 10px;">
                        <hr class="hrseparator" style="margin-top: 0px; margin-bottom: 10px" />
                    </div>
                    <div class="row" style="margin: 0 10px;" id="divaddart" data-serie="false" data-inventario="false">
                        <div class="col-lg-10 col-md-10 col-sm-12 col-xs-12" style="padding: 0;">
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 divarticleadd" style="padding: 0; padding-bottom: 15px;">
                                <div class="col-lg-2 col-md-3 col-sm-3 col-xs-12">
                                    <div class="form-group">
                                        <label for="v_code" class="active">Código:</label>
                                        <input type="text" name="country" id="v_code" class="form-control" placeholder=" " />
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-3 col-sm-6 col-xs-12">
                                    <div class="form-group">
                                        <label for="nombre" class="active">Nombre:</label>
                                        <input type="text" name="nombre" id="nombre" class="form-control" placeholder=" " disabled="true" data-lote="false" data-serie="false" />
                                    </div>
                                </div>
                                <div class="col-lg-2 col-md-2 col-sm-3 col-xs-6">
                                    <div class="form-group">
                                        <label for="existencia" class="active">Exist:</label>
                                        <input id="existencia" type="text" class="form-control" placeholder=" " money="true" data-a-dec="." data-a-sep="," data-m-dec="2" value="0.00" readonly="readonly" disabled="disabled" />
                                    </div>
                                </div>
                                <div class="col-lg-1 col-md-2 col-sm-2 col-xs-6">
                                    <div class="form-group">
                                        <label for="m_quantity" class="active">Cant:</label>
                                        <input id="m_quantity" type="text" class="form-control" placeholder=" " money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="0.01" value="1.00" />
                                    </div>
                                </div>
                                <div class="col-lg-2 col-md-2 col-sm-2 col-xs-6">
                                    <div class="form-group">
                                        <label for="m_precio" class="active">Precio:</label>
                                        <input id="m_precio" type="text" class="form-control addart" value="0.00" placeholder=" " money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="0" data-a-sign="$ " />
                                    </div>
                                </div>
                                <div class="col-lg-2 col-md-2 col-sm-3 col-xs-6">
                                    <div class="form-group">
                                        <label for="Text_Descuento" class="active">% Desc:</label>
                                        <input id="Text_Descuento" type="text" class="form-control addart" data-option="P" placeholder=" " value="0.00" money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="0" data-v-max="100" data-a-sign="% " />
                                    </div>
                                </div> 
                                <div class="col-lg-2 col-md-2 col-sm-2 col-xs-6">
                                    <div class="form-group">
                                        <label for="m_discount" class="active">Desc x Valor:</label>
                                        <input type="text" class="form-control addart" id="m_discount" data-option="V" placeholder=" " value="0.00" money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="0" data-a-sign="$ " />
                                    </div>
                                </div>
                                <div class="col-lg-1 col-md-1 col-sm-3 col-xs-12">
                                    <button title="Agregar" id="addarticle" class="btn btn-outline btn-primary dim  pull-right" type="button" data-id="0" data-idbodega="0" style="margin-bottom: 0 !important; margin-top: 15px; float: left !important;"><i class="fa fa-plus"></i></button>
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding-bottom: 15px; padding-left: 2px; margin-top: -10px;">
                                <div class="table-responsive" style="max-height: 300px">
                                    <table class="table table-striped jambo_table" id="tblcommodity">
                                        <thead>
                                            <tr>
                                                <th data-column-id="codigo" data-formatter="delete" data-sortable="false">Eliminar</th>
                                                <th data-column-id="codigo">Código</th>
                                                <th data-column-id="nombre">Nombre</th>
                                                <th data-column-id="cantidad" data-formatter="cantidad">Cantidad</th>
                                                <th data-column-id="precio" data-formatter="precio">precio</th>
                                                <th data-column-id="iva" data-formatter="valor">Iva</th>
                                                <th data-column-id="inc" data-formatter="valor">Inc</th>
                                                <th data-column-id="descuento" data-formatter="valor">Descuento</th>
                                                <th data-column-id="total" data-formatter="total" data-sortable="false" class="total">Total</th>
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
                                            <h1 id="Ttventa" class="no-margins">$ 0.00</h1>
                                            <span class="font-bold text-navy">Subtotal</span>
                                        </div>
                                    </div>
                                    <div class="col-lg-12 col-md-12 col-xs-12 col-sm-12 " id="txt_desc">
                                        <div class="ibox-content codvalue text-right">
                                            <h1 id="Tdescuento" class="no-margins">$ 0.00</h1>
                                            <span class="font-bold text-navy">Descuento</span>
                                        </div>
                                    </div>
                                    <div class="col-lg-12 col-md-12 col-xs-12 col-sm-12" id="txtini">
                                        <div class="ibox-content codvalue text-right">
                                            <h1 id="Tinicial" class="no-margins">$ 0.00</h1>
                                            <span class="font-bold text-navy">Valor Inicial</span>
                                        </div>
                                    </div>
                                    <div class="col-lg-12 col-md-12 col-xs-12 col-sm-12">
                                        <div class="ibox-content codvalue text-right">
                                            <h1 id="Tiva" class="no-margins">$ 0.00</h1>
                                            <span class="font-bold text-navy">Iva</span>
                                        </div>
                                    </div>
                                    <div class="col-lg-12 col-md-12 col-xs-12 col-sm-12">
                                        <div class="ibox-content codvalue text-right">
                                            <h1 id="Tinc" class="no-margins">$ 0.00</h1>
                                            <span class="font-bold text-navy">Inc</span>
                                        </div>
                                    </div>
                                    <div class="col-lg-12 col-md-12 col-xs-12 col-sm-12">
                                        <div class="ibox-content codvalue text-right">
                                            <h1 id="Ttotal" data-total="0.00" class="no-margins" style="font-weight: bold">$ 0.00</h1>
                                            <span class="font-bold text-navy">Total Cotización</span>
                                        </div>
                                    </div>
                                </div>
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
                            <h2 class="modal-title">Lista de Cotizaciones</h2>
                        </div>
                        <div class="modal-body clearfix" style="margin-bottom: 0; padding-top: 0 !important">
                            <div class="row">
                                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding: 5px;">
                                    <div class="table-responsive" style="max-height: 300px">
                                        <table class="table table-striped jambo_table" id="tblfacturas">
                                            <thead>
                                                <tr>
                                                    <th data-column-id="id" data-formatter="edit" data-sortable="false" style="max-width: 30px !important;">Ver</th>
                                                    <th data-column-id="id">Consecutivo</th>
                                                    <th data-column-id="estado">Estado</th>
                                                    <th data-column-id="fechacot">Fecha</th>
                                                    <th data-column-id="cliente">Cliente</th>
                                                    <th data-column-id="total" data-formatter="total" data-sortable="false" data-class="text-right">Total</th>
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
        </div>
    </div>
    <script src="../Package/Vendor/js/plugins/Autocomplete/jquery.autocomplete.js"></script>
    <script src="../Pages/ScriptsPage/Inventario/Cotizacion.js"></script>
    <script>
        $(document).ready(function () {
            datepicker();
            $("[money]").each(function (i, control) {
                $(control).autoNumeric('init');
            });
        })
    </script>
</asp:Content>
