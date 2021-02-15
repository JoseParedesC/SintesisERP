<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="historialSol.aspx.cs"
    Inherits="historialSol" MasterPageFile="~/Masters/SintesisMaster.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPage" runat="server">
    <script type="text/javascript">
        window.appPath = "<%=Request.ApplicationPath%>";
    </script>
    <link href="../Package/Vendor/css/plugins/logscroll/style-albe-timeline.css" rel="stylesheet" />

    <style>
        .nav > li > a:focus, .nav > li > a:hover {
            background-color: #1c84c6cf !important
        }
        .nav-tabs > li > a {
                color: black !important;
        }

        div.contact p {
            color: #000000ed;
            width: 140PX;
            white-space: nowrap;
            text-overflow: ellipsis;
            overflow: hidden;
        }



        div.contact span.trash {
            position: absolute;
            right: 25px;
            font-size: 20px;
            top: 1px;
            z-index: 1000;
        }

            div.contact span.trash i:hover {
                color: #f5b6b6;
                cursor: pointer;
            }

        div.contact {
            padding: 8px;
            border-radius: .5em;
            color: #fff;
            box-shadow: 0 4px 8px 0 rgba(20, 197, 236, 0.2), 0 6px 20px 0 rgba(121, 148, 220, 0.23);
        }

        .bg-info {
            background-color: #e6e9ec00 !important;
            margin-top: 10px;
        }


        div.contact img {
            display: block;
            max-width: 100px;
            height: 100px;
            border-radius: 50%;
        }

        .contact p {
            word-break: break-all;
            word-wrap: break-word;
            font-size: 13px;
        }
    </style>

    <div class="row" style="margin: 0px 10px;">
        <div class="x_panel">
            <div class="x_title">
                <h1 class="title-master" style="margin-top: 0;"><span class="fa fa-bullhorn fa-fw"></span>Historial de Solicitudes</h1>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>

    <div class="card" id="diventrada">
        <div class="row" style="margin: 0px 10px;">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <div class="table-responsive ">
                    <table class="table table-striped jambo_table" id="tbltipo">
                        <thead>
                            <tr>
                                <th data-column-id="ver" data-formatter="ver" data-sortable="false" style="max-width: 30px !important;">Ver</th>
                                <th data-column-id="consecutivo">Consecutivo</th>
                                <th data-column-id="fecha">Fecha</th>
                                <th data-column-id="identificacion">Identificación</th>
                                <th data-column-id="cliente">Cliente</th>
                                <th data-column-id="asesor">Asesor</th>
                                <th data-column-id="estado">Estado</th>
                            </tr>
                        </thead>
                    </table>
                </div>
            </div>
        </div>
    </div>



    <div class="modal fade" id="ModalSolicitud">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h2 class="modal-title">Detalle de Solicitudes</h2>
                </div>
                <div class="modal-body clearfix" style="margin-bottom: 0;">


                    <div class="hidden" id="id_solicitud" value="0"></div>
                    <button title="Imprimir" style="margin-top: -7px !important; margin-bottom: 0px !important;" id="btnPrint" data-option="I" class="btn btn-outline btn-info dim pull-right" type="button">
                        <i class="fa fa-print"></i>
                    </button>
                    <ul class="nav nav-tabs" id="myTab" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link active" id="nav1" data-toggle="tab" href="#collapseOne" role="tab" aria-controls="collapseOne" aria-selected="true">Info Cotización</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="nav2" data-toggle="tab" href="#collapsetwo" role="tab" aria-controls="collapsetwo" aria-selected="false">Productos</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="nav3" data-toggle="tab" href="#collapsethree" role="tab" aria-controls="collapsethree" aria-selected="false">Historial</a>
                        </li>
                    </ul>

                    <div class="tab-content" id="myTabContent">
                        <div class="tab-pane fade active" id="collapseOne" role="tabpanel" aria-labelledby="home-tab">

                            <div class="card card-body">
                                <div class="portlet-title">
                                    <div class="caption">
                                        <i class="fa fa-calculator fa-fw"></i>Liquidación                                                
                                    </div>
                                </div>
                                <div class="form-group">

                                    <div class="row">
                                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                            <div class="form-group">
                                                <label for="subtotal" class="active">Subtotal:</label>
                                                <input id="subtotal" type="text" placeholder=" " class="form-control" disabled="disabled" />
                                            </div>
                                        </div>
                                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                            <div class="form-group">
                                                <label for="descuento" class="active">Descuentos:</label>
                                                <input id="descuento" type="text" placeholder=" " class="form-control" disabled="disabled" />
                                            </div>
                                        </div>
                                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                            <div class="form-group">
                                                <label for="cuotaini" class="active">Cuota Inicial:</label>
                                                <input id="cuotaini" type="text" placeholder=" " class="form-control" disabled="disabled" />
                                            </div>
                                        </div>
                                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                            <div class="form-group">
                                                <label for="cuotas" class="active">N° Cuotas:</label>
                                                <input id="cuotas" type="text" placeholder=" " class="form-control" disabled="disabled" />
                                            </div>
                                        </div>
                                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                            <div class="form-group">
                                                <label for="valcuotamen" class="active">Cuota Mensual:</label>
                                                <input id="valcuotamen" type="text" placeholder=" " class="form-control" disabled="disabled" />
                                            </div>
                                        </div>
                                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                            <div class="form-group">
                                                <label for="valfinan" class="active">Financiación:</label>
                                                <input id="valfinan" type="text" placeholder=" " class="form-control" disabled="disabled" />
                                            </div>
                                        </div>
                                    </div>
                                    <br />
                                </div>
                            </div>

                            <div class="row" id="divagregados" style="margin-top: 10px !important">
                                <div class="col-lg-12">
                                    <div class="form-group">
                                        <label for="observaciones" class="active">Observaciones:</label>
                                        <textarea id="observaciones" rows="3" placeholder=" " class="form-control" style="min-height: 100px; max-height: 100px; max-width: 100%; min-width: 100%;" disabled="disabled"></textarea>
                                    </div>
                                </div>
                                <input type="hidden" value="0" id="id_solper" />
                                <div class="col-lg-12">
                                    <h3>Agregados</h3>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="collapsetwo" role="tabpanel" aria-labelledby="profile-tab">
                            <div class="card card-body">
                                <table class="table table-striped jambo_table table-responsive sidebar-collapse scrolling" id="tblArticulo" style="max-height: 250px !important;">
                                    <thead>
                                        <tr>
                                            <th class="text-center" data-column-id="nombre">Nombre</th>
                                            <th class="text-center" data-column-id="codigo">Codigo</th>
                                            <th class="text-center" data-column-id="cantidad">Cantidad</th>
                                            <th class="text-center" data-column-id="precio">Precio</th>
                                            <th class="text-center" data-column-id="iva">Iva</th>
                                            <th class="text-center" data-column-id="descuento">Descuento</th>
                                            <th class="text-center" data-column-id="total">SubTotal</th>
                                        </tr>
                                    </thead>
                                </table>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="collapsethree" role="tabpanel" aria-labelledby="contact-tab">
                            <div class="card card-body">
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                            <div class="row">
                                                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                                    <h3 class="title-master" style="margin-top: 0;"><span class="fa fa-list-alt fa-fw"></span>Historial</h3>
                                                    <div class="form-group table-responsive sidebar-collapse scrolling" style="max-height: 250px;">
                                                        <div id="myTimeline">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>










                    <div class="form-group">
                        <button type="button" class="btn btn-danger" style="margin-top: 15px; float: right !important;" id="btnconfirmar" data-dismiss="modal" aria-label="Close">
                            Cerrar
                        </button>

                    </div>

                </div>

            </div>
        </div>
    </div>




    <%--</main>--%>
    <script src="../Package/Vendor/js/plugins/logscroll/jquery-albe-timeline.min.js"></script>
    <script src="../Pages/ScriptsPage/Credito/Historialsol.js"></script>
    <script>
        $(function () {
            $('select').selectpicker();
            $('.i-checks').iCheck({
                checkboxClass: 'icheckbox_square-green',
                radioClass: 'iradio_square-green',
            });
            datepicker();
        })
    </script>
</asp:Content>
