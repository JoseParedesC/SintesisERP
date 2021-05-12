<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Area.aspx.cs" Inherits="Area" MasterPageFile="~/Masters/SintesisMaster.Master" %>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPage" runat="server">
    <script type="text/javascript">
        window.appPath = "<%=Request.ApplicationPath%>";
    </script>

    <style>
        
        .ch {
            height: 20px;
            width: 20px;
            border-radius: 20px !important;
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

    <div class="row" style="margin: 0px 10px;">
        <div class="x_panel">
            <div class="x_title">
                <h1 class="title-master" style="margin-top: 0;"><span class="fa fa-bullhorn fa-fw"></span>Maestro Area</h1>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>

    <div class="card" id="diventrada">
        <div class="row" style="margin: 0px 10px;">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <div class="table-responsive ">
                    <table class="table table-striped jambo_table" id="tblarea">
                        <thead>
                            <tr>
                                <th data-column-id="edit" data-formatter="edit" data-sortable="false" style="max-width: 30px !important;">Editar</th>
                                <th data-column-id="nombre">Nombre</th>
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
    <div class="modal fade" id="ModalArea">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h2 class="modal-title">Descripción del Area</h2>
                </div>

                <div class="modal-body clearfix" style="margin-bottom: 0; padding-top: 0 !important">
                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="areanombre" class="active">Nombre:</label>
                                <input type="text" placeholder=" " class="form-control" id="areanombre" />
                            </div>
                        </div>
                    </div>
                    <h2 style="margin-left: -14px !important;">Cuentas de Gastos</h2>
                    <div class="row" style="border-top: 1px solid #AAB7B8; ">
                        <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="ds_suelcuen_gasto" class="active">Sueldo:</label>
                                <input type="hidden" id="id_suelcuen_gasto" value="0" />
                                <input type="text" class="form-control actionautocomple inputsearch" id="ds_suelcuen_gasto" aria-describedby="sizing-addon1" data-search="RHumanos" data-method="NominaBuscador" data-params="op:H;o:#;tipo:#" data-result="value:name;data:id" data-idvalue="id_suelcuen_gasto" />
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="ds_hextcuen_gasto" class="active">Horas extras:</label>
                                <input type="hidden" id="id_hextcuen_gasto" value="0" />
                                <input type="text" class="form-control actionautocomple inputsearch" id="ds_hextcuen_gasto" aria-describedby="sizing-addon1" data-search="RHumanos" data-method="NominaBuscador" data-params="op:H;o:#;tipo:#" data-result="value:name;data:id" data-idvalue="id_hextcuen_gasto" />
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="ds_bonicuen_gasto" class="active">Bonificaciones:</label>
                                <input type="hidden" id="id_bonicuen_gasto" value="0" />
                                <input type="text" class="form-control actionautocomple inputsearch" id="ds_bonicuen_gasto" aria-describedby="sizing-addon1" data-search="RHumanos" data-method="NominaBuscador" data-params="op:H;o:#;tipo:#" data-result="value:name;data:id" data-idvalue="id_bonicuen_gasto" />
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="ds_comicuen_gasto" class="active">Comisiones:</label>
                                <input type="hidden" id="id_comicuen_gasto" value="0" />
                                <input type="text" class="form-control actionautocomple inputsearch" id="ds_comicuen_gasto" aria-describedby="sizing-addon1" data-search="RHumanos" data-method="NominaBuscador" data-params="op:H;o:#;tipo:#" data-result="value:name;data:id" data-idvalue="id_comicuen_gasto" />
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="ds_auxtranscuen_gasto" class="active">Aux. Transporte:</label>
                                <input type="hidden" id="id_auxtranscuen_gasto" value="0" />
                                <input type="text" class="form-control actionautocomple inputsearch" id="ds_auxtranscuen_gasto" aria-describedby="sizing-addon1" data-search="RHumanos" data-method="NominaBuscador" data-params="op:H;o:#;tipo:#" data-result="value:name;data:id" data-idvalue="id_auxtranscuen_gasto" />
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="ds_cesancuen_gasto" class="active">Cesantías:</label>
                                <input type="hidden" id="id_cesancuen_gasto" value="0" />
                                <input type="text" class="form-control actionautocomple inputsearch" id="ds_cesancuen_gasto" aria-describedby="sizing-addon1" data-search="RHumanos" data-method="NominaBuscador" data-params="op:H;o:#;tipo:#" data-result="value:name;data:id" data-idvalue="id_cesancuen_gasto" />
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="ds_intcasancuen_gasto" class="active">Int. sobre cesantías:</label>
                                <input type="hidden" id="id_intcasancuen_gasto" value="0" />
                                <input type="text" class="form-control actionautocomple inputsearch" id="ds_intcasancuen_gasto" aria-describedby="sizing-addon1" data-search="RHumanos" data-method="NominaBuscador" data-params="op:H;o:#;tipo:#" data-result="value:name;data:id" data-idvalue="id_intcasancuen_gasto" />
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="ds_primsercuen_gasto" class="active">Prima de servicios:</label>
                                <input type="hidden" id="id_primsercuen_gasto" value="0" />
                                <input type="text" class="form-control actionautocomple inputsearch" id="ds_primsercuen_gasto" aria-describedby="sizing-addon1" data-search="RHumanos" data-method="NominaBuscador" data-params="op:H;o:#;tipo:#" data-result="value:name;data:id" data-idvalue="id_primsercuen_gasto" />
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="ds_vacacuen_gasto" class="active">Vacaciones:</label>
                                <input type="hidden" id="id_vacacuen_gasto" value="0" />
                                <input type="text" class="form-control actionautocomple inputsearch" id="ds_vacacuen_gasto" aria-describedby="sizing-addon1" data-search="RHumanos" data-method="NominaBuscador" data-params="op:H;o:#;tipo:#" data-result="value:name;data:id" data-idvalue="id_vacacuen_gasto" />
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="ds_arlcuen_gasto" class="active">A.R.L:</label>
                                <input type="hidden" id="id_arlcuen_gasto" value="0" />
                                <input type="text" class="form-control actionautocomple inputsearch" id="ds_arlcuen_gasto" aria-describedby="sizing-addon1" data-search="RHumanos" data-method="NominaBuscador" data-params="op:H;o:#;tipo:#" data-result="value:name;data:id" data-idvalue="id_arlcuen_gasto" />
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="ds_epscuen_gasto" class="active">Aportes E.P.S:</label>
                                <input type="hidden" id="id_epscuen_gasto" value="0" />
                                <input type="text" class="form-control actionautocomple inputsearch" id="ds_epscuen_gasto" aria-describedby="sizing-addon1" data-search="RHumanos" data-method="NominaBuscador" data-params="op:H;o:#;tipo:#" data-result="value:name;data:id" data-idvalue="id_epscuen_gasto" />
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="ds_pencuen_gasto" class="active">Aportes A.F.P:</label>
                                <input type="hidden" id="id_pencuen_gasto" value="0" />
                                <input type="text" class="form-control actionautocomple inputsearch" id="ds_pencuen_gasto" aria-describedby="sizing-addon1" data-search="RHumanos" data-method="NominaBuscador" data-params="op:H;o:#;tipo:#" data-result="value:name;data:id" data-idvalue="id_pencuen_gasto" />
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="ds_fspencuen_gasto" class="active">Solidaridad Pensional:</label>
                                <input type="hidden" id="id_fspencuen_gasto" value="0" />
                                <input type="text" class="form-control actionautocomple inputsearch" id="ds_fspencuen_gasto" aria-describedby="sizing-addon1" data-search="RHumanos" data-method="NominaBuscador" data-params="op:H;o:#;tipo:#" data-result="value:name;data:id" data-idvalue="id_fspencuen_gasto" />
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="ds_cajacuen_gasto" class="active">Aportes C.C.F:</label>
                                <input type="hidden" id="id_cajacuen_gasto" value="0" />
                                <input type="text" class="form-control actionautocomple inputsearch" id="ds_cajacuen_gasto" aria-describedby="sizing-addon1" data-search="RHumanos" data-method="NominaBuscador" data-params="op:H;o:#;tipo:#" data-result="value:name;data:id" data-idvalue="id_cajacuen_gasto" />
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="ds_icbfcuen_gasto" class="active">I.C.B.F:</label>
                                <input type="hidden" id="id_icbfcuen_gasto" value="0" />
                                <input type="text" class="form-control actionautocomple inputsearch" id="ds_icbfcuen_gasto" aria-describedby="sizing-addon1" data-search="RHumanos" data-method="NominaBuscador" data-params="op:H;o:#;tipo:#" data-result="value:name;data:id" data-idvalue="id_icbfcuen_gasto" />
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="ds_senacuen_gasto" class="active">S.E.N.A:</label>
                                <input type="hidden" id="id_senacuen_gasto" value="0" />
                                <input type="text" class="form-control actionautocomple inputsearch" id="ds_senacuen_gasto" aria-describedby="sizing-addon1" data-search="RHumanos" data-method="NominaBuscador" data-params="op:H;o:#;tipo:#" data-result="value:name;data:id" data-idvalue="id_senacuen_gasto" />
                            </div>
                        </div>

<%--                        <div class="form-group sn-padding">
                            <label for="funciones">Funciones Generales:</label>
                            <div id="funciones" contenteditable class="fake-textarea"></div>
                        </div>--%>

                    </div>
                    <br />
                    <input type="hidden" value="0" id="idarea" />
                    <div class="row buttonaction pull-right">
                        <button title="Guardar" id="btnSave" data-option="I" class="btn btn-outline btn-primary dim waves-effect waves-light" type="button"><i class="fa fa-paste"></i></button>
                        <button title="Cancelar" id="btnCance" class="btn btn-outline btn-danger  dim waves-effect waves-light" data-dismiss="modal" aria-label="Close" type="button"><i class="fa-file-o fa"></i></button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%--</main>--%>
    <script src="../Pages/ScriptsPage/Nomina/Area.js?1"></script>

    <script>
        $(function () {
            $('select').selectpicker();
            $('.i-checks').iCheck({
                checkboxClass: 'icheckbox_square-green',
                radioClass: 'iradio_square-green',
            });
            datepicker();
        })
    </script>
</asp:Content>
