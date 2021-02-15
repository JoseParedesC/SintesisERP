<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Perfiles.aspx.cs"
    Inherits="Perfiles" MasterPageFile="~/Masters/SintesisMaster.Master" %>


<asp:Content ID="Content31" ContentPlaceHolderID="ContentPage" runat="server">
    <script type="text/javascript">
        window.appPath = "<%=Request.ApplicationPath%>";
    </script>
    <style>
        #descripcion{
            height: 60px !important;
        }
    </style>
    
    <div class="row" style="margin: 0px 10px;">
        <div class="x_panel">
            <div class="x_title">
                <h1 class="title-master" style="margin-top: 0;"><span class="fa fa-bullhorn fa-fw"></span>Maestro Perfiles</h1>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>
        <div class="table-responsive" style="max-height: 600px; min-height: 250px; margin-top: 15px; overflow-y: auto">
            <table class="table table-striped jambo_table" id="tblperfiles">
                <thead>
                    <tr>
                        <th data-column-id="edit" data-formatter="edit">Editar</th>
                        <th data-column-id="nombre">Nombre</th>
                        <th data-column-id="app">Aplicación</th>
                        <th data-column-id="estado" data-formatter="state">Estado</th>
                        <th data-column-id="delete" data-formatter="delete">Eliminar</th>
                    </tr>
                </thead>
            </table>
        </div>
        <span class="fa-stack fa-lg pull-right goTop iconnew">
            <i class="fa fa-circle fa-stack-2x"></i>
            <i class="fa fa-plus fa-stack-1x fa-inverse"></i>
        </span>

    <div class="modal fade" id="ModalPerfiles">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h2 class="modal-title">Detalle Perfiles</h2>
                </div>
                <div class="modal-body clearfix" style="margin-bottom: 0;">
                    <div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-6">
                            <div class="form-group">
                                <label for="Text_Nombre" class="active">Nombre</label>
                                <input class="form-control"  id="nombre"/>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6">
                            <div class="form-group">
                                <label>Aplicación</label>
                                <select id="app" runat="server" clientidmode="static" data-size="8" class="form-control selectpicker">
                                    <option></option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12">
                            <div class="form-group">
                                <label>Descripción</label>
                                <textarea class="form-control" style="resize: none;" id="descripcion"></textarea>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-6">
                            <div class="form-group">
                                <label>Menus</label>
                                <select id="menus" runat="server" clientidmode="static" data-size="8" class="form-control selectpicker" multiple="true"></select>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6">
                            <div class="form-group">
                                <label>Reportes</label>
                                <select id="reportes" runat="server" clientidmode="static" data-size="8" class="form-control selectpicker" multiple="true"></select>
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
    <script src="../Pages/ScriptsPage/Parametrizacion/Perfiles.js"></script>
</asp:Content>
