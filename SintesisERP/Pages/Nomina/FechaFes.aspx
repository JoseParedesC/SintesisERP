<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FechaFes.aspx.cs"
    Inherits="FechaFes" MasterPageFile="~/Masters/SintesisMaster.Master" %>


<asp:Content ID="Content3" ContentPlaceHolderID="ContentPage" runat="server">

    <script type="text/javascript">
        window.appPath = "<%=Request.ApplicationPath%>";
    </script>

    <%-- El contenido de la ventana  --%>
    <div class="wrapper wrapper-content" style="padding-top: 5px; background: #fff !important;">
        <div class="row" style="margin-left: 0;">
            <div class="x_panel">
                <div class="x_title">
                    <h1 class="title-master" style="margin-top: 0;"><span class="fa fa-bullhorn fa-fw"></span>Maestro de Fechas Festivas</h1>
                    <div class="clearfix"></div>
                </div>
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding-top: 5px; padding-bottom: 15px; padding-left: 2px;">
                    <div class="table-responsive">
                        <%-- Se crea una tabla para mostrar la informacion de la BD --%>
                        <table class="table table-striped jambo_table" id="tblfecha">
                            <thead>
                                <tr>
                                    <th data-column-id="edit" data-formatter="edit" data-sortable="false" style="max-width: 30px !important;">Editar</th>
                                    <th data-column-id="fecha">Fecha</th>
                                    <th data-column-id="tipo">Tipo</th>
                                    <th data-column-id="delete" data-formatter="delete" data-sortable="false" style="max-width: 30px">Eliminar</th>
                                </tr>
                            </thead>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%-- Boton para abrir un formulario donde se solicita 
        la informacion para mostrar en la tabla --%>
    <span class="fa-stack fa-lg pull-right goTop iconnew">
        <i class="fa fa-circle fa-stack-2x"></i>
        <i class="fa fa-plus fa-stack-1x fa-inverse"></i>
    </span>

    <%-- formulario en el cual se pide la informacion Necesaria--%>
    <div class="modal fade " id="ModalFecha">
        <div class="modal-dialog modal-sm" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h2 class="modal-title">Fechas Festivas</h2>
                </div>
                <div class="modal-body clearfix" style="margin-bottom: 0;">
                    <div class=" row">
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12  sn-padding">
                            <div class="form-group">
                                <label for="Text_fecha" class="active">Fecha</label>
                                <input type="text" class="form-control" id="dt_fecha" current="true" date="true" format="YYYY-MM-DD" />
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row buttonaction pull-right">
                                <button title="Guardar" id="btnSave" data-option="I" class="btn btn-outline btn-primary dim waves-effect waves-light" type="button"><i class="fa fa-paste"></i></button>
                                <button title="Cancelar" id="btnCance" class="btn btn-outline btn-danger  dim waves-effect waves-light" data-dismiss="modal" aria-label="Close" type="button"><i class="fa-file-o fa"></i></button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <script src="../Package/Vendor/js/plugins/Autocomplete/jquery.autocomplete.js"></script>
    <script src="../Pages/ScriptsPage/Nomina/FechaFes.js"></script>


</asp:Content>

