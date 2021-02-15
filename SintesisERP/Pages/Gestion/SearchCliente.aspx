<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SearchCliente.aspx.cs" Inherits="SearchCliente" MasterPageFile="~/Masters/SintesisLayout.Master" %>

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

        #descripcion {
            border-radius: 4px;
            background-color: white;
            border: groove;
            border-color: #c5c5c51f !important;
            border-bottom: none;
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
            background-color: #7be788bd !important;
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
                background-color: #1ab394 !important;
                color: white;
                border: none;
            }

            .nav.nav-tabs li {
                background: #fff;
                color: #1ab394 !important;
            }

                .nav.nav-tabs li.active a {
                    background: #1ab394;
                    color: #fff !important;
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
    </style>

    <input type="hidden" id="id_documento" value="0" />
    <input type="hidden" id="idToken" value="0" />

    <div class="wrapper " style="padding-top: 5px;">
        <div class="row" style="margin-left: 0; background: white;">
            <div class="x_panel">
                <div class="x_title col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <h1 class="title-master" style="margin-top: 8px;"><span class="fa fa-child fa-fw"></span>Consulta de Clientes</h1>
                    <div class="clearfix"></div>
                </div>
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" id="dataclient" style="padding-top: 5px; padding-bottom: 15px; padding-left: 2px; background: #FFF;">
                    <div class="col-lg-4 col-md-5 col-sm-12 col-xs-12">
                        <div class="form-group">
                            <label for="Text_Nombre" class="active">Cliente</label>
                            <div class="input-group">
                                <input type="hidden" id="cd_cliente" value="0" data-op="C" class="recalculo" />
                                <input type="hidden" id="tipotercero1" value="CL" />
                                <input type="text" class="form-control inputsearch" placeholder=" " readonly="readonly" id="ds_cliente" aria-describedby="sizing-addon1" />
                                <span class="input-group-addon">
                                    <button type="button" class="btn btn-primary btnsearch" data-search="CNTTerceros" data-method="CNTTercerosListTipo" data-title="Proveedores" data-select="1,2" data-column="id,tercompleto,tipo" data-fields="cd_cliente,ds_cliente" data-params="tipoter,tipotercero1">
                                        <i class="fa fa-fw fa-search"></i>
                                    </button>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="tab-content">
                    <div class="col-lg-8 col-md-8 col-sm-12 col-xs-12">
                        <ac1:ClienteInfo ID="clienteinfo" runat="server" />
                    </div>
                    <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
                        <div class="row">
                            <div class="col-lg-2 col-md-2 col-sm-2 col-xs-2">
                                <div class="row m-l-sm m-r-md">
                                    <span class="spanact col-lg-2 col-xs-12 mintip" style="background: #e59956c4; width: 40px;" title="Relice llamada" data-type="call"><i class="fa-fw fa fa-phone"></i><%--&nbsp; Llamada--%></span>
                                </div>
                                <div class="row m-l-sm m-r-md">
                                    <span class="spanact col-lg-2 col-xs-12 mintip" style="background: #23c6c8cc; width: 40px;" title="Compromiso de Pago" data-type="pago"><i class="fa-fw fa fa-money"></i><%--&nbsp; Compromiso de Pago--%></span>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-3 col-sm-3 col-xs-3  sn-padding" style="padding-top: 0 !important;">
                                <div class="form-group">
                                    <label for="programer" class="active">Programar</label>
                                    <div class="check-mail">
                                        <input type="checkbox" class="i-checks" id="programer" value="static" />
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 programdate" style="display: none">
                                <div class="form-group fecha">
                                    <label>Fecha</label>
                                    <input id="ds_fechapro" type="text" placeholder=" " class="form-control fecha" value="" current="true" date="true" format="YYYY-MM-DD HH:mm" mdatepicker-position="botton" />
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 asigned" style="display: none">
                                <div class="form-group">
                                    <label for="id_uservisit" class="active">Gestor de Campo</label>
                                    <select runat="server" clientidmode="static" id="id_uservisit" data-size="8" class="form-control selectpicker" title="Seleccione" data-live-search="true">
                                    </select>
                                </div>
                            </div>
                            <div class="col-lg-2 col-md-2 col-sm-2 col-xs-2 Botns pull-right">
                                <button title="Guardar Seguimiento" id="btnnew" data-option="I" class="btn btn-outline btn-primary dim  pull-right actionCredi" type="button" data-estado="APROVED"><i class="fa fa-paste"></i></button>
                            </div>
                        </div>
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                            <div class="form-group">
                                <label>Descripción</label>
                                <textarea id="descripcion" placeholder=" " class="form-control" rows="5" cols="5" style="max-width: 100%; min-width: 100%; min-height: 100px !important;"></textarea>
                            </div>
                        </div>
                        <div class="col-lg-12 col-md-12 col-xs-12 col-sm-12">
                            <h4 class="title-master" style="margin-top: 20px; border-bottom: 2px solid #2166ce73;">&nbsp;<span class="fa fa-list-alt fa-fw"></span>Bitacora</h4>
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

    <script src="../Pages/ScriptsPage/Gestion/SearchCliente.js?1"></script>

    <script>
        $(function () {
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
