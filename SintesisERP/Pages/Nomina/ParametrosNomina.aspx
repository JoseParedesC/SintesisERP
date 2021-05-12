<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ParametrosNomina.aspx.cs" Inherits="ParametrosNomina" MasterPageFile="~/Masters/SintesisMaster.Master" %>

<asp:Content ID="Content40" ContentPlaceHolderID="ContentPage" runat="server">
    <script type="text/javascript">
        window.appPath = "<%=Request.ApplicationPath%>";
    </script>
    <style>
        .rowedit {
            border-color: #1ab394;
        }

        .nav > li > a:focus, .nav > li > a:hover {
            background-color: #1c84c6cf !important
        }

        .nav-tabs > li > a {
            color: #3d3f41e8 !important;
        }

        textarea {
            resize: none;
        }

        .ch {
            height: 20px;
            width: 20px;
            border-radius: 20px !important;
        }

        .divParamAnual table thead tr th {
            padding: 4px !important;
            font-size: 12px !important;
            font-family: "open sans", "helvetica neue", helvetica, arial, sans-serif;
        }

        .acordion input input[readonly] {
            background-color: #b1b1b100;
            animation-duration: 2s;
            animation-name: color;
            font-size: 11px !important;
        }

        .collapse.in {
            padding-bottom: 40px !important;
            height: auto !important;
            width: auto !important;
        }

        .divParam {
            display: none;
        }

        .acordeon {
            text-align: left !important;
            margin-top: -10px;
            width: 100%
        }

        .card-header {
            height: 31px;
        }

        .portlet {
            margin-top: 2px;
            margin-bottom: 5px;
            height: 100%;
        }

        .card .divParam {
            height: auto !important;
            width: auto !important;
        }

        #anoactual {
            font-size: 18px;
            border: 0px;
            border-bottom: 1px darkgray dotted;
            text-align: center;
            width: 71px;
        }

        .accordion{
            padding-left: 12px !important;
            padding-right: 43px !important;
        }

    </style>

    <div class="row" style="margin: 0px 10px;">
        <div class="x_panel">
            <div class="x_title col-lg-6 col-md-6 col-sm-6 col-xs-12">
                <h1 class="title-master" style="margin-top: 0;"><span class="fa fa-bullhorn fa-fw"></span>Parametros Anuales</h1>
                <div class="clearfix"></div>
            </div>
            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 divParam">
                <div class="pull-right">
                    <span style="margin-right: 5px;">
                        <label>Año: </label>
                        <input id="anoactual" type="text" disabled="disabled" runat="server" clientidmode="static" /></span>
                    <button title="Regresar" id="btnBack" data-option="B" class="btn btn-outline btn-warning dim waves-effect waves-light" type="button"><i style="font-size: 12px" class="fa-2x fa-angle-double-left fa"></i></button>
                    <button title="Guardar" id="btnSave" data-option="I" class="btn btn-outline btn-primary dim waves-effect waves-light" type="button"><i class="fa fa-paste"></i></button>
                    <%--<button title="Cancelar" id="btnCance" class="btn btn-outline btn-danger  dim waves-effect waves-light" data-dismiss="modal" aria-label="Close" type="button"><i class="fa-file-o fa"></i></button>--%>
                </div>
            </div>
        </div>
    </div>

    <div class="card">
        <div id="diventrada">
            <div class="row" style="margin: 0px 10px;">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="table-responsive ">
                        <table class="table table-striped jambo_table" id="tblcommodity">
                            <thead>
                                <tr>
                                    <th data-column-id="id" data-formatter="edit" data-sortable="false" style="max-width: 30px !important;">Editar</th>
                                    <th data-column-id="ano">Año</th>
                                    <th data-column-id="SMMLV" data-formatter="valor">Salario Min.</th>
                                    <th data-column-id="aux" data-formatter="valor">Aux. Transporte</th>
                                </tr>
                            </thead>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="card">
        <div id="divinfo" class="divParam" style="margin-top: 20px">
            <div class="row" style="margin: 0px;">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="table-responsive ">
                        <table class="table table-striped jambo_table" id="tblinfo" style="margin: 8px; max-width: 96%; margin-top: 10px">
                            <thead>
                                <tr>
                                    <th class="text-center" data-column-id="ano">Año</th>
                                    <th class="text-center" data-column-id="SMMLV" data-formatter="valor">Salario Min.</th>
                                    <th class="text-center" data-column-id="aux" data-formatter="valor">Aux. Transporte</th>
                                </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div class="divParam" style="padding: 10px !important;">
            <div class="panel">
                <div class="accordion" id="acordeonP">
                    <div class="portlet">
                        <div class="card-header" id="InformacionP">
                            <button class="btn btn-link text-left acordeon collapsed" type="button" data-toggle="collapse" data-target="#InfoGeneral" aria-expanded="false" aria-controls="InfoGeneral">
                                <div class="portlet-title evaluation notepad" style="font-size: 10px;" id="padre1"></div>
                                <i class="fa-2x fa fa-info-circle"></i>&nbsp;&nbsp;Informacion General
                            </button>
                        </div>
                        <div id="InfoGeneral" class="collapse CREDIFORM" aria-labelledby="InformacionP" data-parent="#acordeonP">
                            <div class="card-body">
                                <div class="panel">
                                    <div class="form-body" id="info-deudor">
                                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12 sn-padding">
                                            <div class="form-group">
                                                <label for="smmlv" class="active">Salario Minimo Legal Vigente:</label>
                                                <input id="smmlv" type="text" class="form-control" value="0.00" placeholder=" " money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="0" data-a-sign="$ " />
                                            </div>
                                        </div>
                                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12 sn-padding">
                                            <div class="form-group">
                                                <label for="salInte" class="active">Salario Integral:</label>
                                                <input id="salInte" type="text" class="form-control" value="0.00" placeholder=" " money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="0" data-a-sign="$ " />
                                            </div>
                                        </div>
                                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12 sn-padding">
                                            <div class="form-group">
                                                <label for="auxTrans" class="active">Auxilio de Transporte:</label>
                                                <input id="auxTrans" type="text" class="form-control" value="0.00" placeholder=" " money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="0" data-a-sign="$ " />
                                            </div>
                                        </div>
                                        <div class="col-lg-2 col-md-3 col-sm-6 col-xs-12 sn-padding">
                                            <div class="form-group">
                                                <label for="porcen_interes_Cesantias" class="active">Pago de Incapacidades:</label>
                                                <select id="porcen_interes_Cesantias" class="form-control selectpicker" runat="server" clientidmode="static"></select>
                                            </div>
                                        </div>
                                        <div class="col-lg-1 col-md-3 col-sm-6 col-xs-12 sn-padding">
                                            <div class="form-group">
                                                <label for="exonerado" class="active">Exonerado</label>
                                                <div class="check-mail">
                                                    <input type="checkbox" class="i-checks" id="exonerado"/>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="portlet">
                        <div class="card-header" id="InformacionPres">
                            <button class="btn btn-link text-left acordeon" type="button" data-toggle="collapse" data-target="#InfoPrestaciones" aria-expanded="false" aria-controls="InfoPrestaciones">
                                <div class="portlet-title evaluation notepad" style="font-size: 10px;" id="padre2"></div>
                                <i class="fa fa-users"></i>&nbsp;&nbsp;Prestaciones Sociales
                            </button>
                        </div>
                        <div id="InfoPrestaciones" class="collapse CREDIFORM" aria-labelledby="InformacionPres" data-parent="#acordeonP">
                            <div class="card-body">
                                <div class="panel">
                                    <div class="form-body">
                                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6" style="margin-bottom: 20px">
                                            <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12 sn-padding">
                                                <div class="form-group">
                                                    <label for="porcen_salud_empleado" class="active">Salud (Empleado):</label>
                                                    <input id="porcen_salud_empleado" porcen="true" type="text" class="form-control" placeholder="% 0.0" data-a-sign="% " data-m-dec="2" data-v-min="0.00" data-v-max="100" />
                                                </div>
                                            </div>
                                            <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12  sn-padding">
                                                <div class="form-group">
                                                    <label for="porcen_salud_empleador" class="active">Salud (Empleador):</label>
                                                    <input id="porcen_salud_empleador" porcen="true" type="text" class="form-control" placeholder="% 0.0" data-a-sign="% " data-m-dec="2" data-v-min="0.00" data-v-max="100" />
                                                </div>
                                            </div>
                                            <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12 sn-padding">
                                                <div class="form-group">
                                                    <label for="porcen_salud_total" class="active">Salud total:</label>
                                                    <input id="porcen_salud_total" porcen="true" type="text" class="form-control" placeholder="% 0.0" data-a-sign="% " data-m-dec="2" data-v-min="0.00" data-v-max="100" disabled="disabled" />
                                                </div>
                                            </div>
                                            <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12 sn-padding">
                                                <div class="form-group">
                                                    <label for="porcen_pension_empleado" class="active">Pensión (Empleado):</label>
                                                    <input id="porcen_pension_empleado" porcen="true" type="text" class="form-control" placeholder="% 0.0" data-a-sign="% " data-m-dec="2" data-v-min="0.00" data-v-max="100" />
                                                </div>
                                            </div>
                                            <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12 sn-padding">
                                                <div class="form-group">
                                                    <label for="porcen_pension_empleador" class="active">Pensión (Empleador):</label>
                                                    <input id="porcen_pension_empleador" porcen="true" type="text" class="form-control" placeholder="% 0.0" data-a-sign="% " data-m-dec="2" data-v-min="0.00" data-v-max="100" />
                                                </div>
                                            </div>
                                            <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12 sn-padding">
                                                <div class="form-group">
                                                    <label for="porcen_pension_total" class="active">Pensión total:</label>
                                                    <input id="porcen_pension_total" porcen="true" type="text" class="form-control" placeholder="% 0.0" data-a-sign="% " data-m-dec="2" data-v-min="0.00" data-v-max="100" disabled="disabled" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6 no-show" style="border-left: 4px dotted #1b84c5; margin-bottom: 10px;">
                                            <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12 sn-padding" style="padding-right: 12px;">
                                                <div class="form-group">
                                                    <label for="num_salmin_salud_empleador" class="active">Salarios para salud:</label>
                                                    <input id="num_salmin_salud_empleador" type="text" placeholder=" " class="form-control" <%--disabled="disabled"--%> />
                                                </div>
                                            </div>
                                            <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12 sn-padding">
                                                <div class="form-group">
                                                    <label for="num_salmin_ICBF" class="active">Salarios min para ICBF:</label>
                                                    <input id="num_salmin_ICBF" type="text" placeholder=" " class="form-control" <%--disabled="disabled"--%> />
                                                </div>
                                            </div>
                                            <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12 sn-padding">
                                                <div class="form-group">
                                                    <label for="num_salmin_SENA" class="active">Salarios min para SENA:</label>
                                                    <input id="num_salmin_SENA" type="text" placeholder=" " class="form-control" <%--disabled="disabled"--%> />
                                                </div>
                                            </div>
                                            <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 sn-padding">
                                                <div class="form-group">
                                                    <label for="num_max_seguridasocial" class="active">Salarios max para seguridad social:</label>
                                                    <input id="num_max_seguridasocial" type="text" placeholder=" " class="form-control" <%--disabled="disabled"--%> />
                                                </div>
                                            </div>
                                            <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12 sn-padding">
                                                <div class="form-group">
                                                    <label for="porcen_icbf" class="active"><br />ICBF:</label>
                                                    <input id="porcen_icbf" porcen="true" type="text" placeholder="% 0.0" data-a-sign="% " data-m-dec="2" data-v-min="0.00" data-v-max="100" class="form-control" <%--disabled="disabled"--%> />
                                                </div>
                                            </div>
                                            <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12 sn-padding">
                                                <div class="form-group">
                                                    <label for="porcen_sena" class="active"><br />SENA:</label>
                                                    <input id="porcen_sena" porcen="true" type="text" placeholder="% 0.0" data-a-sign="% " data-m-dec="2" data-v-min="0.00" data-v-max="100" class="form-control" <%--disabled="disabled"--%> />
                                                </div>
                                            </div>
                                            <div class="col-lg-8 col-md-8 col-sm-12 col-xs-12 sn-padding">
                                                <div class="divParamAnual">
                                                    <table class="table-striped" style="margin: 8px; max-width: 96%">
                                                        <thead>
                                                            <label for="lafila" class="active sn-padding">Fondo de solidaridad pensional:</label>
                                                            <tr id="lafila" style="border: 1px solid #AAB7B8;">
                                                                <td style="border-right: 1px solid #AAB7B8;">
                                                                    <input class="form-control command-desde  text-center" placeholder="Desde" id="Rowdesde" />
                                                                </td>
                                                                <td style="border-right: 1px solid #AAB7B8;">
                                                                    <input class="form-control command-hasta text-center" readonly="readonly" placeholder="Hasta" id="Rowhasta" />
                                                                </td>
                                                                <td class="text-center">
                                                                    <input class="form-control command-porcen text-center" readonly="readonly" placeholder="%" id="Rowporcen" data-a-sign="%" />
                                                                </td>
                                                                <%--<td class="text-center" style="color: white">#</td>--%>
                                                            </tr>
                                                        </thead>
                                                    </table>
                                                </div>
                                            </div>
                                            <input type="hidden" value="" runat="server" clientidmode="static" id="htmlestado" />
                                        </div>
                                        <div class="divParamAnual">
                                            <table id="mytable" class="table table-striped jambo_table" style="margin: 8px; max-width: 96%; margin-top: 10px">
                                                <thead>
                                                    <tr>
                                                        <th data-column-id="desde" data-formatter="desde" class="text-center">Desde</th>
                                                        <th data-formatter="hasta" class="text-center">Hasta</th>
                                                        <th data-formatter="porcen" class="text-center">Porcentaje</th>
                                                        <th class="text-center">Eliminar</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="portlet">
                        <div class="card-header" id="InfoHoras">
                            <button class="btn btn-link text-left acordeon" type="button" data-toggle="collapse" data-target="#InfoHorasExtra" aria-expanded="false" aria-controls="InfoHorasExtra">
                                <div class="portlet-title evaluation notepad" style="font-size: 10px;" id="padre3"></div>
                                <i class="fa fa-clock-o"></i>&nbsp;&nbsp;Horas Extra
                            </button>
                        </div>
                        <div id="InfoHorasExtra" class="collapse CREDIFORM" aria-labelledby="InfoHoras" data-parent="#acordeonP">
                            <div class="card-body">
                                <div class="panel">
                                        <div class="panel">
                                            <div class="panel">
                                                <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                                                <div class="form-group">
                                                    <label for="hediurnas" class="active">H. Ext. Diurnas:</label>
                                                    <input id="hediurnas" type="text" class="form-control" value="0.00" placeholder=" " money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="0" data-a-sign="$ " />
                                                </div>
                                            </div>
                                            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                                                <div class="form-group">
                                                    <label for="henoctur" class="active">H. Ext. Nocturnas:</label>
                                                    <input id="henoctur" type="text" class="form-control" value="0.00" placeholder=" " money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="0" data-a-sign="$ " />
                                                </div>
                                            </div>
                                            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                                                <div class="form-group">
                                                    <label for="henoctur" class="active">H. Ext. Fest. Diurnas:</label>
                                                    <input id="hefdiurnas" type="text" class="form-control" value="0.00" placeholder=" " money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="0" data-a-sign="$ " />
                                                </div>
                                            </div>
                                            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                                                <div class="form-group">
                                                    <label for="henoctur" class="active">H. Ext. Fest. Nocturnas:</label>
                                                    <input id="hefnoctur" type="text" class="form-control" value="0.00" placeholder=" " money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="0" data-a-sign="$ " />
                                                </div>
                                            </div>

                                            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                                                <div class="form-group">
                                                    <label for="recnocturno" class="active">Recargo Nocturno:</label>
                                                    <input id="recnocturno" type="text" class="form-control" value="0.00" placeholder=" " money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="0" data-a-sign="$ " />
                                                </div>
                                            </div>
                                            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                                                <div class="form-group">
                                                    <label for="recdomfest" class="active">Hora Dominical:</label>
                                                    <input id="recdomfest" type="text" class="form-control" value="0.00" placeholder=" " money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="0" data-a-sign="$ " />
                                                </div>
                                            </div>
                                            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                                                <div class="form-group">
                                                    <label for="recdomfest" class="active">Recargo Nocturno dominical:</label>
                                                    <input id="recnocdomfest" type="text" class="form-control" value="0.00" placeholder=" " money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="0" data-a-sign="$ " />
                                                </div>
                                            </div>
                                            </div>
                                        </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="portlet">
                        <div class="card-header" id="InfoRetencion">
                            <button class="btn btn-link text-left acordeon collapsed" type="button" data-toggle="collapse" data-target="#Retencion" aria-expanded="false" aria-controls="InfoRetencion">
                                <div class="portlet-title evaluation notepad" style="font-size: 10px;" id=""></div>
                                <i class="fa fa-calculator"></i>&nbsp;&nbsp;Retencion en la Fuente
                            </button>
                        </div>
                        <div id="Retencion" class="collapse CREDIFORM" aria-labelledby="InformacionP" data-parent="#acordeonP">
                            <div class="card-body">
                                <div class="panel">
                                    <div class="form-body">
                                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12 sn-padding">
                                            <div class="form-group">
                                                <label for="uvt" class="active">Valor UVT por año:</label>
                                                <input id="uvt" type="text" class="form-control" value="0.00" placeholder=" " money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="0" data-a-sign="$ " />
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
    <span class="fa-stack fa-lg pull-right goTop iconnew">
        <i class="fa fa-circle fa-stack-2x"></i>
        <i class="fa fa-plus fa-stack-1x fa-inverse"></i>
    </span>



    <script src="../Pages/ScriptsPage/Nomina/ParametrosNom.js?9"></script>
    <script>
        $(function () {
            $('select').selectpicker();
            $('.i-checks').iCheck({
                checkboxClass: 'icheckbox_square-green',
                radioClass: 'iradio_square-green',
            });
            datepicker();
            $("[money]").each(function (i, control) {
                $(control).autoNumeric('init');
            });
            $("[porcen]").each(function (i, control) {
                $(control).autoNumeric('init');
            });
            //$('#lafila').css('background-color', 'rgb(10 104 179 / 66%)');
            $('#lafila').css({ 'margin-bottom': '7px' });

        })
    </script>
</asp:Content>
