<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Seg_social.aspx.cs" Inherits="Seg_social" MasterPageFile="~/Masters/SintesisMaster.Master" %>

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
    </style>

    <div class="row" style="margin: 0px 10px;">
        <div class="x_panel">
            <div class="x_title">
                <h1 class="title-master" style="margin-top: 0;"><span class="fa fa-bullhorn fa-fw"></span>Maestro de Seguridad Social</h1>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>

    <ul class="nav nav-tabs" id="myTab" role="tablist" style="margin-top: 20px;">
        <li class="nav-item">
            <a class="nav-link active" id="nav1" data-toggle="tab" href="#collapseOne" role="tab" aria-controls="collapseOne" aria-selected="true" aria-expanded="true">Salud</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" id="nav2" data-toggle="tab" href="#collapseOne" role="tab" aria-controls="collapseOne" aria-selected="false">Pensión</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" id="nav3" data-toggle="tab" href="#collapseOne" role="tab" aria-controls="collapseOne" aria-selected="false">Caja de Compenzación</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" id="nav4" data-toggle="tab" href="#collapseOne" role="tab" aria-controls="collapseOne" aria-selected="false">ARL</a>
        </li>
    </ul>
    <input type="hidden" value="0" id="hidseg" />
    <div class="tab-content" id="myTabContent">
        <div class="tab-pane fade active in" id="collapseOne" role="tabpanel" aria-labelledby="home-tab">

            <div class="card card-body">

                <div class="card" id="diventrada">
                    <div class="row" style="margin: 0px 10px;">
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                            <div class="table-responsive ">
                                <table class="table table-striped jambo_table" id="tblsegsocial">
                                    <thead>
                                        <tr>
                                            <th data-column-id="edit" data-formatter="edit" data-sortable="false" style="max-width: 30px !important;">Editar</th>
                                            <th data-column-id="nombre">Nombre</th>
                                            <th data-column-id="cod_ext">Codigo</th>
                                            <th data-column-id="delete" data-formatter="delete" data-sortable="false" style="max-width: 30px">Eliminar</th>
                                        </tr>
                                    </thead>
                                </table>
                            </div>
                        </div>
                    </div>

                    <span class="fa-stack fa-lg pull-right goTop iconnew ">
                        <i class="fa fa-circle fa-stack-2x"></i>
                        <i class="fa fa-plus fa-stack-1x fa-inverse"></i>
                    </span>
                </div>

                <!--Modal Del formulario de registro de Cuentas-->
                <div class="modal fade" id="ModalSegsocial">
                    <div class="modal-dialog modal-sm" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                                <h2 class="modal-title">Descripción</h2>
                            </div>

                            <div class="modal-body clearfix" style="margin-bottom: 0; padding-top: 0 !important">
                                <div class="row">
                                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 sn-padding">
                                        <div class="form-group">
                                            <label for="id_tiposegsocial" class="active">Tipo de Seguridad Social:</label>
                                            <select id="id_tiposegsocial" runat="server" clientidmode="static" data-size="8" class="form-control selectpicker" title="Seleccione" data-live-search="true">
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 sn-padding">
                                        <div class="form-group">
                                            <label for="nombre" class="active">Nombre:</label>
                                            <input type="text" placeholder=" " class="form-control" id="nombre" />
                                        </div>
                                    </div>
                                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 sn-padding">
                                        <div class="form-group">
                                            <label for="cod_ext" class="active">Codigo externo:</label>
                                            <input type="text" placeholder=" " class="form-control" id="cod_ext" />
                                        </div>
                                    </div>

                                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 sn-padding">
                                        <div class="form-group">
                                            <label for="ds_contra" class="active">Cuenta de Contrapartida:</label>
                                            <input type="hidden" id="id_contra" value="0" />
                                            <input type="text" class="form-control actionautocomple inputsearch" id="ds_contra" aria-describedby="sizing-addon1" data-search="RHumanos" data-method="NominaBuscador" data-params="op:U;o:#;tipo:#" data-result="value:name;data:id" data-idvalue="id_contra" />
                                        </div>
                                    </div>
                                    <%--<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12 sn-padding">
                            <div class="form-group">
                                <label for="carnombre" class="active">codddddddd:</label>
                                <input type="text" placeholder=" " class="form-control" id="3654654" />
                            </div>
                        </div>--%>
                                </div>
                                <br />
                                <input type="hidden" value="0" id="idsegsocial" />
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
    </div>


    <%--</main>--%>
    <script src="../Pages/ScriptsPage/Nomina/Seg_social.js?1"></script>

    <script>
        $(function () {
            $('select').selectpicker();
            $('.i-checks').iCheck({
                checkboxClass: 'icheckbox_square-green',
                radioClass: 'iradio_square-green',
            });
        })
    </script>
</asp:Content>
