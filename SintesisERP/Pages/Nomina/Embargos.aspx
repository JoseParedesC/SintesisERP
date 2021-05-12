<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Embargos.aspx.cs"
    Inherits="Embargos" MasterPageFile="~/Masters/SintesisMaster.Master" %>


<asp:Content ID="Content3" ContentPlaceHolderID="ContentPage" runat="server">

    <script type="text/javascript">
        window.appPath = "<%=Request.ApplicationPath%>";
    </script>

    <%-- El contenido de la ventana  --%>
    <div class="wrapper wrapper-content" style="padding-top: 5px; background: #fff !important;">
        <div class="row" style="margin-left: 0;">
            <div class="x_panel">
                <div class="x_title">
                    <h1 class="title-master" style="margin-top: 0;"><span class="fa fa-bullhorn fa-fw"></span>Maestro de Embargos</h1>
                    <div class="clearfix"></div>
                </div>
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding-top: 5px; padding-bottom: 15px; padding-left: 2px;">
                    <div class="table-responsive">
                        <%-- Se crea una tabla para mostrar la informacion de la BD --%>
                        <table class="table table-striped jambo_table" id="tblembargos">
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
    </div>

    <%-- Boton para abrir un formulario donde se solicita 
        la informacion para mostrar en la tabla --%>
    <span class="fa-stack fa-lg pull-right goTop iconnew">
        <i class="fa fa-circle fa-stack-2x"></i>
        <i class="fa fa-plus fa-stack-1x fa-inverse"></i>
    </span>

    <%-- formulario en el cual se pide la informacion Necesaria--%>
    <div class="modal fade " id="ModalEmbargo">
        <div class="modal-dialog modal-sm" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h2 class="modal-title">Configuración de Embargos</h2>
                </div>
                <div class="modal-body clearfix" style="margin-bottom: 0;">
                    <div class=" row">
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12  sn-padding">
                            <div class="form-group">
                                <label for="nombreEmbar" class="active">Nombre</label>
                                <input type="text" class="form-control" id="nombreEmbar" />
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


    <script src="../Pages/ScriptsPage/Nomina/Embargos.js"></script>


</asp:Content>

