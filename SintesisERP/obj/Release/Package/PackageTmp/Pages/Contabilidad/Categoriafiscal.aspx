<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Categoriafiscal.aspx.cs"
    Inherits="Categoriafiscal" MasterPageFile="~/Masters/SintesisMaster.Master" %>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPage" runat="server">
    <script type="text/javascript">
        window.appPath = "<%=Request.ApplicationPath%>";
    </script>
    <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
        <div class="row" style="margin: 0px 10px;">
            <div class="x_panel">
                <div class="x_title">
                    <h1 class="title-master" style="margin-top: 0;"><span class="fa fa-bullhorn fa-fw"></span>Maestro Categorías Fiscales</h1>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>

        <div class="card" id="diventrada">
            <div class="row" style="padding-bottom: 64px">
                <span class="fa-stack fa-lg pull-right goTop iconnew" data-option="C" style="position: absolute; top: 8px">
                    <i class="fa fa-circle fa-stack-2x"></i>
                    <i class="fa fa-plus fa-stack-1x fa-inverse"></i>
                </span>
            </div>
            <div class="row" style="margin: 0px 10px;">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding-top: 5px; padding-bottom: 15px; padding-left: 2px;">
                    <div class="table-responsive">
                        <table class="table table-striped jambo_table" id="tblcatfis">
                            <thead>
                                <tr>
                                    <th data-column-id="edit" data-formatter="edit" data-sortable="false" style="max-width: 30px !important;">Editar</th>
                                    <th data-column-id="codigo">Código</th>
                                    <th data-column-id="descripcion">Descripción</th>
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
    <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
        <div class="row" style="margin: 0px 10px;">
            <div class="x_panel">
                <div class="x_title">
                    <h1 class="title-master" style="margin-top: 0;"><span class="fa fa-bullhorn fa-fw"></span>Maestro Categorías de Servicios</h1>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>

        <div class="card" id="diventrada2">
            <div class="row" style="padding-bottom: 64px">
                <span class="fa-stack fa-lg pull-right goTop iconnew" style="margin-bottom: 60px;position: absolute; top: 8px" data-option="S">
                    <i class="fa fa-circle fa-stack-2x" style="color: cadetblue" ></i>
                    <i class="fa fa-plus fa-stack-1x fa-inverse"></i>
                </span>
            </div>
            <div class="row" style="margin: 0px 10px;">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding-top: 5px; padding-bottom: 15px; padding-left: 2px;">
                    <div class="table-responsive">
                        <table class="table table-striped jambo_table" id="tblcatfiserv">
                            <thead>
                                <tr>
                                    <th data-column-id="edit" data-formatter="edit" data-sortable="false" style="max-width: 30px !important;">Editar</th>
                                    <th data-column-id="servicio">Servicio</th>
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


    <div class="modal fade" id="ModalCategoria">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h2 class="modal-title">Detalle Categoría Fiscal</h2>
                </div>
                <div class="modal-body clearfix" style="margin-bottom: 0;">
                    <div class=" row">
                        <div class="col-lg-3 col-md-3 col-sm-3 col-xs-12  sn-padding">
                            <div class="form-group">
                                <label for="Text_Codigo" class="active">Código</label>
                                <input name="Text_Codigo" type="text" class="form-control" id="Text_Codigo" />
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12  sn-padding">
                            <div class="form-group">
                                <label for="descripcion" class="active">Descripción</label>
                                <input type="text" class="form-control" id="descripcion" />
                            </div>
                        </div>
                        <div class="col-md-3 col-lg-3 col-sm-3 col-xs-12 sn-padding" style="padding-top: 0 !important;">
                            <div class="form-group">
                                <label for="Formulado" class="active">Retiene?</label>
                                <div class="check-mail">
                                    <input type="checkbox" class="i-checks pull-right" id="retiene" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class=" row">
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="cd_iva" class="active">Retefuentes:</label>
                                <select runat="server" clientidmode="static" id="cd_retefuente" class="form-control selectpicker" data-size="8">
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="Text_Precio" class="active">Base</label>
                                <input type="text" class="form-control" id="retfuentebase" money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="0" data-v-max="999999999999.99" value="0.00" />
                            </div>
                        </div>

                    </div>
                    <div class=" row">
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="cd_reteiva" class="active">Rete IVA:</label>
                                <select runat="server" clientidmode="static" id="cd_reteiva" class="form-control selectpicker" data-size="8">
                                </select>
                            </div>
                        </div>

                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="retivabase" class="active">Base</label>
                                <input type="text" class="form-control" id="retivabase" money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="0" data-v-max="999999999999.99" value="0.00" />
                            </div>
                        </div>

                    </div>
                    <div class=" row">
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="cd_reteica" class="active">ReteICA:</label>
                                <select runat="server" clientidmode="static" id="cd_reteica" class="form-control selectpicker" data-size="8">
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="Text_Precio" class="active">Base</label>
                                <input type="text" class="form-control" id="reticabase" money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="0" data-v-max="999999999999.99" value="0.00" />
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
    <div class="modal fade" id="ModalCategoriaSer">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h2 class="modal-title">Detalle Categoría de Servicios</h2>
                </div>
                <div class="modal-body clearfix" style="margin-bottom: 0;">
                    <div class=" row">
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 sn-padding">
                            <input type="hidden" id="typemov" runat="server" clientidmode="static" value="0" />
                            <div class="form-group">
                                <label for="ds_concepto" class="active">Concepto:</label>
                                <div class="input-group ">
                                    <input type="hidden" id="cd_concepto" value="0" />
                                    <input type="hidden" id="isDescuento" value="0" />
                                    <input type="hidden" id="typedoc" value="COMPRAS" />
                                    <input type="text" class="form-control inputsearch" placeholder=" " readonly="readonly" id="ds_concepto" aria-describedby="sizing-addon1" />
                                    <span class="input-group-addon ">
                                        <button type="button" class="btn btn-primary btnsearch" data-search="Productos" data-method="ConceptosList" data-title="Conceptos" data-select="1,3" data-column="id,codigo,nombre" data-fields="cd_concepto,ds_concepto" data-params="esDesc,isDescuento;tipodocu,typedoc">
                                            <i class="fa fa-fw fa-search"></i>
                                        </button>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class=" row">
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="cd_retefuenteser" class="active">Retefuentes:</label>
                                <select runat="server" clientidmode="static" id="cd_retefuenteser" class="form-control selectpicker" data-size="8">
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="Text_Precioser" class="active">Base</label>
                                <input type="text" class="form-control" id="retfuentebaseser" money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="0" data-v-max="999999999999.99" value="0.00" />
                            </div>
                        </div>

                    </div>
                    <div class=" row">
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="cd_reteivaser" class="active">Rete IVA:</label>
                                <select runat="server" clientidmode="static" id="cd_reteivaser" class="form-control selectpicker" data-size="8">
                                </select>
                            </div>
                        </div>

                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="retivabaseser" class="active">Base</label>
                                <input type="text" class="form-control" id="retivabaseser" money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="0" data-v-max="999999999999.99" value="0.00" />
                            </div>
                        </div>

                    </div>
                    <div class=" row">
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="cd_reteicaser" class="active">ReteICA:</label>
                                <select runat="server" clientidmode="static" id="cd_reteicaser" class="form-control selectpicker" data-size="8">
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="Text_Precioser" class="active">Base</label>
                                <input type="text" class="form-control" id="reticabaseser" money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="0" data-v-max="999999999999.99" value="0.00" />
                            </div>
                        </div>
                    </div>
                    <div class="row buttonaction pull-right">
                        <button title="Guardar" id="btnSaveSer" data-option="I" class="btn btn-outline btn-primary dim waves-effect waves-light" type="button"><i class="fa fa-paste"></i></button>
                        <button title="Cancelar" id="btnCanceSer" class="btn btn-outline btn-danger  dim waves-effect waves-light" data-dismiss="modal" aria-label="Close" type="button"><i class="fa-file-o fa"></i></button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%--</main>--%>
    <script>
        $(function () {
            $('select').selectpicker();
            $('.i-checks').iCheck({
                checkboxClass: 'icheckbox_square-green',
                radioClass: 'iradio_square-green',
            });
        })
    </script>
    <script src="../Pages/ScriptsPage/Contabilidad/CNTCatFiscal.js?1"></script>
</asp:Content>
