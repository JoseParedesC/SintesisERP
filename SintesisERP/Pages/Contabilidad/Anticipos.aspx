﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Anticipos.aspx.cs"
    Inherits="Anticipos" MasterPageFile="~/Masters/SintesisMaster.Master" %>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPage" runat="server">
    <script type="text/javascript">
        window.appPath = "<%=Request.ApplicationPath%>";
    </script>
    <style>
        .input-group {
            margin-top: -0.223px !important;
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
            margin-bottom: 10px;
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

        .codvalue {
            padding: 0 0 10px 0 !important;
            margin-bottom: 5px;
            border-style: none;
            border-bottom: 1px solid #e7eaec !important;
            height: 38px;
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
    </style>
    <input type="hidden" id="id_documento" value="0" />
    <div class="row" style="margin-left: 0;">
        <div class="x_panel">
            <div class="x_title col-lg-6 col-md-6 col-sm-7 col-xs-12">
                <h1 class="title-master" style="margin-top: 0;"><span class="fa fa-money fa-fw"></span>Anticipos</h1>
                <div class="clearfix"></div>
            </div>
            <div class="col-lg-6 col-md-6 col-sm-5 col-xs-12 Botns">
                <button title="Guardar" id="btnSave" data-option="I" class="btn btn-outline btn-primary dim  pull-right" type="button"><i class="fa fa-paste"></i></button>
                <button title="Imprimir" id="btnPrint" data-option="I" class="btn btn-outline btn-print dim  pull-right" type="button"><i class="fa fa-print"></i></button>
                <button title="Nueva" id="btnnew" data-option="R" class="btn btn-outline btn-default  dim  pull-right" type="button"><i class="fa-file-o fa"></i></button>
                <button title="Listar" id="btnList" data-option="L" class="btn btn-outline btn-info  dim  pull-right" type="button"><i class="fa-list fa"></i></button>

                <span class="pull-right quoteNumber"><span style="font-size: 14px; font-weight: normal;">Consecutivo</span><span class="entradanumber">0</span></span>
            </div>
        </div>
    </div>
	<%-- Aqui empiezan los inputs y los que requieren el autocompletado --%>																		
    <div class="card" id="diventrada" style="padding-bottom: 30px;">
        <div class="row" style="margin: 0px 10px;">
			<%-- Tipo de Documento --%>						   
            <div class="col-lg-2 col-md-4 col-sm-4 col-xs-12  sn-padding">
                <div class="form-group">
                    <div class="form-group">
                        <label for="cd_tipodoc" class="active">Tipo de Documento:</label>
                        <select runat="server" clientidmode="static" id="cd_tipodoc" class="form-control selectpicker" data-size="8">
                        </select>
                    </div>
                </div>
            </div>
			<%-- Centro Costo --%>					  
            <div class="col-lg-3 col-md-4 col-sm-4 col-xs-12 sn-padding">
                <div class="form-group">
                    <label for="Text_Nombre" class="active">Centro Costo</label>	  
					<input type="hidden" id="id_ccostos" />
					<input type="hidden" id="Idcurrent" value="0" />
					<input type="hidden" id="isofDetalle" value='true' />
					<input type="text" class="form-control actionautocomple inputsearch" id="codigoccostos" aria-describedby="sizing-addon1"  data-search="Bodegas" data-method="BodegasBuscador" data-params="op:F;o:#" data-result="value:name;data:id" data-idvalue="id_ccostos"/>							 
                </div>
            </div>
            <div class="col-lg-2 col-md-4 col-sm-4 col-xs-12 sn-padding">
                <div class="form-group">
                    <label for="Text_Fecha" class="active">Fecha:</label>
                    <input id="Text_Fecha" type="text" placeholder=" " class="form-control" current="true" date="true" format="YYYY-MM-DD" />
                </div>
            </div>
            
            <div class="col-lg-2 col-md-4 col-sm-4 col-xs-12  sn-padding">
                <div class="form-group">
                    <label for="cd_tipoter" class="active">Tipo Tercero:</label>
                    <select runat="server" clientidmode="static" id="cd_tipoter" data-size="8" class="form-control selectpicker" title="Seleccione" data-live-search="true">
                    </select>
                </div>
            </div>
			<%-- Tercero --%>
            <div class="col-lg-3 col-md-4 col-sm-4 col-xs-12 sn-padding">
                <div class="form-group">
                    <label for="Text_Nombre" class="active">Tercero:</label>
                        <input type="hidden" id="cd_cliente" value="0" />
                        <input type="hidden" id="tipotercero1" value="" />
                        <input type="text" class="form-control actionautocomple inputsearch" id="ds_cliente" aria-describedby="sizing-addon1" data-search="Bodegas" data-method="BodegasBuscador" data-params="op:T;o:#" data-result="value:name;data:id" data-idvalue="cd_cliente" />
                </div>
            </div>
            <div class="col-lg-2 col-md-3 col-sm-4 col-xs-12  sn-padding">
                <div class="form-group">
                    <label for="id_forma" class="active">Forma de Pago:</label>
                    <select runat="server" clientidmode="static" id="id_forma" data-size="8" class="form-control selectpicker" title="Seleccione" data-live-search="true">
                    </select>
                </div>
            </div>
            <%-- Cuenta de Anticipo --%>
            <div class="col-lg-3 col-md-4 col-sm-4 col-xs-12 sn-padding">
                <div class="form-group">
                    <label for="Text_Nombre" class="active">Cuenta de Anticipo:</label>
					<input type="hidden" id="id_ctaant" />
					<input type="hidden" id="tipo" value="ANT" />
					<input type="text" class="form-control actionautocomple inputsearch" id="ds_ctaant" aria-describedby="sizing-addon1" data-search="Bodegas" data-method="BodegasBuscador" data-params="op:K;o:#;tipo:ANT" data-result="value:name;data:id" data-idvalue="id_ctaant" />
				</div>
            </div>
            <div class="col-lg-2 col-md-2 col-sm-4 col-xs-12  sn-padding">
                <div class="form-group">
                    <label for="m_cost" class="active">Valor:</label>
                    <input id="m_cost" type="text" class="form-control addart" value="0.00" placeholder=" " money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="0" data-a-sign="$ " />
                </div>
            </div>

            <div class="col-lg-3 col-md-3 col-sm-4 col-xs-12 sn-padding" style="display: none" id="divvoucher">
                <div class="form-group">
                    <label for="cd_voucher" class="active">Voucher:</label>
                    <input id="cd_voucher" type="text" class="form-control" value="" placeholder=" " />
                </div>
            </div>
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12  sn-padding">
                <div class="form-group">
                    <label for="descripcion" class="active">Descripción:</label>
                    <textarea id="descripcion" max-length="1000" class="form-control" placeholder="Descripción" style="display: block; min-height: 100px !important; width: 100% !important; max-width: 100%; min-width: 100%; max-height: 300px" value=""></textarea>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="ModalDocumento">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h2 class="modal-title">Lista de Anticipos</h2>
                </div>
                <div class="modal-body clearfix" style="margin-bottom: 0; padding-top: 0 !important">
                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding: 5px;">
                            <div class="table-responsive" style="max-height: 300px">
                                <table class="table table-striped jambo_table" id="tbldocumentos">
                                    <thead>
                                        <tr>
                                            <th data-column-id="id" data-formatter="edit" data-sortable="false" style="max-width: 30px !important;">Ver</th>
                                            <th data-column-id="estado">Estado</th>
                                            <th data-column-id="id">Consecutivo</th>
                                            <th data-column-id="fecha">Fecha</th>
                                            <th data-column-id="tipo">Tipo Tercero</th>
                                            <th data-column-id="tercero">Tercero</th>
                                            <th data-column-id="valor" data-formatter="total" data-sortable="false" data-class="text-right">Valor</th>
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

    <script src="../Pages/ScriptsPage/Contabilidad/Anticipos.js?1"></script>
    <script>
        $(document).ready(function () {
            datepicker();
        });
    </script>
</asp:Content>
