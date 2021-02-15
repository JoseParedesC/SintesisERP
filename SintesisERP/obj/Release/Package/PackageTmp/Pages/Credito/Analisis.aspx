<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Analisis.aspx.cs"
    Inherits="Analisis" MasterPageFile="~/Masters/SintesisLayout.Master" %>

<%@ Register Src="~/Pages/Controles/AnalisisCre.ascx" TagName="AnalisisCre" TagPrefix="ac1" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPage" runat="server">

    <link href="../Package/Vendor/css/plugins/logscroll/style-albe-timeline.css" rel="stylesheet" />
    <script src="../Package/Vendor/js/plugins/logscroll/jquery-albe-timeline.min.js"></script>
    <script type="text/javascript"> 
        window.appPath = "<%=Request.ApplicationPath%>";
    </script>
    <link href="../Package/Vendor/css/plugins/Autocomplete/autocomplet.css" rel="stylesheet" />
    <style>
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

        .fist-item {
            overflow-x: auto;
        }

        .loader,
        .loader:before,
        .loader:after {
            border-radius: 50%;
            width: 2.5em;
            height: 2.5em;
            -webkit-animation-fill-mode: both;
            animation-fill-mode: both;
            -webkit-animation: load7 1.8s infinite ease-in-out;
            animation: load7 1.8s infinite ease-in-out;
        }

        .loader {
            color: #0074bcf0;
            font-size: 10px;
            left: 0%;
            margin: -150px auto;
            position: relative;
            text-indent: -9999em;
            -webkit-transform: translateZ(0);
            -ms-transform: translateZ(0);
            transform: translateZ(0);
            -webkit-animation-delay: -0.16s;
            animation-delay: -0.16s;
        }

            .loader:before,
            .loader:after {
                content: '';
                position: absolute;
                top: 0;
            }

            .loader:before {
                left: -3.5em;
                -webkit-animation-delay: -0.32s;
                animation-delay: -0.32s;
            }

            .loader:after {
                left: 3.5em;
            }

        .acordion {
            background-color: #b1b1b100;
            animation-duration: 2s;
            animation-name: color;
        }

        @keyframes color {
            from {
                background-color: #b1b1b1;
            }

            to {
                background-color: #b1b1b100;
            }
        }

        @-webkit-keyframes load7 {
            0%, 80%, 100% {
                box-shadow: 0 2.5em 0 -1.3em;
            }

            40% {
                box-shadow: 0 2.5em 0 0;
            }
        }

        @keyframes load7 {
            0%, 80%, 100% {
                box-shadow: 0 2.5em 0 -1.3em;
            }

            40% {
                box-shadow: 0 2.5em 0 0;
            }
        }

        .bootstrap-select.btn-group .dropdown-toggle .filter-option {
            font-size: 11px;
            border-bottom: 1px solid #D2D2D2;
            margin-top: 5px;
        }

        .input-padding {
            padding-left: 0px;
            margin-left: -12px;
            margin-right: 35px;
        }

        .input[disabled] {
            border: none;
            background-color: #fff;
            border-bottom: 1px dotted #D2D2D2 !important;
            margin-bottom: 12px;
            cursor: not-allowed;
        }

        .checks {
            height: 20px;
            width: 20px;
            margin-left: 25px !important;
        }

        .cancel {
            color: #ea394c !important;
        }

        .card {
            height: auto !important;
            width: auto !important;
        }

        .ir-arriba {
            display: none;
            padding: 20px;
            background: #0074bcf0;
            font-size: 20px;
            color: #fff;
            cursor: pointer;
            position: fixed;
            border-radius: 6px;
            bottom: 46px;
            right: 20px;
            height: 50px;
        }

        .boton {
            background: #0074bcf0;
            border-bottom: 5px solid #0045a6;
            border-radius: 12px;
            box-shadow: 6px 6px 6px #999;
            color: #fff;
            cursor: pointer;
            display: block;
            font-family: 'Raleway', Arial, Helvetica;
            font-size: 20px;
            /*margin: 80px auto;*/
            padding: 20px 20px;
            text-align: center;
            transition: all 0.2s ease 0s;
            width: 10px;
            /*position: fixed;*/
            height: 5px;
            margin-left: 2%;
            margin-top: 10%;
        }

            .boton:hover {
                background: #0096f7;
            }

            .boton:active {
                box-shadow: 2px 2px 2px #777, 0px 0px 35px 0px #00b7f8;
                border-bottom: 1px solid #0045A6;
                text-shadow: 0px 0px 5px #fff, 0px 0px 5px #fff;
                transform: translateY(4px);
                transition: all 0.1s ease 0s;
            }

        .editForm, .NoteForm {
            font-size: 95% !important;
            background: #fff;
            box-sizing: border-box;
            padding: 10px 15px;
            top: 440px;
            -webkit-box-shadow: 4px 7px 23px 6px rgba(0,0,0,0.75);
            -moz-box-shadow: 4px 7px 23px 6px rgba(0,0,0,0.75);
            box-shadow: 4px 7px 23px 6px rgba(0,0,0,0.75);
            z-index: 999999;
        }

            .editForm .buttons, .NoteForm .buttons {
                text-align: center !important;
            }

        .penditable {
            font-size: 180% !important;
            margin-right: 3px;
        }

        .penditable, .penditabletext {
            bottom: 10px;
            right: 10px;
            cursor: pointer;
            display: block !important;
            float: right;
            color: #114211;
            margin-top: 0px;
            font-weight: bold;
        }

        .penditabletext {
            margin-right: 5px;
            font-size: 160% !important;
        }

        |
        .penditabletext:hover {
            color: #ebe1609c !important;
        }



        div.contact p {
            color: #000000;
        }

        div.contact img {
            display: block;
            max-width: 100px;
            height: 100px;
            border-radius: 50%;
        }

        .form-group {
            margin-bottom: 0px !important;
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


        .contact p {
            word-break: break-all;
            word-wrap: break-word;
            font-size: 14px;
        }

        .Botns button {
            margin-top: 10px !important;
        }

        .file-saves li {
            padding: 5px !important;
            border: solid 1px #ccc !important;
            border-radius: 6px !important;
            width: 100% !important;
            display: block !important;
            margin: -1px !important;
        }

            .file-saves li:hover {
                background-color: #ccc !important;
                cursor: pointer;
                color: #fff !important;
            }

        .file-saves li {
            color: #000;
            font-weight: bold;
            font-size: 12px;
        }

        .file-zoom-fullscreen .modal-dialog {
            width: 100% !important;
        }

        .nav.nav-tabs li a {
            border: 1px solid #ccc;
        }

        .nav.nav-tabs li.active a {
            background-color: #0074bcf0 !important;
            color: white;
            border: none;
        }

        .btn-outline.dim.pull-right {
            margin-bottom: 5px !important;
        }

        legend {
            margin-left: 0 !important;
        }

        #divagregados {
            margin-bottom: 15px !important;
            margin-top: 10px;
        }

        .bot:after {
            content: "Información de Solicitud";
            font-size: 12px;
            font-weight: 700;
            letter-spacing: 1px;
            position: absolute;
            text-transform: uppercase;
            top: 2px;
            left: 7px;
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
            padding: 15px;
            padding-left: 27px;
            padding-right: 7px;
            border-radius: 5px;
            background: #fff;
            border: solid 1px #ccc;
            overflow-y: auto;
            padding-top: 30px;
            margin-top: 10px;
            margin-bottom: 20px !important;
        }

        .text-anals {
            color: #2fe418;
        }

        #dropdown-menu {
            right: 45px;
            background-color: #fff0;
            box-shadow: none;
            position: absolute !important;
            top: 100% !important;
        }

        .dropdown-item {
            padding: 0px;
        }

        #btnConc:focus, #btnConc:hover {
            background-color: #1c84c6 !important;
            color: #fff !important;
        }

        .btn-success:hover, .btn-primary:hover {
            background-color: #1c84c6 !important;
            color: #fff;
        }

        .btn-danger:hover {
            background-color: #ed5565 !important;
            color: #fff;
        }

        .btn-warning:hover {
            background-color: #f8ac59 !important;
            color: #fff;
        }

        .group2 {
            border-radius: 50% !important;
            animation-duration: 1s;
            animation-name: slidein;
        }

        @keyframes slidein {
            from {
                margin-top: -50px;
                box-shadow: inset 0 0 0 #ffffff00, 0 5px 0 0 #ffffff00, 0 10px 5px #ffffff00;
                background-color: #ffffff00;
                color: #ffffff00;
                border-color: #ffffff00;
                /*transform: rotate(0deg);*/
            }

            to {
                margin-top: 0%;
                /*transform: rotate(360deg);*/
            }
        }

        .container-fluid {
            background-color: white !important;
        }

        .btn-danger[disabled] {
            color: white;
            background-color: #ed5565 !important;
        }

        .btn-primary[disabled] {
            color: white;
            background-color: #0074bcf0 !important;
        }

        .group1 {
            bottom: 20px;
        }

        .bloque[disabled]:hover {
            cursor: not-allowed;
        }

        .tab-content {
            border: 1px solid #ddd;
            padding: 10px;
            border-top-color: white;
            height: auto;
        }

        #separator {
            border-bottom: 5px dotted #0f7cc0 !important;
            margin-bottom: 15px;
        }

        .EditCot {
            animation-name: subir;
            animation-duration: 0.5s;
        }

        @keyframes subir {
            from {
                margin-top: 20%;
            }

            to {
                margin-top: 0%;
            }
        }
    </style>

    <div class="wrapper wrapper-content" style="padding-top: 0px; background: #fff !important;">
        <input type="hidden" id="idToken" />
        <div class="row" style="margin-left: 0; margin-right: 0">
            <div class="x_panel" style="margin-top: 10px">
                <div class="x_title col-lg-6 col-md-6 col-sm-6 col-xs-12">
                    <h1 class="title-master" style="margin-top: 0;"><span class="fa fa-eye fa-fw"></span>Análisis de Credito</h1>
                    <input type="hidden" id="estadosol" />
                    <div class="clearfix"></div>
                    <%-- <button title="Imprimir" id="btnPrint" style="background-color: white" class="group2 btn btn-outline btn-print dim pull-right" type="button" data-option="I"><i class="fa-paste fa"></i></button> --%>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 ">
                    <div class="group" role="group" aria-label="Button group with nested dropdown">
                        <div class="btn-group group1 Botns pull-right" role="group">
                            <button title="Listar" style="border-radius: 6px;" id="btnList" data-option="L" class="btn btn-outline btn-info  dim  pull-right " type="button"><i class="fa-list fa"></i></button>
                            <button title="Concluir" style="border-radius: 6px; height: 35px; width: 35px; color: #4389b5; font-size: 20px; text-align: center" id="btnConc" data-option="UC" class="btn btn-outline btn-success dim  pull-right btn-add dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" type="button" disabled="disabled"><i class="fa fa-sort-down" style="position: relative; bottom: 5px;"></i></button>
                            <div class="dropdown-menu" id="dropdown-menu" aria-labelledby="btnGroupDrop1">
                                <a class="dropdown-item" href="#">
                                    <button title="Rechazar" id="btnRev" style="background-color: white" class="group2 btn btn-outline btn-danger  dim  pull-right actionCredi" type="button" disabled="disabled" data-estado="RECHA"><i class="fa-file-o fa"></i></button>
                                </a>
                                <a class="dropdown-item" href="#">
                                    <button title="Excepcionar" id="btnExp" style="background-color: white" data-option="I" class="group2 btn btn-outline btn-warning dim  pull-right actionCredi" type="button" disabled="disabled" data-estado="EXCEPCI"><i class="fa fa-warning"></i></button>
                                </a>
                                <a class="dropdown-item" href="#">
                                    <button title="Aprobar" id="btnSave" style="background-color: white" data-option="I" class="group2 btn btn-outline btn-primary dim  pull-right actionCredi" type="button" disabled="disabled" data-estado="FACTURED"><i class="fa fa-paste"></i></button>
                                </a>
                                <a class="dropdown-item" href="#">
                                    <button title="Reprocesar" id="btnRep" style="background-color: white" data-option="I" class="group2 btn btn-outline btn-success dim  pull-right actionCredi" type="button" disabled="disabled" data-estado="REPROCES"><i class="fa fa-rotate-left"></i></button>
                                </a>
                            </div>
                            <button title="Guardar" style="border-radius: 6px;" id="btnUpdate" data-option="UC" class="btn btn-outline btn-warning dim  pull-right btn-add" type="button" disabled="disabled"><i class="fa-save fa"></i></button>
                        </div>
                    </div>
                </div>
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" id="divfilter">
                    <div class="col-lg-2 col-md-2 col-sm-6 col-xs-6 sn-padding">
                        <div class="form-group">
                            <label for="id_estacionfil" class="active">Estacion:</label>
                            <div class="input-icon left">
                                <select type="input" class="selectpicker select" id="id_estacionfil" runat="server" clientidmode="static"></select>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-6 col-xs-6 sn-padding">
                        <div class="form-group">
                            <label for="id_asesorfil" class="active">Asesor:</label>
                            <select class="selectpicker select" id="id_asesorfil" runat="server" clientidmode="static"></select>
                        </div>
                    </div>
                </div>
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding: 3px" id="divlist">
                    <div class="table-responsive" style="max-height: 500px">
                        <input type="hidden" id="id_persona" />
                        <input type="hidden" id="id_solicitud" />
                        <input type="hidden" id="id_bodega" />
                        <table class="table table-striped jambo_table" id="tblsolicitudes">
                            <thead>
                                <tr>
                                    <th data-column-id="edit" data-formatter="edit" data-sortable="false" style="max-width: 30px !important;">Ver</th>
                                    <th data-column-id="consecutivo">N°</th>
                                    <th data-column-id="fecha">Fecha</th>
                                    <th data-column-id="identificacion">Identificación</th>
                                    <th data-column-id="cliente">Cliente</th>
                                    <th data-column-id="producto">Producto</th>
                                    <th data-column-id="estacion">Estación</th>
                                    <th data-column-id="asesor">Asesor</th>
                                    <th data-column-id="estado">Estado</th>
                                </tr>
                            </thead>
                        </table>
                    </div>
                </div>

                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding: 3px; display: none; bottom: 20px" id="divinfo">
                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                        <fieldset class="bot">
                            <div class="">
                                <div class="col-lg-2 col-md-2 col-sm-4 col-xs-4 input-padding">
                                    <div class="form-group">
                                        <label for="numsolic" class="active"># Solicitud:</label>
                                        <div class="input-icon left">
                                            <i class="fa fa-tag"></i>
                                            <input id="numsolic" type="text" placeholder="" class="input" disabled="disabled" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-2 col-md-2 col-sm-4 col-xs-4 input-padding">
                                    <div class="form-group">
                                        <label for="estado" class="active">Estado :</label>
                                        <div class="input-icon left">
                                            <i class="fa fa-gear"></i>
                                            <input id="estado" type="text" placeholder=" " class="input" disabled="disabled" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-2 col-md-2 col-sm-4 col-xs-4 input-padding">
                                    <div class="form-group">
                                        <label for="cd_cotizacion" class="active">Cotizacion:</label>
                                        <div class="input-icon left">
                                            <i class="fa fa-tag"></i>
                                            <input id="cd_cotizacion" type="text" placeholder=" " class="input" disabled="disabled" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-2 col-md-2 col-sm-4 col-xs-4 input-padding">
                                    <div class="form-group">
                                        <label for="Text_Fecha" class="active">Fecha:</label>
                                        <div class="input-icon left">
                                            <i class="fa fa-calendar"></i>
                                            <input id="Text_Fecha" type="text" placeholder=" " class="input" disabled="disabled" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-2 col-md-2 col-sm-3 col-xs-3 input-padding">
                                    <div class="form-group">
                                        <label for="asesor" class="active">Asesor :</label>
                                        <div class="input-icon left">
                                            <i class="fa fa-user"></i>
                                            <input id="asesor" type="text" placeholder=" " class="input" disabled="disabled" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </fieldset>
                    </div>
                    <div class="col-lg-9 col-md-12 col-sm-12 col-xs-12" style="padding-left: 10px; bottom: 20px">
                        <div class="content clearfix" style="display: block; margin: 5px 5px 10px 5px;" id="divcabecera">
                            <div class="" style="display: block;" id="divregistro">
                                <ul class="nav nav-tabs">
                                    <li class="list active">
                                        <a data-toggle="tab" id="tab1" href="#tab-1"><i class="fa fa-briefcase"></i>
                                            <span class="hidden-xs">Información Credito</span></a>
                                    </li>
                                    <li class="list">
                                        <a data-toggle="tab" id="tab2" href="#tab-2"><i class="fa fa-user"></i>
                                            <span class="hidden-xs">Información Personas</span></a>
                                    </li>
                                    <li class="list">
                                        <a data-toggle="tab" id="tab3" href="#tab-3"><i class="fa fa-file-text"></i>
                                            <span class="hidden-xs">Seguimiento</span></a>
                                    </li>
                                    <button title="Personas" style="border-radius: 6px; display: none;" id="btnBack" data-option="B" class="btn btn-outline btn-warning dim  pull-right " type="button"><i style="font-size: 12px" class="fa-2x fa-angle-double-left fa"></i></button>
                                    <button id="detalleCot" type="button" data-option="D" class="btn btn-outline btn-primary dim  pull-right" title="Detalles" disabled=""><i class="fa fa-pencil"></i></button>
                                    <button style="display: none;" title="Guardar" id="actCuotas" data-option="true" data-send="T" class="btn btn-outline btn-primary dim  pull-right bloque" type="button"><i class="fa fa-paste"></i></button>
                                </ul>

                                <div class="tab-content">
                                    <div id="tab-1" class="tab-pane active">
                                        <div class="portlet">
                                            <div class="portlet-title">
                                                <div class="caption">
                                                    <i class="fa fa-calculator fa-fw"></i>Liquidación                                                
                                                </div>
                                            </div>
                                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                                <div class="col-lg-9 col-md-9 col-sm-12 col-xs-12">
                                                    <div class="row">
                                                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12" id="PagoAcreditos">
                                                            <div class="form-group">
                                                                <label for="tipo_cartera" class="active">Forma Pago:</label>
                                                                <select runat="server" clientidmode="static" id="tipo_cartera" data-size="8" class="form-control selectpicker bloq" title="" data-live-search="true" disabled="disabled">
                                                                    <option value="0">Seleccione</option>
                                                                    <option value="1">Financieros</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                                                            <div class="form-group">
                                                                <label for="descuento" class="active">Descuentos:</label>
                                                                <input id="descuento" data-estado="false" type="text" class="form-control bloq" placeholder="$ 0.0" money="true" disabled="disabled" data-a-sign="$ " data-m-dec="2" data-v-min="0.00" data-v-max="999999999999.99"/>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                                                            <div class="form-group">
                                                                <label for="fecha_venc" class="active">Venc. Inicial:</label>
                                                                <input id="fecha_venc" type="text" placeholder=" " class="form-control bloq" value="" current="true" date="true" format="YYYY-MM-DD" mdatepicker-position="botton" disabled="disabled" />
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                                                            <div class="form-group">
                                                                <label for="cuotaini" class="active">Cuota Inicial:</label>
                                                                <input id="cuotaini" type="text" class="form-control bloq" placeholder="$ 0.0" money="true" disabled="disabled" data-a-sign="$ " data-m-dec="2" data-v-min="0.00" data-v-max="999999999999.99"/>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                                                            <div class="form-group">
                                                                <label for="lineacredit" class="active">Linea de Credito</label>
                                                                <select runat="server" clientidmode="static" id="lineacredit" data-size="8" class="form-control selectpicker bloq" title="" data-live-search="true" disabled="disabled"></select>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                                                            <div class="form-group">
                                                                <label for="cuotas" class="active">N° Cuotas:</label>
                                                                <input id="cuotas" type="text" placeholder=" " class="form-control bloq" disabled="disabled" />
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                                                            <div class="form-group">
                                                                <label for="valcuotamen" class="active">Cuota Mensual:</label>
                                                                <input id="valcuotamen" type="text" placeholder="$ 0.00 " class="form-control" disabled="disabled" data-m-dec="2" data-v-min="0.00" data-a-sign="$ " data-v-max="999999999999.99" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                                            <div class="form-group ob">
                                                                <label for="observaciones" class="active">Observaciones:</label>
                                                                <textarea id="observaciones" rows="4" placeholder=" " class="form-control bloq" disabled="disabled" style="max-width: 100%; min-width: 100%; min-height: 100px !important; max-height: 200px !important"></textarea>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-lg-3 col-md-3 col-sm-12 col-xs-12">
                                                    <div class="col-lg-12 col-md-12 col-xs-12 col-sm-12" style="font-size: 11px">
                                                        <div class="ibox-content codvalue text-right">
                                                            <h1 id="precio" class="no-margins" style="font-size: 20px;">$ 0.00</h1>
                                                            <span class="font-bold text-navy">Subtotal</span>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-12 col-md-12 col-xs-12 col-sm-12" style="font-size: 11px">
                                                        <div class="ibox-content codvalue text-right">
                                                            <h1 id="valoriva" class="no-margins" style="font-size: 20px;">$ 0.00</h1>
                                                            <span class="font-bold text-navy">IVA: </span>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-12 col-md-12 col-xs-12 col-sm-12" style="font-size: 11px">
                                                        <div class="ibox-content codvalue text-right">
                                                            <h1 id="valfinan" class="no-margins" style="font-size: 20px;">$ 0.00</h1>
                                                            <input id="hidden_valfinan" type="hidden" placeholder="$ 0.00 " class="form-control" disabled="disabled" />
                                                            <span class="font-bold text-navy">Financiacion </span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row"></div>
                                        </div>
                                        <div class="EditCot" style="display: none;">
                                            <div class="header">
                                                <input type="hidden" id="tipo" value="TERCE" />
                                                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" id="separator"></div>
                                                <h2 class="title"><i class="fa fa-calculator"></i>Detalles de la Cotización</h2>
                                            </div>
                                            <div class="clearfix" style="margin-bottom: 0; padding: 28px; padding-top: 12px;">
                                                <div class="row">
                                                    <div class="col-lg-2 col-md-2 col-sm-6 col-xs-6">
                                                        <div class="form-group">
                                                            <label for="codprod" class="active">Codigo: </label>
                                                            <input id="codprod" type="text" placeholder=" " class="form-control actionautocomplete inputsearch" value="" autocomplete="off" />
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6">
                                                        <div class="form-group">
                                                            <label for="nombreart" class="active">Producto: </label>
                                                            <input type="hidden" id="hiddenart" />
                                                            <input id="nombreart" type="text" placeholder=" " class="form-control actionautocomplete inputsearch" value="" autocomplete="off" />
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-2 col-md-2 col-sm-5 col-xs-5">
                                                        <div class="form-group">
                                                            <label for="cant" class="active">Cantidad: </label>
                                                            <input id="cant" type="text" placeholder="1.0" class="form-control" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="0.01" />
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-3 col-md-3 col-sm-6 col-xs-6">
                                                        <div class="form-group">
                                                            <label for="price" class="active">Precio: </label>
                                                            <input id="price" type="text" placeholder="$ 0.00" class="form-control addart" money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="0" data-a-sign="$ " />
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-1 col-md-1 col-sm-1 col-xs-1 pull-right">
                                                        <button id="btnProd" type="button" data-op="true" style="height: 40px; width: 40px;" data-option="D" class="btn btn-outline btn-circle addarticle pull-right bloque" disabled="" title="Agregar"><i class="fa fa-plus"></i></button>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                                        <div class="table-responsive" style="height: 110px !important;">
                                                            <table class="table table-striped jambo_table table-fixed" id="tblArticulo">
                                                                <thead>
                                                                    <tr>
                                                                        <th class="text-center" data-formatter="edit">Editar</th>
                                                                        <th class="text-center" data-column-id="codigo">Codigo</th>
                                                                        <th class="text-center" data-column-id="nombre">Nombre</th>
                                                                        <th class="text-center" data-column-id="cantidad">Cantidad</th>
                                                                        <th class="text-center" data-column-id="precio" data-formatter="precio">Precio</th>
                                                                        <th class="text-center" data-column-id="iva" data-formatter="iva">Iva</th>
                                                                        <th class="text-center" data-column-id="descuento" data-formatter="descuento">Desc.</th>
                                                                        <th class="text-center" data-column-id="total" data-formatter="total">SubTotal</th>
                                                                        <th class="text-center" data-formatter="delete">Eliminar</th>
                                                                    </tr>
                                                                </thead>
                                                            </table>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div id="tab-2" class="tab-pane">
                                        <h3>Agregados</h3>
                                        <input type="hidden" value="0" id="id_solper" />
                                        <div class="row" id="divagregados">
                                            <div class="col-lg-12">
                                            </div>
                                        </div>
                                        <div class="row" id="divpersonainfo" style="display: none">
                                            <div class="col-lg-12">
                                                <section>
                                                    <div style="display: none;" id="loadingDiv">
                                                        <div class="loader">Loading...</div>
                                                    </div>
                                                    <ac1:AnalisisCre ID="analisis" runat="server" />
                                                </section>
                                            </div>
                                        </div>
                                    </div>
                                    <div id="tab-3" class="tab-pane">
                                        <div class="row">
                                            <div class="col-lg-11 col-md-11 col-xs-12 col-sm-11">
                                                <div class="form-group">
                                                    <label>Observaciones:</label>
                                                    <textarea rows="4" class="form-control text" id="seguimiento" style="height: 70px !important; resize: none"></textarea>
                                                </div>
                                            </div>
                                            <div class="col-lg-1 col-xs-12 col-md-1 col-sm-1">
                                                <button title="Agregar" id="btnSaveseg" data-option="I" class="btn btn-outline btn-info dim  pull-right btn-large-dim" data-loading-text="<i class='fa fa-spinner fa-spin'></i>" type="button"><i class="fa fa-paste"></i></button>
                                            </div>
                                        </div>
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
                    </div>

                    <div class="col-lg-3 col-md-12 col-sm-12 col-xs-12">
                        <div class="row archivo">
                            <div class="col-lg-12">
                                <div class="form-group">
                                    <label>Archivos subidos:</label>
                                    <div class="file-saves">
                                        <ul class="list-group clear-list m-t" id="filesaves">
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
        <span class="ir-arriba fa fa-sort-asc"></span>
    </div>

    <div class="editForm" style="max-width: 250px; width: 100%; display: none; position: absolute; top: 372.6px; right: 0;">
        <div class="form-group">
            <label class="active" for="sVal">Puntaje:</label>
            <select id="sVal" class="sendable select-style" data-sel="">
                <option value="0">Seleccione</option>
                <option value="AL">Alto</option>
                <option value="ME">Medio</option>
                <option value="BA">Bajo</option>
                <option value="NA">No Aplica</option>
            </select>
        </div>
        <div class="buttons">
            <a class="btn btn-sm btn-success postChanges waves-effect waves-light" id="saveeval"><i class="fa fa-check"></i></a>
            <a class="btn btn-sm btn-danger hideLay waves-effect waves-light"><i class="fa fa-times"></i></a>
        </div>
    </div>

    <div class="NoteForm" style="max-width: 350px; width: 100%; display: none; position: absolute; top: 372.6px; right: 0;">
        <div class="form-group">
            <label for="visible" class="active">Visible</label>
            <div class="check-mail">
                <input type="checkbox" class="checks" id="visible" />
            </div>
        </div>
        <div class="form-group">
            <label class="active" for="notetext">Nota:</label>
            <textarea id="notetext" class="form-control text" rows="2" style="min-width: 100%; max-width: 100%; max-height: 120px; min-height: 120px !important"></textarea>
        </div>
        <div class="buttons">
            <a class="btn btn-sm btn-success postChanges waves-effect waves-light" id="savenote"><i class="fa fa-check"></i></a>
            <a class="btn btn-sm btn-danger hideLay waves-effect waves-light"><i class="fa fa-times"></i></a>
        </div>
    </div>


    <%--</main>--%>

    <script src="../Package/Vendor/js/plugins/Autocomplete/jquery.autocomplete.js"></script>
    <asp:Literal runat="server" ID="scripts"></asp:Literal>

    <script>

        $(document).ready(function () {
            $('.actionCredi').hide();

            $('.i-checks').iCheck({
                checkboxClass: 'icheckbox_square-green',
                radioClass: 'iradio_square-green',
            });

            $('.ir-arriba').click(function () {
                $('body, html').animate({ scrollTop: '0px' }, 300);
            });

            $(window).scroll(function () {
                if ($(this).scrollTop() > 0) {
                    $('.ir-arriba').slideDown(300);
                } else {
                    $('.ir-arriba').slideUp(300);
                }
            });

            if (document.documentElement.clientWidth <= 1125) {
                $('.archivo').addClass('archivos');
                $('.row').removeClass('archivo');
                var col = $('.archivos').closest('.col-md-12');
                col.removeClass('col-md-12');
                col.addClass('col-md-11')
            } else {
                $('.archivos').addClass('archivo');
                $('.row').removeClass('archivos');
            }

            $('#btnConc').click(function () {
                $('#btnConc').attr('aria-expanded', true);
            });

        });

    </script>
</asp:Content>
