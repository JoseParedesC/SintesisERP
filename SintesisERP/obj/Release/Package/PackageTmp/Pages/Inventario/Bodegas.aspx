<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Bodegas.aspx.cs" Inherits="Bodegas" 
    MasterPageFile="~/Masters/SintesisMaster.Master" %>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPage" runat="server">
    <script type="text/javascript">
        window.appPath = "<%=Request.ApplicationPath%>";
    </script>

    <div class="row" style="margin: 0px 10px;">
        <div class="x_panel">
            <div class="x_title">
                <h1 class="title-master" style="margin-top: 0;"><span class="fa fa-bullhorn fa-fw"></span>Maestro Bodegas</h1>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>

    <div class="card" id="diventrada">
        <div class="row" style="margin: 0px 10px;">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding-top: 5px; padding-bottom: 15px; padding-left: 2px;">
                <div class="table-responsive ">
                    <table class="table table-striped jambo_table" id="tbltipo">
                        <thead>
                            <tr>
                                <th data-column-id="edit" data-formatter="edit" data-sortable="false" style="max-width: 30px !important;">Editar</th>
                                <th data-column-id="codigo">Código</th>
                                <th data-column-id="nombre">Nombre</th>
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
    <!--Modal Del formulario de registro de Cuentas-->
    <div class="modal fade" id="ModalWineries">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h2 class="modal-title">Detalle Bodega</h2>
                </div>
                <div class="modal-body clearfix" style="margin-bottom: 0; padding-top: 0 !important">
                    <div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="codigo" class="active">Código</label>
                                <input type="text" placeholder=" " class="form-control" id="codigo" />
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="Text_Nombre" class="active">Nombre</label>
                                <input type="text" placeholder=" " class="form-control" id="Text_Nombre" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 sn-padding">
                            <input type="hidden" id="tipo" value="TERCE" />
                            <!--Campo de busqueda de cuentas-->
                            <div class="form-group">
                                <label for="Text_Nombre" class="active">Cuenta Inventario</label>
                                <div class="input-group ">
                                    <input type="hidden" id="id_ctainv" />
                                    <input type="text" class="form-control inputsearch" placeholder=" " readonly="readonly" id="ds_ctainv" aria-describedby="sizing-addon1" />
                                    <span class="input-group-addon ">
                                        <button id="id_AccountBox" type="button" class="btn btn-primary btnsearch" data-search="CNTCuentas" data-method="CNTCuentasDetalle" data-select="1,2" data-title="Cuentas" data-column="id,codigo,nombre" data-fields="id_ctainv,ds_ctainv" data-params="tipo,tipo">
                                            <i class="fa fa-fw fa-search"></i>
                                        </button>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 sn-padding">
                            <!--Campo de busqueda de cuentas-->
                            <div class="form-group">
                                <label for="Text_Nombre" class="active">Cuenta Costo</label>
                                <div class="input-group ">
                                    <input type="hidden" id="id_ctacos" />
                                    <input type="text" class="form-control inputsearch" placeholder=" " readonly="readonly" id="ds_ctacos" aria-describedby="sizing-addon1" />
                                    <span class="input-group-addon ">
                                        <button id="Button2" type="button" class="btn btn-primary btnsearch" data-search="CNTCuentas" data-method="CNTCuentasDetalle" data-title="Cuentas" data-select="1,2" data-column="id,codigo,nombre" data-fields="id_ctacos,ds_ctacos" data-params="tipo,tipo">
                                            <i class="fa fa-fw fa-search"></i>
                                        </button>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 sn-padding">
                            <!--Campo de busqueda de cuentas-->
                            <div class="form-group">
                                <label for="Text_Nombre" class="active">Cuenta Descuento</label>
                                <div class="input-group ">
                                    <input type="hidden" id="id_ctades" />
                                    <input type="text" class="form-control inputsearch" placeholder=" " readonly="readonly" id="ds_ctades" aria-describedby="sizing-addon1" />
                                    <span class="input-group-addon ">
                                        <button id="Button6" type="button" class="btn btn-primary btnsearch" data-search="CNTCuentas" data-method="CNTCuentasDetalle" data-title="Cuentas" data-select="1,2" data-column="id,codigo,nombre" data-fields="id_ctades,ds_ctades" data-params="tipo,tipo">
                                            <i class="fa fa-fw fa-search"></i>
                                        </button>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 sn-padding">
                            <!--Campo de busqueda de cuentas-->
                            <div class="form-group">
                                <label for="Text_Nombre" class="active">Cuenta Ingreso</label>
                                <div class="input-group ">
                                    <input type="hidden" id="id_ctaing" />
                                    <input type="text" class="form-control inputsearch" placeholder=" " readonly="readonly" id="ds_ctaing" aria-describedby="sizing-addon1" />
                                    <span class="input-group-addon ">
                                        <button id="Button7" type="button" class="btn btn-primary btnsearch" data-search="CNTCuentas" data-method="CNTCuentasDetalle" data-title="Cuentas" data-select="1,2" data-column="id,codigo,nombre" data-fields="id_ctaing,ds_ctaing" data-params="tipo,tipo">
                                            <i class="fa fa-fw fa-search"></i>
                                        </button>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 sn-padding">
                            <!--Campo de busqueda de cuentas-->
                            <div class="form-group">
                                <label for="Text_Nombre" class="active">Cuenta Ing. Excluidos</label>
                                <div class="input-group ">
                                    <input type="hidden" id="id_ctaingex" />
                                    <input type="text" class="form-control inputsearch" placeholder=" " readonly="readonly" id="ds_ctaingex" aria-describedby="sizing-addon1" />
                                    <span class="input-group-addon ">
                                        <button id="Buttoningex" type="button" class="btn btn-primary btnsearch" data-search="CNTCuentas" data-method="CNTCuentasDetalle" data-title="Cuentas" data-select="1,2" data-column="id,codigo,nombre" data-fields="id_ctaingex,ds_ctaingex" data-params="tipo,tipo">
                                            <i class="fa fa-fw fa-search"></i>
                                        </button>
                                    </span>
                                </div>
                            </div>
                        </div>
                         <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 sn-padding">
                            <!--Campo de busqueda de cuentas-->
                            <div class="form-group">
                                <label for="Text_Nombre" class="active">Cuenta Iva Flete</label>
                                <div class="input-group ">
                                    <input type="hidden" id="id_ctaivaflete" />
                                    <input type="text" class="form-control inputsearch" placeholder=" " readonly="readonly" id="ds_ctaivaflete" aria-describedby="sizing-addon1" />
                                    <span class="input-group-addon ">
                                        <button id="Buttonivaflete" type="button" class="btn btn-primary btnsearch" data-search="CNTCuentas" data-method="CNTCuentasDetalle" data-title="Cuentas" data-select="1,2" data-column="id,codigo,nombre" data-fields="id_ctaivaflete,ds_ctaivaflete" data-params="tipo,tipo">
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
    <script>
        $(function () {
            $('select').selectpicker();
        })
    </script>
    <script src="../Pages/ScriptsPage/Inventario/Bodegas.js?1"></script>
</asp:Content>

