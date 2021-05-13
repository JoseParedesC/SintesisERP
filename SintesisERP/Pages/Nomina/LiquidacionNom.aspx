<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LiquidacionNom.aspx.cs" Inherits="LiquidacionNom" MasterPageFile="~/Masters/SintesisLayout.Master" %>


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

        .contrato {
            margin-bottom: 10px !important;
        }

        .ch {
            height: 20px;
            width: 20px;
            border-radius: 20px !important;
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

							   


        .codvalue {
            padding: 0 0 10px 0 !important;
            margin-bottom: 2px;
            border-style: none;
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

        .contra, .tabla1, .tabla2 {
            display: none;
        }






        .MuiPaper-elevation2 {
            box-shadow: 0px 4px 24px rgb(20 9 51 / 8%);
        }

        .MuiPaper-rounded {
            border-radius: 8px;
        }

        .MuiPaper-root {
            color: inherit;
            transition: box-shadow 300ms cubic-bezier(0.4, 0, 0.2, 1) 0ms;
            background-color: #fff;
        }

        .MuiTableContainer-root {
            width: 100%;
            box-shadow: 0px 2px 16px rgb(20 9 51 / 8%);
            overflow-x: auto;
            border-radius: 8px;
            padding-bottom: 8px;
            background-color: #fff;
        }

        .MuiTable-root {
            width: 100%;
            display: table;
            border-spacing: 0;
            border-collapse: collapse;
        }

        .MuiTableHead-root {
            display: table-header-group;
        }

            .MuiTableHead-root .MuiTableRow-root {
                border-bottom: 2px solid #E9E6F0;
            }

        .MuiTableRow-root {
            color: inherit;
            display: table-row;
            outline: 0;
            vertical-align: middle;
        }

        .jss59 {
            top: 0;
            z-index: 10;
            position: sticky;
            background-color: #fff;
        }

        .jss52, .title-master {
            margin-left: 25px;
            margin-right: 25px;
        }

        .MuiTableCell-alignLeft {
            text-align: left;
        }

        .MuiTableCell-head {
            color: #29282B;
            font-weight: 500;
            line-height: 1.5rem;
        }

        .MuiTableCell-root {
            height: 37px;
            display: table-cell;
            padding: 0 16px;
            font-size: 1.5rem;
            text-align: left;
            font-family: Roboto;
            font-weight: normal;
            line-height: 20px;
            border-bottom: 0;
            letter-spacing: 0.02em;
            vertical-align: inherit;
        }

        .MuiTableBody-root {
            display: table-row-group;
        }

            .MuiTableBody-root .MuiTableRow-root:not(:last-child) {
                border-bottom: 1px solid #E9E6F0;
            }

            .MuiTableBody-root .MuiTableRow-root {
                border-bottom: none;
            }

        .MuiTableRow-root {
            color: inherit;
            display: table-row;
            outline: 0;
            vertical-align: middle;
        }

        .linea{
            display: none;
        }

        .movisq {
            transform: translate(-200%,0);
            -webkit-transform: translate(-200%, 0);
            -o-transform: translate(-200%, 0);
            -moz-transform: translate(-200%, 0);
            transition: all 1s ease-in-out;
            -webkit-transition: all 1s ease-in-out;
            -moz-transition: all 1s ease-in-out;
            -o-transition: all 1s ease-in-out;
        }

        .content {
            display: flex;
            padding: 5px;
            height: 300px;
        }

        .rigth {
            display: none;
            width: 70%;
            height: 100%;
            padding: 10px;
        }

        .left {
            width: 100%;
        }
    </style>

    <input type="hidden" id="id_documento" value="0" />
    <input type="hidden" id="hidper_por_cont" value="0" />
    <div class="wrapper " style="padding-top: 5px;">
        <div class="row" style="margin-left: 0; background: white;">
            <div class="x_panel">
                <div class="row">
                    <div class="x_title col-lg-6 col-md-6 col-sm-7 col-xs-12">
                        <h1 class="title-master" style="margin-top: 8px;"><span class="fa fa-bullhorn fa-fw"></span>Liquidación de la Nomina</h1>
                        <div class="clearfix"></div>

                    </div>
                    <div class="col-lg-6 col-md-6 col-sm-5 col-xs-12">
                        <%--<button title="Guardar" id="btnguardar" class="btn btn-outline btn-primary dim  pull-right" type="button" style="margin-right: 40px !important;" disabled="disabled"><i class="fa fa-paste"></i></button>
                        <button title="Guardar Contrato" id="btnguardarcontra" class="btn btn-outline btn-primary dim  pull-right" type="button" style="margin-right: 40px !important; display: none;" disabled="disabled"><i class="fa fa-paste"></i></button>
                        <button title="Imprimir" id="btnPrint" data-option="I" class="btn btn-outline btn-info dim  pull-right" type="button"><i class="fa fa-print"></i></button>
                        <button title="Nueva Liquidación" id="btnnews" data-option="R" class="btn btn-outline btn-default  dim  pull-right" type="button"><i class="fa-file-o fa"></i></button>
                        <button title="Nuevo Contrato" id="btnnewscon" data-option="R" class="btn btn-outline btn-default  dim  pull-right" type="button" style="display: none;"><i class="fa-file-o fa"></i></button>
                        <button title="Crear Contrato" id="btncontra" data-option="R" class="btn btn-outline btn-default  dim  pull-right" type="button" style="display: none;"><i class="fa-plus fa"></i></button>
                        <button title="Atrás" id="atras" class="btn btn-outline btn-warning  dim  pull-right" type="button" style="display: none;"><i class="fa fa-angle-double-left"></i></button>--%>
                    </div>
                </div>
                <div class="row">
                    <input type="hidden" id="hidempleado" value="0" />
                    <input type="hidden" id="hidcontrato" value="0" />
                    <div class="tblliquidacion content" style="height: 100vh">
                        <div class="left">
                            <label onclick="toggleCC()" class="control-label" style="width: 100%; margin-bottom: 10px; border-bottom: solid #ccc 1px; padding-left: 5px; font-size: 14px;"><span class="fa fa-2x fa-eye text-info iconfa font-weight-light"></span>&nbsp;Filtros: <span class="pull-right"><i class="fa fa-chevron-down fa-fw fdown"></i></span></label>
                            <div class="fold row" style="display: none; margin: 0; border: solid 0px 1px 2px 1px #ccc">
                                <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12 sn-padding">
                                    <div class="form-group">
                                        <label for="filtroliq" class="active">Filtro:</label>
                                        <select runat="server" clientidmode="static" id="filtroliq" data-size="8" type="text" class="form-control selectpicker" data-live-search="true">
                                        </select>
                                    </div>
                                </div>
                                <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12 sn-padding contra">
                                    <div class="form-group">
                                        <label for="period" class="active">Periodo:</label>
                                        <select runat="server" clientidmode="static" id="period" data-size="8" class="form-control selectpicker" title="Seleccione" data-live-search="true">
                                        </select>
                                    </div>
                                </div>

                            </div>
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 sn-padding">
                                <button id="btnSearchClient" type="button" data-id="0" class="btn btn-primary ink-reaction btn-raised btn-loading-state" data-loading-text="<i class='fa fa-spinner fa-spin'></i> Cargando..." style="width: 100%; margin: 0 5px 0 1px">Consultar</button>
                            </div>

                            <div class="table-responsive tabla1">
                                <table class="table table-condensed table-striped jambo_table" id="tblLiquidacionperiod">
                                    <thead>
                                        <tr>
                                            <th data-column-id="ver" data-formatter="ver" id="search1">#</th>
                                            <th data-column-id="dias_pagar">Días</th>
                                            <th data-column-id="Fecha_pago">Fecha de Pago</th>
                                        </tr>
                                    </thead>
                                </table>
                            </div>

                            <div class="table-responsive tabla2">
                                <table class="table table-condensed table-striped jambo_table" id="tblLiquidacioncontrato" style="width: 100%;">
                                    <thead>
                                        <tr>
                                            <th data-column-id="ver" data-formatter="ver" id="search2">#</th>
                                            <th data-column-id="razonsocial">Nombre</th>
                                            <th data-column-id="dias_pagar">Días</th>
                                            <th data-column-id="nombre_cargo">Cargo</th>
                                            <th data-column-id="novedad" data-formatter="novedad" data-sortable="false" style="max-width: 30px">Novedad</th>
                                        </tr>
                                    </thead>
                                </table>
                            </div>
                        </div>
                        <div class="rigth">
                            <div class="col-lg-8 col-md-8 col-sm-7 col-xs-12" id="dataempleado" style="padding-top: 5px; padding-bottom: 15px; padding-left: 2px; background: #FFF;">
                                <div class="navbar-header">
                                    <a class="navbar-minimalize minimalize-styl-2 btn btn-primary  waves-effect waves-light" id="noneempleado" href="#"><i id="iconbot" class="fa fa-caret-left"></i></a>
                                </div>

                                <div class="card" id="divliquidacion" style="margin-right: 18px !important;">
                                    <div class="row col-lg-12">
                                        <button title="Guardar" id="btntiqui" class="btn btn-outline btn-info dim  pull-right" type="button"><i class="fa fa-paste"></i></button>

                                    </div>

                                    <h2 class="title-master" style="margin-top: 0;"><span class="fa fa-money fa-fw"></span>Pago al empleado</h2>
                                    <div class="jss52">
                                        <div class="MuiPaper-root MuiPaper-elevation2 MuiPaper-rounded">
                                            <div class="MuiTableContainer-root" style="position: relative; margin-bottom: 1em;">
                                                <div class="jss58" style="overflow-x: auto; position: relative;">
                                                    <div>
                                                        <div style="overflow-y: auto;">
                                                            <div>
                                                                <table class="MuiTable-root" style="table-layout: auto;">
                                                                    <thead class="MuiTableHead-root">
                                                                        <tr class="MuiTableRow-root MuiTableRow-head">
                                                                            <th class="MuiTableCell-root MuiTableCell-head jss59 MuiTableCell-alignLeft" scope="col" style="box-sizing: border-box; width: auto; background-color: #205f96; color: #fff">Concepto</th>
                                                                            <th class="MuiTableCell-root MuiTableCell-head jss59 MuiTableCell-alignLeft" scope="col" style="text-align: center; box-sizing: border-box; width: auto; background-color: #205f96; color: #fff">%</th>
                                                                            <th class="MuiTableCell-root MuiTableCell-head jss59 MuiTableCell-alignLeft" scope="col" style="text-align: right; box-sizing: border-box; width: auto; background-color: #205f96; color: #fff">Valor</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody class="MuiTableBody-root">
                                                                        <tr class="MuiTableRow-root linea" index="0" level="0" path="0" style="transition: all 300ms ease 0s;" id="salarioDev">
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" style="color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit;">Salario</td>
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" id="salariop" value="0" style="color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit; text-align: right;"></td>
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" id="salario" value="0" style="color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit; text-align: right;"></td>
                                                                        </tr>
                                                                        <tr class="MuiTableRow-root linea" index="0" level="0" path="1" style="transition: all 300ms ease 0s;" id="diasDev">
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" style="color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit;">Días trabajados</td>
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" id="diasp" value="0" style="color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit; text-align: right;"></td>
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" id="dias" value="0" style="color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit; text-align: right;"></td>
                                                                        </tr>
                                                                        <tr class="MuiTableRow-root linea" index="0" level="0" path="1" style="transition: all 300ms ease 0s;" id="aux_transDev">
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" style="color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit;">Auxilio de transporte</td>
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" id="aux_transp" value="0" style="color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit; text-align: right;"></td>
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" id="aux_trans" value="0" style="color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit; text-align: right;"></td>
                                                                        </tr>
                                                                        <tr class="MuiTableRow-root linea" index="0" level="0" path="1" style="transition: all 300ms ease 0s;" id="rec_nocDev">
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" style="color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit;">Recargo nocturno</td>
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" id="rec_nocp" value="0" style="color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit; text-align: right;"></td>
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" id="rec_noc" value="0" style="color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit; text-align: right;"></td>
                                                                        </tr>
                                                                        <tr class="MuiTableRow-root linea" index="0" level="0" path="1" style="transition: all 300ms ease 0s;" id="H_extraDev">
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" style="color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit;">Horas extra</td>
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" id="H_extrap" value="0" style="color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit; text-align: right;"></td>
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" id="H_extra" value="0" style="color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit; text-align: right;"></td>
                                                                        </tr>
                                                                        <tr class="MuiTableRow-root linea" index="0" level="0" path="1" style="transition: all 300ms ease 0s;" id="bonifiDev">
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" style="color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit;">Bonificación</td>
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" id="bonifip" value="0" style="color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit; text-align: right;"></td>
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" id="bonifi" value="0" style="color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit; text-align: right;"></td>
                                                                        </tr>
                                                                        <tr class="MuiTableRow-root linea" index="0" level="0" path="1" style="transition: all 300ms ease 0s;" id="comiDev">
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" style="color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit;">Comisión</td>
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" id="comisp" value="0" style="color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit; text-align: right;"></td>
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" id="comis" value="0" style="color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit; text-align: right;"></td>
                                                                        </tr>
                                                                        <tr class="MuiTableRow-root linea" index="1" level="0" path="1" style="transition: all 300ms ease 0s;" id="deduccionDev">
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" style="color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit;">Retenciones y deducciones</td>
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" id="deduccionp" value="0" style="color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit; text-align: right;"></td>
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" id="deduccion" value="0" style="color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit; text-align: right;"></td>
                                                                        </tr>
                                                                        <tr class="MuiTableRow-root linea" index="2" level="0" path="2" style="transition: all 300ms ease 0s; background-color: rgb(224, 224, 224); font-weight: 600;" id="totalDev">
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" style="color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit;">Total neto a pagar al empleado</td>
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" id="totalp" value="0" style="color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit; text-align: right;"></td>
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" id="total" value="0" style="color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit; text-align: right;"></td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <br />
                                    <h2 class="title-master" style="margin-top: 0;"><span class="fa fa-money fa-fw"></span>Pagos de el empleador</h2>
                                    <div class="jss52">
                                        <div class="MuiPaper-root MuiPaper-elevation2 MuiPaper-rounded">
                                            <div class="MuiTableContainer-root" style="position: relative; margin-bottom: 1em;">
                                                <div class="jss58" style="overflow-x: auto; position: relative;">
                                                    <div>
                                                        <div style="overflow-y: auto;">
                                                            <div>
                                                                <table class="MuiTable-root" style="table-layout: auto;">
                                                                    <thead class="MuiTableHead-root">
                                                                        <tr class="MuiTableRow-root MuiTableRow-head">
                                                                            <th class="MuiTableCell-root MuiTableCell-head jss59 MuiTableCell-alignLeft" scope="col" style="box-sizing: border-box; width: auto; background-color: #205f96; color: #fff">Concepto</th>
                                                                            <th class="MuiTableCell-root MuiTableCell-head jss59 MuiTableCell-alignLeft" scope="col" style="text-align: center; box-sizing: border-box; width: auto; background-color: #205f96; color: #fff">%</th>
                                                                            <th class="MuiTableCell-root MuiTableCell-head jss59 MuiTableCell-alignLeft" scope="col" style="text-align: right; box-sizing: border-box; width: auto; background-color: #205f96; color: #fff">Valor</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody class="MuiTableBody-root">
                                                                        <tr class="MuiTableRow-root linea" index="0" level="0" path="0" style="transition: all 300ms ease 0s;" id="ibcDed">
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" style="color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit;">IBC</td>
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" id="ibcp" value="0" style="text-align: center; color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit; text-align: right;"></td>
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" id="ibc" value="0" style="color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit; text-align: right;"></td>
                                                                        </tr>
                                                                        <tr class="MuiTableRow-root linea" index="0" level="0" path="1" style="transition: all 300ms ease 0s;" id="saludDed">
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" style="color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit;">Salud</td>
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" id="saludp" value="0" style="text-align: center; color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit;"></td>
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" id="salud" value="0" style="color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit; text-align: right;"></td>
                                                                        </tr>
                                                                        <tr class="MuiTableRow-root linea" index="0" level="0" path="1" style="transition: all 300ms ease 0s;" id="pensionDed">
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" style="color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit;">Pension</td>
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" id="pensionp" value="0" style="text-align: center; color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit;"></td>
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" id="pension" value="0" style="color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit; text-align: right;"></td>
                                                                        </tr>
                                                                        <tr class="MuiTableRow-root linea" index="2" level="0" path="2" style="transition: all 300ms ease 0s; background-color: rgb(224, 224, 224); font-weight: 600;" id="totalDed">
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" style="color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit;">Total deducciones</td>
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" id="totaldedp" value="0" style="text-align: center; color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit;"></td>
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" id="totalded" value="0" style="color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit; text-align: right;"></td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <br />
                                    <h2 class="title-master" style="margin-top: 0;"><span class="fa fa-money fa-fw"></span>Prestaciones Sociales</h2>
                                    <div class="jss52">
                                        <div class="MuiPaper-root MuiPaper-elevation2 MuiPaper-rounded">
                                            <div class="MuiTableContainer-root" style="position: relative; margin-bottom: 1em;">
                                                <div class="jss58" style="overflow-x: auto; position: relative;">
                                                    <div>
                                                        <div style="overflow-y: auto;">
                                                            <div>
                                                                <table class="MuiTable-root" style="table-layout: auto;">
                                                                    <thead class="MuiTableHead-root">
                                                                        <tr class="MuiTableRow-root MuiTableRow-head">
                                                                            <th class="MuiTableCell-root MuiTableCell-head jss59 MuiTableCell-alignLeft" scope="col" style="box-sizing: border-box; width: auto; background-color: #205f96; color: #fff">Concepto</th>
                                                                            <th class="MuiTableCell-root MuiTableCell-head jss59 MuiTableCell-alignLeft" scope="col" style="text-align: center; box-sizing: border-box; width: auto; background-color: #205f96; color: #fff">%</th>
                                                                            <th class="MuiTableCell-root MuiTableCell-head jss59 MuiTableCell-alignLeft" scope="col" style="text-align: right; box-sizing: border-box; width: auto; background-color: #205f96; color: #fff">Valor</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody class="MuiTableBody-root">
                                                                        <tr class="MuiTableRow-root linea" index="0" level="0" path="0" style="transition: all 300ms ease 0s;" id="Presibc2">
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" style="color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit;">IBC</td>
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" id="ibc2p" value="0" style="color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit; text-align: right;"></td>
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" id="ibc2" value="0" style="color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit; text-align: right;"></td>
                                                                        </tr>
                                                                        <tr class="MuiTableRow-root linea" index="0" level="0" path="1" style="transition: all 300ms ease 0s;" id="Presprimas">
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" style="color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit;">Salud</td>
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" id="primap" value="0" style="color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit; text-align: right;"></td>
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" id="prima" value="0" style="color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit; text-align: right;"></td>
                                                                        </tr>
                                                                        <tr class="MuiTableRow-root linea" index="0" level="0" path="1" style="transition: all 300ms ease 0s;" id="Prescesan">
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" style="color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit;">Salud</td>
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" id="cesanp" value="0" style="color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit; text-align: right;"></td>
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" id="cesan" value="0" style="color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit; text-align: right;"></td>
                                                                        </tr>
                                                                        <tr class="MuiTableRow-root linea" index="0" level="0" path="1" style="transition: all 300ms ease 0s;" id="Presintcesan">
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" style="color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit;">Pension</td>
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" id="intcesanp" value="0" style="color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit; text-align: right;"></td>
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" id="intcesan" value="0" style="color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit; text-align: right;"></td>
                                                                        </tr>
                                                                        <tr class="MuiTableRow-root linea" index="0" level="0" path="1" style="transition: all 300ms ease 0s;" id="PresdiasV">
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" style="color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit;">Pension</td>
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" id="diasvp" value="0" style="color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit; text-align: right;"></td>
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" id="diasv" value="0" style="color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit; text-align: right;"></td>
                                                                        </tr>
                                                                        <tr class="MuiTableRow-root linea" index="2" level="0" path="2" style="transition: all 300ms ease 0s; background-color: rgb(224, 224, 224); font-weight: 600;" id="Prestotal">
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" style="color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit;">Total deducciones</td>
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" id="totalpresp" value="0" style="color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit; text-align: right;"></td>
                                                                            <td class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignLeft" id="totalpres" value="0" style="color: inherit; width: 33%; box-sizing: border-box; font-size: inherit; font-family: inherit; font-weight: inherit; text-align: right;"></td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <br />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <div class="modal fade" id="ModalNovedades">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header" style="margin-bottom: 3%">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h2 class="modal-title"><i class="fa fa-paper-plane-o"></i>&nbsp;Detalles de Novedades</h2>
                </div>

                <div class="modal-body clearfix" style="margin-bottom: 0; padding-top: 0 !important">
                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding-left: 10px; bottom: 20px">
                        <div class="content clearfix" style="display: block; margin: 5px 5px 10px 5px;">
                            <div class="" style="display: block;" id="divregistro">
                                <ul class="nav nav-tabs">
                                    <li class="list active">
                                        <a data-toggle="tab" id="tab1" href="#tab-1"><i class="fa fa-line-chart fa-fw"></i>
                                            <span class="hidden-xs">Devengo</span></a>
                                    </li>
                                    <li class="list">
                                        <a data-toggle="tab" id="tab2" href="#tab-2"><i class="fa fa-user-times"></i>
                                            <span class="hidden-xs">Ausencias</span></a>
                                    </li>
                                    <li class="list">
                                        <a data-toggle="tab" id="tab3" href="#tab-3"><i class="fa fa-file-text"></i>
                                            <span class="hidden-xs">Deducciones</span></a>
                                    </li>
                                </ul>

                                <div class="tab-content">
                                    <div id="tab-1" class="tab-pane active">
                                        <div class="portlet">
                                            <div class="card">
                                                <div class="form-body" style="margin-bottom: 10px">
                                                    <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12 sn-padding">
                                                        <div class="form-group">
                                                            <label for="f_ini">Inicio Horas extra:</label>
                                                            <input type="text" class="form-control" id="f_ini" placeholder=" " date="true" format="YYYY-MM-DD HH:mm" current="true" />
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12 sn-padding">
                                                        <div class="form-group">
                                                            <label for="f_fin">Fin Horas extra:</label>
                                                            <input type="text" class="form-control" id="f_fin" placeholder=" " date="true" format="YYYY-MM-DD HH:mm" current="true" />
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12 sn-padding">
                                                        <div class="form-group">
                                                            <label for="boni">Bonificacion:</label>
                                                            <input type="text" class="form-control nodate" id="boni" money="true" data-a-dec="." data-a-sep="," data-a-sign="$ " placeholder="$ 0.0" />
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12 sn-padding">
                                                        <div class="form-group">
                                                            <label for="comi">Comision:</label>
                                                            <input type="text" class="form-control nodate" id="comi" money="true" data-a-dec="." data-a-sep="," data-a-sign="$ " placeholder="$ 0.0" />
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-2 col-md-4 col-sm-12 col-xs-12 sn-padding">
                                                        <button id="addDeven" type="button" class="btn btn-sin btn-circle addarticle" title="Agregar"><i class="fa fa-2x fa-plus"></i></button>
                                                    </div>
                                                </div>
                                                <br />
                                                <div class="table-responsive">
                                                    <table class="table table-striped jambo_table" id="tbnDevengo" style="margin-left: 2%; width: 96%; margin-bottom: 7px !important;">
                                                        <thead style="font-size: 10px">
                                                            <tr>
                                                                <th class="text-right">#</th>
                                                                <th class="text-center">FECHA INICIO</th>
                                                                <th class="text-center">FECHA FIN</th>
                                                                <th class="text-center">BONIFICACION</th>
                                                                <th class="text-center">COMISION</th>
                                                                <th class="text-left">#</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody></tbody>
                                                    </table>
                                                    <div class="col-lg-12" style="font-size: 10px;">
                                                        <div class="col-lg-4 col-md-3 col-sm-6 col-xs-12 sn-padding pull-right">
                                                            <div class="ibox-content codvalue text-right">
                                                                <h2 id="mtotal_comision" class="no-margins totales">$ 0.00</h2>
                                                                <span class="font-bold text-navy">Total Comision</span>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-4 col-md-3 col-sm-6 col-xs-12 sn-padding pull-right">
                                                            <div class="ibox-content codvalue text-right">
                                                                <h2 id="mtotal_bonificacion" class="no-margins totales">$ 0.00</h2>
                                                                <span class="font-bold text-navy">Total Bonificacion</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div id="tab-2" class="tab-pane">
                                        <div class="portlet">
                                            <div class="card">
                                                <div class="form-body" style="margin-bottom: 10px">
                                                    <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12 sn-padding">
                                                        <div class="form-group">
                                                            <label for="fecha_ini">Fecha inicio</label>
                                                            <input type="text" class="form-control" id="fecha_ini" placeholder=" " date="true" format="YYYY-MM-DD HH:mm" current="true" />
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12 sn-padding">
                                                        <div class="form-group">
                                                            <label for="fecha_fin">Fecha fin</label>
                                                            <input type="text" class="form-control" id="fecha_fin" placeholder=" " date="true" format="YYYY-MM-DD HH:mm" current="true" />
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12 sn-padding">
                                                        <div class="form-group">
                                                            <label for="ds_ausencia">Ausencia</label>
                                                            <select class="selectpicker form-control nodate" id="ds_ausencia" clientidmode="static" runat="server"></select>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12 sn-padding ausencia" style="display: none">
                                                        <div class="form-group">
                                                            <label for="ds_incapacidad">Diagnostico:</label>
                                                            <input type="hidden" id="id_diagnostico" value="" />
                                                            <input type="text" class="form-control actionautocomple inputsearch nodate" id="ds_diagnostico" clientidmode="static" runat="server" aria-describedby="sizing-addon1" data-search="RHumanos" data-method="NominaBuscador" data-params="op:D;" data-result="value:name;data:id" data-idvalue="id_diagnostico" />
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-2 col-md-4 col-sm-12 col-xs-12 sn-padding  ausencia" style="display: none">
                                                        <div class="form-group">
                                                            <label for="remunerado">Remunerado</label>
                                                            <div class="check-mail">
                                                                <input type="checkbox" class="form-control i-checks" id="remunerado" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-2 col-md-4 col-sm-12 col-xs-12 sn-padding">
                                                        <div class="form-group">
                                                            <label for="suspendido">Suspension</label>
                                                            <div class="check-mail">
                                                                <input type="checkbox" class="form-control i-checks" id="suspendido" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-2 col-md-4 col-sm-12 col-xs-12 sn-padding">
                                                        <button id="addAusenc" type="button" class="btn btn-sin btn-circle addarticle" title="Agregar"><i class="fa fa-2x fa-plus"></i></button>
                                                    </div>
                                                </div>
                                                <br />
                                                <div class="table-responsive">
                                                    <table class="table table-striped jambo_table" id="tblAusenc" style="margin-left: 2%; width: 96%; margin-bottom: 7px !important">
                                                        <thead style="font-size: 10px">
                                                            <tr>
                                                                <th class="text-right">#</th>
                                                                <th class="text-center">FECHA INICIO</th>
                                                                <th class="text-center">FECHA FIN</th>
                                                                <th class="text-center">AUSENCIA</th>
                                                                <th class="text-center">INCAPACIDAD</th>
                                                                <th class="text-center">REMUNERADO</th>
                                                                <th class="text-center">SUSPENCION</th>
                                                                <th class="text-left">#</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody></tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div id="tab-3" class="tab-pane">
                                        <div class="portlet">
                                            <div class="card">
                                                <div class="form-body" style="margin-bottom: 10px">
                                                    <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12 sn-padding">
                                                        <div class="form-group">
                                                            <label for="prestamo">Prestamos</label>
                                                            <input type="text" class="form-control nodate" id="prestamo" money="true" data-a-dec="." data-a-sep="," data-a-sign="$ " placeholder="$ 0.0" />
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12  sn-padding">
                                                        <div class="form-group">
                                                            <label for="libranza">Libranzas</label>
                                                            <input type="text" class="form-control nodate" id="libranza" money="true" data-a-dec="." data-a-sep="," data-a-sign="$ " placeholder="$ 0.0" />
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12 sn-padding">
                                                        <div class="form-group">
                                                            <label for="ds_embargo">Embargo</label>
                                                            <input type="hidden" id="id_embargo" />
                                                            <input type="text" class="form-control actionautocomple inputsearch nodate" id="ds_embargo" clientidmode="static" runat="server" aria-describedby="sizing-addon1" data-search="RHumanos" data-method="NominaBuscador" data-params="op:l;" data-result="value:name;data:id" data-idvalue="id_embargo" />
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12 sn-padding">
                                                        <div class="form-group">
                                                            <label for="retefuente">Retefuente</label>
                                                            <input type="text" class="form-control nodate" id="retefuente" money="true" data-a-dec="." data-a-sep="," data-a-sign="$ " placeholder="$ 0.0" />
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-2 col-md-4 col-sm-12 col-xs-12 sn-padding">
                                                        <button id="addDeduc" type="button" class="btn btn-sin btn-circle addarticle" title="Agregar"><i class="fa fa-2x fa-plus"></i></button>
                                                    </div>
                                                </div>
                                                <br />
                                                <div class="table-responsive">
                                                    <table class="table table-striped jambo_table" id="tblDeduc" style="margin-left: 2%; width: 96%; margin-bottom: 7px !important">
                                                        <thead style="font-size: 10px">
                                                            <tr>
                                                                <th class="text-right">#</th>
                                                                <th class="text-center">PRESTAMOS</th>
                                                                <th class="text-center">LIBRANZAS</th>
                                                                <th class="text-center">EMBARGO</th>
                                                                <th class="text-center">RETEFUENTE</th>
                                                                <th class="text-left">#</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody></tbody>
                                                    </table>
                                                    <div class="col-lg-12" style="font-size: 10px;">
                                                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12 sn-padding pull-right">
                                                            <div class="ibox-content codvalue text-right">
                                                                <h2 id="mtotal_retefuente" class="no-margins totales">$ 0.00</h2>
                                                                <span class="font-bold text-navy">Total Retenciones</span>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12 sn-padding pull-right">
                                                            <div class="ibox-content codvalue text-right">
                                                                <h2 id="mtotal_Libranza" class="no-margins totales">$ 0.00</h2>
                                                                <span class="font-bold text-navy">Total Libranza</span>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12 sn-padding pull-right">
                                                            <div class="ibox-content codvalue text-right">
                                                                <h2 id="mtotal_Prestamo" class="no-margins totales">$ 0.00</h2>
                                                                <span class="font-bold text-navy">Total Prestamo</span>
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
                        <div class="row buttonaction pull-right">
                            <button title="Guardar" id="btnSaveNovedad" class="btn btn-outline btn-primary dim waves-effect waves-light" type="button"><i class="fa fa-paste"></i></button>
                            <button title="Cancelar" id="btnCanceNovedad" class="btn btn-outline btn-danger  dim waves-effect waves-light" data-dismiss="modal" aria-label="Close" type="button"><i class="fa-file-o fa"></i></button>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <span class="ir-arriba fa fa-sort-asc"></span>
    <script src="../Pages/ScriptsPage/Nomina/LiquidacionNom.js"></script>

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
    </script>

</asp:Content>

