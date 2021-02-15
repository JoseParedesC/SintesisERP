<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CierreContable.aspx.cs"
    Inherits="CierreContable" MasterPageFile="~/Masters/SintesisMaster.Master" %>

<asp:Content ID="Content39" ContentPlaceHolderID="ContentPage" runat="server">
    <script type="text/javascript">
        window.appPath = "<%=Request.ApplicationPath%>";
    </script>
    <style>

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
    </style>
    <div class="row" style="margin-left: 0;">
        <div class="x_panel">
            <div class="x_title col-lg-6 col-md-6 col-sm-7 col-xs-12">
                <h1 class="title-master" style="margin-top: 0;"><span class="fa fa-level-down fa-fw"></span>Cierre Contable</h1>
                <div class="clearfix"></div>
            </div>
            <div class="col-lg-6 col-md-6 col-sm-5 col-xs-12 Botns">
                <button title="Guardar" id="btnSave" data-option="I" class="btn btn-outline btn-primary dim  pull-right" type="button"><i class="fa fa-paste"></i></button>
                <button title="Revertir" id="btnRev" class="btn btn-outline btn-danger  dim  pull-right" type="button" disabled="disabled"><i class="fa-file-o fa"></i></button>
                <button title="Nueva" id="btnnew" data-option="R" class="btn btn-outline btn-default  dim  pull-right" type="button"><i class="fa-file-o fa"></i></button>
                <button title="Listar" id="btnList" data-option="L" class="btn btn-outline btn-info  dim  pull-right" type="button"><i class="fa-list fa"></i></button>
                <span class="pull-right quoteNumber"><span style="font-size: 14px; font-weight: normal;">Consecutivo</span><span id="consecutivo" class="entradanumber">0</span></span>
            </div>
        </div>
    </div>
    <div class="card" id="diventrada" style="padding-bottom: 30px;">
        <div class="row" style="padding: 6px;">
            <div class="col-lg-3 col-sm-6 col-md-3 col-xs-6">
                <div class="form-group">
                    <label>Fecha</label>
                    <input type="text" id="fecha" class="form-control" date="true" format="YYYY-MM-DD" current="true" />
                </div>
            </div>
            <div class="col-lg-3 col-sm-6 col-md-3 col-xs-6">
                <div class="form-group">
                    <label for="Text_Nombre" class="active">Centro Costo</label>
                    <input type="hidden" id="id_centro" value="0" />
                    <input type="text" class="form-control actionautocomple inputsearch" id="ds_centro"
                        aria-describedby="sizing-addon1" data-search="Bodegas" data-method="BodegasBuscador"
                        data-params="op:F;o:#;tipo:#" data-result="value:name;data:id" data-idvalue="id_centro" />
                </div>
            </div>
            <div class="col-lg-3 col-sm-6 col-md-3 col-xs-6">
                <div class="form-group">
                    <label for="Text_Nombre" class="active" id="cancelacion">Cuenta de cancelación</label>
                    <input type="hidden" id="id_cancel" value="0" />
                    <input type="text" class="form-control actionautocomple inputsearch" id="ds_cancel"
                        aria-describedby="sizing-addon1" data-search="Bodegas" data-method="BodegasBuscador"
                        data-params="op:B;o:#;tipo:#" data-result="value:name;data:id" data-idvalue="id_cancel" />
                </div>
            </div>
            <div class="col-lg-3 col-sm-6 col-md-3 col-xs-6">
                <div class="form-group">
                    <label for="Text_Nombre" class="active" id="cierre">Cuenta de cierre</label>
                    <input type="hidden" id="id_cierre" value="0" />
                    <input type="text" class="form-control actionautocomple inputsearch" id="ds_cierre"
                        aria-describedby="sizing-addon1" data-search="Bodegas" data-method="BodegasBuscador"
                        data-params="op:B;o:#;tipo:#" data-result="value:name;data:id" data-idvalue="id_cierre" />
                </div>
            </div>
        </div>
        <div class="row" style="padding: 6px;">
            <div class="col-lg-3 col-md-3 col-sm-3 col-xs-3">
                <div class="form-group">
                    <label>Año de cierre</label>
                    <input class="form-control" id="ano" date="true" format="YYYY" current="true" /> 
                </div>
            </div>
            <div class="col-lg-9 col-md-9 col-sm-9">
                <div class="form-group">
                    <label id="lb_descrip">Descripción</label>
                    <textarea id="descrip" class="form-control" style="resize: none; width: 70%;"></textarea>
                </div>
            </div>
        </div>
        <div class="row" style="margin: 0px 10px;">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding-top: 5px; padding-bottom: 15px; padding-left: 2px;">
                <div class="table-responsive" style="height: 400px !important;">
                    <table class="table table-striped jambo_table table-fixed" id="tblcierre">
                        <thead>
                            <tr>
                                <th data-column-id="codigo">Nro cuenta</th>
                                <th data-column-id="nombre">Nombre</th>
                                <th data-column-id="debito" data-formatter="debito">Débito</th>
                                <th data-column-id="credito" data-formatter="credito">Crédito</th>
                            </tr>
                        </thead>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="ModalCierreContable">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h2 class="modal-title">Lista Cierres Contables</h2>
                </div>
                <div class="modal-body clearfix" style="margin-bottom: 0; padding-top: 0 !important">
                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding: 5px;">
                            <div class="table-responsive" style="max-height: 300px">
                                <table class="table table-striped jambo_table" id="tblmovcierre">
                                    <thead>
                                        <tr>
                                            <th data-column-id="id" data-formatter="ver" data-sortable="false" style="max-width: 30px !important;">Ver</th>
                                            <th data-column-id="estado">Estado</th>
											<th data-column-id="anomes">Año</th>
                                            <th data-column-id="fecha">Fecha</th>
                                            <th data-column-id="centro">Centro costo</th>
                                            <th data-column-id="id_cancel">Cuenta cancelación</th>
                                            <th data-column-id="id_cierre">Cuenta cierre</th>
                                            <th data-column-id="documento">Tipo de documento</th>
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
    <script src="../Pages/ScriptsPage/Contabilidad/CierreContable.js"></script>
    <script src="../Package/Vendor/js/plugins/Autocomplete/jquery.autocomplete.js"></script>
</asp:Content>
