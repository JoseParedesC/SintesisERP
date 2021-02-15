<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AnalisisCre.ascx.cs" Inherits="AnalisisCre" %>


<%--<link href="../Package/Vendor/css/plugins/steps/jquery.steps.css" rel="stylesheet" />
<link href="../Package/Vendor/css/plugins/fileinput/fileinput.css" rel="stylesheet" />--%>
<style>

    #tblreferen{
        margin-top: 15px;
    }

    .acordeon {
        margin-top: -20px !important;
        margin-bottom: -21px !important;
        width: 100% !important;
    }

    .btn-link:hover, .btn-link:focus {
        color: #6eafe5 !important;
    }

    .card-header {
        padding: 1px !important;
    }

    .form-group .form-control{
        font-size: 12px;
    }

    label.active{
        font-size:12px;
    }

    .caption {
        font-size: 13px;
    }

    .row .panel {
        margin-top: 0px;
        margin-bottom: 0px;
    }

    .portlet {
        margin-top: 2px;
        margin-bottom: 5px;
    }

    .table-responsive {
        font-size: 13px;
    }

    .dropdown-menu {
        position: absolute;
        top: 100%;
        left: 0;
        z-index: 100000000;
    }

    input.file-caption-name {
        padding-left: 10px !important;
    }

    div.btn.btn-primary.btn-file, div.file-caption.form-control.kv-fileinput-caption, div.input-group-btn.input-group-append .btn-secondary {
        font-size: 14px !important;
        height: 34px !important;
        padding-top: 8px !important;
    }

    .input-group-lg > .form-control, .input-group-lg > .input-group-addon, .input-group-lg > .input-group-btn > .btn {
        height: 46px !important;
    }

    .wizard > .content > .body {
        float: left;
        position: unset;
        width: 100%;
        height: 100%;
        padding: 0;
        border-radius: 5px;
        background: #fff;
        border: 0;
        overflow-y: auto;
        /*max-height: 600px !important;*/
    }

    .wizard-big.wizard > .content {
        min-height: initial;
    }

    .ibox-content {
        padding: 2px 0 0 0;
    }

    .wizard > .content > .body input {
        display: block;
        border: 0;
    }

    legend {
        display: block;
        width: 100%;
        padding: 0;
        margin-bottom: 10px;
        font-size: 21px;
        /* line-height: inherit; */
        color: #333;
        border: 0;
        margin-left: -10px;
    }

        legend h3, legend h2 {
            background: #cccccc52;
            padding: 5px 0 5px 2px;
            border-radius: 4px;
            color: #57646f;
            font-weight: bold;
            margin: 0;
            width: 102%
        }

    .Botns button {
        margin-bottom: 10px !important;
        margin-top: 10px !important;
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

    .diventrada {
        box-shadow: 0 5px 15px rgba(0,0,0,.3);
        margin-bottom: 15px;
        padding: 15px;
        border-radius: 10px;
    }

    .form-control[disabled], .form-group .form-control[disabled], fieldset[disabled] .form-control, fieldset[disabled] .form-group .form-control {
        border-bottom: 1px dotted #D2D2D2 !important;
        margin-bottom:12px;
        color: #8e8e8ee8;
    }

    .wizard > .content > .body ul > li {
        display: unset;
    }

</style>

<div class="accordion" id="acordeonSol">
    <div class="portlet">
        <div class="card-header" id="InformacionP">
            <h2 class="mb-0" />
            <button class="btn btn-link text-left acordeon" style="text-align: left !important" type="button" data-toggle="collapse" data-target="#Infopersonal" aria-expanded="false" aria-controls="Infopersonal">
                <div class="portlet-title evaluation notepad" style="font-size: 10px;" data-note="Información Personal" id="padre1" data-evaluation="DT"></div>
                <i class="fa fa-user"></i>Información Personal &nbsp;&nbsp;<label id="titulosol" style="color: #57646f; font-weight: bold"></label>
            </button>
            <input type="hidden" id="id_personas_referencias" />
        </div>
        <div id="Infopersonal" class="collapse" aria-labelledby="InformacionP" data-parent="#acordeonSol">
            <div class="card-body">
                <div class="panel">
                    <div class="form-body" id="info-deudor">
                        <div class="row panel">
                            <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <label for="id_tipoper" class="active">Tipo Persona:</label>
                                    <input type="hidden" value="0" id="tipoper">
                                    <select id="id_tipoper" runat="server" clientidmode="static" data-size="8" class="form-select selectpicker CREDIFORM" title="Seleccione" data-live-search="true"></select>
                                </div>
                            </div>
                            <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                <div class="form-group select">
                                    <label for="id_tipoiden" class="active">Tipo iden:</label>
                                    <select id="id_tipoiden" runat="server" clientidmode="static" data-size="8" class="form-select selectpicker CREDIFORM" title="Seleccione" data-live-search="true">
                                    </select>
                                </div>
                            </div>
                            <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                <div class="input-group ">
                                    <div class="form-group">
                                        <label for="iden" class="active">Identificación:</label>
                                        <input id="iden" type="text" placeholder=" " class="form-control CREDIFORM" value="" />
                                    </div>
                                    <span class="input-group-addon ">
                                        <label id="identificacion" class="lado" for="iden" style="margin-top: 15px; margin-left: 4px; font-family: sans-serif; color: #3d3f41a8" onfocus="false">0 </label>
                                    </span>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <label for="pnombre" class="active">Primer nombre:</label>
                                    <input id="pnombre" type="text" placeholder=" " class="form-control CREDIFORM" value="" runat="server" clientidmode="static" />
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <label for="snombre" class="active">Segundo nombre:</label>
                                    <input id="snombre" type="text" placeholder=" " class="form-control CREDIFORM" />
                                </div>
                            </div>
                        </div>
                        <div class="row panel" style="margin-top: 20px;">
                            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <label for="papellido" class="active">Primer apellido:</label>
                                    <input id="papellido" type="text" placeholder=" " class="form-control CREDIFORM" value="" />
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <label for="sapellido" class="active">Segundo apellido:</label>
                                    <input id="sapellido" type="text" placeholder=" " class="form-control CREDIFORM" value="" />
                                </div>
                            </div>
                            <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <label for="fnaci" class="active">F. Nacimiento:</label>
                                    <input id="fnaci" type="text" placeholder=" " class="form-control CREDIFORM" value="" current="true" date="true" format="YYYY-MM-DD" mdatepicker-position="botton" />
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <label for="Text_city" class="active">Ciudad:</label>
                                    <select runat="server" class="selectpicker CREDIFORM" clientidmode="static" id="Text_city" data-size="8" title="Ciudad" data-live-search="true">
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="row panel" style="margin-top: 20px;">
                            <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <label for="fexpe" class="active">F. Expedición:</label>
                                    <input id="fexpe" type="text" placeholder=" " class="form-control CREDIFORM" value="" current="true" date="true" format="YYYY-MM-DD" mdatepicker-position="botton" />
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <label for="ciudadexp" class="active">Ciudad Exped:</label>
                                    <select runat="server" class="selectpicker CREDIFORM" clientidmode="static" id="ciudadexp" data-size="8" title="Ciudad exp" data-live-search="true">
                                    </select>
                                </div>
                            </div>
                            <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <label for="genero" class="active">Género:</label>
                                    <select id="genero" runat="server" clientidmode="static" class="selectpicker CREDIFORM" data-size="8" title="Seleccione" data-live-search="true">
                                    </select>
                                </div>
                            </div>
                            <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <label for="estrato" class="active">Estrato:</label>
                                    <select id="estrato" runat="server" clientidmode="static" class="selectpicker CREDIFORM" data-size="8" title="Seleccione" data-live-search="true">
                                    </select>
                                </div>
                            </div>
                            <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <label for="ecivil" class="active">Estado civil:</label>
                                    <select id="ecivil" runat="server" clientidmode="static" class="selectpicker CREDIFORM" data-size="8" title="Seleccione" data-live-search="true">
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="row panel" style="margin-top: 20px;">
                            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <label for="profesion" class="active">Profesión:</label>
                                    <input id="profesion" type="text" placeholder=" " class="form-control CREDIFORM" value="" maxlength="50" />
                                </div>
                            </div>
                            <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <label for="pcargo" class="active">Per. a cargo:</label>
                                    <input id="pcargo" type="number" placeholder=" " class="form-control CREDIFORM" data-m-dec="0" data-v-min="0" data-v-max="100" value="0.00" />
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <label for="scorreo" class="active">Correo:</label>
                                    <input id="scorreo" type="email" placeholder=" " class="form-control notbloque CREDIFORM" value="" />
                                </div>
                            </div>
                            <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <label for="stelefono" class="active">Telefono:</label>
                                    <input id="stelefono" type="number" placeholder=" " class="form-control notbloque CREDIFORM" data-m-dec="0" data-v-max="99999999999" value="" data-a-sep="" />
                                </div>
                            </div>
                        </div>
                        <div class="row panel" style="margin-top: 20px;">
                            <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <label for="scelular" class="active">Celular:</label>
                                    <input id="scelular" type="text" placeholder=" " class="form-control notbloque CREDIFORM" value="" money="true" data-m-dec="0" data-v-max="9999999999" data-a-sep="" />
                                </div>
                            </div>
                            <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <label for="sotrotel" class="active">Otro:</label>
                                    <input id="sotrotel" type="text" placeholder=" " class="form-control notbloque CREDIFORM" value="" money="true" data-m-dec="0" data-v-max="9999999999" data-a-sep="" />
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-3 col-sm-12 col-xs-12">
                                <div class="form-group">
                                    <label for="direccion" class="active">Direccion Residencia:</label>
                                    <input id="direccion" type="text" placeholder=" " class="form-control direcresi CREDIFORM" disabled="disabled" value="0"/>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <label for="id_escolaridad" class="active">Nivel de Educacion</label>
                                    <input type="hidden" value="0" id="escolaridad">
                                    <select runat="server" id="id_escolaridad" clientidmode="static" data-size="8" class="form-select selectpicker CREDIFORM" title="Seleccione" data-live-search="true"></select>
                                    <input type="hidden" id="tipoter" />
                                </div>
                            </div>
                            <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <label for="vinmueble" class="active">Vive inmueble:</label>
                                    <select id="vinmueble" runat="server" clientidmode="static" class="selectpicker CREDIFORM" data-size="8" title="Seleccione" data-live-search="true">
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="row panel" style="margin-top: 20px;">
                            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <label for="varriendo" class="active">Valor arriendo:</label>
                                    <input id="varriendo" type="text" placeholder=" " class="form-control CREDIFORM" money="true" data-m-dec="2" data-v-min="0.00" data-a-sign="$ " data-v-max="999999999999.99" value="0.00" disabled="disabled" />
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <label for="fraiz" class="active">Finca raiz:</label>
                                    <select id="fraiz" class="selectpicker CREDIFORM" runat="server" clientidmode="static" data-size="8" title="Seleccione" data-live-search="true">
                                    </select>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <label for="fraizcual" class="active">Cual?:</label>
                                    <input id="fraizcual" type="text" placeholder=" " class="form-control CREDIFORM" value="" />
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <label for="vehiculo" class="active">Vehiculo:</label>
                                    <input id="vehiculo" type="text" placeholder=" " class="form-control CREDIFORM" value="" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="portlet">
        <div class="card-header" id="InformacionCon">
            <h2 class="mb-0">
                <button class="btn btn-link text-left acordeon collapsed" style="text-align: left !important" type="button" data-toggle="collapse" data-target="#infoconyugue" aria-expanded="true" aria-controls="infoconyugue">
                    <div class="portlet-title notepad" data-note="Información Conyuge" style="font-size: 10px;"></div>
                    <div class="caption">
                        <i class="fa fa-user"></i>Información Conyuge<label id="" style="color: #57646f; font-weight: bold"></label>
                    </div>
                </button>
            </h2>
        </div>
        <div id="infoconyugue" class="collapse" aria-labelledby="InformacionCon" data-parent="#acordeonSol">
            <div class="card-body">
                <div class="panel">
                    <div class="form-body" id="info-conyuge">
                        <div class="row panel">
                            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <label for="nconyuge" class="active">Nombre Completo:</label>
                                    <input id="nconyuge" type="text" placeholder=" " class="form-control conyuge CREDIFORM" value="" disabled="disabled" />
                                </div>
                            </div>
                            <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <label for="idenconyuge" class="active">Tipo Id:</label>
                                    <select id="idenconyuge" runat="server" clientidmode="static" class="conyuge selectpicker CREDIFORM" data-size="8" disabled="disabled" title="Seleccione" data-live-search="true">
                                    </select>
                                </div>
                            </div>
                            <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <label for="idencon" class="active">Identificación:</label>
                                    <input id="idencon" type="text" placeholder=" " class="form-control conyuge CREDIFORM" value="" disabled="disabled" />
                                </div>
                            </div>
                            <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <label for="ctelefono" class="active">Telefono:</label>
                                    <input id="ctelefono" type="number" placeholder=" " class="form-control conyuge CREDIFORM" data-m-dec="0" data-v-min="0" data-v-max="9999999999" data-a-sep="" value="0" disabled="disabled" />
                                </div>
                            </div>
                            <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <label for="ccorreo" class="active">Correo:</label>
                                    <input id="ccorreo" type="email" placeholder=" " class="form-control conyuge CREDIFORM" disabled="disabled" />
                                </div>
                            </div>
                        </div>
                        <div class="row panel" style="margin-top: 20px;">
                            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <label for="elaboraconyuge" class="active">Empresa donde Labora:</label>
                                    <input id="elaboraconyuge" type="text" placeholder=" " class="form-control conyuge CREDIFORM" value="" />
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <label for="cdireccion" class="active">Dirección:</label>
                                    <input id="cdireccion" type="text" placeholder=" " class="form-control conyuge CREDIFORM" value="" disabled="disabled" />
                                </div>
                            </div>
                            <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <label for="etelefono" class="active">Telefono:</label>
                                    <input id="etelefono" type="number" placeholder=" " class="form-control conyuge CREDIFORM" data-m-dec="0" data-v-max="99999999999" data-a-sep="" disabled="disabled" />
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-2 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <label for="esalario" class="active">Salario:</label>
                                    <input id="esalario" type="text" placeholder=" " class="form-control conyuge CREDIFORM" money="true" data-m-dec="2" data-v-min="0" data-v-max="999999999999999.99" data-a-sign="$ " value=" 0.00" disabled="disabled" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="portlet">
        <div class="card-header" id="InformacionLab">
            <h2 class="mb-0">
                <button class="btn btn-link text-left acordeon collapsed" style="text-align: left !important" type="button" data-toggle="collapse" data-target="#infoLaboral" aria-expanded="false" aria-controls="infoLaboral">
                    <div class="portlet-title evaluation notepad" data-note="Información Laboral" id="padre2" data-evaluation="LB" style="font-size: 10px;"></div>
                    <div class="caption">
                        <i class="fa fa-building"></i>Información Laboral<label id="" style="color: #57646f; font-weight: bold"></label>
                    </div>
                </button>
            </h2>
        </div>
        <div id="infoLaboral" class="collapse" aria-labelledby="InformacionLab" data-parent="#acordeonSol">
            <div class="card-body">
                <div class="panel">
                    <div class="form-body" id="info-laboral">
                        <div class="row panel">
                            <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <label for="TipoAct" class="active">Actividad:</label>
                                    <select id="TipoAct" runat="server" class="selectpicker CREDIFORM" clientidmode="static" data-size="8" title="Seleccione" data-live-search="true">
                                    </select>
                                </div>
                            </div>
                            <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <label for="TipoEmpleo" class="active">Empleo:</label>
                                    <select id="TipoEmpleo" runat="server" class="selectpicker CREDIFORM" clientidmode="static" data-size="8" title="Seleccione" data-live-search="true">
                                    </select>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-4 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <label for="sempresa" class="active">Empresa donde labora:</label>
                                    <input id="sempresa" type="text" placeholder=" " class="form-control empleosol CREDIFORM" value="" />
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-4 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <label for="sedireccion" class="active">Dirección:</label>
                                    <input id="sedireccion" type="text" placeholder=" " class="form-control empleosol CREDIFORM" value="" />
                                </div>
                            </div>
                            <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <label for="setelefono" class="active">Telefono:</label>
                                    <input id="setelefono" type="text" placeholder=" " class="form-control empleosol CREDIFORM" money="true" data-m-dec="0" data-v-max="99999999999" value="" data-a-sep="" />
                                </div>
                            </div>
                        </div>
                        <div class="row panel" style="margin-top: 20px;">
                            <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <label for="secargoactual" class="active">Cargo Actual:</label>
                                    <input id="secargoactual" type="text" placeholder=" " class="form-control empleosol CREDIFORM" value="" />
                                </div>
                            </div>
                            <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <label for="setiemposer" class="active">Tiempo Servicio:</label>
                                    <select id="setiemposer" class="selectpicker CREDIFORM" runat="server" clientidmode="static" data-size="8" title="Seleccione" data-live-search="true">
                                    </select>
                                </div>
                            </div>
                            <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <label for="sesalario" class="active">Salario:</label>
                                    <input id="sesalario" type="text" placeholder=" " class="form-control empleosol CREDIFORM" value="0.00" money="true" data-m-dec="2" data-v-max="9999999999.99" data-a-sign="$ " />
                                </div>
                            </div>
                            <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <label for="seotroing" class="active">Otros Ingresos:</label>
                                    <input id="seotroing" type="text" placeholder=" " class="form-control empleosol CREDIFORM" value=" 0.00" money="true" data-m-dec="2" data-v-max="9999999999.99" data-a-sign="$ " />
                                </div>
                            </div>
                            <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <label for="seconceptooi" class="active">Concepto:</label>
                                    <input id="seconceptooi" type="text" placeholder=" " class="form-control empleosol CREDIFORM" value="" />
                                </div>
                            </div>
                            <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <label for="gastos" class="active">Gastos:</label>
                                    <input id="gastos" type="text" placeholder=" " class="form-control empleosol CREDIFORM" value="0.00" money="true" data-m-dec="2" data-v-max="9999999999.99" data-a-sign="$ " />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="portlet">
        <div class="card-header" id="ReferenciaBank">
            <h2 class="mb-0">
                <button class="btn btn-link text-left acordeon collapsed" style="text-align: left !important" type="button" data-toggle="collapse" data-target="#refBancaria" aria-expanded="false" aria-controls="refBancaria">
                    <div class="portlet-title evaluation notepad" data-note="Referencia Bancaria" id="padre3" data-evaluation="BC" style="font-size: 10px;"></div>
                    <div class="caption">
                        <i class="fa fa-bank"></i>Referencia Bancaria<label id="" style="color: #57646f; font-weight: bold"></label>
                    </div>
                </button>
            </h2>
        </div>
        <div id="refBancaria" class="collapse" aria-labelledby="ReferenciaBank" data-parent="#acordeonSol">
            <div class="card-body">
                <div class="panel">
                    <div class="form-body" id="info-banc">
                        <div class="row panel">
                            <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
                                <div class="form-group">
                                    <label for="sbanco" class="active">Banco:</label>
                                    <input id="sbanco" type="text" placeholder=" " class="form-control CREDIFORM" value="" />
                                </div>
                            </div>
                            <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <label for="tipocuenta" class="active">Tipo Cuenta:</label>
                                    <select id="tipocuenta" class="selectpicker CREDIFORM" runat="server" clientidmode="static" data-size="8" title="Seleccione" data-live-search="true">
                                    </select>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <label for="ncuenta" class="active">N° Cuenta:</label>
                                    <input id="ncuenta" type="text" placeholder=" " class="form-control CREDIFORM" money="true" data-m-dec="0" data-v-max="999999999999999999999999" value="" data-a-sep="" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="portlet">
        <div class="card-header" id="ReferenciaFamyPer">
            <h2 class="mb-0">
                <button class="btn btn-link text-left acordeon collapsed" style="text-align: left !important" type="button" data-toggle="collapse" data-target="#collapseFive" aria-expanded="false" aria-controls="collapseFive">
                    <div class="portlet-title evaluation notepad" data-note="Referencias Personales" id="padre4" data-evaluation="RF" style="font-size: 10px;"></div>
                    <div class="caption">
                        <i class="fa fa-user"></i>Referencias Personales y Familiares
                    </div>
                </button>
            </h2>
        </div>
        <div id="collapseFive" class="collapse" aria-labelledby="ReferenciaFamyPer" data-parent="#acordeonSol">
            <div class="card-body">
                <div class="panel">
                    <div class="form-body" id="info-ref">
                        <div class=" row panel">
                            <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <label for="refnobre" class="active">Nombre:</label>
                                    <input type="text" class="form-control notbloque CREDIFORM" id="refnobre" placeholder=" " maxlength="120" />
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <label for="refdireccion" class="active">Dirección:</label>
                                    <input type="text" class="form-control notbloque CREDIFORM" id="refdireccion" placeholder=" " maxlength="120" />
                                </div>
                            </div>
                            <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <label for="reftelefono" class="active">Teléfono:</label>
                                    <input type="number" class="form-control notbloque CREDIFORM" id="reftelefono" max="2" data-v-max="2" />
                                </div>
                            </div>
                            <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <label for="tiporef" class="active">Tipo Referencia:</label>
                                    <select id="tiporef" class="selectpicker CREDIFORM" runat="server" clientidmode="static" data-size="8" title="Seleccione">
                                    </select>
                                </div>
                            </div>
                            <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <label for="id_parentez" class="active">Parentezco:</label>
                                    <select id="id_parentez" class="selectpicker CREDIFORM" runat="server" clientidmode="static" data-size="4" title="Seleccione">
                                    </select>
                                </div>
                            </div>
                            <div class="col-lg-1 col-md-1 col-sm-6 col-xs-12">
                                <button id="addref" type="button" class="btn btn-sin btn-circle addarticle bloque" title="Agregar" disabled="" style="margin-top: 10px;"><i class="fa fa-plus"></i></button>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <div class="table-responsive" style="max-height: 300px; text-align: center">
                                    <table class="table table-striped jambo_table" id="tblreferen">
                                        <thead>
                                            <tr>
                                                <th class="text-center">Eliminar</th>
                                                <th class="text-center">Nombre</th>
                                                <th class="text-center">Dirección</th>
                                                <th class="text-center">Teléfono</th>
                                                <th class="text-center">Tipo</th>
                                                <th class="text-center">Parentezco</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tbodyreferen">
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
