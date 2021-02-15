<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Cajas.aspx.cs"
    Inherits="Cajas" MasterPageFile="~/Masters/SintesisMaster.Master" %>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPage" runat="server">
    <script type="text/javascript">
        window.appPath = "<%=Request.ApplicationPath%>";
    </script>
    <div class="wrapper wrapper-content" style="padding-top: 5px; background: #fff !important;">
        <div class="row" style="margin-left: 0;">
            <div class="x_panel">
                <div class="x_title">
                    <h1 class="title-master" style="margin-top: 0;"><span class="fa fa-bullhorn fa-fw"></span>Maestro Cajas</h1>
                    <div class="clearfix"></div>
                </div>
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding-top: 5px; padding-bottom: 15px; padding-left: 2px;">
                    <div class="table-responsive">
                        <table class="table table-striped jambo_table" id="tblcaja">
                            <thead>
                                <tr>
                                    <th data-column-id="edit" data-formatter="edit" data-sortable="false" style="max-width: 30px !important;">Editar</th>
                                    <th data-column-id="nombre">Nombre</th>
                                    <th data-column-id="bodega">Bodega</th>
                                    <th data-column-id="estado" data-formatter="state" data-sortable="false" style="max-width: 30px">Estado</th>
                                    <th data-column-id="delete" data-formatter="delete" data-sortable="false" style="max-width: 30px">Eliminar</th>
                                </tr>
                            </thead>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <span class="fa-stack fa-lg pull-right goTop iconnew">
        <i class="fa fa-circle fa-stack-2x"></i>
        <i class="fa fa-plus fa-stack-1x fa-inverse"></i>
    </span>
    <div class="modal fade" id="ModalBoxes">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content" style="overflow-y: auto">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h2 class="modal-title">Detalle Caja</h2>
                </div>
                <div class="modal-body clearfix" style="margin-bottom: 0; padding-top: 0 !important">
                    <input type="hidden" id="tipo" value="TERCE" />
                    <div class=" row">
                        <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="Text_codigo" class="active">Código</label>
                                <input type="text" placeholder=" " class="form-control" id="Text_codigo" />
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="Text_Nombre" class="active">Nombre</label>
                                <input type="text" placeholder=" " class="form-control" id="Text_Nombre" />
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="Text_Bodega" class="active">Bodega</label>
                                <select runat="server" clientidmode="static" id="Text_Bodega" data-size="8" class="form-control selectpicker" title="Bodega" data-live-search="true">
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="Text_Nombre" class="active">Cliente por defecto</label>
                                <div class="input-group ">
                                    <input type="hidden" id="cd_cliente" value="0" />
                                    <input type="hidden" id="tipotercero1" value="CL" />
                                    <input type="text" class="form-control inputsearch" placeholder=" " readonly="readonly" id="ds_cliente" aria-describedby="sizing-addon1" />
                                    <span class="input-group-addon ">
                                        <button type="button" class="btn btn-primary btnsearch" data-search="CNTTerceros" data-method="CNTTercerosListTipo" data-title="Proveedores" data-select="1,3" data-column="id,iden,tercero" data-fields="cd_cliente,ds_cliente" data-params="tipoter,tipotercero1">
                                            <i class="fa fa-fw fa-search"></i>
                                        </button>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="Text_Nombre" class="active">Vendedor por defecto</label>
                                <div class="input-group ">
                                    <input type="hidden" id="id_vendedor" />
                                    <input type="text" class="form-control inputsearch" placeholder=" " readonly="readonly" id="ds_vendedor" aria-describedby="sizing-addon1" />
                                    <span class="input-group-addon ">
                                        <button id="id_VendedorBox" type="button" class="btn btn-primary btnsearch" data-search="Usuarios" data-method="VendedoresList" data-title="Vendedores" data-select="1,2" data-column="id,vendedor" data-fields="id_vendedor,ds_vendedor">
                                            <i class="fa fa-fw fa-search"></i>
                                        </button>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="Text_Nombre" class="active">Centro Costo</label>
                                <div class="input-group ">
                                    <input type="hidden" id="id_ccostos" value="0" />
                                    <input type="hidden" id="isofDetalle" value='true' />
                                    <input type="text" class="form-control inputsearch" placeholder=" " readonly="readonly" id="codigoccostos" aria-describedby="sizing-addon1" />
                                    <span class="input-group-addon ">
                                        <button id="Button2" type="button" class="btn btn-primary btnsearch" data-search="CNTCentrosCostos" data-method="CNTCentroCostosListEsDetalle" data-title="Centro de Costos" data-select="1,2" data-column="id,nombre" data-fields="id_ccostos,codigoccostos">
                                            <i class="fa fa-fw fa-search"></i>
                                        </button>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="Text_Nombre" class="active">Cuenta</label>
                                <div class="input-group ">
                                    <input type="hidden" id="id_cuenta" />
                                    <input type="text" class="form-control inputsearch" placeholder=" " readonly="readonly" id="ds_cuenta" aria-describedby="sizing-addon1" />
                                    <span class="input-group-addon ">
                                        <button id="id_AccountBox" type="button" class="btn btn-primary btnsearch" data-search="CNTCuentas" data-method="CNTCuentasDetalle" data-title="Cuentas" data-select="1,2" data-column="id,codigo,nombre" data-fields="id_cuenta,ds_cuenta" data-params="tipo,tipo">
                                            <i class="fa fa-fw fa-search"></i>
                                        </button>
                                    </span>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="Text_Nombre" class="active">Cuenta Anticipo</label>
                                <div class="input-group ">
                                    <input type="hidden" id="id_cuentaant" />
                                    <input type="text" class="form-control inputsearch" placeholder=" " readonly="readonly" id="ds_cuentaant" aria-describedby="sizing-addon1" />
                                    <span class="input-group-addon ">
                                        <button type="button" class="btn btn-primary btnsearch" data-search="CNTCuentas" data-method="CNTCuentasDetalle" data-title="Cuentas" data-select="1,2" data-column="id,codigo,nombre" data-fields="id_cuentaant,ds_cuentaant" data-params="tipo,tipo">
                                            <i class="fa fa-fw fa-search"></i>
                                        </button>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-lg-6 col-sm-6 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="Text_Categoria" class="active">Cabecera de Reporte</label>
                                <textarea rows="2" class="form-control" id="v_headpage" style="max-width: 100%; min-width: 100%; min-height: 60px;"></textarea>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="Text_IncuyeI" class="active">Pie de pagina</label>
                                <textarea rows="2" class="form-control" id="v_foodpage" style="max-width: 100%; min-width: 100%; min-height: 60px;"></textarea>
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
    <script src="../Pages/ScriptsPage/Inventario/Cajas.js?1"></script>
</asp:Content>
