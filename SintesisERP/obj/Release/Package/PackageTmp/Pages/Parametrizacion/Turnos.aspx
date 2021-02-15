<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Turnos.aspx.cs"
    Inherits="STTurnos" MasterPageFile="~/Masters/SintesisMaster.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPage" runat="server">

    <script type="text/javascript">
        window.appPath = "<%=Request.ApplicationPath%>";
    </script>

    <div class="row" style="margin: 0px 10px;">
        <div class="x_panel">
            <div class="x_title">
                <h1 class="title-master" style="margin-top: 0;"><span class="fa fa-bullhorn fa-fw"></span>Maestro Turnos</h1>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>

    <div class="card" id="diventrada">
        <div class="row" style="margin: 0px 10px;">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding-top: 5px; padding-bottom: 15px; padding-left: 2px;">
                <div class="table-responsive ">
                    <table class="table table-striped jambo_table" id="tblturnos">
                        <thead>
                            <tr>
                                <th data-column-id="edit" data-formatter="edit" data-sortable="false" style="max-width: 30px !important;">Editar</th>
                                <th data-column-id="horainicio">Hora Inicio</th>
                                <th data-column-id="horafin">Hora Fin</th>
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

    <div class="modal fade" id="ModalShifts">
        <div class="modal-dialog modal-sm" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h2 class="modal-title">Detalle Turno</h2>
                </div>
                <div class="modal-body clearfix" style="margin-bottom: 0;">
                    <div class=" row">
                        <div class="form-group">
                            <label for="v_starttime" class="active">Hora Inicio</label>
                            <input type="text" class="form-control" pick24hourformat="true" id="v_starttime" date="true" format="HH:mm" />
                        </div>
                    </div>
                    <div class=" row">
                        <div class="form-group">
                            <label for="v_endtime" class="active">Hora Final</label>
                            <input type="text" class="form-control" id="v_endtime" pick24hourformat="true" date="true" format="HH:mm" />
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
    <script type="text/javascript">
        $(function () {
            datepicker();
        });
    </script>
    <script src="../Pages/ScriptsPage/Parametrizacion/Turnos.js"></script>
</asp:Content>
