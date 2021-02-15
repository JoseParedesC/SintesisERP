<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Usuariosp.aspx.cs"
    Inherits="Usuariosp" MasterPageFile="~/Masters/SintesisMaster.Master" %>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPage" runat="server">
    <script type="text/javascript">
        window.appPath = "<%=Request.ApplicationPath%>";
    </script>

    <div class="row" style="margin: 0px 10px;">
        <div class="x_panel">
            <div class="x_title">
                <h1 class="title-master" style="margin-top: 0;"><span class="fa fa-bullhorn fa-fw"></span>Maestro Usuarios</h1>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>


    <div class="card" id="diventrada">
        <div class="row" style="margin: 0px 10px;">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding-top: 5px; padding-bottom: 15px; padding-left: 2px;">
                <div class="table-responsive">
                    <table class="table table-striped jambo_table" id="tblusuar">
                        <thead>
                            <tr>
                                <th data-column-id="edit" data-formatter="edit" data-sortable="false" style="max-width: 30px !important;">Editar</th>
                                <th data-column-id="username">Usuario</th>
                                <th data-column-id="nombre">Nombre</th>
                                <th data-column-id="perfil">Perfil</th>
                                <th data-column-id="turno">Turno</th>
                                <th data-column-id="estado" data-formatter="state" data-sortable="false" style="max-width: 30px">Estado</th>
                                <th data-column-id="restore" data-formatter="restore" data-sortable="false" style="max-width: 30px">Restaurar Clave</th>
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

    <div class="modal fade" id="ModalUsers">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h2 class="modal-title">Detalle Usuario</h2>
                </div>
                <div class="modal-body clearfix" style="margin-bottom: 0;">
                    <div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12  sn-padding">
                            <div class="form-group">
                                <label for="username" class="active">Usuario</label>
                                <input type="text" placeholder=" " class="form-control" id="username" />
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12  sn-padding">
                            <div class="form-group">
                                <label for="name" class="active">Nombre y Apellido</label>
                                <input type="text" placeholder=" " class="form-control" id="name" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="identification" class="active">Identificación</label>
                                <input type="text" placeholder=" " class="form-control" id="identification" />
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="id_profile" class="active">Perfil</label>
                                <select runat="server" clientidmode="static" id="id_profile" data-size="8" class="form-control selectpicker" title="Perfiles" data-live-search="true">
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="email" class="active">Email</label>
                                <input type="text" placeholder=" " class="form-control" id="email" />
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="phone" class="active">Teléfono</label>
                                <input type="text" placeholder=" " class="form-control" id="phone" />
                            </div>
                        </div>
                    </div>
                    <div class="row">

                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="ids_boxes" class="active">Cajas</label>
                                <select runat="server" clientidmode="static" id="ids_boxes" multiple="true" data-size="8" class="form-control selectpicker" title="Cajas" data-live-search="true">
                                </select>
                            </div>
                        </div>

                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="id_shift" class="active">Turno</label>
                                <select runat="server" clientidmode="static" id="id_shift" data-size="8" class="form-control selectpicker" title="Turno" data-live-search="true">
                                </select>
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
    <script>
        $(function () {
            $('select').selectpicker();
        })
    </script>
    <script src="../Pages/ScriptsPage/Parametrizacion/Usuarios.js"></script>
</asp:Content>

