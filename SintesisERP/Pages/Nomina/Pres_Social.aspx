<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Pres_Social.aspx.cs" Inherits="Pres_Social" MasterPageFile="~/Masters/SintesisMaster.Master" %>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPage" runat="server">
    <script type="text/javascript">
        window.appPath = "<%=Request.ApplicationPath%>";
    </script>
    <link href="../Package/Vendor/css/plugins/Autocomplete/autocomplet.css" rel="stylesheet" />
    <style>
        .nav > li > a:focus, .nav > li > a:hover {
            background-color: #1c84c6cf !important
        }

        .nav-tabs > li > a {
            color: black !important;
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

        .codigo {
            display: none
        }
    </style>

    <div class="row" style="margin: 0px 10px;">
        <div class="x_panel">
            <div class="x_title">
                <h1 class="title-master" style="margin-top: 0;"><span class="fa fa-bullhorn fa-fw"></span>Maestro de Prestaciones Sociales</h1>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>

    <ul class="nav nav-tabs" id="myTab" role="tablist" style="margin-top: 20px;">
        <li class="nav-item active" data-iden="CESAN" data-nav="tblcesantia">
            <a class="nav-link active" id="nav1" data-toggle="tab" href="#collapseOne" role="tab" aria-controls="collapseOne" aria-selected="true" aria-expanded="true">Cesantias</a>
        </li>
        <li class="nav-item" data-iden="INCESAN" data-nav="tblintereses">
            <a class="nav-link" id="nav2" data-toggle="tab" href="#collapseTwo" role="tab" aria-controls="collapsetwo" aria-selected="false">Int. de Cesantias</a>
        </li>
        <li class="nav-item" data-iden="PRIM" data-nav="tblprimas">
            <a class="nav-link" id="nav3" data-toggle="tab" href="#collapseThree" role="tab" aria-controls="collapseThree" aria-selected="false">Primas</a>
        </li>
        <li class="nav-item" data-iden="VACA" data-nav="tblvacaciones">
            <a class="nav-link" id="nav4" data-toggle="tab" href="#collapseFour" role="tab" aria-controls="collapseFour" aria-selected="false">Vacaciones</a>
        </li>
    </ul>


    <div class="tab-content" id="myTabContent">

        <div class="tab-pane fade active in" id="collapseOne" role="tabpanel" aria-labelledby="home-tab">
            <div class="card card-body">
                <div class="row" style="margin: 0px 10px;">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2 class="title-master" style="margin-top: 0;"><span class="fa fa- fa-money"></span>&nbsp;Maestro Cesantías</h2>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div>
                <div class="card" id="divCesantia">
                    <div class="row" style="margin: 0px 10px;">
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                            <div class="table-responsive " id="tblcesantia">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <div class="tab-pane fade" id="collapseTwo" role="tabpanel" aria-labelledby="home-tab">
            <div class="card card-body">
                <div class="row" style="margin: 0px 10px;">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2 class="title-master" style="margin-top: 0;"><span class="fa fa-money"></span>&nbsp;Maestro Intereses de Cesantias</h2>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div>
                <div class="card" id="divInteres">
                    <div class="row" style="margin: 0px 10px;">
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                            <div class="table-responsive " id="tblintereses">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <div class="tab-pane fade active" id="collapseThree" role="tabpanel" aria-labelledby="home-tab">
            <div class="card card-body">
                <div class="row" style="margin: 0px 10px;">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2 class="title-master" style="margin-top: 0;"><span class="fa fa-money"></span>&nbsp;Maestro Primas</h2>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div>
                <div class="card" id="divPrimas">
                    <div class="row" style="margin: 0px 10px;">
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                            <div class="table-responsive " id="tblprimas">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <div class="tab-pane fade active" id="collapseFour" role="tabpanel" aria-labelledby="home-tab">
            <div class="card card-body">
                <div class="row" style="margin: 0px 10px;">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2 class="title-master" style="margin-top: 0;"><span class="fa fa-sun-o"></span>&nbsp;Maestro Vacaciones</h2>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div>
                <div class="card" id="divVacaciones">
                    <div class="row" style="margin: 0px 10px;">
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                            <div class="table-responsive " id="tblvacaciones">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <span class="fa-stack fa-lg pull-right goTop iconnew">
        <i class="fa fa-circle fa-stack-2x"></i>
        <i class="fa fa-plus fa-stack-1x fa-inverse"></i>
    </span>

    <!--Modal Del formulario de registro de Cuentas-->
    <div class="modal fade" id="ModalPrestaciones">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h2 class="modal-title"><i class="fa fa-list"></i>&nbsp;Detalles de Prestacion</h2>
                </div>

                <div class="modal-body clearfix" style="margin-bottom: 0; padding-top: 0 !important">
                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="id_tipoprestacion" class="active">Tipo de Seguridad Social:</label>
                                <select id="id_tipoprestacion" runat="server" clientidmode="static" data-size="8" class="form-control selectpicker" title="Seleccione" data-live-search="true">
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12 sn-padding codigo">
                            <div class="form-group">
                                <label for="codigo" class="active">Codigo:</label>
                                <input type="text" placeholder=" " class="form-control" id="codigo" />
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="nombre" class="active">Nombre:</label>
                                <input type="text" placeholder=" " class="form-control" id="nombre" />
                            </div>
                        </div>


                        <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="ds_cesancontra" class="active">Cuenta Contrapartida:</label>
                                <input type="hidden" id="id_cesancontra" value="0" />
                                <input type="text" class="form-control actionautocomple inputsearch" id="ds_cesancontra" aria-describedby="sizing-addon1" data-search="RHumanos" data-method="NominaBuscador" data-params="op:U;o:#;tipo:#" data-result="value:name;data:id" data-idvalue="id_cesancontra" />
                            </div>
                        </div>
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="provisional" class="active">Provisiones:</label>
                                <input type="text" placeholder="$ 0.00 " class="form-control" id="provisional" money="true" data-a-dec="." data-a-sep="," data-m-dec="2" data-v-min="0" data-a-sign="$ "/>
                            </div>
                        </div>
                    </div>
                    <br />
                    <input type="hidden" value="0" id="idcesan" />
                    <div class="row buttonaction pull-right">
                        <button title="Guardar" id="btnSave" class="btn btn-outline btn-primary dim waves-effect waves-light" type="button"><i class="fa fa-paste"></i></button>
                        <button title="Cancelar" id="btnCance" class="btn btn-outline btn-danger  dim waves-effect waves-light" data-dismiss="modal" aria-label="Close" type="button"><i class="fa-file-o fa"></i></button>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <%--</main>--%>
    <script src="../Pages/ScriptsPage/Nomina/Pres_Sociales.js?1"></script>

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
            $("[porcen]").each(function (i, control) {
                $(control).autoNumeric('init');
            });
        })
    </script>
</asp:Content>
