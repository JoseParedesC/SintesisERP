<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Entradas.aspx.cs"
    Inherits="Entradas" MasterPageFile="~/Masters/SintesisMaster.Master" %>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPage" runat="server">
    <script type="text/javascript">
        window.appPath = "<%=Request.ApplicationPath%>";
    </script>
    <link href="../Package/Vendor/css/plugins/Autocomplete/autocomplet.css" rel="stylesheet" />
    <style>
        .select-css {
            font-weight: 700;
            color: #444;
            padding: .3em 1em .3em .8em;
            width: 100%;
            max-width: 100%;
            border-radius: .5em;
            -moz-appearance: none;
            -webkit-appearance: none;
            appearance: none;
            background-image: url(data:image/svg+xml;charset=US-ASCII,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20width%3D%22292.4%22%20height%3D%22292.4%22%3E%3Cpath%20fill%3D%22%23007CB2%22%20d%3D%22M287%2069.4a17.6%2017.6%200%200%200-13-5.4H18.4c-5%200-9.3%201.8-12.9%205.4A17.6%2017.6%200%200%200%200%2082.2c0%205%201.8%209.3%205.4%2012.9l128%20127.9c3.6%203.6%207.8%205.4%2012.8%205.4s9.2-1.8%2012.8-5.4L287%2095c3.5-3.5%205.4-7.8%205.4-12.8%200-5-1.9-9.2-5.5-12.8z%22%2F%3E%3C%2Fsvg%3E), linear-gradient(to bottom, #ffffff 0%,#e5e5e5 100%);
            background-repeat: no-repeat, repeat;
            background-position: right .7em top 50%, 0 0;
            background-size: .65em auto, 100%;
        }

        .rowedit {
            width: 100px;
        }

        .tdedit {
            cursor: pointer;
        }

        #divaddart .bootstrap-select span.filter-option, #divaddart input, #divaddart .form-group label {
            font-size: 12px !important;
        }

        #divaddart .form-group label {
            margin-bottom: 5px;
        }

        .desactivelote, .desactiveserie, .desactiveservice {
            display: none;
        }

        .activelote, .activeserie, .activeservice {
            display: block;
        }


        .input-group-addon .btn-primary {
            height: 29.77px !important;
        }

        #divaddart.col-sm-12 .actions.btn-group {
            display: none;
        }

        #tblcommodity-footer .row {
            margin-left: 0 !important;
        }

        .btn-outline[disabled] {
            color: #fff !important;
        }

        .dropify-wrapper {
            min-height: 150px;
        }

        .btn-outline {
            margin-bottom: 20px !important;
        }

        .form-group {
            margin-bottom: 10px !important;
        }

        .padsmall {
            padding-right: 5px !important;
            padding-left: 5px !important;
        }

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

        .codvalue {
            padding: 0 0 10px 0 !important;
            margin-bottom: 5px;
            border-style: none;
            min-height: 38px;
        }

            .codvalue h1 {
                font-size: 19px;
                text-align: right;
                padding: 0 !important;
            }

            .codvalue span {
                float: right;
            }

        .icheckbox_square-green {
            margin: 0 !important;
        }

        tr th {
            padding: 2px !important;
        }

        .addarticle {
            font-size: 20px;
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: #1ab394;
            color: #fff;
            text-align: center;
        }

        .row {
            background-color: #fff !important;
        }

        .nav.nav-tabs li {
            background: #1ab394;
            color: #fff !important;
        }

            .nav.nav-tabs li.active {
                background: #fff;
            }

            .nav.nav-tabs li a {
                color: #fff !important;
                outline: none !important;
                border-bottom: 2px #1ab394 solid !important;
            }

            .nav.nav-tabs li.active a {
                color: #1ab394 !important;
            }

        .wrapper {
            padding: 0 10px;
        }

        .Botns button {
            margin-bottom: 20px !important;
        }

        .quoteNumber {
            border-radius: .1em;
            background: #fff;
            font-size: 20px;
            font-weight: bold;
            text-align: center;
            margin-top: -5px;
            margin-right: 5px;
            border: solid 1px;
        }

        .entradanumber {
            width: 100% !important;
            text-align: center;
            position: relative;
            float: right;
            margin-top: -8px;
        }

        .command-edit {
            margin-left: 5px;
        }
    </style>
    <input type="hidden" id="id_entrada" value="0" />
    <input type="hidden" id="id_entradatemp" value="0" />
    <input type="hidden" id="isOrden" value="" />
    <input type="hidden" id="idOrden" value="" />
    <input type="hidden" id="totalItems" value="0" />
    <div class="row" style="margin-left: 0;">
        <div class="x_panel">
            <div class="x_title col-lg-5 col-md-5 col-sm-7 col-xs-12">
                <h1 class="title-master" style="margin-top: 0;"><span class="fa fa-level-down fa-fw"></span>Compras</h1>
                <div class="clearfix"></div>
            </div>
            <div class="col-lg-7 col-md-7 col-sm-5 col-xs-12 Botns">
                <input type="hidden" id="opTipoEntrada" value="T" />
                <input type="hidden" id="esOrden" value="false" />
                <input type="hidden" id="id_ordenCompra" value="" runat="server" clientidmode="static" />

                <button title="Revertir" id="btnRev" class="mintip btn btn-outline btn-danger  dim  pull-right" type="button" disabled="disabled"><i class="fa-file-o fa"></i></button>
                <button title="Guardar" id="btnSave" data-option="I" class="mintip btn btn-outline btn-primary dim  pull-right" type="button"><i class="fa fa-paste"></i></button>
                <button title="Temporal" id="btnTemp" data-option="L" class="mintip btn btn-outline btn-success  dim  pull-right" type="button" style="display: none"><i class="fa fa-upload"></i></button>
                <button title="Imprimir" id="btnPrint" data-option="I" class="mintip btn btn-outline btn-print dim  pull-right" type="button"><i class="fa fa-print"></i></button>
                <button title="Configurar" id="btnconf" data-option="C" class="mintip btn btn-outline btn-warning dim  pull-right" type="button"><i class="fa-cog fa"></i></button>
                <button title="Cargar" id="btnload" data-option="D" class="mintip btn btn-outline btn-warning dim  pull-right" type="button"><i class="fa fa-cloud-upload fa"></i></button>
                <button title="Nueva" id="btnnew" data-option="R" class="mintip btn btn-outline btn-default  dim  pull-right" type="button"><i class="fa-file-o fa"></i></button>
                <button title="Listar" id="btnList" data-option="L" class="mintip btn btn-outline btn-info  dim  pull-right" type="button"><i class="fa-list fa"></i></button>


                <span class="pull-right quoteNumber"><span style="font-size: 14px; font-weight: normal;">Consecutivo</span><span class="entradanumber">0</span></span>
            </div>
        </div>
    </div>

    <div class="card" id="diventrada">
        <div class="row" style="margin: 0px 10px;">
            <div class="col-lg-2 col-md-3 col-sm-4 sn-padding">
                <div class="form-group">
                    <label for="cd_tipodoc" class="active">Tipo de Documento:</label>
                    <select runat="server" clientidmode="static" id="cd_tipodoc" class="form-control selectpicker" data-size="8">
                    </select>
                </div>
            </div>
            <div class="col-lg-2 col-md-3 col-sm-4 sn-padding">
                <div class="form-group">
                    <label for="Text_Nombre" class="active">Centro Costo</label>
                    <input type="hidden" id="id_ccostos" value="0" />
                    <input type="hidden" id="isofDetalle" value='true' />
                    <input type="text" class="form-control actionautocomple inputsearch" id="codigoccostos" aria-describedby="sizing-addon1" data-search="Bodegas" data-method="BodegasBuscador" data-params="op:F;o:#" data-result="value:name;data:id" data-idvalue="id_ccostos" />
                </div>
            </div>
            <div class="col-lg-2 col-md-2 col-sm-4 sn-padding">
                <div class="form-group">
                    <label for="Text_Fecha" class="active">Fecha Doc:</label>
                    <input id="Text_Fecha" type="text" placeholder=" " class="form-control" current="true" date="true" format="YYYY-MM-DD" />
                </div>
            </div>
            <div class="col-lg-2 col-md-2 col-sm-4 sn-padding">
                <div class="form-group">
                    <label for="Text_Numero" class="active">Factura:</label>
                    <input id="Text_Numero" type="text" placeholder=" " class="form-control" />
                </div>
            </div>
            <div class="col-lg-2 col-md-2 col-sm-4 sn-padding">
                <div class="form-group">
                    <label for="Text_FechaFac" class="active">Fec Factura:</label>
                    <input id="Text_FechaFac" type="text" placeholder=" " class="form-control" current="true" date="true" format="YYYY-MM-DD" />
                </div>
            </div>
            <div class="col-lg-2 col-md-1 col-sm-4 sn-padding">
                <div class="form-group">
                    <label for="Text_Dias" class="active">Dias:</label>
                    <input id="Text_Dias" type="text" placeholder=" " class="form-control" money="true" data-a-dec="." data-a-sep="," data-m-dec="0" data-v-min="0" value="0" />
                </div>
            </div>

            <div class="col-lg-2 col-md-3 col-sm-4 col-xs-6 sn-padding">
                <div class="form-group">
                    <label for="Text_FechaV" class="active">Vencimiento:</label>
                    <input id="Text_FechaV" type="text" placeholder=" " class="form-control" current="true" date="true" format="YYYY-MM-DD" />
                </div>
            </div>
            <div class="col-lg-3 col-md-3 col-sm-5 col-xs-12  sn-padding">
                <div class="form-group">
                    <label for="Text_Nombre" class="active">Proveedor</label>
                    <input type="hidden" id="cd_provider" value="0" />
                    <input type="hidden" id="tipotercero" value="PR" />
                    <input type="text" class="form-control actionautocomple inputsearch" id="ds_cliente" aria-describedby="sizing-addon1" data-search="Bodegas" data-method="BodegasBuscador" data-params="op:T;o:PR" data-result="value:name;data:id" data-idvalue="cd_provider" />
                </div>
            </div>
            <div class="col-lg-2 col-md-2 col-sm-3 col-xs-12 padsmall  sn-padding">
                <div class="form-group">
                    <label for="cd_wineridef" class="active">Bodega:</label>
                    <input type="hidden" class="form-control" id="cd_wineridef" value="0" />
                    <input type="text" class="form-control actionautocomple inputsearch" id="ds_bod" aria-describedby="sizing-addon1" data-search="Bodegas" data-method="BodegasBuscador" data-params="op:Z;o:#" data-result="value:name;data:id" data-idvalue="cd_wineridef" />
                </div>
            </div>
            <div class="col-lg-2 col-md-2 col-sm-3 col-xs-12 padsmall  sn-padding">
                <div class="form-group">
                    <label for="cd_formapago" class="active">Forma de Pago:</label>
                    <select runat="server" clientidmode="static" id="cd_formapago" class="form-control selectpicker" data-size="8">
                    </select>
                </div>
            </div>
            <div class="col-lg-1 col-md-1 col-sm-3 col-xs-12 sn-padding">
                <div class="form-group">
                    <label for="flete" class="active">Flete</label>
                    <input type="text" class="form-control" id="flete" money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="0" data-v-max="999999999999.99" value="0" />
                </div>
            </div>
            <div class="col-lg-2 col-md-2 col-sm-4 col-xs-12 sn-padding">
                <div class="form-group">
                    <label for="Text_Nombre" class="active">Cuenta de Anticipo:</label>
					<input type="hidden" class="form-control" id="id_ctaant" />
					<input type="hidden" id="tipo" value="ANT" />
					<input type="text" class="form-control actionautocomple inputsearch" id="ds_ctaant" aria-describedby="sizing-addon1" data-search="Bodegas" data-method="BodegasBuscador" data-params="op:K;o:#;tipo:ANT" data-result="value:name;data:id" data-idvalue="id_ctaant" />
				</div>                
            </div>
        </div>
        <div class="row" style="margin: 0 10px;">
            <hr class="hrseparator" style="margin-top: 0px; margin-bottom: 10px" />
        </div>
        <div class="row" style="margin: 0 10px;" id="divaddart" data-serie="false" data-inventario="false">
            <div class="col-lg-10 col-md-10 col-sm-12 col-xs-12" style="padding: 0;">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 divarticleadd" style="padding: 0;">
                    <div class="col-lg-2 col-md-3 col-sm-6 col-xs-12">
                        <div class="form-group">
                            <label for="v_code" class="active">Código:</label>
                            <input type="text" name="country" id="v_code" class="form-control" placeholder=" " />
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                        <div class="form-group">
                            <label for="nombre" class="active">Nombre:</label>
                            <input type="text" name="nombre" id="nombre" class="form-control" placeholder=" " disabled="disabled" data-lote="false" data-serie="false" />
                        </div>
                    </div>
                    <div class="col-lg-1 col-md-3 col-sm-3 col-xs-12">
                        <div class="form-group">
                            <label for="m_quantity" class="active">Cant:</label>
                            <input id="m_quantity" type="text" class="form-control" data-option="P" placeholder=" " money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="0.01" data-v-max="999999999.99" value="1.00" />
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-3 col-sm-3 col-xs-12">
                        <div class="form-group">
                            <label for="m_cost" class="active">Costo:</label>
                            <input id="m_cost" type="text" class="form-control" data-option="P" value="0.00" placeholder=" " money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="0" data-a-sign="$ " />
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-3 col-xs-12">
                        <div class="form-group">
                            <label for="Text_Descuento" class="active">% Desc:</label>
                            <input id="Text_Descuento" type="text" class="form-control addart" data-option="P" placeholder=" " value="0.00" money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="0" data-v-max="100" data-a-sign="% " />
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-3 col-xs-12">
                        <div class="form-group">
                            <label for="m_discount" class="active">Desc x Valor:</label>
                            <input type="text" class="form-control addart" id="m_discount" data-option="V" placeholder=" " value="0.00" money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="0" data-a-sign="$ " />
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-3 col-xs-12">
                        <div class="form-group">
                            <label for="cd_iva" class="active">IVA:</label>
                            <select runat="server" clientidmode="static" id="cd_iva" class="form-control selectpicker" data-size="8">
                            </select>
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-3 col-xs-12">
                        <div class="form-group">
                            <label for="cd_inc" class="active">INC:</label>
                            <select runat="server" clientidmode="static" id="cd_inc" class="form-control selectpicker" data-size="8">
                            </select>
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12 desactivelote">
                        <div class="form-group">
                            <label for="v_lote" class="active">Lote:</label>
                            <input type="text" name="country" id="v_lote" class="form-control" placeholder=" " />
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12 desactivelote">
                        <div class="form-group">
                            <label for="Text_FechaV2" class="active">Vencimiento:</label>
                            <input id="Text_FechaV2" type="text" placeholder=" " class="form-control" current="true" date="true" format="YYYY-MM-DD" />
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-3 col-xs-12 desactiveservice">
                        <div class="form-group">
                            <label for="cd_retefuente" class="active">Retefuentes:</label>
                            <select runat="server" clientidmode="static" id="cd_retefuente" class="form-control selectpicker" data-size="8">
                            </select>
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-3 col-xs-12 desactiveservice">
                        <div class="form-group">
                            <label for="cd_reteiva" class="active">Rete IVA:</label>
                            <select runat="server" clientidmode="static" id="cd_reteiva" class="form-control selectpicker" data-size="8">
                            </select>
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-3 col-xs-12 desactiveservice">
                        <div class="form-group">
                            <label for="cd_reteica" class="active">ReteICA:</label>
                            <select runat="server" clientidmode="static" id="cd_reteica" class="form-control selectpicker" data-size="8">
                            </select>
                        </div>
                    </div>
                    <div class="col-lg-1 col-md-2 col-sm-3 col-xs-12">
                        <button title="Agregar" id="addarticle" data-option="I" class="btn btn-outline btn-primary dim  pull-right" type="button" data-id="0" style="margin-bottom: 0 !important; margin-top: 15px; float: left !important;"><i class="fa fa-plus"></i></button>
                    </div>
                </div>
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding: 0">
                    <div class="table-responsive" style="max-height: 600px; min-height: 250px">
                        <table class="table table-striped jambo_table" id="tblcommodity">
                            <thead>
                                <tr>
                                    <th data-column-id="codigo" data-formatter="delete" data-sortable="false">#</th>
                                    <th data-column-id="codigo">Código</th>
                                    <th data-column-id="nombre">Nombre</th>
                                    <th data-column-id="bodega">Bodega</th>
                                    <th data-column-id="lote" data-formatter="lote">Lote</th>
                                    <th data-column-id="serie" data-formatter="serie">Serie</th>
                                    <th data-column-id="vencimiento" data-formatter="vencimiento">Vencimiento</th>
                                    <th data-column-id="cantidad" data-formatter="cantidad">Cantidad</th>
                                    <th data-column-id="costo" data-formatter="costo">Costo</th>
                                    <th data-column-id="descuento" data-formatter="descuento">Descuento</th>
                                    <th data-column-id="iva" data-formatter="iva">Iva</th>
                                    <th data-column-id="inc" data-formatter="inc">INC</th>
                                    <th data-column-id="costototal" data-formatter="costototal">Total</th>
                                </tr>
                            </thead>
                        </table>
                    </div>
                </div>
            </div>
            <div class="col-lg-2 col-md-2 col-sm-12 col-xs-12" style="margin-top: 10px;">
                <div class="row">
                    <div class="table-responsive" style="border: none;">
                        <div class="col-lg-12 col-md-12 col-xs-12 col-sm-12" style="border-bottom: 1px solid #e7eaec">
                            <div class="ibox-content codvalue text-right">
                                <h1 id="Tcosto" class="no-margins">$ 0.00</h1>
                                <span class="font-bold text-navy">Costo</span>
                            </div>
                        </div>
                        <div class="col-lg-12 col-md-12 col-xs-12 col-sm-12" style="border-bottom: 1px solid #e7eaec">
                            <div class="ibox-content codvalue text-right">
                                <h1 id="Tdesc" class="no-margins">$ 0.00</h1>
                                <span class="font-bold text-navy">Descuento</span>
                            </div>
                        </div>
                        <div class="col-lg-12 col-md-12 col-xs-12 col-sm-12" style="border-bottom: 1px solid #e7eaec">
                            <div class="ibox-content codvalue text-right">
                                <h1 id="Tiva" class="no-margins">$ 0.00</h1>
                                <span class="font-bold text-navy">Iva</span>
                            </div>
                        </div>
                        <div class="col-lg-12 col-md-12 col-xs-12 col-sm-12" style="border-bottom: 1px solid #e7eaec">
                            <div class="ibox-content codvalue text-right">
                                <h1 id="Tinc" class="no-margins">$ 0.00</h1>
                                <span class="font-bold text-navy">INC</span>
                            </div>
                        </div>
                        <div class="col-lg-12 col-md-12 col-xs-12 col-sm-12" style="border-bottom: 1px solid #e7eaec">
                            <div class="ibox-content codvalue text-right">
                                <h1 id="retfuente" class="no-margins">$ 0.00</h1>
                                <span class="font-bold text-navy">Ret. Fuente %</span>
                            </div>
                        </div>
                        <div class="col-lg-12 col-md-12 col-xs-12 col-sm-12" style="border-bottom: 1px solid #e7eaec">
                            <div class="ibox-content codvalue text-right">
                                <h1 id="retica" class="no-margins">$ 0.00</h1>
                                <span class="font-bold text-navy">Ret. ICA %</span>
                            </div>
                        </div>
                        <div class="col-lg-12 col-md-12 col-xs-12 col-sm-12" style="border-bottom: 1px solid #e7eaec">
                            <div class="ibox-content codvalue text-right">
                                <h1 id="retiva" class="no-margins totales">$ 0.00</h1>
                                <span class="font-bold text-navy">Ret. IVA %</span>
                            </div>
                        </div>
                        <div class="col-lg-12 col-md-12 col-xs-12 col-sm-12" style="border-bottom: 1px solid #e7eaec">
                            <div class="ibox-content codvalue text-right">
                                <h1 id="Tsubtotal" class="no-margins" >$ 0.00</h1>
                                <span class="font-bold text-navy">Subtotal</span>
                            </div>
                        </div>
                        <div class="col-lg-12 col-md-12 col-xs-12 col-sm-12" style="border-bottom: 1px solid #e7eaec; padding-left: 0;">
                            <div class="ibox-content codvalue text-right">
                                <input type="text" class="form-control recalculo" id="m_anticipo" placeholder=" " data-op="A" value="0.00" money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="0" data-a-sign="$ " disabled="disabled"  style="padding: 0;   text-align: right;   font-size: 19px !important;    border: 0;    border-bottom: 1px;   color: red;    background: #f3f3f385;"/>
                                <span class="font-bold text-navy">Anticipo</span>
                            </div>
                        </div>
                        <div class="col-lg-12 col-md-12 col-xs-12 col-sm-12" style="border-bottom: 1px solid #e7eaec">
                            <div class="ibox-content codvalue text-right">
                                <h1 id="Ttotal" class="no-margins" style="font-weight: bold">$ 0.00</h1>
                                <span class="font-bold text-navy">Total Compra</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="ModalSeries">
        <div class="modal-dialog modal-sm" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h2 class="modal-title">Registrar Series</h2>
                </div>
                <div class="modal-body clearfix" style="margin-bottom: 0; padding-top: 0 !important">
                    <div class="row">
                        <div class="table-responsive" style="max-height: 400px; padding-right: 8px;">
                            <div class="col-lg-12 col-md-12 col-xs-12 col-sm-12" style="padding: 0; padding-top: 10px !important;" id="listseries">
                            </div>
                        </div>
                    </div>
                    <div class="row buttonaction pull-right">
                        <button title="Guardar" id="btnSaveSeries" data-option="I" class="btn btn-outline btn-primary dim waves-effect waves-light" type="button"><i class="fa fa-paste"></i></button>
                        <button title="Cancelar" id="btnCanceSeries" class="btn btn-outline btn-danger  dim waves-effect waves-light" data-dismiss="modal" aria-label="Close" type="button"><i class="fa-file-o fa"></i></button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="ModalEntrada">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h2 class="modal-title">Lista de Entradas</h2>
                </div>
                <div class="modal-body clearfix" style="margin-bottom: 0; padding-top: 0 !important">
                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding: 5px;">
                            <div class="table-responsive" style="max-height: 300px">
                                <table class="table table-striped jambo_table" id="tblentradas">
                                    <thead>
                                        <tr>
                                            <th data-column-id="id" data-formatter="edit" data-sortable="false" style="max-width: 30px !important;">Ver</th>
                                            <th data-column-id="estado">Estado</th>
                                            <th data-column-id="id">Consecutivo</th>
                                            <th data-column-id="fechadocumen">Fecha</th>
                                            <th data-column-id="fechafactura">Fecha Factura</th>
                                            <th data-column-id="numfactura">Factura</th>
                                            <th data-column-id="proveedor">Proveedor</th>
                                            <th data-column-id="valor" data-formatter="valor" data-sortable="false" data-class="text-right">Valor</th>
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
    <div class="modal fade" id="ModalOrdenCompra">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h2 class="modal-title">Lista de Entradas</h2>
                </div>
                <div class="modal-body clearfix" style="margin-bottom: 0; padding-top: 0 !important">
                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding: 5px;">
                            <div class="table-responsive" style="max-height: 300px">
                                <table class="table table-striped jambo_table" id="tblOrdenCompras">
                                    <thead>
                                        <tr>
                                            <th data-column-id="id" data-formatter="edit" data-sortable="false" style="max-width: 30px !important;">Ver</th>
                                            <th data-column-id="id">Consecutivo</th>
                                            <th data-column-id="fechadocumen">Fecha</th>
                                            <th data-column-id="proveedor">Proveedor</th>
                                            <th data-column-id="nombrebodega">Bodega</th>

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
    <div class="modal fade" id="ModalConfig">
        <div class="modal-dialog modal-sm" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h2 class="modal-title">Configuración</h2>
                </div>
                <div class="modal-body clearfix" style="margin-bottom: 0; padding-top: 0 !important">
                    <div class="row">
                        <div class="col-md-4 col-lg-4 col-sm-4 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="prorratear" class="active">Prorratear? </label>
                                <div class="check-mail">
                                    <input type="checkbox" class="i-checks pull-right" id="prorratear" checked="checked" />
                                </div>
                            </div>
                        </div>
                        <div class="col-md-8 col-lg-8 col-sm-8 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="typeprorrateo" class="active">Tipo</label>
                                <select id="typeprorrateo" class="form-control selectpicker" runat="server" clientidmode="static">
                                    <option value="V">Valor</option>
                                    <option value="C">Cantidad</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12  sn-padding">
                            <div class="form-group">
                                <label for="Text_Nombre" class="active">Proveedor</label>
                                <div class="input-group ">
                                    <input type="hidden" id="cd_provconf" class="form-control" value="0" />
                                    <input type="hidden" id="tipoterceroconf" value="PR" />
                                    <input type="text" class="form-control actionautocomple inputsearch" id="ds_provconf" aria-describedby="sizing-addon1" data-search="Bodegas" data-method="BodegasBuscador" data-params="op:T;o:PR" data-result="value:name;data:id" data-idvalue="cd_provconf" />
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 padsmall">
                            <div class="form-group">
                                <label for="cd_formapagoFlete" class="active">Forma de Pago:</label>
                                <select runat="server"  clientidmode="static" id="cd_formapagoFlete" class="form-control selectpicker" data-size="8">
                                </select>
                            </div>
                        </div>
                        <div class="col-sm-12 col-xs-12">
                            <button id="btnCance" type="button" data-id="0" class="pull-right btn btn-danger" data-dismiss="modal" aria-label="Close">Cerrar</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="ModalLoad">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-body clearfix" style="margin-bottom: 0; padding-top: 0 !important">
                    <div class="row">
                        <h4 class="text-center">Procesando...</h4>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="ModalLoadPlano">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h2 class="modal-title">Cargar Archivo Plano</h2>
                </div>
                <div class="modal-body clearfix" style="margin-bottom: 0; padding-top: 0 !important">
                    <div class="col-lg-12 col-md-12 col-xs-12 col-sm-12">
                        <div class="form-group">
                            <label for="excel" class="active">Archivo plano :</label>
                            <input type="file" runat="server" clientidmode="Static" id="File1" class="dropify" data-height="80" data-max-file-size="1M"
                                data-allowed-file-extensions="xls xlsx"
                                data-max-file-size-preview="10M" />
                        </div>
                    </div>
                    <div class="col-sm-12 col-xs-12">
                        <button id="btnsupri" type="button" data-id="0" class="pull-right btn btn-danger ink-reaction btn-raised btn-loading-state" data-loading-text="<i class='fa fa-spinner fa-spin'></i> Cargando...">Suprimir</button>
                        <button id="btnLoad" style="margin-right: 5px;" type="button" data-id="0" class="pull-right btn btn-primary ink-reaction btn-raised btn-loading-state" data-loading-text="<i class='fa fa-spinner fa-spin'></i> Cargando...">Cargar</button>

                    </div>
                </div>
            </div>
        </div>
    </div>
    <input type="hidden" id="newId" value="0" />
    <input id="hidden_Pedido" type="hidden" value="0" />
    <script src="../Pages/ScriptsPage/Inventario/Entradas.js?1"></script>
    <script>
        $(document).ready(function () {
            datepicker();
            if ($('#newId').val() == 0) {
                var newid = newID('newId');
            }

            $('.i-checks').iCheck({
                checkboxClass: 'icheckbox_square-green',
                radioClass: 'iradio_square-green',
            });
            $("[money]").each(function (i, control) {
                $(control).autoNumeric('init');
            });
            $('.dropify').dropify({
                messages: {
                    default: 'Arrastre un archivo o haga clic aquí',
                    replace: 'Arrastre un archivo o haga clic para reemplazar',
                    remove: 'Quitar',
                    error: 'Archivo demasiado grande o extensión incorrecta'
                },
                error: {
                    fileSize: 'El tamaño del archivo es muy grande ({{ value }} max).',
                    minWidth: 'El ancho de la imagen es muy pequeño ({{ value }}}px min).',
                    maxWidth: 'El ancho de la imagen es muy grande ({{ value }}}px max).',
                    minHeight: 'La altura de la imagen es muy pequeña ({{ value }}}px min).',
                    maxHeight: 'La altura de la imagen es muy grande ({{ value }}px max).',
                    imageFormat: 'El formato de la imagen no esta permitido ({{ value }} solamente).',
                    fileExtension: 'El archivo no es permitido ({{ value }} solamente).'
                }
            });
        })
    </script>
</asp:Content>
