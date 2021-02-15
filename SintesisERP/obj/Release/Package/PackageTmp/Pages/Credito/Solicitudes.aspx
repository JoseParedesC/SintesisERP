<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Solicitudes.aspx.cs"
    Inherits="Solicitudes" MasterPageFile="~/Masters/SintesisLayout.Master" %>

<%@ Register Src="~/Pages/Controles/Solicitud.ascx" TagName="Solicitud" TagPrefix="sl1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPage" runat="server">
    <script type="text/javascript">
        window.appPath = "<%=Request.ApplicationPath%>";
    </script>

    <%--estilos que se usan en la pagina--%>
    <style>
        .wizard-big input.form-control, .wizard-big .btn-group.bootstrap-select.form-control {
            border: solid 1px #d0d0d0;
            border-radius: 3px !important;
            height: 28px !important;
            background-image: none;
        }

        .wizard-big .bootstrap-select .dropdown-toggle {
            height: 26px !important;
            padding: 0px !important;
        }

        .wizard-big {
            font-size: 13px;
        }

            .wizard-big input.form-control.is-focused {
                background-image: none !important;
            }

            .wizard-big .form-control:focus, .single-line:focus {
                border-color: #0074bcf0 !important;
                background-image: none !important;
            }

        .roundImg {
            border-radius: 50% !important;
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
        }

        div.contact p {
            color: #000000ed;
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

        .bot:after {
            content: "Nueva Solicitud";
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
            padding: 15px 25px;
            border-radius: 5px;
            background: #fff;
            border: solid 1px #ccc;
            overflow-y: auto;
            padding-top: 30px;
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

        .icono:before {
            margin: 2px !important;
        }

        .lado {
            margin-top: 26px !important;
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
                /*margin: 80px auto 76px auto;*/
            }

        .container-fluid {
            background-color: white !important;
        }

        .btn-danger[disabled] {
            color: white;
            background-color: #ed5565 !important;
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

        input[disabled], textarea[readonly] {
            cursor: no-drop;
        }

        @keyframes slidein {
            from {
                margin-top: -50px;
                box-shadow: inset 0 0 0 #ffffff00, 0 5px 0 0 #ffffff00, 0 10px 5px #ffffff00;
                background-color: #ffffff00;
                color: #ffffff00;
                border-color: #ffffff00;
            }

            to {
                margin-top: 0%;
            }
        }
    </style>

    <%--la interfaz principal de la Solicitudes de Credito--%>
    <div class="wrapper wrapper-content" style="padding-top: 5px; background: #fff !important;">
        <div class="row" style="margin-left: 0; margin-right: 0;">
            <div class="x_panel">
                <div class="x_title col-lg-6 col-md-6 col-sm-7 col-xs-12">
                    <h1 class="title-master" style="margin-top: 0;"><span class="fa fa-file fa-fw"></span>Solicitud de Credito</h1>
                    <div class="clearfix"></div>
                </div>

                <%--los botones de la parte superior de la pagina--%>
                <div class="col-lg-6 col-md-6 col-sm-5 col-xs-12 ">
                    <button title="Guardar" id="btnguardar" class="btn btn-outline btn-primary dim  pull-right" type="button" disabled="disabled"><i class="fa fa-paste"></i></button>
                    <button title="Analizar" id="btnNext" class="btn btn-outline btn-success dim  pull-right" data-loading-text="<i class='fa fa-spinner fa-spin'></i>" type="button" data-estado="ENANAL" disabled="disabled"><i class="fa fa-mail-forward"></i></button>
                    <button title="Imprimir" id="btnPrint" data-option="I" class="btn btn-outline btn-info dim  pull-right" type="button"><i class="fa fa-print"></i></button>
                    <button title="Nueva" id="btnnew" data-option="R" class="btn btn-outline btn-default  dim  pull-right" type="button"><i class="fa-file-o fa"></i></button>
                    <button title="Listar" id="btnList" data-option="L" class="btn btn-outline btn-info  dim  pull-right" type="button"><i class="fa-list fa"></i></button>
                </div>


                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding: 3px">
                    <div class="content clearfix" style="display: block; margin: 5px 5px 10px 5px;" id="divcabecera">
                        <fieldset class="bot">
                            <%--contenido la información basica de la solicitud--%>
                            <div class="row">
                                <input type="hidden" value="solicitante" id="class" />
                                <input type="hidden" value="CL" id="tipoper" />

                                <div id="divloading" style="display: none; font-size: 18px; position: absolute; right: 15px; top: 10px; font-weight: bold;"><span class="fa fa-spinner fa-spin"></span>&nbsp;Cargando...</div>
                                <div class="col-lg-2 col-md-2 col-sm-6 sn-padding">
                                    <div class="form-group">
                                        <label for="numsolic" class="active"># Solicitud:</label>
                                        <div class="input-group">
                                            <div class="input-group-addon">
                                                <i class="fa fa-tag"></i>
                                                <input name="numsolic" id="numsolic" type="text" class="form-control" placeholder="N° Solicitud" disabled="disabled" />
                                            </div>
                                            <input type="hidden" value="0" id="id_solicitud" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-2 col-md-2 col-sm-6 sn-padding">
                                    <div class="form-group">
                                        <label for="estado" class="active">Estado:</label>
                                        <div class="input-group">
                                            <div class="input-group-addon">
                                                <i class="fa fa-gear"></i>
                                                <input id="estado" type="text" placeholder="Estado" class="form-control" disabled="disabled" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-3 col-md-3 col-sm-6 sn-padding">
                                    <div class="form-group">
                                        <label for="Text_Fecha" class="active">Fecha:</label>
                                        <div class="input-group">
                                            <div class="input-group-addon">
                                                <i class="fa fa-calendar"></i>
                                                <input id="Text_Fecha" type="text" placeholder=" " class="form-control" disabled="disabled" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12 sn-padding">
                                    <div class="form-group">
                                        <label for="Text_Nombre" class="active">Cotización</label>
                                        <div class="input-group ">
                                            <input type="hidden" id="estadocoti" value="PROCE" />
                                            <input type="hidden" id="cd_cotizacion" value="" runat="server" clientidmode="static" />
                                            <input type="hidden" id="id_persona" runat="server" clientidmode="static" value="0" />
                                            <input type="hidden" id="identi_per" value="0" runat="server" clientidmode="static" />
                                            <input type="text" class="form-control inputsearch" placeholder=" " readonly="readonly" runat="server" clientidmode="static" id="ds_cliente" aria-describedby="sizing-addon1" value="" />
                                            <span class="input-group-addon ">
                                                <button id="id_AccountBox" type="button" class="btn btn-primary btnsearch" data-search="Facturas" data-method="CotizacionList" data-title="Cotizaciones" data-select="1,2,3" data-column="id,cliente,identificacion,estado" data-params="estado,estadocoti" data-fields="cd_cotizacion,ds_cliente,identi_per">
                                                    <i class="fa fa-fw fa-search"></i>
                                                </button>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-2 col-md-2 col-sm-4 col-xs-12 Botns sn-padding" style="margin-top: 10px;">
                                    <div class="group" role="group" aria-label="Button group with nested dropdown" style="z-index: 999;">
                                        <div class="btn-group group1 Botns pull-left" role="group">
                                            <button title="Concluir" style="height: 36px; width: 37px; color: #4389b5; font-size: 20px; text-align: center" id="btnConc" data-option="UC" class="btn btn-outline btn-success dim pull-left btn-add dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" type="button">
                                                <i class="fa fa-sort-down" style="position: relative; bottom: 5px;"></i>
                                            </button>
                                            <div class="dropdown-menu" id="dropdown-menu" aria-labelledby="btnGroupDrop1">
                                                <a class="dropdown-item" href="#">
                                                    <button title="Agregar Solicitante" id="btnSol" data-tipo="CL" class="btn btn-outline btn-info dim  pull-left" style="margin-top: -3px !important;" data-loading-text="<i class='fa fa-spinner fa-spin'></i>" type="button"><i class="fa fa-plus"></i></button>
                                                </a>
                                                <a class="dropdown-item" href="#">
                                                    <button title="Agregar Codeudor" id="btnCod" data-tipo="CO" class="btn btn-outline btn-warning dim  pull-left" style="margin-top: 0px !important;" data-loading-text="<i class='fa fa-spinner fa-spin'></i>" type="button"><i class="fa fa-plus"></i></button>
                                                </a>
                                            </div>
                                        </div>
                                        <button title="Limpiar Formulario" id="btnCan" data-tipo="CO" class="btn btn-outline btn-danger dim  pull-left" data-loading-text="<i class='fa fa-spinner fa-spin'></i>" type="button" disabled="disabled"><i class="fa fa-eraser"></i></button>
                                        <button title="Atrás" id="atras" class="btn btn-outline btn-warning  dim  pull-left" type="button" style="display: none; font-size: x-large; height: 37px; padding-top: 0px;"><i class="fa fa-angle-double-left"></i></button>
                                    </div>


                                </div>
                            </div>

                            <%--comentarios--%>
                            <div class="row" id="divagregados">
                                <div class="col-lg-12">
                                    <div class="form-group">
                                        <label for="observaciones" class="active">Observaciones:</label>
                                        <textarea id="observaciones" rows="3" placeholder=" " class="form-control" style="min-height: 100px; max-height: 100px; max-width: 100%; min-width: 100%;"></textarea>
                                    </div>
                                </div>
                                <input type="hidden" value="0" id="id_solper" />
                                <div class="col-lg-12">
                                    <h3>Agregados</h3>
                                </div>
                            </div>
                        </fieldset>
                    </div>

                    <canvas id="canvas" height="240" width="320" style="display: none"></canvas>
                    <div class="ibox-content" style="display: none;" id="divregistro">

                        <p>Este formulario esta realizado para la captura de la información del cliente o codeudor que solicitaran un credito.</p>
                        <div id="form" class="wizard-big">

                            <%--abre el formulario (ascx)--%>
                            <h1>Información</h1>
                            <sl1:Solicitud ID="solicitud" runat="server" />

                            <%--crea una seccion del acordeon creado en el ascx para el formulario--%>
                            <div class="card">
                                <div class="card-header" id="archiv">
                                    <h2 class="mb-0">
                                        <button class="btn btn-link text-left acordeon collapsed" style="text-align: left !important" type="button" data-toggle="collapse" data-target="#archivo" aria-expanded="false" aria-controls="archivo">


                                            <div class="portlet-title evaluation notepad" data-note="Archivos" data-evaluation="BC">
                                                <div class="caption">
                                                    <i class="fa fa-file icono"></i>Archivos                                                  
                                                </div>
                                            </div>


                                        </button>
                                    </h2>
                                </div>
                                <div id="archivo" class="collapse" aria-labelledby="archiv" data-parent="#acordeonSol">

                                    <div class="card-body">

                                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                            <div class="row">

                                                <div class="col-lg-8 filesSoicitud">
                                                    <div class="form-group">
                                                        <label>Archivos:</label>
                                                        <div class="file-loading">
                                                            <input id="archivos" name="archivos" type="file" data-name="CEDULA" multiple="multiple" data-show-preview="true" data-allowed-file-extensions='["pdf", "png", "jpg"]' />
                                                        </div>
                                                    </div>
                                                </div>
                                                <%--<div class="col-lg-4 filesSoicitud">
                                                    <div class="form-group">
                                                        <button id="btnCaphue" type="button" data-id="0" class="pull-right btn btn-primary ink-reaction btn-raised btn-loading-state" data-loading-text="<i class='fa fa-spinner fa-spin'></i> Cargando..." style="margin-right: 5px">Capturar Huella</button>
                                                    </div>
                                                </div>--%>
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
                                            <div class="row">
                                                <br />
                                            </div>
                                        </div>


                                    </div>

                                </div>
                            </div>

                            <div class="row">
                                <br />
                                <br />
                                <br />
                                <br />
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%--Modal para capturar la huella--%>
    <div class="modal fade" id="ModalHuella">
        <div class="modal-dialog modal-sm" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h2 class="modal-title">Toma de Huella</h2>
                </div>
                <div class="modal-body clearfix" style="margin-bottom: 0;">
                    <div class="row" style="padding-bottom: 20px">
                        <div class="col-lg-12">
                            <img id="huella" style="width: 100%; height: 300px;" />
                        </div>
                    </div>

                    <div class=" row">
                        <div class="col-lg-12">
                            <button id="btnCance" type="button" data-id="0" class="pull-right btn btn-danger" data-dismiss="modal" aria-label="Close">Cancelar</button>
                            &nbsp;
                            <button id="btnSaveAdd" type="button" data-id="0" class="pull-right btn btn-primary ink-reaction btn-raised btn-loading-state" data-loading-text="<i class='fa fa-spinner fa-spin'></i> Cargando..." style="margin-right: 5px">Guardar</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%--Modal para elegir la cotización--%>
    <div class="modal fade" id="ModalCotizaciones">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h2 class="modal-title">Detalle de Solicitudes</h2>
                </div>
                <div class="modal-body clearfix" style="margin-bottom: 0;">
                    <div class="table-responsive" style="max-height: 500px">
                        <table class="table table-striped jambo_table" id="tblsolicitudes">
                            <thead>
                                <tr>
                                    <th data-column-id="edit" data-formatter="edit" data-sortable="false" style="max-width: 30px !important;">Editar</th>
                                    <th data-column-id="consecutivo">N°</th>
                                    <th data-column-id="fecha">Fecha</th>
                                    <th data-column-id="identificacion">Identificación</th>
                                    <th data-column-id="cliente">Cliente</th>
                                    <th data-column-id="producto">Producto</th>
                                    <th data-column-id="asesor">Asesor</th>
                                    <th data-column-id="estado">Estado</th>
                                </tr>
                            </thead>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%--</main>--%>
    <span class="ir-arriba fa fa-sort-asc"></span>
    <script src="../Pages/ScriptsPage/Credito/Solicitudes.js"></script>

    <script>
        $(document).ready(function () {
            $('.i-checks').iCheck({
                checkboxClass: 'icheckbox_square-green',
                radioClass: 'iradio_square-green',
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

        });

    </script>

    <script>
        $(document).on('ready', function () {
            datepicker();
            //$("#foto, #archivos").fileinput({
            //    theme: 'fa',
            //    showUpload: false,
            //    uploadUrl: "/file-upload-batch/2",
            //    dropZoneEnabled: false,
            //    maxFileCount: 12,
            //    mainClass: "input-group-lg"
            //});
        });

        /*
                var pos = 0;
                var ctx = null;
                var cam = null;
                var image = null;

                var filter_on = false;
                var filter_id = 0;

                function changeFilter() {
                    if (filter_on) {
                        filter_id = (filter_id + 1) & 7;
                    }
                }

                function toggleFilter(obj) {
                    if (filter_on = !filter_on) {
                        obj.parentNode.style.borderColor = "#c00";
                    } else {
                        obj.parentNode.style.borderColor = "#333";
                    }
                }

                $("#webcam").webcam({

                    width: 320,
                    height: 240,
                    mode: "callback",*/
            <%--swffile: '<%=ResolveUrl("~/Package/Vendor/js/plugins/Webcam_Plugin/jscam_canvas_only.swf") %>',*/--%>

        /*  onTick: function (remain) {

              if (0 == remain) {
                  jQuery("#status").text("Cheese!");
              } else {
                  jQuery("#status").text(remain + " seconds remaining...");
              }
          },

          onSave: function (data) {

              var col = data.split(";");
              var img = image;

              if (false == filter_on) {

                  for (var i = 0; i < 320; i++) {
                      var tmp = parseInt(col[i]);
                      img.data[pos + 0] = (tmp >> 16) & 0xff;
                      img.data[pos + 1] = (tmp >> 8) & 0xff;
                      img.data[pos + 2] = tmp & 0xff;
                      img.data[pos + 3] = 0xff;
                      pos += 4;
                  }

              } else {

                  var id = filter_id;
                  var r, g, b;
                  var r1 = Math.floor(Math.random() * 255);
                  var r2 = Math.floor(Math.random() * 255);
                  var r3 = Math.floor(Math.random() * 255);

                  for (var i = 0; i < 320; i++) {
                      var tmp = parseInt(col[i]);

                      /* Copied some xcolor methods here to be faster than calling all methods inside of xcolor and to not serve complete library with every req *-/

                      if (id == 0) {
                          r = (tmp >> 16) & 0xff;
                          g = 0xff;
                          b = 0xff;
                      } else if (id == 1) {
                          r = 0xff;
                          g = (tmp >> 8) & 0xff;
                          b = 0xff;
                      } else if (id == 2) {
                          r = 0xff;
                          g = 0xff;
                          b = tmp & 0xff;
                      } else if (id == 3) {
                          r = 0xff ^ ((tmp >> 16) & 0xff);
                          g = 0xff ^ ((tmp >> 8) & 0xff);
                          b = 0xff ^ (tmp & 0xff);
                      } else if (id == 4) {

                          r = (tmp >> 16) & 0xff;
                          g = (tmp >> 8) & 0xff;
                          b = tmp & 0xff;
                          var v = Math.min(Math.floor(.35 + 13 * (r + g + b) / 60), 255);
                          r = v;
                          g = v;
                          b = v;
                      } else if (id == 5) {
                          r = (tmp >> 16) & 0xff;
                          g = (tmp >> 8) & 0xff;
                          b = tmp & 0xff;
                          if ((r += 32) < 0) r = 0;
                          if ((g += 32) < 0) g = 0;
                          if ((b += 32) < 0) b = 0;
                      } else if (id == 6) {
                          r = (tmp >> 16) & 0xff;
                          g = (tmp >> 8) & 0xff;
                          b = tmp & 0xff;
                          if ((r -= 32) < 0) r = 0;
                          if ((g -= 32) < 0) g = 0;
                          if ((b -= 32) < 0) b = 0;
                      } else if (id == 7) {
                          r = (tmp >> 16) & 0xff;
                          g = (tmp >> 8) & 0xff;
                          b = tmp & 0xff;
                          r = Math.floor(r / 255 * r1);
                          g = Math.floor(g / 255 * r2);
                          b = Math.floor(b / 255 * r3);
                      }

                      img.data[pos + 0] = r;
                      img.data[pos + 1] = g;
                      img.data[pos + 2] = b;
                      img.data[pos + 3] = 0xff;
                      pos += 4;
                  }
              }

              if (pos >= 0x4B000) {
                  ctx.putImageData(img, 0, 0);
                  pos = 0;
              }
              var canvass = document.getElementById("canvas");
              var imgs = canvass.toDataURL("image/png");
              $("#foto").fileinput({
                  theme: 'fa',
                  showUpload: false,
                  uploadUrl: "/file-upload-batch/2",
                  dropZoneEnabled: false,
                  maxFileCount: 12,
                  mainClass: "input-group-lg",
                  initialPreview: [
                      "<img class='kv-preview-data file-preview-image' src='" + imgs + "'>"
                  ],
              });
              $('#imagen').attr('src', imgs);
          },

          onCapture: function () {
              webcam.save();

              jQuery("#flash").css("display", "block");
              jQuery("#flash").fadeOut(100, function () {
                  jQuery("#flash").css("opacity", 1);
              });
          },

          debug: function (type, string) {
              jQuery("#status").html(type + ": " + string);
          },

          onLoad: function () {

              var cams = webcam.getCameraList();
              for (var i in cams) {
                  jQuery("#cams").append("<li>" + cams[i] + "</li>");
              }
          }
      });

      function getPageSize() {

          var xScroll, yScroll;

          if (window.innerHeight && window.scrollMaxY) {
              xScroll = window.innerWidth + window.scrollMaxX;
              yScroll = window.innerHeight + window.scrollMaxY;
          } else if (document.body.scrollHeight > document.body.offsetHeight) { // all but Explorer Mac
              xScroll = document.body.scrollWidth;
              yScroll = document.body.scrollHeight;
          } else { // Explorer Mac...would also work in Explorer 6 Strict, Mozilla and Safari
              xScroll = document.body.offsetWidth;
              yScroll = document.body.offsetHeight;
          }

          var windowWidth, windowHeight;

          if (self.innerHeight) { // all except Explorer
              if (document.documentElement.clientWidth) {
                  windowWidth = document.documentElement.clientWidth;
              } else {
                  windowWidth = self.innerWidth;
              }
              windowHeight = self.innerHeight;
          } else if (document.documentElement && document.documentElement.clientHeight) { // Explorer 6 Strict Mode
              windowWidth = document.documentElement.clientWidth;
              windowHeight = document.documentElement.clientHeight;
          } else if (document.body) { // other Explorers
              windowWidth = document.body.clientWidth;
              windowHeight = document.body.clientHeight;
          }

          // for small pages with total height less then height of the viewport
          if (yScroll < windowHeight) {
              pageHeight = windowHeight;
          } else {
              pageHeight = yScroll;
          }

          // for small pages with total width less then width of the viewport
          if (xScroll < windowWidth) {
              pageWidth = xScroll;
          } else {
              pageWidth = windowWidth;
          }

          return [pageWidth, pageHeight];
      }

      window.addEventListener("load", function () {

          jQuery("body").append("<div id=\"flash\"></div>");

          var canvas = document.getElementById("canvas");

          if (canvas.getContext) {
              ctx = document.getElementById("canvas").getContext("2d");
              ctx.clearRect(0, 0, 320, 240);

              var img = new Image();
              img.src = "/image/logo.gif";
              img.onload = function () {
                  ctx.drawImage(img, 129, 89);
              }
              image = ctx.getImageData(0, 0, 320, 240);
          }

          var pageSize = getPageSize();
          //jQuery("#flash").css({ height: pageSize[1] + "px" });

      }, false);

      window.addEventListener("resize", function () {

          var pageSize = getPageSize();
         // jQuery("#flash").css({ height: pageSize[1] + "px" });

      }, false);
      */
    </script>
</asp:Content>
