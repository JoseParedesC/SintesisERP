<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PagoProveedoresOld.aspx.cs"
    Inherits="PagoProveedoresOld" MasterPageFile="~/Masters/SintesisMaster.Master" %>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPage" runat="server">
    <script type="text/javascript">
        window.appPath = "<%=Request.ApplicationPath%>";
    </script>
    <link href="../Package/Vendor/css/plugins/Autocomplete/autocomplet.css" rel="stylesheet" />
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

        .pagonumber {
            width: 100% !important;
            text-align: center;
            position: relative;
            float: right;
            margin-top: -8px;
        }
    </style>
    <div class="wrapper wrapper-content" style="padding-top: 5px; background: #fff !important;">
        <input type="hidden" id="total_temp" />
        <div class="row" style="margin-left: 0;">
            <div class="x_panel">
                <div class="x_title">
                    <h1 class="title-master" style="margin-top: 0;"><span class="fa fa-bullhorn fa-fw"></span>Pago a Proveedores</h1>
                    <div class="clearfix"></div>
                </div>
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 divpagos" style="padding-top: 5px; padding-bottom: 15px; padding-left: 2px;">
                    <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
                        <div class="form-group">
                            <label for="Text_Fecha" class="active">Fecha:</label>
                            <input id="Text_Fecha" type="text" placeholder=" " class="form-control" current="true" date="true" format="YYYY-MM-DD" />
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-3 col-sm-5 col-xs-12 padsmall" style="margin-left: 12px">
                        <div class="form-group">
                            <label for="cd_formapagoprov" class="active">Forma de Pago:</label>
                            <select runat="server" clientidmode="static" id="cd_formapagoprov" class="form-control selectpicker" data-size="8">
                            </select>
                        </div>
                    </div>
                    <span>
                        <button title="Revertir" id="btnRev" class="btn btn-outline btn-danger  dim  pull-right" type="button" disabled="disabled"><i class="fa-file-o fa"></i></button>
                        <button title="Pagar" id="btnPay" data-option="I" class="btn btn-outline btn-primary dim  pull-right" type="button"><i class="fa fa-paste"></i></button>
                        <button title="Imprimir" id="btnPrint" data-option="I" class="btn btn-outline btn-print dim  pull-right" type="button"><i class="fa fa-print"></i></button>
                        <button title="Nueva" id="btnnew" data-option="R" class="btn btn-outline btn-default  dim  pull-right" type="button"><i class="fa-file-o fa"></i></button>
                        <button title="Listar" id="btnList" data-option="L" class="btn btn-outline btn-info  dim  pull-right" type="button"><i class="fa-list fa"></i></button>
                    </span>
                    <span class="pull-right quoteNumber"><span style="font-size: 14px; font-weight: normal;">Consecutivo</span><span class="pagonumber">0</span></span>
                </div>
                <div class="col-lg-10 col-md-10 col-sm-12 col-xs-12 " style="padding-top: 5px; padding-bottom: 15px; padding-left: 2px;">
                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 divpagos" style="padding-top: 5px; padding-bottom: 15px; padding-left: 2px;">
                        <div class="col-lg-5 col-md-5 col-sm-12 col-xs-12 ">
                            <div class="form-group">
                                <input type="hidden" id="id_pagoprove" value="0" />
                                <label for="Text_Nombre" class="active">Proveedor</label>
                                <div class="input-group ">
                                    <input type="hidden" id="cd_provider" value="0" />
                                    <input type="hidden" id="tipotercero" value="PR" />
                                    <input type="text" class="form-control inputsearch" placeholder=" " readonly="readonly" id="ds_provider" aria-describedby="sizing-addon1" />
                                    <span class="input-group-addon ">
                                        <button id="id_AccountBox" type="button" class="btn btn-primary btnsearch" data-search="CNTTerceros" data-method="CNTTercerosListTipo" data-title="Proveedores" data-select="1,3" data-column="id,iden,tercero" data-fields="cd_provider,ds_provider" data-params="tipoter,tipotercero">
                                            <i class="fa fa-fw fa-search"></i>
                                        </button>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 padsmall" style="margin-left: -12px">
                            <div class="form-group" style="margin-left: 2.3%">
                                <label for="ds_concepto" class="active">Concepto:</label>
                                <div class="input-group ">
                                    <input type="hidden" id="cd_concepto" value="0" />
                                    <input type="hidden" id="isDescuento" />
                                    <input type="text" class="form-control inputsearch" placeholder=" " readonly="readonly" id="ds_concepto" aria-describedby="sizing-addon1" />
                                    <span class="input-group-addon ">
                                        <button type="button" class="btn btn-primary btnsearch" data-search="Articulos" data-method="ConceptoList" data-title="Conceptos" data-select="1,3" data-column="id,codigo,nombre,idcuenta,Cuentacontable,esDescuento" data-fields="cd_concepto,ds_concepto">
                                            <i class="fa fa-fw fa-search"></i>
                                        </button>
                                    </span>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 divpagos" style="padding-top: 5px; padding-bottom: 15px; padding-left: 2px;">
                        <div class="col-lg-4  col-md-4 col-sm-6 col-xs-12" style="margin-right: 30px">
                            <div class="form-group">
                                <label for="m_valor" class="active">Valor:</label>
                                <input id="m_valor" type="text" class="form-control addart" value="0.00" placeholder=" " money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="0" data-a-sign="$ " />
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
                            <button id="addarticle" type="button" class="btn btn-sin btn-circle addarticle" title="Agregar" data-id="0"><i class="fa fa-cart-plus"></i></button>
                        </div>
                    </div>
                </div>
                <div class="col-lg-2 col-md-2 col-sm-12 col-xs-12" style="margin-top: -5px;">
                    <div class="row">
                        <div class="table-responsive" style="border: none;">
                            <div class="col-lg-12 col-md-12 col-xs-12 col-sm-12">
                                <div class="ibox-content codvalue text-right">
                                    <h1 id="mtotal_proveedor" class="no-margins totales">$ 0.00</h1>
                                    <span class="font-bold text-navy">Total Proveedores</span>
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-12 col-xs-12 col-sm-12">
                                <div class="ibox-content codvalue text-right">
                                    <h1 id="mtotal_concepto" class="no-margins totales">$ 0.00</h1>
                                    <span class="font-bold text-navy">Total Conceptos</span>
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-12 col-xs-12 col-sm-12">
                                <div class="ibox-content codvalue text-right">
                                    <h1 id="mtotal" class="no-margins totales">$ 0.00</h1>
                                    <span class="font-bold text-navy">Total</span>
                                </div>
                            </div>


                        </div>
                    </div>
                </div>

            </div>
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding-top: 5px; padding-bottom: 15px; padding-left: 2px">
                <ul class="nav nav-tabs">
                    <li class="active"><a data-toggle="tab" href="#tab-1" id="tabuno"><i class="fa fa-user"></i>
                        <span class="hidden-xs">Proveedor</span></a></li>
                    <li class=""><a data-toggle="tab" href="#tab-2" id="tabdos"><i class="fa fa-briefcase"></i>
                        <span class="hidden-xs">Conceptos</span></a></li>
                </ul>
                <div class="tab-content">
                    <div id="tab-1" class="tab-pane active ">
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding-top: 5px; padding-bottom: 15px; padding-left: 2px;" id="cajaentradas">
                            <div class="table-responsive ">
                                <table class="table table-striped jambo_table" id="tblPagoPro">
                                    <thead>
                                        <tr>
                                            <th data-column-id="estado" data-formatter="state" data-sortable="false" style="max-width: 30px">Seleccion</th>
                                            <th data-column-id="id">Documento</th>
                                            <th data-column-id="numfactura">Factura a Pagar</th>
                                            <th data-column-id="fechavence">Fecha de Vencimiento</th>
                                            <th data-column-id="valor" data-formatter="valor">Valor</th>
                                            <th data-column-id="SaldoActual" data-formatter="saldo">Saldo</th>
                                            <th data-column-id="pay" data-formatter="pay" data-sortable="false" style="max-width: 10px !important">Pagar</th>
                                        </tr>
                                    </thead>
                                </table>
                            </div>
                        </div>
                         <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding-top: 5px; padding-bottom: 15px; padding-left: 2px; display:none" id="cajapagos">
                                <div class="table-responsive"  >
                                    <table class="table table-striped jambo_table" id="tblrecibos">
                                        <thead>
                                            <tr>
                                                <th data-column-id="id_entrada">Entrada</th>
                                                <th data-column-id="nrofactura">Factura</th>
                                                <th data-column-id="totalEntrada">Valor de Entrada</th>
                                                <th data-column-id="valor">Valor Pagado</th>
                                            </tr>
                                        </thead>

                                    </table>

                                </div>
                                
                            </div>
                    </div>
                    <div id="tab-2" class="tab-pane  ">
                        <div class="table-responsive ">
                            <table class="table table-striped jambo_table" id="tblconceptos">
                                <thead>
                                    <tr>
                                        <th data-column-id="estado" data-formatter="state" data-sortable="false" style="max-width: 30px" class="text-center">Seleccion</th>
                                        <th data-column-id="id_concepto" class="text-center">id_Concepto</th>
                                        <th data-column-id="concepto" class="text-center">Concepto</th>
                                        <th data-column-id="valor" class="text-center">Valor</th>
                                    </tr>
                                </thead>
                                <tbody id="tbodconceptos">
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="Modalpagos">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h2 class="modal-title">Lista de Pagos</h2>
                </div>
                <div class="modal-body clearfix" style="margin-bottom: 0; padding-top: 0 !important">
                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding: 5px;">
                            <div class="table-responsive" style="max-height: 300px">
                                <table class="table table-striped jambo_table" id="tblpagos">
                                    <thead>
                                        <tr>
                                            <th data-column-id="id" data-formatter="edit" data-sortable="false" style="max-width: 30px !important;">Ver</th>
                                            <th data-column-id="nomestado">Estado</th>
                                            <th data-column-id="id">Consecutivo</th>
                                            <th data-column-id="proveedor">Proveedor</th>
                                            <th data-column-id="FormaPago">Forma de Pago</th>
                                            <th data-column-id="valorproveedor" data-formatter="valor" data-sortable="false" data-class="text-right">Valor</th>
                                            <th data-formatter="rever" data-sortable="false">Revertir</th>
                                            <th data-formatter="ver" data-sortable="false">Ver</th>
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


    <%--</main>--%>
    <script src="../Pages/ScriptsPage/Inventario/PagoProveedores.js?1"></script>
    <script>
        $(function () {
            $('select').selectpicker();
        })
        $(document).ready(function () {
            datepicker();
            if ($('#newId').val() == 0) {
                var newid = newID('newId');
            }

            $('.i-checks').iCheck({
                checkboxClass: 'icheckbox_square-green',
                radioClass: 'iradio_square-green',
            });
            $("[money]").each(function (i, control) {
                $(control).autoNumeric('init');
            });
        })

    </script>
</asp:Content>

