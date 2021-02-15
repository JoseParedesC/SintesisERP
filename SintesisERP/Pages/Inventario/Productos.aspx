<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Productos.aspx.cs" Inherits="Productos" MasterPageFile="~/Masters/SintesisMaster.Master" %>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPage" runat="server">
    <script type="text/javascript">
        window.appPath = "<%=Request.ApplicationPath%>";
    </script>
    <style>
        .autocomplete-suggestions {
            border: medium none;
            border-radius: 3px;
            box-shadow: 0 0 3px rgba(86, 96, 117, 0.7);
            float: left;
            font-size: 12px;
            left: 0;
            list-style: none outside none;
            padding: 0;
            position: absolute;
            text-shadow: none;
            top: 100%;
            z-index: 1000;
            background: #fff;
        }

        .autocomplete-suggestion {
            border-radius: 3px;
            color: inherit;
            line-height: 25px;
            margin: 4px;
            text-align: left;
            font-weight: normal;
            padding: 3px 20px;
        }

        .autocomplete-selected {
            color: #fff;
            text-decoration: none;
            background-color: #337ab7;
            outline: 0;
        }

            .autocomplete-selected strong {
                color: #fff !important;
            }

        .nav.nav-tabs {
            margin-bottom: 10px !important;
        }

            .nav.nav-tabs li a {
                border: 1px solid #ccc;
            }

            .nav.nav-tabs li.active a {
                background-color: #1c84c6 !important;
                color: white;
                border: none;
            }

        .icheckbox_square-green {
            float: none !important;
        }
    </style>

    <div class="row" style="margin: 0px 10px;">
        <div class="x_panel">
            <div class="x_title">
                <h1 class="title-master" style="margin-top: 0;"><span class="fa fa-bullhorn fa-fw"></span>Maestro Productos</h1>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>

    <div class="card" id="diventrada">
        <div class="row" style="margin: 0px 10px;">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding-top: 5px; padding-bottom: 15px; padding-left: 2px;">
                <div class="table-responsive">
                    <table class="table table-striped jambo_table" id="tblarti">
                        <thead>
                            <tr>
                                <th data-column-id="edit" data-formatter="edit" data-sortable="false" style="max-width: 30px !important;">Editar</th>
                                <th data-column-id="tipoproducto">Tipo</th>
                                <th data-column-id="codigo">Código</th>
                                <th data-column-id="presentacion">Presentación</th>
                                <th data-column-id="nombre">Nombre</th>
                                <th data-column-id="tipo">Categoria</th>
                                <th data-column-id="stock" data-formatter="stock" data-sortable="false" style="max-width: 30px">Stock</th>
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
    <!--Modal Del formulario de registro de Productos-->
    <div class="modal fade" id="ModalArticle">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h2 class="modal-title">Detalle Productos</h2>
                </div>
                <div class="modal-body clearfix" style="margin-bottom: 0;">
                    <div class=" row">
                        <ul class="nav nav-tabs">
                            <li class="active"><a data-toggle="tab" href="#tab-1" id="tabuno"><i class="fa fa-user"></i>
                                <span class="hidden-xs">Productos</span></a></li>
                            <li class=""><a data-toggle="tab" href="#" id="tabdos" style="display: none"><i class="fa fa-briefcase"></i>
                                <span class="hidden-xs">Formulación</span></a></li>
                        </ul>
                        <div class="tab-content">
                            <div id="tab-1" class="tab-pane active">
                                <div class="col-lg-3 col-md-3 col-sm-12 col-xs-12 visible-lg visible-md" style="border: 1px solid #ccc;">
                                    <div class="form-group">
                                        <label>Imagen</label>
                                        <input type="file" runat="server" clientidmode="Static" id="imgarticulo" class="dropify" data-height="205" data-max-file-size="5M"
                                            data-allowed-file-extensions="png jpeg jpg" data-max-file-size-preview="5M" />
                                    </div>
                                </div>
                                <div class="col-lg-9 col-md-9 col-sm-12 col-xs-12 " style="padding: 0 !important;">
                                    <div class="col-sm-12 col-xs-12 ">
                                        <div class="col-md-3 col-lg-3 col-sm-6 col-xs-12 sn-padding">
                                            <div class="form-group">
                                                <label for="cd_tipoprod" class="active">Tipo Producto</label>
                                                <select runat="server" clientidmode="static" id="cd_tipoprod" class="form-control selectpicker">
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12 sn-padding">
                                            <div class="form-group">
                                                <label for="cd_tipodoc" class="active">Tipo de Documento:</label>
                                                <select runat="server" clientidmode="static" id="cd_tipodoc" class="form-control selectpicker contable" data-size="8" disabled>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12  sn-padding">
                                            <div class="form-group">
                                                <label for="Text_Codigo" class="active">Código</label>
                                                <input name="Text_Codigo" type="text" class="form-control" id="Text_Codigo" />
                                            </div>
                                        </div>
                                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12  sn-padding">
                                            <div class="form-group">
                                                <label for="Text_codigobarra" class="active">Codigo Barra</label>
                                                <input type="text" class="form-control" id="Text_codigobarra" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-12 col-xs-12 ">
                                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12  sn-padding">
                                            <div class="form-group">
                                                <label for="Text_Presentacion" class="active">Presentacion</label>
                                                <input type="text" class="form-control" id="Text_Presentacion" />
                                            </div>
                                        </div>
                                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12  sn-padding">
                                            <div class="form-group">
                                                <label for="Text_Modelo" class="active">Modelo</label>
                                                <input type="text" class="form-control" id="Text_Modelo" />
                                            </div>
                                        </div>
                                        <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12  sn-padding">
                                            <div class="form-group">
                                                <label for="Text_Nombre" class="active">Nombre</label>
                                                <input type="text" class="form-control" id="Text_Nombre" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-12 col-xs-12 ">
                                        <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12  sn-padding">
                                            <div class="form-group">
                                                <label for="Text_Color" class="active">Color</label>
                                                <input type="text" class="form-control" id="Text_Color" />
                                            </div>
                                        </div>
                                        <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12  sn-padding">
                                            <div class="form-group">
                                                <label for="Text_Grupo" class="active">Categoria</label>
                                                <select runat="server" clientidmode="static" id="Select_Grupo" class="form-control selectpicker" title="Categoria">
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12  sn-padding">
                                            <div class="form-group">
                                                <label for="Text_Nombre" class="active">Marca</label>
                                                <div class="input-group ">
                                                    <input type="hidden" id="id_marcas" />
                                                    <input type="text" class="form-control inputsearch" placeholder=" " readonly="readonly" id="codigomarca" aria-describedby="sizing-addon1" />
                                                    <span class="input-group-addon ">
                                                        <button id="btnsearhmar" type="button" class="btn btn-primary btnsearch" data-search="Marcas" data-method="MarcasList" data-title="Marcas" data-select="1,2" data-column="id,codigo,nombre" data-fields="id_marcas,codigomarca">
                                                            <i class="fa fa-fw fa-search"></i>
                                                        </button>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 " style="padding: 0 !important;">
                                    <div class="col-sm-12 col-xs-12  col-lg-12 col-md-12">
                                        <div class="col-md-2 col-lg-2 col-sm-4 col-xs-6 sn-padding">
                                            <div class="form-group">
                                                <label for="Inventario" class="active">Inventario ? </label>
                                                <div class="check-mail">
                                                    <input type="checkbox" class="i-checks pull-right" id="Inventario" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-2 col-lg-2 col-sm-4 col-xs-6 sn-padding">
                                            <div class="form-group">
                                                <label for="Text_factura" class="active">Facturable? </label>
                                                <div class="check-mail">
                                                    <input type="checkbox" class="i-checks pull-right" id="Text_factura" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-2 col-lg-2 col-sm-4 col-xs-6 sn-padding">
                                            <div class="form-group">
                                                <label for="Text_serie" class="active">Serie? </label>
                                                <div class="check-mail">
                                                    <input type="checkbox" class="i-checks pull-right" id="Text_serie" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-2 col-lg-2 col-sm-4 col-xs-6 sn-padding">
                                            <div class="form-group">
                                                <label for="lote" class="active">Lote ? </label>
                                                <div class="check-mail">
                                                    <input type="checkbox" class="i-checks pull-right" id="lote" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-2 col-lg-2 col-sm-4 col-xs-6 sn-padding">
                                            <div class="form-group">
                                                <label for="Formulado" class="active">Formulado ? </label>
                                                <div class="check-mail">
                                                    <input type="checkbox" class="i-checks pull-right" id="Formulado" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-2 col-lg-2 col-sm-4 col-xs-6 sn-padding">
                                            <div class="form-group">
                                                <label for="Stock" class="active">Stock ? </label>
                                                <div class="check-mail">
                                                    <input type="checkbox" class="i-checks pull-right" id="stock" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-12 col-xs-12  col-lg-12 col-md-12">
                                        <div class="col-lg-2 col-md-2 col-sm-4 col-xs-6  sn-padding" style="">
                                            <div class="form-group">
                                                <label for="Text_Categoria" class="active">Impuestos?</label>
                                                <div class="check-mail">
                                                    <input type="checkbox" class="i-checks pull-right" id="Text_Categoria" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-2 col-md-2 col-sm-4 col-xs-6  sn-padding" style="">
                                            <div class="form-group">
                                                <label for="Text_IncuyeIva" class="active">IVA incluido  </label>
                                                <div class="check-mail">
                                                    <input type="checkbox" class="i-checks pull-right" id="Text_IncuyeIva" disabled="" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-2 col-md-2 col-sm-12 col-xs-12  sn-padding">
                                            <div class="form-group">
                                                <label for="cd_iva" class="active">IVA:</label>
                                                <select runat="server" clientidmode="static" id="cd_iva" class="form-control selectpicker" data-size="8">
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-lg-3 col-md-3 col-sm-12 col-xs-12  sn-padding">
                                            <div class="form-group">
                                                <label for="cd_inc" class="active">INC:</label>
                                                <select runat="server" clientidmode="static" id="cd_inc" class="form-control selectpicker" data-size="8">
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-lg-3 col-md-3 col-sm-12 col-xs-12 sn-padding">
                                            <div class="form-group">
                                                <label for="Text_Precio" class="active">Precio</label>
                                                <input type="text" class="form-control" id="Text_Precio" money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="0" data-v-max="999999999999.99" value="0" data-a-sign="$ " />
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-12 col-xs-12 col-lg-12 col-md-12">
                                        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12 sn-padding">
                                            <div class="form-group">
                                                <label for="Text_Descuento" class="active">% Descuento</label>
                                                <input type="text" class="form-control" id="Text_Descuento" money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="0" data-v-max="100" value="0" />
                                            </div>
                                        </div>
                                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12 sn-padding">
                                            <div class="form-group">
                                                <label for="Text_Nombre" class="active">Cuenta Contable</label>
                                                <div class="input-group ">
                                                    <input type="hidden" id="tipo" value="TERCE" />
                                                    <input type="hidden" id="id_ctacon" value="0" />
                                                    <input type="text" class="form-control inputsearch" placeholder=" " readonly="readonly" id="ds_ctacon" aria-describedby="sizing-addon1" />
                                                    <span class="input-group-addon ">
                                                        <button id="btncuenta" type="button" class="btn btn-primary btnsearch" data-search="CNTCuentas" data-method="CNTCuentasDetalle" data-title="Cuentas" data-select="1,2" data-column="id,codigo,nombre" data-fields="id_ctacon,ds_ctacon" data-params="tipo,tipo">
                                                            <i class="fa fa-fw fa-search"></i>
                                                        </button>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12 sn-padding">
                                            <div class="form-group">
                                                <label for="cd_naturaleza" class="active">Naturaleza:</label>
                                                <select runat="server" clientidmode="static" id="cd_naturaleza" class="form-control selectpicker contable" data-size="8">
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12  sn-padding" style="">
                                            <div class="form-group">
                                                <label for="Text_Cdescuento" class="active">Es de Descuento?</label>
                                                <div class="check-mail">
                                                    <input type="checkbox" class="i-checks pull-right" id="Text_Cdescuento" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div id="tab-2" class="tab-pane">
                                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding: 5px 0 0 0;">
                                    <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12 sn-padding">
                                        <div class="form-group">
                                            <label for="v_code" class="active">Código:</label>
                                            <input type="hidden" id="v_code" value="0" />
                                            <input type="text" name="country" id="valor_prod" class="form-control actionautocomple inputsearch" placeholder=" " data-search="Productos" data-endcallback="SelecProducto" data-method="ArticulosBuscador" data-params="op:H;o:#;formula:true;id_prod:0;" data-result="value:name;data:id;inventarial:inventarial" data-idvalue="v_code" />
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12 sn-padding">
                                        <div class="form-group">
                                            <label for="nombre" class="active">Nombre:</label>
                                            <input type="text" name="nombre" id="nombre" class="form-control" placeholder=" " disabled="true" data-lote="false" data-serie="false" />
                                        </div>
                                    </div>

                                    <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12 sn-padding">
                                        <div class="form-group">
                                            <label for="m_quantity" class="active">Cantidad:</label>
                                            <input id="m_quantity" type="text" class="form-control" placeholder=" " money="true" data-a-dec="." data-a-sep="," data-m-dec="4" data-v-min="0.00" value="0.00" />
                                        </div>
                                    </div>
                                    <div class="col-lg-1 col-md-1 col-sm-2 col-xs-12 sn-padding">
                                        <button id="addArticulo" type="button" class="btn btn-sin btn-circle addarticle" title="Agregar"><i class="fa fa-plus"></i></button>
                                    </div>
                                </div>
                                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 sn_padding">
                                    <div class="form-group">
                                        <label for="Text_color" class="active">Artículos Agregados</label>
                                        <div class="table-responsive" style="max-height: 200px;">
                                            <table class="table table-striped jambo_table" id="tblformulado">
                                                <thead>
                                                    <tr>
                                                        <th class="text-center"><a id="removeart"><span class="fa fa-2x fa-trash-o text-danger iconfa"></span></a></th>
                                                        <th class="text-center">Id</th>
                                                        <th class="text-center">Producto</th>
                                                        <th class="text-center">Cantidad</th>
                                                    </tr>
                                                </thead>
                                                <tbody id="tbodformulado">
                                                </tbody>
                                            </table>
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
        </div>
    </div>
    <div class="modal fade" id="ModalStock">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h2 class="modal-title">Definicion de Stock por Bodegas</h2>
                </div>
                <div class="modal-body clearfix" style="margin-bottom: 0; padding-top: 0 !important">
                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12 sn-padding">
                            <input type="hidden" id="idbodprod" value="0" />
                        </div>
                        <div class="col-lg-12 col-md-12 col-sm-12  col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="Text_Nombre" class="active">Bodega</label>
                                <div class="input-group ">
                                    <input type="hidden" id="idbodega" />
                                    <input type="text" class="form-control inputsearch" placeholder=" " readonly="readonly" id="codigobodega" aria-describedby="sizing-addon1" />
                                    <span class="input-group-addon ">
                                        <button id="Bodegas" type="button" class="btn btn-primary btnsearch" data-search="Bodegas" data-method="BodegasList" data-title="Bodegas" data-select="1,3" data-column="id,codigo,nombre" data-fields="idbodega,codigobodega">
                                            <i class="fa fa-fw fa-search"></i>
                                        </button>
                                    </span>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="row">
                        <div class="col-lg-5 col-md-5 col-sm-12  col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="Text_stockmin" class="active">Stock Minimo</label>
                                <input type="text" placeholder=" " class="form-control" id="Text_stockmin" money="true" data-v-min="0" value="0.00" />
                            </div>
                        </div>
                        <div class="col-lg-5 col-md-5 col-sm-12  col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="Text_stockmax" class="active">Stock Maximo</label>
                                <input type="text" placeholder=" " class="form-control" id="Text_stockmax" money="true" data-v-min="0" value="0.00" />
                            </div>
                        </div>
                        <div class="col-sm-2 col-md-2 sn-padding">
                            &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;
                                 <button id="btnSaveStock" type="button" data-id="0" class="btn-block btn btn-info  dim " data-loading-text="<i class='fa fa-spinner fa-spin'></i>" style="margin-right: 5px"><i class="fa fa-paste"></i></button>
                        </div>
                    </div>
                    <div class="row" style="padding: 1rem 1rem">
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding-top: 5px; padding-bottom: 15px; padding-left: 2px;">
                            <div class="table-responsive ">
                                <table class="table table-striped jambo_table" id="tblbodegaprodu">
                                    <thead>
                                        <tr>
                                            <th data-column-id="edit" data-formatter="edit" data-sortable="false" style="max-width: 30px !important;">Editar</th>
                                            <th data-column-id="bodega">Bodega</th>
                                            <th data-column-id="stockmin">Min</th>
                                            <th data-column-id="stockmax">Max</th>
                                            <th data-column-id="delete" data-formatter="delete" data-sortable="false" style="max-width: 30px">Eliminar</th>
                                        </tr>
                                    </thead>
                                </table>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <button id="btnCanceBodPro" type="button" data-id="0" class="pull-right btn btn-danger" data-dismiss="modal" aria-label="Close">Cancelar</button>
                        &nbsp;
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
    <script src="../Package/Vendor/js/plugins/Autocomplete/jquery.autocomplete.js"></script>
    <script src="../Pages/ScriptsPage/Inventario/Productos.js"></script>
</asp:Content>
