<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Solicitud.ascx.cs" Inherits="Solicitud" %>


<%--<link href="../Package/Vendor/css/plugins/steps/jquery.steps.css" rel="stylesheet" />--%>
<link href="../Package/Vendor/css/plugins/fileinput/fileinput.css" rel="stylesheet" />

<%--Estilos de el formulario de solicitudes de credito--%>
<style>
    #video {
        height: 270px !important;
    }
    #btnCancelPhoto, #btnSavePhoto {
        margin-top: 9px;
    }
     #ModalFoto {
        height:420px !important;
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
    }

    .wizard > .content > .body ul > li {
        display: unset;
    }

    #modal-foto {
        height: 530px;
    }
</style>

<%-- acordeon el cual contiene todos los inputs ´para 
    obtener la información solicitada para la persona (sea deudor o codeudor)--%>
<div class="accordion" id="acordeonSol">
    <div class="card">
        <div class="card-header" id="InformacionP">
            <h2 class="mb-0">
                <button class="btn btn-link text-left acordeon" style="text-align: left !important" type="button" data-toggle="collapse" data-target="#Infopersonal" aria-expanded="false" aria-controls="Infopersonal">



                    <i class="fa fa-user icono" role="button"></i>Información Personal &nbsp;&nbsp;<label id="titulosol" style="font-weight: bold"></label>




                </button>
            </h2>
        </div>

        <div id="Infopersonal" class="collapse" aria-labelledby="InformacionP" data-parent="#acordeonSol">

            <div class="card-body">

                <div class="col-lg-10 col-md-10 col-sm-12 col-xs-12">
                    <div class="row">
                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                            <div class="form-group">
                                <label for="Selectipoper" class="active">Tipo Persona:</label>
                                <select id="Selectipoper" runat="server" clientidmode="static" data-size="8" class="form-control CREDIFORM selectpicker" title="Seleccione" data-live-search="true">
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                            <div class="form-group">
                                <label for="id_tipoiden" class="active">Tipo iden:</label>
                                <select id="id_tipoiden" runat="server" clientidmode="static" data-size="8" class="form-control CREDIFORM selectpicker" title="Seleccione" data-live-search="true">
                                </select>
                            </div>
                        </div>
                        <%--<div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                        <div class="form-group">
                            <label for="iden" class="active">Identificación:</label>
                            <input id="iden" type="text" placeholder=" " class="form-control CREDIFORM" value="" />
                        </div>
                    </div>--%>

                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                            <div class="input-group ">
                                <div class="form-group">
                                    <label for="iden" class="active">Identificación:</label>
                                    <input id="iden" type="text" placeholder=" " class="form-control CREDITFORM" value="" autocomplete="off">
                                </div>
                                <span class="input-group-addon ">
                                    <label id="identificacion" class="lado" for="iden" style="margin-left: 8px; font-family: sans-serif; color: #3d3f41a8" onfocus="false">1</label>
                                </span>
                            </div>
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                            <div class="form-group">
                                <label for="pnombre" class="active">Primer nombre:</label>
                                <input id="pnombre" type="text" placeholder=" " class="form-control CREDIFORM" value="" runat="server" clientidmode="static" />
                            </div>
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                            <div class="form-group">
                                <label for="snombre" class="active">Segundo nombre:</label>
                                <input id="snombre" type="text" placeholder=" " class="form-control CREDIFORM" />
                            </div>
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                            <div class="form-group">
                                <label for="papellido" class="active">Primer apellido:</label>
                                <input id="papellido" type="text" placeholder=" " class="form-control CREDIFORM" value="" />
                            </div>
                        </div>


                    </div>
                    <div class="row">

                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                            <div class="form-group">
                                <label for="sapellido" class="active">Segundo apellido:</label>
                                <input id="sapellido" type="text" placeholder=" " class="form-control CREDIFORM" value="" />
                            </div>
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                            <div class="form-group">
                                <label for="ecivil" class="active">Estado civil:</label>
                                <select id="ecivil" runat="server" clientidmode="static" data-size="8" class="form-control CREDIFORM selectpicker" title="Seleccione" data-live-search="true">
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                            <div class="form-group">
                                <label for="pcargo" class="active">Per. a cargo:</label>
                                <input id="pcargo" type="text" placeholder=" " class="form-control CREDIFORM" money="true" data-m-dec="0" data-v-min="0" data-v-max="100" value="0.00" />
                            </div>
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                            <div class="form-group">
                                <label for="escolaridad" class="active">Escolaridad:</label>
                                <select id="escolaridad" runat="server" clientidmode="static" data-size="8" class="form-control CREDIFORM selectpicker" title="Seleccione" data-live-search="true">
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                            <div class="form-group">
                                <label for="scorreo" class="active">Correo:</label>
                                <input id="scorreo" type="text" placeholder=" " class="form-control CREDIFORM notbloque" value="" autocomplete="off" />
                            </div>
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                            <div class="form-group">
                                <label for="genero" class="active">Genero:</label>
                                <select id="genero" runat="server" clientidmode="static" data-size="8" class="form-control CREDIFORM selectpicker" title="Seleccione" data-live-search="true">
                                </select>
                            </div>
                        </div>

                    </div>
                    <div class="row">
                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                            <div class="form-group">
                                <label for="estrato" class="active">Estrato:</label>
                                <select id="estrato" runat="server" clientidmode="static" data-size="8" class="form-control CREDIFORM selectpicker" title="Seleccione" data-live-search="true">
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                            <div class="form-group">
                                <label for="scelular" class="active">Celular:</label>
                                <input id="scelular" type="text" placeholder=" " class="form-control CREDIFORM notbloque" value="" money="true" data-m-dec="0" data-v-max="9999999999" data-a-sep="" autocomplete="off" />
                            </div>
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                            <div class="form-group">
                                <label for="sotrotel" class="active">Tel Alternativo:</label>
                                <input id="sotrotel" type="text" placeholder=" " class="form-control CREDIFORM notbloque" value="" money="true" data-m-dec="0" data-v-max="9999999999" data-a-sep="" autocomplete="off" />
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-5 col-sm-12 col-xs-12">
                            <div class="form-group">
                                <label for="direccion" class="active">Direccion Residencia:</label>
                                <input id="direccion" type="text" placeholder=" " class="form-control CREDIFORM direcresi" value="" readonly="" ondblclick="$('#ModalDireccion').modal({ backdrop: 'static', keyboard: false }, 'show');" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                            <div class="form-group">
                                <label for="Text_city" class="active">Ciudad:</label>
                                <select runat="server" clientidmode="static" id="Text_city" data-size="8" class="form-control CREDIFORM selectpicker" title="Ciudad" data-live-search="true">
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                            <div class="form-group">
                                <label for="vinmueble" class="active">Tipo de Vivienda:</label>
                                <select id="vinmueble" runat="server" clientidmode="static" data-size="8" class="form-control CREDIFORM selectpicker" title="Seleccione" data-live-search="true">
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                            <div class="form-group">
                                <label for="varriendo" class="active">Valor arriendo:</label>
                                <input id="varriendo" type="text" placeholder=" " class="form-control CREDIFORM" money="true" data-m-dec="2" data-v-min="0.00" data-a-sign="$ " data-v-max="999999999999.99" value="$ 0.00" disabled="disabled" autocomplete="off" />
                            </div>
                        </div>
                        <%--                    <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                        <div class="form-group">
                            <label for="fraiz" class="active">Finca raiz:</label>
                            <select id="fraiz" runat="server" clientidmode="static" data-size="8" class="form-control CREDIFORM selectpicker" title="Seleccione" data-live-search="true">
                            </select>
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                        <div class="form-group">
                            <label for="fraizcual" class="active">Cual?:</label>
                            <input id="fraizcual" type="text" placeholder=" " class="form-control CREDIFORM" value="" />
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                        <div class="form-group">
                            <label for="Vehiculo" class="active">Vehiculo:</label>
                            <input id="vehiculo" type="text" placeholder=" " class="form-control CREDIFORM" value="" />
                        </div>
                    </div>--%>
                    </div>
                </div>
                <div class="col-lg-2 col-md-2 col-sm-12 col-xs-12">
                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="border: 1px solid #ccc;">
                        <div class="form-group">
                            <label>Foto</label>
                            <input id="foto" name="foto" data-name="FOTO" type="button" runat="server" clientidmode="Static" class="dropify CREDIFORM" data-height="205" data-max-file-size="5M"
                                data-allowed-file-extensions="jpg png jpeg" data-max-file-size-preview="5M" />
                        </div>
                        <div class="row">
                            <br />
                        </div>
                    </div>

                </div>


            </div>
        </div>
    </div>
    <div class="card">
        <div class="card-header" id="InformacionCon">
            <h2 class="mb-0">
                <button class="btn btn-link text-left acordeon collapsed" style="text-align: left !important" type="button" data-toggle="collapse" data-target="#infoconyugue" aria-expanded="true" aria-controls="infoconyugue">
                    <div class="portlet-title notepad" data-note="Información Conyuge">
                        <div class="caption">
                            <i class="fa fa-home icono"></i>Información Conyuge                                                 
                        </div>
                    </div>
                </button>
            </h2>
        </div>
        <div id="infoconyugue" class="collapse" aria-labelledby="InformacionCon" data-parent="#acordeonSol">
            <div class="card-body">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="row">
                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                            <div class="form-group">
                                <label for="nconyuge" class="active">Nombre Completo:</label>
                                <input id="nconyuge" type="text" placeholder=" " class="form-control CREDIFORM conyuge" value="" disabled="disabled" />
                            </div>
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                            <div class="form-group">
                                <label for="ctelefono" class="active">Telefono:</label>
                                <input id="ctelefono" type="text" placeholder=" " class="form-control CREDIFORM conyuge" money="true" data-m-dec="0" data-v-min="0" data-v-max="9999999999" data-a-sep="" value="0" disabled="disabled" autocomplete="off" />
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                            <div class="form-group">
                                <label for="elaboraconyuge" class="active">Empresa donde labora:</label>
                                <input id="elaboraconyuge" type="text" placeholder=" " class="form-control CREDIFORM conyuge" value="" />
                            </div>
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                            <div class="form-group">
                                <label for="esalario" class="active">Ingresos:</label>
                                <input id="esalario" type="text" placeholder=" " class="form-control CREDIFORM conyuge" money="true" data-m-dec="2" data-v-min="0" data-v-max="999999999999999.99" data-a-sign="$ " value="$ 0.00" disabled="disabled" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <br />
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="card">
        <div class="card-header" id="InformacionLab">
            <h2 class="mb-0">
                <button class="btn btn-link text-left acordeon collapsed" style="text-align: left !important" type="button" data-toggle="collapse" data-target="#infoLaboral" aria-expanded="false" aria-controls="infoLaboral">
                    <div class="portlet-title evaluation notepad" data-note="Información Laboral" data-evaluation="LB">
                        <div class="caption">
                            <i class="fa fa-building icono"></i>Información Laboral                                                 
                        </div>
                    </div>
                </button>
            </h2>
        </div>
        <div id="infoLaboral" class="collapse" aria-labelledby="InformacionLab" data-parent="#acordeonSol">
            <div class="card-body">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="row">
                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                            <div class="form-group">
                                <label for="TipEmpleo" class="active">Actividad Principal:</label>
                                <select id="TipEmpleo" runat="server" clientidmode="static" data-size="8" class="form-control CREDIFORM selectpicker" title="Seleccione" data-live-search="true">
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                            <div class="form-group">
                                <label for="sempresa" class="active">Empresa donde labora:</label>
                                <input id="sempresa" type="text" placeholder=" " class="form-control CREDIFORM empleosol" value="" />
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                            <div class="form-group">
                                <label for="sedireccion" class="active">Dirección:</label>
                                <input id="sedireccion" type="text" placeholder=" " class="form-control CREDIFORM empleosol" value="" />
                            </div>
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                            <div class="form-group">
                                <label for="setelefono" class="active">Telefono:</label>
                                <input id="setelefono" type="text" placeholder=" " class="form-control CREDIFORM empleosol" money="true" data-m-dec="0" data-v-max="99999999999" value="" data-a-sep="" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                            <div class="form-group">
                                <label for="secargoactual" class="active">Cargo Actual:</label>
                                <input id="secargoactual" type="text" placeholder=" " class="form-control CREDIFORM empleosol" value="" />
                            </div>
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                            <div class="form-group">
                                <label for="setiemposer" class="active">Tiempo Servicio:</label>
                                <select id="setiemposer" runat="server" clientidmode="static" data-size="8" class="form-control CREDIFORM selectpicker empleosol" title="Seleccione" data-live-search="true">
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                            <div class="form-group">
                                <label for="sesalario" class="active">Salario:</label>
                                <input id="sesalario" type="text" placeholder=" " class="form-control CREDIFORM empleosol" value="" money="true" data-m-dec="0" data-v-max="9999999999" data-a-sign="$ " />
                            </div>
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                            <div class="form-group">
                                <label for="seotroing" class="active">Otros Ingresos:</label>
                                <input id="seotroing" type="text" placeholder=" " class="form-control CREDIFORM empleosol" value="$ 0.00" money="true" data-m-dec="2" data-v-max="9999999999.99" data-a-sign="$ " />
                            </div>
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                            <div class="form-group">
                                <label for="seconceptooi" class="active">Concepto:</label>
                                <input id="seconceptooi" type="text" placeholder=" " class="form-control CREDIFORM empleosol" value="" />
                            </div>
                        </div>
                        <%--            <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                <div class="form-group">
                    <label for="gastos" class="active">Gastos:</label>
                    <input id="gastos" type="text" placeholder=" " class="form-control CREDIFORM empleosol" value="$ 0.00" money="true" data-m-dec="2" data-v-max="9999999999.99" data-a-sign="$ " />
                </div>
            </div>--%>
                    </div>
                    <div class="row">
                        <br />
                    </div>
                </div>


            </div>

        </div>
    </div>
    <%--<div class="card">
    <div class="card-header" id="ReferenciaBank">
      <h2 class="mb-0">
        <button class="btn btn-link text-left acordeon collapsed" style="text-align:left !important" type="button" data-toggle="collapse" data-target="#refBancaria" aria-expanded="false" aria-controls="refBancaria">


        <div class="portlet-title evaluation notepad" data-note="Referencia Bancaria" data-evaluation="BC">
        <div class="caption">
            <i class="fa fa-bank icono"></i> Referencia Bancaria                                                 
        </div>
    </div>


        </button>
      </h2>
    </div>
    <div id="refBancaria" class="collapse" aria-labelledby="ReferenciaBank" data-parent="#acordeonSol">

      <div class="card-body">

        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
           <div class="row">
            <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
                <div class="form-group">
                    <label for="sbanco" class="active">Banco:</label>
                    <input id="sbanco" type="text" placeholder=" " class="form-control CREDIFORM" value="" />
                </div>
            </div>
            <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                <div class="form-group">
                    <label for="tipocuenta" class="active">Tipo Cuenta:</label>
                    <select id="tipocuenta" runat="server" clientidmode="static" data-size="8" class="form-control CREDIFORM selectpicker" title="Seleccione" data-live-search="true">
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
           <div class="row"><br /></div>
        </div>


      </div>

    </div>
  </div>--%>
    <div class="card">
        <div class="card-header" id="ReferenciaFamyPer">
            <h2 class="mb-0">
                <button class="btn btn-link text-left acordeon collapsed" style="text-align: left !important" type="button" data-toggle="collapse" data-target="#collapseFive" aria-expanded="false" aria-controls="collapseFive">
                    <div class="portlet-title evaluation notepad" data-note="Información Per y/o Fam" data-evaluation="RF">
                        <div class="caption">
                            <i class="fa fa-user icono"></i>Referencias Personales y Familiares
                        </div>
                    </div>
                </button>
            </h2>
        </div>
        <div id="collapseFive" class="collapse" aria-labelledby="ReferenciaFamyPer" data-parent="#acordeonSol">
            <div class="card-body">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class=" row">
                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                            <div class="form-group">
                                <label for="Text_color" class="active">Nombre:</label>
                                <input type="text" class="form-control notbloque" id="refnobre" placeholder=" " maxlength="120" />
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                            <div class="form-group">
                                <label for="Text_color" class="active">Dirección:</label>
                                <input type="text" class="form-control notbloque" id="refdireccion" placeholder=" " maxlength="120" />
                            </div>
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                            <div class="form-group">
                                <label for="Text_color" class="active">Teléfono:</label>
                                <input type="text" class="form-control notbloque" id="reftelefono" placeholder=" " maxlength="20" money="true" data-a-dec="." data-a-sep="" data-m-dec="0" data-v-max="99999999999999" />
                            </div>
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                            <div class="form-group">
                                <label for="tiporef" class="active">Tipo Referencia:</label>
                                <select id="tiporef" runat="server" clientidmode="static" data-size="8" class="form-control selectpicker notbloque" title="Seleccione">
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
                            <div class="form-group">
                                <label for="id_parentez" class="active">Parentezco:</label>
                                <select id="id_parentez" runat="server" clientidmode="static" data-size="4" class="form-control selectpicker notbloque" title="Seleccione">
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-1 col-md-1 col-sm-6 col-xs-12">
                            <button id="addref" type="button" class="btn btn-sin btn-circle addarticle notbloque" title="Agregar" style="margin-top: 10px; margin-bottom: 10px;"><i class="fa fa-plus"></i></button>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                            <div class="table-responsive" style="max-height: 300px;">
                                <table class="table table-striped jambo_table" id="tblreferen">
                                    <thead>
                                        <tr>
                                            <th class="text-center">#</th>
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

