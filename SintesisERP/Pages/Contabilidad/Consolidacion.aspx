<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Consolidacion.aspx.cs"
    Inherits="Consolidacion" MasterPageFile="~/Masters/SintesisMaster.Master" %>

<asp:Content ID="Content40" ContentPlaceHolderID="ContentPage" runat="server">
    <script type="text/javascript">
        window.appPath = "<%=Request.ApplicationPath%>";
    </script>
    <style>
        .entradanumber {
            width: 100% !important;
            text-align: center;
            position: relative;
            float: right;
            margin-top: -8px;
        }

        .quoteNumber {
            border-radius: .1em;
            background: #fff;
            font-size: 20px;
            font-weight: bold;
            text-align: center;
            margin-top: -2px;
            margin-right: 5px;
            margin-bottom: 12px;
            border: solid 1px;
        }
    </style>
    <div class="row" style="margin: 0px 10px;">
        <div class="col-lg-4 col-sm-4 col-md-4">
            <div class="x_panel">
                <div class="x_title">
                    <h1 class="title-master" style="margin-top: 0;"><span class="fa fa-bullhorn fa-fw"></span>Conciliacion</h1>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
        <div class="col-lg-8 col-md-8 col-sm-8">
            <button title="Guardar" id="btnSave" class="btn btn-outline btn-primary dim pull-right" type="button"><i class="fa fa-paste"></i></button>
            <button title="Revertir" id="btnRev" class="btn btn-outline btn-danger  dim  pull-right" type="button" disabled="disabled"><i class="fa-file-o fa"></i></button>
            <button title="Nueva" id="btnnew" data-option="R" class="btn btn-outline btn-default  dim  pull-right" disabled="disabled" type="button"><i class="fa-file-o fa"></i></button>
            <button title="Listar" id="btnList" data-option="L" class="btn btn-outline btn-info  dim  pull-right" type="button"><i class="fa-list fa"></i></button>
            <button title="Actualizar" id="btnRefreshTer" class="btn btn-outline pull-right btn-primary dim waves-effect waves-light" type="button"><i class="fa fa-refresh"></i></button>
            <span class="pull-right quoteNumber"><span style="font-size: 14px; font-weight: normal;">Consecutivo</span><span class="entradanumber" id="consecutivo">0</span></span>
        </div>
    </div>

    <div class="card" id="diventrada">
        <div class="row">
            <div class="col-lg-2 col-sm-2 col-md-2 col-xs-4" style="margin: 5px;">
                <div class="form-group" style="margin-left: 11px;">
                    <label>Filtrar por fecha:</label>
                    <input type="text" id="fecha" class="form-control" date="true" format="YYYY-MM" current="true"/>
                </div>
            </div>
            <div class="col-lg-2 col-sm-2 col-md-2 col-xs-4" style="float: left; margin: 5px;">
                <label>Conciliado?</label>
                <div class="check-mail">
                    <input type="checkbox" id="consolidados" class="i-checks"/>
                </div>
            </div>
            <div class="col-lg-7 col-sm-7 col-md-7" style="margin: 5px; float: right;">
                <span class="pull-right quoteNumber">
                    <span style="font-size: 14px; font-weight: normal;">Conciliadas</span>
                    <span class="entradanumber" id="conciliados">0</span>
                </span>
                <span class="pull-right quoteNumber">
                    <span style="font-size: 14px; font-weight: normal;">Por Conciliar</span>
                    <span class="entradanumber" id="noconciliados">0</span>
                </span>
            </div>
        </div>
        <div class="row" style="margin: 0px 10px;">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding-top: 5px; padding-bottom: 15px; padding-left: 2px;">
                <div class="table-responsive" style="height: 300px !important;">
                    <table class="table table-striped jambo_table table-fixed" id="tblconsoli">
                        <thead>
                            <tr>
                                <th data-column-id="fuente">Centro costo</th>
                                <th data-column-id="documento">TD</th>
                                <th data-column-id="fecha">Fecha</th>
                                <th data-column-id="factura">Factura</th>
                                <th data-column-id="descrip">Descripción</th>
                                <th data-column-id="debito" data-formatter="debito">Débito</th>
                                <th data-column-id="credito" data-formatter="credito">Crédito</th>
                                <th data-column-id="voucher" style="max-width: 30px">Voucher</th>
                                <th data-column-id="estado" data-formatter="estado">Conciliado</th>
                            </tr>
                        </thead>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="ModalConciliados">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h2 class="modal-title">Lista de Conciliados</h2>
                </div>
                <div class="modal-body clearfix" style="margin-bottom: 0; padding-top: 0 !important">
                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding: 5px;">
                            <div class="table-responsive" style="max-height: 300px">
                                <table class="table table-striped jambo_table" id="tblmovconciliado">
                                    <thead>
                                        <tr>
                                            <th data-column-id="id" data-formatter="ver" data-sortable="false" style="max-width: 30px !important;">Ver</th>
                                            <th data-column-id="estado">Estado</th>
                                            <th data-column-id="id">Consecutivo</th>
                                            <th data-column-id="fecha">Fecha</th>
                                            <th data-column-id="debito_t" data-formatter="debito_t">Debito</th>
                                            <th data-column-id="credito_t" data-formatter="credito_t">Credito</th>
                                        </tr>
                                    </thead>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="../Pages/ScriptsPage/Contabilidad/Consolidacion.js?1"></script>
</asp:Content>
