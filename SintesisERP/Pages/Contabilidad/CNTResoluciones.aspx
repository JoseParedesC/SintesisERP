<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CNTResoluciones.aspx.cs"
    Inherits="CNTResoluciones" MasterPageFile="~/Masters/SintesisMaster.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPage" runat="server">
    <script type="text/javascript">
        window.appPath = "<%=Request.ApplicationPath%>";
    </script>
    <style>
        .form-group {
            margin-bottom: 0;
        }
    </style>
    <div class="row" style="margin-left: 0;">
        <div class="x_panel">
            <div class="x_title">
                <h1 class="title-master" style="margin-top: 0;"><span class="fa fa-bullhorn fa-fw"></span>Maestro Resolución</h1>
                <div class="clearfix"></div>
            </div>
            <div class="col-lg-12 sn-padding">
                <div role="alert" aria-live="polite" aria-atomic="true" class="alert alert-dismissible alert-alert alert-card alert-info" style="margin-bottom: 0px">
                    <strong class="text-capitalize">Información!</strong>
                    <br />
                    1. Solo puede tener 2 resoluciónes activas por centro de costo, una debe ser de Facturación Electronica y la otra Resolución Clasica.               
                </div>
            </div>
        </div>
    </div>

    <div class="card" id="diventrada">
        <div class="row" style="margin: 0px 10px;">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding-top: 5px; padding-bottom: 15px; padding-left: 2px;">
                <div class="table-responsive ">
                    <table class="table table-striped jambo_table" id="tblresol">
                        <thead>
                            <tr>
                                <th data-column-id="edit" data-formatter="edit" data-sortable="false" style="max-width: 30px !important;">Editar</th>
                                <th data-column-id="centrocosto">Centro Costo</th>
                                <th data-column-id="resolucion">Código</th>
                                <th data-column-id="fechainicio">Fecha Inicio</th>
                                <th data-column-id="fechafin">Fecha Fin</th>
                                <th data-column-id="prefijo" data-sortable="false">Prefijo</th>
                                <th data-column-id="rangoini" data-sortable="false">Rango. Inicial</th>
                                <th data-column-id="rangofin" data-sortable="false">Rango. Final</th>
                                <th data-column-id="consecutivo" data-sortable="false">Consec. Facturado</th>
                                <th data-column-id="isfe" data-formatter="isfe" data-sortable="false">Electronica</th>
                                <th data-column-id="estado" data-formatter="state" data-sortable="false" style="max-width: 30px">Estado</th>
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

    <div class="modal fade" id="ModalResolution">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h2 class="modal-title">Detalle resolución</h2>
                </div>
                <div class="modal-body clearfix" style="margin-bottom: 0; padding-top: 5px;">
                    <div class=" row">
                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="ids_boxes" class="active">Centro de Costo</label>
                                <select runat="server" clientidmode="static" id="id_ccosto" data-size="8" class="form-control selectpicker" title="Seleccione" data-live-search="true">
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="v_codigo" class="active">Codigo</label>
                                <input name="v_codigo" type="text" placeholder=" " class="form-control" id="v_codigo" money="true" data-a-dec="." data-a-sep="" data-m-dec="" value="" />
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="sd_datestar" class="active">Fecha Inicio</label>
                                <input name="sd_datestar" type="text" placeholder=" " class="form-control" date="true" format="YYYY-MM-DD" current="true" id="sd_datestar" />
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="sd_dateend" class="active">Fecha Fin</label>
                                <input name="sd_dateend" type="text" placeholder=" " class="form-control" date="true" format="YYYY-MM-DD" current="true" id="sd_dateend" />
                            </div>
                        </div>
                       <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12" style="margin-bottom: 8px;">
                            <div class="form-group">
                                <label for="electronica" class="active">FE?? </label>
                                <div class="check-mail">
                                    <input type="checkbox" class="i-checks pull-right" id="electronica" />
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-6 sn-padding">
                            <div class="form-group">
                                <label for="prefijo" class="active">Prefijo:</label>
                                <input id="prefijo" type="text" placeholder=" " class="form-control" />
                            </div>
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-6 sn-padding">
                            <div class="form-group">
                                <label for="ini" class="active">Rango. Inicial:</label>
                                <input id="ini" type="text" placeholder=" " class="form-control" money="true" data-m-dec="0" data-v-min="0" value="0" />
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-6 sn-padding">
                            <div class="form-group">
                                <label for="fin" class="active">Rango. Final:</label>
                                <input id="fin" type="text" placeholder=" " class="form-control" money="true" data-m-dec="0" data-v-min="0" value="0" />
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-6 sn-padding">
                            <div class="form-group">
                                <label for="factura" class="active">Consec. Factura:</label>
                                <input id="factura" type="text" placeholder=" " class="form-control" money="true" data-m-dec="0" data-v-min="0" value="0" />
                            </div>
                        </div>
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="v_legend" class="active">Leyenda</label>
                                <textarea class="form-control" rows="2" id="v_legend" placeholder=" " style="max-width: 100%; min-width: 100%; min-height: 50px"></textarea>
                            </div>
                        </div>
                    </div>
                    <div class="row buttonaction pull-right">
                        <button title="Guardar" id="btnSave" data-option="I" class="btn btn-outline btn-primary dim waves-effect waves-light" type="button"><i class="fa fa-paste"></i></button>
                        <button title="Cancelar" id="btnCance" class="btn btn-outline btn-danger  dim waves-effect waves-light" data-dismiss="modal" aria-label="Close" type="button"><i class="fa-file-o fa"></i></button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%--</main>--%>
    <script src="../Pages/ScriptsPage/Contabilidad/CNTResoluciones.js?1"></script>
    <script type="text/javascript">
        $(function () {
            datepicker();
            $("[money]").each(function (i, control) {
                $(control).autoNumeric('init');
            });

            $('.i-checks').iCheck({
                checkboxClass: 'icheckbox_square-green',
                radioClass: 'iradio_square-green',
            });
        });
    </script>
</asp:Content>
