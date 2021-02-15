<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CNTTipodocumentos.aspx.cs"
    Inherits="CNTTipodocumentos" MasterPageFile="~/Masters/SintesisMaster.Master" %>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPage" runat="server">
    <script type="text/javascript">
        window.appPath = "<%=Request.ApplicationPath%>";
    </script>

    <div class="row" style="margin: 0px 10px;">
        <div class="x_panel">
            <div class="x_title">
                <h1 class="title-master" style="margin-top: 0;"><span class="fa fa-bullhorn fa-fw"></span>Maestro Tipo de Documentos</h1>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>

    <div class="card" id="diventrada">
        <div class="row" style="margin: 0px 10px;">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding-top: 5px; padding-bottom: 15px; padding-left: 2px;">
                <div class="table-responsive ">
                    <table class="table table-striped jambo_table" id="tbltipoDoc">
                        <thead>
                            <tr>
                                <th data-column-id="edit" data-formatter="edit" data-sortable="false" style="max-width: 30px !important;">Editar</th>
                                <th data-column-id="codigo">Código</th>
                                <th data-column-id="nombre">Nombre</th>
                                <th data-column-id="centrocosto">Centro de Costo</th>
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
    <!--Modal Del formulario de registro de Tipo de documentos-->
    <div class="modal fade" id="ModaltipoDocu">
        <div class="modal-dialog modal-sm" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h2 class="modal-title">Detalle Tipo de Documentos</h2>
                </div>
                <div class="modal-body clearfix" style="margin-bottom: 0; padding-top: 0 !important">
                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="codigo" class="active">Código</label>
                                <input type="text" placeholder=" " class="form-control" id="codigo" maxlength="2" />
                            </div>
                        </div>
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="Text_Nombre" class="active">Nombre</label>
                                <input type="text" placeholder=" " class="form-control" id="Text_Nombre" maxlength="50" />
                            </div>
                        </div>
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="cd_tipo" class="active">Tipo:</label>
                                <select runat="server" clientidmode="static" id="cd_tipo" class="form-control selectpicker" data-size="8">
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12 sn-padding">
                            <div class="form-group">
                                <label for="ISCcosto" class="active">Centro de Costo?</label>
                                <div class="check-mail">
                                    <input type="checkbox" class="i-checks pull-right" id="ISCcosto" />
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 sn-padding">
                            <!--Campo de busqueda de centro de costo por defecto-->
                            <div class="form-group">
                                <label for="Button2" class="active">Centro Costo por Defecto</label>
                                <div class="input-group ">
                                    <input type="hidden" id="id_ccostos" />
                                    <input type="hidden" id="Idcurrent" value="0" />
                                    <input type="hidden" id="isofDetalle" value='true' />
                                    <input type="text" class="form-control inputsearch" placeholder=" " readonly="readonly" id="codigoccostos" aria-describedby="sizing-addon1" />
                                    <span class="input-group-addon ">
                                        <button id="Button2" type="button" class="btn btn-primary btnsearch" data-search="CNTCentrosCostos" data-method="CNTCentroCostosListEsDetalle" data-title="Centro de Costos" data-select="1,2" data-column="id,nombre" data-fields="id_ccostos,codigoccostos" data-params="detalle,isofDetalle;ide,Idcurrent">
                                            <i class="fa fa-fw fa-search"></i>
                                        </button>
                                    </span>
                                </div>
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
    <script src="../Pages/ScriptsPage/Contabilidad/CNTTipodocumentos.js?1"></script>
    <script>
        $(function () {
            $('select').selectpicker();
            $('.i-checks').iCheck({
                checkboxClass: 'icheckbox_square-green',
                radioClass: 'iradio_square-green',
            });
        })
    </script>
</asp:Content>

