<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CNTImpuestos.aspx.cs" Inherits="CNTImpuestos" MasterPageFile="~/Masters/SintesisMaster.Master" %>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPage" runat="server">
    <script type="text/javascript">
        window.appPath = "<%=Request.ApplicationPath%>";
    </script>

    <div class="row" style="margin: 0px 10px;">
        <div class="x_panel">
            <div class="x_title">
                <h1 class="title-master" style="margin-top: 0;"><span class="fa fa-bullhorn fa-fw"></span>Maestro de Impuestos</h1>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>

    <div class="card" id="diventrada">
        <div class="row" style="margin: 0px 10px;">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding-top: 5px; padding-bottom: 15px; padding-left: 2px;">
                <div class="table-responsive ">
                    <table class="table table-striped jambo_table" id="tbltipoimpuesto">
                        <thead>
                            <tr>
                                <th data-column-id="edit" data-formatter="edit" data-sortable="false" style="max-width: 30px !important;">Editar</th>
                                <th data-column-id="codigo">Código</th>
                                <th data-column-id="nombre">Nombre</th>
                                <th data-column-id="nomtipoimpuesto">Tipo de Impuesto</th>
                                <th data-column-id="valor">%</th>
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
    <!--Modal Del formulario de registro de Tipo de impuestos-->
    <div class="modal fade" id="ModaltipoImp">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h2 class="modal-title">Detalle Impuesto</h2>
                </div>
                <div class="modal-body clearfix" style="margin-bottom: 0; padding-top: 0 !important">
                    <input type="hidden" id="tipo" value="TERCE" />
                    <div class="row">
                        <div class="col-sm-6 col-lg-6 sn-padding">
                            <div class="form-group">
                                <label for="codigo" class="active">Código</label>
                                <input type="text" placeholder=" " class="form-control" id="codigo" maxlength="8" />
                            </div>
                        </div>
                        <div class="col-sm-6 col-lg-6  sn-padding">
                            <div class="form-group">
                                <label for="Text_Nombre" class="active">Nombre</label>
                                <input type="text" placeholder=" " class="form-control" id="Text_Nombre" maxlength="50" />
                            </div>

                        </div>
                        <div class="col-sm-6 col-lg-6 sn-padding">
                            <div class="form-group">
                                <label for="cd_tipoimp" class="active">Tipo de Impuesto:</label>
                                <select runat="server" clientidmode="static" id="cd_tipoimp" class="form-control selectpicker" data-size="8">
                                </select>
                            </div>
                        </div>
                        <div class="col-sm-6 col-lg-6 sn-padding">
                            <div class="form-group">
                                <label for="m_valor" class="active">Porcentaje:</label>
                                <input id="m_valor" type="text" class="form-control addart" value="0" placeholder=" " money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-max="99" data-v-min="0" data-a-sign="% " />
                            </div>
                        </div>
                        <div class="col-sm-6 col-lg-6 sn-padding">
                            <div class="form-group">
                                <label for="id_ctaVenta" class="active">Cuenta de Venta</label>
                                <div class="input-group ">
                                    <input type="hidden" id="id_ctaVenta" />
                                    <input type="text" class="form-control inputsearch" placeholder=" " readonly="readonly" id="ds_ctaVenta" aria-describedby="sizing-addon1" />
                                    <span class="input-group-addon ">
                                        <button id="btn_AccountBox" type="button" class="btn btn-primary btnsearch" data-search="CNTCuentas" data-method="CNTCuentasDetalle" data-select="1,2" data-title="Cuentas" data-column="id,codigo,nombre" data-fields="id_ctaVenta,ds_ctaVenta" data-params="tipo,tipo">
                                            <i class="fa fa-fw fa-search"></i>
                                        </button>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 col-lg-6 sn-padding">
                            <div class="form-group">
                                <label for="id_ctadevVenta" class="active">Cuenta de Devolucion en Venta</label>
                                <div class="input-group ">
                                    <input type="hidden" id="id_ctadevVenta" />
                                    <input type="text" class="form-control inputsearch" placeholder=" " readonly="readonly" id="ds_ctadevVenta" aria-describedby="sizing-addon1" />
                                    <span class="input-group-addon ">
                                        <button id="btn_ctadevVenta" type="button" class="btn btn-primary btnsearch" data-search="CNTCuentas" data-method="CNTCuentasDetalle" data-select="1,2" data-title="Cuentas" data-column="id,codigo,nombre" data-fields="id_ctadevVenta,ds_ctadevVenta" data-params="tipo,tipo">
                                            <i class="fa fa-fw fa-search"></i>
                                        </button>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 col-lg-6 sn-padding">
                            <div class="form-group">
                                <label for="id_ctaCompra" class="active">Cuenta de Compra</label>
                                <div class="input-group ">
                                    <input type="hidden" id="id_ctaCompra" />
                                    <input type="text" class="form-control inputsearch" placeholder=" " readonly="readonly" id="ds_ctaCompra" aria-describedby="sizing-addon1" />
                                    <span class="input-group-addon ">
                                        <button id="btn_ctacompra" type="button" class="btn btn-primary btnsearch" data-search="CNTCuentas" data-method="CNTCuentasDetalle" data-select="1,2" data-title="Cuentas" data-column="id,codigo,nombre" data-fields="id_ctaCompra,ds_ctaCompra" data-params="tipo,tipo">
                                            <i class="fa fa-fw fa-search"></i>
                                        </button>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 col-lg-6 sn-padding">
                            <div class="form-group">
                                <label for="id_ctadevCompra" class="active">Cuenta de Devolucion en Compra</label>
                                <div class="input-group ">
                                    <input type="hidden" id="id_ctadevCompra" />
                                    <input type="text" class="form-control inputsearch" placeholder=" " readonly="readonly" id="ds_ctadevCompra" aria-describedby="sizing-addon1" />
                                    <span class="input-group-addon ">
                                        <button id="btn_ctadevCompra" type="button" class="btn btn-primary btnsearch" data-search="CNTCuentas" data-method="CNTCuentasDetalle" data-select="1,2" data-title="Cuentas" data-column="id,codigo,nombre" data-fields="id_ctadevCompra,ds_ctadevCompra" data-params="tipo,tipo">
                                            <i class="fa fa-fw fa-search"></i>
                                        </button>
                                    </span>
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
    </div>
    <%--</main>--%>
    <script src="../Pages/ScriptsPage/Contabilidad/CNTImpuestos.js?1"></script>
    <script>
        $(function () {
            $('select').selectpicker();
            $('.i-checks').iCheck({
                checkboxClass: 'icheckbox_square-green',
                radioClass: 'iradio_square-green',
            });

            $("[money]").each(function (i, control) {
                $(control).autoNumeric('init');
            });
        });
    </script>
</asp:Content>

