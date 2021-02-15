<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NotasCartera.aspx.cs"
    Inherits="NotasCartera" MasterPageFile="~/Masters/SintesisMaster.Master" %>

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

        #diventrada .icheckbox_square-green {
            height: 38px;
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
            background: #1C84C6;
            color: #fff;
            text-align: center;
             margin-top: 17px;   
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
            <div class="x_title col-lg-5 col-md-5 col-sm-7 col-xs-12">
                <h1 class="title-master" style="margin-top: 0;"><span class="fa fa-level-down fa-fw"></span>Notas Cartera</h1>
                <div class="clearfix"></div>
            </div>
            <div class="col-lg-7 col-md-7 col-sm-5 col-xs-12 Botns">
                <input type="hidden" id="id_nota" value="0" class="datosid" />
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
            <div class="col-lg-2 col-md-3 col-sm-12 sn-padding">
                <div class="form-group">
                    <label for="cd_tipodoc" class="active">Tipo de Documento:</label>
                    <select runat="server" clientidmode="static" id="cd_tipodoc" class="form-control selectpicker" data-size="8">
                    </select>
                </div>
            </div>
            <div class="col-lg-2 col-md-3 col-sm-12 col-xs-12  sn-padding">
                <div class="form-group">
                    <label for="Text_Nombre" class="active">Centro Costo</label>
                    <input type="hidden" id="id_ccostos" value="0" class="datosid" />
                    <input type="hidden" id="isofDetalle" value='true' />
                    <input type="text" class="form-control actionautocomple inputsearch" id="codigoccostos" aria-describedby="sizing-addon1" data-search="Bodegas" data-method="BodegasBuscador" data-params="op:F;o:#" data-result="value:name;data:id" data-idvalue="id_ccostos" />
                </div>
            </div>
            <div class="col-lg-2 col-md-3 col-sm-12 sn-padding">
                <div class="form-group">
                    <label for="Text_Fecha" class="active">Fecha Doc:</label>
                    <input id="Text_Fecha" type="text" placeholder=" " class="form-control" current="true" date="true" format="YYYY-MM-DD" />
                </div>
            </div>
            <div class="col-lg-2 col-md-3 col-sm-12 col-xs-12 sn-padding">
                <div class="form-group">
                    <label for="cd_tipoterce" class="active">Tipo de Tercero:</label>
                    <select runat="server" clientidmode="static" id="cd_tipoterce" class="form-control selectpicker" data-size="8" title="Tipo">
                    </select>
                </div>
            </div>
            <div class="col-lg-2 col-md-3 col-sm-12 col-xs-12 sn-padding">
                <div class="form-group">
                    <label for="Text_Nombre" class="active">Terceros</label>
                    <input type="hidden" id="cd_tercero" value="0" data-op="C" class="recalculo datosid" />
                    <input type="hidden" id="tipotercero1" value="" />
                    <input type="text" class="form-control actionautocomple inputsearch" id="ds_cliente" aria-describedby="sizing-addon1" data-search="Bodegas" data-method="BodegasBuscador" data-params="op:T;o:#" data-result="value:name;data:id" data-idvalue="cd_tercero" />
                </div>
            </div>
            <div class="col-lg-2 col-md-3 col-sm-12 col-xs-12 sn-padding">
                <div class="form-group">
                    <label for="Text_Nombre" class="active">Facturas</label>
                    <input type="hidden" id="cd_factura" value="0" class="datosid" />
                    <input type="hidden" id="fechadoc" value="" />
                    <input type="text" class="form-control actionautocomple inputsearch" id="ds_factura" aria-describedby="sizing-addon1" data-search="Bodegas" data-method="BodegasBuscador" data-params="op:I;o:#;id_bodega:#;tipo:#" data-result="value:name;data:id" data-idvalue="cd_factura" />
                </div>
            </div>
              <div class="col-lg-12 col-md-10 col-sm-12 col-xs-12  sn-padding">
                <hr class="hrseparator" style="margin-top: 10px; margin-bottom: 10px" />
            </div>
            <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12  ">
                <div class="form-group">
                    <label for="Text_cuenta" class="active">Cuenta Asignada</label>
                    <input type="hidden" id="id_cuentaant" value="0" class="datosid" />
                    <input name="Text_cuenta" type="text" class="form-control" id="Text_cuenta" disabled />
                </div>
            </div>
            <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 ">
                <div class="form-group">
                    <label for="Text_Nombre" class="active">Cuenta Contable</label>
                    <input type="hidden" id="tipo" value="" />
                    <input type="hidden" id="id_ctacon" value="0" class="datosid" />
                    <input type="text" class="form-control actionautocomple inputsearch" id="ds_ctacon" aria-describedby="sizing-addon1" data-search="Bodegas" data-method="BodegasBuscador" data-params="op:F;o:#;id_bodega:#;tipo:#" data-result="value:name;data:id" data-idvalue="id_ctacon" />
                </div>
            </div>
            <div class="col-lg-2 col-md-2 col-sm-6 col-xs-6 ">
                <div class="form-group">
                    <label for="m_saldo" class="active">Saldo Actual:</label>
                    <input id="m_saldo" type="text" class="form-control addart" value="0.00" placeholder=" " money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="0" data-a-sign="$ " disabled />
                </div>
            </div>
            <div class="col-lg-2 col-md-2 col-sm-6 col-xs-6">
                <div class="form-group">
                    <label for="m_interes" class="active">Intereses X Mora:</label>
                    <input id="m_interes" type="text" class="form-control addart" value="0.00" placeholder=" " money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="0" data-a-sign="$ " disabled />
                </div>
            </div>
            <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                <div class="form-group">
                    <label for="ischange" class="active">Cambiar fecha ?</label>
                    <div class="check-mail" style="margin-top: 2px">
                        <input type="checkbox" class="i-checks pull-right" id="ischange" />
                    </div>
                </div>
            </div>
            <div class="col-lg-2 col-md-3 col-sm-6 col-xs-12">
                <div class="form-group">
                    <label for="id_tipoven" class="active">Tipo Venc:</label>
                    <select runat="server" clientidmode="static" id="id_tipoven" data-size="8" class="form-control selectpicker" title="Seleccione" data-live-search="true">
                    </select>
                </div>
            </div>
            <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                <div class="form-group">
                    <label for="nrodias" class="active">N° Días:</label>
                    <input type="text" class="form-control" id="nrodias2" money="true" data-a-dec="." data-a-sep="," data-m-dec="0" data-v-min="1" data-v-max="99" value="1" data-a-sign="" />
                </div>
            </div>
            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                <div class="form-group">
                    <label for="Text_FechaVenIni2" class="active">Fecha:</label>
                    <input type="hidden" id="cuotanro" value="0" class="datosid" />
                    <input type="hidden" id="cantcuotas" value="0" class="datosid" />
                    <input id="Text_FechaVenIni2" type="text" placeholder=" " class="form-control" current="true" date="true" format="YYYY-MM-DD" disabled />
                </div>
            </div>
            <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                <div class="form-group">
                    <label for="ischange" class="active">N° Cuotas ?</label>
                    <div class="check-mail" style="margin-top: 2px">
                        <input type="checkbox" class="i-checks pull-right" id="isNcuota" disabled />
                    </div>
                </div>
            </div>
            <div style="display: none" id="pagoCredito">
                <div class="col-lg-1 col-md-2 col-sm-2 col-xs-12">
                    <div class="form-group">
                        <label for="valorforma" class="active">N° Cuotas:</label>
                        <input type="text" class="form-control" id="nrocuotas2" money="true" data-a-dec="." data-a-sep="," data-m-dec="0" data-v-min="1" data-v-max="36" value="1" data-a-sign="" />
                    </div>
                </div>


            </div>
            <div class="col-lg-11 col-md-10 col-sm-12 col-xs-12 ">
                <div class="form-group">
                    <label for="descripcion" class="active">Detalle:</label>
                    <textarea id="descripcion" max-length="1000" class="form-control" placeholder="Detalle" style="display: block; min-height: 40px !important; width: 100% !important; max-width: 100%; min-width: 100%; max-height: 40px"></textarea>
                </div>
            </div>
            <div class="col-lg-1 col-md-1 col-sm-1 col-xs-4 ">
                <button id="addPago" type="button" class="btn btn-sin btn-circle addarticle" title="Agregar"><i class="fa fa-money"></i></button>
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
                                            <th data-column-id="cuota">Cuota</th>
                                            <th data-column-id="vlrcuota" data-formatter="vlrcuota">Valor de cuota</th>
                                            <th data-column-id="vencimiento_cuota" data-formatter="vencimiento_cuota">Fecha de Vencimiento</th>
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

    <div class="modal fade" id="ModalNotas">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h2 class="modal-title">Lista de Notas de Carteras</h2>
                </div>
                <div class="modal-body clearfix" style="margin-bottom: 0; padding-top: 0 !important">
                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding: 5px;">
                            <div class="table-responsive" style="max-height: 300px">
                                <table class="table table-striped jambo_table" id="tblnotas">
                                    <thead>
                                        <tr>
                                            <th data-column-id="id" data-formatter="edit" data-sortable="false" style="max-width: 30px !important;">Ver</th>
                                            <th data-column-id="estado">Estado</th>
                                            <th data-column-id="id">Consecutivo</th>
                                            <th data-column-id="fecha">Fecha</th>
                                            <th data-column-id="nrofactura">N° Factura</th>
                                            <th data-column-id="tipotercero">Tipo de Tercero</th>
                                            <th data-column-id="tercero">Tercero</th>
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

    <input type="hidden" id="newId" value="0" />
    <script src="../Pages/ScriptsPage/Contabilidad/notascartera.js"></script>
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
