<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Tercerointegral.aspx.cs"
    Inherits="TerceroIntegral" MasterPageFile="~/Masters/SintesisMaster.Master" %>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPage" runat="server">
    <script type="text/javascript">
        window.appPath = "<%=Request.ApplicationPath%>";
    </script>
    <link href="../Package/Vendor/css/plugins/Autocomplete/autocomplet.css" rel="stylesheet" />
    <style>
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
            background: #1ab394;
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
            <div class="x_title col-lg-5 col-md-5 col-sm- col-xs-12">
                <h1 class="title-master" style="margin-top: 0;"><span class="fa fa-level-down fa-fw"></span>Terceros Integral</h1>
                <div class="clearfix"></div>
            </div>

        </div>
    </div>

    <div class="card" id="diventrada">
        <div class="row" style="margin: 0px 10px;">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 sn-padding divarticleadd">
                <div class="col-lg-2 col-md-2 col-sm-12 col-xs-12 sn-padding">
                    <div class="form-group">
                        <label for="cd_tipoterce" class="active">Tipo de Tercero:</label>
                        <select runat="server" clientidmode="static" id="cd_tipoterce" class="form-control selectpicker" data-size="8" title="Tipo">
                        </select>
                    </div>
                </div>
                <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 sn-padding">
                    <div class="form-group">
                        <label for="Text_Nombre" class="active">Terceros</label>
                        <div class="input-group ">
                            <input type="hidden" id="cd_tercero" value="0" data-op="C" class="recalculo" />
                            <input type="hidden" id="tipotercero1" value="" />
                            <input type="text" class="form-control inputsearch" placeholder=" " readonly="readonly" id="ds_tercero" aria-describedby="sizing-addon1" />
                            <span class="input-group-addon ">
                                <button type="button" class="btn btn-primary btnsearch" data-search="CNTTerceros" data-method="CNTTercerosListTipo" data-title="Clientes / Terceros" data-select="1,2" data-column="id,tercompleto,tipo" data-fields="cd_tercero,ds_tercero" data-params="tipoter,tipotercero1">
                                    <i class="fa fa-fw fa-search"></i>
                                </button>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-2 col-md-2 col-sm-12 col-xs-12 sn-padding">
                    <div class="form-group">
                        <label for="isReca" class="active">Canceladas</label>
                        <div class="check-mail" style="margin-top: 2px">
                            <input type="checkbox" class="i-checks pull-right" id="pagadas" />
                        </div>
                    </div>
                </div>
                <div class="col-lg-2 col-md-2 col-sm-12 sn-padding">
                    <div class="form-group">
                        <label for="Text_Fecha" class="active">Fecha</label>
                        <input id="Text_Fecha" type="text" placeholder=" " class="form-control" current="true" date="true" format="YYYY-MM-DD" />
                    </div>
                </div>
                <div class="col-lg-1 col-md-1 col-sm-12 col-xs-12 sn-padding">
                    <button title="Actualizar" id="btnRefreshTer" class="btn btn-outline btn-primary dim waves-effect waves-light" style="margin-top: 10px;" type="button"><i class="fa fa-refresh"></i></button>
                </div>
            </div>
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 sn-padding divarticleadd">
                <div class="col-lg-2 col-md-3 col-sm-4 col-xs-12 sn-padding">
                    <div class="form-group">
                        <label for="cd_type" class="active">Tipo de Identificación</label>
                        <select runat="server" clientidmode="static" id="cd_type" data-size="8" class="form-control selectpicker" title="Tipo" data-live-search="true" disabled>
                        </select>
                    </div>
                </div>
                <div class="col-lg-2 col-md-3 col-sm-4 col-xs-12 sn-padding">
                    <div class="form-group">
                        <label for="pn_type" class="active">Tipo de Persona</label>
                        <select runat="server" clientidmode="static" id="pn_type" data-size="8" class="form-control selectpicker" title="Tipo" disabled>
                        </select>
                    </div>
                </div>
                <div class="col-lg-2 col-md-3 col-sm-4 col-xs-12 sn-padding">
                    <div class="form-group">
                        <label for="cd_catfiscal" class="active">Categoria fiscal</label>
                        <select runat="server" clientidmode="static" id="cd_catfiscal" data-size="8" class="form-control selectpicker" title="Categoria" data-live-search="true" disabled>
                        </select>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 col-sm-6 sn-padding">
                    <div class="form-group">
                        <label for="Text_direccion" class="active">Direccion:</label>
                        <input id="Text_direccion" type="text" placeholder=" " class="form-control" disabled />
                    </div>
                </div>
                <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12 sn-padding">
                    <div class="form-group">
                        <label for="cd_city" class="active">Ciudad</label>
                        <select runat="server" clientidmode="static" id="cd_city" data-size="8" class="form-control selectpicker" title="Ciudad" data-live-search="true" disabled>
                        </select>
                    </div>
                </div>

            </div>
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 sn-padding divarticleadd" id="divaddart">
                <div class="card" style="padding: 0px 13px">
                    <div class="row" style="margin-left: 0;">
                        <div class="x_panel">
                            <div class="x_title col-lg-5 col-md-5 col-sm-7 col-xs-12">
                                <h3 class="title-master" style="margin-top: 10px;"><span class="fa fa-bars fa-fw"></span>Listado de Facturas</h3>
                                <div class="clearfix"></div>
                            </div>

                        </div>
                    </div>
                    <div class="row" style="margin-left: 0;">
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 sn-padding">
                            <div class="table-responsive" style="max-height: 600px; min-height: 55px">
                                <table class="table table-striped jambo_table text-center" id="tblcommodity" style="font-size: 12px">
                                    <thead>
                                        <tr>
                                            <th data-column-id="estado" data-formatter="state" data-sortable="false" style="max-width: 30px">Seleccion</th>
                                            <th data-formatter="viewc" data-sortable="false">Cuotas</th>
                                            <th data-column-id="consecutivo">Consecutivo</th>
                                            <th data-column-id="fechafac">Fecha</th>
                                            <th data-column-id="total" data-formatter="total">Total Fact</th>
                                            <th data-column-id="totalcredito" data-formatter="totalcredito">Total Credito</th>
                                            <th data-formatter="ver" data-sortable="false">Ver</th>
                                        </tr>
                                    </thead>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 sn-padding divarticleadd">
                <div class="card" style="padding: 0px 13px">
                    <div class="row" style="margin-left: 0;">
                        <div class="x_panel">
                            <div class="x_title col-lg-5 col-md-5 col-sm-7 col-xs-12">
                                <h3 class="title-master" style="margin-top: 10px;"><span class="fa fa-list-ol fa-fw"></span>Listado de Cuotas / Pagos</h3>
                                <div class="clearfix"></div>
                            </div>

                        </div>
                    </div>
                    <div class="row" style="margin-left: 0;">
                        <input type="hidden" id="id_factura" value="0" />
                        <input type="hidden" id="id_cuenta" value="0" />
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 sn-padding" id="cliente">
                            <div class="table-responsive" style="max-height: 600px; min-height: 55px">
                                <table class="table table-striped jambo_table" id="tblcuotas">
                                    <thead>
                                        <tr>
                                            <th data-column-id="tipodocumento">Tipo de Documento</th>
                                            <th data-column-id="nrodocumento">Numero de Documento</th>
                                            <th data-column-id="FECHADCTO">Fecha de Documento</th>
                                            <th data-formatter="ver" data-sortable="false">Ver</th>
                                        </tr>
                                    </thead>
                                </table>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 sn-padding divarticleadd">
                <div class="table-responsive" style="border: none;">
                    <div class="col-lg-12 col-md-12 col-xs-12 col-sm-12" style="border-bottom: 1px solid #e7eaec;">
                        <div class="ibox-content codvalue text-left">
                            <h1 id="saldoactual" class="no-margins totales">$ 0.00</h1>
                            <span class="font-bold text-navy">Saldo</span>
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
                                            <th data-column-id="cuota">Cuota</th>
                                            <th data-column-id="vlrcuota" data-formatter="vlrcuota">Valor de Cuota</th>
                                            <th data-column-id="abono" data-formatter="abono">Abono</th>
                                            <th data-column-id="saldo" data-formatter="saldo">Saldo</th>
                                            <th data-column-id="vencimiento_cuota">Vencimiento</th>
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
    <input type="hidden" id="newId" value="0" />
    <script src="../Pages/ScriptsPage/Contabilidad/TerceroIntegral.js?1"></script>
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
