<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FacturacionElectronica.aspx.cs" Inherits="FacturacionElectronica" MasterPageFile="~/Masters/SintesisMaster.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPage" runat="server">
    <script type="text/javascript">
        window.appPath = "<%=Request.ApplicationPath%>";
    </script>
    <link href="../Package/Vendor/js/daterangepicker-master/example/daterangepicker.css" rel="stylesheet" />
    <style>
        .bot.success:after {
            content: "Filtro Facturas Enviadas";
        }

        .bot.error:after {
            content: "Filtro Facturas Erradas";
        }

        .bot.pendiente:after {
            content: "Filtro Facturas Pendientes";
        }

        .bot:after {
            font-size: 12px;
            font-weight: 700;
            letter-spacing: 1px;
            position: absolute;
            text-transform: uppercase;
            top: -1px;
            left: -1px;
            border: 1px solid #ddd;
            border-radius: 4px 0;
            padding: 3px 7px;
            color: #555;
            background-color: #f1f1f1;
            text-shadow: #fff 1px 1px 0;
            margin-left: 9px;
            margin-top: 9px;
        }

        .bot {
            border: solid 1px #ccc;
            float: left;
            position: unset;
            width: 100%;
            height: 100%;
            padding: 30px 15px 15px 15px;
            border-radius: 5px;
            background: #fff;
            border: solid 1px #ccc;
        }

        .nav.nav-tabs li.active {
            background: #5696f7d6;
        }

        .nav.nav-tabs li {
            background: #fff;
            color: #205F96 !important;
        }

            .nav.nav-tabs li.active a {
                color: #FFF !important;
            }

            .nav.nav-tabs li a {
                color: #205F96 !important;
                outline: none !important;
                border-bottom: 2px #337ab7 solid !important;
            }
    </style>

    <div class="row" style="margin-left: 0; margin-right: 0">
        <div class="x_panel">
            <div class="x_title col-lg-6 col-md-6 col-sm-7 col-xs-12 sn-padding">
                <h1 class="title-master" style="margin-top: 0;"><span class="fa icon-facturacion fa-fw iconbox"></span>Facturación Electronica</h1>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>




    <div class="row">
        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 sn-padding" id="divinfo">

            <ul class="nav nav-tabs">
                <li class="active" id="liuno"><a data-toggle="tab" href="#tab-1" id="tabuno"><i class="fa fa-user"></i>
                    <span class="hidden-xs">Enviadas</span></a></li>
                <li class="" id="lidos"><a data-toggle="tab" href="#tab-2" id="tabdos"><i class="fa fa-briefcase"></i>
                    <span class="hidden-xs">Error</span></a></li>
                <li class="" id="pend"><a data-toggle="tab" href="#tab-3" id="Pendientes"><i class="fa fa-briefcase"></i>
                    <span class="hidden-xs">Pendientes</span></a></li>
            </ul>
            <div class="tab-content">
                <div id="tab-1" class="tab-pane active ">
                    <div class="card" style="padding: 0px 13px">
                        <div class="row">
                            <div class="" style="display: block; margin: 5px 5px 10px 5px;">
                                <div class="bot success">
                                    <div class="col-lg-3 col-md-3 sn-padding">
                                        <div class="form-group">
                                            <label for="Text_Fecha2" class="active">Rango de Fecha:</label>
                                            <div class="form-group">
                                                <div class="btn col-sm-12" id="Text_Fecha" data-idfstar="startDateS" data-idfend="endDateS" current="true" daterange="true" format="YYYY-MM-DD" min="2019-10-01" max="true" style="z-index:999999; border-bottom: 1px solid #D2D2D2; padding: 11px 0px 0px 0px; -webkit-box-shadow: none; width: 100%; min-height: 24px">
                                                    <span class="thin uppercase hidden-xs" style="width: 100% !important; float: left !important; text-align: left; font-size: 12.5px; display: block !important;"></span>
                                                </div>
                                            </div>
                                        </div>
                                        <input type="hidden" id="startDateS" />
                                        <input type="hidden" id="endDateS" />
                                    </div>
                                    <div class="col-lg-2 col-md-2 sn-padding">
                                        <div class="form-group">
                                            <label for="facturaS" class="active">N° Factura:</label>
                                            <input id="facturaS" type="text" placeholder=" " class="form-control" maxlength="30" />
                                        </div>
                                    </div>
                                    <button title="Consultar" id="btnSuccess" class="btn btn-outline btn-info dim pull" type="button" style="margin-top: 15px; margin-bottom: 0 !important"><i class="fa fa-refresh"></i></button>
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding: 3px">
                                <div class="table-responsive" style="max-height: 500px">
                                    <table class="table table-striped jambo_table" id="tblfactsuccess">
                                        <thead>
                                            <tr>
                                                <th data-column-id="idcliente" data-formatter="accion" class="text-info">#</th>
                                                <th data-column-id="tipodoc">Tipo Documento</th>
                                                <th data-column-id="fecha">Fecha Factura</th>
                                                <th data-column-id="resolucion">N° Resolución</th>
                                                <th data-column-id="factura">Factura</th>
                                                <th data-column-id="cliente">Cliente</th>
                                                <th data-column-id="mail" data-formatter="mail" data-sortable="false" style="max-width: 30px !important;">Reenviar</th>
                                            </tr>
                                        </thead>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="tab-2" class="tab-pane">
                    <div class="card" style="padding: 0px 13px">
                        <div class="row">
                            <div class="" style="display: block; margin: 5px 5px 10px 5px;" id="divcabecera">
                                <div class="bot error">
                                    <div class="col-lg-3 col-md-3 sn-padding">
                                        <div class="form-group">
                                            <label for="Text_Fecha2" class="active">Rango de Fecha:</label>
                                            <div class="form-group">
                                                <div class="btn col-sm-12" id="Text_FechaE" data-idfstar="startDateE" data-idfend="endDateE" current="true" daterange="true" format="YYYY-MM-DD" min="2019-10-01" max="true" style="z-index:999999; border-bottom: 1px solid #D2D2D2; padding: 11px 0px 0px 0px; -webkit-box-shadow: none; width: 100%; min-height: 24px">
                                                    <span class="thin uppercase hidden-xs" style="width: 100% !important; float: left !important; text-align: left; font-size: 12.5px; display: block !important;"></span>
                                                </div>
                                            </div>
                                        </div>
                                        <input type="hidden" id="startDateE" />
                                        <input type="hidden" id="endDateE" />
                                    </div>
                                    <div class="col-lg-2 col-md-2 sn-padding">
                                        <div class="form-group">
                                            <label for="facturaE" class="active">N° Factura:</label>
                                            <input id="facturaE" type="text" placeholder=" " class="form-control" maxlength="20" />
                                        </div>
                                    </div>
                                    <button title="Consultar" id="btnListError" class="btn btn-outline btn-info dim pull" type="button" style="margin-top: 15px; margin-bottom: 0 !important"><i class="fa fa-refresh"></i></button>
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding: 3px" id="divlist">
                                <div class="table-responsive" style="max-height: 500px">
                                    <table class="table table-striped jambo_table" id="tblfacerror">
                                        <thead>
                                            <tr>
                                                <th data-column-id="idcliente" data-formatter="edit" class="text-info">#</th>
                                                <th data-column-id="tipodoc">Tipo Documento</th>
                                                <th data-column-id="fecha">Fecha Factura</th>
                                                <th data-column-id="resolucion">N° Resolución</th>
                                                <th data-column-id="factura">Factura</th>
                                                <th data-column-id="cliente">Cliente</th>
                                                <th data-column-id="log" data-formatter="log" data-sortable="false" style="max-width: 30px !important;">Log</th>
                                            </tr>
                                        </thead>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="tab-3" class="tab-pane ">
                    <div class="card" style="padding: 0px 13px">
                        <div class="row">
                            <div class="" style="display: block; margin: 5px 5px 10px 5px;">
                                <div class="bot pendiente">
                                    <div class="col-lg-3 col-md-3 sn-padding">
                                        <div class="form-group">
                                            <label for="Text_Fecha2" class="active">Rango de Fecha:</label>
                                            <div class="form-group">
                                                <div class="btn col-sm-12" id="Text_FechaP" data-idfstar="startDateP" data-idfend="endDateP" current="true" daterange="true" format="YYYY-MM-DD" min="2019-10-01" max="true" style="z-index:999999; border-bottom: 1px solid #D2D2D2; padding: 11px 0px 0px 0px; -webkit-box-shadow: none; width: 100%; min-height: 24px">
                                                    <span class="thin uppercase hidden-xs" style="width: 100% !important; float: left !important; text-align: left; font-size: 12.5px; display: block !important;"></span>
                                                </div>
                                            </div>
                                        </div>
                                        <input type="hidden" id="startDateP" />
                                        <input type="hidden" id="endDateP" />
                                    </div>
                                    <button title="Consultar" id="btnPendiente" class="btn btn-outline btn-info dim pull" type="button" style="margin-top: 15px; margin-bottom: 0 !important"><i class="fa fa-refresh"></i></button>
                                    <button title="Facturar" id="btnSave" class="btn btn-outline btn-primary dim  pull-right  btn-large-dim" style="width: 60px;height: 60px;font-size: 32px;" type="button"><i class="fa fa-paste"></i></button>      
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding: 3px" id="divlistP">
                                <div class="table-responsive" style="max-height: 500px">
                                    <table class="table table-striped jambo_table" id="tblfacpendietes">
                                        <thead>
                                            <tr>
                                                <th data-column-id="tipodoc">Tipo Documento</th>
                                                <th data-column-id="fecha">Fecha Factura</th>
                                                <th data-column-id="resolucion">N° Resolución</th>
                                                <th data-column-id="factura">Factura</th>
                                                <th data-column-id="cliente">Cliente</th>
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

    <div class="modal fade" id="ModalLog">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h2 class="modal-title">Detalle del Log</h2>
                </div>
                <div class="modal-body clearfix" style="margin-bottom: 0;">
                    <div class="row">
                        <input type="hidden" id="id_proce" value="" />
                        <input type="hidden" id="tipodocument" value="0" />                        
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding: 5px;">
                            <div class="table-responsive" style="max-height: 300px">
                                <table class="table table-striped jambo_table" id="tbllog">
                                    <thead>
                                        <tr>
                                            <th data-column-id="fecha">Fecha</th>
                                            <th data-column-id="codigo">Codigo de Respuesta</th>
                                            <th data-column-id="mensaje">Respuesta</th>
                                        </tr>
                                    </thead>
                                </table>
                            </div>
                        </div>
                        <div class="col-lg-12 sn-padding">
                            <button title="Cerrar" id="btnCan" data-op="C" class="btn btn-outline btn-danger  dim  pull-right" type="button" data-dismiss="modal" aria-label="Close"><i class="fa fa-minus-square-o"></i></button>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
    
    <div class="modal fade" id="ModalMail">
        <div class="modal-dialog modal-sm" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h2 class="modal-title">Detalle de Envio</h2>
                </div>
                <div class="modal-body clearfix" style="margin-bottom: 0;">
                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding: 5px;">
                            <div class="form-group">
                                <label for="ds_email" class="active">Email:</label>
                                <input class="form-control" id="ds_email" name="ds_email" type="text" />
                            </div>
                        </div>
                        <div class="col-lg-12 sn-padding">
                            <button title="Cerrar" id="btnCanc" data-op="C" class="btn btn-outline btn-danger  dim  pull-right" type="button" data-dismiss="modal" aria-label="Close"><i class="fa fa-minus-square-o"></i></button>
                            <button title="Enviar" id="btnSend" data-op="R" class="btn btn-outline btn-primary dim  pull-right" type="button"><i class="fa fa-paste"></i></button>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <%--</main>--%>
    <script>
        $(document).ready(function () {
            datepicker();
            daterangepicker();
        });
    </script>
    <script src="../Pages/ScriptsPage/Facturacion/FacturacionElectronica.js"></script>
</asp:Content>
