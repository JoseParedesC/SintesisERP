<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Empleados.aspx.cs" Inherits="Empleados" MasterPageFile="~/Masters/SintesisMaster.Master" %>


<asp:Content ID="Content3" ContentPlaceHolderID="ContentPage" runat="server">
    <%--<link href="../Package/Vendor/css/plugins/logscroll/style-albe-timeline.css" rel="stylesheet" />--%>
    <link href="../Package/Vendor/css/plugins/fileinput/fileinput.css" rel="stylesheet" />
    <%--<script src="../Package/Vendor/js/plugins/logscroll/jquery-albe-timeline.min.js"></script>--%>



    <script type="text/javascript">
        window.appPath = "<%=Request.ApplicationPath%>";
    </script>
    <style>
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
            z-index: 2;
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

        .noneclient, .formpago, .formpagotro, .cargo {
            display: none;
        }

        .spanact.active {
            border: 3px solid #2580dd;
            color: #000;
        }

        .table-responsive {
            overflow-y: auto !important;
        }

        .cont {
            margin-bottom: 10px !important;
        }

        .divclientinfo input.form-control, .form-group label {
            font-size: 12px !important;
        }

        .divclientinfo table tbody tr td {
            font-size: 11px !important;
            font-family: "open sans", "Helvetica Neue", Helvetica, Arial, sans-serif;
        }

        .divclientinfo table thead tr th {
            padding: 4px !important;
            font-size: 12px !important;
            font-family: "open sans", "Helvetica Neue", Helvetica, Arial, sans-serif;
        }

        .form-control[disabled], .form-group .form-control[disabled], fieldset[disabled] .form-control, fieldset[disabled] .form-group .form-control {
            border-bottom: 1px dotted #D2D2D2 !important;
        }

        .lado {
            margin-top: 26px !important;
        }

        #ch_Discapasidad {
            height: 20px;
            width: 20px;
            border-radius: 20px !important;
        }

        .discapasidad {
            display: none;
        }

        .extran {
            display: none;
        }

        .trabajador {
            margin-bottom: 10px !important;
        }

        #soporte {
            width: 284px;
            height: 13px;
        }

        input.file-caption-name {
            padding-left: 10px !important;
        }

        div.btn.btn-primary.btn-file, div.file-caption.form-control.kv-fileinput-caption, div.input-group-btn.input-group-append .btn-secondary {
            font-size: 14px !important;
            height: 34px !important;
            padding-top: 8px !important;
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

        #video {
            height: 270px !important;
        }

        #btnCancelPhoto, #btnSavePhoto {
            margin-top: 9px;
        }

        #ModalFoto {
            height: 420px !important;
        }

        #modal-foto {
            height: 530px;
        }

        /*.file-loading {
        width: 283px;
    }*/
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
    </style>

    <input type="hidden" id="id_documento" value="0" />
    <input type="hidden" id="idToken" value="0" />
    <div class="wrapper " style="padding-top: 5px;">
        <div class="row" style="margin-left: 0; background: white;">
            <div class="x_panel">
                <div class="row">
                    <div class="x_title col-lg-6 col-md-6 col-sm-7 col-xs-12">
                        <h1 class="title-master" style="margin-top: 8px;"><span class="fa fa-bullhorn fa-fw"></span>Maestro de Empleados</h1>
                        <div class="clearfix"></div>

                    </div>
                    <div class="col-lg-6 col-md-6 col-sm-5 col-xs-12 btnempleado" style="display: none;">
                        <button title="Guardar" id="btnguardar" class="btn btn-outline btn-primary dim  pull-right" type="button" style="margin-right: 40px !important;" disabled="disabled"><i class="fa fa-paste"></i></button>
                        <button title="Guardar Contrato" id="btnguardarcontra" class="btn btn-outline btn-primary dim  pull-right" type="button" style="margin-right: 40px !important; display: none;" disabled="disabled"><i class="fa fa-paste"></i></button>
                        <button title="Imprimir" id="btnPrint" data-option="I" class="btn btn-outline btn-info dim  pull-right" type="button" style=" display: none;"><i class="fa fa-print"></i></button>
                        <button title="Nuevo Empleado" id="btnnews" data-option="R" class="btn btn-outline btn-default  dim  pull-right" type="button" style=" display: none;"><i class="fa-file-o fa"></i></button>
                        <button title="Atrás" id="atras" class="btn btn-outline btn-default  dim  pull-right" type="button" style="display: none;"><i class="fa fa fa-backward"></i></button>
                        <button class="btn btn-default btn-outline dim pull-right" id="noneempleado" href="#"><i id="iconbot" class="fa fa fa-backward"></i></button>
                    </div>
                    <div class="col-lg-6 col-md-6 col-sm-5 col-xs-12 " style="display: none;">
                    </div>
                </div>
                <div class="row">


                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 tblempleados">

                        <%--<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 sn-padding" style="padding-left: 0px; margin-bottom: 8px;">
                        <div class="float-e-margins">
                            <div class="ibox-title" style="border: 2px solid #e7eaec; border-radius: 8px;">
                                <span runat="server" clientidmode="static" class="label label-success pull-right" id="countclient" style="font-size: 14px;">0</span>
                                <h5><span class="fa fa-file-text-o fa-fw" style="font-size: 20px"></span>&nbsp;Clientes</h5>
                            </div>
                        </div>
                    </div>--%>
                        <div class="col-lg-2 col-md-2 col-sm-12 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="filtrocen" class="active">Centro de costo</label>
                                <select runat="server" clientidmode="static" id="filtrocen" data-size="8" class="form-control selectpicker" title="Seleccione" data-live-search="true">
                                </select>
                            </div>
                        </div>


                        <div class="table-responsive">
                            <table class="table table-condensed table-striped jambo_table" id="tblEmpleado">
                                <thead>
                                    <tr>
                                        <th data-column-id="ver" data-formatter="ver" id="search">#</th>
                                        <th data-column-id="nombre">Nombre</th>
                                        <th data-column-id="cargo">Cargo</th>
                                        <th data-column-id="contra" data-formatter="contra" data-sortable="false" style="max-width: 30px">Contrato</th>
                                        <th data-column-id="delete" data-formatter="delete" data-sortable="false" style="max-width: 30px">#</th>
                                    </tr>
                                </thead>
                            </table>
                        </div>

                        <input type="hidden" id="hidempleado" value="0" />
                        <input type="hidden" id="hidcontrato" value="0" />
                        <input type="hidden" id="hidhorario" value="0" />
                        <input clientidmode="static" type="hidden" id="hidsalario" value="0" money="true" runat="server" />
                        <input clientidmode="static" type="hidden" id="hidsalarioIntegral" value="0" money="true" runat="server" />
                    </div>

                    <span class="fa-stack fa-lg pull-right goTop iconnew">
                        <i class="fa fa-circle fa-stack-2x"></i>
                        <i class="fa fa-plus fa-stack-1x fa-inverse"></i>
                    </span>

                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" id="dataempleado" style="display: none; padding-top: 5px; padding-bottom: 15px; padding-left: 2px; background: #FFF;">

                        <ul class="nav nav-tabs">
                            <li class="active" id="infopersonal">
                                <a data-toggle="tab" href="#tab-1"><i class="fa fa-briefcase"></i>
                                    <span class="hidden-xs">Información Personal</span></a>
                            </li>
                            <li class="" style="display: none;" id="Contrato">
                                <a data-toggle="tab" href="#tab-3"><i class="fa fa-file-text"></i>
                                    <span class="hidden-xs">Contrato</span></a>
                            </li>
                        </ul>
                        <div class="tab-content">
                            <div id="tab-1" class="tab-pane active">
                                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">


                                    <div class="divclientinfo">
                                        <div class="form-group">
                                            <div class="col-lg-10 col-md-10 col-sm-12 col-xs-12">
                                                <div class="row">
                                                    <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                                        <div class="form-group">
                                                            <label for="id_tipoiden" class="active">Tipo iden:</label>
                                                            <select id="id_tipoiden" runat="server" clientidmode="static" data-size="8" class="form-control trabajador selectpicker" title="Seleccione" data-live-search="true">
                                                            </select>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                                        <div class="input-group ">
                                                            <div class="form-group">
                                                                <label for="iden" class="active">Identificación:</label>
                                                                <input id="iden" type="text" placeholder=" " class="form-control trabajador" value="" autocomplete="off" />
                                                            </div>
                                                            <span class="input-group-addon ">
                                                                <label id="identificacion" class="lado" for="iden" style="margin-left: 8px; font-family: sans-serif; color: #3d3f41a8" onfocus="false">0</label>
                                                            </span>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                                        <div class="form-group ">
                                                            <label for="fechaexp" class="active">Fecha de Exp:</label>
                                                            <input type="text" class="form-control trabajador" id="fechaexp" date="true" format="YYYY-MM-DD" />
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12 extran">
                                                        <div class="form-group">
                                                            <label for="fechavenpas" class="active">Fecha de Venc:</label>
                                                            <input type="text" class="form-control trabajador " id="fechavenpas" date="true" format="YYYY-MM-DD" />
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12 extran">
                                                        <div class="form-group" style="margin-bottom: 10px!important">
                                                            <label for="certijudicial" class="active">Certificado Judicial:</label>
                                                            <div class="file-loading">
                                                                <input id="certijudicial" name="certificado" type="file" data-name="CERTIFICADO" data-show-preview="true" data-allowed-file-extensions='["pdf"]' />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                                        <div class="form-group">
                                                            <label for="pnombre" class="active">Primer nombre:</label>
                                                            <input id="pnombre" type="text" placeholder=" " class="form-control trabajador" value="" runat="server" clientidmode="static" />
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                                        <div class="form-group">
                                                            <label for="snombre" class="active">Segundo nombre:</label>
                                                            <input id="snombre" type="text" placeholder=" " class="form-control trabajador" />
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                                        <div class="form-group">
                                                            <label for="papellido" class="active">Primer apellido:</label>
                                                            <input id="papellido" type="text" placeholder=" " class="form-control trabajador" value="" />
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                                        <div class="form-group">
                                                            <label for="sapellido" class="active">Segundo apellido:</label>
                                                            <input id="sapellido" type="text" placeholder=" " class="form-control trabajador" value="" />
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                                        <div class="form-group ">
                                                            <label for="fechacaci" class="active">Fecha Nacimiento:</label>
                                                            <input type="text" class="form-control trabajador" id="fechacaci" date="true" format="YYYY-MM-DD" />
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                                        <div class="form-group">
                                                            <label for="profesion" class="active">Profesión:</label>
                                                            <input id="profesion" type="text" placeholder=" " class="form-control trabajador" value="" runat="server" clientidmode="static" />
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                                        <div class="form-group">
                                                            <label for="universidad" class="active">Universidad:</label>
                                                            <input id="universidad" type="text" placeholder=" " class="form-control trabajador" value="" runat="server" clientidmode="static" />
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                                        <div class="form-group">
                                                            <label for="escolaridad" class="active">Escolaridad:</label>
                                                            <select id="escolaridad" runat="server" clientidmode="static" data-size="8" class="form-control trabajador selectpicker" title="Seleccione" data-live-search="true">
                                                            </select>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                                        <div class="form-group">
                                                            <label for="estrato" class="active">Estrato:</label>
                                                            <select id="estrato" runat="server" clientidmode="static" data-size="8" class="form-control trabajador selectpicker" title="Seleccione" data-live-search="true">
                                                            </select>
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                                        <div class="form-group">
                                                            <label for="nacionalidad" class="active">Nacionalidad:</label>
                                                            <input id="nacionalidad" type="text" placeholder=" " class="form-control trabajador" value="" runat="server" clientidmode="static" />
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
                                                        <div class="form-group">
                                                            <label for="direccion" class="active">Direccion Residencia:</label>
                                                            <input id="direccion" type="text" placeholder=" " class="form-control trabajador" value="" runat="server" clientidmode="static" readonly />
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                                                        <div class="form-group">
                                                            <label for="Text_city" class="active">Ciudad:</label>
                                                            <select runat="server" clientidmode="static" id="Text_city" data-size="8" class="form-control trabajador selectpicker" title="Ciudad" data-live-search="true">
                                                            </select>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                                                        <div class="form-group">
                                                            <label for="genero" class="active">Genero:</label>
                                                            <select id="genero" runat="server" clientidmode="static" data-size="8" class="form-control trabajador selectpicker" title="Seleccione" data-live-search="true">
                                                            </select>
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                                        <div class="form-group">
                                                            <label for="ecivil" class="active">Estado civil:</label>
                                                            <select id="ecivil" runat="server" clientidmode="static" data-size="8" class="form-control trabajador selectpicker" title="Seleccione" data-live-search="true">
                                                            </select>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                                        <div class="form-group">
                                                            <label for="pcargo" class="active">Per. a cargo:</label>
                                                            <input id="pcargo" type="text" placeholder=" " class="form-control trabajador" maxlength="2" money="true" data-a-dec="." data-a-sep="" data-m-dec="0" data-v-max="99999999999999" />
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                                        <div class="form-group">
                                                            <label for="TipoSangre" class="active">Tipo de Sangre:</label>
                                                            <select id="TipoSangre" runat="server" clientidmode="static" data-size="8" class="form-control trabajador selectpicker" title="Seleccione" data-live-search="true">
                                                            </select>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                                        <div class="form-group">
                                                            <label for="scelular" class="active">Celular:</label>
                                                            <input id="scelular" type="text" placeholder=" " class="form-control trabajador notbloque" value="" money="true" data-m-dec="0" data-v-max="9999999999" data-a-sep="" autocomplete="off" />
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                                        <div class="form-group">
                                                            <label for="sotrotel" class="active">Tel Alternativo:</label>
                                                            <input id="sotrotel" type="text" placeholder=" " class="form-control trabajador notbloque" value="" money="true" data-m-dec="0" data-v-max="9999999999" data-a-sep="" autocomplete="off" />
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                                        <div class="form-group">
                                                            <label for="scorreo" class="active">Correo:</label>
                                                            <input id="scorreo" type="text" placeholder=" " class="form-control trabajador notbloque" value="" autocomplete="off" />
                                                        </div>
                                                    </div>


                                                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                                                        <div class="form-group" style="margin-bottom: 10px!important">
                                                            <label for="soporte" class="active">Soporte de estudio:</label>
                                                            <div class="file-loading">
                                                                <input id="soporte" name="soporte" type="file" data-name="SOPORTE" multiple="multiple" data-show-preview="true" data-allowed-file-extensions='["pdf"]' />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <%--<div class="col-lg-4">
                                                    <div class="form-group">
                                                        <label>Archivos subidos:</label>
                                                        <div class="file-saves">
                                                            <ul class="list-group clear-list m-t" id="filesaves">
                                                            </ul>
                                                        </div>
                                                    </div>
                                                </div>--%>
                                                    <div class="col-md-2 col-lg-2 col-sm-4 col-xs-4" style="display: none; padding-top: 0 !important; padding-right: 0px !important; width: 125px !important;">
                                                        <div class="form-group">
                                                            <label for="ch_Discapasidad" class="active">Discapasidad?</label>
                                                            <div class="check-mail">
                                                                <input type="checkbox" class="pull-right trabajador" id="ch_Discapasidad" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <br />
                                                </div>
                                            </div>

                                            <div class="col-lg-2 col-md-2 col-sm-12 col-xs-12">
                                                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="border: 1px solid #ccc;">
                                                    <div class="form-group">
                                                        <label>Foto</label>
                                                        <input id="foto" name="foto" data-name="FOTO" type="button" runat="server" clientidmode="Static" class="dropify" data-height="205" data-max-file-size="5M"
                                                            data-allowed-file-extensions="jpg png jpeg" data-max-file-size-preview="5M" />
                                                    </div>
                                                    <div class="row">
                                                        <br />
                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                        <div class="col-lg-12"></div>
                                        <%-- <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                                <div class="form-group">
                                                    <label for="fechaexpcer" class="active">Fecha de Exp:</label>
                                                    <input type="text" class="form-control trabajador extran" id="fechaexpcer" date="true" format="YYYY-MM-DD"/>
                                                </div>
                                            </div>
                                            <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                                <div class="form-group">
                                                    <label for="fechavencer" class="active">Fecha de Ven:</label>
                                                    <input type="text" class="form-control trabajador extran" id="fechavencer" date="true" format="YYYY-MM-DD"/>
                                                </div>
                                            </div>--%>


                                        <br />
                                        <br />
                                        <div class="row discapasidad">
                                            <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                                <div class="form-group">
                                                    <label for="tipodis" class="active" style="font-size: 12px !important; text-align: center; margin-left: -12px !important; margin-top: -15px !important;">Tipo de Discapasidad:</label>
                                                    <select id="tipodis" runat="server" clientidmode="static" data-size="8" class="form-control trabajador selectpicker" title="Seleccione" data-live-search="true">
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                                <div class="form-group">
                                                    <label for="porcentaje" class="active">Porcentaje:</label>
                                                    <input id="porcentaje" type="text" placeholder=" " class="form-control trabajador" money="true" data-m-dec="0" data-v-max="999" />
                                                    <%-- numerico --%>
                                                </div>
                                            </div>
                                            <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                                <div class="form-group">
                                                    <label for="grado" class="active">Grado:</label>
                                                    <input id="grado" type="text" placeholder=" " class="form-control trabajador" money="true" data-m-dec="0" data-v-max="999" />
                                                    <%-- numerico --%>
                                                </div>
                                            </div>
                                            <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                                <div class="form-group">
                                                    <label for="carnet" class="active">Carnet No:</label>
                                                    <input id="carnet" type="text" placeholder=" " class="form-control trabajador" />
                                                </div>
                                            </div>
                                            <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                                <div class="form-group">
                                                    <label for="fechaexpdis" class="active">Fecha de Exp:</label>
                                                    <input type="text" class="form-control trabajador" id="fechaexpdis" date="true" format="YYYY-MM-DD" />
                                                </div>
                                            </div>
                                            <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                                <div class="form-group">
                                                    <label for="vencimiento" class="active">Vencimiento:</label>
                                                    <input id="vencimiento" type="text" placeholder=" " class="form-control trabajador" date="true" format="YYYY-MM-DD" />
                                                </div>
                                            </div>
                                        </div>
                                        <br />
                                        <div class="row conyuge" style="display: none">
                                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12"
                                                style="padding-top: 5px; padding-bottom: 15px;" id="conyugeinfo">
                                                <h2 class="title-master" style="margin-top: 0;"><span class="fa fa-slideshare fa-fw"></span>Conyuge</h2>
                                                <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                                    <div class="form-group">
                                                        <label for="congenero" class="active">Genero:</label>
                                                        <select id="congenero" runat="server" clientidmode="static" data-size="8" class="form-control trabajador selectpicker" title="Seleccione" data-live-search="true">
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                                    <div class="form-group">
                                                        <label for="confecha_naci" class="active">Fecha de Nacimiento:</label>
                                                        <input type="text" class="form-control trabajador" id="confecha_naci" date="true" format="YYYY-MM-DD" />
                                                    </div>
                                                </div>
                                                <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                                    <div class="form-group">
                                                        <label for="conprofesion" class="active">Profesión:</label>
                                                        <input id="conprofesion" type="text" placeholder=" " class="form-control trabajador" value="" runat="server" clientidmode="static" />
                                                    </div>
                                                </div>
                                                <div class="col-lg-2 col-md-4 col-sm-6 col-xs-12">
                                                    <div class="form-group">
                                                        <label for="nconyuge" class="active">Nombres:</label>
                                                        <input id="nconyuge" type="text" placeholder=" " class="form-control trabajador " value="" />
                                                    </div>
                                                </div>
                                                <div class="col-lg-2 col-md-4 col-sm-6 col-xs-12">
                                                    <div class="form-group">
                                                        <label for="aconyuge" class="active">Apellidos:</label>
                                                        <input id="aconyuge" type="text" placeholder=" " class="form-control trabajador" value="" />
                                                    </div>
                                                </div>
                                                <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                                    <div class="form-group">
                                                        <label for="coniden" class="active">Identificación:</label>
                                                        <input id="coniden" type="text" placeholder=" " class="form-control trabajador" data-v-max="9999999999" data-a-sep="" autocomplete="off" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row jumbo-tables">
                                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12"
                                                style="padding-top: 5px; padding-bottom: 15px; display: none" id="tablahijos">
                                                <h2 class="title-master" style="margin-top: 0;"><span class="fa fa-users fa-fw"></span>Hijos</h2>
                                                <div class=" row">
                                                    <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                                        <div class="form-group">
                                                            <label for="idenhijo" class="active">Identificación:</label>
                                                            <input type="text" class="form-control notbloque trabajador" id="idenhijo" placeholder=" " maxlength="120" />
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                                        <div class="form-group">
                                                            <label for="nombrehijo" class="active">Nombres:</label>
                                                            <input type="text" class="form-control notbloque trabajador" id="nombrehijo" placeholder=" " maxlength="120" />
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                                        <div class="form-group">
                                                            <label for="apellhijo" class="active">Apellidos:</label>
                                                            <input type="text" class="form-control notbloque trabajador" id="apellhijo" placeholder=" " maxlength="120" />
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                                        <div class="form-group">
                                                            <label for="hijogenero" class="active">Genero:</label>
                                                            <select id="hijogenero" runat="server" clientidmode="static" data-size="8" class="form-control selectpicker notbloque trabajador" title="Seleccione">
                                                            </select>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                                        <div class="form-group">
                                                            <label for="hijo_profesion" class="active">Profesión:</label>
                                                            <select id="hijo_profesion" runat="server" clientidmode="static" data-size="4" class="form-control selectpicker notbloque trabajador" title="Seleccione">
                                                            </select>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-1 col-md-1 col-sm-6 col-xs-12">
                                                        <button id="addref" type="button" class="btn btn-sin btn-circle addarticle notbloque trabajador" title="Agregar" style="margin-top: 10px; margin-bottom: 10px;"><i class="fa fa-plus"></i></button>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                                        <div class="table-responsive" style="max-height: 300px;">
                                                            <table class="table table-striped jambo_table" id="tblreferenhijos">
                                                                <thead>
                                                                    <tr>
                                                                        <th class="text-center">#</th>
                                                                        <th class="text-center">Identificación</th>
                                                                        <th class="text-center">Nombres</th>
                                                                        <th class="text-center">Apellidos</th>
                                                                        <th class="text-center">Genero</th>
                                                                        <th class="text-center">Profesión</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody id="tbodyhijos">
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </div>
                                                </div>


                                            </div>

                                        </div>


                                        <div class="row jumbo-tables">
                                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12"
                                                style="padding-top: 5px; padding-bottom: 15px; display: none" id="tablacontrato">
                                                <h2 class="title-master" style="margin-top: 0;"><span class="fa fa-users fa-fw"></span>Contratos</h2>
                                                <div class="row">
                                                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                                        <div class="table-responsive" style="max-height: 300px;">
                                                            <table class="table table-striped jambo_table" id="tblcontratop">
                                                                <thead>
                                                                    <tr>
                                                                        <th data-column-id="ver" data-formatter="ver" data-sortable="false" style="max-width: 30px !important;">ver</th>
                                                                        <th data-column-id="consecutivo">Consecutivo</th>
                                                                        <th data-column-id="tipo">Tipo</th>
                                                                        <th data-column-id="salario" data-formatter="salario">Salario</th>
                                                                        <th data-column-id="diasapagar">Días para pagar</th>
                                                                        <th data-column-id="fecha">Fecha inicio</th>
                                                                        <th data-column-id="centrocosto">Lugar de trabajo</th>
                                                                        <th data-column-id="estado" data-formatter="estado">Estado</th>
                                                                    </tr>
                                                                </thead>
                                                            </table>
                                                        </div>
                                                    </div>
                                                </div>
                                                <input type="hidden" value="" runat="server" clientidmode="static" id="htmlestado" />

                                            </div>

                                        </div>





                                    </div>

                                </div>


                                <%--Modal eñ cual tiene todos los campos para capturar y guardar la imagen de la persona (sea deudor o codeudor)--%>
                                <div class="modal fade" id="ModalFoto">
                                    <div class="modal-dialog modal-md" id="pic" role="document">
                                        <div class="modal-content" id="modal-foto">
                                            <div class="modal-header">
                                                <button type="button" class="close salgo" data-dismiss="modal" aria-label="Close">
                                                    <span aria-hidden="true">&times</span>
                                                </button>
                                                <h2 class="modal-title">FOTO</h2>
                                            </div>
                                            <div class="modal-body clearfix" style="margin-bottom: 0;">
                                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6 sn-padding">
                                                    <video muted="muted" id="video" style="margin-left: 1px"></video>
                                                    <canvas id="canvas" style="display: none;"></canvas>
                                                    <div style="text-align: center; margin-top: -43px !important;">
                                                        <button id="boton" class="btn btn-outline btn-primary dim" style="width: 40px; height: 40px; margin-top: 15px; margin-right: 0px;">
                                                            <i class="fa fa-camera"></i>
                                                        </button>
                                                    </div>
                                                </div>
                                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6 sn-padding">
                                                    <label>Foto</label>
                                                    <input type="hidden" name="listaDeDispositivos" id="listaDeDispositivos" />
                                                    <input type="hidden" id="estado" />

                                                    <div class="form-group">
                                                        <input id="previa" name="previa" data-name="PREVIA" type="text" runat="server" clientidmode="Static" class="dropify xoc" data-height="205" data-max-file-size="5M"
                                                            data-allowed-file-extensions="jpg png jpeg" data-max-file-size-preview="5M" />
                                                    </div>
                                                </div>
                                                <div class="row buttonaction pull-right">
                                                    <button title="Guardar" id="btnSavePhoto" data-option="I" class="btn btn-outline btn-primary dim waves-effect waves-light" type="button"><i class="fa fa-paste"></i></button>
                                                    <button title="Cancelar" id="btnCancelPhoto" class="btn btn-outline btn-danger  dim waves-effect waves-light" data-dismiss="modal" aria-label="Close" type="button"><i class="fa-file-o fa"></i></button>
                                                </div>
                                            </div>



                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div id="tab-3" class="tab-pane">
                                <div class="col-lg-12">

                                    <div class="row">
                                        <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
                                            <div class="form-group">
                                                <label for="NombreEmp" class="active">Nombre:</label>
                                                <input id="NombreEmp" type="text" placeholder=" " class="form-control" runat="server" clientidmode="static" disabled="disabled" />
                                            </div>
                                        </div>
                                        <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
                                            <div class="form-group">
                                                <label for="Iden" class="active">Identificación:</label>
                                                <input id="Iden" type="text" placeholder=" " class="form-control" runat="server" clientidmode="static" disabled="disabled" />
                                            </div>
                                        </div>
                                        <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
                                            <div class="form-group">
                                                <label for="codContrato" class="active">Codigo:</label>
                                                <input id="codContrato" type="text" placeholder=" " class="form-control" value="" runat="server" clientidmode="static" disabled="disabled" />
                                            </div>
                                        </div>
                                    </div>
                                    <br />

                                    <div class="row">
                                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                            <div class="form-group">
                                                <label for="contratacion" class="active">Contratación:</label>
                                                <select id="contratacion" runat="server" clientidmode="static" data-size="8" class="form-control contrato cont selectpicker" title="Seleccione" data-live-search="true">
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                            <div class="form-group">
                                                <label for="tipocontrato" class="active">Tipo de Contrato:</label>
                                                <select id="tipocontrato" runat="server" clientidmode="static" data-size="8" class="form-control contrato cont selectpicker" title="Seleccione" data-live-search="true">
                                                </select>
                                            </div>
                                        </div>

                                        <div class="col-md-2 col-lg-2 col-sm-6 col-xs-6" style="padding-top: 0 !important; padding-right: 0px !important;">
                                            <div class="form-group">
                                                <label for="ch_CotExtrangero" class="active">Cotiza en el Extranjero?</label>
                                                <div style="padding-left: 30px;">
                                                    <div class="check-mail">
                                                        <input type="checkbox" class="i-checks pull-right contrato cont" id="ch_CotExtrangero" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>


                                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12 sn-padding">
                                            <div class="form-group">
                                                <label for="tipocot" class="active">Tipo de Cotizante:</label>
                                                <input type="hidden" id="id_tipocot" value="0" />
                                                <input type="text" class="form-control actionautocomple inputsearch contrato" id="tipocot" aria-describedby="sizing-addon1" data-search="RHumanos" data-method="NominaBuscador" data-params="op:T;o:#;tipo:#" data-result="value:name;data:id" data-idvalue="id_tipocot" />
                                            </div>
                                        </div>

                                        <div class="col-md-2 col-lg-2 col-sm-6 col-xs-6" style="padding-right: 0px !important;">
                                            <div class="form-group">
                                                <label for="ch_salinte" class="active">Salario Integral?</label>
                                                <div style="padding-left: 30px;">
                                                    <div class="check-mail">
                                                        <input type="checkbox" class="i-checks pull-right contrato cont" id="ch_salinte" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <%--<div class="form-group">
                                            <label for="ch_Discapasidad" class="active">Discapasidad?</label>
                                            <div class="check-mail">
                                                <input type="checkbox" class="pull-right trabajador" id="ch_Discapasidad" />
                                            </div>
                                        </div>--%>
                                        <%--<div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                                <div class="form-group">
                                                    <label for="tipovincula" class="active">Tipo de Voinculación:</label>
                                                    <select id="tipovincula" runat="server" clientidmode="static" data-size="8" class="form-control contrato selectpicker" title="Seleccione" data-live-search="true">
                                                    </select>
                                                </div>
                                            </div>--%>
                                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                            <div class="form-group">
                                                <label for="salario" class="active">Salario:</label>
                                                <input id="salario" type="text" placeholder=" " class="form-control contrato cont" money="true" data-a-dec="." />
                                            </div>
                                        </div>
                                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                            <div class="form-group">
                                                <label for="tiponom" class="active">Tipo de Nomina:</label>
                                                <select id="tiponom" runat="server" clientidmode="static" data-size="8" class="form-control contrato selectpicker cont" title="Seleccione" data-live-search="true">
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12 diasparapag" style="display: none">
                                            <div class="form-group">
                                                <label for="diaspag" class="active">Días para pagar:</label>
                                                <input id="diaspag" type="text" placeholder=" " class="form-control contrato cont" />
                                            </div>
                                        </div>
                                        <div class="col-md-1 col-lg-1 col-sm-1 col-xs-1 " style="padding-top: 0 !important; padding-left: 2px !important; display: none">
                                            <div class="form-group">
                                                <label for="ch_Convenio" class="active">Convenio?</label>
                                                <div class="check-mail">
                                                    <input type="checkbox" class="pull-right i-checks cont contrato" id="ch_Convenio" />
                                                </div>
                                            </div>
                                        </div>
                                        <%--<div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                                <div class="form-group">
                                                    <label for="persep_salarial" class="active">Persepciones Salariales:</label>
                                                    <input id="persep_salarial" type="text" placeholder=" " class="form-control contrato" value="" />
                                                </div>
                                            </div>--%>

                                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                            <div class="form-group">
                                                <label for="fechainicontra" class="active">Fecha de Inicio:</label>
                                                <input type="text" class="form-control contrato cont" id="fechainicontra" placeholder="Fecha inicial" date="true" format="YYYY-MM-DD" <%--current="true"--%> />
                                            </div>
                                        </div>

                                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12" id="fechafin" style="display: none">
                                            <div class="form-group">
                                                <label for="fechafincontra" class="active">Finalización:</label>
                                                <input type="text" class="form-control contrato cont" id="fechafincontra" placeholder="Fecha final" date="true" format="YYYY-MM-DD" <%--current="true"--%> />
                                            </div>
                                        </div>

                                        <div class="col-md-2 col-lg-2 col-sm-6 col-xs-6" style="padding-top: 0 !important; padding-left: 2px !important;">
                                            <div class="form-group">
                                                <label for="ch_jefe" class="active">Tiene Personas a cargo?</label>
                                                <div style="padding-left: 30px;">
                                                    <div class="check-mail">
                                                        <input type="checkbox" class="i-checks pull-right contrato cont" id="ch_jefe" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12 sn-padding">
                                            <div class="form-group">
                                                <label for="jefe" class="active">Jefe Directo:</label>
                                                <input type="hidden" id="id_jefe" value="0" />
                                                <input type="text" class="form-control actionautocomple inputsearch contrato" id="jefe" aria-describedby="sizing-addon1" data-search="RHumanos" data-method="NominaBuscador" data-params="op:J;o:#;tipo:#" data-result="value:name;data:id" data-idvalue="id_jefe" />
                                            </div>
                                        </div>

                                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12 sn-padding">
                                            <div class="form-group">
                                                <label for="area" class="active">Area:</label>
                                                <input type="hidden" id="id_area" value="0" />
                                                <input type="text" class="form-control actionautocomple inputsearch contrato" id="area" aria-describedby="sizing-addon1" data-search="RHumanos" data-method="NominaBuscador" data-params="op:A;o:#;tipo:#" data-result="value:name;data:id" data-idvalue="id_area" />
                                            </div>
                                        </div>
                                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                            <div class="form-group">
                                                <label for="cargo" class="active">Cargo:</label>
                                                <select id="cargo" runat="server" clientidmode="static" data-size="8" class="form-control contrato cont selectpicker" title="Seleccione" data-live-search="true">
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12 cargo">
                                            <div class="form-group">
                                                <label for="funesp" class="active">Funciones Esp:</label>
                                                <input id="funesp" type="text" placeholder="Separar por coma ','" class="form-control contrato cont" value="" runat="server" clientidmode="static" />
                                            </div>
                                        </div>
                                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                            <div class="form-group">
                                                <label for="horario" class="active">Horario:</label>
                                                <select id="horario" runat="server" clientidmode="static" data-size="8" class="form-control contrato cont selectpicker" title="Seleccione" data-live-search="true">
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12 sn-padding">
                                            <div class="form-group">
                                                <label for="eps" class="active">EPS:</label>
                                                <input type="hidden" id="id_eps" value="0" />
                                                <input type="text" class="form-control actionautocomple inputsearch contrato" id="eps" aria-describedby="sizing-addon1" data-search="RHumanos" data-method="NominaBuscador" data-params="op:E;o:#;tipo:#" data-result="value:name;data:id" data-idvalue="id_eps" />
                                            </div>
                                        </div>
                                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12 sn-padding">
                                            <div class="form-group">
                                                <label for="cesan" class="active">Cesantías:</label>
                                                <input type="hidden" id="id_cesan" value="0" />
                                                <input type="text" class="form-control actionautocomple inputsearch contrato" id="cesan" aria-describedby="sizing-addon1" data-search="RHumanos" data-method="NominaBuscador" data-params="op:P;o:#;tipo:#" data-result="value:name;data:id" data-idvalue="id_cesan" />
                                            </div>
                                        </div>
                                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12 sn-padding">
                                            <div class="form-group">
                                                <label for="pen" class="active">Pensión:</label>
                                                <input type="hidden" id="id_pen" value="0" />
                                                <input type="text" class="form-control actionautocomple inputsearch contrato" id="pen" aria-describedby="sizing-addon1" data-search="RHumanos" data-method="NominaBuscador" data-params="op:P;o:#;tipo:#" data-result="value:name;data:id" data-idvalue="id_pen" />
                                            </div>
                                        </div>
                                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12 sn-padding">
                                            <div class="form-group">
                                                <label for="cajacomp" class="active">Cajas de Compensación:</label>
                                                <input type="hidden" id="id_cajacomp" value="0" />
                                                <input type="text" class="form-control actionautocomple inputsearch contrato" id="cajacomp" aria-describedby="sizing-addon1" data-search="RHumanos" data-method="NominaBuscador" data-params="op:O;o:#;tipo:#" data-result="value:name;data:id" data-idvalue="id_cajacomp" />
                                            </div>
                                        </div>
                                        <%--<div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                                <div class="form-group">
                                                    <label for="nomina" class="active">Nomina:</label>
                                                    <select id="nomina" runat="server" clientidmode="static" data-size="8" class="form-control contrato selectpicker" title="Seleccione" data-live-search="true">
                                                    </select>

                                                </div>
                                            </div>--%>
                                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                            <div class="form-group">
                                                <label for="formapago" class="active">Forma de Pago:</label>
                                                <select id="formapago" runat="server" clientidmode="static" data-size="8" class="form-control contrato cont selectpicker" title="Seleccione" data-live-search="true">
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12 formpago">
                                            <div class="form-group">
                                                <label for="ncuenta" class="active">N° de Cuenta:</label>
                                                <input id="ncuenta" type="text" placeholder=" " class="form-control contrato cont" value="" runat="server" clientidmode="static" />
                                            </div>
                                        </div>
                                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12 formpago">
                                            <div class="form-group">
                                                <label for="tipocuenta" class="active">Tipo de cuenta:</label>
                                                <select id="tipocuenta" runat="server" clientidmode="static" data-size="8" class="form-control contrato cont selectpicker" title="Seleccione" data-live-search="true">
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12 formpago sn-padding">
                                            <div class="form-group">
                                                <label for="banco" class="active">Banco:</label>
                                                <input type="hidden" id="id_banco" value="0" />
                                                <input type="text" class="form-control actionautocomple inputsearch contrato" id="banco" aria-describedby="sizing-addon1" data-search="RHumanos" data-method="NominaBuscador" data-params="op:B;o:#;tipo:#" data-result="value:name;data:id" data-idvalue="id_banco" />
                                            </div>
                                        </div>
                                        <%--<div class="col-lg-2 col-md-2 col-sm-6 col-xs-12 formpagotro">
                                                <div class="form-group">
                                                    <label for="otaformapag" class="active">Cual?</label>
                                                    <input id="otaformapag" type="text" placeholder=" " class="form-control contrato " value="" runat="server" clientidmode="static" />
                                                </div>
                                            </div>--%>
                                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                            <div class="form-group">
                                                <label for="tipojor" class="active">Tipo de Jornada:</label>
                                                <select id="tipojor" runat="server" clientidmode="static" data-size="8" class="form-control contrato selectpicker cont" title="Seleccione" data-live-search="true">
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                                            <div class="form-group">
                                                <label for="centrocosac" class="active">Lugar de contratacion:</label>
                                                <select id="centrocosac" runat="server" clientidmode="static" data-size="8" class="form-control contrato cont selectpicker" title="Seleccione" data-live-search="true">
                                                </select>

                                            </div>
                                        </div>
                                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                                            <div class="form-group">
                                                <label for="centrocostra" class="active">Centro de Costo donde va a laborar:</label>
                                                <select id="centrocostra" runat="server" clientidmode="static" data-size="8" class="form-control contrato cont selectpicker" title="Seleccione" data-live-search="true">
                                                </select>

                                            </div>
                                        </div>
                                        <div class="col-md-2 col-lg-2 col-sm-6 col-xs-12" style="padding-top: 0 !important; padding-left: 0px !important; padding-bottom: 11px !important;">
                                            <div class="form-group">
                                                <label for="ch_ley" class="active">Ley 50?</label>
                                                <div style="padding-left: 30px;">
                                                    <div class="check-mail">
                                                        <input type="checkbox" class="i-checks pull-right " id="ch_ley" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <%--<div class="col-md-2 col-lg-2 col-sm-6 col-xs-6" style="padding-top: 0 !important; padding-left: 2px !important;">
                                            <div class="form-group">
                                                <label for="ch_jefe" class="active">Tiene Personas a cargo?</label>
                                                <div style="padding-left: 30px;">
                                                    <div class="check-mail">
                                                        <input type="checkbox" class="i-checks pull-right contrato cont" id="ch_jefe" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>--%>

                                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                            <div class="form-group">
                                                <label for="proce" class="active">Procedimiento:</label>
                                                <select id="proce" runat="server" clientidmode="static" data-size="8" class="form-control contrato cont selectpicker" title="Seleccione" data-live-search="true">
                                                </select>
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


        <%--Modal para tomar la direccion de la persona (sea deudor o codeudor)--%>
        <div class="modal fade" id="ModalDirecciones">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times</span>
                        </button>
                        <h2 class="modal-title">Completar Dirección</h2>
                    </div>
                    <div class="modal-body clearfix" style="margin-bottom: 0;">
                        <div class="">
                            <div class="">
                                <div class="col-lg-11 justify-content-center">
                                    <button type="button" class="btn btn-default w-palabra inputaddress" data-dian="AUT " data-dir="AUTOPISTA " con-nombre="1">Autopista</button>
                                    <button type="button" class="btn btn-default w-palabra inputaddress" data-dian="AV " data-dir="AVENIDA " con-nombre="1">Avenida</button>
                                    <button type="button" class="btn btn-default w-palabra inputaddress" data-dian="AK " data-dir="AVENIDA CARRERA " con-nombre="1">Avenida Carrera</button>
                                    <button type="button" class="btn btn-default w-palabra inputaddress" data-dian="AC " data-dir="AVENIDA CALLE " con-nombre="1">Avenida Calle</button>
                                    <button type="button" class="btn btn-default w-palabra inputaddress" data-dian="BRR " data-dir="BARRIO " con-nombre="1">Barrio</button>
                                    <button type="button" class="btn btn-default w-palabra inputaddress" data-dian="BLV " data-dir="BOULEVAR " con-nombre="1">Boulevar</button>
                                    <button type="button" class="btn btn-default w-palabra inputaddress" data-dian="CLL " data-dir="CALLE " con-nombre="1">Calle</button>
                                    <button type="button" class="btn btn-default w-palabra inputaddress" data-dian="CR " data-dir="CARRERA " con-nombre="1">Carrera</button>
                                    <button type="button" class="btn btn-default w-palabra inputaddress" data-dian="CRV " data-dir="CIRCUNVALAR ">Circunvalar</button>

                                    <button type="button" class="btn btn-default w-palabra inputaddress" data-dian="CON " data-dir="CONJUNTO RESIDENCIAL " con-nombre="1">Conjunto Residencial</button>
                                    <button type="button" class="btn btn-default w-palabra inputaddress" data-dian="DPTO " data-dir="DEPARTAMENTO " con-nombre="1">Departamento</button>
                                    <button type="button" class="btn btn-default w-palabra inputaddress" data-dian="DG " data-dir="DIAGONAL ">Diagonal</button>
                                    <button type="button" class="btn btn-default w-palabra inputaddress" data-dian="ED " data-dir="EDIFICIO " con-nombre="1">Edificio</button>
                                    <button type="button" class="btn btn-default w-palabra inputaddress" data-dian="FCA " data-dir="FINCA " con-nombre="1">Finca</button>
                                    <button type="button" class="btn btn-default w-palabra inputaddress" data-dian="KM " data-dir="KILÓMETRO ">Kilómetro</button>
                                    <button type="button" class="btn btn-default w-palabra inputaddress" data-dian="LC " data-dir="LOCAL ">Local</button>
                                    <button type="button" class="btn btn-default w-palabra inputaddress" data-dian="NORTE " data-dir="NORTE ">Norte</button>
                                    <button type="button" class="btn btn-default w-palabra inputaddress" data-dian="OF " data-dir="OFICINA ">Oficina</button>

                                    <button type="button" class="btn btn-default w-palabra inputaddress" data-dian="SEC " data-dir="SECTOR " con-nombre="1">Sector</button>
                                    <button type="button" class="btn btn-default w-palabra inputaddress" data-dian="SUR " data-dir="SUR ">Sur</button>
                                    <button type="button" class="btn btn-default w-palabra inputaddress" data-dian="TO " data-dir="TORRE " con-nombre="1">Torre</button>
                                    <button type="button" class="btn btn-default w-palabra inputaddress" data-dian="TV " data-dir="TRANSVERSAL ">Transversal</button>
                                    <button type="button" class="btn btn-default w-palabra inputaddress" data-dian="URB " data-dir="URBANIZACIÓN " con-nombre="1">Urbanización</button>
                                    <button type="button" class="btn btn-default w-palabra inputaddress" data-dian="VDA " data-dir="VEREDA " con-nombre="1">Vereda</button>
                                    <div class="btn btn-default w-palabra ">
                                        <select class="form-control selectpicker form-group" id="comboaddress" tabindex="-1" data-size="8" runat="server" clientidmode="static" data-live-search="true">
                                            <option data-dian="" data-dir="">Más ...</option>
                                            <option data-dian="ADL " data-dir="ADELANTE " con-nombre="1">Adelante</option>
                                            <option data-dian="AD " data-dir="ADMINISTRACIÓN ">Administración</option>
                                            <option data-dian="AER " data-dir="AEROPUERTO " con-nombre="1">Aeropuerto</option>
                                            <option data-dian="AG " data-dir="AGENCIA " con-nombre="1">Agencia</option>
                                            <option data-dian="AGP " data-dir="AGRUPACIÓN " con-nombre="1">Agrupación</option>
                                            <option data-dian="ALD " data-dir="AL LADO " con-nombre="1">Al lado</option>
                                            <option data-dian="ALM " data-dir="ALMACÉN " con-nombre="1">Almacén</option>
                                            <option data-dian="AL " data-dir="ALTILLO ">Altillo</option>
                                            <option data-dian="APTDO " data-dir="APARTADO ">Apartado</option>
                                            <option data-dian="AP " data-dir="APARTAMENTO ">Apartamento</option>
                                            <option data-dian="ATR " data-dir="ATRAS " con-nombre="1">Atrás</option>
                                            <option data-dian="BL " data-dir="BLOQUE ">Bloque</option>
                                            <option data-dian="BG " data-dir="BODEGA ">Bodega</option>
                                            <option data-dian="CN " data-dir="CAMINO " con-nombre="1">Camino</option>
                                            <option data-dian="CRT " data-dir="CARRETERA " con-nombre="1">Carretera</option>
                                            <option data-dian="CA " data-dir="CASA " con-nombre="1">Casa</option>
                                            <option data-dian="CEL " data-dir="CELULA " con-nombre="1">Celula</option>
                                            <option data-dian="CC " data-dir="CENTRO COMERCIAL " con-nombre="1">Centro Comercial</option>
                                            <option data-dian="CIR " data-dir="CIRCULAR ">Circular</option>
                                            <option data-dian="CD " data-dir="CIUDADELA " con-nombre="1">Ciudadela</option>
                                            <option data-dian="CONJ " data-dir="CONJUNTO " con-nombre="1">Conjunto</option>
                                            <option data-dian="CS " data-dir="CONSULTORIO ">Consultorio</option>
                                            <option data-dian="CORR " data-dir="CORREGIMIENTO " con-nombre="1">Corregimiento</option>
                                            <option data-dian="DP " data-dir="DEPÓSITO " con-nombre="1">Depósito</option>
                                            <option data-dian="DS " data-dir="DEPÓSITO SOTANO ">Depósito Sotano</option>
                                            <option data-dian="EN " data-dir="ENTRADA " con-nombre="1">Entrada</option>
                                            <option data-dian="ESQ " data-dir="ESQUINA ">Esquina</option>
                                            <option data-dian="ESTE " data-dir="ESTE ">Este</option>
                                            <option data-dian="ET " data-dir="ETAPA " con-nombre="1">Etapa</option>
                                            <option data-dian="EX " data-dir="EXTERIOR ">Exterior</option>
                                            <option data-dian="GJ " data-dir="GARAJE ">Garaje</option>
                                            <option data-dian="GS " data-dir="GARAJE SOTANO ">Garaje Sotano</option>
                                            <option data-dian="HC " data-dir="HACIENDA " con-nombre="1">Hacienda</option>
                                            <option data-dian="IN " data-dir="INTERIOR ">Interior</option>
                                            <option data-dian="LM " data-dir="LOCAL MEZZANINE ">Local Mezzanine</option>
                                            <option data-dian="LT " data-dir="LOTE " con-nombre="1">Lote</option>
                                            <option data-dian="MZ " data-dir="MANZANA ">Manzana</option>
                                            <option data-dian="MN " data-dir="MEZZANINE ">Mezzanine</option>
                                            <option data-dian="MD " data-dir="MODULO " con-nombre="1">Modulo</option>
                                            <option data-dian="MCP " data-dir="MUNICIPIO " con-nombre="1">Municipio</option>
                                            <option data-dian="OCC " data-dir="OCCIDENTE ">Occidente</option>
                                            <option data-dian="OESTE " data-dir="OESTE ">Oeste</option>
                                            <option data-dian="O " data-dir="ORIENTE ">Oriente</option>
                                            <option data-dian="PA " data-dir="PARCELA " con-nombre="1">Parcela</option>
                                            <option data-dian="PAR " data-dir="PARQUE " con-nombre="1">Parque</option>
                                            <option data-dian="PQ " data-dir="PARQUEADERO " con-nombre="1">Parqueadero</option>
                                            <option data-dian="PJ " data-dir="PASAJE " con-nombre="1">Pasaje</option>
                                            <option data-dian="PS " data-dir="PASEO " con-nombre="1">Paseo</option>
                                            <option data-dian="PH " data-dir="PENTHOUSE ">Penthouse</option>
                                            <option data-dian="P " data-dir="PISO ">Piso</option>
                                            <option data-dian="PL " data-dir="PLANTA ">Planta</option>
                                            <option data-dian="POR " data-dir="PORTERÍA ">Portería</option>
                                            <option data-dian="PD " data-dir="PREDIO " con-nombre="1">Predio</option>
                                            <option data-dian="PN " data-dir="PUENTE " con-nombre="1">Puente</option>
                                            <option data-dian="PT " data-dir="PUESTO " con-nombre="1">Puesto</option>
                                            <option data-dian="SA " data-dir="SALÓN " con-nombre="1">Salón</option>
                                            <option data-dian="SC " data-dir="SALÓN COMUNAL " con-nombre="1">Salón Comunal</option>
                                            <option data-dian="SS " data-dir="SEMISOTANO ">Semisotano</option>
                                            <option data-dian="SL " data-dir="SOLAR ">Solar</option>
                                            <option data-dian="ST " data-dir="SOTANO ">Sotano</option>
                                            <option data-dian="SU " data-dir="SUITE " con-nombre="1">Suite</option>
                                            <option data-dian="SM " data-dir="SUPERMANZANA ">Supermanzana</option>
                                            <option data-dian="TER " data-dir="TERMINAL " con-nombre="1">Terminal</option>
                                            <option data-dian="TZ " data-dir="TERRAZA " con-nombre="1">Terraza</option>
                                            <option data-dian="UN " data-dir="UNIDAD " con-nombre="1">Unidad</option>
                                            <option data-dian="UR " data-dir="UNIDAD RESIDENCIAL " con-nombre="1">Unidad Residencial</option>
                                            <option data-dian="VTE " data-dir="VARIANTE " con-nombre="1">Variante</option>
                                            <option data-dian="ZN " data-dir="ZONA " con-nombre="1">Zona</option>
                                            <option data-dian="ZF " data-dir="ZONA FRANCA " con-nombre="1">Zona Franca</option>
                                        </select>
                                    </div>

                                </div>
                            </div>
                            <div class="col-lg-5 col-md-5 col-sm-4 col-xs-12 sn-padding">
                                <div class="form-group">
                                    <label for="tmpdireccion" class="active col-md-4" style="margin-left: -8px;">Nombre?</label>
                                    <input id="tmpdireccion" type="text" placeholder=" " class="form-control notbloque col-md-8" value="" style="margin-left: 5px; background: #1ab3946e;" />
                                </div>
                            </div>
                            <div class="col-lg-2 col-md-3 col-sm-4 col-xs-12 sn-padding" style="margin-top: 20px; margin-left: 5px;">
                                <button id="adddirec" type="button" class="btn btn-sin btn-circle addarticle notbloque" title="Agregar" style="height: 40px; width: 40px; margin-bottom: 10px;"><i class="fa fa-plus"></i></button>
                                <button id="remdirec" type="button" class="btn btn-sin btn-circle addarticle notbloque" title="Remover" style="height: 40px; width: 40px; margin-bottom: 10px; background: #9c2323 !important"><i class="fa fa-remove"></i></button>
                            </div>
                            <div class="col-lg-5 col-md-5 col-sm-4 col-xs-12 sn-padding">
                                <div class="row" style="margin-bottom: 5px; margin-left: 1px;">
                                    <input id="tempdir" class="form-control" type="text" placeholder="" style="text-transform: uppercase" readonly="true" disabled="" />
                                </div>
                            </div>
                        </div>
                        <div class=" row">
                            <div class="col-lg-12">
                                <button id="btnCance" type="button" data-id="0" class="pull-right btn btn-danger" data-dismiss="modal" aria-label="Close">Cancelar</button>
                                &nbsp;
                        <button id="btnSaveAdd" type="button" data-id="0" class="pull-right btn btn-primary ink-reaction btn-raised btn-loading-state" data-loading-text="<i class='fa fa-spinner fa-spin'></i> Cargando..." style="margin-right: 5px">Completar</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
    <span class="ir-arriba fa fa-sort-asc"></span>
    <script src="../Pages/ScriptsPage/Nomina/Empleados.js"></script>

    <script src="../Package/Vendor/js/plugins/fileinput/fileinput.js"></script>


    <script>
        $(function () {
            $('select').selectpicker();
            $('.i-checks').iCheck({
                checkboxClass: 'icheckbox_square-green',
                radioClass: 'iradio_square-green'

            });

        });

        $('.ir-arriba').click(function () {
            $('body, html').animate({
                scrollTop: '0px'
            }, 300);
        });

        $(window).scroll(function () {
            if ($(this).scrollTop() > 0) {
                $('.ir-arriba').slideDown(300);
            } else {
                $('.ir-arriba').slideUp(300);
            }
        });

        $(document).ready(function () {
            datepicker();

        });

        //document.addEventListener('DOMContentLoaded', function () {
        //    var calendarEl = document.getElementById('calendar');
        //    var calendar = new FullCalendar.Calendar(calendarEl, {
        //        displayEventTime: false,
        //        initialDate: '2019-04-01',
        //        headerToolbar: {
        //            left: 'prev,next today',
        //            center: 'title',
        //            right: 'dayGridMonth,listYear'
        //        },
        //        events: {
        //            url: 'ics/feed.ics',
        //            format: 'ics',
        //            failure: function () {
        //                document.getElementById('script-warning').style.display = 'block';
        //            }
        //        },
        //        loading: function (bool) {
        //            document.getElementById('loading').style.display =
        //                bool ? 'block' : 'none';
        //        }
        //    });
        //    calendar.render();
        //});
    </script>

</asp:Content>

