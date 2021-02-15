<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RecaudoCartera.aspx.cs"
    Inherits="RecaudoCartera" MasterPageFile="~/Masters/SintesisMaster.Master" %>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPage" runat="server">
    <script type="text/javascript">
        window.appPath = "<%=Request.ApplicationPath%>";
    </script>
    <link href="../Package/Vendor/css/plugins/Autocomplete/autocomplet.css" rel="stylesheet" />


    <style>
        #ModalFormas, table th, #ModalFormas table a span {
            color: #3d3f41e8 !important;
        }


            #ModalFormas .btn-primary:hover, #ModalFormas .btn-primary:focus {
                background-color: #0074bcf0;
                border-color: #0074bcf0;
                color: #FFFFFF;
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

        input[type="checkbox"].form-control {
            height: 16px !important;
            margin: 0px 0 0 !important;
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
            width: 70px !important;
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

        .nav.nav-tabs li {
            background: #fff;
            color: #205F96 !important;
        }

            .nav.nav-tabs li.active {
                background: #5696f7d6;
            }

            .nav.nav-tabs li a {
                color: #205F96 !important;
                outline: none !important;
                border-bottom: 2px #337ab7 solid !important;
            }

            .nav.nav-tabs li.active a {
                color: #FFF !important;
            }

        .fa-2x {
            font-size: 1.6em !important;
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

        .command-edit {
            margin-left: 5px;
        }
    </style>
    <div class="row" style="margin-left: 0;">
        <div class="x_panel">
            <div class="x_title col-lg-5 col-md-5 col-sm-7 col-xs-12">
                <h1 class="title-master" style="margin-top: 0;"><span class="fa fa-level-down fa-fw"></span>Recaudo de Cartera</h1>
                <div class="clearfix"></div>
            </div>
            <div class="col-lg-7 col-md-7 col-sm-5 col-xs-12 Botns">
                <input type="hidden" id="id_recibo" value="0" />

                <input type="hidden" id="interesCredit" value="0" />
                <input type="hidden" id="idToken" value="0" />
                <button title="Revertir" id="btnRev" class="btn btn-outline btn-danger  dim  pull-right" type="button" disabled="disabled"><i class="fa-file-o fa"></i></button>
                <button title="Guardar" id="btnSave" data-option="F" class="btn btn-outline btn-primary dim  pull-right" type="button"><i class="fa fa-paste"></i></button>
                <button title="Temporal" id="btnTemp" data-option="L" class="btn btn-outline btn-success  dim  pull-right" type="button" style="display: none"><i class="fa fa-upload"></i></button>
                <button title="Imprimir" id="btnPrint" data-option="I" class="btn btn-outline btn-print dim  pull-right" type="button"><i class="fa fa-print"></i></button>
                <button title="Nueva" id="btnnew" data-option="R" class="btn btn-outline btn-default  dim  pull-right" type="button"><i class="fa-file-o fa"></i></button>
                <button title="Listar" id="btnList" data-option="L" class="btn btn-outline btn-info  dim  pull-right" type="button"><i class="fa-list fa"></i></button>


                <span class="pull-right quoteNumber"><span style="font-size: 14px; font-weight: normal;">Consecutivo</span><span class="pagonumber">0</span></span>
            </div>
        </div>
    </div>

    <div class="card" id="diventrada">
        <div class="row" style="margin: 0px 10px;">
            <div class="col-lg-2 col-md-3 col-sm-6 sn-padding">
                <div class="form-group">
                    <label for="cd_tipodoc" class="active">Tipo de Documento:</label>
                    <select runat="server" clientidmode="static" id="cd_tipodoc" class="form-control selectpicker" data-size="8">
                    </select>
                </div>
            </div>
            <%-- centro de costo --%>
            <div class="col-lg-2 col-md-3 col-sm-6 col-xs-12 sn-padding">
                <div class="form-group">
                    <label for="Text_Nombre" class="active">Centro Costo</label>
                    <input type="hidden" id="id_ccostos" />
                    <input type="hidden" id="Idcurrent" value="0" />
                    <input type="hidden" id="isofDetalle" value='true' />
                    <input type="text" class="form-control actionautocomple inputsearch" id="codigoccostos" aria-describedby="sizing-addon1" data-search="Bodegas" data-method="BodegasBuscador" data-params="op:F;o:#" data-result="value:name;data:id" data-idvalue="id_ccostos" />
                </div>
            </div>
            <div class="col-lg-2 col-md-3 col-sm-6 sn-padding">
                <div class="form-group">
                    <label for="Text_Fecha" class="active">Fecha Doc:</label>
                    <input id="Text_Fecha" type="text" placeholder=" " class="form-control" current="true" date="true" format="YYYY-MM-DD" />
                </div>
            </div>

            <%-- Cliente --%>
            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12 sn-padding">
                <div class="form-group">
                    <label for="Text_Nombre" class="active">Cliente</label>

                    <input type="hidden" id="cd_cliente" value="0" data-op="C" class="recalculo" />
                    <input type="hidden" id="tipotercero1" value="CL" />
                    <input type="text" class="form-control actionautocomple inputsearch" id="ds_cliente" aria-describedby="sizing-addon1" data-search="Bodegas" data-method="BodegasBuscador" data-params="op:T;o:CL" data-result="value:name;data:id" data-idvalue="cd_cliente" />
                </div>
            </div>


            <div class="col-lg-12 col-md-10 col-sm-12 col-xs-12  sn-padding">
                <div class="form-group">
                    <label for="descripcion" class="active">Detalle:</label>
                    <textarea id="descripcion" max-length="1000" class="form-control" placeholder="Detalle" style="display: block; min-height: 40px !important; width: 100% !important; max-width: 100%; min-width: 100%; max-height: 40px"></textarea>
                </div>
            </div>

            <!-- -->
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 sn-padding divarticleadd" id="divaddart">
                <div class="card" style="padding: 0px 13px">
                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding: 0" id="cajacuotas">
                            <div class="table-responsive" style="max-height: 600px; min-height: 55px">
                                <table class="table table-striped jambo_table" id="tblcommodity" style="font-size: 10.5px">
                                    <thead>
                                        <tr>
                                            <th data-column-id="estado" data-formatter="state" data-sortable="false" style="max-width: 30px">Seleccion</th>
                                            <th data-column-id="estado" data-formatter="view" data-sortable="false" style="max-width: 30px">Detalle</th>
                                            <th data-column-id="cuota_pagar">Cuota No.</th>
                                            <th data-column-id="factura">Consecutivo</th>
                                            <th data-column-id="total" data-formatter="total">Total Fact</th>
                                            <th data-column-id="fechavencimiento">Vencimiento</th>
                                            <th data-column-id="diasvencido">Dias Vencidos</th>
                                            <th data-column-id="valorcuota" data-formatter="valorcuota">Vlr de Cuota</th>
                                            <th data-column-id="saldocuota" data-formatter="saldocuota">Sdo de Cuota</th>
                                            <th data-column-id="interes" data-formatter="interes">% Int. mora</th>
                                            <th data-column-id="interes" data-formatter="Tinteres">Total Interes</th>
                                            <th data-column-id="interesabono" data-formatter="Tinteresabono">Int Mora Abonado</th>
                                            <th data-column-id="saldoInteres" data-formatter="saldointeres">Sdo Interes</th>
                                            <th data-column-id="id" data-formatter="capital">A Capital</th>
                                            <th data-column-id="pay" data-formatter="pay" data-sortable="false" style="max-width: 10px !important">Pagar</th>
                                        </tr>
                                    </thead>
                                </table>
                            </div>
                        </div>
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding: 0; display: none" id="cajarecibos">
                            <div class="table-responsive" style="max-height: 600px; min-height: 55px">
                                <table class="table table-striped jambo_table" id="tblrecibos" style="font-size: 12px">
                                    <thead>
                                        <tr>
                                            <th data-column-id="factura" data-formatter="factura">Consecutivo</th>
                                            <th data-column-id="cuota">Cuota No.</th>
                                            <th data-column-id="valorCuota" data-formatter="valorCuota">Valor de cuota</th>
                                            <th data-column-id="pagoCuota" data-formatter="pagoCuota">Abono/Pago a capital</th>
                                            <th data-column-id="porceInteres" data-formatter="porceInteres">Porcentaje mora</th>
                                            <th data-column-id="pagoInteres" data-formatter="pagoInteres">Abono/Pago a interes</th>
                                            <th data-column-id="porceInterescre" data-formatter="porceInterescre">Porcentaje credito </th>
                                            <th data-column-id="valorIva" data-formatter="valorIva">Pago iva </th>
                                            <th data-column-id="Interes_credito" data-formatter="Interes_credito">Interes corriente</th>
                                            <th data-column-id="totalpagado" data-formatter="totalpagado">Total pagado</th>
                                        </tr>
                                    </thead>
                                </table>
                            </div>
                        </div>

                        <div class="col-lg-2 col-md-2 col-sm-12 col-xs-12 sn-padding pull-right">
                            <div class="form-group">
                                <label for="m_valorCliente" class="active">Valor:</label>
                                <input id="m_valorCliente" type="text" class="form-control addart" value="0.00" placeholder=" " money="false" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="0" />
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 sn-padding pull-right">
                            <div class="form-group">
                                <label for="ds_concepto" class="active">Concepto de Descuento:</label>
                                <div class="input-group ">
                                    <input type="hidden" id="id_conceptoDscto" value="0" />
                                    <input type="hidden" id="isDescuentoDscto" value="1" />
                                    <input type="text" class="form-control inputsearch" placeholder=" " readonly="readonly" id="ds_conceptoDscto" aria-describedby="sizing-addon1" />
                                    <span class="input-group-addon ">
                                        <button type="button" class="btn btn-primary btnsearch" data-search="Productos" data-method="ConceptosList" data-title="Conceptos" data-select="1,3" data-column="id,codigo,nombre" data-fields="id_conceptoDscto,ds_conceptoDscto" data-params="esDesc,isDescuentoDscto">
                                            <i class="fa fa-fw fa-search"></i>
                                        </button>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-8 col-md-8 col-sm-12 col-xs-12 pull-right" style="margin-top: 30px; margin-bottom: 15px">
                    <div class="table-responsive" style="border: none;">
                        <div class="col-lg-3 col-md-3 col-xs-12 col-sm-12" style="border-bottom: 1px solid #e7eaec;">
                            <div class="ibox-content codvalue text-right">
                                <h1 id="mtotal_cliente" class="no-margins totales">$ 0.00</h1>
                                <span class="font-bold text-navy">Total Recaudo</span>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-3 col-xs-12 col-sm-12" style="border-bottom: 1px solid #e7eaec;">
                            <div class="ibox-content codvalue text-right">
                                <h1 id="mtotaldesct_cliente" class="no-margins totales">$ 0.00</h1>
                                <span class="font-bold text-navy">Dscto Recaudo</span>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-3 col-xs-12 col-sm-12" style="border-bottom: 1px solid #e7eaec;">
                            <div class="ibox-content codvalue text-right">
                                <h1 id="mtotal_concepto" class="no-margins totales">$ 0.00</h1>
                                <span class="font-bold text-navy">Total Conceptos</span>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-3 col-xs-12 col-sm-12" style="border-bottom: 1px solid #e7eaec;">
                            <div class="ibox-content codvalue text-right">
                                <h1 id="mtotal" class="no-margins totales">$ 0.00</h1>
                                <span class="font-bold text-navy">Total</span>
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
                                                <th data-column-id="estado">Estado</th>
                                                <th data-column-id="id">Consecutivo</th>
                                                <th data-column-id="cliente">Cliente</th>
                                                <th data-column-id="valorcliente" data-formatter="valorcli" data-sortable="false" data-class="text-right">Valor Cartera</th>
                                                <%--   <th data-column-id="valorconcepto" data-formatter="valor" data-sortable="false" data-class="text-right">Valor Conceptos</th>--%>
                                                <th data-column-id="rever" data-formatter="rever" data-sortable="false">Revertir</th>
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

        <div class="modal fade" id="Modalcuotas">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h2 class="modal-title">Cuotas de Factura <span id="numFactura"></span></h2>
                        <h2 id="facturanro"></h2>
                        <input type="hidden" id="idfactura" value="0" />
                        <input type="hidden" id="vlrpagar" value="0" />
                        <input type="hidden" id="mtotalclienteTemp" value="0" />
                        <input type="hidden" id="porceinteres" value="0" />
                    </div>
                    <div class="modal-body clearfix" style="margin-bottom: 0; padding-top: 0 !important">
                        <div class="row">
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding: 5px;">
                                <div class="table-responsive" style="max-height: 300px">
                                    <table class="table table-striped jambo_table" id="tblcuotasxfact">
                                        <thead>
                                            <tr>
                                                <th data-column-id="estado" data-formatter="state" style="max-width: 30px">LO</th>
                                                <th data-column-id="cuota">Cuota</th>
                                                <th data-column-id="vlrcuota" data-formatter="vlrcuota">Valor de Cuota</th>
                                                <th data-column-id="abono" data-formatter="abono">Abono</th>
                                                <th data-column-id="saldo" data-formatter="saldo">Saldo</th>
                                                <th data-column-id="vencimiento_cuota">Vencimiento</th>
                                                <th data-column-id="diasdevenci">Dias vencidos</th>
                                                <th data-column-id="interes" data-formatter="interes">Int. Mora</th>
                                                <th data-column-id="Causacion" data-formatter="Causacion">Causar</th>
                                            </tr>
                                        </thead>
                                    </table>
                                </div>
                            </div>
                        </div>

                        <div class="row buttonaction " style="margin-top: 1px">
                            <div class="col-lg-3  col-md-3 col-xs-12 col-sm-12 pull-right" style="padding-left: 12%">
                                <button title="Guardar" id="btnAdd" data-option="F" class="btn btn-outline btn-primary dim waves-effect waves-light" type="button"><i class="fa fa-paste"></i></button>
                                <button title="Cancelar" id="btnCan" class="btn btn-outline btn-danger  dim waves-effect waves-light" data-dismiss="modal" aria-label="Close" type="button"><i class="fa-file-o fa"></i></button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%--fomas de pagos --%>
        <div class="modal fade" id="ModalFormas">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h2 class="modal-title">Pagos</h2>
                    </div>
                    <div class="modal-body clearfix" style="margin-bottom: 0; padding-top: 0 !important">
                        <div class="row">

                            <div id="pagoContado" class="col-lg-12">
                                <h3 style="text-align: center">Detalle de pago decontado</h3>
                                <div class="col-lg-3 col-md-3 col-sm-3 col-xs-6 sn-padding">
                                    <div class="form-group">
                                        <label for="cd_formapago" class="active">Forma de Pago:</label>
                                        <select runat="server" clientidmode="static" id="cd_formapago" class="form-control selectpicker" data-size="8">
                                        </select>
                                    </div>
                                </div>
                                <div class="col-lg-3 col-md-3 col-sm-3 col-xs-6 sn-padding">
                                    <div class="form-group">
                                        <label for="valorforma" class="active">Valor</label>
                                        <input type="text" class="form-control" id="valorforma" money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="0" data-v-max="999999999999.99" value="0" data-a-sign="$ " />
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-4 col-sm-3 col-xs-6 sn-padding">
                                    <div class="form-group">
                                        <label for="voucher" class="active">Voucher</label>
                                        <input type="text" class="form-control" id="voucher" />
                                    </div>
                                </div>
                                <div class="col-lg-1 col-md-1 col-sm-1 col-xs-6 sn-padding">
                                    <button id="addPago" type="button" class="btn btn-sin btn-circle addarticle" title="Agregar"><i class="fa fa-money"></i></button>
                                </div>
                                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding: 10px;">
                                    <div class="table-responsive" style="max-height: 200px">
                                        <table class="table table-striped text-center" id="tblpagosDoc">
                                            <thead>
                                                <tr>
                                                    <th data-column-id="id" data-formatter="delete" data-sortable="false" style="max-width: 30px !important;">#</th>
                                                    <th data-column-id="tipo">Tipo</th>
                                                    <th data-column-id="valor" data-formatter="valor" data-sortable="false" data-class="text-right">Valor</th>
                                                    <th data-column-id="voucher">Voucher</th>
                                                </tr>
                                            </thead>
                                            <tbody id="tbdpagos">
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-12" style="margin-top: 10%;">

                            <div class="col-lg-3 col-md-4 col-xs-4 col-sm-3  sn_padding sn_padding NOcredito" style="border-bottom: 1px solid #e7eaec;">
                                <div class="ibox-content codvalue text-right">
                                    <h4 id="Ttotalfac" class="no-margins" style="font-weight: bold">$ 0.00</h4>
                                    <span class="font-bold text-navy">Total Documento</span>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-4 col-xs-4 col-sm-3 sn_padding NOcredito" style="border-bottom: 1px solid #e7eaec;">
                                <div class="ibox-content codvalue text-right">
                                    <h4 id="Tpagado" class="no-margins">$ 0.00</h4>
                                    <span class="font-bold text-navy">Pagado</span>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-xs-4 col-sm-3 sn_padding NOcredito" style="border-bottom: 1px solid #e7eaec; margin-bottom: 4px;">
                                <div class="ibox-content codvalue text-right">
                                    <h4 id="Tcambio" class="no-margins">$ 0.00</h4>
                                    <span class="font-bold text-navy">Cambio</span>
                                </div>
                            </div>
                        </div>

                        <div class="row buttonaction pull-right">
                            <div class="col-lg-12  col-md-12 col-xs-12 col-sm-12">
                                <button title="Guardar" id="btnFact" data-option="F" class="btn btn-outline btn-primary dim waves-effect waves-light" type="button"><i class="fa fa-paste"></i></button>
                                <button title="Cancelar" id="btnCance" class="btn btn-outline btn-danger  dim waves-effect waves-light" data-dismiss="modal" aria-label="Close" type="button"><i class="fa-file-o fa"></i></button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <input type="hidden" id="newId" value="0" />
        <script src="../Pages/ScriptsPage/Financiero/RecaudoCartera.js"></script>
        <script>
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
