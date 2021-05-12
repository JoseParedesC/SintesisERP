<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Horario.aspx.cs" Inherits="Horario" MasterPageFile="~/Masters/SintesisMaster.Master" %>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPage" runat="server">
    <script type="text/javascript">
        window.appPath = "<%=Request.ApplicationPath%>";
    </script>

    <style>
        textarea {
            resize: none;
        }

        .fake-textarea {
            padding: .5rem;
            min-height: 3rem;
        }

            .fake-textarea:focus {
                border-color: #66afe9;
                outline: 0;
                -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6);
                box-shadow: inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6);
            }

            .fake-textarea::-moz-placeholder {
                color: #999;
                opacity: 1;
            }

            .fake-textarea:-ms-input-placeholder {
                color: #999;
            }

            .fake-textarea::-webkit-input-placeholder {
                color: #999;
            }

            .fake-textarea:empty::before {
                position: absolute !important;
                content: "Escribe aquí...";
            }

            .fake-textarea::after, .fake-textarea::before {
                box-sizing: border-box;
            }

        .ch {
            height: 20px;
            width: 20px;
            border-radius: 20px !important;
        }

         .cantdias, .cadadia, .reg, #rowhora {
            display: none;
        }

        .main {
            font: 13px verdana;
            font-weight: normal;
        }
    </style>

    <div class="row" style="margin: 0px 10px;">
        <div class="x_panel">
            <div class="x_title">
                <h1 class="title-master" style="margin-top: 0;"><span class="fa fa-bullhorn fa-fw"></span>Maestro de Horarios</h1>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>

    <div class="card" id="diventrada">
        <div class="row" style="margin: 0px 10px;">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <div class="table-responsive ">
                    <table class="table table-striped jambo_table" id="tblcargo">
                        <thead>
                            <tr>
                                <th data-column-id="edit" data-formatter="edit" data-sortable="false" style="max-width: 30px !important;">Editar</th>
                                <th data-column-id="nombre">Nombre</th>
                                <th data-column-id="delete" data-formatter="delete" data-sortable="false" style="max-width: 30px">Eliminar</th>
                            </tr>
                        </thead>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <span class="fa-stack fa-lg pull-right goTop iconnew">
        <i class="fa fa-circle fa-stack-2x"></i>
        <i class="fa fa-plus fa-stack-1x fa-inverse"></i>
    </span>


    <div class="modal fade" id="ModalHorario">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h2 class="modal-title">Configuración del Horario</h2>
                </div>
                <div class="modal-body clearfix" style="margin-bottom: 0; padding-top: 0 !important">
                    <div class="row">
                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                            <div class="form-group">
                                <label for="tipohora" class="active">Tipo Horario</label>
                                <select runat="server" clientidmode="static" id="tipohora" data-size="8" class="form-control selectpicker" title="Seleccione" data-live-search="true">
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                            <div class="form-group">
                                <label for="nombre" class="active">Nombre:</label>
                                <input id="nombre" type="text" placeholder=" " class="form-control" value="" runat="server" clientidmode="static" />
                            </div>
                        </div>
                        <div class="colF-lg-3 col-md-3 col-sm-6 col-xs-12 cadadia">
                            <div class="form-group">
                                <label for="cadadia" class="active">Cant. de días:</label>
                                <input id="cadadia" type="text" placeholder=" " class="form-control" value="" runat="server" clientidmode="static" />
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12 cantdias">
                            <div class="form-group">
                                <label for="cantdiastr" class="active">Cant. días trabajo:</label>
                                <input id="cantdiastr" type="text" placeholder=" " class="form-control" value="" runat="server" clientidmode="static" />
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12 cantdias">
                            <div class="form-group">
                                <label for="cantdiasds" class="active">Cant. días Desc.:</label>
                                <input id="cantdiasds" type="text" placeholder=" " class="form-control" value="" runat="server" clientidmode="static" />
                            </div>
                        </div>
                    </div>
                    <h2 class="reg">Días de Semana</h2>
                    <h2 class="cadadia">Días de trabajo</h2>
                    <div id="esp"></div>
                    <div class="row" id="rowhora" style="border-top: 1px dashed #AAB7B8; margin-top: 15px">
                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                            <div class="form-group">
                                <label for="horaini" class="active">Hor. de inicio:</label>
                                <input type="text" class="form-control hora" id="horaini" current="true" date="true" format="HH:mm" />
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12" style="padding-right: 1px !important; right: 8px !important;">
                            <div class="form-group">
                                <label for="horainides" class="active">Hor. de inicio desc.:</label>
                                <input type="text" class="form-control hora" id="horainides" current="true" date="true" format="HH:mm" />
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12" style="padding-right: 7px !important;">
                            <div class="form-group">
                                <label for="horafindes" class="active">Hor de final desc.:</label>
                                <input type="text" class="form-control hora" id="horafindes" current="true" date="true" format="HH:mm" />
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                            <div class="form-group">
                                <label for="horafin" class="active">Hor. de final:</label>
                                <input type="text" class="form-control hora" id="horafin" current="true" date="true" format="HH:mm" />
                            </div>
                        </div>
                    </div>

                    <h2 class="reg">Sábados</h2>
                    <div class="row reg" style="border-top: 1px dashed #AAB7B8; margin-top: 15px">
                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                            <div class="form-group">
                                <label for="horainisab" class="active">Hor. de inicio:</label>
                                <input type="text" class="form-control hora" id="horainisab" current="true" date="true" format="HH:mm" />
                            </div>
                        </div>

                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                            <div class="form-group">
                                <label for="horafinsab" class="active">Hor. de final:</label>
                                <input type="text" class="form-control hora" id="horafinsab" current="true" date="true" format="HH:mm" />
                            </div>
                        </div>
                    </div>
                     <input type="hidden" value="0" id="idhorario" />
                    <div class="row buttonaction pull-right">
                        <button title="Guardar" id="btnSave" data-option="I" class="btn btn-outline btn-primary dim waves-effect waves-light" type="button"><i class="fa fa-paste"></i></button>
                        <button title="Cancelar" id="btnCance" class="btn btn-outline btn-danger  dim waves-effect waves-light" data-dismiss="modal" aria-label="Close" type="button"><i class="fa-file-o fa"></i></button>
                    </div>
                </div>

            </div>
        </div>
    </div>


    <%--</main>--%>
    <script src="../Pages/ScriptsPage/Nomina/Horario.js?1"></script>

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
