<%@ Control Language="C#" AutoEventWireup="true"
    CodeBehind="ClienteInfo.ascx.cs" Inherits="ClienteInfo" %>

<style>
    .coloract {
        background: #18abc361 !important;
        font-weight: bold;
    }

    .divclientinfo .form-group .form-control[readonly] {
        border: solid 1px #b9b9b95c;
        border-radius: 2px;
        background: #b9b9b929;
        padding: 0 18px 0 5px !important;
    }

    .divclientinfo input.form-control, .form-group label {
        font-size: 12px !important;
    }

    .divclientinfo table tbody tr td {
        font-size: 11px !important;
        font-family: "open sans", "Helvetica Neue", Helvetica, Arial, sans-serif;
    }

    .divclientinfo table thead tr th {
        padding: 4px !important;
        font-size: 12px !important;
        font-family: "open sans", "Helvetica Neue", Helvetica, Arial, sans-serif;
    }
</style>
<div class="divclientinfo">
    <div class="row row-inputs" style="margin-bottom: 20px; margin-top: 20px;">
        <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
            <div class="form-group">
                <label>Nombre Cliente</label>
                <input type="text" class="form-control" id="cliente"
                    readonly="readonly" />
            </div>
        </div>
        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
            <div class="form-group">
                <label>Identificación</label>
                <input type="text" class="form-control" id="iden"
                    readonly="readonly" />
            </div>
        </div>
        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
            <div class="form-group">
                <label>Tipo Iden</label>
                <input type="text" class="form-control" id="tipoiden"
                    readonly="readonly" />
            </div>
        </div>
        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
            <div class="form-group">
                <label>Dirección</label>
                <input type="text" class="form-control" id="direccion"
                    readonly="readonly" />
            </div>
        </div>
        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
            <div class="form-group">
                <label>Telefono</label>
                <input type="text" class="form-control" id="telefono"
                    readonly="readonly" />
            </div>
        </div>
        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
            <div class="form-group">
                <label>Celular</label>
                <input type="text" class="form-control" id="celular"
                    readonly="readonly" />
            </div>
        </div>
        <div class="col-lg-12">
            <button title="Cambiar Estado Cliente" id="btnChangestate"
                data-option="I" class="btn btn-outline btn-primary dim  pull-right"
                type="button" style="display: none">
                <i class="fa fa-pencil"></i>
            </button>
        </div>
    </div>
    <div class="row jumbo-tables">
        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12"
            style="padding-top: 5px; padding-bottom: 15px;">
            <h2 class="title-master" style="margin-top: 0;"><span class="fa fa-slideshare fa-fw"></span>Codeudores</h2>
            <div class="table-responsive " style="max-height: 200px !important">
                <table class="table table-striped jambo_table" id="tblcodeudor">
                    <thead>
                        <tr>
                            <th data-column-id="CONTACTO">Nombre</th>
                            <th data-column-id="IDEN">Identificación</th>
                            <th data-column-id="DIRECCION">Dirección</th>
                            <th data-column-id="TELEFONO">Teléfonos</th>
                            <th data-column-id="CELULAR">Celular</th>
                        </tr>
                    </thead>
                </table>
            </div>
        </div>
        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12"
            style="padding-top: 5px; padding-bottom: 15px;">
            <h2 class="title-master" style="margin-top: 0;"><span class="fa fa-list fa-fw"></span>Facturas</h2>
            <div class="table-responsive " style="max-height: 150px !important">
                <table class="table table-striped jambo_table"
                    id="tblfacturas">
                    <thead>
                        <tr>
                            <th data-column-id="cliente" data-formatter="ver">Ver</th>
                            <th data-column-id="FECHFAC">Fecha</th>
                            <th data-column-id="NUMEFAC">Factura</th>
                            <th data-column-id="NUMCUOTAS">Cuotas</th>
                            <th data-column-id="CUOCANCE">Canceladas</th>
                            <th data-column-id="CUOMORA">Mora</th>
                            <th data-column-id="DEUDASINM" data-formatter="valor">$ Mora</th>
                            <th data-column-id="DEUDACONM" data-formatter="valor">$ Mora + Int</th>
                            <th data-column-id="TOTALDEUDA" data-formatter="valor">Total Deuda</th>
                            <th data-column-id="DEUDATOTAL" data-formatter="valor">Total Deuda + Int</th>
                        </tr>
                    </thead>
                </table>
            </div>
        </div>
    </div>
    <div class="row" style="margin-bottom: 20px;">
        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 cuotasfac"
            style="padding-top: 5px; padding-bottom: 15px; display: none;">
            <h2 class="title-master" style="margin-top: 0;"><span class="fa fa-bullhorn fa-fw"></span>Producto<span class="pull-right"
                style="font-weight: bold" id="producto">#0</span></h2>
            <div class="table-responsive " style="max-height: 350px !important">
                <table class="table table-striped jambo_table"
                    id="tblproducto">
                    <thead>
                        <tr>
                            <th data-column-id="NOMBRE">Nombre</th>
                            <th data-column-id="SERIE">Serie</th>
                            <th data-column-id="LOTE">Lote</th>
                            <th data-column-id="CANTIDAD">Cantidad</th>
                            <th data-column-id="PRECIO"
                                data-formatter="valor">Precio</th>
                            <th data-column-id="PRESENTACION">Presentacion</th>
                        </tr>
                    </thead>
                </table>
            </div>
        </div>
        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 cuotasfac"
            style="padding-top: 5px; padding-bottom: 15px; display: none;">
            <div role="alert" aria-live="polite" aria-atomic="true" class="alert alert-dismissible alert-alert alert-card" style="margin-bottom: 0px;padding: 0;padding-bottom: 10px;">                
                <span class="fa fa-2x fa-th-large" style="color:#34E105"></span> Cuotas Pendientes No Vencidas &nbsp;
                <span class="fa fa-2x fa-th-large" style="color:#B82508"></span> Cuotas Pendientes Vencidas &nbsp;
                <span class="fa fa-2x fa-th-large" style="color:#e19d05"></span> Cuotas Refinanciadas &nbsp;
               <span class="pull-right"> <span style="font-weight:bold" id="intmoravalor">0.00</span> % Int. Mora</span>
            </div>
            <h2 class="title-master" style="margin-top: 0;"><span class="fa fa-bullhorn fa-fw"></span>Estado de Cliente <span class="pull-right"
                style="font-weight: bold" id="cuoven">#0</span></h2>
            <div class="table-responsive " style="max-height: 350px !important">
                <table class="table table-striped jambo_table"
                    id="tblcuovencidas">
                    <thead>
                        <tr>
                            <th data-column-id="VENCFAC">Fecha</th>
                            <th data-column-id="CUOTA">Cuota</th>
                            <th data-column-id="VALCUOTA" data-formatter="valor">Valor Cuota</th>
                            <th data-column-id="SANTFAC" data-formatter="debe">Valor Debe</th>
                            <th data-column-id="DIASVEN">Dias Vencidos</th>
                            <th data-column-id="INTEVENC" data-formatter="interes">Intereses</th>
                            <th data-column-id="SALTOTAL" data-formatter="valor">Total</th>
                        </tr>
                    </thead>
                </table>
            </div>
        </div>
        <br />
        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 cuotasfac"
            style="padding-top: 5px; padding-bottom: 15px; display: none;">
            <h2 class="title-master" style="margin-top: 0;"><span class="fa fa-bullhorn fa-fw"></span>Extracto de Cliente <span class="pull-right"
                style="font-weight: bold" id="cuocan">#0</span></h2>
            <div class="table-responsive " style="max-height: 350px !important">
                <table class="table table-striped jambo_table"
                    id="tblcuocanceladas">
                    <thead>
                        <tr>
                            <th data-column-id="NUMDOCTRA">Documento</th>
                            <th data-column-id="IDCENCOSTO">Centro de Costo</th>
                            <th data-column-id="DESCRITRA">Descripción</th>
                            <th data-column-id="VENCEFAC">Fecha Vencimiento</th>
                            <th data-column-id="FECHATRA">Fecha de Recaudo</th>
                            <th data-column-id="VALORTRA" data-formatter="valor">Valor</th>
                        </tr>
                    </thead>
                </table>
            </div>
        </div>
    </div>
</div>
<script>
    $(document).on('click', '.changeact', function () {
        $('.changeact').closest('tr').removeClass('coloract');
        $(this).closest('tr').addClass('coloract');
    });
</script>