<%--Modal para tomar la direccion de la persona (sea deudor o codeudor)--%>
<div class="modal fade" id="ModalDireccion">
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
                            <input id="tmpdireccion" type="text" placeholder=" " class="form-control notbloque col-md-8" value="" style="margin-left: 5px; background: #1ab3946e;">
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-3 col-sm-4 col-xs-12 sn-padding" style="margin-top: 20px; margin-left: 5px;">
                        <button id="adddirec" type="button" class="btn btn-sin btn-circle addarticle notbloque" title="Agregar" style="height: 40px; width: 40px; margin-bottom: 10px;"><i class="fa fa-plus"></i></button>
                        <button id="remdirec" type="button" class="btn btn-sin btn-circle addarticle notbloque" title="Remover" style="height: 40px; width: 40px; margin-bottom: 10px; background: #9c2323 !important"><i class="fa fa-remove"></i></button>
                    </div>
                    <div class="col-lg-5 col-md-5 col-sm-4 col-xs-12 sn-padding">
                        <div class="row" style="margin-bottom: 5px; margin-left: 1px;">
                            <input id="tempdir" class="form-control" type="text" placeholder="" style="text-transform: uppercase" readonly="true" disabled="">
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
                <button id="btnCancelPhoto" type="button" data-id="0" class="pull-right btn btn-danger" data-dismiss="modal" aria-label="Close">Cancelar</button>
                &nbsp;
                    <button id="btnSavePhoto" type="button" data-id="0" class="pull-right btn btn-primary ink-reaction btn-raised btn-loading-state" data-loading-text="<i class='fa fa-spinner fa-spin'></i> Cargando..." style="margin-right: 5px" data-dismiss="modal" aria-label="Close">Completar</button>
            </div>



        </div>
    </div>
</div>
   

<%--<script src="../Package/Vendor/js/plugins/steps/jquery.steps.js"></script>--%>
<script src="../Package/Vendor/js/plugins/fileinput/fileinput.js"></script>

