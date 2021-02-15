<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LineasCredito.aspx.cs"
    Inherits="LineasCredito" MasterPageFile="~/Masters/SintesisMaster.Master" %>



<asp:Content ID="Content3" ContentPlaceHolderID="ContentPage" runat="server">
    <script type="text/javascript">
        window.appPath = "<%=Request.ApplicationPath%>";
    </script>

    <style>
        .autocomplete-suggestions {
            overflow-y: auto;
        }

        .autocomplete-selected {
            overflow-y: auto;
        }

        .actionautocomple {
            overflow-y: auto;
        }

        .searchclass .form-group {
            margin-bottom: 0.22px !important;
        }

        #ISIva {
            width: 20px;
            height: 20px;
        }

        #ISIvaIncluido {
            width: 20px;
            height: 20px;
        }

        .input-group {
            margin-top: -0.223px !important;
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

        .entradanumber {
            width: 100% !important;
            text-align: center;
            position: relative;
            float: right;
            margin-top: -8px;
        }
    </style>
    <input type="hidden" id="id_documento" value="0" />
    <div class="row" style="margin-left: 0;">
        <div class="x_panel">
            <div class="x_title col-lg-6 col-md-6 col-sm-7 col-xs-12">
                <h1 class="title-master" style="margin-top: 0;"><span class="fa fa-money fa-fw"></span>Lineas Credito</h1>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>
    <div class="card" id="diventrada" style="padding-bottom: 30px; padding: 10px;">
        <div class="row" style="margin: 0px 20px;">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding: 5px;">
                <div class="table-responsive" style="max-height: 300px">
                    <table class="table table-striped jambo_table" id="tbldocumentos">
                        <thead>
                            <tr>
                                <th data-column-id="id" data-formatter="edit" data-sortable="false" style="max-width: 30px !important;">Ver</th>
                                <th data-column-id="codigo">Codigo</th>
                                <th data-column-id="nombre">Nombre</th>
                                <th data-column-id="iva">Iva</th>
                                <th data-column-id="Porcentaje">Porcentaje</th>
                                <th data-column-id="delete" data-formatter="delete" data-sortable="false" style="max-width: 30px">Eliminar</th>
                            </tr>
                        </thead>
                    </table>
                </div>
            </div>
        </div>

        <span class="fa-stack fa-lg pull-right goTop iconnew">
            <i class="fa fa-circle fa-stack-2x"></i>
            <i class="fa fa-plus fa-stack-1x fa-inverse"></i>
        </span>

        <div class="modal fade" id="ModalDocumento">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <input type="hidden" id="tipo" value="TERCE" />
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h2 class="modal-title">Detalles Lineas Creditos</h2>
                    </div>
                    <div class="modal-body clearfix" style="margin-bottom: 0; padding-top: 0 !important">

                        <div class="row col-lg-12">
                            <div class="col-lg-2 col-md-2 col-sm-16 col-xs-12 sn-padding">
                                <div class="form-group">
                                    <label for="codigo" class="active">Codigo:</label>
                                    <input type="text" name="codigo" id="codigo" class="form-control" autocomplete="off" placeholder=" " data-lote="false" data-serie="false" />
                                </div>
                            </div>

                            <div class="col-lg-2 col-md-2 col-sm-12 col-xs-12 sn-padding">
                                <div class="form-group">
                                    <label for="nombre" class="active">Nombre:</label>
                                    <input type="text" name="nombre" id="nombre" class="form-control" placeholder=" " data-lote="false" data-serie="false" />
                                </div>
                            </div>

                            <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 sn-padding searchclass">
                                <div class="form-group">
                                    <label for="Text_Nombre" class="active">Cuenta Credito:</label>

                                    <input type="hidden" id="id_ctaantCredito" value="CRED" />
                                    <input type="text" class="form-control actionautocomple inputsearch" id="id_AccountBox1" aria-describedby="sizing-addon1" data-search="Bodegas" data-method="BodegasBuscador" data-params="op:K;o:#;tipo:CRED" data-result="value:name;data:id" data-idvalue="id_ctaantCredito" />
                                </div>
                            </div>

                            <div class="col-lg-2 col-md-2 col-sm-12 col-xs-12 sn-padding">
                                <div class="form-group">
                                    <label for="Porcentaje" class="active">% Porcentaje:</label>
                                    <input id="txtporcentaje" type="text" class="form-control addart" placeholder=" " value="0.00" money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="0" data-v-max="100" data-a-sign="% " />
                                </div>
                            </div>

                            <div class="col-lg-2 col-md-2 col-sm-12 col-xs-12 sn-padding">
                                <div class="form-group">
                                    <label for="Text_Porcentaje" class="active">% Tasa anual:</label>
                                    <input type="text" class="form-control" id="TasaAnual" placeholder=" " money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-max="100" data-v-min="0" data-a-sign="% " />
                                </div>
                            </div>

                        </div>
                        <div class="row col-lg-12">

                            <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 sn-padding">
                                <div class="form-group">
                                    <label for="Text_Nombre" class="active">Cuenta Int mora:</label>
                                    <input type="hidden" id="id_ctaantIntMora" value="ANT" />
                                    <input type="text" class="form-control actionautocomple inputsearch" id="id_AccountBox3" aria-describedby="sizing-addon1" data-search="Bodegas" data-method="BodegasBuscador" data-params="op:B;o:#;tipo:ANT" data-result="value:name;data:id" data-idvalue="id_ctaantIntMora" />
                                </div>
                            </div>


                            <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 sn-padding searchclass">
                                <div class="form-group">
                                    <label for="Text_Nombre" class="active">Cuenta Int Corriente:</label>
                                    <input type="hidden" id="id_ctaantIntCorri" value="ANT" />
                                    <input type="text" class="form-control actionautocomple inputsearch" id="id_AccountBox2" aria-describedby="sizing-addon1" data-search="Bodegas" data-method="BodegasBuscador" data-params="op:B;o:#;tipo:ANT" data-result="value:name;data:id" data-idvalue="id_ctaantIntCorri" />
                                </div>
                            </div>


                            <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 sn-padding">
                                <div class="form-group">
                                    <label for="Text_Nombre" class="active">Cuenta Fianza:</label>
                                    <input type="hidden" id="id_ctaantFianza" value="ANT" />
                                    <input type="text" class="form-control actionautocomple inputsearch" id="id_AccountBox4" aria-describedby="sizing-addon1" data-search="Bodegas" data-method="BodegasBuscador" data-params="op:B;o:#;tipo:ANT" data-result="value:name;data:id" data-idvalue="id_ctaantFianza" />
                                </div>
                            </div>
                        </div>

                        <div class="row col-lg-12">
                            <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12  sn-padding">
                                <div class="form-group">
                                    <label for="ISIva" class="active">Iva?</label>
                                    <div class="check-mail">
                                        <input type="checkbox" class="i-checks pull-right" id="ISIva" />
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12  sn-padding">
                                <div class="form-group">
                                    <label for="ISIvaa" class="active">Iva Incluido</label>
                                    <div class="check-mail">
                                        <input type="checkbox" class="i-checkss pull-right" id="ISIvaIncluido" />
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
                                <div class="form-group">
                                    <label for="Text_Nombre" class="active">Cuenta Iva:</label>
                                    <input type="hidden" id="id_iva" value="ANT" />
                                    <input type="text" class="form-control actionautocomple inputsearch" id="button2" aria-describedby="sizing-addon1" data-search="Bodegas" data-method="BodegasBuscador" data-params="op:B;o:#;tipo:ANT" data-result="value:name;data:id" data-idvalue="id_iva" />
                                </div>
                            </div>

                            <div class="col-lg-2 col-md-2 col-sm-12 col-xs-12">
                                <div class="form-group">
                                    <label for="PorcentajeIVA" class="active">% Porcentaje Iva:</label>
                                    <input id="txtporcenIva" type="text" class="form-control addart" placeholder=" " value="1.19" money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="0" data-v-max="100" data-a-sign="% " />
                                </div>
                            </div>
                        </div>

                        <div class="row col-lg-12" id="mostrar">
                            <br />
                            <div class="col-lg-3 col-md-4 col-sm-12 col-xs-12 sn-padding">
                                <div class="form-group">
                                    <label for="id_forma" class="active">Servicios financieros </label>
                                    <select runat="server" clientidmode="static" id="id_forma" data-size="8" class="form-control selectpicker" title="Seleccione" data-live-search="true">
                                    </select>
                                </div>
                            </div>
                            <div class="col-lg-2 col-md-2 col-sm-4 col-xs-12 sn-padding">
                                <div class="form-group">
                                    <label for="Text_Porcentaje" class="active">Porcentaje:</label>
                                    <input type="text" class="form-control" id="Text_Porcentaje" placeholder=" " money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-max="100" data-v-min="0" data-a-sign="% " />
                                </div>
                            </div>

                            <div class="col-lg-3 col-md-4 col-sm-3 col-xs-12">
                                <button title="Agregar" id="addServicio" class="btn btn-outline btn-primary dim  pull-right" type="button" data-id="0" data-idbodega="0" style="margin-bottom: 0 !important; margin-top: 15px; float: left !important;"><i class="fa fa-plus"></i></button>
                            </div>

                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding-top: 5px; padding-bottom: 15px; padding-left: 2px;">
                                <div class="table-responsive">
                                    <table class="table table-striped jambo_table" id="tblServicios">
                                        <thead>
                                            <tr>
                                                <th data-column-id="edit" data-formatter="edit" data-sortable="false" style="max-width: 30px !important;">Editar</th>
                                                <th data-column-id="Servicios">Servicios</th>
                                                <th data-column-id="porcentaje">Porcentaje</th>
                                                <th data-column-id="delete" data-formatter="delete" data-sortable="false" style="max-width: 30px">Eliminar</th>
                                            </tr>
                                        </thead>
                                    </table>
                                </div>
                            </div>
                        </div>


                        <div class="row buttonaction pull-right">
                            <button title="Guardar" id="btnSave" data-id="0" data-option="I" class="btn btn-outline btn-primary dim" type="button"><i class="fa fa-paste"></i></button>
                            <button title="Cancelar" id="btnCance" class="btn btn-outline btn-danger  dim waves-effect waves-light" data-dismiss="modal" aria-label="Close" type="button"><i class="fa-file-o fa"></i></button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>



    <script src="../Package/Vendor/js/plugins/Autocomplete/jquery.autocomplete.js"></script>
    <script src="../Pages/ScriptsPage/Financiero/LineasCreditos.js"></script>
    <script>
        $(document).ready(function () {
            datepicker();
            $("[money]").each(function (i, control) {
                $(control).autoNumeric('init');
            });
        });

    </script>
</asp:Content>




