<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GestionCartera.aspx.cs" Inherits="GestionCartera" MasterPageFile="~/Masters/SintesisLayout.Master" %>

<%@ Register Src="~/Pages/Controles/ClienteInfo.ascx" TagName="ClienteInfo" TagPrefix="ac1" %>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPage" runat="server">
    <link href="../Package/Vendor/css/plugins/logscroll/style-albe-timeline.css" rel="stylesheet" />
    <script src="../Package/Vendor/js/plugins/logscroll/jquery-albe-timeline.min.js"></script>
    <script type="text/javascript">
        window.appPath = "<%=Request.ApplicationPath%>";
    </script>
    <style>
         .stateclientcuota {
            padding: 3px 5px;
            border-radius: 7px;
            color: #fff;
            font-weight: bold;
        }
        .statecuotasuccess{            
            background: #34E105;
        }        

        .statecuotaerror{            
            background: #B82508;
        }

        .statecuotawarning{            
            background:#e19d05;
        }        
        .fa-warning:before, .fa-exclamation-triangle:before {
            margin-left: 4px;
        }

        .btn-colorpago {
            background: #23c6c8cc;
            color: #fff;
        }

        .btn-colorinmo {
            background: #f62050e0;
            color: #fff;
        }

        .rowselection {
            background-color: #7bb7e736 !important;
            font-weight: bold !important;
            color: #000 !important;
        }

        .cuotasfac {
            display: none;
        }

        .form-group label {
            margin: 0 !important;
        }

        .nav.nav-tabs {
            margin-bottom: 10px !important;
        }

            .nav.nav-tabs li a {
                border: 1px solid #ccc;
            }

            .nav.nav-tabs li.active a {
                background-color: #0074bcf0 !important;
                color: white;
                border: none;
            }

            .nav.nav-tabs li {
                background: #fff;
                color: #0074bcf0 !important;
            }

                .nav.nav-tabs li.active a {
                    background: #0074bcf0;
                    color: #fff !important;
                }

        .diventrada .nav-tabs > li > a:hover, .nav-tabs > li > a:focus {
            background-color: #0074bcf0;
            color: #fff !important;
            opacity: 0.8;
            border: none;
        }

        .nav.nav-tabs li a {
            color: #0074bcf0 !important;
            outline: none !important;
            border: 1px solid #0074bcf0;
            width: 100%;
        }

        .form-group {
            margin-bottom: 3px;
        }

        .spanact {
            padding: 4px 10px;
            border-radius: 5px;
            color: #ffffffe6;
            font-weight: bold;
            margin-bottom: 5px;
        }

            .spanact:hover {
                cursor: pointer;
            }

        .noneclient {
            display: none;
        }

        .spanact.active {
            border: 3px solid #2580dd;
            color: #000;
        }

        .table-responsive {
            overflow-y: auto !important;
        }



        #tblClientes-header .btn-group > .btn:first-child:not(:last-child):not(.dropdown-toggle) {
            display: none;
        }
		#tblClientes tbody{
			font-size:11px !important;
		}
    </style>

    <input type="hidden" id="id_documento" value="0" />
    <input type="hidden" id="idToken" value="0" />
    <div class="wrapper " style="padding-top: 5px;">
        <div class="row" style="margin-left: 0; background: white;">
            <div class="x_panel">
                <div class="x_title col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <h1 class="title-master" style="margin-top: 8px;"><span class="fa fa-bullhorn fa-fw"></span>Gestión de Cobro</h1>
                    <div class="clearfix"></div>
                </div>
                <div id="filtro" class="col-lg-4 col-md-4 col-sm-5 col-xs-12 tablaclients" style="padding-top: 5px; padding-bottom: 15px; padding-left: 2px;">
                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 sn-padding" style="padding-left: 0px; margin-bottom: 8px;">
                        <div class="float-e-margins">
                            <div class="ibox-title" style="border: 2px solid #e7eaec; border-radius: 8px;">
                                <span runat="server" clientidmode="static" class="label label-success pull-right" id="countclient" style="font-size: 14px;">0</span>
                                <h5><span class="fa fa-file-text-o fa-fw" style="font-size: 20px"></span>&nbsp;Clientes</h5>
                            </div>
                        </div>
                    </div>
                    <label onclick="toggleCC()" class="control-label" style="width: 100%; margin-bottom: 10px; border-bottom: solid #ccc 1px; padding-left: 5px; font-size: 14px;"><span class="fa fa-2x fa-eye text-info iconfa font-weight-light"></span>&nbsp;Filtros: <span class="pull-right"><i class="fa fa-chevron-down fa-fw fdown"></i></span></label>
                    <div class="fold row" style="display: none; margin: 0; border: solid 0px 1px 2px 1px #ccc">
                        <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="estadocon" class="active">Estado</label>
                                <select runat="server" clientidmode="static" id="estadocon" data-size="8" class="form-control selectpicker" title="Seleccione" data-live-search="true">
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="id_cuenta" class="active">Cuenta</label>
                                <select runat="server" clientidmode="static" id="id_cuenta" data-size="8" class="form-control selectpicker" title="Seleccione" data-live-search="true">
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-12 col-md-122 col-sm-126 col-xs-12  sn-padding" style="padding-top: 0 !important;">
                            <div class="form-group">
                                <label for="programer" class="active">Programados</label>
                                <div class="check-mail m-b-lg">
                                    <input type="checkbox" class="i-checks pull-right btn-warning" id="programed" />
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 sn-padding">
                        <button id="btnSearchClient" type="button" data-id="0" class="btn btn-primary ink-reaction btn-raised btn-loading-state" data-loading-text="<i class='fa fa-spinner fa-spin'></i> Cargando..." style="width: 100%; margin: 0 5px 0 1px">Consultar</button>
                    </div>
                    <div class="table-responsive tableclients" style="max-height: 600px !important">
                        <table class="table table-striped jambo_table" id="tblClientes">
                            <thead>
                                <tr>
                                    <th data-column-id="iden" data-formatter="ver" id="search">#</th>
                                    <th data-column-id="cliente" data-formatter="cliente">Cliente</th>
                                    <th data-column-id="vencimiento">Vence</th>
                                    <th data-column-id="cuenta">Cuenta</th>
                                </tr>
                            </thead>
                        </table>
                    </div>
                    <input type="hidden" id="hidempresa" value="0" />
                    <input type="hidden" id="hidcliente" value="0" />
                </div>
                <div class="col-lg-8 col-md-8 col-sm-7 col-xs-12 " id="dataclient" style="padding-top: 5px; padding-bottom: 15px; padding-left: 2px; background: #FFF;">
                    <div class="navbar-header">
                        <a class="navbar-minimalize minimalize-styl-2 btn btn-primary  waves-effect waves-light" id="noneclientes" href="#"><i class="fa fa-bars"></i></a>
                    </div>
                    <div class="col-lg-12"></div>
                    <ul class="nav nav-tabs">
                        <li class="active">
                            <a data-toggle="tab" href="#tab-1"><i class="fa fa-briefcase"></i>
                                <span class="hidden-xs">Información General</span></a>
                        </li>
                        <li class=""><a data-toggle="tab" href="#tab-3"><i class="fa fa-file-text"></i>
                            <span class="hidden-xs">Seguimiento</span></a>
                        </li>
                    </ul>
                    <div class="tab-content">
                        <div id="tab-1" class="tab-pane active">
                            <div class="col-lg-12">
                            </div>
                            <ac1:ClienteInfo ID="clienteinfo" runat="server" />
                        </div>
                        <div id="tab-3" class="tab-pane">
                            <div class="row" id="mostrar">
                                <div>
                                    <div class="col-lg-1 col-md-1 col-sm-1 col-xs-1">
                                        <div class="row m-l-sm m-r-md">
                                            <span class="spanact col-lg-12 col-xs-12 mintip" style="background: #e59956c4; width: 40px;" title="Realice llamada" data-type="call"><i class="fa-fw fa fa-phone"></i><%--&nbsp; Llamada--%></span>
                                        </div>
                                        <div class="row m-l-sm m-r-md">
                                            <span class="spanact col-lg-12 col-xs-12 mintip" style="background: #2f4050d6; width: 40px;" title="Programar visita" data-type="visit"><i class="fa-fw fa fa-user-secret"></i><%--&nbsp; Visita--%></span>
                                        </div>
                                        <div class="row m-l-sm m-r-md">
                                            <span class="spanact col-lg-12 col-xs-12 mintip" style="background: #23c6c8cc; width: 40px;" title="Compromiso de Pago" data-type="pago"><i class="fa-fw fa fa-money"></i><%--&nbsp; Compromiso de Pago--%></span>
                                        </div>
                                        <div class="row m-l-sm m-r-md">
                                            <span class="spanact col-lg-12 col-xs-12 mintip" style="background: #f62050e0; width: 40px;" title="Penalizacion" data-type="inmov"><i class="fa fa-exclamation-triangle"></i><%--&nbsp; Inmovilización--%></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-10 col-md-10 col-sm-10 col-xs-10 sn-padding m-l-sm" style="padding-top: 5px; padding-bottom: 15px; padding-left: 2px;">
                                    <div class="col-lg-2 col-md-2 col-sm-6 col-xs-6  sn-padding" style="padding-top: 0 !important;">
                                        <div class="form-group">
                                            <label for="programer" class="active">Programar</label>
                                            <div class="check-mail">
                                                <input type="checkbox" class="i-checks pull-right icheckbox_square-green checked" id="programer" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-4 col-md-6 col-sm-6 col-xs-12 programdate" style="display: none">
                                        <div class="form-group">
                                            <label>Fecha</label>
                                            <input id="ds_fechapro" type="text" placeholder=" " class="form-control" value="" current="true" date="true" format="YYYY-MM-DD HH:mm" mdatepicker-position="botton" />
                                        </div>
                                    </div>
                                    <div class="col-lg-4 col-md-8 col-sm-6 col-xs-12 asigned" style="display: none">
                                    </div>

                                    <div class="col-lg-2 col-md-4 col-sm-6 col-xs-12 Botns pull-right">
                                        <button title="Guardar Seguimiento" id="btnnew" data-option="I" class="btn btn-outline btn-primary dim  pull-right actionCredi" type="button" data-estado="APROVED"><i class="fa fa-paste"></i></button>
                                    </div>
                                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                        <div class="form-group">
                                            <label>Descripción</label>
                                            <textarea id="descripcion" placeholder=" " class="form-control" rows="5" cols="5" style="border: groove; border-radius: 6px; max-width: 100%; min-width: 100%; min-height: 100px !important;"></textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>


                            <div class="col-lg-12 col-md-12 col-xs-12 col-sm-12">
                                <h4 class="title-master" style="margin-top: 0; border-bottom: 2px solid #2166ce73;">&nbsp;<span class="fa fa-list-alt fa-fw"></span>Bitacora</h4>
                                <div class="form-group table-responsive" style="max-height: 350px;">
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
    <script src="../Pages/ScriptsPage/Gestion/ClienteGestion.js?2"></script>

    <script>
        $(function () {
            $('select').selectpicker();
            $('.i-checks').iCheck({
                checkboxClass: 'icheckbox_square-green',
                radioClass: 'iradio_square-green'

            });
        });

        $(document).ready(function () {
            datepicker();
        });
    </script>

</asp:Content>