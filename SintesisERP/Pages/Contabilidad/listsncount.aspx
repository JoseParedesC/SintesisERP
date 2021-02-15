<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="listsncount.aspx.cs"
    Inherits="listsncount" MasterPageFile="~/Masters/SintesisMaster.Master" %>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPage" runat="server">
    <script type="text/javascript">
        window.appPath = "<%=Request.ApplicationPath%>";
    </script>
    <style>
        .icheckbox_square-green, .iradio_square-green {
            width: 24px !important;
            height: 24px !important;
            border: 1px solid #fff;
            margin-top: 3px !important;
            margin-bottom: 3px !important;
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
    <input type="hidden" id="id_devolucion" value="0" />
    <input type="hidden" id="id_devoluciontemp" value="0" />
    <div class="row" style="margin-left: 0;">
        <div class="x_panel">
            <div class="x_title col-lg-5 col-md-5 col-sm-7 col-xs-12">
                <h1 class="title-master" style="margin-top: 0;"><span class="fa fa-level-up fa-fw"></span>Documentos sin Contabilizar</h1>
                <div class="clearfix"></div>
            </div>
            <div class="col-lg-7 col-md-7 col-sm-5 col-xs-12 Botns">
                <button title="Guardar" id="btnSave" class="btn btn-outline btn-primary dim waves-effect waves-light pull-right btn-loading-state" style="margin-right: 34px !important;" data-loading-text="<i class='fa fa-spinner fa-spin'></i>" type="button"><i class="fa fa-archive"></i></button>
            </div>
        </div>
    </div>


    <div class="card" id="diventrada" style="padding-bottom: 30px;">
        <div class="row" style="margin: 0px 10px;">
            <div id="idvdevent">


                <div class="col-lg-3 col-md-3 sn-padding">
                    <div class="form-group">
                        <label for="Text_Fecha" class="active">Rango de Fecha:</label>
                        <div class="form-group">
                            <div class="btn col-sm-12" id="Text_Fecha" data-idfstar="startDate" data-idfend="endDate" current="true" daterange="true" format="YYYY-MM-DD" min="2019-09-01" max="true" style="border-bottom: 1px solid #D2D2D2; padding: 11px 0px 0px 0px; -webkit-box-shadow: none; width: 100%; min-height: 24px">
                                <span class="thin uppercase hidden-xs" style="width: 100% !important; float: left !important; text-align: left; font-size: 12.5px; display: block !important;"></span>
                            </div>
                        </div>
                    </div>
                    <input type="hidden" id="startDate" />
                    <input type="hidden" id="endDate" />
                </div>
                <div class="col-lg-1 col-md-1 col-sm-2 col-xs-12 sn-padding">
                    <button title="Actualizar" id="btnRefreshTer" class="btn btn-outline btn-primary dim waves-effect waves-light" style="margin-top: 20px;" type="button"><i class="fa fa-refresh"></i></button>
                </div>
            </div>
            <div id="divfact">
            </div>
        </div>

        <div class="row" style="margin: 0 10px;" id="divaddart" data-serie="false" data-inventario="false">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding: 0">
                <div class="table-responsive" style="max-height: 600px; min-height: 250px">
                    <table class="table table-striped jambo_table" id="tblcommodity">
                        <thead>
                            <tr>
                                <th data-formatter="select" data-column-id="id" data-columntext="html" data-sortable="false">
                                    <div class="check-mail">
                                        <input type="checkbox" class="i-checks pull-right" id="allcheck" />
                                    </div>
                                </th>
                                <th data-column-id="tipodocumento">Tipo documento</th>
                                <th data-column-id="id">id</th>
                                <th data-column-id="fecha">Fecha</th>
                                <th data-column-id="factura">Factura</th>
                                <th data-column-id="total" data-formatter="total">Total Documento</th>

                            </tr>
                        </thead>
                    </table>
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

    <div class="modal fade" id="ModalEntrada">
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
                                <table class="table table-striped jambo_table" id="tblentradas">
                                    <thead>
                                        <tr>
                                            <th data-column-id="id" data-formatter="edit" data-sortable="false" style="max-width: 30px !important;">Ver</th>
                                            <th data-column-id="estado">Estado</th>
                                            <th data-column-id="id">Consecutivo</th>
                                            <th data-column-id="fechadocumen">Fecha</th>
                                            <th data-column-id="fechafactura">Fecha Factura</th>
                                            <th data-column-id="numfactura">Factura</th>
                                            <th data-column-id="proveedor">Proveedor</th>
                                            <th data-column-id="valor" data-formatter="valor" data-sortable="false" data-class="text-right">Valor</th>
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

    <script src="../Package/Vendor/js/plugins/Autocomplete/jquery.autocomplete.js"></script>
    <script src="../Package/Vendor/js/plugins/daterangepicker/daterangepicker.js"></script>
    <script src="../Pages/ScriptsPage/Contabilidad/listsncount.js?1"></script>
    <script>
        $(document).ready(function () {
            $('.i-checks').iCheck({
                checkboxClass: 'icheckbox_square-green',
                radioClass: 'iradio_square-green',
            });
            daterangepicker()
            $('select').selectpicker();
            $("[money]").each(function (i, control) {
                $(control).autoNumeric('init');
            });
        })
    </script>
</asp:Content>
